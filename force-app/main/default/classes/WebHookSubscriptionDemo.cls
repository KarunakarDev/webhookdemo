@RestResource(urlmapping='/api/webhooks/publish/*')
global with sharing class WebHookSubscriptionDemo {

    @Httppost
    global static void handleNotification(){
        try{
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;

            System.debug('Print request body >>>>>'+ req.requestBody);
            //String hashedVal = req.headers.get('x-Hub-Signature-256');
            //Blob bBody = req.requestBody;

            JSONParser parser = JSON.createParser(req.requestBody.toString());
            pusher ps;
            //head_commit hc; 
            //String repo;

            while(parser.nextToken() != null){
                if(parser.getText() == 'pusher') {
                    System.debug('Inside Pusher');
                    parser.nextToken();
                    ps = (Pusher)parser.readValueAs(pusher.class);
                    System.debug(System.LoggingLevel.DEBUG, '****\n Print pusher info..'+ps);                    
                }
            }

            res.responseBody = Blob.valueOf('{success:true, event:"Push"}');
            res.statusCode = 200;

        }catch(Exception e){
            
        }
    }

    public class Pusher{
        public String name;
        public String email;
        public pusher(String name, String email){
            name=name;
            email=email;
        }
    }
}