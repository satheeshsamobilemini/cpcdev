public class PostalCodeRateController {
 public String zipCode{get;set;}
 public List<Post_Code_Rate__c> pcrList{get;set;}
 public Boolean dispResult{get;set;}
 public Boolean dispResult2{get;set;}
 public Boolean isSysAdmin{get;set;}
 public List<postCodeRateWrapper> pcrwList{get;set;}
 public set<String> pcrLabelSet = new set<String>();
 
 public PostalCodeRateController(){
  dispResult = false;
  dispResult2 = false;
  isSysAdmin = false;
  
  List<PostCodeRate_UK__c> pcrList = PostCodeRate_UK__c.getAll().values();
   if(pcrList.size() > 0){
     for(PostCodeRate_UK__c p : pcrList)
      pcrLabelSet.add(p.Post_Code_Rate_FieldLabels__c);
   }
              
  String loginUserProfile = [select Profile.Name from User where id =: UserInfo.getUserId()].Profile.Name;
   if(loginUserProfile != null && loginUserProfile != '' && loginUserProfile == 'System Administrator UK')
     { isSysAdmin = true;  }
 }
 
 public void searchZipCode(){
  String nzipCode = '';
  String zipCode1 = '', zipCode2 = '';
  String fLabel='';
  String fDataType ='';
  //List<List<PostCodeRateWrapper>> pcrwListed = new List<List<POstCodeRateWrapper>>();
    
  if(zipCode != null && zipCode != ''){
   String qString = 'select Id,Name,Service_Branch__c,Size_8ft_to_24ft_Units__c,Size_30ft_Units__c,Size_32ft_Units__c,Size_20ft_Welfare_and_Generator__c,';
   qString += 'Size_26ft_Welfare_and_Generator__c,Size_40ft_Units__c,Area__c,Miles__c,Steps_Staircase__c,Additional_Toll__c '; 
   qString += 'from Post_Code_Rate__c ';
   String qFilter = 'where Name like: ';
   
   zipCode = zipCode.toUpperCase(); 
   zipCode = zipCode.replace(' ','');
   
    // form filter for query..
   if(zipCode.length() >= 5){
     nzipCode = zipCode.subString(0,5);
     zipCode1 = nzipCode.subString(0,nzipCode.length()-1);
     zipCode2 = nzipCode.subString(0,nzipCode.length()-2);
     qFilter += 'nzipCode or Name like: zipCode1 or Name like: zipCode2';
   }else if(zipCode.length() == 4){ // zip of 4 characters..
     nzipCode = zipCode;
     zipCode1 = nzipCode.subString(0,nzipCode.length()-1);
     qFilter += 'nzipCode or Name like: zipCode1';
   }else if(zipCode.length() <=3){
     nzipCode = zipCode;
     qFilter += 'nzipCode';
   } 
    
   qFilter += ' LIMIT 1';
    
  pcrList = Database.query(qString + qFilter);  
  pcrwList = new List<postCodeRateWrapper>();
    
    if(pcrList.size() == 1){
       map<String,sObjectField> mapFieldNameApi = Post_Code_Rate__c.getsObjectType().getDescribe().Fields.getMap();
         
         for(String f : mapFieldNameApi.keySet()){
            fLabel = mapFieldNameApi.get(f).getDescribe().getLabel();
             if(pcrLabelSet.contains(fLabel)){
               postCodeRateWrapper pcrw = new PostCodeRateWrapper();
               
               pcrw.pId = pcrList[0].Id;
               pcrw.pFieldLabel = fLabel;
               fDataType = String.valueOf(mapFieldNameApi.get(f).getDescribe().getType());
                
                 if(fDataType == 'STRING')
                    { pcrw.pFieldValue = String.valueOf(pcrList[0].get(f)); }  
                 else if(fDataType == 'DOUBLE')
                    { pcrw.pFieldValue = String.valueOf(Double.valueOf(pcrList[0].get(f))); } 
               pcrwList.add(pcrw);
              }
           }
      }
 }   
    if(!isSysAdmin)
     { dispResult = true; }
    else
     { dispResult2 = true;  }
  }  
  
  public Class postCodeRateWrapper{
   public Id pId{get;set;}
   public String pFieldLabel{get;set;}
   public String pFieldValue{get;set;}
   
  }
  
}