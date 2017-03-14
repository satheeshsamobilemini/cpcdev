public with sharing class CapacityLookUpXMLParser_AC {
	public Capabilities[] CapabilitiesList{get;set;}
	public class Capabilities{
		public Map<String,List<String>> capValues=new Map<String,List<string>>();
	}
	public CapacityLookUpXMLParser_AC(){
		CapabilitiesList= new Capabilities[0];
	}
	public PageReference loadData(String response){
		
		/*string response = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><ns2:capacityResponse xmlns:ns2="http://capacity.services.operation.cuberoute.com"><return>'+
            				'<response><responseCode>Success</responseCode>'+
               					'<capacities>'+
                  					'<date>2013-05-08T04:00:00.000Z</date>'+		
                  					'<mileage>20.85073</mileage>'+
                  					'<storeNumber>941</storeNumber>'+
                  					'<storeType>Location</storeType>'+
                  					'<depotGroup>Rialto Tilt</depotGroup>'+
                  					'<amCapacity>0</amCapacity>'+
                  					'<pmCapacity>3</pmCapacity>'+
                  					'<noPrefCapacity>0</noPrefCapacity>'+
               					'</capacities>'+	
               					'<capacities>'+
                  					'<date>2013-05-09T04:00:00.000Z</date>'+
                  					'<mileage>20.85073</mileage>'+
                  					'<storeNumber>941</storeNumber>'+
                  					'<storeType>Location</storeType>'+
                  					'<depotGroup>Rialto Tilt</depotGroup>'+
                  					'<amCapacity>0</amCapacity>'+
                  					'<pmCapacity>3</pmCapacity>'+
                  					'<noPrefCapacity>0</noPrefCapacity>'+
               					'</capacities>'+
               				'<capacityReservationID xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            				'</response></return></ns2:capacityResponse></soapenv:Body></soapenv:Envelope>';*/
		XmlStreamReader reader = new XmlStreamReader(response);
		if(reader!=null)
		CapabilitiesList = parser(reader);
		system.debug('----------------CapabilitiesList-------------------'+CapabilitiesList);
		return null;
	} 
	public Capabilities[] parser(XmlStreamReader reader){
		Capabilities[] Capability = new Capabilities[0];
		while(reader.hasNext()){
			if (reader.getEventType() == XmlTag.START_ELEMENT) {
				System.debug('capability:'+reader.getEventType()+'name :'+reader.getLocalName());
            //if ('capacities' == reader.getLocalName()) {
            //  Pass the book to the parseBook method (below) 
            	System.debug('capability in if:'+reader.getLocalName());
                Capabilities cap = parseCap(reader);
                System.debug('capability:'+cap);
                Capability.add(cap);
            //}
         }
        reader.next();
		}
		system.debug('----Capability-----'+Capability);
		system.debug('----Capability--size---'+Capability.size());
		if(Capability.size()>0)
		{
			if((Capability[0].capValues).containsKey('amCapacity')){
				for(Integer i = 0; i<Capability[0].capValues.get('amCapacity').size(); i++)
				{
					HomeBaseBeans.CapacityLookupHandler r = new  HomeBaseBeans.CapacityLookupHandler();
					r.amCapacity = Capability[0].capValues.get('amCapacity')[i];
					r.pmCapacity = Capability[0].capValues.get('pmCapacity')[i];
					r.mileage = Capability[0].capValues.get('mileage')[i];
					r.storeNumber = Capability[0].capValues.get('storeNumber')[i];
					r.dateVal = Capability[0].capValues.get('date')[i];
					r.depotGroup = Capability[0].capValues.get('depotGroup')[i];
					r.storeType = Capability[0].capValues.get('storeType')[i];
					r.noPrefCapacity = Capability[0].capValues.get('noPrefCapacity')[i];
					responseHandlerList.add(r);
					
				}
			}
			system.debug('----Capability[0].capValues-----'+Capability[0].capValues);
			if((Capability[0].capValues).containsKey('faultstring')){
				for(Integer i = 0; i<Capability[0].capValues.get('faultstring').size(); i++)
				{
					HomeBaseBeans.CapacityLookupHandler r = new  HomeBaseBeans.CapacityLookupHandler();
					r.ErrorString = Capability[0].capValues.get('faultstring')[i];
					responseHandlerList.add(r);
					
				}
			}
			if((Capability[0].capValues).containsKey('responseCode')){
				for(Integer i = 0; i<Capability[0].capValues.get('responseCode').size(); i++)
				{
					
					system.debug('----Capability[0].capValues.get(responseCode)----'+Capability[0].capValues.get('responseCode'));
					if( Capability[0].capValues.get('responseCode')[i] == 'InvalidData'){
						HomeBaseBeans.CapacityLookupHandler r = new  HomeBaseBeans.CapacityLookupHandler();
						r.ErrorString = Capability[0].capValues.get('responseDescription')[i];
						responseHandlerList.add(r);
					}
					
				}
			}
		}
		System.debug('Maheshssssssssssssssss '+responseHandlerList);
		
    	return Capability;
	}
	public Capabilities parseCap(XmlStreamReader reader){
		Capabilities cap = new Capabilities();
		String cpval;
		String header;
     	while(reader.hasNext()) {
        if (reader.getEventType() == XmlTag.START_ELEMENT) {
        	header=reader.getLocalName();
        	System.debug('header '+header);
           
        }
        System.debug('++++++++++++reader.getEventType()+++++++++++++++++: '+reader.getEventType());
        //System.debug('++++++++++++reader.getText()+++++++++++++++++: '+reader.getText());
         if (reader.getEventType() == XmlTag.CHARACTERS) {
           cpval=reader.getText();
           System.debug(' value: '+cpval);
	        if(!cap.capValues.containsKey(header)) 
	        {
	        	cap.capValues.put(header,new List<String>{cpval});
	        }
	        else{
	        	cap.capValues.get(header).add(cpval);	
	        }
        }
        
        reader.next();
     	}
    	return cap;
	}
	
	public List<HomeBaseBeans.CapacityLookupHandler> responseHandlerList = new List<HomeBaseBeans.CapacityLookupHandler>();
	
	public List<HomeBaseBeans.CapacityLookupHandler> returnWebserviceResponse(String res)
	{
		if(res!=null)
		{
			loadData(res);
			return responseHandlerList;
		}
		else
		{
			return null;
		}
	}
}