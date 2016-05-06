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
	
	
		<section class="section-spl">
			<div class="container">
				<div class="row">
					<div class="col-md-3 pad-top-10">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="13"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="spl-tools-btn"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="12"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="shopping-link"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
                        
                        <cfif url.dealer_id eq 262 or url.dealer_id eq 42 or url.dealer_id eq 47>
                        	<a href="/forms/trade.cfm"><img src="/dealer/#url.assets#/images/icons/btn_KelleyBlueBook_home.png"  /></a>
                        </cfif>
					</div>
					<div class="col-md-9 no-pad">
						<div class="pad-top-10">
						 <cfif #ss_trigger# eq 1 >  <!--- 1 --->		<!--- Turned of Stoltz  and #url.dealer_id# NEQ 46--->		  
                            <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  <cfelse>
                            <cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  </cfif>
							<!---<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>--->
						</div>
					</div>
				</div>
				
				<!--- Splash Banners like used on Baierl  10/27/2014 --->				
				<div class="container visible-md visible-lg">
					<div class="row splash-logos-row">
						<div class="col-md-12  pad-top-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="41"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-icons"/>
								<cfinvokeargument name="pull" value="none"/>
							</cfinvoke>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12">
						<br/>
					</div>
				</div>
				<div class="row visible-md visible-lg">
					<div class="col-md-12 pad-top-10">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="misc">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="#url.dealer_ID#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="6"/>
							<cfinvokeargument name="maxSlides" value="20"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="45"/>
							<cfinvokeargument name="carousel_class" value="misc-carousel"/>
							<cfinvokeargument name="element_class" value="misc-icon"/>
							<cfinvokeargument name="slideWidth" value="130"/>
							<cfinvokeargument name="slideMargin" value="50"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</section>

		
<!--- If a MAP is found, the Commercials go away --->

		<cfset variables.End_Date=Dateformat(now(),"mm/dd/yyyy")>
		<cfquery datasource="Ultra10" name="Chk_Map">
			SELECT		Nav_Type_ID
			FROM		Navigation
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="4">
			AND			Nav_Type_ID = 38
			AND			Start_Date < GETDATE()
			AND			End_Date >= '#variables.End_Date#'
		</cfquery>
		<cfset wch = "Commercial" >
		<cfif #Chk_Map.recordcount# GT 0 >
			<cfset wch = "Map" >
		</cfif>
		
		
		<section class="section-search">
			<div class="container">
				<div class="row">
					<div class="col-md-3 verticalBlank">		<!--- verticalBlank inserts a blank column for spacing Ridgecrest & Stoltz  --->
						<cfif #url.dealer_id# NEQ 83 and  #url.dealer_id# NEQ 80 >
							<div class="spl-search-name" title="#arguments.dealer_name# Car Finder">#arguments.dealer_name# <span class="spl-search-title">CAR FINDER</span></div>
						<cfelse>  <!--- Pinegar Branson --->
							<div class="spl-search-name" title="#arguments.dealer_name# Car Finder"><span class="spl-search-title">Find Your Car</span></div>	
						</cfif>
						<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						</cfinvoke>
						
					</div>
					<div class="col-md-6 verticalLine">		<!--- verticalLine inserts a BLACK column for separation Ridgecrest & Stoltz  --->
						<cfif #url.dealer_id# NEQ 83 and  #url.dealer_id# NEQ 80  >
							<div class="spl-search-name" title="#arguments.dealer_name# Quick Quote">#arguments.dealer_name# <span class="spl-search-title">QUICK QUOTE</span></div>
						<cfelse>  <!--- Pinegar Branson --->
							<div class="spl-search-name" title="#arguments.dealer_name# Quick Quote"><span class="spl-search-title">Get a Quick Quote</span></div>
						</cfif>
						<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
						</cfinvoke>
					</div>
					<div class="col-md-3 visible-md visible-lg verticalLine">
					<cfif #wch# EQ "Commercial" >
						<cfif #url.dealer_id# NEQ 83 and  #url.dealer_id# NEQ 80  >
						<div class="spl-search-name" title="#arguments.dealer_name# Videos">#arguments.dealer_name# <span class="spl-search-title">VIDEOS</span></div>
						<cfelse>  <!--- Pinegar Branson --->
						<div class="spl-search-name" title="#arguments.dealer_name# Videos"><span class="spl-search-title">View Our Videos</span></div>
						</cfif>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="30"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="video-link"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
					<cfelse>
						<div class="spl-search-name" title="#arguments.dealer_name# Location">#arguments.dealer_name# <span class="spl-search-title">LOCATION</span></div>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="38"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-map"/>
						</cfinvoke>
					</cfif>		
					</div>
				</div>
			</div>
		</section>

		<section class="section-carousel">
			<div class="container pad-top-10 visible-md visible-lg">
				<div class="row" align="center">
					<div id="#arguments.assets#-carousel" class="col-md-12">
							<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_ID#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="2"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="5"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel"/>
								<cfinvokeargument name="element_class" value="specials-icon"/>
								<cfinvokeargument name="slideWidth" value="450"/>
								<cfinvokeargument name="slideMargin" value="80"/>
								<cfinvokeargument name="addScript" value="true"/>
							</cfinvoke>
					</div>
					<div class="row">
						<div class="col-md-12">
							<br/>
						</div>
					</div>
				</div>
			</div>
			<div class="container pad-top-10 visible-xs visible-sm">
				<div class="row">
					<div class="col-md-12" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="5"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="specials-icon-mbl"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</section>
		
		<!--- About Us Text Area --->	
		<cfif #url.dealer_id# NEQ 46 >
			<cfinclude template="section_about_us.cfm" >
		</cfif>			

		<section class="section-links">
			<div class="container pad-top-10">
				<div class="row">
					<div class="col-md-9">
						<div class="row">
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
								</cfinvoke>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="11"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
				</div>
			</div>			
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	<!--- Check for Toyota Dealer  --->
		<cfset ss_trigger = 0 >
		<cfquery datasource="ultra10" name="Chk_tdds">SELECT Dealer_ID,	OEM_Key, TDDS, TDDS_region,	TDDS_tda,TDDS_district,	TDDS_autogroup FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfif #Chk_tdds.TDDS# EQ 1><cfset ss_trigger = 1 ></cfif>
	<!--- Check for Toyota Dealer  --->
	
		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:195px;padding:10px 10px 10px 0px;" valign="top">
							<div>
								<div style="padding-top:5px">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="13"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="spl-tools-btn"/>
										<cfinvokeargument name="glyph_left" value="true"/>
									</cfinvoke>
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="12"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="shopping-link"/>
										<cfinvokeargument name="glyph_left" value="true"/>
									</cfinvoke>
								</div>
							</div>
						</td>
						<td class="pad-top-10" style="width:785px" valign="top">
						 <cfif #ss_trigger# eq 999> 				  
                            <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  <cfelse>
                            <cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  </cfif>
							<!---<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>--->
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
							<cfinvoke component="/cfcs/ultra10/bxslider" method="misc">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_ID#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="6"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="45"/>
								<cfinvokeargument name="carousel_class" value="misc-carousel"/>
								<cfinvokeargument name="element_class" value="misc-icon"/>
								<cfinvokeargument name="slideWidth" value="130"/>
								<cfinvokeargument name="slideMargin" value="30"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-search">
			<div class="container">
				<table style="width:990px;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:230px;" valign="top">
							<div class="spl-search-name" title="#arguments.dealer_name# Car Finder">#arguments.dealer_name# <span class="spl-search-title">CAR FINDER</span></div>
							<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							</cfinvoke>
						</td>
						<td style="width:460px;" valign="top">
							<div class="spl-search-name" title="#arguments.dealer_name# Quick Quote">#arguments.dealer_name# <span class="spl-search-title">QUICK QUOTE</span></div>
							<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq_leg">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
							</cfinvoke>							
						</td>
						<td style="width:300px;" valign="top">
							<div class="spl-search-name" title="#arguments.dealer_name# Videos">#arguments.dealer_name# <span class="spl-search-title">VIDEOS</span></div>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
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
								<cfinvokeargument name="dealer_id" value="#url.dealer_ID#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="2"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="5"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel"/>
								<cfinvokeargument name="element_class" value="specials-icon"/>
								<cfinvokeargument name="slideWidth" value="450"/>
								<cfinvokeargument name="slideMargin" value="40"/>
								<cfinvokeargument name="addScript" value="true"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-links">
			<div class="container pad-top-10">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="8"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="9"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="10"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="11"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>