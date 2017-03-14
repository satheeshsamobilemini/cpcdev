public with sharing class EmailTempalteBodyGeneraterUtil {
	public static String finalBody {get;set;}
	public static EmailTemplate etObj {get;set;}
	public static String accOwnerId {get;set;}
	
	public static String generateEmailBody(String QuoteId,String OpportunityId,String AccountId,String ContactId, String QuoteType, String TemplateId){
		list<EmailTemplate> et =[Select e.TemplateType, e.TemplateStyle, e.Subject, e.Name, e.IsActive, e.Id, e.Folder.Name, e.Folder.Id, e.FolderId, e.DeveloperName, e.Description, e.Body,e.HtmlValue From EmailTemplate e where e.Id = :TemplateId];
		// 00XQ0000000QzfX text template id
		// 00XQ0000000Qziq html template id
		
		system.debug('------et.Folder.Name------'+et[0].Folder.Name);
		system.debug('------et.body------'+et[0].Body);
		system.debug('------et.HtmlValue------'+et[0].HtmlValue);
		system.debug('------et.id------'+et[0].Id);
		//String modifiedBody = et[0].HtmlValue; // for html template
		String modifiedBody = et[0].Body; // for text template
		//==================================================Final========================================================
		if(ContactId != null && ContactId != '' && modifiedBody.contains('{!Contact.')){
			modifiedBody = mergeContactFields(modifiedBody, ContactId); // get all Contact Field Merged
		}
		if(AccountId != null && AccountId != '' && modifiedBody.contains('{!Account.')){
			modifiedBody = mergeAccountFields(modifiedBody, AccountId); // get all Account Field Merged
		}
		if(OpportunityId != null && OpportunityId != '' && modifiedBody.contains('{!Opportunity.')){
			modifiedBody = mergeOpportunityFields(modifiedBody, OpportunityId); // get all Opportunity Field Merged
		}
		if(QuoteType == 'qq' && QuoteId != null && QuoteId != '' && modifiedBody.contains('{!MMI_Quotes__c.')){
			modifiedBody = mergeQQFields(modifiedBody, QuoteId); // get all Quick Quote Field Merged
		}
		if(QuoteType == 'fq' && QuoteId != null && QuoteId != '' && modifiedBody.contains('{!MMI_Full_Quotes__c.')){
			modifiedBody = mergeFQFields(modifiedBody, QuoteId); // get all Full Quote Field Merged
		}
		if(modifiedBody.contains('{!User.')){
			modifiedBody = mergeUserFields(modifiedBody, UserInfo.getUserId()); // get all User Field Merged
		}
		if(accOwnerId != null && accOwnerId != '' && modifiedBody.contains('{!Account.Owner')){
			modifiedBody = mergeAccountOwnerUserFields(modifiedBody, accOwnerId); // get all AccountOwner User Field Merged
		}
		//-----------------for html template-----------------------------------------------------------------------
		
		//modifiedBody = modifiedBody.replaceAll('<!\\[CDATA\\[', ''); // i.e. '<![CDATA['
		//modifiedBody = modifiedBody.replaceAll('\\]\\]>', ''); // i.e. ']]'
		
		//-----------------for html template-----------------------------------------------------------------------
		
		//***************************************************************************************************************
		
		//-----------------for text template-----------------------------------------------------------------------
		
		//modifiedBody = modifiedBody.replaceAll('\n','<br/>'); // convert text to html
		
		//-----------------for text template-----------------------------------------------------------------------
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		EmailTemplate etModObj = new EmailTemplate();
		
		etModObj.Body = modifiedBody;
		etModObj.HtmlValue = modifiedBody;
		etObj = etModObj;
		//sendEmail(modifiedBody);
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate an email body with all Contact field replaced
    Parameters  : Email template body and Contact Id
    Returns     : Email template body with Contact merge fields replaced
    **********************************************************************/
	public static String mergeContactFields(String emailTemplateBody, String ConId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapCon = Schema.SObjectType.Contact.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapCon);
		
		String contactQuery = 'Select ';
		for (String fieldName: schemaFieldMapCon.keySet()) {
			contactQuery += fieldName + ',';
		}
		
		contactQuery = contactQuery.substring(0,contactQuery.length() - 1);
		contactQuery += ' from Contact where Id =\''+ConId+'\'';
		
		Contact conObject = database.query(contactQuery);
		Map<String, Object> queriedConFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(conObject));
		set<String> setConFlds = new set<String>();
		for(String s: queriedConFieldValues.keySet()){
			setConFlds.add(s);
		}
		system.debug('------setConFlds----------'+setConFlds);
		for(String cf : setConFlds){
			system.debug('------cf---------------'+cf);
			
			if(modifiedBody.contains('{!Contact.'+cf+'}')){
				/*Contact con = conObject;
				String fldTyp = fildAndTyp.get(cf);
				system.debug('------fldTyp---------------'+fldTyp);
				if(fldTyp == 'DOUBLE'){
					Decimal price = (Decimal) con.get(cf);
					modifiedBody = modifiedBody.replace('{!Contact.'+cf+'}',String.valueOf(price));
				}else if(fldTyp == 'DATETIME'){
					String dateTimeStr = String.valueOf(con.get(cf));
					modifiedBody = modifiedBody.replace('{!Contact.'+cf+'}',dateTimeStr);
				}else if(fldTyp == 'DATE'){
					String dateStr = String.valueOf(con.get(cf));
					dateStr = dateStr.substring(0,10);
					modifiedBody = modifiedBody.replace('{!Contact.'+cf+'}',dateStr);
				}else{
					modifiedBody = modifiedBody.replace('{!Contact.'+cf+'}',(String) con.get(cf));
				}*/
				modifiedBody = typeConversion(modifiedBody, 'Contact',conObject,cf,fildAndTyp);
			}
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate an email body with all Account field replaced
    Parameters  : Email template body and Account Id
    Returns     : Email template body with Account merge fields replaced
    **********************************************************************/
	public static String mergeAccountFields(String emailTemplateBody, String AccId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapAcc = Schema.SObjectType.Account.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapAcc);
		
		String AccountQuery = 'Select ';
		for (String fieldName: schemaFieldMapAcc.keySet()) {
			AccountQuery += fieldName + ',';
		}
		
		AccountQuery = AccountQuery.substring(0,AccountQuery.length() - 1);
		AccountQuery += ' from Account where Id =\''+AccId+'\'';
		
		Account accObject = database.query(AccountQuery);
		if(accObject != null){
			accOwnerId = accObject.OwnerId;
		}
		Map<String, Object> queriedAccFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(accObject));
		set<String> setAccFlds = new set<String>();
		for(String s: queriedAccFieldValues.keySet()){
			setAccFlds.add(s);
		}
		system.debug('------setAccFlds----------'+setAccFlds);
		for(String cf : setAccFlds){
			system.debug('------cf---------------'+cf);
			
			if(modifiedBody.contains('{!Account.'+cf+'}')){
				/*Account acc = accObject;
				String fldTyp = fildAndTyp.get(cf);
				if(fldTyp == 'DOUBLE'){
					Decimal price = (Decimal) acc.get(cf);
					modifiedBody = modifiedBody.replace('{!Account.'+cf+'}',String.valueOf(price));
				}else if(fldTyp == 'DATETIME'){
					String dateTimeStr = String.valueOf(acc.get(cf));
					modifiedBody = modifiedBody.replace('{!Account.'+cf+'}',dateTimeStr);
				}else if(fldTyp == 'DATE'){
					String dateStr = String.valueOf(acc.get(cf));
					dateStr = dateStr.substring(0,10);
					modifiedBody = modifiedBody.replace('{!Account.'+cf+'}',dateStr);
				}else{
					modifiedBody = modifiedBody.replace('{!Account.'+cf+'}',(String) acc.get(cf));
				}*/
				modifiedBody = typeConversion(modifiedBody, 'Account',accObject,cf,fildAndTyp);
			}
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate an email body with all Opportunity field replaced
    Parameters  : Email template body and Opportunity Id
    Returns     : Email template body with Opportunity merge fields replaced
    **********************************************************************/
	public static String mergeOpportunityFields(String emailTemplateBody, String OppId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapOpp = Schema.SObjectType.Opportunity.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapOpp);
		
		String OpportunityQuery = 'Select ';
		for (String fieldName: schemaFieldMapOpp.keySet()) {
			OpportunityQuery += fieldName + ',';
		}
		
		OpportunityQuery = OpportunityQuery.substring(0,OpportunityQuery.length() - 1);
		OpportunityQuery += ' from Opportunity where Id =\''+OppId+'\'';
		
		Opportunity oppObject = database.query(OpportunityQuery);
		Map<String, Object> queriedOppFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(oppObject));
		set<String> setOppFlds = new set<String>();
		for(String s: queriedOppFieldValues.keySet()){
			setOppFlds.add(s);
		}
		system.debug('------setOppFlds----------'+setOppFlds);
		for(String cf : setOppFlds){
			system.debug('------cf---------------'+cf);
			
			if(modifiedBody.contains('{!Opportunity.'+cf+'}')){
				/*Opportunity opp = oppObject;
				String fldTyp = fildAndTyp.get(cf);
				if(fldTyp == 'DOUBLE'){
					Decimal price = (Decimal) opp.get(cf);
					modifiedBody = modifiedBody.replace('{!Opportunity.'+cf+'}',String.valueOf(price));
				}else if(fldTyp == 'DATETIME'){
					String dateTimeStr = String.valueOf(opp.get(cf));
					modifiedBody = modifiedBody.replace('{!Opportunity.'+cf+'}',dateTimeStr);
				}else if(fldTyp == 'DATE'){
					String dateStr = String.valueOf(opp.get(cf));
					dateStr = dateStr.substring(0,10);
					modifiedBody = modifiedBody.replace('{!Opportunity.'+cf+'}',dateStr);
				}else{
					modifiedBody = modifiedBody.replace('{!Opportunity.'+cf+'}',(String) opp.get(cf));
				}*/
				modifiedBody = typeConversion(modifiedBody, 'Opportunity',oppObject,cf,fildAndTyp);
			}
			
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	
	/*********************************************************************
    Purpose     : To generate an email body with all Quick Quote field replaced
    Parameters  : Email template body and Quick Quote Id
    Returns     : Email template body with Quick Quote merge fields replaced
    **********************************************************************/
	public static String mergeQQFields(String emailTemplateBody, String qqId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapQQ = Schema.SObjectType.MMI_Quotes__c.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapQQ);
		
		String qqQuery = 'Select ';
		for (String fieldName: schemaFieldMapQQ.keySet()) {
			qqQuery += fieldName + ',';
		}
		
		qqQuery = qqQuery.substring(0,qqQuery.length() - 1);
		qqQuery += ' from MMI_Quotes__c where Id =\''+qqId+'\'';
		
		MMI_Quotes__c qqObject = database.query(qqQuery);
		Map<String, Object> queriedqqFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(qqObject));
		set<String> setqqFlds = new set<String>();
		for(String s: queriedqqFieldValues.keySet()){
			setqqFlds.add(s);
		}
		system.debug('------setqqFlds----------'+setqqFlds);
		for(String cf : setqqFlds){
			system.debug('------cf---------------'+cf);
			
			if(modifiedBody.contains('{!MMI_Quotes__c.'+cf+'}')){
				/*MMI_Quotes__c qq = qqObject;
				String fldTyp = fildAndTyp.get(cf);
				if(fldTyp == 'DOUBLE'){
					Decimal price = (Decimal) qq.get(cf);
					modifiedBody = modifiedBody.replace('{!MMI_Quotes__c.'+cf+'}',String.valueOf(price));
				}else if(fldTyp == 'DATETIME'){
					String dateTimeStr = String.valueOf(qq.get(cf));
					modifiedBody = modifiedBody.replace('{!MMI_Quotes__c.'+cf+'}',dateTimeStr);
				}else if(fldTyp == 'DATE'){
					String dateStr = String.valueOf(qq.get(cf));
					dateStr = dateStr.substring(0,10);
					modifiedBody = modifiedBody.replace('{!MMI_Quotes__c.'+cf+'}',dateStr);
				}else{
					modifiedBody = modifiedBody.replace('{!MMI_Quotes__c.'+cf+'}',(String) qq.get(cf));
				}*/
				modifiedBody = typeConversion(modifiedBody, 'MMI_Quotes__c',qqObject,cf,fildAndTyp);
			}
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate an email body with all Full Quote field replaced
    Parameters  : Email template body and Full Quote Id
    Returns     : Email template body with Full Quote merge fields replaced
    **********************************************************************/
	public static String mergeFQFields(String emailTemplateBody, String fqId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapFQ = Schema.SObjectType.MMI_Full_Quotes__c.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapFQ);
		
		String fqQuery = 'Select ';
		for (String fieldName: schemaFieldMapFQ.keySet()) {
			fqQuery += fieldName + ',';
		}
		
		fqQuery = fqQuery.substring(0,fqQuery.length() - 1);
		fqQuery += ' from MMI_Full_Quotes__c where Id =\''+fqId+'\'';
		
		MMI_Full_Quotes__c fqObject = database.query(fqQuery);
		Map<String, Object> queriedfqFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(fqObject));
		set<String> setfqFlds = new set<String>();
		for(String s: queriedfqFieldValues.keySet()){
			setfqFlds.add(s);
		}
		system.debug('------setfqFlds----------'+setfqFlds);
		for(String cf : setfqFlds){
			system.debug('------cf---------------'+cf);
			
			if(modifiedBody.contains('{!MMI_Full_Quotes__c.'+cf+'}')){
				/*MMI_Full_Quotes__c fq = fqObject;
				String fldTyp = fildAndTyp.get(cf);
				if(fldTyp == 'DOUBLE'){
					Decimal price = (Decimal) fq.get(cf);
					modifiedBody = modifiedBody.replace('{!MMI_Full_Quotes__c.'+cf+'}',String.valueOf(price));
				}else if(fldTyp == 'DATETIME'){
					String dateTimeStr = String.valueOf(fq.get(cf));
					modifiedBody = modifiedBody.replace('{!MMI_Full_Quotes__c.'+cf+'}',dateTimeStr);
				}else if(fldTyp == 'DATE'){
					String dateStr = String.valueOf(fq.get(cf));
					dateStr = dateStr.substring(0,10);
					modifiedBody = modifiedBody.replace('{!MMI_Full_Quotes__c.'+cf+'}',dateStr);
				}else{
					modifiedBody = modifiedBody.replace('{!MMI_Full_Quotes__c.'+cf+'}',(String) fq.get(cf));
				}*/
				modifiedBody = typeConversion(modifiedBody, 'MMI_Full_Quotes__c',fqObject,cf,fildAndTyp);
				
			}
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate an email body with all User field replaced
    Parameters  : Email template body and User Id
    Returns     : Email template body with User merge fields replaced
    **********************************************************************/
	public static String mergeUserFields(String emailTemplateBody, String UserId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapUser = Schema.SObjectType.User.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapUser);
		
		String UserQuery = 'Select ';
		for (String fieldName: schemaFieldMapUser.keySet()) {
			UserQuery += fieldName + ',';
		}
		
		UserQuery = UserQuery.substring(0,UserQuery.length() - 1);
		UserQuery += ' from User where Id =\''+UserId+'\'';
		
		User UserObject = database.query(UserQuery);
		Map<String, Object> queriedUserFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(UserObject));
		set<String> setUserFlds = new set<String>();
		for(String s: queriedUserFieldValues.keySet()){
			setUserFlds.add(s);
		}
		system.debug('------setUserFlds----------'+setUserFlds);
		for(String cf : setUserFlds){
			system.debug('------cf---------------'+cf);
			if(modifiedBody.contains('{!User.'+cf+'}')){
				modifiedBody = typeConversion(modifiedBody, 'User',UserObject,cf,fildAndTyp);
			}
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate an email body with all AccountOwner field replaced
    Parameters  : Email template body and AccountOwner Id
    Returns     : Email template body with AccountOwner merge fields replaced
    **********************************************************************/
	public static String mergeAccountOwnerUserFields(String emailTemplateBody, String UserId){
		String modifiedBody = emailTemplateBody;
		Map<String, Schema.SObjectField> schemaFieldMapUser = Schema.SObjectType.User.fields.getMap();
		map<String,String> fildAndTyp = new map<String,String>();
		fildAndTyp = generateFldTypeMap(schemaFieldMapUser);
		
		String UserQuery = 'Select ';
		for (String fieldName: schemaFieldMapUser.keySet()) {
			UserQuery += fieldName + ',';
		}
		
		UserQuery = UserQuery.substring(0,UserQuery.length() - 1);
		UserQuery += ' from User where Id =\''+UserId+'\'';
		
		User UserObject = database.query(UserQuery);
		system.debug('------User Phone----------'+UserObject.get('Phone'));
		Map<String, Object> queriedUserFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(UserObject));
		set<String> setUserFlds = new set<String>();
		for(String s: queriedUserFieldValues.keySet()){
			setUserFlds.add(s);
		}
		system.debug('------setUserFlds----------'+setUserFlds);
		if(modifiedBody.contains('{!Account.OwnerFullName}')){
			modifiedBody = modifiedBody.replace('{!Account.OwnerFullName}', '{!Account.OwnerName}');
		}
		for(String cf : setUserFlds){
			system.debug('------cf---------------'+cf);
			if(accOwnerId != null && accOwnerId != ''){
				if(modifiedBody.contains('{!Account.Owner'+cf+'}')){
					modifiedBody = typeConversion(modifiedBody, 'Account.Owner',UserObject,cf,fildAndTyp);
				}
			}
		}
		
		system.debug('------modifiedBody--------------'+modifiedBody);
		return modifiedBody;
	}
	
	
	public static String typeConversion(String TemplateBody, String ObjectApiName, sObject ObjectRecord, String objectFieldApiName, map<String,String> fildAndTyp){
		String modifiedBody = TemplateBody;
		sObject RecordVal = ObjectRecord;
		String cf = objectFieldApiName;
		String fldTyp = fildAndTyp.get(cf);
		if(fldTyp == 'DOUBLE'){
			if(RecordVal.get(cf) != null){
				Decimal price = (Decimal) RecordVal.get(cf);
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}',String.valueOf(price));
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}',String.valueOf(price));
				}
			}else{
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}','');
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}','');
				}
			}
		}else if(fldTyp == 'DATETIME'){
			if(RecordVal.get(cf) != null){
				String dateTimeStr = String.valueOf(RecordVal.get(cf));
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}',dateTimeStr);
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}',dateTimeStr);
				}
			}else{
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}','');
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}','');
				}
			}
		}else if(fldTyp == 'DATE'){
			if(RecordVal.get(cf) != null){
				String dateStr = String.valueOf(RecordVal.get(cf));
				dateStr = dateStr.substring(0,10);
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}',dateStr);
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}',dateStr);
				}
			}else{
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}','');
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}','');
				}
			}
		}else{
			if(RecordVal.get(cf) != null){
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}',(String) RecordVal.get(cf));
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}',(String) RecordVal.get(cf));
				}
			}else{
				if(ObjectApiName == 'Account.Owner'){
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+''+cf+'}','');
				}else{
					modifiedBody = modifiedBody.replace('{!'+ObjectApiName+'.'+cf+'}','');
				}
			}
		}
		
		return modifiedBody;
	}
	
	/*********************************************************************
    Purpose     : To generate a map of Field name as ket and Field Type as value
    Parameters  : map of String and Schema.SObjectField
    Returns     : map of Field name as ket and Field Type as value
    **********************************************************************/
	public static map<String,String> generateFldTypeMap(Map<String, Schema.SObjectField> mapSchemaFld){
		map<String,String> mapFieldType = new map<String,String>();
		for(Schema.SObjectField sc : mapSchemaFld.values()){
				Schema.DescribeFieldResult flsDesc = sc.getDescribe();
				Schema.DisplayType fldDispTyp = flsDesc.getType();
				mapFieldType.put(String.valueOf(sc), String.valueOf(fldDispTyp));
		}
		return mapFieldType;
	}
	
	
	/*********************************************************************
    Purpose     : To send the mail
    Parameters  : String type template body
    Returns     : none
    **********************************************************************/
	public static void sendEmail(String templateBody){
		User loginUserRec = [Select Id,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c,UserRole.Name,Street,City,State,PostalCode,MobilePhone from User where Id = :UserInfo.getUserId()];
		List<Messaging.Singleemailmessage> emails = new List<Messaging.Singleemailmessage>();
		List<String> mailIds = new List<string>();
		mailIds.add('rmaity@teksystems.com');
		mailIds.add('maity.it@gmail.com');
		Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
		mail.setToAddresses(mailIds);
        mail.setSubject('test template');
        String UserSign = generateSignature(loginUserRec);
        
        //mail.setPlainTextBody(etObj.Body);
        mail.setHtmlBody(templateBody + UserSign);
        mail.setUseSignature(false);
        emails.add(mail);
        Messaging.sendEmail(emails);
	}
	
	/*********************************************************************
    Purpose     : To generate the user signature
    Parameters  : User Record
    Returns     : User signature as a HTML String
    **********************************************************************/
	 public static string generateSignature(User uRec){
      	String UserSign = '';
      	UserSign += '<br/><br/><br/><table align="left"><tr><td><b>'+uRec.Name+'</b></td></tr><tr><td>'+uRec.UserRole.Name+'</td></tr><tr><td>';
      	if(uRec.Street != null && uRec.Street != ''){
      		UserSign += uRec.Street+'|';
      	}
      	if(uRec.City != null && uRec.City != ''){
      		UserSign += uRec.City+' ';
      	}
      	if(uRec.State != null && uRec.State != ''){
      		UserSign += uRec.State+' ';
      	}
      	if(uRec.PostalCode != null && uRec.PostalCode != ''){
      		UserSign += uRec.PostalCode+' ';
      	}
      	UserSign += '</td></tr><tr><td>o:';
      	if(uRec.Phone != null && uRec.Phone != ''){
      		UserSign += uRec.Phone+','+uRec.Extension__c;
      	}
      	UserSign += '</td></tr><tr><td>m:';
      	if(uRec.MobilePhone != null && uRec.MobilePhone != ''){
      		UserSign += uRec.MobilePhone;
      	}
      	UserSign += '</td></tr><tr><td>';
      	if(uRec.Email != null && uRec.Email != ''){
      		UserSign += uRec.Email;
      	}
      	UserSign += '</td></tr><tr><td><img src="https://c.na6.content.force.com/servlet/servlet.ImageServer?id=01580000001rJ2A&oid=00D80000000azTL" /></td></tr></table>';
      	return UserSign;
      } 

}