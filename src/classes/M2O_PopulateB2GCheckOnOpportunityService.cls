/**
* @ClassName :M2O_PopulateB2GCheckOnOpportunityService
* @Description : This class is the business class for M2O_PopulateB2GCheckOnOpportunity trigger
* @Author : Vishal Kashyap
* @Last Modified : 14/11/2014
* @Discussionpoints : No Information
*/
public class M2O_PopulateB2GCheckOnOpportunityService{
    
    M2O_PopulateB2GCheckOnOpportunityDAO daoObject = new M2O_PopulateB2GCheckOnOpportunityDAO();
    List<OpportunityTeamMember> listTeamMember = new List<OpportunityTeamMember>();
    Set<ID> setB2GOpportunities = new Set<ID>();
    Set<Opportunity> setnotB2G = new Set<Opportunity>();
    list<Opportunity> listB2G = new list<Opportunity>();
    
     /**
    * @Description : This method fetches and updates the record from opportunity team member using opportunity Id.
    * @param       : set of opportunity ids
    * @return      : void
    **/ 
    public void updateListTeamMember(set<ID> setRelatedOpportunity){
        listTeamMember = daoObject.getListTeamMember(setRelatedOpportunity);
        for(OpportunityTeamMember loopVar : listTeamMember ) {
            if(loopVar.TeamMemberRole != null) {
                if(loopVar.TeamMemberRole.contains('B2G')) {
                    setB2GOpportunities.add(loopVar.OpportunityID);
                }
            }
        }
        setRelatedOpportunity.removeAll(setB2GOpportunities);
        for(ID loopVar : setB2GOpportunities) {
            listB2G.add(new Opportunity(ID = loopVar,B2G_Opportunity__c=true));
        }
        for(ID loopVar : setRelatedOpportunity) {
            setnotB2G.add(new Opportunity(ID = loopVar,B2G_Opportunity__c=false));
        }
        listB2G.addall(setnotB2G);
        daoObject.updateListTeamMember(listB2G);
        }
    
}