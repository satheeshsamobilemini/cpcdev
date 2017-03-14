/**
* (c) 2015 TEKsystems Global Services
*
* Name           : ProductUKAggredValueTrigger
* Created Date   : 10 April 2015
* Created By     : Sreenivas M
* Purpose        : Trigger to populate Product Field in ProductUKAggredValue object
*
**/
trigger ProductUKAggredValueTrigger on Product_UK_Agreed_Value__c (before insert,before update)
{
  ProductUKAggredValueTriggerHandler.populateProdcut(Trigger.new);   
}