component client="true" output="false" {
	
   public function getSupplierDetail(id) {
 		q = queryExecute("select s.*, st.name as statusname from supplier s join status st on s.statusid = st.id and s.id = '#id#'", null, {"datasource"="cfds"});       
 		return q;
    }
    
    public function getSupplier(id) {
 		q = queryExecute("select s.* from supplier s where s.id = '#id#'", null, {"datasource"="cfds"});       
 		return q;
    }
    public function getActiveSuppliers() {
 		q = queryExecute("select id, name from supplier", null, {"datasource"="cfds"});       
 		return q;
    }
	public function getSupplierList() {
 		q = queryExecute("select id, name, contact, phone FROM supplier ", null, {"datasource"="cfds"});       
 		return q;
    }
    
    
	public function createSupplier(data) {
		
		sql = "
		insert into supplier
		(
			name,
			contact,
			email,
			address1,
			address2,
			city,
			state,
			zip,
			phone,
			altphone,
			notes,
			statusid
		)
		 values
		(
			
			'#data.supplierName#',
			'#data.supplierContact#',
			'#data.supplierEmail#',
			'#data.supplierAddress#',
			'#data.supplierAddress2#',
			'#data.supplierCity#',
			'#data.supplierState#',
			'#data.supplierZip#',
			'#data.supplierPhone#',
			'#data.supplierAltPhone#',
			'#data.supplierNotes#',
			'#data.supplierStatus#'
		)";

		
 		queryExecute(sql, null, {"datasource"="cfds"});
 		return true;
    }
    
    public function updateSupplier(data) {
		
		sql = "
		update supplier
		set 
			name = '#data.supplierName#',
			contact = '#data.supplierContact#',
			email = '#data.supplierEmail#',
			address1 = '#data.supplierAddress#',
			address2 = '#data.supplierAddress2#',
			city = '#data.supplierCity#',
			state = '#data.supplierState#',
			zip = '#data.supplierZip#',
			phone = '#data.supplierPhone#',
			altphone = '#data.supplierAltPhone#',
			notes = '#data.supplierNotes#',
			statusid = '#data.supplierStatus#'
		where id = #data.supplierId#";

		
 		queryExecute(sql, null, {"datasource"="cfds"});
 		return true;
    }
    
    
    
   public function deleteSupplier(id) {
 		q = queryExecute("select count(id) as items from inventory where supplierid = '#id#'", null, {"datasource"="cfds"});       
 		// can only delete a supplier if they have no inventory
 		if ( q.items == 0 ){ 			
 			q = queryExecute("delete from supplier where id = '#id#'", null, {"datasource"="cfds"});
 			return true;
 		} else {
 			return false;
 		}
    }
    
    
}