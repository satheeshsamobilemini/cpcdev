/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestFileUploadController {

    static testMethod void myUnitTest() {
    	User use = MMIFullquoteTestDataProvider.getUser();
    	insert use;
        Document doc = MMIFullquoteTestDataProvider.getDocument();
		doc.FolderId = use.id;
        insert doc;
        
        FileUploadController fileUp = new FileUploadController();
        
        Blob b = Blob.valueOf('Test Data');
        
        fileUp.strAttachFile = 'test file';
        fileUp.fileBody = b; 
        
        FileUploadController.wrapperClass wrp = new FileUploadController.wrapperClass();
        wrp.isCheckdoc = true;
        fileUp.saveDocumentInAttac();
        fileUp.save();
        
    }
    static testMethod void strAttachFile1() {
        FileUploadController fileUp = new FileUploadController();
        
        Blob b = Blob.valueOf('Test Data');
        
        fileUp.strAttachFile1 = 'Test Attachment for Parent' ;
        fileUp.fileBody1 = b; 
        
        FileUploadController.wrapperClass wrp = new FileUploadController.wrapperClass();
        wrp.isCheckdoc = true;
        fileUp.saveDocumentInAttac();
        fileUp.save();
        
    }
    static testMethod void strAttachFile2() {
        FileUploadController fileUp = new FileUploadController();
        
        Blob b = Blob.valueOf('Test Data');
        
        fileUp.strAttachFile2 = 'Test Attachment for Parent' ;
        fileUp.fileBody2 = b; 
        
        FileUploadController.wrapperClass wrp = new FileUploadController.wrapperClass();
        wrp.isCheckdoc = true;
        fileUp.saveDocumentInAttac();
        fileUp.save();
        
    }
    static testMethod void strAttachFile3() {
        FileUploadController fileUp = new FileUploadController();
        
        Blob b = Blob.valueOf('Test Data');
        
        fileUp.strAttachFile3 = 'Test Attachment for Parent' ;
        fileUp.fileBody3 = b; 
        
        FileUploadController.wrapperClass wrp = new FileUploadController.wrapperClass();
        wrp.isCheckdoc = true;
        fileUp.saveDocumentInAttac();
        fileUp.save();
        
    }
    static testMethod void strAttachFile4() {
        FileUploadController fileUp = new FileUploadController();
        
        Blob b = Blob.valueOf('Test Data');
        
        fileUp.strAttachFile4 = 'Test Attachment for Parent' ;
        fileUp.fileBody4 = b; 
        ApexPages.currentPage().getParameters().put('salesorg','1501');
        FileUploadController.wrapperClass wrp = new FileUploadController.wrapperClass();
        wrp.isCheckdoc = true;
        fileUp.saveDocumentInAttac();
        fileUp.save();
        
    }
    
    
}