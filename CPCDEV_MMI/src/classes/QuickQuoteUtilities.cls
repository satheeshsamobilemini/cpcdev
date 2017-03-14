/**************************************************************************
Name:  QuickQuoteUtilities()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains utility methods required for the 
Quick Quote related functionalities
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             12/3/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteUtilities {
    
    /*******************************************************************
    Purpose     : Return the available Duration options
    Parameters  : None
    Returns     : List  Duration options
    ********************************************************************/
    public static List<Selectoption> getDurationList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getDurationList');
        List<Selectoption> durationOptions=null;
        try{
            //Populate duration Options
            durationOptions=new List<Selectoption>();
            durationOptions.add(new Selectoption('1','1 Period') );
            durationOptions.add(new Selectoption('2','2 Period') );
            durationOptions.add(new Selectoption('3','3 Period') );
            durationOptions.add(new Selectoption('4','4 Period') );
            durationOptions.add(new Selectoption('5','5 Period') );
            durationOptions.add(new Selectoption('6','6 Period') );
            durationOptions.add(new Selectoption('7','7 Period') );
            durationOptions.add(new Selectoption('8','8 Period') );
            durationOptions.add(new Selectoption('9','9 Period') );
            durationOptions.add(new Selectoption('10','10 Period') );
            durationOptions.add(new Selectoption('11','11 Period') );
            durationOptions.add(new Selectoption('12','12 Period') );
            durationOptions.add(new Selectoption('13','13 Period') );
            durationOptions.add(new Selectoption('14','14 Period') );
            durationOptions.add(new Selectoption('15','15 Period') );
            durationOptions.add(new Selectoption('16','16 Period') );
            durationOptions.add(new Selectoption('17','17 Period') );
            durationOptions.add(new Selectoption('18','18 Period') );
            durationOptions.add(new Selectoption('19','19 Period') );
            durationOptions.add(new Selectoption('20','20 Period') );
            durationOptions.add(new Selectoption('21','21 Period') );
            durationOptions.add(new Selectoption('22','22 Period') );
            durationOptions.add(new Selectoption('23','23 Period') );
            durationOptions.add(new Selectoption('24','24 Period') );
            durationOptions.add(new Selectoption('25','25 Period') );
            durationOptions.add(new Selectoption('26','26 Period') );
            durationOptions.add(new Selectoption('27','27 Period') );
            durationOptions.add(new Selectoption('28','28 Period') );
            durationOptions.add(new Selectoption('29','29 Period') );
            durationOptions.add(new Selectoption('30','30 Period') );
            durationOptions.add(new Selectoption('31','31 Period') );
            durationOptions.add(new Selectoption('32','32 Period') );
            durationOptions.add(new Selectoption('33','33 Period') );
            durationOptions.add(new Selectoption('34','34 Period') );
            durationOptions.add(new Selectoption('35','35 Period') );
            durationOptions.add(new Selectoption('36','36 Period') );
            durationOptions.add(new Selectoption('37','37 Period') );
            durationOptions.add(new Selectoption('38','38 Period') );
            durationOptions.add(new Selectoption('39','39 Period') );
            durationOptions.add(new Selectoption('40','40 Period') );
            durationOptions.add(new Selectoption('41','41 Period') );
            durationOptions.add(new Selectoption('42','42 Period') );
            durationOptions.add(new Selectoption('43','43 Period') );
            durationOptions.add(new Selectoption('44','44 Period') );
            durationOptions.add(new Selectoption('45','45 Period') );
            durationOptions.add(new Selectoption('46','46 Period') );
            durationOptions.add(new Selectoption('47','47 Period') );
            durationOptions.add(new Selectoption('48','48 Period') );
            durationOptions.add(new Selectoption('49','49 Period') );
            durationOptions.add(new Selectoption('50','50 Period') );
            durationOptions.add(new Selectoption('51','51 Period') );
            durationOptions.add(new Selectoption('52','52 Period') );
            durationOptions.add(new Selectoption('53','53 Period') );
            durationOptions.add(new Selectoption('54','54 Period') );

        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving duration Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getDurationList'+durationOptions);
        return durationOptions;
    }
    
    /*******************************************************************
    Purpose     : Return the available Product Type options
    Parameters  : None
    Returns     : List  Product Type options
    ********************************************************************/
    public static List<Selectoption> getProductTypeList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getProductTypeList');
        List<Selectoption> productType=null;
        try{
            //Populate Product Type Options
            productType=new List<Selectoption>();
            productType.add(new Selectoption('','-None-') );
            productType.add(new Selectoption('CONT','Container') );
            productType.add(new Selectoption('SECURITY','Security') );
            productType.add(new Selectoption('MOBILE','Mobiles') );
            productType.add(new Selectoption('VTRAILER','Trailers') );
            productType.add(new Selectoption('','Other') );

        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving Product Type Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getProductTypeList'+productType);
        return productType;
    }
    
    /*******************************************************************
    Purpose     : Return the available Duration options
    Parameters  : None
    Returns     : List  Duration options
    ********************************************************************/
    public static List<Selectoption> getProductSizeList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getProductSizeList');
        List<Selectoption> productSize=null;
        try{
            //Populate Product Type Options
            productSize=new List<Selectoption>();
            productSize.add(new Selectoption('-None-','-None-') );
            productSize.add(new Selectoption('5-9','5-9') );
            productSize.add(new Selectoption('10-19','10-19') );
            productSize.add(new Selectoption('20-29','20-29') );
            productSize.add(new Selectoption('30-39','30-39') );
            productSize.add(new Selectoption('40+','40+') );

        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving Product Size Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getProductSizeList'+productSize);
        return productSize;
    }
    
     /*******************************************************************
    Purpose     : Return the available Product Type options
    Parameters  : None
    Returns     : List  Product Type options
    ********************************************************************/
    public static List<QuickQuoteWrapper.productTypes>  getProductTypeNewList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getProductTypeNewList');
        List<QuickQuoteWrapper.productTypes> productType=null;
        try{
            //Populate Product Type Options
            productType=new List<QuickQuoteWrapper.productTypes>();
            QuickQuoteWrapper.productTypes prodTyp=new QuickQuoteWrapper.productTypes();
            prodTyp.RecUniqId=1;
            prodTyp.isSelected=false;
            prodTyp.productType='Container';
            productType.add(prodTyp);
             QuickQuoteWrapper.productTypes prodTyp2=new QuickQuoteWrapper.productTypes();
            prodTyp2.RecUniqId=2;
            prodTyp2.isSelected=false;
            prodTyp2.productType='Security';
            productType.add(prodTyp2);
             QuickQuoteWrapper.productTypes prodTyp3=new QuickQuoteWrapper.productTypes();
            prodTyp3.RecUniqId=3;
            prodTyp3.isSelected=false;
            prodTyp3.productType='Mobiles';
             productType.add(prodTyp3);
             
             QuickQuoteWrapper.productTypes prodTyp4=new QuickQuoteWrapper.productTypes();
            prodTyp4.RecUniqId=4;
            prodTyp4.isSelected=false;
            prodTyp4.productType='Trailers';
            
             productType.add(prodTyp4);
             QuickQuoteWrapper.productTypes prodTyp5=new QuickQuoteWrapper.productTypes();
            prodTyp5.RecUniqId=5;
            prodTyp5.isSelected=false;
            prodTyp5.productType='Other';
            
             productType.add(prodTyp5);

        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving Product Type Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getProductTypeNewList'+productType);
        return productType;
    }
    
    /*******************************************************************
    Purpose     : Return the available Duration options
    Parameters  : None
    Returns     : List  Duration options
    ********************************************************************/
    public static List<QuickQuoteWrapper.productSizes> getProductSizeNewList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getProductSizeNewList');
        List<QuickQuoteWrapper.productSizes> productSize=null;
        try{
            //Populate Product Type Options
            productSize=new List<QuickQuoteWrapper.productSizes>();
            
            QuickQuoteWrapper.productSizes prodTyp=new QuickQuoteWrapper.productSizes();
            prodTyp.RecUniqId=1;
            prodTyp.isSelected=false;
            prodTyp.productSize='5-9';
            productSize.add(prodTyp);
             QuickQuoteWrapper.productSizes prodTyp2=new QuickQuoteWrapper.productSizes();
            prodTyp2.RecUniqId=2;
             prodTyp2.isSelected=false;
             prodTyp2.productSize='10-19';
            productSize.add(prodTyp2);
             QuickQuoteWrapper.productSizes prodTyp3=new QuickQuoteWrapper.productSizes();
            prodTyp3.RecUniqId=3;
             prodTyp3.isSelected=false;
             prodTyp3.productSize='20-29';
             productSize.add(prodTyp3);
             
             QuickQuoteWrapper.productSizes prodTyp4=new QuickQuoteWrapper.productSizes();
            prodTyp4.RecUniqId=4;
             prodTyp4.isSelected=false;
             prodTyp4.productSize='30-39';
            
             productSize.add(prodTyp4);
             QuickQuoteWrapper.productSizes prodTyp5=new QuickQuoteWrapper.productSizes();
            prodTyp5.RecUniqId=5;
             prodTyp5.isSelected=false;
             prodTyp5.productSize='40+';
            
             productSize.add(prodTyp5);
 
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving Product Size Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getProductSizeNewList'+productSize);
        return productSize;
    }
    
     /*******************************************************************
    Purpose     : Return the available Product Type options
    Parameters  : None
    Returns     : List  Product Type options
    ********************************************************************/
    public static List<FullQuoteWrapper.productTypes>  getProductTypeNewListFullQuote(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getProductTypeNewList');
        List<FullQuoteWrapper.productTypes> productType=null;
        try{
            //Populate Product Type Options
            productType=new List<FullQuoteWrapper.productTypes>();
            FullQuoteWrapper.productTypes prodTyp=new FullQuoteWrapper.productTypes();
            prodTyp.RecUniqId=1;
            prodTyp.isSelected=false;
            prodTyp.productType='Container';
            productType.add(prodTyp);
             FullQuoteWrapper.productTypes prodTyp2=new FullQuoteWrapper.productTypes();
            prodTyp2.RecUniqId=2;
            prodTyp2.isSelected=false;
            prodTyp2.productType='Security';
            productType.add(prodTyp2);
             FullQuoteWrapper.productTypes prodTyp3=new FullQuoteWrapper.productTypes();
            prodTyp3.RecUniqId=3;
            prodTyp3.isSelected=false;
            prodTyp3.productType='Mobiles';
             productType.add(prodTyp3);
             
             FullQuoteWrapper.productTypes prodTyp4=new FullQuoteWrapper.productTypes();
            prodTyp4.RecUniqId=4;
            prodTyp4.isSelected=false;
            prodTyp4.productType='Trailers';
            
             productType.add(prodTyp4);
             FullQuoteWrapper.productTypes prodTyp5=new FullQuoteWrapper.productTypes();
            prodTyp5.RecUniqId=5;
            prodTyp5.isSelected=false;
            prodTyp5.productType='Other';
            
             productType.add(prodTyp5);

        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving Product Type Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getProductTypeNewList'+productType);
        return productType;
    }
    
    /*******************************************************************
    Purpose     : Return the available Duration options
    Parameters  : None
    Returns     : List  Duration options
    ********************************************************************/
    public static List<FullQuoteWrapper.productSizes> getProductSizeNewListFullQuote(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteUtilities:getProductSizeNewList');
        List<FullQuoteWrapper.productSizes> productSize=null;
        try{
            //Populate Product Type Options
            productSize=new List<FullQuoteWrapper.productSizes>();
            
            FullQuoteWrapper.productSizes prodTyp=new FullQuoteWrapper.productSizes();
            prodTyp.RecUniqId=1;
            prodTyp.isSelected=false;
            prodTyp.productSize='5-9';
            productSize.add(prodTyp);
             FullQuoteWrapper.productSizes prodTyp2=new FullQuoteWrapper.productSizes();
            prodTyp2.RecUniqId=2;
             prodTyp2.isSelected=false;
             prodTyp2.productSize='10-19';
            productSize.add(prodTyp2);
             FullQuoteWrapper.productSizes prodTyp3=new FullQuoteWrapper.productSizes();
            prodTyp3.RecUniqId=3;
             prodTyp3.isSelected=false;
             prodTyp3.productSize='20-29';
             productSize.add(prodTyp3);
             
             FullQuoteWrapper.productSizes prodTyp4=new FullQuoteWrapper.productSizes();
            prodTyp4.RecUniqId=4;
             prodTyp4.isSelected=false;
             prodTyp4.productSize='30-39';
            
             productSize.add(prodTyp4);
             FullQuoteWrapper.productSizes prodTyp5=new FullQuoteWrapper.productSizes();
            prodTyp5.RecUniqId=5;
             prodTyp5.isSelected=false;
             prodTyp5.productSize='40+';
            
             productSize.add(prodTyp5);
 
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when retrieving Product Size Options'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'QuickQuoteUtilities:getProductSizeNewList'+productSize);
        return productSize;
    }
    
    
}