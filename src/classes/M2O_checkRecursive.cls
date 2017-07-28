/**
    @Class Name: M2O_checkRecursive
    @Description : Stops recurssion of lead campaign member update trigger
    @Developer : Somdev Bhattacharyya
**/    
Global Class M2O_checkRecursive{
    private static boolean run = true;
    private static boolean run1=true;
    private static boolean run2=true;
    public static boolean runOnce(){
    if(run){
     run=false;
     return true;
    }else{
        return run;
    }
    }
    public static boolean run1Once(){
    if(run1){
     run1=false;
     return true;
    }else{
        return run;
    }
    }
    public static boolean run2Once(){
    if(run2){
     run2=false;
     return true;
    }else{
        return run;
    }
    }
}