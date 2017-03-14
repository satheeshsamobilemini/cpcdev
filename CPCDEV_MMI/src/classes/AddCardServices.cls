public with sharing class AddCardServices {
    public String CardListResponse {get;set;}
    public String SpecificCardResponse {get;set;}
    public String AddCardResponseData {get;set;}
    public String UpdateCardResponse {get;set;}
    public String AddAutoCheckResponse {get;set;}
    public String UpdateAutoCheckResponse {get;set;}
    public String AddCardWithQuoteResponse {get;set;}
    
    
    public List<HomeBaseBeans.ListCard> listCards(String contactId, String AccountNo)
    {
        ServiceProxy servicePro =null; 
        List<HomeBaseBeans.ListCard> cardList = null;
        
        try{    
            servicePro = new ServiceProxy();
            if(!test.isRunningTest()){
                CardListResponse = servicePro.callRestService('rest/api/v1/companies/1/creditcards/cards?account_id='+AccountNo+'&contact_id='+contactId,'GET','');
                System.debug('******CardListResponse************'+CardListResponse);
            }else{
                CardListResponse = '{"creditCardDetails":[{"accountId":"237135.3","contactId":"18","firstName":"FirstName","lastName":"Gorrie","address1":"5950 BERKSHIRE LANE","address2":"STE1200","city":"DALLAS","county":"DALLAS","state":"TX","zipcode":"75225","country":"USA","email":"mike.clark@rentalResult.com","defaultAddressCode":"CON","defaultAddressCodeDescription":"CONTACT","cardType":"002","cardTypeDescription":"MasterCard","cardExpiryDate":"12/2014","cardName":"FirstNameGorrie","cardNumberLast4":"XXXXXXXXXXXX1111","paymentType":"CRD","paymentTypeDescription":"CREDIT","transactionSource":"MOTO","transactionType":"AUTHORIZATION","bankName":"","bankCity":"","bankState":"","bankAccountType":"","bankAccountTypeDescription":null,"chequeType":"","chequeTypeDescription":null,"telephone":"","cardKey1":2147402861,"cardKey2":8080,"cardKey3":7},{"accountId":"237135.3","contactId":"18","firstName":"FirstName","lastName":"Gorrie","address1":"5950 BERKSHIRELANE","address2":"STE1200","city":"DALLAS","county":"DALLAS","state":"TX","zipcode":"75225","country":"USA","email":"mike.clark@rentalResult.com","defaultAddressCode":"CON","defaultAddressCodeDescription":"CONTACT","cardType":"002","cardTypeDescription":"MasterCard","cardExpiryDate":"12/2014","cardName":"FirstNameGorrie","cardNumberLast4":"XXXXXXXXXXXX1111","paymentType":"CRD","paymentTypeDescription":"CREDIT","transactionSource":"MOTO","transactionType":"AUTHORIZATION","bankName":"","bankCity":"","bankState":"","bankAccountType":"","bankAccountTypeDescription":null,"chequeType":"","chequeTypeDescription":null,"telephone":"","cardKey1":2147402861,"cardKey2":8080,"cardKey3":8}]}';
            }
            if(!CardListResponse.contains('"errorCode"'))
            {               
                DeserializeCardList cardLst = (DeserializeCardList)JSON.deserialize(CardListResponse, DeserializeCardList.class);
                System.debug('---------------creditCardDetails-------------------'+cardLst.creditCardDetails);
                
                return cardLst.creditCardDetails;
            }
            else
            { 
                cardList = new List<HomeBaseBeans.ListCard>();
                HomeBaseBeans.ListCard h = new HomeBaseBeans.ListCard();
                String errorMessage = QuickQuoteErrorHandler.handleError(CardListResponse);
                h.errorMessage = errorMessage;
                cardList.add(h); 
                return cardList;
            }
            
        }
        catch(Exception e)
        {
            System.debug('***** response error '+e);
            String errorMessage = e.getMessage();
            cardList = new List<HomeBaseBeans.ListCard>();
            HomeBaseBeans.ListCard h = new HomeBaseBeans.ListCard();
            h.errorMessage = errorMessage;
            cardList.add(h); 
            return cardList;
        }
        
                
    }
    
     public class DeserializeCardList
    {
        public List<HomeBaseBeans.ListCard> creditCardDetails;
        
        public DeserializeCardList()
        {
            creditCardDetails = new List<HomeBaseBeans.ListCard>();
        }
    }
    
    
    public List<HomeBaseBeans.ListCard> SpecificCards(String cardKey1, String cardKey2, String cardKey3)
    {
        ServiceProxy servicePro =null; 
        List<HomeBaseBeans.ListCard> specCard = null;
        
        try{    
            servicePro = new ServiceProxy();
            if(!test.isRunningTest()){
                SpecificCardResponse = servicePro.callRestService('rest/api/v1/companies/1/creditcards?card_key1='+cardKey1+'&card_key2='+cardKey2+'&card_key3='+cardKey3,'GET','');
                System.debug('******SpecificCardResponse************'+SpecificCardResponse);
            }else{
                SpecificCardResponse = '{"creditCardDetails":{"accountId":"237135.3","contactId":"18","firstName":"FirstName","lastName":"Gorrie","address1":"5950 BERKSHIRE LANE","address2":"STE1200","city":"DALLAS","county":"DALLAS","state":"TX","zipcode":"75225","country":"USA","email":"mike.clark@rentalResult.com","defaultAddressCode":"CON","defaultAddressCodeDescription":"CONTACT","cardType":"001","cardTypeDescription":"Visa","cardExpiryDate":"12/2014","cardName":"FirstNameGorrie","cardNumberLast4":"XXXXXXXXXXXX1111","paymentType":"CRD","paymentTypeDescription":"CREDIT","transactionSource":"MOTO","transactionType":"AUTHORIZATION","bankName":"","bankCity":"","bankState":"","bankAccountType":"","bankAccountTypeDescription":null,"chequeType":"","chequeTypeDescription":null,"telephone":"","cardKey1":2147402861,"cardKey2":8080,"cardKey3":14.00}}';
            }
            if(!SpecificCardResponse.contains('"errorCode"'))
            {               
                DeserializeSpecCard specCardData = (DeserializeSpecCard)JSON.deserialize(SpecificCardResponse, DeserializeSpecCard.class);
                System.debug('---------------creditCardDetails-------------------'+specCardData.creditCardDetails);
                
                return specCardData.creditCardDetails;
            }
            else
            { 
                specCard = new List<HomeBaseBeans.ListCard>();
                HomeBaseBeans.ListCard h = new HomeBaseBeans.ListCard();
                String errorMessage = QuickQuoteErrorHandler.handleError(SpecificCardResponse);
                h.errorMessage = errorMessage;
                specCard.add(h); 
                return specCard;
            }
            
        }
        catch(Exception e)
        {
            System.debug('***** response error '+e);
            String errorMessage = e.getMessage();
            specCard = new List<HomeBaseBeans.ListCard>();
            HomeBaseBeans.ListCard h = new HomeBaseBeans.ListCard();
            h.errorMessage = errorMessage;
            specCard.add(h); 
            return specCard;
        }
        
                
    }
    
     public class DeserializeSpecCard
    {
        public List<HomeBaseBeans.ListCard> creditCardDetails;
        
        public DeserializeSpecCard()
        {
            creditCardDetails = new List<HomeBaseBeans.ListCard>();
        }
    }
    
    public List<HomeBaseBeans.AddCardResponse> AddCard(String repId, String Payload)
    {
        ServiceProxy servicePro =null; 
        List<HomeBaseBeans.AddCardResponse> newCard = null;
        
        try{    
            servicePro = new ServiceProxy();
            if(!test.isRunningTest()){
                AddCardResponseData = servicePro.callRestService('rest/api/v1/companies/1/creditcards/card?login_id='+repId,'POST', Payload);
                System.debug('******AddCardResponseData************'+AddCardResponseData);
            }else{
                AddCardResponseData = '{"statusCode":"100","statusMessage":"Successfultransaction","decision":"ACCEPT","authorizationReference":"4206389325310176195842","successful":true,"cardKey1":2147402861,"cardKey2":8080,"cardKey3":16.00}';
            }
            if(!AddCardResponseData.contains('"errorCode"'))
            {               
                DeserializeNewCard newCardData = (DeserializeNewCard)JSON.deserialize(AddCardResponseData, DeserializeNewCard.class);
                System.debug('---------------creditCardDetails-------------------'+newCardData);
                newCard = new List<HomeBaseBeans.AddCardResponse>();
                if(newCardData != null){
                    HomeBaseBeans.AddCardResponse cr = new HomeBaseBeans.AddCardResponse();
                    cr.statusCode = newCardData.statusCode;
                    cr.statusMessage = newCardData.statusMessage;
                    cr.decision = newCardData.decision;
                    cr.authorizationReference = newCardData.authorizationReference;
                    cr.successful = newCardData.successful;
                    cr.cardKey1 = newCardData.cardKey1;
                    cr.cardKey2 = newCardData.cardKey2;
                    cr.cardKey3 = newCardData.cardKey3;
                    newCard.add(cr);
                }
                return newCard;
            }
            else
            { 
                newCard = new List<HomeBaseBeans.AddCardResponse>();
                HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
                String errorMessage = QuickQuoteErrorHandler.handleError(AddCardResponseData);
                h.errorMessage = errorMessage;
                newCard.add(h); 
                return newCard;
            }
            
        }
        catch(Exception e)
        {
            System.debug('***** response error '+e);
            String errorMessage = e.getMessage();
            newCard = new List<HomeBaseBeans.AddCardResponse>();
            HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
            h.errorMessage = errorMessage;
            newCard.add(h); 
            return newCard;
        }
        
                
    }
    
     public class DeserializeNewCard
    {
        public String statusCode {get;set;}
        public String statusMessage {get;set;}
        public String decision {get;set;}
        public String authorizationReference {get;set;}
        public String successful {get;set;}
        public String cardKey1 {get;set;}
        public String cardKey2 {get;set;}
        public String cardKey3 {get;set;}
    }
    
    public List<HomeBaseBeans.AddCardResponse> UpdateCard(String repId, String Payload)
    {
        ServiceProxy servicePro =null; 
        List<HomeBaseBeans.AddCardResponse> updateCardData = null;
        
        try{    
            servicePro = new ServiceProxy();
            if(!test.isRunningTest()){
                UpdateCardResponse = servicePro.callRestService('rest/api/v1/companies/1/creditcards/card?login_id='+repId,'PUT', Payload);
            }else{
                UpdateCardResponse = '{"statusCode":"100","statusMessage":"Successfultransaction","decision":"ACCEPT","authorizationReference":4206389325310176195842?,"successful":true,"cardKey1":2147417832,"cardKey2":25000,"cardKey3":21.00}';
            }
            System.debug('******UpdateCardResponse************'+UpdateCardResponse);
            if(!UpdateCardResponse.contains('"errorCode"'))
            {               
                DeserializeUpdateCard updateCrdData = (DeserializeUpdateCard)JSON.deserialize(UpdateCardResponse, DeserializeUpdateCard.class);
                System.debug('---------------updateCardResponseData-------------------'+updateCrdData);
                
                updateCardData = new List<HomeBaseBeans.AddCardResponse>();
                if(updateCrdData != null){
                    HomeBaseBeans.AddCardResponse cr = new HomeBaseBeans.AddCardResponse();
                    cr.statusCode = updateCrdData.statusCode;
                    cr.statusMessage = updateCrdData.statusMessage;
                    cr.decision = updateCrdData.decision;
                    cr.authorizationReference = updateCrdData.authorizationReference;
                    cr.successful = updateCrdData.successful;
                    cr.cardKey1 = updateCrdData.cardKey1;
                    cr.cardKey2 = updateCrdData.cardKey2;
                    cr.cardKey3 = updateCrdData.cardKey3;
                    updateCardData.add(cr);
                }
                return updateCardData;
            }
            else
            { 
                updateCardData = new List<HomeBaseBeans.AddCardResponse>();
                HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
                String errorMessage = QuickQuoteErrorHandler.handleError(UpdateCardResponse);
                h.errorMessage = errorMessage;
                updateCardData.add(h); 
                return updateCardData;
            }
            
        }
        catch(Exception e)
        {
            System.debug('***** response error '+e);
            String errorMessage = e.getMessage();
            updateCardData = new List<HomeBaseBeans.AddCardResponse>();
            HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
            h.errorMessage = errorMessage;
            updateCardData.add(h); 
            return updateCardData;
        }
        
                
    }
    
     public class DeserializeUpdateCard
    {
        public String statusCode {get;set;}
        public String statusMessage {get;set;}
        public String decision {get;set;}
        public String authorizationReference {get;set;}
        public String successful {get;set;}
        public String cardKey1 {get;set;}
        public String cardKey2 {get;set;}
        public String cardKey3 {get;set;}
    }
    
    public List<HomeBaseBeans.AddCardResponse> AddAutoCheck(String repId, String Payload)
    {
        ServiceProxy servicePro =null; 
        List<HomeBaseBeans.AddCardResponse> newAutoCheck = null;
        
        try{    
            servicePro = new ServiceProxy();
            if(!test.isRunningTest()){
                AddAutoCheckResponse = servicePro.callRestService('rest/api/v1/companies/1/creditcards/check?login_id='+repId,'POST', Payload);
            }else{
                AddAutoCheckResponse = '{"statusCode":"100","statusMessage":"Successfultransaction","decision":"ACCEPT","authorizationReference":"4206389325310176195842","successful":true,"cardKey1":2147402861,"cardKey2":8080,"cardKey3":16.00}';
            }
            System.debug('******AddAutoCheckResponse************'+AddAutoCheckResponse);
            if(!AddAutoCheckResponse.contains('"errorCode"'))
            {               
                DeserializeNewAutoCheck newAutoChkData = (DeserializeNewAutoCheck)JSON.deserialize(AddAutoCheckResponse, DeserializeNewAutoCheck.class);
                System.debug('---------------newAutoCheckData-------------------'+newAutoChkData);
                
                newAutoCheck = new List<HomeBaseBeans.AddCardResponse>();
                if(newAutoChkData != null){
                    HomeBaseBeans.AddCardResponse Ach = new HomeBaseBeans.AddCardResponse();
                    Ach.authorizationReference = newAutoChkData.authorizationReference;
                    Ach.statusCode = newAutoChkData.statusCode;
                    Ach.statusMessage = newAutoChkData.statusMessage;
                    Ach.decision = newAutoChkData.decision;
                    Ach.successful = newAutoChkData.successful;
                    Ach.cardKey1 = newAutoChkData.cardKey1;
                    Ach.cardKey2 = newAutoChkData.cardKey2;
                    Ach.cardKey3 = newAutoChkData.cardKey3;
                    newAutoCheck.add(Ach);
                }
                return newAutoCheck;
            }
            else
            { 
                newAutoCheck = new List<HomeBaseBeans.AddCardResponse>();
                HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
                String errorMessage = QuickQuoteErrorHandler.handleError(AddAutoCheckResponse);
                h.errorMessage = errorMessage;
                newAutoCheck.add(h); 
                return newAutoCheck;
            }
            
        }
        catch(Exception e)
        {
            System.debug('***** response error '+e);
            String errorMessage = e.getMessage();
            newAutoCheck = new List<HomeBaseBeans.AddCardResponse>();
            HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
            h.errorMessage = errorMessage;
            newAutoCheck.add(h); 
            return newAutoCheck;
        }
        
                
    }
    
    public class DeserializeNewAutoCheck
    {
        public String statusCode {get;set;}
        public String statusMessage {get;set;}
        public String decision {get;set;}
        public String authorizationReference {get;set;}
        public String successful {get;set;}
        public String cardKey1 {get;set;}
        public String cardKey2 {get;set;}
        public String cardKey3 {get;set;}
    }
    
    public List<HomeBaseBeans.AddCardResponse> UpdateAutoCheck(String repId, String Payload)
    {
        ServiceProxy servicePro =null; 
        List<HomeBaseBeans.AddCardResponse> updateAutoCheck = null;
        
        try{    
            servicePro = new ServiceProxy();
            if(!test.isRunningTest()){
                UpdateAutoCheckResponse = servicePro.callRestService('rest/api/v1/companies/1/creditcards/check?login_id='+repId,'PUT', Payload);
            }else{
                UpdateAutoCheckResponse = '{"statusCode":"100","statusMessage":"Successfultransaction","decision":"ACCEPT","authorizationReference":null,"successful":true,"cardKey1":2147417832,"cardKey2":25000,"cardKey3":17.00}';
            }
            System.debug('******UpdateAutoCheckResponse************'+UpdateAutoCheckResponse);
            if(!UpdateAutoCheckResponse.contains('"errorCode"'))
            {               
                DeserializeUpdateAutoCheck updateAutoChkData = (DeserializeUpdateAutoCheck)JSON.deserialize(UpdateAutoCheckResponse, DeserializeUpdateAutoCheck.class);
                System.debug('---------------updateAutoChkData-------------------'+updateAutoChkData);
                
                updateAutoCheck = new List<HomeBaseBeans.AddCardResponse>();
                if(updateAutoChkData != null){
                    HomeBaseBeans.AddCardResponse Ach = new HomeBaseBeans.AddCardResponse();
                    Ach.authorizationReference = updateAutoChkData.authorizationReference;
                    Ach.statusCode = updateAutoChkData.statusCode;
                    Ach.statusMessage = updateAutoChkData.statusMessage;
                    Ach.decision = updateAutoChkData.decision;
                    Ach.successful = updateAutoChkData.successful;
                    Ach.cardKey1 = updateAutoChkData.cardKey1;
                    Ach.cardKey2 = updateAutoChkData.cardKey2;
                    Ach.cardKey3 = updateAutoChkData.cardKey3;
                    updateAutoCheck.add(Ach);
                }
                return updateAutoCheck;
            }
            else
            { 
                updateAutoCheck = new List<HomeBaseBeans.AddCardResponse>();
                HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
                String errorMessage = QuickQuoteErrorHandler.handleError(UpdateAutoCheckResponse);
                h.errorMessage = errorMessage;
                updateAutoCheck.add(h); 
                return updateAutoCheck;
            }
            
        }
        catch(Exception e)
        {
            System.debug('***** response error '+e);
            String errorMessage = e.getMessage();
            updateAutoCheck = new List<HomeBaseBeans.AddCardResponse>();
            HomeBaseBeans.AddCardResponse h = new HomeBaseBeans.AddCardResponse();
            h.errorMessage = errorMessage;
            updateAutoCheck.add(h); 
            return updateAutoCheck;
        }
        
                
    }
    
    public class DeserializeUpdateAutoCheck
    {
        public String statusCode {get;set;}
        public String statusMessage {get;set;}
        public String decision {get;set;}
        public String authorizationReference {get;set;}
        public String successful {get;set;}
        public String cardKey1 {get;set;}
        public String cardKey2 {get;set;}
        public String cardKey3 {get;set;}
    }
    
    
    public List<HomeBaseBeans.AutocheckResponse> AddCardWithQuote(String repId, String Payload)
    {
        ServiceProxy servicePro = null;
        servicePro = new ServiceProxy();
        List<HomeBaseBeans.AutocheckResponse> AutoCheckResData = null;
        //String Payload = '{"mode":"REMOVE","accountId":"21200137","contactId":"6","type":"QUOTE","document_id":"101064197","cardKey1":-1407970299,"cardKey2":22000,"cardKey3":115.00}';
        if(!test.isRunningTest()){
            AddCardWithQuoteResponse = servicePro.callRestService('/rest/api/v1/companies/1/creditcards/attach_card?login_id='+repId,'POST', Payload);
            system.debug('---------------AddCardWithQuoteResponse---------------'+AddCardWithQuoteResponse);
        }else{
        	AddCardWithQuoteResponse = '{successful : true, statusMessage : ""}';
        }
        
        if(AddCardWithQuoteResponse != null && AddCardWithQuoteResponse != ''){               
            DeserializeAddCardWithQuote AutoChkResponse = (DeserializeAddCardWithQuote)JSON.deserialize(AddCardWithQuoteResponse, DeserializeAddCardWithQuote.class);
            System.debug('---------------AutoChkResponse------------------'+AutoChkResponse);
            
            AutoCheckResData = new List<HomeBaseBeans.AutocheckResponse>();
            if(AutoChkResponse != null){
                HomeBaseBeans.AutocheckResponse Ach = new HomeBaseBeans.AutocheckResponse();
                Ach.successful = AutoChkResponse.successful;
                Ach.statusMessage = AutoChkResponse.statusMessage;
                AutoCheckResData.add(Ach);
            }
            return AutoCheckResData;
        }
        
        return AutoCheckResData;
    }
    
    public class DeserializeAddCardWithQuote
    {
        public String successful{get;set;}
		public String statusMessage{get;set;}
    }
}