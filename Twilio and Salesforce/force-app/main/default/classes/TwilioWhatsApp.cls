public class TwilioWhatsApp {

    @AuraEnabled
    public Static string sendMessage(string msg){
        try {
            String accountId = 'AC1f448faf4fb988b5968f3ffa286558eb';
            String authToken = 'aaf95b5db861d44386bc8e43a6f4e4cc';
            String fromNumber = '+14155238886';
            String toNumber = '+2349046735149';

           Http ht = new Http();
           HttpRequest req = new HttpRequest();
           HttpResponse res = new HttpResponse();

           req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/' + accountId + '/Messages.json');
           req.setMethod('POST');

           Blob b = Blob.valueof(accountId + ':' + authToken);
           String encodedValue = 'Basic ' + EncodingUtil.base64Encode(b);
           req.setHeader('Authorization',encodedValue);
           req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

           String body = 'From=whatsapp:' + EncodingUtil.urlEncode(fromNumber, 'UTF-8');
           body += '&Body=' + msg;
           body += '&To=whatsapp:' + EncodingUtil.urlEncode(toNumber, 'UTF-8');
           req.setBody(body);

           res = ht.send(req);
           System.debug(':::: Response: ' + res.getBody());
           return 'success' + res.getBody();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}