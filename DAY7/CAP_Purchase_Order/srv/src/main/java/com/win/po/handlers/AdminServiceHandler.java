package com.win.po.handlers;

import java.io.File;
import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Supplier;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnAnalyzer;
import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import com.win.po.common.MessageKeys;
import com.win.po.common.totalItemsCalculator;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.OrderItems;
import cds.gen.adminservice.OrderItems_;
import cds.gen.adminservice.Orders;
import cds.gen.adminservice.Orders_;
import cds.gen.adminservice.SyncContext;
import cds.gen.adminservice.Vendors;
import cds.gen.adminservice.Vendors_;

@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler {

    @Autowired
    private PersistenceService db;

    @Autowired
    private CdsModel model;

    @Autowired
    private totalItemsCalculator totalCalculator;

    @After(event = CqnService.EVENT_READ, entity = Orders_.CDS_NAME)
    public void afterReadOrder(CdsReadEventContext context, List<Orders> orders) {
        totalCalculator.calculateTotal(orders);
    }

    @After(event = CqnService.EVENT_READ, entity = Orders_.CDS_NAME)
    public void setOrderStatusIconAndColor(CdsReadEventContext context, List<Orders> orders) {
        for (Orders order : orders) {
            try {
                order.setStatusIcon(
                        order.getStatus().containsValue("Y")
                        ? 3
                        : order.getStatus().containsValue("S")
                        ? 2
                        : 1
                );
            } catch (NullPointerException e) {
                // throw new ServiceException(ErrorStatuses.SERVER_ERROR, MessageKeys.ICON_FAILED, e);
            }
        }
    }

    @After(event = CqnService.EVENT_READ, entity = OrderItems_.CDS_NAME)
    public void setStatusIconAndColor(CdsReadEventContext context, List<OrderItems> order_items) {

        for (OrderItems order_item : order_items) {
            try {
                order_item.setStockIcon(
                        order_item.getStock().compareTo(BigDecimal.ZERO) > 0
                        ? 3
                        : 1
                );
            } catch (NullPointerException e) {
                // throw new ServiceException(ErrorStatuses.SERVER_ERROR, MessageKeys.ICON_FAILED, e);
            }
        }
    }

    @Before(event = {CqnService.EVENT_CREATE, CqnService.EVENT_UPDATE}, entity = Orders_.CDS_NAME)
    public void beforeCreateOrUpdateOrder(Orders order) {
        order.setStatusCode("S");
        order.setCurrencyCode(db.run(Select.from(Vendors_.class).where(o -> o.vendor().eq(order.getVendorVendor())))
                .first(Vendors.class).orElseThrow(notFound(MessageKeys.ORDER_MISSING)).getCurrencyCode());
    }

    private Supplier<ServiceException> notFound(String message) {
        return () -> new ServiceException(ErrorStatuses.NOT_FOUND, message);
    }

    @On(event = SyncContext.CDS_NAME)
    public void sync(SyncContext context) {
        System.out.println("MASUK");
        String orderId = (String) CqnAnalyzer.create(model).analyze(context.getCqn()).targetKeys().get(Orders.ID);

        // Ambil order dari DB beserta items
        Orders order = db.run(Select.from(Orders_.class).where(o -> o.ID().eq(orderId)))
                .single(Orders.class);

        List<OrderItems> orderItems = db.run(Select.from(OrderItems_.class)
                .where(oi -> oi.parent().orderNo().eq(orderId)))
                .listOf(OrderItems.class);

        try {
            // Prepare HTTP request body
            // Map<String, Object> requestBody = buildSapRequestBody(order, orderItems);

            // // Make HTTP call to SAP
            // String sapResponse = callSapApi(requestBody);

            // // Parse response (assuming JSON response with PO_NUMBER)
            // ObjectMapper mapper = new ObjectMapper();
            // JsonNode responseNode = mapper.readTree(sapResponse);
            // String poNumberFromSAP = responseNode.path("PO_NUMBER").asText();
            // Print raw response for debugging
            // if (poNumberFromSAP != null && !poNumberFromSAP.isEmpty()) {
            //     // Update order dengan PO Number darfi SAP
            //     order.setOrderNo(poNumberFromSAP);
            //     db.run(Update.entity(Orders_.class)
            //             .data(Orders.ORDER_NO, poNumberFromSAP)
            //             .where(o -> o.ID().eq(orderId)));
            //     System.out.println("Order updated with PO Number: " + poNumberFromSAP);
            // }
        } catch (Exception e) {
            System.err.println("Error during SAP sync: " + e.getMessage());
            throw new ServiceException(ErrorStatuses.SERVER_ERROR, "SAP sync failed: " + e.getMessage());
        }

        context.setCompleted();
    }

    private Map<String, Object> buildSapRequestBody(Orders order, List<OrderItems> orderItems) {
        Map<String, Object> requestBody = new HashMap<>();

        // POHEADER
        Map<String, Object> poHeader = new HashMap<>();
        poHeader.put("CLIENT", "");
        poHeader.put("PO_NUMBER", "");
        poHeader.put("VENDOR", "0013300001");
        poHeader.put("PURCH_ORG", "1310");
        poHeader.put("PUR_GROUP", "001");
        poHeader.put("CO_CODE", "1310");
        poHeader.put("CURRENCY", order.getCurrencyCode());
        poHeader.put("STATU", "");
        poHeader.put("NOTE", "");
        poHeader.put("TEXT", "");
        poHeader.put("ERNAM", "");
        poHeader.put("ERDAT", 0);
        poHeader.put("AENAM", "");
        poHeader.put("AEDAT", 0);
        poHeader.put("LOCAL_LAST_CHANGED_AT", 0);
        requestBody.put("POHEADER", poHeader);

        // POITEM
        List<Map<String, Object>> poItems = new ArrayList<>();
        int itemNumber = 10;
        for (OrderItems item : orderItems) {
            Map<String, Object> poItem = new HashMap<>();
            poItem.put("CLIENT", "");
            poItem.put("PO_NUMBER", "");
            poItem.put("PO_ITEM", itemNumber);
            poItem.put("ACCTASSCAT", "");
            poItem.put("ITEM_CAT", "");
            poItem.put("MATERIAL", item.getMaterialNo());
            poItem.put("SHORT_TEXT", item.getMaterialDescr());
            poItem.put("PRICE_CTR", "");
            poItem.put("QUANTITY", item.getStock());
            poItem.put("NET_PRICE", item.getNetPrice());
            poItem.put("MAT_GRP", "");
            poItem.put("PLANT", "1310");
            poItem.put("STORE_LOC", "");
            poItem.put("PO_UNIT", "ST");
            poItem.put("TEXT", "");
            poItem.put("ERNAM", "");
            poItem.put("ERDAT", 0);
            poItem.put("AENAM", "");
            poItem.put("AEDAT", 0);
            poItem.put("LOCAL_LAST_CHANGED_AT", 0);
            poItems.add(poItem);
            itemNumber += 10;
        }
        requestBody.put("POITEM", poItems);

        // POHEADERTEXT
        List<Map<String, Object>> headerTexts = new ArrayList<>();
        Map<String, Object> headerText = new HashMap<>();
        headerText.put("TDFORMAT", "");
        headerText.put("TDLINE", "textx");
        headerTexts.add(headerText);
        requestBody.put("POHEADERTEXT", headerTexts);

        // POHEADERNOTE  
        List<Map<String, Object>> headerNotes = new ArrayList<>();
        Map<String, Object> headerNote = new HashMap<>();
        headerNote.put("TDFORMAT", "");
        headerNote.put("TDLINE", "textn");
        headerNotes.add(headerNote);
        requestBody.put("POHEADERNOTE", headerNotes);

        // POITEMTEXT
        List<Map<String, Object>> itemTexts = new ArrayList<>();
        itemNumber = 10;
        for (OrderItems item : orderItems) {
            Map<String, Object> itemText = new HashMap<>();
            itemText.put("EBELP", itemNumber);

            List<Map<String, Object>> texts = new ArrayList<>();
            Map<String, Object> text = new HashMap<>();
            text.put("TDFORMAT", "");
            text.put("TDLINE", "itemtext");
            texts.add(text);

            itemText.put("TEXT", texts);
            itemTexts.add(itemText);
            itemNumber += 10;
        }
        requestBody.put("POITEMTEXT", itemTexts);

        try {
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(new File("request.json"), requestBody);
        } catch (Exception e) {
        }
        return requestBody;
    }

    private String callSapApi(Map<String, Object> requestBody) throws Exception {
        // SAP API endpoint - ganti dengan URL yang sesuai
        String sapApiUrl = "http://handhana01.hand-china.com:8050/indonesia/zrestapicreate?sap-client=300";
        String username = System.getenv("API_USERNAME");
        String password = System.getenv("API_PASSWORD");


        // Convert request body to JSON
        ObjectMapper mapper = new ObjectMapper();
        String jsonBody = mapper.writeValueAsString(requestBody);

        // Create HTTP client
        HttpClient client = HttpClient.newHttpClient();

        // Create basic auth header
        String auth = username + ":" + password;
        // String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());
        String encodedAuth = Base64.getEncoder().encodeToString((username + ":" + password).getBytes(StandardCharsets.UTF_8));

        System.out.println(encodedAuth);
        // Build HTTP request
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(sapApiUrl))
                // .header("Accept", "application/json")
                .header("Content-Type", "application/json")
                .header("Authorization", "Basic " + encodedAuth)
                .header("User-Agent", "Java HttpClient")
                .header("X-CSRF-Token", "Fetch")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();

        // Send request and get response
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        String responseBody = response.body();


        // Write response body to file
        Path outputPath = Paths.get("response_body.txt");
        Files.write(outputPath, responseBody.getBytes());

        if (response.statusCode() != 200 && response.statusCode() != 201) {
            throw new RuntimeException("SAP API call failed with status: " + response.statusCode()
                    + ", body: " + response.body());
        }

        return response.body();
    }

}
