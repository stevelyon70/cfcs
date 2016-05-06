<cfcomponent>

	<cffunction name="form_popup" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_legend" default="Contact Us">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/friend_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-4" for="First_Name"><span class="txt-red">*</span> Your Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="Your Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-4" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-4" for="friend_name"><span class="txt-red">*</span> Your Friend's Name</label>
					<div class="col-md-6">
						<input name="friend_name" class="form-control input-md" id="friend_name" type="text" maxlength="50" placeholder="Your Friend's Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-4" for="friend_email"><span class="txt-red">*</span> Your Friend's Email</label>
					<div class="col-md-6">
						<input name="friend_email" class="form-control input-md" id="friend_email" type="email" maxlength="100" placeholder="Your Friend's Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-4" for="Comments"><span class="txt-red">*</span> Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000" required>#url.v_comments#</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-4" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Send to Your Friend" <cfif url.sdds eq 1> onclick="tmsomni.linkTrackEvents = 'event67';"</cfif>>
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>

	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Ultra10">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.friend_name" default="">
		<cfparam name="form.friend_email" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.voi_vin" default="">
		<cfparam name="form.voi_stock" default="">
		<cfparam name="form.voi_year" default="">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">

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
			<cfset form.delivery_dealer_id=Get_Vehicle_Details.Dealer_ID>
		</cfif>

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">


		<!--- First Name: form.first_name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Your Name"/>
			<cfinvokeargument name="text_value" value="#form.first_name#"/>
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
		<!--- Friend's Name: form.friend_name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Friend's Name"/>
			<cfinvokeargument name="text_value" value="#form.friend_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Friend Email: form.Friend_Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Friend's Email"/>
			<cfinvokeargument name="text_value" value="#form.friend_email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
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
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_contact" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Contact_Type_ID" value="2"/>
				<cfinvokeargument name="first_name" value="#form.friend_name#"/>
				<cfinvokeargument name="email" value="#form.friend_email#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="1"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.delivery_dealer_id#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_send_id#" maxlength="10">
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
					<cfprocresult name="Get_Lead_Addresses" resultset="1">
				</cfstoredproc>
				<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>
			</cfif>

			<!---Generate Text Email--->

			<cfinvoke component="/cfcs/emails/text_gen" method="contact_text" returnvariable="text_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
				<cfinvokeargument name="name" value="#form.friend_name#"/>
				<cfinvokeargument name="email" value="#form.friend_email#"/>
				<cfinvokeargument name="ref_name" value="#form.first_name#"/>
				<cfinvokeargument name="ref_email" value="#form.email#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
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
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			
			
			
			
			
			<cfparam name="variables.Email_Subject" default="Send to a Friend Referral from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

<cfmail to="#form.friend_email#" from="#form.email#" subject="#form.first_name# Wants You to Check Out This #form.voi_year# #form.voi_make# #form.voi_model# #form.voi_trim# at #url.dealer_name#" bcc="#variables.WD_BCC#" type="html">
<br/>
Dear #form.friend_name#,<br/>
#form.comments#<br/><br/>
You can see more on this vehicle by following the link below:<br/>
Sincerely,<br/>
#form.first_name#<br/><br/>
<a href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#form.voi_vin#">Click Here to view this vehicle</a><br/><br/>
</cfmail>

			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
						<cfmailparam name="Reply-To" value="#form.email#">
						#variables.text_email#
						</cfmail>
					</cfif>
					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1 and url.dealer_id eq 51 >  <!--- Lamacchia Honda --->
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
						<cfmailparam name="Reply-To" value="#form.email#">
						#variables.text_email#
						</cfmail>
					</cfif>

				</cfloop>
			</cfif>
			
		</cfif>

	</cffunction>

</cfcomponent>