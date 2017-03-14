/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class BaseBrainsharkComponentController {
    global String apiHost {
        get;
    }
    global String appHost {
        get;
    }
    global String authenticateUrl {
        get;
    }
    global Integer companyId {
        get;
    }
    global String returnUrl {
        get;
    }
    global String sessionJson {
        get;
    }
    global String staticHost {
        get;
    }
    global BaseBrainsharkComponentController() {

    }
    @RemoteAction
    global static Map<String,String> createRelatedObjects(BRNSHRK.BrainsharkAPI.Session session, Id toEmailId, String messageBody, String pidString, String objId, List<BRNSHRK.SendEmailController.BrainsharkIntKeyPair> intKeys) {
        return null;
    }
    @RemoteAction
    global static List<BRNSHRK.SendEmailController.BrainsharkIntKeyPair> getIntegrationKeys(BRNSHRK.BrainsharkAPI.Session session, String toId, String objId, String pidString, Boolean sendViewReceipt) {
        return null;
    }
    @RemoteAction
    global static BRNSHRK.SendEmailController.BrainsharkUserEmail getObjectEmail(Id objectId) {
        return null;
    }
    @RemoteAction
    global static BRNSHRK.BrainsharkModels.ToEmailViewModel getToEmailList(Id recordId, Integer pageNumber, Integer recordsPerPage) {
        return null;
    }
    @RemoteAction
    global static BRNSHRK.BrainsharkAPI.Session refreshSession() {
        return null;
    }
    @RemoteAction
    global static BRNSHRK.BrainsharkSearchResult searchBrainsharks(String searchType, String query) {
        return null;
    }
}
