<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">	
		
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
	<!--- Check for Toyota Dealer  --->
		<cfset ss_trigger = 0 >
		<cfquery datasource="ultra10" name="Chk_tdds">SELECT Dealer_ID,	OEM_Key, TDDS, TDDS_region,	TDDS_tda,TDDS_district,	TDDS_autogroup FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfif #Chk_tdds.TDDS# EQ 1><cfset ss_trigger = 1 ></cfif>
	<!--- Check for Toyota Dealer  --->
	
	<!--- Check for Quick Quote / Search Links  / Video --->
		<cfset variables.srch_meth = 0 >
		<cfset variables.price_srch_meth = 0 >  
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	srch_method, price_srch_method  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.srch_meth = #Chk_Srch.srch_method# >
		<cfset variables.price_srch_meth = #Chk_Srch.price_srch_method# >
	<!--- Check for Quick Quote / Search Links / Video --->
	
		<section class="section-spl">
			<div class="container">	
			 	 <div class="row">
					<div class="col-md-12 pad-top-5 visible-lg visible-md">
						<div class="gradient" ></div>		
					</div>
				</div>	   
				<div class="row pad-top-10">  <!--- start big row --->
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-12 pad-top-10 quik-link-btn"> <!--- I removed visible-md visible-lg to have it visible across the board--->
								 Search Inventory 
								<div class="tab-content srch-tabs">
									<div class="tab-pane active" id="srch">
										<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="btn_pull" value="pull-left"/>
										</cfinvoke>
									</div>
										<cfif #variables.price_srch_meth# NEQ 0 > 
										
										  
											<!--- <cfif #url.dealer_id# eq 84 >
												<div class="tab-pane active">  <!--- Switchable REGIONAL Search Module --->
													<div class="row pad-top-10 "><div class="tab-pane quik-link-btn ">&nbsp;Search by Region</div></div> 
													<cfif IsDefined("url.reg_err_msg")>
														<div class="row"><div class="col-md-12" align="center"><span style="color:red;font-size:9pt;font-weight:bold">#url.reg_err_msg#</span></div></div>	
													</cfif>
													<div class="row srch-tabs-price active">
														<cfinvoke component="/cfcs/forms/form_regional_search" method="regional_srch">
															<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
															<cfinvokeargument name="VOI_Vin" value=""/>
															<cfinvokeargument name="VOI_New_Used" value="#variables.price_srch_meth#"/>
															<cfinvokeargument name="form_name" value="regional_search"/>
															<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/regional_search_action.cfm"/>
														</cfinvoke>  
													</div>
												</div>
											
											</cfif> --->
										   
										
											<div class="tab-pane active"> <!--- Switchable Price Search Module --->
												<div class="row pad-top-10 "><div class="tab-pane quik-link-btn ">&nbsp;Search By Price</div></div> 
												<cfif IsDefined("url.err_msg")>
													<div class="row"><div class="col-md-12" align="center"><span style="color:red;font-size:9pt;font-weight:bold">#url.err_msg#</span></div></div>	
												</cfif>
												<div class="row srch-tabs-price active">
													<cfinvoke component="/cfcs/forms/form_price_search" method="price_srch">
														<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
														<cfinvokeargument name="VOI_Vin" value=""/>
														<cfinvokeargument name="VOI_New_Used" value="#variables.price_srch_meth#"/>
														<cfinvokeargument name="form_name" value="price_search"/>
														<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/price_search_action.cfm"/>
													</cfinvoke>  
												</div>
											</div>
										</cfif>
									<div class="tab-pane active">
										<div class="row"><div class="tab-pane visible-md visible-lg"> </div></div> 
										<cfif #url.dealer_id# NEQ 55 >
											<div class="row pad-top-10">
												<cfif #url.dealer_id# eq 36 or  #url.dealer_id# eq 233 or  #url.dealer_id# eq 259 or  #url.dealer_id# eq 252 or  #url.dealer_id# eq 258 or  #url.dealer_id# eq 200>
													<div class="row gradient"></div><div class="pad-top-10 visible-md visible-lg quik-link-btn">Quick Links</div>
												<cfelse>
													<!--- <div class="pad-top-10 visible-md visible-lg quik-link-btn">Search by Price</div> --->
												</cfif>
											</div>
										</cfif>
										<div class="row"><div class="tab-pane visible-md visible-lg"></div></div>
										<div class="row pad-top-10 tab-pane active">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="42"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="srch-links-btn"/>
												<cfinvokeargument name="glyph_left" value="true"/>
											</cfinvoke>
										</div>
									</div>
								</div>
							</div>
						</div>	
					</div>	
					<div class="col-md-9 pad-top-10">
						<div class="row visible-xs visible-sm">
							<div class="col-md-12">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="13"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-tools-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row img-responsive" >  
							<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke><br>
						</div>
						 <div class="row visible-xs visible-sm">
							<div class="col-md-12" align="center">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="56"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="specials-icon-mbl"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row"> 
							<div id="#arguments.assets#-carousel" class="col-md-12 visible-md visible-lg pad-top-10">
								 <cfif #url.dealer_id# neq 55 AND  #url.dealer_id# neq 36>
									<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
										<cfinvokeargument name="dsn" value="ultra10"/>
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="new_used" value="U"/>
										<cfinvokeargument name="minSlides" value="4"/>
										<cfinvokeargument name="maxSlides" value="20"/>
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="nav_type_id" value="56"/>
										<cfinvokeargument name="carousel_class" value="specials-carousel"/>
										<cfinvokeargument name="element_class" value="specials-icon"/>
										<cfinvokeargument name="slideWidth" value="230"/>
										<cfinvokeargument name="slideMargin" value="15"/>
									</cfinvoke>
								 </cfif>  
								 <cfif #url.dealer_id# eq 36 >
									<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
										<cfinvokeargument name="dsn" value="ultra10"/>
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="new_used" value="U"/>
										<cfinvokeargument name="minSlides" value="4"/>
										<cfinvokeargument name="maxSlides" value="20"/>
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="nav_type_id" value="56"/>
										<cfinvokeargument name="carousel_class" value="specials-carousel"/>
										<cfinvokeargument name="element_class" value="specials-icon"/>
										<cfinvokeargument name="slideWidth" value="200"/>
										<cfinvokeargument name="slideMargin" value="10"/>
									</cfinvoke>
								 </cfif>  
							</div>	
						</div> 
					</div>
				</div> <!--- end big row --->
			</div>
		</section>
  <cfif #url.dealer_id# eq 55 >
		<section class="section-spl">
			<div class="container">	
			 	 <div class="row">
					<div class="col-md-12 pad-top-5 visible-lg visible-md">
						<div class="gradient" ></div>		
					</div>
				</div>	   
				<div class="row pad-top-10">  <!--- start big row --->
					<div class="col-md-12">
					
									<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
										<cfinvokeargument name="dsn" value="ultra10"/>
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="new_used" value="U"/>
										<cfinvokeargument name="minSlides" value="5"/>
										<cfinvokeargument name="maxSlides" value="20"/>
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="nav_type_id" value="56"/>
										<cfinvokeargument name="carousel_class" value="specials-carousel"/>
										<cfinvokeargument name="element_class" value="specials-icon"/>
										<cfinvokeargument name="slideWidth" value="230"/>
										<cfinvokeargument name="slideMargin" value="15"/>
									</cfinvoke>
					</div>
					
				</div> <!--- end big row --->
			</div>
		</section>
					
</cfif>					
  
		<cfquery name="Get_Assigned_OEMs" datasource="Ultra10" >
			SELECT  a.ID, a.dealer_id, a.dealer_oem_id, a.link_to, a.active, a.hierarchy,
					b.OEM_ID, b.Logo,b.OEM_Name
			FROM    Vulcan_Brand_Links a, OEMs b
			where 	a.dealer_id = #url.dealer_id#
			and		a.dealer_oem_id = b.OEM_ID
			and a.active = 1
			order by a.hierarchy ASC
		</cfquery>
  
		<cfset nbr_col = "2" >
		<cfif #url.dealer_id# neq 36 >
			<cfif #Get_Assigned_OEMs.recordcount# LTE 6 >
				<cfset nbr_col = "2" >
			</cfif>
		</cfif>
	
	<cfif  #Get_Assigned_OEMs.recordcount# GT 0 >
		<cfif(#url.dealer_id# eq 36 or  #url.dealer_id# eq 233 or  #url.dealer_id# eq 252) >
		<section class="section-brands">
			 <div class="container pad-top-10">
			<div class="row">
				<div class="col-md-12 pad-top-5 pad-bot-10 visible-lg visible-md">
			<div class="gradient"></div>		
				</div>
			</div>	
				<div class="row">
					<div class="col-md-2 pad-top-10 visible-lg visible-md" align="right">
						<strong>OUR BRANDS:</strong>
					</div>
					<div class="col-md-2 pad-top-10 visible-xs visible-sm" align="left">
						<strong>OUR BRANDS:</strong>
					</div>
					<cfloop query="Get_Assigned_OEMs" >
						<div class="col-md-#nbr_col#" align="left">
							 <cfif  #len(Get_Assigned_OEMs.Logo)# gt 0 >
							 	<a href="#Get_Assigned_OEMs.link_to#" target="_blank"><img  alt="#Get_Assigned_OEMs.OEM_Name#" src="http://dealers.wdautos.com//images/brand_logos/#Get_Assigned_OEMs.Logo#" class="img-responsive" ></a>
							 <cfelse>
							 	#Get_Assigned_OEMs.OEM_Name#
							 </cfif> 
						</div>
					</cfloop>
					
				</div>
			</div>	
		</section>
	<cfelse>
		
		<section class="section-brands">
			 <div class="container pad-top-10">
			<div class="row">
				<div class="col-md-12 pad-top-10  visible-lg visible-md">
			<div class="gradient"></div>		
				</div>
			</div>	
				<div class="row">
					<cfloop query="Get_Assigned_OEMs" >
						<div class="col-md-#nbr_col# pad-left 10px" align="center">
							 <cfif  #len(Get_Assigned_OEMs.Logo)# gt 0 >
							 	<a href="#Get_Assigned_OEMs.link_to#" target="_blank"><img  alt="#Get_Assigned_OEMs.OEM_Name#" src="http://dealers.wdautos.com//images/brand_logos/#Get_Assigned_OEMs.Logo#" class="img-responsive" ></a>
							 <cfelse>
							 	#Get_Assigned_OEMs.OEM_Name#
							 </cfif> 
						</div>
					</cfloop>
				</div>
			</div>	
			<div class="clearfix"></div>
		</section>
	</cfif>
</cfif>	
	<cfinclude template="section_about_us.cfm">
		<section class="section-links">
			<div class="container pad-top-10">
			<div class="row">
				<div class="col-md-12 pad-top-5  visible-lg visible-md">
				<div class="gradient"></div>		
				</div>
			</div>	
				<cfswitch expression="#url.dealer_id#">
					<cfcase value="18">
						<div class="row">
							<div class="col-md-6">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="37"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="right"/>
								</cfinvoke>								
							</div>
						</div>
					</cfcase>
					<cfcase value="55,259">
					</cfcase>
					<cfdefaultcase>
						<div class="row">
							<div class="col-md-12">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</div>
						</div>
					</cfdefaultcase>
				</cfswitch>
				<div class="row pad-top-10">
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="7"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="8"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="9"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					 <div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="10"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>  
					 <!---  <div class="col-md-3 visible-md visible-lg">
						<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="dsn" value="#url.DSN#"/>
							<cfinvokeargument name="title_class" value="ftr-title"/>
							<cfinvokeargument name="input_class" value="ftr-input"/>
							<cfinvokeargument name="button_class" value="ftr-contact-input"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
						</cfinvoke>
					</div>   --->
				</div>
			</div>		
			 
								<div class="clearfix"></div>
			
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:195px;padding:10px 10px 10px 0px;" valign="top">
							<div>
								<div style="padding-top:5px">
									<div class="spl-search-name">#arguments.dealer_name#</div>
									<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
									</cfinvoke>
									<div style="padding-right:10px;">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="42"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="srch-links-btn"/>
											<cfinvokeargument name="glyph_right" value="true"/>
										</cfinvoke>
									</div>
								</div>
							</div>
						</td>
						<td class="pad-top-10" style="width:785px" valign="top">
							<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>
							<br/><br/>
						</td>
					</tr>
				</table>
			</div>			
		</div>

		<div class="section-carousel">
			<div class="container pad-top-10" align="center">
				<table style="width:990px;">
					<tr>
						<td>
							<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="31"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="4"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="35"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel-legacy"/>
								<cfinvokeargument name="element_class" value="specials-icon-legacy"/>
								<cfinvokeargument name="slideWidth" value="230"/>
								<cfinvokeargument name="slideMargin" value="17"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
			<div class="container pad-top-10" align="center">
				<table style="width:990px;">
					<tr>
						<td>
							<div id="#arguments.assets#-btn-carousel">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="36"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="btns-oblong-leg"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
								<div class="clearfix"></div>
								<div class="pad-top-10"></div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-video">
			<div class="container">
				<table style="width:100%">
					<tr>
						<td style="width:50%" class="pad-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
							</cfinvoke>
						</td>
						<td style="width:50%" class="pad-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="38"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-links">
			<div class="container pad-top-10">

				<table style="width:100%;margin-bottom:10px;" cellpadding="0" cellspacing="0">
					<cfswitch expression="#url.dealer_id#">
						<cfcase value="18">
							<tr>
								<td style="width:50%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="28"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="left"/>
									</cfinvoke>
								</td>
								<td style="width:50%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="37"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="right"/>
									</cfinvoke>								
								</td>
							</tr>
						</cfcase>
						<cfdefaultcase>
							<tr>
								<td style="width:100%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="28"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="left"/>
									</cfinvoke>
								</td>
							</tr>
						</cfdefaultcase>
					</cfswitch>
				</table>
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="8"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="9"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer_leg">
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="dsn" value="#url.DSN#"/>
								<cfinvokeargument name="title_class" value="ftr-title"/>
								<cfinvokeargument name="input_class" value="ftr-input"/>
								<cfinvokeargument name="button_class" value="ftr-contact-input"/>
								<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>