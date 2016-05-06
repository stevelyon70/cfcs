
<cfcomponent>


	<cffunction name="modern" description="CCAP Form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		  <cfargument name="dealercode" required="false">  
		  <cfargument name="dealercode_id" required="false">  
		  <cfargument name="myid" required="false">  
	


		<cfquery datasource="Ultra10" name="Get_Control_Details">
			SELECT		Dealer_ID,
						dealer_directory
			FROM		Dealers
			WHERE		Dealer_id = 285
		</cfquery>
		<cfset variables.dlr_dir = #Get_Control_Details.Dealer_Directory#>
		
		<cfquery datasource="CCAP10" name="Get_dealer_Details">
			SELECT	 ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, 
                      Dealer_Email, Dealer_ADF_Email, Dealer_Website, inventory_link, finance_link, contact_link, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, 
                      expires_dt, active, clicks, Dealer_Report_Name
			FROM      Dealers
			<cfif IsDefined("url.take_two")>
				WHERE	dealer_id=#url.take_two#
			<cfelse>
				WHERE	id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.dealer_id#" maxlength="6">
			</cfif>
		</cfquery>

		<cfset url.dealercode = #url.Dealercode# >
		 
		
		<cfquery datasource="CCAP10" name="Check_ID">
			SELECT		Dealers.Dealer_Website,
						Dealers.inventory_link,
						Dealers.contact_link,
						Dealers.finance_link,
						Dealers.id
			FROM		CCAP_Leads
			INNER JOIN	Dealers
			ON			CCAP_Leads.lead_dlr_id = Dealers.id
			WHERE		CCAP_Leads.MyID=<cfqueryparam value="#arguments.MyId#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
		
		<cfquery datasource="CCAP10" name="Get_Customer_Info">
			SELECT		CCAP_Leads.ccap_Lead_ID,
						CCAP_Leads.PIN,
						CCAP_Leads.PIN_type,
						CCAP_Leads.first_name,
						CCAP_Leads.last_name,
						CCAP_Leads.phone,
						CCAP_Leads.email,
						CCAP_Leads.Loan_Amount,
						Dealers.ID,
						Dealers.Dealer_Name,
						Dealers.dealer_id,
						Dealers. Dealer_Address_1,
						Dealers.Dealer_Address_2,
						Dealers.Dealer_City,
						Dealers.Dealer_State,
						Dealers. Dealer_Zip, 
						Dealers.Dealer_Phone
			FROM		CCAP_Leads 
			INNER JOIN	Dealers
			ON			CCAP_Leads.lead_dlr_id = Dealers.ID
			WHERE		CCAP_Leads.MyID=<cfqueryparam value="#arguments.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>  
		
<!
		<section class="section-spl">
			<div class="container" >
				<div class="row">&nbsp;</div>
			 	<div class="row">
					<div class="col-md-4 pad-top-10" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/CC_Logo_Positive_sm.jpg" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-3 pad-top-10" align="left" >				 
						<!--- <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png" border="0" class="img-responsive">  --->&nbsp;
					</div>
					<div class="col-md-5 no-pad" align="right" >				 
						<span style="font-size:20pt;color:##000000;font-weight:bold">#Get_dealer_Details.Dealer_Name#</span><br>			 
						<cfif #Get_dealer_Details.Dealer_Address_1# NEQ "" >
							<span style="font-size:12pt;color:##000000;font-weight:bold">#Get_dealer_Details.Dealer_Address_1#&nbsp;&nbsp;#Get_dealer_Details.Dealer_City#,&nbsp;#Get_dealer_Details.Dealer_State#&nbsp;#Get_dealer_Details.Dealer_Zip#</span><br>
						</cfif>	 
						<cfif #Get_dealer_Details.Dealer_Contact# NEQ "" >
							<span style="font-size:20pt;color:##000000;font-weight:bold">&nbsp;#Get_dealer_Details.Dealer_Contact#</span>&nbsp;&nbsp;
						</cfif>
						<cfif #Get_dealer_Details.Dealer_Phone# NEQ "" >
							<span style="font-size:20pt;color:##000000;font-weight:bold">&nbsp;#Get_dealer_Details.Dealer_Phone#</span>
						</cfif>
						
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row ">
							<div class="col-md-6" align="left" >	&nbsp; 
								<!--- <div class="row pad-top-3" style="height:24px;background-color:##000000;color:##ffffff;font-size:10px" >
									<div class="col-md-3 pad left 3" align="left" >		
									<a href="#Check_ID.Dealer_Website#" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold" ><< HOMEPAGE</a>
									</div>		 
									<div class="col-md-6  pad left 3" align="center" >		
									<a href="#Check_ID.inventory_link#" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold"><< SEARCH OUR INVENTORY</a>
									</div>		 
									<div class="col-md-3  pad left 3" align="right" >		
									<a href="#Check_ID.contact_link#" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold"><< CONTACT US</a>
									</div>		 
								</div> --->
								<div class="row pad-top-3" >
									<div class="col-md-12" align="left" >
										<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/right-side.jpg" border="0" class="img-responsive"> 
  										 <!--- <iframe 	width="100%" 
										 			height="380" 
													src="http://www.youtube.com/embed/aY_II077YOM?rel=0&autoplay=1&controls=0showinfo=0&modestbranding=1" 
													frameborder="0" 
													allowfullscreen> 
										</iframe> --->
									</div>
								</div>												
							</div> 
							<div class="col-md-6  pad left 5" align="left"  >	
								<div class="row" align="left">
									<div class="col-md-12 ">
										<cfset bucks = "#NumberFormat(Get_Customer_Info.Loan_Amount, "$" )#" >
										<cfif #Get_Customer_Info.pin_type# EQ 1><cfset bucks = "$XX,XXX"></cfif> 
										<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##000000;font-weight:bold">Congratulations, #Get_Customer_Info.first_name# #Get_Customer_Info.last_name#!</span><br>
										<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##000000;font-weight:normal">You have been pre-approved for financing for the purchase of an automobile from <b>#Get_dealer_Details.Dealer_Name#</b> for up to <b>#bucks#</b>.</span>
									</div>
								</div>
								<div class="row"><div class="col-md-12">&nbsp;</div></div>
								<div class="row" align="left">
									<div class="col-md-12">
									<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##000000;font-weight:normal">You must visit the participating dealer listed on your letter to avoid expiration of your pre-approved auto financing. Please see the back of your letter for complete details.</span>
									</div>
								</div>
								<div class="row"><div class="col-md-12">&nbsp;</div></div>
								<div class="row" align="left">
									<div class="col-md-12">
									<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##000000;font-weight:bold">Step 1: Please verify your information.</span><br>
									<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##000000;font-weight:normal">Complete the information below and one of our financial specialists at <b>#Get_dealer_Details.Dealer_Name#</b> will contact you and review your pre-approved offer and their vehicle line up.</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
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
										appointment and review your loan options. (Be prepared to 
										accept immediate delivery of your vehicle)</span>
									</div>								
								&nbsp;</div>
							</div>
							<div class="col-md-6 " align="right" >	
								<cfinvoke component="/cfcs/forms/form_ccap" method="ccap_page_2">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="MyID" value="#arguments.MyId#"/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/ccap_action_2.cfm"/>
								</cfinvoke>  
							</div>	
							<div class="row" >&nbsp;</div>	
							<div class="row" >&nbsp;</div>	
							<div class="row" >&nbsp;</div>	
							<div class="row" >
							<div class="col-md-12 " align="left" >	
								<span style="font-family:Helvetica-Condensed, sans-serif;font-size:7pt;color:##ffffff;font-weight:normal">
								<b>PRE-APPROVAL RULES</b>
- Present Pre-approval letter to participating Chrysler dealer listed on the letter. - Offer is valid for a limited time only as stated on front of letter. - Pre-approval does not guarantee final approval. Final approval is contingent upon verification of identification, employment, income, credit and debt obligations as they pertain to the criteria established for this offer. - Personal information including, but not limited to, credit bureau information, employment information and income information may be requested and collected for verification purposes. - Pre-approval offer applies to vehicles purchased for personal use only. - Pre-approval applies to any new or certified pre-owned vehicle. Customer must take delivery of vehicle prior to expiration date stated on front. - Pre-approval offer is non-transferable and supersedes all prior offers. Pre-approval offer is valid only for individuals named on Pre-approval certificate. - Chrysler Capital will be listed as lien holder on the vehicle title and insurance documentation. - You must have the legal capacity to enter into a binding contract. You must be at least 18 years of age and have a minimum verifiable income of $2,000 per month. - You must provide valid identification and evidence of full coverage automobile insurance at the time of purchase. - Any bankruptcies must be fully discharged prior to funding. - Any automobile repossession must be at least 6 months old and paid off. - Any prior charged-off or delinquent history with Chrysler Capital or Santander Consumer USA may disqualify you for this pre-approval offer. - All information that you provide must be true and correct. Chrysler Capital assumes no responsibility for incorrect information provided by the various consumer credit reporting agencies. - Vehicle age and mileage restrictions apply.
- See participating Chrysler dealer for details.<br>
<b>DEALER INSTRUCTIONS</b>
- Verify that the customer's name and address matches that of their pre-approval letter. - Check the expiration date printed on the pre-approval letter. - Normal underwriting policies and provisions apply. - Submit the customer's pre-approval letter and certificate with contract.

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