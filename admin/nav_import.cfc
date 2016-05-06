<cfcomponent>

	<cffunction name="legacy_dealer_nav" description="gets legacy dealers" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		
		<cfquery datasource="Ultra8" name="Get_Dealers">
			SELECT DISTINCT		Dealers.Dealercode,
								Dealers.Display_Name,
								Dealers.City,
								Dealers.State
			FROM         		Dealers
			INNER JOIN			Nav_Main_Dealer
			ON					Dealers.Dealercode = Nav_Main_Dealer.Dealercode
			WHERE				Dealers.Active = 1
			AND					Dealers.Display_Name NOT LIKE 'zzz%'
			ORDER BY 			Dealers.Display_Name
		</cfquery>
	
		<form class="form-horizontal" action="#arguments.form_action#?page_action=get_legacy_navbar&#arguments.Site_ID_Name#=#arguments.Site_ID#&Nav_Type_ID=#url.Nav_Type_ID#" method="post">
			<select name="dealercode">
				<cfloop query="Get_Dealers">
					<option value="#Get_Dealers.Dealercode#">#Get_Dealers.Display_Name# - #Get_Dealers.City#, #Get_Dealers.State#</option>
				</cfloop>
			</select>
			<input type="submit" value="Choose Dealer"/>
		</form>
	
	</cffunction>
	
	<cffunction name="get_legacy_navbar" description="gets legacy dealer main nav" output="Yes" access="public">
	
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfparam name="form.Dealercode" default="">
		
		<cfif len(trim(form.Dealercode)) gt 0>
			<cfquery datasource="Ultra8" name="Get_Main_Nav">
				SELECT		ID,
							Nav_Main_Name,
							Hierarchy
				FROM		Nav_Main_Dealer
				WHERE		Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Dealercode#" maxlength="30">
				ORDER BY 	Hierarchy
			</cfquery>
		
			<form action="#arguments.form_action#?page_action=import_legacy_nav&#arguments.Site_ID_Name#=#arguments.Site_ID#&Nav_Type_ID=#url.Nav_Type_ID#" method="post">
				<table>
					<tr>
						<td>Slide Name</td>
						<td>Order</td>
						<td>Select</td>
					</tr>
					<cfloop query="Get_Main_Nav">
						<tr>
							<td>#Get_Main_Nav.Nav_Main_Name#</td>
							<td align="center">#Get_Main_Nav.Hierarchy#</td>
							<td align="center"><input name="Nav_Main_ID" type="checkbox" value="#Get_Main_Nav.ID#"/></td>
						</tr>
					</cfloop>
				</table>
				<input type="submit" value="Import Nav"/>
			</form>
		
		</cfif>

	</cffunction>
	
	<cffunction name="import_legacy_nav" description="gets legacy dealer main nav" output="Yes" access="public">
		
		<cfif listlen(form.Nav_Main_ID) gt 0>
			<ul>
				<cfloop list="#form.Nav_Main_ID#" index="i">
					<cfquery datasource="Ultra8" name="Get_Main_Nav">
						SELECT		Nav_Main_ID,
									Nav_Main_Name,
									File_Path,
									Behavior_ID,
									Dealercode
						FROM		Nav_Main_Dealer
						WHERE		ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.i#" maxlength="10">
					</cfquery>

					<cfquery datasource="Ultra8" name="Get_Sub_Nav">
						SELECT		ID,
									Nav_Sub_Name,
									File_Path,
									Behavior_ID,
									Hierarchy
						FROM		Nav_Sub_Dealer
						WHERE		Nav_Main_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Main_Nav.Nav_Main_ID#" maxlength="10">
						AND			Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Main_Nav.Dealercode#" maxlength="30">
						ORDER BY Hierarchy
					</cfquery>
					<li>#Get_Main_Nav.Nav_Main_Name# - #Get_Main_Nav.File_Path# - #Get_Main_Nav.Behavior_ID# - #url.Dealer_ID#</li>

					<cfquery datasource="Ultra10" name="Get_H">
						SELECT		max(Hierarchy) as max_h
						FROM		Navigation
						WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="4">
						AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1" maxlength="10">
					</cfquery>
	
					<cfif len(trim(Get_H.max_h)) eq 0>
						<cfset variables.Hierarchy=1>
					<cfelse>
						<cfset variables.Hierarchy=Get_H.max_h+1>
					</cfif>

					<cfquery datasource="Ultra10" name="Insert_Nav">
						INSERT INTO Navigation
							(Dealer_ID,
							Nav_Type_ID,
							Nav_Name,
							Nav_Alt,
							Hierarchy,
							Nav_Link,
							Nav_Behaviour_ID,
							Legacy_Nav_Main_ID,
							Start_Date)
						VALUES
							(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="10">,
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1" maxlength="10">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Main_Nav.Nav_Main_Name#" maxlength="100">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Main_Nav.Nav_Main_Name#" maxlength="100">,
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="4">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Main_Nav.File_Path#">,
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Main_Nav.Behavior_ID#" maxlength="10">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.i#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),"mm/dd/yyyy")#">
							)
					
						SELECT SCOPE_IDENTITY() as New_ID
					</cfquery>

					<ul>
						<cfif Get_Sub_Nav.Recordcount gt 0>
							
							<cfloop query="Get_Sub_Nav">

								<cfquery datasource="Ultra10" name="Get_H">
									SELECT		max(Hierarchy) as max_h
									FROM		Navigation
									WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="4">
									AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="2" maxlength="10">
									AND			Parent_Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Insert_Nav.New_ID#" maxlength="10">
								</cfquery>

								<cfif len(trim(Get_H.max_h)) eq 0>
									<cfset variables.Hierarchy=1>
								<cfelse>
									<cfset variables.Hierarchy=Get_H.max_h+1>
								</cfif>

								<cfquery datasource="Ultra10" name="Insert_Sub_Nav">
									INSERT INTO Navigation
										(Dealer_ID,
										Nav_Type_ID,
										Nav_Name,
										Nav_Alt,
										Hierarchy,
										Nav_Link,
										Nav_Behaviour_ID,
										Legacy_Nav_Sub_ID,
										Parent_Nav_ID,
										Start_Date)
									VALUES
										(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="10">,
										<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="2" maxlength="10">,
										<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Sub_Nav.Nav_Sub_Name#" maxlength="100">,
										<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Sub_Nav.Nav_Sub_Name#" maxlength="100">,
										<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="4">,
										<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Sub_Nav.File_Path#">,
										<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Sub_Nav.Behavior_ID#" maxlength="10">,
										<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Sub_Nav.ID#">,
										<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Insert_Nav.New_ID#" maxlength="10">,
										<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),"mm/dd/yyyy")#">)
								</cfquery>

								<li>#Get_Sub_Nav.Nav_Sub_Name# - #Get_Sub_Nav.File_Path# - #Get_Sub_Nav.Behavior_ID# - #url.Dealer_ID# - #Insert_Nav.New_ID#</li>
							</cfloop>
						
						</cfif>
					</ul>
				</cfloop>
			</ul>
		</cfif>
		
	</cffunction>
	
</cfcomponent>