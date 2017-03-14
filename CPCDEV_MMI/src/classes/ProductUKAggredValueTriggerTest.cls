/**
* (c) 2015 TEKsystems Global Services
*
* Name           : ProductUKAggredValueTriggerTest
* Created Date   : 21 May April 2015
* Created By     : Sreenivas M (TEK)
* Purpose        : Test class for ProductUKAggredValueTrigger to populate Product Field
*
**/
@isTest
public class ProductUKAggredValueTriggerTest
{
 static testMethod void testProdUkTrigger() 
 {
  List<Account> listBusAcc = MMIFullquoteTestDataProvider.getBusinessAccountList();
  insert listBusAcc;
  
  List<Product_UK__c> listProd = TestDataUtil_UK.createProductList();
  insert listProd;
  
  List<Product_UK_Agreed_Value__c> listProdAggVal = new List<Product_UK_Agreed_Value__c>();
  
  for(Product_UK__c objProd :listProd)
  {
    for(Account objAcc : listBusAcc)
    {
     listProdAggVal.add(new Product_UK_Agreed_Value__c(Product_Description__c =objProd.Description__c,Account__c = objAcc.id,Agreed_Value__c =10.0,Product_Code__c =objProd.Code__c));
    }
  }
    listProdAggVal.add(new Product_UK_Agreed_Value__c(Account__c = listBusAcc[0].id,Agreed_Value__c =10.0,Product__c = listProd[0].id));
    insert listProdAggVal;
 }
}