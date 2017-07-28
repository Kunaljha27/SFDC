Public Class M2O_UpadationOfQualificationLevelService {
    public void updateQualificationLevel (Set <Id> leadIdSet) {
        if(leadIdSet!=null && !leadIdSet.isEmpty()) {
        list<lead>ldList = new list<lead>();
        list<lead> leadList= [select Id, Budget_Score__c,Time_Score__c,Eloqua_Check__c,Source_System__c,Timing__c,Authority_Score__c,Need_Score__c,Lead_Qualification_Level_Drop_Down__c from lead where Id in :leadIdSet];
            for(Lead ld :leadList) {
                IF(( ld.Budget_Score__c+ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c <=5)&&(ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c >0)) {
                    ld.Lead_Qualification_Level_Drop_Down__c='Cold';
                    
                }
                Else IF((ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c >= 9 &&  ((ld.Budget_Score__c <> 0 && ld.Budget_Score__c <> 1) || (ld.Timing__c=='Urgent') )&& 
                          ((ld.Authority_Score__c <> 0 && ld.Authority_Score__c <> 1) || (ld.Timing__c =='Urgent'))&&((ld.Need_Score__c <> 0 && ld.Need_Score__c <> 1) || (ld.Timing__c =='Urgent'))&& 
                          ((ld.Time_Score__c <> 0 && ld.Time_Score__c <> 1) ||
                          (ld.Timing__c =='Urgent')))) {
                          system.debug('Hot'+ld.Authority_Score__c+'ll'+ld.Need_Score__c+'jjjj'+ld.Budget_Score__c+'kkk'+ld.Timing__c);
                    ld.Lead_Qualification_Level_Drop_Down__c='Hot';
                }
                Else If((ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c > 5 && ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c <9)) {
                    ld.Lead_Qualification_Level_Drop_Down__c='Warm';  
                }
                Else If ((ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c >=9&&(ld.Timing__c !='Urgent')&& (ld.Budget_Score__c == 0||ld.Budget_Score__c == 1||ld.Need_Score__c ==0||ld.Need_Score__c ==1||ld.Time_Score__c == 0||ld.Time_Score__c == 1||ld.Authority_Score__c == 0||ld.Authority_Score__c == 1))) {
                    ld.Lead_Qualification_Level_Drop_Down__c='Warm';    
                }
                Else if( (ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c ) == 0) {
                    ld.Lead_Qualification_Level_Drop_Down__c='Disqualified';
                    system.debug('Disqualified'+ld.Authority_Score__c+'ll'+ld.Need_Score__c+'jjjj'+ld.Budget_Score__c+'kkk'+ld.Timing__c);
                }
                ldList.add(ld);
            }
            update ldList;
        }
    }                               
}