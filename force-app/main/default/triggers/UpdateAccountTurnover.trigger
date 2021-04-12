/**
 * Mise à jour du CA
 */
trigger UpdateAccountTurnover on Order (after update) {

    set<Id> accountIds = new set<Id>();
	
    // comptes avec des commandes activated
    for(Order order : trigger.new){
        if(order.Status == 'Activated'){
            accountIds.add(order.AccountId);
        }
    }

    // mise à jour du CA
    if(accountIds.size() > 0){
        List<Account> accountsWithOrders = [SELECT Id, 
                                    (SELECT TotalAmount FROM Orders WHERE Status='Activated')
                                FROM Account
                                WHERE Id IN :accountIds
                                ];

        AccountTurnover.calculate(accountsWithOrders);
    } 
}