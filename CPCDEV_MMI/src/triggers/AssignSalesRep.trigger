trigger AssignSalesRep on Lead (before insert, before update) 
{

    /****************************************************************************************************************/
    /*                                                                                                              */
    /* The code from:                                                                                               */
    /*      updateBranchCodeLead.trigger                                                                            */
    /*      LeadUpdateOwnerMgr.trigger                                                                              */
    /*  has been merged with this module to ensure proper order of  trigger execution                               */
    /*                                                                                                              */
    /****************************************************************************************************************/
    
   if(TriggerSwitch.isTriggerExecutionFlagDisabled('Lead','AssignSalesRep')){ 
    return;
   } 

    List<Lead> leadTriggerInsertNew = New List<Lead>();
    List<Lead> leadTriggerUpdateNew = New List<Lead>();
    List<Lead> leadTriggerUpdateOld = New List<Lead>();
    List<Lead> leadTriggerInsertNewABI = new List<Lead>();
    List<Lead> leadTriggerUpdateNewABI = new List<Lead>();
    List<Lead> leadTriggerUpdateOldABI = new List<Lead>();
    
    List<Lead> UKwebLeadList = new List<Lead>();                           // UK Web to Lead  
    List<Lead> OtherLeadlist = new List<Lead>();                          //  UK Web to Lead
    Id ETSrecordtypeID = AssignmentRules.getETSWMIrectypeID('Lead');     // TFS 3981, 4220
    Set<String> ETSprofileSet = AssignmentRules.getETSnWMIprofileNames();   // TFS 3981, 4220
    map<Id,Boolean> mapIdETScreated = new map<Id,Boolean>();              // TFS 3981, 4220
    map<Id,Boolean> mapIdETSowned = new map<Id,Boolean>();                // TFS 3981, 4220   
    List<Lead> AllUKLeadlist = new List<Lead>();     
    List<Lead> serviceBranchUpdateLeads = new List<Lead>();
    Set<String> postalCodes = new Set<String>();
    //Added by Rajib to update Territory and Selling Region.....Starts.........
    set<String> allPostalCodes = new set<String>();
    set<String> allShippingCodes = new set<String>();
    Id GleniganrecordtypeID = AssignmentRules.gleniganRecTypeID();      //TFS 6866
    
    for (Lead ld : Trigger.new){
        String billPostalCode = '';
        if(ld.PostalCode != null && ld.PostalCode != ''){
            billPostalCode = AssignmentRules.getZipCodeConversion(ld.PostalCode,ld.Country);
            if(billPostalCode != null){
                allPostalCodes.add(billPostalCode);
            }
        }
        String delPostalCode = '';
        if(ld.Delivery_Postal_Code__c != null && ld.Delivery_Postal_Code__c != ''){
            delPostalCode = AssignmentRules.getZipCodeConversion(ld.Delivery_Postal_Code__c,ld.Delivery_Country__c);
            if(delPostalCode != null){
                allShippingCodes.add(delPostalCode);
            }
        }
      // TFS 3981, 4220.. leads created and owned by ETS users
     Boolean isCreated = ETSprofileSet.contains(ld.CreatedBy.Profile.Name) ? true : false ;
     Boolean isOwned =  ETSprofileSet.contains(ld.Owner.Profile.Name) ? true : false ;
     mapIdETScreated.put(ld.Id,isCreated);
     mapIdETSowned.put(ld.Id,isOwned); 
    }
    map<String,Branch_Lookup__c> allBranchLookups = AssignmentRules.GetAllBranchLookupData(allPostalCodes);
    map<String,Branch_Lookup__c> allBranchLookupsShipping = AssignmentRules.GetAllBranchLookupData(allShippingCodes);
    map<String,List<Lead>> mapPCCkeyLead = new map<String,List<Lead>>();                        // TFS-2378
        
    for (Lead ld : Trigger.new){
        String zipCode = '';
        if(ld.PostalCode != null && ld.PostalCode != ''){
            zipCode = AssignmentRules.getZipCodeConversion(ld.PostalCode,ld.Country);
        }
        Branch_Lookup__c branchLookupObj = null;
        if(allBranchLookups.containsKey(zipCode)){
            branchLookupObj = allBranchLookups.get(zipCode);
            ld.Territory__c = branchLookupObj.Territory__c;
            ld.Selling_Region__c = branchLookupObj.Selling_Region__c;
            ld.Plant_Code__c = branchLookupObj.Plant_Code__c;
            ld.Rollup_Plant__c = branchLookupObj.Rollup_Plant__c;
        }else{
            ld.Territory__c = '';
            ld.Selling_Region__c = null;
            ld.Plant_Code__c = '';
            ld.Rollup_Plant__c = '';
        }
        String zipCodeShipping = '';
        if(ld.Delivery_Postal_Code__c != null && ld.Delivery_Postal_Code__c != ''){
            zipCodeShipping = AssignmentRules.getZipCodeConversion(ld.Delivery_Postal_Code__c,ld.Delivery_Country__c);
        }
        Branch_Lookup__c branchLookupObjForShipping = null;
        if(zipCodeShipping != '' && allBranchLookupsShipping.containsKey(zipCodeShipping)){
            branchLookupObjForShipping = allBranchLookupsShipping.get(zipCodeShipping);
            ld.Shipping_Territory__c = branchLookupObjForShipping.Territory__c;
            ld.Servicing_Plant_code__c = branchLookupObjForShipping.Plant_Code__c;
            ld.Servicing_Rollup_Plant__c = branchLookupObjForShipping.Rollup_Plant__c; 
        }else{
            ld.Shipping_Territory__c = '';
            ld.Servicing_Plant_code__c = '';
            ld.Servicing_Rollup_Plant__c = '';
        }
     } 
    
    //Added by Rajib to update Territory and Selling Region......Ends................
    
    if (Trigger.isInsert) 
    {
          //Done for Case # 0035523 (populating the OriginalOwner on lead to the valid User before execution of the Assignment Rules)
            // AssignmentRules.populateOriginalOwner(Trigger.new);              UK Web to Lead
        
        // Only pass the Leads we NEED to process
        // AssignmentRules.runAssignmentAlgo(Trigger.new,null);
        //copy code NumericPhoneUpdationOnLead ( on 31-08-2010)
        for (Lead lead : Trigger.new){
         if(lead.RecordTypeId <> ETSrecordtypeID && !mapIdETScreated.get(lead.Id) && !mapIdETSowned.get(lead.Id))     // TFS 3981, 4220
         { lead.NumericPhone__c =  lead.phone != null ? Utils.processNumericPhone(lead.phone): null;
            if (lead.Auto_Assign_Lead__c == True){
                if(lead.isUKwebLead__c)  { lead.PostalCode = lead.Delivery_Postal_Code__c; }     // UK Web to Lead.. 
                leadTriggerInsertNew.add(lead);
                serviceBranchUpdateLeads.add(lead);
                String zipCode = AssignmentRules.getZipCode(lead);
                postalCodes.add(zipCode);
            
            }else if(lead.Delivery_Postal_Code__c != null && lead.Delivery_Postal_Code__c != ''){
                serviceBranchUpdateLeads.add(lead);
                String zipCode = AssignmentRules.getZipCode(lead);
                postalCodes.add(zipCode);
            }else if(lead.PostalCode != null && lead.PostalCode != ''){
                serviceBranchUpdateLeads.add(lead);
                String zipCode1 = AssignmentRules.getZipCode(lead);
                postalCodes.add(zipCode1);
                
            }/*else if (trigger.new[i].leadSource != null && trigger.new[i].leadSource.contains('ABI')){
                leadTriggerInsertNewABI.add(trigger.new[i]);
            }*/
          // TFS 2378..
          if(lead.PPC_Keywords_URL__c != null && lead.PPC_Keywords_URL__c != ''){
              if(!mapPCCkeyLead.containskey(lead.PPC_Keywords_URL__c))
                { mapPCCkeyLead.put(lead.PPC_Keywords_URL__c,new list<Lead>{lead}); }
              else
               { mapPCCkeyLead.get(lead.PPC_Keywords_URL__c).add(lead);}
            }   
         // UK Web to Lead
          if(lead.isUKwebLead__c == true && lead.Auto_Assign_Lead__c == True){                                              
                    UKwebLeadList.add(lead);
                }
            else
                { OtherLeadlist.add(lead); }        
   }
  }  
        System.Debug('-----------------leadTriggerInsertNew-----------'+leadTriggerInsertNew);
             
    }

    else if(Trigger.isUpdate)
    {

        // Only pass the Leads we NEED to process
        //AssignmentRules.runAssignmentAlgo(Trigger.new,Trigger.old);

        for (Lead lead : Trigger.new){
         if(lead.RecordTypeId <> ETSrecordtypeID && !mapIdETScreated.get(lead.Id) && !mapIdETSowned.get(lead.Id))   // TFS 3981, 4220
          { lead.NumericPhone__c =  lead.phone != null ? Utils.processNumericPhone(lead.phone): null;
             if (trigger.oldMap.containsKey(lead.id) && ((lead.Auto_Assign_Lead__c == True && trigger.oldMap.get(lead.id).Auto_Assign_Lead__c == False) || (lead.Govt_Lead__c == True && trigger.oldMap.get(lead.id).Govt_Lead__c == False ))){            
                leadTriggerUpdateNew.add(lead);
                leadTriggerUpdateOld.add(trigger.oldMap.get(lead.id));
                serviceBranchUpdateLeads.add(lead);
                String zipCode = AssignmentRules.getZipCode(lead);
                postalCodes.add(zipCode);
            }else if(lead.Delivery_Postal_Code__c != null){
                if(lead.Delivery_Postal_Code__c != trigger.oldMap.get(lead.id).Delivery_Postal_Code__c){
                    serviceBranchUpdateLeads.add(lead);
                    String zipCode = AssignmentRules.getZipCode(lead);
                    postalCodes.add(zipCode);
                }
            }else if(lead.PostalCode != null && lead.PostalCode != trigger.oldMap.get(lead.id).PostalCode){
                serviceBranchUpdateLeads.add(lead);
                String zipCode1 = AssignmentRules.getZipCode(lead);
                postalCodes.add(zipCode1);
            }
            /*else if(trigger.new[i].leadSource != null && trigger.new[i].leadSource.contains('ABI') && trigger.new[i].Auto_Assign_Lead__c == False && trigger.old[i].Auto_Assign_Lead__c == true){
                leadTriggerUpdateNewABI.add(trigger.new[i]);
                leadTriggerUpdateOldABI.add(trigger.old[i]);
            }*/
           // TFS-2378..
          if(trigger.oldmap.containskey(lead.id) && (trigger.oldmap.get(lead.id).PPC_Keywords_URL__c == null || trigger.oldmap.get(lead.id).PPC_Keywords_URL__c =='') && (trigger.oldmap.get(lead.id).PPC_Keywords_URL__c <> lead.PPC_Keywords_URL__c) && (lead.PPC_Keywords_URL__c <>null || lead.PPC_Keywords_URL__c <>'')){
             if(!mapPCCkeyLead.containskey(lead.PPC_Keywords_URL__c))
                { mapPCCkeyLead.put(lead.PPC_Keywords_URL__c,new list<Lead>{lead}); }
              else
               { mapPCCkeyLead.get(lead.PPC_Keywords_URL__c).add(lead);}
          } 
       }
     }           
    }
    
    // UK Web to Lead
    if(UKwebLeadList.size() > 0){
        AssignmentRules.populateOriginalOwner(UKwebLeadList);
    }
    // UK Web to Lead
    if(OtherLeadlist.size() > 0){
      AssignmentRules.populateOriginalOwner(OtherLeadlist); 
    }
    
    if (leadTriggerInsertNew.size() > 0){
        
        //We dont check for duplicates in case of Dodge/360 Mobile Office/ The Blue Book
        if(leadTriggerInsertNew[0].LeadSource <> 'Dodge' && leadTriggerInsertNew[0].LeadSource <> '360 Mobile Office' && leadTriggerInsertNew[0].LeadSource <> 'The Blue Book' && leadTriggerInsertNew[0].LeadSource <> 'BuyerZone' && leadTriggerInsertNew[0].LeadSource <> 'Barbour ABI' && leadTriggerInsertNew[0].LeadSource <> 'ABI'){
            //Added by Kirtesh Dated on 24 August 2009
            leadTriggerInsertNew  =  AssignmentRules.RemoveDuplicateLeadfromBatch(leadTriggerInsertNew);
        }
        AssignmentRules.runAssignmentAlgo(leadTriggerInsertNew, null);  
        System.Debug('Debug---------------After leadTriggerInsertNew-Owner' + leadTriggerInsertNew[0].Owner);
        
    }
    
   /* if(leadTriggerInsertNewABI.size() > 0){
        leadTriggerInsertNew  =  AssignmentRules.RemoveDuplicateLeadfromBatch(leadTriggerInsertNew);
        AssignmentRules.runAssignmentAlgoForABI(leadTriggerInsertNewABI, null);
    }*/
    if (leadTriggerUpdateNew.size() > 0){
        AssignmentRules.runAssignmentAlgo(leadTriggerUpdateNew, leadTriggerUpdateOld);  
    }
    /*if(leadTriggerUpdateNewABI.size() > 0){
        AssignmentRules.runAssignmentAlgoForABI(leadTriggerInsertNewABI, leadTriggerUpdateOldABI);
    }*/
    if(serviceBranchUpdateLeads.size() > 0){
        updateLeadBranchCode.updateServiceBranchId(serviceBranchUpdateLeads,postalCodes);
    } 
    
    // TFS-2378..
    if(mapPCCkeyLead.size() > 0)
    {  for(Lead_Source__c ls : [select id,DNIS__c,Campaign__c from Lead_Source__c where DNIS__c IN: mapPCCkeyLead.keyset()])
        { List<Lead> LDlist = mapPCCkeyLead.get(ls.DNIS__c); 
           for(lead l : LDlist)
           { l.Mapped_Campaign__c = ls.Campaign__c; }      
        }    
    }
    
    /****************************************************************************************************************/
    /*                                                                                                              */
    /* updateBranchCodeLead.trgger                                                                                  */
    /*                                                                                                              */
    /****************************************************************************************************************/
    
    // Creates a map between User ID and the User's branch code
    Map<ID, String> userBranchCode = New Map<ID, String>();
    Set<ID> ownerIds = New Set<ID>();
    List<Lead> leadsToUpdate = New List<Lead>();

    Private String BranchUserID = '';   
    try{
        User branchAccountUserID = [Select Id from User where name = 'Branch Account'];     
        BranchUserID = branchAccountUserID.Id;      
    }

    catch (QueryException e) {
        System.debug('Query Issue: ' + e);
    }   

    if (trigger.isInsert){
    
        for (Lead lead : Trigger.new){
            // only process if the owner is not "Branch Account"
            if (lead.ownerId != BranchUserID && lead.RecordTypeId <> ETSrecordtypeID && !mapIdETScreated.get(lead.Id) && !mapIdETSowned.get(lead.Id)){  // TFS 3981, 4220
                ownerIds.add(lead.OwnerId);
                leadsToUpdate.add(lead);
            }
        }
        
    
    }

    if (trigger.isUpdate){
    
        for (Lead lead : Trigger.new){
            // only process if the owner has changed AND the owner is not "Branch Account"
            
            system.debug('Lead Owner during Before Update : ' + lead.ownerId );
            system.debug('Lead Owner Old map value during Before Update : ' + trigger.oldMap.get(lead.id).ownerId);
            
            if ((lead.ownerId != trigger.oldMap.get(lead.id).ownerId) && lead.ownerId != BranchUserID && lead.RecordTypeId <> ETSrecordtypeID && !mapIdETScreated.get(lead.Id) && !mapIdETSowned.get(lead.Id)){ // TFS 3981, 4220
                ownerIds.add(lead.OwnerId);
                leadsToUpdate.add(lead);
            }
        }
    
    }
    
    // Do we need to process any records - Update Branch__c on Lead?
    if (leadsToUpdate.size()>0){
     updateLeadBranchCode.updateBranchCodesOnLead(ownerIds, leadsToUpdate);
    }   
    
    /****************************************************************************************************************/
    /*                                                                                                              */
    /* LeadUpdateOwnerMgr.trigger                                                                                   */
    /*                                                                                                              */
    /****************************************************************************************************************/
    
    List<Lead> leadList = New List<Lead>();
    Set<ID> ownerIds2 = New Set<ID>();
    if (trigger.isInsert){
    
        // Add all the inserts to the list -- we need to get the owner's manager
        for (Lead lead : trigger.new){
            
          
            // Lead Owner Assignment for Uk Weblead & Glenigan Lead (TFS 6866)
            if(lead.isUKwebLead__c == true && lead.Auto_Assign_Lead__c == True){ 
                AllUKLeadlist.add(lead);
            }
            else  if(Lead.RecordTypeId == GleniganrecordtypeID && lead.Auto_Assign_Lead__c == True){
                AllUKLeadlist.add(lead);
            }
            else if(lead.RecordTypeId <> ETSrecordtypeID && !mapIdETScreated.get(lead.Id) && !mapIdETSowned.get(lead.Id)){   // TFS 3981, 4220
                leadList.add(lead);     
                ownerIds2.add(lead.OwnerId); 
            }
          
          
          //leadList.add(lead);     
          //ownerIds2.add(lead.OwnerId);    
            
        }  
    }
    
    else if(trigger.isUpdate){
    
        // Add only the updates where the owner has changed
        for (Lead lead : trigger.new){
        
            system.debug('Lead Owner during Before Update : ' + lead.ownerId );
            system.debug('Lead Owner Old map value during Before Update : ' + trigger.oldMap.get(lead.id).ownerId);
            
            
                
                // Lead Owner Assignment for Uk Weblead & Glenigan Lead (TFS 6866)
                if(lead.isUKwebLead__c == true && lead.Auto_Assign_Lead__c == True && trigger.oldMap.get(lead.id).Auto_Assign_Lead__c == False){ 
                    AllUKLeadlist.add(lead);
                }else  if(Lead.RecordTypeId == GleniganrecordtypeID && lead.Auto_Assign_Lead__c == True && trigger.oldMap.get(lead.id).Auto_Assign_Lead__c == False){
                    AllUKLeadlist.add(lead);
                }else if (lead.ownerId != trigger.OldMap.get(lead.id).ownerId && lead.RecordTypeId <> ETSrecordtypeID && !mapIdETScreated.get(lead.Id) && !mapIdETSowned.get(lead.Id)){  // TFS 3981, 4220
                    leadList.add(lead);
                    ownerIds2.add(lead.OwnerId);   
                }
                
                
                //leadList.add(lead);
                //ownerIds2.add(lead.OwnerId);    
            
        }

    }

    // See if we need to process anything
    if (leadList.size() > 0){
    
        LeadUpdateOwnerMgr.updateOwnersManager(leadList, ownerIds2);
    
        //Done for Case # 0035523 (populating the OriginalOwner on lead to the valid User after execution of the Assignment Rules)
            AssignmentRules.populateOriginalOwner(leadList);
    
    }  

     if (AllUKLeadlist.size() > 0){
        AssignmentRules.updateowner(AllUKLeadlist);
    }   
    
}