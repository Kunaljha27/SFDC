global class ApprovalContractNotification implements Schedulable {

    global void execute(SchedulableContext SC) {
        sendReminders();
    }

    public void sendReminders(){

    	List<Messaging.SingleEmailMessage> mailMessages = new List<Messaging.SingleEmailMessage>();
		String subject='Contract Requires Approval';

		Date oneDayBeforeNow=system.today().addDays(-1);
		Datetime oneDayBeforeNowStart = DateTime.newInstanceGmt(oneDayBeforeNow, Time.newInstance(0, 0, 0,0));
		DateTime oneDayBeforeNowEnd = DateTime.newInstanceGmt(oneDayBeforeNow,Time.newInstance(23, 59, 59,0));

		List<AggregateResult> a = [Select Name, REVVY__ContractId__c, OwnerID
			from REVVY__MnContract__c
			where REVVY__Phase__c = 'Approval'
			group by Name, REVVY__ContractId__c, OwnerID
			HAVING MIN(CreatedDate)<:oneDayBeforeNowEnd];
		// (MIN(CreatedDate)>:oneDayBeforeNowStart) and
    	for(AggregateResult x : a){

		    String body = '<html><body>'+ 'Dear Owner,' +
		    '<br/><br/>A gentle reminder to approve the contract ' + String.valueOf(x.get('Name'));

		    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

		    mail.setTargetObjectId(String.valueOf(x.get('OwnerID')));
            mail.setSubject(subject);
            mail.setHtmlBody(body);
            mail.setSaveAsActivity(false);
            mailMessages.add(mail);

		}

		Messaging.sendEmail(mailMessages);
    }
 }