<cfcomponent>

	<cffunction name="sall_default" description="display default contact us form" output="Yes" access="public">
		
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="passed_purl" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#/forms/sall_action.cfm"> 

		<cfset var Get_Form_Locations="">
		<cfset multi_purl = 0 >
		
		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL
			FROM         Campaign_Control
			WHERE	Campaign_URL=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CGI.server_name#" maxlength="50"> 
		</cfquery>
		
		<cfquery name="get_images" datasource="SALL">
			SELECT     id, campaign_id, left_header_image, splash_image, lower_right_image, video_image, lower_page2_image, 
						button_page1, button_page2, email_image_1, email_image_2, active
			FROM       Campaign_Images
			where	campaign_id = #Get_Control_Details.campaign_id#
		</cfquery>
		
		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group pull-left">
					<div class="col-md-12" align="left">
					<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:20pt;color:##cc0000;font-weight:bold">Step 1</span>
					</div>
					<div class="col-md-12" align="left">
					<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:10pt;color:##cc0000;font-weight:bold">Enter Your Private Invitation Number (PIN) and Contact Information<br>(all fields required)</span>
					</div>
				</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">PIN:</span>
					</div>
					<div class="col-md-10" align="left">
						<input name="user_pin"  id="user_pin" class="input-sm "  style="border:1px solid ##cc0000"  type="text" size="30"  maxlength="11" placeholder="" required> 
					</div> 
				</div>
				<div class="form-group">
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">First Name:</span>
					</div>
					<div class="col-md-10" align="left">
						<input name="First_Name" class="  input-sm" style="border:1px solid ##cc0000;min-height:25px"  id="First_Name" type="text" size="30"  maxlength="50" required>
					</div> 
				</div>
				<div class="form-group">
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Last Name:</span>
					</div>
					<div class="col-md-10" align="left">
						<input name="Last_Name"  class="input-sm" style="border:1px solid ##cc0000;min-height:25px"  id="Last_Name" type="text" size="30"  maxlength="50"  required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Email:</span>
					</div>
					<div class="col-md-10" align="left">
						<input name="Email" class="input-sm" style="border:1px solid ##cc0000;min-height:25px"   id="Email" type="email" size="30"  maxlength="100"   required >
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Phone:</span>
					</div>
					<div class="col-md-10" align="left">
						<input name="Phone_1"  class="input-sm"  style="border:1px solid ##cc0000;min-height:25px"  id="Phone_1" type="text" size="30"  maxlength="10"   required >
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div> 
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-8" align="center">
						<cfif #get_images.button_page1# NEQ "" >
							<input type="image" src="http://#cgi.server_name#/sall/images/#get_images.button_page1#" border="0" alt="Submit">
						<cfelse>
							<input type="button" name="submit" value="Submit" border="0" alt="Submit">	
						</cfif>
					</div>
				</div>
			</fieldset>
		</form>


	</cffunction>

	<cffunction name="sall_default_mobile" description="display Mobile contact us form" output="Yes" access="public">
		
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/sall_action.cfm"> 

		<cfset var Get_Form_Locations="">
		
		
		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL
			FROM         Campaign_Control
			WHERE	Campaign_URL=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CGI.server_name#" maxlength="50"> 
		</cfquery>
		
		<cfquery name="get_images" datasource="SALL">
			SELECT     id, campaign_id, left_header_image, splash_image, lower_right_image, video_image, lower_page2_image, 
						button_page1, button_page2, email_image_1, email_image_2, active
			FROM       Campaign_Images
			where	campaign_id = #Get_Control_Details.campaign_id#
		</cfquery>

		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group pull-left">
					<div class="col-md-12" align="left">
					<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:20pt;color:##cc0000;font-weight:bold">Step 1</span>
					</div>
					<div class="col-md-12" align="left">
					<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:10pt;color:##cc0000;font-weight:bold">Enter Your Private Invitation Number (PIN) and Contact Information<br>(all fields required)</span>
					</div>
				</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-10" align="left">
						<input name="user_pin"  id="user_pin" class="input-sm "  style="border:1px solid ##cc0000"  type="text" size="30"  maxlength="11" placeholder="PIN" required> 
					</div> 
				</div>
				<div class="form-group">
					<div class="col-md-10" align="left">
						<input name="First_Name" class="  input-sm" style="border:1px solid ##cc0000;min-height:25px"  id="First_Name" type="text" size="30" placeholder="Firstname"  maxlength="50" required>
					</div> 
				</div>
				<div class="form-group">
					<div class="col-md-10" align="left">
						<input name="Last_Name"  class="input-sm" style="border:1px solid ##cc0000;min-height:25px"  id="Last_Name" type="text" size="30" placeholder="Lastname"  maxlength="50"  required>
					</div>
				</div>
				<div class="form-group">
						<div class="col-md-10" align="left">
						<input name="Email" class="input-sm" style="border:1px solid ##cc0000;min-height:25px"   id="Email" type="email" size="30"  placeholder="Email" maxlength="100"   required >
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-10" align="left">
						<input name="Phone_1"  class="input-sm"  style="border:1px solid ##cc0000;min-height:25px"  id="Phone_1" type="text" size="30" placeholder="Phone"  maxlength="10"   required >
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div> 
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-8" align="left">
						<input type="image" src="http://#cgi.server_name#/sall/images/#get_images.button_page1#" border="0" alt="Submit">
					</div>
				</div>
			</fieldset>
		</form>


	</cffunction>
	
	<cffunction name="form_submit_sall" description="action page for form" output="Yes" access="public">
 	
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="SALL">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.address" default="">
		<cfparam name="form.city" default="">
		<cfparam name="form.state" default="">
		<cfparam name="form.zip" default="">
		<cfparam name="form.authorization_nbr" default="">
		<cfparam name="form.newsletter" default="0">
		<cfparam name="form.multi_purl" default="0">

		<cfparam name="form.voi_vin" default="">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.voi_stock" default="">
		<cfparam name="form.voi_year" default="">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">
		<cfparam name="form.sales_rep" default="">

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<!--- <cfinvoke component="/cfcs/ultra10/forms/form_save" method="check_submit"></cfinvoke> --->

		<!---Server Side Form Validation--->

		<!--- set mail parameters --->
		<!--- <cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net"> --->
		<cfset variables.subject="Thank you for submitting your information to Direct Car Financing!">
		<cfset variables.from="info@autoproval.com">
	
		<cfset variables.error_message="">
		<cfset variables.error=0>

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
		
		<cfif listlen(variables.error_message) gt 0>
			<cfset url.error_message=variables.error_message>
		<cfelse> 
  
<!--- Create "MyID"  --->
			<cfset variables.MyID=replace(createUUID(),'-','','all')>
	
			<cfset nbr_of_visits = 0 >
			<cfquery datasource="SALL" name="Check_Pin">
				SELECT 	 ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                      	nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, v_year, v_make, v_model, authorization_nbr
				FROM    Customer_PURLs
				WHERE	PURL=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
				AND		Active=1
			</cfquery>

				
			<cfif #Check_Pin.recordcount# eq 0>
				
				<!---  <cfmail to="wdsupport@worlddealer.net" from="#variables.from#" subject="Invalid CCAPapproval.com Approval Code" bcc="bob@worlddealer.net"  type="HTML"> --->
				 <cfmail to="bob@worlddealer.net" from="leads@worlddealer.net" subject="Invalid tradeoffer.org pURL"   type="HTML">	 
					An invalid pURL has been entered at tradeoffer.org<br>All info entered is below<br><br>
					PURL : #form.user_pin#<br><br>
					Firstname : #form.first_name#<br>
					Lastname : #form.last_name#<br>
					Email : #form.email#<br>
					Phone : #form.phone_1#<br><br>
					Date/Time: #dateformat(now(),"mm/dd/yyyy")#&nbsp;@&nbsp;#timeformat(now(),"hh:mm tt")#
					<br><br>
					This lead has not been delivered!<br>
					Please check the area code entered vs which dealers we have in the system and verify that all dealers in that area have valid Approval Codes.<br>
					If you indeed believe this is a valid attempt to use the system and a dealer doesn't have PIN, please contact Aspen IMMEDIATELY with the dealer information.<br><br>
				
					This could be a DUPLICATE pURL and the email address entered doesn't match anyone in the database.<br>
					This could be a typo on the user's part.<br>
					This could be somebody testing the system.<br>
					This could also be somebody messing with the system.<br>
					We need to rule out all possibilities.<br>

				</cfmail>
				<cfset url.error_message="Invalid Approval Code. Please try again.">
			<cfelse> 
				<!--- PIN is good, continue --->
				<cfoutput>
				
				<cfset form.address = #Check_Pin.Address_1# >
				<cfset form.city = #Check_Pin.City# >
				<cfset form.state = #Check_Pin.State# >
				<cfset form.zip = #Check_Pin.Zip# >

				<cfset nu_clicks = #Check_Pin.nbr_visits#+1 >		
				<cfquery NAME="UpdateCustClicks" datasource="SALL">
					UPDATE Customer_PURLs
					SET 	nbr_visits=#nu_clicks#,
							first_visit_dt=#CreateODBCDate(now())#
					WHERE 	ID	=	#Check_Pin.ID#
				</cfquery>
				
				<cfset url.purl = #form.user_pin#>
				<cfset url.customer_purl_id = #Check_Pin.ID# >
				<cfset nbr_of_visits = #nu_clicks# >
				<cfquery datasource="SALL" name="Get_S_Dealer">
					SELECT	ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, 
                      		Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active, clicks,email_type, Dealer_Report_Name
					FROM    Dealers	
					WHERE	Dealer_id= '#Check_Pin.Dealer_ID#'
				</cfquery>
				
				<cfset nu_clicks = #Get_S_Dealer.clicks#+1 >		
				<cfquery NAME="UpdateDClicks" datasource="SALL">
					UPDATE dealers
					SET 	clicks=#nu_clicks#
					WHERE 	ID	=	#Get_S_Dealer.ID#
				</cfquery>
				
				 <cfquery datasource="SALL" name="Get_Ctrl_Detl">
					 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL, Campaign_type, Campaign_Identifier, Campaign_Contact, Campaign_Contact_Phone, 
		    	                  Campaign_contact_email, Campaign_Image, Comments, Visits, active, start_dt, expires_dt
					FROM         Campaign_Control
					WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_S_Dealer.Campaign_ID#" maxlength="6"> 
				</cfquery>
				<cfset campaign_prime_url = #Get_Ctrl_Detl.Campaign_URL# >
				<cfset nu_camp_clicks = #Get_Ctrl_Detl.Visits#+1 >		
				<cfquery NAME="UpdateCampClicks" datasource="SALL">
					UPDATE Campaign_Control
					SET 	Visits=#nu_clicks#
					WHERE 	ID	=	#Get_Ctrl_Detl.ID#
				</cfquery>
				
				<cfif #Get_S_Dealer.Dealer_Email# NEQ "" >
					<cfset s_dealer_email = "#Get_S_Dealer.Dealer_Email#" >
					<cfset s_email_type = #Get_S_Dealer.email_type# >
				<cfelse>		
					<cfset s_dealer_email = "bob@worlddealer.net" >
					<cfset s_email_type = 0 >
				</cfif>
								
				<cfset variables.recipient_list="#s_dealer_email#">
				
				</cfoutput> 
				
				<cfif Check_Pin.Recordcount gt 0>
					<cfquery datasource="SALL" name="Insert_LEAD">
						INSERT INTO	Leads
									(campaign_id,
									dealer_id,
									Date_Submitted,
									PIN,
									MyID,
									First_Name,
									Last_Name,
									Address,
									City,
									State,
									Zip,
									Email,
				 					Phone,
									Trade_Year,
									Trade_Make,
									Trade_Model,
									Authorization_nbr,
									Newsletter_Opt_In)
							VALUES
									(<cfqueryparam value="#Check_Pin.Campaign_id#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									<cfqueryparam value="#Check_Pin.Dealer_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									#CreateODBCDate(now())#,
									<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.address#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.city#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.state#" cfsqltype="CF_SQL_VARCHAR" maxlength="2">,
									<cfqueryparam value="#form.zip#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
									<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#form.phone_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
									<cfqueryparam value="#Check_Pin.v_Year#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									<cfqueryparam value="#Check_Pin.v_make#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.v_model#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#Check_Pin.authorization_nbr#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfif IsDefined("form.Newsletter_Opt_In") >
										1
									<cfelse>
										0	
									</cfif> )
				 	</cfquery>
 					<cfset variables.dlrcode = 	#Check_Pin.Dealer_ID#>
				<cfelse>
					<cfset variables.error=1>
				</cfif>
	
				<cfif variables.error eq 0 >
					
			
					<cfquery datasource="SALL" name="Get_CCAP_Dealer">
						SELECT		Leads.Lead_ID,
									Leads.PIN,
									Leads.first_name,
									Leads.last_name,
									Leads.address,
									Leads.city,
									Leads.state,
									Leads.zip,
									Leads.phone,
									Leads.email,
									Leads.trade_year,
									Leads.trade_make,
									Leads.trade_model,
									Leads.Authorization_nbr,
									Leads.Newsletter_Opt_In,
									Leads.date_submitted,
									Dealers.ID,
									Dealers.Dealer_Name,
									Dealers.Dealer_contact,
									Dealers.dealer_id,
									Dealers. Dealer_Address_1,
									Dealers.Dealer_Address_2,
									Dealers.Dealer_City,
									Dealers.Dealer_State,
									Dealers. Dealer_Zip, 
									Dealers.Dealer_Phone
						FROM		Leads 
						INNER JOIN	Dealers
						ON			leads.dealer_id = Dealers.dealer_ID
						WHERE		leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>  
		  
			 		<cfset url.dealercode = #Get_S_Dealer.Dealer_ID# >
		
			 		<cfset url.dealer_id = #Get_CCAP_Dealer.ID# >
			 		<cfset url.dealercode_id = #Get_CCAP_Dealer.Dealer_ID# >
			 		<cfset url.MyID = #variables.MyID# >
		
					<cfquery datasource="Ultra10" name="Get_program_Details">
						SELECT		Dealer_ID,
									dealer_directory
						FROM		Dealers
						WHERE		Dealer_id = 331
						ORDER BY 	Dealer_Name
					</cfquery>
		
					<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  


					<!--- set mail parameters --->
					<!--- <cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net"> --->
					<cfset variables.subject="Congratulations on your Bonus Trade-In Offer from #Get_CCAP_Dealer.Dealer_Name#">
					<cfset variables.lead_subject="Bonus Trade-In Offer Claim from #Get_CCAP_Dealer.Dealer_Name#">
					<cfset variables.from="tradeoffer@tradeoffer.com">


				<!--- Leads Emails --->			
					<cfif #s_email_type# EQ 1  >
						<!---Generate ADF Email--->
						 <cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_CCAP_Dealer.Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="first_name" value="#Get_CCAP_Dealer.First_Name#"/>
							<cfinvokeargument name="last_name" value="#Get_CCAP_Dealer.Last_Name#"/>
							<cfinvokeargument name="email" value="#Get_CCAP_Dealer.Email#"/>
							<cfinvokeargument name="zip" value="#Get_CCAP_Dealer.zip#"/>
							<cfinvokeargument name="city" value="#Get_CCAP_Dealer.city#"/>
							<cfinvokeargument name="state" value="#Get_CCAP_Dealer.state#"/>
							<cfinvokeargument name="address_1" value="#Get_CCAP_Dealer.address#"/>
							<cfinvokeargument name="phone_1" value="#Get_CCAP_Dealer.Phone#"/>
							<cfinvokeargument name="PIN" value="#Get_CCAP_Dealer.Pin#"/>
							<cfinvokeargument name="Dealer" value="#Get_CCAP_Dealer.Dealer_Name#"/>
							<cfinvokeargument name="Newsletter" value="#Get_CCAP_Dealer.Newsletter_Opt_In#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="interest" value=""/>
							<cfinvokeargument name="v_vin" value=""/>
							<cfinvokeargument name="v_stock" value=""/>
							<cfinvokeargument name="new_used" value=""/>
							<cfinvokeargument name="v_year" value="#Get_CCAP_Dealer.trade_year#"/>
							<cfinvokeargument name="v_make" value="#Get_CCAP_Dealer.trade_make#"/>
							<cfinvokeargument name="v_model" value="#Get_CCAP_Dealer.trade_model#"/>
							<cfinvokeargument name="v_trim" value=""/>
							<cfinvokeargument name="v_price" value=""/>
							<cfif #form.multi_purl# EQ 0 >
								<cfinvokeargument name="v_comments" value=""/>
							<cfelse>
								<cfinvokeargument name="v_comments" value="MULTIPLES OF THIS PURL ON FILE"/>	
							</cfif>
						</cfinvoke>
						<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="#variables.recipient_list#" from="#variables.From#" subject="#variables.lead_subject#"<!---  bcc="wdsupport@worlddealer.net" --->  >
							#variables.adf_email#
					  	</cfmail>   
					<cfelse>
						<!---Generate TEXT Email--->
						<!--- <cfmail to="#variables.recipient_list#" from="#variables.from#" subject="#variables.lead_subject#" bcc="kelly@worlddealer.net,wdsupport@worlddealer.net"  type="HTML"> --->		
						<cfmail to="bob@worlddealer.net" from="#variables.from#" subject="#variables.lead_subject#"  type="HTML">			
							<table cellpadding="0" width="70%" cellspacing="0">
								<tr>
									<td align="left" > 
										Name: #form.First_Name# #form.Last_Name#<br>
										Address: #form.address#<br>
										City/ST/Zip: #form.City# #form.state# #form.zip#<br>
										Phone: #form.Phone_1#<br>
										Email: #form.Email#<br>
										Year: #Get_CCAP_Dealer.trade_year#<br>
										Make: #Get_CCAP_Dealer.trade_make#<br>
										Model: #Get_CCAP_Dealer.trade_model#<br>
										Newsletter: <cfif #Get_CCAP_Dealer.Newsletter_Opt_In# eq 1>Yes<cfelse>No</cfif><br>
										PURL: #Get_CCAP_Dealer.Pin#<br><br>
										Dealer: #Get_CCAP_Dealer.Dealer_Name#<br>
										Contact: #Get_CCAP_Dealer.Dealer_Contact#<br>
										Lead ID: #Get_CCAP_Dealer.Lead_ID# 
										<cfif #form.multi_purl# EQ 1 >
										<br><br>** MULTIPLES OF THIS PURL ON FILE **
										</cfif>
									 </td>
								</tr>
								<tr><td>&nbsp;</td></tr>
							</table>  
						</cfmail>
					</cfif>			
				<!--- END Leads Emails --->		
				</cfif>	<!--- end of variables.error if --->
			</cfif> <!--- end invalid PIN --->
			
		</cfif>
	</cffunction>

	<cffunction name="sall_page_2" description="display default contact us form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/sall_action_2.cfm"> 

		<cfset var Get_Form_Locations="">
		
		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL
			FROM         Campaign_Control
			WHERE	Campaign_URL=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CGI.server_name#" maxlength="50"> 
		</cfquery>
		
		<cfquery name="get_images" datasource="SALL">
			SELECT     id, campaign_id, left_header_image, splash_image, lower_right_image, video_image, lower_page2_image, 
						button_page1, button_page2, email_image_1, email_image_2, active
			FROM       Campaign_Images
			where	campaign_id = #Get_Control_Details.campaign_id#
		</cfquery>
			
		<cfquery datasource="SALL" name="Get_Lead_Detl">
			SELECT		Leads.Lead_ID,
						Leads.PIN,
						Leads.first_name,
						Leads.last_name,
						Leads.address,
						Leads.city,
						Leads.state,
						Leads.zip,
						Leads.phone,
						Leads.email,
						Leads.trade_year,
						Leads.trade_make,
						Leads.trade_model,
						Leads.Authorization_nbr,
						Leads.Newsletter_Opt_In,
						Leads.date_submitted,
						Dealers.ID,
						Dealers.Dealer_Name,
						Dealers.Dealer_contact,
						Dealers.dealer_id,
						Dealers. Dealer_Address_1,
						Dealers.Dealer_Address_2,
						Dealers.Dealer_City,
						Dealers.Dealer_State,
						Dealers. Dealer_Zip, 
						Dealers.Dealer_Phone
			FROM		Leads 
			INNER JOIN	Dealers
			ON			leads.dealer_id = Dealers.dealer_ID
			WHERE		leads.MyID=<cfqueryparam value="#arguments.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>  
		  
		<cfset variables.lead_phone = #Get_Lead_Detl.phone# >
			
		<form id="tap_drive" class="form-horizontal" name="sall_2" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" id="MyID" name="MyID" value="#arguments.MyID#">
				<input type="hidden" id="user_pin" name="user_pin" value="#Get_Lead_Detl.PIN#">
				<div class="form-group">
					<div class="col-md-4  visible-lg visible-md" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Age:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class="input-sm" name="age" id="age" >
						<option value="">Select Age</option>
						<option value="18-25">18 - 25</option>
						<option value="26-40">26 - 40</option>
						<option value="41-55">41 - 55</option>
						<option value="56-64">56 - 64</option>
						<option value="65 or Older">65 or Older</option>
					</select>
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4 visible-lg visible-md" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Income:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class=" input-sm" name="income" id="income">
						<option value="">Select Income</option>
						<option value="$0-$10000">$0 - $10,000</option>
						<option value="$10000-$20000">$10,000 - $20,000</option>
						<option value="$20000-$35000">$20,000 - $35,000</option>
						<option value="$35000-$50000">$35,000 - $50,000</option>
						<option value="$50000-$65000">$50,000 - $65,000</option>
						<option value="$65000-$80000">$65,000 - $80,000</option>
						<option value="Above $80000"> Above $80,000</option>
					</select>
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4 visible-lg visible-md" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Employment:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class=" input-sm" name="Employment" id="Employment">
						<option value="">Select Employment</option>
						<option value="0 - 6 Months">0 - 6 Months</option>
						<option value="6 Months - 2 Years">6 Months - 2 Years</option>
						<option value="2 Years - 5 Years">2 Years - 5 Years</option>
						<option value="5 Years - 10 Years">5 Years - 10 Years</option>
						<option value="10 Years or More">10 Years or More</option>
					</select>
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4 visible-lg visible-md" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Phone Number:</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Phone_1"  class=" input-sm"  style="border:1px solid ##666666;min-height:25px" placeholder="Phone" value="#variables.lead_phone#" id="Phone_1" type="text" size="30"  maxlength="10"   >
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4 visible-lg visible-md" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Appointment Date:</span> 
					</div>
					<div class="col-md-4" align="left">
						<input name="Appointment_date"  class=" input-sm"  style="border:1px solid ##666666;min-height:25px" placeholder="Appointment Date"  id="Appointment_date" type="text" size="30"  maxlength="10" required >
						<p class="help-block"><span style="color:##cc0000">Format: mm/dd/yyyy</span></p>					
					</div>
					
				</div>
				<div class="form-group">
					<div class="col-md-4 visible-lg visible-md" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Appointment Time:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class=" input-sm" name="Appointment_time" id="Appointment_time">
						<option value="">Select Appointment Time</option>
						<option value="9:00 AM">9:00 AM</option>
						<option value="9:30 AM">9:30 AM</option>
						<option value="10:00 AM">10:00 AM</option>
						<option value="10:30 AM">10:30 AM</option>
						<option value="11:00 AM">11:00 AM</option>
						<option value="11:30 AM">11:30 AM</option>
						<option value="12:00 PM">12:00 PM</option>
						<option value="12:30 PM">12:30 PM</option>
						<option value="1:00 PM">1:00 PM</option>
						<option value="1:30 PM">1:30 PM</option>
						<option value="2:00 PM">2:00 PM</option>
						<option value="2:30 PM">2:30 PM</option>
						<option value="3:00 PM">3:00 PM</option>
						<option value="3:30 PM">3:30 PM</option>
						<option value="4:00 PM">4:00 PM</option>
						<option value="4:30 PM">4:30 PM</option>
						<option value="5:00 PM">5:00 PM</option>
						<option value="5:30 PM">5:30 PM</option>
						<option value="6:00 PM">6:00 PM</option>
						<option value="6:30 PM">6:30 PM</option>
					</select>
					</div>
				</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-8" align="right">
						<input type="submit" class="btn btn-primary"  style="border:1px navy solid;background-color:navy;font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:14pt;color:##ffffff;font-weight:bold"  id="Contact_Us" value="Schedule Appointment">
					</div>
				</div>
			</fieldset>
		</form>


	</cffunction>
	
	
	
	<cffunction name="form_submit_sall_2" description="action page for form" output="Yes" access="public">
 	
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Aspen10">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.MyID" default="">
		<cfparam name="form.Age" default="">
		<cfparam name="form.Income" default="">
		<cfparam name="form.Employment" default="">
		<cfparam name="form.Appointment_time" default="">
		<cfparam name="form.Appointment_date" default="">
		<cfparam name="form.Phone_1" default="">


		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<!--- <cfinvoke component="/cfcs/aspen10/forms/form_save" method="check_submit"></cfinvoke> --->

		<!---Server Side Form Validation--->

		<!--- set mail parameters --->
		<cfset variables.subject="Thank you for submitting your information to Autoproval!">
		<cfset variables.from="info@autoproval.com">
	
		<cfset variables.error_message="">
		<cfset variables.error=0>
		
				
			<cfif ( #mid(form.appointment_date,3,1)# NEQ "/" or  #mid(form.appointment_date,6,1)# NEQ "/" ) OR #len(form.appointment_date)# LT 10 >
				<cfset variables.error_message = "Invalid Date Format. MUST be mm/dd/yyyy. Please re-enter." >
			</cfif>
		 	
			<!--- <cfif #arguments.Dealer_ID# eq 495 >
				<cfif ( #dateformat(now(),"mm/dd/yyyy")# LTE #form.appointment_date# >
					<cfset variables.error_message = "MUST be a Future Date. Please re-enter." >
				</cfif>
			</cfif> --->
		 
		<cfif listlen(variables.error_message) gt 0>
			<cfset url.error_message=variables.error_message>
		<cfelse> 
			<cfset variables.MyID=#form.MyID#>
			<cfif variables.error eq 0 >
				 <cfoutput>
				
					 <cfquery datasource="SALL" name="Get_SALL_Dealer">
						SELECT		Leads.Lead_ID,
									Leads.PIN,
									Leads.first_name,
									Leads.last_name,
									Leads.phone,
									Leads.email,
									Dealers.Dealer_Name,
									Dealers.dealer_id,
									Dealers.Dealer_Address_1,
									Dealers.Dealer_Address_2,
									Dealers.Dealer_City,
									Dealers.Dealer_State,
									Dealers.Dealer_Zip, 
									Dealers.dealer_Phone
						FROM		Leads 
						INNER JOIN	Dealers
						ON			Leads.dealer_id = Dealers.dealer_id
						WHERE		Leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>  
		
	
			<cfquery datasource="SALL" name="Check_Pin">
				SELECT 	 ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                      nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, v_year, v_make, v_model, authorization_nbr
				FROM         Customer_PURLs
				WHERE	PURL=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
				AND		Active=1
			</cfquery>

				<cfquery datasource="SALL" name="Get_S_Dealer">
					SELECT	ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, 
                      		Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active, clicks,email_type, Dealer_Report_Name
					FROM    Dealers	
					WHERE	Dealer_id= '#Check_Pin.Dealer_ID#'
				</cfquery>
				
				<cfif #Get_S_Dealer.Dealer_Email# NEQ "" >
					<cfset s_dealer_email = "#Get_S_Dealer.Dealer_Email#" >
					<cfset s_email_type = #Get_S_Dealer.email_type# >
				<cfelse>		
					<cfset s_dealer_email = "bob@worlddealer.net" >
					<cfset s_email_type = 0 >
				</cfif>
								
				<cfset variables.recipient_list="#s_dealer_email#">
				</cfoutput>  
			 		<cfset url.dealercode = #Get_S_Dealer.Dealer_ID# >
		
			 		<cfset url.dealer_id = #Get_SALL_Dealer.Dealer_ID# >
			 		<cfset url.dealercode_id = #Get_SALL_Dealer.Dealer_ID# >
			 		<cfset url.MyID = #variables.MyID# >
		
					<cfquery datasource="ultra10" name="Get_program_Details">
						SELECT		Dealer_ID,
									dealer_directory
						FROM		Dealers
						WHERE		Dealer_id = 331
						ORDER BY 	Dealer_Name
					</cfquery>
		
					<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  

					<cfif	len(trim(form.myid)) neq 0 and form.myid neq "0"
							and len(trim(form.age)) neq 0
							and len(trim(form.employment)) neq 0
							and len(trim(form.income)) neq 0
							and len(trim(form.Appointment_date)) neq 0
							and len(trim(form.Appointment_time)) neq 0>
							 
							<cfquery datasource="SALL" name="Insert_Trade">
								UPDATE	Leads
								SET		Age=<cfqueryparam value="#form.age#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										Employment=<cfqueryparam value="#form.employment#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										Income=<cfqueryparam value="#form.income#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										td_App_Date=<cfqueryparam value="#form.appointment_date#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										TD_App_Time=<cfqueryparam value="#form.appointment_time#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
								WHERE	MyID=<cfqueryparam value="#form.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
							</cfquery>  

	<!--- Customer Email --->							
							<cfmail  to="#Get_SALL_Dealer.email#" from="#variables.from#" subject="#variables.subject#"   type="HTML">
								<table width="70%"  cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="2"><img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Logo.png">&nbsp;<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png"> </td>
										</tr> 
										<tr><td>&nbsp;</td></tr>
										<tr><td>&nbsp;</td></tr>
										<tr>
											<td colspan="2" style="padding:30px 10px 30px 10px">
												Thank you for requesting a meeting at <strong>#Get_SALL_Dealer.Dealer_Name#</strong>! We will be contacting you shortly to confirm your appointment time. However if you would like to contact us immediately, we have provided an email contact link and phone number with this message. Also do not hesitate to search our inventory by clicking on the convenient link.<br/><br/>
												
											</td>
										</tr>
										<tr>
											<td  valign="top">
													 <div style="font:bold 20px arial">#Get_SALL_Dealer.dealer_Name#</div>  
														 #Get_SALL_Dealer.dealer_Address_1#<br/>
														<cfif #Get_SALL_Dealer.dealer_City# NEQ "" >
															#Get_SALL_Dealer.dealer_City#, #Get_SALL_Dealer.dealer_State# #numberformat(Get_SALL_Dealer.dealer_Zip,"00000")#<br/>
														</cfif>	
														<!--- <cfif #Check_Pin.pin_dlr_id# NEQ 524 >
														<div style="font:bold 20px arial">PHONE : #Get_phones.Area_Code#.#Get_phones.Prefix#.#Get_phones.Line_Number#<cfif #Check_Pin.pin_dlr_id# EQ 500> x111</cfif></div>   
														</cfif> --->
											</td>
											<td style="padding:0px 10px 10px 10px;width:50%" valign="top"> 
												<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
												<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div> 
											</td>
										</tr>
									</table>
							</cfmail>
				
	<!--- END Customer Email --->		
	<cfset variables.recipient_list="#s_dealer_email#">

	<!--- Leads Emails --->		

		<cfset variables.lead_subject="Appointment Request from Autoproval.com #Get_SALL_Dealer.Dealer_Name#">
		

<cfif #s_email_type# EQ 0 >
		<!---Generate TEXT Email--->
			<cfmail to="#variables.recipient_list#" from="#variables.from#" subject="#variables.lead_subject#"   type="HTML">			
				<table cellpadding="0" width="70%" cellspacing="0">
					<tr><td colspan="2">&nbsp;</td></tr> 
					<tr><td colspan="2">&nbsp;</td></tr> 
					<tr>
						<td align="left" > 
						Name: #Get_SALL_Dealer.First_Name# #Get_SALL_Dealer.Last_Name#<br>
						Phone: #Get_SALL_Dealer.Phone#<br>
						Email: #Get_SALL_Dealer.Email#<br>
						Age: #form.age#<br>
						Employment: #form.employment#<br>
						Income: #form.income#<br>
						Appointment: #form.Appointment_date# #form.appointment_time#<br>
						PIN: #Get_SALL_Dealer.Pin#<br>
						Dealer: #Get_SALL_Dealer.Dealer_Name#<br>
						Lead ID: #Get_SALL_Dealer.Lead_ID#<br>
						 </td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					
				</table>  
			</cfmail>
		<!---Generate ADF Email--->
 <cfelse>

						<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
							<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
							<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
							<cfinvokeargument name="zip" value=""/>
							<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
							<cfinvokeargument name="Age" value="#form.Age#"/>
							<cfinvokeargument name="Employment" value="#form.Employment#"/>
							<cfinvokeargument name="Income" value="#form.Income#"/>
							<cfinvokeargument name="Appointment" value="#form.Appointment_date#"/>
							<cfinvokeargument name="Appointment_time" value="#form.Appointment_time#"/>
							<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
							<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="interest" value=""/>
							<cfinvokeargument name="v_vin" value=""/>
							<cfinvokeargument name="v_year" value=""/>
							<cfinvokeargument name="v_make" value=""/>
							<cfinvokeargument name="v_model" value=""/>
							<cfinvokeargument name="v_mileage" value=""/>
							<cfinvokeargument name="v_comments" value=""/>
						</cfinvoke> 
						
						<cfset variables.this_dealer_id=form.delivery_dealer_id>
						
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
						<!---Send ADF Emails--->
							<cfmail to="bob@worlddealer.net" from="#variables.From#" subject="#variables.lead_subject#"  >
								#variables.adf_email#
						  </cfmail>  
  
</cfif>					
<!--- END Leads Emails --->		
				</cfif>
			</cfif>	<!--- end of variables.error if --->
		</cfif>
	</cffunction>

	
	
</cfcomponent>