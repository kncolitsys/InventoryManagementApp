component client="true" output="false" {
	
	public function createInventory(data, image) {
		
		sql = "
		insert into inventory
		(
			supplierid,
			locationid,
			statusid,
			name,
			description,
			serialnum,
			cost,
			retail,
			onhand,
			threshold,
			photo
		)
		 values
		(
			
			'#data.itemSupplier#',
			'#data.itemLocation#',
			'#data.itemStatus#',
			'#data.itemName#',
			:desc,
			'#data.itemSerial#',
			'#data.itemCost#',
			'#data.itemPrice#',
			'#data.itemQuantity#',
			'#data.itemThreshold#',
			'#image#'
		)";

		
 		queryExecute(sql, [data.itemDesc], {"datasource"="cfds"});
 		return true;
    }
    
    
    public any function updateInventory(data, image){
    	
    	
    	sql = "update inventory
		    	set 
		    		supplierid = '#data.itemSupplier#',
					locationid = '#data.itemLocation#',
					statusid = '#data.itemStatus#',
					name = '#data.itemName#',
					description = :desc,
					serialnum = '#data.itemSerial#',
					cost = '#data.itemCost#',
					retail = '#data.itemPrice#',
					onhand = '#data.itemQuantity#',
					threshold = '#data.itemThreshold#'
		    		where id = #data.itemId#
		    	";
    		
 		queryExecute(sql, [data.itemDesc], {"datasource"="cfds"});
 		
 		
 		if (image != ''){
 			sql = "update inventory set photo = '#image#' where id = #data.itemId#";
 			queryExecute(sql, null, {"datasource"="cfds"});
 		}
 		
    	return true;	
    	
    }    
    
    
    public any function getRecentItems(count = 5){
    	
    	sql = "select i.id, i.name, i.onhand, i.threshold, i.photo, s.name as suppliername, st.name as statusname from inventory i join supplier s on i.supplierid = s.id join status st on i.statusid = st.id limit :count";
    	
    	
    	q = queryExecute(sql, [count], {"datasource"="cfds"});
 		return q;
    	
    }
	public any function searchInventory(searchText){
   		
    	sql = "select i.id, i.name, i.onhand, i.threshold, i.photo, s.name as suppliername, st.name as statusname from inventory i join supplier s on i.supplierid = s.id join status st on i.statusid = st.id where i.serialnum = '#searchText#'";
   		q = queryExecute(sql, null, {"datasource"="cfds"});
   		   		
   		if (! q.recordCount) {
   			return searchInventoryName(searchText);   			
   		} else {
   			return q;   			
   		}
	}
    
	public any function searchInventoryName(name){
    	
    	sql = "select i.id, i.name, i.onhand, i.threshold, i.photo, s.name as suppliername, st.name as statusname from inventory i join supplier s on i.supplierid = s.id join status st on i.statusid = st.id where i.name like '%#name#%'";
    	q = queryExecute(sql, null, {"datasource"="cfds"});
 		return q;
    	
    }
    
	public any function getInventoryItem(itemid){
    	
    	sql = "select i.*, s.name as suppliername, st.name as statusname, l.name as locationname from inventory i join supplier s on i.supplierid = s.id join status st on i.statusid = st.id join location l on i.locationid = l.id where i.id = #itemid#";
    	q = queryExecute(sql, null, {"datasource"="cfds"});
 		return q;
    	
    }
    
	public any function getInventoryItemForEdit(itemid){
    	sql = "select i.* from inventory i where i.id = #itemid#";
    	q = queryExecute(sql, null, {"datasource"="cfds"});
 		return q;
    	
    }
	public any function getInventoryLocation(location){		
		sql = "select i.id, i.name, i.onhand, i.threshold, i.photo, s.name as suppliername, st.name as statusname from inventory i join supplier s on i.supplierid = s.id join status st on i.statusid = st.id where i.locationid = #location#";
   		
    	q = queryExecute(sql, null, {"datasource"="cfds"});
 		return q;
    }
    
   
	public any function getInventorySupplier(supplier){		
		sql = "select i.id, i.name, i.onhand, i.threshold, i.photo, s.name as suppliername, st.name as statusname from inventory i join supplier s on i.supplierid = s.id join status st on i.statusid = st.id where i.supplierid = #supplier#";
   		
    	q = queryExecute(sql, null, {"datasource"="cfds"});
 		return q;
    }
         
    public any function deleteInventoryItem(itemid){
    	
    	sql = "delete from inventory where id = #itemid#";
    	q = queryExecute(sql, null, {"datasource"="cfds"});
    	
    }
    
}