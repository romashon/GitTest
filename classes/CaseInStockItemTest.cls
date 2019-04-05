@isTest 
public class CaseInStockItemTest {
    
    @isTest static void WHTriggerTestInStockOne () {        
        Warehouse_Item__c testItem = new Warehouse_Item__c (
        	Name = 'Banana',
            Quantity__c = 9,
            Price__c = 11,
            Type__c = 'Fruit',
            Added__c = Date.today().addDays(-3),
            Release__c = Date.today().addDays(-20)
        );
        Database.insert(testItem, false);
        List<Warehouse_Item__c> testWHInsert = [SELECT Name, In_Stock__c FROM Warehouse_Item__c];
        System.assertEquals('Banana', testWHInsert[0].Name);
        System.assertEquals(true, testWHInsert[0].In_Stock__c);
        
        testItem.Quantity__c = 0;
        Database.update(testItem, false);
        List<Warehouse_Item__c> testWHUpdate = [SELECT Name, In_Stock__c FROM Warehouse_Item__c];
        System.assertEquals('Banana', testWHUpdate[0].Name);
        System.assertEquals(false, testWHUpdate[0].In_Stock__c);
    }
    
    @isTest static void WHTriggerTestInStockTwo () {        
        Warehouse_Item__c testItem = new Warehouse_Item__c (
        	Name = 'Pear',
            Quantity__c = 0,
            Price__c = 15,
            Type__c = 'Fruit',
            Added__c = Date.today().addDays(-5),
            Release__c = Date.today().addDays(-16)
        );
        Database.insert(testItem, false);
        List<Warehouse_Item__c> testWHInsert = [SELECT Name, In_Stock__c FROM Warehouse_Item__c];
        System.assertEquals('Pear', testWHInsert[0].Name);
        System.assertEquals(false, testWHInsert[0].In_Stock__c);
        
        testItem.Quantity__c = 21;
        Database.update(testItem, false);
        List<Warehouse_Item__c> testWHUpdate = [SELECT Name, In_Stock__c FROM Warehouse_Item__c];
        System.assertEquals('Pear', testWHUpdate[0].Name);
        System.assertEquals(true, testWHUpdate[0].In_Stock__c);
    }
    
    
    @isTest static void WHValidRuleTestDateNegative () {        
        Warehouse_Item__c testItem = new Warehouse_Item__c (
        	Name = 'Apple',
            Quantity__c = 6,
            Price__c = 9,
            Type__c = 'Fruit',
            Added__c = Date.today().addDays(-3),
            Release__c = Date.today().addDays(6)
        );
        Database.insert(testItem, false);
        
        Integer testWHSize = database.countQuery('SELECT count() FROM Warehouse_Item__c');
        System.assertEquals(0, testWHSize);
    }
    
    @isTest static void WHValidRuleTestDatePositive () {    
        Warehouse_Item__c testItem = new Warehouse_Item__c (
        	Name = 'Orange',
            Quantity__c = 0,
            Price__c = 18,
            Type__c = 'Fruit',
            Added__c = Date.today().addDays(-10),
            Release__c = Date.today().addDays(-30)
        );
        Database.insert(testItem, false);
        
        Integer testWHSize = database.countQuery('SELECT count() FROM Warehouse_Item__c');
        System.assertEquals(1, testWHSize);
    }
    
    
}