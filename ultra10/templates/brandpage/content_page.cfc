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
		
		<cfif IsDefined("url.chrome_model_id") and #url.dealer_id# eq 256 >
			<cfset arguments.display_type = "" >
		</cfif> 
		
		<cfinclude template="section_utility_1.cfm">
		
		<section class="section-spl section-int">
			<div class="container int-container">
			
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
						<cfif #Get_Meta_Info.incl_position_1# eq 1 >
							<div class="row">
								<div class="col-md-12">
									<span style="color:red">#Get_Meta_Info.incl_dept_1#staff goes here</span>
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<!--- <cfset url.v_make = "Honda"> --->
								<cfset url.page_type = "4">
							<!--- Check for Toyota Dealer  --->
							<cfset ss_trigger = 0 >
							<cfquery datasource="ultra10" name="Chk_tdds">SELECT Dealer_ID,	OEM_Key, TDDS, TDDS_region,	TDDS_tda,TDDS_district,	TDDS_autogroup FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
							<cfif #Chk_tdds.TDDS# EQ 1><cfset ss_trigger = 1 ></cfif>
							<!--- Check for Toyota Dealer  --->
							
							<!--- Check for Quick Quote / Search Links  / Video --->
							<cfset variables.srch_meth = 0 >
							<cfset variables.price_srch_meth = 0 >  
							<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	srch_method,bxs_new_used, price_srch_method  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
							<cfset variables.srch_meth = #Chk_Srch.srch_method# >
						
							<cfset tmp_bx_type = "0" >   <!--- Default for Carousel --->
								
							<cfset variables.price_srch_meth = #Chk_Srch.price_srch_method# >
						
							<cfset sub_section_1_active = 0 >
							<cfset sub_section_2_active = 0 >
							<cfset sub_sec_v1_active = 0 >
							<cfset sub_sec_v2_active = 0 >
							<cfset sub_sec_helpful_1_active = 0 >
							<cfset sub_sec_helpful_2_active = 0 >
							<cfset sub_section_spl_type = 0 >
							<cfset contain_nav = 0 >		<!--- Primary Navigation 0 = No 1 = Yes--->
							<cfset position_nav = 0 >		<!--- Position Navigation 0 = Standard 1 = Variable --->
							<cfset section_seq = ArrayNew(1) >
							<cfset section_seq_active = ArrayNew(1) >
							<cfset scrn_title = 0>	 <!--- variable to include Screen Title  --->
							
							<cfquery datasource="Ultra10" name="Get_Layout">
								SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
								FROM    Variable_template_dealer_layout
								WHERE	dealer_id = #url.dealer_id#
								AND		page_type = #url.page_type#
								AND		active = 1
								ORDER BY  hierarchy ASC
							</cfquery>
							<cfset b = 0 >
							<cfloop  query="Get_Layout" >
								<cfset b = #b# +1 >
								<cfset section_seq[b] = "#Get_Layout.module_name#" >
									<cfif #Get_Layout.hierarchy# EQ 0 AND  #Get_Layout.active# EQ 1 ><cfset scrn_title = 1></cfif>
									
									<cfif #Get_Layout.has_subs# EQ 1 and #Get_Layout.module_ID# EQ 1 OR #Get_Layout.module_ID# EQ 49 >
										<cfset sub_section_1_active = #Get_Layout.variable_spl1# >		<!--- Search Position 0 = None 1=left 2=right --->
										<cfset sub_section_2_active = #Get_Layout.variable_spl2# >		<!--- Slideshow/Carousel 0 = None 1=Slideshow 2=Carousel--->
										<cfset sub_section_spl_type = #Get_Layout.variable_nav_type# >	<!--- Nav_Type_ID for Slideshow ---> 
									</cfif>
									
									<cfif #Get_Layout.module_ID# EQ 14 >
										<cfset tmp_bx_type = #Get_Layout.variable_spl1# >		<!--- New or Used for Carousel --->
									</cfif>	
									
									<cfif #Get_Layout.module_ID# EQ 19 >
										<cfset contain_nav = #Get_Layout.variable_spl1# >		<!--- Primary Navigation 0 = No 1 = Yes--->
										<cfset position_nav = #Get_Layout.variable_spl2# >		<!--- Primary Navigation 0 = Standard 1 = Variable --->
									</cfif>	
									
									<cfif #Get_Layout.module_ID# EQ 23 >
										<cfset sub_sec_v1_active = #Get_Layout.variable_spl1# >		<!--- Video Position 0=Non 1=left 2=right --->
										<cfset sub_sec_v2_active = #Get_Layout.variable_spl2# >		<!--- Form Style 0=Contact Us 1=Test Drive 2=Quote --->
									</cfif>	
									<cfif #Get_Layout.module_ID# EQ 24 >
										<cfset sub_sec_helpful_1_active = #Get_Layout.variable_spl1# >		<!--- Carousel Position 0=Non 1=left 2=right --->
										<cfset sub_sec_helpful_2_active = #Get_Layout.variable_spl2# >		<!--- Search / Link Style 0=Helpful Links 1=Search --->
									</cfif>	
									
								<cfset pg_nbr = #Get_Layout.page_type# >
							</cfloop>
							<cfset num_sections = #b# >
							
							<cfset spl1 	= #sub_section_1_active# >
							<cfset spl2 	= #sub_section_2_active# >
							<cfset ss_type 	= #sub_section_spl_type# >
							<cfif #tmp_bx_type# EQ 0 >
								<cfset variables.bx_type 	= "U" >
							<cfelse>
								<cfset variables.bx_type 	= "N" >
							</cfif>
								
							<cfinclude template="section_utility_1.cfm">
							<cfloop index="x" from="1" to="#num_sections#" >
								
									<cfinclude template="#section_seq[x]#">
						
							</cfloop>
							

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
		</section>

		<cfinclude template="section_utility_1.cfm">
		
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
				<!--- <cfset url.v_make = "#Chk_Showroom.showroom_make#" > --->
				<cfset url.v_make = "#a_make[x]#" >
				<cfset url.count = "#howmany#" >
				<cfinclude template="section_showroom.cfm">
			</cfloop>
		</cfif>
		<!--- Showroom Section goes here --->
		<cfif #url.dealer_id# EQ 90 >
		
			<cfinclude template="section_portal_btns.cfm">
		
		</cfif>
		
		<cfif #url.dealer_id# EQ 311 >
			<cfinclude template="section_rotator_flip.cfm" >
			<cfinclude template="section_links_v1.cfm" >
		<cfelse>
		<section class="section-links">
			<div class="container pad-top-10">
				 <!---  <div class="row">
					<div class="col-md-12 pad-top-10  visible-lg visible-md">
						<div class="gradient"></div>		
					</div>
				</div>	  --->
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
						
					</cfdefaultcase>
				</cfswitch>
				<div class="row pad-top-10">
				<cfif #url.dealer_id# NEQ 37 >		<!--- NO BOTTOM LINKS FOR Washington Toyota --->
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
				</cfif>
				</div>
			</div>			
		</section>
		</cfif>

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