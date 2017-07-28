/**
* @ClassName :M2O_PopulateB2GCheckOnOpportunityDAO
* @Description : This class is the DAO class for M2O_PopulateB2GCheckOnOpportunity trigger
* @Author : Vishal Kashyap
* @Last Modified : 14/11/2014
* @Discussionpoints : No Information
*/
public class M2O_PopulateB2GCheckOnOpportunityDAO{


     /**
    * @Description : This method fetches the record from opportunity team member using opportunity Id.
    * @param       : set of opportunity ids
    * @return      : List if Opportunity team member
    **/ 
    public List<OpportunityTeamMember> getListTeamMember(set<ID> setRelatedOpportunity){
        List<OpportunityTeamMember> listTeamMember = new List<OpportunityTeamMember>();
        try{
            if(setRelatedOpportunity != null && !setRelatedOpportunity.isEmpty()){
                listTeamMember = [SELECT Id,OpportunityId,TeamMemberRole FROM OpportunityTeamMember WHERE OpportunityId IN :setRelatedOpportunity];
            }
        }
        catch(QueryException ex){
            M2O_ErrorHandling.errorHandling(ex);
        }
        return listTeamMember;
    }
    
    /**
    * @Description : This method update the record from opportunity team member.
    * @param       : List<Opportunity>
    * @return      : void
    **/ 
    public void updateListTeamMember(List<Opportunity> listB2G){
        try{
            if(listB2G!= null && !listB2G.isEmpty()){
                Database.Update(listB2G);
            }
        }
        catch(DMLException ex){
            M2O_ErrorHandling.errorHandling(ex);
        }
    }
    
}