/*************************************************************************
Name   : TestAccountHierarchyController
Usage  : Unit tests for testing AccountHierarchyController apex class.
Author : Aashish Mathur
Date   : July 14, 2009
*************************************************************************/

@isTest
private with sharing class TestAccountHierarchyController {
    @isTest
    static void testAccountHierarchyController() {
        // Test data preparation start
        
        // Insert root account
        Account rootAccount = new Account();
        rootAccount.Name = 'rootAccount';
        insert rootAccount;
        
        // Insert root account's children
        Account childAccount1 = new Account();
        childAccount1.Name = 'childAccount1';
        childAccount1.ParentId = rootAccount.id;
        insert childAccount1;
        
        Account childAccount2 = new Account();
        childAccount2.Name = 'childAccount2';
        childAccount2.ParentId = rootAccount.id;
        insert childAccount2;
        
        // Insert children of more lower level
        Account childAccount11 = new Account();
        childAccount11.Name = 'childAccount11';
        childAccount11.ParentId = childAccount1.id;
        insert childAccount11;
        
        Account childAccount111 = new Account();
        childAccount111.Name = 'childAccount111';
        childAccount111.ParentId = childAccount11.id;
        insert childAccount111;
        
        Account childAccount1111 = new Account();
        childAccount1111.Name = 'childAccount1111';
        childAccount1111.ParentId = childAccount111.id;
        insert childAccount1111;
        
        Account childAccount11111 = new Account();
        childAccount11111.Name = 'childAccount11111';
        childAccount11111.ParentId = childAccount1111.id;
        insert childAccount11111;
        
        Account childAccount111111 = new Account();
        childAccount111111.Name = 'childAccount111111';
        childAccount111111.ParentId = childAccount11111.id;
        insert childAccount111111;
        
        // Test data preparation complete
        
        // Testing starts
        Test.startTest();
        
        AccountHierarchyController controller =
                new AccountHierarchyController(new ApexPages.StandardController(childAccount111111));
        
        // Create more instances for code coverage
        controller = new AccountHierarchyController(new ApexPages.StandardController(childAccount11111));
        controller = new AccountHierarchyController(new ApexPages.StandardController(childAccount1111));
        controller = new AccountHierarchyController(new ApexPages.StandardController(childAccount111));
        controller = new AccountHierarchyController(new ApexPages.StandardController(childAccount11));
        controller = new AccountHierarchyController(new ApexPages.StandardController(childAccount1));
        controller = new AccountHierarchyController(new ApexPages.StandardController(rootAccount));
        
        // Testing completes
        Test.stopTest();
        
        // Assert post conditions
        
        // All 8 accounts should present in list of Hierarchy nodes
        System.assertEquals(controller.nodesList.size(), 8);
        
        // Nodes should be in specific order
        System.assertEquals(controller.nodesList[0].account.id, rootAccount.id);
        System.assertEquals(controller.nodesList[1].account.id, childAccount1.id);
        System.assertEquals(controller.nodesList[2].account.id, childAccount11.id);
        System.assertEquals(controller.nodesList[3].account.id, childAccount111.id);
        System.assertEquals(controller.nodesList[4].account.id, childAccount1111.id);
        System.assertEquals(controller.nodesList[5].account.id, childAccount11111.id);
        System.assertEquals(controller.nodesList[6].account.id, childAccount111111.id);
        System.assertEquals(controller.nodesList[7].account.id, childAccount2.id);
        
        // All nodes should have correct indent level
        String spanString = '        ';
        
        System.assertEquals(controller.nodesList[0].spanContent, '');
        System.assertEquals(controller.nodesList[1].spanContent, spanString);
        System.assertEquals(controller.nodesList[2].spanContent, spanString + spanString);
        System.assertEquals(controller.nodesList[3].spanContent, spanString + spanString + spanString);
        System.assertEquals(controller.nodesList[4].spanContent,
                spanString + spanString + spanString + spanString);
        System.assertEquals(controller.nodesList[5].spanContent,
                spanString + spanString + spanString + spanString + spanString);
        System.assertEquals(controller.nodesList[6].spanContent,
                spanString + spanString + spanString + spanString + spanString + spanString);
        System.assertEquals(controller.nodesList[7].spanContent, spanString);
        
        // Assert children nodes of every node
        
        System.assertEquals(controller.nodesList[0].childrenAccountsNodes.size(), 2);
        System.assertEquals(controller.nodesList[0].childrenAccountsNodes[0].account.id, childAccount1.id);
        System.assertEquals(controller.nodesList[0].childrenAccountsNodes[1].account.id, childAccount2.id);
        
        System.assertEquals(controller.nodesList[1].childrenAccountsNodes.size(), 1);
        System.assertEquals(controller.nodesList[1].childrenAccountsNodes[0].account.id, childAccount11.id);
        
        System.assertEquals(controller.nodesList[2].childrenAccountsNodes.size(), 1);
        System.assertEquals(controller.nodesList[2].childrenAccountsNodes[0].account.id, childAccount111.id);
        
        System.assertEquals(controller.nodesList[3].childrenAccountsNodes.size(), 1);
        System.assertEquals(controller.nodesList[3].childrenAccountsNodes[0].account.id,
                childAccount1111.id);
        
        System.assertEquals(controller.nodesList[4].childrenAccountsNodes.size(), 1);
        System.assertEquals(controller.nodesList[4].childrenAccountsNodes[0].account.id,
                childAccount11111.id);
        
        System.assertEquals(controller.nodesList[5].childrenAccountsNodes.size(), 1);
        System.assertEquals(controller.nodesList[5].childrenAccountsNodes[0].account.id,
                childAccount111111.id);
        
        System.assertEquals(controller.nodesList[6].childrenAccountsNodes.size(), 0);
        System.assertEquals(controller.nodesList[7].childrenAccountsNodes.size(), 0);
    }
}