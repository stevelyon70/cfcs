<cfcomponent>

	<cffunction name="contact_form" description="contact form for automall" output="Yes" access="public">
		<cfargument name="Get_All_Dealers" required="true"/>
		<cfset Get_All_Dealers=arguments.Get_All_Dealers>

		<div class="row">
			<div class="col-md-12">
				<cfparam name="url.first_name" default="">
				<cfparam name="url.last_name" default="">
				<cfparam name="url.email" default="">
				<cfparam name="url.phone_1" default="">
				<cfparam name="url.phone_2" default="">
				<cfparam name="url.best_method" default="">
				<cfparam name="url.best_time" default="">
				<cfparam name="url.comments" default="">
				<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="post">
					<fieldset>
						<input type="hidden" name="Automall_ID" value="#arguments.Automall_ID#"/>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="first_name"><em>*</em> First Name</label>
							<div class="col-md-8">
								<input name="first_name" class="form-control input-md" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="last_name"><em>*</em> Last Name</label>  
							<div class="col-md-8">
								<input name="last_name" class="form-control input-md" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="email"><em>*</em> Email</label>  
							<div class="col-md-8">
								<input name="email" class="form-control input-md" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="phone"><em>*</em> Daytime Phone</label>  
							<div class="col-md-8">
								<input name="phone_1" class="form-control input-md" id="phone_1" type="text" placeholder="Phone" maxlength="10" value="#url.phone_1#" required/>
								<span class="help-block">Numbers Only - no hypens or parentheses</span>  
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="phone">Evening Phone</label>  
							<div class="col-md-8">
								<input name="phone_2" class="form-control input-md" id="phone_2" type="text" placeholder="Phone" maxlength="10" value="#url.phone_2#"/>
								<span class="help-block">Numbers Only - no hypens or parentheses</span>  
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="best_method"><em>*</em> Best Contact Method</label>  
							<div class="col-md-8">
								<select id="best_method" name="best_method" class="form-control input-md">
									<option value="Email" <cfif url.best_method eq "Email">selected</cfif>>Email</option>
									<option value="Daytime Phone" <cfif url.best_method eq "Daytime Phone">selected</cfif>>Daytime Phone</option>
									<option value="Evening Phone" <cfif url.best_method eq "Evening Phone">selected</cfif>>Evening Phone</option>
									<option value="Text Daytime Phone" <cfif url.best_method eq "Text Daytime Phone">selected</cfif>>Text Daytime Phone</option>
									<option value="Text Evening Phone" <cfif url.best_method eq "Text Evening Phone">selected</cfif>>Text Evening Phone</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="best_time"><em>*</em> Best Contact Time</label>  
							<div class="col-md-8">
								<select id="best_time" name="best_time" class="form-control input-md">
									<option value="Evening" <cfif url.best_time eq "Evening">selected</cfif>>Evening</option>
									<option value="Afternoon" <cfif url.best_time eq "Afternoon">selected</cfif>>Afternoon</option>
									<option value="Morning" <cfif url.best_time eq "Morning">selected</cfif>>Morning</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label visible-md visible-lg" for="comments">Comments</label>
							<div class="col-md-8">                     
								<textarea name="comments" class="form-control" id="comments" maxlength="1000" placeholder="Comments">#url.comments#</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="delivery_dealer_id"><em>*</em> Select A Dealer</label>
							<div class="col-md-8">
								<select id="delivery_dealer_id" name="delivery_dealer_id" class="form-control input-md" required>
									<option value="">Select A Dealer</option>
									<cfloop query="Get_All_Dealers">
										<option value="#Get_All_Dealers.Dealer_ID#">#Get_All_Dealers.Display_Name#</option>
									</cfloop>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="col-md-4 control-label" for="reset"></label>
							<div class="col-md-8" align="center">
								<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
								<input type="submit" class="btn btn-primary" id="submit" value="Contact Us"/>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</cffunction>
	
	<cffunction name="submit_form" description="contact form for automall" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Automall_ID" required="true">
		<cfset variables.lead_type_id="3">

		<!--- defaults --->
		<cfparam name="form.dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.phone_2" default="">
		<cfparam name="form.best_method" default="Email">
		<cfparam name="form.best_time" default="Evening">
		<cfparam name="form.comments" default="">
		
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
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Daytime Phone"/>
			<cfinvokeargument name="text_value" value="#form.Phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Evening Phone: form.Phone_2 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Evening Phone"/>
			<cfinvokeargument name="text_value" value="#form.Phone_2#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Select Dealership: form.Delivery_Dealer_ID --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Preferred Dealership"/>
			<cfinvokeargument name="int_value" value="#form.Delivery_Dealer_ID#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select a Dealership"/>
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
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#variables.lead_type_id#" maxlength="10">
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

			<!---Get Automall Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#variables.lead_type_id#" maxlength="10">
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
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
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
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
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

			<cfparam name="variables.Email_Subject" default="Finance Request from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@pittsburghautosuperstore.com">
			<!---bcc--->
			<cfparam name="variables.WD_BCC" default="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

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

			<cfif Get_Automall_Addresses.Recordcount gt 0>
				<cfloop query="Get_Automall_Addresses">
					<!---Send Text Emails--->
<cfmail to="#Get_Automall_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
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
			#form.Phone_2#<br/>
			#form.Best_Method#<br/>
			#form.Best_Time#<br/>
			#form.Email#<br/>
			#form.Comments#<br/><br/>
			Lead ID - #variables.New_ID#<br/>
			Contact ID - #variables.Contact_ID#
			#variables.recipient_list#
			--->
			
			<cflocation url="thank_you.cfm">

		</cfif>
	
	</cffunction>
</cfcomponent>