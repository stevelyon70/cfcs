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
		

		<cfquery datasource="SALL" name="Get_dealer_Detl">
			SELECT	ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Show_Address, Dealer_Show_Phone, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State,
     		    Dealer_Zip, Dealer_Phone, Dealer_title, Dealer_Contact, Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active,
                clicks, email_type, Dealer_Report_Name, Dealer_Show_Links, Dealer_Homepage_Link_Text, Dealer_Homepage_link, Dealer_Inventory_Link_Text, 
                Dealer_Inventory_link, Dealer_Finance_Link_Text, Dealer_Finance_Link, Dealer_Contact_Us_Text, Dealer_Contact_Us,YouTube_link
			FROM    Dealers
			WHERE	dealer_id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.dealercode_id#" maxlength="6">
		</cfquery>

		<cfquery name="get_oem" datasource="Ultra10">
			SELECT   OEM_ID,OEM_Name,description  
			FROM   OEMs
			WHERE	oem_id = #Get_dealer_Detl.dealer_image#
		</cfquery>
		<cfset oem_name = "" >
		<cfif #get_oem.recordcount# NEQ 0 >
			<cfset oem_name = #get_oem.OEM_Name# >
		</cfif>
		
		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL, Campaign_type, Campaign_Identifier, Campaign_Contact, Campaign_Contact_Phone, 
    	                  Campaign_contact_email, Campaign_Image, Comments, Visits, active, start_dt, expires_dt
			FROM         Campaign_Control
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Detl.Campaign_ID#" maxlength="6"> 
		</cfquery>
		
		<cfquery datasource="SALL" name="Get_Lead_Detail">
			SELECT		Leads.Lead_ID,Leads.PIN,Leads.first_name,Leads.last_name,Leads.address,Leads.city,Leads.state,Leads.zip,Leads.phone,Leads.email,
						Leads.trade_year,Leads.trade_make,Leads.trade_model,Leads.Authorization_nbr,Leads.Newsletter_Opt_In,Leads.date_submitted
			FROM		Leads 
			WHERE		leads.MyID=<cfqueryparam value="#arguments.MyID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>  
		
		 <cfquery datasource="SALL" name="Get_Page_Area_1">
			SELECT     id, page_text
			FROM         Page_Text
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Detl.Campaign_ID#" maxlength="6"> 
			AND		page_nbr = 3
			AND 	page_area = 1
			AND		active = 1
		</cfquery>
		<cfif #Get_Page_Area_1.recordcount# NEQ 0 >
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$CUST1$","#Get_Lead_Detail.first_name#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$CUST2$","#Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$CEMAIL$","#Get_Lead_Detail.email#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$CUST$","#Get_Lead_Detail.first_name# #Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$WHERE$","#Get_dealer_Detl.Dealer_Name#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$OEMMAKE$","#oem_name#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$DEMAIL$","#Get_dealer_Detl.Dealer_Email#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$DPHN$","#Get_dealer_Detl.Dealer_Phone#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$YEAR$","#Get_Lead_Detail.trade_year#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$MAKE$","#Get_Lead_Detail.trade_make#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$MODEL$","#Get_Lead_Detail.trade_model#","All")>
			<cfset Get_Page_Area_1.page_text=replace(Get_Page_Area_1.page_text,"$AUTH$","#Get_Lead_Detail.Authorization_nbr#","All")>
		</cfif>						
		
		<cfquery datasource="Ultra10" name="Get_program_Details">
			SELECT		Dealer_ID,
						dealer_directory
			FROM		Dealers
			WHERE		Dealer_id = 331
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset variables.dlr_dir = #Get_program_Details.Dealer_Directory#>
	 
		<cfset url.dealercode = #url.Dealercode# > 
		

<!--- Page 1 --->		
		<section class="section-spl">
			<div class="container" >
			 	<div class="row">
					<div class="col-md-8 no-pad" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header.jpg" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-4 no-pad" align="right" style="color:##cc0000;font-size:18px;font-weight:bold" >				 
						#Get_dealer_Detl.Dealer_Name#
						<cfif #Get_dealer_Detl.Dealer_Show_Address# EQ 1 >
							<br>#Get_dealer_Detl.Dealer_Address_1#
							<cfif #Get_dealer_Detl.Dealer_Address_2# NEQ "" >
								<br>#Get_dealer_Detl.Dealer_Address_2#
							</cfif>
							<cfif #Get_dealer_Detl.Dealer_City# NEQ "" >
								<br>#Get_dealer_Detl.Dealer_City# #Get_dealer_Detl.Dealer_State# #Get_dealer_Detl.Dealer_Zip#
							</cfif>
						</cfif>
						<cfif #Get_dealer_Detl.Dealer_Show_Phone# EQ 1 >
							<br>#Get_dealer_Detl.Dealer_Phone#
						</cfif>	
					</div>
				</div>  
			</div>
		</section>	
		<section class="section-spl">
			<div class="container" >
				<div class="row"><div class="col-md-12">&nbsp;</div></div>
			 	<div class="row">
					<div class="col-md-12 no-pad"  >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/splash_image.jpg" border="0" class="img-responsive"> 
					</div>
				</div> 
			</div>
		</section>
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="col-md-8 " align="left" >	
							<div class="col-md-12">
								#Get_Page_Area_1.page_text#
							</div>
						</div>
					</div>
			</div>  <!--- container --->
		</section>


	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">
	</cffunction>

</cfcomponent>