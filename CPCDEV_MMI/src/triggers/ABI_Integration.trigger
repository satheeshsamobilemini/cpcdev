trigger ABI_Integration on ABI__c (after insert) {
	System.debug('_________________ ABI_Integration - Trigger.new.size() _________________________' + Trigger.new.size());
	ABI_IntegrationUtil.loadABIProjects(Trigger.new);
}