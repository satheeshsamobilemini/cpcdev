@isTest
public class BonusPurposeAndTSMControllerTest {
    static testmethod void testCheck1(){
        Account objAcc = new Account();
          objAcc.Name = 'testAccount';
        Insert objAcc;  
        ApexPages.StandardController sc = new ApexPages.StandardController(objAcc);
        BonusPurposeAndTSMController bpts = new BonusPurposeAndTSMController(sc);
        bpts.requestVal = 'ADD';
        bpts.submitForBonusApproval();
        
        bpts.requestVal = 'REMOVE';
        bpts.submitForBonusApproval();
        
        bpts.requestValTSM = 'ADD';
        bpts.submitForTSMApproval();
        
        bpts.requestValTSM = 'REMOVE';
        bpts.submitForTSMApproval();
        
        
        bpts.goBack();
        bpts.getBonusItems();
        bpts.getTSMItems();
        bpts.submitForApproval();
        bpts.getRequestVal();
    }
}