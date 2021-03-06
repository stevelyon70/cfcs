<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">

		<cfinvoke component="/cfcs/ultra10/templates/#url.template_id#/content_splash" method="#url.site_mode#">
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
			<cfif IsDefined("url.myid")>
				<cfinvokeargument name="MyID" value="#url.myid#"/>
			</cfif>
			<cfif IsDefined("arguments.dealercode_id")>
				<cfinvokeargument name="dealercode_id" value="#arguments.dealercode_id#"/>
			</cfif>
		</cfinvoke>

	</cffunction>

</cfcomponent>