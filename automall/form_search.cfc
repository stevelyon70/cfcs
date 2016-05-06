<cfcomponent>

	<cffunction name="vehicle_search" description="vehicle search" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="form_id" default="searchForm">
		<cfargument name="form_class" default="spl-form">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<input class="spl-search-input" type="text" name="search_zip" id="search_zip_#arguments.form_id#" value="#cookie.savezip#" maxlength="5" placeholder="Your Zip Code">
			<select class="spl-search-input" name="search_radius" id="search_radius_#arguments.form_id#">
				<option value="5">5 Miles</option>
				<option value="10">10 Miles</option>
				<option value="25" selected="selected">25 Miles</option>
				<option value="50">50 Miles</option>
				<option value="100">100 Miles</option>
			</select>
			<!--- <select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
				<option value="">Select a Year</option>
				<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
					<cfinclude template="/automall/sandbox/search_years.cfm" >
				</cfcache>
			</select>  --->
			<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
				<option value="N">New Vehicles</option>
				<option value="U">Pre-Owned Vehicles</option>
				<option value="C">Certified Vehicles</option>
			</select>
			<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
				<option>loading makes...</option>
			</select>
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
				<option>loading models...</option>
			</select>
			
				
			<select class="spl-search-input" name="search_body" id="search_body_#arguments.form_id#">
				<option>loading body types...</option>
			</select>
			
			
			<!--- <select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
				<option value="">Select a Year</option>
				<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
					<cfinclude template="/automall/sandbox/search_years.cfm" >
				</cfcache>
			</select> --->
			
			
<!---			<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
				<cfinclude template="/automall/sandbox/search_nu.cfm" >
				<!---<option value="N">New Vehicles</option>
				<option value="U">Pre-Owned Vehicles</option>
				<option value="C">Certified Vehicles</option>
				<option value="B">All Vehicles</option>--->
			</select>
			<!---<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
				<option value="">Select a Year</option>
				<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
					<cfinclude template="/automall/sandbox/search_years.cfm" >
				</cfcache>
			</select>--->
			<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
				<option value="">Select a Make</option>
				<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
					<cfinclude template="/automall/sandbox/search_makes.cfm" >
				</cfcache>
			</select>
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
				<option value="">Select a Model</option>
				<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
					<cfinclude template="/automall/sandbox/search_models.cfm" >
				</cfcache>
			</select>--->
			<select class="spl-search-input" name="search_maxprice" id="search_maxprice_#arguments.form_id#">
				<option value="11000000">Select a Max Price</option>
				<option value="10000">$10,000</option>
				<option value="20000">$20,000</option>
				<option value="30000">$30,000</option>
				<option value="50000">$50,000</option>
				<option value="100000">$100,000</option>
			</select>
			<input type="submit" class="btn btn-spl-search" id="spl-search-submit" value="Search Now!">				
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')				
				var $body = $('##search_body_#arguments.form_id#')
				$make.load('sites/#arguments.automall_name#/data/inv_makes.cfm?new_used=n');
				$model.load('sites/#arguments.automall_name#/data/inv_models.cfm?make=&new_used=n');
				$body.load('sites/#arguments.automall_name#/data/inv_body.cfm?make=&new_used=n');
				$new_used.change(function(){
					var condName = $new_used.val();
					$make.load('sites/#arguments.automall_name#/data/inv_makes.cfm?new_used=' + condName);
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('sites/#arguments.automall_name#/data/inv_models.cfm?make=' + makeName + '&new_used=' + condName);
					$body.load('sites/#arguments.automall_name#/data/inv_body.cfm?make=' + makeName + '&new_used=' + condName);
					//body load
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$body.load('sites/#arguments.automall_name#/data/inv_body.cfm?make=' + makeName + '&new_used=' + condName + '&model=' + modelName);
					//body load
				});
			});
		</script>
		
		<!---<cfset url.Dom_Functions= url.Dom_Functions & '
			$("##search_make_#arguments.form_id#").chained("##search_new_used_#arguments.form_id#");
			$("##search_model_#arguments.form_id#").chained("##search_make_#arguments.form_id#");
			
		'>--->
		
	</cffunction>

	<cffunction name="dealer_search" description="search by dealer" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="form_id" default="searchForm">
		<cfargument name="form_class" default="spl-form">
		<cfargument name="form_method" default="post">
		<cfargument name="form_action" default="">
		<cfargument name="Get_Dealers" required="true">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>

		<cfset Get_Dealers=arguments.Get_Dealers>

		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<input type="hidden" name="new_used" value="N">
			<input type="hidden" name="zip" value="#cookie.savezip#">
			<input type="hidden" name="radius" value="100">
			<select class="spl-dlr-input" name="dealer_id" onchange="this.form.submit()">
				<option value="">OR SEARCH BY DEALERSHIP</option>
				<cfloop query="Get_Dealers">
					<option value="#Get_Dealers.Dealer_ID#">#Get_Dealers.Dealer_Display_Name# - #Get_Dealers.Dealer_City#, #Get_Dealers.Dealer_State#</option>
				</cfloop>
			</select>								
		</form>

	
	</cffunction>

</cfcomponent>