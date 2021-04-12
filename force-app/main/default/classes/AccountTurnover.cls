/**
 * Service 
 * pour la mise à jour du chiffre d'affaire 
 * pour une liste de comptes avec des commandes
 */
global without sharing class AccountTurnover {
    
    global static void calculate(List<Account> accountsWithOrders) {

        for(Account thisAccount : accountsWithOrders) {


            thisAccount.Chiffre_d_affaire__c = 0;
            
            for(Order order : thisAccount.Orders){
                thisAccount.Chiffre_d_affaire__c += order.TotalAmount;
            }
        }

        update accountsWithOrders;
    }
}