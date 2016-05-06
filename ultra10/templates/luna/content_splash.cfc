<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<section class="section-spl">
			<div class="container">
				<div class="row">
					<div class="col-md-3 pad-top-10 visible-md visible-lg">
						<div class="search-tools-bg">
							<div>
								<div class="spl-search-name">#arguments.dealer_name#</div>
								<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
								</cfinvoke>
							</div>
							<hr class="line-break"/>
							<div>
								<div class="spl-search-name">#arguments.dealer_name#</div>
								<div class="spl-search-title" title="QUICK QUOTE">QUICK QUOTE</div>
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
									<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
							</div>
							<br/><br/><br/>
						</div>
					</div>
					<div class="col-md-9 pad-top-10">
						<div class="row visible-sm visible-xs">
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
								<div class="search-tools-bg">
									<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
										<cfinvokeargument name="form_id" value="carfinderFormMbl"/>
									</cfinvoke>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<br/>
							</div>
						</div>
						<div class="row pad-top-10 visible-md visible-lg"><!--- OEM Box --->		
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="icon_label">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="54"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="spl-specials"/>
								<cfinvokeargument name="pull" value="left"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</div>
		</section>

		<section class="section-video">
			<div class="container">
				<div class="row visible-md visible-lg">
					<div class="col-md-8 no-pad">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="53"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="bottom-buttons"/>
							<cfinvokeargument name="pull" value="left"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 pad-top-10">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="30"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="video-link"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row visible-xs visible-sm">
					<div class="col-md-8 no-pad" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="53"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="bottom-buttons"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</section>
		

				<cfinclude template="section_about_us.cfm" >
				
		<section class="section-links">
			<div class="container pad-top-10">
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
							<div class="col-md-6" align="center">
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
					<div class="col-md-10">
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
								<br/>
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
								<br/>
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
								<br/>
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
								<br/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="11"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
						<br/>
					</div>
				</div>   <!--- end row --->
				
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
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="13"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-tools-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							<div class="search-tools-bg">
								<div style="padding-top:5px">
									<div class="spl-search-name">#arguments.dealer_name#</div>
									<div class="spl-search-title" title="CAR FINDER" >CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
									</cfinvoke>
								</div>
								<div style="padding-top:5px">
									<div class="spl-search-name">#arguments.dealer_name#</div>
									<div class="spl-search-title" title="QUICK QUOTE">QUICK QUOTE</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
										<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
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
							<table style="width:100%" cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top" align="center">
									<!--- OEM Box instead of bxslider --->									
										<div class="row pad-top-12 visible-md visible-lg">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="icon_label">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="54"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="spl-specials"/>
												<cfinvokeargument name="pull" value="left"/>
											</cfinvoke>
										</div>
									</td>
								</tr>	
							</table>	
							<table style="width:100%">
								<tr>
									<td valign="top">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="53"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="bottom-buttons"/>
											<cfinvokeargument name="pull" value="left"/>
										</cfinvoke>
									</td>
								</tr>	
								<tr>	
									<td valign="top">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="30"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="video-link"/>
										</cfinvoke>
										</td>  
									</tr>
										</table>
									</td>
								</tr>
							</table>
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
								<cfinvokeargument name="minSlides" value="2"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="5"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel-legacy"/>
								<cfinvokeargument name="element_class" value="specials-icon-legacy"/>
								<cfinvokeargument name="slideWidth" value="450"/>
								<cfinvokeargument name="slideMargin" value="100"/>
								<cfinvokeargument name="addScript" value="false"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

		<div class="section-tool-divider">
			<div class="container pad-top-10">
				<hr class="tool-div"/>
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