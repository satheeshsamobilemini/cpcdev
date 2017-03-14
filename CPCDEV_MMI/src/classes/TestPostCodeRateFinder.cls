/** 
  Test Class for Post Code Rate Finder
**/
@isTest
private class TestPostCodeRateFinder{
  testmethod static void testmethod1(){
         
    Post_Code_Rate__c pcr = new Post_Code_Rate__c(Name = 'TDCU1',Service_Branch__c = 'Tristan',Area__c = 'Tristan',Miles__c = 20);
    pcr.Size_20ft_Welfare_and_Generator__c = 175.00;  pcr.Size_26ft_Welfare_and_Generator__c = 175.00;
    pcr.Size_30ft_Units__c = 175.00; pcr.Size_32ft_Units__c = 185.00;  
    pcr.Size_40ft_Units__c = 195.00; pcr.Size_8ft_to_24ft_Units__c = 175.00;  
    pcr.Steps_Staircase__c = 175.00; pcr.Additional_Toll__c = 0.00;
    insert pcr;
    
    List<String> pcLabels = new List<String>{'Post Code','Service Branch','Area','Miles','20ft Welfare and Generator'};
    pcLabels.add('26ft Welfare and Generator'); pcLabels.add('30ft Units');
    pcLabels.add('32ft Units'); pcLabels.add('40ft Units'); 
    pcLabels.add('8ft to 24ft Units'); pcLabels.add('8ft to 24ft Units');
    pcLabels.add('Steps/Staircase'); pcLabels.add('Additional Toll');
    
    List<PostCodeRate_UK__c> pcUk = new List<PostCodeRate_UK__c>();
    
     for(integer i = 0; i < pcLabels.size(); i++){
       PostCodeRate_UK__c pc = new PostCodeRate_UK__c(Name = 'Post Code UK' + i, Post_Code_Rate_FieldLabels__c = pcLabels[i]);
       pcUk.add(pc);
     }
     insert pcUk;
        
    Test.startTest();
     PostalCodeRateController pc = new PostalCodeRateController();
     pc.zipCode = 'TDCU 1ZZ';
     pc.searchZipCode();
     pc.ZipCode = 'TD CU';
     pc.searchZipCode();
     pc.zipCode = 'T DC';
     pc.searchZipCode();
    Test.stopTest();
  
  }
}