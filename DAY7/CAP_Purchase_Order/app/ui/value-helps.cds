using from '../../srv/admin-service';
annotate AdminService.Orders with {
    orderNo @(
        Common.ValueList :{
            $Type : 'Common.ValueListType',
            CollectionPath : 'Orders',
            Label   : '{i18n>OrderNo}',
            PresentationVariantQualifier :'vh_Orders_orderNo',
            Parameters :[
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: orderNo,
                    ValueListProperty: 'orderNo',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty : vendor_vendor,
                    ValueListProperty : 'vendor_vendor'
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : purchGroup_purchGroup,
                    ValueListProperty : 'purchGroup_purchGroup',
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : purchOrg_purchOrg,
                    ValueListProperty : 'purchOrg_purchOrg',
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : companyCode_companyCode,
                    ValueListProperty : 'companyCode_companyCode',
                },
            ],
            
        },
        Common.ValueListWithFixedValues: false
    );
    vendor @(
        Common.ValueList :{
            $Type : 'Common.ValueListType',
            CollectionPath : 'Vendors',
            Label   : '{i18n>Vendors}',
            PresentationVariantQualifier :'vh_Orders_vendor',
            Parameters :[
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: vendor_vendor,
                    ValueListProperty: 'vendor',    
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'country',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'currency_code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name1',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name2',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name3',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name4',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'city',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'street',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'address',
                },
            ]
        },
        Common.ValueListWithFixedValues: false
    );
    purchOrg @(
        Common.ValueList :{
            $Type : 'Common.ValueListType',
            CollectionPath : 'PurchOrganizations',
            Label   : '{i18n>PurchOrg}',
            PresentationVariantQualifier :'vh_Orders_purchOrg',
            Parameters :[
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: purchOrg_purchOrg,
                    ValueListProperty: 'purchOrg',    
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'descr',
                },
                                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'companyCode',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'schemaGroup',
                },
                
            ]
        },
        Common.ValueListWithFixedValues: false
    );
    purchGroup @(
        Common.ValueList :{
            $Type : 'Common.ValueListType',
            CollectionPath : 'PurchasingGroups',
            Label   : '{i18n>PurchGroup}',
            PresentationVariantQualifier :'vh_Orders_purchGroup',
            Parameters :[
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: purchGroup_purchGroup,
                    ValueListProperty: 'purchGroup',    
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'descr',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'tel',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'outputDevice',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'faxNo',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'eMail',
                },
                
            ]
        },
        Common.ValueListWithFixedValues: false
    );
    companyCode @(
        Common.ValueList :{
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Label   : '{i18n>CompanyCode}}',
            PresentationVariantQualifier :'vh_Orders_companyCode',
            Parameters :[
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: companyCode_companyCode,
                    ValueListProperty: 'companyCode',    
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'city',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'country',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'currency',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'language',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'charOfAccts',
                },
            ]
        },
        Common.ValueListWithFixedValues: false
    );
    
    status @Common.ValueListWithFixedValues;
};


annotate AdminService.Orders with @(
    UI.PresentationVariant #vh_Orders_orderNo    : {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : orderNo,
            Descending: false,
        }, ],
    },
    UI.PresentationVariant #vh_Orders_vendors    : {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : vendor_vendor,
            Descending: false,
        }, ],
    },
    UI.PresentationVariant #vh_Orders_companyCode: {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : companyCode_companyCode,
            Descending: false,
        }, ],
    },
    UI.PresentationVariant #vh_Orders_purchOrg   : {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : purchOrg_purchOrg,
            Descending: false,
        }, ],
    },
    UI.PresentationVariant #vh_Orders_purchGroup : {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : purchGroup_purchGroup,
            Descending: false,
        }, ],
    }
);
