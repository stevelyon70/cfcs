<cfcomponent>
	
	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/test_drive_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Aspen10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Contact Information</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Zip">Zip</label>
					<div class="col-md-6">
						<input name="Zip" class="form-control input-md" id="Zip" type="text" maxlength="5" placeholder="Zip Code" onkeypress="return isNumberKey(event)">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Best_Method">Best Contact Method</label>
					<div class="col-md-6">
						<select name="Best_Method" class="form-control input-md" id="Best_Method">
							<cfif #arguments.dealer_id# EQ 18 >
								<option value="Daytime Phone">Daytime Phone</option>
								<option value="Email">Email</option>
							<cfelse>	
								<option value="Email">Email</option>
								<option value="Daytime Phone">Daytime Phone</option>
							</cfif>
							<option value="Text Daytime Phone">Text Phone</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Vehicle of Interest</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_New_Used"><span class="txt-red">*</span> Condition</label>
					<div class="col-md-6">
						<select class="form-control input-md" name="Voi_New_Used" id="Voi_New_Used" required>
							<option value="N" selected="selected">New</option>
							<option value="U">Pre-Owned</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Make"><span class="txt-red">*</span> Make</label>
					<div class="col-md-6">
						<select  class="form-control input-md" name="Voi_Make" id="Voi_Make" required>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Model"><span class="txt-red">*</span> Model</label>
					<div class="col-md-6">
						<select  class="form-control input-md" name="Voi_Model" id="Voi_Model" required>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Year">Year</label>
					<div class="col-md-6">
						<select  class="form-control input-md" name="Voi_Year" id="Voi_Year">
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Stock">Stock ##</label>
					<div class="col-md-6">
						<input name="Voi_Stock" class="form-control input-md" id="Voi_Stock" type="text" maxlength="50" placeholder="Stock ##">
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Schedule Your Test Drive</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Date"><span class="txt-red">*</span> Test Drive Date</label>
					<div class="col-md-6">
						<input name="Date" class="form-control input-md" id="Date" type="Date" maxlength="10" placeholder="Test Drive Date" required>
						<p class="help-block">Format: mm/dd/yyyy</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Time"><span class="txt-red">*</span> Test Drive Time</label>
					<div class="col-md-6">
						<select class="form-control input-md" name="Time" id="Time" required>
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<cfif Get_Form_Locations.Recordcount gt 0>
					<div class="form-group">
						<label class="control-label col-md-3" for="Delivery_Dealer_ID"><span class="txt-red">*</span> Preferred Dealership</label>
						<div class="col-md-6">
							<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
								<option value="">Select a Dealer</option>
								<cfloop query="Get_Form_Locations">
									<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
								</cfloop> 
							</select>
						</div>
					</div>
				<cfelse>
					<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
				</cfif>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Schedule Your Test Drive">
					</div>
				</div>
			</fieldset>
		</form>

		<script>
			$(function() {
				var $new_used = $('##Voi_New_Used')
				var $make = $('##Voi_Make')
				var $model = $('##Voi_Model')
				var $year = $('##Voi_Year')
				$make.load('http://#cgi.server_name#/global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('http://#cgi.server_name#/global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('http://#cgi.server_name#/global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('http://#cgi.server_name#/global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('http://#cgi.server_name#/global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>

	</cffunction>

	<cffunction name="form_popup" description="test drive popup form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Schedule Test Drive">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/test_drive_action.cfm">
		<cfargument name="form_name" default="quick_quote">

		<form id="test_drive_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<fieldset>
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Date"><span class="txt-red">*</span> Test Drive Date</label>
					<div class="col-md-6">
						<input name="Date" class="form-control input-md" id="Date" type="Date" maxlength="10" placeholder="Test Drive Date" required>
						<p class="help-block">Format: mm/dd/yyyy</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Time"><span class="txt-red">*</span> Test Drive Time</label>
					<div class="col-md-6">
						<select class="form-control input-md" name="Time" id="Time" required>
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>

	<cffunction name="form_popup_legacy" description="test drive popup form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Schedule Test Drive">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/test_drive_action.cfm">
		<cfargument name="form_name" default="quick_quote">

		<form id="test_drive_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>

			<table style="width:100%">
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					</td>
					<td style="width:50%;">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					</td>
					<td style="width:50%;">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Phone_1">Phone</label>
					</td>
					<td style="width:50%;">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					</td>
					<td style="width:50%;">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Date"><span class="txt-red">*</span> Test Drive Date</label>
					</td>
					<td style="width:50%;">
						<input name="Date" class="form-control input-md" id="Date" type="Date" maxlength="10" placeholder="Test Drive Date" required>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<p class="help-block">Format: mm/dd/yyyy</p>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Time"><span class="txt-red">*</span> Test Drive Time</label>
					</td>
					<td style="width:50%;">
						<select class="form-control input-md" name="Time" id="Time" required>
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					</td>
					<td style="width:50%;">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<p class="help-block">If you are already working with someone.</p>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Comments">Comments</label>
					</td>
					<td style="width:50%;">
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
					</td>
				</tr>
			</table>
		</form>

	
	</cffunction>

	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Aspen10">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.voi_vin" default="">
		<cfparam name="form.voi_stock" default="">
		<cfparam name="form.voi_year" default="">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">
		<cfparam name="form.sales_rep" default="">
		<cfparam name="form.date" default="">
		<cfparam name="form.time" default="">
		<cfparam name="form.best_method" default="">
		<cfparam name="form.zip" default="">

		<cfif len(trim(form.voi_vin)) gt 0>
			<!---Get Vehicle Details--->
			<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Vehicle_Details">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(form.voi_vin,17)#" maxlength="21">
				<cfprocresult name="Get_Vehicle_Details" resultset="1">
			</cfstoredproc>
			<cfset form.voi_new_used=Get_Vehicle_Details.V_New_Used>
			<cfset form.voi_vin=Get_Vehicle_Details.Vin>
			<cfset form.voi_year=Get_Vehicle_Details.V_Year>
			<cfset form.voi_make=Get_Vehicle_Details.V_Make>
			<cfset form.voi_model=Get_Vehicle_Details.V_Model>
			<cfset form.voi_trim=Get_Vehicle_Details.V_Trim>
			<cfset form.voi_price=Get_Vehicle_Details.Selling_Price>
			<cfif #arguments.Dealer_ID# eq 79 or #arguments.Dealer_ID# eq 78 >
				<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
			<cfelse>
				<cfparam name="form.delivery_dealer_id" default="#Get_Vehicle_Details.Dealer_ID#">	
			</cfif>
		</cfif>

		<cfset url.year=form.voi_year>
		<cfset url.make=form.voi_make>
		<cfset url.model=form.voi_model>
		<cfset url.new_used=form.voi_new_used>

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.first_name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Last Name: form.Last_Name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Condition: form.voi_new_used --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Condition"/>
			<cfinvokeargument name="text_value" value="#form.voi_new_used#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Make: form.voi_make --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Make"/>
			<cfinvokeargument name="text_value" value="#form.voi_make#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Model: form.voi_model --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Model"/>
			<cfinvokeargument name="text_value" value="#form.voi_model#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Test Drive Date: form.date --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Test Drive Date"/>
			<cfinvokeargument name="text_value" value="#form.date#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Test Drive Time: form.time --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Test Drive Time"/>
			<cfinvokeargument name="text_value" value="#form.time#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Select Dealership: form.Zip --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Zip Code"/>
			<cfinvokeargument name="int_value" value="#form.zip#"/>
			<cfinvokeargument name="int_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Invalid Zip Code"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>

		<cfelse>

			<!---lead delivery hack Faulkner --->
			 <cfswitch expression="#url.dealer_id#">
				<cfcase value="78,79,82,24">
					<cfset form.dealer_id=url.dealer_id>
					<cfset form.delivery_dealer_id=url.dealer_id>
					<!--- <cfset arguments.lead_send_id=url.dealer_id> --->
				</cfcase>
			</cfswitch> 
			
			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#arguments.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#form.dealer_id#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#form.delivery_dealer_id#"/>
				<cfinvokeargument name="remote_addr" value="#cgi.Remote_Addr#">
				<cfinvokeargument name="http_user_agent" value="#cgi.Http_User_Agent#">
			</cfinvoke>
	
			<cfinvoke component="/cfcs/forms/form_save" method="insert_contact" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Contact_Type_ID" value="1"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="4"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_appt">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="appt_type_ID" value="1"/>
				<cfinvokeargument name="appt_datetime_1" value="#form.Date# #form.Time#">
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Aspen10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.delivery_dealer_id#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_type_id#" maxlength="10">  <!--- was lead_send_id --->
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Aspen10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
					<cfprocresult name="Get_Lead_Addresses" resultset="1">
				</cfstoredproc>
				<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>
			</cfif>

			<!---Generate Text Email--->

			<cfinvoke component="/cfcs/emails/text_gen" method="contact_text" returnvariable="text_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
			</cfinvoke>


			<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
				<cfinvokeargument name="td_date" value="#dateformat(form.date,"mm/dd/yyyy")#"/>
				<cfinvokeargument name="td_time" value="#form.time#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="test-drive"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
				<cfinvokeargument name="v_comments" value="Test Drive Date: #dateformat(form.date,"mm/dd/yyyy")# - #form.time#"/>
			</cfinvoke>

			<cfset variables.this_dealer_id=form.Delivery_Dealer_ID>
			
			<cfinvoke component="/cfcs/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfparam name="variables.Email_Subject" default="Test Drive Request from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.text_email#
</cfmail>
<!---<li>#Get_Lead_Addresses.Email# - Text</li>--->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.adf_email#
</cfmail>
<!---<li>#Get_Lead_Addresses.Email# - ADF</li>--->					
					</cfif>

				</cfloop>
			</cfif>
			
		</cfif>

	</cffunction>

</cfcomponent>