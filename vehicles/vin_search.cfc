<cfcomponent>

	<cffunction name="standard" description="shows standard dealer hours" output="Yes" access="public">
	
		<!---arguments--->
		<cfargument name="dealer_id" required="yes">
		<cfargument name="vin" required="yes">
		<cfargument name="new_used" required="yes">
		
		 
		
			<cfif len(trim(arguments.vin)) gt 0>
				<cfquery datasource="Ultra10" name="Get_Vin">
					SELECT		TOP 1
								Vin,
								Permalink,
								V_Make,
								V_Model
					FROM		Vehicles
					WHERE		vin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vin#" maxlength="25">
						AND			Dealer_ID IN 
							(	SELECT 	Distinct Share_ID 
								FROM 	ultra10.dbo.Dealer_Shares 
								WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4"> 
							 )
				</cfquery>
				
				<cfif Get_Vin.Recordcount eq 1>
					<cfif len(trim(Get_Vin.Permalink)) gt 0>
						<cflocation url="http://#cgi.server_name#/vehicles/#lcase(Get_Vin.V_Make)#/#lcase(Get_Vin.V_Model)#/#Get_Vin.Permalink#">
					<cfelse>
						<cflocation url="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vin.vin#">
					</cfif>
				<cfelse>
					<cflocation url="http://#cgi.server_name#/file_not_found.cfm"> 
				</cfif>			
			</cfif>

		<!--- If search is clicked with no VIN number --->
		<cflocation url="http://#cgi.server_name#/file_not_found.cfm">
	</cffunction>

</cfcomponent>