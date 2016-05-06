<cfset variables.File_Name="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#"><!--- Get File Name --->
<cfparam name="attributes.Dealercode" default="0">
<cfparam name="url.xl" default="0">
<cfparam name="url.show_test" default="0">
<cfparam name="variables.web_clicks" default="0">
<cfparam name="variables.inv_clicks" default="0">
<cfparam name="variables.fin_clicks" default="0">
<cfparam name="variables.con_clicks" default="0">
<cfparam name="variables.td_clicks" default="0">
<cfparam name="variables.cou_clicks" default="0">
<cfparam name="variables.tot_clicks" default="0">
<cfparam name="variables.fin_sub" default="0">

<cfquery datasource="Ultra8" name="Get_Dealer">
	SELECT		Dealers.Dealercode,
				Dealers.Display_Name,
				Dealers.Address_1,
				Dealers.City,
				Dealers.State,
				Dealers.Zip,
				Dealers.Primary_Phone, 
                TAP_Settings.start_date,
				TAP_Settings.exp_date
	FROM		Dealers
	INNER JOIN	TAP_Settings
	ON 			Dealers.Dealercode = TAP_Settings.Dealercode
	WHERE     	Dealers.Dealercode='#attributes.Dealercode#'
</cfquery>

<cfquery datasource="Ultra8" name="Get_SALL_Leads">
	SELECT		SALL_Lead_ID,
				Date_Submitted,
				PIN,
				First_Name,
				Last_Name,
				PIN_First_Name,
				PIN_Last_Name,
				Email,
				Phone,
				Address,
				City,
				State,
				Zip,
				Trade_Year,
				Trade_Make,
				Trade_Model, 
	            Trade_Odometer,
				VOI_Make,
				VOI_Model, 
				TD_Date_Submitted,
				TD_App_Time,
				TD_App_Date,
				Fin_App_Time,
				Fin_App_Date,
				Age,
				Employment,
				Income,
				Click_Website,
				Click_Inventory,
				Click_Financing,
				Click_Contact,
				Click_TestDrive, 
	            Click_CouponPrint,
				Click_Website+Click_Inventory+Click_Financing+Click_Contact+Click_TestDrive+Click_CouponPrint as My_Total,
				Opt_In
	FROM		SALL_Leads
	WHERE		Dealercode=<cfqueryparam value="#attributes.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
	AND			Email is not null
	<cfswitch expression="#url.show_test#">
		<cfcase value="0">
			AND	PIN not like '99999%'
			AND	Email not like '%worlddealer.net'
			AND	Email not like '%thomasdealerships.com'
			AND	Email not like '%colonialcars%'
			AND	Email not like '%mikekosior%'
			AND	Email not like '%test%'
			AND	Email not like '%aspen%'
			AND	Email not like '%test%'
			AND	Email not like '%baierl%'
			AND Email not like '%crestmont%'
			AND First_Name not like '%TEST%'
			AND Last_Name not like '%TEST%'
		</cfcase>
		<cfcase value="1">
			AND	(PIN like '99999%'
			OR	Email like '%worlddealer.net'
			OR	Email like '%thomasdealerships.com'
			OR	Email like '%colonialcars%'
			OR	Email like '%mikekosior%'
			OR	Email like '%test%'
			OR	Email like '%aspen%'
			OR	Email like '%test%'
			OR	Email like '%baierl%'
			OR	Email like '%crestmont%'
			OR 	First_Name like '%TEST%'
			OR 	Last_Name like '%TEST%')
		</cfcase>
	</cfswitch>
	ORDER BY 	Date_Submitted
</cfquery>


<cfoutput>

<cfif url.xl eq 0>
<table style="width:990px;font:normal 10px arial;background-color:##fff">
<tr>
	<td>
		<cfif url.show_test eq 1><a style="color:##00f" href="#variables.File_Name#?show_test=0">Show Real Data</a></cfif>
		<cfif url.show_test eq 0><a style="color:##00f" href="#variables.File_Name#?show_test=1">Show Test Data</a></cfif>
	</td>
	<td align="right"><a style="color:##00f" href="#variables.File_Name#?xl=1&show_test=#url.show_test#" target="_blank">Export to Excel</a></td>
</tr>
</table>
</cfif>
<cfif url.xl eq 0>
<table style="width:990px;border:1px solid ##000;font:normal 16px arial;background-color:##fff">
	<tr><td colspan="2" style="background-color:##8C2020;color:##ffffff;font:bold 12px arial;text-align:center;padding:5px">SureAutoLoanLink.com Report</td></tr>
	<tr>
		<td style="width:50%;padding:5px">
			#Get_Dealer.Display_Name#<br/>
			#Get_Dealer.Address_1#<br/>
			#Get_Dealer.City#, #Get_Dealer.State# #Get_Dealer.Zip#<br/>
		</td>
		<td style="width:50%;padding:5px" valign="bottom">
			Dealer ID: #Get_Dealer.Dealercode#<br/>
			Start Date : #dateformat(Get_Dealer.start_date,"mm/dd/yyyy")#<br/>
			Expiration Date : #dateformat(Get_Dealer.exp_date,"mm/dd/yyyy")#<br/>
		</td>
	</tr>
</table>
<table style="width:990px;border:1px solid ##000000;font:bold 10px arial;background-color:##fff" cellpadding="0" cellspacing="0">
	<cfloop query="Get_SALL_Leads">
		<tr style="background-color:##eeeeee">
			<td style="padding:5px;width:100px;text-align:center">#Get_SALL_Leads.PIN#</td>
			<td style="padding:5px;width:200px">#Get_SALL_Leads.First_Name# #Get_SALL_Leads.Last_Name#</td>
			<td style="padding:5px;width:200px">Mailer Info</td>
			<td style="padding:5px;width:200px">Date Submitted: #dateformat(Get_SALL_Leads.Date_Submitted,"mm/dd/yyyy")# #timeformat(Get_SALL_Leads.Date_Submitted,"h:mm tt")#</td>
			<td>Click Activity</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td style="padding:5px" valign="top">
				Email: #Get_SALL_Leads.Email#<br/>
				Phone: #Get_SALL_Leads.phone#<br/>
				Lead ID: #Get_SALL_Leads.SALL_Lead_ID#<br/>
			</td>
			<td style="padding:5px" valign="top">
				Mailer Name : #Get_SALL_Leads.PIN_First_Name# #Get_SALL_Leads.PIN_Last_Name#<br/>
				Address : #Get_SALL_Leads.Address#<br/>
				City, State Zip : #Get_SALL_Leads.City#, #Get_SALL_Leads.State# #Get_SALL_Leads.Zip#<br/>
			</td>
			<td style="padding:5px" valign="top">
				<cfif len(trim(Get_SALL_Leads.Fin_App_Date)) gt 0>
					<cfset variables.fin_sub=variables.fin_sub+1>
					Appt: #dateformat(Get_SALL_Leads.Fin_App_Date,"mm/dd/yyy")# #Get_SALL_Leads.Fin_App_Time#<br/>
					Age: #Get_SALL_Leads.Age#<br/>
					Employment: #Get_SALL_Leads.Employment#<br/>
					Income: #Get_SALL_Leads.Income#
				<cfelse>
					No Appointment Scheduled
				</cfif>
			</td>
			<td style="padding:5px" valign="top">
				Website Clicks: #Get_SALL_Leads.Click_Website#<br />
				Inventory Clicks: #Get_SALL_Leads.Click_Inventory#<br />
				Contact Clicks: #Get_SALL_Leads.Click_Contact#<br />
				<cfset variables.web_clicks=variables.web_clicks+Get_SALL_Leads.Click_Website>
				<cfset variables.inv_clicks=variables.inv_clicks+Get_SALL_Leads.Click_Inventory>
				<cfset variables.fin_clicks=variables.fin_clicks+Get_SALL_Leads.Click_Financing>
				<cfset variables.con_clicks=variables.con_clicks+Get_SALL_Leads.Click_Contact>
				<cfset variables.td_clicks=variables.td_clicks+Get_SALL_Leads.Click_TestDrive>
				<cfset variables.cou_clicks=variables.cou_clicks+Get_SALL_Leads.Click_CouponPrint>
			</td>
		</tr>
	</cfloop>
</table>
<cfset variables.tot_clicks=variables.tot_clicks+variables.web_clicks+variables.inv_clicks+variables.fin_clicks+variables.con_clicks+variables.td_clicks+variables.cou_clicks>
<table style="width:990px;border:1px solid ##000;background-color:##8C2020;color:##ffffff;font:bold 12px arial;text-align:center" cellpadding="0" cellspacing="0">
	<tr>
		<td style="padding:5px">Total Leads : #Get_SALL_Leads.Recordcount#</td>
		<td style="padding:5px">Total Appointments : #variables.fin_sub#</td>
		<td style="padding:5px">Website Clicks : #variables.web_clicks#</td>
		<td style="padding:5px">Inventory Clicks : #variables.inv_clicks#</td>
		<td style="padding:5px">Contact Clicks : #variables.con_clicks#</td>
		<td style="padding:5px">Total Clicks : #variables.tot_clicks#</td>
	</tr>
</table>
<cfelse>
<cfcontent type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=#replace(Get_Dealer.Display_Name,' ','_','ALL')#_SALL_Report_#dateformat(now(),'mmddyyyy')#.xls">
<table border="1" bordercolor="##000000" cellpadding="0" cellspacing="0">
	<tr>
		<td bgcolor="##000080" colspan="18" align="center"><font color="##ffffff" face="Arial" size="-1">SureAutoLoanLink.com Report</font></td>
	</tr>
	<tr>
		<td colspan="9">
			<font face="Arial" size="-1">
			#Get_Dealer.Display_Name#<br/>
			#Get_Dealer.Address_1#<br/>
			#Get_Dealer.City#, #Get_Dealer.State# #Get_Dealer.Zip#<br/>
			</font>
		</td>
		<td colspan="9">
			<font face="Arial" size="-1">
			Dealer ID: #Get_Dealer.Dealercode#<br/>
			Start Date : #dateformat(Get_Dealer.start_date,"mm/dd/yyyy")#<br/>
			Expiration Date : #dateformat(Get_Dealer.exp_date,"mm/dd/yyyy")#<br/>
			</font>
		</td>
	</tr>
	<tr>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Lead ID</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">PIN</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Name</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Date Submitted</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Email</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Phone</font></td>
		
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Mailer Name</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Address</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">City</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">State</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Zip</font></td>		
		
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Appointment</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Age</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Employment</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Income</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Website Clicks</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Inventory Clicks</font></td>
		<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Contact Clicks</font></td>
	</tr>
	<cfloop query="Get_SALL_Leads">
		<tr>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.SALL_Lead_ID#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.PIN#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.First_Name# #Get_SALL_Leads.Last_Name#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#dateformat(Get_SALL_Leads.Date_Submitted,"mm/dd/yyyy")# #timeformat(Get_SALL_Leads.Date_Submitted,"h:mm tt")#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Email#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Phone#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.PIN_First_Name# #Get_SALL_Leads.PIN_Last_Name#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Address#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.City#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.State#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Zip#</font></td>
			<cfif len(trim(Get_SALL_Leads.Fin_App_Date)) gt 0>
				<cfset variables.fin_sub=variables.fin_sub+1>
				<td><font color="##000000" face="Arial" size="-2">#dateformat(Get_SALL_Leads.Fin_App_Date,"mm/dd/yyy")# #Get_SALL_Leads.Fin_App_Time#</font></td>
			<cfelse>
				<td><font color="##000000" face="Arial" size="-2">N/A</font></td>
			</cfif>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Age#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Employment#</font></td>
			<td><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Income#</font></td>
			<td align="right"><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Click_Website#</font></td>
			<td align="right"><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Click_Inventory#</font></td>
			<td align="right"><font color="##000000" face="Arial" size="-2">#Get_SALL_Leads.Click_Contact#</font></td>	
		</tr>
		<cfset variables.web_clicks=variables.web_clicks+Get_SALL_Leads.Click_Website>
		<cfset variables.inv_clicks=variables.inv_clicks+Get_SALL_Leads.Click_Inventory>
		<cfset variables.fin_clicks=variables.fin_clicks+Get_SALL_Leads.Click_Financing>
		<cfset variables.con_clicks=variables.con_clicks+Get_SALL_Leads.Click_Contact>
		<cfset variables.td_clicks=variables.td_clicks+Get_SALL_Leads.Click_TestDrive>
		<cfset variables.cou_clicks=variables.cou_clicks+Get_SALL_Leads.Click_CouponPrint>
	</cfloop>
		<tr>
			<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Total Leads</font></td>
			<td bgcolor="##000080" align="right"><font color="##ffffff" face="Arial" size="-2">#Get_SALL_Leads.Recordcount#</font></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Total Appts</font></td>
			<td bgcolor="##000080" align="right"><font color="##ffffff" face="Arial" size="-2">#variables.fin_sub#</font></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"></td>
			<td bgcolor="##000080"><font color="##ffffff" face="Arial" size="-2">Total Clicks</font></td>
			<td bgcolor="##000080" align="right"><font color="##ffffff" face="Arial" size="-2">#variables.web_clicks#</font></td>
			<td bgcolor="##000080" align="right"><font color="##ffffff" face="Arial" size="-2">#variables.inv_clicks#</font></td>
			<td bgcolor="##000080" align="right"><font color="##ffffff" face="Arial" size="-2">#variables.con_clicks#</font></td>	
		</tr>	
</table>
</cfif>
<cfif url.xl eq 0>
<table style="width:990px;font:normal 10px arial;background-color:##fff">
<tr>
	<td>
		<cfif url.show_test eq 1><a style="color:##00f" href="#variables.File_Name#?show_test=0">Show Real Data</a></cfif>
		<cfif url.show_test eq 0><a style="color:##00f" href="#variables.File_Name#?show_test=1">Show Test Data</a></cfif>
	</td>
	<td align="right"><a style="color:##00f" href="#variables.File_Name#?xl=1&show_test=#url.show_test#" target="_blank">Export to Excel</a></td>
</tr>
</table>
</cfif>
</cfoutput>