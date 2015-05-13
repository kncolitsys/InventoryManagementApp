<!doctype html>

<cfclientsettings enableDeviceAPI="true" detectdevice="true" >

<cfclient>
  	<cfscript>  		
	  	inventoryDAO = new cfcs.inventory();
		latestInventoryLoad();	
		registerEvents.init();
		
		public any function latestInventoryLoad(){
			if (utils.getQueryVariable('s')) {				
				var st = decodeURIComponent(utils.getQueryVariable('s'));
				inventoryNS.searchInventory(st);	
				$('##inventorySearchText').val(st);					 
			} else {
				inventoryData = utils.queryToObject(inventoryDAO.getRecentItems(15));
				templateObj.inventoryListTemplate(inventoryData);	
			}
		} 
		
  	</cfscript>
</cfclient>


<html>
  
   <head>
    <title>CFInventory - Inventory</title>
     	
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
	    <script id="inventory-list-template" type="text/x-handlebars-template">	    
	    	{{#each records}}
	    	<div class="media">
				<a class="pull-left" href="./inventorydetail.cfm?i={{id}}" data-item="{{id}}">
					{{#if photo}}
						<img class="media-object" src="data:image/jpeg;base64,{{photo}}" style="width: 64px; height: 64px;">
					{{else}}
						<img class="media-object" alt="" src="data:image/jpeg;base64,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" style="width: 64px; height: 64px;">
					{{/if}}
				</a>
				<div class="media-body">
					<h5>({{id}}) {{name}}</h5>
					<div><em>{{suppliername}}</em></div>
		            <div class="pull-left">{{statusname}}</div>
		            <div class="label pull-right label-{{thresholdCheck onhand threshold}}">{{onhand}}</div>
		    	</div>
		    </div>
		    <hr>
			{{/each}}
	    </script>
	    
	    <script id="inventory-search-noResults" type="text/x-handlebars-template">
	    	<div class="alert alert-warning" style="text-align: center;"><strong>Your search returned no results.</strong></div>
	    	<hr>
	  		<a class="btn btn-primary btn-block" href="./inventory.cfm"><span class="glyphicon glyphicon-refresh" style="padding-right: 10px;"></span>  Reset</button>
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
      
      	<div class="input-group">
      		<span class="input-group-addon">
      			<span class="glyphicon glyphicon-search">
      			</span>
      		</span>
      		<input type="text" class="form-control" placeholder="search for item" id="inventorySearchText">
      		<span class="input-group-btn">
      			<button class="btn btn-primary" type="button" onclick="inventoryNS.searchInventory();">
      				<span class="glyphicon glyphicon-ok"></span>
      			</button>
      		</span>
      	</div>
    
		<div class="container" style="padding-top: 25px;">
			<div id="inventoryContainer">
			</div>
		  <!-- /container -->
		  	<a href="./inventoryadd.cfm" class="btn btn-primary btn-block"><span class="glyphicon glyphicon-plus" style="padding-right: 10px;"></span> New Inventory Item</a>
	
		</div>
      <!-- /container -->
    </div>
    
    <div id="footer">
      <div class="container">
        <p class="text-muted">&copy; Company 2013</p>
      </div>
    </div>
  </body>

