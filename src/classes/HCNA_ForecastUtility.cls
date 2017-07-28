/**
@Classname :       HCNA_ForecastUtility
@Description :     This class is having utility methods related to forecast page
@Author:           Harmeet
@Last Modified:    05/02/2014
**/

public class HCNA_ForecastUtility{
    
    /**  
    * @Description : Constructor
    **/
    public HCNA_ForecastUtility() {
    }
    /**
    * @Description : This method creates priceBook record.
    * @param       : None
    * @return      : priceBook records.
    **/     
    public static Pricebook2 getPriceBookData() {      
        Pricebook2 priceBookRecord = [Select id from Pricebook2  where IsStandard = true];
        return priceBookRecord;    
    }
    /**  
    * @Description : This method will add comma to the amount after every possible three characters.
    * @param       : String
    * @return      : String 
    **/
     
    public String getComma(String input){
        List<String> splittedInput;
        String amount;
        Boolean hasDecimal = false;
        if(input != null){
            if(input.contains('.')){
                hasDecimal = true;
                splittedInput = input.split('\\.'); 
                amount = splittedInput[0];
            }else{
                amount = input;
            }
            Long total = Long.valueOf(amount);
            String finalAmount;
            if(total < 1000){
                finalAmount = amount;
                if(hasDecimal){
                    return finalAmount + '.' + splittedInput[1];
                }
                return finalAmount;
            }else if(total < 1000000){
                String start3Char = String.valueOf(Math.FLOOR(total/1000));
                List<String> splitArray = new List<String>();
                splitArray = start3Char.split('\\.');
                finalAmount = splitArray[0] + ',' + right(String.valueOf(total), 3);
                if(hasDecimal){
                    return finalAmount + '.' + splittedInput[1];
                }
                return finalAmount;
            }else if(total < 1000000000){
                String start3Char = String.valueOf(Math.FLOOR(total/1000000));
                List<String> splitArray = new List<String>();
                splitArray = start3Char.split('\\.');            
                String start6Char = String.valueOf(Math.FLOOR(total/1000));
                List<String> splitArray2 = new List<String>();
                splitArray2 = start6Char.split('\\.');
                Integer start6Int;
                start6Int = integer.valueof(splitArray2[0]);                
                Integer mid3Int = Math.mod(start6Int,1000);
                String mid3Char;
                if(mid3Int < 1000){
                    mid3Char = String.valueOf(mid3Int);
                    if(mid3Char.length() == 1){
                        mid3Char = '00'+mid3Char;
                    }else if(mid3Char.length() == 2){
                         mid3Char = '0'+mid3Char;
                    }
                }else{
                    mid3Char = String.valueOf(mid3Int);
                }                
                finalAmount = splitArray[0] + ',' + mid3Char + ',' + right(String.valueOf(total),3);                  
                if(hasDecimal){
                    return finalAmount + '.' + splittedInput[1];
                }
                return finalAmount;
            }
            else if(total < 1000000000000L){
                String start6Char = String.valueOf(Math.FLOOR(total/1000000));
                List<String> splitArray = new List<String>();
                splitArray = start6Char.split('\\.');
                Integer start6Int;
                start6Int = integer.valueof(splitArray[0]);
                String start3Char = String.valueOf(Math.FLOOR(start6Int/1000));
                List<String> strAr2 = new List<String>();
                strAr2 = start3Char.split('\\.');
                Integer second3Int;
                second3Int = Math.mod(start6Int,1000);                
                String second3Char;
                if(second3Int < 1000){
                    second3Char = String.valueOf(second3Int);
                    if(second3Char.length() == 1){
                        second3Char  = '00'+second3Char;
                    }else if(second3Char .length() == 2){
                         second3Char  = '0'+second3Char ;
                    }                   
                }else{
                    second3Char = String.valueOf(second3Int);
                }                
                Integer last6Int = Integer.valueOf(Math.mod(total,1000000));
                String tempSecondLast3Char = String.valueOf(Math.FLOOR(last6Int/1000));
                List<String> splitArray2 = new List<String>();
                splitArray2 = tempSecondLast3Char.split('\\.');
                Integer secondLast3Int;
                secondLast3Int = Integer.valueof(splitArray2[0]);
                String secondLast3Char;
                if(secondLast3Int < 1000){
                    secondLast3Char = String.valueOf(secondLast3Int);
                    if(secondLast3Char.length() == 1){
                        secondLast3Char = '00'+secondLast3Char;
                    }else if(secondLast3Char.length() == 2){
                        secondLast3Char = '0'+secondLast3Char ;
                    }                    
                }else{
                    secondLast3Char = String.valueOf(secondLast3Int);
                }  
                finalAmount = strAr2[0] + ',' + second3Char + ',' + secondLast3Char + ',' + right(String.valueOf(total),3);                  
                if(hasDecimal){
                    return finalAmount + '.' + splittedInput[1];
                }
                return finalAmount;
            }
            else if(total < 1000000000000000L){               
                String start9Char = String.valueOf(Math.FLOOR(total/1000000));
                List<String> splitArray = new List<String>();
                splitArray = start9Char.split('\\.');
                Integer start9Int;
                start9Int = Integer.valueof(splitArray[0]);                
                String start6Char = String.valueOf(Math.FLOOR(start9Int/1000));
                List<String> strAr2 = new List<String>();
                strAr2 = start6Char.split('\\.');
                Integer start6Int = Integer.valueOf(strAr2[0]);
                Integer second3Int;
                second3Int = Math.mod(start6Int,1000);
                String second3Char;
                if(second3Int < 1000){
                    second3Char = String.valueOf(second3Int);
                    if(second3Char.length() == 1){
                        second3Char = '00'+second3Char;
                    }else if(second3Char.length() == 2){
                         second3Char = '0'+second3Char;
                    }
                }else{
                    second3Char = String.valueOf(second3Int);
                }                
                Integer third3Int;
                third3Int = Math.mod(start9Int,1000);
                String third3Char;
                if(third3Int < 1000){
                    third3Char = String.valueOf(third3Int);
                    if(third3Char.length() == 1){
                        third3Char = '00'+third3Char;
                    }else if(third3Char.length() == 2){
                        third3Char = '0'+third3Char;
                    }
                }else{
                    third3Char = String.valueOf(third3Int);
                }
                String first3Char = String.valueOf(Math.FLOOR(start6Int/1000));
                List<String> tempList = new List<String>();
                tempList = first3Char.split('\\.');
                Integer first3Int;
                first3Char = String.valueOf(tempList[0]);                                
                Integer last6Int = Integer.valueOf(Math.mod(total,1000000));
                String tempSecondLast3Char = String.valueOf(Math.FLOOR(last6Int/1000));
                List<String> splitArray2 = new List<String>();
                splitArray2 = tempSecondLast3Char.split('\\.');
                Integer secondLast3Int;
                secondLast3Int = Integer.valueof(splitArray2[0]);
                String secondLast3Char;
                if(secondLast3Int < 1000){
                    secondLast3Char = String.valueOf(secondLast3Int);
                    if(secondLast3Char.length() == 1){
                        secondLast3Char = '00'+secondLast3Char;
                    }else if(secondLast3Char.length() == 2){
                         secondLast3Char = '0'+secondLast3Char;
                    }
                }else{
                    secondLast3Char = String.valueOf(secondLast3Int);
                }                
                finalAmount = first3Char + ',' + second3Char + ',' + third3Char + ',' + secondLast3Char + ',' + right(String.valueOf(total),3);                  
                if(hasDecimal){
                    return finalAmount + '.' + splittedInput[1];
                }
                return finalAmount;
            }
            else{       
                return input;
            } 
        }
       else{
           return '0';
       }
    }
    
    /**  
    * @Description : This method will right shift the amount to incorporate a comma.
    * @param       : String, Integer  
    * @return      : String 
    **/
    public String right(String rightString, Integer count) {
        if (rightString == null || rightString == '' || count <=0 ) {
            return '';
        } else if (count >= rightString.length()) {
            return rightString;
        } else {
            return rightString.subString(rightString.length() - count, rightString.length());
        }
    } 
}