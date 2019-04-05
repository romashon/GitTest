public class InStockItemHandler {
    public static void CaseInStockItemMethod (List<Warehouse_Item__c> newItems) {
        for (Warehouse_Item__c item : newItems) {
        if (item.Quantity__c == 0) {
            item.In_Stock__c = false;
        } else {
            item.In_Stock__c = true;
        }
    }
    }
}