@isTest
	private class WarehouseViewControllerTest {
		
        @isTest static void WHViewControllerTest () {
            WarehouseViewController WHVC = new WarehouseViewController();
            
            WHVC.itemForAdd = new Warehouse_Item__c(
            	Name = 'Pen',
                Quantity__c = 12,
                Price__c = 122,
                Type__c = 'Office',
                Added__c = Date.today(),
                Release__c = Date.today().addDays(5)
            );
            WHVC.Save();
            
            WHVC.itemForAdd = new Warehouse_Item__c(
            	Name = 'Bag',
                Quantity__c = 12,
                Price__c = 122,
                Type__c = 'Office',
                Added__c = Date.today(),
                Release__c = Date.today().addDays(-55)
            );
            WHVC.Save();
            
            WHVC.itemForAdd = new Warehouse_Item__c(
            	Name = 'Laptop',
                Quantity__c = 122,
                Price__c = 1122,
                Type__c = 'Office',
                Added__c = Date.today().addDays(-1),
                Release__c = Date.today().addDays(-50)
            );
            WHVC.Save();
            
            //check filling the database
            Integer testWHSize = database.countQuery('SELECT count() FROM Warehouse_Item__c');
        	System.assertEquals(2, testWHSize);
            
            //check Sort and Order
            WHVC.sortOrders = 'DESC';
            WHVC.sortItems = 'Name';
            WHVC.SortItems();
            System.assertEquals('ASC', WHVC.sortOrders);
            System.assertEquals('Bag', WHVC.itemsWarehouse[0].Name);
            
            //check Delete
            WHVC.itemForAdd = new Warehouse_Item__c(
            	Name = 'Phone',
                Quantity__c = 12,
                Price__c = 332,
                Type__c = 'Office',
                Added__c = Date.today(),
                Release__c = Date.today().addDays(-50)
            );
            WHVC.Save();
            testWHSize = database.countQuery('SELECT count() FROM Warehouse_Item__c');
        	System.assertEquals(3, testWHSize);
            List<Warehouse_Item__c> selectedIdForDel = [SELECT Id FROM Warehouse_Item__c WHERE Name = 'Phone'];
            WHVC.selectedItemId = selectedIdForDel[0].id;
            WHVC.DeleteItem();
            testWHSize = database.countQuery('SELECT count() FROM Warehouse_Item__c');
            System.assertEquals(2, testWHSize);
            
            //check Search
            WHVC.searchItemName = 'Laptop';
            WHVC.searchItemDate = Date.today().addDays(-1);
            WHVC.SearchByItem();
            System.assertEquals(1, WHVC.itemsWarehouse.size());
            System.assertEquals('Laptop', WHVC.itemsWarehouse[0].Name);
            
            //check ChangeListSize
            WHVC.listSize = 3;
            WHVC.inputListSize = -5;
            WHVC.ChangeListSize();
            System.assertEquals(3, WHVC.listSize);
            WHVC.inputListSize = 7;
            WHVC.ChangeListSize();
            System.assertEquals(7, WHVC.listSize);
        }
	}