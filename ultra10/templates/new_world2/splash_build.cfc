<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfif NOT IsDefined("arguments.page") >
			<cfset arguments.page = 0 >
		</cfif>
		 
		<cfif #url.dealer_id# NEQ 341 >
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
		<cfif #url.dealer_id# EQ 341 >
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
		
		<cfif #url.dealer_id# NEQ 341 >
			<cfif #disp_nav# EQ 1 >
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
			</cfif>
		</cfif>
		
		<cfset url.page_type = #arguments.page# > 
		<cfinvoke component="/cfcs/ultra10/templates/#url.template_id#/content_variable" method="#url.site_mode#">
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
		</cfinvoke>
		
		<cfif #url.dealer_id# NEQ 341  >
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
		<cfif #url.dealer_id# EQ 341 >
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