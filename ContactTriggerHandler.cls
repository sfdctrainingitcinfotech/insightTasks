public class ContactTriggerHandler {
    
    public static void submitCasesFromContact(List<Contact> contacts){
        String contactString = JSON.serialize(contacts);
        ContactTriggerHandler.createCasesFromContact(contactString);
    }
    
    @future
    public static void createCasesFromContact(String contactString){
        
        List<Contact> contacts = (List<Contact>) JSON.deserialize(contactString, List<Contact>.class);
        List<Case> casesToInsert = new List<Case>();
        List<Task> taskToInsert = new List<Task>();
        
        Map<String, String> contactLevelCasePriorityMap = new Map<String, String>{'Primary' => 'High', 
            																		'Secondary' => 'Medium', 
            																		'Tertiary' => 'Low'};
        for(Contact contact : contacts){
            Case cs = new Case();
            cs.Status = 'Working';
            cs.Origin = 'New Contact';
            cs.OwnerId = contact.OwnerId;
            cs.Priority = contactLevelCasePriorityMap.get(contact.Level__c);
            cs.ContactId = contact.Id;
            cs.AccountId = contact.AccountId != null ? contact.AccountId : null;
            casesToInsert.add(cs);
        }
        
        insert casesToInsert;
        
        Set<Id> caseIds = new Set<Id>();
        for(Case cs : casesToInsert){
            caseIds.add(cs.id);
        }
        
        List<Case> caseList = [SELECT Id, priority, OwnerId, CaseNumber FROM Case WHERE id IN: caseIds];
        
        for(Case cs : caseList){
            Task tsk = new Task();
            tsk.WhatId = cs.Id;
            tsk.Status = 'Not Started';
            tsk.subject = ' Welcome call for '+cs.CaseNumber;
            tsk.Priority = 'Normal';
            if(CS.Priority == 'High'){
                tsk.ActivityDate = System.today()+7;
            }
            if(CS.Priority == 'Medium'){
                tsk.ActivityDate = System.today()+14;
            }
            if(CS.Priority == 'Low'){
                tsk.ActivityDate = System.today()+21;
            }
            taskToInsert.add(tsk);
        }
        insert taskToInsert;
      }

}