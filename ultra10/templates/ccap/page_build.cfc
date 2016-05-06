<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="false">
		<cfargument name="method_name" required="false">
		<cfargument name="display_type" default="">

		<cfinvoke component="/cfcs/Ultra10/templates/#url.template_id#/content_error_page" method="#url.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="dealercode" value="#url.dealercode#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
			<cfinvokeargument name="component_name" value=""/>
			<cfinvokeargument name="method_name" value=""/>  <!--- #arguments.method_name# --->
			<cfinvokeargument name="display_type" value="#arguments.display_type#"/>
			<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
		</cfinvoke>
	</cffunction>

</cfcomponent>