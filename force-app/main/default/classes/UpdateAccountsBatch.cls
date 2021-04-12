/**
 * Calcul du CA en batch
 */
global class UpdateAccountsBatch implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator('SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status=\'Activated\') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Activated\')');

   }
    
   global void execute(Database.BatchableContext info, List<Account> accountsWithOrders){      
        AccountTurnover.calculate(accountsWithOrders);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}