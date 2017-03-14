/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SMF_WS_ImportUtils {
    global SMF_WS_ImportUtils() {

    }
    webService static String addVersionsToFolder(String folderId, List<String> versionsIds) {
        return null;
    }
    webService static String createFolders(List<sharem.SMF_WS_ImportUtils.FolderDTO> folders) {
        return null;
    }
    webService static String createUniqueFolder(sharem.SMF_WS_ImportUtils.FolderDTO folder) {
        return null;
    }
    webService static String deleteSObjects(String sObjectName, List<String> sObjectsIds) {
        return null;
    }
    @ReadOnly
    webService static String getParentsIds(sharem.SMF_WS_ImportUtils.ParentRelationshipInfo relationship, List<String> childObjectsIds) {
        return null;
    }
    webService static sharem.SMF_WS_ImportUtils.WebServiceInfo getWebServiceInfo() {
        return null;
    }
global class FolderDTO {
    webService String name {
        get;
        set;
    }
    webService String parentId {
        get;
        set;
    }
}
global class ParentRelationshipInfo {
    webService String childObjectName {
        get;
        set;
    }
    webService String parentFieldName {
        get;
        set;
    }
    global ParentRelationshipInfo() {

    }
}
global class WebServiceInfo {
    webService Integer allowedNewSmDocs {
        get;
        set;
    }
    webService Integer apiVersion {
        get;
        set;
    }
    webService Boolean canImportFolder {
        get;
        set;
    }
    webService String importAccessError {
        get;
        set;
    }
    webService Boolean isSmDocsLimitEnabled {
        get;
        set;
    }
    webService String smfVersion {
        get;
        set;
    }
    global WebServiceInfo() {

    }
}
}
