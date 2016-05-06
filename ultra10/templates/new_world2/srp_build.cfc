<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
<cfif NOT IsDefined("arguments.page") >
	<cfset arguments.page = 0 >
</cfif>
		 
<cfif #url.dealer_id# NEQ 198 AND  #url.dealer_id# NEQ 302  AND  #url.dealer_id# NEQ 336  AND  #url.dealer_id# NEQ 17 AND  #url.dealer_id# NEQ 233  AND  #url.dealer_id# NEQ 341  >
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
			(#url.dealer_id# EQ 341 AND  #cgi.server_name# EQ "14ultra10.wddemos.com") >
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



		
		<!--- 
		<cfquery datasource="Ultra10" name="Chk_Nav">
			SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
			FROM    Variable_template_dealer_layout
			WHERE	dealer_id = #url.dealer_id#
			AND		module_id = 19
			and		page_type = #arguments.page#
			AND		active = 1
		</cfquery>
		<cfif #Chk_Nav.recordcount# EQ 0 > --->
			<cfset disp_nav = 1 >
			<cfset contain_nav = 1 >	
		<!--- <cfelse>
			<cfif #Chk_Nav.variable_spl2# EQ 0  >
				<cfset disp_nav = 1 >	
				<cfset contain_nav = #Chk_Nav.variable_spl1# >	
			<cfelseif #Chk_Nav.variable_spl2# EQ 1  >
				<cfset disp_nav = 0 >	
				<cfset contain_nav = #Chk_Nav.variable_spl1# >		
			</cfif>
		</cfif> --->
		
		<cfinclude template="section_utility_1.cfm">
		
	<cfif #url.dealer_id# NEQ 198 AND ( #url.dealer_id# NEQ 17 AND  #cgi.server_name# NEQ "12ultra10.wddemos.com" ) AND 
			( #url.dealer_id# NEQ 233 AND  #cgi.server_name# NEQ "11ultra10.wddemos.com" )  AND ( #url.dealer_id# NEQ 341 AND  #cgi.server_name# NEQ "14ultra10.wddemos.com" ) >
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
		
		<cfinclude template="section_utility_1.cfm">
		
		<cfif IsDefined("url.lookup_vins") ><cfset url.lookup_vins = #url.lookup_vins#></cfif>	<!--- From Collection search 03/27/2015 --->
		
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
		<cfinclude template="section_utility_1.cfm">
		
		<cfif #url.dealer_id# EQ 90 >
		
			<cfinclude template="section_portal_btns.cfm">
		
		</cfif>
	<cfif #url.dealer_id# EQ 311 >
		<cfinclude template="section_rotator_flip.cfm" >
		<cfinclude template="section_links_v1.cfm" >
	<cfelse>
		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				<section class="section-links">
					<div class="container pad-top-10">
					<!--- <div class="row">
						<div class="col-md-12 pad-top-10  visible-lg visible-md">
							<div class="gradient"></div>		
						</div>
					</div>	 --->
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
					</div>			
				</section>
			</cfdefaultcase>
			<cfcase value="legacy">
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
			</cfcase> 
		</cfswitch>
	</cfif>	

		<cfswitch expression="#arguments.dealer_id#">
			<cfdefaultcase>
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
			</cfdefaultcase>
			<cfcase value="18">
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
			</cfcase> 
		</cfswitch> 

	</cffunction>

</cfcomponent>