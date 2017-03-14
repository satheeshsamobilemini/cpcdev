/*************************************************************************
Name   : TestManageSalesRepsController
Usage  : Unit tests for testing ManageSalesRepsController apex class.
Author : Aashish Mathur
Date   : September 2, 2009
*************************************************************************/

@isTest
private with sharing class TestManageSalesRepsController {
    @isTest
    static void testManageSalesRepsController() {
        ManageSalesRepsController controller = new ManageSalesRepsController();
        System.assertEquals(controller.manageAvailability, true);
        System.assertEquals(controller.manageDaysOff, false);
        
        controller.switchManage();
        System.assertEquals(controller.manageAvailability, false);
        System.assertEquals(controller.manageDaysOff, true);
    }
}