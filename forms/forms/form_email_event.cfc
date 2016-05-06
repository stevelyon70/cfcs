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
	    <div class="row">

			<div class="col-md-7  visible-sm visible-xs  visible-lg visible-md" >	
		    	<img src="http://dealers.wdautos.com/dealer/baierl/images/library/2016MalibuEvent_FormGraphic.jpg" width="100%" alt="Chevrolet Malibu Launch Event on March 10th"/>
			</div>
				
			<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md"   >	
				<div class="register_title" >2016 Chevy Malibu Reveal - RSVP here</div>
				<!--- <span class="register_text" >Fill out the form below</span> --->
				<form action="#arguments.form_action#" method="post">
					<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
					<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
					<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First & Last Name" required>
<!--- 					<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* Last Name" required> --->
					<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:10px" maxlength="100" placeholder="* Email" required>
					<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:10px" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
					<input class="#arguments.input_class#" name="Guests" id="Guests" type="text" style="margin-bottom:10px" maxlength="50" placeholder="## of Guests (including yourself)" required>
					
					<br><input class="register-go-btn pull-right"   name="Submit" id="Submit"   type="submit" value="Register Now">
				</form>
			</div>			

        </div>  <!--- End ROW --->

	</cffunction>
	




	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="false">
		<cfargument name="email_subject" default="Malibu Launch Event Notification from Baierl.com">

		<!--- defaults --->
		<cfset variables.WD_BCC="wdsupport@worlddealer.net">
		<cfset variables.from_email="registration@Baierl.com">
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
			 <cfset recipient = "micheleedymkoski@baierl.com" > 
			<!--- <cfset recipient = "#form.Email#" > --->
			
			
			
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
	
		</cfif>
	
	</cffunction>



</cfcomponent>