using from '../../srv/admin-service';

annotate AdminService.Orders with @title: '{i18n>Orders}' {
    orderNo       @Common.Label         : '{i18n>OrderNo}';
    vendor        @Common.Label         : '{i18n>Vendor}'       @Common.Text: vendor.name1;
    purchOrg      @Common.Label         : '{i18n>PurchOrg}'     @Common.Text: purchOrg.descr;
    purchGroup    @Common.Label         : '{i18n>PurchGroup}'   @Common.Text: purchGroup.descr;
    companyCode   @Common.Label         : '{i18n>CompanyCode}'  @Common.Text: companyCode.name;
    currency      @Common.Label         : '{i18n>Currency}';
    text          @Common.Label         : '{i18n>Text}';
    note          @Common.Label         : '{i18n>Note}';
    totalStock    @Common.Label         : '{i18n>TotalStock}';
    totalNetPrice @Common.Label         : '{i18n>TotalNetPrice}';
    items         @Common.Label         : '{i18n>Items}';
    status        @Common.Label         : '{i18n>Status}'       @Common.Text: status.name  @Common.TextArrangement: #TextOnly;
};