/**
 * @Author :Vivek
 * @Date: 29-Sep-2015
 * @Description: This is test class for ConvertLeadForCPQ. 
 */

@isTest
public class TestConvertLeadForCPQ{

@testSetup static void setup() {
        CPQActiveURL__c CPQActiveURLVar=new CPQActiveURL__c();
        CPQActiveURLVar.Name='DevURL';
        CPQActiveURLVar.CPQ_URL__c='http://cpq-devapp/CPQ';
        CPQActiveURLVar.Environment__c = URL.getSalesforceBaseUrl().getHost(); 
        CPQActiveURLVar.Portal_URL__c = 'http://cpq-devweb.mobilemini.com/CPQ';
        insert CPQActiveURLVar; 
    }
static testMethod void ConvertLeadMethod1() {

    List<User> u = createUsers(1);
    Lead ld = new Lead();
    ld.FirstName = 'TestLead';
    ld.LastName = 'TestLead';
    ld.company = 'TestCompany';
    ld.Delivery_Postal_Code__c = '345252';
    ld.Industry = '4-Institutional';
    ld.Phone = '546456';
    ld.LeadSource = 'Email';
    ld.Country = 'tstcntry';    
    insert ld;
 
   Test.startTest();
    String St =  ConvertLeadForCPQ.convertlead(ld.id, 'TestLead', '', '345252','TestLead',u[0].Id,'city','st','cntry','strt','123456','bcty','bst','bcntry','bstrt');
   Test.stopTest();
  
} 

static testMethod void ConvertLeadMethod2() {
      
    List<User> u = createUsers(1);
    Lead ld2 = new Lead();
    ld2.FirstName = 'TestLead 1';
    ld2.LastName = 'TestLead 2';
    ld2.company = 'TestCompany 2';
    ld2.Delivery_Postal_Code__c = '341252';
    ld2.Industry = '4-Institutional';
    ld2.Phone = '541456';
    ld2.LeadSource = 'Email';
    ld2.Country = 'tstCountry'; 
    insert ld2;
    Test.startTest();
        String St1 =  ConvertLeadForCPQ.convertlead(ld2.id, 'TestLead', 'testCompany', '345252','TestLead',u[0].Id,'city','st','cntry','strt','123456','bcty','bst','bcntry','bstrt');
    Test.stopTest();
}

    
   public static List<User> createUsers(integer size){
    List<User> users = new List<User>();
    Id profileId;
    List<Profile> profiles = [select id from profile where name = 'Customer Sales Specialist - NSC - US' limit 1];
    if(profiles.size() > 0){
        profileId= profiles.get(0).id;
    }else{
        Profile p2 = [select id from profile where name='System Administrator'];
        profileId = p2.id;
    }
    
    for(Integer i=0;i < size ;i++){
        User user = new User(Available_For_Leads__c=True,alias = 'SubUser', email='salesrep@testorg.com',
             emailencodingkey='UTF-8', firstname='SubUserTesting' + DateTime.now()+'--'+i,lastname='SubUserTesting' +DateTime.now()+'-'+i,languagelocalekey='en_US',
             localesidkey='en_US', profileid = profileId, timezonesidkey='America/Los_Angeles', 
             username='salesrep@testorg.com'+i ,Branch__c ='101',Street='testStreet',city='testcity',state='teststate',PostalCode='123456',phone='1290000');
        users.add(user);
    }
    insert users;
    return users;
    }
}