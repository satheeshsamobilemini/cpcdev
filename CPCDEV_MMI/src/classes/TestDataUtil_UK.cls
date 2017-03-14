/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestDataUtil_UK
* Created Date   : 21 May 2015
* Created By     : Sreenivas M (TEK)
* Purpose        : Utility class for all UK classes
*
**/
@isTest
public class TestDataUtil_UK
{
    public static MMI_Full_Quotes_UK__c createFullQuoteUk()
    {
        
        return new MMI_Full_Quotes_UK__c (name ='test quote',Delivery_County__c='kindom',Delivery_Phone__c='6437374674',Delivery_Mobile__c='6464554674',Billing_Mobile__c ='1644364672',No_of_units__c=2,Billing_Phone__c ='6473343232',Del_Time__c ='First Drop',Required_Date__c = System.today(),Quote_Expires__c =system.today()+30);
    }
    
    public static MMI_Full_Quotes_UK__c createFullQuoteUkWithParam(Id Sales_Rep, String Product_Type, String Unit_Size)
    {
        
        return new MMI_Full_Quotes_UK__c (name ='test quote', Sales_Rep__c = Sales_Rep, Product_Type__c = Product_Type, Unit_Size__c = Unit_Size);
    }
    
    public static User createUser(String LastName, String Alias, String Email, String Username, String CommunityNickname, Id ProfileId, Boolean IsActive, String Sales_Rep_Id, String EmailEncodingKey, String LanguageLocaleKey, String TimeZoneSidKey, String LocaleSidKey)
    {
    return new User(LastName = LastName, Alias = Alias, Username = Username, CommunityNickname = CommunityNickname, ProfileId = ProfileId, IsActive = IsActive, Sales_Rep_Id__c = Sales_Rep_Id, Email = Email, EmailEncodingKey = EmailEncodingKey, LanguageLocaleKey = LanguageLocaleKey, TimeZoneSidKey = TimeZoneSidKey, LocaleSidKey = LocaleSidKey);
    }
    
    public static Lead createLead(String LastName, String Email)
    {
    return new Lead(LastName = LastName, Email = Email);
    }
    
    public static Product_UK__c createProduct(String Name, String Rate, String Type, String Size, Boolean isactive,String unitType2){
    return new Product_UK__c(Name = Name, Rate__c = Rate, Type__c = Type, Size__c = Size, IsActive__c = isactive,Unit_Type_2__c=unitType2);
    }
    
    
    public static Product_UK__c createProduct()
    {
         string dummyDesc = '8\''+'x8\'container';
        return new Product_UK__c(Code__c='08CGN',Description__c=dummyDesc,name='08CGN',isActive__c=true,Unit_Type_2__c='Main');
        
    }
    
    public static List<Product_UK__c> createProductList()
    {
       Product_UK__c prod1 = new Product_UK__c(Code__c='08CGN',Description__c='8x8 container',name='08CGN',isActive__c=true,Unit_Type_2__c='Main');
       Product_UK__c prod2 = new Product_UK__c(Code__c='08MNN',Description__c='28x8 container',name='08MNN',isActive__c=true,Unit_Type_2__c='Main');
       return new List<Product_UK__c>{prod1,prod2};
        
    }
    
}