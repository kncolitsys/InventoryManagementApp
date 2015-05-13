
supplierNS = {
	
	getCurrentSupplier: function(){
		return supplierEditData;
		
	},
	setCurrentSupplier: function(data){
		supplierEditData = data;
	},
	saveEditSupplier: function(){
		var formdata = $('#supplierEditForm').serializeObject();		

		if (formdata.supplierName.length) {
			if (formdata.supplierId.length){
				supplierDAO.updateSupplier(formdata);
			} else {
				supplierDAO.createSupplier(formdata);
			}
		}
		invokeCFClientFunction("supplierListLoad");
		$('#supplierModal').modal('hide');
	},
	
	deleteSuppler: function(source){
		
		var item = source;
		var thisId = $(item).attr('data-item-id');
		
		if (confirm('Are you sure you wish to delete this supplier?')){
			invokeCFClientFunction("supplierDAO.deleteSupplier", thisId, function(data){
				if (data){
					invokeCFClientFunction("supplierListLoad");
				} else  {
					alert('Unable to delete supplier.');
					return;
				}
				
			});
		}
		
	},
	
	
	editSuppler: function(source){
		
		this.setCurrentSupplier(source);
		
		$('#supplierModal').modal({
				remote: './supplieredit.cfm'			
		}).show();
		
	},
	fillFormForEdit: function(){
		
		
		source = this.getCurrentSupplier()[0];
				
		if (source.id != undefined) {
			$('#supplierId').val(source.id);
			$('#supplierName').val(source.name);
			$('#supplierContact').val(source.contact);
			$('#supplierEmail').val(source.email);
			$('#supplierAddress').val(source.address1);
			$('#supplierAddress2').val(source.address2);
			$('#supplierCity').val(source.city);
			$('#supplierState').val(source.state);
			$('#supplierZip').val(source.zip);
			$('#supplierPhone').val(source.name);
			$('#supplierAltPhone').val(source.phone);
			$('#supplierNotes').val(source.notes);
			$('#supplierStatus').val(source.statusid);
		}
		return ;
	}
	
};

locationNS = {
	reloadLocations: function(){		
		var locData = utils.queryToObject(locationDAO.getAllLocations());
		templateObj.locationsTemplate(locData);		
	},
	editLocation: function(val){
		var item = $('*[data-item="' + val + '"]');		
		var itemName = $(item).find('.data-item-name').html();
		var itemId = val;
		var itemStatus = $(item).find('.data-status-id').attr('data-status-id');
		
		$('#locationName').val(itemName);
		$('#locationStatus').val(itemStatus);
		$('#locationId').val(itemId);		
		$('#locationModal').modal('show');
		return;
	},
	
	saveEditLocation: function(){
		var loc = $('#locationEditForm').serializeObject();		
		if (loc.locationName.length) {
			if (loc.locationId.length){
				locationDAO.updateLocation(loc);
			} else {
				locationDAO.createLocation(loc);
			}
		}				
		invokeCFClientFunction("locationLoad");
		$('#locationModal').modal('hide');
	},
	deleteLocation: function(id){		
		
		if (confirm("Are you sure you wish to delete this location?")){			
			locationDAO.deleteLocation(id);		
			
			invokeCFClientFunction("locationDAO.deleteLocation", id, function(data){
						
			if (data) {
				invokeCFClientFunction("locationLoad");		
			} else {
				alert('Unable to delete location.');
				return;		
			}
			 
		});
				
		}		
				
	},
	newLocation: function(){		
		document.getElementById("locationEditForm").reset();
		$('#locationId').val('');
		$('#locationModal').modal('show');
	}
};

inventoryNS = {
	
	
	setNewInvImage : function(imgString) {
		newInvImage = imgString;	
	},
	
	getNewInvImage: function() {
		return newInvImage	
	},
	
	resetImage : function(){
		document.getElementById('invSampleImg').src = $('#invSampleImg').data('original');
		inventoryNS.setNewInvImage('');
	},
	
	
	searchInventoryFromHome : function(){
		
		var sText = $('#inventorySearchText').val();
		if (! sText.length || sText.length < 3){
			return;						
		}
		
		window.location.href = "./inventory.cfm?s=" + sText;
		
	},
	
	searchInventory : function(v){
		
		if (v) {		
			var sText = v;
		} else {
			var sText = $('#inventorySearchText').val();
			if (! sText.length || sText.length < 3){
				return;						
			}
		}
		invokeCFClientFunction("inventoryDAO.searchInventory", sText, function(data){
						
			if (data.recordCount) {
				var d = utils.queryToObject(data);
				templateObj.inventoryListTemplate(d, true);		
			} else {
				templateObj.noSearchResults();				
			}
			 
		});
		
		
	},
	getInventoryLocationName : function(loc){
		
		invokeCFClientFunction("locationDAO.getLocation", loc, function(data){		
			var d = utils.queryToObject(data);
			
			$('#inventoryContainer').prepend( '<div class="alert alert-info" style="text-align: center;"><strong>Inventory for: <br>' + d[0].name + '</strong></div><hr>' );	
		});
	},
	getInventoryByLocation : function(loc){
		invokeCFClientFunction("inventoryDAO.getInventoryLocation", loc, function(data){		
			if (data.recordCount) {
				var d = utils.queryToObject(data);
				templateObj.inventoryListTemplate(d, false);	
				inventoryNS.getInventoryLocationName(loc);		
			} else {
				templateObj.noSearchResults();				
			}
			 
		});
		
	},
	
	getInventoryBySupplier : function(sup){
		invokeCFClientFunction("inventoryDAO.getInventorySupplier", sup, function(data){		
			if (data.recordCount) {
				var d = utils.queryToObject(data);
				templateObj.inventoryListTemplate(d, false);	
				
			} else {
				templateObj.noSearchResults();				
			}
			 
		});
		
	},
	
		
	getInventoryItem : function(item) {
		invokeCFClientFunction("inventoryDAO.getInventoryItem", item, function(data){			
			if (data.recordCount) {
				var d = utils.queryToObject(data);
				templateObj.inventoryDetailTemplate(d);	
			} else {
				window.location.href = "./inventory.cfm";			
			}
			 
		});
		
	},	
	
	deleteInventory : function(item){
		if (confirm("Are you sure you wish to delete this inventory item?")){					
			invokeCFClientFunction("inventoryDAO.deleteInventoryItem", item, function(){
				window.location.href = "./inventory.cfm";
			});		
		}		
		
	},
	
	fillFormForEdit : function(data){
		var $data = data[0];
		
		$('#itemId').val($data.id);
		$('#itemName').val($data.name);
		$('#itemQuantity').val($data.onhand);	
		$('#itemThreshold').val($data.threshold);		
		$('#itemCost').val($data.cost);	
		$('#itemPrice').val($data.retail);	
		$('#itemSerial').val($data.serialnum);	
		$('#itemDesc').val($data.description);	
		$('#itemSupplier').val($data.supplierid);	
		$('#itemStatus').val($data.statusid);	
		$('#itemLocation').val($data.locationid);	
		
		
		
		if ($data.photo != '') {
			photo = $data.photo;
		} else {
			photo = utils.getTempImage();	
		}
		
		imgB64 ='data:image/jpeg;base64,'+ photo;
		
		$('#invSampleImg').data('original', imgB64);		
        $('#invSampleImg').attr('src', imgB64);
	},
	
	validateInventoryForm : function(formdata){
		var errors = false;
		$('.has-error').removeClass('has-error');
		$('.text-danger').removeClass('text-danger');
		
		if (! formdata.itemQuantity.length) {
			$('#itemQuantity').parent().addClass('has-error');
			errors = true;
		} else if (parseInt(formdata.itemQuantity) <= parseInt(formdata.itemThreshold)) {
			$('#itemQuantity').parent().addClass('has-error');
			$('#itemThreshold').parent().addClass('has-error');
			$('#itemThresholdHelp').html('The quantity amount must be larger than the threshold.')
			errors = true;
		}
		
		if (! formdata.itemName.length){
			$('#itemName').parent().addClass('has-error');
			errors = true;
		}
		
		if (formdata.itemSupplier == 0){
			$('#itemSupplier').parent().addClass('has-error');
			errors = true;
		}
		if (formdata.itemLocation == 0){
			$('#itemLocation').parent().addClass('has-error');
			errors = true;
		}
		if (formdata.itemStatus == 0){
			$('#itemStatus').parent().addClass('has-error');
			errors = true;
		}
		
		return errors;
	},
	
	
	saveEditInventory : function(){
		
		var errors = false;
		var formdata = $('#inventoryForm').serializeObject();	
		
		errors = inventoryNS.validateInventoryForm(formdata);
		if (errors){			
			$("html, body").animate({ scrollTop: 0 }, "slow");			
			$('#formInstructions').addClass('text-danger').html('Please correct the fields in red.');
		} else {
		
			invokeCFClientFunction("inventoryDAO.updateInventory", formdata, inventoryNS.getNewInvImage(), function(){
				$('#formInstructions').html( $('#formInstructions').attr('data-original') );
				$('.has-error').removeClass('has-error');
				$('.text-danger').removeClass('text-danger');	
				$("html, body").animate({ scrollTop: 0 }, "slow");	
				alert('Item Updated.');
			});
		}
		
		
	},
	
	
	saveNewInventory : function(){		
		var errors = false;
		var formdata = $('#inventoryForm').serializeObject();	
		// remove any error classes left behind.		
		errors = inventoryNS.validateInventoryForm(formdata);
		
		if (errors){			
			$("html, body").animate({ scrollTop: 0 }, "slow");			
			$('#formInstructions').addClass('text-danger').html('Please correct the fields in red.');			
		} else {
			// all good lets save the item
			invokeCFClientFunction("inventoryDAO.createInventory", formdata, inventoryNS.getNewInvImage(), function(){
				if (confirm('Item created.  Whould you like to create another?')){
					// reset form back to load state
					document.getElementById("inventoryForm").reset();	
					inventoryNS.setNewInvImage('');
					$('#formInstructions').html( $('#formInstructions').attr('data-original') );
					$('.has-error').removeClass('has-error');
					$('.text-danger').removeClass('text-danger');
					$("html, body").animate({ scrollTop: 0 }, "slow");				
				} else {
					window.location.href = "./inventory.cfm";
				}
			});			
		}
		
	}
	

};



alerts = {
	
	generator : function(){		
		invokeCFClientFunction("systemalertsDAO.createRandomAlert", null, function(){ 
			console.log('------------');			
			invokeCFClientFunction("systemalertsDAO.getRecentItems", null, function(data){	
				if (data.recordCount) {
					var d = utils.queryToObject(data);
					templateObj.systemAlerts(d);	
				}
			});
			
		});
	}
	
	
}


