/**
* (c) 2015 TEKsystems Global Services
*
* Name           : CreateQuotePDF
* Created Date   : 31, Mar 2016 
* Created By     : Ankur Goyal (TEKSystems)
* Purpose        : This is class to create a PDF and attach to the quote header(Quote header detail page).
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 31-Mar-2016
**/

global class CreateQuotePDF{

    webservice static String createAndAttachPDF(ID quoteID, String salesOrgID, String type)
    {
         String pdfType;
         String pdfName;
         
         if(type== 'ZSLS')
             pdfType = 'Sales';
         else
             pdfType = 'Rental';
             
         if(salesOrgID == '1200'){ /*
            
            List<Attachment> attList = [select ID,parentid,name from attachment where parentid =:quoteID and name = 'QuotePDF.pdf'];
            if(!attList.isEmpty()){
                delete attList;
            }
            blob attachmentPdf = null;
            Pagereference pdfcont  = new PageReference('/apex/QuotePDF_UK?id='+quoteID+'&salorg='+salesOrgID);
            pdfcont.setRedirect(false);
            attachmentPdf = pdfcont.getContent(); 
            
            Attachment attach = new Attachment();
            Blob body;
            if(!test.isRunningTest()){
                body = attachmentPdf;  //.getContent();
            }else{
                body=blob.valueOf('TestString');
            }
            attach.Body = body;
            attach.Name = 'QuotePDF.pdf';
            attach.IsPrivate = false;
            attach.ParentId = quoteID; 
            attach.Description = 'Quote PDF';   
            insert attach; */
                           
        }    
        else if(salesOrgID == '1500' || salesOrgID == '1501'){
            
            pdfName = pdfType +'PDF.pdf';
            List<Attachment> attList = [select ID,parentid,name from attachment where parentid =:quoteID and name = :pdfName ];
            if(!attList.isEmpty()){
                delete attList;
            }
            blob attachmentPdf = null;
            Pagereference pdfcont1  = new PageReference('/apex/QuotePDF_ETS?quoteid='+quoteID+'&type='+pdfType+'&salorg='+salesOrgID);
            pdfcont1.setRedirect(false);
            //attachmentPdf = pdfcont1.getContent(); 
            
            Attachment attach = new Attachment();
            Blob body;
            if(!test.isRunningTest()){
                attachmentPdf = pdfcont1.getContent();
                body = attachmentPdf;  //.getContent();
            }else{
                body=blob.valueOf('TestString');
            }
            attach.Body = body;
            attach.Name = pdfName;
            attach.IsPrivate = false;
            attach.ParentId = quoteID; 
            attach.Description = 'Quote PDF';   
            insert attach;
            
        } 
        else{
        
            pdfName = pdfType +'PDF.pdf';
            List<Attachment> attList = [select ID,parentid,name from attachment where parentid =:quoteID and name = :pdfName ];
            if(!attList.isEmpty()){
                delete attList;
            }
            blob attachmentPdf = null;
            Pagereference pdfcont1  = new PageReference('/apex/QuotePDF_US?quoteid='+quoteID+'&type='+pdfType+'&salorg='+salesOrgID);
            pdfcont1.setRedirect(false);
         //   attachmentPdf = pdfcont1.getContent(); 
            
            Attachment attach = new Attachment();
            Blob body;
            if(!test.isRunningTest()){
                attachmentPdf = pdfcont1.getContent(); 
                body = attachmentPdf;  //.getContent();
               
            }else{
                body=blob.valueOf('TestString');
            }
            attach.Body = body;
            attach.Name = pdfName;
            attach.IsPrivate = false;
            attach.ParentId = quoteID; 
            attach.Description = 'Quote PDF';   
            insert attach;
            
        }
        
        return pdfName;
    }
}