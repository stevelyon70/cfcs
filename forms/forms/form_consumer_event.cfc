<cfcomponent>
	<cffunction name="consumer_event_page" description="Kelly Event form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="price_search">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/consumer_events_action.cfm">
		<cfargument name="voi_new_used" default="">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="register-btn">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
		
		<cfif #url.dealer_id# eq 79 >
			<cfset what_mo = "December" ><cfset what_day = 16><cfset form_heading = "Register to Attend">
		<cfelseif #url.dealer_id# eq 52 >
			<cfset what_mo = "December" ><cfset what_day = 7><cfset form_heading = "Register to Attend">
		<cfelse>
			<cfset what_mo = "November" ><cfset what_day = 9><cfset form_heading = "Want to learn more?">
		</cfif>
		
		<cfset err_style = "" >
		<cfif IsDefined("url.err_msg") and #len(url.err_msg)# GT 0 >
			<cfset err_style = "background-color:yellow" >
		</cfif>
	    <div class="row">

			<div class="col-md-9  visible-sm visible-xs  visible-lg visible-md" >	
					
					<div class="titan-header">
						<div class="titan-50">
					    	<img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_Header.jpg" width="100%" alt="Exclusive preview of the 2016 Nissan Titan XD at Kelly Nissan"/>
						</div>
						<div class="titan-50">
							<p style="text-align:center"><img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_NowInDiesel.png" width="75%" alt="All-New 2016 Nissan Titan XD"/>
							<p>Dropping a Cummins 5.0L V8 Turbo Diesel engine in a half-ton creates enormous towing power<a href="http://www.nissanusa.com/trucks/2016-titan/disclaimers.html##towing-guide" target="_blank" style="color: ##A7A7A7; text-decoration:none;">*</a>. If you’re going to use all that power, you’re going to need commercial   grade components and the stability provided by a gooseneck hitch.  We engineered both right into the TITAN XD frame. In early trials held in sweltering Arizona we pulled more than 6 tons, and the TITAN XD performed with total confidence.</p>
						</div>
					</div>
					
					<div style="clear:both"></div>
					
					<div class="titan-header">
						<div class="titan-event">
							<div class="titan-50">
								<img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_MeetTitan.png" width="100%" alt="Meet the all-new Nissan Titan"/>
							</div>
						    <div class="titan-50">
						    <h3 style="text-align:center;">Get an exclusive look at the<br><strong>ALL-NEW 2016 TITAN XD DIESEL</strong><br>#what_mo# #what_day#th from 6pm to 8pm at #url.dealer_name#.</h3>
							</div>
						</div>
						
						<div style="clear:both"></div>
						
						
						<div class="titan-25">
						  <h3><img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_TheBeast.jpg" width="100%" alt="2016 Nissan Titan with diesel Cummins engine"/></h3>
						  <p>The all-new Cummins 5.0L V8 Turbo Diesel<a href="http://www.nissanusa.com/trucks/2016-titan/disclaimers.html##available-feature" target="_blank" style="color: ##A7A7A7; text-decoration:none;">*</a> is the heart of the next-gen TITAN XD. This beast of an engine, with 310 HP, brings   heavy-duty attitude and 555lbs of torque to half-ton pickup territory, and does it   with better fuel economy than its 
						    gasoline counterparts.</p>
						
						</div>
						<div class="titan-25">
						  <h3><img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_GoBig.jpg " width="100%" alt="2016 Nissan Titan commercial towing capacity"/></h3>
						  <p>We needed a bigger, burlier chassis to handle TITAN XD’s expanded towing and payload potential, so we looked at the battle-tested   chassis of the Nissan Commercial Vehicle as a jumping off point. From   there we engineered a new frame and chassis and reinforced  them with some seriously substantial components.<a href="http://www.nissanusa.com/trucks/2016-titan/disclaimers.html##not-yet-available" target="_blank" style="color: ##A7A7A7; text-decoration:none;">*</a></p>
						
						</div>
						<div class="titan-25">
						  <h3><img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_BigShot.jpg " width="100%" alt="2016 Nissan Titan: Great looking and functional inside & out"/></h3>
						  <p>The new class of power meets master craftsmanship in TITAN   XD’s ultra-comfortable, premium interior. We’ve relocated the shifter to   the steering column, making more room for a massive center console and   for more overall space in an already spacious interior. Carefully   considered storage features and power sources are placed throughout the   cabin. Advanced connective technology helps keep you in touch, while   supportive, leather-appointed front seats provide exceptional long-haul   comfort.</p>
						
						</div>
						<div class="titan-25">
						  <h3><img src="http://dealers.wdautos.com/dealer/kellynissan/images/library/2016Titan_Smarter.jpg" width="100%" alt="2016 Nissan Titan: Innovative features to help you work smarter"/></h3>
						  <p>The new 2016 TITAN XD lineup boasts a cargo box loaded with   available features. The innovative Utili-track® cargo system features   four heavy-duty aluminum alloy cleats that move and lock anywhere along   the walls, bed floor and header tracks to give you endless tie-down   possibilities. Lockable in-bed storage sits sight-unseen at street   level, and flush-mounted LED lighting helps you find that rogue socket   wrench in the dark. This is a truck bed that not only lets you work   harder, it helps you work smarter.<a href="http://www.nissanusa.com/trucks/2016-titan/disclaimers.html##cargo-capacity" target="_blank" style="color: ##A7A7A7; text-decoration:none;">*</a></p>
						
						</div>
					</div>
				
				</div>
				
				<div class="col-md-3  visible-sm visible-xs  visible-lg visible-md"   >	
					<span class="register_title" >#form_heading#</span><br>
					<span class="register_text" >Fill out the form below</span>
					<form action="#arguments.form_action#" method="post">
						<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
						<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
						<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* First Name" required>
						<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* Last Name" required>
						<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:5px" maxlength="100" placeholder="* Email" required>
						<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:5px" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
						<cfif #url.dealer_id# neq 79 >
							<input class="#arguments.input_class#" name="Current_vehicle" id="Current_vehicle" type="text"  style="margin-bottom:5px" maxlength="50" placeholder="Current Vehicle" >
						</cfif>
						<br><input class="#arguments.button_class# pull-right" name="Submit" id="Submit"   type="submit" value="Submit">
					</form>
				</div>			

	        </div>  <!--- End ROW --->

	</cffunction>
	




	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="email_subject" default="Consumer Events Notification from #lcase(cgi.Server_Name)#">

		<!--- defaults --->
		<cfset variables.WD_BCC="wdsupport@worlddealer.net">
		<cfset variables.from_email="leads@worlddealer.net">
		<cfparam name="variables.Email_Subject" default="#arguments.email_subject#">
		<!--- <cfset variables.mail_server="info@tradeinprogram.com:wd2000@mail.greatmail.com"> --->
	
		<cfparam name="form.Dealer_ID" default="#arguments.dealer_id#">
		<cfparam name="form.Delivery_Dealer_ID" default="#arguments.dealer_id#">
		<cfparam name="form.First_Name" default="">
		<cfparam name="form.Last_Name" default="">
		<cfparam name="form.Phone_1" default="">
		<cfparam name="form.Email" default="">
		<cfparam name="form.current_vehicle" default="">

		<cfparam name="form.VOI_Vin" default="">
		<cfparam name="form.VOI_New_Used" default="">
		<cfparam name="form.VOI_Year" default="">
		<cfparam name="form.VOI_Make" default="">
		<cfparam name="form.VOI_Model" default="">
		<cfparam name="form.VOI_Stock" default="">

		<cfparam name="form.Sales_Rep" default="">
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
			<cfinvokeargument name="text_value" value="#form.Current_Vehicle#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<!---<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>--->
			
			<cfset url.error_message=variables.error_message>

		<cfelse>
				
			<!--- <cfswitch expression="#arguments.dealer_id#" >
				<cfdefaultcase>
					<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
						<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(form.VOI_Vin,17)#" maxlength="21">
						<cfprocresult name="Get_Vehicle_Details" resultset="1">
					</cfstoredproc>
					<cfset form.Delivery_Dealer_ID=Get_Vehicle_Details.Dealer_ID>
				</cfdefaultcase>
			</cfswitch> --->

			<!---lead delivery hack  Faulkner--->
			<!---  <cfswitch expression="#url.dealer_id#">
				<cfcase value="78,79,82,24">
					<cfset form.dealer_id=url.dealer_id>
					<cfset form.delivery_dealer_id=url.dealer_id>
					<!--- <cfset arguments.lead_send_id=url.dealer_id> --->
				</cfcase>
			</cfswitch>  --->

			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#arguments.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#form.Dealer_ID#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#form.Delivery_Dealer_ID#"/>
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
				<cfinvokeargument name="comments" value="#form.Current_vehicle#"/>
				<cfinvokeargument name="sales_rep" value="#form.Sales_Rep#"/>
			</cfinvoke>
<!--- 
			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="4"/>
				<cfinvokeargument name="new_used" value="#form.VOI_New_Used#"/>
				<cfinvokeargument name="v_year" value="#form.VOI_Year#"/>
				<cfinvokeargument name="v_make" value="#form.VOI_Make#"/>
				<cfinvokeargument name="v_model" value="#form.VOI_Model#"/>
				<cfinvokeargument name="v_vin" value="#form.VOI_Vin#"/>
				<cfinvokeargument name="v_stock" value="#form.VOI_Stock#"/>
			</cfinvoke> --->

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_type_id#" maxlength="10">
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
				<cfinvokeargument name="first_name" value="#form.First_Name#"/>
				<cfinvokeargument name="last_name" value="#form.Last_Name#"/>
				<cfinvokeargument name="email" value="#form.Email#"/>
				<cfinvokeargument name="phone_1" value="#form.Phone_1#"/>
				<cfinvokeargument name="comments" value="#form.Current_Vehicle#"/>
				<cfinvokeargument name="sales_rep" value="#form.Sales_Rep#"/>
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
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.First_Name#"/>
				<cfinvokeargument name="last_name" value="#form.Last_Name#"/>
				<cfinvokeargument name="email" value="#form.Email#"/>
				<cfinvokeargument name="phone_1" value="#form.Phone_1#"/>
				<cfinvokeargument name="comments" value="#form.Current_Vehicle#"/>
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
			
			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" bcc="#variables.WD_BCC#" from="#variables.from_email#" subject="#variables.Email_Subject#">
						<cfmailparam name="Reply-To" value="#form.Email#">
						#variables.text_email#
						</cfmail>
						<!---<li>#Get_Lead_Addresses.Email# - Text</li>--->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" bcc="#variables.WD_BCC#" from="#variables.from_email#" subject="#variables.Email_Subject#">
						<cfmailparam name="Reply-To" value="#form.Email#">
						#variables.adf_email#
						</cfmail>
						<!---<li>#Get_Lead_Addresses.Email# - ADF</li>--->					
					</cfif>

				</cfloop>
			</cfif>
	
		</cfif>
	
	</cffunction>



</cfcomponent>