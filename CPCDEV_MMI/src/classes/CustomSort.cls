public with sharing class CustomSort {
	
	
    
    public static list<FullQuoteWrapper.quote> sortByLastDate(list<FullQuoteWrapper.quote> wrapperObject,String sortingOrder) {
       
       system.debug('##################'+wrapperObject);
       
        if(wrapperObject == null || wrapperObject.size() <= 1){
            return wrapperObject ;
        }
        
        
        
        List<FullQuoteWrapper.quote> lessSelectOption = new List<FullQuoteWrapper.quote>();
        List<FullQuoteWrapper.quote> greaterSelectOption = new List<FullQuoteWrapper.quote>();
        integer pivot = wrapperObject.size() / 2;
        
        //save the pivot and remove it from the wrapper list
        FullQuoteWrapper.quote pivotValue = wrapperObject[pivot];
        wrapperObject.remove(pivot);        
        for( FullQuoteWrapper.quote SO : wrapperObject){
        	
        	system.debug('##################@@@@'+SO);
        	if(SO.quoteCreated!=null && SO.quoteCreated!=''){
	            if(sortingOrder == 'Desc'){
	 
	                if( Date.valueOf(SO.quoteCreated) >  Date.valueOf(pivotValue.quoteCreated)){
	                    lessSelectOption.add(SO);
	                }else if( Date.valueOf(SO.quoteCreated) <= Date.valueOf(pivotValue.quoteCreated)){
	                    greaterSelectOption.add(SO);   
	                }
	            }else{
	                if( Date.valueOf(SO.quoteCreated) <= Date.valueOf(pivotValue.quoteCreated)){
	                    lessSelectOption.add(SO);
	                }else if(Date.valueOf(SO.quoteCreated) > Date.valueOf(pivotValue.quoteCreated)){
	                    greaterSelectOption.add(SO);   
	                }
	            }
            
            }
            
        }
        list<FullQuoteWrapper.quote> sortedSelectOptions = new list<FullQuoteWrapper.quote>(); 
        sortedSelectOptions.addAll(sortByLastDate(lessSelectOption,sortingOrder));
        sortedSelectOptions.add(pivotValue);
        sortedSelectOptions.addAll(sortByLastDate(greaterSelectOption,sortingOrder));
        return SortedSelectOptions;
    }
    
    
     

}