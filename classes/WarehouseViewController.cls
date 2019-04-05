public class WarehouseViewController {
    public List<Warehouse_Item__c> itemsWarehouse { get; set; }
    public Warehouse_Item__c itemForAdd { get; set; }
    
    public String sortItems { get; set; }
    public String sortOrders { get; set; }
    
    public String selectedItemId { get; set; }
    public String searchItemName { get; set; }
    public Date searchItemDate { get; set; }
        
    public Integer totalSize {get; set;}
    public Integer totalSizeForView {get; set;}
    public Integer currentPageCount {get; set;}
    public Integer listSize {get; set;}
	public Integer currentPageNumber {get; set;}
    
    public Boolean disableNext {get; set;}
    public Boolean disablePrevious {get; set;}
    
    public Integer inputListSize {get; set;}
    
    public WarehouseViewController () {
        sortItems = 'Name';
        sortOrders = 'ASC';
        itemForAdd = new Warehouse_Item__c ();
        searchItemName = '';
		searchItemDate = null; 
        currentPageCount = 0;
        currentPageNumber = 0;
        listSize = 5;
        InputListSize = 5;
        disablePrevious = true;
        disableNext = false;
		GetItems();        
    }
    	
    private void GetItems () {
        String querySearch = '';
        
        if(searchItemName != '' && searchItemDate != null) {
            querySearch += 'WHERE Name like \'%' + searchItemName + '%\' AND ' +
                'Added__c = '  + Datetime.newInstance(searchItemDate.year(), searchItemDate.month(), searchItemDate.day()).format('yyyy-MM-dd');
        } else if (searchItemName != '' && searchItemDate == null) {
            querySearch += 'WHERE Name like \'%' + searchItemName + '%\'';
        } else if (searchItemName == '' && searchItemDate != null) {
            querySearch += 'WHERE Added__c = '  + Datetime.newInstance(searchItemDate.year(), searchItemDate.month(), searchItemDate.day()).format('yyyy-MM-dd');
        }
        
        String querySize = 'SELECT count() FROM Warehouse_Item__c ' + querySearch;
        totalSize = database.countQuery(querySize);
		currentPageNumber = (currentPageCount/listSize)+1;
        totalSizeForView = Math.mod(totalSize, listSize)==0 ? totalSize/listSize : (totalSize/listSize)+1;

		String queryLimit = ' LIMIT ' + listSize  + ' OFFSET ' + (currentPageCount);
        
        String querySQL = 'SELECT id, Name, Added__c, In_Stock__c, Price__c, Quantity__c, Release__c, Type__c '+
            	   'FROM Warehouse_Item__c '+ querySearch +
                   ' ORDER BY ' + sortItems + ' ' + sortOrders + queryLimit; 
        
        itemsWarehouse = Database.query(querySQL);
        disableNext = GetDisableNext();
        disablePrevious = GetDisablePrevious();
    }
    
    public void SortItems () {
        if (sortOrders == 'ASC') {
            sortOrders = 'DESC';
        } else if (sortOrders == 'DESC') {
            sortOrders = 'ASC';
        }
		GetItems();
    }
        
    public void SearchByItem() {
        GetItems();
    }
    
    public void DeleteItem()
   	{
      if (selectedItemId == null) {
         return;
      }
      Warehouse_Item__c tobeDeleted = null;
      for(Warehouse_Item__c item : itemsWarehouse)
       if (item.id == selectedItemId) {
          tobeDeleted = item;
          break;
       }
      
      if (tobeDeleted != null) {
          try{
          	Delete tobeDeleted;
          }
          catch (DMLException e) {
        	string err = tobeDeleted.Name + ' - ' + e.getDmlMessage(0);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,err));
        }
      }
        GetItems();
   	}    
    
    public void Save() {
        try{
    		insert itemForAdd;
            itemForAdd = new Warehouse_Item__c ();
        }
        catch (DMLException e) {
            string err = itemForAdd.Name + ' - ' + e.getDmlMessage(0);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,err));
        }
        GetItems();
    }
    
    public void NextPage() {
        currentPageCount += listSize;
        GetItems();
    }
    
    public void PreviousePage() {
        currentPageCount -= listSize;
        GetItems();
    }
    
    public Boolean GetDisableNext() {
        if(currentPageCount + listSize < totalSize) return false; else return true;
    }
    
    public Boolean GetDisablePrevious() { 
    	if(currentPageCount>0) return false; else return true;
   }
    
    public void ChangeListSize () {
        if(inputListSize <=0) {
            return;
        } else {
            listSize = inputListSize;
        	currentPageCount = 0;
        	GetItems();
        }
    }
	
}