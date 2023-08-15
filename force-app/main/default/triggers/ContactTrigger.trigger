trigger ContactTrigger on Contact (before insert, before update) {

   for(Contact cpre :Trigger.new) 
    {  
        cpre.Salutation='Mr';
    }
}