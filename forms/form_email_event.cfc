<cfcomponent>
	<cffunction name="email_event_page" description="Email Event form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="price_search">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/email_event_action.cfm">
		<cfargument name="voi_new_used" default="">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="register-btn">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
				
		<cfset err_style = "" >
		<cfif IsDefined("url.err_msg") and #len(url.err_msg)# GT 0 >
			<cfset err_style = "background-color:yellow" >
		</cfif>
		
		<cfset t_voi_vin = ""><cfset t_voi_new_used = ""><cfset t_voi_year = "">
		<cfset t_voi_make = "">	<cfset t_voi_model = ""><cfset t_voi_stock = "">
		<!--- <cfif left(cgi.remote_addr,13) eq "172.16.25.112" and IsDefined("voi_vin") > --->
		<cfif #url.dealer_id# EQ 365 and IsDefined("url.vin") >
			<cfquery datasource="ultra10" name="get_car">SELECT vin, stock,v_new_used, v_make,v_model,v_year FROM vehicles WHERE dealer_id = 365 AND vin='#url.vin#' </cfquery>
			<cfif #get_car.recordcount# NEQ 0 >
				<cfset t_voi_vin = "#get_car.vin#"><cfset t_voi_new_used = "#get_car.v_new_used#"><cfset t_voi_year = "#get_car.v_year#">
				<cfset t_voi_make = "#get_car.v_make#"><cfset t_voi_model = "#get_car.v_model#"><cfset t_voi_stock = "#get_car.stock#">
			</cfif>
		</cfif>

	    <div class="row">

			<div class="col-md-7  visible-sm visible-xs  visible-lg visible-md" >	
			<cfif #arguments.dealer_id# NEQ 365 >
		    	<img src="http://dealers.wdautos.com/dealer/baierl/images/library/2016MalibuEvent_FormGraphic.jpg" width="100%" alt="Chevrolet Malibu Launch Event on March 10th"/>
			<cfelse>
				 <cfif left(cgi.remote_addr,13) eq "172.16.25.112" >#t_voi_vin# - #t_voi_new_used# - #t_voi_year# - #t_voi_make# - #t_voi_model#  </cfif>   
		    	<img src="http://dealers.wdautos.com/dealer/kellynissan_bld/images/icons/form_MothersDaySpecial.jpg" width="100%" alt="Mother's Day Weekend Special"/>
			</cfif>
			</div>
				
			<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md"   >	
			<cfif #arguments.dealer_id# NEQ 365 >
				<div class="register_title" >2016 Chevy Malibu Reveal - RSVP here</div>
			<cfelse>
				<div class="register_title" >Complete this form to qualify for TV Offer. <br />Hurry Offer ends 5/9/2016.</div>	
				
			</cfif>	
				<!--- <span class="register_text" >Fill out the form below</span> --->
				<form action="#arguments.form_action#" method="post">
					<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
					<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
					<input type="hidden" name="voi_vin" id="voi_vin" value="#t_voi_vin#">
					<input type="hidden" name="voi_new_used" id="voi_new_used" value="#t_voi_new_used#">
					<input type="hidden" name="voi_year" id="voi_year" value="#t_voi_year#">
					<input type="hidden" name="voi_make" id="voi_make" value="#t_voi_make#">
					<input type="hidden" name="voi_model" id="voi_model" value="#t_voi_model#">
					<input type="hidden" name="voi_stock" id="voi_stock" value="#t_voi_stock#">
			<cfif #arguments.dealer_id# NEQ 365 AND  #arguments.dealer_id# NEQ 358 >
					<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First & Last Name" required>
			<cfelse>
					<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First Name" required>
 					<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* Last Name" required> 
			</cfif>
					<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:10px" maxlength="100" placeholder="* Email" required>
					<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:10px" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
			<cfif #arguments.dealer_id# NEQ 365 >
					<input class="#arguments.input_class#" name="Guests" id="Guests" type="text" style="margin-bottom:10px" maxlength="50" placeholder="## of Guests (including yourself)" required>
			</cfif>		
					<cfif #arguments.dealer_id# NEQ 365 AND  #arguments.dealer_id# NEQ 358 >
					<br><input class="register-go-btn pull-right"   name="Submit" id="Submit"   type="submit" value="Register Now">
					<cfelse>
					<div style="align:center!important"><input class="register-go-btn"   name="Submit" id="Submit"   type="submit" value="Submit"></div>
					</cfif>
				</form>
				
				<cfif #arguments.dealer_id# EQ 365 >
				 
					<div class="register_big_button_container" style="align:center;margin-top:10px!important" >
						<div class="register_big_button_text">
                        	<a href="http://kellynissanofroute33.com/new/offers.cfm" >
                            	<img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/btn_NewSpecials.png" width="100%" alt="Spring into Savings Sales Event"/>
                            </a>
                        </div>
						<!---<div class="register_big_button_text"><a href="http://kellynissanofroute33.com/used/special_offers.cfm" ><img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/btn_UsedSpecials.jpg" width="100%" alt="Spring into Savings Sales Event"/></a></div>--->
					</div>	
						
				</cfif>			
			</div>		
				

        </div>  <!--- End ROW --->

	</cffunction>
	




	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="false">
		<cfargument name="email_subject" default="Event Notification from ???.com">
		
		<cfif #url.dealer_id# NEQ 365 and #url.dealer_id# NEQ 358 >
			<cfset arguments.email_subject = "Malibu Launch Event Notification from Baierl.com">
		<cfelseif #url.dealer_id# EQ 365>	
			<cfset arguments.email_subject = "Mothers Day Weekend Special Notification from KellyNissanofRoute33.com">
		<cfelseif #url.dealer_id# EQ 358>	
			<cfset arguments.email_subject = "Mothers Day Weekend Special Notification from Save.KellyNissanofRoute33.com">
		</cfif>
		<!--- defaults --->
		<cfset variables.WD_BCC="wdsupport@worlddealer.net">
		<cfif #url.dealer_id# NEQ 365 and #url.dealer_id# NEQ 358 >
			<cfset variables.from_email="registration@Baierl.com">
		<cfelse>
			<cfset variables.from_email="registration@KellyNissanofRoute33.com">
		</cfif>	
		<cfparam name="variables.Email_Subject" default="#arguments.email_subject#">
	
		<cfparam name="form.Dealer_ID" default="#arguments.dealer_id#">
		<cfparam name="form.Delivery_Dealer_ID" default="#arguments.dealer_id#">
		<cfparam name="form.First_Name" default="">
		<cfparam name="form.Last_Name" default="">
		<cfparam name="form.Phone_1" default="">
		<cfparam name="form.Email" default="">
		<cfparam name="form.Guests" default="0">

		<!--- <cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke> --->

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
		
		<!--- Email: form.Email --->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.Email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke> --->
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.Phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		
		<cfif listlen(variables.error_message) gt 0>
	
			<cfset url.error_message=variables.error_message>

		<cfelse>
			<!---Generate Text Email--->
		<cfif #url.dealer_id# NEQ 365 and #url.dealer_id# NEQ 358 >
			 <cfset recipient = "MicheleDymkoski@Baierl.com,KatePakler@Baierl.com" > 
		<cfelse>
			 <cfset recipient = "bob@worlddealer.net" > 
		</cfif>	 
			 
			<!--- <cfset recipient = "#form.Email#" > --->
			
		<cfif #url.dealer_id# NEQ 365 and #url.dealer_id# NEQ 358 >
			<cfmail to="#recipient#" bcc="#variables.WD_BCC#" from="#variables.from_email#"  type="HTML" subject="#variables.Email_Subject#">		
				<table cellpadding="0" width="70%" cellspacing="0">
					<tr>
						<td align="left" > 
							Name: #form.First_Name#<br>
							Phone: #form.Phone_1#<br>
							Email: #form.Email#<br> 
							## of Guests: #form.guests# <br><br>
							 
							
							Date Sent: #dateformat(now(), "mm/dd/yyyy")#&nbsp;@&nbsp;#timeformat(now(), "hh:mm tt")#
						 </td>
					</tr>
					<tr><td>&nbsp;</td></tr>
				</table>  
			</cfmail>
		<cfelse>
			<cfmail to="#recipient#" from="#variables.from_email#"  type="HTML" subject="#variables.Email_Subject#">	
			
				<table cellpadding="0" width="70%" cellspacing="0">
					<tr>
						<td align="left" > 
							Name: #form.First_Name#<br>
							Phone: #form.Phone_1#<br>
							Email: #form.Email#<br>
							<br><br>
							
							Date Sent: #dateformat(now(), "mm/dd/yyyy")#&nbsp;@&nbsp;#timeformat(now(), "hh:mm tt")#
						 </td>
					</tr>
					<tr><td>&nbsp;</td></tr>
				</table>  
			</cfmail>
		</cfif>		
		</cfif>
	
	</cffunction>

	

	<cffunction name="form_submit_event" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="email_subject" default="Event Notification from #lcase(cgi.Server_Name)#">
		<cfif #url.dealer_id# EQ 365>	
			<cfset arguments.email_subject = "Mothers Day Weekend Special Notification from KellyNissanofRoute33.com">
		<cfelseif #url.dealer_id# EQ 358>	
			<cfset arguments.email_subject = "Mothers Day Weekend Special Notification from Save.KellyNissanofRoute33.com">
		</cfif>
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