using from '../../srv/admin-service';
using from '../ui/layout-list_report';

annotate AdminService.Orders with @(
    UI.HeaderInfo  : {
        TypeName : '{i18n>HeaderTitle}',
        TypeNamePlural : '{i18n>OrderInfro}',
        Title : {Value: orderNo},
        TypeImageUrl: 'sap-icon://accelerated'
    },
    UI.HeaderFacets  : [
                {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>POOverview}',
            ID    : 'Header',
            Target: '@UI.FieldGroup#Basic_info'
        }
    ],
    UI.FieldGroup #Basic_info    : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: totalStock
            },
            {
                $Type: 'UI.DataField',
                Value: totalNetPrice
            },
            {
                $Type: 'UI.DataField',
                Value: status_code
            }
        ]
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>General}',
            ID    : 'General',
            Target: '@UI.FieldGroup#General'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrganizationInfo}',
            ID    : 'OrganizationInfo',
            Target: '@UI.FieldGroup#OrganizationInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Texts}',
            ID    : 'Texts',
            Target: '@UI.FieldGroup#Texts'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Items}',
            Target: 'items/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Attachments}',
            Target: 'attachments/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Administrative',
            ID    : 'Administrative',
            Target: '@UI.FieldGroup#Administrative'
        },
    ],
    UI.FieldGroup #General        : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: orderNo
            },
            {
                $Type: 'UI.DataField',
                Value: vendor_vendor
            },
            {
                $Type: 'UI.DataField',
                Value: currency_code
            },

        ]
    },
    UI.FieldGroup #OrganizationInfo       : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: companyCode_companyCode
            },
            {
                $Type: 'UI.DataField',
                Value:purchOrg_purchOrg
            },
            {
                $Type: 'UI.DataField',
                Value: purchGroup_purchGroup
            },

        ]
    },
    UI.FieldGroup #Texts      : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: text
            },
            {
                $Type: 'UI.DataField',
                Value: note
            },

        ]
    },
    UI.FieldGroup #Administrative: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: createdAt,
                Label: '{i18n>Createdat}'
            },
            {
                $Type: 'UI.DataField',
                Value: createdBy,
                Label: '{i18n>Createdby}'
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedAt,
                Label: '{i18n>Modifiedat}'
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedBy,
                Label: '{i18n>Modifiedby}'
            }
        ]
    }
);

annotate AdminService.OrderItems with @(UI: {
    PresentationVariant        : {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : orderItemNo,
            Descending: true
        }, ],
    },
    LineItem                   : [
        {
            Value             : orderItemNo,
            Label             : '{i18n>OrderItemNo}',
            @HTML5.CssDefaults: {width: '15em'}
        },
        {
            Value: accountAssignmentCategory,
            Label: '{i18n>AccountAssignmentCategory}'
        },
        {
            Value: itemCategory,
            Label: '{i18n>ItemCategory}'
        },
        {
            Value: materialNo,
            Label: '{i18n>MaterialNo}'
        },
        {
            Value: materialDescr,
            Label: '{i18n>MaterialDescr}'
        },
        {
            Value: deliveryDateCategory,
            Label: '{i18n>DeliveryDateCategory}'
        },
        {
            Value: deliveryDate,
            Label: '{i18n>DelivertDate}'
        },
        {
            Value: stock,
            Label: '{i18n>Stock}'
        },
        {
            Value: netPrice,
            Label: '{i18n>NetPrice}'
        },
        {
            Value: materialGroup,
            Label: '{i18n>MaterialGroup}'
        },
        {
            Value: plant_plant,
            Label: '{i18n>Plant}'
        },
        {
            Value: storageLocation_storageLocation,
            Label: '{i18n>StorageLocation}'
        },
        {
            Value: text,
            Label: '{i18n>Text}'
        },
        {
            Value: modifiedBy,
            Label: '{i18n>ModifiedBy}'
        },
        {
            Value: modifiedAt,
            Label: '{i18n>ModifiedAt}'
        },
        {
            Value: createdBy,
            Label: '{i18n>CreatedBy}'
        },
        {
            Value: createdAt,
            Label: '{i18n>CreatedAt}'
        },
    ]
});



annotate AdminService.Attachments with @(UI: {
    PresentationVariant        : {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : ID,
            Descending: true
        }, ],
    },
    LineItem                   : [
        {
            Value             : data,
            Label             : '{i18n>Data}',
            @HTML5.CssDefaults: {width: '15em'}
        },
        {
            Value: createdAt,
            Label: '{i18n>CreatedAt}'
        },
        {
            Value: createdBy,
            Label: '{i18n>CreatedBy}'
        },
                {
            Value: modifiedAt,
            Label: '{i18n>ModifiedAt}'
        },
                {
            Value: modifiedAt,
            Label: '{i18n>ModifiedAt}'
        },
    ]
});
