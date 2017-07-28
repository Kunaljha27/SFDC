/**
@Classname :       MultiselectController
@Description :     MultiselectController synchronizes the values of the hidden elements to the SelectOption lists.
@Author:           Harmeet
@Last Modified:    05/02/2014
**/

public with sharing class MultiselectController {    
    public SelectOption[] leftOptions { get; set; }
    public SelectOption[] rightOptions { get; set; }
    
    private void setOptions(SelectOption[] options, String value) {
        try{
            options.clear();
            String[] parts = value.split('&');
            for (Integer i=0; i<parts.size()/2; i++) {
                options.add(new SelectOption(EncodingUtil.urlDecode(parts[i*2], 'UTF-8'), 
                EncodingUtil.urlDecode(parts[(i*2)+1], 'UTF-8')));
            }
        }
        catch(Exception e){
            system.debug('Exception'+ e.getMessage());
        }
    }
        
    public String leftOptionsHidden { get; set {
           leftOptionsHidden = value;
           setOptions(leftOptions, value);
        }
    }
    
    public String rightOptionsHidden { get; set {
        rightOptionsHidden = value;
            try{
                setOptions(rightOptions, value);
            }
            catch(Exception e){
                system.debug('Exception'+ e.getMessage());
            }
        }
    }
}