<cfcomponent>

	<cffunction name="form_popup" description="popup version of form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Schedule Test Drive">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="form_name" default="test_drive">

		<cfparam name="url.first_name" default="">
		<cfparam name="url.last_name" default="">
		<cfparam name="url.email" default="">
		<cfparam name="url.phone_1" default="">
		<cfparam name="url.td_date" default="">
		<cfparam name="url.td_time" default="">
		<cfparam name="url.comments" default="">

		<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=td_submit&vin=#left(arguments.VOI_Vin,17)#" method="post">
			<fieldset>
				<input type="hidden" name="Dealer_ID" value="#arguments.Dealer_ID#"/>
				<input name="VOI_Vin" id="VOI_Vin" type="hidden"  value="#left(arguments.VOI_Vin,17)#"/>
				<div class="row">
					<div class="col-md-12">
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="first_name"><em>*</em> First Name</label>
						<div class="col-md-8">
							<input name="first_name" class="form-control input-md modal-input" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
						</div>
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="last_name"><em>*</em> Last Name</label>  
						<div class="col-md-8">
							<input name="last_name" class="form-control input-md modal-input" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
						</div>
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="email"><em>*</em> Email</label>  
						<div class="col-md-8">
							<input name="email" class="form-control input-md modal-input" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
						</div>
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="phone"> Phone</label>  
						<div class="col-md-8">
							<input name="phone_1" class="form-control input-md modal-input" id="phone_1" type="text" placeholder="Phone" maxlength="10" value="#url.phone_1#" />
							<span class="help-block">Numbers Only - no hypens or parentheses</span>
						</div>
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="td_date"><em>*</em> Date</label>  
						<div class="col-md-8">
							<input name="td_date" class="form-control input-md modal-input" id="td_date" type="text" placeholder="Test Drive Date" maxlength="10" value="#url.td_date#" required/>
							<span class="help-block">format - mm/dd/yyyy</span>
						</div>
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="td_time"><em>*</em> Time</label>  
						<div class="col-md-8">
							<select class="form-control input-md modal-input" name="td_time" required>
								<option value="">Select a Time</option>
								<option value="9:00 AM" <cfif url.td_time eq "9:00 AM">selected</cfif>>9:00 AM</option>
								<option value="9:15 AM" <cfif url.td_time eq "9:15 AM">selected</cfif>>9:15 AM</option>
								<option value="9:30 AM" <cfif url.td_time eq "9:30 AM">selected</cfif>>9:30 AM</option>
								<option value="9:45 AM" <cfif url.td_time eq "9:45 AM">selected</cfif>>9:45 AM</option>
								<option value="10:00 AM" <cfif url.td_time eq "10:00 AM">selected</cfif>>10:00 AM</option>
								<option value="10:15 AM" <cfif url.td_time eq "10:15 AM">selected</cfif>>10:15 AM</option>
								<option value="10:30 AM" <cfif url.td_time eq "10:30 AM">selected</cfif>>10:30 AM</option>
								<option value="10:45 AM" <cfif url.td_time eq "10:45 AM">selected</cfif>>10:45 AM</option>
								<option value="11:00 AM" <cfif url.td_time eq "11:00 AM">selected</cfif>>11:00 AM</option>
								<option value="11:15 AM" <cfif url.td_time eq "11:15 AM">selected</cfif>>11:15 AM</option>
								<option value="11:30 AM" <cfif url.td_time eq "11:30 AM">selected</cfif>>11:30 AM</option>
								<option value="11:45 AM" <cfif url.td_time eq "11:45 AM">selected</cfif>>11:45 AM</option>
								<option value="12:00 PM" <cfif url.td_time eq "12:00 AM">selected</cfif>>12:00 PM</option>
								<option value="12:15 PM" <cfif url.td_time eq "12:15 AM">selected</cfif>>12:15 PM</option>
								<option value="12:30 PM" <cfif url.td_time eq "12:30 AM">selected</cfif>>12:30 PM</option>
								<option value="12:45 PM" <cfif url.td_time eq "12:45 AM">selected</cfif>>12:45 PM</option>
								<option value="1:00 PM" <cfif url.td_time eq "1:00 AM">selected</cfif>>1:00 PM</option>
								<option value="1:15 PM" <cfif url.td_time eq "1:15 AM">selected</cfif>>1:15 PM</option>
								<option value="1:30 PM" <cfif url.td_time eq "1:30 AM">selected</cfif>>1:30 PM</option>
								<option value="1:45 PM" <cfif url.td_time eq "1:45 AM">selected</cfif>>1:45 PM</option>
								<option value="2:00 PM" <cfif url.td_time eq "2:00 AM">selected</cfif>>2:00 PM</option>
								<option value="2:15 PM" <cfif url.td_time eq "2:15 AM">selected</cfif>>2:15 PM</option>
								<option value="2:30 PM" <cfif url.td_time eq "2:30 AM">selected</cfif>>2:30 PM</option>
								<option value="2:45 PM" <cfif url.td_time eq "2:45 AM">selected</cfif>>2:45 PM</option>
								<option value="3:00 PM" <cfif url.td_time eq "3:00 AM">selected</cfif>>3:00 PM</option>
								<option value="3:15 PM" <cfif url.td_time eq "3:15 AM">selected</cfif>>3:15 PM</option>
								<option value="3:30 PM" <cfif url.td_time eq "3:30 AM">selected</cfif>>3:30 PM</option>
								<option value="3:45 PM" <cfif url.td_time eq "3:45 AM">selected</cfif>>3:45 PM</option>
								<option value="4:00 PM" <cfif url.td_time eq "4:00 AM">selected</cfif>>4:00 PM</option>
								<option value="4:15 PM" <cfif url.td_time eq "4:15 AM">selected</cfif>>4:15 PM</option>
								<option value="4:30 PM" <cfif url.td_time eq "4:30 AM">selected</cfif>>4:30 PM</option>
								<option value="4:45 PM" <cfif url.td_time eq "4:45 AM">selected</cfif>>4:45 PM</option>
								<option value="5:00 PM" <cfif url.td_time eq "5:00 AM">selected</cfif>>5:00 PM</option>
								<option value="5:15 PM" <cfif url.td_time eq "5:15 AM">selected</cfif>>5:15 PM</option>
								<option value="5:30 PM" <cfif url.td_time eq "5:30 AM">selected</cfif>>5:30 PM</option>
								<option value="5:45 PM" <cfif url.td_time eq "5:45 AM">selected</cfif>>5:45 PM</option>
								<option value="6:00 PM" <cfif url.td_time eq "6:00 AM">selected</cfif>>6:00 PM</option>
								<option value="6:15 PM" <cfif url.td_time eq "6:15 AM">selected</cfif>>6:15 PM</option>
								<option value="6:30 PM" <cfif url.td_time eq "6:30 AM">selected</cfif>>6:30 PM</option>
								<option value="6:45 PM" <cfif url.td_time eq "6:45 AM">selected</cfif>>6:45 PM</option>
							</select>
						</div>
						<label class="col-md-4 control-label modal-label visible-md visible-lg" for="comments">Comments</label>
						<div class="col-md-8">                     
							<textarea name="comments" class="form-control modal-input" id="comments" maxlength="500" placeholder="Comments">#url.comments#</textarea>
						</div>
						<label class="col-md-4 control-label" for="reset"></label>
						<div class="col-md-8" align="center">
							<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
							<input type="submit" class="btn btn-primary" id="submit" value="#arguments.btn_label#"/>
						</div>
						<div class="col-md-2 visible-md visible-lg"></div>
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>

	<cffunction name="form_modal" description="popup version of form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">

		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.VOI_Vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>
		
		
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h4 class="modal-title" id="myModalLabel">Request a Quick Quote on this #Get_Vehicle_Details.V_Year#  #Get_Vehicle_Details.V_Make#  #Get_Vehicle_Details.V_Model#  #Get_Vehicle_Details.V_Trim#</h4>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="pop-form-box">
						<cfinvoke component="/cfcs/ultra10/vehicles/form_test_drive" method="form_popup">
							<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
							<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="col-md-6">
					<cfinvoke component="/cfcs/automall/vehicle_photos" method="single_photo">
						<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
						<cfinvokeargument name="img_title" value="#Get_Vehicle_Details.V_Year# #Get_Vehicle_Details.V_Make# #Get_Vehicle_Details.V_Model# #Get_Vehicle_Details.V_Trim#"/>
						<cfinvokeargument name="img_class" value="img-responsive"/>
					</cfinvoke>
				</div>									
			</div>
		</div>
	
	</cffunction>
	
	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="VOI_Vin" required="true">

		<!--- defaults --->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.td_date" default="">
		<cfparam name="form.td_time" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.voi_vin" default="0">


		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.voi_vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>

		<cfset form.Delivery_Dealer_ID=Get_Vehicle_Details.Dealer_ID>

		<cfif Get_Vehicle_Details.V_New_Used eq "N">
			<cfset variables.lead_type_id="10">
			<cfset variables.lead_send_id="10">
		<cfelse>
			<cfset variables.lead_type_id="14">
			<cfset variables.lead_send_id="14">
		</cfif>
		
		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.First_Name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.Last_Name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Last Name: form.Last_Name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.Last_Name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.Email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Date: form.td_date --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Test Drive Date"/>
			<cfinvokeargument name="text_value" value="#form.td_date#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Time: form.td_time --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Test Drive Time"/>
			<cfinvokeargument name="text_value" value="#form.td_time#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.Phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.Comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>

		<cfelse>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#variables.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#form.Dealer_ID#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#form.Delivery_Dealer_ID#"/>
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
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="4"/>
				<cfinvokeargument name="v_vin" value="#Get_Vehicle_Details.Vin#"/>
				<cfinvokeargument name="v_stock" value="#Get_Vehicle_Details.Stock#"/>
				<cfinvokeargument name="new_used" value="#Get_Vehicle_Details.V_New_Used#"/>
				<cfinvokeargument name="v_year" value="#Get_Vehicle_Details.V_Year#"/>
				<cfinvokeargument name="v_make" value="#Get_Vehicle_Details.V_Make#"/>
				<cfinvokeargument name="v_model" value="#Get_Vehicle_Details.V_Model#"/>
				<cfinvokeargument name="v_trim" value="#Get_Vehicle_Details.V_Trim#"/>
				<cfinvokeargument name="v_price" value="#Get_Vehicle_Details.Selling_Price#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_appt">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="appt_type_ID" value="1"/>
				<cfinvokeargument name="appt_datetime_1" value="#dateformat(form.td_date,"mm/dd/yyyy")# #timeformat(form.td_time,"hh:mm tt")#">
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@var" value="#form.Delivery_Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@var" value="#variables.lead_send_id#" maxlength="10">
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@var" value="#form.Delivery_Dealer_ID#" maxlength="10">
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
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="new_used" value="#Get_Vehicle_Details.V_New_Used#"/>
				<cfinvokeargument name="v_vin" value="#Get_Vehicle_Details.Vin#"/>
				<cfinvokeargument name="v_stock" value="#Get_Vehicle_Details.Stock#"/>
				<cfinvokeargument name="v_year" value="#Get_Vehicle_Details.V_Year#"/>
				<cfinvokeargument name="v_make" value="#Get_Vehicle_Details.V_Make#"/>
				<cfinvokeargument name="v_model" value="#Get_Vehicle_Details.V_Model#"/>
				<cfinvokeargument name="v_trim" value="#Get_Vehicle_Details.V_Trim#"/>
				<cfinvokeargument name="v_price" value="#Get_Vehicle_Details.Selling_Price#"/>
				<cfinvokeargument name="td_date" value="#dateformat(form.td_date,"mm/dd/yyyy")#"/>
				<cfinvokeargument name="td_time" value="#timeformat(form.td_time,"hh:mm tt")#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Source" value="TribLive"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="test-drive"/>
				<cfinvokeargument name="new_used" value="#Get_Vehicle_Details.V_New_Used#"/>
				<cfinvokeargument name="v_vin" value="#Get_Vehicle_Details.Vin#"/>
				<cfinvokeargument name="v_stock" value="#Get_Vehicle_Details.Stock#"/>
				<cfinvokeargument name="v_year" value="#Get_Vehicle_Details.V_Year#"/>
				<cfinvokeargument name="v_make" value="#Get_Vehicle_Details.V_Make#"/>
				<cfinvokeargument name="v_model" value="#Get_Vehicle_Details.V_Model#"/>
				<cfinvokeargument name="v_trim" value="#Get_Vehicle_Details.V_Trim#"/>
				<cfinvokeargument name="v_price" value="#Get_Vehicle_Details.Selling_Price#"/>
				<cfinvokeargument name="v_comments" value="Test Drive Date/Time: #dateformat(form.td_date,"mm/dd/yyyy")# #timeformat(form.td_time,"hh:mm tt")#"/>
			</cfinvoke>

			<cfset variables.this_dealer_id=form.Delivery_Dealer_ID>
			
			<cfinvoke component="/cfcs/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="provider_trib" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfparam name="variables.Email_Subject" default="Test Drive Request from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leadstest@worlddealer.net">

			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.text_email#
</cfmail>
<!---<li>#Get_Lead_Addresses.Email# - Text</li>--->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.adf_email#
</cfmail>
<!---<li>#Get_Lead_Addresses.Email# - ADF</li>--->					
					</cfif>

				</cfloop>
			</cfif>

			<!---
			#form.Dealer_ID#<br/>
			#form.Delivery_Dealer_ID#<br/>
			#form.First_Name#<br/>
			#form.Last_Name#<br/>
			#form.Phone_1#<br/>
			#form.Email#<br/>
			Lead ID - #variables.New_ID#<br/>
			Contact ID - #variables.Contact_ID#
			#variables.recipient_list#
			--->
			
			<script>
				top.location.href="http://#cgi.server_name#/vehicles/thank_you_test_drive.cfm";
			</script>

		</cfif>

	</cffunction>

</cfcomponent>