@isTest(SeeAllData=false)
global class Test_DFG_SettingsController {
    public static testmethod void Test_DFG_SettingsController() 
    {
        Test.startTest();


        DFG_SettingsController con = new DFG_SettingsController();
        con.applyTokenizationSettings();
        con.applyTriggerSettings();
        con.changeObject();
        con.applyObjectSettings();
        con.applyIntegrationSettings();
        con.empty();
        con.showOnlySelectedObj();
        con.showOnlySelectedTrigg();

        con.applyPermissionsSettings();
        con.selectedUserField = 'user';
        con.applyTokenizationSettings();
        con.delPermissionsSettings();
        con.tokenSettings.nameForTransaction__c = 'DFGTransactionId__c';
        con.tokenSettings.isLocalize__c = true;
        con.applyPermissionsSettings();
        con.applyTokenizationSettingsLocalization();
        con.applyTokenizationSettings();
        // 12/10/2016 
        con.permissionsSettings = new DFGPermissions__c(Name='Param', UserField__c='Country', SimpleAccess__c='DFGPermissionsOther', TokenizationAccess__c='DFGPermissionsRus');
        con.tokenSettings = new TokenizationSettings__c(name='Param',SignLocalization__c='Russia');
        // // 12/10/2016 
        con.runAssigningBatch();

        insert new ObjectSettings__c (Name = 'Contact', FieldName__c = 'FirstName',OpenfieldName__c='FirstName', Active__c=true);
        
        List <ObjectSettings__c> os = [Select Name, FieldName__c, OpenfieldName__c from ObjectSettings__c where Name = 'Contact'];
        system.assertequals(os[0].Name,'Contact');
    
        /*insert new TriggerSettingsD__c (Name = 'Contact', Active__c = TRUE);*/
        DFG_SettingsController con2 = new DFG_SettingsController();
        con2.selectedObject = 'Contact';
        con2.selectedObjectTrigger = 'Contact';
        con2.changeObject();
        con2.selFieldNames =  new List<SelectOption> {new SelectOption( 'SecondName', 'SecondName')};
        con2.selOpenedFieldNames = new List<SelectOption> {new SelectOption( 'SecondName', 'SecondName')};
        con2.applyObjectSettings();
        con2.delObjectSettings();
        con2.delTriggerSettings();
        con2.tokenSettings = null;
        con2.setDisplayProperties(con2.tokenSettings);
        con2.tokenSettings = new TokenizationSettings__c(isLocalize__c=true,name='Param');
        con2.setDisplayProperties(con2.tokenSettings);
        con2.selectedUserField = 'user';
        con2.setDisplayProperties(con2.tokenSettings);
        con2.selectedUserField = 'sObject';
        con2.setDisplayProperties(con2.tokenSettings);
        con2.applyPermissionsSettings();



        Test.stopTest();

    }
 
}