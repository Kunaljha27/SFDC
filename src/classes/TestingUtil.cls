public with sharing class TestingUtil {
  public String opId;
  public String scsId;
  public String scsecId;
  public String scsecItemId;
  public String actId;

  public TestingUtil(){
    opId = makeTestableOp();
    scsId = makeSalesCoachStage();
    scsecId = makeSalesCoachSections();
    scsecItemId = makeSecItem();
    actId = makeActivities();
    ApexPages.currentPage().getParameters().put('id', this.opId);
  }
  
  public static Region__c regInsert(){
  Region__c rediondata=new Region__c();
        rediondata.name='Test Region';
        rediondata.Country__c='India';
        rediondata.Region_Code__c='AA-113';
        return rediondata;
    }
  public static Account accInsert(Region__c regio){  
  Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regio.id,Market__c='North America');
  return acc;
  }
  
  private string makeTestableOp(){
  Region__c reg = regInsert();
  insert reg;
  Account acc = accInsert(reg);
  insert acc;
    Opportunity op = new Opportunity();
    op.Name='testOpName';
    op.CloseDate = Date.today();
    op.StageName='testStage';
    op.AccountId = acc.Id;
    insert op;
    return op.Id;
  }
  
  private String makeSalesCoachStage(){
    Sales_Coach_Stage__c scs = new Sales_Coach_Stage__c();
    scs.Name='testStage';
    scs.Buyer_Stage__c='testBuyStage';
    scs.Active__c=true;
    insert scs;
    return scs.Id;
  }
  
  private String makeSalesCoachSections(){
    Sales_Coach_Section__c scsec =  new Sales_Coach_Section__c();
    scsec.Section_Ordering__c =1.0;
    scsec.Section_Name__c='testSection';
    scsec.Sales_Coach_Stage__c=scsId;
    scsec.Section_Width__c=33.0;
    insert scsec;
    return scsec.Id;
  }
  
 private String makeSecItem(){
    Sales_Coach_Section_Item__c secItem = new Sales_Coach_Section_Item__c();
    secItem.Section_Ordering__c=1.0;
    secItem.Sales_Coach_Section__c=scsecId;
    secItem.Link_to_Content__c='http://www.google.com';
    secItem.Item_Name__c='testItem';
    secItem.Display__c=true;
    secItem.Products__c='';
    insert secItem;
    return secItem.Id;
 }
 
 private String makeActivities(){
  Sales_Coach_Activity__c sca = new Sales_Coach_Activity__c();
  sca.Sales_Coach_Stage__c=scsId;
  sca.Ordering_Number__c=1.0;
  sca.Activity_Details__c='testActivity';
  insert sca;
  return sca.Id;
 }

}