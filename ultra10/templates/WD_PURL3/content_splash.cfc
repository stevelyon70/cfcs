<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">	
		
		<link href='http://fonts.googleapis.com/css?family=La+Belle+Aurore' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,800,300' rel='stylesheet' type='text/css'>
		
		<cfif NOT IsDefined("url.page")>
			<cfset url.page = "1" >
		</cfif>
		
		<cfquery name="load_purl" datasource="PURLs">
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
		
		<cfquery name="get_dealer" datasource="PURLs">
			SELECT	ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Address_1, Address_1_Link, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, 
                    Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active, clicks, Dealer_Report_Name
			FROM    dealers
			WHERE	dealer_ID = #load_purl.Dealer_ID#
		</cfquery>
		
		<cfquery name="get_logo" datasource="Ultra10">
			SELECT   OEM_ID ,  OEM_Name , logo, Active ,   description  
			FROM   OEMs
			WHERE	OEM_ID = #get_dealer.Dealer_Image#
		</cfquery>
		
		
		
		<!---  <cfif #load_purl.Dealer_ID# EQ 144 >
			Here - #get_dealer.Campaign_ID#<cfabort>
		</cfif>  --->
		
		
	<cfif #url.page# EQ 1 >
	
		<cfquery name="get_text" datasource="PURLs">
			SELECT   id, campaign_id, page_nbr, page_text, active, create_ts
			FROM         Page_Text
			WHERE	campaign_id	=	#get_dealer.Campaign_ID#
			AND	page_nbr = 1
		</cfquery>
		
		<section class="section-splash-spl">
			<div class="container">		
			
	<!--- Header Desktop Page 1  --->
				<div class="row visible-md visible-lg no-pad" >	
					<div class="col-md-7 welcome-title" align="left">
						<div style="background-color:##fff;margin:5px;">
							<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118  AND  #load_purl.Dealer_ID# NEQ 121  AND  #load_purl.Dealer_ID# NEQ 128  >
								#load_purl.Firstname#, Do you know all your lease-end options? 
							<cfelse>
								<span style="color:black;font-weight:bold;">#load_purl.Firstname#</span>, join us for a private Owner Loyalty Event.
							</cfif>
						</div>
					</div>	
					<div class="col-md-5"  align="right">
						<div class="row pad-top-10">	
							<div class="col-md-9" align="right">
								<div class="dealer-name">#get_dealer.dealer_Name#</div> 
								<cfif#get_dealer.Address_1_link# EQ 0 >
									<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<cfelse>
									<div class="dealer-address"><a href="http://#get_dealer.Dealer_Address_1#" target="_blank">#get_dealer.Dealer_Address_1#</a></div> 
								</cfif>
								<cfif#get_dealer.Dealer_Address_2# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_Address_2#</div> 
								</cfif>
								<cfif#get_dealer.Dealer_City# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
								</cfif>
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
						<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118 AND  #load_purl.Dealer_ID# NEQ 121 AND  #load_purl.Dealer_ID# NEQ 130  
							AND #load_purl.Dealer_ID# NEQ 133 AND #load_purl.Dealer_ID# NEQ 147 >
							<img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/img_Step1.jpg" class="img-responsive" border="0"> 
						<cfelseif #load_purl.Dealer_ID# EQ 117 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl4/images/icons/img_TurkeyPURL_NoSteps.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 118 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl5/images/icons/img_Audi_Step1Header.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 121 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl6/images/icons/img_FordLoyalty_Step1.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 130 or #load_purl.Dealer_ID# EQ 133 or #load_purl.Dealer_ID# EQ 147  >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/ColonialHonda_Step1.jpg" class="img-responsive" border="0">
						</cfif>
					</div>
				</div>	
				
	<!--- Header MOBILE Page 1  --->
				<div class="row visible-sm visible-xs " >	
					<div class="col-md-12  "  align="left">
						 <div class="row">	
							<div class="col-md-12  pad-top-10"  align="right">
								<img src="http://dealers.wdautos.com/images/brand_logos/#get_logo.logo#" class="img-responsive" style="float:right"  alt="#get_logo.OEM_Name#" >
								<div class="dealer-name">#get_dealer.dealer_Name#</div>
								<cfif#get_dealer.Address_1_link# EQ 0 >
									<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<cfelse>
									<div class="dealer-address"><a href="http://#get_dealer.Dealer_Address_1#" target="_blank">#get_dealer.Dealer_Address_1#</a></div> 
								</cfif>
								<cfif#get_dealer.Dealer_Address_2# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_Address_2#</div> 
								</cfif>
								<cfif#get_dealer.Dealer_City# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
								</cfif>
							</div>
						</div>
						<div class="col-md-7 welcome-title" align="left">
						
							<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118 AND  #load_purl.Dealer_ID# NEQ 121 >
								#load_purl.Firstname#, Do you know all your lease-end options?
							<cfelse>	
								<span style="color:black;font-weight:bold;">#load_purl.Firstname#</span>, join us for a private Owner Loyalty Event.
							</cfif>
						
						</div>
					</div> 
				</div>
				<div class="row visible-sm visible-xs no-pad "   >	 
					<div class="col-md-12 no-pad" align="left" >
						<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118 AND  #load_purl.Dealer_ID# NEQ 121 AND  #load_purl.Dealer_ID# NEQ 130  AND #load_purl.Dealer_ID# NEQ 133  AND #load_purl.Dealer_ID# NEQ 147 >
						 <img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/img_GlamourShot_Full.jpg" class="img-responsive" border="0">  
						<cfelseif #load_purl.Dealer_ID# EQ 117 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl4/images/icons/img_TurkeyPURL_NoSteps.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 118 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl5/images/icons/DirectMail_AudiLoyalty_PURLLandingPage_Header_Nov30.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 121 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl6/images/icons/DirectMail_FordLoyalty_PURLLandingPage_Dec15_mobileHeader.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 130  or #load_purl.Dealer_ID# EQ 133 or #load_purl.Dealer_ID# EQ 147 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/colonial_honda_hdr.jpg" class="img-responsive" border="0">
						</cfif>
					</div>
				</div>	


		
	<!--- Body DESKTOP Page 1  --->	
				<div class="row">	 
					<div class="col-md-5 body-text visible-md visible-lg pad-top-10" align="left">
						<div style="background-color:##fff;margin:5px;;margin-right:10px;">
						<cfset get_text.page_text=replace(get_text.page_text,"$YEAR$","#load_purl.v_year#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MAKE$","#load_purl.v_make#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MODEL$","#load_purl.v_model#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$CUST$","#load_purl.Firstname#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$AMT$","#load_purl.Max_Loan_Amount#","All")>
						#get_text.page_text# 
						
						</div>
						<div class="row">	
							<div class="col-md-12 no-pad" align="left"  style="margin-left:5px">
								<div style="background-color:##fff;margin:5px;">
							<cfif #load_purl.Dealer_ID# NEQ 118  >
									<div class="signature_fnt">#get_dealer.Dealer_Contact#</div>  
							<cfelse>	
								<img src="http://dealers.wdautos.com/dealer/wdpurl5/images/icons/signture_freshscript.jpg" class="img-responsive" border="0">	
							</cfif>		
								<span class="body-text" style="margin-left:5px">#get_dealer.Dealer_Phone#, #get_dealer.Dealer_Name#</span>
								</div>
							</div>	
						</div>
						<cfif #load_purl.Dealer_ID# EQ 117 OR  #load_purl.Dealer_ID# EQ 118 OR  #load_purl.Dealer_ID# EQ 121 OR  #load_purl.Dealer_ID# EQ 130 
								 OR #load_purl.Dealer_ID# EQ 133 OR #load_purl.Dealer_ID# EQ 147 >
							<div class="row">&nbsp;</div>	
							<div class="row">&nbsp;</div>	
							<div class="row">	
								<div class="col-md-12 no-pad" align="left"  style="font-size:7pt;margin-left:5px">
									* see mailer or dealer for full details
								</div>
							</div>		
						</cfif>
					</div>
					
					<!--- <div class="col-md-1" >&nbsp;</div> --->
					
					
					<div class="col-md-1" >&nbsp;</div>
	<!--- Form DESKTOP Page 1 --->
					<div class="col-md-5 visible-md visible-lg" align="right" >
						<div class="row  " >	
							<div class="col-md-12 no-pad  img-placement" align="right" style="margin-left:25px!important;background-color:##EBEBEB;min-height:475px;min-width:430px">	
								<cfinvoke component="/cfcs/forms/form_purls" method="purls_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="purls_default"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/purls_action.cfm"/>
									<cfif #get_multi# eq 1 >
										<cfinvokeargument name="passed_purl" value="#arguments.get_purl#"/>
									</cfif>
								</cfinvoke>  
							</div>
						</div>	
					</div>
					
	<!--- Form Mobile Page 1 --->
					<div class="col-md-5 visible-sm visible-xs" align="left" >
						<cfif #load_purl.Dealer_ID# EQ 117 >
							<div class="row" style="max-height:70px;background-color:##02477E">	
						</cfif>	
						<cfif #load_purl.Dealer_ID# EQ 118  >
							<div class="row" style="max-height:70px;background-color:##cc0000">	
						</cfif>	
						<cfif   #load_purl.Dealer_ID# EQ 121 >
							<div class="row" style="max-height:70px;background-color:##02477E">	
						</cfif>	
						<cfif   #load_purl.Dealer_ID# EQ 130 or #load_purl.Dealer_ID# EQ 133  >
							<div class="row" style="max-height:70px;background-color:##02477E">	
						</cfif>	
							<div class="col-md-12 no-pad" align="left">
								<cfif #load_purl.Dealer_ID# EQ 117 >
									<div style="font-size:14pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px;margin-right:15px"><i>Step ##1 - Claim Your Offer</i></div>
								</cfif>	
								<cfif #load_purl.Dealer_ID# EQ 118 >
									<div style="font-size:14pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px;margin-right:15px"><i>Step ##1 - RSVP to Claim Offer</i></div>
								</cfif>	
								<cfif #load_purl.Dealer_ID# EQ 121 >
									<div style="font-size:14pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px;margin-right:15px"><i>Step ##1 - RSVP to Claim Offer</i></div>
								</cfif>	
								<cfif #load_purl.Dealer_ID# EQ 130  AND #load_purl.Dealer_ID# NEQ 133 >
									<div style="font-size:14pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px;margin-right:15px"><i>Step ##1 - RSVP to Claim Offer</i></div>
								</cfif>	
							</div> 
						</div>	
						<div class="row visible-sm visible-xs">	
							<div class="col-md-12 no-pad" align="right" style="background-color:##EBEBEB;margin-left:15px;margin-right:15px">	
								<cfinvoke component="/cfcs/forms/form_purls" method="purls_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="purls_default"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/purls_action.cfm"/>
									<cfif #get_multi# eq 1 >
										<cfinvokeargument name="passed_purl" value="#arguments.get_purl#"/>
									</cfif>
								</cfinvoke>  
							</div>
						</div>
					</div>
					
					
				</div>
				
	<!--- Footer DESKTOP Page 1 --->
				<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118  AND  #load_purl.Dealer_ID# NEQ 121  
						AND  #load_purl.Dealer_ID# NEQ 130 AND #load_purl.Dealer_ID# NEQ 133  AND #load_purl.Dealer_ID# NEQ 144    AND #load_purl.Dealer_ID# NEQ 147  >
					<div class="row visible-md visible-lg  pad-top-10">	
					</div>
					<div class="row visible-md visible-lg ">	
						<div class="col-md-12 no-pad" align="left">
							 <img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/footer_img.jpg"  class="img-responsive"  alt="Prime Motor Group" >
						</div>
					</div>	
					<div class="row visible-md visible-lg  pad-top-10">	
					</div>
				</cfif>
	<!--- Footer DESKTOP Page 1 --->	
				<cfif #load_purl.Dealer_ID# NEQ 130  AND #load_purl.Dealer_ID# NEQ 133  AND #load_purl.Dealer_ID# NEQ 144 AND #load_purl.Dealer_ID# NEQ 147 >
					<div class="row visible-md visible-lg "><div class="col-md-12 no-pad gradient"></div></div>		
					<div class="row visible-md visible-lg  pad-top-10"><div class="col-md-12 no-pad" align="left">&nbsp;</div></div>
					<div class="row visible-md visible-lg ">	 
							<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="center">
								 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/logo_prime.png"  alt="Prime Motor Group" ><i>A new kind of car buying experience. </i>
							</div> 
					</div>	
					<div class="row visible-md visible-lg  pad-top-10">	
					</div>
				</cfif>

	<!--- Footer MOBILE Page 1 --->	
				<cfif #load_purl.Dealer_ID# NEQ 130  AND #load_purl.Dealer_ID# NEQ 133   AND #load_purl.Dealer_ID# NEQ 144  AND #load_purl.Dealer_ID# NEQ 147>
					<div class="row visible-sm visible-xs ">	
						<div class="col-md-3 " align="left">
							 <img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/logo_Prime_footer_sm.jpg" class="img-responsive" style="float:left"  alt="Prime Motor Group" >
						</div>	
						<div class="col-md-9 pad-top-10" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:9pt;">
							 <i>A new kind of car buying experience. </i>
						</div>
					</div>	
				</cfif>
				
			</div>  <!--- container --->
			
			
		</section>
	<cfelse>

		<cfquery name="get_text" datasource="PURLs">
			SELECT   id, campaign_id, page_nbr, page_text, active, create_ts
			FROM         Page_Text
			WHERE	campaign_id	=	#get_dealer.Campaign_ID#
			AND	page_nbr = 2
		</cfquery>
		
		<cfquery name="get_text_right" datasource="PURLs">
			SELECT   id, campaign_id, page_nbr, page_text, active, create_ts
			FROM         Page_Text
			WHERE	campaign_id	=	#get_dealer.Campaign_ID#
			AND	page_nbr = 3
		</cfquery>
		
		<section class="section-splash-spl">
			<div class="container">		
			
	<!--- Header Desktop Page 2  --->
				<div class="row visible-md visible-lg no-pad" >	
					<div class="col-md-7 welcome-title" align="left">
						<div style="background-color:##fff;margin:5px;">
							
							<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118  AND  #load_purl.Dealer_ID# NEQ 121 >
								#load_purl.Firstname#, Do you know all your lease-end options?
							<cfelse>	
								<span style="color:black;font-weight:bold;">#load_purl.Firstname#</span>, join us for a private Owner Loyalty Event.
							</cfif>
						</div>
					</div>	
					<div class="col-md-5"  align="right">
						<div class="row pad-top-10">	
							<div class="col-md-9" align="right">
								<div class="dealer-name">#get_dealer.dealer_Name#</div> 
								<cfif#get_dealer.Address_1_link# EQ 0 >
									<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<cfelse>
									<div class="dealer-address"><a href="http://#get_dealer.Dealer_Address_1#" target="_blank">#get_dealer.Dealer_Address_1#</a></div> 
								</cfif>
								<cfif#get_dealer.Dealer_Address_2# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_Address_2#</div> 
								</cfif>
								<cfif#get_dealer.Dealer_City# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
								</cfif>
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
						<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118 AND  #load_purl.Dealer_ID# NEQ 121 AND  #load_purl.Dealer_ID# NEQ 130  
							AND #load_purl.Dealer_ID# NEQ 133 AND #load_purl.Dealer_ID# NEQ 147 >
							<img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/img_glamourshot_heading.jpg" class="img-responsive" border="0"> 
						<cfelseif #load_purl.Dealer_ID# EQ 117 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl4/images/icons/img_TurkeyPURL_NoSteps.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 118 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl5/images/icons/img_Audi_Step1Header.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 121 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl6/images/icons/img_FordLoyalty_Step1.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 130  OR #load_purl.Dealer_ID# EQ 133  OR #load_purl.Dealer_ID# EQ 147 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/ColonialHonda_Step2.jpg" class="img-responsive" border="0">
						</cfif>
					</div>
				</div>	
				
	<!--- Header MOBILE Page 2  --->
				<div class="row visible-sm visible-xs " >	
					<div class="col-md-12  "  align="left">
						 <div class="row">	
							<div class="col-md-12  pad-top-10"  align="right">
								<img src="http://dealers.wdautos.com/images/brand_logos/#get_logo.logo#" class="img-responsive" style="float:right"  alt="#get_logo.OEM_Name#" >
								<div class="dealer-name">#get_dealer.dealer_Name#</div>
								<cfif#get_dealer.Address_1_link# EQ 0 >
									<div class="dealer-address">#get_dealer.Dealer_Address_1#</div> 
								<cfelse>
									<div class="dealer-address"><a href="http://#get_dealer.Dealer_Address_1#" target="_blank">#get_dealer.Dealer_Address_1#</a></div> 
								</cfif>
								<cfif#get_dealer.Dealer_Address_2# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_Address_2#</div> 
								</cfif>
								<cfif#get_dealer.Dealer_City# NEQ "" >
									<div class="dealer-address">#get_dealer.Dealer_City#, #get_dealer.Dealer_State# #get_dealer.Dealer_Zip#</div> 
								</cfif>
							</div>
						</div>
						<div class="col-md-7 welcome-title" align="left">
						
							<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118 AND  #load_purl.Dealer_ID# NEQ 121 >
								#load_purl.Firstname#, Do you know all your lease-end options?
							<cfelse>	
								<span style="color:black;font-weight:bold;">#load_purl.Firstname#</span>, join us for a private Owner Loyalty Event.
							</cfif>
						</div>
					</div> 
				</div>
				<div class="row visible-sm visible-xs no-pad "   >	 
					<div class="col-md-12 no-pad" align="left" >
						<cfif #load_purl.Dealer_ID# NEQ 117 AND  #load_purl.Dealer_ID# NEQ 118 AND  #load_purl.Dealer_ID# NEQ 121 AND  #load_purl.Dealer_ID# NEQ 130 
							 AND #load_purl.Dealer_ID# NEQ 133  AND #load_purl.Dealer_ID# NEQ 147 >
						 <img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/img_GlamourShot_Full.jpg" class="img-responsive" border="0">  
						<cfelseif #load_purl.Dealer_ID# EQ 117 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl4/images/icons/img_TurkeyPURL_NoSteps.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 118 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl5/images/icons/DirectMail_AudiLoyalty_PURLLandingPage_Header_Nov30.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 121 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl6/images/icons/DirectMail_FordLoyalty_PURLLandingPage_Dec15_mobileHeader.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 147 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/colonial_honda_hdr.jpg" class="img-responsive" border="0">
						<cfelseif #load_purl.Dealer_ID# EQ 130  or #load_purl.Dealer_ID# NEQ 133 >	
							<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/colonial_honda_hdr.jpg" class="img-responsive" border="0">
						</cfif>
					</div>
				</div>	


		
	<!--- Body DESKTOP Page 2  --->	
				<div class="row">	 
					<div class="col-md-5 body-text visible-md visible-lg" align="left">
						<div style="background-color:##fff;margin:5px;;margin-right:10px;">
						<cfset get_text.page_text=replace(get_text.page_text,"$YEAR$","#load_purl.v_year#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MAKE$","#load_purl.v_make#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MODEL$","#load_purl.v_model#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$CUST$","#load_purl.Firstname#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$AMT$","#load_purl.Max_Loan_Amount#","All")>
						#get_text.page_text#
						
						</div>
						<div class="row">	
							<div class="col-md-12 no-pad" align="left"  style="margin-left:5px">
								<div style="background-color:##fff;margin:5px;">
							<cfif #load_purl.Dealer_ID# NEQ 118 >
									<div class="signature_fnt">#get_dealer.Dealer_Contact#</div>  
							<cfelse>	
								<img src="http://dealers.wdautos.com/dealer/wdpurl5/images/icons/signture_freshscript.jpg" class="img-responsive" border="0">	
							</cfif>		
								<span class="body-text" style="margin-left:5px">#get_dealer.Dealer_Phone#, #get_dealer.Dealer_Name#</span>
								</div>
							</div>	
						</div>
						<cfif #load_purl.Dealer_ID# EQ 117 OR  #load_purl.Dealer_ID# EQ 118  OR  #load_purl.Dealer_ID# EQ 121 OR  #load_purl.Dealer_ID# EQ 130
							 OR  #load_purl.Dealer_ID# EQ 133 OR  #load_purl.Dealer_ID# EQ 147 >
							<div class="row">&nbsp;</div>	
							<div class="row">&nbsp;</div>	
							<div class="row">	
								<div class="col-md-12 no-pad" align="left"  style="font-size:7pt;margin-left:5px">
									* see mailer or dealer for full details
								</div>
							</div>		
						</cfif>
					</div>
					
					<!---   <div class="col-md-1" >&nbsp;</div>  ---> 
					
					<div class="col-md-1" >&nbsp;</div>  
	<!--- Form DESKTOP Page 2 --->
					<div class="col-md-5 visible-md visible-lg" align="left" >
						<div class="row  " >	
							<div class="col-md-12 no-pad  img-placement" align="left" style="margin-left:25px!important;background-color:##EBEBEB;min-height:475px;min-width:430px">	
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$YEAR$","#load_purl.v_year#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MAKE$","#load_purl.v_make#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MODEL$","#load_purl.v_model#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$CUST$","#load_purl.Firstname#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$AMT$","#load_purl.Max_Loan_Amount#","All")>
								<div class="col-md-12" style="margin-left:20px;margin-right:20px" align="left">	
								#rtrim(get_text_right.page_text)#
									<a href="#get_dealer.Destination_URL#" style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;font-weight:normal" class="btn btn-primary">Find Your Next Vehicle</a>
								</div>
								<div class="row"><div class="col-md-12" >&nbsp;</div></div><div class="row"><div class="col-md-12" >&nbsp;</div></div>
							</div>
						</div>	
					</div>
					
	<!--- Form Mobile Page 2 --->
					<div class="col-md-5 visible-sm visible-xs" align="left" >
						<cfif #load_purl.Dealer_ID# EQ 117 >
							<div class="row" style="max-height:70px;background-color:##02477E">	
						</cfif>	
						<cfif #load_purl.Dealer_ID# EQ 118 >
							<div class="row" style="max-height:70px;background-color:##cc0000">	
						</cfif>	 
						<cfif #load_purl.Dealer_ID# EQ 121 >
							<div class="row" style="max-height:70px;background-color:##02477E">	
						</cfif>	 
						<cfif #load_purl.Dealer_ID# EQ 130 OR #load_purl.Dealer_ID# EQ 133  >
							<div class="row" style="max-height:70px;background-color:##02477E">	
						</cfif>	
							<div class="col-md-12 no-pad" align="left">
								<div style="font-size:14pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px;margin-right:15px"><i>Step ##2 - Find a New Car</i></div>
							</div> 
						</div>	
						<div class="row visible-sm visible-xs">	
							<div class="col-md-12 no-pad  " align="left" style="background-color:##EBEBEB;margin-left:15px;margin-right:15px">	
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$YEAR$","#load_purl.v_year#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MAKE$","#load_purl.v_make#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MODEL$","#load_purl.v_model#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$CUST$","#load_purl.Firstname#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$AMT$","#load_purl.Max_Loan_Amount#","All")>
								#rtrim(get_text_right.page_text)#
								<a href="#get_dealer.Destination_URL#" style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;font-weight:normal" class="btn btn-primary">Find Your Next Vehicle</a>
								<div class="row"><div class="col-md-12" >&nbsp;</div></div><div class="row"><div class="col-md-12" >&nbsp;</div></div>
							</div>
						</div>
					</div>
					
					
				</div>
				
	<!--- Footer DESKTOP Page 2 --->
	
				<cfif #load_purl.Dealer_ID# NEQ 117  AND  #load_purl.Dealer_ID# NEQ 118  AND  #load_purl.Dealer_ID# NEQ 121  
						AND  #load_purl.Dealer_ID# NEQ 130 AND #load_purl.Dealer_ID# NEQ 133 AND #load_purl.Dealer_ID# NEQ 144  AND #load_purl.Dealer_ID# NEQ 147  >
					<div class="row visible-md visible-lg  pad-top-10"></div>
					<div class="row visible-md visible-lg ">	
						<div class="col-md-12 no-pad" align="left">
							 <img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/footer_img.jpg"  class="img-responsive"  alt="Prime Motor Group" >
							</div>
					</div>	
					<div class="row visible-md visible-lg  pad-top-10"></div>
				</cfif>	
	<!--- Footer DESKTOP Page 2 --->	
			<cfif #load_purl.Dealer_ID# NEQ 130 AND #load_purl.Dealer_ID# NEQ 133 AND #load_purl.Dealer_ID# NEQ 144  AND #load_purl.Dealer_ID# NEQ 147 >
				<div class="row visible-md visible-lg "><div class="col-md-12 no-pad gradient"></div></div>		
				<div class="row visible-md visible-lg  pad-top-10"><div class="col-md-12 no-pad" align="left">&nbsp;</div></div>
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="center">
						 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/logo_prime.png"  alt="Prime Motor Group" ><i>A new kind of car buying experience. </i>
					</div>
				</div>	
				<div class="row visible-md visible-lg  pad-top-10"></div>

	<!--- Footer MOBILE Page 2 --->	
				<div class="row visible-sm visible-xs ">	
					<div class="col-md-3 " align="left">
						 <img src="http://dealers.wdautos.com/dealer/wdpurl3/images/icons/logo_Prime_footer_sm.jpg" class="img-responsive" style="float:left"  alt="Prime Motor Group" >
					</div>	
					<div class="col-md-9 pad-top-10" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:9pt;">
						 <i>A new kind of car buying experience. </i>
					</div>
				</div>	
			</cfif>	
			</div>  <!--- container --->
			
			
		</section>
		
<!--- end --->		
	</cfif>			
  

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	</cffunction>

</cfcomponent>