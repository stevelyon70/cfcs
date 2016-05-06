<cfcomponent>

<!--- 
Files associated with this cfc are: 
cfc\vehicles\build_options
vehicles \splash_action
global\any inv cfm
teaking takes place in the javascript
--->

	<cffunction name="vertical_search" description="vertical display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="Search Now">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
		<cfargument name="btn_pull" default="no-pull">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>

		
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
 
			<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
				<cfif arguments.dealer_id neq "35"  >
					<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
				</cfif>
				<cfif arguments.dealer_id eq "36" >
					<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used Vehicles</option>
				<cfelse>
					<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>	
				</cfif>	
				<cfif arguments.dealer_id neq "51"  >     <!--- Lamacchia Honda --->
					<option value="C">Certified Vehicles</option>
				</cfif>  
				   <cfif arguments.dealer_id eq "66"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
					<option value="z"<cfif arguments.default_new_used eq "z">selected="selected"</cfif>>Classic Cars</option>
				</cfif>   
			</select><br/>
			<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
			</select><br/>
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
			</select><br/>
			<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
			</select><br/>
			
			  <cfif arguments.dealer_id eq "178"   or  arguments.dealer_id eq "84"   >
			  <select class="spl-search-input" name="search_zip" id="search_zip_#arguments.form_id#">
			</select><br/>
			</cfif>  

			<input class="spl-search-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>
		</form>
		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $zip = $('##search_zip_#arguments.form_id#')
								
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
												
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');					
				});
										
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');					
				});
				
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');					
				});
				
								
			});
		</script>
		
		
		
		

		<!---
		<cfif arguments.dealer_id eq "178">						
			<br /><br />
            <cfquery name="fuccilloZipCodes" datasource="Aspen10">
                SELECT DISTINCT
                [Dealer_Display_Name]     
      			,[Dealer_Zip]     
  				FROM [Aspen10].[dbo].[vehicles] where Dealer_Display_Name LIKE '%fuccillo%' AND LEN([Dealer_Zip]) = 5 
                ORDER BY Dealer_Zip ASC
             </cfquery>
           
            <select class="spl-search-input" name="search_zip" id="search_zip_#arguments.form_id#">
           			<option value="" selected="selected" >Select Zipcode</option>
                <CFOUTPUT QUERY="fuccilloZipCodes">
                	<OPTION value="#fuccilloZipCodes.Dealer_Zip#">#fuccilloZipCodes.Dealer_Zip# - #fuccilloZipCodes.Dealer_Display_Name#</OPTION>
     			</CFOUTPUT>
			</select>
            <br/>
            
			<input class="spl-search-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>						
        </cfif>
		--->

		

	</cffunction>

	<cffunction name="vertical_qq" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>

		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
				<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
				<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
				<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
				<p class="help-block">numbers only - no hypens or parentheses</p>
				<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
			<cfelse>
				<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
				<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
				<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
				<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
			</cfif>
			
			<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
				<cfif arguments.dealer_id neq "35">
					<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
				</cfif>
				<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
				<option value="C">Certified Vehicles</option>
				
			</select>
			<br/>
			<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
			</select>
			<br/>
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
			</select>
			<br/>
			<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
			</select>
			
			<br/>
			<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>

		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="vertical_td" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="tdFormV">
		<cfargument name="form_class" default="td-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Schedule Test Drive">
		<cfargument name="btn_pull" default="no-pull">

		<cfstoredproc datasource="Aspen10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<div class="row">
				<div class="col-md-6">
					<input name="First_Name" class="spl-td-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
				</div>
				<div class="col-md-6">
					<input name="Last_Name" class="spl-td-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<input name="Phone_1" class="spl-td-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
				</div>
				<div class="col-md-6">
					<input name="Email" class="spl-td-input" id="Email" type="email" maxlength="100" placeholder="Email" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="spl-td-title" title="Vehicle Information">Vehicle Information</div>
					<select class="spl-td-input" name="voi_new_used" id="search_new_used_#arguments.form_id#">
						<option value="N" selected="selected">New Vehicles</option>
						<option value="U">Pre-Owned Vehicles</option>
						<option value="C">Certified Vehicles</option>
					</select><br/>
					<select class="spl-td-input" name="voi_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-td-input" name="voi_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-td-input" name="voi_year" id="search_year_#arguments.form_id#">
					</select>
				</div>
				<div class="col-md-6">
					<div class="spl-td-title" title="Preferred Time">Preferred Time</div>
					<input name="Date" class="spl-td-input" id="Date" type="Date" maxlength="10" placeholder="Test Drive Date" required><br/>
					<select class="spl-td-input" name="Time" id="Time" required>
						<option value="">Select Time</option>
						<option value="Morning">Morning</option>
						<option value="Afternoon">Afternoon</option>
						<option value="Evening">Evening</option>
					</select><br/>
					<cfif Get_Form_Locations.Recordcount gt 0>
						<select name="Delivery_Dealer_ID" class="spl-td-input" id="Delivery_Dealer_ID" required>
							<option value="">Select a Dealer</option>
							<cfloop query="Get_Form_Locations">
								<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
							</cfloop> 
						</select><br/>
					<cfelse>
						<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
					</cfif>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<textarea name="Comments" class="spl-td-input"" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
				</div>
			</div>
			<div class="clearfix"></div>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="vertical_td_leg" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="tdFormV">
		<cfargument name="form_class" default="td-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Schedule Test Drive">
		<cfargument name="btn_pull" default="no-pull">

		<cfstoredproc datasource="Aspen10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<table style="width:100%;" cellpadding="5" cellspacing="0">
				<tr>
					<td>
						<input name="First_Name" class="spl-td-input" id="First_Name" type="text" maxlength="50"  value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" class="spl-td-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
					</td>
					<td>
						<input name="Phone_1" class="spl-td-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'" onkeypress="return isNumberKey(event)">
						<input name="Email" class="spl-td-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					</td>
				</tr>
				<tr>
					<td valign="top">
						<div class="spl-td-title" title="Vehicle Information">Vehicle Information</div>
						<select class="spl-td-input" name="voi_new_used" id="search_new_used_#arguments.form_id#">
							<option value="N" selected="selected">New Vehicles</option>
							<option value="U">Pre-Owned Vehicles</option>
							<option value="C">Certified Vehicles</option>
						</select><br/>
						<select class="spl-td-input" name="voi_make" id="search_make_#arguments.form_id#">
						</select><br/>
						<select class="spl-td-input" name="voi_model" id="search_model_#arguments.form_id#">
						</select><br/>
						<select class="spl-td-input" name="voi_year" id="search_year_#arguments.form_id#">
						</select>
					</td>
					<td valign="top">
						<div class="spl-td-title" title="Preferred Time">Preferred Time</div>
						<input name="Date" class="spl-td-input" id="Date" type="Date" maxlength="10" value="Test Drive Date" onfocus="if (this.value=='Test Drive Date') this.value = ''" onblur="if (this.value=='') this.value = 'Test Drive Date'"><br/>
						<select class="spl-td-input" name="Time" id="Time" required>
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select><br/>
						<cfif Get_Form_Locations.Recordcount gt 0>
							<select name="Delivery_Dealer_ID" class="spl-td-input" id="Delivery_Dealer_ID" required>
								<option value="">Select a Dealer</option>
								<cfloop query="Get_Form_Locations">
									<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
								</cfloop> 
							</select><br/>
						<cfelse>
							<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
						</cfif>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="Comments" class="spl-td-input"" id="Comments" maxlength="1000" onfocus="if (this.value=='Comments') this.value = ''" onblur="if (this.value=='') this.value = 'Comments'">Comments</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
					</td>
				</tr>
			</table>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="horizontal_search" description="horizontal display for search tool" output="Yes" access="public">

		horizontal_search
			
	</cffunction>

	<cffunction name="horizontal_qq" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>

		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<div class="row">
				<div class="col-md-6">
					<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<p class="help-block">numbers only - no hypens or parentheses</p>
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					<cfelse>
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
					</cfif>
				</div>
				<div class="col-md-6">
					<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
						<cfif arguments.dealer_id neq "35">
							<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
						</cfif>
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
						<option value="C">Certified Vehicles</option>
					</select><br/>
					<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
					</select><br/>
					<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
				</div>
			</div>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>


	<cffunction name="horizontal_qq_big" description="horizontal display for search tool for WD_1008" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>

		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<div class="row">
				<div class="row">
					<div class="col-md-6"><span style="color:white;font-weight:bold;font-size:9pt">&nbsp;&nbsp;&nbsp;Tell Us About You</span></div><div class="col-md-6"<span style="color:white;font-weight:bold;font-size:9pt">What You're Looking For?</span></div>
				</div>	
				<div class="col-md-6">
					<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<p class="help-block">numbers only - no hypens or parentheses</p>
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					<cfelse>
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
					</cfif>
				</div>
				<div class="col-md-6">
					<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
						<cfif arguments.dealer_id neq "35">
							<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
						</cfif>
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
						<option value="C">Certified Vehicles</option>
					</select><br/>
					<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
					</select><br/>
					<input class="blk2-btn" type="submit" value="#arguments.btn_submit#">
				</div>
			</div>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="horizontal_qq_leg" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>

		<table style="width:100%" cellpadding="0" cellspacing="0">
			<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
				<tr>
					<td style="width:50%" style="padding:10px;" valign="top">
						<input name="First_Name" id="First_Name" class="spl-search-input" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" id="Last_Name" class="spl-search-input" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
						<input name="Phone_1" id="Phone_1" class="spl-search-input" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<input name="Email" id="Email" class="spl-search-input" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					</td>
					<td style="width:50%" style="padding:10px;" valign="top">
						<select class="spl-search-input" name="search_new_used" class="spl-search-input" id="search_new_used_#arguments.form_id#">
							<cfif arguments.dealer_id neq "35">
								<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
							</cfif>
							<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
							<option value="C">Certified Vehicles</option>
						</select><br/>
						<select name="search_make" class="spl-search-input" id="search_make_#arguments.form_id#">
						</select><br/>
						<select name="search_model" class="spl-search-input" id="search_model_#arguments.form_id#">
						</select><br/>
						<select name="search_year" class="spl-search-input" id="search_year_#arguments.form_id#">
						</select><br/>
						<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
					</td>
				</tr>
			</form>
		</table>

		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

</cfcomponent>