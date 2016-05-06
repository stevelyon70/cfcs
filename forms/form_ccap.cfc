<!--- form_ccap.cfm --->


<cfcomponent>

	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">

	</cffunction>
	
	<cffunction name="tap_default" description="display default contact us form" output="Yes" access="public">

	</cffunction>


	<cffunction name="ccap_default" description="display default contact us form" output="Yes" access="public">
		
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/ccap_action.cfm"> 

		<cfset var Get_Form_Locations="">
		

		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<div class="col-md-12" align="center">
					<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:16pt;color:##0079c2;font-weight:bold">Please enter your Approval Code below to confirm your identity.</span>
					</div>
					<div class="col-md-3" align="center"></div>
					<div class="col-md-6" align="center">
						<input name="user_pin"  id="user_pin" class="form-control input-lg"  style="font-size:20pt;border:1px solid ##0079c2;min-height:45px"  type="text" size="70"  maxlength="11" placeholder="" required> 
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="row" >&nbsp;</div>
				<div class="row" >&nbsp;</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">First Name:*</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="First_Name" class="form-control input-sm" style="border:1px solid ##0079c2;min-height:25px"  id="First_Name" type="text" size="40"  maxlength="50" required>
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">Last Name:*</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Last_Name"  class="form-control input-sm" style="border:1px solid ##0079c2;min-height:25px"  id="Last_Name" type="text" size="40"  maxlength="50"  required>
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">Email:*</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Email" class="form-control input-sm" style="border:1px solid ##0079c2;min-height:25px"   id="Email" type="email" size="40"  maxlength="100"   required >
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">Phone:*</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Phone_1"  class="form-control input-sm"  style="border:1px solid ##0079c2;min-height:25px"  id="Phone_1" type="text" size="40"  maxlength="10"   required >
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="row" >&nbsp;</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-12" align="center">
						<input type="submit" class="btn btn-primary"  style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:20pt;color:##ffffff;font-weight:bold;width:170px;height:55px"  id="Contact_Us" value="Submit">
					</div>
				</div>
			</fieldset>
		</form>


	</cffunction>

	<cffunction name="ccap_page_2" description="display default contact us form" output="Yes" access="public">
	
 
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/ccap_action_2.cfm"> 

		<cfset var Get_Form_Locations="">
		
		
		 <cfquery datasource="CCAP10" name="Get_Lead_Detl">
			SELECT		CCAP_Leads.ccap_Lead_ID,
						CCAP_Leads.PIN,
						CCAP_Leads.first_name,
						CCAP_Leads.last_name,
						CCAP_Leads.phone,
						CCAP_Leads.email
			FROM		CCAP_Leads 
			WHERE		CCAP_Leads.MyID=<cfqueryparam value="#arguments.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>  
		<cfset variables.lead_phone = #Get_Lead_Detl.phone# >
			
		<form id="tap_drive" class="form-horizontal" name="ccap_2" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" id="user_pin" name="user_pin" value="#Get_Lead_Detl.PIN#">
				<input type="hidden" id="MyID" name="MyID" value="#arguments.MyID#">
				<div class="row" >&nbsp;</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Age:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class="form-control input-sm" name="age" id="age">
						<option value="">Select</option>
						<option value="18-25">18 - 25</option>
						<option value="26-40">26 - 40</option>
						<option value="41-55">41 - 55</option>
						<option value="56-64">56 - 64</option>
						<option value="65 or Older">65 or Older</option>
					</select>
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Income:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class="form-control input-sm" name="income" id="income">
						<option value="">Select</option>
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
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Employment:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class="form-control input-sm" name="Employment" id="Employment">
						<option value="">Select</option>
						<option value="0 - 6 Months">0 - 6 Months</option>
						<option value="6 Months - 2 Years">6 Months - 2 Years</option>
						<option value="2 Years - 5 Years">2 Years - 5 Years</option>
						<option value="5 Years - 10 Years">5 Years - 10 Years</option>
						<option value="10 Years or More">10 Years or More</option>
					</select>
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Phone Number:</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Phone_1"  class="form-control input-sm"  style="border:1px solid ##ffffff;min-height:25px" value="#variables.lead_phone#" id="Phone_1" type="text" size="40"  maxlength="10"   >
						<p class="help-block" style="color:##ffffff">Numbers Only - no hyphens or parentheses</p>
					</div>
					 
				</div>
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Appointment Date:</span> 
					</div>
					<div class="col-md-4" align="left">
						
					    <cfif #arguments.dealer_id# eq 495 >  
					 <div id="datetimepicker2" class="input-append date">
     
					<input name="Appointment_date"  class="form-control input-sm " data-format="MM/dd/yyyy"  style="border:1px solid ##ffffff;min-height:25px"  placeholder="mm/dd/yyyy" id="datetimepicker" type="text" size="30"  maxlength="10" > </input>
				      <span class="add-on">
				        <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
				      </span>
					</div>
 				<cfelse>  
						<input name="Appointment_date"  class="form-control input-sm"  style="border:1px solid ##ffffff;min-height:25px" placeholder="mm/dd/yyyy"  id="Appointment_date" type="text" size="30"  maxlength="10" required >
						<p class="help-block"><span style="color:##ffffff">Format: mm/dd/yyyy</span></p>					
						 </cfif>    
					</div>
					
				</div>
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Appointment Time:</span>
					</div>
					<div class="col-md-4" align="left">
					<select class="form-control input-sm" name="Appointment_time" id="Appointment_time">
						<option value="">Select a Time</option>
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
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##ffffff;font-weight:bold">Comments:</span>
					</div>
					<div class="col-md-4" align="left">
						<textarea class="form-control input-sm" name="Comments" id="Comments" placeholder="Comments" rows="4" size="1000" maxlength="1000" ></textarea>
					</div>
					 
				</div>
				<div class="row" >&nbsp;</div>
				<div class="row" >&nbsp;</div>
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-8" align="center">
						<input type="submit" class="btn btn-primary"  style="background-color:##000000;font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:20pt;color:##ffffff;font-weight:bold;width:170px;height:55px"  id="Contact_Us" value="Submit">
					</div>
				</div>
			</fieldset>
		</form>


	</cffunction>
	
	<cffunction name="show_offer" description="display trade-in form for featured offer" output="Yes" access="public">

	</cffunction>
	
	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

	</cffunction>


	
	<cffunction name="form_submit_ccap" description="action page for form" output="Yes" access="public">
 	
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="CCAP10">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">

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
		<!--- <cfinvoke component="/cfcs/aspen10/forms/form_save" method="check_submit"></cfinvoke> --->

		<!---Server Side Form Validation--->

		<!--- set mail parameters --->
		<!--- <cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net"> --->
		<cfset variables.subject="Congratulations on your pre-approval from Chrysler Capital!">
		<cfset variables.from="info@ccapapproval.com">
	
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
			<cfquery datasource="CCAP10" name="Check_Pin">
				SELECT 	ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                       	nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, APR
				FROM   	Customer_PURLs
				WHERE	PURL=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="11">
				AND		Active=1
				AND		expires_dt >= '#dateformat(now(),"mm/dd/yyyy")#'
			</cfquery>
				
			<cfif #Check_Pin.recordcount# eq 0>
				
				 <cfmail to="wdsupport@worlddealer.net" from="#variables.from#" subject="Invalid CCAPapproval.com Approval Code" bcc="bob@worlddealer.net"  type="HTML">	 
					An invalid Approval Code has been entered at CCAPapproval.com<br><br>
					PIN : #form.user_pin#<br><br>
					Firstname : #form.first_name#<br>
					Lastname : #form.last_name#<br>
					Email : #form.email#<br>
					Phone : #form.phone_1#<br><br>
					Date/Time: #dateformat(now(),"mm/dd/yyyy")#&nbsp;@&nbsp;#timeformat(now(),"hh:mm tt")#
					<br><br>
					This lead has not been delivered!<br>
					Please check the area code entered vs which dealers we have in the system and verify that all dealers in that area have valid Approval Codes.<br>
					If you indeed believe this is a valid attempt to use the system and a dealer doesn't have PIN, please contact Aspen IMMEDIATELY with the dealer information.<br><br>
				
					This could be a typo on the user's part.<br>
					This could be somebody testing the system.<br>
					This could also be somebody messing with the system.<br>
					We need to rule out all possibilities.<br>

				</cfmail>
				<cfset url.error_message="Invalid Approval Code. Please try again.">
			<cfelse> 
				<!--- PIN is good, continue --->
				<cfoutput>
				
				<cfset nbr_of_visits = #Check_Pin.nbr_visits# >
				<cfquery datasource="CCAP10" name="Get_S_Dealer">
					SELECT 	ID, Campaign_ID, Dealer_ID, Dealer_srt, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, 
		                    Dealer_Contact, Dealer_Email, Dealer_Email_type, Dealer_Website, inventory_link, finance_link, contact_link, Destination_URL, PURL_Identifier, Dealer_Image, 
        		            Comments, Links_in_Emails, Links_on_Screens, start_dt, expires_dt, active, clicks, Dealer_Report_Name
					FROM	dealers		
					WHERE	Dealer_id= '#Check_Pin.Dealer_ID#'
				</cfquery>
				
				<cfset email_links = #Get_S_Dealer.Links_in_Emails# >
				<cfset screen_links = #Get_S_Dealer.Links_on_Screens# >
				
				<cfif #Get_S_Dealer.Dealer_Email# NEQ "" >
					<cfset s_dealer_email = #Get_S_Dealer.Dealer_Email# >
					<cfset s_email_type = #Get_S_Dealer.Dealer_Email_type# >
				<cfelse>
					<cfset s_dealer_email = "bob@worlddealer.net" >
					<cfset s_email_type = 0 >
				</cfif>
				
				<!--- <cfif #Check_Pin.email# EQ "" >
					<cfif #Get_S_Dealer.Dealer_Email# NEQ "" >
						<cfset s_dealer_email = #Get_S_Dealer.Dealer_Email# >
						<cfset s_email_type = 0 >
					<cfelseif #Get_S_Dealer.Dealer_ADF_Email# NEQ "" >
						<cfset s_dealer_email = #Get_S_Dealer.Dealer_ADF_Email# >
						<cfset s_email_type = 1 >
					</cfif>
				<cfelse>
					<cfif #Get_S_Dealer.Dealer_Email# NEQ "" >
						<cfset s_dealer_email = #Get_S_Dealer.Dealer_Email# >
						<cfset s_email_type = 0 >
					<cfelseif #Get_S_Dealer.Dealer_ADF_Email# NEQ "" >
						<cfset s_dealer_email = #Get_S_Dealer.Dealer_ADF_Email# >
						<cfset s_email_type = 1 >
					</cfif>
					<cfset s_dealer_email = #Check_Pin.email# >	
					<cfset s_email_type = #Get_S_Dealer.email_type# >
				</cfif> --->
				
				</cfoutput>  
				
				<cfif Check_Pin.Recordcount gt 0>
					<cfquery datasource="CCAP10" name="Insert_LEAD">
						INSERT INTO	CCAP_Leads
									(Dealercode,
									PIN,
									MyID,
									First_Name,
									Last_Name,
									Email,
									Phone,
									PIN_First_Name,
									PIN_Last_Name,
									Address,
									City,
									State,
									Zip,
									Loan_Amount,
									Lead_Source,
									pin_type,
									lead_dlr_id)
							VALUES
									(<cfqueryparam value="#Check_Pin.Dealer_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
									<cfqueryparam value="#Check_Pin.PURL#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
									<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#form.phone_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
									<cfqueryparam value="#Check_Pin.FirstName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.LastName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.Address_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#Check_Pin.City#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.State#" cfsqltype="CF_SQL_VARCHAR" maxlength="2">,
									<cfqueryparam value="#left(Check_Pin.Zip,5)#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
									#Check_Pin.Max_Loan_Amount#,
									0,
									#Check_Pin.purl_type#,
									#Get_S_Dealer.ID# )
				 	</cfquery>
 					<cfset variables.dlrcode = 	#Check_Pin.Dealer_ID#>
				<cfelse>
					<cfset variables.error=1>
				</cfif>
	
				<cfif variables.error eq 0 >
					<!--- Update Visit Date on PIN record --->
					<cfset nbr_of_visits = #nbr_of_visits#+1 >
					<cfquery NAME="UpdVisit" datasource="CCAP10">
						UPDATE Customer_PURLs
						SET 	first_visit_dt=#CreateODBCDate(now())#,
								nbr_visits=#nbr_of_visits#
						WHERE 	ID	=	#Check_Pin.ID#
					</cfquery>
			
					<cfquery datasource="CCAP10" name="Get_CCAP_Dealer">
						SELECT		CCAP_Leads.ccap_Lead_ID,
									CCAP_Leads.PIN,
									CCAP_Leads.PIN_type,
									CCAP_Leads.first_name,
									CCAP_Leads.last_name,
									CCAP_Leads.phone,
									CCAP_Leads.email,
									CCAP_Leads.Loan_Amount,
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
						FROM		CCAP_Leads 
						INNER JOIN	Dealers
						ON			CCAP_Leads.lead_dlr_id = Dealers.ID
						WHERE		CCAP_Leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>  
		  
		  			<cfset bucks = 	"#NumberFormat(Get_CCAP_Dealer.Loan_Amount, "$" )#" >
		  			<cfif #Get_CCAP_Dealer.pin_type# EQ 1 >
		  				<cfset bucks = 	"$XX,XXX" >
					</cfif>
		  
			 		<cfset url.dealercode = #Get_S_Dealer.Dealer_ID# >
		
			 		<cfset url.dealer_id = #Get_CCAP_Dealer.ID# >
			 		<cfset url.dealercode_id = #Get_CCAP_Dealer.Dealer_ID# >
			 		<cfset url.MyID = #variables.MyID# >
		
					<cfquery datasource="Ultra10" name="Get_program_Details">
						SELECT		Dealer_ID,
									dealer_directory
						FROM		Dealers
						WHERE		Dealer_id = 285
						ORDER BY 	Dealer_Name
					</cfquery>
		
					<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  

					<cfset variables.lead_subject="Approval Code Submission from CCAPapproval.com #Get_CCAP_Dealer.Dealer_Name#">

				<!--- Customer Email --->		
				<!--- 	<cfmail to="#form.email#" from="#variables.from#" subject="#variables.subject#" bcc="kelly@worlddealer.net"  type="HTML">	 --->		
					<cfmail to="#form.email#" from="#variables.from#" subject="#variables.subject#"   type="HTML">			
						<table cellpadding="0" width="70%" cellspacing="0">
							<tr>
								<td colspan="2" align="left" ><img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/CC_Logo_Positive_sm.jpg"></td>
							</tr> 
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td colspan="2" >  
									<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##000000;font-weight:bold">Congratulations, #Get_CCAP_Dealer.first_name# #Get_CCAP_Dealer.last_name#!</span> <span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##000000;font-weight:normal">You have been pre-approved for financing for the purchase of an automobile at <b>#Get_CCAP_Dealer.Dealer_Name#</b> through <b>Chrysler Capital</b> for up to <b>#bucks#</b>.</span><br/>
								 </td>
							</tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td  valign="top"> 
									<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/ccap_redir.cfm?rmyID=#variables.MyID#" target="_blank">Click here to schedule your appointment</a></div>
								</td>
							</tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td valign="top">
									 <div style="font:bold 20px arial">Authorized Dealership</div>  
									 <div style="font:bold 18px arial">#Get_CCAP_Dealer.Dealer_Name#</div>  
										 #Get_CCAP_Dealer.Dealer_Address_1#<br/>
										<cfif #Get_CCAP_Dealer.Dealer_City# NEQ "" >
											#Get_CCAP_Dealer.Dealer_City#, #Get_CCAP_Dealer.Dealer_State# #Get_CCAP_Dealer.Dealer_Zip#<br/>
										</cfif>
										<cfif #Get_CCAP_Dealer.Dealer_contact# NEQ "" >
											#Get_CCAP_Dealer.Dealer_contact#<br/>
										</cfif>
										<div style="font:bold 20px arial">PHONE : #Get_CCAP_Dealer.Dealer_Phone#</div> 
								</td>
							</tr>
							<cfif #email_links# EQ 1 >
								<tr>
									<td  valign="top"> 
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/ccap_click.cfm?MyID=#variables.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/ccap_click.cfm?MyID=#variables.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div> 
									</td>
								</tr>
							</cfif>
						</table>  
					</cfmail>
				<!--- END Customer Email --->

					<cfset variables.recipient_list="#s_dealer_email#">

				<!--- Leads Emails --->			
					<cfif #s_email_type# EQ 1 >
						<!---Generate ADF Email--->
						 <cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_CCAP_Dealer.ccap_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							<cfinvokeargument name="first_name" value="#Get_CCAP_Dealer.First_Name#"/>
							<cfinvokeargument name="last_name" value="#Get_CCAP_Dealer.Last_Name#"/>
							<cfinvokeargument name="email" value="#Get_CCAP_Dealer.Email#"/>
							<cfinvokeargument name="zip" value=""/>
							<cfinvokeargument name="phone_1" value="#Get_CCAP_Dealer.Phone#"/>
							<cfinvokeargument name="PIN" value="#Get_CCAP_Dealer.Pin#"/>
							<cfinvokeargument name="Dealer" value="#Get_CCAP_Dealer.Display_Name#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!--- <cfmail to="#variables.recipient_list#" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  > --->
						<cfmail to="bob@worlddealer.net" from="#variables.From#" subject="#variables.lead_subject#"   >
							#variables.adf_email#
					  	</cfmail>    
					<cfelse>
						<!---Generate TEXT Email--->
						<!--- <cfmail to="#variables.recipient_list#" from="#variables.from#" subject="#variables.lead_subject#" bcc="kelly@worlddealer.net,wdsupport@worlddealer.net"  type="HTML"> --->		
						<cfmail to="bob@worlddealer.net" from="#variables.from#" subject="#variables.lead_subject#"  bcc="kelly@worlddealer.net"   type="HTML">			
							<table cellpadding="0" width="70%" cellspacing="0">
								<tr><td colspan="2">&nbsp;</td></tr> 
								<tr><td colspan="2">&nbsp;</td></tr> 
								<tr>
									<td align="left" > 
										Name: #form.First_Name# #form.Last_Name#<br>
										Phone: #form.Phone_1#<br>
										Email: #form.Email#<br>
										Loan Amount: #bucks#<br><br>
										PIN: #Get_CCAP_Dealer.Pin#<br>
										Dealer: #Get_CCAP_Dealer.Dealer_Name#<br>
										Contact: #Get_CCAP_Dealer.Dealer_Contact#<br>
										Lead ID: #Get_CCAP_Dealer.ccap_Lead_ID# 
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
	
	
	<cffunction name="form_submit_ccap_2" description="action page for form" output="Yes" access="public">
 	
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="CCAP10">
		
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
		<cfparam name="form.user_pin" default="">
		<cfparam name="form.comments" default="">


		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<!--- <cfinvoke component="/cfcs/aspen10/forms/form_save" method="check_submit"></cfinvoke> --->

		<!--- set mail parameters --->
		<cfset variables.subject="Thank you for scheduling an appointment with your authorized dealer.">
		<cfset variables.from="info@ccapapproval.com">
	
		<cfset variables.error_message="">
		<cfset variables.error=0>
		
				
		<cfif ( #mid(form.appointment_date,3,1)# NEQ "/" or  #mid(form.appointment_date,6,1)# NEQ "/" ) OR #len(form.appointment_date)# LT 10 >
			<cfset variables.error_message = "Invalid Date Format. MUST be mm/dd/yyyy. Please re-enter." >
		</cfif>
		 
		<cfif listlen(variables.error_message) gt 0>
			<cfset url.error_message=variables.error_message>
		<cfelse> 
			<cfset variables.MyID=#form.MyID#>
			<cfif variables.error eq 0 >
				 <cfoutput>
				 <cfset nbr_of_visits = 0 >
				 <cfquery datasource="CCAP10" name="Get_CCAP_Dealer">
					SELECT		CCAP_Leads.ccap_Lead_ID,
								CCAP_Leads.PIN,
								CCAP_Leads.PIN_type,
								CCAP_Leads.first_name,
								CCAP_Leads.last_name,
								CCAP_Leads.phone,
								CCAP_Leads.email,
								CCAP_Leads.Loan_amount,
								Dealers.ID,
								Dealers.dealer_Name,
								Dealers.Dealer_Contact,
								Dealers.dealer_id,
								Dealers.dealer_Address_1,
								Dealers.dealer_Address_2,
								Dealers.dealer_City,
								Dealers.dealer_State,
								Dealers.dealer_Zip, 
								Dealers.dealer_Phone
					FROM		CCAP_Leads 
					INNER JOIN	Dealers
					ON			CCAP_Leads.lead_dlr_id = Dealers.id
					WHERE		CCAP_Leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
				</cfquery>  
		
		  			<cfset bucks = 	"#NumberFormat(Get_CCAP_Dealer.Loan_Amount, "$" )#" >
		  			<cfif #Get_CCAP_Dealer.pin_type# EQ 1 >
		  				<cfset bucks = 	"$XX,XXX" >
					</cfif>
					
				<cfquery datasource="CCAP10" name="Check_Pin">
					SELECT 	ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                       		nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, APR
					FROM    Customer_PURLs
					WHERE	PURL=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="11">
					AND		dealer_id = '#Get_CCAP_Dealer.dealer_id#'
					AND		Active=1
					AND		expires_dt >= '#dateformat(now(),"mm/dd/yyyy")#'
				</cfquery>
				<cfset nbr_of_visits = #Check_Pin.nbr_visits# >
				<cfquery datasource="CCAP10" name="Get_S_Dealer">
					SELECT	ID, Campaign_ID, Dealer_ID, Dealer_srt, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, 
		                    Dealer_Contact, Dealer_Email, Dealer_Email_type, Dealer_Website, inventory_link, finance_link, contact_link, Destination_URL, PURL_Identifier, Dealer_Image, 
        		            Comments, Links_in_Emails, Links_on_Screens, start_dt, expires_dt, active, clicks, Dealer_Report_Name
					FROM	dealers		
					WHERE	Dealer_id = '#Check_Pin.Dealer_ID#'
				</cfquery>
				
				<cfset email_links = #Get_S_Dealer.Links_in_Emails# >
				<cfset screen_links = #Get_S_Dealer.Links_on_Screens# >

				<cfif #Get_S_Dealer.Dealer_Email# NEQ "" >
					<cfset s_dealer_email = #Get_S_Dealer.Dealer_Email# >
					<cfset s_email_type = #Get_S_Dealer.Dealer_Email_type# >
				<cfelse>
					<cfset s_dealer_email = "bob@worlddealer.net" >
					<cfset s_email_type = 0 >
				</cfif>
				
				<!--- <cfif #Get_S_Dealer.dealer_adf_email# EQ "" >
					<cfset s_dealer_email = #Get_S_Dealer.dealer_email# >
					<cfset s_email_type = 0 >
				<cfelse>
					<cfset s_dealer_email = #Get_S_Dealer.dealer_email# >	
					<cfset s_email_type = 1 >
				</cfif> --->
				
				</cfoutput>  

		 		<cfset url.dealercode = #Get_S_Dealer.Dealer_ID# >
		 		<cfset url.dealer_id = #Get_CCAP_Dealer.ID# >
		 		<cfset url.dealercode_id = #Get_CCAP_Dealer.Dealer_ID# >
		 		<cfset url.MyID = #variables.MyID# >
		
				<cfquery datasource="Ultra10" name="Get_program_Details">
					SELECT		Dealer_ID,
								dealer_directory
					FROM		Dealers
					WHERE		Dealer_id = 285
					ORDER BY 	Dealer_Name
				</cfquery>
		
				<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  
		
				<cfif	len(trim(form.myid)) neq 0 and 
							form.myid neq "0"
								and len(trim(form.age)) neq 0
									and len(trim(form.employment)) neq 0
										and len(trim(form.income)) neq 0
											and len(trim(form.Appointment_date)) neq 0
												and len(trim(form.Appointment_time)) neq 0>
						<cfquery datasource="CCAP10" name="Insert_Trade">
							UPDATE	CCAP_Leads
							SET		Age=<cfqueryparam value="#form.age#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
									Employment=<cfqueryparam value="#form.employment#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
									Income=<cfqueryparam value="#form.income#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
									Comments=<cfqueryparam value="#form.comments#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
									Fin_App_Date=<cfqueryparam value="#form.appointment_date#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
									Fin_App_Time=<cfqueryparam value="#form.appointment_time#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
							WHERE	MyID=<cfqueryparam value="#form.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
						</cfquery>  
						
					<!--- Update Visit Date on PIN record --->
					<cfset nbr_of_visits = #nbr_of_visits#+1 >
					<cfquery NAME="UpdVisit" datasource="CCAP10">
						UPDATE Customer_PURLs
						SET 	last_visit_dt=#CreateODBCDate(now())#,
								nbr_visits=#nbr_of_visits#
						WHERE 	ID	=	#Check_Pin.ID#
					</cfquery>
					
		<!--- Customer Email --->	<!--- 						
						<cfmail  to="#Get_CCAP_Dealer.email#" from="#variables.from#" subject="#variables.subject#" bcc="wdsupport@worlddealer.net"  type="HTML"> --->						
						<cfmail  to="#Get_CCAP_Dealer.email#" from="#variables.from#" subject="#variables.subject#" bcc="bob@worlddealer.net" type="HTML">
							<table width="70%"  cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="2" align="left"><img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/CC_Logo_Positive_sm.jpg"></td>
								</tr> 
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td colspan="2" style="padding:30px 10px 30px 10px">
										Thank you for requesting a meeting at <strong>#Get_CCAP_Dealer.Dealer_Name#</strong>! We will be contacting you shortly to confirm your appointment time. However if you would like to contact us immediately, our contact information is below. Please do not hesitate to contact us directly.<br/><br/>
									</td>
								</tr>
								<tr>
									<td  valign="top">
										 <div style="font:bold 20px arial">#Get_CCAP_Dealer.Dealer_Name#</div>   
										 #Get_CCAP_Dealer.Dealer_Address_1#<br/>
										<cfif #Get_CCAP_Dealer.Dealer_City# NEQ "" >
											#Get_CCAP_Dealer.Dealer_City#, #Get_CCAP_Dealer.Dealer_State# #Get_CCAP_Dealer.Dealer_Zip#<br/>
										</cfif>	
										<cfif #Get_CCAP_Dealer.Dealer_contact# NEQ "" >
											#Get_CCAP_Dealer.Dealer_contact#  <br/>
										</cfif>
										<cfif #Get_CCAP_Dealer.Dealer_Phone# NEQ "" >
											<div style="font:bold 20px arial">#Get_CCAP_Dealer.Dealer_Phone#</div>   
										</cfif>
									</td>
									<td style="padding:0px 10px 10px 10px;width:50%" valign="top"> 
									<cfif #email_links# EQ 1 >
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/ccap_click.cfm?MyID=#variables.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/ccap_click.cfm?MyID=#variables.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div> 
									</cfif>	
									</td>
								</tr>
							</table>
						</cfmail>
		<!--- END Customer Email --->		
						
						<cfset variables.recipient_list="#s_dealer_email#">
		<!--- Leads Emails --->		

						<cfset variables.lead_subject="Appointment Request from CCAPapproval.com #Get_CCAP_Dealer.Dealer_Name#">
		
						<cfif #s_email_type# EQ 1 >
		<!---Generate ADF Email--->
							  <cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_CCAP_Dealer.ccap_Lead_ID#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/Ultra10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_CCAP_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_CCAP_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_CCAP_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_CCAP_Dealer.Phone#"/>
								<cfinvokeargument name="Age" value="#form.Age#"/>
								<cfinvokeargument name="Employment" value="#form.Employment#"/>
								<cfinvokeargument name="Income" value="#form.Income#"/>
								<cfinvokeargument name="Appointment" value="#form.Appointment_date#"/>
								<cfinvokeargument name="Appointment_time" value="#form.Appointment_time#"/>
								<cfinvokeargument name="PIN" value="#Get_CCAP_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_CCAP_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/Ultra10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!--- <cfmail to="#variables.recipient_list#" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >  ---> 
							<cfmail to="bob@worlddealer.net" from="#variables.From#" subject="#variables.lead_subject#"   >
								#variables.adf_email#
						  	</cfmail>   
						<cfelse>
		<!---Generate TEXT Email--->
							<!--- <cfmail to="#variables.recipient_list#" from="#variables.from#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"   type="HTML">	 --->
							<cfmail to="bob@worlddealer.net" from="#variables.from#" subject="#variables.lead_subject#"  bcc="kelly@worlddealer.net"    type="HTML">			
								<table cellpadding="0" width="70%" cellspacing="0">
									<tr><td colspan="2">&nbsp;</td></tr> 
									<tr><td colspan="2">&nbsp;</td></tr> 
									<tr>
										<td align="left" > 
										Name: #Get_CCAP_Dealer.First_Name# #Get_CCAP_Dealer.Last_Name#<br>
										Phone: #Get_CCAP_Dealer.Phone#<br>
										Email: #Get_CCAP_Dealer.Email#<br>
										Age: #form.age#<br>
										Employment: #form.employment#<br>
										Income: #form.income#<br>
										Appointment: #form.Appointment_date# #form.appointment_time#<br>
										Loan Amount: #bucks#<br>
										Comments: #form.comments#<br><br>
										PIN: #Get_CCAP_Dealer.Pin#<br>
										Dealer: #Get_CCAP_Dealer.Dealer_Name#<br>
										Contact: #Get_CCAP_Dealer.Dealer_Contact#<br>
										Lead ID: #Get_CCAP_Dealer.ccap_Lead_ID#<br>
										 </td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									
								</table>  
							</cfmail>
						</cfif>		
					</cfif>
				</cfif>	<!--- end of variables.error if --->
			</cfif>
		</cffunction>

	
	
</cfcomponent>