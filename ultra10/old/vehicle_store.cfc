<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp store info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_Display_Name" default="">
		<cfargument name="Dealer_Address_1" default="">
		<cfargument name="Dealer_Address_2" default="">
		<cfargument name="Dealer_City" default="">
		<cfargument name="Dealer_State" default="">
		<cfargument name="Dealer_Zip" default="">
		<cfargument name="Dealer_Phone" default="">

		Vehicle Located At<br/>
		<cfif len(trim(arguments.Dealer_Display_Name)) gt 0><div class="vdp-store-name"><b>#ucase(arguments.Dealer_Display_Name)#</b></div></cfif>
		<cfif len(trim(arguments.Dealer_Address_1)) gt 0>#arguments.Dealer_Address_1# |</cfif>
		<cfif len(trim(arguments.Dealer_Address_2)) gt 0>#arguments.Dealer_Address_2#</cfif>
		<cfif len(trim(arguments.Dealer_City)) gt 0>#arguments.Dealer_City#, #arguments.Dealer_State# #arguments.Dealer_Zip#</cfif>
		<cfif len(trim(arguments.Dealer_Phone)) gt 0><div class="vdp-store-phone txt-red"><b>#arguments.Dealer_Phone#</b></div></cfif>

	</cffunction>

	<cffunction name="horizontal" description="shows default vdp store info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_Display_Name" default="">
		<cfargument name="Dealer_Address_1" default="">
		<cfargument name="Dealer_Address_2" default="">
		<cfargument name="Dealer_City" default="">
		<cfargument name="Dealer_State" default="">
		<cfargument name="Dealer_Zip" default="">
		<cfargument name="Dealer_Phone" default="">

		<cfif len(trim(arguments.Dealer_Display_Name)) gt 0>Vehicle Located At : <span class="vdp-store-name"><b>#ucase(arguments.Dealer_Display_Name)#</b></span></cfif>
		<cfif len(trim(arguments.Dealer_Address_1)) gt 0>#arguments.Dealer_Address_1# |</cfif>
		<cfif len(trim(arguments.Dealer_Address_2)) gt 0>#arguments.Dealer_Address_2#</cfif>
		<cfif len(trim(arguments.Dealer_City)) gt 0>#arguments.Dealer_City#, #arguments.Dealer_State# #arguments.Dealer_Zip# | </cfif>
		<cfif len(trim(arguments.Dealer_Phone)) gt 0><span class="vdp-store-phone txt-red"><b>#arguments.Dealer_Phone#</b></span></cfif>

	</cffunction>

</cfcomponent>