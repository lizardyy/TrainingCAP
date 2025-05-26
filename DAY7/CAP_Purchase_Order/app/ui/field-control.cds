using from '../../srv/admin-service';
using from '../ui/labels';

annotate AdminService.Orders with {
    ID  @UI.Hidden @UI.HiddenFilter;
    orderNo @readonly;
    text @UI.MultiLineText : true;
    note @UI.MultiLineText : true;
    totalNetPrice @readonly;
    totalStock @readonly;
} actions {
  @(
    Common.SideEffects             : {
      TargetProperties: ['_it/ID'],
      TargetEntities  : [
        _it,
      ]
    },
    cds.odata.bindingparameter.name: '_it',
    Core.OperationAvailable        : _it.isSyncable
  )
  sync
};



annotate AdminService.OrderItems with {
    ID @UI.Hidden @UI.HiddenFilter;
    parent @UI.Hidden @UI.HiddenFilter;
};

annotate AdminService.Attachments with {
    ID @UI.Hidden @UI.HiddenFilter;
};

annotate AdminService.Accounts with {
    ID @UI.Hidden @UI.HiddenFilter;
    parent @UI.Hidden @UI.HiddenFilter;
};