using from '../../srv/admin-service';

annotate AdminService.Orders with @title: '{i18n>Orders}' {
    orderNo       @Common.Label         : '{i18n>OrderNo}';
    vendor        @Common.Label         : '{i18n>Vendor}';
    purchOrg      @Common.Label         : '{i18n>PurchOrg}';
    purchGroup    @Common.Label         : '{i18n>PurchGroup}';
    companyCode   @Common.Label         : '{i18n>CompanyCode}';
    currency      @Common.Label         : '{i18n>Currency}';
    text          @Common.Label         : '{i18n>Text}';
    note          @Common.Label         : '{i18n>Note}';
    totalStock    @Common.Label         : '{i18n>TotalStock}';
    totalNetPrice @Common.Label         : '{i18n>TotalNetPrice}';
    items         @Common.Label         : '{i18n>Items}';
    status        @Common.Label         : '{i18n>Status}';
};

annotate AdminService.Vendors {
    vendor  @Common.Text: name1;
}

annotate AdminService.PurchOrganizations {
    purchOrg @common.Label: '{i18n>PurchOrg}';
};

annotate AdminService.PurchasingGroups {
    purchGroup @Common.Label: '{i18n>PurchGroup}';
};

annotate AdminService.Companies {
    companyCode @Common.Label: '{i18n>CompanyCode}';
};

annotate AdminService.status {
    name @Common.Label: '{i18n>Status}';
};
