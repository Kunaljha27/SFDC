public with sharing class M2O_UpdateNameStreet {
    ID opportunityID {get;set;}
    public Boolean editMode{get;set;}
    private ApexPages.StandardController controller;
    
    public M2O_UpdateNameStreet(ApexPages.StandardController controller) {
        opportunityID = ApexPages.currentPage().getParameters().get('OpportunityID');
        editMode = false;
        this.controller = controller;
        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Please validate the Name and Street fields for this account as they will appear on the Quote documents. The other address components (e.g. City, Postal code, etc) will be picked up from the account.');
    }
    public void toggleMode() {
        editMode = editMode == true?false : true;
    }
    
    public PageReference saveAndReturn() {
        //List<account> a = new List<account>();
        //a.add((Account)Controller.getRecord());
        //    update a;
        pagereference saveReturn = controller.save();
        if(saveReturn != null)
            editMode = false;
        return null;
    }

}