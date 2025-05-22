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
            @HTML5.CssDefaults: {width: '10em'}
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
            Label: '{i18n>PurchOrg}', 
            ![@UI.Importance] : #High,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : purchGroup_purchGroup,
            Label: '{i18n>PurchGroup}',
            ![@UI.Importance] : #High,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : companyCode_companyCode,
            Label: '{i18n>CompanyCode}',
            ![@UI.Importance] : #High,
            @HTML5.CssDefaults: {width: '7em'}

        },
        {
            $Type             : 'UI.DataField',
            Value             : totalStock,
            ![@UI.Importance] : #Medium,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : totalNetPrice,
            ![@UI.Importance] : #Medium,
            @HTML5.CssDefaults: {width: '12em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : status_code,
            Criticality       : statusIcon,
            @HTML5.CssDefaults: {width: '8em'},
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
            Descending: true
        }],
        GroupBy       : [vendor_vendor],
        Visualizations: ['@UI.LineItem']
    }
);
