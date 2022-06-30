trigger contactTrigger on Contact(before insert, before update, after insert){
    
    if(Trigger.isInsert && Trigger.isAfter){
        ContactTriggerHandler.submitCasesFromContact(Trigger.new);
    }
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        ContactHelper.updateHasCustomerOnAccount(Trigger.new);
    }
}
