trigger contactTrigger on Contact(after insert){
    
    if(Trigger.isInsert && Trigger.isAfter){
        ContactTriggerHandler.submitCasesFromContact(Trigger.new);
    }
}