package com.win.po.handlers;
import java.math.BigDecimal;
import java.util.List;
import java.util.function.Supplier;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Select;
import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import com.win.po.common.MessageKeys;
import com.win.po.common.totalItemsCalculator;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.OrderItems;
import cds.gen.adminservice.OrderItems_;
import cds.gen.adminservice.Orders;
import cds.gen.adminservice.Orders_;
import cds.gen.adminservice.Vendors;
import cds.gen.adminservice.Vendors_;

@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler{
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
                    ?   3 
                    :   order.getStatus().containsValue("S") 
                        ? 2 
                        : 1
                );
            } catch (NullPointerException e) {
                
                throw new ServiceException(ErrorStatuses.SERVER_ERROR, MessageKeys.ICON_FAILED, e);
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
                throw new ServiceException(ErrorStatuses.SERVER_ERROR, MessageKeys.ICON_FAILED, e);
            }
        }
    }

        @Before(event = { CqnService.EVENT_CREATE, CqnService.EVENT_UPDATE }, entity = Orders_.CDS_NAME)
    public void beforeCreateOrUpdateOrder(Orders order) {
        order.setStatusCode("S");
        order.setCurrencyCode(db.run(Select.from(Vendors_.class).where(o -> o.vendor().eq(order.getVendorVendor())))
                .first(Vendors.class).orElseThrow(notFound(MessageKeys.ORDER_MISSING)).getCurrencyCode());
    }

    private Supplier<ServiceException> notFound(String message) {
        return () -> new ServiceException(ErrorStatuses.NOT_FOUND, message);
    }
}
