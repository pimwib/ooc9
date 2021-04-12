@isTest
private class UpdateAccountsBatchTest {
    @TestSetup
    static void makeData(){
        List<Account> testAccounts = TestDataFactory.createAccounts(20);
        List<Order> testOrders = TestDataFactory.createOrdersForAccounts(testAccounts, 5, 100, 30);

        for (Order order : testOrders) {
            order.Status = 'Activated';
        }
        update testOrders;
    }

    /**
     * Test du calcul de CA en batch
     */
    @isTest static void test_AccountsBatch() {

        Test.startTest();
        UpdateAccountsBatch obj = new UpdateAccountsBatch();
        Id batchId = DataBase.executeBatch(obj); 
        Test.stopTest();

        List<Account> results = [SELECT Id, Chiffre_d_affaire__c
                                    FROM Account
                                    WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Activated')
                                ];

        System.assertEquals(20, results.size(), 'error account numbers');
        for(Account account : results){
            System.assertEquals(5*100*30, account.Chiffre_d_affaire__c, 'error: Chiffre_d_affaire__c');
        }
    }
}