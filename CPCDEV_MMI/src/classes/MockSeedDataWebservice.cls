@isTest
global class MockSeedDataWebservice implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
       
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"Records": [{"Domain": "TRANSACTION_TYPE","DomainID": "MOC","DomainDescription": "Rental Offsite Construction","ParentDomainID": 1000}]}');
        res.setStatusCode(200);
        return res;
    }
}