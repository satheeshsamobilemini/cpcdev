/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SendEmailController {
    global String apiHost {
        get;
    }
    global String appHost {
        get;
    }
    global String staticHost {
        get;
    }
    global SendEmailController() {

    }
    @RemoteAction
    global static Map<String,String> createRelatedObjects(BRNSHRK.BrainsharkAPI.Session session, Id toEmailId, String subject, String messageBody, String pidString, String objId, List<BRNSHRK.SendEmailController.BrainsharkIntKeyPair> intKeys) {
        return null;
    }
    @RemoteAction
    global static BRNSHRK.SendEmailController.BrainsharkMessage getEmailTemplate(Id emailTemplateId, Id toId) {
        return null;
    }
    @RemoteAction
    global static BRNSHRK.SendEmailController.EmailFolderViewModel getFolderList(Integer pageNumber, Integer recordsPerPage) {
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
    global static Map<String,String> sendEmail(BRNSHRK.BrainsharkAPI.Session session, Id toEmailId, String cc, String subject, String messageBody, Boolean isBccMeSet, Boolean isViewReceiptSet) {
        return null;
    }
global class Brainshark {
    global Brainshark() {

    }
}
global class BrainsharkIntKeyPair {
    global BrainsharkIntKeyPair() {

    }
}
global class BrainsharkMessage {
    global BrainsharkMessage() {

    }
}
global class BrainsharkUserEmail {
    global BrainsharkUserEmail() {

    }
}
global class EmailFolderViewModel {
    global EmailFolderViewModel() {

    }
}
global class EmailTemplateModel {
    global EmailTemplateModel() {

    }
}
}
