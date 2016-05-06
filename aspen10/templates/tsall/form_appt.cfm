<cfparam name="attributes.mod_action" default="none">
<cfset variables.WD_BCC="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">
<cfset variables.subject="SureAutoLoanLink.com : Financial Advisor Appointment Confirmation">
<cfset variables.lead_subject="Appointment Registration from SureAutoLoanLink.com">
<cfset variables.from="info@sureautoloanlink.com">
<cfset variables.mail_server="info@tradeinprogram.com:H3L1c0pt3r!@mail.greatmail.com">
<!--- <cfset variables.mail_server="leads@worlddealerinc.com:Aspen12@smtp.emailsrvr.com"> --->
<cfparam name="attributes.Directory" default="0">
<cfparam name="attributes.Assets_Directory" default="0">

<cfswitch expression="#attributes.mod_action#">
	
	<cfdefaultcase><!--- Default Form Display --->
		<cfoutput>
			<h2 class="step-note">&nbsp;</h2>
			<form id="info-form" name="info-form" action="index.cfm?page_action=submit_appt" method="post">
				<input type="hidden" name="MyID" value="#url.MyID#"/>
				<p class="splash-form-p">
					<label class="info-label" for="age">Age :</label>
					<select class="info-input" name="age" id="age">
						<option value="">Select</option>
						<option value="18-25">18 - 25</option>
						<option value="26-40">26 - 40</option>
						<option value="41-55">41 - 55</option>
						<option value="56-64">56 - 64</option>
						<option value="65 or Older">65 or Older</option>
					</select>
				</p>
				<p class="splash-form-p">
					<label class="info-label" for="income">Income :</label>
					<select class="info-input" name="income" id="income">
						<option value="">Select</option>
						<option value="$0-$10000">$0 - $10,000</option>
						<option value="$10000-$20000">$10,000 - $20,000</option>
						<option value="$20000-$35000">$20,000 - $35,000</option>
						<option value="$35000-$50000">$35,000 - $50,000</option>
						<option value="$50000-$65000">$50,000 - $65,000</option>
						<option value="$65000-$80000">$65,000 - $80,000</option>
						<option value="Above $80000"> Above $80,000</option>
					</select>
				</p>
				<p class="splash-form-p">
					<label class="info-label" for="emp">Employment :</label>
					<select class="info-input" name="emp" id="emp">
						<option value="">Select</option>
						<option value="0 - 6 Months">0 - 6 Months</option>
						<option value="6 Months - 2 Years">6 Months - 2 Years</option>
						<option value="2 Years - 5 Years">2 Years - 5 Years</option>
						<option value="5 Years - 10 Years">5 Years - 10 Years</option>
						<option value="10 Years or More">10 Years or More</option>
					</select>
				</p>
				<p class="splash-form-p"><label class="info-label" for="date">Appointment Date : </label><input class="info-inputd date" name="date" id="date" type="text" maxlength="15"/></p>
				<p class="splash-form-p">
					<label class="info-label" for="time">Appointment Time : </label>
					<select class="info-input" name="time" id="time">
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
				</p>
				<p class="splash-form-p"><input class="submit-btn" type="submit" value="Submit"/></p>
			</form>
		</cfoutput>
	</cfdefaultcase>
	
	<cfcase value="submit">

		<cfparam name="form.myid" default="0">
		<cfparam name="form.age" default="">
		<cfparam name="form.emp" default="">
		<cfparam name="form.income" default="">
		<cfparam name="form.date" default="">
		<cfparam name="form.time" default="">
		<cfquery datasource="Ultra8" name="Get_SALL_Dealer">
			SELECT		SALL_Leads.SALL_Lead_ID,
						SALL_Leads.Dealercode,
						SALL_Leads.PIN,
						SALL_Leads.First_Name,
						SALL_Leads.Last_Name,
						SALL_Leads.Email,
						SALL_Leads.Phone,
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
			WHERE		SALL_Leads.MyID=<cfqueryparam value="#form.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
		<cfif	len(trim(form.myid)) neq 0 and form.myid neq "0"
				and len(trim(form.age)) neq 0
				and len(trim(form.emp)) neq 0
				and len(trim(form.income)) neq 0
				and len(trim(form.date)) neq 0
				and len(trim(form.time)) neq 0>
				
				<cfquery datasource="Ultra8" name="Insert_Trade">
					UPDATE	SALL_Leads
					SET		Age=<cfqueryparam value="#form.age#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
							Employment=<cfqueryparam value="#form.emp#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
							Income=<cfqueryparam value="#form.income#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
							Fin_App_Date=<cfqueryparam value="#form.date#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
							Fin_App_Time=<cfqueryparam value="#form.time#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
					WHERE	MyID=<cfqueryparam value="#form.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
				</cfquery>
					
				<cfmail <!--- server="#variables.mail_server#" ---> to="#Get_SALL_Dealer.Email#" from="#variables.from#" subject="#variables.subject#" bcc="#variables.WD_BCC#" type="HTML">
					<table style="width:650px;background-color:##8C2020;color:##fff;font:normal 12px arial" cellpadding="0" cellspacing="0">
						<tr><td colspan="2"><img src="http://#cgi.server_name#/dealer/#attributes.Assets_Directory#/templates/#attributes.Directory#/images/header_email.jpg"></td></tr>
						<tr>
							<td colspan="2" style="padding:30px 10px 30px 10px">
								Thank you for requesting a meeting at <strong>Sure Auto Loan Link</strong>! We will be contacting you shortly to confirm your appointment time. However if you would like to contact us immediately, we have provided an email contact link and phone number with this message. Also don�t hesitate to search our inventory by clicking on the convenient link.<br/><br/>
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
								<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:##ff0;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#form.MyID#&click_action=Click_Contact" target="_blank">Contact Us</a></div>
								<div style="margin:10px 0px 0px 0px;font:bold 18px arial;display:block;clear:both"><a style="color:##ff0;text-decoration:none;" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#form.MyID#&click_action=Click_Inventory" target="_blank">Search Our Inventory</a></div>
							</td>
						</tr>
					</table>
				</cfmail>
				
				<cfmodule template="/global/leads/get_addresses.cfm" Dealercode="#Get_SALL_Dealer.Dealercode#" lead_type="Contact_General" pin="#Get_SALL_Dealer.PIN#">
				
				<cfif Get_Emails_TXT.Recordcount neq 0>
					<cfloop query="Get_Emails_TXT">
						<cfmail <!--- server="#variables.mail_server#" ---> to="#Get_Emails_TXT.Text_Email#" from="#variables.from#" bcc="#variables.WD_BCC#" subject="#variables.lead_subject#">
							<cfmailparam name="Reply-To" value="#Get_SALL_Dealer.Email#">
								Name: #Get_SALL_Dealer.First_Name# #Get_SALL_Dealer.Last_Name#
								Phone: #Get_SALL_Dealer.Phone#
								Email: #Get_SALL_Dealer.Email#
								Age: #form.age#
								Employment: #form.emp#
								Income: #form.income#
								Apptointment: #form.date# #form.time#
								PIN: #Get_SALL_Dealer.Pin#
								Dealer: #Get_SALL_Dealer.Display_Name#
								Lead ID: #Get_SALL_Dealer.SALL_Lead_ID#
						</cfmail>
						<cfswitch expression="#Get_SALL_Dealer.Dealercode#">
							<cfcase value="0102-0001-999-01-C3E00CAA1C">
								<cfif Get_SALL_Dealer.Email neq Get_Emails_TXT.Text_Email>
									<cfmail <!--- server="#variables.mail_server#" ---> to="#Get_SALL_Dealer.Email#" from="#variables.from#" bcc="#variables.WD_BCC#" subject="#variables.lead_subject#">
										<cfmailparam name="Reply-To" value="#Get_Emails_TXT.Text_Email#">
										Name: #Get_SALL_Dealer.First_Name# #Get_SALL_Dealer.Last_Name#
										Phone: #Get_SALL_Dealer.Phone#
										Email: #Get_SALL_Dealer.Email#
										Age: #form.age#
										Employment: #form.emp#
										Income: #form.income#
										Apptointment: #form.date# #form.time#
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
							c_fname="#Get_SALL_Dealer.First_Name#"
							c_lname="#Get_SALL_Dealer.Last_Name#"
							c_email="#Get_SALL_Dealer.Email#"
							c_phone="#Get_SALL_Dealer.Phone#"
							c_comments="Age: #form.age##chr(10)#Employment: #form.emp##chr(10)#Income: #form.income##chr(10)#Appointment: #form.date# #form.time##chr(10)#PIN: #Get_SALL_Dealer.Pin#">
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
							<cfmailparam name="Reply-To" value="#Get_SALL_Dealer.Email#">
							#variables.adf_xml#
						</cfmail>
					</cfloop>
				</cfif>
				
				<cflocation url="index.cfm?page_action=thank_you&MyID=#form.MyID#">
				
		</cfif>
		
	</cfcase>
	
</cfswitch>