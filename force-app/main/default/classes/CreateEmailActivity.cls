global class CreateEmailActivity implements messaging.InboundEmailHandler {
List<Contact> contacts;
global messaging.InboundEmailresult handleInboundEmail(messaging.InboundEmail email, messaging.InboundEnvelope envelope) {

contacts = new List<Contact>();
List<Attachment> attachments = new List<Attachment>();
List<Attachment> attachmentList = new List<Attachment>();
List<String> toEmailAddresss = new List<String>();
List<String> ccEmailAddresss = new List<String>();
system.debug('email ' + email);
messaging.InboundEmailresult result = new messaging.InboundEmailresult();
string senderName = email.fromname;
String fromEmailAddress = email.fromAddress;
toEmailAddresss = email.toAddresses;
ccEmailAddresss = email.ccAddresses;
Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = email.binaryAttachments;
contacts = [select id from Contact where email= :fromEmailAddress LIMIT 1];
String htmlBody = email.htmlBody;
String taskSubject = email.subject;
System.debug('htmlBody: ' + htmlBody);


return result;
}
}