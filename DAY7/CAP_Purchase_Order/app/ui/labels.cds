using from '../../srv/admin-service';

annotate AdminService.Orders with @title: '{i18n>Orders}' {
    orderNo       @Common.Label         : '{i18n>OrderNo}';
    vendor        @Common.Label: '{i18n>Vendor}'       @Common.Text: vendor.name1;
    purchOrg      @Common.Label: '{i18n>PurchOrg}'     @Common.Text: purchOrg.descr;
    purchGroup    @Common.Label: '{i18n>PurchGroup}'   @Common.Text: purchGroup.descr;
    companyCode   @Common.Label: '{i18n>CompanyCode}'  @Common.Text: companyCode.name;
    currency      @Common.Label         : '{i18n>Currency}';
    text          @Common.Label         : '{i18n>Text}';
    note          @Common.Label         : '{i18n>Note}';
    totalStock    @Common.Label         : '{i18n>TotalStock}';
    totalNetPrice @Common.Label         : '{i18n>TotalNetPrice}';
    items         @Common.Label         : '{i18n>Items}';
    status        @Common.Label: '{i18n>Status}'       @Common.Text: status.name  @Common.TextArrangement: #TextOnly;
    createdAt     @Common.Label         : '{i18n>CreatedAt}';
    createdBy     @Common.Label         : '{i18n>CreatedBy}';
    modifiedAt    @Common.Label         : '{i18n>ModifiedAt}';
    modifiedBy    @Common.Label         : '{i18n>ModifiedBy}';

};

annotate AdminService.OrderItems with @title: '{i18n>OrderItems}' {
    createdAt                 @Common.Label : '{i18n>CreatedAt}';
    createdBy                 @Common.Label : '{i18n>CreatedBy}';
    modifiedAt                @Common.Label : '{i18n>ModifiedAt}';
    modifiedBy                @Common.Label : '{i18n>ModifiedBy}';
    orderItemNo               @Common.Label : '{i18n>OrderItemNo}';
    accountAssignmentCategory @Common.Label : '{i18n>AccountAssignmentCategory}';
    itemCategory              @Common.Label : '{i18n>ItemCategory}';
    materialNo                @Common.Label : '{i18n>MaterialNo}';
    materialDescr             @Common.Label : '{i18n>MaterialDescr}';
    deliveryDateCategory      @Common.Label : '{i18n>DeliveryDateCategory}';
    stock                     @Common.Label : '{i18n>Stock}';
    deliveryDate              @Common.Label : '{i18n>DeliveryDate}';
    netPrice                  @Common.Label : '{i18n>NetPrice}';
    materialGroup             @Common.Label : '{i18n>MaterialGroup}';
    plant                     @Common.Label : '{i18n>Plant}';
    storageLocation           @Common.Label : '{i18n>StorageLocation}';
    deletionIndicator         @Common.Label : '{i18n>DeletionIndicarot}';
    text                      @Common.Label : '{i18n>Text}';
    accounts                  @Common.Label : '{i18n>Accounts}';
    stockIcon                 @Common.Label : '{i18n>StockIcon}';
    attachments               @Common.Label : '{i18n>Attachments}';
};


annotate AdminService.Accounts with @title: '{i18n>Accounts}'{
  createdAt @Common.Label :'{i18n>CreatedAt}';
  createdBy @Common.Label :'{i18n>CreatedBy}';
  modifiedAt @Common.Label :'{i18n>ModifiedAt}';
  modifiedBy @Common.Label :'{i18n>ModifiedBy}';
  accountAssgmtNo @Common.Label :'{i18n>AccountAssgmntNo}';
  accountAssignmentCategory @Common.Label :'{i18n>AccountAssignmentCategory}';
  unloadingPoint @Common.Label :'{i18n>UnloadingPoint}';
  goodsRecipient @Common.Label :'{i18n>GoodsRecipient}';
  GLAccountNo @Common.Label :'{i18n>GLAccountNo}';
  costCenter @Common.Label :'{i18n>CostCenter}';
  functionalArea @Common.Label :'{i18n>FuncitonalArea}';
  deletionIndicator @Common.Label :'{i18n>DeletionIndicator}';
};


annotate AdminService.Attachments with @title: '{i18n>Accounts}'{
  createdAt @Common.Label :'{i18n>CreatedAt}';
  createdBy @Common.Label :'{i18n>CreatedBy}';
  modifiedAt @Common.Label :'{i18n>ModifiedAt}';
  modifiedBy @Common.Label :'{i18n>ModifiedBy}';
  fileName;
  fileType;
  data @Common.Label :'{i18n>Data}';
};
