@isTest
private class TestService800CSVfileByEmail {

    static testMethod void testService800CSVfileByEmail() {
       Account objAccount = new Account();
        objAccount.Name ='Net Promoter Scores';
       insert objAccount;
        
       Messaging.SingleEmailMessage outMail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {'service800@35kgxrj7xg8dn65mk7upavs4o.in.sandbox.salesforce.com'};
       string body = 'testbody';
       string subject = 'testService800CSV';
       outMail.setToAddresses(toAddresses);
       outMail.setPlainTextBody(body);
       outMail.setSubject(subject);
       //Blob csvblob =  Blob.valueOf('923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"113"|"4"|"WESTERN"|"UNKNOWN"|"40ZS"|"REPEAT BUSINESS"|""|"918-622-8804"|""|""|""||10|10|9|10|||||10|""|"PRODUCT APPEARANCE');
       //string csvstring = '923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"113"|"4"|"WESTERN"|"UNKNOWN"|"40ZS"|"REPEAT BUSINESS"|""|"918-622-8804"|""|""|""||10|10|9|10|||||10|""|"PRODUCT APPEARANCE';
       //Blob csvblob = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016|Good Product||Sale||Yes|2/1/2016 8:11:00 AM');
       //string csvstring = '4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016|Good Product||Sale||Yes|2/1/2016 8:11:00 AM';
       Blob csvblob = Blob.valueOf('924115|3M|1000009857|0010120537|0010120537|DANIA CUT HOLDINGS|BRIAN|954-923-9545|05/04/2016 4:00:00 AM|00140877|Inside Sales Representative|Dania|FL|33004|Test Job|Delivery|GROUND LEVEL OFFICES|Monthly Recurring|US|103|Miami|Region 6|East|Retail Trade|20W|SHIRLEY BEDFORD|(954) 923-9545|(984) 903-9985|MOC|Z01|10|10|10|10|10|10|8|8|9|3|WORK ON THE BILLING AND PICK UP TIMES|6|I DIDNT PUT IN MUCH EFFORT, I JUST CALLED THEY TOOK CARE OF IT|Ease of Requesting S|NO, THEY DO GOOD TO THEIR EXPECTATIONS|0|0|RATE 14 = 0, 1|Yes|5/08/2016 08:47:00 PM|Yes|5|2016|concerned on locking system,will send service tech out|5/19/2016 12:00:00 AM|PICK UP ISSUE|5/19/2016 12:00:00 AM|YES|5/19/2016 12:00:00 AM');
       string csvstring = '924115|3M|1000009857|0010120537|0010120537|DANIA CUT HOLDINGS|BRIAN|954-923-9545|05/04/2016 4:00:00 AM|00140877|Inside Sales Representative|Dania|FL|33004|Test Job|Delivery|GROUND LEVEL OFFICES|Monthly Recurring|US|103|Miami|Region 6|East|Retail Trade|20W|SHIRLEY BEDFORD|(954) 923-9545|(984) 903-9985|MOC|Z01|10|10|10|10|10|10|8|8|9|3|WORK ON THE BILLING AND PICK UP TIMES|6|I DIDNT PUT IN MUCH EFFORT, I JUST CALLED THEY TOOK CARE OF IT|Ease of Requesting S|NO, THEY DO GOOD TO THEIR EXPECTATIONS|0|0|RATE 14 = 0, 1|Yes|5/08/2016 08:47:00 PM|Yes|5|2016|concerned on locking system,will send service tech out|5/19/2016 12:00:00 AM|PICK UP ISSUE|5/19/2016 12:00:00 AM|YES|5/19/2016 12:00:00 AM';
              
       Attachment attachment = new Attachment(); 
       attachment.body =  csvblob ; 
       attachment.NAme = 'CSVTest.csv' ; 
       
       
      
       Messaging.EmailFileAttachment[] fileAttachments = new Messaging.EmailFileAttachment[1];
       Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
       fileAttachment.setBody(attachment.body); 
       fileAttachment.setFileName(attachment.Name); 
       fileAttachments[0] = fileAttachment;
       outMail.setFileAttachments(fileAttachments);
      
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment.body = csvblob;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.textattachment txtattachment = new Messaging.InboundEmail.textattachment();
       txtattachment.body = csvstring;
       inboundEmail.textAttachments = new Messaging.InboundEmail.textattachment[]{txtattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       //Blob csvblob2 =  Blob.valueOf('923769|"107014631"|"3M"|"55696"|"NATL/BAKER DRYWALL"|"CHARLIE"|"2108320500"|5/10/2011 12:00:00 AM|"107160"|"SAN ANTONIO TX"|""|"PICKED UP"|"STORAGE CONTAINER"|"NATIONAL ACCOUNT VIP"|"REPEAT"|"USA"|10.2|"EN"|"107"|"5"|"WESTERN"|"CONSTRUCTION"|"20ZI"|"REPEAT BUSINESS"|"CHARLIE BEASLEY"|"2108320500"|""|""|""||||||5|5|5|5|5|""|""|""|"I COULD"');
       //Blob csvblob2 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       Blob csvblob2 = Blob.valueOf('923769|3M|2000020364|0010025281|0010025281|CRAIN FAMILY HOLDINGS||501-712-1366|05/12/2016 00:00:00|UNK|UNKNOWN|LITTLE ROCK|AR|72223||Pickup|GROUND LEVEL OFFICES|Monthly Recurring|US|109|Little Rock|Region 3|West|Unknown|UNK|Brandon|501-278-0333|||Z01|||||10|10|10|10|10|10||5|I HAD TO PUT SOME EFFORT IN\n923700|3M|2000014996|0010089804|0010089804|S T WOOTEN CORPORATION');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment1 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment1.body = csvblob2;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment1};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvblob3 =  Blob.valueOf('924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"');
       //Blob csvblob3 =  Blob.valueOf('4|924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"');
       Blob csvblob3 =  Blob.valueOf('924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"||501-712-1366\n924012|"1812008534"|"3M"|"21104146"|"POWER ELECTRIC COMP"||501-712-1366');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment2 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment2.body = csvblob3;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment2};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
    
    
       //BloB csvBlob4 =  Blob.valueOf('924335|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"120"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""|"(206)436-4444"|""|""|""|9|9||9||||||9|""|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"|""|"NO"|0|0|""|""|5/27/2011 11:39:00 AM|""|5|2011||""|""|""|""|""|""||""||""|"CNAG"|"NATIONAL ACCOUNT"');
       //BloB csvBlob4 = Blob.valueOf('924335|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"120"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""|"(206)436-4444"|""|""|""|9|9||9||||||9|""|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"|""|"NO"|12|Yes|Test|0|0|""|""|5/27/2011 11:39:00 AM|""|5|2011||""|""|""|""|""|""||""||""|"CNAG"|"NATIONAL ACCOUNT"');  // TFS-5166
       //BloB csvBlob4 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       BloB csvBlob4 = Blob.valueOf('924115|3M|1000009857|0010120537|0010120537|DANIA CUT HOLDINGS||954-923-9545|05/04/2016 00:00:00|00140877|Inside Sales Representative|Dania|FL|33004||Delivery|GROUND LEVEL OFFICES|Monthly Recurring|US|112|Miami|Region 6|East|Retail Trade|20W|SHIRLEY BEDFORD|(954) 923-9545||MOC|Z01|10|10|10|10||||||10||6|I DIDNT PUT IN MUCH EFFORT, I JUST CALLED THEY TOOK CARE OF IT|Ease of Requesting S|NO, THEY DO GOOD TO THEIR EXPECTATIONS|0|0||No|05/13/2016 08:47:00||5|2016|concerned on locking system,will send service tech out|5/19/2016 12:00:00 AM|PCIK UP ISSUE|5/19/2016 12:00:00 AM|YES|5/19/2016 12:00:00 AM');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment3 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment3.body = csvBlob4;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment3};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvBloB5 = blob.valueof('924111|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"111"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"|"REPEAT BUSINESS"|""|"918-369-3910"|""|""|""|10|8|10|10|10|||||10|""|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"');
       //Blob csvBloB5 = blob.valueof('14|924111|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"111"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"|"REPEAT BUSINESS"|""|"918-369-3910"|""|""|""|10|8|10|10|10|||||10|10.0|7.0|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"');
       Blob csvBloB5 = blob.valueof('924111|3M|2000020364|0010025281|0010025281|CRAIN FAMILY HOLDINGS||501-712-1366|05/12/2016 00:00:00|UNK|UNKNOWN|LITTLE ROCK|AR|72223||Pickup|GROUND LEVEL OFFICES|Monthly Recurring|US|141|Little Rock|Region 3|West|Unknown|UNK|Brandon|501-278-0333|||Z01|||||10|10|10|10|10|10||8|I HAD TO PUT SOME EFFORT IN');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment4 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment4.body = csvBlob5;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment4};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
    }
    
    static testMethod void testLessColumnsInFile() {
        Account objAccount = new Account();
        objAccount.Name ='Net Promoter Scores';
       insert objAccount;
       Messaging.SingleEmailMessage outMail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {'service800@35kgxrj7xg8dn65mk7upavs4o.in.sandbox.salesforce.com'};
       string body = 'testbody';
       string subject = 'testService800CSV';
       outMail.setToAddresses(toAddresses);
       outMail.setPlainTextBody(body);
       outMail.setSubject(subject);
       //Blob csvblob =  Blob.valueOf('923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"');
       //string csvstring = '923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"';
       //Blob csvblob =  Blob.valueOf('1003|923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"');
       //string csvstring = '1003|923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"';
       Blob csvblob =  Blob.valueOf('923724|3M|2000022335|0010026944|0010026944|DandW PAINTING INC||512-259-1411|null|UNK');
       string csvstring = '923724|3M|2000022335|0010026944|0010026944|DandW PAINTING INC||512-259-1411|null|UNK';
       
       Attachment attachment = new Attachment(); 
       attachment.body =  csvblob ; 
       attachment.NAme = 'CSVTest.csv' ; 
       
       
      
       Messaging.EmailFileAttachment[] fileAttachments = new Messaging.EmailFileAttachment[1];
       Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
       fileAttachment.setBody(attachment.body); 
       fileAttachment.setFileName(attachment.Name); 
       fileAttachments[0] = fileAttachment;
       outMail.setFileAttachments(fileAttachments);
      
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment.body = csvblob;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.textattachment txtattachment = new Messaging.InboundEmail.textattachment();
       txtattachment.body = csvstring;
       inboundEmail.textAttachments = new Messaging.InboundEmail.textattachment[]{txtattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       //Blob csvblob2 =  Blob.valueOf('923769|"107014631"|"3M"|"55696"|"NATL/BAKER DRYWALL"|"CHARLIE"|"2108320500"|5/10/2011 12:00:00 AM|"107160"|"SAN ANTONIO TX"|""');
       //Blob csvblob2 =  Blob.valueOf('1003|923769|"107014631"|"3M"|"55696"|"NATL/BAKER DRYWALL"|"CHARLIE"|"2108320500"|5/10/2011 12:00:00 AM|"107160"|"SAN ANTONIO TX"|""');
       Blob csvblob2 =  Blob.valueOf('923769|3M|2000022335|0010026944|0010026944|DandW PAINTING INC||512-259-1411|05/12/2016 00:00:00|UNK');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment1 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment1.body = csvblob2;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment1};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvblob3 =  Blob.valueOf('924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"');
       //Blob csvblob3 =  Blob.valueOf('1002|924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY","MARRY ANN"');
       Blob csvblob3 =  Blob.valueOf('924312|3M|2000022335|0010026944|0010026944|DandW PAINTING INC||512-259-1411|05/12/2016 00:00:00|UNK\n924300|3M|1000023864|0010302749|0010302749|GREGORIOS INVERT BUILDERS|||05/11/2016 00:00:00|00105493|Inside Sales Representative');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment2 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment2.body = csvblob3;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment2};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
    
    
       //BloB csvBlob4 =  Blob.valueOf('924335|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"120"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""');
       //BloB csvBlob4 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       BloB csvBlob4 = Blob.valueOf('924335|3M|2000021900|0000113984|0010133724|WALSH CONSTRUCTION CO OF IL||312-492-0640|05/11/2016 00:00:00|UNK|UNKNOWN|REDLANDS|CA|92373||Pickup|GROUND LEVEL OFFICES|Monthly Recurring|US|114|Rialto/Inland Empire|Region 1|West|Single-family housin|UNK|Mark Ashworth|(909) 963-1800|||Z01||||||||||10|||||IM TOO BUSY');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment3 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment3.body = csvBlob4;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment3};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvBloB5 = blob.valueof('924111|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"111"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"|"REPEAT BUSINESS"|""|"918-369-3910"|""|""|""|10|8|10|10|10|||||10|""');
       //Blob csvBlob5 = blob.valueof('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       Blob csvBlob5 = blob.valueof('924111|3M|2000021900|0000113984|0010133724|WALSH CONSTRUCTION CO OF IL||312-492-0640|05/11/2016 00:00:00|UNK|UNKNOWN|REDLANDS|CA|92373||Pickup|GROUND LEVEL OFFICES|Monthly Recurring|US|155|Rialto/Inland Empire');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment4 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment4.body = csvBlob5;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment4};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
    }
    
    static testMethod void testBranchId() {
        Account objAccount = new Account();
        objAccount.Name ='Net Promoter Scores';
       insert objAccount;
       Messaging.SingleEmailMessage outMail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {'service800@35kgxrj7xg8dn65mk7upavs4o.in.sandbox.salesforce.com'};
       string body = 'testbody';
       string subject = 'testService800CSV';
       outMail.setToAddresses(toAddresses);
       outMail.setPlainTextBody(body);
       outMail.setSubject(subject);
       //Blob csvblob =  Blob.valueOf('923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"112"|"4"|"WESTERN"|"UNKNOWN"');
       //string csvstring = '923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"113"|"4"|"WESTERN"|"UNKNOWN"|"40ZS"|"REPEAT BUSINESS"|""|"918-622-8804"|""|""|""||10|10|9|10|||||10|""|"PRODUCT APPEARANCE';
       //Blob csvblob =  Blob.valueOf('1111|923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"112"|"4"|"WESTERN"|"UNKNOWN"');
       //string csvstring = '1111|923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"113"|"4"|"WESTERN"|"UNKNOWN"|"40ZS"|"REPEAT BUSINESS"|""|"918-622-8804"|""|""|""||10|10|9|10|||||10|10.0|6.0';
       Blob csvblob =  Blob.valueOf('923724|3T|2000022238|0010000406|0010000406|BR166-DOW||9896334296|05/10/2016 00:00:00|00001604|Dispatcher|FREEPORT|TX|77541||Pickup|SS TANK TRAILERS|Monthly Recurring|US|3166|ETS Clute|Region 9|Central|Unknown|UNK|Mike Harper|979-238-4269|||Z01|9|IT TOOK VERY EFFORT ON MY PART TO GET THIS|Ease of Requesting S|||8||10|10|10|10|||Yes|10||NOT THAT I CAN THINK OF|0|0||No|05/18/2016 14:10:00||5|2016||||||');
       string csvstring = '923724|3T|2000022238|0010000406|0010000406|BR166-DOW||9896334296|05/10/2016 00:00:00|00001604|Dispatcher|FREEPORT|TX|77541||Pickup|SS TANK TRAILERS|Monthly Recurring|US|104|ETS Clute|Region 9|Central|Unknown|UNK|Mike Harper|979-238-4269|||Z01|9|IT TOOK VERY EFFORT ON MY PART TO GET THIS|Ease of Requesting S|||||10|10|10|10|||Yes|10||NOT THAT I CAN THINK OF|0|0||No|05/18/2016 14:10:00||5|2016||||||';
       
       Attachment attachment = new Attachment(); 
       attachment.body =  csvblob ; 
       attachment.NAme = 'CSVTest.csv' ; 
       
       
      
       Messaging.EmailFileAttachment[] fileAttachments = new Messaging.EmailFileAttachment[1];
       Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
       fileAttachment.setBody(attachment.body); 
       fileAttachment.setFileName(attachment.Name); 
       fileAttachments[0] = fileAttachment;
       outMail.setFileAttachments(fileAttachments);
      
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment.body = csvblob;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.textattachment txtattachment = new Messaging.InboundEmail.textattachment();
       txtattachment.body = csvstring;
       inboundEmail.textAttachments = new Messaging.InboundEmail.textattachment[]{txtattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       //Blob csvblob2 =  Blob.valueOf('923769|"107014631"|"3M"|"55696"|"NATL/BAKER DRYWALL"|"CHARLIE"|"2108320500"|5/10/2011 12:00:00 AM|"107160"|"SAN ANTONIO TX"|""|"PICKED UP"|"STORAGE CONTAINER"|"NATIONAL ACCOUNT VIP"|"REPEAT"|"USA"|10.2|"EN"|"104"|"5"|"WESTERN"|"CONSTRUCTION"|"20ZI"');
       //Blob csvblob2 =  Blob.valueOf('132|923769|"107014631"|"3M"|"55696"|"NATL/BAKER DRYWALL"|"CHARLIE"|"2108320500"|5/10/2011 12:00:00 AM|"107160"|"SAN ANTONIO TX"|""|"PICKED UP"|"STORAGE CONTAINER"|"NATIONAL ACCOUNT VIP"|"REPEAT"|"USA"|10.2|"EN"|"104"|"5"|"WESTERN"|"CONSTRUCTION"|"20ZI"');
       Blob csvblob2 =  Blob.valueOf('923769|3T|1000023835|0010000413|0010000413|EXXON B.O.P.||2818346326|05/10/2016 00:00:00|00012587|Senior Account|Baytown|TX|77520||Delivery|BOXES|Monthly Recurring|US|168|ETS Baytown|Region 9|Central|Unknown|UNK|Charles Garcia|7132959324|||Z01|10|NO EFFORT AT ALL');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment1 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment1.body = csvblob2;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment1};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvblob3 =  Blob.valueOf('924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"|""|""');
       //Blob csvblob3 =  Blob.valueOf('132|924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"|""|""');
       Blob csvblob3 =  Blob.valueOf('924312|3T|1000025082|UNK|0010116891|BLUE CUBE FREEPORT||9896334296|05/12/2016 00:00:00|00012791|Rental Coordinator|FREEPORT|TX|77541||Delivery|BOXES|Monthly Recurring|US|163|ETS Clute|Region 9|Central|Unknown|500-2501|COURTNEY WILLIAMS|979-238-3337|||Z01|10|VERY LITTLE EFFORT');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment2 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment2.body = csvblob3;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment2};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
    
    
       //BloB csvBlob4 =  Blob.valueOf('924335|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"141"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""|"(206)436-4444"|""|""|""|9|9||9||||||9|""|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"|""|"NO"|0|0');
       //BloB csvBlob4 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||'); 
       BloB csvBlob4 = Blob.valueOf('924335|3T|2000021571|0010000947|0010000947|SHELL EXPLORATION and PRODUCTION||00|05/09/2016 00:00:00|00012808|Account Manager|Midland|TX|79701||Pickup|STEEL TANK|Monthly Recurring|US|177|ETS Midland|Region 4|Central|Unknown|UNK|JEREMY HARP COMPLETION|903-452-6205|||Z01|||||||||||||||||I WAS TOLD WE WERE GOING TO BE TAKEN OFF YOUR CALL LIST|0|0||No');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment3 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment3.body = csvBlob4;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment3};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvBloB5 = blob.valueof('924111|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"163"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"|"REPEAT BUSINESS"|""|"918-369-3910"|""|""|""|10|8|10|10|10|||||10');
       //Blob csvBloB5 = blob.valueof('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       Blob csvBloB5 = blob.valueof('924111|3T|1000024516|0010159575|0010159575|KINGSLEY CONSTRUCTORS INC||2813631979|05/11/2016 00:00:00|00012827|Rental Coordinator|Midland|TX|79701||Delivery|STEEL TANK|Monthly Recurring|US|156|ETS Midland|Region 4|Central|Unknown|300-5013|BRANDON BRITT|832-851-4628|||Z01|8|ANOTHER TANK WAS HERE');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment4 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment4.body = csvBlob5;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment4};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
    }
    
    static testMethod void testContinue() {
        Account objAccount = new Account();
        objAccount.Name ='Net Promoter Scores';
       insert objAccount;
       Messaging.SingleEmailMessage outMail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {'service800@35kgxrj7xg8dn65mk7upavs4o.in.sandbox.salesforce.com'};
       string body = 'testbody';
       string subject = 'testService800CSV';
       outMail.setToAddresses(toAddresses);
       outMail.setPlainTextBody(body);
       outMail.setSubject(subject);
       //Blob csvblob =  Blob.valueOf('923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"156"|"4"|"WESTERN"|"UNKNOWN"|"40ZS"|"REPEAT BUSINESS"|""|"918-622-8804"|""|""|""||10');
       //string csvstring = '923724|"298019878"|"3M"|"111420"|"ADVANTAGE GLASS"|"BRYAN JOHNSON"|"918-694-8447"|5/19/2011 12:00:00 AM|"113425"|"TULSA OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|3|"EN"|"156"|"4"|"WESTERN"|"UNKNOWN"|"40ZS"|"REPEAT BUSINESS"|""|"918-622-8804"|""|""|""||10';
       //Blob csvblob = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       //string csvstring = '4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||';
       Blob csvblob = Blob.valueOf('923724|3T|1000023363|0010000406|0010000406|BR166-DOW|AMBER HAWKINS|9896334296|5/16/2016 02:00:00 PM|00012791|Rental Coordinator|FREEPORT|TX|77541||Delivery|BOXES|Monthly Recurring|US|3166|ETS Clute|Region 9|Central|Unknown|250-2501|AMBER HAWKINS|979-285-7102|||Z01|9|YOU DO A GREAT JOB|No change/Nothing|10|10||10||||||Unsure|Yes|10||NO|0|0||No|05/18/2016 14:09:00||5|2016||||||');
       string csvstring = '923724|3T|1000023363|0010000406|0010000406|BR166-DOW|AMBER HAWKINS|9896334296|5/16/2016 02:00:00 PM|00012791|Rental Coordinator|FREEPORT|TX|77541||Delivery|BOXES|Monthly Recurring|US|109|ETS Clute|Region 9|Central|Unknown|250-2501|AMBER HAWKINS|979-285-7102|||Z01|9|YOU DO A GREAT JOB|No change/Nothing|10|10||10||||||Unsure|Yes|10||NO|0|0||No|05/18/2016 14:09:00||5|2016||||||';
       Attachment attachment = new Attachment(); 
       attachment.body =  csvblob ; 
       attachment.NAme = 'CSVTest.csv' ; 
       
       
      
       Messaging.EmailFileAttachment[] fileAttachments = new Messaging.EmailFileAttachment[1];
       Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
       fileAttachment.setBody(attachment.body); 
       fileAttachment.setFileName(attachment.Name); 
       fileAttachments[0] = fileAttachment;
       outMail.setFileAttachments(fileAttachments);
      
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment.body = csvblob;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.textattachment txtattachment = new Messaging.InboundEmail.textattachment();
       txtattachment.body = csvstring;
       inboundEmail.textAttachments = new Messaging.InboundEmail.textattachment[]{txtattachment};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       
       //Blob csvblob2 =  Blob.valueOf('923769|"107014631"|"3M"|"55696"|"NATL/BAKER DRYWALL"|"CHARLIE"|"2108320500"|5/10/2011 12:00:00 AM|"107160"|"SAN ANTONIO TX"|""|"PICKED UP"|"STORAGE CONTAINER"|"NATIONAL ACCOUNT VIP"|"REPEAT"|"USA"|10.2|"EN"|"145"');
       //Blob csvblob2 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       Blob csvblob2 = Blob.valueOf('923769|3M|1000019951|0010039670|0010039670|G and F RENOVATIONS INC||404-474-4808|05/06/2016 00:00:00|00105895|Branch Sales Representative|Birmingham|AL|35211||Delivery|STEEL CONTAINERS|Monthly Recurring|US|145|Birmingham|Region 6|East|Single-family housin|15ZI|Carlos Sandoval|404-597-9535||MOC|Z01|10|10|10|10||||||10||9|I LIKE THE SERVICE, EVERYTHING IS RIGHT|No change/Nothing|NO ITS OK|0|0||No|05/13/2016 09:32:00||5|2016||||||');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment1 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment1.body = csvblob2;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment1};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvblob3 =  Blob.valueOf('924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"|""');
       //Blob csvblob3 =  Blob.valueOf('100|924312|"180008534"|"3M"|"21154146"|"POWER ELECTRIC COMPANY"|""');
       Blob csvblob3 =  Blob.valueOf('924312|3T|1000023568|0010132100|0010132100|MOTIVA ENTERPRISES LLC||8773958031|05/10/2016 00:00:00|00012843|Administrative|CONVENT|LA|70723||Delivery|BOXES|Monthly Recurring|US|177|ETS Baton Rouge');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment2 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment2.body = csvblob3;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment2};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
    
    
       //BloB csvBlob4 =  Blob.valueOf('924335|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"114"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""|"(206)436-4444"|""|""|""|9|9||9||||||9|""|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"|""|"NO"|0|0|""|""|5/27/2011 11:39:00 AM|""|5|2011||""|""|""|""|""|""||""||""|"CNAG"|"NATIONAL ACCOUNT"');
       //BloB csvBlob4 = Blob.valueOf('924335|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"114"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""|"(206)436-4444"|""|""|""|9|9||9||||||9|""|"CONVENIENCE OF PRODUCT BEING DELIVERED TO YOUR LOCATION"|""|"NO"|23|Sure|Test|0|0|""|""|5/27/2011 11:39:00 AM|""|5|2011||""|""|""|""|""|""||""||""|"CNAG"|"NATIONAL ACCOUNT"'); // TFS-5166
       //BloB csvBlob4 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       BloB csvBlob4 = Blob.valueOf('924312|3M|1000024581|0010302831|0010302831|Ryan Gaudioso|Ryan Gaudioso||05/11/2016 00:00:00|00105308|Inside Sales Representative|Tucson|AZ|85741||Delivery|STEEL CONTAINERS|Monthly Recurring|US|155|Tucson|Region 2|West||25ZJ|Ryan Gaudioso|520-437-8825||MOC|NEW|10|10|10|10||||||10||9|IT WAS JUST GOING THERE');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment3 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment3.body = csvBlob4;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment3};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvBloB5 = blob.valueof('924111|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"168"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"|"REPEAT BUSINESS"|""|"918-369-3910"');
       //Blob csvBlob5 = blob.valueof('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       Blob csvBlob5 = blob.valueof('924111|3T|1000023363|0010000406|0010000406|BR166-DOW|AMBER HAWKINS|9896334296|05/10/2016 00:00:00|00012791|Rental Coordinator|FREEPORT|TX|77541||Delivery|BOXES|Monthly Recurring|US|163|ETS Clute|Region 9|Central|Unknown|250-2501|AMBER HAWKINS|979-285-7102|||Z01|9|YOU DO A GREAT JOB|No change/Nothing|10|10||10||||||Unsure|Yes|10||NO|0|0||No|05/18/2016 14:09:00||5');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment4 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment4.body = csvBlob5;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment4};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //BloB csvBlob6 =  Blob.valueOf('924336|"120017539"|"3M"|"21046569"|"NATL/NORTH COAST ELECTRIC"|"TONY"|"360 305 6810"|5/18/2011 12:00:00 AM|"120437"|"YELM WA"|""|"DELIVERED"|"MOBILE OFFICE"|"NATIONAL ACCOUNT GOLD"|"REPEAT"|"USA"|2|"EN"|"177"|"2"|"WESTERN"|"CONSTRUCTION"|"32LMO"|"OTHER"|""');
       //BloB csvBlob6 = Blob.valueOf('4|2542606|124010963|3M|80145587|DLC OF PALM BEACH COUNTY|Don Clark|561-582-5022|2/1/2016 12:00:00 AM|124975|LANTANA FL||Picked Up|Storage Container|Monthly Recurring Acct - Cust|New|USA|94.0|EN|124|6|Eastern|Retail Trade/Business|24S2|Repeat Business||561-582-5022|561-719-7303|CA||OFF|NORM||||||||||||||||0|0|||2/9/2016 7:11:00 AM||2|2016||||||');
       BloB csvBlob6 = Blob.valueOf('924336|3T|2000024246|0010132114|0010132114|SWS ENVIRONMENTAL SERVICES||8502348428|05/12/2016 00:00:00|00003080|Branch Manager|DECATUR|AL|35601||Pickup|STEEL TANK|Monthly Recurring|US|145|ETS Decatur|Region 6|East|Unknown|UNK|JONAH CORLEY|334-651-5639|||Z01|5|JUST MIDDLE OF THE ROAD|No change/Nothing|||||8|8|9|8|8||Yes|10||JUST THE PRICING|0|0||No|05/18/2016 14:15:00||5|2016');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment6 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment6.body = csvBlob6;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment6};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       //Blob csvBloB7 = blob.valueof('924115|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"103"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"');
       //Blob csvBloB7 = blob.valueof('100|924115|"111018901"|"3M"|"131956"|"ATLAS GENERAL CONTRACTORS"|"JOHN LESTER"|"405-501-1922"|5/16/2011 12:00:00 AM|"111787"|"OKLAHOMA CITY OK"|""|"DELIVERED"|"STORAGE CONTAINER"|"MONTHLY RECURRING ACCT - CUST"|"REPEAT"|"USA"|8|"EN"|"103"|"4"|"WESTERN"|"CONSTRUCTION"|"40K2"');
       Blob csvBloB7 = blob.valueof('924115|3M|1000009857|0010120537|0010120537|DANIA CUT HOLDINGS||914-923-9545|05/04/2016 00:00:00|00140877|Inside Sales Representative|Dania|FL|33004||Delivery|GROUND LEVEL OFFICES|Monthly Recurring|US|1124|Miami|Region 6|East|Retail Trade|20W|SHIRLEY BEDFORD|(954) 923-9545||MOC|Z01|10|10|10|10||||||10||6|I DIDNT PUT IN MUCH EFFORT, I JUST CALLED THEY TOOK CARE OF IT|Ease of Requesting S|NO, THEY DO GOOD TO THEIR EXPECTATIONS|0|0||No|05/13/2016 08:47:00||5|2016|concerned on locking system,will send service tech out|5/19/2016 12:00:00 AM|PICK UP ISSUE|5/19/2016 12:00:00 AM|YES|5/19/2016 12:00:00 AM');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment7 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment7.body = csvBlob7;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment7};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
       
       Blob csvBloB8 = blob.valueof('926796|3M|2000014577|0010023212|0010023212|COMMERCIAL MECHANICAL INC||972-487-0366\n924777|3M|1000024774|0010070112|0010070112|MECHANICAL|Dee Mozingo|812-546-6111|05/12/2016 09:30:00 PM\n924211|3M|1000023410|0010011240|0010011240|CONSTRUCTION|Chris Ciolfi|510-286-8200|05/12/2016 04:00:00 AM|00220190\n924960|3M|1000024237|0000106605|0010126258|JORDAN COMMERCIAL||210-222-0131||00303528|ISR|El Paso');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{outMail});
       inboundEmail = new Messaging.InboundEmail();
       Messaging.InboundEmail.Binaryattachment binaryattachment8 = new Messaging.InboundEmail.Binaryattachment();
       binaryattachment8.body = csvBlob8;
       inboundEmail.binaryAttachments = new Messaging.InboundEmail.Binaryattachment[]{binaryattachment8};
       new Service800CSVfileByEmail().handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
    }
    
    
}