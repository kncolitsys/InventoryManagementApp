<!doctype html>


<cfclientsettings enableDeviceAPI="true" detectdevice="true" >


     
<cfclient>
  	<cfscript>
  		
	  	inventoryDAO = new cfcs.inventory();	
	  	locationDAO = new cfcs.location();	
		statusObj = new cfcs.status();
		supplierDAO = new cfcs.supplier();
		registerEvents.init();
		inventoryNS.setNewInvImage('');
		
		statusData = utils.queryToObject(statusObj.getStatusByType(2));
		ui.fillSelectOptions('itemStatus', statusData);		
		
		locationData = utils.queryToObject(locationDAO.getActiveLocations());
		ui.fillSelectOptions('itemLocation', locationData);
		
		supplierData = utils.queryToObject(supplierDAO.getActiveSuppliers());
		ui.fillSelectOptions('itemSupplier', supplierData);
		
		if (utils.getQueryVariable('i')) {				
			var item = decodeURIComponent(utils.getQueryVariable('i'));
			inventoryData = utils.queryToObject(inventoryDAO.getInventoryItemForEdit(item));
			inventoryNS.fillFormForEdit(inventoryData);
			ui.hideLoadingModal();
		} else {
			window.history.go(-1);
		}
		
		
		
	
  		public void function getPicFromCam(){
  			
	        opt = cfclient.camera.getOptions();
	        res = cfclient.camera.getPicture(opt,true);
	        imgB64 ='data:image/jpeg;base64,'+res;
	        inventoryNS.setNewInvImage(res);
	        document.getElementById('invSampleImg').src = imgB64;
  			
  		}
  		
  		public void function getPicFromLib(){
  			
	        opt = cfclient.camera.getOptions();
	        res = cfclient.camera.getPictureFromPhotoLibrary(opt,true);
	        imgB64 ='data:image/jpeg;base64,'+res;
	        inventoryNS.setNewInvImage(res);
	        document.getElementById('invSampleImg').src = imgB64;
  			
  		}
  		
  	</cfscript>
    
</cfclient>

<html>
  
  <head>
    <title>CFInventory - Edit Inventory</title>
     	
    	
		<meta name="viewport" content="width=device-width">
		
		<!---css stuff--->
		<link rel="stylesheet" href="./assets/css/lib/bootstrap.min.css">
		<link rel="stylesheet" href="./assets/css/lib/flatly.bootstrap.min.css">    
		<link rel="stylesheet" href="./assets/css/lib/pgwmodal.css">   	
		<link rel="stylesheet" href="./assets/css/site.css">
		   
		    <!---libs--->	
		<script type="text/javascript" src="./assets/js/lib/jquery.min.js"></script>
		<script type="text/javascript" src="./assets/js/lib/bootstrap.min.js"></script>
		<script type="text/javascript" src="./assets/js/lib/handlebars-v1.3.0.js"></script>
		<script type="text/javascript" src="./assets/js/lib/pgwmodal.js"></script>
		   
		   	<!---site js---> 
		<script type="text/javascript" src="./assets/js/util.js"></script>
		<script type="text/javascript" src="./assets/js/site.js"></script>
		<script type="text/javascript" src="./assets/js/template.js"></script>
		<script type="text/javascript" src="./assets/js/ui.js"></script>
		<script type="text/javascript" src="./assets/js/events.js"></script>
    	
	    <script>
	    	// this needs to be here so loading overlay launches first
			ui.showLoadingModal();
	    </script>	    

  </head>
  
  <body>

    	
	<div class="navbar navbar-inverse navbar-fixed-top">
	  <div class="container">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	        <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="./index.cfm">CFInventory</a>
	    </div>
	    <div class="navbar-collapse collapse">
	      <ul class="nav navbar-nav">
	      	<li>
	          <a href="./index.cfm"><span class="glyphicon glyphicon-home" style="padding-right: 10px;"></span> Home</a>
	        </li>        
	        <li>
	        	<a href="./inventory.cfm"><span class="glyphicon glyphicon-tags" style="padding-right: 10px;"></span>Current Inventory</a>	
	        </li>            
	        <li>
		        <a href="./locations.cfm"><span class="glyphicon glyphicon-tower" style="padding-right: 10px;"></span> Inventory Locations</a>
	        </li>
	        
	        <li>
	        	<a href="./suppliers.cfm"><span class="glyphicon glyphicon-book" style="padding-right: 10px;"></span> Suppliers</a>
	        </li>	        
	        <li>
	          <a href="./learnmore.cfm"><span class="glyphicon glyphicon-question-sign" style="padding-right: 10px;"></span> About</a>
	        </li>
	       
	      </ul>
	    </div>
	    <!--/.navbar-collapse -->
	  </div>
	</div>
    
	<div class="container" style="padding-top: 25px;">
    	
      <div class="row">
        <div class="col-lg-4">
          <p class="text-center" id="formInstructions" data-original="Update the fields below to edit the item.">Update the fields below to edit the item.</p>
          <div class="well well-sm">
            <form method="post" id="inventoryForm">
            <input type="hidden" name="itemId" id="itemId">
              <div class="form-group">
                <label class="control-label">Name</label>
                <input type="text" class="form-control" id="itemName" name="itemName">
              </div>
              <div class="form-group">
                <label class="control-label">Supplier</label>
                  <select class="form-control" id="itemSupplier" name="itemSupplier">
                  	<option value="0"></option>
                  </select>
              </div>
              <div class="form-group">
                <label class="control-label">Status</label>
                  <select class="form-control" id="itemStatus" name="itemStatus">
                  	<option value="0"></option>
                  </select>
              </div>
              <div class="form-group">
                <label class="control-label">Location</label>
                  <select class="form-control" id="itemLocation" name="itemLocation">
                  <option value="0"></option>
                  </select>
              </div>
              <div class="form-group">
                <label class="control-label">Item Cost</label>
                  <input type="text" class="form-control" id="itemCost" name="itemCost">
              </div>
              <div class="form-group">
                <label class="control-label">Retail Price</label>
                  <input type="text" class="form-control" id="itemPrice" name="itemPrice">
              </div>
              <div class="form-group">
                <label class="control-label">Serial Number</label>
                  <input type="text" class="form-control" id="itemSerial" name="itemSerial">
              </div>
              <div class="form-group">
                <label class="control-label">Quantity</label>
                  <input type="number" class="form-control" id="itemQuantity" name="itemQuantity">
              </div>
              <div class="form-group">
                <label class="control-label">Threshold</label>
                  <input type="number"  class="form-control" id="itemThreshold" name="itemThreshold">
                  <span class="help-block" id="itemThresholdHelp">If quantity drops below this number a reorder alert will occurr.</span>
              </div>
              <div class="form-group">
                <label class="control-label">Description</label>
                  <textarea class="form-control" rows="5" id="itemDesc" name="itemDesc"></textarea>
              </div>
            </form>
              <div class="form-group clearfix" style="min-height: 125px; padding-bottom: 20px;">
                <div class="col-xs-6 text-center">
					<div class="btn-group">
					  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
					    Add Image <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
					    <li><a href="javascript: invokeCFClientFunction('getPicFromCam',null);" style="text-align: left;"><span class="glyphicon glyphicon-facetime-video" style="padding-right: 10px;"></span> Take Picture</a></li>
					    <li><a href="javascript: invokeCFClientFunction('getPicFromLib',null);" style="text-align: left;"><span class="glyphicon glyphicon-book" style="padding-right: 10px;"></span> Get from Photo Library</a></li>
					  	<li><a href="javascript: inventoryNS.resetImage();" style="text-align: left;"><span class="glyphicon glyphicon-trash" style="padding-right: 10px;"></span> Reset</a></li>
					  </ul>
					</div>
                </div>
                <div class="col-xs-6 text-center">
                  	<img style = "width:125; height:125;" id = "invSampleImg" class="img-thumbnail"/>
                </div>
              </div>
          </div>
        </div>
        
		<hr />
		<div>
			<div class="col-xs-6">
				<button type="button" class="btn btn-success btn-lg btn-block" onclick="history.go(-1);"><span class="glyphicon glyphicon-arrow-left"></span>&nbsp;</button>
			</div>
			<div class="col-xs-6">
			   <button  type="button" class="btn btn-info btn-lg btn-block" onclick="inventoryNS.saveEditInventory();"><span class="glyphicon glyphicon-floppy-disk" style="padding-right: 10px;"></span> Save</button>
         </div>
		</div>
      </div>
      <!-- /container -->
    </div>
    
    <div id="footer">
      <div class="container">
        <p class="text-muted">&copy; Company 2013</p>
      </div>
    </div>
  </body>

</html>



