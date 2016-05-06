<cfcomponent>

	<cffunction name="form_popup" description="popup version of form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="VOI_Title" required="true">
		<cfargument name="Dealer_Display_Name" required="true">
		<cfargument name="btn_label" default="SEND TO A FRIEND">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="form_name" default="quick_quote">

		<cfparam name="url.first_name" default="">
		<cfparam name="url.email" default="">
		<cfparam name="url.friend_name" default="">
		<cfparam name="url.friend_email" default="">
		<cfparam name="url.comments" default="">
		
		<cfif len(trim(url.comments)) eq 0>
			<cfset url.comments="Check out this #arguments.VOI_Title# at #arguments.Dealer_Display_Name#">
		</cfif>
	
		<form class="form-horizontal no-pad" action="#arguments.form_action#?form_action=friend_submit&vin=#left(arguments.VOI_Vin,17)#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
			<fieldset>
				<input name="VOI_Vin" id="VOI_Vin" type="hidden"  value="#left(arguments.VOI_Vin,17)#"/>
				<div class="row">
					<label class="col-md-4 control-label modal-label visible-md visible-lg" for="first_name"><em>*</em> Your Name</label>
					<div class="col-md-8">
						<input name="first_name" class="form-control input-md modal-input" id="first_name" type="text" placeholder="Your Name" maxlength="50" value="#url.first_name#" required/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-4 control-label modal-label visible-md visible-lg" for="email"><em>*</em>Your Email</label>  
					<div class="col-md-8">
						<input name="email" class="form-control input-md modal-input" id="email" type="email" placeholder="Your Email" maxlength="100" value="#url.first_name#" required/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-4 control-label modal-label visible-md visible-lg" for="friend_name"><em>*</em> Your Friend's Name</label>
					<div class="col-md-8">
						<input name="friend_name" class="form-control input-md modal-input" id="friend_name" type="text" placeholder="Your Friend's Name" maxlength="50" value="#url.friend_name#" required/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-4 control-label modal-label visible-md visible-lg" for="friend_email"><em>*</em>Your Friend's Email</label>  
					<div class="col-md-8">
						<input name="friend_email" class="form-control input-md modal-input" id="friend_email" type="friend_email" placeholder="Your Friend's Email" maxlength="100" value="#url.friend_email#" required/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-4 control-label modal-label visible-md visible-lg" for="comments">Comments</label>
					<div class="col-md-8">                     
						<textarea name="comments" class="form-control modal-input" id="comments" maxlength="500" placeholder="Comments" rows="8">#url.comments#</textarea>
					</div>
					<div class="col-md-2 visible-md visible-lg"></div>
				</div>
				<div class="row">
					<label class="col-md-4 control-label" for="reset"></label>
					<div class="col-md-8" align="center">
						<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
						<input type="submit" class="btn btn-primary" id="submit" value="#arguments.btn_label#"/>
					</div>
					<div class="col-md-2 visible-md visible-lg"></div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>
	
	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">


		<!--- arguments --->
		<cfargument name="Automall_ID" required="true">
		<cfargument name="VOI_Vin" required="true">

		<!--- defaults --->
		<cfparam name="form.dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.friend_name" default="">
		<cfparam name="form.friend_email" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.voi_vin" default="0">


		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Automall" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.voi_vin,17)#" maxlength="21">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="2">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>

		<cfset form.Delivery_Dealer_ID=Get_Vehicle_Details.Dealer_ID>

		<cfif Get_Vehicle_Details.V_New_Used eq "N">
			<cfset variables.lead_type_id="5">
			<cfset variables.lead_send_id="4">
		<cfelse>
			<cfset variables.lead_type_id="6">
			<cfset variables.lead_send_id="18">
		</cfif>
		
		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Your Name"/>
			<cfinvokeargument name="text_value" value="#form.First_Name#"/>
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
		<!--- Friend's Name: form.friend_name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Friend's Name"/>
			<cfinvokeargument name="text_value" value="#form.friend_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Friend's Email: form.friend_email --->
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
			<cfinvokeargument name="text_value" value="#form.Comments#"/>
			<cfinvokeargument name="text_req" value="true"/>
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
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_contact" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Contact_Type_ID" value="3"/>
				<cfinvokeargument name="friend_name" value="#form.friend_name#"/>
				<cfinvokeargument name="friend_email" value="#form.friend_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="8"/>
				<cfinvokeargument name="v_vin" value="#Get_Vehicle_Details.Vin#"/>
				<cfinvokeargument name="v_stock" value="#Get_Vehicle_Details.Stock#"/>
				<cfinvokeargument name="new_used" value="#Get_Vehicle_Details.V_New_Used#"/>
				<cfinvokeargument name="v_year" value="#Get_Vehicle_Details.V_Year#"/>
				<cfinvokeargument name="v_make" value="#Get_Vehicle_Details.V_Make#"/>
				<cfinvokeargument name="v_model" value="#Get_Vehicle_Details.V_Model#"/>
				<cfinvokeargument name="v_trim" value="#Get_Vehicle_Details.V_Trim#"/>
				<cfinvokeargument name="v_price" value="#Get_Vehicle_Details.Selling_Price#"/>
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

			<!---Get Automall Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@var" value="#form.Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@var" value="#variables.lead_send_id#" maxlength="10">
				<cfprocresult name="Get_Automall_Addresses" resultset="1">
			</cfstoredproc>
			<cfloop query="Get_Automall_Addresses">
				<cfset variables.recipient_list=listappend(variables.recipient_list,Get_Automall_Addresses.Email)>
			</cfloop>

			<!---If no Automall delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Automall_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@var" value="#form.Dealer_ID#" maxlength="10">
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
				<cfinvokeargument name="name" value="#form.friend_name#"/>
				<cfinvokeargument name="email" value="#form.friend_email#"/>
				<cfinvokeargument name="ref_name" value="#form.first_name#"/>
				<cfinvokeargument name="ref_email" value="#form.email#"/>
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
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<cfparam name="variables.Email_Subject" default="Send to a Friend Referral from #lcase(cgi.server_name)#">
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

				</cfloop>
			</cfif>

			<cfif Get_Automall_Addresses.Recordcount gt 0>
				<cfloop query="Get_Automall_Addresses">
					<!---Send Text Emails--->
<cfmail to="#Get_Automall_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.text_email#
</cfmail>
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
			
			<cflocation url="thank_you_friend.cfm">	
			
		</cfif>
			
	</cffunction>

</cfcomponent>