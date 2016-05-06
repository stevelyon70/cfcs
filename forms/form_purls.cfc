
	<cffunction name="purls_default" description="display default contact us form" output="Yes" access="public">
		
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="passed_purl" default="">
		<cfargument name="pass_ems" default="0">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#/forms/purls_action.cfm"> 

		<cfset var Get_Form_Locations="">
		<cfset multi_purl = 0 >
		
		<cfquery name="load_cust_info" datasource="PURLs">
			SELECT  ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                    nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, v_year, v_make, v_model, authorization_nbr
			FROM    Customer_PURLs
			<cfif #arguments.passed_purl# EQ "" >
				WHERE 	ID = #url.customer_purl_id# 
			<cfelse>	
				WHERE 	PURL = '#arguments.passed_purl#' 
			</cfif>
		</cfquery>	
		<cfif #load_cust_info.recordcount# GT 1 >
			<cfset multi_purl = 1 >
			<cfset url.customer_purl_id = #load_cust_info.ID# >
		</cfif>
		<cfquery name="get_pident" datasource="PURLs">SELECT ID, Campaign_ID, PURL_Identifier FROM dealers WHERE	dealer_ID = #load_cust_info.Dealer_ID# </cfquery>

		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" id="User_pin" name="User_pin" value="#load_cust_info.PURL#">
				<input type="hidden" id="customer_purl_id" name="customer_purl_id" value="#url.customer_purl_id#">
				<input type="hidden" id="Address" name="Address" value="#load_cust_info.Address_1#">
				<input type="hidden" id="City" name="City" value="#load_cust_info.City#">
				<input type="hidden" id="State" name="State" value="#load_cust_info.State#">
				<input type="hidden" id="Zip" name="Zip" value="#load_cust_info.Zip#">
				<input type="hidden" id="purl_type" name="purl_type" value="#load_cust_info.purl_type#">
				<input type="hidden" id="lead_source" name="lead_source" value="#arguments.pass_ems#">						<!--- 0 = WEBSITE  1 = Email  2 = IVR 03-22-2016 --->
				<input type="hidden" id="multi_purl" name="multi_purl" value="#multi_purl#">

				<input type="hidden" id="purl_identifier" name="purl_identifier" value="#get_pident.PURL_Identifier#">								<!--- req for EMS entry 03-22-2016  --->
				<input type="hidden" id="Destination_URL" name="Destination_URL" value="#load_cust_info.Destination_URL#">								<!--- req for EMS entry 03-22-2016  --->
				<input type="hidden" id="Campaign_ID" name="Campaign_ID" value="#load_cust_info.Campaign_ID#">										<!--- req for EMS entry 03-22-2016  --->
				<input type="hidden" id="first_visit_dt" name="first_visit_dt" value="#dateformat(load_cust_info.first_visit_dt,"mm/dd/yyyy")#">	<!--- req for EMS entry 03-22-2016  --->
				<input type="hidden" id="start_dt" name="start_dt" value="#dateformat(load_cust_info.start_dt,"mm/dd/yyyy")#">						<!--- req for EMS entry 03-22-2016  --->
				<input type="hidden" id="expires_dt" name="expires_dt" value="#dateformat(load_cust_info.expires_dt,"mm/dd/yyyy")#">				<!--- req for EMS entry 03-22-2016  --->
				<input type="hidden" id="p_dlr" name="p_dlr" value="#load_cust_info.dealer_id#">											<!--- req for EMS entry 03-22-2016  --->
				 
				
				<cfif #multi_purl# EQ 1 >
					<div class="row" ><div class="col-md-12 col-md-offset-1" align="left"><div class="body-text-bold" >Please verify your First and Last Name</div></div></div>
					<div class="row" >&nbsp;</div>
				<cfelse>
					<cfif IsDefined("arguments.pass_ems") and #arguments.pass_ems# EQ 1 >
						<div class="row" ><div class="col-md-12 col-md-offset-1" align="left"><div class="body-text-bold" >Please enter your contact Information</div></div></div>
						<cfset load_cust_info.Firstname = "" ><cfset load_cust_info.Lastname = "" ><cfset load_cust_info.Email = "" ><cfset load_cust_info.Phone_1 = "" >
						<div class="row" >&nbsp;</div>
					<cfelse>
						<div class="row" >&nbsp;</div>
					</cfif>	
				</cfif>
				 
				<div class="form-group">
					<div class="col-md-12 col-md-offset-1" align="left">
						<div class="body-text-bold">First Name</div>
						<input name="First_Name" class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px" value="#load_cust_info.Firstname#" id="First_Name" type="text" size="40"  maxlength="50" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12 col-md-offset-1" align="left">
						<div  class="body-text-bold">Last Name</div>
						<input name="Last_Name"  class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px"  value="#load_cust_info.Lastname#" id="Last_Name" type="text" size="40"  maxlength="50"  required>
					</div>
				</div>
				
				<cfif  #url.dealer_id# eq 372 >	
					<input type="hidden" id="purl_dlr" name="purl_dlr" value="368">	
				</cfif>	
				<cfif  #url.dealer_id# eq 378 >	
					<input type="hidden" id="purl_dlr" name="purl_dlr" value="378">	
				</cfif>	
				<cfif  #url.dealer_id# eq 368 >	
					<input type="hidden" id="purl_dlr" name="purl_dlr" value="368">	
				</cfif>	
				<cfif  #url.dealer_id# eq 368 or #url.dealer_id# eq 378 >		
					 <div class="form-group">
						<div class="col-md-12 col-md-offset-1" align="left">
							<div  class="body-text-bold">Vehicle Year/Make/Model</div>
							<input name="comment" class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px"  value="#load_cust_info.v_year# #load_cust_info.v_make# #load_cust_info.v_model# "  id="comment" type="text" size="40"  maxlength="100"  >
						</div>
					</div> 
				</cfif>	
				<div class="form-group">
					<div class="col-md-12 col-md-offset-1" align="left">
						<div  class="body-text-bold">Email</div>
						<cfif #multi_purl# EQ 0 >
							<cfif #load_cust_info.Email# NEQ "email">
								<input name="Email" class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px"  value="#load_cust_info.Email#"  id="Email" type="email" size="40"  maxlength="100"   required >
							<cfelse>								
								<input name="Email"  class="input-xlarge"  style="border:1px solid ##EBEBEB;min-height:25px"  value="" id="Email" type="text" size="40" placeholder="Valid Email Address" maxlength="10"   required >
							</cfif>
						<cfelse>
							<input name="Email" class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px"  value=""  id="Email" type="email" size="40"  maxlength="100"   required >
						</cfif>
					</div>
				</div>
				<cfif #url.dealer_id# eq 337 >
					<input type="hidden" id="purl_dlr" name="purl_dlr" value="337">
					<input name="authorization_nbr" value="#load_cust_info.PURL#"  id="authorization_nbr" type="hidden" >	
					<!--- <div class="form-group">
						<div class="col-md-12 col-md-offset-1" align="left">
							<div  class="body-text-bold">Authorization Number</div>
							<cfif #multi_purl# EQ 0 >
								<input name="authorization_nbr" class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px"  value="#load_cust_info.PURL#"  id="authorization_nbr" type="text" size="40"  maxlength="100"   required >
							<cfelse>
								<input name="authorization_nbr" class="input-xlarge" style="border:1px solid ##EBEBEB;min-height:25px"  value="#load_cust_info.PURL#"  id="authorization_nbr" type="text" size="40"  maxlength="100"   required >
							</cfif>
						</div>
					</div> --->
				<cfelseif  #url.dealer_id# eq 306 >
					<input type="hidden" id="purl_dlr" name="purl_dlr" value="306">	
				</cfif>
				<div class="form-group">
					<div class="col-md-12 col-md-offset-1" align="left">
						<div  class="body-text-bold">Phone</div>
						<cfif #multi_purl# EQ 0  >
							<cfif #load_cust_info.Phone# NEQ "phone">
								<input name="Phone_1"  class="input-xlarge"  style="border:1px solid ##EBEBEB;min-height:25px"  value="#load_cust_info.Phone#" id="Phone_1" type="text" size="40" placeholder="Numbers Only-no hyphens or parentheses" maxlength="10"   required >
							<cfelse>								
								<input name="Phone_1"  class="input-xlarge"  style="border:1px solid ##EBEBEB;min-height:25px"  value="" id="Phone_1" type="text" size="40" placeholder="Numbers Only-no hyphens or parentheses" maxlength="10"   required >
							</cfif>
						<cfelse>
							<input name="Phone_1"  class="input-xlarge"  style="border:1px solid ##EBEBEB;min-height:25px"  value="" id="Phone_1" type="text" size="40" placeholder="Numbers Only-no hyphens or parentheses" maxlength="10"   required >
						</cfif>	
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12 col-md-offset-1"  align="left">
						<div  class="body-text-bold"><input name="Newsletter_Opt_In"   style="border:1px solid ##EBEBEB;min-height:25px"  value="1" id="Newsletter_Opt_In" type="checkbox" >&nbsp;&nbsp;&nbsp;<span style="valign:TOP">Sign me up for the monthly newsletter!</span>
						</div>
					</div>
				</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-12 col-md-offset-1" align="left">
					<cfif #url.dealer_id# Neq 337 AND  #url.dealer_id# Neq 368 AND  #url.dealer_id# Neq 378 >
						<input type="submit" class="btn btn-primary"  style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##1E4281!important;font-weight:normal!important"  id="Continue" value="Continue">
					<cfelseif #url.dealer_id# eq 368 >
						<input type="submit" class="btn btn-primary"  style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##3c8443!important;font-weight:normal!important"  id="Continue" value="Continue">
					<cfelseif #url.dealer_id# eq 378 >
						<input type="submit" class="btn btn-primary"  style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##3c8443!important;font-weight:normal!important"  id="Continue" value="Continue">
					<cfelse>
						<input type="submit" class="btn btn-primary"  style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;font-weight:normal!important"  id="Continue" value="Continue">
					</cfif>	
					</div>
				</div>
			</fieldset>
		</form>


	</cffunction>

	
	
	<cffunction name="form_submit_purls" description="action page for form" output="Yes" access="public">
 		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="PURLS">
		
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
		<cfparam name="form.Newsletter_Opt_In" default="0">
		
		<cfparam name="form.purl_type" default="0">
		<cfparam name="form.lead_source" default="0">
		<cfparam name="form.purl_identifier" default="999">

		<cfparam name="form.voi_vin" default="">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.voi_stock" default="">
		<cfparam name="form.voi_year" default="0">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">
		<cfparam name="form.sales_rep" default="">
		<cfparam name="form.comment" default="">
 
		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<!--- <cfinvoke component="/cfcs/aspen10/forms/form_save" method="check_submit"></cfinvoke> --->

		<!---Server Side Form Validation--->

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
<!--- If Email Submission, build pURL --->
		<!---  <cfif #form.lead_source# EQ 1 >
			<cfset new_purl = "#form.purl_identifier##left(form.First_name,1)##form.Last_name#_e" >
			<cfset form.purl = "#new_purl#" >
			<cfset form.user_pin = "#new_purl#" >
			<cfquery NAME="InsertEpurl" datasource="PURLs">
				  INSERT into Customer_PURLs ( 	Campaign_ID, 
				  								Dealer_ID, 
												Firstname, 
												Lastname,  
												Address_1,  
												City,  
												State,  
												Zip,  
												<cfif IsDefined("form.v_year") >
													v_year,  
													v_make,  
													v_model, 
												</cfif>
												
												Email, 
												Phone, 
												PURL, 
												Destination_URL, 
												start_dt, 
												expires_dt, 
												nbr_visits,
												purl_type, 
												active )
				  					VALUES 	( 	#Form.Campaign_ID#,
												#Form.p_dlr#,
												'#Form.first_name#',
												'#Form.Last_name#',
												'#Form.Address#',
												'#Form.City#',
												'#Form.State#',
												'#Form.Zip#',
												<cfif IsDefined("form.v_year") >
													'#Form.v_year#',
													'#Form.v_make#',
													'#Form.v_model#',
												</cfif>
												
												'#Form.Email#',
												'#Form.Phone_1#',
												'#Form.PURL#',
												'#Form.Destination_URL#', 
												#CreateODBCDate(Form.start_dt)#, #CreateODBCDate(Form.expires_dt)#,1 ,0, 1  )
				</cfquery>

		</cfif>    --->
		
<!--- Create "MyID"  --->
			<cfset variables.MyID=replace(createUUID(),'-','','all')>
	
			<cfset nbr_of_visits = 0 >
			<cfquery datasource="PURLS" name="Check_Pin">
				SELECT 	 ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                      nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, v_year, v_make, v_model, authorization_nbr
				FROM         Customer_PURLs
				WHERE	PURL=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
				AND		Active=1
				<cfif #form.multi_purl# neq 0 and email NEQ "" >
					AND	Email = '#form.email#' OR phone = '#form.phone_1#'
				</cfif> 
				<!--- AND		expires_dt >= '#dateformat(now(),"mm/dd/yyyy")#' --->
			</cfquery>
			
			<cfif #Check_Pin.v_year# EQ "" >
				<cfset form.v_year = 0 >
			<cfelse>
				<cfset form.v_year = #Check_Pin.v_year# >
			</cfif>
				
			<cfif #Check_Pin.recordcount# eq 0>
				
				<!---  <cfmail to="wdsupport@worlddealer.net" from="#variables.from#" subject="Invalid CCAPapproval.com Approval Code" bcc="bob@worlddealer.net"  type="HTML"> --->
				 <cfmail to="wdsupport@worlddealer.net" from="leads@worlddealer.net" subject="Invalid tradeoffer.org pURL"   type="HTML">	 
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
					If you indeed believe this is a valid attempt to use the system and a dealer doesn't have a pURL, please contact Aspen IMMEDIATELY with the dealer information.<br><br>
				
					<b>This could be a DUPLICATE pURL and the email address entered doesn't match anyone in the database.</b><br>
					This could be a typo on the user's part.<br>
					This could be somebody testing the system.<br>
					This could also be somebody messing with the system.<br>
					We need to rule out all possibilities.<br>

				</cfmail>
				<cfset url.error_message="Invalid Approval Code. Please try again.">
			<cfelse> 
				<!--- PIN is good, continue --->
				<cfoutput>
				
				<cfset url.purl = #form.user_pin#>
				<cfset url.customer_purl_id = #form.customer_purl_id# >
				<cfset nbr_of_visits = #Check_Pin.nbr_visits# >
				<cfquery datasource="PURLS" name="Get_S_Dealer">
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
				
				<cfif Check_Pin.Recordcount gt 0>
					<cfquery datasource="PURLS" name="Insert_LEAD">
						INSERT INTO	Leads
									(campaign_id,
									dealer_id,
									Date_Submitted,
									PIN,
									MyID,
									First_Name,
									Last_Name,
									PIN_First_Name,
									PIN_Last_Name,
									PIN_Email,
									PIN_Phone, 
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
									pin_type,
									lead_source,
									comment,
									Newsletter_Opt_In)
							VALUES
									(<cfqueryparam value="#Check_Pin.Campaign_id#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									<cfqueryparam value="#Check_Pin.Dealer_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									#CreateODBCDateTime(now())#,
									<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.firstname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.lastname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									 <cfqueryparam value="#Check_Pin.Email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#Check_Pin.Phone#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,  
									<cfqueryparam value="#form.address#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.city#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.state#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.zip#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#form.phone_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.v_year#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.v_make#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.v_model#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#Check_Pin.authorization_nbr#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.purl_type#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									<cfqueryparam value="#form.lead_source#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
									<cfqueryparam value="#form.comment#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#form.Newsletter_Opt_In#" cfsqltype="CF_SQL_INTEGER" maxlength="6"> )
				 	</cfquery>
 					<cfset variables.dlrcode = 	#Check_Pin.Dealer_ID#>
				<cfelse>
					<cfset variables.error=1>
				</cfif>
	
				<cfif variables.error eq 0 >
					
			
					<cfquery datasource="PURLS" name="Get_CCAP_Dealer">
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
									Leads.pin_type,
									Leads.lead_source,
									Leads.date_submitted,
									Dealers.ID,
									Dealers.Dealer_Name,
									Dealers.Dealer_contact,
									Dealers.dealer_id,
									Dealers.Dealer_Address_1,
									Dealers.Dealer_Address_2,
									Dealers.Dealer_City,
									Dealers.Dealer_State, 
									Dealers. Dealer_Zip, Dealers. Agency_Title, 
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
					<cfset provider_srce = #Get_CCAP_Dealer.Agency_title# > 
		
					<cfquery datasource="Ultra10" name="Get_program_Details">
						SELECT		Dealer_ID, 
									dealer_directory
						FROM		Dealers
						WHERE		Dealer_id = #form.purl_dlr#
						ORDER BY 	Dealer_Name
					</cfquery>
		
					<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  
			 		

					<!--- set mail parameters --->
					<!--- <cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net"> --->
					<cfif #form.purl_dlr# NEQ 337 >
						<cfset variables.subject="Congratulations on your Bonus Trade-In Offer from #Get_CCAP_Dealer.Dealer_Name#">
						<cfset variables.lead_subject="Bonus Trade-In Offer Claim from #Get_CCAP_Dealer.Dealer_Name#">
						
						<cfif #form.purl_dlr# NEQ 368 AND  #form.purl_dlr# NEQ 372  AND  #form.purl_dlr# NEQ 378 >
							<cfset variables.from="tradeoffer@tradeoffer.com">
						<cfelse>
							<cfif #form.purl_dlr# EQ 368 >
								<cfif #url.dealercode# EQ 140 >
									<cfset variables.from="mytradeinoffer@mytradeinoffer.com">
								<cfelse>
									<cfset variables.from="tradeoffer@tradeoffer.com">
								</cfif>
							</cfif>
							<cfif #form.purl_dlr# EQ 378 >
								<cfset variables.subject="Congratulations on your Loyalty Bonus Package from #Get_CCAP_Dealer.Dealer_Name#">
								<cfset variables.lead_subject="Loyalty Bonus Package Claim from #Get_CCAP_Dealer.Dealer_Name#">
								<cfset variables.from="myownerloyaltyevent@myownerloyaltyevent.com">
							</cfif>	
							<cfif #form.purl_dlr# EQ 372 >
								<cfset variables.from="myleaseendoffer@myleaseendoffer.com">
							</cfif>	
						</cfif>
					<cfelse>
						<cfset variables.subject="Congratulations on your Lease-End Offer from #Get_CCAP_Dealer.Dealer_Name#">
						<cfset variables.lead_subject="Lease-End Offer Claim from #Get_CCAP_Dealer.Dealer_Name#">
						<cfset variables.from="leaseendoptions@leaseendoptions.com">	
					</cfif>


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
							<cfif  #url.dealercode# EQ 148 >
							 	<cfinvokeargument name="comments" value="DATABASE - #Get_CCAP_Dealer.PIN#"/> 
							</cfif>	
							<cfif  #url.dealercode# EQ 149 >
							 	<cfinvokeargument name="comments" value="CONQUEST - #Get_CCAP_Dealer.PIN#"/> 
							</cfif>	
							 
							<cfinvokeargument name="Dealer" value="#Get_CCAP_Dealer.Dealer_Name#"/>
							<cfinvokeargument name="Newsletter" value="#Get_CCAP_Dealer.Newsletter_Opt_In#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="interest" value="Trade-In"/>
							<cfinvokeargument name="v_vin" value=""/>
							<cfinvokeargument name="v_stock" value=""/>
							<cfinvokeargument name="new_used" value=""/>
							<cfinvokeargument name="v_year" value="#Get_CCAP_Dealer.trade_year#"/>
							<cfinvokeargument name="v_make" value="#Get_CCAP_Dealer.trade_make#"/>
							<cfinvokeargument name="v_model" value="#Get_CCAP_Dealer.trade_model#"/>
							<cfinvokeargument name="v_trim" value=""/>
							<cfinvokeargument name="v_price" value=""/>
							<cfif #form.multi_purl# EQ 0 >
								<cfinvokeargument name="v_comments" value="#form.comment#"/>
							<cfelse>
								<cfinvokeargument name="v_comments" value="MULTIPLES OF THIS PURL ON FILE  #form.comment#"/>	
							</cfif>
						</cfinvoke>
		<!--- 03-17-2016 --->				
						<cfinvoke component="/cfcs/emails/adf_gen" method="provider_purl" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="vanity_Source" value="#provider_srce# Mailer"/>
						</cfinvoke>
						
						<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke> 
						 
				<cfif #left(Get_CCAP_Dealer.pin,2)# NEQ 35 >
						 <cfmail to="#variables.recipient_list#" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net,bob@worlddealer.net"  >  
							#variables.adf_email#
					  	</cfmail>   
				<cfelse>		
						 <cfmail to="bob@worlddealer.net" from="#variables.From#" subject="#variables.lead_subject#"  >  
							#variables.adf_email#
					  	</cfmail>   
				</cfif>		  		
						
						<!--- <cfmail to="bob@worlddealer.net" from="#variables.from#" subject="#variables.lead_subject#"  type="HTML">			
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
										Lead Source: #Get_CCAP_Dealer.lead_source#<br>
										PURL: #Get_CCAP_Dealer.Pin#<br><br>
										Dealer: #Get_CCAP_Dealer.Dealer_Name#<br>
										Contact: #Get_CCAP_Dealer.Dealer_Contact#<br>
										Provider: #provider_srce# 
										<cfif #form.multi_purl# EQ 1 >
										<br><br>Comment: ** MULTIPLES OF THIS PURL ON FILE **  #form.comment#
										<cfelse>
										<br><br>Comment: #form.comment#
										</cfif>
									 </td>
								</tr>
								<tr><td>&nbsp;</td></tr>
							</table>  
						</cfmail>   --->
						
<!--- SPECIAL 03-17-2016 --->						 
<cfif #url.dealercode# EQ 132 or #url.dealercode# EQ 134 >
	<cflocation url="#Check_Pin.Destination_URL#" >
</cfif> 
						
						
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
										Lead Source: #Get_CCAP_Dealer.lead_source#<br>
										PURL: #Get_CCAP_Dealer.Pin#<br><br>
										Dealer: #Get_CCAP_Dealer.Dealer_Name#<br>
										Contact: #Get_CCAP_Dealer.Dealer_Contact#<br>
										Provider: #provider_srce# 
										<cfif #form.multi_purl# EQ 1 >
										<br><br>Comment: ** MULTIPLES OF THIS PURL ON FILE **  #form.comment#
										<cfelse>
										<br><br>Comment: #form.comment#
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
	
