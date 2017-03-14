trigger GleniganBidderTrigger on Glenigan_Bidder__c (after insert, after update) {
	if(Trigger.isAfter && Trigger.isInsert)
		GleniganBidderTriggerHandler.afterInsert(Trigger.new);
	else if(Trigger.isAfter && Trigger.isUpdate)
		GleniganBidderTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
}