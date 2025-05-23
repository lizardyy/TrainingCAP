using from '../../srv/admin-service';
using from '../ui/layout-list_report';

annotate AdminService.Orders with @(
    UI.HeaderInfo                  : {
        TypeName      : '{i18n>HeaderTitle}',
        TypeNamePlural: '{i18n>OrderInfo}',
        Title         : {Value: orderNo},
        TypeImageUrl  : 'sap-icon://accelerated'
    },
    UI.HeaderFacets                : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>POOverview}',
        ID    : 'Header',
        Target: '@UI.FieldGroup#Basic_info'
    }],
    UI.FieldGroup #Basic_info      : {
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
                $Type      : 'UI.DataField',
                Value      : status_code,
                Criticality: statusIcon,
            }
        ]
    },
    UI.Facets                      : [
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
    UI.FieldGroup #General         : {
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
    UI.FieldGroup #OrganizationInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: companyCode_companyCode
            },
            {
                $Type: 'UI.DataField',
                Value: purchOrg_purchOrg
            },
            {
                $Type: 'UI.DataField',
                Value: purchGroup_purchGroup
            },

        ]
    },
    UI.FieldGroup #Texts           : {
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
    UI.FieldGroup #Administrative  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: createdAt,
            },
            {
                $Type: 'UI.DataField',
                Value: createdBy,
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedAt,
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedBy,
            }
        ]
    }
);


annotate AdminService.OrderItems with @(
    UI.HeaderInfo            : {
        TypeName      : '{i18n>HeaderItemTitle}',
        TypeNamePlural: '{i18n>OrderItemInfo}',
        Title         : {Value: parent_ID},
        TypeImageUrl  : 'sap-icon://accelerated'
    },
    UI.HeaderFacets          : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'Header',
        Target: '@UI.FieldGroup#Basic_info'
    }],
    UI.FieldGroup #Basic_info: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: orderItemNo
            },
            {
                $Type: 'UI.DataField',
                Value: materialNo
            },
            {
                $Type: 'UI.DataField',
                Value: materialDescr
            },
            {
                $Type: 'UI.DataField',
                Value: stock,
                Criticality:stockIcon
            },
            {
                $Type: 'UI.DataField',
                Value: netPrice,
            },
        ]
    },
    UI.Facets                : [

        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Items}',
            Target: 'accounts/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Attachments}',
            Target: 'attachments/@UI.LineItem'
        },
    ],

);
