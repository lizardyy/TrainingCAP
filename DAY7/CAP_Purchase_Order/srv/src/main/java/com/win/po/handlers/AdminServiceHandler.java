package com.win.po.handlers;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import com.win.po.common.totalItemsCalculator;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.Orders;
import cds.gen.adminservice.Orders_;

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
            }
        };
    }
}
