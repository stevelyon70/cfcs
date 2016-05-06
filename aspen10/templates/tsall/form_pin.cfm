<cfparam name="attributes.mod_action" default="none">
<cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">
<cfset variables.subject="Thank you for submitting your information to SureAutoLoanLink.com!">
<cfset variables.lead_subject="PIN Submission from SureAutoLoanLink.com">
<cfset variables.from="info@sureautoloanlink.com">
<cfset variables.mail_server="info@tradeinprogram.com:H3L1c0pt3r!@mail.greatmail.com">
<!--- <cfset variables.mail_server="leads@worlddealerinc.com:Aspen12@smtp.emailsrvr.com"> --->
<cfparam name="url.first_name" default="">
<cfparam name="url.last_name" default="">
<cfparam name="url.phone" default="">
<cfparam name="url.email" default="">
<cfparam name="attributes.Directory" default="0">
<cfparam name="attributes.Assets_Directory" default="0">

<cfswitch expression="#attributes.mod_action#">

<cfdefaultcase><!--- Default Form Display --->
	<cfoutput>
	<form id="splash-form" name="splash-form" action="index.cfm?page_action=pin_submit" method="post">
	<p class="splash-form-p"><label class="info-label" for="pin">PIN :</label><input class="info-input" id="pin" name="pin" maxlength="11" value="#url.Pin#" type="text"/></p>
	<p class="splash-form-p"><label class="info-label" for="first_name">First Name :</label><input class="info-input" id="first_name" name="first_name" value="#url.first_name#" maxlength="50" type="text"/></p>
	<p class="splash-form-p"><label class="info-label" for="last_name">Last Name :</label><input class="info-input" id="last_name" name="last_name" value="#url.last_name#" maxlength="50" type="text"/></p>
	<p class="splash-form-p"><label class="info-label" for="email">Email :</label><input class="info-input" id="email" name="email" value="#url.email#" maxlength="100" type="text"/></p>
	<p class="splash-form-p"><label class="info-label phone" for="phone">Phone :</label><input class="info-input phone" id="phone" name="phone" value="#url.phone#" maxlength="14" type="text"/></p>
	<p class="splash-form-p"><input class="submit-btn" type="submit" value="Submit"/></p>
	</form>
	</cfoutput>
</cfdefaultcase>

<cfcase value="submit"><!--- Form Action --->

	<cfparam name="form.pin" default="0">
	<cfparam name="form.first_name" default="">
	<cfparam name="form.last_name" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.email" default="">
	<cfparam name="variables.MyID" default="0">
	<cfparam name="variables.error" default="0">
	<cfparam name="Get_Cust_Info.Dealercode" default="">
	<cfset variables.MyID=replace(createUUID(),'-','','all')>
	
	<cfif 	len(trim(form.pin)) neq 0 and form.Pin neq "0"
			and len(trim(form.first_name)) neq 0
			and len(trim(form.last_name)) neq 0
			and isvalid("email",form.email) eq "Yes" 
			and isvalid("telephone",form.phone) eq "Yes">

			<cftransaction>
				<cfquery datasource="Ultra8" name="Check_Pin">
					SELECT     	Dealercode,
								Pin,
								First_Name,
								Last_Name,
								Address,
								City,
								State,
								Zip
					FROM		SALL_Pins
					WHERE		Pin=<cfqueryparam value="#form.pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="11">
					AND			Dealercode like '0102%'
					AND			Active=1
					AND			Date_Expires >= '#dateformat(now(),"mm/dd/yyyy")#'
				</cfquery>
				
				<cfif Check_Pin.Recordcount gt 0>
					<cfquery datasource="Ultra8" name="Insert_LEAD">
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
							Zip)
						VALUES
							(<cfqueryparam value="#Check_Pin.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
							<cfqueryparam value="#Check_Pin.Pin#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
							<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
							<cfqueryparam value="#form.phone#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
							<cfqueryparam value="#Check_Pin.First_Name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#Check_Pin.Last_Name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#Check_Pin.Address#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
							<cfqueryparam value="#Check_Pin.City#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#Check_Pin.State#" cfsqltype="CF_SQL_VARCHAR" maxlength="2">,
							<cfqueryparam value="#left(Check_Pin.Zip,5)#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
					</cfquery>
				<cfelse>
					<cfset variables.error=1>
				</cfif>
			</cftransaction>
	
	<cfelse>
	
		<cfset variables.error=1>
	
	</cfif>
	
	<cfif variables.error eq "0">

		<cfquery datasource="Ultra8" name="Get_SALL_Dealer">
			SELECT		SALL_Leads.SALL_Lead_ID,
						SALL_Leads.Dealercode,
						SALL_Leads.PIN,
						Dealers.Display_Name,
						Dealers.Address_1,
						Dealers.Address_2,
						Dealers.City,
						Dealers.State,
						Dealers.Zip, 
						Dealers.Primary_Phone
			FROM		SALL_Leads
			INNER JOIN	Dealers
			ON			SALL_Leads.Dealercode = Dealers.Dealercode
			WHERE		SALL_Leads.MyID=<cfqueryparam value="#variables.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
		
		<cfmail <!--- server="#variables.mail_server#" ---> to="#form.Email#" from="#variables.from#" subject="#variables.subject#" bcc="#variables.WD_BCC#" type="HTML">
			<table style="width:650px;background-color:##8C2020;color:##fff;font:normal 12px arial" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2"><img src="http://#cgi.server_name#/dealer/#attributes.Assets_Directory#/templates/#attributes.Directory#/images/header_email.jpg"></td>
				</tr>
				<tr>
					<td colspan="2" style="padding:30px 10px 30px 10px">
						Thank you for submitting your information to <strong>Sure Auto Loan Link</strong>! We will be contacting you shortly to discuss your loan options. However, if you would like to contact us immediately, we have provided an email contact link and phone number with this message. Also, don�t hesitate to search our inventory by clicking on the convenient link.<br/><br/>
						We have had success helping car buyers with bad credit, slow credit, bankruptcies, repossessions and 1st time buyers get into a new vehicle or pre-owned vehicle. <strong>100% approval is our goal!</strong>
					</td>
				</tr>
				<tr>
				<td style="padding:0px 10px 10px 10px;color:##ff0;width:50%" valign="top">
					<div style="font:bold 20px arial">#Get_SALL_Dealer.Display_Name#</div>
					<cfif Get_SALL_Dealer.Display_Name neq "Easterns Automotive Group">
						#Get_SALL_Dealer.Address_1#<br/>
						#Get_SALL_Dealer.City#, #Get_SALL_Dealer.State# #numberformat(Get_SALL_Dealer.Zip,"00000")#<br/>
						<div style="font:bold 20px arial">PHONE : #Get_SALL_Dealer.Primary_Phone#</div>
					</cfif>
				</td>
				<td style="padding:0px 10px 10px 10px;width:50%" valign="top">
					<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:##ff0;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
					<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:##ff0;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#variables.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div>
				</td>
				</tr>
			</table>
		</cfmail>

		<cfmodule template="/global/leads/get_addresses.cfm" Dealercode="#Get_SALL_Dealer.Dealercode#" lead_type="Contact_General" pin="#Get_SALL_Dealer.PIN#">
		
		<cfif Get_Emails_TXT.Recordcount neq 0>
			<cfloop query="Get_Emails_TXT">
				<cfmail <!--- server="#variables.mail_server#" ---> to="#Get_Emails_TXT.Text_Email#" from="#variables.from#" bcc="#variables.WD_BCC#" subject="#variables.lead_subject#">
					<cfmailparam name="Reply-To" value="#form.Email#">
					Name: #form.First_Name# #form.Last_Name#
					Phone: #form.Phone#
					Email: #form.Email#
					PIN: #Get_SALL_Dealer.Pin#
					Dealer: #Get_SALL_Dealer.Display_Name#
					Lead ID: #Get_SALL_Dealer.SALL_Lead_ID#
				</cfmail>
				<cfswitch expression="#Get_SALL_Dealer.Dealercode#">
					<cfcase value="0102-0001-999-01-C3E00CAA1C">
						<cfif form.Email neq Get_Emails_TXT.Text_Email>
							<cfmail <!--- server="#variables.mail_server#" ---> to="#form.Email#" from="#variables.from#" bcc="#variables.WD_BCC#" subject="#variables.lead_subject#">
								<cfmailparam name="Reply-To" value="#Get_Emails_TXT.Text_Email#">
								Name: #form.First_Name# #form.Last_Name#
								Phone: #form.Phone#
								Email: #form.Email#
								PIN: #Get_SALL_Dealer.Pin#
								Dealer: #Get_SALL_Dealer.Display_Name#
								Lead ID: #Get_SALL_Dealer.SALL_Lead_ID#
							</cfmail>
						</cfif>
					</cfcase>
				</cfswitch>
			</cfloop>
		</cfif>
		
		<!--- Write ADF --->
		<cfset variables.adf_xml="">
		<cfset variables.newline="#chr(10)#">
		<!--- Setup Header --->
		<cfmodule 	template="/global/adf/adf_header.cfm"
					Lead_ID="#Get_SALL_Dealer.SALL_Lead_ID#">
		<cfset variables.adf_xml=variables.adf_xml & "#variables.header_xml#">
		<!--- Setup Customer --->
		<cfmodule 	template="/global/adf/adf_customer.cfm"
					c_fname="#form.First_Name#"
					c_lname="#form.Last_Name#"
					c_email="#form.Email#"
					c_phone="#form.Phone#"
					c_comments="PIN: #Get_SALL_Dealer.Pin#">
		<cfset variables.adf_xml=variables.adf_xml & "#variables.customer_xml#">
		<!--- Setup Vendor --->
		<cfmodule 	template="/global/adf/adf_vendor.cfm"
					Dealercode="#attributes.Dealercode#">
		<cfset variables.adf_xml=variables.adf_xml & "#variables.vendor_xml#">
		<!--- Setup Provider --->
		<cfmodule template="/global/adf/adf_provider.cfm" Dealercode="#attributes.Dealercode#">
		<cfset variables.adf_xml=variables.adf_xml & "#variables.provider_xml#">
		<!--- Setup Footer --->
		<cfmodule template="/global/adf/adf_footer.cfm">
		<cfset variables.adf_xml=variables.adf_xml & "#variables.footer_xml#">

		<cfif Get_Emails_ADF.Recordcount neq 0>
			<cfloop query="Get_Emails_ADF">
				<cfmail <!--- server="#variables.mail_server#" ---> to="#Get_Emails_ADF.ADF_Email#" from="#variables.from#" bcc="#variables.WD_BCC#" subject="#variables.lead_subject#">
					<cfmailparam name="Reply-To" value="#form.Email#">
					#variables.adf_xml#
				</cfmail>
			</cfloop>
		</cfif>
		
		<cflocation url="index.cfm?page_action=appointment&MyID=#variables.MyID#">
		
	<cfelse>
		<!--- If there is an error recognizing the PIN - notify the user and support --->
		<cfif form.Pin neq "22000-14183">
			<!--- If there is an error recognizing the PIN - notify the user and support --->
			<cfmail <!--- server="info@tradeinprogram.com:H3L1c0pt3r!@mail.greatmail.com" ---> to="wdsupport@worlddealer.net,mikekosior@worlddealer.net" from="SALLERRORS@worlddealer.net" subject="Invalid SALL PIN">
				NOTICE!
				The following Invalid PIN information has been entered for a SALL program.
	
				PIN: #form.Pin#
				First Name: #form.First_Name#
				Last Name: #form.Last_Name#
				Phone: #form.Phone#
				Email: #form.Email#
				Browser: #cgi.HTTP_USER_AGENT#
				IP: #cgi.REMOTE_ADDR#
				
				This lead has not been delivered!
				Please check the area code entered vs which dealers we have in the system and verify that all dealers in that area have valid PINs.
				If you indeed believe this is a valid attempt to use the system and a dealer doesn't have PIN, please contact Aspen IMMEDIATELY with the dealer information.
				
				This could be a typo on the user's part.
				This could be somebody testing the system.
				This could also be somebody messing with the system.
				We need to rule out all possibilities.
			</cfmail>
		</cfif>
		<cflocation url="index.cfm?page_action=pin_error&pin=#form.Pin#&first_name=#form.first_name#&last_name=#form.last_name#&phone=#form.phone#&email=#form.email#">
	</cfif>
	
</cfcase>
</cfswitch>