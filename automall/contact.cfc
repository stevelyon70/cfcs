<cfcomponent>

	<cffunction name="contact_form" description="contact form for automall" output="Yes" access="public">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_banner#
				</div>
			</div>
		</cfif>
		<div class="row">
			<div class="col-md-12">
				<cfparam name="url.first_name" default="">
				<cfparam name="url.last_name" default="">
				<cfparam name="url.email" default="">
				<cfparam name="url.phone" default="">
				<cfparam name="url.comments" default="">
				<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="post">
					<fieldset>
						<input type="hidden" name="Automall_ID" value="#arguments.Automall_ID#"/>
						<div class="form-group">
							<label class="col-md-3 control-label visible-md visible-lg" for="first_name"><em>*</em> First Name</label>
							<div class="col-md-6">
								<input name="first_name" class="form-control input-md" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label visible-md visible-lg" for="last_name"><em>*</em> Last Name</label>  
							<div class="col-md-6">
								<input name="last_name" class="form-control input-md" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label visible-md visible-lg" for="email"><em>*</em> Email</label>  
							<div class="col-md-6">
								<input name="email" class="form-control input-md" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label visible-md visible-lg" for="phone">Phone</label>  
							<div class="col-md-6">
								<input name="phone" class="form-control input-md" id="phone" type="text" placeholder="Phone" maxlength="10" value="#url.phone#"/>
								<span class="help-block">Numbers Only - no hypens or parentheses</span>  
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label visible-md visible-lg" for="comments"><em>*</em> Comments</label>
							<div class="col-md-6">                     
								<textarea name="comments" class="form-control" id="comments" maxlength="1000" placeholder="Comments" required>#url.comments#</textarea>
							</div>
						</div>
						<div class="control-group">
							<label class="col-md-3 control-label" for="reset"></label>
							<div class="col-md-6" align="center">
								<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
								<input type="submit" class="btn btn-primary" id="submit" value="Contact Us"/>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_footer#
				</div>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="submit_form" description="contact form for automall" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Automall_ID" required="true">
		<cfset variables.lead_type_id="1">

		<!--- defaults --->
		<cfparam name="form.Dealer_ID" default="#arguments.Automall_ID#">
		<cfparam name="form.Delivery_Dealer_ID" default="#arguments.Automall_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.phone" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.comments" default="">

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
			<cfinvokeargument name="text_name" value="Daytime Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<div class="row">
				<div class="col-md-12">
					<br/>
					<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
						<cfinvokeargument name="error_message" value="#variables.error_message#"/>
					</cfinvoke>
	
					<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?first_name=#form.first_name#&last_name=#form.last_name#&phone=#form.phone#&email=#form.email#&comments=#form.comments#">Go Back</a>
					<br/>
				</div>
			</div>
		
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
				<cfinvokeargument name="phone_1" value="#form.phone#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#variables.lead_type_id#" maxlength="10">
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
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
				<cfinvokeargument name="phone_1" value="#form.phone#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
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
				<cfinvokeargument name="phone_1" value="#form.phone#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfset variables.this_dealer_id=form.Dealer_ID>
			
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

			<cfparam name="variables.Email_Subject" default="Contact Request from #lcase(cgi.Server_Name)#">
			<!---bcc--->
			<cfparam name="variables.WD_BCC" default="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">
			
			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="leads@pittsburghautosuperstore.com" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.text_email#
</cfmail>
<!--- <li>#Get_Lead_Addresses.Email# - Text</li> --->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
<cfmail to="#Get_Lead_Addresses.Email#" from="leads@pittsburghautosuperstore.com" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.adf_email#
</cfmail>
<!--- <li>#Get_Lead_Addresses.Email# - ADF</li>	 --->				
					</cfif>

				</cfloop>
			</cfif>

			<!---#form.Dealer_ID#<br/>
			#form.Delivery_Dealer_ID#<br/>
			#form.First_Name#<br/>
			#form.Last_Name#<br/>
			#form.Phone_1#<br/>
			#form.Email#<br/>
			#form.Comments#<br/><br/>
			Lead ID - #variables.New_ID#<br/>
			Contact ID - #variables.Contact_ID#--->
		
			<cflocation url="thank_you.cfm">
			
		</cfif>
	
	</cffunction>
</cfcomponent>