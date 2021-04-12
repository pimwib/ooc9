/**
 * Calcul du chiffre d'affaire pour l'équipe
 */
public without sharing class MyTeamOrdersController {
    public decimal SumOders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Activated'];
			return (decimal)groupedResults.get('total');

        }
        private set;
    }
}