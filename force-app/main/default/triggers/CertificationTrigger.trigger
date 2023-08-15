trigger CertificationTrigger on Certification__c (after insert, after update) {
    
    Set<Id> memberIdSet = new Set<Id>();

    //Collect all Invoice ids in the set from Invoice Line Item.
    for(Certification__c cert : trigger.new)  { 
        if(cert.Member__c != NULL) memberIdSet.add(cert.Member__c);
    }

    if(memberIdSet.size() > 0) {

        //query against Invoice__c using the above set and will return required results instead of querying all records from database. and stored that in the map with key as Invoice Id.
        Map<Id,Member__c>  memberMap = new Map<Id,Member__c>([Select id, name, Institution__r.id 
                                                              From Member__c WHERE Id IN :memberIdSet]);

        Map<Id,Institution__c> instToUpdateMap = new Map<Id,Institution__c>();

        for(Certification__c invLI : trigger.new)  { 
            //if(invLI.Procedure_Type__c!= NULL){

                //check the Invoice record in the map
                if(memberMap.containsKey(invLI.Member__c ) && memberMap.get(invLI.Member__c ).Institution__r.Id != NULL){ 

                    Institution__c opp = new Institution__c(Id = memberMap.get(invLI.Member__c ).Institution__r.Id);
                    opp.Cert_Count__c = 20;
                    instToUpdateMap.put(opp.Id,opp); //use map instead of list to collect the opportunity to update.So that Even if more than one record inserted,DUPLICATE_VALUE error won't occur.
                }
            //}

        }  

        if(instToUpdateMap.size() > 0 && instToUpdateMap.values().size() > 0){
            update instToUpdateMap.values(); //update opportunity records
        } 
            
    }
    
    
}