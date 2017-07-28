@isTest
private class M2O_CPQ_TestCMnCustomTemplateCtrl {

    //creates a 'ModelN Test Account' and returns it
    static Account createAccount() {
        Account acct = new Account(Name = 'ModelN Test Account');
        Database.upsert(acct);
        return acct;
    }

    //creates a 'ModelN Test Opportunity' and returns it
    static Opportunity createOpportunity(Account acct) {
        return  createOpportunity('ModelN Test Opportunity', acct);
    }

    static Opportunity createOpportunity(String oppName, Account acct){
        Opportunity opp = new Opportunity(Name = oppName,
                closeDate = System.Today() + 30,
                stageName = 'Prospecting',
                accountid = acct.id);
        Database.upsert(opp);
        return opp;
    }

    static REVVY__MnQuote__c createQuote(){
        Account acct = createAccount();
        Opportunity opp = createOpportunity(acct);
        return createQuote(acct, opp);
    }

    //creates a 'ModelN Test Quote' and returns it
    static REVVY__MnQuote__c createQuote(Account acct, Opportunity opp) {
        REVVY__MnQuote__c quote = new REVVY__MnQuote__c(Name = 'ModelN Test Quote',
                REVVY__account__c = acct.Id,
                REVVY__opportunity__c = opp.Id,
                REVVY__status__c = 'Draft',
                REVVY__expiration_date__c = System.Today());
        Database.upsert(quote);
        return quote;
    }

    //creates a 'ModelN Test Product' and returns it.
    static REVVY__MnCatalogNode__c createProduct() {
        return createProduct('ModelN Test Product');
    }


    //creates a 'ModelN Test Product' and returns it.
    static REVVY__MnCatalogNode__c createProduct(String prodName) {
        REVVY__MnCatalogNode__c prod = new REVVY__MnCatalogNode__c( Name = prodName,
                REVVY__Id__c = prodName,
                REVVY__status__c = 'Active',
                REVVY__type__c = 'Product',
                REVVY__mainImage1__c = 'mainimage1path',
                REVVY__image2__c = 'image2path',
                REVVY__image3__c = 'image3path',
                REVVY__image4__c = 'image4path');
        //this is called from many places where we are running as user
        // who doesn't have permissions to create product. It's ok to skip CRUD/FLS
        Database.upsert(prod);
        return prod;
    }

    static REVVY__MnPriceList__c createPriceList() {
        REVVY__MnPriceList__c pl =  new REVVY__MnPriceList__c(name = 'ModelN Test PriceList',
                REVVY__currency__c = 'USD',
                REVVY__Id__c = 'the_price_list',
                REVVY__Segment__c = 'General',
                REVVY__Start_date__c = System.Today(),
                REVVY__end_date__c = System.Today()+30,
                REVVY__status__c = 'Active');
        Database.upsert(pl);
        return pl;
    }

    static REVVY__MnCatalogNode__c createBundle(String bundleName, Integer numberProductsInBundle) {
        REVVY__MnCatalogNode__c bund = new REVVY__MnCatalogNode__c( Name = bundleName,
                REVVY__Id__c = bundleName,
                REVVY__status__c = 'Active',
                REVVY__type__c = 'Bundle');
        Database.upsert(bund);

        List<REVVY__MnCatalogNodeEdge__c> edgeList = new List<REVVY__MnCatalogNodeEdge__c>();
        List<REVVY__MnCatalogNode__c> prodList = new List<REVVY__MnCatalogNode__c>();


        for (Integer i = 0; i < numberProductsInBundle; i++) {
            REVVY__MnCatalogNode__c prod = new REVVY__MnCatalogNode__c(Name = bundleName+'__'+i,
                    REVVY__Id__c = bundleName+'__'+i,
                    REVVY__status__c = 'Active',
                    REVVY__type__c = 'Product');

            prodList.add(prod);
        }
        Database.upsert(prodList);
        String prodMatch = bundleName + '__%';
        prodList = [SELECT Id FROM REVVY__MnCatalogNode__c WHERE Name LIKE :prodMatch];

        for (Integer i = 0 ; i < prodList.size() ; i++) {
            REVVY__MnCatalogNodeEdge__c edge = new REVVY__MnCatalogNodeEdge__c();
            edge.REVVY__Quantity__c = 1;
            edge.REVVY__Parent__c = bund.Id;
            edge.REVVY__Child__c = prodList[i].Id;
            edge.REVVY__Relative_Level__c = 1;
            edgeList.add(edge);
        }

        Database.upsert(edgeList);
        return bund;
    }

    static REVVY__MnPriceListLine__c createPriceListLine(REVVY__MnCatalogNode__c prod, REVVY__MnPriceList__c pl) {
        if (prod == null) prod = createProduct();
        if (pl == null) pl = createPriceList();
        REVVY__MnPriceListLine__c pll = new REVVY__MnPriceListLine__c(
                REVVY__start_date__c = pl.REVVY__start_date__c,
                REVVY__end_date__c = pl.REVVY__end_date__c,
                REVVY__ListedPrice__c = 50,
                REVVY__product__c =prod.id,
                REVVY__pricelist__c = pl.id);
        Database.upsert(pll);
        return pll;
    }

    //creates a quote item for given quote and product with quantity 1.                                                  
    static REVVY__MnQuoteItem__c createQuoteItem(REVVY__MnQuote__c quot, REVVY__MnCatalogNode__c prod) {
        REVVY__MnQuoteItem__c qi = new REVVY__MnQuoteItem__c(
                REVVY__catalog_Node__c = prod.Id,
                REVVY__quantity__c = 1,
                REVVY__quote__c = quot.Id);
        Database.upsert(qi);
        return qi;
    }


    static REVVY__MnQuoteItemSubLine__c createQuoteItemSublineNoSave(
        REVVY__MnCatalogNode__c prod, REVVY__MnQuoteItem__c qi, String billingFreq)
    {
        REVVY__MnQuoteItemSubLine__c qis = new REVVY__MnQuoteItemSubLine__c(
                REVVY__catalog_Node__c = prod.Id,
                REVVY__quoteItem__c = qi.Id,
                REVVY__Billing_Frequency_WF__c = billingFreq
        );
        return qis;
    }

    static REVVY__MnQuoteItem__c[] getQuoteItems(Id quoteId, Id quoteItemId) {
        //List<Schema.FieldSetMember> quoteItemFields = 
            //SObjectType.REVVY__MnQuoteItem__c.FieldSets.Line_Detail_Fields.getFields();
        String query = 'SELECT ';

        //for(Schema.FieldSetMember f : quoteItemFields) {
            //query += f.getFieldPath() + ', ';
        //}

        query += 
                ' REVVY__Is_Configuration_Complete__c,REVVY__ProductConfig__c,REVVY__Catalog_Node__r.REVVY__Model__c,' +
                ' REVVY__Catalog_Node__r.REVVY__Configurable__c,' +
                ' REVVY__Catalog_Node__r.Name,REVVY__Price__c,REVVY__Unit_Price__c,REVVY__Discount__c,REVVY__Quantity__c,' +
                ' REVVY__Catalog_Node__r.REVVY__Type__c,REVVY__Catalog_Node__r.REVVY__Billing_Frequency__c,REVVY__Record_Number__c,' +
                ' REVVY__Catalog_Node__r.REVVY__mainImage1__c,REVVY__Catalog_Node__r.REVVY__Id__c,REVVY__Discount_Absolute__c,REVVY__Discount_Type__c,' +
                ' REVVY__Extended_Price_F__c,REVVY__Catalog_Node__r.REVVY__image2__c,REVVY__Catalog_Node__r.REVVY__image3__c,' +
                'REVVY__Catalog_Node__r.REVVY__image4__c,REVVY__Monthly_Total_Value_F__c,REVVY__Monthly_Discount_F__c,' +
                'REVVY__Monthly_Discount_Absolute_F__c,REVVY__Monthly_Extended_Price_F__c,REVVY__Monthly_Price_Before_Discount_F__c,'+
                ' REVVY__Yearly_Total_Value_F__c,REVVY__Yearly_Discount_F__c,REVVY__Yearly_Discount_Absolute_F__c,REVVY__Yearly_Extended_Price_F__c,REVVY__Yearly_Price_Before_Discount_F__c,' +
                ' REVVY__Weekly_Total_Value_F__c,REVVY__Weekly_Discount_F__c,REVVY__Weekly_Discount_Absolute_F__c,REVVY__Weekly_Extended_Price_F__c,REVVY__Weekly_Price_Before_Discount_F__c,' +
                ' REVVY__One_Time_Total_Value_F__c,REVVY__One_Time_Discount_F__c,REVVY__One_Time_Discount_Absolute_F__c,REVVY__One_Time_Extended_Price_F__c,REVVY__One_Time_Price_Before_Discount_F__c ' +
                ' FROM REVVY__MnQuoteItem__c where REVVY__quote__c = :quoteId';

        if (quoteItemId != null) query += ' AND  id = :quoteItemId';

        return Database.query(query);
    }

    static REVVY__MnQuoteItem__c getNewQuoteItem(ID productId, Integer quantity, ID quoteId) {
        REVVY__MnQuoteItem__c newQuoteItem = new REVVY__MnQuoteItem__c();
        //quoteId == null implies QuoteItem is been created directly
        if (quoteId == null) {
            return newQuoteItem;
        }

        newQuoteItem.REVVY__Catalog_Node__c = productId;
        newQuoteItem.REVVY__Quantity__c = quantity;
        newQuoteItem.REVVY__Quote__c = quoteId;

        Database.upsert(newQuoteItem);

        newQuoteItem = getQuoteItems(quoteId, newQuoteItem.Id)[0];

        String productType = newQuoteItem.REVVY__Catalog_Node__r.REVVY__Type__c;
        if (productType == 'Bundle') {
            List<REVVY__MnQuoteItem__c> quoteItems = new List<REVVY__MnQuoteItem__c>();
            quoteItems.add(newQuoteItem);
            createSublines(quoteItems);
        }

        return newQuoteItem;
    }

    static List<REVVY__MnQuoteItemSubLine__c> createSublines(List<REVVY__MnQuoteItem__c> quoteItems) {
        List<REVVY__MnQuoteItemSubLine__c> subLineList = new List<REVVY__MnQuoteItemSubLine__c>();

        List<ID> prodIds = new List<ID>();
        for (REVVY__MnQuoteItem__c item : quoteItems) {
            prodIds.add(item.REVVY__Catalog_Node__c);
        }

        Map<ID, List<REVVY__MnCatalogNodeEdge__c>> prodEdgeMap = new Map<ID, List<REVVY__MnCatalogNodeEdge__c>>();
        for (REVVY__MnCatalogNodeEdge__c edge : 
                [Select m.REVVY__Quantity__c, m.REVVY__Parent__r.Name, m.REVVY__Parent__r.Id, 
                 m.REVVY__Child__r.Name, m.REVVY__Relative_Level__c
                 FROM REVVY__MnCatalogNodeEdge__c m
                 WHERE m.REVVY__Parent__r.Id IN : prodIds AND 
                 m.REVVY__Relative_Level__c = 1.0 AND m.REVVY__Parent__r.REVVY__Type__c = 'Bundle'])
        {
             List<REVVY__MnCatalogNodeEdge__c>  edgeList =  prodEdgeMap.get(edge.REVVY__Parent__r.Id);
             if (edgeList == null) {
                  edgeList = new  List<REVVY__MnCatalogNodeEdge__c>();
                  prodEdgeMap.put(edge.REVVY__Parent__r.Id, edgeList);
             }
             edgeList.add(edge);
        }

        for (REVVY__MnQuoteItem__c item : quoteItems) {
            List<REVVY__MnCatalogNodeEdge__c>  edgeList =  prodEdgeMap.get(item.REVVY__Catalog_Node__c);
            if (edgeList != null) {
                 for (REVVY__MnCatalogNodeEdge__c edge : edgeList) {
                     REVVY__MnQuoteItemSubLine__c subline = new REVVY__MnQuoteItemSubLine__c();
                     subline.REVVY__QuoteItem__c = item.Id;
                     subline.REVVY__Catalog_Node__c = edge.REVVY__Child__r.Id;
                     subline.REVVY__Quantity__c = edge.REVVY__Quantity__c;
                     subLineList.add(subline);
                 }
            }
        }
        Database.upsert(subLineList);
        return subLineList;
    }


    static REVVY__MnConfigEngineModel__c createModel(String modelName) {
        REVVY__MnConfigEngineModel__c model = new REVVY__MnConfigEngineModel__c();
        model.REVVY__Id__c = modelName;
        Database.upsert(model);
        return model;
    }

    // Commented out since this requires that CPQ Test profile exist
    static void giveObjectsFullAccess(List<String> objs, Id permSetId) {
        String nPrefix = 'REVVY__';
        List<ObjectPermissions> objPerms = new List<ObjectPermissions>();
        for (String objName : objs) {
            objPerms.add(new ObjectPermissions(parentid=permSetId,
                    permissionsRead=true, PermissionsCreate=true,
                    PermissionsEdit=true, PermissionsDelete=true,
                    PermissionsViewAllRecords=true,
                    PermissionsModifyAllRecords=true,
                    sobjecttype = (objName.startsWithIgnoreCase('mn')? (nPrefix + objName) : objName)));
        }
        Database.upsert(objPerms);
    }

    static void giveFieldsReadAccess(String objName , List<String> fieldNames, Id permSetId) {
        String nPrefix = 'REVVY__';
        List<FieldPermissions> fieldPerms = new List<FieldPermissions>();
        for(String fieldName : fieldNames) {
            fieldPerms.add(new FieldPermissions(parentid=permSetId,
                    Field=nPrefix + objName + '.' + nPrefix + fieldName,
                    permissionsEdit=false,
                    permissionsRead=true,
                    sobjecttype=nPrefix + objName));

        }
        Database.upsert(fieldPerms);
    }

    static testMethod void testAllProposalTemplatePageApis() {
        Account acct = createAccount();
        Opportunity opp = createOpportunity(acct);
        REVVY__MnPriceList__c pl = createPriceList();

        REVVY__MnQuote__c qt = createQuote(acct, opp);

        PageReference pageref = Page.M2O_CPQ_PMnCustomTemplate;
        pageRef.getParameters().putAll(new Map<String,String>{
            'quoteId'=>qt.Id
        });
        Test.setCurrentPage(pageRef);


        // Create some test data
        REVVY__MnPrintTemplate__c pt = new REVVY__MnPrintTemplate__c(
                    REVVY__VisualforcePageName__c='pg1', Name='testpt1');

        Database.upsert(pt);

        REVVY__MnQuoteProposalParameter__c qp = new REVVY__MnQuoteProposalParameter__c();
        qp.REVVY__usedTemplate__c = pt.Id;
        qp.REVVY__quote__c = qt.Id;
        qp.REVVY__proposalTitle__c = 'ProposalTest';

        Database.upsert(qp);

        M2O_CPQ_CMnCustomTemplateCtrl poCtrl = new M2O_CPQ_CMnCustomTemplateCtrl();
        System.assertEquals(poCtrl.quote.Id, qt.Id);
        //Quote_N010_US15815_001 FLS checks
        //make sure user with proper rights can see display discount checkbox
        //on proposal page.
        System.assertEquals(poCtrl.displayquoteDiscount , 'table-cell');

        User cpqTest = null;

        System.runAs(new User(Id = Userinfo.getUserId())) {
            //create a test user using test user profile.
            Profile testProfile = [SELECT Id FROM Profile WHERE Name='CPQ Test'];
            UserRole repRole = new UserRole(name = 'ProposalTestRepRole');
            Database.upsert(repRole);
            cpqTest = new User(Alias = 'Rep1', Email='standarduser@proposaltestorg.com',
                    EmailEncodingKey='UTF-8', LastName='standRep1', LanguageLocaleKey='en_US',
                    LocaleSidKey='en_US', ProfileId = testProfile.Id, department = 'STP',
                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@proposaltest.com',
                    UserRoleId = repRole.Id);
            Database.upsert(cpqTest);

            //give read permissions on objects
            //create a new permission set.
            PermissionSet pms = new PermissionSet(Description='repset1',
                    Label='repset1',
                    Name='repset1'
            );
            Database.upsert(pms);

            //assign the permission set to test user.
            PermissionSetAssignment pma = new PermissionSetAssignment(assigneeid=cpqTest.id, permissionsetid=pms.id);
            Database.upsert(pma);

            //give permission to read on rules and related objects for cpqTest via permission set that we created above.
            List<String> objs = new List<String> {
                        'MnQuote__c',
                        'MnQuoteItem__c',
                        'MnQuoteProposalParameter__c',
                        'MnPrintTemplate__c',
                        'Account',
                        'Opportunity',
                        'MnPriceList__c'
            };

            giveObjectsFullAccess(objs, pms.Id);

            List<String> qFields = new List<String> {
                'One_Time_Total_Value_S__c',
                'Weekly_Total_Value_S__c',
                'Monthly_Total_Value_S__c',
                'Yearly_Total_Value_S__c'
            };

            giveFieldsReadAccess('MnQuote__c', qFields, pms.Id);

        }
        //Quote_N010_US15815_001 FLS checks
        //make sure user without appropriate rights cannot see display discount checkbox
        //on proposal page.
        System.runAs(cpqTest) {
            poCtrl = new M2O_CPQ_CMnCustomTemplateCtrl();
            System.assertEquals(poCtrl.quote.Id, qt.Id);
            //we didn't give access to display discount field on proposal parameter for test user
            //so he shouldn't see discount checkbox.
            System.assertEquals(poCtrl.displayquoteDiscount , 'none');
        }
    }
//

//    
    public static REVVY__MnCatalogNode__c createConfig(String configName, Integer numberProductsInConfig,
                                                       String BillFreq)
    {
        REVVY__MnConfigEngineModel__c modelDefinition = createModel('Config Model'+BillFreq);
        modelDefinition.REVVY__Status__c = 'Active';
        Database.upsert(modelDefinition);
        REVVY__MnCatalogNode__c confProd = new REVVY__MnCatalogNode__c(Name = configName,
                                                    REVVY__Id__c = configName,
                                                    REVVY__status__c = 'Active',
                                                    REVVY__type__c = 'Product',
                                                    REVVY__Configurable__c=true,
                                                    REVVY__model__c=modelDefinition.Id,
                                                    REVVY__Billing_Frequency__c=BillFreq);
        Database.upsert(confProd);

        List<REVVY__MnCatalogNodeEdge__c> edgeList = new List<REVVY__MnCatalogNodeEdge__c>();
        List<REVVY__MnCatalogNode__c> prodList = new List<REVVY__MnCatalogNode__c>();


        for (Integer i = 0; i < numberProductsInConfig; i++) {
            REVVY__MnCatalogNode__c prod = new REVVY__MnCatalogNode__c(Name = configName +'__'+i,
                                                            REVVY__Id__c = configName +'__'+i,
                                                            REVVY__status__c = 'Active',
                                                            REVVY__type__c = 'Product',
                                                            REVVY__Billing_Frequency__c='Weekly');

            prodList.add(prod);
        }
        Database.upsert(prodList);
        String prodMatch = configName + '__%';
        prodList = [SELECT Id FROM REVVY__MnCatalogNode__c WHERE Name LIKE :prodMatch];

          for (Integer i = 0 ; i < prodList.size() ; i++) {
              REVVY__MnCatalogNodeEdge__c edge = new REVVY__MnCatalogNodeEdge__c();
              edge.REVVY__Quantity__c = 1;
              edge.REVVY__Parent__c = confProd.Id;
              edge.REVVY__Child__c = prodList[i].Id;
              edge.REVVY__Relative_Level__c = 1;
              edgeList.add(edge);
          }

          Database.upsert(edgeList);
          return confProd;
    }
    
    public static REVVY__MnCatalogNode__c createServices(String configName,String BillFreq) {
        REVVY__MnCatalogNode__c confProd = new REVVY__MnCatalogNode__c(Name = configName,
                                                    REVVY__Id__c = configName,
                                                    REVVY__status__c = 'Active',
                                                    REVVY__type__c = 'Product',
                                                    REVVY__Configurable__c=false,
                                                    REVVY__Billing_Frequency__c=BillFreq);
        Database.upsert(confProd);

        List<REVVY__MnCatalogNodeEdge__c> edgeList = new List<REVVY__MnCatalogNodeEdge__c>();
        List<REVVY__MnCatalogNode__c> prodList = new List<REVVY__MnCatalogNode__c>();


        for (Integer i = 0; i < 3; i++) {
            REVVY__MnCatalogNode__c prod = new REVVY__MnCatalogNode__c(Name = configName +'__'+i,
                                                            REVVY__Id__c = configName +'__'+i,
                                                            REVVY__status__c = 'Active',
                                                            REVVY__type__c = 'Product',
                                                            REVVY__Billing_Frequency__c=BillFreq);

            prodList.add(prod);
        }
        Database.upsert(prodList);
        String prodMatch = configName + '__%';
        prodList = [SELECT Id FROM REVVY__MnCatalogNode__c WHERE Name LIKE :prodMatch];

          for (Integer i = 0 ; i < prodList.size() ; i++) {
              REVVY__MnCatalogNodeEdge__c edge = new REVVY__MnCatalogNodeEdge__c();
              edge.REVVY__Quantity__c = 1;
              edge.REVVY__Parent__c = confProd.Id;
              edge.REVVY__Child__c = prodList[i].Id;
              edge.REVVY__Relative_Level__c = 1;
              edgeList.add(edge);
          }

          Database.upsert(edgeList);
          return confProd;
    }
    
    static testMethod void testProposalTemplatePageWithConfig() {
        Account acct = createAccount();
        Opportunity opp = createOpportunity(acct);
        REVVY__MnPriceList__c pl = createPriceList();
        
        //Bundle with 5 products
        REVVY__MnCatalogNode__c oneTimeConfig = createConfig('Config Prod1',5,'One Time');
        REVVY__MnCatalogNode__c weeklyConfig = createConfig('Config Prod2',5,'Weekly');
        REVVY__MnCatalogNode__c monthlyConfig = createConfig('Config Prod3',5,'Monthly');
        REVVY__MnCatalogNode__c yearlyConfig = createConfig('Config Prod4',5,'Yearly');
        
        REVVY__MnQuote__c quote = createQuote(acct, opp);
        REVVY__MnQuoteItem__c oneTimeQuoteItem = getNewQuoteItem(oneTimeConfig.Id, 1, quote.Id);
        REVVY__MnQuoteItem__c monthlyQuoteItem = getNewQuoteItem(monthlyConfig.Id, 1, quote.Id);
        //ID quoteItemId = quoteItem.Id;
        
        //create 5 sublines for quote item 1 for 5 products above.
        REVVY__MnQuoteItemSubline__c qis1 = createQuoteItemSublineNoSave(oneTimeConfig , oneTimeQuoteItem, 'One Time');
        REVVY__MnQuoteItemSubline__c qis2 = createQuoteItemSublineNoSave(oneTimeConfig , oneTimeQuoteItem, 'One Time');
        
        REVVY__MnQuoteItemSubline__c qis3 = createQuoteItemSublineNoSave(monthlyConfig, monthlyQuoteItem, 'Monthly');
        REVVY__MnQuoteItemSubline__c qis4 = createQuoteItemSublineNoSave(weeklyConfig, oneTimeQuoteItem, 'Weekly');
        REVVY__MnQuoteItemSubline__c qis5 = createQuoteItemSublineNoSave(yearlyConfig, oneTimeQuoteItem, 'Yearly');
        REVVY__MnQuoteItemSubline__c qis6 = createQuoteItemSublineNoSave(monthlyConfig, monthlyQuoteItem, 'Monthly');
        
        //set list price for all sublines.
        qis1.REVVY__price__c = 10;
        qis2.REVVY__price__c = 20;
        qis3.REVVY__price__c = 30;
        qis4.REVVY__price__c = 40;
        qis5.REVVY__price__c = 50;
        qis6.REVVY__price__c = 60;
        
        //Update the section number
        qis1.REVVY__SectionNumber__c = 1;
        qis2.REVVY__SectionNumber__c = 2;
        qis3.REVVY__SectionNumber__c = 3;
        qis4.REVVY__SectionNumber__c = 4;
        qis5.REVVY__SectionNumber__c = 5;
        qis6.REVVY__SectionNumber__c = 3;
        
        //change quantities for some sublines.
        qis1.REVVY__quantity__c = 2;
        qis2.REVVY__quantity__c = 4;
        
        //give discounts for some sublines.
        qis1.REVVY__discount_type__c = 'Absolute'; 
        qis1.REVVY__discount_absolute__c = 2;
        qis2.REVVY__discount__c = 50;
        
        List<REVVY__MnQuoteItemSubline__c> sublines = new List<REVVY__MnQuoteItemSubline__c>();
        sublines.add(qis1);sublines.add(qis2);sublines.add(qis3);sublines.add(qis4);sublines.add(qis5); sublines.add(qis6);
        Database.upsert(sublines);
        
        PageReference pageref = Page.M2O_CPQ_PMnCustomTemplate;
        pageRef.getParameters().putAll(new Map<String,String>{
            'quoteId'=>quote.Id
        });
        Test.setCurrentPage(pageRef);


        // Create some test data
        REVVY__MnPrintTemplate__c pt = new REVVY__MnPrintTemplate__c(
                            REVVY__VisualforcePageName__c='M2O_CPQ_PMnCustomTemplate',
                            Name='Default Template',
                            REVVY__TermsOfService__c='Test Terms and Conditions from Test Methods');

        Database.upsert(pt);

        REVVY__MnQuoteProposalParameter__c qp = new REVVY__MnQuoteProposalParameter__c();
        qp.REVVY__usedTemplate__c = pt.Id;
        qp.REVVY__quote__c = quote.Id;
        qp.REVVY__proposalTitle__c = 'ProposalTest';
        qp.REVVY__displayDiscounts__c = false;
        qp.REVVY__displayProductIds__c = false;
        qp.REVVY__displayProductImages__c = false;

        Database.upsert(qp);

        M2O_CPQ_CMnCustomTemplateCtrl poCtrl = new M2O_CPQ_CMnCustomTemplateCtrl();
        System.assertEquals(poCtrl.quote.Id, quote.Id);
    }
    
    static testMethod void testProposalTemplatePageWithBundle() {
        Account acct = createAccount();
        Opportunity opp = createOpportunity(acct);
        REVVY__MnPriceList__c pl = createPriceList();

        //Bundle with 5 products
        REVVY__MnCatalogNode__c bundle = createBundle('Bundle1',5);
        createPriceListLine(bundle, pl);
        
        REVVY__MnQuote__c quote = createQuote(acct, opp);
        REVVY__MnQuoteItem__c quoteItem = getNewQuoteItem(bundle.Id, 1, quote.Id);
        ID quoteItemId = quoteItem.Id;
        
        PageReference pageref = Page.M2O_CPQ_PMnCustomTemplate;
        pageRef.getParameters().putAll(new Map<String,String>{
            'quoteId'=>quote.Id
        });
        Test.setCurrentPage(pageRef);
        
        // Create some test data
        REVVY__MnPrintTemplate__c pt = new REVVY__MnPrintTemplate__c(
                    REVVY__VisualforcePageName__c='M2O_CPQ_PMnCustomTemplate',
                    Name='Default Template',
                    REVVY__TermsOfService__c='Test Terms and Conditions from Test Methods',
                    REVVY__openingComments__c='Test opening comments',
                    REVVY__closingComments__c='Test Closing Comments');

        Database.upsert(pt);

        REVVY__MnQuoteProposalParameter__c qp = new REVVY__MnQuoteProposalParameter__c();
        qp.REVVY__usedTemplate__c = pt.Id;
        qp.REVVY__quote__c = quote.Id;
        qp.REVVY__proposalTitle__c = 'ProposalTest';
        qp.REVVY__displayDiscounts__c = true;
        qp.REVVY__displayProductIds__c = true;
        qp.REVVY__displayProductImages__c = false;

        Database.upsert(qp);

        M2O_CPQ_CMnCustomTemplateCtrl poCtrl = new M2O_CPQ_CMnCustomTemplateCtrl();
        System.assertEquals(poCtrl.quote.Id, quote.Id);

        
    }
    
    static testMethod void testProposalTemplatePageWithService() {
        Account acct = createAccount();
        Opportunity opp = createOpportunity(acct);
        REVVY__MnPriceList__c pl = createPriceList();

        //Services
        REVVY__MnCatalogNode__c weeklyService = createServices('Services1','Weekly');
        REVVY__MnCatalogNode__c monthlyService = createServices('Services2','Monthly');
        REVVY__MnCatalogNode__c yearlyService = createServices('Services3','Yearly');
        
        REVVY__MnQuote__c quote = createQuote(acct, opp);
        REVVY__MnQuoteItem__c weeklyQuoteItem = getNewQuoteItem(weeklyService.Id, 1, quote.Id);
        REVVY__MnQuoteItem__c monthlyQuoteItem = getNewQuoteItem(monthlyService.Id, 1, quote.Id);
        REVVY__MnQuoteItem__c yearlyItem = getNewQuoteItem(yearlyService.Id, 1, quote.Id);
        
        //ID quoteItemId = quoteItem.Id;
        
        PageReference pageref = Page.M2O_CPQ_PMnCustomTemplate;
        pageRef.getParameters().putAll(new Map<String,String>{
            'quoteId'=>quote.Id
        });
        Test.setCurrentPage(pageRef);
        
        // Create some test data
        REVVY__MnPrintTemplate__c pt = new REVVY__MnPrintTemplate__c(
                    REVVY__VisualforcePageName__c='M2O_CPQ_PMnCustomTemplate',
                    Name='Default Template',
                    REVVY__TermsOfService__c='Test Terms and Conditions from Test Methods',
                    REVVY__openingComments__c='Test opening comments',
                    REVVY__closingComments__c='Test Closing Comments');

        Database.upsert(pt);

        REVVY__MnQuoteProposalParameter__c qp = new REVVY__MnQuoteProposalParameter__c();
        qp.REVVY__usedTemplate__c = pt.Id;
        qp.REVVY__quote__c = quote.Id;
        qp.REVVY__proposalTitle__c = 'ProposalTest';
        qp.REVVY__displayDiscounts__c = true;
        qp.REVVY__displayProductIds__c = true;
        qp.REVVY__displayProductImages__c = false;

        Database.upsert(qp);

        M2O_CPQ_CMnCustomTemplateCtrl poCtrl = new M2O_CPQ_CMnCustomTemplateCtrl();
        System.assertEquals(poCtrl.quote.Id, quote.Id);

        
    }
//

static testMethod void testPlaceHolder() {System.assertEquals(1, 1);}

}