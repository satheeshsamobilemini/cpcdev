/********************************************************************
Name   : ManageSalesRepsController
Usage  : Controller class of ManageSalesReps VF page which contains
         content of ManageSalesReps tab.
Author : Aashish Mathur
Date   : September 2, 2009
********************************************************************/

public with sharing class ManageSalesRepsController {
    public Boolean manageAvailability {get; private set;}
    public Boolean manageDaysOff {get; private set;}
    
    public ManageSalesRepsController() {
        manageAvailability = true;
        manageDaysOff = false;
    }
    
    // Switch rendered VF page
    public void switchManage() {
        manageAvailability = !(manageAvailability);
        manageDaysOff = !(manageDaysOff);
    }
}