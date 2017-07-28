/**
@Classname :       M2O_UpadationOfBANTFieldsService
@Description :     Service class of the trigger M2O_UpadationOfBANTFieldsService
@Author:           Somdev Bhattacharyya
@Last Modified:    29/01/2015
**/

Public Class M2O_UpadationOfBANTFieldsService {
    public void updateBantFields (set<id> leadIdSet) {
    system.debug('555522');
    list<lead>ldList = new list<lead>();
    list<lead> leadList= [select Id,Automated_Budget__c,Eloqua_Check__c,Source_System__c,Automated_Need__c, Automated_Authority__c,Automated_Timing_Months__c,Automated_Lead_Qualification_Level__c,Budget_Score__c,Time_Score__c,Authority_Score__c,Need_Score__c,Lead_Qualification_Level_Drop_Down__c,Timing__c from lead where Id in :leadIdSet];
        for(Lead ld :leadList) {
            if(ld.Source_System__c==M2O_DataUtility.sourceSystem &&ld.Eloqua_Check__c==True) {
            system.debug('@@@Shambhavi debug BANT'+ld.Automated_Budget__c+','+ld.Automated_Authority__c+','+ld.Automated_Need__c+','+ld.Automated_Timing_Months__c);
            system.debug('5555'+ld.Automated_Authority__c+'5555'+ld.Automated_Need__c);
                ld.Authority__c=ld.Automated_Authority__c;
                ld.Budget__c=ld.Automated_Budget__c;
                ld.Need__c=ld.Automated_Need__c;
                ld.Timing__c=ld.Automated_Timing_Months__c;
                system.debug(ld.Authority__c+'hd'+ld.Budget__c+'hd'+ld.Need__c+'hd'+ld.Timing__c);
                IF(( ld.Budget_Score__c+ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c <=5)&&(ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c >0)) {
                    ld.Automated_Lead_Qualification_Level__c='Cold';
                }
                //system.debug('I am inside trigger1'+ld);
                Else IF((ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c >= 9 &&  ((ld.Budget_Score__c <> 0 && ld.Budget_Score__c <> 1) || (ld.Timing__c=='Urgent') )&& 
                      ((ld.Authority_Score__c <> 0 && ld.Authority_Score__c <> 1) || (ld.Timing__c =='Urgent'))&&((ld.Need_Score__c <> 0 && ld.Need_Score__c <> 1) || (ld.Timing__c =='Urgent'))&& 
                      ((ld.Time_Score__c <> 0 && ld.Time_Score__c <> 1) ||
                      (ld.Timing__c =='Urgent')))) {
                    ld.Automated_Lead_Qualification_Level__c='Hot';
                }
                Else If((ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c > 5 && ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c <9)) {
                    ld.Automated_Lead_Qualification_Level__c='Warm';  
                }
                Else If ((ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c >=9&&(ld.Timing__c !='Urgent')&& (ld.Budget_Score__c == 0||ld.Budget_Score__c == 1||ld.Need_Score__c ==0||ld.Need_Score__c ==1||ld.Time_Score__c == 0||ld.Time_Score__c == 1||ld.Authority_Score__c == 0||ld.Authority_Score__c == 1))) {
                    ld.Automated_Lead_Qualification_Level__c='Warm';    
                }
                Else if( (ld.Budget_Score__c + ld.Need_Score__c + ld.Time_Score__c + ld.Authority_Score__c ) == 0 ) {
                    ld.Automated_Lead_Qualification_Level__c='Disqualified';
               }
               ldList.add(ld);
           }
        }system.debug('gggmmm'+leadList);
        update ldList;
    }
}