/**************************************************************************
Name   : SummaryScorecard
Usage  : Used to display Summary Scorecard of Account currently being viewed.
Author : Kirtesh Jain
Date   : September 17, 2009
****************************************************************************/

public with sharing class SummaryScorecardController {
 /* TFS 2291 start 1
    // To track if there is an exception
    public Boolean hasError {get; private set;}
    //List of Hierarchy nodes
    public List<AccountHierarchyNode> nodesList {get; private set;}
    // Query to get Accounts' details
    private final String QUERY_STRING;
    // padding-right of white space used to indent Hierarchy
    private final Integer SPAN_PADDING;
    
    public SummaryScorecardController(ApexPages.StandardController stdCont) {
        SPAN_PADDING = 25 ;
        
        QUERY_STRING = 'Select Id, Result_Id__c, ParentId, Name, Branch__c, Servicing_Branch_Id__c, Owner.Name, '
                     + 'Total_Revenue_YTD_Current_Year__c, Total_Revenue_Change_YTD__c, Total_Revenue_Last_12_Months__c, '
                    + 'Total_Revenue_Change_Last_12_Months__c ,Total_Units_on_Rent__c, '
                     +' Total_Units_on_Rent_YoY_Change__c, Last_Date_of_Rental_All__c, ORNPU_Num_Units_15_to_30_Days__c '
                     +'From Account where ';
        try {            
        ID rootAccountId = getRootAccountId(stdCont.getId());
        
          
        
        AccountHierarchyNode rootAccountNode = new AccountHierarchyNode(Database.query(QUERY_STRING
                   + 'id = \'' + rootAccountId + '\''));
        createChildrenAccountsNodes(new AccountHierarchyNode[]{rootAccountNode});
        
        // Create list of Hierarchy nodes and add root node
        // and its children with one indent level
        nodesList = new List<AccountHierarchyNode>();
        
        rootAccountNode.spanPadding = 0;
        nodesList.add(rootAccountNode);
        addChildrenNodes(rootAccountNode, 1);
        }catch(Exception ex){
          hasError = true ;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ex.getMessage()));
          
        }
     }                     TFS 2291 end 1 */
     
     /*
     * Adds children nodes of given node to list of Hierarchy nodes
     * @param currentNode: Given node
     * @param indentLevel: Level of indentation
     */                       /* TFS 2291 start 2
    private void addChildrenNodes(AccountHierarchyNode currentNode, Integer indentLevel) {
        // Prepare padding-right of indentation white space according to given indent level
        Integer spanPadding = 0;
        for (Integer level = 0; level < indentLevel; level++)
            spanPadding += SPAN_PADDING;
        
        // If associated Account of given node has not any child Account or
        // if its "Result Id" is not null then set following null fields to zero
        Account currentAccount = currentNode.account;
        if (currentNode.childrenAccountsNodes.size() == 0 || currentAccount.Result_Id__c != null) {
            if(currentAccount.Total_Revenue_YTD_Current_Year__c == null )
                currentAccount.Total_Revenue_YTD_Current_Year__c = 0 ;
            if( currentAccount.Total_Revenue_Change_YTD__c == null)
                currentAccount.Total_Revenue_Change_YTD__c = 0 ;
            if( currentAccount.Total_Revenue_Last_12_Months__c == null) 
                currentAccount.Total_Revenue_Last_12_Months__c = 0 ;
            if( currentAccount.Total_Revenue_Change_Last_12_Months__c == null)
                currentAccount.Total_Revenue_Change_Last_12_Months__c = 0 ;
            if( currentAccount.Total_Units_on_Rent__c == null)      
                currentAccount.Total_Units_on_Rent__c = 0;
            if( currentAccount.Total_Units_on_Rent_YoY_Change__c == null)
                currentAccount.Total_Units_on_Rent_YoY_Change__c = 0 ;
            if(  currentAccount.Last_Date_of_Rental_All__c != null ){
                 Decimal temp =  currentAccount.Last_Date_of_Rental_All__c.DaysBetween(date.today())/30.000 ;
                 currentNode.MonthsinceLastRental = convertDays(temp) ;
            }
            if( currentAccount.ORNPU_Num_Units_15_to_30_Days__c  == null )
                currentAccount.ORNPU_Num_Units_15_to_30_Days__c  = 0 ;
         }
        
        // If associated Account of given node has not any child Account then return
        if (currentNode.childrenAccountsNodes.size() == 0)
            return;
      TFS 2291 end 2 */   
        /* Associated Account of given node has children Accounts */
   /* TFS 2291 start 3    
        // If Account's "Result Id" is null then set following fields to zero
        if (currentAccount.Result_Id__c == null){
            
            currentAccount.Total_Revenue_YTD_Current_Year__c = 
            currentAccount.Total_Revenue_Change_YTD__c =
            currentAccount.Total_Revenue_Last_12_Months__c =
            currentAccount.Total_Revenue_Change_Last_12_Months__c =
            currentAccount.Total_Units_on_Rent__c = 
            currentAccount.Total_Units_on_Rent_YoY_Change__c = 
            currentAccount.ORNPU_Num_Units_15_to_30_Days__c = 0 ;
            
            if( currentAccount.Last_Date_of_Rental_All__c != null){
             Decimal temp =  currentAccount.Last_Date_of_Rental_All__c.DaysBetween(date.today())/30.000 ;
             currentNode.MonthsinceLastRental = convertDays(temp) ;
            }
        }   
        
        Double YTDChange = 0 ;
        Double ChangeLast12months = 0 ;
        Double YOYChange = 0 ;
        
        // Process children nodes of given node
        for (AccountHierarchyNode node : currentNode.childrenAccountsNodes) {
            node.spanPadding = spanPadding;
            nodesList.add(node);
            
            // Add children nodes of current child node with one more indent level
            addChildrenNodes(node, indentLevel + 1);
            
            // If Account's "Result Id" is not null then continue to next child Account
            if (currentAccount.Result_Id__c != null)
                continue;
        TFS 2291 end 3 */    
            /* Else summarize following fields */     /* TFS 2291 start 4
            Account accLocal = node.account;
            currentAccount.Total_Revenue_YTD_Current_Year__c+= accLocal.Total_Revenue_YTD_Current_Year__c ;
            //currentAccount.Total_Revenue_Change_YTD__c+= accLocal.Total_Revenue_Change_YTD__c ;
            currentAccount.Total_Revenue_Last_12_Months__c += accLocal.Total_Revenue_Last_12_Months__c;
            //currentAccount.Total_Revenue_Change_Last_12_Months__c+= accLocal.Total_Revenue_Change_Last_12_Months__c ;
            currentAccount.Total_Units_on_Rent__c += accLocal.Total_Units_on_Rent__c;
            //currentAccount.Total_Units_on_Rent_YoY_Change__c += accLocal.Total_Units_on_Rent_YoY_Change__c;
            currentAccount.ORNPU_Num_Units_15_to_30_Days__c += accLocal.ORNPU_Num_Units_15_to_30_Days__c ;
            
            // % values(Need to be done Avg value)
            YTDChange += accLocal.Total_Revenue_Change_YTD__c;
            ChangeLast12months += accLocal.Total_Revenue_Change_Last_12_Months__c ;
            YOYChange += accLocal.Total_Units_on_Rent_YoY_Change__c ;
        }
        
        if(currentAccount.Result_Id__c != null) 
           return ;
        
        Integer no = currentNode.childrenAccountsNodes.size();
        
        if( no > 0 ){
          currentAccount.Total_Revenue_Change_YTD__c = YTDChange/ no;
          currentAccount.Total_Revenue_Change_Last_12_Months__c = ChangeLast12months/no ;
          currentAccount.Total_Units_on_Rent_YoY_Change__c = YOYChange/no ;
        }
    }                    TFS 2291 end 4 */
    
   /*
     * Used to get root Account id of given account id
     * @param currentAccountId: Given account id
     * @return root Account id
     */                           /* TFS 2291 start 5
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
    }                            TFS 2291 end 5 */
    
     
   /*
    * Creates children Accounts' nodes of given parent account nodes
    * @param parentNodes: Given parent account nodes
    */                             /* TFS 2291 start 6
    private void createChildrenAccountsNodes(List<AccountHierarchyNode> parentNodes) {
        // Set of ids of parent accounts
        Set<ID> parentAccountIds = new Set<ID>();
        // Map from account id to List of children nodes
        Map<ID, List<AccountHierarchyNode>> childrenAccountsNodesMap = new Map<ID, List<AccountHierarchyNode>>();
        
        for (AccountHierarchyNode node : parentNodes) {
            parentAccountIds.add(node.account.id);
            childrenAccountsNodesMap.put(node.account.id, node.childrenAccountsNodes);
        }
        
        // Process children accounts
        for (List<Account> childrenAccounts : Database.query(QUERY_STRING + 'ParentId in '
                + ':parentAccountIds order by Name')) {
            for (Account childrenAccount : childrenAccounts) {
                // Add current account to corresponding List of children nodes
                childrenAccountsNodesMap.get(childrenAccount.ParentId).add(new AccountHierarchyNode(childrenAccount));
            }
        }
        
        // Create lower level of children Accounts' nodes
        for (List<AccountHierarchyNode> childrenAccountsNodes : childrenAccountsNodesMap.values()) {
            // Recursive call only if there are children accounts
            if (childrenAccountsNodes.size() > 0)
                createChildrenAccountsNodes(childrenAccountsNodes);
        }
    }
    
    public static string convertDays( decimal Dated){
      string locstring  = string.valueOf(Dated);
      string firstpart  = locstring.substring( 0 , locstring.indexof('.') );
      string secondpart = locstring.substring( locstring.indexof('.'), ((locstring.length() >= (locstring.indexOf('.') + 2))? (locstring.indexOf('.') + 2) : locstring.length()));
      string totalstring  =  firstpart+secondpart;
      
      if ((totalstring.indexOf('.') + 2) == totalstring.length())
         totalstring += '0';
      
      return totalString ;    
   }                        TFS 2291 end 6 */
  
   /*
    * Private class which represents nodes of Hierarchy
   */               /* TFS 2291 start 7
    private class AccountHierarchyNode {
        // Associated Account record
        public Account account {get; private set;}
        
        //field to Differentiate  LastDate and CurrentDate
        public String MonthsinceLastRental{ get ; private set ;}
        
        // List of children nodes
        public List<AccountHierarchyNode> childrenAccountsNodes {get; private set;}
        // padding-right of indentation white space
        public Integer spanPadding {get; private set;}
    TFS 2291 end 7 */    
        /*
         * Constructor
         * @param account: Associated Account record
         */             /* TFS 2291 start 8
        public AccountHierarchyNode(Account account) {
            this.account = account;
            childrenAccountsNodes = new List<AccountHierarchyNode>();
        }
    }                     TFS 2291 end 8 */
}