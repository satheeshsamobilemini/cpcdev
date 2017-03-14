global class SchedulingClassToUpdateLeadMetaPhoneKey implements Schedulable {
	 global void execute(SchedulableContext SC) {
	 	ScheduleLeadUpdateMetaPhoneKey Sch = new ScheduleLeadUpdateMetaPhoneKey();
	 	sch.UpdateLeadMetaphone();
	 }
	 
	
}