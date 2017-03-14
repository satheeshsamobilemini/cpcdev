public class updateAccountBranchCode {

    /*
    
        2010.07.19 - Added code to set "Servicing Branch" [Servicing_Branch_Id__c]  
        
        2011.05.26 - Changed logic to process Account differently depending on Insert/Update
    
    */
    
    /*
    
    Public Static VOID updateBranchCodesOnAccount(List<ID> ownerIds, List<Account> accountsToUpdate, List <String> listPostalCodes, Map <ID, Boolean> mapAcctOwnerChanged){
    
        Map<ID, String> userToBranchCodeMap = New Map<ID, String>();
        Map<Id,String> userToUserRoleMap = new Map<ID,String>();
        
        Map<String,Set<String>> allowServicingUserRoleMap = getAllowServicingIds();
        User[] u = [Select Id, Branch_Id__c,UserRole.Name, UserRoleId from User where ID in :ownerIds];
        
        // Added 2010.07.19
        List <String> listPostalCodestoFindServicingBranch = New List <String>();
        List <Account> listAccountsOwnedByNSC = New List <Account>();
        
        // Build the user map
        for (integer i=0;i<u.size();i++){
    
            // See if we already have this key (User ID)
            Boolean contains = userToBranchCodeMap.containsKey(u[i].Id);
            if (contains == false){
                userToBranchCodeMap.put(u[i].Id, u[i].Branch_Id__c);
                userToUserRoleMap.put(u[i].id,u[i].UserRole.Name);
            }

        }
        
        Map <string, string> postalCodetoBranchId = New map <string, string>();
        
		Branch_Lookup__c[] blookup = [Select Branch_Code__c, Zip__c from Branch_lookup__c where Zip__c in: listPostalCodes];
		
		for (Branch_Lookup__c bLook : blookup){
							
			if (postalCodetoBranchId.containsKey(bLook.Zip__c) == FALSE){
				postalCodetoBranchId.put(bLook.Zip__c, bLook.Branch_Code__c);
			}
		
		}        
		
		String tempServicingBranchID = '';
        
        // Process the accounts
        for (integer i=0;i<accountsToUpdate.size();i++){
            accountsToUpdate[i].branch__c = userToBranchCodeMap.get(accountsToUpdate[i].OwnerId); 

       		tempServicingBranchID = postalCodetoBranchId.get(AssignmentRules.getConvertedZipCode(accountsToUpdate[i].ShippingPostalCode,accountsToUpdate[i].ShippingCountry)); 
            
            system.debug('$$$$$$$$$$$$$ tempServicingBranchID = ' + tempServicingBranchID);
            
            // 2010.07.19
            // Update Servicing_Branch_Id__c
            
            // Is this an insert or update?
            
            if (accountsToUpdate[i].Id == NULL){
            	// insert
            	system.debug('$$$$$$$$$$$$ Account is insert');
            	if ((accountsToUpdate[i].Servicing_Branch_Id__c == NULL) && (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) != '298')){
            		// Account is Branch Owned
            		system.debug('$$$$$$$$$$$$ Account is insert, branch owned');
            		accountsToUpdate[i].Servicing_Branch_Id__c = userToBranchCodeMap.get(accountsToUpdate[i].OwnerId);
            	}
            	else{
					// Account is NSC Owned
					system.debug('$$$$$$$$$$$$ Account is insert, NSC Owned');
	                // Need to look up Servicing_Branch_Id__c by Postal Code
	                if (accountsToUpdate[i].ShippingPostalCode != NULL){
	                    accountsToUpdate[i].Servicing_Branch_Id__c = tempServicingBranchID;
	                }
	                else{
						accountsToUpdate[i].Servicing_Branch_Id__c = postalCodetoBranchId.get(AssignmentRules.getConvertedZipCode(accountsToUpdate[i].BillingPostalCode,accountsToUpdate[i].ShippingCountry));
	                }
            	
            	}
            	
            }
            else{
            	// update
            	system.debug('$$$$$$$$$$$$ Account is update [' + accountsToUpdate[i].Id + ']');
            	// DO NOT process if the owner has not changed
            	if (!mapAcctOwnerChanged.containsKey(accountsToUpdate[i].Id)){

	            	// Is Servicing Branch ID NULL and Branch owned?
	            	// If it is NSC owned, we dont want to force anything unless Shipping Postal code has a value

					//if (accountsToUpdate[i].Servicing_Branch_Id__c == NULL){
					if ((accountsToUpdate[i].Servicing_Branch_Id__c == NULL) && (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) != '298') && (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) != '777')){
            			accountsToUpdate[i].Servicing_Branch_Id__c = userToBranchCodeMap.get(accountsToUpdate[i].OwnerId);            			
            		}

	            	else if ((accountsToUpdate[i].Servicing_Branch_Id__c != NULL) && (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) != '298') && (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) != '777')){
	            		// Account is Branch Owned
	            		system.debug('$$$$$$$$$$$$ Account is update [' + accountsToUpdate[i].Id + '], Branch Owned');
	            		
	            		
	            		// Does the Shipping postal code resolve to a different ?
	            		// Make sure we dont evaluate this on change of owner?
	            		if (tempServicingBranchID != accountsToUpdate[i].Servicing_Branch_Id__c){
	            			System.debug('$$$$$$$$$ tempServicingBranchID = ' + tempServicingBranchID);
	            			System.debug('$$$$$$$$$ accountsToUpdate[i].Servicing_Branch_Id__c = ' + accountsToUpdate[i].Servicing_Branch_Id__c);
	            			// Servicing Branch has changed - do we allow this?
	            			if ( userToUserRoleMap.containsKey(accountsToUpdate[i].OwnerId) && allowServicingUserRoleMap.containsKey(userToUserRoleMap.get(accountsToUpdate[i].OwnerId)) && (allowServicingUserRoleMap.get(userToUserRoleMap.get(accountsToUpdate[i].OwnerId)).contains(tempServicingBranchID)) ) {
	            				accountsToUpdate[i].Servicing_Branch_Id__c = tempServicingBranchID;
	            			}	
	            			
	            			// There is no else since we do not want to change the servicing branch ID
	            			// However, we are allowing the shipping postal code to be updated regardless 
	            			
	            		}
	            	            	
	            	}
	            	else if ( (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) == '298') || (userToBranchCodeMap.get(accountsToUpdate[i].OwnerId) == '777') ){
	            		// Account is NSC Owned
	            		system.debug('$$$$$$$$$$$$ Account is update [' + accountsToUpdate[i].Id + '], NSC Owned');
	            		accountsToUpdate[i].Servicing_Branch_Id__c = tempServicingBranchID;
	            	}
				}
            }
            
            //Done for Case # 00039090 [Set Servicing_Branch_Id__c and Branch__c with the Branch selected(ShadowBranch__c) from the Branch Manager in the VF page while cloning an account record by Branch Manager only as logged in user.]
		        if(accountsToUpdate[i].ShadowBranch__c != null){
		        	accountsToUpdate[i].Branch__c = accountsToUpdate[i].ShadowBranch__c;
		        	accountsToUpdate[i].Servicing_Branch_Id__c = accountsToUpdate[i].ShadowBranch__c;
		        }
        		//End Case # 00039090
                        
        }
    }
    
    
    public static Map<String,Set<String>> getAllowServicingIds(){
        Map<String,Set<String>> tempMap = new Map<String,Set<String>>();
        Set<String> tempSet = new Set<String>();
        tempSet.add('131');
        tempSet.add('175');
        tempMap.put('Sales Rep - 131 - Milwaukee', tempSet);
        tempMap.put('Territory Sales Mgr - 131 - Milwaukee',tempSet);
        tempMap.put('Branch Manager - 131/175 - Milwaukee/Mad',tempSet);
        tempSet = new Set<String>();
        tempSet.add('187');
        tempSet.add('159');
        tempMap.put('Sales Rep - 187 - Newberry',tempSet);
        tempMap.put('Branch Manager - 159/187- Worcester/NB',tempSet);
        tempSet = new Set<String>();
        tempSet.add('147');
        tempSet.add('187');
        tempSet.add('159');
        tempMap.put('Territory Sales Mgr - 147 - Boston', tempSet);
        return tempMap;
   }
   
    static testMethod void myUnitTest() {
    
        String BranchUserID = '';   
        User branchAccountUserID = [Select Id from User where name = 'Branch Account'];
        BranchUserID = branchAccountUserID.Id; 

        String salesRepUserID = '';  
        User salesRepAccountUserID = [Select Id from User where name = 'Paul Widner'];
        salesRepUserID = salesRepAccountUserID.Id;
        //updated on 02/17/2011 (PR-08255)
        List<Account> accounts = new List<Account>();
        Account newAccount = New Account(Name='Test Account', ownerid=salesRepUserID,ShippingPostalCode = 'BT28 1JA', ShippingCountry = 'UK');
        accounts.add(newAccount);
        Account newAccount1 = New Account(Name='Test Account', ownerid=salesRepUserID,BillingPostalCode = 'BT28 1JA', BillingCountry = 'UK');
        accounts.add(newAccount1);
        insert accounts;
        
        newAccount.ownerid = BranchUserID;
        
        update newAccount;

        delete newAccount;
    
    }
    
    static testMethod void testSetServicingId(){
       User newUser = createUser(); 
       List<Account> accounts = new List<Account>();
       Account newAccount = New Account(Name='Test Account', ownerid=newUser.id,ShippingPostalCode = '53725', ShippingCountry = 'USA');
       accounts.add(newAccount);
       insert accounts;
       try{
        accounts = new List<Account>();
        Account newAccount1 = New Account(Name='Test Account 1', ownerid=newUser.id,ShippingPostalCode = '60018', ShippingCountry = 'USA');
        accounts.add(newAccount1);
        insert accounts;
       }catch(Exception ex){
         System.assert(ex.getMessage().contains('You can not change servicing branch id to'));
       }
       
    }
    
    static User createUser(){
        Id profileId;
        Id userRoleId;
        for(Profile p : [select id from Profile where Name ='System Administrator' limit 1]){
            profileId = p.id;
        }
        for(UserRole ur : [select id from UserRole where Name in ('Sales Rep - 131 - Milwaukee','Territory Sales Mgr - 131 - Milwaukee','Branch Manager - 131/175 - Milwaukee/Mad') limit 1]){
            userRoleId = ur.id;
        }
        User user = new User(Available_For_Leads__c=True,alias = 'SubUser'+ date.Today(), email='salesrep' + String.valueOf(date.today()) + '@testorg.com',
                 emailencodingkey='UTF-8', firstname='SubUserTesting' +  date.Today(),lastname='SubUserTesting' + date.Today(),languagelocalekey='en_US',
                 localesidkey='en_US', profileid = profileId, timezonesidkey='America/Los_Angeles', 
                 username='salesrep'+ String.valueOf(date.Today()) + '@testorg.com' ,UserRoleId= userRoleId ,Branch__c ='131');
       insert user;
       return user;
        
    }
*/
}