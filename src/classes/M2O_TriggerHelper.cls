public class M2O_TriggerHelper{
    private static Boolean CaseFieldUpdates = false;
    public static boolean isCaseFieldUpdatesExecuted(){
        return CaseFieldUpdates;
    }
    public static void CaseFieldUpdatesExecuted(){
        CaseFieldUpdates = True;
    }   
}