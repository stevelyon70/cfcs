<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="true">
		<cfargument name="method_name" required="true">
		<cfargument name="display_type" default="">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
	
		<section class="section-spl">
			<div class="container">

				<cfswitch expression="#arguments.display_type#">
					
					<cfdefaultcase>
						<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
							<div class="row">
								<div class="col-md-12">
									<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
								</div>
							</div>
						</cfif>
						<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
							<div class="row">
								<div class="col-md-12">
									#Get_Meta_Info.page_banner#
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
						</div>
					</cfdefaultcase>

					<cfcase value="col_right">
						<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
							<div class="row">
								<div class="col-md-12">
									#Get_Meta_Info.page_banner#
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-9 pad-top-10">
								<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
									<div class="row">
										<div class="col-md-12">
											<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
										</div>
									</div>
								</cfif>
								<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
							<div class="col-md-3 pad-top-10 contact-div visible-md visible-lg">
								<div class="content-contact">
									<cfif cgi.script_name neq "/forms/contact.cfm">
										<cfinvoke component="/cfcs/forms/form_contact" method="sidebar_modern">
											<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
											<cfinvokeargument name="dsn" value="#url.DSN#"/>
											<cfinvokeargument name="title_class" value="side-title"/>
											<cfinvokeargument name="input_class" value="side-input"/>
											<cfinvokeargument name="button_class" value="button-input"/>
											<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
										</cfinvoke>
										<hr>
									</cfif>
									<cfinvoke component="/cfcs/ultra10/contact" method="phone">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
										<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
										<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
										<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
										<cfinvokeargument name="city" value="#arguments.city#"/>
										<cfinvokeargument name="state" value="#arguments.state#"/>
										<cfinvokeargument name="zip" value="#arguments.zip#"/>
										<cfinvokeargument name="title_class" value="side-title"/>
									</cfinvoke>
								</div>
							</div>
						</div>
					</cfcase>

					<cfcase value="col_left">
						<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
							<div class="row">
								<div class="col-md-12">
									#Get_Meta_Info.page_banner#
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-3 pad-top-10 contact-div">
								<div class="content-contact">
									<cfinvoke component="/cfcs/forms/form_contact" method="sidebar_modern">
										<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
										<cfinvokeargument name="dsn" value="#url.DSN#"/>
										<cfinvokeargument name="title_class" value="side-title"/>
										<cfinvokeargument name="input_class" value="side-input"/>
										<cfinvokeargument name="button_class" value="button-input"/>
										<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
									</cfinvoke>
									<hr>
									<cfinvoke component="/cfcs/ultra10/contact" method="phone">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
										<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
										<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
										<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
										<cfinvokeargument name="city" value="#arguments.city#"/>
										<cfinvokeargument name="state" value="#arguments.state#"/>
										<cfinvokeargument name="zip" value="#arguments.zip#"/>
										<cfinvokeargument name="title_class" value="side-title"/>
									</cfinvoke>
								</div>
							</div>
							<div class="col-md-9 pad-top-10">
								<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
									<div class="row">
										<div class="col-md-12">
											<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
										</div>
									</div>
								</cfif>
								<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
						</div>
					</cfcase>

				</cfswitch>
				<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
				</cfif>
			</div>
			<div class="div-10"></div>
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
												<img alt="Commercials" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/icon_videos.png" border="0"/>
											</a>
										</div>
									</td>
									<td style="width:65%;padding:20px 0px 0px 0px;" valign="top">
										<div title="#arguments.dealer_name# FEATURED VEHICLES"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">FEATURED VEHICLES</span></div>
										<div>
											fv
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
				<cfinvoke component="/cfcs/ultra10/nav_elements" method="carousel_legacy">
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
					<cfinvokeargument name="nav_type_id" value="5"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="element_class" value="specials-icon"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="max_icons" value="2"/>
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