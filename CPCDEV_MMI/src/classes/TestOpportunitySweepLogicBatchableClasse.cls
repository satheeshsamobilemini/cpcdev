@isTest
public class TestOpportunitySweepLogicBatchableClasse {
    public static testMethod void testContoller() {
        Set<ID> ETSOppRecordTypeSet = new Set<ID>{AssignmentRules.getETSWMIrectypeID('OpportunitySale'),AssignmentRules.getETSWMIrectypeID('OpportunityRental'),AssignmentRules.getETSWMIrectypeID('OpportunityWMI')};
        DateTime dt = DateTime.Now();
            OpportunitySweepLogicBatchableClasse oslb = new OpportunitySweepLogicBatchableClasse(ETSOppRecordTypeSet,dt);
        Database.executeBatch(oslb);

    }
}