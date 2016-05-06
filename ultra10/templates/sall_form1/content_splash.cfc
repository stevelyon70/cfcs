
<cfcomponent>
<cfoutput>

	<cffunction name="modern" description="SALL Form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
		<cfif IsDefined("url.page2")>
<!--- Page 2 --->
		<cfquery datasource="SALL" name="Get_dealer_Detl">
			SELECT	ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Show_Address, Dealer_Show_Phone, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State,
     		    Dealer_Zip, Dealer_Phone, Dealer_title, Dealer_Contact, Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active,
                clicks, email_type, Dealer_Report_Name, Dealer_Show_Links, Dealer_Homepage_Link_Text, Dealer_Homepage_link, Dealer_Inventory_Link_Text, 
                Dealer_Inventory_link, Dealer_Finance_Link_Text, Dealer_Finance_Link, Dealer_Contact_Us_Text, Dealer_Contact_Us,YouTube_link,Dealer_Show_Logo
			FROM    Dealers
			WHERE	dealer_id=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.dealercode_id#" maxlength="6">
		</cfquery>

		<cfquery name="get_oem" datasource="Ultra10">
			SELECT   OEM_ID, OEM_Name, Active, Logo, description
			FROM   OEMs
			WHERE	oem_id = #Get_dealer_Detl.dealer_image#
		</cfquery>
		<cfset oem_name = "" >
		<cfset oem_logo = "" >
		<cfif #get_oem.recordcount# NEQ 0 >
			<cfset oem_name = #get_oem.OEM_Name# >
			<cfset oem_logo = #get_oem.Logo# >
		</cfif>
		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL, Campaign_type, Campaign_Identifier, Campaign_Contact, Campaign_Contact_Phone, 
    	                  Campaign_contact_email, Campaign_Image, Comments, Visits, active, start_dt, expires_dt
			FROM         Campaign_Control
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Detl.Campaign_ID#" maxlength="6"> 
		</cfquery>
		
		<cfquery name="get_images" datasource="SALL">
			SELECT     id, campaign_id, left_header_image, splash_image, lower_right_image, video_image, lower_page2_image, 
						button_page1, button_page2, email_image_1, email_image_2, active
			FROM       Campaign_Images
			where	campaign_id = #Get_Control_Details.campaign_id#
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
			AND		page_nbr = 2
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
		
		 <cfquery datasource="SALL" name="Get_Page_Area_2">
			SELECT     id, page_text
			FROM         Page_Text
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Detl.Campaign_ID#" maxlength="6"> 
			AND		page_nbr = 2
			AND 	page_area = 2
			AND		active = 1
		</cfquery>
		<cfif #Get_Page_Area_2.recordcount# NEQ 0 >
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$CUST1$","#Get_Lead_Detail.first_name#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$CUST2$","#Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$CEMAIL$","#Get_Lead_Detail.email#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$CUST$","#Get_Lead_Detail.first_name# #Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$WHERE$","#Get_dealer_Detl.Dealer_Name#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$OEMMAKE$","#oem_name#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$DEMAIL$","#Get_dealer_Detl.Dealer_Email#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$DPHN$","#Get_dealer_Detl.Dealer_Phone#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$YEAR$","#Get_Lead_Detail.trade_year#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$MAKE$","#Get_Lead_Detail.trade_make#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$MODEL$","#Get_Lead_Detail.trade_model#","All")>
			<cfset Get_Page_Area_2.page_text=replace(Get_Page_Area_2.page_text,"$AUTH$","#Get_Lead_Detail.Authorization_nbr#","All")>
		</cfif>			
		 <cfquery datasource="SALL" name="Get_Page_Area_3">
			SELECT     id, page_text
			FROM         Page_Text
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Detl.Campaign_ID#" maxlength="6"> 
			AND		page_nbr = 2
			AND 	page_area = 3
			AND		active = 1
		</cfquery>
		<cfif #Get_Page_Area_3.recordcount# NEQ 0 >
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$CUST1$","#Get_Lead_Detail.first_name#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$CUST2$","#Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$CEMAIL$","#Get_Lead_Detail.email#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$CUST$","#Get_Lead_Detail.first_name# #Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$WHERE$","#Get_dealer_Detl.Dealer_Name#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$OEMMAKE$","#oem_name#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$DEMAIL$","#Get_dealer_Detl.Dealer_Email#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$DPHN$","#Get_dealer_Detl.Dealer_Phone#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$YEAR$","#Get_Lead_Detail.trade_year#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$MAKE$","#Get_Lead_Detail.trade_make#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$MODEL$","#Get_Lead_Detail.trade_model#","All")>
			<cfset Get_Page_Area_3.page_text=replace(Get_Page_Area_3.page_text,"$AUTH$","#Get_Lead_Detail.Authorization_nbr#","All")>
		</cfif>					
		 <cfquery datasource="SALL" name="Get_Page_Area_4">
			SELECT     id, page_text
			FROM         Page_Text
			WHERE	Campaign_ID=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_dealer_Detl.Campaign_ID#" maxlength="6"> 
			AND		page_nbr = 2
			AND 	page_area = 4
			AND		active = 1
		</cfquery>
		<cfif #Get_Page_Area_4.recordcount# NEQ 0 >
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$CUST1$","#Get_Lead_Detail.first_name#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$CUST2$","#Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$CEMAIL$","#Get_Lead_Detail.email#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$CUST$","#Get_Lead_Detail.first_name# #Get_Lead_Detail.last_name#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$WHERE$","#Get_dealer_Detl.Dealer_Name#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$OEMMAKE$","#oem_name#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$DEMAIL$","#Get_dealer_Detl.Dealer_Email#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$DPHN$","#Get_dealer_Detl.Dealer_Phone#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$YEAR$","#Get_Lead_Detail.trade_year#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$MAKE$","#Get_Lead_Detail.trade_make#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$MODEL$","#Get_Lead_Detail.trade_model#","All")>
			<cfset Get_Page_Area_4.page_text=replace(Get_Page_Area_4.page_text,"$AUTH$","#Get_Lead_Detail.Authorization_nbr#","All")>
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
		<section class="section-spl">
			<div class="container" >
			 	<div class="row">
					<div class="col-md-7 no-pad" align="left" >				 
						<cfif #get_images.left_header_image# NEQ "" >
							<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/#get_images.left_header_image#" border="0" class="img-responsive"> 
						</cfif>
					</div>
					<div class="col-md-5 no-pad" align="right" style="color:##cc0000;font-size:18px;font-weight:bold" >		
						<div class="row pad-top-10">	
						
							<cfif #Get_dealer_Detl.Dealer_Show_Logo# EQ 1 >
								<div class="col-md-9" align="right">		 
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
										<br>#Get_dealer_Detl.Dealer_Phone#
								</div>
								<div class="col-md-3" align="right">  
									<img src="http://dealers.wdautos.com/images/brand_logos/#oem_logo#"  alt="#OEM_Name#" >
								</div>
							<cfelse>
								<div class="col-md-12 pull-right" align="right">		 
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
							</cfif>
							
						</div>
						
					</div>
				</div>  
			</div>
		</section>	
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row ">
							<div class="col-md-6 pad-top-10" align="left" >	 
								<cfif #Get_dealer_Detl.Dealer_Show_Links# EQ 1 >
									<div class="row pad-top-3" style="margin-top:5px;height:24px;background-color:##cc0000;color:##ffffff;font-size:10px" >
										<cfif #Get_dealer_Detl.Dealer_Homepage_link# NEQ"" >
											<div class="col-md-3 " style="margin-top:4px;background-color:##cc0000;color:##ffffff;font-size:10px" align="left" >		
											<a href="#Get_dealer_Detl.Dealer_Homepage_link#" target="_blank" style="color:##ffffff;font-size:12px;font-weight:bold" >#Get_dealer_Detl.Dealer_Homepage_link_text#</a>
											</div>		 
										</cfif>
										<cfif #Get_dealer_Detl.Dealer_Inventory_link# NEQ"" >
											<div class="col-md-3 " style="margin-top:4px;background-color:##cc0000;color:##ffffff;font-size:10px"  align="center" >		
											<a href="#Get_dealer_Detl.Dealer_Inventory_link#" target="_blank" style="margin-top:5px;color:##ffffff;font-size:12px;font-weight:bold">#Get_dealer_Detl.Dealer_Inventory_link_text#</a>
											</div>		 
										</cfif>
										<cfif #Get_dealer_Detl.Dealer_Finance_Link# NEQ"" >	 
											<div class="col-md-3  " style="margin-top:4px;background-color:##cc0000;color:##ffffff;font-size:10px"  align="right" >		
											<a href="#Get_dealer_Detl.Dealer_Finance_Link#" target="_blank" style="margin-top:5px;color:##ffffff;font-size:12px;font-weight:bold">#Get_dealer_Detl.Dealer_Finance_Link_text#</a>
											</div>		 
										</cfif>
										<cfif #Get_dealer_Detl.Dealer_Contact_Us# NEQ"" >		 
											<div class="col-md-3  " style="margin-top:4px;background-color:##cc0000;color:##ffffff;font-size:10px"  align="right" >		
											<a href="#Get_dealer_Detl.Dealer_Contact_Us#" target="_blank" style="margin-top:5px;color:##ffffff;font-size:12px;font-weight:bold">#Get_dealer_Detl.Dealer_Contact_Us_text#</a>
											</div>		 
										</cfif>	 
									</div>
								</cfif>
								<div class="row pad-top-3"  style="background-color:##ffffff">
									<div class="col-md-12" align="left" >
  										 <iframe 	width="100%" 
										 			height="350" 
													src="#Get_dealer_Detl.YouTube_Link#" 
													frameborder="0" 
													allowfullscreen>
										</iframe>
									</div>
								</div>												
							</div> 
							<div class="col-md-6 pad-top-10  pad left 5" align="left"  >	
								<div class="row" align="left">
									<div class="col-md-12 pad-top-10 ">
										#Get_Page_Area_1.page_text#
									</div>
								</div>
								<div class="row"><div class="col-md-12">&nbsp;</div></div>
								<div class="row" align="left">
									<div class="col-md-12">
										#Get_Page_Area_2.page_text#
									</div>
								</div>
							</div>
						</div>
					</div>
			</div>  <!--- container --->
		</section>
		
		<section class="section-spl" style="background-color:##ffffff" >
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-6 " align="left" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >
									<div class="col-md-2 " align="right" >&nbsp;</div>
									<div class="col-md-10 " align="left" >	
										#Get_Page_Area_3.page_text#
									</div>								
								&nbsp;</div>
								<div class="row" >
									<div class="col-md-12 " align="center" >	
								<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/arrow_graphic.jpg" border="0" class="img-responsive"> 
								</div>
								</div>
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
							<div class="row" >
							<div class="col-md-12 " align="left" >	
								#Get_Page_Area_4.page_text#
							</div>	
							</div>	
						&nbsp;
						</div>
					</div>
			</div>  
		</section>
		

		<cfelse>
<!--- Page 1 --->		


		 <cfquery datasource="SALL" name="Get_Control_Details">
			 SELECT     ID, Campaign_ID, Campaign_Name, Campaign_URL, Campaign_type, Campaign_Identifier, Campaign_Contact, Campaign_Contact_Phone, 
    	                  Campaign_contact_email, Campaign_Image, Comments, Visits, active, start_dt, expires_dt
			FROM         Campaign_Control
			WHERE	Campaign_URL=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CGI.server_name#" maxlength="50"> 
		</cfquery>
		
		<cfquery name="get_images" datasource="SALL">
			SELECT     id, campaign_id, left_header_image, splash_image, lower_right_image, video_image, lower_page2_image, 
						button_page1, button_page2, email_image_1, email_image_2, active
			FROM       Campaign_Images
			where	campaign_id = #Get_Control_Details.campaign_id#
		</cfquery>
		
		<section class="section-spl">
			<div class="container" >
			 	<div class="row">
					<div class="col-md-12 no-pad" align="left" >				 
						<cfif #get_images.left_header_image# NEQ "" >
							<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/#get_images.left_header_image#" border="0" class="img-responsive"> 
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
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/#get_images.splash_image#" border="0" class="img-responsive"> 
					</div>
				</div> 
			</div>
		</section>
		<!--- --->
		<cfset tst_image = "#get_images.lower_right_image#" >
		<section class="section-spl visible-lg visible-md">
			<div class="container"  style="background:url('http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/#tst_image#');background-repeat:no-repeat;height:320px;width:990px"  >
						<div class="row">
							<div class="col-md-8 pull-left">	
								  <cfinvoke component="/cfcs/forms/form_sall" method="sall_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/sall_action.cfm"/>
								</cfinvoke>     
							</div>
					
						</div>
					</div>
			</div>   
		</section>
		<section class="section-spl visible-sm visible-xs">
			<div class="container"  >
						<div class="row">
							<div class="col-md-12 pull-left">	
								  <cfinvoke component="/cfcs/forms/form_sall" method="sall_default_mobile">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/sall_action.cfm"/>
								</cfinvoke>     
							</div>
							
						</div>
					</div>
			</div>   
		</section>
		
		</cfif>
		
	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>
</cfoutput>
</cfcomponent>