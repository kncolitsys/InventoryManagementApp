<!doctype html>
<cfclientsettings detectdevice="true" enabledeviceapi="true"/>

<cfclient>
	<cfscript>
    	    

		supplierDAO = new cfcs.supplier();	
		statusObj = new cfcs.status();
		
		supplierListLoad();
		registerEvents.init();
		
		statusData = utils.queryToObject(statusObj.getStatusByType(1));
		
		public any function supplierListLoad(){
			var supplierData = utils.queryToObject(supplierDAO.getSupplierList());
			templateObj.supplierListTemplate(supplierData);
			ui.hideLoadingModal();
		}
		
		public any function supplierLoadForEdit(required any id){
			var d = utils.queryToObject(supplierDAO.getSupplier(id));
			supplierNS.editSuppler(d);
		}
		
		public any function supplierDetailLoad(required any id){
			var supplierData = utils.queryToObject(supplierDAO.getSupplierDetail(id));
			templateObj.supplierDetailTemplate(supplierData);
		}
	
	</cfscript>

</cfclient>
<html>
  
  <head>
    <title>CFInventory - Suppliers</title>
    
	
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
    
    <!---templates--->
    <script id="supplier-list-template" type="text/x-handlebars-template">
    	{{#each records}}
    		<div class="list-group supplierListItem" data-item="{{id}}">
				<div class="list-group-item clearfix">
		            <h4 class="list-group-item-heading">{{name}}</h4>
		            <div class="list-group-item-text pull-left"><em>{{contact}}</em></div>
		            <div class="list-group-item-text pull-right"><a href="tel:{{phone}}">{{phone}}</a></div>
	          	</div>
          	</div>
		{{/each}}
    </script>
    <script id="supplier-detail-template" type="text/x-handlebars-template">
		{{#each records}}
			<div class="well row" style="margin-top: -9px" data-displayed-id="{{id}}">
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Name</b>:</span>
					</div>
					<div class="col-xs-8">{{name}}</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Contact</b>:</span>
					</div>
					<div class="col-xs-8">{{contact}}</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Email</b>:</span>
					</div>
					<div class="col-xs-8">
						<a href="mailto:{{email}}">{{email}}</a>
					</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Phone</b>:</span>
					</div>
					<div class="col-xs-8">
						<a href="tel:{{phone}}">{{phone}}</a>
					</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Address</b>:</span>
					</div>
					<div class="col-xs-8">
						<address>{{address1}}<br>{{address2}}<br>{{city}}, {{state}} {{zip}}</address>
					</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Alt Phone</b>:</span>
					</div>
					<div class="col-xs-8">
						<a href="tel:{{altphone}}">{{altphone}}</a>
					</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Status</b>:</span>
					</div>
				<div class="col-xs-8">{{statusname}}</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-4">
						<span class="pull-right"><b>Notes</b>:</span>
					</div>
					<div class="col-xs-8">{{notes}}</div>
				</div>
				<hr />
				<div>
					<div class="col-xs-4">
						<button type="button" class="btn btn-danger btn-lg btn-block" onclick="supplierNS.deleteSuppler(this)" data-item-id="{{id}}"><span class="glyphicon glyphicon-trash"></span></button>
					</div>
					<div class="col-xs-4">
						<a type="button" class="btn btn-primary btn-lg btn-block" href="./supplierinventory.cfm?s={{id}}" ><span class="glyphicon glyphicon-tags"></span></a>
					</div>
					<div class="col-xs-4">
						<button type="button" class="btn btn-success btn-lg btn-block" onclick="invokeCFClientFunction('supplierLoadForEdit', {{id}}, null)" data-item-id="{{id}}"><span class="glyphicon glyphicon-pencil"></span></button>
					</div>
				</div>
			</div>
		{{/each}}
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
		<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog" aria-labelledby="supplierModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content"></div>
			</div>
		</div>
		<div id="supplierContainer"></div>
		<div id="supplierDetailContainer"></div>
		<button type="button" class="btn btn-primary btn-block newSupplierBtn" style="display: none;" ><span class="glyphicon glyphicon-plus" style="padding-right: 10px;"></span> New Supplier</button>
	  <!-- /container -->
	</div>
    <div id="footer">
      <div class="container">
        <p class="text-muted">&copy; Company 2013</p>
      </div>
    </div>
    
  </body>

