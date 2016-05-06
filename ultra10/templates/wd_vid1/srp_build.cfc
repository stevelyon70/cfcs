<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<!--- <cfargument name="page" required="true"> --->
<cfif NOT IsDefined("arguments.page") >
	<cfset arguments.page = 0 >
</cfif>
		 
<cfif #url.dealer_id# NEQ 198 AND  #url.dealer_id# NEQ 302  AND  #url.dealer_id# NEQ 336  AND  #url.dealer_id# NEQ 17 
		AND  #url.dealer_id# NEQ 365 AND  #url.dealer_id# NEQ 233  AND  #url.dealer_id# NEQ 341   AND  #url.dealer_id# NEQ 24   
			AND  #url.dealer_id# NEQ 82    AND  #url.dealer_id# NEQ 46  AND  #url.dealer_id# NEQ 366    >
		<cfinvoke component="/cfcs/ultra10/build_header_full" method="#arguments.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
			<cfinvokeargument name="dealer_template_id" value="#arguments.dealer_template_id#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
		</cfinvoke> 
		<cfif arguments.site_mode eq "modern">
			<div container-fluid >
			<section class="section-subhdr visible-md visible-lg">
				<div class="container">
					<div class="row row-centered">
						<div class="col-centered">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="39"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="subhdr-link"/>
								<cfinvokeargument name="pull" value="left"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</section>
			</div>			
		</cfif>
</cfif>		 
<cfif (#url.dealer_id# EQ 17 AND  #cgi.server_name# EQ "12ultra10.wddemos.com") OR  (#url.dealer_id# EQ 233 AND  #cgi.server_name# EQ "11ultra10.wddemos.com")  OR  
			 #url.dealer_id# EQ 82 OR  #url.dealer_id# EQ 365  OR  #url.dealer_id# EQ 46  OR  #url.dealer_id# EQ 366   >
		<cfinvoke component="/cfcs/ultra10/build_header_full_v1" method="#arguments.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
			<cfinvokeargument name="dealer_template_id" value="#arguments.dealer_template_id#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
		</cfinvoke> 
		<cfif arguments.site_mode eq "modern">
			<cfif (#url.dealer_id# EQ 17 AND  #cgi.server_name# EQ "12ultra10.wddemos.com")>
				<div container-fluid >
				<section class="section-subhdr visible-md visible-lg">
					<div class="container">
						<div class="row row-centered">
							<div class="col-centered">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="39"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="subhdr-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</div>
						</div>
					</div>
				</section>
				</div>			
			</cfif>
		</cfif>
	</cfif>	




		
		<cfquery datasource="Ultra10" name="Chk_Nav">
			SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
			FROM    Variable_template_dealer_layout
			WHERE	dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#">
			AND		module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="19">
			and	page_type = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.page#">
			AND		active = 1
		</cfquery>
		<cfif #Chk_Nav.recordcount# EQ 0 >
			<cfset disp_nav = 0 >
			<cfset contain_nav = 0 >	
		<cfelse>
			<cfif #Chk_Nav.variable_spl2# EQ 0  >
				<cfset disp_nav = 1 >	
				<cfset contain_nav = #Chk_Nav.variable_spl1# >	
			<cfelseif #Chk_Nav.variable_spl2# EQ 1  >
				<cfset disp_nav = 0 >	
				<cfset contain_nav = #Chk_Nav.variable_spl1# >		
			<cfelseif #Chk_Nav.variable_spl2# EQ 2  >
				<cfset disp_nav = 0 >	
				<cfset contain_nav = 0 >		
			</cfif>
		</cfif>
		
		<cfinclude template="section_utility_1.cfm">
		
	<cfif #url.dealer_id# NEQ 198 AND ( #url.dealer_id# NEQ 17 AND  #cgi.server_name# NEQ "12ultra10.wddemos.com" ) AND 
			( #url.dealer_id# NEQ 233 AND  #cgi.server_name# NEQ "11ultra10.wddemos.com" )  AND ( #url.dealer_id# NEQ 341  )   AND 
			( #url.dealer_id# NEQ 24 AND  #cgi.server_name# NEQ "16ultra10.wddemos.com" ) AND #url.dealer_id# NEQ 365 AND #url.dealer_id# NEQ 366  >
			
		<cfif #disp_nav# EQ 1 >
		
				<cfif #url.dealer_id# NEQ 311 and #url.dealer_id# NEQ 341 >
					<cfif #contain_nav# EQ 1 ><div class="container"></cfif>
						<cfinvoke component="/cfcs/ultra10/build_navigation" method="#arguments.site_mode#">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
							<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
							<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
							<cfinvokeargument name="city" value="#arguments.city#"/>
							<cfinvokeargument name="state" value="#arguments.state#"/>
							<cfinvokeargument name="zip" value="#arguments.zip#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						</cfinvoke>
					<cfif #contain_nav# EQ 1 ></div></cfif>
					
				<cfelse>
					
					<cfif #contain_nav# EQ 1 ><div class="container-fluid"></cfif>
						<cfinvoke component="/cfcs/ultra10/build_navigation_right" method="#arguments.site_mode#">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
							<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
							<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
							<cfinvokeargument name="city" value="#arguments.city#"/>
							<cfinvokeargument name="state" value="#arguments.state#"/>
							<cfinvokeargument name="zip" value="#arguments.zip#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						</cfinvoke>
					<cfif #contain_nav# EQ 1 ></div></cfif>
				</cfif>
		</cfif>
		
	</cfif>
		
<div class="section-80-percent">		<!--- NEW 10/30/2015 Applies to all internal pages--->
		<div class="section-srp">
		<cfinvoke component="/cfcs/vehicles/srp" method="#url.site_mode#_standard">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
		</cfinvoke>
		</div>
</div>

				
				<cfif #url.dealer_id# EQ 365 OR  #url.dealer_id# EQ 366 >
					
				<cfelse>
					<section class="section-links">
						<div class="container pad-top-10">
							<cfswitch expression="#url.dealer_id#">
								<cfcase value="18,34,33,32,236">
									<div class="row">
										<div class="col-md-6 no-pad">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="28"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="sm-link"/>
												<cfinvokeargument name="pull" value="left"/>
											</cfinvoke>
										</div>
										<div class="col-md-6 no-pad">
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
							<div class="row">
								<div class="row pad-top-10">
								
					<div class="row pad-top-10 visible-sm visible-xs">
						<div class="col-md-3 pad-top-10" align="center" >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</div>
						<div class="col-md-3 pad-top-10" align="center"  >
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
						<div class="col-md-3 pad-top-10"  align="center"  >
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
						 <div class="col-md-3 pad-top-10"  align="center"  >
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
						 <!---  <div class="col-md-3 visible-md visible-lg" align="center" >
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
					<div class="section-80-percent visible-md visible-lg">
					<div class="row pad-top-10 visible-md visible-lg">
						<div class="col-md-3" align="left" >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</div>
						<div class="col-md-3" align="left"  >
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
						<div class="col-md-3"  align="left"  >
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
						 <div class="col-md-3"  align="left"  >
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
						 <!---  <div class="col-md-3 visible-md visible-lg" align="left" >
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
								</div>
							</div>
						</div>			
					</section>
				</cfif>	
			 


		
	<cfif #url.dealer_id# NEQ 198  AND  #url.dealer_id# NEQ 302    AND  #url.dealer_id# NEQ 296    AND  
		#url.dealer_id# NEQ 17   AND  #url.dealer_id# NEQ 341    AND  #url.dealer_id# NEQ 233    AND  #url.dealer_id# NEQ 24     AND  #url.dealer_id# NEQ 82     AND  #url.dealer_id# NEQ 365    AND  #url.dealer_id# NEQ 366       >

		<cfinvoke component="/cfcs/ultra10/build_footer" method="#url.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
		<cfquery name="chk_about" datasource="Ultra10">
			SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
			FROM    Variable_template_dealer_layout
			WHERE	dealer_id = #url.dealer_id#
			AND		page_type = #arguments.page#
			AND		active = 1
			ORDER BY  hierarchy ASC
		</cfquery>
		<cfif #chk_about.recordcount# EQ 1 >
			<cfset pg_nbr = #arguments.page# >
	 		<cfinclude template="section_about_us.cfm"> 
		</cfif>
			
	</cfif>
	
	<cfif #url.dealer_id# eq 365 OR  #url.dealer_id# eq 366 >
			<cfinclude template="section_links_about_us.cfm" >	
		<cfinvoke component="/cfcs/ultra10/build_footer" method="nissan_#url.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	</cfif>
	<cfif #url.dealer_id# eq 296 >
	
		<cfinvoke component="/cfcs/ultra10/build_footer" method="#url.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	</cfif>
	
	
	<cfif #url.dealer_id# EQ 302>
		<cfinvoke component="/cfcs/ultra10/build_footer" method="modern_portal">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	</cfif>
	<cfif #url.dealer_id# EQ 17>
		<cfinvoke component="/cfcs/ultra10/build_footer_v1" method="modern">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	</cfif>
	<cfif #url.dealer_id# EQ 341 or  #url.dealer_id# EQ 233 or  #url.dealer_id# EQ 24 or  #url.dealer_id# EQ 82>
		<cfinvoke component="/cfcs/ultra10/build_footer_v2" method="modern">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	</cfif>
	
	
	
	</cffunction>

</cfcomponent>