/***Class Name :M2O_UpadationOfBANTServiceTest 
    Description : Test class for M2O_UpadationOfBANTFieldsService
    Written By : Somdev Bhattacharyya
**/ 
@isTest(SeeAllData=false)
public class M2O_UpadationOfBANTServiceTest {
    Public static testMethod void M2O_UpadationOfBANT () {
        List<Lead> leadList = new List<Lead>();
        set<Id> leadIds = new set<Id>();
        leadList=M2O_OpportunityTestDataUtility.getLeadList();
        insert leadList;
        for(Lead l : leadList){
            leadIds.add(l.id);
        }
        M2O_UpadationOfBANTFieldsService service = new M2O_UpadationOfBANTFieldsService();
        service.updateBantFields(leadIds);
    }
}