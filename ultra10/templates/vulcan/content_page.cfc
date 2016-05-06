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
			
				<!--- Page Break Bar --->			<!--- gradient class declared in template-min.css if required  --->
			 	 <div class="row">
					<div class="col-md-12 pad-top-5 visible-lg visible-md">
						<div class="gradient" ></div>		
					</div>
				</div>	   
		<!--- Page Break Bar --->
				<cfswitch expression="#arguments.display_type#">
					
					<cfdefaultcase>
						<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
							<div class="row">
								<div class="col-md-12">
									<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
								</div>
							</div>
						</cfif>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="52"/>
							<cfinvokeargument name="assets" value="#url.assets#"/>
							<cfinvokeargument name="element_class" value="page-banner"/>
							<cfswitch expression="#lcase(cgi.script_name)#">
								<cfdefaultcase><cfinvokeargument name="page_id" value="#lcase(cgi.script_name)#"/></cfdefaultcase>
								<cfcase value="/new/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								</cfcase>
								<cfcase value="/used/special_offers.cfm,/certified/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfcase>
							</cfswitch>
						</cfinvoke>
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
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
						</div>
					</cfdefaultcase>

					<cfcase value="col_right">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="52"/>
							<cfinvokeargument name="assets" value="#url.assets#"/>
							<cfinvokeargument name="element_class" value="page-banner"/>
							<cfswitch expression="#lcase(cgi.script_name)#">
								<cfdefaultcase><cfinvokeargument name="page_id" value="#lcase(cgi.script_name)#"/></cfdefaultcase>
								<cfcase value="/new/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								</cfcase>
								<cfcase value="/used/special_offers.cfm,/certified/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfcase>
							</cfswitch>
						</cfinvoke>
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
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
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
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="52"/>
							<cfinvokeargument name="assets" value="#url.assets#"/>
							<cfinvokeargument name="element_class" value="page-banner"/>
							<cfswitch expression="#lcase(cgi.script_name)#">
								<cfdefaultcase><cfinvokeargument name="page_id" value="#lcase(cgi.script_name)#"/></cfdefaultcase>
								<cfcase value="/new/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								</cfcase>
								<cfcase value="/used/special_offers.cfm,/certified/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfcase>
							</cfswitch>
						</cfinvoke>
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
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
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
			
								<div class="clearfix"></div>
		</section>

		<!--- Showroom Section goes here --->
		<cfquery datasource="Ultra10" name="Chk_Showroom">
			SELECT 	Dealer_Page_ID, Dealer_ID, showroom_inc, showroom_make
			FROM    Dealer_Pages
			WHERE   Dealer_ID = #url.dealer_id#
			AND		showroom_inc = 1
			AND		script_name = '#lcase(cgi.script_name)#'
		</cfquery>
		<cfset howmany = #listlen(Chk_Showroom.showroom_make)#>
		<cfset a_make = #listtoarray(Chk_Showroom.showroom_make)#>
		<cfif #Chk_Showroom.recordcount# NEQ 0 >
			<cfset url.dealer_display = "#arguments.dealer_name#" >
			<cfloop index="x" from="1" to="#howmany#">
				<cfset url.v_make = "#a_make[x]#" >
				<cfset url.count = "#howmany#" >
				<cfinclude template="section_showroom.cfm">
			</cfloop>
		</cfif>
		<!--- Showroom Section goes here --->
		
		<section class="section-links">
			<div class="container pad-top-10">
				  <div class="row">
					<div class="col-md-12 pad-top-10  visible-lg visible-md">
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
					<cfdefaultcase>
						<div class="row">
							<div class="col-md-12">
								<!--- <cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke> --->
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
					<!--- <div class="col-md-3 visible-md visible-lg">
						<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="dsn" value="#url.DSN#"/>
							<cfinvokeargument name="title_class" value="ftr-title"/>
							<cfinvokeargument name="input_class" value="ftr-input"/>
							<cfinvokeargument name="button_class" value="ftr-contact-input"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
						</cfinvoke>
					</div> --->
				</div>
			</div>			
			
								<div class="clearfix"></div>
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<cfswitch expression="#arguments.display_type#">
					<cfdefaultcase>
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding:10px 0px 10px 0px;" valign="top">
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
									<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_footer#
											</div>
										</div>
									</cfif>
								</td>
							</tr>
						</table>
					</cfdefaultcase>
					<cfcase value="col_right">
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td style="width:790px;padding:0px 10px 0px 0px;" valign="top">
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
									<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_footer#
											</div>
										</div>
									</cfif>
								</td>
								<td  style="width:200px" valign="top">
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
								</td>
							</tr>
						</table>
					</cfcase>
					<cfcase value="col_left">
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td  style="width:200px" valign="top">
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
								</td>
								<td style="width:790px" valign="top">
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
									<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_footer#
											</div>
										</div>
									</cfif>
								</td>
							</tr>
						</table>
					</cfcase>
				</cfswitch>
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