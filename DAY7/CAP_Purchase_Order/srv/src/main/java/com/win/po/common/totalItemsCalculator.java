package com.win.po.common;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Select;
import com.sap.cds.Result;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.adminservice.AdminService;
import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.OrderItems;
import cds.gen.adminservice.OrderItems_;
import cds.gen.adminservice.Orders;

@Component
public class totalItemsCalculator {
    
    @Autowired
    private PersistenceService db;

    public void calculateTotal(List<Orders> orders){
        for (Orders order : orders) {
            order.setTotalNetPrice(BigDecimal.ZERO);
            order.setTotalStock(BigDecimal.ZERO);

            Result result = db.run(Select.from(AdminService_.ORDER_ITEMS)
            .where(o -> o.parent_ID().eq(order.getId())));

            for (OrderItems orderItem : result.listOf(OrderItems.class)) {
                order.setTotalNetPrice(
                    orderItem.getNetPrice() != null 
                    ? orderItem.getNetPrice().add(order.getTotalNetPrice())
                    : order.getTotalNetPrice()
                );
                order.setTotalStock(
                    orderItem.getStock() != null 
                    ? orderItem.getStock().add(order.getTotalStock())
                    : order.getTotalStock()
                );
            }
        }
    }
}
