
<!--- section_primary_nav.cfm --->

<cfoutput>
	<cfif #position_nav# EQ 1 >
		<cfif #contain_nav# EQ 1 >
			<div class="container">
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
			</div>
		<cfelse>	
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
		</cfif>
	</cfif>
</cfoutput>
