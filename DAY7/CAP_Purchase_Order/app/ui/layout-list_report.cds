using from '../../srv/admin-service';


annotate AdminService.Orders with @(
    UI.HeaderInfo         : {
        TypeName      : '{i18n>HeaderTitle}',
        TypeNamePlural: '{i18n>OrderInfo}',
    },
    UI.SelectionFields    : [orderNo, ],
    UI.LineItem           : [
        {
            $Type             : 'UI.DataField',
            Value             : orderNo,
            @UI.Importance    : #High,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : vendor.vendor,
            Label             : '{i18n>Vendor}',
            @HTML5.CssDefaults: {width: '12em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : purchOrg.purchOrg,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : purchGroup.purchGroup,
            @HTML5.CssDefaults: {width: '7em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : companyCode.companyCode,
            @HTML5.CssDefaults: {width: '7em'}

        },
        {
            $Type             : 'UI.DataField',
            Value             : totalStock,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : totalNetPrice,
            @HTML5.CssDefaults: {width: '12em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : status.name,
            @HTML5.CssDefaults: {width: '8em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : text,
            @HTML5.CssDefaults: {width: '10em'}
        },
        {
            $Type             : 'UI.DataField',
            Value             : note,
            @HTML5.CssDefaults: {width: '10em'}
        },

    ],
    UI.PresentationVariant: {
        SortOrder     : [{
            $Type     : 'Common.SortOrderType',
            Property  : orderNo,
            Descending: true
        }],
        GroupBy       : [vendor.vendor],
        Visualizations: ['@UI.LineItem']
    }
);
