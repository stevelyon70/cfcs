<cfcomponent>

	<cffunction name="standard" description="shows standard dealer hours" output="Yes" access="public">
	
		<!---arguments--->
		<cfargument name="dealer_id" required="yes">
		<cfargument name="stock" required="yes">
		<cfargument name="new_used" required="yes">
		
		 
		<cfif #url.dealer_id# NEQ 78 and  <!--- Faulkner Mazda & Faulkner Nissan --->
				#url.dealer_id# NEQ 79 and  
					#url.dealer_id# NEQ 24 and  
						#url.dealer_id# NEQ 82 >
			<cfif len(trim(arguments.stock)) gt 0>
				<cfquery datasource="Ultra10" name="Get_Vin">
					SELECT		TOP 1
								Vin,
								Permalink,
								V_Make,
								V_Model
					FROM		Vehicles
					WHERE		Stock = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.stock#" maxlength="20">
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
		<cfelse>
        
        	
			<cfif len(trim(arguments.stock)) gt 0>
			
			<!--- right here if the car is searched for is used th arguments are still new --->
			
			<cfquery datasource="Ultra10" name="Get_Vin">
					SELECT		TOP 1
                    			Dealer_ID,
								V_New_Used,
								Vin,
								Permalink,
								V_Make,
								V_Model
					FROM		Vehicles V
					WHERE		Stock = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.stock#" maxlength="20">					            
								AND			Dealer_ID IN 
							(	SELECT 	Distinct Share_ID 
								FROM 	ultra10.dbo.Dealer_Shares 
								WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4"> 
							 )
				</cfquery>
                
                <cfif Get_Vin.Recordcount eq 1>
					<cfif len(trim(Get_Vin.Permalink)) gt 0>
                
				
						<cfif Get_Vin.V_New_Used EQ 'U' AND Get_Vin.Dealer_id EQ 78 AND url.dealer_id EQ 79>                            
                            <cflocation url="http://#cgi.server_name#/file_not_found.cfm"> 
						<cfelseif Get_Vin.V_New_Used EQ "U" AND Get_Vin.Dealer_id EQ 79 AND url.dealer_id EQ 78> >
							<cflocation url="http://#cgi.server_name#/file_not_found.cfm">
						<cfelse>
							<cflocation url="http://#cgi.server_name#/vehicles/#lcase(Get_Vin.V_Make)#/#lcase(Get_Vin.V_Model)#/#Get_Vin.Permalink#">
						</cfif>
						
						<cfif #Get_Vin.V_New_Used# EQ "N" AND #arguments.dealer_id# EQ 79 OR #arguments.dealer_id# EQ 78  >
                            <cflocation url="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vin.vin#">  
													
						</cfif>	
							
                        
						
						
						
						 
						<!---<cfif #Get_Vin.V_New_Used# EQ "U" AND #Get_Vin.Dealer_id# EQ 79 AND #url.dealer_id# EQ 78>                            
                            <cflocation url="http://#cgi.server_name#/file_not_found.cfm"> 	
						<cfelse>
							<cflocation url="http://#cgi.server_name#/vehicles/#lcase(Get_Vin.V_Make)#/#lcase(Get_Vin.V_Model)#/#Get_Vin.Permalink#"> 
						</cfif>--->
						
						<!---
						<cflocation url="http://#cgi.server_name#/vehicles/#lcase(Get_Vin.V_Make)#/#lcase(Get_Vin.V_Model)#/#Get_Vin.Permalink#">    
						<cfelseif Get_Vin.V_New_Used eq "U" AND #arguments.dealer_id# EQ 78 AND #url.dealer_id# EQ 79>
							
						<cfelseif Get_Vin.V_New_Used eq "U" AND #arguments.dealer_id# EQ 79 AND #url.dealer_id# EQ 79>
                            <cflocation url="http://#cgi.server_name#/vehicles/#lcase(Get_Vin.V_Make)#/#lcase(Get_Vin.V_Model)#/#Get_Vin.Permalink#">    
						<cfelseif Get_Vin.V_New_Used eq "U" AND #arguments.dealer_id# EQ 79 AND #url.dealer_id# EQ 78>
                            <cflocation url="http://#cgi.server_name#/file_not_found.cfm"> 								
                        
						<cfelse>
                            <cflocation url="http://#cgi.server_name#/file_not_found.cfm">
                        </cfif>--->
				
					</cfif>
                </cfif>
				
				
			
				
				<!---<cfif Get_Vin.Recordcount eq 1>
					<cfif len(trim(Get_Vin.Permalink)) gt 0>
						<cflocation url="http://#cgi.server_name#/vehicles/#lcase(Get_Vin.V_Make)#/#lcase(Get_Vin.V_Model)#/#Get_Vin.Permalink#">
					<cfelse>
						<cflocation url="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vin.vin#">
					</cfif>
				<cfelse>
					<cflocation url="http://#cgi.server_name#/file_not_found.cfm"> 
			</cfif>--->
			
		</cfif>
	</cfif>		 
	<!--- If search is clicked with no stock number --->
			 <cflocation url="http://#cgi.server_name#/file_not_found.cfm">
	</cffunction>

</cfcomponent>