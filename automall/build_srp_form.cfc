<cfcomponent>

	<cffunction name="srp_default" description="srp search engine" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="form_id" default="srp_form"/>
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfparam name="url.show_redirect" default="">
		
		<cfif url.show_redirect eq 1>
			<cfset arguments.srp_action=arguments.srp_action & "?show_redirect=1">
		</cfif>
		
		<cfset Get_Makes=arguments.Get_Makes>
		<cfset Get_Models=arguments.Get_Models>
		<cfset Get_Dealers=arguments.Get_Dealers>
		
		<form id="#arguments.form_id#" name="#arguments.form_id#" action="#arguments.srp_action#" method="post" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-2">
					<select name="new_used" class="srp-input" onchange="javascript:srp_form_submit();">
						<!---<option value="B" <cfif url.new_used eq "B">selected</cfif>>All Vehicles</option>--->
						<option value="N" <cfif url.new_used eq "N">selected</cfif>>New Vehicles</option>
						<option value="U" <cfif url.new_used eq "U">selected</cfif>>Used Vehicles</option>
						<option value="C" <cfif url.new_used eq "C">selected</cfif>>Certified Vehicles</option>
					</select>
				</div>
				<div class="col-md-2">
					<select name="make" class="srp-input" onchange="javascript:srp_form_submit();">
						<option value="">Select A Make</option>
						<cfloop query="Get_Makes">
							<option value="#Get_Makes.V_Make#" <cfif url.make eq Get_Makes.V_Make>selected</cfif>>#Get_Makes.V_Make#</option>	
						</cfloop>
					</select>
				</div>
				<div class="col-md-2">
					<cfif len(trim(url.make)) gt 0>
						<select name="model" class="srp-input" onchange="javascript:srp_form_submit();">
							<option value="">Select A Model</option>
							<cfloop query="Get_Models">
								<cfset variables.this_model=replace(Get_Models.V_Model,"&","%26","all" )>
								<cfset variables.this_model=replace(variables.this_model," ","%20","all" )>
								<option value="#variables.this_model#" <cfif url.model eq Get_Models.V_Model>selected</cfif>>#Get_Models.V_Model#</option>	
							</cfloop>
						</select>
					<cfelse>
						<select name="model" class="srp-input" disabled="true">
							<option value="">Select A Model</option>
						</select>
					</cfif>
				</div>
				<div class="col-md-2 visible-md visible-lg">
					<select name="sortblock" class="srp-input" onchange="javascript:srp_form_submit();">
						<option value="">Sort By</option>
						<option value="1" <cfif url.sortblock eq "1">selected</cfif>>Sort by Make,Model</option>
						<option value="2" <cfif url.sortblock eq "2">selected</cfif>>Sort by Price (low to high)</option>
						<option value="3" <cfif url.sortblock eq "3">selected</cfif>>Sort by Price (high to low)</option>
						<cfif url.new_used neq "N"><option value="4" <cfif url.sortblock eq "4">selected</cfif>>Sort by Mileage (low to high)</option></cfif>
						<cfif url.new_used neq "N"><option value="5" <cfif url.sortblock eq "5">selected</cfif>>Sort by Mileage (high to low)</option></cfif>
						<option value="6" <cfif url.sortblock eq "6">selected</cfif>>Sort by Year (low to high)</option>
						<option value="7" <cfif url.sortblock eq "7">selected</cfif>>Sort by Year (high to low)</option>
						<cfif len(trim(url.dealer_id)) gt 0><option value="8" <cfif url.sortblock eq "8">selected</cfif>>Sort by Stock Number</option></cfif>
						<option value="9" <cfif url.sortblock eq "9">selected</cfif>>Luxury</option>
						<!---<option value="10" <cfif url.sortblock eq "10">selected</cfif>>Fleet</option>--->
					</select>
				</div>
				<div class="col-md-2">
					<select class="srp-input" name="dealer_id" onchange="javascript:srp_form_submit();">
						<option value="">Select a Dealer</option>
						<cfloop query="Get_Dealers">
							<option value="#Get_Dealers.Dealer_ID#" <cfif url.dealer_id eq Get_Dealers.Dealer_ID>selected</cfif>>#Get_Dealers.Dealer_Display_Name#</option>
						</cfloop>
					</select>
				</div>
				<div class="col-md-2">
					<input class="srp-btn-search btn btn-default" type="button" value="Reset Search" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#&zip=#url.zip#&radius=#url.radius#'"/>
				</div>
			</div>
			<input type="hidden" name="year" value="#url.year#"/>
			<input type="hidden" name="body" value="#url.body#"/>
			<input type="hidden" name="zip" value="#url.zip#"/>
			<input type="hidden" name="radius" value="#url.radius#"/>
			<input type="hidden" name="maxprice" value="#url.maxprice#"/>
			<input type="hidden" name="minprice" value="#url.minprice#"/>
			<input type="hidden" name="old_year" value="#url.year#"/>
			<input type="hidden" name="old_make" value="#url.make#"/>
			<input type="hidden" name="old_dealer_id" value="#url.dealer_id#"/>
		</form>
		
		<script>
			function srp_form_submit(){
				document.getElementById("#arguments.form_id#").submit();
			}
		</script>

	</cffunction>
	
</cfcomponent>