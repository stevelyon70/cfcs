<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">

		<cfquery datasource="Ultra10" name="Get_Departments">
			SELECT		Join_Dealer_Dept.Dealer_Dept_ID,
						Departments.Department
			FROM		Join_Dealer_Dept
			INNER JOIN	Departments
			ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
			WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			AND			Join_Dealer_Dept.Dealer_Dept_ID IN (SELECT Dealer_Dept_ID FROM Dealer_Dept_Hours)
			ORDER BY 	Join_Dealer_Dept.Hierarchy
		</cfquery>
		
		<cfquery datasource="ultra10" name="Get_Dirs">SELECT driving_directions FROM Dealers WHERE dealer_id = #url.dealer_id# </cfquery>
		<cfset directions_onoff = #Get_Dirs.driving_directions# >
		
		<div class="row">
			<cfloop query="Get_Departments">
				<cfquery datasource="Ultra10" name="Get_Hours">
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
		
		<cfif #directions_onoff# eq 1 >
				<div class="row-centered">
					<div class="dept-name pull-left"  title="Driving Directions"><b>Get Driving Directions:</b></div>
					<div class="col-centered"style="margin-top:10px!important">
						<form action="http://maps.google.com/maps" method="get" target="_blank">
							Enter Your Starting Address:
							 <input type="text" name="saddr" size="50" placeholder="Street City State Zip" />&nbsp;&nbsp;
							 <input type="submit" class="dd-btn directions-go-btn" value="Get Directions" />
							 <input type="hidden" name="daddr" value="#arguments.address_1# #arguments.address_2# #arguments.city# #arguments.state# #arguments.zip#" />
							 </form>
							 <br/>
					</div>
				</div>
		</cfif>
		
		<div class="row">
			<div class="col-md-12">
		<cfif #directions_onoff# neq 1 >
				<cfinvoke component="/cfcs/ultra10/google_map" method="v3">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
		<cfelse>
				<cfinvoke component="/cfcs/ultra10/google_map" method="v2">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
		</cfif>		
			</div>
		</div>
		
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">

		<cfquery datasource="Ultra10" name="Get_Departments">
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
								<cfquery datasource="Ultra10" name="Get_Hours">
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
					<cfinvoke component="/cfcs/ultra10/google_map" method="v3">
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