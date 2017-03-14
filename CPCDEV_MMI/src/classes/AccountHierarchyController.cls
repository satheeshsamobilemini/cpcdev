/********************************************************************************************
Name   : AccountHierarchyController
Usage  : Controller class of AccountHierarchy VF page which is used to display Account
         Hierarchy of given account with custom fields/data.
Author : Aashish Mathur
Date   : July 14, 2009
Last Updated By: Ankur Goyal (TEKSystems)
Last Updated Date: 12-Jan-2016
********************************************************************************************/

public with sharing class AccountHierarchyController {
    // List of Hierarchy nodes
    public List<AccountHierarchyNode> nodesList {get; private set;}
    // To track if there is an exception
    public Boolean hasError {get; private set;}
    
    // Query to get Accounts' details
    private final String queryString {get; set;}
    // Content of white space used to indent Hierarchy
    private final String spanString {get; set;}
    public static integer count;
    /*
     * Constructor
     * @param stdCont: Instance of StandardController
     */
    public AccountHierarchyController(ApexPages.StandardController stdCont) {
        hasError = false;
        spanString = '        ';
        count = 0;
        queryString = 'Select Servicing_Branch_Id__c, Id, ParentId, Name, Branch__c, Owner.FirstName, Owner.LastName, '
                + 'Type, Result_Id__c, Phone, BillingCity, BillingState,Last_Activity_Datetime__c,Next_Activity_Date__c,(Select Id, Name From Opportunities where IsClosed=false limit 999) From Account where ';
        //added into query to fetch opportunities by Najma Ateeq for #00035443
        try {
            // Create root node of Hierarchy
            // and its children nodes upto end level
            ID rootAccountId = getRootAccountId(stdCont.getId());
            AccountHierarchyNode rootAccountNode = new AccountHierarchyNode(Database.query(queryString
                   + 'id = \'' + rootAccountId + '\''));
            createChildrenAccountsNodes(new AccountHierarchyNode[]{rootAccountNode});
            
            // Create list of Hierarchy nodes and add root node
            // and its children with one indent level
            nodesList = new List<AccountHierarchyNode>();
            
            rootAccountNode.spanContent = '';
            nodesList.add(rootAccountNode);
            addChildrenNodes(rootAccountNode, 1);
        } catch (Exception ex) {
            // If there is an exception then do not show Hierarchy
            // and display error message to end user
            hasError = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ex.getMessage()));
        }
    } //end of constructor
    
    /*
     * Adds children nodes of given node to list of Hierarchy nodes
     * @param currentNode: Given node
     * @param indentLevel: Level of indentation
     */
    private void addChildrenNodes(AccountHierarchyNode currentNode, Integer indentLevel) {
        // Prepare content of indentation white space
        // according to given indent level
        String spanContent = '';
        for (Integer level = 0; level < indentLevel; level++)
            spanContent += spanString;
        
        // Process children nodes of given node
        
        for (AccountHierarchyNode node : currentNode.childrenAccountsNodes) {
            if(nodesList.size() >= 998){
                break;
            } 
            node.spanContent = spanContent;
            nodesList.add(node);
            
            // Add children nodes of current child node
            // with one more indent level
            addChildrenNodes(node, indentLevel + 1);
        }
    } //end of addChildrenNodes
    
    /*
     * Used to get root Account id of given account id
     * @param currentAccountId: Given account id
     * @return root Account id
     */
    private ID getRootAccountId(ID currentAccountId) {
        // Get parent accounts' ids of current account upto fifth level
        Account currentAccount = [select ParentId, Parent.ParentId, Parent.Parent.ParentId,
                Parent.Parent.Parent.ParentId, Parent.Parent.Parent.Parent.ParentId,
                Parent.Parent.Parent.Parent.Parent.ParentId from Account where id = :currentAccountId];
        
        // Check parent accounts' ids in desending order of level
        ID rootAccountId = currentAccount.Parent.Parent.Parent.Parent.Parent.ParentId;
        if (rootAccountId != null)
            // If fifth level parent account id exists
            // then check if current account has more upper level of parents
            return getRootAccountId(rootAccountId);
        
        rootAccountId = currentAccount.Parent.Parent.Parent.Parent.ParentId;
        if (rootAccountId != null)
            return rootAccountId;
        
        rootAccountId = currentAccount.Parent.Parent.Parent.ParentId;
        if (rootAccountId != null)
            return rootAccountId;
        
        rootAccountId = currentAccount.Parent.Parent.ParentId;
        if (rootAccountId != null)
            return rootAccountId;
        
        rootAccountId = currentAccount.Parent.ParentId;
        if (rootAccountId != null)
            return rootAccountId;
        
        rootAccountId = currentAccount.ParentId;
        if (rootAccountId != null)
            return rootAccountId;
        
        // If there is not any parent account
        // then current account is root Account
        return currentAccountId;
    } //end of getRootAccountId
    
    /*
     * Creates children Accounts' nodes of given parent account nodes
     * @param parentNodes: Given parent account nodes
     */
    private void createChildrenAccountsNodes(List<AccountHierarchyNode> parentNodes) {
        // Set of ids of parent accounts
        Set<ID> parentAccountIds = new Set<ID>();
        // Map from account id to List of children nodes
        Map<ID, List<AccountHierarchyNode>> childrenAccountsNodesMap =
                new Map<ID, List<AccountHierarchyNode>>();
        
        for (AccountHierarchyNode node : parentNodes) {
            parentAccountIds.add(node.account.id);
            childrenAccountsNodesMap.put(node.account.id, node.childrenAccountsNodes);
        }
        
        // Process children accounts
        for (List<Account> childrenAccounts : Database.query(queryString + 'ParentId in '
                + ':parentAccountIds order by Name')) {
            for (Account childrenAccount : childrenAccounts) {
                // Add current account to corresponding List of children nodes
                
                childrenAccountsNodesMap.get(childrenAccount.ParentId).add(
                        new AccountHierarchyNode(childrenAccount));
            }
        }
        
        // Create lower level of children Accounts' nodes
        for (List<AccountHierarchyNode> childrenAccountsNodes : childrenAccountsNodesMap.values()) {
            // Recursive call only if there are children accounts
            if (childrenAccountsNodes.size() > 0)
                createChildrenAccountsNodes(childrenAccountsNodes);
        }
    } //end of createChildrenAccountsNodes
    
    /*
     * Private class which represents nodes of Hierarchy
     */
    private class AccountHierarchyNode {
        // Associated Account record
        public Account account {get; private set;}
        // List of children nodes
        public List<AccountHierarchyNode> childrenAccountsNodes {get; set;}
        // Content of indentation white space
        public String spanContent {get; set;}
        public integer countOpp {get;set;}
        //added by Najma Ateeq for #00035443
        public List<Opportunity> lstOpportunity {get;set;}
        /*
         * Constructor
         * @param account: Associated Account record
         */
        public AccountHierarchyNode(Account account) {
            this.account = account;
            this.countOpp = account.Opportunities.size();
             //added by Najma Ateeq for #00035443
            this.lstOpportunity = account.Opportunities;
            childrenAccountsNodes = new List<AccountHierarchyNode>();
        }
    } //end of AccountHierarchyNode
}