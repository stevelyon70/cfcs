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
		
			<cfset pass_ems = 0 >
		<cfif IsDefined("url.ems") AND #url.ems# EQ 1 >
			<cfset pass_ems = 1 >
		</cfif>
		
		<cfquery name="get_dealer" datasource="PURLs">
			SELECT	ID, Campaign_ID, Dealer_ID, Dealer_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Contact, 
                    Dealer_Email, Dealer_Website, Destination_URL, PURL_Identifier, Dealer_Image, Comments, start_dt, expires_dt, active, clicks, Dealer_Report_Name
			FROM    dealers
			WHERE	dealer_ID = #load_purl.Dealer_ID#
		</cfquery>
		
		<cfquery name="get_logo" datasource="Ultra10">
			SELECT   OEM_ID ,  OEM_Name , logo, Active ,   description  
			FROM   OEMs
			WHERE	OEM_ID = #get_dealer.Dealer_Image#
		</cfquery>
		
		
		
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
							<cfif #load_purl.Dealer_ID# NEQ 125 and  #load_purl.Dealer_ID# NEQ 126  and  #load_purl.Dealer_ID# NEQ 137 
									and  #load_purl.Dealer_ID# NEQ 135 and  #load_purl.Dealer_ID# NEQ 129 and  #load_purl.Dealer_ID# NEQ 140 
									 and  #load_purl.Dealer_ID# NEQ 141  and  #load_purl.Dealer_ID# NEQ 149  >
									#load_purl.Firstname#, Claim Your $1,000 Bonus Trade-In Offer!
							<cfelse>	 
								<cfif #load_purl.dealer_id# EQ 126 OR  #load_purl.dealer_id# EQ 129 OR  #load_purl.dealer_id# EQ 149 >
									#load_purl.Firstname#, Claim Your $1,500 Bonus Trade-In Offer!
								<cfelse>	
									#load_purl.Firstname#, Claim Your $2,000 Bonus Trade-In Offer!
								</cfif>
							</cfif>
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
						<cfif #load_purl.Dealer_ID# EQ 140 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/img_chevyheader.jpg" class="img-responsive" border="0">   
						<cfelseif #load_purl.Dealer_ID# EQ 148 or  #load_purl.Dealer_ID# EQ 149 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/SouthernMaine_HeaderImage.jpg" class="img-responsive" border="0">  
						 <cfelse>
							 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/GirlInCar.jpg" class="img-responsive" border="0">  
						</cfif>	 
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
							<cfif #load_purl.Dealer_ID# NEQ 125 and  #load_purl.Dealer_ID# NEQ 126  and  #load_purl.Dealer_ID# NEQ 137 and  #load_purl.Dealer_ID# NEQ 135 
									and  #load_purl.Dealer_ID# NEQ 129 and  #load_purl.Dealer_ID# NEQ 140  and  #load_purl.Dealer_ID# NEQ 141  and  #load_purl.Dealer_ID# NEQ 149  >
									#load_purl.Firstname#, Claim Your $1,000 Bonus Trade-In Offer!
							<cfelse>	 
								<cfif #load_purl.dealer_id# EQ 126 OR  #load_purl.dealer_id# EQ 129 OR  #load_purl.dealer_id# EQ 149 >
									#load_purl.Firstname#, Claim Your $1,500 Bonus Trade-In Offer!
								<cfelse>	
									#load_purl.Firstname#, Claim Your $2,000 Bonus Trade-In Offer!
								</cfif>
							</cfif>
						</div>
					</div> 
				</div>
				<div class="row visible-sm visible-xs no-pad "   >	 
					<div class="col-md-12 no-pad" align="left" >
						<cfif #load_purl.Dealer_ID# EQ 140 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/img_chevyheader.jpg" class="img-responsive" border="0">  
						<cfelseif #load_purl.Dealer_ID# EQ 148 or  #load_purl.Dealer_ID# EQ 149 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/SouthernMaine_HeaderImage.jpg" class="img-responsive" border="0">  
						 <cfelse>
							 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/GirlInCar.jpg" class="img-responsive" border="0">  
						</cfif>	 
					</div>
				</div>	


		
	<!--- Body DESKTP & MOBILE Page 1  --->	
				<div class="row">	 
					<div class="col-md-6 body-text visible-md visible-lg pad-top-10" align="left">
						<div style="background-color:##fff;margin:5px;">
						<cfset get_text.page_text=replace(get_text.page_text,"$YEAR$","#load_purl.v_year#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MAKE$","#load_purl.v_make#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MODEL$","#load_purl.v_model#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$CUST$","#load_purl.Firstname#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
						<cfif #load_purl.Dealer_ID# EQ 140 >
							<cfset get_text.page_text=replace(get_text.page_text,"$AMT$","$2,000","All")>
						</cfif>
						<cfif #load_purl.Dealer_ID# EQ 145 >
							<cfset get_text.page_text=replace(get_text.page_text,"$AMT$","$1,000","All")>
						</cfif>
						#get_text.page_text#
						
						</div>
						<div class="row">	
							<div class="col-md-12 no-pad" align="left"  style="margin-left:5px">
								<div style="background-color:##fff;margin:5px;">
									<cfif #load_purl.Dealer_ID# EQ 148 OR  #load_purl.Dealer_ID# EQ 149 >
										 <div class="signature_fnt">&nbsp;&nbsp;<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/img_signature.jpg"  class="img-placement img-placement-js" border="0"></div>  
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
								<cfif #load_purl.Dealer_ID# EQ 140 OR  #load_purl.Dealer_ID# EQ 145 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/Logo_BlackBook.png"  class="img-placement img-placement-js" border="0">
								<cfelseif #load_purl.Dealer_ID# EQ 148 OR  #load_purl.Dealer_ID# EQ 149 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/Logo_kbb.png"  class="img-placement  img-placement-js-kbb" border="0">
								<cfelse>
									 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/logo_kbb_sm.png"  class="img-placement" border="0">
								</cfif>	 	 
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12 no-pad" align="right" style="background-color:##EBEBEB">	
								<cfinvoke component="/cfcs/forms/form_purls" method="purls_default">
									<cfinvokeargument name="dealer_id" value="#load_purl.dealer_id#"/>
									<cfinvokeargument name="pass_ems" value="#pass_ems#"/>
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
						<div class="row" style="max-height:80px;background-color:##1b2a59">	
							<div class="col-md-6 no-pad" align="left">
								<div style="font-size:20pt;color:##ffffff;font-weight:bold;vertical-align: text-top;margin-left:15px"><i>Step ##1</i></div>
							</div>
							<div class="col-md-6 no-pad" align="right" >
								<cfif #load_purl.Dealer_ID# EQ 140 OR  #load_purl.Dealer_ID# EQ 145 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/Logo_BlackBook.png"  class="img-placement img-placement-mbl" border="0">
								<cfelse>
									<cfif #load_purl.Dealer_ID# EQ 148 OR  #load_purl.Dealer_ID# EQ 149  >
									 	<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/logo_kbb.png"  class="img-placement img-placement-js-kbb-mbl" border="0">
									 <cfelse>
									 	<img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/logo_kbb_sm.png"  class="img-placement img-placement-mbl" border="0">
									 </cfif>
								</cfif>	 	 
							 
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12 no-pad" align="right" style="background-color:##EBEBEB">	
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
				<div class="row visible-md visible-lg "><div class="col-md-12 gradient"></div></div>			
	<cfif 	#load_purl.Dealer_ID# NEQ 140  AND  #load_purl.Dealer_ID# NEQ 145 AND  #load_purl.Dealer_ID# NEQ 146 AND  #load_purl.Dealer_ID# NEQ 127
				 AND  #load_purl.Dealer_ID# NEQ 148  AND  #load_purl.Dealer_ID# NEQ 149 >			
			<cfif 	#load_purl.Dealer_ID# NEQ 120 >
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;valign:bottom" align="center">
						 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/new_logo_full.png"  alt="Prime Motor Group" ><!--- &nbsp;<i>A new kind of car buying experience. </i> --->
					</div>
				</div>	
			<cfelse>	
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;valign:bottom" align="center">
						 <div class="col-md-5" >&nbsp;</div>
						 <div class="col-md-2" ><img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/wd-logo1.png"  class="img-responsive" alt="WorldDealer, Inc" ></div>
						 <div class="col-md-5" >&nbsp;</div>
					</div>
				</div>	
			</cfif>
				<div class="row visible-md visible-lg  pad-top-10">	
				</div>

	<!--- Footer MOBILE Page 1 --->	
				<div class="row visible-sm visible-xs ">	
					<cfif 	#load_purl.Dealer_ID# NEQ 120 >
						<div class="col-md-12 " align="center">
							 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/new_logo_full.png" class="img-responsive" style="float:left"  alt="Prime Motor Group" >
						</div>	
					</cfif>
					<!--- <div class="col-md-9 pad-top-10" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:9pt;">
						 <i>A new kind of car buying experience. </i>
					</div> --->
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
			
	<!--- Header DESKTOP Page 2 --->
				<div class="row visible-md visible-lg no-pad" >	
					<div class="col-md-7 welcome-title" align="left">
						<div style="background-color:##fff;margin:5px;">
							<cfif #load_purl.Dealer_ID# NEQ 125 and  #load_purl.Dealer_ID# NEQ 126  and  #load_purl.Dealer_ID# NEQ 137 
									and  #load_purl.Dealer_ID# NEQ 135 and  #load_purl.Dealer_ID# NEQ 129 and  #load_purl.Dealer_ID# NEQ 140
									 and  #load_purl.Dealer_ID# NEQ 141  and  #load_purl.Dealer_ID# NEQ 149  >
									#load_purl.Firstname#, Claim Your $1,000 Bonus Trade-In Offer!
							<cfelse>	 
								<cfif #load_purl.dealer_id# EQ 126 OR  #load_purl.dealer_id# EQ 129  OR  #load_purl.dealer_id# EQ 149 >
									#load_purl.Firstname#, Claim Your $1,500 Bonus Trade-In Offer!
								<cfelse>	
									#load_purl.Firstname#, Claim Your $2,000 Bonus Trade-In Offer!
								</cfif>
							</cfif>
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
						<cfif #load_purl.Dealer_ID# EQ 140 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/img_chevyheader.jpg" class="img-responsive" border="0"> 
						<cfelseif #load_purl.Dealer_ID# EQ 148 or  #load_purl.Dealer_ID# EQ 149 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/SouthernMaine_HeaderImage.jpg" class="img-responsive" border="0">   
						 <cfelse>
							 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/GirlInCar.jpg" class="img-responsive" border="0">  
						</cfif>	 
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
							<cfif #load_purl.Dealer_ID# NEQ 125 and  #load_purl.Dealer_ID# NEQ 126  and  #load_purl.Dealer_ID# NEQ 137 
									and  #load_purl.Dealer_ID# NEQ 135 and  #load_purl.Dealer_ID# NEQ 129 and  #load_purl.Dealer_ID# NEQ 140  and  #load_purl.Dealer_ID# NEQ 141 
										 and  #load_purl.Dealer_ID# NEQ 149  >
									#load_purl.Firstname#, Claim Your $1,000 Bonus Trade-In Offer!
							<cfelse>	 
								<cfif #load_purl.dealer_id# EQ 126 OR  #load_purl.dealer_id# EQ 129 OR  #load_purl.dealer_id# EQ 149 >
									#load_purl.Firstname#, Claim Your $1,500 Bonus Trade-In Offer!
								<cfelse>	
									#load_purl.Firstname#, Claim Your $2,000 Bonus Trade-In Offer!
								</cfif>
							</cfif>
						</div>
					</div> 
				</div>
				<div class="row visible-sm visible-xs no-pad "   >	 
					<div class="col-md-12 no-pad" align="left" >
						<cfif #load_purl.Dealer_ID# EQ 140 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/img_chevyheader.jpg" class="img-responsive " border="0">  
						<cfelseif #load_purl.Dealer_ID# EQ 148 or  #load_purl.Dealer_ID# EQ 149 >
							 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/SouthernMaine_HeaderImage.jpg" class="img-responsive" border="0">  
						 <cfelse>
							 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/GirlInCar.jpg" class="img-responsive" border="0">  
						</cfif>	 
					</div>
				</div>	
		
	<!--- Body DESKTOP & MOBILE Page 2  --->	
				<div class="row">	 
					<div class="col-md-6 body-text visible-md visible-lg pad-top-10" align="left">
						<div style="background-color:##fff;margin:5px;">
						<cfset get_text.page_text=replace(get_text.page_text,"$YEAR$","#load_purl.v_year#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MAKE$","#load_purl.v_make#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$MODEL$","#load_purl.v_model#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$CUST$","#load_purl.Firstname#","All")>
						<cfset get_text.page_text=replace(get_text.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
						<cfif #load_purl.Dealer_ID# EQ 140 >
							<cfset get_text.page_text=replace(get_text.page_text,"$AMT$","$2,000","All")>
						</cfif>
						<cfif #load_purl.Dealer_ID# EQ 145 >
							<cfset get_text.page_text=replace(get_text.page_text,"$AMT$","$1,000","All")>
						</cfif>
						#get_text.page_text#
						<!--- Signature Section --->	
						<div class="row">	
							<div class="col-md-12" align="left" style="margin-left:0px">
								<cfif #load_purl.Dealer_ID# EQ 148 OR  #load_purl.Dealer_ID# EQ 149 >
									 <div class="signature_fnt">&nbsp;&nbsp;<img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/img_signature.jpg"  class="img-placement img-placement-js" border="0"></div>  
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
								<cfif #load_purl.Dealer_ID# EQ 140 OR  #load_purl.Dealer_ID# EQ 145 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/Logo_BlackBook.png"  class="img-placement  img-placement-js" border="0">
								<cfelseif #load_purl.Dealer_ID# EQ 148 OR  #load_purl.Dealer_ID# EQ 149 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/Logo_kbb.png"  class="img-placement  img-placement-js" border="0">
								<cfelse>
									 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/logo_kbb_sm.png"  class="img-placement" border="0">
								</cfif>	 	 
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12" align="left" style="background-color:##EBEBEB">	
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$YEAR$","#load_purl.v_year#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MAKE$","#load_purl.v_make#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MODEL$","#load_purl.v_model#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$CUST$","#load_purl.Firstname#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
								<cfif #load_purl.Dealer_ID# EQ 140 >
									<cfset get_text_right.page_text=replace(get_text_right.page_text,"$AMT$","$2,000","All")>
								</cfif>
								<cfif #load_purl.Dealer_ID# EQ 145 >
									<cfset get_text_right.page_text=replace(get_text_right.page_text,"$AMT$","$1,000","All")>
								</cfif>
								#rtrim(get_text_right.page_text)#
								<a href="#get_dealer.Destination_URL#" style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##3c8443!important;font-weight:bold" class="btn btn-primary">Get My Trade-In Value</a>
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
								<cfif #load_purl.Dealer_ID# EQ 140 OR  #load_purl.Dealer_ID# EQ 145 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/Logo_BlackBook.png"  class="img-placement img-placement-mbl" border="0">
								<cfelse>
									<cfif #load_purl.Dealer_ID# EQ 148 OR  #load_purl.Dealer_ID# EQ 149 >
									 <img src="http://dealers.wdautos.com/dealer/wdpurl7/images/icons/logo_kbb.png"  class="img-placement img-placement-js-kbb-mbl" border="0">
									 <cfelse>
									 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/logo_kbb_sm.png"  class="img-placement img-placement-mbl" border="0">
									 </cfif>
								</cfif>	 	 
							</div>
						</div>	
						<div class="row">	
							<div class="col-md-12" align="left" style="background-color:##EBEBEB">	
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$YEAR$","#load_purl.v_year#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MAKE$","#load_purl.v_make#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$MODEL$","#load_purl.v_model#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$WHERE$","#get_dealer.dealer_Name#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$CUST$","#load_purl.Firstname#","All")>
								<cfset get_text_right.page_text=replace(get_text_right.page_text,"$OEMMAKE$","#get_logo.OEM_Name#","All")>
								<cfif #load_purl.Dealer_ID# EQ 140 >
									<cfset get_text_right.page_text=replace(get_text_right.page_text,"$AMT$","$2,000","All")>
								</cfif>
								<cfif #load_purl.Dealer_ID# EQ 145 >
									<cfset get_text_right.page_text=replace(get_text_right.page_text,"$AMT$","$1,000","All")>
								</cfif>
								#rtrim(get_text_right.page_text)#
								<a href="#get_dealer.Destination_URL#" style="font-family:Helvetica, Condensed,bold, italic, sans-serif;font-style:italic;font-size:16pt;color:##ffffff;background-color:##3c8443!important;font-weight:bold" class="btn btn-primary">Get My Trade-In Value</a>
								<div class="row"><div class="col-md-12" >&nbsp;</div></div><div class="row"><div class="col-md-12" >&nbsp;</div></div>
							</div>
						</div>
					</div>
				</div>
				
	<!--- Footer DESKTOP Page 2 --->	
				<div class="row visible-md visible-lg "><div class="col-md-12 gradient"></div></div>			
<cfif 	#load_purl.Dealer_ID# NEQ 140  AND  #load_purl.Dealer_ID# NEQ 145  AND  #load_purl.Dealer_ID# NEQ 146  AND  #load_purl.Dealer_ID# NEQ 127 
			 AND  #load_purl.Dealer_ID# NEQ 148  AND  #load_purl.Dealer_ID# NEQ 149>								
			<cfif 	#load_purl.Dealer_ID# NEQ 120 >
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;valign:bottom" align="center">
						 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/new_logo_full.png"  alt="Prime Motor Group" ><!--- &nbsp;<i>A new kind of car buying experience. </i> --->
					</div>
				</div>	
			<cfelse>	
				<div class="row visible-md visible-lg ">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;valign:bottom" align="center">
						 <div class="col-md-5" >&nbsp;</div>
						 <div class="col-md-2" ><img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/wd-logo1.png"  class="img-responsive" alt="WorldDealer, Inc" ></div>
						 <div class="col-md-5" >&nbsp;</div>
					</div>
				</div>	
			</cfif>
				<div class="row visible-md visible-lg  pad-top-10">	
				</div>

	<!--- Footer MOBILE Page 2  --->	
				<div class="row visible-sm visible-xs ">	
				<cfif 	#load_purl.Dealer_ID# NEQ 120 >	
					<div class="col-md-12 " align="center">
						 <img src="http://dealers.wdautos.com/dealer/wdpurl2/images/icons/new_logo_full.png" class="img-responsive" style="float:left"  alt="Prime Motor Group" >
					</div>	
				</cfif>	
					<!--- <div class="col-md-9 pad-top-10" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:9pt;">
						 <i>A new kind of car buying experience. </i>
					</div> --->
				</div>	
</cfif>				
			</div>  <!--- container --->
			
			
		</section>


	</cfif>			
  

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	</cffunction>

</cfcomponent>