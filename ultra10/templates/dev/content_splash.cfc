<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<section class="section-spl">
			<div class="container">
				<div class="row">
					<div class="col-md-3 pad-top-10 visible-md visible-lg">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="13"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="spl-tools-btn"/>
							<cfinvokeargument name="glyph_right" value="true"/>
						</cfinvoke>
						<hr/>
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
						<hr class="line-break"/>
						<div>
							<div class="spl-search-title" title="SHOPPING TOOLS">SHOPPING TOOLS</div>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="12"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="shopping-link"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
							<div class="div-10"></div>
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
						<div class="row pad-top-10">
							<div class="col-md-5 pad-top-10 visible-md visible-lg">
								<div title="#arguments.dealer_name# COMMERCIALS"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">COMMERCIALS</span></div>
								<div class="pad-top-10">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="30"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="video-link"/>
										<cfinvokeargument name="glyph_left" value="true"/>
									</cfinvoke>
									<!---<a href="##" data-toggle="modal" data-target="##videoModal">
										<img src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/icon_videos.png"/>
									</a>--->
								</div>
							</div>
							<div class="col-md-7 pad-top-10">
								<div title="#arguments.dealer_name# FEATURED VEHICLES"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">FEATURED VEHICLES</span></div>
								<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
									<cfinvoke component="/cfcs/ultra10/bxslider" method="v_specials_legacy">
										<cfinvokeargument name="dsn" value="ultra10"/>
										<cfinvokeargument name="dealer_id" value="31"/>
										<cfinvokeargument name="assets" value="stuckeyforyou"/>
										<cfinvokeargument name="new_used" value="U"/>
										<cfinvokeargument name="minSlides" value="3"/>
										<cfinvokeargument name="maxSlides" value="12"/>										
									</cfinvoke>
								</div>
								<div class="row visible-md visible-lg">
									<div class="col-md-6 pad-top-10" align="center">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="14"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="specials-link"/>
											<cfinvokeargument name="glyph_left" value="true"/>
										</cfinvoke>
									</div>
									<div class="col-md-6 pad-top-10" align="center">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="15"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="specials-link"/>
											<cfinvokeargument name="glyph_left" value="true"/>
										</cfinvoke>
									</div>
								</div>
								<div class="row visible-xs visible-sm">
									<div class="col-md-6 pad-top-10" align="center">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="14"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="specials-link"/>
											<cfinvokeargument name="glyph_left" value="true"/>
										</cfinvoke>
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="15"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="specials-link"/>
											<cfinvokeargument name="glyph_left" value="true"/>
										</cfinvoke>
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="12"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="specials-link"/>
											<cfinvokeargument name="glyph_left" value="true"/>
										</cfinvoke>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<section class="section-carousel">
			<div class="container pad-top-10 visible-md visible-lg">
				<div class="row">
					<div id="#arguments.assets#-carousel" class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="31"/>
							<cfinvokeargument name="assets" value="stuckeyforyou"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="2"/>
							<cfinvokeargument name="maxSlides" value="20"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="5"/>
							<cfinvokeargument name="carousel_class" value="specials-carousel"/>
							<cfinvokeargument name="element_class" value="specials-icon"/>
							<cfinvokeargument name="slideWidth" value="450"/>
							<cfinvokeargument name="slideMargin" value="100"/>
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
							<cfinvokeargument name="nav_type_id" value="5"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="specials-icon-mbl"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</section>

		<section class="section-tool-divider pad-top-10">
			<hr class="tool-div"/>
		</section>

		<section class="section-links">
			<div class="container pad-top-10">
				<div class="row">
					<div class="col-md-2">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="7"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
						</cfinvoke>
					</div>
					<div class="col-md-2">
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
					<div class="col-md-2">
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

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td class="pad-top-10" style="width:25%" valign="top">
							<div style="width:92%">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="13"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-tools-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
							<hr/>
							<div class="spl-search-name">#arguments.dealer_name#</div>
							<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
							<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="btn_pull" value="pull-right"/>
							</cfinvoke>
							<hr/>
							<div class="spl-search-name">#arguments.dealer_name#</div>
							<div class="spl-search-title" title="QUICK QUOTE">QUICK QUOTE</div>
							<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="btn_pull" value="pull-right"/>
							</cfinvoke>
							<hr/>
							<div class="spl-search-title" title="SHOPPING TOOLS">SHOPPING TOOLS</div>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="12"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="shopping-link"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
							<div class="div-10"></div>
						</td>
						<td class="pad-top-10" style="width:75%" valign="top">
							<table style="width:100%;margin:0px 0px 0px 10px;" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="2">
										<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="nav_type_id" value="3"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
										</cfinvoke>
									</td>
								</tr>
								<tr>
									<td style="width:35%;padding:20px 0px 0px 0px;" valign="top">
										<div title="#arguments.dealer_name# COMMERCIALS"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">COMMERCIALS</span></div>
										<div class="pad-top-10">
											<a href="##">
												<img alt="Videos" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/icon_videos.png" border="0"/>
											</a>
										</div>
									</td>
									<td style="width:65%;padding:20px 0px 0px 0px;" valign="top">
										<div title="#arguments.dealer_name# FEATURED VEHICLES"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">FEATURED VEHICLES</span></div>
										<div>
											<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
												<cfinvokeargument name="dsn" value="ultra10"/>
												<cfinvokeargument name="dealer_id" value="31"/>
												<cfinvokeargument name="assets" value="stuckeyforyou"/>
												<cfinvokeargument name="new_used" value="U"/>
												<cfinvokeargument name="minSlides" value="3"/>
												<cfinvokeargument name="maxSlides" value="12"/>										
											</cfinvoke>
										</div>
										<table style="width:100%" cellpadding="0" cellspacing="0">
											<tr>
												<td style="width:50%">
													<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
														<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
														<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
														<cfinvokeargument name="nav_type_id" value="14"/>
														<cfinvokeargument name="assets" value="#arguments.assets#"/>
														<cfinvokeargument name="element_class" value="specials-link"/>
														<cfinvokeargument name="glyph_left" value="true"/>
													</cfinvoke>
												</td>
												<td style="width:50%">
													<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
														<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
														<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
														<cfinvokeargument name="nav_type_id" value="15"/>
														<cfinvokeargument name="assets" value="#arguments.assets#"/>
														<cfinvokeargument name="element_class" value="specials-link"/>
														<cfinvokeargument name="glyph_left" value="true"/>
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
			<div class="container pad-top-10">
				<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
					<cfinvokeargument name="dsn" value="ultra10"/>
					<cfinvokeargument name="dealer_id" value="31"/>
					<cfinvokeargument name="assets" value="stuckeyforyou"/>
					<cfinvokeargument name="new_used" value="U"/>
					<cfinvokeargument name="minSlides" value="2"/>
					<cfinvokeargument name="maxSlides" value="20"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="nav_type_id" value="5"/>
					<cfinvokeargument name="carousel_class" value="specials-carousel"/>
					<cfinvokeargument name="element_class" value="specials-icon"/>
					<cfinvokeargument name="slideWidth" value="450"/>
					<cfinvokeargument name="slideMargin" value="100"/>
					<cfinvokeargument name="addScript" value="false"/>
				</cfinvoke>
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