@isTest
public class ContactHelperTests {
    
    @testSetup static void setup() {
        Account customerAccount = new Account(Name = 'Test customerAccount');
        Insert customerAccount;
        
        Account notCustomerAccount = new Account(Name = 'Test notCustomerAccount');
        Insert notCustomerAccount;
        
        Account acc = new Account(Name = 'Test Acc');
        insert acc;
        
        List<Contact> contacts = new List<Contact>();		
            Contact CustomerContact = new Contact(FirstName='Test', LastName='CustomerContact', accountId = customerAccount.Id,
                                      Contact_Type__c = 'Customer');
            contacts.add(CustomerContact);
        
            Contact CustomerNotContact = new Contact(FirstName='Test', LastName='CustomerNotContact', accountId = notCustomerAccount.Id,
                                      Contact_Type__c = 'Not a customer');
            contacts.add(CustomerNotContact);
        
            Contact con = new Contact(FirstName='Test', LastName='Customer', accountId = acc.Id);
            contacts.add(con);
        
        
        insert contacts;
    }
    
    
    @isTest
    static void conatactTypeCustomer(){
        List<Contact> contacts = [SELECT id, AccountId, Account.Has_Customer__c FROM contact WHERE Contact_Type__c = 'Customer'];
        
        System.assertEquals(true, contacts[0].Account.Has_Customer__c, 'Incorrect Has Customer on Account');
        
    }
    
    @isTest
    static void conatactTypeNotACustomer(){
        List<Contact> contacts = [SELECT id, AccountId, Account.Has_Customer__c FROM contact WHERE Contact_Type__c = 'Not a customer'];
        
        System.assertEquals(false, contacts[0].Account.Has_Customer__c, 'Incorrect Has Customer on Account');
        
    }
    
    @isTest
    static void conatactTypeUpdateToCusotmer(){
        List<Contact> contacts = [SELECT id, AccountId, Account.Has_Customer__c FROM contact WHERE Contact_Type__c = null];
        for(contact con : contacts){
            con.Contact_Type__c = 'Customer';
        }
        update contacts;
        Account account = [SELECT Id, Has_Customer__c FROM Account WHERE Id =: contacts[0].AccountId];
        
        System.assertEquals(true, account.Has_Customer__c, 'Incorrect Has Customer on Account');
        
    }
    
    @isTest
    static void conatactTypeUpdateToNotACusotmer(){
       List<Contact> contacts = [SELECT id, AccountId, Account.Has_Customer__c FROM contact WHERE Contact_Type__c = null];
        for(contact con : contacts){
            con.Contact_Type__c = 'Not a customer';
        }
        update contacts;
        Account account = [SELECT Id, Has_Customer__c FROM Account WHERE Id =: contacts[0].AccountId];
        
        System.assertEquals(false, account.Has_Customer__c, 'Incorrect Has Customer on Account');
        
    }

}