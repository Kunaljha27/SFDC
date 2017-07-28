@isTest
public without sharing class M2O_ApprovalForCommitmentTest{
 /**   public static testMethod void test_CEE(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Account parentAccount = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount.Market__c='Central& East Europe';
        insert parentAccount;
        Commercial_Policy__c cp = new Commercial_Policy__c();
        cp.account__c = parentAccount.id;
        insert cp;
        StaticVariableClass.firstRun = TRUE;  
        Commitment__c comRec = new Commitment__c();
        comRec.Activity_Amount__c=5001;
        comRec.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec.Activity_Short_Description__c ='Training Staff';
        comRec.Category__c='0353 Air';
        comRec.Commercial_Policy__c=cp.id;
        comRec.Commitment_Status__c='Draft';
        comRec.Commitment_Type__c='Trade Investment';
        comRec.Investment_Type__c='Upselling investment';
        comRec.Approve__c=True;
        insert comRec;
    }       
    public static testMethod void test_Afr(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Account parentAccount2 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount2.Market__c='Africa';
        insert parentAccount2;
        Commercial_Policy__c cp2 = new Commercial_Policy__c();
        cp2.account__c = parentAccount2.id;
        insert cp2;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec2 = new Commitment__c();
        comRec2.Activity_Amount__c=5001;
        comRec2.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec2.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec2.Activity_Short_Description__c ='Training Staff';
        comRec2.Category__c='0353 Air';
        comRec2.Commercial_Policy__c=cp2.id;
        comRec2.Commitment_Status__c='Draft';
        comRec2.Commitment_Type__c='Trade Investment';
        comRec2.Investment_Type__c='Upselling investment';
        comRec2.Approve__c=True;
        insert comRec2;
    }
    
    public static testMethod void test_Ben(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
        Account parentAccount3 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount3.Market__c='Benelux';
        insert parentAccount3;
        Commercial_Policy__c cp3 = new Commercial_Policy__c();
        cp3.account__c = parentAccount3.id;
        insert cp3;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec3 = new Commitment__c();
        comRec3.Activity_Amount__c=5001;
        comRec3.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec3.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec3.Activity_Short_Description__c ='Training Staff';
        comRec3.Category__c='0353 Air';
        comRec3.Commercial_Policy__c=cp3.id;
        comRec3.Commitment_Status__c='Draft';
        comRec3.Commitment_Type__c='Trade Investment';
        comRec3.Investment_Type__c='Upselling investment';
        comRec3.Approve__c=True;
        insert comRec3;
    }
    
    public static testMethod void test_DACH(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
        Account parentAccount4 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount4.Market__c='DACH';
        insert parentAccount4;
        Commercial_Policy__c cp4 = new Commercial_Policy__c();
        cp4.account__c = parentAccount4.id;
        insert cp4;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec4 = new Commitment__c();
        comRec4.Activity_Amount__c=5001;
        comRec4.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec4.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec4.Activity_Short_Description__c ='Training Staff';
        comRec4.Category__c='0353 Air';
        comRec4.Commercial_Policy__c=cp4.id;
        comRec4.Commitment_Status__c='Draft';
        comRec4.Commitment_Type__c='Trade Investment';
        comRec4.Investment_Type__c='Upselling investment';
        comRec4.Approve__c=True;
        insert comRec4;
    }
    public static testMethod void test_FRANCE(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;       
        Account parentAccount5 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount5.Market__c='France';
        insert parentAccount5;
        Commercial_Policy__c cp5= new Commercial_Policy__c();
        cp5.account__c = parentAccount5.id;
        insert cp5;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec5 = new Commitment__c();
        comRec5.Activity_Amount__c=5001;
        comRec5.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec5.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec5.Activity_Short_Description__c ='Training Staff';
        comRec5.Category__c='0353 Air';
        comRec5.Commercial_Policy__c=cp5.id;
        comRec5.Commitment_Status__c='Draft';
        comRec5.Commitment_Type__c='Trade Investment';
        comRec5.Investment_Type__c='Upselling investment';
        comRec5.Approve__c=True;
        insert comRec5;   
    }
    public static testMethod void test_Iberia(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
            
        Account parentAccount6 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount6.Market__c='Iberia';
        insert parentAccount6;
        Commercial_Policy__c cp6 = new Commercial_Policy__c();
        cp6.account__c = parentAccount6.id;
        insert cp6;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec6 = new Commitment__c();
        comRec6.Activity_Amount__c=5001;
        comRec6.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec6.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec6.Activity_Short_Description__c ='Training Staff';
        comRec6.Category__c='0353 Air';
        comRec6.Commercial_Policy__c=cp6.id;
        comRec6.Commitment_Status__c='Draft';
        comRec6.Commitment_Type__c='Trade Investment';
        comRec6.Investment_Type__c='Upselling investment';
        comRec6.Approve__c=True;
        insert comRec6;
    }
    public static testMethod void test_IIG(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
            
        Account parentAccount7 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount7.Market__c='Italy, Israel&Greece';
        insert parentAccount7;
        Commercial_Policy__c cp7 = new Commercial_Policy__c();
        cp7.account__c = parentAccount7.id;
        insert cp7;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec7 = new Commitment__c();
        comRec7.Activity_Amount__c=5001;
        comRec7.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec7.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec7.Activity_Short_Description__c ='Training Staff';
        comRec7.Category__c='0353 Air';
        comRec7.Commercial_Policy__c=cp7.id;
        comRec7.Commitment_Status__c='Draft';
        comRec7.Commitment_Type__c='Trade Investment';
        comRec7.Investment_Type__c='Upselling investment';
        comRec7.Approve__c=True;
        insert comRec7;
    }
    public static testMethod void test_NOR(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
            
        Account parentAccount8 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount8.Market__c='Nordics';
        insert parentAccount8;
        Commercial_Policy__c cp8 = new Commercial_Policy__c();
        cp8.account__c = parentAccount8.id;
        insert cp8;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec8 = new Commitment__c();
        comRec8.Activity_Amount__c=5001;
        comRec8.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec8.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec8.Activity_Short_Description__c ='Training Staff';
        comRec8.Category__c='0353 Air';
        comRec8.Commercial_Policy__c=cp8.id;
        comRec8.Commitment_Status__c='Draft';
        comRec8.Commitment_Type__c='Trade Investment';
        comRec8.Investment_Type__c='Upselling investment';
        comRec8.Approve__c=True;
        insert comRec8;
}
    public static testMethod void test_RSA(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
            
        Account parentAccount9 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount9.Market__c='RSA';
        insert parentAccount9;
        Commercial_Policy__c cp9 = new Commercial_Policy__c();
        cp9.account__c = parentAccount9.id;
        insert cp9;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec9 = new Commitment__c();
        comRec9.Activity_Amount__c=5001;
        comRec9.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec9.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec9.Activity_Short_Description__c ='Training Staff';
        comRec9.Category__c='0353 Air';
        comRec9.Commercial_Policy__c=cp9.id;
        comRec9.Commitment_Status__c='Draft';
        comRec9.Commitment_Type__c='Trade Investment';
        comRec9.Investment_Type__c='Upselling investment';
        comRec9.Approve__c=True;
        insert comRec9;
    }
    public static testMethod void test_UK(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;      
    
        Account parentAccount10 = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        parentAccount10.Market__c='UK & Ireland';
        insert parentAccount10;
        Commercial_Policy__c cp10 = new Commercial_Policy__c();
        cp10.account__c = parentAccount10.id;
        insert cp10;
        StaticVariableClass.firstRun = TRUE;
        Commitment__c comRec10 = new Commitment__c();
        comRec10.Activity_Amount__c=5001;
        comRec10.Acitivity_start_date__c= date.ValueOf('2014-12-16');
        comRec10.Activity_Completion_Date__c = date.ValueOf('2015-04-06');
        comRec10.Activity_Short_Description__c ='Training Staff';
        comRec10.Category__c='0353 Air';
        comRec10.Commercial_Policy__c=cp10.id;
        comRec10.Commitment_Status__c='Draft';
        comRec10.Commitment_Type__c='Trade Investment';
        comRec10.Investment_Type__c='Upselling investment';
        comRec10.Approve__c=True;
        insert comRec10;
    
    }**/
}