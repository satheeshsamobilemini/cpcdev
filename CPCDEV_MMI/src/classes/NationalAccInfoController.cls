/********************************************************************************************
Name   : NationalAccInfoController
Usage  : Controller class of NationalAccInfo VF page which is used to display and edit
         "National Account Information" fields of related Account.
Author : Aashish Mathur
Date   : November 19, 2009
********************************************************************************************/

public class NationalAccInfoController {
    public Boolean editMode {get; private set;}
    
    private ApexPages.StandardController stdCont;
    private String pageRefUrl;
    
    public NationalAccInfoController(ApexPages.StandardController stdCont) {
        this.stdCont = stdCont;
        pageRefUrl = '/apex/NationalAccInfo?id=' + stdCont.getId() + '&editMode=';
        
        if (ApexPages.currentPage().getParameters().get('editMode') == 'true') {
            editMode = true;
        } else {
            editMode = false;
        }
    }
    
    public PageReference editAcc() {
        PageReference pageRef = new PageReference(pageRefUrl + 'true');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference saveAcc() {
        stdCont.save();
        return cancel();
    }
    
    public PageReference cancel() {
        PageReference pageRef =  new PageReference(pageRefUrl + 'false');
        pageRef.setRedirect(true);
        return pageRef;
    }
}