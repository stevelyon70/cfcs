<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">	
		
		<link href='http://fonts.googleapis.com/css?family=La+Belle+Aurore' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,800,300' rel='stylesheet' type='text/css'>
		
		<cfif NOT IsDefined("url.page")>
			<cfset url.page = "1" >
		</cfif>
		
		<cfquery name="load_purl" datasource="wd360">
			SELECT  ID, Campaign_ID, Dealer_ID, Firstname, Lastname, PURL, Destination_URL, Max_Loan_Amount, create_dt, first_visit_dt, last_visit_dt, start_dt, expires_dt, 
                    nbr_visits, active, purl_type, Address_1, Address_2, City, State, Zip, Phone, Email, v_year, v_make, v_model
			FROM    Customer_PURLs
			<cfif NOT IsDefined("arguments.multi_purls") >
				 WHERE 	ID = #url.customer_purl_id# 
			<cfelse>
				 WHERE 	PURL = '#arguments.get_purl#' 	 
			 </cfif>
		</cfquery>	
		<cfset get_multi = 0 >
		<cfif #load_purl.recordcount# GT 1 >	
			<cfset get_multi = 1 >
		</cfif>
		
		<!--- ACCESS METHOD 0=PURL 1=EMAIL --->
		<cfset pass_ems = 0 >
		<cfif IsDefined("url.ems") AND #url.ems# EQ 1 >
			<cfset pass_ems = 1 >
		</cfif>
		
		<cfquery name="get_dealer" datasource="wd360">
			SELECT 	ID, Campaign_ID, Dealer_ID, Dealer_Name, truck, Agency_title, Trade_Lease_Loyalty, Dealer_Address_1, Address_1_Link, Dealer_Address_2, Dealer_City, 
          			Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, 
				    expires_dt, active, clicks, email_type, Dealer_Report_Name, Web_Link, Inv_Link, Contact_Link, Finance_Link, Trade_Link, Report_Link, Alt_Link, NV_Link, UV_Link, 
			        Specials_Link, Disclaimer, Exclusions, Additional_Low_Miles, Campaign_Value, Inv_Type, Inv_Value, Coupon, Coupon_Value, Trade_Email, TD_Email, TD_Incentive, 
		          	TD_Incentive_Value, TD_Gift, TD_Gift_Value, TD_Gift_Image, Dealer_Text, Video, Video_Image, Digital_Offer_Type, Digital_Offer_Value, Digital_Authorization, 
		          	TIE_Coupon_1, TIE_Coupon_2, dealer_header_img, dealer_form_logo, dealer_footer_img, dealer_greeting,dealer_offer_amount,email_year_make_model,dealer_signature_img
			FROM    Dealers 
			WHERE	dealer_ID = #load_purl.Dealer_ID#
		</cfquery>
		
		<cfquery name="get_logo" datasource="Ultra10">
			SELECT   OEM_ID ,  OEM_Name , logo, Active ,   description  
			FROM   OEMs
			WHERE	OEM_ID = #get_dealer.Dealer_Image#
		</cfquery>
		
		
		
	<cfif #url.page# EQ 1 >
	
		<cfquery name="get_text_dlr" datasource="wd360">
			SELECT	id, campaign_id, dealer_id, page_nbr, page_text, active, create_ts,page_greeting, page_type, page_button_text, page_button_link,page_email_instruct
			FROM    Page_Text
			WHERE	dealer_id	=	#get_dealer.dealer_id#
			AND		page_type =#pass_ems#
			AND	page_nbr = 1
		</cfquery>
		<cfif #get_text_dlr.recordcount# GT 0>
			<cfset page_text = #get_text_dlr.page_text# >
			<cfset page_greeting = #get_text_dlr.page_greeting# >
			<cfset page_button_text = #get_text_dlr.page_button_text# >
			<cfset page_type = #get_text_dlr.page_type# >
			<cfset ems_instruct = #get_text_dlr.page_email_instruct# >
		</cfif>
		<cfif #get_text_dlr.recordcount# eq 0>
			<cfquery name="get_text_dflt" datasource="wd360">
				SELECT	id, campaign_id, dealer_id, page_nbr, page_text, active, create_ts,page_greeting, page_type, page_button_text, page_button_link,page_email_instruct
				FROM    Page_Text
				WHERE	campaign_id	=	#get_dealer.Campaign_ID#
				AND		page_type =#pass_ems#
				AND	page_nbr = 1
			</cfquery>
			<cfset page_text = #get_text_dflt.page_text# >
			<cfset page_greeting = #get_text_dflt.page_greeting# >
			<cfset page_button_text = #get_text_dflt.page_button_text# >
			<cfset page_type = #get_text_dflt.page_type# >
			<cfset ems_instruct = #get_text_dflt.page_email_instruct# >
		</cfif>
		
		<section class="section-splash-spl">
			<div class="container">		
			
	<!--- Header Desktop Page 1  --->
				<div class="row visible-md visible-lg no-pad" >	
					<div class="col-md-7 welcome-title" align="left">
						<div style="background-color:##fff;margin:5px;">
							<cfset page_greeting=replace(page_greeting,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_greeting=replace(page_greeting,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_greeting=replace(page_greeting,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_greeting=replace(page_greeting,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_greeting=replace(page_greeting,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_greeting=replace(page_greeting,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_greeting=replace(page_greeting,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_greeting#
						</div>
					</div>	
					<div class="col-md-5"  align="right">
						<div class="row pad-top-10">	
							<div class="col-md-9" align="right">
								<div class="dealer-name">#get_dealer.dealer_Name#</div> 
								<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
							</div>
							<div class="col-md-3" align="right">  
								<img src="http://dealers.wdautos.com/images/brand_logos/#get_logo.logo#"  alt="#get_logo.OEM_Name#" >
							</div>
						</div>
					</div>
				</div>	
				<div class="row visible-md visible-lg"><div class="col-md-12 gradient"></div></div>	
				<div class="row visible-md visible-lg" >	 
					<div class="col-md-12 no-pad" align="left">
						<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_header_img#" class="img-responsive" border="0">  
					</div>
				</div>	
				
	<!--- Header Mobile Page 1  --->
				<div class="row visible-sm visible-xs " >	
					<div class="col-md-12  "  align="left">
						 <div class="row">	
							<div class="col-md-12  pad-top-10"  align="right">
								<img src="http://dealers.wdautos.com/images/brand_logos/#get_logo.logo#" class="img-responsive" style="margin-left:8px;float:right"  alt="#get_logo.OEM_Name#" >
								<div class="dealer-name">#get_dealer.dealer_Name#</div>
								<div class="dealer-address" >#get_dealer.Dealer_Address_1#</div> 
								<div class="dealer-address" >#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
								
							</div>
						</div>
						<div class="col-md-7 welcome-title" align="left">
							<cfset page_greeting=replace(page_greeting,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_greeting=replace(page_greeting,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_greeting=replace(page_greeting,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_greeting=replace(page_greeting,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_greeting=replace(page_greeting,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_greeting=replace(page_greeting,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_greeting=replace(page_greeting,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_greeting#
						</div>
					</div> 
				</div>
				<div class="row visible-sm visible-xs no-pad "   >	 
					<div class="col-md-12 no-pad" align="left" >
						<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_header_img#" class="img-responsive" border="0">  
					</div>
				</div>	


		
	<!--- Body DESKTP & MOBILE Page 1  --->	
				<div class="row">	 
					<div class="col-md-6 body-text visible-md visible-lg pad-top-10" align="left">
						<div style="background-color:##fff;margin:5px;">
							<cfset page_text=replace(page_text,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_text=replace(page_text,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_text=replace(page_text,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_text=replace(page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_text=replace(page_text,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_text=replace(page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_text=replace(page_text,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_text#
						</div>
						<div class="row">	
							<div class="col-md-12 no-pad" align="left"  style="margin-left:5px">
								<div style="background-color:##fff;margin:5px;">
								<cfif #get_dealer.dealer_signature_img# NEQ "" >
									<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_signature_img#"  class="img-responsive" border="0">
								<cfelse>	
									<div class="signature_fnt">#get_dealer.Dealer_Contact#</div>  
								</cfif>	
								<span class="body-text" style="margin-left:10px">#get_dealer.Dealer_Phone#, #get_dealer.Dealer_Name#</span>
								</div>
							</div>	
						</div>
					</div>
					
					<div class="col-md-1" >&nbsp;</div>
					
	<!--- Form DESKTOP Page 1 --->
					<div class="col-md-5 visible-md visible-lg" align="left" >
						<div class="row" style="max-height:80px;background-color:##1b2a59">	
							<div class="col-md-6 no-pad" align="left">
								<div style="font-size:20pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px"><i>Step ##1</i></div>
							</div>
							<div class="col-md-6 no-pad" align="right" >
								<cfif #get_dealer.dealer_form_logo# NEQ "" >
									<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_form_logo#"  class="img-placement" border="0">
								</cfif>
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12 no-pad" align="right" style="background-color:##EBEBEB">	
								<cfinvoke component="/cfcs/forms/form_purl360" method="purls_default">
									<cfinvokeargument name="dealer_id" value="#load_purl.dealer_id#"/>
									<cfinvokeargument name="pass_ems" value="#pass_ems#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="purls_default"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/purl360_action.cfm"/>
									<cfinvokeargument name="ems_instruct" value="#ems_instruct#"/>
									<cfinvokeargument name="ems_vehicle" value="#get_dealer.email_year_make_model#"/>
									<cfif #get_multi# eq 1 >
										<cfinvokeargument name="passed_purl" value="#arguments.get_purl#"/>
									</cfif>
								</cfinvoke>  
							</div>
						</div>
					</div>
					
	<!--- Form Mobile Page 1 --->
					<div class="col-md-5 visible-sm visible-xs" align="left" >
						<div class="row" style="max-height:80px;background-color:##1b2a59">	
							<div class="col-md-6 no-pad" align="left">
								<div style="font-size:20pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px"><i>Step ##1</i></div>
							</div>
							<div class="col-md-6 no-pad" align="right" >
								<cfif #get_dealer.dealer_form_logo# NEQ "" >
									<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_form_logo#"  class="img-placement img-placement-mbl" border="0">
								</cfif>	
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12 no-pad" align="right" style="background-color:##EBEBEB">	
								<cfinvoke component="/cfcs/forms/form_purl360" method="purls_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="pass_ems" value="#pass_ems#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="purls_default"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/purl360_action.cfm"/>
									<cfinvokeargument name="ems_instruct" value="#ems_instruct#"/>
									<cfinvokeargument name="ems_vehicle" value="#get_dealer.email_year_make_model#"/>
									<cfif #get_multi# eq 1 >
										<cfinvokeargument name="passed_purl" value="#arguments.get_purl#"/>
									</cfif>
								</cfinvoke>  
							</div>
						</div>
					</div>
				</div>
				
	<!--- Footer DESKTOP Page 1 --->	
			<div class="row visible-md visible-lg "><div class="col-md-12 gradient"></div></div>			
			<cfif 	#get_dealer.dealer_footer_img# NEQ "" >
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;valign:bottom" align="center">
						 <img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_footer_img#"  alt="#get_dealer.Agency_title#" >
					</div>
				</div>	
			</cfif>
				<div class="row visible-md visible-lg  pad-top-10">	
				</div>

	<!--- Footer MOBILE Page 1 --->	
			<cfif 	#get_dealer.dealer_footer_img# NEQ "" >
				<div class="row visible-sm visible-xs ">	
					<div class="col-md-12 " align="center">
						 <img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_footer_img#" class="img-responsive" style="float:left"  alt="#get_dealer.Agency_title#" >
					</div>	
				</div>	
			</cfif>	
	
			</div>  <!--- container --->
			
			
		</section>
	<cfelse>

		<!--- LEFT --->
		<cfquery name="get_text2_dlr" datasource="wd360">
			SELECT	page_nbr, page_text, page_greeting, page_type, page_button_text, page_button_link FROM Page_Text WHERE dealer_id=#get_dealer.dealer_id#	AND	page_nbr=2 AND page_type=#pass_ems#</cfquery>
		<cfif #get_text2_dlr.recordcount# GT 0>
			<cfset page_text2 = #get_text2_dlr.page_text# ><cfset page_greeting2 = #get_text2_dlr.page_greeting# ><cfset page_button_text2 = #get_text2_dlr.page_button_text# >
			<cfset page_type2 = #get_text2_dlr.page_type# >
		</cfif>
		<cfif #get_text2_dlr.recordcount# eq 0>
			<cfquery name="get_text2_dflt" datasource="wd360">
				SELECT	page_nbr, page_text, page_greeting, page_type, page_button_text, page_button_link FROM Page_Text WHERE campaign_id=#get_dealer.Campaign_ID# AND	page_nbr=2 AND page_type=#pass_ems# </cfquery>
			<cfset page_text2 = #get_text2_dflt.page_text# ><cfset page_greeting2 = #get_text2_dflt.page_greeting# ><cfset page_button_text2 = #get_text2_dflt.page_button_text# >
			<cfset page_type2 = #get_text2_dflt.page_type# >
		</cfif>
		<!--- RIGHT --->
		<cfquery name="get_text3_dlr" datasource="wd360">
			SELECT	page_nbr, page_text, page_greeting, page_type, page_button_text, page_button_link FROM Page_Text WHERE dealer_id=#get_dealer.dealer_id#	AND	page_nbr=3 AND page_type=#pass_ems#</cfquery>
		<cfif #get_text3_dlr.recordcount# GT 0>
			<cfset page_text3 = #get_text3_dlr.page_text# ><cfset page_greeting3 = #get_text3_dlr.page_greeting# ><cfset page_button_text3 = #get_text3_dlr.page_button_text# >
			<cfset page_type3 = #get_text3_dlr.page_type# >
		</cfif>
		<cfif #get_text3_dlr.recordcount# eq 0>
			<cfquery name="get_text3_dflt" datasource="wd360">
				SELECT	page_nbr, page_text, page_greeting, page_type, page_button_text, page_button_link FROM Page_Text WHERE campaign_id=#get_dealer.Campaign_ID# AND	page_nbr=3 AND page_type=#pass_ems#</cfquery>
			<cfset page_text3 = #get_text3_dflt.page_text# ><cfset page_greeting3 = #get_text3_dflt.page_greeting# ><cfset page_button_text3 = #get_text3_dflt.page_button_text# >
			<cfset page_type3 = #get_text3_dflt.page_type# >
		</cfif>

		<section class="section-splash-spl">
			<div class="container">		
			
	<!--- Header DESKTOP Page 2 --->
				<div class="row visible-md visible-lg no-pad" >	
					<div class="col-md-7 welcome-title" align="left">
						<div style="background-color:##fff;margin:5px;">
							<cfset page_greeting2=replace(page_greeting2,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_greeting2#
						</div>
					</div>	
					<div class="col-md-5"  align="right">
						<div class="row  pad-top-10">	
							<div class="col-md-9" align="right">
								<div class="dealer-name">#get_dealer.dealer_Name#</div> 
								<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
							</div>
							<div class="col-md-3" align="right">  
								<img src="http://dealers.wdautos.com/images/brand_logos/#get_logo.logo#"  alt="#get_logo.OEM_Name#" >
							</div>
						</div>
					</div>
				</div>	
				<div class="row visible-md visible-lg"><div class="col-md-12 gradient"></div></div>	
				<div class="row visible-md visible-lg" >	 
					<div class="col-md-12 no-pad" align="left">
						<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_header_img#" class="img-responsive" border="0">  
					</div>
				</div>	
				
	<!--- Header MOBILE Page 2 --->
				<div class="row visible-sm visible-xs " >	
					<div class="col-md-12  "  align="left">
						 <div class="row">	
							<div class="col-md-12   no-pad"  align="right">
								<img src="http://dealers.wdautos.com/images/brand_logos/#get_logo.logo#" class="img-responsive" style="margin-left:8px;float:right"  alt="#get_logo.OEM_Name#" >
								<div class="dealer-name">#get_dealer.dealer_Name#</div>
								<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
								
							</div>
						</div>
						<div class="col-md-7 welcome-title" align="left">
							<cfset page_greeting2=replace(page_greeting2,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_greeting2=replace(page_greeting2,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_greeting2#
						</div>
					</div> 
				</div>
				<div class="row visible-sm visible-xs no-pad "   >	 
					<div class="col-md-12 no-pad" align="left" >
						<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_header_img#" class="img-responsive" border="0">  
					</div>
				</div>	
		
	<!--- Body DESKTOP & MOBILE Page 2  --->	
				<div class="row">	 
					<div class="col-md-6 body-text visible-md visible-lg pad-top-10" align="left">
						<div style="background-color:##fff;margin:5px;">
							<cfset page_text2=replace(page_text2,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_text2=replace(page_text2,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_text2=replace(page_text2,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_text2=replace(page_text2,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_text2=replace(page_text2,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_text2=replace(page_text2,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_text2=replace(page_text2,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_text2#
						<!--- Signature Section --->	
						<div class="row">	
							<div class="col-md-12" align="left" style="margin-left:0px">
								<cfif #get_dealer.dealer_signature_img# NEQ "" >
									<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_signature_img#"  class="img-responsive" border="0">
								<cfelse>	
									<div class="signature_fnt">#get_dealer.Dealer_Contact#</div>  
								</cfif>	 
								<span class="body-text" >#get_dealer.Dealer_Phone#, #get_dealer.Dealer_Name#</span>
							</div>
						</div>
						</div>
					</div>
					<div class="col-md-1" >&nbsp;</div>
					
	<!--- Form DESKTOP Page 2  --->
					<div class="col-md-5 visible-md visible-lg" align="left" >
						<div class="row" style="max-height:80px;background-color:##1b2a59">	
							<div class="col-md-6 no-pad" align="left">
								<div style="font-size:20pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px"><i>Step ##2</i></div>
							</div>
							<div class="col-md-6 no-pad" align="right" >
								<cfif #get_dealer.dealer_form_logo# NEQ "" >
									<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_form_logo#"  class="img-placement-js" border="0">
								</cfif>	
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12" align="left" style="background-color:##EBEBEB">	
							<cfset page_text3=replace(page_text3,"$YEAR$","#load_purl.v_year#","All")>
							<cfset page_text3=replace(page_text3,"$MAKE$","#load_purl.v_make#","All")>
							<cfset page_text3=replace(page_text3,"$MODEL$","#load_purl.v_model#","All")>
							<cfset page_text3=replace(page_text3,"$WHERE$","#get_dealer.dealer_Name#","All")>
							<cfset page_text3=replace(page_text3,"$CUST$","#load_purl.Firstname#","All")>
							<cfset page_text3=replace(page_text3,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
							<cfset page_text3=replace(page_text3,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
							#page_text3#
								<a href="#get_dealer.Destination_URL#" style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##3c8443!important;font-weight:bold" class="btn btn-primary">#page_button_text3#</a>
								<div class="row"><div class="col-md-12" >&nbsp;</div></div><div class="row"><div class="col-md-12" >&nbsp;</div></div>
							</div>
						</div>
					</div>
					
	<!--- Form MOBILE Page 2 --->
					<div class="col-md-5 visible-sm visible-xs" align="left" >
						<div class="row" style="max-height:80px;background-color:##1b2a59">	
							<div class="col-md-6 no-pad" align="left">
								<div style="font-size:20pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px"><i>Step ##2</i></div>
							</div>
							<div class="col-md-6 no-pad" align="right" >
								<cfif #get_dealer.dealer_form_logo# NEQ "" >
									<img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_form_logo#"  class="img-placement img-placement-360-mbl" border="0">
								</cfif>	
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12" align="left" style="background-color:##EBEBEB">	
								<cfset page_text3=replace(page_text3,"$YEAR$","#load_purl.v_year#","All")>
								<cfset page_text3=replace(page_text3,"$MAKE$","#load_purl.v_make#","All")>
								<cfset page_text3=replace(page_text3,"$MODEL$","#load_purl.v_model#","All")>
								<cfset page_text3=replace(page_text3,"$WHERE$","#get_dealer.dealer_Name#","All")>
								<cfset page_text3=replace(page_text3,"$CUST$","#load_purl.Firstname#","All")>
								<cfset page_text3=replace(page_text3,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
								<cfset page_text3=replace(page_text3,"$AMT$","#get_dealer.dealer_offer_amount#","All")>
								#page_text3#
								<a href="#get_dealer.Destination_URL#" style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##3c8443!important;font-weight:bold" class="btn btn-primary">#page_button_text3#</a>
								<div class="row"><div class="col-md-12" >&nbsp;</div></div><div class="row"><div class="col-md-12" >&nbsp;</div></div>
							</div>
						</div>
					</div>
				</div>
				
	<!--- Footer DESKTOP Page 2 --->	
				
			<div class="row visible-md visible-lg "><div class="col-md-12 gradient"></div></div>			
			<cfif 	#get_dealer.dealer_footer_img# NEQ "" >
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;valign:bottom" align="center">
						 <img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_footer_img#"  alt="#get_dealer.Agency_title#" >
					</div>
				</div>	
			</cfif>
				<div class="row visible-md visible-lg  pad-top-10">	
				</div>

	<!--- Footer MOBILE Page 2  --->	
			<cfif 	#get_dealer.dealer_footer_img# NEQ "" >
				<div class="row visible-sm visible-xs ">	
					<div class="col-md-12 " align="center">
						 <img src="http://dealers.wdautos.com/dealer/worlddealer360/images/icons/#get_dealer.dealer_footer_img#" class="img-responsive" style="float:left"  alt="#get_dealer.Agency_title#" >
					</div>	
				</div>	
			</cfif>	
		
			</div>  <!--- container --->
			
			
		</section>


	</cfif>			
  

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	</cffunction>

</cfcomponent>