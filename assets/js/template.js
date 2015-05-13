/**
 * Created by dferguson on 3/2/14.
 */


//template rendering functions

templateObj = {
	
	locationsTemplate: function(data) {
		var source   = $("#locations-list-template").html();
		var template = Handlebars.compile(source);
		$("#bodyContainer").html(template({records: data}));	
	},
	
	supplierListTemplate: function(data){
		var source   = $("#supplier-list-template").html();
		var template = Handlebars.compile(source);
		$("#supplierContainer").html(template({records: data}));		
		$('.newSupplierBtn').show();	
		$('.supplierListBtn').hide();
	
	},
	
	supplierDetailTemplate: function(data){
		
		var source   = $("#supplier-detail-template").html();
		var template = Handlebars.compile(source);
		
		$('#supplierDetailContainer').insertAfter($( ".supplierListItem[data-item='" + data[0].id + "']" ));
		$("#supplierDetailContainer").html(template({records: data}));	
		$('#supplierDetailContainer').slideDown('slow');		
		$('.newSupplierBtn').hide();	
		$('.supplierListBtn').show();
		
	},
	
	inventoryListTemplate: function(data, isSearch){
		
		var source   = $("#inventory-list-template").html();
		var template = Handlebars.compile(source);
		$("#inventoryContainer").html(template({records: data}));
		
		if (isSearch){
			$('#inventoryContainer').prepend( '<div class="alert alert-info" style="text-align: center;"><strong>' + data.length + '</strong> items found</div><hr>' );			
		}		
		ui.hideLoadingModal();
	}, 
	
	inventoryDetailTemplate: function(data){
		
		var source   = $("#inventory-detail-template").html();
		var template = Handlebars.compile(source);
		$("#inventoryContainer").html(template({records: data}));
		ui.hideLoadingModal();
	}, 
	noSearchResults: function(){
		
		var source   = $("#inventory-search-noResults").html();
		var template = Handlebars.compile(source);
		$("#inventoryContainer").html(template());
		
	},
	
	systemAlerts: function(data){
		var source   = $("#systemalerts-list-template").html();
		var template = Handlebars.compile(source);
		$("#alertContainer").html(template({records: data}));
		
	}
	
	
	
	
	
};



// handlbars helpers
Handlebars.registerHelper('ifvalue', function (conditional, options) {
  if (options.hash.value == conditional) {
    return options.fn(this)
  } else {
    return options.inverse(this);
  }
});


Handlebars.registerHelper('statusIDtoText', function(status) {
  return status;
});

Handlebars.registerHelper('ifCond', function (v1, operator, v2, options) {

    switch (operator) {
        case '==':
            return (v1 == v2) ? options.fn(this) : options.inverse(this);
        case '===':
            return (v1 === v2) ? options.fn(this) : options.inverse(this);
        case '<':
            return (v1 < v2) ? options.fn(this) : options.inverse(this);
        case '<=':
            return (v1 <= v2) ? options.fn(this) : options.inverse(this);
        case '>':
            return (v1 > v2) ? options.fn(this) : options.inverse(this);
        case '>=':
            return (v1 >= v2) ? options.fn(this) : options.inverse(this);
        case '&&':
            return (v1 && v2) ? options.fn(this) : options.inverse(this);
        case '||':
            return (v1 || v2) ? options.fn(this) : options.inverse(this);
        default:
            return options.inverse(this);
    }
});





Handlebars.registerHelper('alertToClass', function(alert) {
	
	if (alert == 'Quantity alert') {		
		return 'alert-primary';
	}
	if (alert == 'Ordered') {		
		return 'alert-danger';
	}
	if (alert == 'In Transit') {		
		return 'alert-warning';
	}
	if (alert == 'At location') {		
		return 'alert-info';
	}
	if (alert == 'Processed') {		
		return 'alert-success';
	}
	
	
	
});

Handlebars.registerHelper('thresholdCheck', function(quantity, threshold) {
	
	if (quantity == 0 || quantity == '') {
		return 'danger';
	}
	
	if (threshold == 0 || threshold == '') {
		return 'primary';
	}
	
	var t = threshold * 1.25;
	
	if (quantity <= t && quantity > threshold) {
		return "warning";
	} else if (quantity <= threshold) {
		return "danger";
	} else {
		return 'primary'
	}
	
});


