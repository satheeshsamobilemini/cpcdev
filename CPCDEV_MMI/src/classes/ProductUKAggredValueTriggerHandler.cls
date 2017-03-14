/**
* (c) 2015 TEKsystems Global Services
*
* Name           : ProductUKAggredValueTriggerHandler
* Created Date   : 10 April 2015
* Created By     : Sreenivas M
* Purpose        : Handler Class for ProductUKAggredValueTrigger to populate Product Field
*
**/
public class ProductUKAggredValueTriggerHandler
{
   //Sreenivas -Populate the Product Field when record inserted or updated   
   public static void populateProdcut(List<Product_UK_Agreed_Value__c> TriggerNew)
   {   
       List<Product_UK__c> listProdUK = new List<Product_UK__c>();
       Map<String,String> mapCodeDescSizetoCode =new Map<String,String>();
       Map<String,string> mapCodeDescSizetoDesc = new Map<String,String>();
       Map<String,string> mapCodeDescSizetoSize = new Map<String,String>();
       Map<Id,String> mapProdtoCode = new map<Id,String>();
       Map<Id,String> mapProdtoDesc = new map<Id,String>();
       Map<Id,String> mapProdtoSize = new Map<Id,String>();
       Map<String,id> mapCodeDescSizetoProduct =new Map<String,id>();
       Set<Id> setProdIds = new Set<id>();
       
       for(Product_UK_Agreed_Value__c objPAV : TriggerNew)
       {
            if(objPAV.Product__c == null)
            {
             String codeDescriptionSize = objPAV.Product_Code__c+'__'+objPAV.Product_Description__c+'__'+objPAV.Product_Size__c;
             mapCodeDescSizetoCode.put(codeDescriptionSize,objPAV.Product_Code__c);
             mapCodeDescSizetoDesc.put(codeDescriptionSize,objPAV.Product_Description__c);
             mapCodeDescSizetoSize.put(codeDescriptionSize,objPAV.Product_Size__c);
            }
            else
            {
             setProdIds.add(objPAV.Product__c);
            }
       }
       
       listProdUK = [SELECT Id, Name, Code__c,Size__c,Description__c FROM Product_UK__c where ( Id in :setProdIds OR (Code__c In : mapCodeDescSizetoCode.values() AND Description__c In:mapCodeDescSizetoDesc.values() AND Size__c In:mapCodeDescSizetoSize.values()))];
       
       for(Product_UK__c prod : listProdUK)
       {
        mapCodeDescSizetoProduct.put(prod.Code__c+'__'+prod.Description__c+'__'+prod.Size__c,prod.id);
        mapProdtoCode.put(prod.id,prod.Code__c);
        mapProdtoDesc.put(prod.id,prod.Description__c);
        mapProdtoSize.put(prod.id,prod.Size__c);
       }
       
       for(Product_UK_Agreed_Value__c prodAggVal : TriggerNew)
       {
         if(prodAggVal.Product__c == null)
                prodAggVal.Product__c = mapCodeDescSizetoProduct.get(prodAggVal.Product_Code__c+'__'+prodAggVal.Product_Description__c+'__'+prodAggVal.Product_Size__c);
         else
           {
                prodAggVal.Product_Code__c =  mapProdtoCode.get(prodAggVal.Product__c);
                prodAggVal.Product_Description__c = mapProdtoDesc.get(prodAggVal.Product__c);
                prodAggVal.Product_Size__c = mapProdtoSize.get(prodAggVal.Product__c);
           }
       }
    }
}