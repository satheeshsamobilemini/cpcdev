@isTest
public class TestTriggerSwitch{

    private testmethod static void testSwitch(){
    
        /*Trigger_Handler__mdt rec1 = new Trigger_Handler__mdt();
        rec1.Type__c = 'All';
        rec1.Deactivate_Trigger__c = true;
        rec1.Object_s_Trigger_s__c = 'Account';
        insert rec1;
                
        Trigger_Handler__mdt rec2 = new Trigger_Handler__mdt();
        //rec2.Type__c = 'Object';
        rec2.Deactivate_Trigger__c = true;
        rec2.Object_s_Trigger_s__c = 'Account';
        insert rec2;
                
        Trigger_Handler__mdt rec3 = new Trigger_Handler__mdt();
        //rec3.Type__c = 'Trigger';
        rec3.Deactivate_Trigger__c = true;
        rec3.Object_s_Trigger_s__c = 'AccountTrigger';
        insert rec3;*/
           
        Boolean allFlag = TriggerSwitch.isTriggerExecutionFlagDisabled('Dodge_Project__c','Dodge_Project__c');
    
    }

}