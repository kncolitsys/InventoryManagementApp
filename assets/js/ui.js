//generic ui functions

ui = {
	 fillSelectOptions: function(field, data, selectVal){	
		$.each(data, function(key, value) {
	     	$('#' + field)
		         .append($("<option></option>")
		         .attr("value",value.id)
		         .text(value.name));
		     
		});
		
		if (selectVal) {
			$('#' + field).val(selectVal);
		}
	},
	
	showLoadingModal : function(){
		var modalWidth = cfclient.properties.width-50;
		$.pgwModal({
		    content: '<div class="loadingModalContent"><h2>Loading</h2><div class="spinner">\
  						<div class="spinner-container container1">\
						    <div class="circle1"></div>\
						    <div class="circle2"></div>\
						    <div class="circle3"></div>\
						    <div class="circle4"></div>\
						  </div>\
						  <div class="spinner-container container2">\
						    <div class="circle1"></div>\
						    <div class="circle2"></div>\
						    <div class="circle3"></div>\
						    <div class="circle4"></div>\
						  </div>\
						  <div class="spinner-container container3">\
						    <div class="circle1"></div>\
						    <div class="circle2"></div>\
						    <div class="circle3"></div>\
						    <div class="circle4"></div>\
						  </div>\
					</div></div>',
		    title: '',
		    close: false,
		    maxWidth: modalWidth
		});
		
	},
	
	hideLoadingModal : function(){
		$.pgwModal('close');
	}
}
			


 
// converts serialized data to structure 
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

