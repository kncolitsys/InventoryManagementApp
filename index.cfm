<!doctype html>
<cfclientsettings detectdevice="true" enabledeviceapi="true"/>

<cfclient>
	
	<cfscript>
		config = new cfcs.config();
		
	  	systemalertsDAO = new cfcs.systemalerts();
		
		registerEvents.init();
		initHome();
		alerts.generator();
		
		public any function initHome() {
		
			if ( utils.getCookie('hideJumbo') != 1) {
				$('.jumbotron').slideDown('slow');		
				$('##containerBody').css("padding-top", "0px");	
			};
			
		}
	</cfscript>
</cfclient>



<html>
  
  <head>
    <title>CFInventory - Home</title>
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
	    
		<!---templates--->    
    
	    <script id="systemalerts-list-template" type="text/x-handlebars-template">	 
          <h2>System Alerts</h2>   	
	    	<ul class="list-group">
	    		{{#each records}}
				  <li class="list-group-item ">{{inventoryname}} <span class="badge {{alertToClass alert}}">{{alert}}</span></li>
			  	{{/each}}
			</ul>
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
    <div class="jumbotron" style="display: none;">
      <div class="container" id="jumbocontainer">
        <p>This is a demo mobile application to show off some of the features of ColdFusion 11's new CFClient functionality.&nbsp;</p>
        <p><a class="btn btn-primary btn-lg" href="./learnmore.cfm">Learn more &raquo;</a><button class="btn btn-info btn-lg pull-right" id="learnMoreHide">Hide</button></p>
      </div>
    </div>
    <div class="container" id="containerBody" style="padding-top: 25px;">
      <form>
        <div class="input-group">
          <span class="input-group-addon">
            <span class="glyphicon glyphicon-search"></span>
          </span>
      		<input type="text" class="form-control" placeholder="search inventory" id="inventorySearchText">
           <span class="input-group-btn">
            <button class="btn btn-primary" type="button" onclick="inventoryNS.searchInventoryFromHome();">
              <span class="glyphicon glyphicon-ok"></span>
            </button>
          </span>
        </div>        
      </form>
      <div class="list-group">
        <a href="./inventory.cfm" class="list-group-item"><span class="glyphicon glyphicon-tags" style="padding-right: 10px;"></span>Current Inventory List</a>
        <a href="./inventoryadd.cfm" class="list-group-item"><span class="glyphicon glyphicon-plus" style="padding-right: 10px;"></span> Add Inventory</a>
        <a href="./locations.cfm" class="list-group-item"><span class="glyphicon glyphicon-tower" style="padding-right: 10px;"></span> Inventory Locations</a>
        <a href="./suppliers.cfm" class="list-group-item"><span class="glyphicon glyphicon-book" style="padding-right: 10px;"></span> Suppliers</a>
      </div>
      <div class="row">
        <div class="col-lg-4" id="alertContainer">
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