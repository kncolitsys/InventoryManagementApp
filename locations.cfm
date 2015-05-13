<!doctype html>

<cfclientsettings detectdevice="true" enabledeviceapi="true"/>

<cfclient>
	<cfscript>
		locationDAO = new cfcs.location();
		locationDAO = new cfcs.location();
		statusObj = new cfcs.status();	
		registerEvents.init();
		
		statusData = utils.queryToObject(statusObj.getStatusByType(3));
		ui.fillSelectOptions('locationStatus', statusData);
		
		locationLoad();
		
		public any function locationLoad(){				
			locData = utils.queryToObject(locationDAO.getAllLocationsWithICount());
			templateObj.locationsTemplate(locData);
			ui.hideLoadingModal();
		};
		
	</cfscript>

	
</cfclient>

<html>
  <head>
    <title>CFInventory - Locations</title>
    
   
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
    
    <script id="locations-list-template" type="text/x-handlebars-template">
    	{{#each records}}
		<div class="list-group" data-item="{{id}}">
			<div class="list-group-item clearfix">
				<div class="pull-left">
					<p> 
						<span class="data-item-name">
							{{#ifCond counts '>' 0}}
								<span class="badge">{{counts}}</span>
								<a href="./locationinventory.cfm?l={{id}}">{{name}}</a>
							{{else}}
								{{name}}
							{{/ifCond}}
						</span>
					</p>
					<span class="label {{class}} data-status-id" data-status-id="{{statusid}}">{{statusname}}</span>
		  		</div>
			  	<div class="pull-right">
					<button class="btn btn-primary btn-md" onclick="locationNS.editLocation({{id}});" data-value="{{id}}"><span class="glyphicon glyphicon-pencil"></span></button>
					<button class="btn btn-primary btn-md"  onclick="locationNS.deleteLocation({{id}});"><span class="glyphicon glyphicon-trash"></span></button>
			  </div>
			</div>
		</div>
		{{/each}}
    </script>
  </head>
  
  <body>
  	<div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="locationModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="modalLabel">Location</h4>
	      </div>
	      <div class="modal-body">
	       <form role="form" id="locationEditForm">
			  <input type="hidden" id="locationId" name="locationId">
			  <div class="form-group">
			    <label for="locationName">Name</label>
			    <input type="text" class="form-control" id="locationName" name="locationName">
			  </div>
			  <div class="form-group">
			    <label for="locationStatus">Status</label>
			    <select class="form-control" id="locationStatus" name="locationStatus">
				</select>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="locationNS.saveEditLocation();">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
  		
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
      <div id="bodyContainer" ></div>
      <!-- /container -->
      
      <button type="button" class="btn btn-primary btn-block" onclick="locationNS.newLocation();"><span class="glyphicon glyphicon-plus" style="padding-right: 10px;"></span>  New Location</button>
      
    </div>
    <div id="footer">
      <div class="container">
        <p class="text-muted">&copy; Company 2013</p>
      </div>
    </div>
    

    
    
  </body>

</html>