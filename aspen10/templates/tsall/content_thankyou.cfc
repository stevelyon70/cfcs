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
			WHERE	dealer_id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.dealer_id#" maxlength="6">
		</cfquery>

		<cfset url.dealercode = #url.Dealercode#  >
		
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
		
		

		<section class="section-spl">
			<div class="container" >
			<!--- <div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div> --->
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
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
						<cfif #Get_dealer_Details.Address_1# NEQ "">
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
								Thank you for submitting your information to #Get_dealer_Details.Display_Name#! We will be contacting you shortly to discuss your loan options. 
							<cfif #url.dealer_id# NEQ 524>	However if you would like to contact us immediately, you may call us at #Get_phones.Area_Code#.#Get_phones.Prefix#.#Get_phones.Line_Number#.</cfif><br>Also, don’t hesitate to 
								<a class="standard" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#arguments.MyID#&click_action=Click_Website" title="Visit Our Homepage" target="_blank"><span style="font-size:14pt;color:blue;font-weight:bold">Visit Our Homepage</span></a> 
								<span style="font-size:14pt;color:black;font-weight:bold">or</span> <a class="standard" href="http://#cgi.server_name#/clicks/sall_click.cfm?MyID=#arguments.MyID#&click_action=Click_Inventory" title="Search Our Inventory" target="_blank"><span style="font-size:14pt;color:blue;font-weight:bold">Search Our Inventory</span></a>.<br/><br/>
								
							</div>
							<div class="col-md-4" align="center"  >	
								<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/right-side.png" border="0" class="img-responsive"> 
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