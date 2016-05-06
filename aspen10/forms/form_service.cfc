<cfcomponent>
	
	<cffunction name="modern_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/service_action.cfm">

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
					<label class="control-label col-md-3" for="Phone_1"><span class="txt-red">*</span> Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" required>
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
					<div class="col-md-9 form-divider" align="center">
						<b>Vehicle Information</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Year"><span class="txt-red">*</span> Year</label>
					<div class="col-md-6">
						<input name="Voi_Year" class="form-control input-md" id="Voi_Year" type="text" maxlength="4" placeholder="Year" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Make"><span class="txt-red">*</span> Make</label>
					<div class="col-md-6">
						<input name="Voi_Make" class="form-control input-md" id="Voi_Make" type="text" maxlength="50" placeholder="Make" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Model"><span class="txt-red">*</span> Model</label>
					<div class="col-md-6">
						<input name="Voi_Model" class="form-control input-md" id="Voi_Model" type="text" maxlength="50" placeholder="Model" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Service Rep</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Service Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments"><span class="txt-red">*</span> Service Requested</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Service Requested" maxlength="1000" required></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Preferred Service Times</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Appt_Date_1">First Choice</label>
					<div class="col-md-3">
						<input name="Appt_Date_1" class="form-control input-md" id="Appt_Date_1" type="Date" maxlength="10" placeholder="Date">
						<p class="help-block">Format: mm/dd/yyyy</p>
					</div>
					<div class="col-md-3">
						<select class="form-control input-md" name="Appt_Time_1" id="Appt_Time_1">
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Appt_Date_2">Second Choice</label>
					<div class="col-md-3">
						<input name="Appt_Date_2" class="form-control input-md" id="Appt_Date_2" type="Date" maxlength="10" placeholder="Date">
						<p class="help-block">Format: mm/dd/yyyy</p>
					</div>
					<div class="col-md-3">
						<select class="form-control input-md" name="Appt_Time_2" id="Appt_Time_2">
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Appt_Date_3">Third Choice</label>
					<div class="col-md-3">
						<input name="Appt_Date_3" class="form-control input-md" id="Appt_Date_3" type="Date" maxlength="10" placeholder="Date">
						<p class="help-block">Format: mm/dd/yyyy</p>
					</div>
					<div class="col-md-3">
						<select class="form-control input-md" name="Appt_Time_3" id="Appt_Time_3">
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-9">
						Before bringing your vehicle in for service, please await confirmation
						from our service department, verifying that one of your preferred
						dates/times is available.<br/><br/>
						Or, if you would prefer to speak with a service representative to schedule your appointment, please check below.
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<input type="checkbox" name="Appt_Contact" id="Appt_Contact" value="1">
						<label class="control-label" for="Appt_Contact">&nbsp;Please contact me to schedule an appointment.</label>
					</div>
				</div>
				<cfif Get_Form_Locations.Recordcount gt 0>
					<div class="form-group">
						<label class="control-label col-md-3" for="Delivery_Dealer_ID">Preferred Dealership</label>
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
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Send Your Service Request">
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>

	<cffunction name="legacy_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/service_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Aspen10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
			<table style="width:100%" cellpadding="0" cellspacing="0">
				<tr>
					<td style="width:50%;" valign="top">
						<h4>Contact Information</h4>
						<table style="width:75%">
							<tr>
								<td style="width:50%;" align="right">
									<label for="First_Name"><span class="txt-red">*</span> First Name</label>
								</td>
								<td style="width:50%;">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Last_Name"><span class="txt-red">*</span> Last Name</label>
								</td>
								<td style="width:50%;">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Phone_1"><span class="txt-red">*</span> Phone</label>
								</td>
								<td style="width:50%;">
									<input name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" required><br/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									Numbers Only - no hyphens or parentheses
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Email"><span class="txt-red">*</span> Email</label>
								</td>
								<td style="width:50%;">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
								</td>
							</tr>
						</table>
					</td>
					<td style="width:50%;" valign="top">
						<h4>Vehicle Information</h4>
						<table style="width:75%">
							<tr>
								<td style="width:50%;" align="right">
									<label class="control-label col-md-3" for="Voi_Year"><span class="txt-red">*</span> Year</label>
								</td>
								<td style="width:50%;">
									<input name="Voi_Year" class="form-control input-md" id="Voi_Year" type="text" maxlength="4" placeholder="Year" required><br/>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label class="control-label col-md-3" for="Voi_Make"><span class="txt-red">*</span> Make</label>
								</td>
								<td style="width:50%;">
									<input name="Voi_Make" class="form-control input-md" id="Voi_Make" type="text" maxlength="50" placeholder="Make" required><br/>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label class="control-label col-md-3" for="Voi_Model"><span class="txt-red">*</span> Model</label>
								</td>
								<td style="width:50%;">
									<input name="Voi_Model" class="form-control input-md" id="Voi_Model" type="text" maxlength="50" placeholder="Model" required><br/>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label class="control-label col-md-3" for="Sales_Rep">Service Rep</label>
								</td>
								<td style="width:50%;">
									<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Service Representative"><br/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									If you are already working with someone.
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Comments"><span class="txt-red">*</span> Service Requested</label>
								</td>
								<td style="width:50%;">
									<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Service Requested" maxlength="1000" required></textarea>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<h4>Preferred Service Times</h4>
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td style="width:33%;" valign="top">
									<label class="control-label col-md-3" for="Appt_Date_1">First Choice</label>
									<div class="col-md-3">
										<input name="Appt_Date_1" class="form-control input-md" id="Appt_Date_1" type="Date" maxlength="10" placeholder="Date">
										<p class="help-block">Format: mm/dd/yyyy</p>
									</div>
									<div class="col-md-3">
										<select class="form-control input-md" name="Appt_Time_1" id="Appt_Time_1">
											<option value="">Select Time</option>
											<option value="Morning">Morning</option>
											<option value="Afternoon">Afternoon</option>
											<option value="Evening">Evening</option>
										</select>
									</div>
								</td>
								<td style="width:33%;" valign="top">
									<label class="control-label col-md-3" for="Appt_Date_2">Second Choice</label>
									<div class="col-md-3">
										<input name="Appt_Date_2" class="form-control input-md" id="Appt_Date_2" type="Date" maxlength="10" placeholder="Date">
										<p class="help-block">Format: mm/dd/yyyy</p>
									</div>
									<div class="col-md-3">
										<select class="form-control input-md" name="Appt_Time_2" id="Appt_Time_2">
											<option value="">Select Time</option>
											<option value="Morning">Morning</option>
											<option value="Afternoon">Afternoon</option>
											<option value="Evening">Evening</option>
										</select>
									</div>
								</td>
								<td style="width:33%;" valign="top">
									<label class="control-label col-md-3" for="Appt_Date_3">Third Choice</label>
									<div class="col-md-3">
										<input name="Appt_Date_3" class="form-control input-md" id="Appt_Date_3" type="Date" maxlength="10" placeholder="Date">
										<p class="help-block">Format: mm/dd/yyyy</p>
									</div>
									<div class="col-md-3">
										<select class="form-control input-md" name="Appt_Time_3" id="Appt_Time_3">
											<option value="">Select Time</option>
											<option value="Morning">Morning</option>
											<option value="Afternoon">Afternoon</option>
											<option value="Evening">Evening</option>
										</select>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="padding:20px;" colspan="2">
						Before bringing your vehicle in for service, please await confirmation
						from our service department, verifying that one of your preferred
						dates/times is available.<br/><br/>
						Or, if you would prefer to speak with a service representative to schedule your appointment, please check below.
						<br/><br/>
						<input type="checkbox" name="Appt_Contact" id="Appt_Contact" value="1">
						<label class="control-label" for="Appt_Contact">&nbsp;Please contact me to schedule an appointment.</label>
					</td>
				</tr>
				<tr>
					<td>
						<cfif Get_Form_Locations.Recordcount gt 0>
							<table style="width:100%">
								<tr>
									<td style="width:50%;" align="right">
										<label class="control-label col-md-3" for="Delivery_Dealer_ID"><span class="txt-red">*</span> Preferred Dealership</label>
									</td>
									<td style="width:50%;">
										<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
											<option value="">Select a Dealer</option>
											<cfloop query="Get_Form_Locations">
												<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
											</cfloop> 
										</select>
									</td>
								</tr>
							</table>
						<cfelse>
							<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
						</cfif>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Send Your Service Request">
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
		<cfparam name="form.voi_year" default="">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">
		<cfparam name="form.sales_rep" default="">
		<cfparam name="form.Appt_Date_1" default="">
		<cfparam name="form.Appt_Time_1" default="">
		<cfparam name="form.Appt_Date_2" default="">
		<cfparam name="form.Appt_Time_2" default="">
		<cfparam name="form.Appt_Date_3" default="">
		<cfparam name="form.Appt_Time_3" default="">
		<cfparam name="form.Appt_Contact" default="0">
		
		<!---Appointment Date Formatting--->
		<cfif form.Appt_Contact eq 1>
			<cfset form.Appt_Date_1="">
			<cfset form.Appt_Time_1="">
			<cfset form.Appt_Date_2="">
			<cfset form.Appt_Time_2="">
			<cfset form.Appt_Date_3="">
			<cfset form.Appt_Time_3="">
		</cfif>
		<cfif isvalid("usdate",form.Appt_Date_1) eq "No">
			<cfset form.Appt_Date_1="">
			<cfset form.Appt_Time_1="">
		</cfif>
		<cfif isvalid("usdate",form.Appt_Date_2) eq "No">
			<cfset form.Appt_Date_2="">
			<cfset form.Appt_Time_2="">
		</cfif>
		<cfif isvalid("usdate",form.Appt_Date_3) eq "No">
			<cfset form.Appt_Date_3="">
			<cfset form.Appt_Time_3="">
		</cfif>
		<cfif 	isvalid("usdate",form.Appt_Date_1) eq "No" and 
				isvalid("usdate",form.Appt_Date_2) eq "No" and 
				isvalid("usdate",form.Appt_Date_3) eq "No">
			<cfset form.Appt_Contact="1">
			<cfset form.Appt_Date_1="">
			<cfset form.Appt_Time_1="">
			<cfset form.Appt_Date_2="">
			<cfset form.Appt_Time_2="">
			<cfset form.Appt_Date_3="">
			<cfset form.Appt_Time_3="">
		</cfif>

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
		<!--- Year: form.voi_year --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Year"/>
			<cfinvokeargument name="text_value" value="#form.voi_year#"/>
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
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Service Requested"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<!---<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>--->
			
			<cfset url.error_message=variables.error_message>

		<cfelse>

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
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="6"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_appt">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="appt_type_ID" value="1"/>
				<cfinvokeargument name="appt_comments" value="#form.comments#"/>
				<cfif form.Appt_Contact eq 1>
					<cfinvokeargument name="appt_contact" value="1">
				<cfelse>
					<cfinvokeargument name="appt_datetime_1" value="#form.Appt_Date_1# - #form.Appt_Time_1#">
					<cfinvokeargument name="appt_datetime_2" value="#form.Appt_Date_2# - #form.Appt_Time_2#">
					<cfinvokeargument name="appt_datetime_3" value="#form.Appt_Date_3# - #form.Appt_Time_3#">	
				</cfif>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Aspen10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.delivery_dealer_id#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_send_id#" maxlength="10">
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
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="service_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="appt_datetime_1" value="#form.Appt_Date_1# - #form.Appt_Time_1#"/>
				<cfinvokeargument name="appt_datetime_2" value="#form.Appt_Date_2# - #form.Appt_Time_2#"/>
				<cfinvokeargument name="appt_datetime_3" value="#form.Appt_Date_3# - #form.Appt_Time_3#"/>
				<cfinvokeargument name="appt_contact" value="#form.appt_contact#"/>
				<cfinvokeargument name="appt_comments" value="#form.comments#"/>
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
				<cfif form.appt_contact eq 1>
					<cfinvokeargument name="comments" value="Service Date/Time: Please contact me to schedule an appointment."/>
				<cfelse>
					<cfinvokeargument name="comments" value="
First Choice Date/Time: #form.Appt_Date_1# - #form.Appt_Time_1#
Second Choice Date/Time: #form.Appt_Date_2# - #form.Appt_Time_2#
Third Choice Date/Time: #form.Appt_Date_3# - #form.Appt_Time_3#
					"/>
				</cfif>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="service"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_comments" value="Service Requested: #form.comments#"/>
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

			<cfparam name="variables.Email_Subject" default="Service Request from #lcase(cgi.Server_Name)#">
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