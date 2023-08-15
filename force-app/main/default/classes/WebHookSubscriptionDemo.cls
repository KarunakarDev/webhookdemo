@RestResource(urlmapping='/api/webhooks/publish/*')
global with sharing class WebHookSubscriptionDemo {

    @Httppost
    global static void handleNotification(){
        try{
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
        }catch(Exception e){
            
        }
    }
}