<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="false">
		<cfargument name="method_name" required="false">
		<cfargument name="display_type" default="">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
			<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		
		<cfquery datasource="Ultra10" name="Get_Control_Details">
			SELECT		Dealer_ID,
						dealer_directory
			FROM		Dealers
			WHERE		Dealer_id = 285
		</cfquery>
		<cfset variables.dlr_dir = #Get_Control_Details.Dealer_Directory#>
		
		<cfquery datasource="CCAP10" name="Get_dealer_Details">
			SELECT	  ID, Campaign_ID, Dealer_ID, Dealer_srt, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, 
                      Dealer_Contact, Dealer_Email, Dealer_ADF_Email, Dealer_Website, inventory_link, finance_link, contact_link, Destination_URL, PURL_Identifier, Dealer_Image, 
                      Comments, Links_in_Emails, Links_on_Screens, start_dt, expires_dt, active, clicks, Dealer_Report_Name
			FROM         Dealers
			WHERE	id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.dealer_id#" maxlength="6">
		</cfquery>

		<cfset url.dealercode = #url.Dealer_ID#  >
		
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
		
		

		<section class="section-spl">
			<div class="container" >
			<!--- <div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div> --->
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
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
						<div class="row">
							<div class="col-md-8 " align="center" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								
								<h2>REGISTRATION COMPLETE</h2>
								<span style="font-size:14pt;color:black;font-weight:bold">
								Thank you for submitting your information to #Get_dealer_Details.Dealer_Name#!<br>We will be contacting you shortly to discuss your auto loan options. 
								<cfif #Get_dealer_Details.Dealer_Phone# NEQ "" >However if you would like to contact us immediately, you may call us at #Get_dealer_Details.Dealer_Phone#.</cfif>
								<cfif #Get_dealer_Details.Links_on_Screens# EQ 1 >
									<br>Also, don’t hesitate to 
									<a class="standard" href="http://#cgi.server_name#/clicks/ccap_click.cfm?MyID=#arguments.MyID#&click_action=Click_Website" title="Visit Our Homepage" target="_blank"><span style="font-size:14pt;color:blue;font-weight:bold">Visit Our Homepage</span></a> 
									<span style="font-size:14pt;color:black;font-weight:bold">or</span> <a class="standard" href="http://#cgi.server_name#/clicks/ccap_click.cfm?MyID=#arguments.MyID#&click_action=Click_Inventory" title="Search Our Inventory" target="_blank"><span style="font-size:14pt;color:blue;font-weight:bold">Search Our Inventory</span></a>.<br/><br/>
								</cfif>
								
							</div>
							<div class="col-md-4" align="center"  >	
								<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/coupledodge.png" border="0" class="img-responsive"> 
							</div>
						</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
					</div>
			</div>  <!--- container --->
		</section>


	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">
	</cffunction>

</cfcomponent>