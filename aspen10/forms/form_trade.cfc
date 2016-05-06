<cfcomponent>

	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">

	</cffunction>
	
	<cffunction name="tap_default" description="display default contact us form" output="Yes" access="public">

	</cffunction>


	<cffunction name="sall_default" description="display default contact us form" output="Yes" access="public">
		
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/sall_action.cfm"> 

		<cfset var Get_Form_Locations="">
		

		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<div class="col-md-12" align="center">
					<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:20pt;color:##0079c2;font-weight:bold">Private Invitation Number</span>
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
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">First Name:</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="First_Name" class="form-control input-sm" style="border:1px solid ##0079c2;min-height:25px"  id="First_Name" type="text" size="40"  maxlength="50" required>
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">Last Name:</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Last_Name"  class="form-control input-sm" style="border:1px solid ##0079c2;min-height:25px"  id="Last_Name" type="text" size="40"  maxlength="50"  required>
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">Email:</span>
					</div>
					<div class="col-md-4" align="left">
						<input name="Email" class="form-control input-sm" style="border:1px solid ##0079c2;min-height:25px"   id="Email" type="email" size="40"  maxlength="100"   required >
					</div>
					<div class="col-md-3" align="center"></div>
				</div>
				<div class="form-group">
					<div class="col-md-3" align="center"></div>
					<div class="col-md-2" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##0079c2;font-weight:bold">Phone:</span>
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

	<cffunction name="sall_page_2" description="display default contact us form" output="Yes" access="public">
	
 
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/sall_action_2.cfm"> 

		<cfset var Get_Form_Locations="">
		
		
		 <cfquery datasource="Aspen10" name="Get_Lead_Detl">
			SELECT		SALL_Leads.SALL_Lead_ID,
						SALL_Leads.PIN,
						SALL_Leads.first_name,
						SALL_Leads.last_name,
						SALL_Leads.phone,
						SALL_Leads.email
			FROM		SALL_Leads 
			WHERE		SALL_Leads.MyID=<cfqueryparam value="#arguments.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>  
		<cfset variables.lead_phone = #Get_Lead_Detl.phone# >
			
		<form id="tap_drive" class="form-horizontal" name="sall_2" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
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
						<input name="Phone_1"  class="form-control input-sm"  style="border:1px solid ##ffffff;min-height:25px" value="#variables.lead_phone#" id="Phone_1" type="text" size="40"  maxlength="10" required  >
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


	
	<cffunction name="form_submit_sall" description="action page for form" output="Yes" access="public">
 	
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
		<cfset variables.subject="Thank you for submitting your information to Autoproval!">
		<cfset variables.from="info@autoproval.com">
	
		<cfset variables.error_message="">
		<cfset variables.error=0>

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/aspen10/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.first_name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Last Name: form.Last_Name --->
		<cfinvoke component="/cfcs/aspen10/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/aspen10/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		  <cfinvoke component="/cfcs/aspen10/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke> 
		
		<cfif listlen(variables.error_message) gt 0>
			<cfset url.error_message=variables.error_message>
		<cfelse> 
  
			<cfset variables.MyID=replace(createUUID(),'-','','all')>
			
			<cfif #len(form.user_pin)# LT 11>
				<cfset form.user_pin="#left(form.user_pin,5)#-#right(form.user_pin,5)#">
			</cfif>
	
	
			<cfquery datasource="Aspen10" name="Check_Pin">
				SELECT     	a.Dealercode,
							a.Pin,
							a.First_Name,
							a.Last_Name,
							a.Address,
							a.City,
							a.State,
							a.Zip,
							a.pin_email,
							a.pin_dlr_id
				FROM		SALL_Pins a
				WHERE		a.Pin=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="11">
				<!--- AND			a.Dealercode like '0102%'  --->
				AND			a.Active=1
				AND			a.Date_Expires >= '#dateformat(now(),"mm/dd/yyyy")#'
			</cfquery>
				
			<cfif #Check_Pin.recordcount# eq 0>
					<!--- <cfmail to="bob@worlddealer.net" from="#variables.from#" subject="Invalid Autoproval PIN"   type="HTML">	 --->
				<cfquery datasource="Aspen10" name="Check_Expired">
					SELECT     	a.Dealercode,a.Pin,a.First_Name,a.Last_Name,a.Date_Expires,a.pin_dlr_id
					FROM		SALL_Pins a
					WHERE		a.Pin=<cfqueryparam value="#form.user_pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="11">
				</cfquery>
				<cfset expiration_flag = "" >
				<cfif #Check_Expired.Date_Expires# LTE #dateformat(now(),"mm/dd/yyyy")# >
					<cfset expiration_flag = "This PIN EXPIRED #dateformat(Check_Expired.Date_Expires,"mm/dd/yyyy")#" >
				</cfif>
				
				 <cfmail to="wdsupport@worlddealer.net" from="#variables.from#" subject="Invalid Autoproval PIN" type="HTML">	 
					An invalid Private Invitation Number has been entered at Autoproval.com<br><br>
					<cfif #expiration_flag# NEQ "">
						<span style="color:##cc0000;font-weight:bold" >#expiration_flag#</span><br><br>
					</cfif>
					PIN : #form.user_pin#<br><br>
					Firstname : #form.first_name#<br>
					Lastname : #form.last_name#<br>
					Email : #form.email#<br>
					Phone : #form.phone_1#<br><br>
					Date/Time: #dateformat(now(),"mm/dd/yyyy")#&nbsp;@&nbsp;#timeformat(now(),"hh:mm tt")#
					<br><br>
					This lead has not been delivered!<br>
					Please check the area code entered vs which dealers we have in the system and verify that all dealers in that area have valid PINs.<br>
					If you indeed believe this is a valid attempt to use the system and a dealer doesn't have PIN, please contact Aspen IMMEDIATELY with the dealer information.<br><br>
				
					This could be a typo on the user's part.<br>
					This could be somebody testing the system.<br>
					This could also be somebody messing with the system.<br>
					We need to rule out all possibilities.<br>

				</cfmail>
				<cfif #expiration_flag# EQ "">
					<cfset url.error_message="Invalid Private Invitation Number. Please try again.">
				<cfelse>
					<cfset url.error_message="#expiration_flag#.">
				</cfif>	
			<cfelse> 
				<!--- PIN is good, continue --->
				<cfoutput>
				<cfquery datasource="Aspen10" name="Get_S_Dealer">
					SELECT		Display_Name,Dealercode,
								dealer_id,
								Address_1,
								Address_2,
								City,
								State,
								Zip, 
								Primary_Phone,
								store_contact_email, email_type
					FROM		Dealers
					WHERE		Dealer_id= #Check_Pin.pin_dlr_id#
				</cfquery>
				
				<cfif #Check_Pin.pin_email# EQ "" >
					<cfset s_dealer_email = #Get_S_Dealer.store_contact_email# >
					<cfset s_email_type = #Get_S_Dealer.email_type# >
				<cfelse>
					<cfset s_dealer_email = #Check_Pin.pin_email# >	
					<cfset s_email_type = #Get_S_Dealer.email_type# >
				</cfif>
				
				<cfif #Check_Pin.pin_dlr_id# EQ 504 or #Check_Pin.pin_dlr_id# EQ 515 >
					<cfset s_dealer_email = "stevebaldoford@stevebaldo.com,mramsdell@stevebaldo.com,abaldo@stevebaldo.com,jblake@stevebaldo.com" >
				</cfif>
				
				</cfoutput>  
				
				<cfif Check_Pin.Recordcount gt 0>
					
 
					<cfquery datasource="Aspen10" name="Insert_LEAD">
						INSERT INTO	SALL_Leads
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
									lead_dlr_id)
							VALUES
									(<cfqueryparam value="#Check_Pin.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
									<cfqueryparam value="#Check_Pin.Pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
									<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#form.phone_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
									<cfqueryparam value="#Check_Pin.First_Name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.Last_Name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.Address#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
									<cfqueryparam value="#Check_Pin.City#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
									<cfqueryparam value="#Check_Pin.State#" cfsqltype="CF_SQL_VARCHAR" maxlength="2">,
									<cfqueryparam value="#left(Check_Pin.Zip,5)#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
									#Check_Pin.pin_dlr_id# )
					 	</cfquery>
 				
						<cfset variables.dlrcode = 	#Check_Pin.Dealercode#>
					<cfelse>
						<cfset variables.error=1>
					</cfif>
	
					<cfif variables.error eq 0 >
						<cfquery datasource="Aspen10" name="Get_SALL_Dealer">
							SELECT		SALL_Leads.SALL_Lead_ID,
										SALL_Leads.PIN,
										SALL_Leads.first_name,
										SALL_Leads.last_name,
										SALL_Leads.phone,
										SALL_Leads.email,
										Dealers.Display_Name,
										Dealers.dealer_id,
										Dealers.Address_1,
										Dealers.Address_2,
										Dealers.City,
										Dealers.State,
										Dealers.Zip, 
										Dealers.Primary_Phone
							FROM		SALL_Leads 
							INNER JOIN	Dealers
							ON			SALL_Leads.lead_dlr_id = Dealers.dealer_id
							WHERE		SALL_Leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
						</cfquery>  
			  
						<cfquery datasource="Aspen10" name="Get_phones">
							SELECT	Phone_ID, Dealer_ID, Dealer_Dept_ID, Phone_Label, Area_Code, Prefix, Line_Number, Vanity_Number, Desktop, Mobile, Hierarchy
							FROM    Dealer_Phones
							WHERE	Phone_ID = <cfoutput>#Get_SALL_Dealer.Primary_Phone#</cfoutput>
						</cfquery>
				
				 		<cfset url.dealercode = #Get_S_Dealer.dealercode# >
			
				 		<cfset url.dealer_id = #Get_SALL_Dealer.Dealer_ID# >
				 		<cfset url.dealercode_id = #Get_SALL_Dealer.Dealer_ID# >
				 		<cfset url.MyID = #variables.MyID# >
			
						<cfquery datasource="aspen10" name="Get_program_Details">
							SELECT		Dealer_ID,
										dealer_directory
							FROM		Dealers
							WHERE		Dealer_id = 255
							ORDER BY 	Dealer_Name
						</cfquery>
			
						<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  

					<cfset variables.lead_subject="PIN Submission from Autoproval.com #Get_SALL_Dealer.Display_Name#">
		
<cfif 	#Check_Pin.pin_dlr_id# neq 495 >						
	<!--- Customer Email --->		
						<cfmail to="#form.email#" from="#variables.from#" subject="#variables.subject#" bcc="kelly@worlddealer.net"  type="HTML">			
							<table cellpadding="0" width="70%" cellspacing="0">
								<tr>
									<td colspan="2"><img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Logo.png">&nbsp;<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png"> </td>
								</tr> 
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td colspan="2" >  
										Thank you for submitting your information to <strong>#Get_SALL_Dealer.Display_Name#</strong>! We will be contacting you shortly to discuss your loan options. However, if you would like to contact us immediately, we have provided an email contact link and phone number with this message. Also, do not hesitate to search our inventory by clicking on the convenient link.<br/><br/>
									 </td>
								</tr>
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td  valign="top"> 
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#?rmyID=#variables.MyID#" target="_blank">Click here to schedule your appointment</a></div>
									</td>
								</tr>
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td valign="top">
									<cfif 	#Check_Pin.pin_dlr_id# neq 528 >	
										 <div style="font:bold 20px arial">#Get_SALL_Dealer.Display_Name#</div>  
									<cfelse>	 
										 <div style="font:bold 20px arial">Tarbox Hyundai</div>  
										 <div style="font:bold 20px arial">Tarbox Toyota</div>  
									</cfif>	 
											 #Get_SALL_Dealer.Address_1#<br/>
											<cfif #Get_SALL_Dealer.City# NEQ "" >
											#Get_SALL_Dealer.City#, #Get_SALL_Dealer.State# #numberformat(Get_SALL_Dealer.Zip,"00000")#<br/>
											</cfif>
											<cfif #Check_Pin.pin_dlr_id# neq 524 >
											<div style="font:bold 20px arial">PHONE : #Get_phones.Area_Code#.#Get_phones.Prefix#.#Get_phones.Line_Number#<cfif #Check_Pin.pin_dlr_id# EQ 500> x111</cfif></div> 
											</cfif>
									</td>
								</tr>
								<tr>
									<td  valign="top"> 
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div> 
									</td>
								</tr>
							</table>  
						</cfmail>
	<!--- END Customer Email --->
	<cfelse>
						<cfmail to="bob@worlddealer.net" from="#variables.from#" subject="#variables.subject#" type="HTML">			
							<table cellpadding="0" width="70%" cellspacing="0">
								<tr>
									<td colspan="2"><img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Logo.png">&nbsp;<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png"> </td>
								</tr> 
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td colspan="2" >  
										Thank you for submitting your information to <strong>#Get_SALL_Dealer.Display_Name#</strong>! We will be contacting you shortly to discuss your loan options. However, if you would like to contact us immediately, we have provided an email contact link and phone number with this message. Also, do not hesitate to search our inventory by clicking on the convenient link.<br/><br/>
									 </td>
								</tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td  valign="top"> 
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#?rmyID=#variables.MyID#" target="_blank">Click here to Schedule your appointment</a></div>
									</td>
								</tr>
	
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td valign="top">
										 <div style="font:bold 20px arial">#Get_SALL_Dealer.Display_Name#</div>  
											 #Get_SALL_Dealer.Address_1#<br/>
											<cfif #Get_SALL_Dealer.City# NEQ "" >
												#Get_SALL_Dealer.City#, #Get_SALL_Dealer.State# #numberformat(Get_SALL_Dealer.Zip,"00000")#<br/>
											</cfif>
											<div style="font:bold 20px arial">PHONE : #Get_phones.Area_Code#.#Get_phones.Prefix#.#Get_phones.Line_Number#<cfif #Check_Pin.pin_dlr_id# EQ 500> x111</cfif></div> 
									</td>
								</tr>
								<tr>
									<td  valign="top"> 
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
										<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:blue;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div> 
									</td>
								</tr>
							</table>  
						</cfmail>
	</cfif>		

	<cfset variables.recipient_list="#s_dealer_email#">


	<!--- Leads Emails --->			
				
	<cfif #s_email_type# EQ 1 >
		<!---Generate ADF Email--->
 
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
			</cfinvoke>
	
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
				<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
				<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
				<cfinvokeargument name="zip" value=""/>
				<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
				<!--- <cfinvokeargument name="Age" value="#form.Age#"/>
				<cfinvokeargument name="Employment" value="#form.Employment#"/>
				<cfinvokeargument name="Income" value="#form.Income#"/>
				<cfinvokeargument name="Appointment" value="#form.Appointment_date#"/>
				<cfinvokeargument name="Appointment_time" value="#form.Appointment_time#"/> --->
				<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
				<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
			</cfinvoke>
	<!---  --->		
	<cfif #Get_S_Dealer.dealer_id# eq 495	>
	<!--- 
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value=""/>
				<cfinvokeargument name="v_vin" value=""/>
				<cfinvokeargument name="v_year" value=""/>
				<cfinvokeargument name="v_make" value=""/>
				<cfinvokeargument name="v_model" value=""/>
				<cfinvokeargument name="v_mileage" value=""/>
				<cfinvokeargument name="v_comments" value=""/>
			</cfinvoke> --->
<!---  --->
			<cfset variables.this_dealer_id=form.delivery_dealer_id>
			
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>
<!---  --->			
	</cfif>	
	<!---  --->	
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>  
			<!---Send ADF Emails--->
	<!---  --->		
	<cfif #Get_S_Dealer.dealer_id# eq 495	>
			<cfmail to="bob@worlddealer.net" from="#variables.From#" subject="#variables.lead_subject#"  >
				#variables.adf_email#
		  	</cfmail>  
	<cfelse>
			<cfmail to="#variables.recipient_list#" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
				#variables.adf_email#
		  	</cfmail>  		
	</cfif>
		<cfelse>

			<cfif #Get_S_Dealer.dealer_id# neq 513 AND  #Get_S_Dealer.dealer_id# neq 512 and #Get_S_Dealer.dealer_id# neq 516 and  #Get_S_Dealer.dealer_id# neq 540 and 
				#Get_S_Dealer.dealer_id# neq 517  and #Get_S_Dealer.dealer_id# neq 530   and #Get_S_Dealer.dealer_id# neq 532   and #Get_S_Dealer.dealer_id# neq 534    and 
					#Get_S_Dealer.dealer_id# neq 533   and #Get_S_Dealer.dealer_id# neq 528  and #Get_S_Dealer.dealer_id# neq 546   and #Get_S_Dealer.dealer_id# neq 549 
					  and #Get_S_Dealer.dealer_id# neq 550   and #Get_S_Dealer.dealer_id# neq 551   and #Get_S_Dealer.dealer_id# neq 552   and #Get_S_Dealer.dealer_id# neq 553   
					  and #Get_S_Dealer.dealer_id# neq 554 and #Get_S_Dealer.dealer_id# neq 556  and #Get_S_Dealer.dealer_id# neq 557     and #Get_S_Dealer.dealer_id# neq 558      
					  and #Get_S_Dealer.dealer_id# neq 560  and #Get_S_Dealer.dealer_id# neq 562  and #Get_S_Dealer.dealer_id# neq 563    and #Get_S_Dealer.dealer_id# neq 564   
					   and #Get_S_Dealer.dealer_id# neq 587 and #Get_S_Dealer.dealer_id# neq 590   and #Get_S_Dealer.dealer_id# neq 591  and #Get_S_Dealer.dealer_id# neq 592  
					    and #Get_S_Dealer.dealer_id# neq 593 >
			
				<cfmail to="#variables.recipient_list#" from="#variables.from#" subject="#variables.lead_subject#" bcc="kelly@worlddealer.net,wdsupport@worlddealer.net"  type="HTML">			
					<table cellpadding="0" width="70%" cellspacing="0">
						<tr><td colspan="2">&nbsp;</td></tr> 
						<tr><td colspan="2">&nbsp;</td></tr> 
						<tr>
							<td align="left" > 
								Name: #form.First_Name# #form.Last_Name#<br>
								Phone: #form.Phone_1#<br>
								Email: #form.Email#<br>
								PIN: #Get_SALL_Dealer.Pin#<br>
								Dealer: #Get_SALL_Dealer.Display_Name#<br>
								Lead ID: #Get_SALL_Dealer.SALL_Lead_ID# 
							 </td>
						</tr>
						<tr><td>&nbsp;</td></tr>
					</table>  
				</cfmail>
			</cfif>
						
 		<cfif #Get_S_Dealer.dealer_id# eq 593>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="leads@dullesmotorcars.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>  						
 		<cfif #Get_S_Dealer.dealer_id# eq 592>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="jimmckaychev@promaxonline.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>  
 		<cfif #Get_S_Dealer.dealer_id# eq 591>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="leads@route44hyundai.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>  
 		<cfif #Get_S_Dealer.dealer_id# eq 590>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="liahyundaialbany@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>  
 		<cfif #Get_S_Dealer.dealer_id# eq 587>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="ckplleads@centralkia.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>  
			
			<cfif #Get_S_Dealer.dealer_id# eq 582>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="internetleads1169@car-crm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 581>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="internetleads0614@car-crm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 580>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="internetleads1189@car-crm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 579>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="taylorchryslerdodgejeepram2183@adfleads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 577>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="hondawebleads@ronbouchardsautostores.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 575>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="crossroadsfordlincolnsanford@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 574>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="crossroadsnissanofsanford@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 573>
							<!---Generate ADF Email for Crossroads Ford Mazda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="crossroadsofvirginia@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 570>
							<!---Generate ADF Email for Big Star Honda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="webleads@bigstarhonda.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 564>
							<!---Generate ADF Email for Prime Hyundai--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="primetoyotasaco@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 563>
							<!---Generate ADF Email for Prime Hyundai--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="primehyundai@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 562>
							<!---Generate ADF Email for Lia Hyundai--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="liahyundaienfield@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 560>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="texanwebleads@texangm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 558>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="liatoyotascionnorthampton@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 557>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primetoyotasaco@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 556>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primehyundai@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 554>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primevolkswagen@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 553>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primetoyotart2@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 552>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primehyundaisouthma@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 551>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primehondasaco@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 550>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primefordmazda@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 549>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="primeacuranorth@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 548>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="cps065il@lotproonline.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 547>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="cps065il@lotproonline.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 546>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="KellyMitsubishiRiskFree1604@ADFLeads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 542>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="crmleads@concordvillecares.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 541>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="mstone@silveiraautos.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			
			<cfif #Get_S_Dealer.dealer_id# eq 540>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="KellyGMCBuick1601@ADFLeads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 539>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="25051leads@i360webleads.com,cps065il@lotproonline.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 535>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="liatoyotascionnorthampton@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 528>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="tarboxhyundai@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 537>
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<cfmail to="leads@nissanvillage.dealercrm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 534>
							<!---Generate ADF Email for Tarbox--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="leads@royrobinson.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 532>
							<!---Generate ADF Email for Tarbox--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="nationwidekia@nationwidemotors.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 530>
							<!---Generate ADF Email for Tarbox--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="linus@northwoodauto.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			 <cfif #Get_S_Dealer.dealer_id# eq 533>
							<!---Generate ADF Email for Tarbox--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="elcochevroletinc@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>  
			<cfif #Get_S_Dealer.dealer_id# eq 498>
							<!---Generate ADF Email for Tameron Honda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="webleads@tameron.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 513>
							<!---Generate ADF Email for Tameron Honda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="liavwenfield@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 510>
							<!---Generate ADF Email for Tameron Honda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="leads@easterns.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 524>
							<!---Generate ADF Email for Tameron Honda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="leads@easterns.motosnap.com,easterns@press1totalk.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 512>
							<!---Generate ADF Email for Tameron Honda--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="lianissansaratoga@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 499>
							<!---Generate ADF Email for Savage 61 Dodge--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="61leads@savageautogroup.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 503>
							<!---Generate ADF Email for Lynn Smith Chevy--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="lynnsmithchevrolet@adfleads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 509>
							<!---Generate ADF Email for Bastrop Ford--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="rduncan@samesbford.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 516>
							<!---Generate ADF Email for Lia Hyundai--->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="liahyundaienfield@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 517>
							<!---Generate ADF Email for Lia Hyundai Hartford --->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="liahyundaihartford@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 519>
							<!---Generate ADF Email for Lia Kia Northampton --->
			 				<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
								<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
								<cfinvokeargument name="first_name" value="#Get_SALL_Dealer.First_Name#"/>
								<cfinvokeargument name="last_name" value="#Get_SALL_Dealer.Last_Name#"/>
								<cfinvokeargument name="email" value="#Get_SALL_Dealer.Email#"/>
								<cfinvokeargument name="zip" value=""/>
								<cfinvokeargument name="phone_1" value="#Get_SALL_Dealer.Phone#"/>
								<cfinvokeargument name="PIN" value="#Get_SALL_Dealer.Pin#"/>
								<cfinvokeargument name="Dealer" value="#Get_SALL_Dealer.Display_Name#"/>
							</cfinvoke>
				<!---  --->
							<cfset variables.this_dealer_id=form.delivery_dealer_id>
							
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
								<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>
				<!---  --->									
							<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
								<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
							</cfinvoke>  
							<!---Send ADF Emails--->
							<cfmail to="liakianorthamptonma@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  	</cfmail>  
			</cfif>
		</cfif>			
	<!--- END Leads Emails --->		
 
				</cfif>	<!--- end of variables.error if --->
			</cfif> <!--- end invalid PIN --->
		</cfif>
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
				
					 <cfquery datasource="Aspen10" name="Get_SALL_Dealer">
						SELECT		SALL_Leads.SALL_Lead_ID,
									SALL_Leads.PIN,
									SALL_Leads.first_name,
									SALL_Leads.last_name,
									SALL_Leads.phone,
									SALL_Leads.email,
									Dealers.Display_Name,
									Dealers.dealer_id,
									Dealers.Address_1,
									Dealers.Address_2,
									Dealers.City,
									Dealers.State,
									Dealers.Zip, 
									Dealers.Primary_Phone
						FROM		SALL_Leads 
						INNER JOIN	Dealers
						ON			SALL_Leads.lead_dlr_id = Dealers.dealer_id
						WHERE		SALL_Leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>  
		
					<cfquery datasource="Aspen10" name="Get_phones">
						SELECT	 Phone_ID, Dealer_ID, Dealer_Dept_ID, Phone_Label, Area_Code, Prefix, Line_Number, Vanity_Number, Desktop, Mobile, Hierarchy
						FROM         Dealer_Phones
						WHERE		Phone_ID=<cfoutput>#Get_SALL_Dealer.Primary_Phone#</cfoutput>
					</cfquery>
			
	
				<cfquery datasource="Aspen10" name="Check_Pin">
					SELECT     	a.Dealercode,
								a.Pin,
								a.First_Name,
								a.Last_Name,
								a.Address,
								a.City,
								a.State,
								a.Zip,
								a.pin_email,
								a.pin_dlr_id
					FROM		SALL_Pins a
					WHERE		a.Pin=<cfqueryparam value="#Get_SALL_Dealer.PIN#" cfsqltype="CF_SQL_VARCHAR" maxlength="11">
					<!--- AND			a.Dealercode like '0102%' --->
					AND			a.pin_dlr_id = #Get_SALL_Dealer.dealer_id#
					AND			a.Active=1
					AND			a.Date_Expires >= '#dateformat(now(),"mm/dd/yyyy")#'
				</cfquery>
					<cfquery datasource="Aspen10" name="Get_S_Dealer">
						SELECT		Display_Name,Dealercode,
									dealer_id,
									Address_1,
									Address_2,
									City,
									State,
									Zip, 
									Primary_Phone,
								store_contact_email, email_type
						FROM		Dealers
						WHERE		Dealer_id= #Check_Pin.pin_dlr_id#
					</cfquery>
					<cfif #Check_Pin.pin_email# EQ "" >
						<cfset s_dealer_email = #Get_S_Dealer.store_contact_email# >
						<cfset s_email_type = #Get_S_Dealer.email_type# >
					<cfelse>
						<cfset s_dealer_email = #Check_Pin.pin_email# >	
						<cfset s_email_type = #Get_S_Dealer.email_type# >
					</cfif>
				
				<cfif #Check_Pin.pin_dlr_id# EQ 504 OR  #Check_Pin.pin_dlr_id# EQ 515 >
					<cfset s_dealer_email = "stevebaldoford@stevebaldo.com,mramsdell@stevebaldo.com,abaldo@stevebaldo.com,jblake@stevebaldo.com" >
				</cfif>
				
				</cfoutput>  
			 		<cfset url.dealercode = #Get_S_Dealer.dealercode# >
		
			 		<cfset url.dealer_id = #Get_SALL_Dealer.Dealer_ID# >
			 		<cfset url.dealercode_id = #Get_SALL_Dealer.Dealer_ID# >
			 		<cfset url.MyID = #variables.MyID# >
		
					<cfquery datasource="aspen10" name="Get_program_Details">
						SELECT		Dealer_ID,
									dealer_directory
						FROM		Dealers
						WHERE		Dealer_id = 255
						ORDER BY 	Dealer_Name
					</cfquery>
		
					<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>  
		
					<cfif	len(trim(form.myid)) neq 0 and form.myid neq "0"
							and len(trim(form.age)) neq 0
							and len(trim(form.employment)) neq 0
							and len(trim(form.income)) neq 0
							and len(trim(form.Appointment_date)) neq 0
							and len(trim(form.Appointment_time)) neq 0>
							 
							<cfquery datasource="Aspen10" name="Insert_Trade">
								UPDATE	SALL_Leads
								SET		Age=<cfqueryparam value="#form.age#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										Employment=<cfqueryparam value="#form.employment#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										Income=<cfqueryparam value="#form.income#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										Fin_App_Date=<cfqueryparam value="#form.appointment_date#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
										Fin_App_Time=<cfqueryparam value="#form.appointment_time#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
								WHERE	MyID=<cfqueryparam value="#form.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
							</cfquery>  

	<!--- Customer Email --->							
							<cfmail  to="#Get_SALL_Dealer.email#" from="#variables.from#" subject="#variables.subject#" bcc="wdsupport@worlddealer.net"  type="HTML">
								<table width="70%"  cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="2"><img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Logo.png">&nbsp;<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png"> </td>
										</tr> 
										<tr><td>&nbsp;</td></tr>
										<tr><td>&nbsp;</td></tr>
										<tr>
											<td colspan="2" style="padding:30px 10px 30px 10px">
												Thank you for requesting a meeting at <strong>#Get_SALL_Dealer.Display_Name#</strong>! We will be contacting you shortly to confirm your appointment time. However if you would like to contact us immediately, we have provided an email contact link and phone number with this message. Also do not hesitate to search our inventory by clicking on the convenient link.<br/><br/>
												
											</td>
										</tr>
										<tr>
											<td  valign="top">
											<cfif #Get_SALL_Dealer.Dealer_ID# NEQ 528 >
													 <div style="font:bold 20px arial">#Get_SALL_Dealer.Display_Name#</div>   
											<cfelse>
													 <div style="font:bold 20px arial">Tarbox Hyundai</div>  
													 <div style="font:bold 20px arial">Tarbox Toyota</div>   		 
											 </cfif>
														 #Get_SALL_Dealer.Address_1#<br/>
														<cfif #Get_SALL_Dealer.City# NEQ "" >
															#Get_SALL_Dealer.City#, #Get_SALL_Dealer.State# #numberformat(Get_SALL_Dealer.Zip,"00000")#<br/>
														</cfif>	
														<cfif #Check_Pin.pin_dlr_id# NEQ 524 >
														<div style="font:bold 20px arial">PHONE : #Get_phones.Area_Code#.#Get_phones.Prefix#.#Get_phones.Line_Number#<cfif #Check_Pin.pin_dlr_id# EQ 500> x111</cfif></div>   
														</cfif>
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

		<cfset variables.lead_subject="Appointment Request from Autoproval.com #Get_SALL_Dealer.Display_Name#">
		
<cfif 	#Check_Pin.pin_dlr_id# neq 495 >		

	<cfif #s_email_type# EQ 1 >
		<!---Generate ADF Email--->
 
		<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
			<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
		</cfinvoke>

		<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->						
		<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
			<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
		</cfinvoke>  
		<!---Send ADF Emails--->
			<cfmail to="#variables.recipient_list#" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
				#variables.adf_email#
		  </cfmail>  
	
	<cfelse>
		<cfif #Get_S_Dealer.dealer_id# neq 513 AND  #Get_S_Dealer.dealer_id# neq 512 and #Get_S_Dealer.dealer_id# neq 516 and #Get_S_Dealer.dealer_id# neq 517  and  #Get_S_Dealer.dealer_id# neq 540 and 
			#Get_S_Dealer.dealer_id# neq 530   and #Get_S_Dealer.dealer_id# neq 532    and #Get_S_Dealer.dealer_id# neq 534   and #Get_S_Dealer.dealer_id# neq 533   and #Get_S_Dealer.dealer_id# neq 528 and 
			#Get_S_Dealer.dealer_id# neq 546   and #Get_S_Dealer.dealer_id# neq 549   and #Get_S_Dealer.dealer_id# neq 550   and #Get_S_Dealer.dealer_id# neq 551   and 
			#Get_S_Dealer.dealer_id# neq 552   and #Get_S_Dealer.dealer_id# neq 553   and #Get_S_Dealer.dealer_id# neq 554    and #Get_S_Dealer.dealer_id# neq 556   and #Get_S_Dealer.dealer_id# neq 557   
			and #Get_S_Dealer.dealer_id# neq 558 and #Get_S_Dealer.dealer_id# neq 560  and #Get_S_Dealer.dealer_id# neq 562   and #Get_S_Dealer.dealer_id# neq 563 and #Get_S_Dealer.dealer_id# neq 564  
			and #Get_S_Dealer.dealer_id# neq 587   and #Get_S_Dealer.dealer_id# neq 590   and #Get_S_Dealer.dealer_id# neq 591  and #Get_S_Dealer.dealer_id# neq 592 
			 and #Get_S_Dealer.dealer_id# neq 593       >
			<!---Generate TEXT Email--->
			<cfmail to="#variables.recipient_list#" from="#variables.from#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"   type="HTML">			
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
						Dealer: #Get_SALL_Dealer.Display_Name#<br>
						Lead ID: #Get_SALL_Dealer.SALL_Lead_ID#<br>
						 </td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					
				</table>  
			</cfmail>
		</cfif>
				
			 <cfif #Get_S_Dealer.dealer_id# eq 593>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="leads@dullesmotorcars.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				 
				
			 <cfif #Get_S_Dealer.dealer_id# eq 592>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="jimmckaychev@promaxonline.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				 
				
			 <cfif #Get_S_Dealer.dealer_id# eq 591>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="leads@route44hyundai.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				 
				
			 <cfif #Get_S_Dealer.dealer_id# eq 590>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="liahyundaialbany@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				 
				
			 <cfif #Get_S_Dealer.dealer_id# eq 587>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="ckplleads@centralkia.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				 
				
			<cfif #Get_S_Dealer.dealer_id# eq 582>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="internetleads1169@car-crm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				
				
			<cfif #Get_S_Dealer.dealer_id# eq 581>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="internetleads0614@car-crm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				
				
				
			<cfif #Get_S_Dealer.dealer_id# eq 580>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="internetleads1189@car-crm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				
				
			<cfif #Get_S_Dealer.dealer_id# eq 579>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="taylorchryslerdodgejeepram2183@adfleads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				
				
			<cfif #Get_S_Dealer.dealer_id# eq 577>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="hondawebleads@ronbouchardsautostores.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				
			<cfif #Get_S_Dealer.dealer_id# eq 575>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="crossroadsfordlincolnsanford@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>				
			<cfif #Get_S_Dealer.dealer_id# eq 574>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="crossroadsnissanofsanford@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 573>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="crossroadsofvirginia@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 570>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="webleads@bigstarhonda.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>

			<cfif #Get_S_Dealer.dealer_id# eq 564>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="primetoyotasaco@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>

			<cfif #Get_S_Dealer.dealer_id# eq 563>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="primehyundai@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
		
			<cfif #Get_S_Dealer.dealer_id# eq 562>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
							<cfmail to="liahyundaienfield@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 560>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="texanwebleads@texangm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>				
			<cfif #Get_S_Dealer.dealer_id# eq 558>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="liatoyotascionnorthampton@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>				
			<cfif #Get_S_Dealer.dealer_id# eq 557>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primetoyotasaco@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>				
			<cfif #Get_S_Dealer.dealer_id# eq 556>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primehyundai@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>							
			<cfif #Get_S_Dealer.dealer_id# eq 554>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primevolkswagen@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>							
			<cfif #Get_S_Dealer.dealer_id# eq 553>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primetoyotart2@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>					
			<cfif #Get_S_Dealer.dealer_id# eq 552>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primehyundaisouthma@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
			<cfif #Get_S_Dealer.dealer_id# eq 551>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primehondasaco@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
			<cfif #Get_S_Dealer.dealer_id# eq 550>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primefordmazda@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
		
		
			<cfif #Get_S_Dealer.dealer_id# eq 549>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="primeacuranorth@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
		
			<cfif #Get_S_Dealer.dealer_id# eq 548>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="cps065il@lotproonline.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
		
			<cfif #Get_S_Dealer.dealer_id# eq 547>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="cps065il@lotproonline.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
		
			<cfif #Get_S_Dealer.dealer_id# eq 546>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="KellyMitsubishiRiskFree1604@ADFLeads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
			<cfif #Get_S_Dealer.dealer_id# eq 542>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="crmleads@concordvillecares.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
			<cfif #Get_S_Dealer.dealer_id# eq 541>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="mstone@silveiraautos.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
		
			<cfif #Get_S_Dealer.dealer_id# eq 540>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="KellyGMCBuick1601@ADFLeads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>			
			<cfif #Get_S_Dealer.dealer_id# eq 539>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="cps065il@lotproonline.com,25051leads@i360webleads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 537>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="leads@nissanvillage.dealercrm.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 535>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="liatoyotascionnorthampton@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 528>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<cfmail to="tarboxhyundai@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
							#variables.adf_email#
					  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 534>
						<!---Generate ADF Email for Tarbox Hyundai & Toyota --->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="leads@royrobinson.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 532>
						<!---Generate ADF Email for Tarbox Hyundai & Toyota --->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="nationwidekia@nationwidemotors.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 530>
						<!---Generate ADF Email for Tarbox Hyundai & Toyota --->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="linus@northwoodauto.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
		 <cfif #Get_S_Dealer.dealer_id# eq 533>
						<!---Generate ADF Email for   --->
				 
				 
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="elcochevroletinc@newsales.leads.cmdlr.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>  
			<cfif #Get_S_Dealer.dealer_id# eq 519>
						<!---Generate ADF Email for Lia Kia Northampton --->
				 
				 
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="liakianorthamptonma@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 517>
						<!---Generate ADF Email for Lia Hyundai Hartford--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="liahyundaihartford@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 513>
						<!---Generate ADF Email for Lia Hyundai Hartford--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="liavwenfield@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 516>
						<!---Generate ADF Email for Tameron Honda in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="liahyundaienfield@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 510>
						<!---Generate ADF Email for Tameron Honda in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="leads@easterns.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 524>
						<!---Generate ADF Email for Tameron Honda in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="leads@easterns.motosnap.com,easterns@press1totalk.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 512>
						<!---Generate ADF Email for Lia Nissan in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="lianissansaratoga@eleadtrack.net" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 498>
						<!---Generate ADF Email for Tameron Honda in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="webleads@tameron.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 499>
						<!---Generate ADF Email for Savage 61 Dodge in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="61leads@savageautogroup.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 503>
						<!---Generate ADF Email for Lynn Smith Chevy in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="lynnsmithchevrolet@adfleads.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
			<cfif #Get_S_Dealer.dealer_id# eq 509>
						<!---Generate ADF Email for Bastrop Ford in addition to text--->
				 
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
							<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
						</cfinvoke>
				
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
			
			 <!---  --->
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
						
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
							<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>
			<!---  --->			
										
						<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
							<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
						</cfinvoke>  
						<!---Send ADF Emails--->
							<cfmail to="rduncan@samesbford.motosnap.com" from="#variables.From#" subject="#variables.lead_subject#" bcc="wdsupport@worlddealer.net"  >
								#variables.adf_email#
						  </cfmail>  
			</cfif>
	</cfif>				
<cfelse>	

<!---Generate ADF Email--->
 
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#Get_SALL_Dealer.SALL_Lead_ID#"/>
			</cfinvoke>

			 <cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
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
 <!---  --->
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
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
			
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>
<!---  --->			
			<cfinvoke component="/cfcs/aspen10/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>   
			
		<!---Send ADF Emails--->
			<cfmail to="bob@worlddealer.net" from="#variables.From#" subject="#variables.lead_subject#"    >
				#variables.adf_email#
		  </cfmail>  
  
</cfif>					
<!--- END Leads Emails --->		
				</cfif>
			</cfif>	<!--- end of variables.error if --->
		</cfif>
	</cffunction>

	
	
</cfcomponent>