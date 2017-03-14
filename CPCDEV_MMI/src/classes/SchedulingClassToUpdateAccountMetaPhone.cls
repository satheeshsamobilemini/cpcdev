global class SchedulingClassToUpdateAccountMetaPhone implements Schedulable {
	 global void execute(SchedulableContext SC) {
	 	ScheduleAccountUpdateMetaPhoneKey Sch = new ScheduleAccountUpdateMetaPhoneKey();
	 	sch.UpdateAccountMetaphone();
	 } 
	 
}