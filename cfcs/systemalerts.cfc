component client="true" output="false" {
	
	// this code is just form simulating events for inventory quantity threshold
	// gets random item from inventory and manipulates quantities and updates system alerts
	public any function createRandomAlert() {
		var sql = '';
		var q = queryExecute('select id from inventory', null, {"datasource"="cfds"}); 
		var ids = '';
		var qCheck =  '';
		
		for (var i = 1; i <= q.length; i++) {
			ids = listAppend(ids,q.id[i]);
		}
		randItem = listGetAt(ids, randRange(1, q.length));
		sql = "select i.* from inventory i where i.id = #randItem#";
    	invItem = queryExecute(sql, null, {"datasource"="cfds"});
    	
    	console.log(randItem);
    	
		var newQ = invItem.onhand;
    	var qCheck = checkThreshold(invItem.onhand, invItem.threshold);
		console.log('qcheck 1 : ' + qCheck);
		console.log('quan : ' + invItem.onhand);
		
		
    	if (qCheck == 11) { // inventory count is inside the warning zone.. lets lower onhand by quarter
    		newQ = Math.floor(invItem.onhand-(invItem.onhand*.25));    		    		
    	}
    	if (qCheck == 10) { // inventory is good.. lets drop by third
    		newQ = Math.floor(invItem.onhand-(invItem.onhand/3));
    	}
    	
		console.log('newQ : ' + newQ);
		
    	if (isNumeric(newQ)){
    		sql = 'update inventory set onhand = #newQ# where id = #randItem#';
    		upd = queryExecute(sql, null, {"datasource"="cfds"});    	
    	
    		qCheck = checkThreshold(newQ, invItem.threshold);
			console.log('qcheck 2 : ' + qCheck);
    		
    		if (qCheck == 11) { // warning alert	    		
    			sql = 'insert into systemalerts (inventoryid , flowtypesid ) values (#randItem#, 1)';
    			ins = queryExecute(sql, null, {"datasource"="cfds"});    	
	    	}
	    	if (qCheck == 12) { // inventory is in danger zone.. throw alert
	    	
	    		// get last alert...
	    		// if id is not 5 set to next id
	    		// if 5 set quantity to 3x threshold and remove alerts for item
	    		sql = "select  * from systemalerts where inventoryid = #randItem# order by flowtypesid desc limit 1";
	    		sel = queryExecute(sql, null, {"datasource"="cfds"});
	    		console.log(sel);
	    		if (! sel.recordCount) { // no alerts for item.. create at level 2	    		
	    			sql = 'insert into systemalerts (inventoryid , flowtypesid ) values (#randItem#, 2)';
    				ins = queryExecute(sql, null, {"datasource"="cfds"});  
	    		} else {
	    			if (sel.flowtypesid != 5) {
	    				nextFlow = sel.flowtypesid+1;	    						
		    			sql = 'insert into systemalerts (inventoryid , flowtypesid ) values (#randItem#, #nextFlow#)';
	    				ins = queryExecute(sql, null, {"datasource"="cfds"});  
	    			} else {	    					
		    			sql = 'delete from  systemalerts where inventoryid = #randItem#';    					
	    				ins = queryExecute(sql, null, {"datasource"="cfds"});	    				
	    				newQ = invItem.threshold*3;
	    				sql = 'update inventory set onhand = #newQ# where id = #randItem#';	    					
	    				upd = queryExecute(sql, null, {"datasource"="cfds"});	    						
	    			}   			
	    		}
	    	}
    	}
    	
		return true;
	}
	
	 public any function getRecentItems(count = 10){
    	
    	sql = "select i.name as inventoryname, f.name as alert from systemalerts s join inventory i on s.inventoryid = i.id join flowtypes f on s.flowtypesid = f.id order by s.id  limit :count";
    	q = queryExecute(sql, [count], {"datasource"="cfds"});
 		return q;
    	
    }
	
	private any function checkThreshold(quantity, threshold) {
		if (quantity == 0 || quantity == '') {
			return 0;
		}
		
		if (threshold == 0 || threshold == '') {
			return 1;
		}
		
		var t = threshold * 1.25;
		
		console.log('thr : ' + threshold);
		console.log('th : ' + t);
		if (quantity <= t && quantity > threshold) {
			return 11;
		} else if (quantity <= threshold) {
			return 12;
		} else {
			return 10;
		}
		
	}
	
}



