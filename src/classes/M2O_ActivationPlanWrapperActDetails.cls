public class M2O_ActivationPlanWrapperActDetails {
    public Date activityStartDate{set; get;}
    public Date activityEndDate{set; get;}
    public string activityStatus{set; get;}
    public string activityDetail{set; get;}
    public string activityType{set; get;}
    public string activityCategory{set; get;}
    public Id activityId{set; get;}
    public M2O_ActivationPlanWrapperActDetails(string Detail, Date startDate, Date endDate, string status,string actType, string actCategory, ID Id) {
        activityDetail=String.escapeSingleQuotes(Detail);
        activityStartDate=startDate;
        activityEndDate=endDate;
        activityStatus=status;
        activityType=actType;
        activityCategory=actCategory;
        activityId=Id;
    }
}