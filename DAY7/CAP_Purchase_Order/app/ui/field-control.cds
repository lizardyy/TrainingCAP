using from '../../srv/admin-service';
using from '../ui/labels';

annotate AdminService.Orders with {
    orderNo @UI.Hidden @UI.HiddenFilter;
    text @UI.MultiLineText : true;
    note @UI.MultiLineText : true;
    totalNetPrice @readonly;
    totalStock @readonly;
}