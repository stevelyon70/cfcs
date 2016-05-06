<cfcomponent>

	<cffunction name="qq_default" description="default quote layout" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="VOI_New_Used" required="true">
		<cfargument name="btn_label" default="GET OUR BEST PRICE NOW">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="form_name" default="quick_quote">
	
		<form class="form-horizontal no-pad" action="#arguments.form_action#?form_action=submit_quote&vin=#left(arguments.VOI_Vin,17)#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
			<fieldset>
				<input name="VOI_Vin" id="VOI_Vin" type="hidden"  value="#left(arguments.VOI_Vin,17)#"/>
				<input name="VOI_New_Used" id="VOI_New_Used" type="hidden"  value="#arguments.VOI_New_Used#"/>
				<div class="form-group  qq-input">
					<div class="col-md-12">
						<input  class="form-control" id="First_Name" name="First_Name" type="text" placeholder="First Name" maxlength="50" required>
					</div>
				</div>
				<div class="form-group  qq-input">
					<div class="col-md-12">
						<input class="form-control" id="Last_Name" name="Last_Name" type="text" placeholder="Last Name" maxlength="50" required>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input class="form-control input-md" id="Phone_1" name="Phone_1" type="text" placeholder="Phone" maxlength="10">
						<span class="help-block">Numbers Only - no hypens or parentheses</span>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input class="form-control" id="Email" name="Email" type="Email" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">                     
						<textarea class="form-control" id="Comments" name="Comments" placeholder="Comments"></textarea>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input class="btn btn-navy" type="submit" id="submit" name="submit" value="#arguments.btn_label#">
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>

	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="automall_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="email_subject" default="Quick Quote Request from #lcase(cgi.Server_Name)#">

		<cfif form.VOI_New_Used eq "N">
			<cfset arguments.lead_type_id=4> <!---New--->
		<cfelse>
			<cfset arguments.lead_type_id=6> <!---Used--->
		</cfif>

		<!--- defaults --->
		<cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">
		<cfset variables.from_email="leads@pittsburghautosuperstore.com">
		<cfparam name="variables.Email_Subject" default="#arguments.email_subject#">
		<cfset variables.mail_server="info@tradeinprogram.com:wd2000@mail.greatmail.com">
	
		<cfparam name="form.Dealer_ID" default="#arguments.automall_id#">
		<cfparam name="form.Delivery_Dealer_ID" default="#arguments.dealer_id#">
		<cfparam name="form.First_Name" default="">
		<cfparam name="form.Last_Name" default="">
		<cfparam name="form.Phone_1" default="">
		<cfparam name="form.Email" default="">

		<cfparam name="form.VOI_Vin" default="">
		<cfparam name="form.VOI_New_Used" default="">
		<cfparam name="form.VOI_Year" default="">
		<cfparam name="form.VOI_Make" default="">
		<cfparam name="form.VOI_Model" default="">
		<cfparam name="form.VOI_Stock" default="">

		<cfparam name="form.Comments" default="">

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
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>

		<cfelse>
			
			<cfswitch expression="#arguments.dealer_id#" >
				<cfdefaultcase>
					<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
						<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(form.VOI_Vin,17)#" maxlength="21">
						<cfprocresult name="Get_Vehicle_Details" resultset="1">
					</cfstoredproc>
					<cfset form.Delivery_Dealer_ID=Get_Vehicle_Details.Dealer_ID>
				</cfdefaultcase>
			</cfswitch>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#arguments.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#arguments.automall_id#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="remote_addr" value="#cgi.Remote_Addr#">
				<cfinvokeargument name="http_user_agent" value="#cgi.Http_User_Agent#">
			</cfinvoke>
	
			<cfinvoke component="/cfcs/forms/form_save" method="insert_contact" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Contact_Type_ID" value="1"/>
				<cfinvokeargument name="first_name" value="#form.First_Name#"/>
				<cfinvokeargument name="last_name" value="#form.Last_Name#"/>
				<cfinvokeargument name="email" value="#form.Email#"/>
				<cfinvokeargument name="phone_1" value="#form.Phone_1#"/>
				<cfinvokeargument name="comments" value="#form.Comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="4"/>
				<cfinvokeargument name="new_used" value="#form.VOI_New_Used#"/>
				<cfinvokeargument name="v_year" value="#form.VOI_Year#"/>
				<cfinvokeargument name="v_make" value="#form.VOI_Make#"/>
				<cfinvokeargument name="v_model" value="#form.VOI_Model#"/>
				<cfinvokeargument name="v_vin" value="#form.VOI_Vin#"/>
				<cfinvokeargument name="v_stock" value="#form.VOI_Stock#"/>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_type_id#" maxlength="10">
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
					<cfprocresult name="Get_Lead_Addresses" resultset="1">
				</cfstoredproc>
				<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>
			</cfif>

			<!---Get Automall Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_type_id#" maxlength="10">
				<cfprocresult name="Get_Automall_Addresses" resultset="1">
			</cfstoredproc>
			<cfloop query="Get_Automall_Addresses">
				<cfset variables.recipient_list=listappend(variables.recipient_list,Get_Automall_Addresses.Email)>
			</cfloop>

			<!---If no Automall delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Automall_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
					<cfprocresult name="Get_Automall_Addresses" resultset="1">
				</cfstoredproc>
				<cfloop query="Get_Automall_Addresses">
					<cfset variables.recipient_list=listappend(variables.recipient_list,Get_Automall_Addresses.Email)>
				</cfloop>
			</cfif>

			<!---Generate Text Email--->

			<cfinvoke component="/cfcs/emails/text_gen" method="contact_text" returnvariable="text_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
				<cfinvokeargument name="first_name" value="#form.First_Name#"/>
				<cfinvokeargument name="last_name" value="#form.Last_Name#"/>
				<cfinvokeargument name="email" value="#form.Email#"/>
				<cfinvokeargument name="phone_1" value="#form.Phone_1#"/>
				<cfinvokeargument name="comments" value="#form.Comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="new_used" value="#form.VOI_New_Used#"/>
				<cfinvokeargument name="v_year" value="#form.VOI_Year#"/>
				<cfinvokeargument name="v_make" value="#form.VOI_Make#"/>
				<cfinvokeargument name="v_model" value="#form.VOI_Model#"/>
				<cfinvokeargument name="v_vin" value="#form.VOI_Vin#"/>
				<cfinvokeargument name="v_stock" value="#form.VOI_Stock#"/>
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
				<cfinvokeargument name="first_name" value="#form.First_Name#"/>
				<cfinvokeargument name="last_name" value="#form.Last_Name#"/>
				<cfinvokeargument name="email" value="#form.Email#"/>
				<cfinvokeargument name="phone_1" value="#form.Phone_1#"/>
				<cfinvokeargument name="comments" value="#form.Comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="test-drive"/>
				<cfinvokeargument name="new_used" value="#form.VOI_New_Used#"/>
				<cfinvokeargument name="v_year" value="#form.VOI_Year#"/>
				<cfinvokeargument name="v_make" value="#form.VOI_Make#"/>
				<cfinvokeargument name="v_model" value="#form.VOI_Model#"/>
				<cfinvokeargument name="v_vin" value="#form.VOI_Vin#"/>
				<cfinvokeargument name="v_stock" value="#form.VOI_Stock#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="provider_trib" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>
			
			<!---bcc--->
			<cfparam name="variables.WD_BCC" default="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">
			
			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.from_email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.Email#">
#variables.text_email#
</cfmail>
<!---<li>#Get_Lead_Addresses.Email# - Text</li>--->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.from_email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.Email#">
#variables.adf_email#
</cfmail>
<!---<li>#Get_Lead_Addresses.Email# - ADF</li>--->					
					</cfif>

				</cfloop>
			</cfif>

			<cfif Get_Automall_Addresses.Recordcount gt 0>
				<cfloop query="Get_Automall_Addresses">
					<!---Send Text Emails--->
<cfmail to="#Get_Automall_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.text_email#
</cfmail>
				</cfloop>
			</cfif>

			<cflocation url="http://#cgi.server_name#/vehicles/thank_you_quote.cfm">
	
		</cfif>
	
	</cffunction>

</cfcomponent>