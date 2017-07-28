@isTest
private class Test_MultiselectControllerD {
    
    @isTest static void Test_MultiselectController()  {
        DFGMultiselectController c = new DFGMultiselectController();
        
        c.leftOptions2 = new List<SelectOption>();
        c.rightOptions2 = new List<SelectOption>();

        c.leftOptionsHidden = 'A&a&b&b&C&c';
        c.rightOptionsHidden = '';
        
        System.assertEquals(c.leftOptions2.size(), 3);
        System.assertEquals(c.rightOptions2.size(), 0);
    }
}