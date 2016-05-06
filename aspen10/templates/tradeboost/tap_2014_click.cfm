<cfset variables.DSN="Aspen10">
<cfparam name="url.MyID" default="0">
<cfparam name="url.click_action" default="">
<cfparam name="Get_Clicks.click_total" default="0">

<cfif len(trim(url.MyID)) lt 1>
	<cfset url.click_action="">
</cfif>

<cfif len(url.click_action) gt 0 and url.MyID neq 0>
	<cfoutput>

		<cfswitch expression="#url.click_action#">
		
			<cfcase value="Click_Website,Click_Inventory,Click_TestDrive,Click_Financing,Click_Contact,Click_CouponPrint,Click_TDPrint,Click_Alt,Click_TradeValue">
			
				<cftransaction>
	
					<cfquery datasource="#variables.DSN#" name="Get_Clicks">
						SELECT		#url.click_action#+1 as click_total
						FROM		Leads
						WHERE		MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>
					
					<cfquery datasource="#variables.DSN#" name="Update_Click">
						UPDATE		Leads
						SET			#url.click_action#=<cfqueryparam value="#Get_Clicks.click_total#" cfsqltype="CF_SQL_INTEGER">
						WHERE		MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>

					<cfquery datasource="#variables.DSN#" name="Check_ID">
						SELECT		Leads.Dealercode,
									Leads.MyID,
									Site_Settings.Web_Link,
									Site_Settings.Inv_Link,
									Site_Settings.Contact_Link,
									Site_Settings.Finance_Link,
									Site_Settings.Trade_Link,
									Site_Settings.Alt_Link
						FROM		Leads
						INNER JOIN	Site_Settings
						ON 			Leads.Dealercode = Site_Settings.Dealercode
						WHERE     	Leads.MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>
					
				</cftransaction>
			
				<cfswitch expression="#url.click_action#">
					
					<cfcase value="Click_Website">
						<script>
							location.href='#Check_ID.Web_Link#';
						</script>
					</cfcase>

					<cfcase value="Click_Inventory">
						<script>
							location.href='#Check_ID.Inv_Link#';
						</script>
					</cfcase>

					<cfcase value="Click_Contact">
						<script>
							location.href='#Check_ID.Contact_Link#';
						</script>
					</cfcase>

					<cfcase value="Click_Financing">
						<script>
							location.href='#Check_ID.Finance_Link#';
						</script>
					</cfcase>

					<cfcase value="Click_TestDrive">
						<script>
							location.href='http://#cgi.Server_Name#/dealer.cfm?MyID=#url.MyID#';
						</script>
					</cfcase>

					<cfcase value="Click_TradeValue">
						<script>
							location.href='#Check_ID.Trade_Link#';
						</script>
					</cfcase>

					<cfcase value="Click_Alt">
						<script>
							location.href='#Check_ID.Alt_Link#';
						</script>
					</cfcase>
					
					<cfcase value="Click_CouponPrint">

						<cfquery datasource="#variables.DSN#" name="Get_Settings">
							SELECT		Site_Settings.Start_Date,
										Site_Settings.End_Date,
										Site_Settings.Coupon,
										Site_Settings.Coupon_Value,
										Site_Settings.Inv_Type,
										Site_Settings.Exclusions,
										Site_Settings.Disclaimer,
										Site_Settings.Inv_Value
							FROM		Leads
							INNER JOIN	Site_Settings
							ON			Leads.Dealercode = Site_Settings.Dealercode
							WHERE     	Leads.MyID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.myid#" maxlength="50">
						</cfquery>

						<div id="print-coupon-div">
							<cfswitch expression="#Get_Settings.Coupon#">
								<cfcase value="Discount">
									<cfif left(Check_ID.Dealercode, 4) eq "0129">
										<span style="font:normal 20px impact;text-align:center;display:block"><br/>UP TO</span>
									</cfif>
									<span id="print-coupon-title">$#Get_Settings.Coupon_Value#</span>
									<cfif left(Check_ID.Dealercode, 4) eq "0129">
										<span id="print-coupon-desc">trade-in assistance<br/>HOLIDAY BONUS CASH*</span>
									<cfelse>
										<span id="print-coupon-desc">OFF COUPON*</span>
									</cfif>
									<cfif Get_Settings.Inv_Type neq 0>
										<span id="print-coupon-text">
											<cfswitch expression="#Get_Settings.Inv_Type#">
												<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
												<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="S">#ucase(Get_Settings.Inv_Value)#<br/></cfcase>
											</cfswitch>
										</span>
									</cfif>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfcase value="Top Dollar">
									<span id="print-coupon-title">TOP DOLLAR</span>
									<span id="print-coupon-desc">For Your Trade*</span>
									<cfif Get_Settings.Inv_Type neq 0>
										<span id="print-coupon-text">
											<cfswitch expression="#Get_Settings.Inv_Type#">
												<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
												<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="S">#ucase(Get_Settings.Inv_Value)#<br/></cfcase>
												<cfcase value="0"></cfcase>
											</cfswitch>
										</span>
									</cfif>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfcase value="Down Payment Asst">
									<span id="print-coupon-title">#Get_Settings.Coupon_Value#</span>
									<span id="print-coupon-desc">DOWNPAYMENT<br/>ASSISTANCE</span>
									<cfif Get_Settings.Inv_Type neq 0>
										<span id="print-coupon-text">
											<cfswitch expression="#Get_Settings.Inv_Type#">
												<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
												<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="S">#ucase(Get_Settings.Inv_Value)#<br/></cfcase>
												<cfcase value="0"></cfcase>
											</cfswitch>
										</span>
									</cfif>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfcase value="KBB">
									<div style="font:normal 20px impact;margin-top:10px" align="center">UP TO</div>
									<span id="print-coupon-title">$#Get_Settings.Coupon_Value#</span>
									<span id="print-coupon-desc">ABOVE FAIR BOOK VALUE*</span>
									<cfif Get_Settings.Inv_Type neq 0>
										<span id="print-coupon-text">
											<cfswitch expression="#Get_Settings.Inv_Type#">
												<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
												<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="S">#ucase(Get_Settings.Inv_Value)#<br/></cfcase>
											</cfswitch>
										</span>
									</cfif>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfcase value="Percent">
									<div style="font:normal 20px impact;margin-top:10px" align="center">UP TO</div>
									<span id="print-coupon-title">#Get_Settings.Coupon_Value#%</span>
									<span id="print-coupon-desc">ABOVE FAIR BOOK VALUE*</span>
									<cfif Get_Settings.Inv_Type neq 0>
										<span id="print-coupon-text">
											<cfswitch expression="#Get_Settings.Inv_Type#">
												<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
												<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="S">#ucase(Get_Settings.Inv_Value)#<br/></cfcase>
											</cfswitch>
										</span>
									</cfif>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfcase value="Custom Text">
									<br/><br/>
									<span id="coupon-desc">#Get_Settings.Coupon_Value#</span>
									<cfif Get_Settings.Inv_Type neq 0>
										<span id="print-coupon-text">
											<cfswitch expression="#Get_Settings.Inv_Type#">
												<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
												<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
												<cfcase value="S">#ucase(Get_Settings.Inv_Value)#<br/></cfcase>
											</cfswitch>
										</span>
									</cfif>
									<span id="coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfdefaultcase>None</cfdefaultcase>
							</cfswitch>
						</div>
						
						<script>window.print();</script> 
						
					</cfcase>

					<cfcase value="Click_TDPrint">

						<cfquery datasource="#variables.DSN#" name="Get_Settings">
							SELECT		Site_Settings.Start_Date,
										Site_Settings.End_Date,
										Site_Settings.TD_Incentive,
										Site_Settings.TD_Incentive_Value,
										Site_Settings.Inv_Type,
										Site_Settings.Inv_Value,
										Site_Settings.Exclusions
							FROM		Leads
							INNER JOIN	Site_Settings
							ON			Leads.Dealercode = Site_Settings.Dealercode
							WHERE     	Leads.MyID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.myid#" maxlength="50">
						</cfquery>

						<div id="print-coupon-div">
							<cfswitch expression="#Get_Settings.TD_Incentive#">
								<cfcase value="Discount">
									<span id="print-coupon-title">$#Get_Settings.TD_Incentive_Value#</span>
									<span id="print-coupon-desc">OFF COUPON*</span>
									<span id="print-coupon-text">
										<cfswitch expression="#Get_Settings.Inv_Type#">
											<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/></cfdefaultcase>
											<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/></cfcase>
											<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/></cfcase>
										</cfswitch>
										IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.
									</span>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfcase value="Custom Text">
									<span id="print-coupon-desc">#Get_Settings.TD_Incentive_Value#</span>
									<span id="print-coupon-text">
										<cfswitch expression="#Get_Settings.Inv_Type#">
											<cfdefaultcase>WHEN YOU PURCHASE A<br/>NEW OR QUALITY USED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfdefaultcase>
											<cfcase value="N">WHEN YOU PURCHASE<br/>A NEW VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
											<cfcase value="U">WHEN YOU PURCHASE A<br/>QUALITY PRE-OWNED VEHICLE<br/>IN ADDITION TO ALL OTHER<br/>INCENTIVES &amp; DISCOUNTS.</cfcase>
											<cfcase value="S">#ucase(Get_Settings.Inv_Value)#</cfcase>
										</cfswitch>
									</span>
									<span id="print-coupon-disclaimer">
										Limit One Coupon Per Purchase.<br/>
										#Get_Settings.Exclusions#<br/>
										See Dealer for Details.<br/>
										Expires #dateformat(Get_Settings.end_date,"mm/dd/yyyy")#
									</span>
								</cfcase>
								<cfdefaultcase>None</cfdefaultcase>
							</cfswitch>
						</div>
						
						<script>window.print();</script> 
						
					</cfcase>
				
				</cfswitch>
			
			</cfcase>
			
			<!--- 
			<cfcase value="unsubscribe">
				<cftransaction>
					<cfquery datasource="Ultra8" name="OptOut">
						UPDATE		TAP_Leads
						SET			Opt_In = 0
						WHERE		MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>
					<cfquery datasource="Ultra8" name="Get_Email">
						SELECT		TAP_Leads.Email,
									Dealers.Display_Name
						FROM		TAP_Leads
						INNER JOIN	Dealers
						ON			TAP_Leads.Dealercode=Dealers.Dealercode
						WHERE     	TAP_Leads.MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>
				</cftransaction>
				<div style="font:bold arial 20px;color:##006">#Get_Email.Email# has been removed from the #Get_Email.Display_Name# Mailing List.</div>
			</cfcase>
			--->
			
			<!--- 
			<cfcase value="subscribe">
				<cftransaction>
					<cfquery datasource="Ultra8" name="OptOut">
						UPDATE		TAP_Leads
						SET			Opt_In=1
						WHERE		MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>
					<cfquery datasource="Ultra8" name="Get_Email">
						SELECT		TAP_Leads.Email,
									Dealers.Display_Name
						FROM		TAP_Leads
						INNER JOIN	Dealers
						ON			TAP_Leads.Dealercode=Dealers.Dealercode
						WHERE     	TAP_Leads.MyID=<cfqueryparam value="#url.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
					</cfquery>
				</cftransaction>
				<div style="font:bold arial 20px;color:##006">#Get_Email.Email# has been added to the #Get_Email.Display_Name# Mailing List.</div>			
			</cfcase>
			--->

			<cfdefaultcase>
				<div style="font:bold arial 20px;color:##006">No Action</div>
			</cfdefaultcase>
		</cfswitch>
	</cfoutput>
<cfelse>
	<div style="font:bold arial 20px;color:#fff">No Action</div>
</cfif>