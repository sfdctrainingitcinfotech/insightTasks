@isTest
public class ContactTriggerHandlerTests {
    
    @isTest
    Static void caseCreationUponInsertingPrimaryLevelContact(){
        // Arrange (For vuilfing the data)
        // 
        Account acc = new Account(Name = 'Test LastName');
        Insert acc;
        
        List<Contact> contacts = new List<Contact>();		
        for(Integer i =0; i <150; i++){
            Contact con = new Contact(FirstName='Test'+i, LastName='test Last NAme'+i, accountId = acc.Id,
                                      ownerId = userInfo.getUserId(), level__c = 'Primary');
            contacts.add(con);
        }
        
        // Act (Inserting the data)
        Test.startTest();
        insert contacts;
        Test.stopTest();
        
        List<Case> cases = [SELECT id, Priority, ownerId, status, Origin, accountId, contactId FROM case];
        List<Task> tasks = [SELECT id, Priority,Status, Subject, ActivityDate, WhatId FROM Task];
        
        //Assert 
        System.assertEquals(true, cases[0].contactId != null, 'Incorrect Accpunt Id');
        System.assertEquals(acc.id, cases[0].accountId, 'Account Id is Incorrect');
        
        System.assertEquals(150, cases.size(), 'Number of Cases Inserted are wrong');
        System.assertEquals(userInfo.getUserId(), cases[0].ownerId, 'Incorrect owner Id');
        System.assertEquals('High', cases[0].Priority, 'Incorrect case Priority');
        System.assertEquals('Working', cases[0].status, 'Incorrect Case Status');
        System.assertEquals('New Contact', cases[0].Origin, 'Incorrect Case Origin');
        
        System.assertEquals(150, tasks.size(), 'Incorrect tasks');
        System.assertEquals(true, tasks[0].WhatId != null, 'Incorrect task Priority');
        System.assertEquals('Not Started', tasks[0].Status, 'Incorrect task Status');
        System.assertEquals(true, tasks[0].Subject.StartsWith('Welcome call for '), 'Incorrect task Subject');
        System.assertEquals('Normal', tasks[0].Priority, 'Incorrect task Priority');
        System.assertEquals(System.today()+7, tasks[0].ActivityDate, 'Incorrect task due date');
    }
    
    @isTest
    Static void caseCreationUponInsertingSecondaryLevelContact(){
        // Arrange (For vuilfing the data)
        List<Contact> contacts = new List<Contact>();		
        for(Integer i =0; i <150; i++){
            Contact con = new Contact(FirstName='Test'+i, LastName='test Last NAme'+i,
                                      ownerId = userInfo.getUserId(), level__c = 'Secondary');
            contacts.add(con);
        }
        
        // Act (Inserting the data)
        Test.startTest();
        insert contacts;
        Test.stopTest();
        
        List<Case> cases = [SELECT id, Priority, ownerId, status, Origin, accountId, contactId FROM case];
        List<Task> tasks = [SELECT id, Priority,Status, Subject, ActivityDate, WhatId FROM Task];
        
        //Assert
        System.assertEquals(true, cases[0].contactId != null, 'Incorrect Accpunt Id');
        System.assertEquals(null, cases[0].accountId, 'Incorrect Accpunt Id');
        
        System.assertEquals(150, cases.size(), 'Number of Cases Inserted are wrong');
        System.assertEquals(userInfo.getUserId(), cases[0].ownerId, 'Incorrect owner Id');
        System.assertEquals('Medium', cases[0].Priority, 'Incorrect case Priority');
        System.assertEquals('Working', cases[0].status, 'Incorrect Case Status');
        System.assertEquals('New Contact', cases[0].Origin, 'Incorrect Case Origin');
        
        System.assertEquals(150, tasks.size(), 'Incorrect tasks');
        System.assertEquals(true, tasks[0].WhatId != null, 'Incorrect task Priority');
        System.assertEquals('Not Started', tasks[0].Status, 'Incorrect task Status');
        System.assertEquals(true, tasks[0].Subject.StartsWith('Welcome call for '), 'Incorrect task Subject');
        System.assertEquals('Normal', tasks[0].Priority, 'Incorrect task Priority');
        System.assertEquals(System.today()+14, tasks[0].ActivityDate, 'Incorrect task due date');
    }
    
    @isTest
    Static void caseCreationUponInsertingTertiaryLevelContact(){
        // Arrange (For vuilfing the data)
        List<Contact> contacts = new List<Contact>();		
        for(Integer i =0; i <150; i++){
            Contact con = new Contact(FirstName='Test'+i, LastName='test Last NAme'+i,
                                      ownerId = userInfo.getUserId(), level__c = 'Tertiary');
            contacts.add(con);
        }
        
        // Act (Inserting the data)
        Test.startTest();
        insert contacts;
        Test.stopTest();
        
        List<Case> cases = [SELECT id, Priority, ownerId, status, Origin, accountId, contactId FROM case];
        List<Task> tasks = [SELECT id, Priority,Status, Subject, ActivityDate, WhatId FROM Task];
        
        //Assert
        System.assertEquals(true, cases[0].contactId != null, 'Incorrect Accpunt Id');
        System.assertEquals(null, cases[0].accountId, 'Incorrect Accpunt Id');
        
        System.assertEquals(150, cases.size(), 'Number of Cases Inserted are wrong');
        System.assertEquals(userInfo.getUserId(), cases[0].ownerId, 'Incorrect owner Id');
        System.assertEquals('Low', cases[0].Priority, 'Incorrect case Priority');
        System.assertEquals('Working', cases[0].status, 'Incorrect Case Status');
        System.assertEquals('New Contact', cases[0].Origin, 'Incorrect Case Origin');
        
        System.assertEquals(150, tasks.size(), 'Incorrect tasks');
        System.assertEquals(true, tasks[0].WhatId != null, 'Incorrect task Priority');
        System.assertEquals('Not Started', tasks[0].Status, 'Incorrect task Status');
        System.assertEquals(true, tasks[0].Subject.StartsWith('Welcome call for '), 'Incorrect task Subject');
        System.assertEquals('Normal', tasks[0].Priority, 'Incorrect task Priority');
        System.assertEquals(System.today()+21, tasks[0].ActivityDate, 'Incorrect task due date');
    }
    
}