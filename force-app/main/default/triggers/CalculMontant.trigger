/**
 * Calcul du montant net de la commande
 */
trigger CalculMontant on Order (before update) {
	
	for(Order order : trigger.new){
		order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
	}
}