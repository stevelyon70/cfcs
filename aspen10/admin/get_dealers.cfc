<cfcomponent>
	
	<cffunction name="get_dealers" description="gets dealers" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="dealer_id" default="">
		<cfargument name="my_output" default="select">
		
		<cfquery datasource="#arguments.DSN#" name="Get_Dealers">
			SELECT		Dealer_ID,
						Dealercode,
						Dealer_Name
			FROM		Dealers
			WHERE		Active = 1
			ORDER BY	Dealer_Name
		</cfquery>
		
		<cfswitch expression="#arguments.my_output#">
			<!--- default case is a select box --->
			<cfdefaultcase>
				
				<form id="Dealer_Form" name="Dealer_Form" action="#arguments.form_action#" method="get">
				
					<select class="table-input-data" name="Dealer_ID" onchange="javascript:document.getElementById('Dealer_Form').submit();">
						<option value="">Select A Dealer</option>
						<cfloop query="Get_Dealers">
							<option value="#Get_Dealers.Dealer_ID#" <cfif arguments.dealer_id eq "#Get_Dealers.Dealer_ID#">selected</cfif>>#Get_Dealers.Dealer_Name#</option>
						</cfloop>
					</select>
				
				</form>

			</cfdefaultcase>
			
		</cfswitch>
			
	</cffunction>
	
</cfcomponent>