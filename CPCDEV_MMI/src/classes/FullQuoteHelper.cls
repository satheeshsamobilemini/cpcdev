public with sharing class FullQuoteHelper {

   public void getrefreshFullQwrapper(FullQuoteWrapper fullQWrapper){
        fullQWrapper.AccountId = '';
        fullQWrapper.AccountName = '';
        fullQWrapper.BillingContactID = '';
        fullQWrapper.ID = '';
        fullQWrapper.TaxExempt = false;
        fullQWrapper.Status = '';
        fullQWrapper.Name = '';
        fullQWrapper.Address = '';
        fullQWrapper.telePhone = '';
        fullQWrapper.City = '';
        fullQWrapper.Fax = '';
        fullQWrapper.County = '';
        fullQWrapper.Email = '';
        fullQWrapper.State = '';
        fullQWrapper.Country = '';
        fullQWrapper.ZipCode = '';
        fullQWrapper.shippingId = '';
        fullQWrapper.deliveryContactId = '';
        fullQWrapper.AddressInShippingDates = '';
        fullQWrapper.NameInShippingDates1 = '';
        fullQWrapper.cityInShippingDates = '';
        fullQWrapper.telInShippingDates = '';
        fullQWrapper.countyInShippingDates = '';
        fullQWrapper.faxInShippingDates = '';
        fullQWrapper.stateInShippingDates = '';
        fullQWrapper.countryInShippingDates = '';
        fullQWrapper.emailInShippingDates = '';
        fullQWrapper.ZipCodeInShipping = '';
        fullQWrapper.isUseBillingAddress = false;
        fullQWrapper.fulFillingBranchInShippingDates = '';
        fullQWrapper.fulFillingBranchNameInShippingDates = '';
        
   }
   
    
   public string getRefreshPayload(FullQuoteWrapper fullQWrapper,List<HomeBaseBeans.quoteLine> summaryLineList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList,
                                          List<HomeBaseBeans.extras> ProductExtrasList,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling,String startDate,
                                           String plannedCollectionDate,String quoteExpires, String PO_Expires, String shippingDate,
                                           HomeBaseBeans.TaxIds selectedTaxRecInBilling,
                                           HomeBaseBeans.TaxIds selectedTaxRecInShipping,String SelectedShipingTaxId, String SelectedRentalLength,String docId, MMI_Full_Quotes__c updateQuoteRec   
                                           ){
      system.debug(LoggingLevel.DEBUG,'Entering FullQuoteHelper :getRefreshPayload'+ProductExtrasList+summaryLineList+'-------selectedTaxRecInShipping----'+selectedTaxRecInShipping);
      String payLoad=null;
      try{
        //fullQWrapper.CODInstructions = fullQWrapper.CODInstructions.trim();
        //fullQWrapper.deliveryInstructions = fullQWrapper.deliveryInstructions.trim();
        fullQWrapper.CODInstructions = removeSpecialCharacters(fullQWrapper.CODInstructions);
        fullQWrapper.deliveryInstructions = removeSpecialCharacters(fullQWrapper.deliveryInstructions);
        fullQWrapper.Address = removeSpecialCharacters(fullQWrapper.Address);
        selectedVAddressInShipping.address1 = removeSpecialCharacters(selectedVAddressInShipping.address1);
        fullQWrapper.AccountName = removeSpecialCharacters(fullQWrapper.AccountName);
         if(fullQWrapper.selectedFullQUote == 'Sales'){
                payLoad = '{"salesQuote": {';
            }else{
                payLoad = '{"rentalQuote": {';
            }
            if(docId != '' && docId != null){
                payLoad = payLoad+'"documentId":'+docId+',';
            }else{
                payLoad = payLoad+'"documentId":0,';
            }   
                payLoad = payLoad+'"companyId": 1,'+
                                     '"transactionId": "'+fullQWrapper.TransactionType+'",'+
                                     '"salesRep1": "'+fullQWrapper.WriteUpRep+'",'+
                                     '"salesRep1Name": "'+fullQWrapper.WriteUpRepName+'",'+
                                     '"salesRep2": "'+fullQWrapper.AssistingRep+'",'+
                                     '"salesRep2Name": "'+fullQWrapper.AssistingRepName+'",'+                                    
                                     '"narrative1": "'+fullQWrapper.JoborLocation+'",'+
                                     '"narrative2": "",'+
                                     '"instructionText": "'+fullQWrapper.CODInstructions+'",'+
                                     '"status": null,'+
                                     //'"status": null,'+
                                     '"modifiedTimestamp": 0,'+ 
                                     '"billingContactDetails": {'+
                                            '"id": "'+fullQWrapper.BillingContactID+'",'+                                       
                                            '"name": "'+fullQWrapper.Name+'",'+                                         
                                            '"tel": "'+fullQWrapper.telePhone+'",'+
                                            '"fax": "'+fullQWrapper.Fax+'",'+  
                                            '"email": "'+fullQWrapper.Email+'",'+
                                            '"mobile": null'+
                                            '},'+
                                     '"reference": "'+fullQWrapper.POContact+'",'+
                                     '"poExpires": "'+PO_Expires+'",'+   
                                    // '"reference": "",'+
                                    // '"poExpires": "",'+                           
                                     '"creditApproval": "",'+
                                     '"taxExemptAuthorisation": "'+fullQWrapper.TaxExemptAuthorization+'",'+
                                     '"taxExempt": '+fullQWrapper.TaxExempt+',';
                                     if(fullQWrapper.selectedFullQUote != 'sales'){ 
                                        payLoad = payLoad +'"quoteTotal": "'+fullQWrapper.QuoteTotal+'",';
                                     } 
                                     payLoad = payLoad +'"lines": [ ';
                    Integer ProdLstSize = 1;                 
                    for(HomeBaseBeans.quoteLine HB : summaryLineList)
                    {               
                        if(HB.lineId == 'new' || HB.lineId == 'newAdded'){
                            HB.lineId = '';
                        }
                        if(HB.description != null){
                            HB.description = removeSpecialCharacters(HB.description);
                        }
                        if(fullQWrapper.selectedFullQUote == 'Sales'){
                            payLoad = payLoad +'{'+'"itemId": "'+HB.itemId+'",'+ 
                                              '"ecode": "'+HB.ecode+'",'+
                                              '"reference": "'+HB.reference+'",'+
                                              '"removeLine": '+HB.removeLine+','+
                                              '"description": "'+HB.description+'",'+
                                              '"lineValue": '+HB.LockTypeTotal+','+
                                              '"quantity": '+HB.quantity+','+
                                              '"price": '+HB.price+','+
                                              '"invoiceDiscountApplicable": '+HB.invoiceDiscountApplicable+','+
                                              '"lockItemCode": "'+HB.lockItemCode+'",';
                            if(HB.lineId != null && HB.lineId != ''){
                                payLoad = payLoad +'"lineId": '+HB.lineId+',';
                            }else{
                                payLoad = payLoad +'"lineId": null,';
                            }
                            payLoad = payLoad +'"estimatedCost": null,'+
                                              '"gpPercent": null,';
                            if(HB.netBookValue != null){ 
                                payLoad = payLoad +'"netBookValue": '+HB.netBookValue+',';
                            }else{
                                payLoad = payLoad +'"netBookValue": null,';
                            }
                            payLoad = payLoad +'"paymentType": null,'+
                                              '"payment1": null,'+
                                              '"payment2": null,'+
                                              '"payment3": null }';
                        }else{
                            payLoad = payLoad +'{'+'"itemId": "'+HB.itemId+'",'+
                                              '"ecode": "'+HB.ecode+'",'+
                                              '"reference": "'+HB.reference+'",'+
                                              '"removeLine": '+HB.removeLine+','+
                                              '"description": "'+HB.description+'",'+
                                              '"lineValue": '+HB.LockTypeTotal+','+
                                              '"quantity": '+HB.quantity+','+
                                              '"price": '+HB.price+','+
                                              '"invoiceDiscountApplicable": '+HB.invoiceDiscountApplicable+','+
                                              '"lockItemCode": "'+HB.lockItemCode+'",';
                            if(HB.lineId != null && HB.lineId != ''){
                                payLoad = payLoad +'"lineId": '+HB.lineId+',';
                            }else{
                                payLoad = payLoad +'"lineId": null,';
                            }
                                              
                         payLoad = payLoad +'"internetCoupon": "'+HB.internetCoupon+'",';
                                                if(HB.chargeCode!=null){                      
                                                payLoad = payLoad +'"chargeCode": {'+
                                                                      '"description": '+ HB.chargeCode.description+','+
                                                                       '"active":'+ HB.chargeCode.active+','+
                                                                        '"id":"'+ HB.chargeCode.id+'"},';
                                                }else{
                                                        payLoad = payLoad +'"chargeCode": null,';
                                                }
                                                if(fullQWrapper.TransactionType == 'MOBO' || fullQWrapper.TransactionType == 'SECO'){
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 2 && Integer.valueOf(fullQWrapper.rentalLength) <= 6){
                                                        payLoad = payLoad +'"rate1": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate1.description+'",'+
                                                        '"editable":'+HB.rate1.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate1": {'+
                                                        '"rate":'+HB.rate1.rate+','+
                                                        '"description": "'+HB.rate1.description+'",'+
                                                        '"editable":'+HB.rate1.editable+
                                                      '},';
                                                    }
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 7 && Integer.valueOf(fullQWrapper.rentalLength) <= 12){
                                                        payLoad = payLoad +'"rate2": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate2.description+'",'+
                                                        '"editable":'+HB.rate2.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate2": {'+
                                                        '"rate":'+HB.rate2.rate+','+
                                                        '"description": "'+HB.rate2.description+'",'+
                                                        '"editable":'+HB.rate2.editable+
                                                        '},';
                                                    }
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 13 && Integer.valueOf(fullQWrapper.rentalLength) <= 24){
                                                        payLoad = payLoad +'"rate3": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate3.description+'",'+
                                                        '"editable":'+HB.rate3.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate3": {'+
                                                        '"rate":'+HB.rate3.rate+','+
                                                        '"description": "'+HB.rate3.description+'",'+
                                                        '"editable":'+HB.rate3.editable+
                                                        '},';
                                                    }
                                                  
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 25){
                                                        payLoad = payLoad +'"rate4": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate4.description+'",'+
                                                        '"editable":'+HB.rate4.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate4": {'+
                                                        '"rate":'+HB.rate4.rate+','+
                                                        '"description": "'+HB.rate4.description+'",'+
                                                        '"editable":'+HB.rate4.editable+
                                                        '},';
                                                    }
                                                    if(fullQWrapper.TransactionType == 'CNST'){
                                                        payLoad = payLoad +'"rate5": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate5.description+'",'+
                                                        '"editable":'+HB.rate4.editable+
                                                        '},';
                                                }else{
                                                        payLoad = payLoad +'"rate5": {'+
                                                        '"rate":'+HB.rate5.rate+','+
                                                        '"description": "'+HB.rate5.description+'",'+
                                                        '"editable":'+HB.rate5.editable+
                                                        '},';
                                                }
                                                
                                                }else{
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) == 1){
                                                        payLoad = payLoad +'"rate1": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate1.description+'",'+
                                                        '"editable":'+HB.rate1.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate1": {'+
                                                        '"rate":'+HB.rate1.rate+','+
                                                        '"description": "'+HB.rate1.description+'",'+
                                                        '"editable":'+HB.rate1.editable+
                                                      '},';
                                                    }
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 2 && Integer.valueOf(fullQWrapper.rentalLength) <= 6){
                                                        payLoad = payLoad +'"rate2": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate2.description+'",'+
                                                        '"editable":'+HB.rate2.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate2": {'+
                                                    '"rate":'+HB.rate2.rate+','+
                                                    '"description": "'+HB.rate2.description+'",'+
                                                    '"editable":'+HB.rate2.editable+
                                                        '},';
                                                    }
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 7 && Integer.valueOf(fullQWrapper.rentalLength) <= 12){
                                                        payLoad = payLoad +'"rate3": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate3.description+'",'+
                                                        '"editable":'+HB.rate3.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate3": {'+
                                                    '"rate":'+HB.rate3.rate+','+
                                                    '"description": "'+HB.rate3.description+'",'+
                                                    '"editable":'+HB.rate3.editable+
                                                        '},';
                                                    }
                                                    
                                                    if(Integer.valueOf(fullQWrapper.rentalLength) >= 13){
                                                        payLoad = payLoad +'"rate4": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate4.description+'",'+
                                                        '"editable":'+HB.rate4.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate4": {'+
                                                    '"rate":'+HB.rate4.rate+','+
                                                    '"description": "'+HB.rate4.description+'",'+
                                                    '"editable":'+HB.rate4.editable+
                                                        '},';
                                                    }
                                                    if(fullQWrapper.TransactionType == 'CNST'){
                                                        payLoad = payLoad +'"rate5": {'+
                                                        '"rate":'+HB.price+','+
                                                        '"description": "'+HB.rate5.description+'",'+
                                                        '"editable":'+HB.rate4.editable+
                                                        '},';
                                                    }else{
                                                        payLoad = payLoad +'"rate5": {'+
                                                    '"rate":'+HB.rate5.rate+','+
                                                    '"description": "'+HB.rate5.description+'",'+
                                                    '"editable":'+HB.rate5.editable+
                                                        '},';
                                                    }
                                                }                               
                                                payLoad = payLoad +'"rate6": {'+
                                                    '"rate":'+HB.rate6.rate+','+
                                                    '"description": "'+HB.rate6.description+'",'+
                                                    '"editable":'+HB.rate6.editable+
                                              '},'+
                                                    
                                              '"rate7": {'+
                                                    '"rate":'+HB.rate7.rate+','+
                                                    '"description": "'+HB.rate7.description+'",'+
                                                    '"editable":'+HB.rate7.editable+
                                              '},'+
                                                    
                                              '"rate8": {'+
                                                    '"rate":'+HB.rate8.rate+','+
                                                    '"description": "'+HB.rate8.description+'",'+
                                                    '"editable":'+HB.rate8.editable+
                                              '},'+
                                              '"commission1": '+HB.commission1+','+
                                              '"commission2": '+HB.commission2+','+
                                              '"commission3": '+HB.commission3+','+
                                              '"commission4": '+HB.commission4+
                                             '}';
                                             
                        }                                         
                            if(summaryLineList.size() != ProdLstSize)
                            {
                                payLoad = payLoad + ',';
                            }
                            ProdLstSize ++;         
                    
                            //break;
                    }                
                    payLoad = payLoad + '],';
                    Integer n = 1;                  
                    for(HomeBaseBeans.AnalysisSetHeaders HB : analysisSetHeaderResponseList)
                    {
                            if(HB.description == 'Cost Center'){
                                HB.selectedId = '00';
                                HB.selectedDescription = 'NA';
                            }
                            if(HB.description == 'Write Off A/c'){
                                HB.selectedId =  '49100';  
                                HB.selectedDescription = 'Cost of Sales'; 
                            }
                            if(HB.description == 'Outside TSM'){
                                HB.selectedDescription = HB.Longdescription;
                            }
                        
                            payLoad = payLoad +'"analysisSet'+n+'": {'+
                                                    '"header": {'+  
                                                        '"id": '+HB.id+','+
                                                        '"description": "'+HB.description+'"'+
                                                     '},'+
                                                     '"selection": {'+
                                                        '"id": "'+HB.selectedId+'",'+
                                                        '"description": "'+HB.selectedDescription+'"'+
                                                     '}'+
                                                 '},';
                                         
                        n++;
                    } 
                    
                                    
                    for(HomeBaseBeans.AnalysisSetHeaders HB : analysisSetHeaderResponseShippingList)
                    {
                        if(HB.id == '111'){
                            n = 1;
                        }else if(HB.id == '112'){
                            if(HB.selectedId == null || HB.selectedId == ''){
                                HB.selectedDescription = null;
                            }
                            n = 2;
                        }else if(HB.id == '113'){
                            n = 3;
                        }else if(HB.id == '114'){
                            if(HB.selectedId == null || HB.selectedId == ''){
                                HB.selectedDescription = null;
                            }
                            n = 4;
                        }
                        
                        payLoad = payLoad +'"additionalAnalysisSet'+n+'": {'+
                                                '"header": {'+  
                                                    '"id": '+HB.id+','+
                                                    '"description": "'+HB.description+'"'+
                                                 '},'+
                                                 '"selection": {'+
                                                    '"id": "'+HB.selectedId+'",'+
                                                    '"description": "'+HB.selectedDescription+'"'+
                                                 '}'+
                                             '},';
                                            
                    } 
                    
                    payLoad = payLoad + '"termsCode": "'+fullQWrapper.TermsCode+'",'+
                                        '"invoicedBalance": "'+fullQWrapper.InvoicedBalance+'",';
                    String LastInvoiceDate = '';
                    if(fullQWrapper.LastInvoice == null || fullQWrapper.LastInvoice == ''){
                        LastInvoiceDate = '""';
                    }else{
                        LastInvoiceDate = '"'+fullQWrapper.LastInvoice+'"';
                    }                   
                    payLoad = payLoad +'"lastInvoiceDate": '+LastInvoiceDate+','+
                                        '"writeUpRepCommission": null,'+    
                                        '"nscRepCommission": null,'+
                                        '"portalContact": "",'+
                                        '"portalContactEmail": "",'+
                                        '"alreadyRegistered": null,'+
                                        '"homeOwner": "",'+
                                        '"creditStatus": "'+fullQWrapper.Status+'",'+
                                        '"poRequired": null,'+
                                        '"viewDocumentIn": null,'+
                                        '"emailPortalLink": false,'+
                                        '"messageDetails": null,';
                    if(updateQuoteRec != null){
                        if(updateQuoteRec.Reservation_ID__c != null && updateQuoteRec.Reservation_ID__c != ''){
                            payLoad = payLoad +'"reservationId": '+updateQuoteRec.Reservation_ID__c+',';
                        }else{
                            payLoad = payLoad +'"reservationId": null,';
                        }
                    }else{
                        payLoad = payLoad +'"reservationId": null,';
                    }                   
                    payLoad = payLoad +'"accountId": "'+fullQWrapper.AccountId+'",'+
                                        '"startDate": "'+startDate+'",'+
                                        '"plannedCollectionDate": "'+plannedCollectionDate+'",'+
                                        '"billingAddressId": "'+fullQWrapper.ID+'",'+
                                        
                                        '"billingAddress": {'+
                                                '"name": "'+fullQWrapper.AccountName+'",'+                                          
                                                '"address1": "'+fullQWrapper.Address+'",'+
                                                '"address2": "'+selectedVAddressInBilling.address2+'",'+
                                                '"address3": "'+fullQWrapper.City+'",'+
                                                '"address4": "'+fullQWrapper.County+'",'+
                                                '"state": "'+fullQWrapper.State+'",'+
                                                '"countryId": "'+fullQWrapper.Country+'",'+
                                                '"zipCode": "'+fullQWrapper.ZipCode+'",'+
                                                '"crossStreet1": null,'+
                                                '"crossStreet2": null,'+
                                                '"taxId": "'+selectedTaxRecInBilling.Id+'",';
                                                if(fullQWrapper.TransactionType == 'MOBO'){
                                                    payLoad = payLoad +'"deliveryZone": null,';
                                                }else{
                                                    payLoad = payLoad +'"deliveryZone": "'+selectedVAddressInBilling.deliveryZone+'",';
                                                }
                            payLoad = payLoad +'"cityZone": null,'+
                                                '"zoneWarning": '+selectedVAddressInBilling.zoneWarning+','+
                                                '"latitude": '+selectedVAddressInBilling.latitude+','+
                                                '"longitude": '+selectedVAddressInBilling.longitude+','+
                                                '"oldPostalCode": "'+selectedVAddressInBilling.oldPostalCode+'",'+
                                                //'"zipCode": "'+selectedVAddressInBilling.zipCode+'",'+
                                                '"distanceFromBranch": '+selectedVAddressInBilling.distanceFromBranch+','+
                                                '"distanceBranch": '+selectedVAddressInBilling.distanceBranch+','+
                                                '"fulfillingBranchId": null,'+
                                                '"fulfillingBranchName": "'+selectedVAddressInBilling.fulfillingBranchName+'"'+
                                        '},'+
                                    '"extras": [';
                                        
                    Integer m = 1; 
                    
                    list<HomeBaseBeans.extras>  tempProductExtrasList = new list<HomeBaseBeans.extras>();
                    for(HomeBaseBeans.extras HB : ProductExtrasList)
                    {
                        if(HB.include == true){
                            tempProductExtrasList.add(HB);
                        }
                    }
                    for(HomeBaseBeans.extras HB : tempProductExtrasList)
                    {
                            payLoad = payLoad + '{'+
                                                    '"id": "'+HB.Id+'",'+
                                                '"description": "'+HB.description+'",'+
                                                '"quantity": '+HB.quantity+','+
                                                '"price": '+HB.price+','+
                                                '"total": '+HB.total+','+
                                                '"rate1": {'+
                                                    '"rate":"'+HB.rate1.rate+'",'+
                                                    '"description": "'+HB.rate1.description+'",'+
                                                    '"editable":'+HB.rate1.editable+
                                                  '},'+
                                                  
                                                  '"rate2": {'+
                                                        '"rate":"'+HB.rate2.rate+'",'+
                                                        '"description": "'+HB.rate2.description+'",'+
                                                        '"editable":'+HB.rate2.editable+
                                                  '},'+
                                                        
                                                  '"rate3": {'+
                                                        '"rate":"'+HB.rate3.rate+'",'+
                                                        '"description": "'+HB.rate3.description+'",'+
                                                        '"editable":'+HB.rate3.editable+
                                                  '},'+
                                                        
                                                  '"rate4": {'+
                                                        '"rate":"'+HB.rate4.rate+'",'+
                                                        '"description": "'+HB.rate4.description+'",'+
                                                        '"editable":'+HB.rate4.editable+
                                                  '},'+
                                                        
                                                  '"rate5": {'+
                                                        '"rate":"'+HB.rate5.rate+'",'+
                                                        '"description": "'+HB.rate5.description+'",'+
                                                        '"editable":'+HB.rate5.editable+
                                                  '},'+
                                                        
                                                  '"rate6": {'+
                                                        '"rate":"'+HB.rate6.rate+'",'+
                                                        '"description": "'+HB.rate6.description+'",'+
                                                        '"editable":'+HB.rate6.editable+
                                                  '},'+
                                                        
                                                  '"rate7": {'+
                                                        '"rate":"'+HB.rate7.rate+'",'+
                                                        '"description": "'+HB.rate7.description+'",'+
                                                        '"editable":'+HB.rate7.editable+
                                                  '},'+
                                                        
                                                  '"rate8": {'+
                                                        '"rate":"'+HB.rate8.rate+'",'+
                                                        '"description": "'+HB.rate8.description+'",'+
                                                        '"editable":'+HB.rate8.editable+
                                                  '},'+
                                                  '"include": '+HB.include+','+
                                                  '"mandatory": '+HB.mandatory+','+
                                                  '"priceEditable": '+HB.priceEditable+','+
                                                  '"quantityEditable": '+HB.quantityEditable+','+
                                                  '"quantityRequired": '+HB.quantityRequired+
                                             '}';
                        if(tempProductExtrasList.size() != m)
                        {
                            payLoad = payLoad + ',';
                        }
                        m++;                     
                                                
                    }                       
                    
                 payLoad = payLoad + '],'+
                                     '"quoteExpires": "'+quoteExpires+'",'+
                                    // '"PO_Expires": "'+PO_Expires+'",'+
                                     
                                     '"certificateOfInsurance": "'+fullQWrapper.CertofInsurance+'",';
                    /*if(fullQWrapper.DeliveryInInvoicing != null && fullQWrapper.DeliveryInInvoicing != ''){
                        payLoad = payLoad +'"delivery": '+fullQWrapper.DeliveryInInvoicing+',';
                    }else{*/
                        payLoad = payLoad +'"delivery": null,';
                    //}
                    User userBranchDetail = FullQuoteDAO.getUserBranchDetails();
                    String loggedInUserBranchId = fullQWrapper.userBranchId;
    	 			if(userBranchDetail != null && userBranchDetail.NSC_Rep__c ){
    	 				loggedInUserBranchId = '298';
                    }
                    if(fullQWrapper.selectedFullQUote == 'Sales'){
                        payLoad = payLoad +'"orderGoods": null,'+
                                            '"extrasTotal": null,'+
                                            '"tax": null,'+
                                            '"orderTotal": null,'+
                                            //'"salesTerms": "'+fullQWrapper.Terms+'",'+
                                            '"type": "sales",'+
                                            '"mobilization": null,'+
                                            '"branchId": '+loggedInUserBranchId+','+
                                            '"ytdSales": "'+fullQWrapper.YTDSales+'",';
                    }else{
                        payLoad = payLoad +'"rentalCharge": null,'+
                                     '"pickUp": null,'+     
                                     '"accessories": null,'+
                                     '"llw": null,'+
                                     '"other": null,'+
                                     '"codAmount": null,'+
                                     '"tax": null,'+
                                     '"totalCodAmount": null,'+
                                     '"hireTerms": "'+fullQWrapper.Terms+'",'+
                                     '"customerText1": "",'+
                                     ' "type": "rental",'+
                                     '"mobilization": null,'+
                                     '"branchId": '+loggedInUserBranchId+','+
                                     //'"branchId": 126,'+                               
                                     '"ytdSales": "'+fullQWrapper.YTDSales+'",';
                    }    
                                     
                                      
                   payLoad = payLoad +'"shippingDate": "'+shippingDate+'",'+
                                     '"shippingAddressId": "'+fullQWrapper.shippingId+'",'+ 
                                     '"shippingAddress": {'+
                                                '"name": "'+fullQWrapper.AccountName+'",'+                                          
                                                '"address1": "'+selectedVAddressInShipping.address1+'",'+
                                                '"address2": "'+selectedVAddressInShipping.address2+'",'+
                                                '"address3": "'+selectedVAddressInShipping.address3+'",'+
                                                '"address4": "'+selectedVAddressInShipping.address4+'",'+
                                                '"state": "'+selectedVAddressInShipping.state+'",'+
                                                '"countryId": "'+selectedVAddressInShipping.countryId+'",'+
                                                '"crossStreet1": "'+fullQWrapper.crossStreetInShippingDates+'",'+
                                                '"crossStreet2": "'+fullQWrapper.crossStreet2InShippingDates+'",'+
                                                '"taxId": "'+fullQWrapper.SelectedShipingTaxId+'",';
                                                if(fullQWrapper.TransactionType == 'MOBO'){
                                                    payLoad = payLoad +'"deliveryZone": null,';
                                                }else{
                                                    payLoad = payLoad +'"deliveryZone": "'+fullQWrapper.deliveryZoneInShipping+'",';
                                                }
                            payLoad = payLoad +'"cityZone": null,';
                                                
                                                if(selectedVAddressInShipping.zoneWarning!=null){
                                                    payLoad = payLoad+'"zoneWarning": "'+selectedVAddressInShipping.zoneWarning+'",';
                                                }else{
                                                    payLoad = payLoad+'"zoneWarning": '+selectedVAddressInShipping.zoneWarning+',';
                                                }
                                                
                                            payLoad = payLoad+'"latitude": '+selectedVAddressInShipping.latitude+','+
                                                '"longitude": '+selectedVAddressInShipping.longitude+','+
                                                '"oldPostalCode": "'+selectedVAddressInShipping.oldPostalCode+'",'+
                                                '"zipCode": "'+selectedVAddressInShipping.zipCode+'",'+
                                                '"distanceFromBranch": '+fullQWrapper.distFromBranch+','+
                                                '"distanceBranch": '+selectedVAddressInShipping.distanceBranch+','+
                                                '"fulfillingBranchId": '+fullQWrapper.userBranchId+','+
                                                '"fulfillingBranchName": "'+fullQWrapper.fulFillingBranchNameInShippingDates+'"'+
                                    '},'+
                                    ' "shippingContactDetails": {'+
                                            '"id": "'+fullQWrapper.deliveryContactId+'",'+                                      
                                            '"name": "'+fullQWrapper.NameInShippingDates1+'",'+                                                 
                                            '"tel": "'+fullQWrapper.telInShippingDates+'",'+
                                            '"fax": "'+fullQWrapper.faxInShippingDates+'",'+
                                            '"email": "'+fullQWrapper.emailInShippingDates+'",'+
                                            '"mobile":""'+
                                            '},';
                            if(fullQWrapper.selectedFullQUote != 'Sales'){  
                                    payLoad = payLoad+'"shippingInstructions": "'+fullQWrapper.deliveryInstructions+'",'+       
                                    '"rentalLength": '+SelectedRentalLength; 
                            }else{
                                payLoad = payLoad+'"shippingInstructions": "'+fullQWrapper.deliveryInstructions+'"';        
                            }
                            payLoad = payLoad+'}'+
                        '}';    
                
                payLoad = payLoad.replaceAll('"null"','""');
                
         }catch(Exception e){
             system.debug(LoggingLevel.ERROR,'Error while getting values from  FullQuoteHelper :getRefreshPayload: '+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting FullQuoteHelper :getRefreshPayload'+payLoad);     
        return payLoad;
   }
   
    public void assignRefreshValue(FullQuoteWrapper fullQWrapper,List<HomeBaseBeans.quoteLine> summaryLineList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList,
                                          List<HomeBaseBeans.extras> ProductExtrasList,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling,String startDate,
                                           String plannedCollectionDate,String quoteExpires,String PO_Expires, String shippingDate,
                                           HomeBaseBeans.TaxIds selectedTaxRecInBilling,
                                           HomeBaseBeans.TaxIds selectedTaxRecInShipping,
                                           FullQuoteRefreshParser_AC EditResponse
                                           ){
                                            
                system.debug(LoggingLevel.DEBUG,'Entering FullQuoteHelper :assignRefreshValue'+EditResponse);
                system.debug(LoggingLevel.DEBUG,'ProductExtrasList------'+ProductExtrasList);
                                            
                try{                            
                      if(fullQWrapper.selectedFullQUote == 'sales'){
                        
                        fullQWrapper.CODInstructions = EditResponse.salesQuote.instructionText;
                        fullQWrapper.deliveryInstructions = EditResponse.salesQuote.shippingInstructions;
                        fullQWrapper.TransactionType = EditResponse.salesQuote.transactionId;
                        fullQWrapper.WriteUpRep = EditResponse.salesQuote.salesRep1;
                        fullQWrapper.WriteUpRepName = EditResponse.salesQuote.salesRep1Name;
                        fullQWrapper.AssistingRep = EditResponse.salesQuote.salesRep2;
                        fullQWrapper.AssistingRepName = EditResponse.salesQuote.salesRep2Name;
                        fullQWrapper.AccountId = EditResponse.salesQuote.accountId;
                        
                        
                        // Billing address
                        
                        fullQWrapper.ID = EditResponse.salesQuote.billingAddressId; 
                        fullQWrapper.TaxExempt = EditResponse.salesQuote.taxExempt;
                        fullQWrapper.Status = EditResponse.salesQuote.creditStatus;
                        fullQWrapper.Address = EditResponse.salesQuote.billingAddress.address1;
                        fullQWrapper.City = EditResponse.salesQuote.billingAddress.address3;
                        fullQWrapper.Country = EditResponse.salesQuote.billingAddress.countryId;
                        fullQWrapper.State = EditResponse.salesQuote.billingAddress.state;
                        fullQWrapper.ZipCode = EditResponse.salesQuote.billingAddress.zipCode;
                        
                        // BillingContact Details
                        
                        fullQWrapper.BillingContactID = EditResponse.salesQuote.billingContactDetails.id;
                        fullQWrapper.Name = EditResponse.salesQuote.billingContactDetails.name;
                        fullQWrapper.telePhone = EditResponse.salesQuote.billingContactDetails.tel;
                        // Shipping address
                        
                        fullQWrapper.shippingId = EditResponse.salesQuote.shippingAddressId;
                        fullQWrapper.AddressInShippingDates = EditResponse.salesQuote.shippingAddress.address1;
                        fullQWrapper.cityInShippingDates = EditResponse.salesQuote.shippingAddress.address3;
                        fullQWrapper.countryInShippingDates = EditResponse.salesQuote.shippingAddress.countryId;
                        fullQWrapper.stateInShippingDates = EditResponse.salesQuote.shippingAddress.state;
                        fullQWrapper.ZipCodeInShipping = EditResponse.salesQuote.shippingAddress.zipCode;
                        fullQWrapper.crossStreetInShippingDates = EditResponse.salesQuote.shippingAddress.crossStreet1;
                        fullQWrapper.crossStreet2InShippingDates = EditResponse.salesQuote.shippingAddress.crossStreet2;
                        fullQWrapper.deliveryZoneInShipping = EditResponse.salesQuote.shippingAddress.deliveryZone;
                        fullQWrapper.distFromBranch = EditResponse.salesQuote.shippingAddress.distanceFromBranch;
                        
                        // ShippingContact Details
                        
                        fullQWrapper.deliveryContactId = EditResponse.salesQuote.shippingContactDetails.id;
                        fullQWrapper.NameInShippingDates1 = EditResponse.salesQuote.shippingContactDetails.name;
                        
                        if(!(EditResponse.salesQuote.accessories == '' || EditResponse.salesQuote.accessories == null))
                        {   
                            fullQWrapper.Accessories = EditResponse.salesQuote.accessories;
                        } 
                          
                        fullQWrapper.CertofInsurance = EditResponse.salesQuote.certificateOfInsurance;
                        if(!(EditResponse.salesQuote.codAmount == '' || EditResponse.salesQuote.codAmount == null))
                        {   
                            fullQWrapper.CODAmount = EditResponse.salesQuote.codAmount; 
                        }
                        if(!(EditResponse.salesQuote.tax == '' || EditResponse.salesQuote.tax == null)){
                            fullQWrapper.taxInvoice = EditResponse.salesQuote.tax;
                        }
                        fullQWrapper.CreditApproval = EditResponse.salesQuote.creditApproval;
                        
                        if(!(EditResponse.salesQuote.delivery == '' || EditResponse.salesQuote.delivery == null))
                        {   
                            fullQWrapper.DeliveryInInvoicing = EditResponse.salesQuote.delivery;
                        }
                        
                        ProductExtrasList = new List<HomeBaseBeans.extras>();
                        system.debug(LoggingLevel.DEBUG,'ProductExtrasList------'+ProductExtrasList);
                        
                        for(FullQuoteRefreshParser_AC.Extras PE : EditResponse.salesQuote.extras)
                        {
                            HomeBaseBeans.extras HB = new HomeBaseBeans.extras();
                            HB.id = PE.id;
                            HB.description = PE.description;
                            if(!(PE.quantity == '' || PE.quantity == null))
                            {   
                                HB.quantity = PE.quantity;
                            }
                            HB.include = PE.include; 
                            HB.mandatory = PE.mandatory;
                            if(!(PE.price == '' || PE.price == null))
                            {   
                                HB.price = PE.price; 
                            }
                            HB.priceEditable = PE.priceEditable;
                            HB.quantityEditable = PE.quantityEditable;
                            HB.quantityRequired = PE.quantityRequired;
                            if(!(PE.total == '' || PE.total == null))
                            {   
                                HB.total = PE.total;
                            }
                            
                            HB.rate1 = new HomeBaseBeans.rates();
                            
                            HB.rate1.description = PE.rate1.description;
                            HB.rate1.editable = PE.rate1.editable;
                            HB.rate1.rate = PE.rate1.rate;
                            
                            HB.rate2= null;
                            HB.rate3= null;
                            HB.rate4= null;
                            HB.rate5= null;
                            HB.rate6= null;
                            HB.rate7= null;
                            HB.rate8= null;
                            
                            ProductExtrasList.add(HB);
                        }
                        
                
                        fullQWrapper.extrasInvoice = EditResponse.salesQuote.extrasTotal;
                        fullQWrapper.totalInvoice = EditResponse.salesQuote.orderTotal;
                        fullQWrapper.BillDiscountInvoice = '';
                        fullQWrapper.unitPriceInvoice = EditResponse.salesQuote.orderGoods;
                        fullQWrapper.CODInstructions = EditResponse.salesQuote.instructionText;
                        //fullQWrapper.Terms = EditResponse.salesQuote.hireTerms;
                        //fullQWrapper.TermsCode = EditResponse.salesQuote.termsCode;
                        //fullQWrapper.InvoicedBalance= EditResponse.salesQuote.invoicedBalance;
                        //fullQWrapper.LastInvoice = '';
                        //fullQWrapper.YTDSales = EditResponse.salesQuote.ytdSales;
                        
                        for(HomeBaseBeans.quoteLine HB : summaryLineList)
                        {
                            for(FullQuoteRefreshParser_AC.Lines FL : EditResponse.salesQuote.lines )
                            {
                                if(HB.itemId == FL.itemId )
                                {
                                    if(!(FL.commission1 == '' || FL.commission1 == null))
                                    {   
                                        HB.commission1 = Decimal.valueOf(FL.commission1);
                                    }
                                    if(!(FL.commission2 == '' || FL.commission2 == null))
                                    {   
                                        HB.commission2 = Decimal.valueOf(FL.commission2);
                                    }
                                    if(!(FL.commission3 == '' || FL.commission3 == null))
                                    {   
                                        HB.commission3 = Decimal.valueOf(FL.commission3);
                                    }
                                    if(!(FL.commission4 == '' || FL.commission4 == null))
                                    {   
                                        HB.commission4 = Decimal.valueOf(FL.commission4);
                                    }
                                    HB.description = FL.description;
                                    HB.ecode = FL.ecode;
                                    HB.internetCoupon = FL.internetCoupon;
                                    HB.invoiceDiscountApplicable = FL.invoiceDiscountApplicable;
                                    HB.lineValue = FL.lineValue;
                                    HB.price = Decimal.valueOf(FL.price);
                                    HB.lockItemCode = FL.lockItemCode;
                                    HB.lineId = FL.lineId;
                                    if(FL.netBookValue != null){
                                        HB.netBookValue = Decimal.valueOf(FL.netBookValue);
                                    }
                                    HB.paymentType = null;
                                    HB.payment1 = null;
                                    HB.payment2 = null;
                                    HB.payment3 = null;
                                    if(!(FL.quantity == '' || FL.quantity == null))
                                    {   
                                        HB.quantity = Decimal.valueOf(FL.quantity);
                                    }
                                    HB.rate1 = null;
                                    HB.rate2 = null;
                                    HB.rate3 = null;
                                    HB.rate4 = null;
                                    HB.rate5 = null;
                                    HB.rate6 = null;
                                    HB.rate7 = null;
                                    HB.rate8 = null;
                                    HB.reference = FL.reference;                            
                                }
                            }
                        }
                        
                        
                    
                    }else{
                        fullQWrapper.TransactionType = EditResponse.rentalQuote.transactionId;
                        fullQWrapper.WriteUpRep = EditResponse.rentalQuote.salesRep1;
                        fullQWrapper.WriteUpRepName = EditResponse.rentalQuote.salesRep1Name;
                        fullQWrapper.AssistingRep = EditResponse.rentalQuote.salesRep2;
                        fullQWrapper.AssistingRepName = EditResponse.rentalQuote.salesRep2Name;
                        fullQWrapper.AccountId = EditResponse.rentalQuote.accountId;
                        
                    
                        
                        // Billing address
                        
                        fullQWrapper.ID = EditResponse.rentalQuote.billingAddressId;    
                        fullQWrapper.TaxExempt = EditResponse.rentalQuote.taxExempt;
                        fullQWrapper.Status = EditResponse.rentalQuote.creditStatus;
                        fullQWrapper.Address = EditResponse.rentalQuote.billingAddress.address1;
                        fullQWrapper.City = EditResponse.rentalQuote.billingAddress.address3;
                        fullQWrapper.Country = EditResponse.rentalQuote.billingAddress.countryId;
                        fullQWrapper.State = EditResponse.rentalQuote.billingAddress.state;
                        fullQWrapper.ZipCode = EditResponse.rentalQuote.billingAddress.zipCode;
                        fullQWrapper.CODInstructions = EditResponse.rentalQuote.instructionText;
                        fullQWrapper.deliveryInstructions = EditResponse.rentalQuote.shippingInstructions;
                        // BillingContact Details
                        
                        fullQWrapper.BillingContactID = EditResponse.rentalQuote.billingContactDetails.id;
                        fullQWrapper.Name = EditResponse.rentalQuote.billingContactDetails.name;
                        fullQWrapper.telePhone = EditResponse.rentalQuote.billingContactDetails.tel;
                        // Shipping address
                        
                        fullQWrapper.shippingId = EditResponse.rentalQuote.shippingAddressId;
                        fullQWrapper.AddressInShippingDates = EditResponse.rentalQuote.shippingAddress.address1;
                        fullQWrapper.cityInShippingDates = EditResponse.rentalQuote.shippingAddress.address3;
                        fullQWrapper.countryInShippingDates = EditResponse.rentalQuote.shippingAddress.countryId;
                        fullQWrapper.stateInShippingDates = EditResponse.rentalQuote.shippingAddress.state;
                        fullQWrapper.ZipCodeInShipping = EditResponse.rentalQuote.shippingAddress.zipCode;
                        fullQWrapper.crossStreetInShippingDates = EditResponse.rentalQuote.shippingAddress.crossStreet1;
                        fullQWrapper.crossStreet2InShippingDates = EditResponse.rentalQuote.shippingAddress.crossStreet2;
                        fullQWrapper.deliveryZoneInShipping = EditResponse.rentalQuote.shippingAddress.deliveryZone;
                        fullQWrapper.distFromBranch = EditResponse.rentalQuote.shippingAddress.distanceFromBranch;
                        
                        // ShippingContact Details
                        
                        fullQWrapper.deliveryContactId = EditResponse.rentalQuote.shippingContactDetails.id;
                        fullQWrapper.NameInShippingDates1 = EditResponse.rentalQuote.shippingContactDetails.name;
                        
                        if(!(EditResponse.rentalQuote.accessories == '' || EditResponse.rentalQuote.accessories == null))
                        {   
                            fullQWrapper.Accessories = EditResponse.rentalQuote.accessories;
                        } 
                        fullQWrapper.CertofInsurance = EditResponse.rentalQuote.certificateOfInsurance;
                        if(!(EditResponse.rentalQuote.codAmount == '' || EditResponse.rentalQuote.codAmount == null))
                        {   
                            fullQWrapper.CODAmount = EditResponse.rentalQuote.codAmount; 
                        }
                        if(!(EditResponse.rentalQuote.tax == '' || EditResponse.rentalQuote.tax == null)){
                            fullQWrapper.TaxTotal = EditResponse.rentalQuote.tax;
                        }
                        if(!(EditResponse.rentalQuote.rentalCharge == '' || EditResponse.rentalQuote.rentalCharge == null)){
                            fullQWrapper.RentalCharge = EditResponse.rentalQuote.rentalCharge;
                        }
                        if(!(EditResponse.rentalQuote.codAmount == '' || EditResponse.rentalQuote.codAmount == null))
                        {
                            if(!(EditResponse.rentalQuote.tax == '' || EditResponse.rentalQuote.tax == null)){
                                fullQWrapper.TotalCODAmount =String.ValueOf(Decimal.valueOf(EditResponse.rentalQuote.codAmount) + Decimal.valueOf(EditResponse.rentalQuote.tax));
                            }else{  
                                fullQWrapper.TotalCODAmount = EditResponse.rentalQuote.codAmount;
                            } 
                        }
                        fullQWrapper.CreditApproval = EditResponse.rentalQuote.creditApproval;
                        
                        if(!(EditResponse.rentalQuote.delivery == '' || EditResponse.rentalQuote.delivery == null))
                        {   
                            fullQWrapper.DeliveryInInvoicing = EditResponse.rentalQuote.delivery;
                        }
                        system.debug(LoggingLevel.DEBUG,'ProductExtrasList------'+ProductExtrasList);
                        
                        ProductExtrasList = new List<HomeBaseBeans.extras>();
                
                        for(FullQuoteRefreshParser_AC.Extras PE : EditResponse.rentalQuote.extras)
                        {
                            HomeBaseBeans.extras HB = new HomeBaseBeans.extras();
                            HB.id = PE.id;
                            HB.description = PE.description;
                            if(PE.description.contains('Personal Property Expense'))
                            {
                                fullQWrapper.PPETotal = String.valueOf(PE.total);
                            }
                            if(!(PE.quantity == '' || PE.quantity == null))
                            {   
                                HB.quantity = PE.quantity;
                            }
                            HB.include = PE.include; 
                            HB.mandatory = PE.mandatory;
                            if(!(PE.price == '' || PE.price == null))
                            {   
                                HB.price = PE.price; 
                            }
                            HB.priceEditable = PE.priceEditable;
                            HB.quantityEditable = PE.quantityEditable;
                            HB.quantityRequired = PE.quantityRequired;
                            if(!(PE.total == '' || PE.total == null))
                            {   
                                HB.total = PE.total;
                            }
                            
                            HB.rate1 = new HomeBaseBeans.rates();
                            HB.rate2 = new HomeBaseBeans.rates();
                            HB.rate3 = new HomeBaseBeans.rates();
                            HB.rate4 = new HomeBaseBeans.rates();
                            HB.rate5 = new HomeBaseBeans.rates();
                            HB.rate6 = new HomeBaseBeans.rates();
                            HB.rate7 = new HomeBaseBeans.rates();
                            HB.rate8 = new HomeBaseBeans.rates();
                            
                            HB.rate1.description = PE.rate1.description;
                            HB.rate1.editable = PE.rate1.editable;
                            HB.rate1.rate = PE.rate1.rate;
                            
                            HB.rate2.description = PE.rate2.description;
                            HB.rate2.editable = PE.rate2.editable;
                            HB.rate2.rate = PE.rate2.rate;
                            
                            HB.rate3.description = PE.rate3.description;
                            HB.rate3.editable = PE.rate3.editable;
                            HB.rate3.rate = PE.rate3.rate;
                            
                            HB.rate4.description = PE.rate4.description;
                            HB.rate4.editable = PE.rate4.editable;
                            HB.rate4.rate = PE.rate4.rate;
                            
                            HB.rate5.description = PE.rate5.description;
                            HB.rate5.editable = PE.rate5.editable;
                            HB.rate5.rate = PE.rate5.rate;
                            
                            HB.rate6.description = PE.rate6.description;
                            HB.rate6.editable = PE.rate6.editable;
                            HB.rate6.rate = PE.rate6.rate;
                            
                            HB.rate7.description = PE.rate7.description;
                            HB.rate7.editable = PE.rate7.editable;
                            HB.rate7.rate = PE.rate7.rate;
                            
                            HB.rate8.description = PE.rate8.description;
                            HB.rate8.editable = PE.rate8.editable;
                            HB.rate8.rate = PE.rate8.rate;
                            
                            ProductExtrasList.add(HB);
                        }
                        system.debug(LoggingLevel.DEBUG,'ProductExtrasList------'+ProductExtrasList);
                        System.debug(summaryLineList+' Lines resoinse *** '+EditResponse.RentalQuote.lines);
                        
                        for(HomeBaseBeans.quoteLine HB : summaryLineList)
                        {
                            for(FullQuoteRefreshParser_AC.Lines FL : EditResponse.rentalQuote.lines )
                            {
                                if(HB.itemId == FL.itemId )
                                {
                                    if(!(FL.commission1 == '' || FL.commission1 == null))
                                    {   
                                        HB.commission1 = Decimal.valueOf(FL.commission1);
                                    }
                                    if(!(FL.commission2 == '' || FL.commission2 == null))
                                    {   
                                        HB.commission2 = Decimal.valueOf(FL.commission2);
                                    }
                                    if(!(FL.commission3 == '' || FL.commission3 == null))
                                    {   
                                        HB.commission3 = Decimal.valueOf(FL.commission3);
                                    }
                                    if(!(FL.commission4 == '' || FL.commission4 == null))
                                    {   
                                        HB.commission4 = Decimal.valueOf(FL.commission4);
                                    }   
                                    HB.description = FL.description;
                                    HB.ecode = FL.ecode;
                                    HB.internetCoupon = FL.internetCoupon;
                                    HB.invoiceDiscountApplicable = FL.invoiceDiscountApplicable;
                                    HB.lineValue = FL.lineValue;
                                    HB.lockItemCode = FL.lockItemCode;
                                    if(!(FL.quantity == '' || FL.quantity == null))
                                    {   
                                        HB.quantity = Decimal.valueOf(FL.quantity);
                                    }
                                    
                                    HB.rate1 = new HomeBaseBeans.rates();
                                    HB.rate2 = new HomeBaseBeans.rates();
                                    HB.rate3 = new HomeBaseBeans.rates();
                                    HB.rate4 = new HomeBaseBeans.rates();
                                    HB.rate5 = new HomeBaseBeans.rates();
                                    HB.rate6 = new HomeBaseBeans.rates();
                                    HB.rate7 = new HomeBaseBeans.rates();
                                    HB.rate8 = new HomeBaseBeans.rates();
                                    
                                    HB.rate1.description = FL.rate1.description;
                                    HB.rate1.editable = FL.rate1.editable;
                                    HB.rate1.rate = FL.rate1.rate;
                                    
                                    HB.rate2.description = FL.rate2.description;
                                    HB.rate2.editable = FL.rate2.editable;
                                    HB.rate2.rate = FL.rate2.rate;
                                    
                                    HB.rate3.description = FL.rate3.description;
                                    HB.rate3.editable = FL.rate3.editable;
                                    HB.rate3.rate = FL.rate3.rate;
                                    
                                    HB.rate4.description = FL.rate4.description;
                                    HB.rate4.editable = FL.rate4.editable;
                                    HB.rate4.rate = FL.rate4.rate;
                                    
                                    HB.rate5.description = FL.rate5.description;
                                    HB.rate5.editable = FL.rate5.editable;
                                    HB.rate5.rate = FL.rate5.rate;
                                    
                                    HB.rate6.description = FL.rate6.description;
                                    HB.rate6.editable = FL.rate6.editable;
                                    HB.rate6.rate = FL.rate6.rate;
                                    
                                    HB.rate7.description = FL.rate7.description;
                                    HB.rate7.editable = FL.rate7.editable;
                                    HB.rate7.rate = FL.rate7.rate;
                                    
                                    HB.rate8.description = FL.rate8.description;
                                    HB.rate8.editable = FL.rate8.editable;
                                    HB.rate8.rate = FL.rate8.rate;
                                    
                                    HB.reference = FL.reference;                            
                                }
                            }
                        }
                        
                        if(!(EditResponse.rentalQuote.llw == '' || EditResponse.rentalQuote.llw == null))
                        {   
                            //fullQWrapper.LLWTotal = EditResponse.rentalQuote.llw;
                            fullQWrapper.LLWTotal = String.valueOf(Decimal.valueOf(EditResponse.rentalQuote.llw).setScale(2));
                        }
                                        
                        if(!(EditResponse.rentalQuote.other == '' || EditResponse.rentalQuote.other == null))
                        {   
                            fullQWrapper.otherInInvoicing = EditResponse.rentalQuote.other;
                        }
                        
                        if(!(EditResponse.rentalQuote.pickUp == '' || EditResponse.rentalQuote.pickUp == null))
                        {   
                            fullQWrapper.pickupCharge = EditResponse.rentalQuote.pickUp;
                        }
                    }
         }catch(Exception e){
             system.debug(LoggingLevel.ERROR,'Error while getting values from  FullQuoteHelper :assignRefreshValue: '+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting FullQuoteHelper :assignRefreshValue'+fullQWrapper);               
                                            
     }
     
     public void assingModificationValue(Full_Quote_Transactional__c fullQuote_tran,FullQuoteWrapper fullQWrapper, List<HomeBaseBeans.extras> ProductExtrasList,Integer summaryLineCount,
                                  List<HomeBaseBeans.quoteLine> summaryLineList,FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling,FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
                                   List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList, List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList){
        try{     
            if(fullQuote_tran != null){
                FullQuoteMainService fqService=new FullQuoteMainService();
                Set<id> productId = new Set<id>();
                List<Rate__c> rateList = new List<Rate__c>();
                List<Product_Extras__c> productList = fullQuote_tran.Product_Extras__r;
                List<Summary_Line__c> summaryList = fullQuote_tran.Summary_Lines__r;
                //summaryList = fullQuote_tran.Summary_Lines__r;
                List<Modification_Option_Transactional__c> modificaitonOptionList = fullQuote_tran.Modification_Option_Transactional__r;
                List<AnalysisSet__c> AnalysisSetsList= fullQuote_tran.AnalysisSets__r;
                List<AdditionalAnalysisSet__c> AdditionalAnalysisSetsList= fullQuote_tran.AdditionalAnalysisSets__r;
                 
                for(Product_Extras__c produId: productList){
                    productId.add(produId.id);
                }
                rateList = fqService.getRateListInfo(productId);
                
                
                for(Summary_Line__c  summRec : summaryList){
                }   
                for(Modification_Option_Transactional__c modificaitonReco : modificaitonOptionList){
                } 
                for(AnalysisSet__c analyRec : AnalysisSetsList){
                }
                for(AdditionalAnalysisSet__c AddinAnayRec : AdditionalAnalysisSetsList){
                }
            
                //fullQWrapper.selectedFullQUote = fullQuote_tran.type__c;
                //fullQWrapper.TransactionType = fullQuote_tran.transactionId__c; 
                fullQWrapper.sourceId=fullQuote_tran.SourceId__c;
                fullQWrapper.WriteUpRep = fullQuote_tran.salesRep1__c;
                fullQWrapper.WriteUpRepName = fullQuote_tran.salesRep1Name__c;
                fullQWrapper.AssistingRep = fullQuote_tran.salesRep2__c;
                fullQWrapper.AssistingRepName = fullQuote_tran.salesRep2Name__c;
                fullQWrapper.AccountId = fullQuote_tran.accountId__c;
                fullQWrapper.AccountName = fullQuote_tran.account_Name__c;
                fullQWrapper.POContact=fullQuote_tran.reference__c;
                fullQWrapper.QouteStatus = fullQuote_tran.status__c;
                fullQWrapper.QuoteTotal=fullQuote_tran.quoteTotal__c;
                fullQWrapper.TaxExemptAuthorization=fullQuote_tran.taxExemptAuthorisation__c;
                //fullQWrapper.POContact=fullQuote_tran.portalContact;
                // Billing address
                fullQWrapper.ID = fullQuote_tran.billingAddressId__c;   
                fullQWrapper.TaxExempt = fullQuote_tran.taxExempt__c;
                fullQWrapper.Status = fullQuote_tran.creditStatus__c;
                fullQWrapper.Address = fullQuote_tran.billingAddress_address1__c;
                fullQWrapper.City = fullQuote_tran.billingAddress_address3__c;
                fullQWrapper.Country = fullQuote_tran.billingAddress_countryId__c;
                fullQWrapper.County = fullQuote_tran.billingAddress_address4__c;
                fullQWrapper.State = fullQuote_tran.billingAddress_state__c;
                fullQWrapper.ZipCode = fullQuote_tran.billingAddress_zipCode__c;
                //For Edit FullQuote
                selectedVAddressInBilling.address1=fullQuote_tran.billingAddress_address1__c;
                selectedVAddressInBilling.address3=fullQuote_tran.billingAddress_address3__c;
                selectedVAddressInBilling.countryId=fullQuote_tran.billingAddress_countryId__c;
                fullQWrapper.crossStreetInShippingDates=fullQuote_tran.billingAddress_crossStreet1__c;
                fullQWrapper.crossStreet2InShippingDates=fullQuote_tran.billingAddress_crossStreet2__c;
                selectedVAddressInBilling.deliveryZone= fullQuote_tran.billingAddress_deliveryZone__c;
                selectedVAddressInBilling.distanceFromBranch=fullQuote_tran.billingAddress_distanceFromBranch__c;
                selectedVAddressInBilling.state=fullQuote_tran.billingAddress_state__c;
                selectedVAddressInBilling.zipCode=fullQuote_tran.billingAddress_zipCode__c;
                selectedVAddressInBilling.address2=fullQuote_tran.billingAddress_address2__c;
                selectedVAddressInBilling.address4 =fullQuote_tran.billingAddress_address4__c;
                selectedVAddressInBilling.fulfillingBranch=fullQuote_tran.billingAddress_fulfillingBranchId__c;
                selectedVAddressInBilling.fulfillingBranchName=fullQuote_tran.billingAddress_fulfillingBranchName__c;
                selectedVAddressInBilling.latitude=fullQuote_tran.billingAddress_latitude__c;
                selectedVAddressInBilling.longitude=fullQuote_tran.billingAddress_longitude__c;
                selectedVAddressInBilling.oldPostalCode=fullQuote_tran.billingAddress_oldPostalCode__c;
                selectedVAddressInBilling.taxId=fullQuote_tran.billingAddress_taxId__c;
                selectedVAddressInBilling.zoneWarning=fullQuote_tran.billingAddress_zoneWarning__c;
                // BillingContact Details
                fullQWrapper.BillingContactID = fullQuote_tran.BillingContactDetails_id__c;
                fullQWrapper.Name = fullQuote_tran.BillingContactDetails_name__c;
                fullQWrapper.telePhone=fullQuote_tran.BillingContactDetails_tel__c;
                fullQWrapper.Fax=fullQuote_tran.BillingContactDetails_fax__c;
                fullQWrapper.Email=fullQuote_tran.BillingContactDetails_email__c;
                // Shipping address
                fullQWrapper.shippingId = fullQuote_tran.shippingAddressId__c;
                fullQWrapper.AddressInShippingDates = fullQuote_tran.shippingAddress_address1__c;
                fullQWrapper.cityInShippingDates = fullQuote_tran.shippingAddress_address3__c;
                fullQWrapper.countryInShippingDates = fullQuote_tran.shippingAddress_countryId__c;
                fullQWrapper.countyInShippingDates = fullQuote_tran.shippingAddress_address4__c;
                fullQWrapper.stateInShippingDates = fullQuote_tran.shippingAddress_state__c;
                fullQWrapper.ZipCodeInShipping = fullQuote_tran.shippingAddress_zipCode__c;
                fullQWrapper.crossStreetInShippingDates = fullQuote_tran.shippingAddress_crossStreet1__c;
                fullQWrapper.crossStreet2InShippingDates = fullQuote_tran.shippingAddress_crossStreet2__c;
                fullQWrapper.deliveryZoneInShipping = fullQuote_tran.shippingAddress_deliveryZone__c;
                fullQWrapper.distFromBranch = fullQuote_tran.shippingAddress_distanceFromBranch__c;
                fullQWrapper.deliveryInstructions=fullQuote_tran.shippingInstructions__c;
                //for Edit Full Quote
                selectedVAddressInShipping.address1=fullQuote_tran.shippingAddress_address1__c;
                selectedVAddressInShipping.address3=fullQuote_tran.shippingAddress_address3__c;
                selectedVAddressInShipping.countryId=fullQuote_tran.shippingAddress_countryId__c;
                fullQWrapper.crossStreetInShippingDates=fullQuote_tran.shippingAddress_crossStreet1__c;
                fullQWrapper.crossStreet2InShippingDates=fullQuote_tran.shippingAddress_crossStreet2__c;
                selectedVAddressInShipping.deliveryZone= fullQuote_tran.shippingAddress_deliveryZone__c;
                selectedVAddressInShipping.distanceFromBranch=fullQuote_tran.shippingAddress_distanceFromBranch__c;
                selectedVAddressInShipping.state=fullQuote_tran.shippingAddress_state__c;
                selectedVAddressInShipping.zipCode=fullQuote_tran.shippingAddress_zipCode__c;
                selectedVAddressInShipping.address2=fullQuote_tran.shippingAddress_address2__c;
                selectedVAddressInShipping.address4=fullQuote_tran.shippingAddress_address4__c;
                selectedVAddressInShipping.fulfillingBranch=fullQuote_tran.shippingAddress_fulfillingBranchId__c;
                selectedVAddressInShipping.fulfillingBranchName=fullQuote_tran.shippingAddress_fulfillingBranchName__c;
                selectedVAddressInShipping.latitude=fullQuote_tran.shippingAddress_latitude__c;
                selectedVAddressInShipping.longitude=fullQuote_tran.shippingAddress_longitude__c;
                selectedVAddressInShipping.oldPostalCode=fullQuote_tran.shippingAddress_oldPostalCode__c;
                selectedVAddressInShipping.taxId=fullQuote_tran.shippingAddress_taxId__c;
                selectedVAddressInShipping.zoneWarning=fullQuote_tran.shippingAddress_zoneWarning__c;
                
                if(fullQuote_tran.shippingAddress_fulfillingBranchId__c!=null && fullQuote_tran.shippingAddress_fulfillingBranchId__c!=''){
                    fullQWrapper.userBranchId=fullQuote_tran.shippingAddress_fulfillingBranchId__c;
                    fullQWrapper.fulFillingBranchInShippingDates=fullQuote_tran.shippingAddress_fulfillingBranchId__c;
                }else{
                    fullQWrapper.userBranchId=fullQuote_tran.branchId__c;
                }
                fullQWrapper.fulFillingBranchNameInShippingDates=fullQuote_tran.shippingAddress_fulfillingBranchName__c;
                // ShippingContact Details
                fullQWrapper.deliveryContactId = fullQuote_tran.ShippingContactDetails_id__c;
                fullQWrapper.NameInShippingDates1 = fullQuote_tran.ShippingContactDetails_name__c;
                fullQWrapper.telInShippingDates=fullQuote_tran.ShippingContactDetails_tel__c;
                fullQWrapper.faxInShippingDates=fullQuote_tran.ShippingContactDetails_fax__c;
                fullQWrapper.emailInShippingDates=fullQuote_tran.ShippingContactDetails_email__c;
                if(!(fullQuote_tran.accessories__c == '' || fullQuote_tran.accessories__c == null))
                {   
                    fullQWrapper.Accessories = fullQuote_tran.accessories__c;
                }
                if(fullQuote_tran.rentalCharge__c != '' && fullQuote_tran.rentalCharge__c != null){
                    fullQWrapper.RentalCharge = fullQuote_tran.rentalCharge__c;
                }
                if(fullQuote_tran.totalCodAmount__c != '' && fullQuote_tran.totalCodAmount__c != null){
                    fullQWrapper.TotalCODAmount = fullQuote_tran.totalCodAmount__c;
                }
                if(fullQuote_tran.tax__c != '' && fullQuote_tran.tax__c != null){
                    fullQWrapper.TaxTotal = fullQuote_tran.tax__c;
                }
                if(fullQuote_tran.pickUp__c != '' && fullQuote_tran.pickUp__c != null){
                    fullQWrapper.PPETotal = fullQuote_tran.pickUp__c;
                }
                if(fullQuote_tran.hireTerms__c!= '' && fullQuote_tran.hireTerms__c!= null){
                    fullQWrapper.Terms = fullQuote_tran.hireTerms__c;
                }
                if(fullQuote_tran.invoicedBalance__c!= '' && fullQuote_tran.invoicedBalance__c!= null){
                    fullQWrapper.InvoicedBalance= fullQuote_tran.invoicedBalance__c;
                }
                if(fullQuote_tran.ytdSales__c!= '' && fullQuote_tran.ytdSales__c!= null){
                    fullQWrapper.YTDSales = fullQuote_tran.ytdSales__c;
                }
                if(fullQuote_tran.termsCode__c!= '' && fullQuote_tran.termsCode__c!= null){
                    fullQWrapper.TermsCode = fullQuote_tran.termsCode__c;
                }
                fullQWrapper.CertofInsurance = fullQuote_tran.certificateOfInsurance__c;
                if(!(fullQuote_tran.codAmount__c == '' || fullQuote_tran.codAmount__c == null))
                {   
                    fullQWrapper.CODAmount = fullQuote_tran.codAmount__c; 
                }
                fullQWrapper.CreditApproval = fullQuote_tran.creditApproval__c;
                if(!(fullQuote_tran.delivery__c == '' || fullQuote_tran.delivery__c == null))
                {   
                    fullQWrapper.DeliveryInInvoicing = fullQuote_tran.delivery__c;
                }
                if(!(fullQuote_tran.lastInvoiceDate__c == '' || fullQuote_tran.lastInvoiceDate__c == null))
                {   
                     fullQWrapper.LastInvoice= fullQuote_tran.lastInvoiceDate__c;
                }
                if(!(fullQuote_tran.llw__c == '' || fullQuote_tran.llw__c == null))
                {   
                    fullQWrapper.LLWTotal = fullQuote_tran.llw__c;
                }
                if(!(fullQuote_tran.other__c == '' || fullQuote_tran.other__c == null))
                {   
                    fullQWrapper.otherInInvoicing = fullQuote_tran.other__c;
                }
                
                if(!(fullQuote_tran.pickUp__c == '' || fullQuote_tran.pickUp__c == null))
                {   
                    fullQWrapper.pickupCharge = fullQuote_tran.pickUp__c;
                }
                fullQWrapper.ModificationComments = fullQuote_tran.Modification_Comments__c;
                fullQWrapper.ApproverComments = fullQuote_tran.Approver_Comments__c;
                fullQWrapper.SelectedShipingTaxId = fullQuote_tran.shippingAddress_taxId__c;
                
               /* for(AnalysisSet__c analyRec : AnalysisSetsList){

                   HomeBaseBeans.AnalysisSetHeaders as1=new HomeBaseBeans.AnalysisSetHeaders();
                     
                        as1.id=analyRec.Header_id__c;
                        as1.description=analyRec.Header_description__c;
                        as1.selectedId=analyRec.Selection_id__c;
                        as1.selectedDescription=analyRec.Selection_description__c;
                        analysisSetHeaderResponseList.add(as1);
  
                }*/
               /* 
                 HomeBaseBeans.AnalysisSetHeaders as2=new HomeBaseBeans.AnalysisSetHeaders();
                  
                     as2.id='102';
                     as2.description='Ad Source';
                     as2.selectedId='ACQ';
                     as2.selectedDescription='Acquistion';
                     analysisSetHeaderResponseList.add(as2);
                 
                for(AdditionalAnalysisSet__c AddinAnayRec : AdditionalAnalysisSetsList){
                    HomeBaseBeans.AnalysisSetHeaders as6=new HomeBaseBeans.AnalysisSetHeaders();
                  
                        as6.id=AddinAnayRec.Header_id__c;
                        as6.description=AddinAnayRec.Header_description__c;
                        as6.selectedId=AddinAnayRec.Selection_id__c;
                        as6.selectedDescription=AddinAnayRec.Selection_description__c;
                        analysisSetHeaderResponseShippingList.add(as6);

                    }
                    */
                    
          
                    for(Summary_Line__c  sumRed: summaryList){
                        HomeBaseBeans.quoteLine HB = new HomeBaseBeans.quoteLine();
                            if(!(sumRed.commission1__c == '' || sumRed.commission1__c == null))
                            {   
                                HB.commission1 = Decimal.valueOf(sumRed.commission1__c);
                            }
                            if(!(sumRed.commission2__c == '' || sumRed.commission2__c == null))
                            {   
                                HB.commission2 = Decimal.valueOf(sumRed.commission2__c);
                            }
                            if(!(sumRed.commission3__c == '' || sumRed.commission3__c == null))
                            {   
                                HB.commission3 = Decimal.valueOf(sumRed.commission3__c);
                            }
                            if(!(sumRed.commission4__c == '' || sumRed.commission4__c == null))
                            {   
                                HB.commission4 = Decimal.valueOf(sumRed.commission4__c);
                            }
                            if(sumRed.lineId__c != null && sumRed.lineId__c != ''){
                                HB.lineId = sumRed.lineId__c;
                            }
                            HB.removeLine = 'false';
                            HB.lineCount=Integer.valueOf(sumRed.Sequence__c);
                            HB.description = sumRed.description__c;
                            HB.ecode = sumRed.ecode__c;
                            HB.internetCoupon = sumRed.internetCoupon__c;
                            HB.invoiceDiscountApplicable = sumRed.invoiceDiscountApplicable__c;
                            HB.lineValue = sumRed.lineValue__c;
                            HB.LockTypeTotal=Decimal.valueOf(sumRed.lineValue__c);
                            HB.itemId = sumRed.itemId__c;   
                            if(sumRed.NetBookValue__c!=null){
                            HB.netBookValue=Decimal.valueOf(sumRed.NetBookValue__c);
                            }
                            HB.chargeCode = new HomeBaseBeans.chargeCodes();
                            if(sumRed.ChargeCode_id__c != null && sumRed.ChargeCode_id__c != ''){
                                HB.chargeCode.id = sumRed.ChargeCode_id__c;
                            }
                            if(sumRed.ChargeCode_description__c != null && sumRed.ChargeCode_description__c != ''){
                                HB.chargeCode.description = sumRed.ChargeCode_description__c;
                            }
                            HB.chargeCode.active = sumRed.ChargeCode_active__c;
                            if(sumRed.price__c!=null && sumRed.price__c!=''){
                                HB.price=Decimal.valueOf(sumRed.price__c);
                            }
                            HB.lockItemCode = String.valueOf(sumRed.lockItemCode__c);
                            if(!(sumRed.quantity__c == '' || sumRed.quantity__c == null))
                            {   
                                HB.quantity = Decimal.valueOf(sumRed.quantity__c);
                            }
                            
                            summaryLineList.add(HB);
                    }
                  
                //ProductExtrasList = new List<HomeBaseBeans.extras>();
        
                for(Product_Extras__c produId : productList){
                    HomeBaseBeans.extras HB = new HomeBaseBeans.extras();
                    HB.id = produId.id__c;
                    HB.description = produId.description__c;
                    if(!(produId.quantity__c == '' || produId.quantity__c == null))
                    {   
                        HB.quantity = produId.quantity__c;
                    }
                    HB.include = produId.include__c;
                    HB.mandatory = produId.mandatory__c;
                    if(!(produId.price__c == '' || produId.price__c == null))
                    {   
                        HB.price = produId.price__c; 
                    }
                    HB.priceEditable = produId.priceEditable__c;
                    HB.quantityEditable = produId.quantityEditable__c;
                    HB.quantityRequired = produId.quantityRequired__c;
                    if(!(produId.total__c == '' || produId.total__c == null))
                    {   
                        HB.total = produId.total__c;
                    }
                    
                    
                           HB.rate1 = new HomeBaseBeans.rates(); 
                            HB.rate2 = new HomeBaseBeans.rates();
                            HB.rate3 = new HomeBaseBeans.rates();
                            HB.rate4 = new HomeBaseBeans.rates();
                            HB.rate5 = new HomeBaseBeans.rates();
                            HB.rate6 = new HomeBaseBeans.rates();
                            HB.rate7 = new HomeBaseBeans.rates();
                            HB.rate8 = new HomeBaseBeans.rates();
                    
                    for(Rate__c rate : rateList){
                        
                        if(rate.Product_Extras__c == produId.Id){
                            if(Integer.valueOf(rate.Sequence__c)==1){
                                if(rate.description__c!=null){
                                     HB.rate1.description=rate.description__c;
                                }
                              
                               HB.rate1.rate=rate.rate__c;
                               HB.rate1.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==2){
                                if(rate.description__c!=null){
                                    HB.rate2.description=rate.description__c;
                                }
                               HB.rate2.rate=rate.rate__c;
                               HB.rate2.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==3){
                            if(rate.description__c!=null){
                               HB.rate3.description=rate.description__c;
                            }
                               HB.rate3.rate=rate.rate__c;
                               HB.rate3.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==4){
                              if(rate.description__c!=null){
                                  HB.rate4.description=rate.description__c;
                               }
                               HB.rate4.rate=rate.rate__c;
                               HB.rate4.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==5){
                                if(rate.description__c!=null){
                                    HB.rate5.description=rate.description__c;
                                }
                               HB.rate5.rate=rate.rate__c;
                               HB.rate5.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==6){
                                
                                if(rate.description__c!=null){
                                  HB.rate6.description=rate.description__c;
                                }
                               HB.rate6.rate=rate.rate__c;
                               HB.rate6.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==7){
                                if(rate.description__c!=null){
                                   HB.rate7.description=rate.description__c;
                                }
                               HB.rate7.rate=rate.rate__c;
                               HB.rate7.editable=rate.editable__c;
                            }
                            if(Integer.valueOf(rate.Sequence__c)==8){
                                if(rate.description__c!=null){
                                  HB.rate8.description=rate.description__c;
                                }
                               HB.rate8.rate=rate.rate__c;
                               HB.rate8.editable=rate.editable__c;
                            }

                        }
                    }
                    ProductExtrasList.add(HB);
                }
            }
         }catch(Exception e){
             system.debug(LoggingLevel.ERROR,'Error while getting values from  FullQuoteHelper :assignEditValue: '+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting FullQuoteHelper :assignEditValue'+fullQWrapper);
                                   
    }
    
     
     public void assignEditValue(EditFullQUoteService_AC EditResponse,FullQuoteWrapper fullQWrapper, List<HomeBaseBeans.extras> ProductExtrasList,Integer summaryLineCount,
                                  List<HomeBaseBeans.quoteLine> summaryLineList,FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling,FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
                                   List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList, List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList){
                                
                system.debug(LoggingLevel.DEBUG,'Entering FullQuoteHelper :assignEditValue'+ProductExtrasList+summaryLineList+analysisSetHeaderResponseList+analysisSetHeaderResponseShippingList+EditResponse);                            
                try{                                
                fullQWrapper.TransactionType = EditResponse.rentalQuote.transactionId; 
                fullQWrapper.WriteUpRep = EditResponse.rentalQuote.salesRep1;
                fullQWrapper.WriteUpRepName = EditResponse.rentalQuote.salesRep1Name;
                fullQWrapper.AssistingRep = EditResponse.rentalQuote.salesRep2;
                fullQWrapper.AssistingRepName = EditResponse.rentalQuote.salesRep2Name;
                fullQWrapper.JoborLocation =  EditResponse.rentalQuote.narrative1;
                fullQWrapper.AccountId = EditResponse.rentalQuote.accountId;
                fullQWrapper.POContact=EditResponse.rentalQuote.reference;
                fullQWrapper.QouteStatus = EditResponse.rentalQuote.status;
                
                 fullQWrapper.TaxExemptAuthorization=EditResponse.rentalQuote.taxExemptAuthorisation;
                
                //fullQWrapper.POContact=EditResponse.rentalQuote.portalContact;
                
                // Billing address
                
                fullQWrapper.ID = EditResponse.rentalQuote.billingAddressId;    
                fullQWrapper.TaxExempt = EditResponse.rentalQuote.taxExempt;
                fullQWrapper.Status = EditResponse.rentalQuote.creditStatus;
      
                fullQWrapper.Address = EditResponse.rentalQuote.billingAddress.address1;
                fullQWrapper.City = EditResponse.rentalQuote.billingAddress.address3;
                fullQWrapper.Country = EditResponse.rentalQuote.billingAddress.countryId;
                fullQWrapper.County = EditResponse.rentalQuote.billingAddress.address4;
                fullQWrapper.State = EditResponse.rentalQuote.billingAddress.state;
                fullQWrapper.ZipCode = EditResponse.rentalQuote.billingAddress.zipCode;
                fullQWrapper.deliveryInstructions = EditResponse.rentalQuote.shippingInstructions;
                fullQWrapper.CODInstructions = EditResponse.rentalQuote.instructionText;
                //For Edit FullQuote
                
                selectedVAddressInBilling.address1=EditResponse.rentalQuote.billingAddress.address1;
                selectedVAddressInBilling.address3=EditResponse.rentalQuote.billingAddress.address3;
                selectedVAddressInBilling.countryId=EditResponse.rentalQuote.billingAddress.countryId;
                fullQWrapper.crossStreetInShippingDates=EditResponse.rentalQuote.billingAddress.crossStreet1;
                fullQWrapper.crossStreet2InShippingDates=EditResponse.rentalQuote.billingAddress.crossStreet2;
                selectedVAddressInBilling.deliveryZone= EditResponse.rentalQuote.billingAddress.deliveryZone;
                selectedVAddressInBilling.distanceFromBranch=EditResponse.rentalQuote.billingAddress.distanceFromBranch;
                selectedVAddressInBilling.state=EditResponse.rentalQuote.billingAddress.state;
                selectedVAddressInBilling.zipCode=EditResponse.rentalQuote.billingAddress.zipCode;
                selectedVAddressInBilling.address2=EditResponse.rentalQuote.billingAddress.address2;
                selectedVAddressInBilling.address4 =EditResponse.rentalQuote.billingAddress.address4;
                selectedVAddressInBilling.fulfillingBranch=EditResponse.rentalQuote.billingAddress.fulfillingBranchId;
                selectedVAddressInBilling.fulfillingBranchName=EditResponse.rentalQuote.billingAddress.fulfillingBranchName;
                selectedVAddressInBilling.latitude=EditResponse.rentalQuote.billingAddress.latitude;
                selectedVAddressInBilling.longitude=EditResponse.rentalQuote.billingAddress.longitude;
                selectedVAddressInBilling.oldPostalCode=EditResponse.rentalQuote.billingAddress.oldPostalCode;
                //selectedVAddressInBilling.taxId=EditResponse.rentalQuote.billingAddress.taxId;
                selectedVAddressInBilling.zoneWarning=EditResponse.rentalQuote.billingAddress.zoneWarning;
                
                //
                
                // BillingContact Details
                
                fullQWrapper.BillingContactID = EditResponse.rentalQuote.billingContactDetails.id;
                fullQWrapper.Name = EditResponse.rentalQuote.billingContactDetails.name;
                fullQWrapper.telePhone=EditResponse.rentalQuote.billingContactDetails.tel;
                fullQWrapper.Fax=EditResponse.rentalQuote.billingContactDetails.fax;
                fullQWrapper.Email=EditResponse.rentalQuote.billingContactDetails.email;
                
                // Shipping address
                
                fullQWrapper.shippingId = EditResponse.rentalQuote.shippingAddressId;
                fullQWrapper.AddressInShippingDates = EditResponse.rentalQuote.shippingAddress.address1;
                fullQWrapper.cityInShippingDates = EditResponse.rentalQuote.shippingAddress.address3;
                fullQWrapper.countryInShippingDates = EditResponse.rentalQuote.shippingAddress.countryId;
                fullQWrapper.countyInShippingDates = EditResponse.rentalQuote.shippingAddress.address4;
                fullQWrapper.stateInShippingDates = EditResponse.rentalQuote.shippingAddress.state;
                fullQWrapper.ZipCodeInShipping = EditResponse.rentalQuote.shippingAddress.zipCode;
                fullQWrapper.crossStreetInShippingDates = EditResponse.rentalQuote.shippingAddress.crossStreet1;
                fullQWrapper.crossStreet2InShippingDates = EditResponse.rentalQuote.shippingAddress.crossStreet2;
                fullQWrapper.deliveryZoneInShipping = EditResponse.rentalQuote.shippingAddress.deliveryZone;
                fullQWrapper.distFromBranch = EditResponse.rentalQuote.shippingAddress.distanceFromBranch;
                
                
                //for Edit Full Quote
                selectedVAddressInShipping.address1=EditResponse.rentalQuote.shippingAddress.address1;
                selectedVAddressInShipping.address3=EditResponse.rentalQuote.shippingAddress.address3;
                selectedVAddressInShipping.countryId=EditResponse.rentalQuote.shippingAddress.countryId;
                fullQWrapper.crossStreetInShippingDates=EditResponse.rentalQuote.shippingAddress.crossStreet1;
                fullQWrapper.crossStreet2InShippingDates=EditResponse.rentalQuote.shippingAddress.crossStreet2;
                selectedVAddressInShipping.deliveryZone= EditResponse.rentalQuote.shippingAddress.deliveryZone;
                selectedVAddressInShipping.distanceFromBranch=EditResponse.rentalQuote.shippingAddress.distanceFromBranch;
                selectedVAddressInShipping.state=EditResponse.rentalQuote.shippingAddress.state;
                selectedVAddressInShipping.zipCode=EditResponse.rentalQuote.shippingAddress.zipCode;
                selectedVAddressInShipping.address2=EditResponse.rentalQuote.shippingAddress.address2;
                selectedVAddressInShipping.address4=EditResponse.rentalQuote.shippingAddress.address4;
                selectedVAddressInShipping.fulfillingBranch=EditResponse.rentalQuote.shippingAddress.fulfillingBranchId;
                selectedVAddressInShipping.fulfillingBranchName=EditResponse.rentalQuote.shippingAddress.fulfillingBranchName;
                selectedVAddressInShipping.latitude=EditResponse.rentalQuote.shippingAddress.latitude;
                selectedVAddressInShipping.longitude=EditResponse.rentalQuote.shippingAddress.longitude;
                selectedVAddressInShipping.oldPostalCode=EditResponse.rentalQuote.shippingAddress.oldPostalCode;
                selectedVAddressInShipping.taxId = EditResponse.rentalQuote.shippingAddress.taxId;
                fullQWrapper.SelectedShipingTaxId = EditResponse.rentalQuote.shippingAddress.taxId;
                
                selectedVAddressInShipping.zoneWarning=EditResponse.rentalQuote.shippingAddress.zoneWarning;
                fullQWrapper.rentalLength = EditResponse.rentalQuote.rentalLength;
                
                if(EditResponse.rentalQuote.shippingAddress.fulfillingBranchId!=null && EditResponse.rentalQuote.shippingAddress.fulfillingBranchId!=''){
                    fullQWrapper.userBranchId=EditResponse.rentalQuote.shippingAddress.fulfillingBranchId;
                    fullQWrapper.fulFillingBranchInShippingDates=EditResponse.rentalQuote.shippingAddress.fulfillingBranchId;
                }else{
                    fullQWrapper.userBranchId=EditResponse.rentalQuote.branchId;
                }
                
                
                fullQWrapper.fulFillingBranchNameInShippingDates=EditResponse.rentalQuote.shippingAddress.fulfillingBranchName;
                
                // ShippingContact Details
                
                fullQWrapper.deliveryContactId = EditResponse.rentalQuote.shippingContactDetails.id;
                fullQWrapper.NameInShippingDates1 = EditResponse.rentalQuote.shippingContactDetails.name;
                
                fullQWrapper.telInShippingDates=EditResponse.rentalQuote.shippingContactDetails.tel;
                fullQWrapper.faxInShippingDates=EditResponse.rentalQuote.shippingContactDetails.fax;
                fullQWrapper.emailInShippingDates=EditResponse.rentalQuote.shippingContactDetails.email;
                
                if(!(EditResponse.rentalQuote.accessories == '' || EditResponse.rentalQuote.accessories == null))
                {   
                    fullQWrapper.Accessories = EditResponse.rentalQuote.accessories;
                }
                if(EditResponse.rentalQuote.rentalCharge != '' && EditResponse.rentalQuote.rentalCharge != null){
                    fullQWrapper.RentalCharge = EditResponse.rentalQuote.rentalCharge;
                }
                if(EditResponse.rentalQuote.totalCodAmount != '' && EditResponse.rentalQuote.totalCodAmount != null){
                    fullQWrapper.TotalCODAmount = EditResponse.rentalQuote.totalCodAmount;
                }
                    
                if(EditResponse.rentalQuote.tax != '' && EditResponse.rentalQuote.tax != null){
                    fullQWrapper.TaxTotal = EditResponse.rentalQuote.tax;
                }
                
                if(EditResponse.rentalQuote.hireTerms!= '' && EditResponse.rentalQuote.hireTerms!= null){
                    fullQWrapper.Terms = EditResponse.rentalQuote.hireTerms;
                }
                //---------------TFS 2870---------------------------------------------------------------------
                if(EditResponse.rentalQuote.hireNotes!= '' && EditResponse.rentalQuote.hireNotes!= null){
                    fullQWrapper.hireNotes = EditResponse.rentalQuote.hireNotes;
                }
                //---------------TFS 2870---------------------------------------------------------------------
                if(EditResponse.rentalQuote.salesTerms!= '' && EditResponse.rentalQuote.salesTerms!= null){
                    fullQWrapper.Terms = EditResponse.rentalQuote.salesTerms;
                }
                
                if(EditResponse.rentalQuote.invoicedBalance!= '' && EditResponse.rentalQuote.invoicedBalance!= null){
                    fullQWrapper.InvoicedBalance= EditResponse.rentalQuote.invoicedBalance;
                }
                
                if(EditResponse.rentalQuote.ytdSales!= '' && EditResponse.rentalQuote.ytdSales!= null){
                    fullQWrapper.YTDSales = EditResponse.rentalQuote.ytdSales;
                }
                
                if(EditResponse.rentalQuote.termsCode!= '' && EditResponse.rentalQuote.termsCode!= null){
                    fullQWrapper.TermsCode = EditResponse.rentalQuote.termsCode;
                }


                fullQWrapper.CertofInsurance = EditResponse.rentalQuote.certificateOfInsurance;
                if(!(EditResponse.rentalQuote.codAmount == '' || EditResponse.rentalQuote.codAmount == null))
                {   
                    fullQWrapper.CODAmount = EditResponse.rentalQuote.codAmount; 
                }
                fullQWrapper.CreditApproval = EditResponse.rentalQuote.creditApproval;
                
                if(!(EditResponse.rentalQuote.delivery == '' || EditResponse.rentalQuote.delivery == null))
                {   
                    fullQWrapper.DeliveryInInvoicing = EditResponse.rentalQuote.delivery;
                }
                
                
                if(!(EditResponse.rentalQuote.lastInvoiceDate == '' || EditResponse.rentalQuote.lastInvoiceDate == null))
                {   
                     fullQWrapper.LastInvoice= EditResponse.rentalQuote.lastInvoiceDate;
                }
                
                if(!(EditResponse.rentalQuote.tax == '' || EditResponse.rentalQuote.tax == null)){
                            fullQWrapper.taxInvoice = EditResponse.rentalQuote.tax;
                }
                
                if(!(EditResponse.rentalQuote.orderTotal == '' || EditResponse.rentalQuote.orderTotal == null)){
                            fullQWrapper.totalInvoice = EditResponse.rentalQuote.orderTotal;
                }
                if(!(EditResponse.rentalQuote.extrasTotal == '' || EditResponse.rentalQuote.extrasTotal == null)){
                        fullQWrapper.extrasInvoice = EditResponse.rentalQuote.extrasTotal;
                }
                fullQWrapper.unitPriceInvoice = EditResponse.rentalQuote.orderGoods;
                if(EditResponse.rentalQuote.type != 'sales'){
                    fullQWrapper.rentalLengthInProduct = EditResponse.rentalQuote.rentalLength;
                }
                 
                 HomeBaseBeans.AnalysisSetHeaders as1=new HomeBaseBeans.AnalysisSetHeaders();
                 if(EditResponse.rentalQuote.analysisSet1!=null){
                     as1.id=EditResponse.rentalQuote.analysisSet1.header.id;
                     as1.description=EditResponse.rentalQuote.analysisSet1.header.description;
                     as1.selectedId=EditResponse.rentalQuote.analysisSet1.selection.id;
                     as1.selectedDescription=EditResponse.rentalQuote.analysisSet1.selection.description;
                     analysisSetHeaderResponseList.add(as1);
                 }
                 
                
                 HomeBaseBeans.AnalysisSetHeaders as2=new HomeBaseBeans.AnalysisSetHeaders();
                  if(EditResponse.rentalQuote.analysisSet2!=null){
                     as2.id=EditResponse.rentalQuote.analysisSet2.header.id;
                     as2.description=EditResponse.rentalQuote.analysisSet2.header.description;
                     as2.selectedId=EditResponse.rentalQuote.analysisSet2.selection.id;
                     as2.selectedDescription=EditResponse.rentalQuote.analysisSet2.selection.description;
                     analysisSetHeaderResponseList.add(as2);
                  }
                 HomeBaseBeans.AnalysisSetHeaders as3=new HomeBaseBeans.AnalysisSetHeaders();
                 if(EditResponse.rentalQuote.analysisSet3!=null){
                     as3.id=EditResponse.rentalQuote.analysisSet3.header.id;
                     as3.description=EditResponse.rentalQuote.analysisSet3.header.description;
                     as3.selectedId = EditResponse.rentalQuote.analysisSet3.selection.id;
                     as3.selectedDescription=EditResponse.rentalQuote.analysisSet3.selection.description;
                     analysisSetHeaderResponseList.add(as3);
                 }
                 
                 HomeBaseBeans.AnalysisSetHeaders as4=new HomeBaseBeans.AnalysisSetHeaders();
                 if(EditResponse.rentalQuote.analysisSet4!=null){
                     as4.id=EditResponse.rentalQuote.analysisSet4.header.id;
                     as4.description=EditResponse.rentalQuote.analysisSet4.header.description;
                     as4.selectedId=EditResponse.rentalQuote.analysisSet4.selection.id;
                     as4.selectedDescription=EditResponse.rentalQuote.analysisSet4.selection.description;
                     analysisSetHeaderResponseList.add(as4);
                 }
                 
                 HomeBaseBeans.AnalysisSetHeaders as9=new HomeBaseBeans.AnalysisSetHeaders();
                  if(EditResponse.rentalQuote.analysisSet5!=null){
                     as9.id=EditResponse.rentalQuote.analysisSet5.header.id;
                     as9.description=EditResponse.rentalQuote.analysisSet5.header.description;
                     as9.selectedId=EditResponse.rentalQuote.analysisSet5.selection.id;
                     as9.description=EditResponse.rentalQuote.analysisSet5.selection.description;
                     as9.Longdescription=EditResponse.rentalQuote.analysisSet5.selection.Longdescription;
                     analysisSetHeaderResponseList.add(as9);
                  }
                 
                 HomeBaseBeans.AnalysisSetHeaders as5=new HomeBaseBeans.AnalysisSetHeaders();
                 if(EditResponse.rentalQuote.additionalAnalysisSet1!=null){
                    
                     as5.id=EditResponse.rentalQuote.additionalAnalysisSet1.header.id;
                     as5.description=EditResponse.rentalQuote.additionalAnalysisSet1.header.description;
                     as5.selectedId=EditResponse.rentalQuote.additionalAnalysisSet1.selection.id;
                     as5.selectedDescription=EditResponse.rentalQuote.additionalAnalysisSet1.selection.description;
                     analysisSetHeaderResponseShippingList.add(as5);
                 }
                 
                 HomeBaseBeans.AnalysisSetHeaders as6=new HomeBaseBeans.AnalysisSetHeaders();
                  if(EditResponse.rentalQuote.additionalAnalysisSet2!=null){
                     as6.id=EditResponse.rentalQuote.additionalAnalysisSet2.header.id;
                     as6.description=EditResponse.rentalQuote.additionalAnalysisSet2.header.description;
                     as6.selectedId=EditResponse.rentalQuote.additionalAnalysisSet2.selection.id;
                     as6.selectedDescription=EditResponse.rentalQuote.additionalAnalysisSet2.selection.description;
                     analysisSetHeaderResponseShippingList.add(as6);
                  }
                  
                 HomeBaseBeans.AnalysisSetHeaders as7=new HomeBaseBeans.AnalysisSetHeaders();
                  if(EditResponse.rentalQuote.additionalAnalysisSet3!=null){
                     as7.id=EditResponse.rentalQuote.additionalAnalysisSet3.header.id;
                     as7.description=EditResponse.rentalQuote.additionalAnalysisSet3.header.description;
                     as7.selectedId=EditResponse.rentalQuote.additionalAnalysisSet3.selection.id;
                     as7.selectedDescription=EditResponse.rentalQuote.additionalAnalysisSet3.selection.description;
                     analysisSetHeaderResponseShippingList.add(as7);
                  }
                 
                 HomeBaseBeans.AnalysisSetHeaders as8=new HomeBaseBeans.AnalysisSetHeaders();
                  if(EditResponse.rentalQuote.additionalAnalysisSet4!=null){
                     as8.id=EditResponse.rentalQuote.additionalAnalysisSet4.header.id;
                     as8.description=EditResponse.rentalQuote.additionalAnalysisSet4.header.description;
                     as8.selectedId=EditResponse.rentalQuote.additionalAnalysisSet4.selection.id;
                     as8.selectedDescription=EditResponse.rentalQuote.additionalAnalysisSet4.selection.description;
                     analysisSetHeaderResponseShippingList.add(as8);
                  }
                 
                 HomeBaseBeans.AnalysisSetHeaders as10=new HomeBaseBeans.AnalysisSetHeaders();
                  if(EditResponse.rentalQuote.additionalAnalysisSet5!=null){
                     as10.id=EditResponse.rentalQuote.additionalAnalysisSet5.header.id;
                     as10.description=EditResponse.rentalQuote.additionalAnalysisSet5.header.description;
                     as10.selectedId=EditResponse.rentalQuote.additionalAnalysisSet5.selection.id;
                     as10.selectedDescription=EditResponse.rentalQuote.additionalAnalysisSet5.selection.description;
                     analysisSetHeaderResponseShippingList.add(as10);
                  }
                 
  
                
                
                //for(HomeBaseBeans.quoteLine HB : summaryLineList)
                //{
                    for(EditFullQUoteService_AC.Lines FL : EditResponse.rentalQuote.lines )
                    {
                        HomeBaseBeans.quoteLine HB = new HomeBaseBeans.quoteLine();
                    //  if(HB.itemId == FL.itemId ){
                            if(!(FL.commission1 == '' || FL.commission1 == null))
                            {   
                                HB.commission1 = Decimal.valueOf(FL.commission1);
                            }
                            if(!(FL.commission2 == '' || FL.commission2 == null))
                            {   
                                HB.commission2 = Decimal.valueOf(FL.commission2);
                            }
                            if(!(FL.commission3 == '' || FL.commission3 == null))
                            {   
                                HB.commission3 = Decimal.valueOf(FL.commission3);
                            }
                            if(!(FL.commission4 == '' || FL.commission4 == null))
                            {   
                                HB.commission4 = Decimal.valueOf(FL.commission4);
                            }   
                            HB.description = FL.description;
                            HB.ecode = FL.ecode;
                            HB.internetCoupon = FL.internetCoupon;
                            HB.invoiceDiscountApplicable = FL.invoiceDiscountApplicable;
                            HB.lineValue = FL.lineValue;
                            HB.LockTypeTotal=Decimal.valueOf(FL.lineValue);
                            HB.lineId = FL.lineId;
                            HB.itemId = FL.itemId;  
                            HB.removeLine = FL.removeLine;
                            if(EditResponse.rentalQuote.type != 'sales'){
                                HB.chargeCode = new HomeBaseBeans.chargeCodes();
                                 
                                
                                if(FL.chargeCode.Id != null && FL.chargeCode.Id != ''){
                                    
                                    HB.chargeCode.id = FL.chargeCode.Id;
                            
                                }
                                
                                if(FL.chargeCode.description != null && FL.chargeCode.description != ''){
                                
                                    HB.chargeCode.description = FL.chargeCode.description;
                                }
                    
                                HB.chargeCode.active = FL.chargeCode.active;
                            }
                            
                            if(FL.price!=null && FL.price!=''){
                                HB.price=Decimal.valueOf(FL.price);
                            }
                            HB.lineCount = summaryLineCount;
                            summaryLineCount = summaryLineCount + 1;
                            HB.lockItemCode = String.valueOf(FL.lockItemCode);
                            if(!(FL.quantity == '' || FL.quantity == null))
                            {   
                                HB.quantity = Decimal.valueOf(FL.quantity).setScale(2);
                            }
                            
                            if(EditResponse.rentalQuote.type != 'sales'){
                                HB.rate1 = new HomeBaseBeans.rates(); 
                                HB.rate2 = new HomeBaseBeans.rates();
                                HB.rate3 = new HomeBaseBeans.rates();
                                HB.rate4 = new HomeBaseBeans.rates();
                                HB.rate5 = new HomeBaseBeans.rates();
                                HB.rate6 = new HomeBaseBeans.rates();
                                HB.rate7 = new HomeBaseBeans.rates();
                                HB.rate8 = new HomeBaseBeans.rates();
                                
                                HB.rate1.description = FL.rate1.description;
                                HB.rate1.editable = FL.rate1.editable;
                                HB.rate1.rate = FL.rate1.rate;
                                
                                HB.rate2.description = FL.rate2.description;
                                HB.rate2.editable = FL.rate2.editable;
                                HB.rate2.rate = FL.rate2.rate;
                                
                                HB.rate3.description = FL.rate3.description;
                                HB.rate3.editable = FL.rate3.editable;
                                HB.rate3.rate = FL.rate3.rate;
                                
                                HB.rate4.description = FL.rate4.description;
                                HB.rate4.editable = FL.rate4.editable;
                                HB.rate4.rate = FL.rate4.rate;
                                
                                HB.rate5.description = FL.rate5.description;
                                HB.rate5.editable = FL.rate5.editable;
                                HB.rate5.rate = FL.rate5.rate;
                                
                                HB.rate6.description = FL.rate6.description;
                                HB.rate6.editable = FL.rate6.editable;
                                HB.rate6.rate = FL.rate6.rate;
                                
                                HB.rate7.description = FL.rate7.description;
                                HB.rate7.editable = FL.rate7.editable;
                                HB.rate7.rate = FL.rate7.rate;
                                
                                HB.rate8.description = FL.rate8.description;
                                HB.rate8.editable = FL.rate8.editable;
                                HB.rate8.rate = FL.rate8.rate;
                            }
                            
                            HB.reference = FL.reference;    
                            summaryLineList.add(HB);                        
                        //}
                    }
                //}
                
                if(!(EditResponse.rentalQuote.llw == '' || EditResponse.rentalQuote.llw == null))
                {   
                    fullQWrapper.LLWTotal = EditResponse.rentalQuote.llw;
                }
                                
                if(!(EditResponse.rentalQuote.other == '' || EditResponse.rentalQuote.other == null))
                {   
                    fullQWrapper.otherInInvoicing = EditResponse.rentalQuote.other;
                }
                
                if(!(EditResponse.rentalQuote.pickUp == '' || EditResponse.rentalQuote.pickUp == null))
                {   
                    fullQWrapper.pickupCharge = EditResponse.rentalQuote.pickUp;
                }
                
                //ProductExtrasList = new List<HomeBaseBeans.extras>();
        
                for(EditFullQUoteService_AC.Extras PE : EditResponse.rentalQuote.extras)
                {
                    HomeBaseBeans.extras HB = new HomeBaseBeans.extras();
                    if(PE.id == 'PPE1'){
                        fullQWrapper.PPETotal = PE.total; 
                    }
                    HB.id = PE.id;
                    HB.description = PE.description;
                    //--------------TFS 2911-----------------------
                    if(HB.description.startsWith('Delivery') || HB.description.startsWith('PickUp') || HB.description.startsWith('Security')){
                    	HB.dollarOrPercent = '$';
                    }else{
                    	HB.dollarOrPercent = '%';
                    }
                    //--------------TFS 2911----------------------- 
                    if(!(PE.quantity == '' || PE.quantity == null))
                    {   
                        HB.quantity = String.ValueOf(Integer.valueOF(PE.quantity));
                    }
                    HB.include = PE.include;
                    HB.mandatory = PE.mandatory;
                    if(!(PE.price == '' || PE.price == null))
                    {   
                        HB.price = PE.price; 
                    }
                    HB.priceEditable = PE.priceEditable;
                    HB.quantityEditable = PE.quantityEditable;
                    HB.quantityRequired = PE.quantityRequired;
                    if(!(PE.total == '' || PE.total == null))
                    {   
                        HB.total = PE.total;
                    }
                    
                    HB.rate1 = new HomeBaseBeans.rates();
                    HB.rate2 = new HomeBaseBeans.rates();
                    HB.rate3 = new HomeBaseBeans.rates();
                    HB.rate4 = new HomeBaseBeans.rates();
                    HB.rate5 = new HomeBaseBeans.rates();
                    HB.rate6 = new HomeBaseBeans.rates();
                    HB.rate7 = new HomeBaseBeans.rates();
                    HB.rate8 = new HomeBaseBeans.rates(); 
                    
                    
                    HB.rate1.description = String.valueOf(PE.rate1.description);
                    HB.rate1.editable = PE.rate1.editable;
                    HB.rate1.rate = PE.rate1.rate;
                    
                    HB.rate2.description = String.valueOf(PE.rate2.description);
                    HB.rate2.editable = PE.rate2.editable;
                    HB.rate2.rate = PE.rate2.rate;
                    
                    HB.rate3.description = String.valueOf(PE.rate3.description);
                    HB.rate3.editable = PE.rate3.editable;
                    HB.rate3.rate = PE.rate3.rate;
                    
                    HB.rate4.description = String.valueOf(PE.rate4.description);
                    HB.rate4.editable = PE.rate4.editable;
                    HB.rate4.rate = PE.rate4.rate;
                    
                    HB.rate5.description = String.valueOf(PE.rate5.description);
                    HB.rate5.editable = PE.rate5.editable;
                    HB.rate5.rate = PE.rate5.rate;
                    
                    HB.rate6.description = String.valueOf(PE.rate6.description);
                    HB.rate6.editable = PE.rate6.editable;
                    HB.rate6.rate = PE.rate6.rate;
                    
                    HB.rate7.description = String.valueOf(PE.rate7.description);
                    HB.rate7.editable = PE.rate7.editable;
                    HB.rate7.rate = PE.rate7.rate;
                    HB.rate8.description = String.valueOf(PE.rate8.description);
                    HB.rate8.editable = PE.rate8.editable;
                    HB.rate8.rate = PE.rate8.rate;
                    
                    ProductExtrasList.add(HB); 
                }
        
                        
         }catch(Exception e){
             system.debug(LoggingLevel.ERROR,'Error while getting values from  FullQuoteHelper :assignEditValue: '+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting FullQuoteHelper :assignEditValue'+fullQWrapper +ProductExtrasList + analysisSetHeaderResponseList+summaryLineList);                                       
     }
     
     public string getSavePayload(String cloneIsTrue,String docsId,FullQuoteWrapper fullQWrapper,List<HomeBaseBeans.quoteLine> summaryLineList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList,
                                          List<HomeBaseBeans.extras> ProductExtrasList,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling,String startDate,
                                           String plannedCollectionDate,String quoteExpires,String PO_Expires,String shippingDate,
                                           HomeBaseBeans.TaxIds selectedTaxRecInBilling,
                                           HomeBaseBeans.TaxIds selectedTaxRecInShipping,
                                           String SelectedShipingTaxId,
                                           String modifiedTimeStamp,
                                          String Mobilization, String SelectedRentalLength,MMI_Full_Quotes__c updateQuoteRec ){
                                            
                                            
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteHelper :getSavePayload');
        String payLoad=null;                            
        try{ 
            if(PO_Expires != null && PO_Expires != '' ){
                PO_Expires = FullQuoteMainService.getDateInFormat(PO_Expires);
            }
            if(quoteExpires != null && quoteExpires != '' ){
                quoteExpires = FullQuoteMainService.getDateInFormat(quoteExpires);
            }
            if(plannedCollectionDate != null && plannedCollectionDate != '' ){
                plannedCollectionDate = FullQuoteMainService.getDateInFormat(plannedCollectionDate);
            }
            if(startDate != null && startDate != '' ){
                startDate = FullQuoteMainService.getDateInFormat(startDate);
            }
            if(shippingDate != null && shippingDate != '' ){
                shippingDate = FullQuoteMainService.getDateInFormat(shippingDate);
            }   
            system.debug('-----startDate-----'+startDate);
            
            if(docsId != '0' || cloneIsTrue == 'true'){
              ContactsService_AC contactsService = new ContactsService_AC();
              List<HomeBaseBeans.contactSummaryList> contactsResponseList = contactsService.listContacts(fullQWrapper.AccountId);
              if(contactsResponseList.size()<=0){
                  fullQWrapper.BillingContactID='';
                  fullQWrapper.deliveryContactId ='';
              }
            } 
            system.debug('-----fullQWrapper.deliveryZoneInShipping-----'+fullQWrapper.deliveryZoneInShipping);
            //fullQWrapper.CODInstructions = fullQWrapper.CODInstructions.trim();
            //fullQWrapper.deliveryInstructions = fullQWrapper.deliveryInstructions.trim();
            fullQWrapper.Address = removeSpecialCharacters(fullQWrapper.Address);
            selectedVAddressInShipping.address1 = removeSpecialCharacters(selectedVAddressInShipping.address1);
            
            fullQWrapper.CODInstructions = removeSpecialCharacters(fullQWrapper.CODInstructions);
            fullQWrapper.deliveryInstructions = removeSpecialCharacters(fullQWrapper.deliveryInstructions); 
            fullQWrapper.AccountName = removeSpecialCharacters(fullQWrapper.AccountName);
            if(fullQWrapper.selectedFullQUote == 'Sales'){
                    payLoad = '{"salesQuote": {';
            }else{
                    payLoad = '{"rentalQuote": {';
            }
            payLoad += '"documentId":'+docsId+','+
                                     '"companyId": 1,'+
                                     '"transactionId": "'+fullQWrapper.TransactionType+'",'+
                                     '"salesRep1": "'+fullQWrapper.WriteUpRep+'",'+
                                     '"salesRep1Name": "'+fullQWrapper.WriteUpRepName+'",'+
                                     '"salesRep2": "'+fullQWrapper.AssistingRep+'",'+
                                     '"salesRep2Name": "'+fullQWrapper.AssistingRepName+'",'+
                                     //'"salesRep1": "1234",'+
                                     //'"salesRep1Name": "",'+
                                    // '"salesRep2": "1234",'+
                                    // '"salesRep2Name": "",'+
                                     '"narrative1": "'+fullQWrapper.JoborLocation+'",'+
                                     '"narrative2": "",'+
                                     '"instructionText": "'+fullQWrapper.CODInstructions+'",'+
                                     '"status": null,'+
                                    // '"status": null,'+
                                     '"modifiedTimestamp": '+modifiedTimeStamp+','+
                                     '"billingContactDetails": {'+
                                            '"id": "'+fullQWrapper.BillingContactID+'",'+                                       
                                            '"name": "'+fullQWrapper.Name+'",'+
                                            //'"id": "",'+
                                            //'"name": "James Collins",'+
                                            '"tel": "'+fullQWrapper.telePhone+'",'+
                                            '"fax": "'+fullQWrapper.Fax+'",'+
                                            '"email": "'+fullQWrapper.Email+'",'+
                                            '"mobile": null'+
                                            '},'+
                                     '"reference": "'+fullQWrapper.POContact+'",'+
                                     '"poExpires": "'+PO_Expires+'",'+   
                                    // '"reference": "",'+
                                     //'"poExpires": "",'+                           
                                     '"creditApproval": "",'+
                                     '"taxExemptAuthorisation": "'+fullQWrapper.TaxExemptAuthorization+'",'+
                                     '"taxExempt": '+fullQWrapper.TaxExempt+',';    
                                     if(fullQWrapper.selectedFullQUote != 'sales'){ 
                                        payLoad = payLoad +'"quoteTotal": "'+fullQWrapper.QuoteTotal+'",';
                                     }
                                     payLoad = payLoad +'"lines": [ ';
                    
                    User userBranchDetail = FullQuoteDAO.getUserBranchDetails();
                    String loggedInUserBranchId = fullQWrapper.userBranchId;
	    	 		if(userBranchDetail != null && userBranchDetail.NSC_Rep__c ){
    	 				loggedInUserBranchId = '298';
                    }
                        
                    if(summaryLineList!=null && !summaryLineList.isEmpty()){                 
                        Integer ProdLstSize = 1;                 
                    for(HomeBaseBeans.quoteLine HB : summaryLineList)
                    {               
                        if(HB.lineId == 'new' || HB.lineId == 'newAdded'){
                            HB.lineId = '';
                        }
                        if(HB.description != null){
                            HB.description = removeSpecialCharacters(HB.description);
                        }
                        
                        if(fullQWrapper.selectedFullQUote == 'Sales'){
                            if(loggedInUserBranchId == '298'){
                                HB.ecode = '';
                            }
                            payLoad = payLoad +'{'+'"itemId": "'+HB.itemId+'",'+
                                              '"ecode": "'+HB.ecode+'",'+
                                              '"reference": "'+HB.reference+'",'+
                                              '"removeLine": '+HB.removeLine+','+
                                              '"description": "'+HB.description+'",'+
                                              '"lineValue": '+HB.lineValue+','+
                                              '"quantity": '+HB.quantity+','+
                                              '"price": '+HB.price+','+
                                              '"invoiceDiscountApplicable": '+HB.invoiceDiscountApplicable+','+
                                              '"lockItemCode": "'+HB.lockItemCode+'",';
                            if(HB.lineId != null && HB.lineId != ''){
                                if(docsId == '0'){
                                    payLoad = payLoad +'"lineId": null,';   
                                }else{
                                payLoad = payLoad +'"lineId": '+HB.lineId+',';
                                }
                            }else{
                                payLoad = payLoad +'"lineId": null,';
                            }
                            payLoad = payLoad +'"estimatedCost": null,'+
                                              '"gpPercent": null,';
                            if(HB.netBookValue != null){
                                payLoad = payLoad +'"netBookValue": '+HB.netBookValue+',';
                            }else{
                                payLoad = payLoad +'"netBookValue": null,';
                            }
                            payLoad = payLoad +'"paymentType": null,'+
                                              '"payment1": null,'+
                                              '"payment2": null,'+
                                              '"payment3": null }';
                        }else{
                            payLoad = payLoad +'{'+'"itemId": "'+HB.itemId+'",'+
                                              '"ecode": "'+HB.ecode+'",'+
                                              '"reference": "'+HB.reference+'",'+
                                              '"removeLine": '+HB.removeLine+','+
                                              '"description": "'+HB.description+'",'+
                                              '"lineValue": '+HB.LockTypeTotal+','+
                                              '"quantity": '+HB.quantity+','+
                                              '"price": '+HB.price+','+
                                              '"invoiceDiscountApplicable": '+HB.invoiceDiscountApplicable+','+
                                              '"lockItemCode": "'+HB.lockItemCode+'",';
                            if(HB.lineId != null && HB.lineId != ''){
                                if(docsId == '0'){
                                    payLoad = payLoad +'"lineId": null,';   
                                }else{
                                payLoad = payLoad +'"lineId": '+HB.lineId+',';
                                }
                            }else{
                                payLoad = payLoad +'"lineId": null,';
                            }
                                payLoad = payLoad +'"internetCoupon": "'+HB.internetCoupon+'",';
                            if(HB.chargeCode!=null){                      
                            payLoad = payLoad +'"chargeCode": {'+
                                                  '"description": '+ HB.chargeCode.description+','+
                                                   '"active":'+ HB.chargeCode.active+','+
                                                    '"id":"'+ HB.chargeCode.id+'"}';
                            }else{
                                    payLoad = payLoad +'"chargeCode": null';
                            }
                                 payLoad = payLoad +',"rate1": {';
                                                if(HB.rate1.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate1.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate1.description+'",'+
                                                    '"editable":'+HB.rate1.editable+
                                              '},'+
                                              
                                              '"rate2": {';
                                                if(HB.rate2.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate2.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate2.description+'",'+
                                                    '"editable":'+HB.rate2.editable+
                                              '},'+
                                                    
                                              '"rate3": {';
                                                if(HB.rate3.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate3.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate3.description+'",'+
                                                    '"editable":'+HB.rate3.editable+
                                              '},'+
                                                    
                                              '"rate4": {';
                                                if(HB.rate4.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate4.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate4.description+'",'+
                                                    '"editable":'+HB.rate4.editable+
                                              '},'+
                                                    
                                              '"rate5": {';
                                                if(HB.rate5.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate5.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate5.description+'",'+
                                                    '"editable":'+HB.rate5.editable+
                                              '},'+
                                                    
                                              '"rate6": {';
                                                if(HB.rate6.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate6.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate6.description+'",'+
                                                    '"editable":'+HB.rate6.editable+
                                              '},'+
                                                    
                                              '"rate7": {';
                                                if(HB.rate7.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate7.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate7.description+'",'+
                                                    '"editable":'+HB.rate7.editable+
                                              '},'+
                                                    
                                              '"rate8": {';
                                                if(HB.rate8.rate != null){
                                                    payLoad = payLoad +'"rate":'+HB.rate8.rate+',';
                                                }else{
                                                    payLoad = payLoad +'"rate":null,';
                                                }
                                payLoad = payLoad +'"description": "'+HB.rate8.description+'",'+
                                                    '"editable":'+HB.rate8.editable+
                                              '},';
                                              if(HB.commission1 != null){
                                                payLoad = payLoad +'"commission1": '+HB.commission1+',';
                                              }else{
                                                payLoad = payLoad +'"commission1": null,';
                                              }
                                              if(HB.commission2 != null){
                                                payLoad = payLoad +'"commission2": '+HB.commission2+',';
                                              }else{
                                                payLoad = payLoad +'"commission2": null,';
                                              }
                                              if(HB.commission3 != null){
                                                payLoad = payLoad +'"commission3": '+HB.commission3+',';
                                              }else{
                                                payLoad = payLoad +'"commission3": null,';
                                              }
                                              if(HB.commission4 != null){
                                                payLoad = payLoad +'"commission4": '+HB.commission4;
                                              }else{
                                                payLoad = payLoad +'"commission4": null';
                                              }
                                             payLoad = payLoad +'}';                                          
                            
                        }
                            if(summaryLineList.size() != ProdLstSize)
                            {
                                payLoad = payLoad + ',';
                            }
                            ProdLstSize ++;
                        
                        //break;
                    }
                    
                    }
                    payLoad = payLoad +'],';             
                    if(analysisSetHeaderResponseList!=null && !analysisSetHeaderResponseList.isEmpty()){
                    Integer n = 1;                  
                    for(HomeBaseBeans.AnalysisSetHeaders HB : analysisSetHeaderResponseList)
                    {
                        
                            payLoad = payLoad +'"analysisSet'+n+'": {'+
                                                    '"header": {'+  
                                                        '"id": '+HB.id+','+
                                                        '"description": "'+HB.description+'"'+
                                                     '},'+
                                                     '"selection": {'+
                                                        '"id": "'+HB.selectedId+'",'+
                                                        '"description": "'+HB.selectedDescription+'"'+
                                                     '}'+
                                                 '},';
                                         
                        n++;
                    } 
                    }
                    
                    if(analysisSetHeaderResponseShippingList!=null && !analysisSetHeaderResponseShippingList.isEmpty()){
                     Integer n = 1;         
                    for(HomeBaseBeans.AnalysisSetHeaders HB : analysisSetHeaderResponseShippingList)
                    {
                        
                        if(HB.id == '111'){
                            n = 1;
                        }else if(HB.id == '112'){
                            if(HB.selectedId == null || HB.selectedId == ''){
                                HB.selectedDescription = null;
                            }
                            n = 2;
                        }else if(HB.id == '113'){
                            n = 3;
                        }else if(HB.id == '114'){
                            if(HB.selectedId == null || HB.selectedId == ''){
                                HB.selectedDescription = null;
                            }
                            n = 4;
                        } 
                        
                        
                        payLoad = payLoad +'"additionalAnalysisSet'+n+'": {'+
                                                '"header": {'+  
                                                    '"id": '+HB.id+','+
                                                    '"description": "'+HB.description+'"'+
                                                 '},'+
                                                 '"selection": {'+
                                                    '"id": "'+HB.selectedId+'",'+
                                                    '"description": "'+HB.selectedDescription+'"'+
                                                 '}'+
                                             '},';
                                             n++;
                                         
                    } 
                    }
                    payLoad = payLoad + '"termsCode": "'+fullQWrapper.TermsCode+'",'+
                                        '"invoicedBalance": "'+fullQWrapper.InvoicedBalance+'",';
                    String LastInvoiceDate = '';
                    if(fullQWrapper.LastInvoice == null || fullQWrapper.LastInvoice == ''){
                        LastInvoiceDate = '""';
                    }else{
                        LastInvoiceDate = '"'+fullQWrapper.LastInvoice+'"';
                    }
                    payLoad = payLoad + +'"lastInvoiceDate": '+LastInvoiceDate+','+
                                        '"writeUpRepCommission": null,'+    
                                        '"nscRepCommission": null,'+
                                        '"portalContact": "",'+
                                        '"portalContactEmail": "",'+
                                        '"alreadyRegistered": null,'+
                                        '"homeOwner": "",'+
                                        '"creditStatus": "'+fullQWrapper.Status+'",'+
                                        '"poRequired": null,'+
                                        '"viewDocumentIn": null,'+
                                        '"emailPortalLink": false,'+
                                        '"messageDetails": null,';
                    if(updateQuoteRec != null){
                        if(updateQuoteRec.Reservation_ID__c != null && updateQuoteRec.Reservation_ID__c != ''){
                            payLoad = payLoad +'"reservationId": '+updateQuoteRec.Reservation_ID__c+',';
                        }else{
                            payLoad = payLoad +'"reservationId": null,';
                        }
                    }else{
                        payLoad = payLoad +'"reservationId": null,';
                    }
                    payLoad = payLoad +'"accountId": "'+fullQWrapper.AccountId+'",'+
                                        '"startDate": "'+startDate+'",'+
                                        '"plannedCollectionDate": "'+plannedCollectionDate+'",'+
                                        '"billingAddressId": "'+fullQWrapper.ID+'",'+
                                        
                                        '"billingAddress": {'+
                                                '"name": "'+fullQWrapper.AccountName+'",'+                                          
                                                '"address1": "'+fullQWrapper.Address+'",'+
                                                '"address2": "'+selectedVAddressInBilling.address2+'",'+
                                                '"address3": "'+fullQWrapper.City+'",'+
                                                '"address4": "'+fullQWrapper.County+'",'+
                                                '"state": "'+fullQWrapper.State+'",'+
                                                '"countryId": "'+fullQWrapper.Country+'",'+
                                                '"zipCode": "'+fullQWrapper.ZipCode+'",'+
                                                '"crossStreet1": null,'+
                                                '"crossStreet2": null,'+
                                                '"taxId": "'+selectedTaxRecInBilling.Id+'",'+
                                                '"deliveryZone": "'+selectedVAddressInBilling.deliveryZone+'",'+
                                                '"cityZone": null,'+
                                                '"zoneWarning": null,'+
                                                '"latitude": null,'+
                                                '"longitude": null,'+
                                                '"oldPostalCode": "'+selectedVAddressInBilling.oldPostalCode+'",'+
                                                '"distanceFromBranch": null,'+
                                                '"distanceBranch": null,'+
                                                '"fulfillingBranchId": null,'+
                                                '"fulfillingBranchName": "'+selectedVAddressInBilling.fulfillingBranchName+'"'+

                                                /*
                                                '"name": "'+fullQWrapper.Name+'",'+                                         
                                                '"address1": "'+selectedVAddressInBilling.address1+'",'+
                                                '"address2": "'+selectedVAddressInBilling.address2+'",'+
                                                '"address3": "'+selectedVAddressInBilling.address3+'",'+
                                                '"address4": "'+selectedVAddressInBilling.address4+'",'+
                                                '"state": "'+selectedVAddressInBilling.state+'",'+
                                                '"countryId": "'+selectedVAddressInBilling.countryId+'",'+
                                                '"zipCode": "'+selectedVAddressInBilling.zipCode+'",'+
                                                '"crossStreet1": "'+fullQWrapper.crossStreetInShippingDates+'",'+
                                                '"crossStreet2": "'+selectedVAddressInBilling.crossStreet2+'",'+
                                                '"taxId": "'+selectedTaxRecInBilling.Id+'",'+
                                                '"deliveryZone": "'+selectedVAddressInBilling.deliveryZone+'",'+
                                                '"cityZone": 0,'+
                                                '"zoneWarning": '+selectedVAddressInBilling.zoneWarning+','+
                                                '"latitude": '+selectedVAddressInBilling.latitude+','+
                                                '"longitude": '+selectedVAddressInBilling.longitude+','+
                                                '"oldPostalCode": "'+selectedVAddressInBilling.oldPostalCode+'",'+
                                                '"distanceFromBranch": '+selectedVAddressInBilling.distanceFromBranch+','+
                                                '"distanceBranch": '+selectedVAddressInBilling.distanceBranch+','+
                                                '"fulfillingBranchId": '+selectedVAddressInBilling.fulfillingBranch+','+
                                                '"fulfillingBranchName": "'+selectedVAddressInBilling.fulfillingBranchName+'"'+*/
                                        '},'+
                                    '"extras": [';
                                    
                    if(ProductExtrasList!=null && !ProductExtrasList.isEmpty()){                    
                        Integer m = 1; 
                        list<HomeBaseBeans.extras>  tempProductExtrasList = new list<HomeBaseBeans.extras>();
                        for(HomeBaseBeans.extras HB : ProductExtrasList)
                        {
                            if(HB.include == true){
                                tempProductExtrasList.add(HB);
                            }
                        }
                        for(HomeBaseBeans.extras HB : tempProductExtrasList)
                        {
                            if(fullQWrapper.selectedFullQUote == 'Sales'){
                                payLoad = payLoad + '{'+
                                                '"id": "'+HB.Id+'",'+
                                                '"description": "'+HB.description+'",'+
                                                '"quantity": '+HB.quantity+','+
                                                '"price": '+HB.price+','+
                                                '"total": '+HB.total+','+
                                                '"rate1": {'+
                                                        '"rate":0.00,'+
                                                        '"description": "",'+
                                                        '"editable": false'+
                                                      '},'+
                                                '"rate2": null,'+
                                                '"rate3": null,'+
                                                '"rate4": null,'+
                                                '"rate5": null,'+
                                                '"rate6": null,'+
                                                '"rate7": null,'+
                                                '"rate8": null,'+
                                                '"include": '+HB.include+','+
                                                '"mandatory": '+HB.mandatory+','+
                                                '"priceEditable": '+HB.priceEditable+','+
                                                '"quantityEditable": '+HB.quantityEditable+','+
                                                '"quantityRequired": '+HB.quantityRequired+
                                             '}';
                            }else{
                                payLoad = payLoad + '{'+
                                                    '"id": "'+HB.Id+'",'+
                                                    '"description": "'+HB.description+'",'+
                                                    '"quantity": '+HB.quantity+','+
                                                    '"price": '+HB.price+','+
                                                    '"total": '+HB.total+','+
                                                    '"include": '+HB.include+','+
                                                    '"mandatory": '+HB.mandatory+','+
                                                    '"priceEditable": '+HB.priceEditable+','+
                                                    '"quantityEditable": '+HB.quantityEditable+','+
                                                    '"quantityRequired": '+HB.quantityRequired+
                                                 '}';
                            }
                            if(tempProductExtrasList.size() != m)
                            {
                                payLoad = payLoad + ',';
                            }
                            m++;                     
                            }                    
                        }                       
                 payLoad = payLoad + '],'+
                                     '"quoteExpires": "'+quoteExpires+'",'+
                                    // '"PO_Expires": "'+PO_Expires+'",'+
                                     '"certificateOfInsurance": "'+fullQWrapper.CertofInsurance+'",';
                        if(fullQWrapper.DeliveryInInvoicing != null && fullQWrapper.DeliveryInInvoicing != ''){
                            payLoad = payLoad +'"delivery": '+fullQWrapper.DeliveryInInvoicing+',';
                        }else{
                            payLoad = payLoad +'"delivery": null,';
                        }
                        
                        payLoad = payLoad +'"printOnOrder": true,'; // TFS 5322
                        
                        if(fullQWrapper.selectedFullQUote == 'Sales'){
                            
                            payLoad = payLoad +'"orderGoods": '+fullQWrapper.unitPriceInvoice+','+
                                            '"extrasTotal": '+fullQWrapper.extrasInvoice+','+
                                            '"tax": '+fullQWrapper.taxInvoice+','+
                                            '"orderTotal": '+fullQWrapper.totalInvoice+','+
                                            //'"salesTerms": "'+fullQWrapper.Terms+'",'+
                                            '"type": "sales",'+
                                            '"mobilization": '+Mobilization+','+
                                            '"branchId": '+loggedInUserBranchId+','+
                                            '"ytdSales": "'+fullQWrapper.YTDSales+'",';
                            }else{           
                                     
                                payLoad = payLoad +'"rentalCharge": '+fullQWrapper.RentalCharge+','+
                                     '"rentalCharge": '+fullQWrapper.RentalCharge+','+
                                     '"pickUp": '+fullQWrapper.pickupCharge+','+    
                                     '"accessories": '+fullQWrapper.Accessories+','+
                                     '"llw": '+fullQWrapper.LLWTotal+','+
                                     '"other": '+fullQWrapper.otherInInvoicing+','+
                                     '"codAmount": '+fullQWrapper.CODAmount+','+
                                     '"tax": '+fullQWrapper.TaxTotal+','+
                                     '"totalCodAmount": '+fullQWrapper.TotalCODAmount+','+
                                     '"hireTerms": "'+fullQWrapper.Terms+'",'+
                                     '"customerText1": "",'+
                                     ' "type": "rental",'+
                                     '"mobilization": '+Mobilization+','+
                                     '"branchId": '+loggedInUserBranchId+','+  
                                     //'"branchId": 126,'+                               
                                     '"ytdSales": "'+fullQWrapper.YTDSales+'",';
                        }             
                        payLoad = payLoad +'"shippingDate": "'+shippingDate+'",'+
                                     '"shippingAddressId": "'+fullQWrapper.shippingId+'",'+ 
                                     '"shippingAddress": {'+
                                                '"name": "'+fullQWrapper.AccountName+'",'+                                          
                                                '"address1": "'+selectedVAddressInShipping.address1+'",'+
                                                '"address2": "'+selectedVAddressInShipping.address2+'",'+
                                                '"address3": "'+selectedVAddressInShipping.address3+'",'+
                                                '"address4": "'+selectedVAddressInShipping.address4+'",'+
                                                '"state": "'+selectedVAddressInShipping.state+'",'+
                                                '"countryId": "'+selectedVAddressInShipping.countryId+'",'+
                                                '"crossStreet1": "'+fullQWrapper.crossStreetInShippingDates+'",'+
                                                '"crossStreet2": "'+fullQWrapper.crossStreet2InShippingDates+'",'+
                                                '"taxId": "'+fullQWrapper.SelectedShipingTaxId+'",'+
                                                '"deliveryZone": "'+fullQWrapper.deliveryZoneInShipping+'",'+
                                                '"cityZone": null,';
                                                
                                                if(selectedVAddressInShipping.zoneWarning!=null){
                                                    payLoad = payLoad+'"zoneWarning": "'+selectedVAddressInShipping.zoneWarning+'",';
                                                }else{
                                                    payLoad = payLoad+'"zoneWarning": '+selectedVAddressInShipping.zoneWarning+',';
                                                }
                                                
                                            payLoad = payLoad+'"latitude": '+selectedVAddressInShipping.latitude+','+
                                                '"longitude": '+selectedVAddressInShipping.longitude+','+
                                                '"oldPostalCode": "'+selectedVAddressInShipping.oldPostalCode+'",'+
                                                '"zipCode": "'+selectedVAddressInShipping.zipCode+'",'+
                                                '"distanceFromBranch": '+fullQWrapper.distFromBranch+','+
                                                '"distanceBranch": '+selectedVAddressInShipping.distanceBranch+','+
                                                '"fulfillingBranchId": '+fullQWrapper.userBranchId+','+
                                                '"fulfillingBranchName": "'+fullQWrapper.fulFillingBranchNameInShippingDates+'"'+
                                                
                                    '},'+ 
                                    ' "shippingContactDetails": {'+
                                            '"id": "'+fullQWrapper.deliveryContactId+'",'+                                      
                                            '"name": "'+fullQWrapper.NameInShippingDates1+'",'+
                                            //'"id": "",'+ 
                                            //'"name": "James Collins",'+       
                                            '"tel": "'+fullQWrapper.telInShippingDates+'",'+
                                            '"fax": "'+fullQWrapper.faxInShippingDates+'",'+
                                            '"email": "'+fullQWrapper.emailInShippingDates+'",'+
                                            '"mobile":""'+
                                        '},';
                                    if(fullQWrapper.selectedFullQUote != 'Sales'){  
                                            payLoad = payLoad+'"shippingInstructions": "'+fullQWrapper.deliveryInstructions+'",'+       
                                            '"rentalLength": '+SelectedRentalLength; 
                                    }else{
                                        payLoad = payLoad+'"shippingInstructions": "'+fullQWrapper.deliveryInstructions+'"';        
                                    }
                            payLoad = payLoad+'}'+  
                        '}';                                             
                    
                    payLoad = payLoad.replaceAll('"null"','""');
         }catch(Exception e){
             system.debug(LoggingLevel.ERROR,'Error while getting values from  FullQuoteHelper :getSavePayload: '+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting FullQuoteHelper :getSavePayload'+payLoad);      
         return payLoad;
     }
     
     public String removeSpecialCharacters(String InputString){
            if(InputString != null || InputString == ''){
                InputString = InputString.trim();
                InputString = InputString.replace('"', '\\"');
                InputString = InputString.replace('\n', ' ');
                InputString = InputString.replace('<br/>', ' ');
                InputString = InputString.replace('\r', ' ');
            
                return InputString;
            }else{
                return '';
            }
        }


}