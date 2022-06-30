public class ContactHelper {
    
    public static void updateHasCustomerOnAccount(List<Contact> contacts){
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Contact con : contacts){
            if(con.Contact_Type__c == null){
                continue;
            }
            if(con.Contact_Type__c == 'Customer'){
                System.debug('Here on Customer');
                Account acc = new Account();
                acc.Id = con.AccountId;
                acc.Has_Customer__c = true;
                accountsToUpdate.add(acc);
            }else if(con.Contact_Type__c == 'Not a customer'){
                Account acc = new Account();
                acc.Id = con.AccountId;
                acc.Has_Customer__c = false;
                accountsToUpdate.add(acc);
            }
        }
        
        if(accountsToUpdate.size() > 0){
            update accountsToUpdate;
        }
    }
}