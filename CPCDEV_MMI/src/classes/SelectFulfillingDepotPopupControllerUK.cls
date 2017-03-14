/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : SelectContactPopupControllerUK
 * Created Date   : 13 April 2015
 * Created By     : Vivek(TEK- DEV)
 * Purpose        : Controller class used by 'SelectFulfillingDepotPopup' VF page.
 *
 **/
public class SelectFulfillingDepotPopupControllerUK {
    //transient public List<Post_Code_Rate__c> lstDepot{get;set;}
    public Set < String > lstDepot {get;set;}
    transient public List < AggregateResult > lstBranch {get;set;}
    public String fulfildepot {get;set;}

    public SelectFulfillingDepotPopupControllerUK() {
        lstDepot = new Set < String > ();
        String fulfildepot = ApexPages.currentPage().getParameters().get('fulfildep');
        
        set<string> settbranchDetail = new set<string>();
        for(Branch_Detail__c bd: [select Branch_Address__c, Branch_Code__c, Branch_Email__c, Branch_Mobile__c, Branch_Phone__c,Branch_Name__c  from Branch_Detail__c])
        {
            settbranchDetail.add(bd.Branch_Name__c);
        }
        
        lstBranch = [select Service_Branch__c from Post_Code_Rate__c GROUP BY Service_Branch__c];
        for (AggregateResult ar: lstBranch) {
            system.debug(ar.get('Service_Branch__c'));
            if(settbranchDetail.contains(string.valueOf(ar.get('Service_Branch__c'))))
                   lstDepot.add(string.valueOf(ar.get('Service_Branch__c')));
        }
    }

}