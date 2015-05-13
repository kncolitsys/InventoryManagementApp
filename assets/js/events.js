
registerEvents = {
	
	// post device ready listeners go here.
	init: function(){
		
		$('#learnMoreHide').on('click', function(){
			$('.jumbotron').slideUp('slow');
			$('#containerBody').css("padding-top", "25px");			
			utils.setCookie('hideJumbo',1,1000);	
		});
			
			
		
		$('.navbar-brand').html($('title').html());
		
		$('.newSupplierBtn').on('click', function(){
				
			$('#supplierModal').modal({
				remote: './supplieredit.cfm'			
			}).show();		
		
		});
		
		$('#supplierModal').on('loaded.bs.modal', function () {
		 	ui.fillSelectOptions('supplierStatus', statusData);
		 	supplierNS.fillFormForEdit();
		})
		
		$('#supplierModal').on('hidden.bs.modal', function() {
		    $(this).removeData('bs.modal');
		});
			
		
		$('.supplierListItem').on('click', function(){			
			var item = this;
			var thisId = $(item).attr('data-item');			
			var visibleItem = $('#supplierDetailContainer').children( ".well" ).attr('data-displayed-id');
						
			if (thisId == visibleItem){
				// hide element instead of showing new
				$('#supplierDetailContainer').slideUp('slow', function(){										
					$('#supplierDetailContainer').html('');
					$('.newSupplierBtn').show();	
					supplierNS.setCurrentSupplier('');
				});
				return;		
			}
			
			if (! $('#supplierDetailContainer').is(":visible")) {
				invokeCFClientFunction("supplierDetailLoad", thisId, null);
			} else {
				$('#supplierDetailContainer').slideUp('slow', function() {
					invokeCFClientFunction("supplierDetailLoad", thisId, null);
		  		});	
			}
			
		});
		
		
	},
	
	
};


