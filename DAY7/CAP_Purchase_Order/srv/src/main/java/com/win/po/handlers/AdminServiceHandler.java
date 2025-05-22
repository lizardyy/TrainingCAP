package com.win.po.handlers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.adminservice.AdminService_;

@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler{
    @Autowired
    private PersistenceService db;
    
    @Autowired
    private CdsModel model;
}
