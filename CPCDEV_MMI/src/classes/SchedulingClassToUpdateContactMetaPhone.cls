global class SchedulingClassToUpdateContactMetaPhone implements Schedulable {
	 global void execute(SchedulableContext SC) {
	 	ScheduleContactUpdateMetaPhoneKey Sch = new ScheduleContactUpdateMetaPhoneKey();
	 	sch.UpdateContactMetaphone();
	 }
}