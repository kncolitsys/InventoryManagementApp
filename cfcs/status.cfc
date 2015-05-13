component client="true" output="false" {
	
   public function getStatus(id)
    {
 		q = queryExecute("select * FROM status where id = '#id#'", null, {"datasource"="cfds"});       
 		return q;
    }
	
   public function getStatusByType(type)
    {
    	// always include type 0 status as they are global
 		q = queryExecute("select * from status where type = '#type#' or type = 0", null, {"datasource"="cfds"});       
 		return q;
    }
	
	
}