component client="true" output="false" {
	
   public function getLocation(id) {
 		var q = queryExecute("select * FROM location where id = '#id#'", null, {"datasource"="cfds"});       
 		return q;
   }
	
   public function getAllLocationsWith() {
 		var q = queryExecute("select l.id, l.name, l.statusid, s.name as statusname, s.class from location l join status s on l.statusid = s.id", null, {"datasource"="cfds"});       
 		return q;
   }
   
   
   public function getAllLocationsWithICount() {
 		var q = queryExecute("select l.id, l.name, l.statusid, s.name as statusname, s.class , (select count(i.id) from inventory i where i.locationid = l.id) as counts from location l join status s on l.statusid = s.id", null, {"datasource"="cfds"});       
 		return q;
   }
   
   
   
   public function getActiveLocations() {
 		var q = queryExecute("select l.id, l.name from location l where statusid in (1,3)", null, {"datasource"="cfds"});       
 		return q;
   }
    
   public function updateLocation(loc) {
 		
 		var sql="update location set name = '#loc.locationName#', statusid = '#loc.locationStatus#' where id = #loc.locationId#"; 		
 		queryExecute(sql, null, {"datasource"="cfds"});       
 		return true;
   }
    
   public function deleteLocation(locid) {
   	
   		q = queryExecute("select count(id) as items from inventory where locationid = '#locid#'", null, {"datasource"="cfds"});       
 		// can only delete a location if they have no inventory
 		if ( q.items == 0 ){ 			
 			q = queryExecute("delete from location where id = #locid#", null, {"datasource"="cfds"});
 			return true;
 		} else {
 			return false;
 		}
 		
   }
    
   public function createLocation(loc) {
 		
 		var sql="insert into location (name, statusid) values ( '#loc.locationName#',  '#loc.locationStatus#')"; 		
 		queryExecute(sql, null, {"datasource"="cfds"});       
 		return true;
   }
    
	
	
}