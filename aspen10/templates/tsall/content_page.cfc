
<cfcomponent>


	<cffunction name="modern" description="SALL Form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		  <cfargument name="dealercode" required="false">  
		  <cfargument name="dealercode_id" required="false">  
		  <cfargument name="myid" required="false">  
	


		<cfquery datasource="Aspen10" name="Get_Control_Details">
			SELECT	Dealer_ID, Dealercode, Dealer_Name, Display_Name, Address_1, Address_2, City, State, Zip, Primary_URL, Dealer_Directory, Longitude, Latitude, 
                    AIS_Dealer_ID, AIS_WID, AIS_BriefInline, New_Inv_Type_ID, Inv_Code_New, Used_Inv_Type_ID, Inv_Code_Used, Fleet_Inv_New_Type_ID, Inv_Code_Fleet_New, 
                    Fleet_Inv_Used_Type_ID, Inv_Code_Fleet_Used, Commercial_New_Inv_Type_ID, Inv_Code_Commercial_New, Commercial_Used_Inv_Type_ID, 
                    Inv_Code_Commercial_Used, Store_Contact, Store_Contact_Email, Primary_Phone, Inv_Phone_New, Inv_Phone_Used, Service_Phone, Parts_Phone, 
                    Automall_Phone, Inv_Phone_New_Automall, Inv_Phone_Used_Automall, OEM_Key, TDDS, TDDS_region, TDDS_tda, TDDS_district, TDDS_autogroup, 
                    Google_Site_Verification, Carfax, Autocheck_CID, Autocheck_SID, Autocheck_PWD, Wordpress_Cat, Link_Finance, Link_Service, Link_Sales, Link_Parts, 
                    Link_Directions, Link_Charity, scripts_head, scripts_above_body, scripts_body_top, scripts_body_bottom, scripts_after_body, vehicle_css, v_disclaimer, youtube, 
                    Active, exclude_inv, directions, scripts_nav_chat, cobalt_url, wd_logo_img, srch_method, price_srch_method, cust_btns
			FROM	Dealers
			WHERE	Dealer_ID=255
		</cfquery>
		<cfset variables.dlr_dir = #Get_Control_Details.Dealer_Directory#>
		
		<cfquery datasource="Aspen10" name="Get_dealer_Details">
			SELECT	Dealer_ID, Dealercode, Dealer_Name, Display_Name, Address_1, Address_2, City, State, Zip, Primary_URL, Dealer_Directory, Longitude, Latitude, 
                    AIS_Dealer_ID, AIS_WID, AIS_BriefInline, New_Inv_Type_ID, Inv_Code_New, Used_Inv_Type_ID, Inv_Code_Used, Fleet_Inv_New_Type_ID, Inv_Code_Fleet_New, 
                    Fleet_Inv_Used_Type_ID, Inv_Code_Fleet_Used, Commercial_New_Inv_Type_ID, Inv_Code_Commercial_New, Commercial_Used_Inv_Type_ID, 
                    Inv_Code_Commercial_Used, Store_Contact, Store_Contact_Email, Primary_Phone, Inv_Phone_New, Inv_Phone_Used, Service_Phone, Parts_Phone, 
                    Automall_Phone, Inv_Phone_New_Automall, Inv_Phone_Used_Automall, OEM_Key, TDDS, TDDS_region, TDDS_tda, TDDS_district, TDDS_autogroup, 
                    Google_Site_Verification, Carfax, Autocheck_CID, Autocheck_SID, Autocheck_PWD, Wordpress_Cat, Link_Finance, Link_Service, Link_Sales, Link_Parts, 
                    Link_Directions, Link_Charity, scripts_head, scripts_above_body, scripts_body_top, scripts_body_bottom, scripts_after_body, vehicle_css, v_disclaimer, youtube, 
                    Active, exclude_inv, directions, scripts_nav_chat, cobalt_url, wd_logo_img, srch_method, price_srch_method, cust_btns
			FROM	Dealers
			<cfif IsDefined("url.take_two")>
				WHERE	dealer_id=#url.take_two#
			<cfelse>
				WHERE	dealer_id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.dealer_id#" maxlength="6">
			</cfif>
		</cfquery>

		<cfset url.dealercode = #url.Dealercode# >
		
		<cfquery datasource="Aspen10" name="Get_phones">
			SELECT	 Phone_ID, Dealer_ID, Dealer_Dept_ID, Phone_Label, Area_Code, Prefix, Line_Number, Vanity_Number, Desktop, Mobile, Hierarchy
			FROM         Dealer_Phones
			WHERE		Phone_ID=#Get_dealer_Details.Primary_Phone#
		</cfquery>
		 
		
		<cfquery datasource="Aspen10" name="Check_ID">
			SELECT		tap_Settings.Web_Link,
						tap_Settings.Inv_Link,
						tap_Settings.Contact_Link,
						tap_Settings.Finance_Link,
						tap_Settings.tap_dlr_id
			FROM		SALL_Leads
			INNER JOIN	tap_Settings
			ON			SALL_Leads.lead_dlr_id = tap_Settings.tap_dlr_id
			WHERE		SALL_Leads.MyID=<cfqueryparam value="#arguments.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
		
		
<!--- Page 2 --->		
		<section class="section-spl">
			<div class="container" >
				<div class="row">&nbsp;</div>
			 	<div class="row">
					<div class="col-md-4 pad-top-10" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/logo.png" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-3 pad-top-10" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-5 no-pad" align="right" >				 
						<cfif #Get_dealer_Details.dealer_id# NEQ 528>
							<span style="font-size:20pt;color:##000000;font-weight:bold">#Get_dealer_Details.Display_Name#</span><br>			 
						<cfelse>	
							<span style="font-size:20pt;color:##000000;font-weight:bold">Tarbox Hyundai</span><br>			 
							<span style="font-size:20pt;color:##000000;font-weight:bold">Tarbox Toyota</span><br>			 
						</cfif>
						<cfif #Get_dealer_Details.Address_1# NEQ "" >
							<span style="font-size:12pt;color:##000000;font-weight:bold">#Get_dealer_Details.Address_1#&nbsp;#Get_dealer_Details.City#,&nbsp;#Get_dealer_Details.State#&nbsp;#Get_dealer_Details.zip#</span><br>
						</cfif>
						<cfif #url.dealer_id# NEQ 524>
						<span style="font-size:22pt;color:##000000;font-weight:bold">Phone:&nbsp;#Get_phones.Area_Code#.#Get_phones.Prefix#.#Get_phones.Line_Number#<cfif #url.dealer_id# EQ 500> x111</cfif></span>
						</cfif>
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row ">
							<div class="col-md-6" align="left" >	 
								<div class="row pad-top-3" style="height:24px;background-color:##000000;color:##ffffff;font-size:10px" >
									<div class="col-md-3 pad left 3" align="left" >		
									<cfif #Check_ID.Web_Link# NEQ "" >	
										<a href="#Check_ID.Web_Link#" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold" ><< HOMEPAGE</a>
									<cfelse>
										&nbsp;	
									</cfif>
									</div>		 
									<div class="col-md-6  pad left 3" align="center" >		
									<cfif #Check_ID.Inv_Link# NEQ "" >
										<a href="#Check_ID.Inv_Link#" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold"><< SEARCH OUR INVENTORY</a>
									<cfelse>
										&nbsp;	
									</cfif>
									</div>		 
									<div class="col-md-3  pad left 3" align="right" >		
									<cfif #Check_ID.Contact_Link# NEQ "" >		
										<a href="#Check_ID.Contact_Link#" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold"><< CONTACT US</a>
									<cfelse>
										&nbsp;	
									</cfif>
									</div>		 
								</div>
								<div class="row pad-top-3"  style="background-color:##ffffff">
									<div class="col-md-12" align="left" >
  										 <iframe 	width="100%" 
										 			height="380" 
													src="http://www.youtube.com/embed/aY_II077YOM?rel=0&autoplay=1&controls=0showinfo=0&modestbranding=1" 
													frameborder="0" 
													allowfullscreen>
										</iframe>
									</div>
								</div>												
							</div> 
							<div class="col-md-6  pad left 5" align="left"  >	
								<div class="row" align="left">
									<div class="col-md-12 ">
								<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##000000;font-weight:bold">&nbsp;Auto Loan From<br>
								&nbsp;$5,500 Up To $39,000.* </span><br>
								<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##000000;font-weight:normal">&nbsp;Congratulations! Your pre-qualified* amount is valid at #Get_dealer_Details.Display_Name#. Securing funding prior to shopping gives you the purchasing power of a cash buyer and #Get_dealer_Details.Display_Name# has agreed to include all new and used vehicles in inventory for this special offer. So the selection is unlimited! #Get_dealer_Details.Display_Name# Management has also been authorized to accept purchase offers that meet your pre-qualification* amount. Please note, this offer will expire soon.
								</span>
								</div>
								</div>
								<div class="row"><div class="col-md-12">&nbsp;</div></div>
								<div class="row" align="left">
									<div class="col-md-12">
									<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##000000;font-weight:bold">Final Step<br>
									Verify your identity and provide some additional information.</span><br>
									<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##000000;font-weight:normal">Just complete the information below and one of our financial specialists will contact you with your Pre-Approved Auto Loan. Our Sure Auto Loan program can help you purchase a new or used vehicle today!</span>
									</div>
								</div>
							</div>
						</div>
					</div>
			</div>  <!--- container --->
		</section>
		
		<section class="section-spl" style="background-color:##0079c2" >
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-6 " align="left" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >
									<div class="col-md-2 " align="right" >&nbsp;</div>
									<div class="col-md-10 " align="left" >	
										<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:18pt;color:##ffffff;font-weight:bold">Step 2: Schedule Your Appointment</span><br>
										<span style="font-family:Helvetica-Condensed, sans-serif;font-size:12pt;color:##ffffff;font-weight:normal">Please complete the information to the right to schedule an
										appointment to discuss your loan options. (Be prepared to 
										accept immediate delivery of your vehicle)</span>
									</div>								
								&nbsp;</div>
							</div>
							<div class="col-md-6 " align="right" >	
								<cfinvoke component="/cfcs/aspen10/forms/form_trade" method="sall_page_2">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="MyID" value="#arguments.MyId#"/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/sall_action_2.cfm"/>
								</cfinvoke>  
							</div>	
							<div class="row" >&nbsp;</div>	
							<div class="row" >&nbsp;</div>	
							<div class="row" >&nbsp;</div>	
							<div class="row" >
							<div class="col-md-12 " align="left" >	
								<span style="font-family:Helvetica-Condensed, sans-serif;font-size:7pt;color:##ffffff;font-weight:normal">
								*TERMS & CONDITIONS: In order to qualify for a loan from Granite Bay Acceptance Inc. (GBA). Your credit will have to be the same or better
than at the time of the prescreen. You will also be subject to the following minimum credit requirements for final approval. You must be
21 years of age or older with a monthly income of $2,150. Your monthly payment may not exceed 20% of your gross monthly income and
45% of your monthly debt. You will certify that all the information you provide on your application will be true and correct. GBA assumes no
responsibility for incorrect information provided by the various credit reporting agencies. A significant equity investment may be required.
Any bankruptcy must be discharged before the funding transaction can take place. If you meet all the criteria provided above, GBA will provide
financing to all qualified consumers and a guaranteed approval for a minimum amount of $5,500 to $39,000 depending on vehicle chosen, at
a simple interest rate of 18.99 APR and/or max state usury rate (whichever is higher). For example, for every $1,000 financed @ 18.99% for
a period of 60 months, your payment will be $25.94. Therefore if you finance $12,500 @ 60 months, your payment will be $324.19 on a new
or pre-owned 2009 or newer vehicle with maximum 60,000 miles and a minimum book/invoice value of $7,500. Minimum contract term of 24
months. See dealer for additional details. All dealer promotions and incentives are strictly the responsibility of the dealer and are not in any way
connected to the financing offer from GBA. For more information about GBA visit <a href="www.GBAFinance.com" target="_blank">www.GBAFinance.com</a>.
</span>
							</div>	
							</div>	
						&nbsp;
						</div>
					</div>
			</div>  <!--- container --->
		</section>
		
	</cffunction>

						
	<cffunction name="modernregthankyou" description="shows a standard header" output="Yes" access="public">

	</cffunction>

	<cffunction name="modernbaierlregthankyou" description="shows a Baierl Thanks Page" output="Yes" access="public">

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>

</cfcomponent>