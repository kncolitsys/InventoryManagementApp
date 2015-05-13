<!doctype html>

<cfclientsettings enableDeviceAPI="true" detectdevice="true" >

<cfclient>
  	<cfscript> 
		registerEvents.init();
  	</cfscript>
</cfclient>

<html>
  
   <head>
    <title>CFInventory - Learn More</title>
 	
	
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
	      </ul>
	    </div>
	    <!--/.navbar-collapse -->
	  </div>
	</div>

	<div class="container" style="padding-top: 25px;">
		<div>
			
			<h3><a href="http://www.adobe.com/products/coldfusion-enterprise.html">ColdFusion 11 Enterprise Edition</a></h3>
			<p>Adobe ColdFusion 11 Enterprise Edition offers you a single platform to rapidly build and deploy scalable, high-performing web and mobile enterprise applications. Leverage unique capabilities to develop, test, and debug mobile applications. Generate high-quality PDF files and manipulate them with the CFPDF tag. Make your server more secure with secure profile and default server lockdown.</p>
			<h3><a href="http://www.adobe.com/products/coldfusion-standard.html">ColdFusion 11 Standard Edition</a></h3>
			<p>Adobe ColdFusion 11 Standard Edition now offers you a unique solution for end-to-end mobile application development. Generate high-quality PDF files from HTML pages. Easily create dynamic HTML5 charts. Boost productivity with full CFSCRIPT support and other language enhancements. Make your server more secure with new features such as default server lockdown and multiple sandboxes.</p>
			<h3><a href="http://www.adobe.com/products/coldfusion-builder.html">Adobe ColdFusion Builder 3</a></h3>
			<p>Adobe ColdFusion Builder 3 offers you a unique solution to develop, test, debug, and deploy mobile applications. Benefit from an all-new engine that powers the IDE to deliver across-the-board performance improvements. Leverage several smart features to boost your productivity and preserve code integrity. Manage your ColdFusion server effortlessly from within the IDE.</p>
			
		 </div>
	  <!-- /container -->
	</div>
    
    <div id="footer">
      <div class="container">
        <p class="text-muted">&copy; Company 2013</p>
      </div>
    </div>
  </body>

