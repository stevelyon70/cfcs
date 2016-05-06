<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">

		<cfquery datasource="Aspen10" name="Get_Departments">
			SELECT		Join_Dealer_Dept.Dealer_Dept_ID,
						Departments.Department
			FROM		Join_Dealer_Dept
			INNER JOIN	Departments
			ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
			WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			AND			Join_Dealer_Dept.Dealer_Dept_ID IN (SELECT Dealer_Dept_ID FROM Dealer_Dept_Hours)
			ORDER BY 	Join_Dealer_Dept.Hierarchy
		</cfquery>
		
		<div class="row">
			<cfloop query="Get_Departments">
				<cfquery datasource="Aspen10" name="Get_Hours">
					SELECT		Line_Desc,
								Line_Value
					FROM		Dealer_Dept_Hours
					WHERE		Dealer_Dept_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Departments.Dealer_Dept_ID#" maxlength="6">
					AND			active = 1
					ORDER BY 	Hierarchy
				</cfquery>
				<div class="col-md-4">
					<div class="dept-name" title="#Get_Departments.Department#"><b>#Get_Departments.Department#</b></div>
					<hr class="dept-break"/>
					<cfloop query="Get_Hours">
						<div class="dept-hours" title="#Get_Hours.Line_Desc#: #Get_Hours.Line_Value#"><b>#Get_Hours.Line_Desc#:</b> #Get_Hours.Line_Value#</div>
					</cfloop>
					<br/><br/>
				</div>
				<cfif Get_Departments.currentRow mod 3 eq 0>
					</div><div class="row">
				</cfif>
			</cfloop>
		</div>
		<div class="row">
			<div class="col-md-12">
				<cfinvoke component="/cfcs/aspen10/google_map" method="v3">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</div>
		
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">

		<cfquery datasource="Aspen10" name="Get_Departments">
			SELECT		Join_Dealer_Dept.Dealer_Dept_ID,
						Departments.Department
			FROM		Join_Dealer_Dept
			INNER JOIN	Departments
			ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
			WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			AND			Join_Dealer_Dept.Dealer_Dept_ID IN (SELECT Dealer_Dept_ID FROM Dealer_Dept_Hours)
			ORDER BY 	Join_Dealer_Dept.Hierarchy
		</cfquery>
		
		<table style="width:100%" cellpadding="0" cellspacing="0">
			<tr>
				<td style="padding:10px 0px 10px 0px;" valign="top">
					<table style="width:100%" cellpadding="0" cellspacing="0">
						<tr>
							<cfloop query="Get_Departments">
								<cfquery datasource="Aspen10" name="Get_Hours">
									SELECT		Line_Desc,
												Line_Value
									FROM		Dealer_Dept_Hours
									WHERE		Dealer_Dept_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Departments.Dealer_Dept_ID#" maxlength="6">
									AND			active = 1
									ORDER BY 	Hierarchy
								</cfquery>
								<td>
									<div class="dept-name" title="#Get_Departments.Department#"><b>#Get_Departments.Department#</b></div>
									<hr class="dept-break"/>
									<cfloop query="Get_Hours">
										<div class="dept-hours" title="#Get_Hours.Line_Desc#: #Get_Hours.Line_Value#"><b>#Get_Hours.Line_Desc#:</b> #Get_Hours.Line_Value#</div>
									</cfloop>
									<br/><br/>
								</td>
								<cfif Get_Departments.Currentrow mod 4 eq 0>
									</tr><tr>
								</cfif>
							</cfloop>
						</tr>
					</table><br/>
					<cfinvoke component="/cfcs/aspen10/google_map" method="v3">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
						<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
						<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
						<cfinvokeargument name="city" value="#arguments.city#"/>
						<cfinvokeargument name="state" value="#arguments.state#"/>
						<cfinvokeargument name="zip" value="#arguments.zip#"/>
					</cfinvoke>
				</td>
			</tr>
		</table>
	</cffunction>

</cfcomponent>