/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */
global class LivePersonLeadCreation implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
	
	String body = email.plainTextBody;
		List<String> parts = body.split('\n');
		Lead l = new Lead();
		Integer i = 0;
		Integer j = 0;
		for(String s : parts) {
		  if(s.contains('[From Name:]')) {
		  	l.Company = s.substring(s.lastIndexOf(']') + 2);
		  	String k = s.substring(s.lastIndexOf(']') + 2);
		  	List<String>names = k.split(' ');
		  	l.FirstName = names.get(0); 
		  	if(names.size() > 1) //contains last name
		  	  l.LastName = k.substring(k.indexOf(names.get(1)));
		  	else
		  	  l.LastName = names.get(0);
		  }
		  if(s.contains('[From e-mail address: ]')) {
		  	if(s.lastIndexOf(']') + 1 < s.length())
		  	  l.Email = s.substring(s.lastIndexOf(']') + 2);
		  }
		  if(s.contains('[Phone Number:]')) {
		  	if(s.lastIndexOf(']') + 1 < s.length())
		  	  l.Phone = s.substring(s.lastIndexOf(']') + 2);
		  }
		  if(s.contains('[Message/Comments:]')) {
		  	j = i;
		  }
		  if(s.contains('[Zip Code:]')) {
		  	if(s.lastIndexOf(']') + 1 < s.length())
		  	  l.PostalCode = s.substring(s.lastIndexOf(']') + 2);
		  }
		  i++;  	
		}
		if(parts.get(j) != null && parts.get(j).lastIndexOf(']') + 1 < parts.get(j).length()) {
		  String descr = parts.get(j).substring(parts.get(j).lastIndexOf(']') + 2) + '\n';
		  for(Integer k = j+1; k < parts.size(); k++) {
		  	if(parts.get(k).contains('[Zip Code:]'))
		  	  break;
		  	else
		  	  descr += parts.get(k) + '\n';
		  }
		  l.description = descr;
		}
		 
		 
		if(l.Phone != null && l.Phone != '')
		  l.Primary_Contact_Method__c = 'Phone';
		else if(l.Email != null && l.Email != '')
		  l.Primary_Contact_Method__c = 'Email';
		l.LeadSource = 'Live Chat';
		l.Rating = 'Hot (Probably Order)';
		l.Auto_Assign_Lead__c = true;
		List<RecordType> rt = [Select id from RecordType where name = 'Standard Lead'];
		if(rt.size() > 0)
		l.RecordTypeId = rt.get(0).id;
		   
		insert l;   
	
        return result;
    }
}