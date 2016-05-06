<cfcomponent>
	
	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_legend" default="Contact Us">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/gpada_app_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfquery name="Chk_AppType" datasource="GPADA" >
			SELECT	a.ID, a.application_type, a.image_1, a.header_text, a.header_link, a.header_link_text, a.header_text_2, a.dues_line, a.disclaimer, a.created_ts, a.active, a.notifications,
			b.description, b.active
			FROM    Application_Layout a, Application_Types b
			WHERE  	a.application_type = #url.app_type# 
			AND		a.application_type = b.ID
			AND 	a.active = 1
		</cfquery>
		
		<!--- 
		
		 ID, app_type, company, address, city, state, zip, phone, fax, cell, email_address, member_type, authorized_name, recipient_name, describe_business, signature, 
                      submitted_dt, status, archive

		 --->
		<div class="container" >
		<div class="row no-pad">
			<div class="col-md-6 " style="font-weight:BOLD;font-size:18pt" >                     
				#Chk_AppType.description#
			</div>
			<div class="col-md-6" >                     
				<img src="http://dealers.wdautos.com/dealer/gpadaapplication/images/icons/#Chk_AppType.image_1#" border="1" class="img-responsive">
			</div>
		</div>
		
		<div class="row  pad-bottom-10 "><div class="col-md-12 " >&nbsp; </div></div>
		
		<div class="row row-centered pad-top-10  pad-bottom-10 ">
			<div class="col-md-12 col-centered" style="font-weight:bold;font-size:13pt;align:center" >                     
				<p style="align:center">#Chk_AppType.header_text#</p>
			</div>
		</div>
		<div class="row row-centered pad-top-10  pad-bottom-10 ">
			<div class="col-md-12 col-centered" style="font-weight:bold;font-size:13pt" >                     
				<a href="#Chk_AppType.header_link#" target="_blank">#Chk_AppType.header_link_text#</a>
			</div>
		</div>
		
		<div class="row pad-bottom-10 "><div class="col-md-12 ">&nbsp; </div></div>				
		
		<div class="row    pad-bottom-10 ">
			<div class="col-md-12 " style="font-weight:normal;font-size:10pt" >                     
				#Chk_AppType.header_text_2#
			</div>
		</div>
				
		<form class="form-horizontal" action="#arguments.form_action#" method="post" enctype="multipart/form-data">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" id="app_type" name="app_type" value="#Chk_AppType.application_type#">
				<input type="hidden" id="email_recipients" name="email_recipients" value="#Chk_AppType.notifications#">
				<div class="form-group">
					<label class="control-label col-md-3" for="company"><span class="txt-red">*</span> Company</label>
					<div class="col-md-6">
						<input name="company" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="Company" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Address"><span class="txt-red">*</span> Mailing Address</label>
					<div class="col-md-6">
						<input name="Address" class="form-control input-md" id="Address" type="text" maxlength="50" placeholder="Mailing Address" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="city"><span class="txt-red">*</span> City</label>
					<div class="col-md-6">
						<input name="city" class="form-control input-md" id="city" type="text" minlength="10" maxlength="10" placeholder="City" required>
						<!--- <p class="help-block">Numbers Only - no hyphens or parentheses</p> --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="State"><span class="txt-red">*</span> State</label>
					<div class="col-md-6">
						<cfinvoke component="/cfcs/forms/form_states" method="standard">
							<cfinvokeargument name="state" value="#url.state#"/>
							<cfinvokeargument name="input_class" value="form-control input-md"/>
						</cfinvoke>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Zip"><span class="txt-red">*</span> Zip</label>
					<div class="col-md-6">
						<input name="Zip" class="form-control input-md" id="Zip" type="text" maxlength="5" placeholder="Zip" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="phone"><span class="txt-red">*</span> Telephone</label>
					<div class="col-md-6">
						<input name="phone" class="form-control input-md" id="phone" type="text" maxlength="30" placeholder="Telephone">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="fax">Fax</label>
					<div class="col-md-6">
						<input name="fax" class="form-control input-md" id="phone" type="fax" maxlength="30" placeholder="Fax">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="cell">Cell Phone</label>
					<div class="col-md-6">
						<input name="cell" class="form-control input-md" id="cell" type="fax" maxlength="30" placeholder="Cell Phone">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="email_address"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="email_address" class="form-control input-md" id="email_address" type="text" maxlength="100" placeholder="Email" required >
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="member_type"><span class="txt-red">*</span> Check One</label>
					<div class="col-md-6">
						<label class="radio-inline" for="member_type">
							<input name="member_type" id="member_type" type="radio" checked="checked" value="1">
							Corporation
						</label> 
						<label class="radio-inline" for="member_type">
							<input name="member_type" id="member_type" type="radio" value="2">
							Partnership
						</label>
						<label class="radio-inline" for="member_type">
							<input name="member_type" id="member_type" type="radio" value="3">
							Individual (Proprietorship)
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="authorized_name"><span class="txt-red">*</span> Authorized Person:</label>
					<div class="col-md-6">
						<textarea name="authorized_name" class="form-control input-md" id="authorized_name" col="100" rows="3" placeholder="Name of person authorized to represent the firm for Association purposes"   maxlength="1000" required></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="recipient_name"><span class="txt-red"> </span> Publications and Correspondence:</label>
					<div class="col-md-6">                     
						<textarea name="recipient_name" class="form-control input-md" id="recipient_name" col="100" rows="3" placeholder="Name and address, if different than above, of person to whom publications and correspondence should be sent" maxlength="1000" ></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="describe_business"><span class="txt-red"> </span> Brief Description of type of business</label>
					<div class="col-md-6">                     
						<textarea name="describe_business" class="form-control input-md" id="describe_business" col="100" rows="4" placeholder="Business Description" maxlength="1000"  ></textarea>
					</div>
				</div>
				<div class="row row-centered pad-top-10  pad-bottom-10 ">
					<div class="col-md-12 col-centered" style="font-weight:bold;font-size:13pt" >                     
						#UCase(Chk_AppType.dues_line)#
					</div>
				</div>
				<div class="row  pad-top-10  pad-bottom-10 ">
					<div class="col-md-12 " style="font-weight:normal;font-size:12pt" >                     
						#Chk_AppType.disclaimer#
					</div>
				</div>
				<div class="row  pad-top-10  pad-bottom-10 "><div class="col-md-12 " style="font-weight:normal;font-size:10pt" >&nbsp; </div></div>
				<div class="form-group">
					<label class="control-label col-md-3" for="signature"><span class="txt-red">*</span> Signature</label>
					<div class="col-md-6">
						<input name="signature" class="form-control input-md" id="signature" type="text" maxlength="100" placeholder="Type your Email Address as your Signature" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="submitted_dt">Date Submitted</label>
					<div class="col-md-6">
						<input name="submitted_dt" class="form-control input-md" id="submitted_dt" type="text" maxlength="20" value="#dateformat(now(),"mm/dd/yyyy")#" >
					</div>
				</div>
				
				<div class="form-group">
					
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6" align="right" >
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="SUBMIT APPLICATION"> 
					</div>
				</div>
			</fieldset>
		</form>
</div>
	</cffunction>

	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="GPADA">
		<!--- 
		 ID, app_type, company, address, city, state, zip, phone, fax, cell, email_address, member_type, authorized_name, recipient_name, describe_business, signature, 
                      submitted_dt, status, archive
		 --->
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.app_type" default="">
		<cfparam name="form.company" default="">
		<cfparam name="form.address" default="">
		<cfparam name="form.city" default="">
		<cfparam name="form.state" default="">
		<cfparam name="form.zip" default="">
		<cfparam name="form.phone" default="">
		<cfparam name="form.fax" default="">
		<cfparam name="form.cell" default="">
		<cfparam name="form.email_address" default="">
		<cfparam name="form.member_type" default="">
		<cfparam name="form.authorized_name" default="">
		<cfparam name="form.recipient_name" default="yes">
		<cfparam name="form.describe_business" default="yes">
		<cfparam name="form.signature" default="">

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.company --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Company"/>
			<cfinvokeargument name="text_value" value="#form.company#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.email_address#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Address 1: form.address_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Address"/>
			<cfinvokeargument name="text_value" value="#form.address#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="false"/>
		</cfinvoke>
		<!--- City: form.city --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="City"/>
			<cfinvokeargument name="text_value" value="#form.city#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- State: form.state --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="State"/>
			<cfinvokeargument name="text_value" value="#form.state#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- Zip: form.zip --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Zip"/>
			<cfinvokeargument name="text_value" value="#form.zip#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<cfset url.error_message=variables.error_message>

		<cfelse>


		 <cfquery NAME="InsApp" datasource="GPADA">
		  INSERT into Applications ( 	app_type, company, address, city, state, zip, phone, fax, cell, email_address, member_type, authorized_name, recipient_name, describe_business, signature, 
                      					submitted_dt  )
		  							VALUES ( 	#Form.app_type#,
												'#Form.company#',
												'#Form.address#',
												'#Form.city#',
												'#Form.state#',
												'#Form.zip#',
												'#Form.phone#',
												'#Form.fax#',
												'#Form.cell#',
												'#Form.email_address#',
												#Form.member_type#,
												'#Form.authorized_name#',
												'#Form.recipient_name#',
												'#Form.describe_business#',
												'#Form.signature#',
												#createODBCDateTime(now())# )
		</cfquery>
		<cfquery datasource="GPADA" name="qryLast_id">SELECT A.ID FROM Applications A ORDER BY A.ID DESC</cfquery>
		<cfset Last_id = #qryLast_id.ID#>  
		
		
			<!---Generate Text Email--->
 
		<cfparam name="recipient_list" default="#Form.email_recipients#">
		<cfparam name="variables.Email_Subject" default="Membership Application from GPADA Site">
		<cfparam name="variables.From_Email" default="leads@worlddealer.net">
		<cfparam name="variables.WD_BCC" default="">
  		
		<cfmail to="#recipient_list#" from="leads@worlddealer.net" bcc="bob@worlddealer.net" type="HTML" subject="#variables.Email_Subject#">  
			<table  align="left" >
				<tr><td colspan="2">The following has completed an online Membership Application.</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>Application ID:</td><td align="left" > #Last_id#</td></tr>
				<tr><td>Company:</td><td align="left" > #form.company#</td></tr>
				<tr><td>Address:</td><td align="left" >#form.address#</td></tr>
				<tr><td>City/State/Zip:</td><td align="left" >#form.City# #form.State# #form.zip#</td></tr>
				<tr><td>Phone:</td><td align="left" > #form.phone#</td></tr>
				<tr><td>Fax:</td><td align="left" > #form.fax#</td></tr>
				<tr><td>Cell Phone:</td><td align="left" > #form.cell#</td></tr>
				<tr><td>Email:</td><td align="left" >#form.email_address#</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>Authorized Person:</td><td align="left" >#form.authorized_name#</td></tr>
				<tr><td>Recipient Name:</td><td align="left" >#form.recipient_name#</td></tr>
				<tr><td>Description:</td><td align="left" >#form.describe_business#</td></tr>
				<tr><td>Signature Price:</td><td align="left" >#form.signature#</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>Submitted:</td><td align="left" >#timeformat(now(),"hh:mm tt")# on #dateformat(now(),"mm/dd/yyyy")#</td></tr>
			</table>
		</cfmail>
		
		<cfset url.appl_id = #Last_id# >
		
		<cfoutput>
			<body onLoad="document.paypal_form.submit();">
	
			<form method="post" name="paypal_form" action="https://www.paypal.com/cgi-bin/webscr" >
	 
				<!--- PayPal Configuration ---> 
				<input type="hidden" name="business" value="JP@GPADA.com"> 
				<input type="hidden" name="cmd" value="_xclick"> 
				<input type="hidden" name="image_url" value="">
				<input type="hidden" name="cancel_url" value="/paypal/pp_toolkit/error.cfm">
				<input type="hidden" name="success_url" value="/paypal/pp_toolkit/success.cfm">
				<input type="hidden" name="return" value="2">
				<input type="hidden" name="cancel_return" value="http://www.40ultra10.wddemos.com">
				<input type="hidden" name="notify_url" value="/paypal/pp_toolkit/ipn/ipn.cfm">
				<input type="hidden" name="rm" value="2">
				<input type="hidden" name="currency_code" value="USD">
				<input type="hidden" name="lc" value="US">
				<input type="hidden" name="bn" value="toolkit-cfm">
				<input type="hidden" name="cbt" value="<Continue >>">
				  
				<!--- Payment Page Information ---> 
				<input type="hidden" name="no_shipping" value="">
				<input type="hidden" name="no_note" value="1">
				<input type="hidden" name="cn" value="Comments"> 
				<input type="hidden" name="cs" value="">
				 
				<!--- Product Information ---> 
				<input type="hidden" name="item_name" value="#Form.item_name#">
				<input type="hidden" name="amount" value="#Form.amount#">
				<input type="hidden" name="quantity" value="#Form.quantity#"> 
				<input type="hidden" name="item_number" value="#Form.item_number#">
				<input type="hidden" name="undefined_quantity" value="">
				<input type="hidden" name="on0" value="#Form.on0#">
				<input type="hidden" name="os0" value="#Form.os0#">
				<input type="hidden" name="on1" value="#Form.on1#">
				<input type="hidden" name="os1" value="#Form.os1#">
				
				<!--- Shipping and Misc Information ---> 
				<input type="hidden" name="shipping" value="">
				<input type="hidden" name="shipping2" value="">
				<input type="hidden" name="handling" value="">
				<input type="hidden" name="tax" value="">
				<input type="hidden" name="invoice" value="">
				
				<!--- Customer Information ---> 
				<input type="hidden" name="first_name" value="#Form.company#"> 
				<input type="hidden" name="last_name" value=""> 
				<input type="hidden" name="address1" value="#Form.address#"> 
				<input type="hidden" name="address2" value=""> 
				<input type="hidden" name="city" value="#Form.city#"> 
				<input type="hidden" name="state" value="#Form.state#"> 
				<input type="hidden" name="zip" value="#Form.zip#"> 
				<input type="hidden" name="email" value="#Form.email#"> 
				<input type="hidden" name="night_phone_a" value="#Form.phone#"> 
				<input type="hidden" name="night_phone_b" value=""> 
				<input type="hidden" name="night_phone_c" value=""> 
				<input type="hidden" name="customer_ID" value="#Last_id#"> 
				<input type="hidden" name="custom" value="#Last_id#">
	  
		</form> 
	</cfoutput>

		</cfif>

	</cffunction>

</cfcomponent>