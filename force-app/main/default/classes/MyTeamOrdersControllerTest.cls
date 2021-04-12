@isTest
private with sharing class MyTeamOrdersControllerTest {
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
     * Test de la somme de CA pour l'équipe
     */
    @isTest static void test_sumOrder() {
        OrderTeamSumController controller = new OrderTeamSumController();

        Test.startTest();
        decimal ordersSum = controller.ordersSum;
        Test.stopTest();

        System.assertEquals(20*5*100*30, ordersSum, 'Error total amount');
    }
}