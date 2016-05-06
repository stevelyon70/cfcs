<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="true">
		<cfargument name="method_name" required="true">
		<cfargument name="display_type" default="">

		<cfinvoke component="/cfcs/ultra10/build_header_v" method="#arguments.site_mode#">
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

		<cfinvoke component="/cfcs/ultra10/build_navigation_v" method="#arguments.site_mode#">
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
	
		<cfinvoke component="/cfcs/ultra10/templates/#url.template_id#/content_page" method="#url.site_mode#">
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
			<cfinvokeargument name="component_name" value="#arguments.component_name#"/>
			<cfinvokeargument name="method_name" value="#arguments.method_name#"/>
			<cfinvokeargument name="display_type" value="#arguments.display_type#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	

		<cfswitch expression="#arguments.dealer_id#">
			<cfdefaultcase>
				<cfinvoke component="/cfcs/ultra10/build_footer_v" method="#url.site_mode#">
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
				<cfinvoke component="/cfcs/ultra10/build_footer_v" method="nissan_#url.site_mode#">
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