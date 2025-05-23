using from '../../srv/admin-service';


annotate AdminService.Orders with @(
    UI.HeaderInfo         : {
        TypeName      : '{i18n>HeaderTitle}',
        TypeNamePlural: '{i18n>OrderInfo}',
    },
    UI.SelectionFields    : [
        orderNo,
        vendor_vendor,
        purchOrg_purchOrg,
        purchGroup_purchGroup,
        companyCode_companyCode,
        currency_code,
        status_code
    ],
    UI.LineItem           : [
        {
            $Type             : 'UI.DataField',
            Value             : orderNo,
            @UI.Importance    : #High,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : vendor_vendor,
            @UI.Importance    : #High,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : purchOrg_purchOrg,
            Label             : '{i18n>PurchOrg}',
            ![@UI.Importance] : #High,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : purchGroup_purchGroup,
            Label             : '{i18n>PurchGroup}',
            ![@UI.Importance] : #High,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : companyCode_companyCode,
            Label             : '{i18n>CompanyCode}',
            ![@UI.Importance] : #High,
            @HTML5.CssDefaults: {width: '7em'}

        },
        {
            $Type             : 'UI.DataField',
            Value             : totalStock,
            ![@UI.Importance] : #Medium,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : totalNetPrice,
            ![@UI.Importance] : #Medium,
            @HTML5.CssDefaults: {width: '15em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : status_code,
            Criticality       : statusIcon,
            @HTML5.CssDefaults: {width: '7em'},
            ![@UI.Importance] : #High

        },
        {
            $Type             : 'UI.DataField',
            Value             : text,
            ![@UI.Importance] : #Low,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : note,
            ![@UI.Importance] : #Low,
            @HTML5.CssDefaults: {width: '10em'}
        },

    ],
    UI.PresentationVariant: {
        SortOrder     : [{
            $Type     : 'Common.SortOrderType',
            Property  : orderNo,
            Descending: false
        }],
        GroupBy       : [vendor_vendor],
        Visualizations: ['@UI.LineItem']
    }
);


annotate AdminService.OrderItems with @(
    UI    : {
        HeaderInfo         : {
            TypeName      : '{i18n>OrderItemTitle}',
            TypeNamePlural: '{i18n>OrderItemInfo}',
        },
        PresentationVariant: {
            $Type    : 'UI.PresentationVariantType',
            SortOrder: [{
                $Type     : 'Common.SortOrderType',
                Property  : orderItemNo,
                Descending: true
            }, ],
        },
        LineItem           : [
            {
                Value             : orderItemNo,
                @HTML5.CssDefaults: {width: '7em'},
            },
            {
                Value             : accountAssignmentCategory,
                @HTML5.CssDefaults: {width: '7em'}
            },
            {
                Value             : itemCategory,
                @HTML5.CssDefaults: {width: '7em'}
            },
            {
                Value             : materialNo,
                @HTML5.CssDefaults: {width: '15em'}
            },
            {
                Value             : materialDescr,
                @HTML5.CssDefaults: {width: '15em'}
            },
            {
                Value             : deliveryDateCategory,
                @HTML5.CssDefaults: {width: '7em'}
            },
            {
                Value             : deliveryDate,
                @HTML5.CssDefaults: {width: '10em'}
            },
            {
                Value             : stock,
                Criticality       : stockIcon,
                @HTML5.CssDefaults: {width: '10em'}
            },
            {
                Value             : netPrice,
                @HTML5.CssDefaults: {width: '15em'}
            },
            {
                Value             : materialGroup,
                @HTML5.CssDefaults: {width: '10em'}
            },
            {
                Value             : plant_plant,
                @HTML5.CssDefaults: {width: '10em'}
            },
            {
                Value             : storageLocation_storageLocation,
                @HTML5.CssDefaults: {width: '10em'}
            },
            {
                Value             : text,
                @HTML5.CssDefaults: {width: '15em'}
            },

        ]
    },
    Common: {SideEffects #stockChanged: {
        SourceProperties: [stock],
        TargetProperties: [
            'netPrice',
            'stockIcon'
        ]
    }}
);


annotate AdminService.Attachments with @(UI: {
    PresentationVariant: {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : ID,
            Descending: true
        }, ],
    },
    LineItem           : [
        {
            Value             : data,
            Label             : '{i18n>Data}',
            @HTML5.CssDefaults: {width: '20em'}
        },
        {
            Value             : createdAt,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            Value             : createdBy,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            Value             : modifiedAt,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            Value             : modifiedBy,
            @HTML5.CssDefaults: {width: '10em'}
        },
    ]
});


annotate AdminService.Accounts with @(UI: {
    PresentationVariant: {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : ID,
            Descending: true
        }, ],
    },
    LineItem           : [
        {
            Value             : accountAssgmtNo,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            Value             : accountAssignmentCategory,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            Value             : unloadingPoint,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            Value             : goodsRecipient,
            @HTML5.CssDefaults: {width: '15em'}
        },
        {
            Value             : GLAccountNo,
            @HTML5.CssDefaults: {width: '15em'},
        },
        {
            Value             : costCenter,
            @HTML5.CssDefaults: {width: '10em'},
        },
        {
            Value             : functionalArea,
            @HTML5.CssDefaults: {width: '10em'},
        },

    ]
});
