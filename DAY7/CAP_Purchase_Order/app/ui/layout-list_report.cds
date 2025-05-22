using from '../../srv/admin-service';


annotate AdminService.Orders with @(
    UI.HeaderInfo: {
        TypeName      : '{i18n>HeaderTitle}',
        TypeNamePlural: '{i18n>OrderInfo}',
    },
    UI.SelectionFields     : [
        orderNo,
    ],
    UI.LineItem  : [
        {
            $Type             : 'UI.DataField',
            Value             : orderNo,
            @UI.Importance    : #High,
            @HTML5.CssDefaults: {width: '10em'}
        },
        // {
        //     $Type: 'UI.DataField',
        //     Value: vendor_vendor
        // },
        // {
        //     $Type         : 'UI.DataField',
        //     Value         : purchOrg_purchOrg,
        // },
        
    ],

);
