<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="display_type" default="">
		<cfif NOT IsDefined("arguments.page") >
			<cfset arguments.page = 0 >
		</cfif>
		 
<cfif #url.dealer_id# NEQ 198 AND  #url.dealer_id# NEQ 302  AND  #url.dealer_id# NEQ 336  AND  #url.dealer_id# NEQ 17 AND  #url.dealer_id# NEQ 343  AND  #url.dealer_id# NEQ 341  >
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
<cfif (#url.dealer_id# EQ 17 AND  #cgi.server_name# EQ "12ultra10.wddemos.com") OR  (#url.dealer_id# EQ 343 AND  #cgi.server_name# EQ "11ultra10.wddemos.com")  OR  
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
			( #url.dealer_id# NEQ 343 AND  #cgi.server_name# NEQ "11ultra10.wddemos.com" )  AND ( #url.dealer_id# NEQ 341 AND  #cgi.server_name# NEQ "14ultra10.wddemos.com" ) >
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
<div class="container-fluid" >
		<section class="section-spl" style="min-height:400px">
			<div class="container">
			
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
				<cfif #url.dealer_id# NEQ 341 >
					<cfinvoke component="/cfcs/ultra10/locations" method="modern_standard">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="show_service" value="yes"/>
						<cfinvokeargument name="label_service" value=""/>
						<cfinvokeargument name="store_class" value="loc-store-name"/>
						<cfinvokeargument name="address_class" value="loc-address-class"/>
						<cfinvokeargument name="phone_class" value="loc-phone-class"/>
						<cfinvokeargument name="service_btn_class" value="loc-service-btn-class"/>
						<cfinvokeargument name="show_primary_btn" value="no"/>
						<cfinvokeargument name="show_service_btn" value="yes"/>
					</cfinvoke>
				<cfelse>
					<cfinvoke component="/cfcs/ultra10/locations_v1" method="modern_standard">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="show_service" value="yes"/>
						<cfinvokeargument name="label_service" value=""/>
						<cfinvokeargument name="store_class" value="loc-store-name"/>
						<cfinvokeargument name="address_class" value="loc-address-class"/>
						<cfinvokeargument name="phone_class" value="loc-phone-class"/>
						<cfinvokeargument name="service_btn_class" value="loc-service-btn-class"/>
						<cfinvokeargument name="show_primary_btn" value="no"/>
						<cfinvokeargument name="show_service_btn" value="yes"/>
					</cfinvoke>
				</cfif>
				<br/><br/>
				<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
				</cfif>
			</div>
		</div>

		<cfinclude template="section_utility_1.cfm">
	
		<cfif #url.dealer_id# EQ 311 >
			<cfinclude template="section_rotator_flip.cfm" >
			<cfinclude template="section_links_v1.cfm" >
		<cfelse>
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
				<cfif #url.dealer_id# NEQ 341 >
					<div class="row pad-top-10">
						<div class="col-md-3" style="align:center" >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</div>
						<div class="col-md-3" style="align:center" >
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
						<div class="col-md-3" style="align:center" >
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
						 <div class="col-md-3" style="align:center" >
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
					</div>
				<cfelse>	
					<div class="row-centered pad-top-10 pad-bottom-10">
						<cfloop index="c" from="7" to="11"> 
							<div class="col-md-2 col-centered" style="align:center" >
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="#c#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="info-link"/>
									<cfinvokeargument name="bold_top" value="true"/>
								</cfinvoke>
							</div>
						</cfloop>
					</div>
				</cfif>
				</div>
			</div>		
			 
								<div class="clearfix"></div>
			
		</section>
		</cfif>

		
	<cfif #url.dealer_id# NEQ 198  AND  #url.dealer_id# NEQ 302    AND  #url.dealer_id# NEQ 296    AND  #url.dealer_id# NEQ 17   AND  #url.dealer_id# NEQ 341       >

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
	<cfif #url.dealer_id# EQ 341>
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
</div>		

	</cffunction>

</cfcomponent>