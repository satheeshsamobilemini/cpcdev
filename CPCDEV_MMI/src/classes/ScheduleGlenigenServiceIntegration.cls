global class ScheduleGlenigenServiceIntegration implements Schedulable{
    final static String NEWPROJ = 'NewProject';
    final static String UPDATEPROJ = 'UpdateProject';
    final static String NEWBIDDER = 'NewBidder';
    final static String UPDATELASTLOGIN = 'UpdateLastLoginDate';
    
    String currentProc; 
    public ScheduleGlenigenServiceIntegration(String currentProcess){
        currentProc = currentProcess == null? NEWPROJ : currentProcess;
    } 
    
    public ScheduleGlenigenServiceIntegration(){
       currentProc = NEWPROJ;
    } 
    
    
    global void execute(SchedulableContext sc){ 
        if(currentProc == NEWPROJ){ 
            GlenigenServiceIntegrationUtility.migrateNewProjects();
            scheduleMe(UPDATEPROJ);
         }
        else if(currentProc == UPDATEPROJ){
            GlenigenServiceIntegrationUtility.migrateExistingProjects();
            scheduleMe(NEWBIDDER);       
        }
        else if(currentProc == NEWBIDDER) {
            GlenigenServiceIntegrationUtility.migrateBidders();
            scheduleMe(UPDATELASTLOGIN);
        }
        else if(currentProc == UPDATELASTLOGIN ) {
            GlenigenServiceIntegrationUtility.UpdateLastLogin();
        }
    } 
    
    
    public static void scheduleMe(String currentProcess){
        ScheduleGlenigenServiceIntegration scheduler = new ScheduleGlenigenServiceIntegration(currentProcess);
        DateTime currentTime = system.now().addMinutes(Integer.valueOf(Label.Glenigan_Schedule_Job_Difference));
        String sch = String.valueOf(currentTime.second() ) + ' ' + String.valueOf(currentTime.minute() ) + ' ' + String.valueOf( currentTime.hour() ) + ' ' + String.valueOf( currentTime.day() ) + ' ' + String.valueOf( currentTime.month() ) + ' ' + '? ' + String.valueOf( currentTime.year() );
        system.schedule('ScheduleGlenigenServiceIntegration' + currentTime + currentProcess,sch,scheduler );
    }   
}