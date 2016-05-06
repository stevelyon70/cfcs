
<cfcomponent>
<cfoutput>

	<cffunction name="modern" description="SALL Form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		  <cfargument name="dealercode" required="false">  
		  <cfargument name="dealercode_id" required="false">  
		  <cfargument name="myid" required="false">  
	

		<cfquery datasource="SALL" name="Get_dealer_Details">
			SELECT     ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, 
                      Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active, clicks, email_type, 
                      Dealer_Report_Name
			FROM         Dealers
			<cfif IsDefined("url.take_two")>
				WHERE	dealer_id=#url.take_two#
			<cfelse>
				WHERE	dealer_id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.dealer_id#" maxlength="6">
			</cfif>
		</cfquery>


		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL, Campaign_type, Campaign_Identifier, Campaign_Contact, Campaign_Contact_Phone, 
    	                  Campaign_contact_email, Campaign_Image, Comments, Visits, active, start_dt, expires_dt
			FROM         Campaign_Control
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Details.Campaign_ID#" maxlength="6"> 
		</cfquery>
		
		<cfquery datasource="Ultra10" name="Get_program_Details">
			SELECT		Dealer_ID,
						dealer_directory
			FROM		Dealers
			WHERE		Dealer_id = 331
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>
	 
		<cfset url.dealercode = #url.Dealercode# >  
				 
<!--- Page 2 --->	
			<div class="container" >
			 	<div class="row">
					<div class="col-md-6 no-pad" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header.jpg" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-6 no-pad" align="right" style="color:##cc0000;font-size:15px" >				 
						x#Get_Control_Details.Campaign_Name##Get_dealer_Details.recordcount# #Get_Control_Details.recordcount#
					</div>
				</div>  
			</div>
		</section>	
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row ">
							<div class="col-md-6" align="left" >	 
								<div class="row pad-top-3" style="height:24px;background-color:##cc0000;color:##ffffff;font-size:10px" >
									<div class="col-md-3 pad left 3" align="left" >		
									<a href="##" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold" ><< HOMEPAGE</a>
									</div>		 
									<div class="col-md-6  pad left 3" align="center" >		
									<a href="##" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold"><< SEARCH OUR INVENTORY</a>
									</div>		 
									<div class="col-md-3  pad left 3" align="right" >		
									<a href="##" target="_blank" style="color:##ffffff;font-size:14px;font-weight:bold"><< CONTACT US</a>
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
								<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">&nbsp;Auto Loan From<br>
								&nbsp;$5,500 Up To $39,000.* </span><br>
								<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##cc0000;font-weight:normal">&nbsp;Congratulations! Your pre-qualified* amount is valid at #Get_dealer_Details.Dealer_Name#. Securing funding prior to shopping gives you the purchasing power of a cash buyer and #Get_dealer_Details.Dealer_Name# has agreed to include all new and used vehicles in inventory for this special offer. So the selection is unlimited! #Get_dealer_Details.Dealer_Name# Management has also been authorized to accept purchase offers that meet your pre-qualification* amount. Please note, this offer will expire soon.
								</span>
								</div>
								</div>
								<div class="row"><div class="col-md-12">&nbsp;</div></div>
								<div class="row" align="left">
									<div class="col-md-12">
									<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:12pt;color:##cc0000;font-weight:bold">Final Step<br>
									Verify your identity and provide some additional information.</span><br>
									<span style="font-family:Helvetica-Condensed, sans-serif;font-size:10pt;color:##cc0000;font-weight:normal">Just complete the information below and one of our financial specialists will contact you with your Pre-Approved Auto Loan. Our Sure Auto Loan program can help you purchase a new or used vehicle today!</span>
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
										<span style="font-family:Helvetica-Condensed, sans-serif;font-style:italic;font-size:18pt;color:##cc0000;font-weight:bold">Step 2: Schedule Your Appointment</span><br>
										<span style="font-family:Helvetica-Condensed, sans-serif;font-size:12pt;color:##cc0000;font-weight:normal">Please complete the information to the right to schedule an
										appointment to discuss your loan options. (Be prepared to 
										accept immediate delivery of your vehicle)</span>
									</div>								
								&nbsp;</div>
							</div>
							<div class="col-md-6 " align="right" >	
								<cfinvoke component="/cfcs/forms/form_sall" method="sall_page_2">
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
								<span style="font-family:Helvetica-Condensed, sans-serif;font-size:7pt;color:##cc0000;font-weight:normal">
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

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>

</cfoutput>
</cfcomponent>