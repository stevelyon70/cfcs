<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<section class="section-spl">
			<div class="container">
				<div class="row">
					<div class="col-md-3 pad-top-10 visible-md visible-lg visible-sm visible-xs">
						<ul class="nav nav-tabs spl-tabs">
							<li class="active"><a href="##srch" data-toggle="tab">Search</a></li>
							<li><a href="##qq" data-toggle="tab">Quick Quote</a></li>
						</ul>
						<div class="tab-content srch-tabs">
							<div class="tab-pane active" id="srch">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="42"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="srch-links-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
							<div class="tab-pane" id="qq">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
									<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
							</div>
						</div>
					</div>
					<div class="col-md-9 pad-top-10">
						<div class="row  visible-sm visible-xs">
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
						<div class="row">
						<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="3"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
						</cfinvoke>
						</div>
						<div class="row visible-sm visible-xs">
							<div class="col-md-12">
								<br/><br/>
								<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
									<cfinvokeargument name="form_id" value="carfinderFormMbl"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<br/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<cfquery dbtype="query" name="Check_Nav">
			SELECT	Nav_ID
			FROM	Get_Nav
			WHERE	Nav_Type_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="25" maxlength="6">
		</cfquery>
		
		<cfif Check_Nav.Recordcount gt 0>
			<section class="section-carousel">
				<div class="container pad-top-10 visible-md visible-lg">
					<div class="row" align="center">
						<div id="#arguments.assets#-carousel" class="col-md-12">
							<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="4"/> 
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="35"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel"/>
								<cfinvokeargument name="element_class" value="specials-icon"/>
								<cfinvokeargument name="slideWidth" value="230"/>
								<cfinvokeargument name="slideMargin" value="15"/>
								<cfinvokeargument name="addScript" value="false"/>
							</cfinvoke>
						</div>
					</div>
				</div>
				<div class="container pad-top-10 visible-xs visible-sm">
					<div class="row">
						<div class="col-md-12" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="35"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="specials-icon-mbl"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</section>
		</cfif>

		  <section class="section-carousel">
			<div class="container pad-top-10">
				<div class="row  visible-md visible-lg" align="center">
					<cfif #url.dealer_id# NEQ 369 and #url.dealer_id# NEQ 288 >			<!--- turn off the oblong button slider 02-12-2016 --->
							<div id="#arguments.assets#-btn-carousel" class="col-md-12" align="center"> 
								<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="new_used" value="U"/>
									<cfinvokeargument name="minSlides" value="5"/>
                    	    	    <cfinvokeargument name="maxSlides" value="20"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="nav_type_id" value="36"/>
									<cfinvokeargument name="carousel_class" value="oblong-carousel"/>
									<cfinvokeargument name="element_class" value="oblong-icon"/>	
									<cfinvokeargument name="slideMargin" value="20"/>
									<cfinvokeargument name="slideWidth" value="186"/>
									<cfinvokeargument name="addScript" value="false"/>
								</cfinvoke>
							</div>
						<cfelse>
					<div id="#arguments.assets#-btn-carousel" class="col-md-12" align="center" >
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="36"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="btns-oblong"/>
							<cfinvokeargument name="pull" value="left"/>
						</cfinvoke>	
						</cfif>
						<div class="clearfix"></div>
						<div class="pad-top-10"></div>
					</div>   
				</div>
				 <div class="row visible-xs visible-sm">
					<div class="col-md-12" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="36"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="specials-icon-mbl"/>
							<cfinvokeargument name="pull" value="left"/>
						</cfinvoke>
					</div>
				</div> 
			</div>
		</section>  
		

		 <cfif #url.dealer_id# eq 54 or  #url.dealer_id# eq 52 >  
		<section class="section-spl">
			<div class="container" >
				<div class="row ">
					<div class="col-md-12 pad-top-10  " align="center">
					 <cfif #url.dealer_id# eq 54 >  
						<a href="http://pittsburgheastnissan.com/dealer/pittsburgheastnissan/daily_offers.cfm"><img class="img-responsive" src="http://images.automarksolutions.com/autopics/i/2098/dd_banner.png" border="0" ALT="Daily Deals"></a>
		 			 <cfelse>				
						<!---<a href="http://westhillsnissan.com/dealer/westhillsnissan/daily_offers.cfm"><img class="img-responsive"  src="http://images.automarksolutions.com/autopics/i/2099/dd_banner.png" border="0" ALT="Daily Deals"></a>--->
					</cfif>  
					</div>
				</div>	
				<div class="row">&nbsp;</div>
			</div>	
		</section>
		</cfif>
		
		<cfif #url.dealer_id# eq 288 OR  #url.dealer_id# eq 333 OR  #url.dealer_id# eq 369 >		<!--- AutoBuySmart - Courtesy 04/20 - Front Range Auto --->
			
		 <cfinclude template="section_bxslider.cfm" >  
		</cfif>
		<cfif  #url.dealer_id# eq 369 >		<!---  Front Range Auto --->
			<cfinclude template="section_cta_upper.cfm" >
			<cfinclude template="section_about_us.cfm" >
			<cfinclude template="section_maps.cfm" >
			 <!---  <cfinclude template="section_reviews.cfm" >  --->
		<cfelse>
		
	<cfif #url.dealer_id# Neq 288 AND  #url.dealer_id# Neq 333  AND  #url.dealer_id# Neq 369  >	
		<section class="section-video">
			<div class="container" >
				<div class="row">
					<div class="col-md-4 pad-top-10 " align="center">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="1"/>
							<cfinvokeargument name="maxSlides" value="1"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="55"/>
							<cfinvokeargument name="carousel_class" value="specials-carousel"/>
							<cfinvokeargument name="element_class" value="specials-icon"/>
							<cfinvokeargument name="slideWidth" value="275"/>
							<cfinvokeargument name="auto" value="false"/>
							<cfinvokeargument name="addScript" value="false"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 pad-top-10 visible-md visible-lg" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="30"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="video-link"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 pad-top-10  " align="center">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="1"/>
							<cfinvokeargument name="maxSlides" value="1"/>
							<cfinvokeargument name="certified" value="0"/>
							<cfinvokeargument name="slideWidth" value="260"/>
							<cfinvokeargument name="auto" value="false"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">&nbsp;</div>
				</div>
			</div>
		</section>
		<cfelse>
		<section class="section-video">
			<div class="container" >
				<div class="row">
					<div class="col-md-4 pad-top-10 " align="center">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="1"/>
							<cfinvokeargument name="maxSlides" value="4"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="55"/>
							<cfinvokeargument name="carousel_class" value="specials-carousel"/>
							<cfinvokeargument name="element_class" value="specials-icon"/>
							<cfinvokeargument name="slideWidth" value="275"/>
							<cfinvokeargument name="auto" value="false"/>
							<cfinvokeargument name="addScript" value="false"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 pad-top-10 visible-md visible-lg" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="38"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-map"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 pad-top-10  " align="center">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="1"/>
							<cfinvokeargument name="maxSlides" value="1"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="67"/>
							<cfinvokeargument name="carousel_class" value="specials-carousel"/>
							<cfinvokeargument name="element_class" value="specials-icon"/>
							<cfinvokeargument name="slideWidth" value="275"/>
							<cfinvokeargument name="auto" value="false"/>
							<cfinvokeargument name="addScript" value="false"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">&nbsp;</div>
				</div>
			</div>
		</section>
		</cfif>
	</cfif>	
				
		<!--- About Us Text Area --->		
		<cfif #url.dealer_id# NEQ 369 >
			<cfinclude template="section_about_us.cfm" >
		</cfif>		

		<section class="section-links">
			<div class="container pad-top-10">
				<cfswitch expression="#url.dealer_id#">
					<cfcase value="82"></cfcase>
					<cfcase value="288"></cfcase>
					<cfcase value="333"></cfcase>
					<cfcase value="369"></cfcase>
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
					<div class="col-md-3 visible-md visible-lg">
						<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="dsn" value="#url.DSN#"/>
							<cfinvokeargument name="title_class" value="ftr-title"/>
							<cfinvokeargument name="input_class" value="ftr-input"/>
							<cfinvokeargument name="button_class" value="ftr-contact-input"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
						</cfinvoke>
					</div>
				</div>
			</div>			
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