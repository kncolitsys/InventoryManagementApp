component client="true" output="false" {
	public any function init()	{
		
		var sql = "";
		var q = "";
		
		sql = "create table if not exists status (
				id integer primary key,
				name text,
				type integer
			)";
		
 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		q = queryExecute('select id from status limit 1', null, {"datasource"="cfds"}); 
			
		// type = (1 : supplier, 2 : inventory, 3 : location)
		if (!q.recordCount){
			q = queryExecute("insert into status (name, type) values ('Acive', 0)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Inacive', 0)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Pending Approval', 0)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Out of business', 1)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('On Order', 2)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Closed', 3)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Discontued', 2)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Replaced with model', 2)", null, {"datasource"="cfds"});
			q = queryExecute("insert into status (name, type) values ('Backordered', 2)", null, {"datasource"="cfds"});
		}
		
		sql = "create table if not exists flowtypes (
				id integer primary key,
				name text,
				sequence integer
			)";	
		
 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		q = queryExecute('select id from flowtypes limit 1', null, {"datasource"="cfds"}); 	
		if (!q.recordCount){
			q = queryExecute("insert into flowtypes (name, sequence) values ('Quantity alert', 1)", null, {"datasource"="cfds"});
			q = queryExecute("insert into flowtypes (name, sequence) values ('Ordered', 2)", null, {"datasource"="cfds"});
			q = queryExecute("insert into flowtypes (name, sequence) values ('In Transit', 3)", null, {"datasource"="cfds"});
			q = queryExecute("insert into flowtypes (name, sequence) values ('At location', 4)", null, {"datasource"="cfds"});
		}
			
			
		sql = "create table if not exists location (
				id integer primary key,
				name text,
				statusid integer
			)";				
			
 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		q = queryExecute('select id from location limit 1', null, {"datasource"="cfds"}); 	
		if (!q.recordCount){
			q = queryExecute("insert into location (name, statusid) values ('Warehouse 44B', 1)", null, {"datasource"="cfds"});
			q = queryExecute("insert into location (name, statusid) values ('Warehouse East', 1)", null, {"datasource"="cfds"});
			q = queryExecute("insert into location (name, statusid) values ('Arizona Assembly Plant', 2)", null, {"datasource"="cfds"});
			q = queryExecute("insert into location (name, statusid) values ('California Faclility', 1)", null, {"datasource"="cfds"});
		}
		
		sql = "create table if not exists config (
			id integer primary key,
			version integer,
			updated date
		)";				
			
 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		q = queryExecute('select * from config limit 1', null, {"datasource"="cfds"}); 	
		
		if (!q.recordCount){			
			q = queryExecute("insert into config (version, updated) values (1, '#now()#')", null, {"datasource"="cfds"});
		} else {
			updateDB(q);
		}
	}
	
	public any function updateDB(conf) {
		
		
		
		if (conf.version <= 1){
			q = queryExecute("drop table if exists userdata", null, {"datasource"="cfds"});
			q = queryExecute("insert into flowtypes (name, sequence) values ('Processed', 5)", null, {"datasource"="cfds"});
		}
		if (conf.version <= 2){
			q = queryExecute("ALTER TABLE status ADD class text", null, {"datasource"="cfds"});			
			q = queryExecute("update status set class = 'label-primary' where id = 1", null, {"datasource"="cfds"});
			q = queryExecute("update status set name = 'Inactive', class = 'label-default' where id = 2", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-info' where id = 3", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-warning' where id = 4", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-info' where id = 5", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-danger' where id = 6", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-warning' where id = 7", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-warning' where id = 8", null, {"datasource"="cfds"});
			q = queryExecute("update status set class = 'label-info' where id = 9", null, {"datasource"="cfds"});
			
		}	
		if (conf.version <= 3){
			
			sql = "create table if not exists supplier (
					id integer primary key,
					name text,
					contact text,
					email text,
					address1 text,
					address2 text,
					city text,
					state text,
					zip text,
					phone text,
					altphone text,
					notes text,
					statusid integer
				)";
			
	 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		}
		
			
		if (conf.version <= 4){
			
			sql = "create table if not exists inventory (
					id integer primary key,
					supplierid integer,
					locationid integer,
					statusid integer,
					name text,
					description text,
					serialnum text,
					cost text,
					retail text,
					onhand integer,
					threshold integer,
					photo text
				)";
			
	 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		}
		
		if (conf.version <= 5){
			
			sql = "create table if not exists systemalerts (
					id integer primary key,
					inventoryid integer,
					flowtypesid integer
				)";
			
	 		q = queryExecute(sql, null, {"datasource"="cfds"}); 
		}
		
		if (conf.version != 5){
			q = queryExecute("update config set version = 5, updated = '#now()#' where id = 1", null, {"datasource"="cfds"});
		}
	}
	
	public any function checkdb() {
		q = queryExecute("select * from config limit 1", null, {"datasource"="cfds"});
		return q;
	}
}



