<cfcomponent>

	<cffunction name="list_spl" description="gets current nav listing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="Special_Type_ID" default="1">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Get_Specials">
			SELECT		Dealer_Special_ID,
						Special_Type_ID,
						Dealer_ID,
						Special_Name,
						Special_Image,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		Dealer_Specials
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			Special_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Special_Type_ID#" maxlength="6">
			ORDER BY 	Hierarchy
		</cfquery>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=bulk_update" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Dealer_ID" value="#arguments.Dealer_ID#"/>
			<input type="hidden" name="Special_Type_ID" value="#arguments.Special_Type_ID#"/>
			<table style="font:normal 12px arial;" cellpadding="3" cellspacing="0">
				<tr>
					<td>
						<b>Special Name</b>
					</td>
					<td>
						<b>Image</b>
					</td>
					<td>
						<b>Start Date</b>
					</td>
					<td>
						<b>End Date</b>
					</td>
					<td>
						<b>Hierarchy</b>
					</td>
					<td align="center">
						<b>Delete</b>
					</td>
				</tr>
				<cfloop query="Get_Specials">
					<input type="hidden" name="Dealer_Special_ID" value="#Get_Specials.Dealer_Special_ID#"/>
					<tr <cfif Get_Specials.currentRow mod 2 eq 0>style="background-color:##eeeeee"</cfif>>
						<td>
							<input type="text" name="Spl_Name_#Get_Specials.Dealer_Special_ID#" value="#Get_Specials.Special_Name#" maxlength="100"/>
						</td>
						<td>
							<input type="file" name="Spl_Img_#Get_Specials.Dealer_Special_ID#"/>
						</td>
						<td>
							<input type="text" name="Start_Date_#Get_Specials.Dealer_Special_ID#" value="#dateformat(Get_Specials.Start_Date,'mm/dd/yyyy')#" maxlength="10"/>
						</td>
						<td>
							<cfif dateformat(Get_Specials.End_Date,"mm/dd/yyyy") eq "12/31/2100">
								<input type="text" name="End_Date_#Get_Specials.Dealer_Special_ID#" value="" maxlength="10"/>
							<cfelse>
								<input type="text" name="End_Date_#Get_Specials.Dealer_Special_ID#" value="#dateformat(Get_Specials.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
							</cfif>
						</td>
						<td>
							<input type="text" name="Hierarchy_#Get_Specials.Dealer_Special_ID#" value="#Get_Specials.Hierarchy#" maxlength="3"/>
						</td>
						<td align="center">
							<input type="checkbox" name="Spl_Delete" value="#Get_Specials.Dealer_Special_ID#"/>
						</td>
					</tr>
					<tr <cfif Get_Specials.currentRow mod 2 eq 0>style="background-color:##eeeeee"</cfif>>
						<td>&nbsp;</td>
						<td valign="top">
							current : <cfif len(trim(Get_Specials.Special_Image)) gt 0>#Get_Specials.Special_Image#<cfelse><span class="color:red">No image uploaded</span></cfif>
						</td>
						<td valign="top" colspan="4">&nbsp;
							
						</td>
					</tr>
				</cfloop>
				<tr>
					<td><input type="submit" value="Update Specials"/></td>
				</tr>
			</table>
		</form>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=add_spl" method="post">
			<input type="hidden" name="Dealer_ID" value="#arguments.Dealer_ID#"/>
			<input type="hidden" name="Special_Type_ID" value="#arguments.Special_Type_ID#"/>
			<input type="text" name="Special_Name" maxlength="100"/>
			<input type="submit" value="Add New Special"/>
		</form>

	
	</cffunction>


	<cffunction name="add_spl" description="Add a Special" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="Special_Type_ID" default="1">

		<cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		max(Hierarchy) as max_h
			FROM		Dealer_Specials
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="4">
			AND			Special_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Special_Type_ID#" maxlength="6">
		</cfquery>
			
		<cfif len(trim(Get_H.max_h)) eq 0>
			<cfset variables.Hierarchy=1>
		<cfelse>
			<cfset variables.Hierarchy=Get_H.max_h+1>
		</cfif>

		<cfquery datasource="#arguments.DSN#" name="Insert_Nav">
			INSERT INTO Dealer_Specials
				(Dealer_ID,
				Special_Name,
				Special_Type_ID,
				Start_Date,
				Hierarchy)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Special_Name#" maxlength="100">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Special_Type_ID#" maxlength="2">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="3">)
		</cfquery>
	
	</cffunction>

	<cffunction name="bulk_update" description="Update Specials" output="Yes" access="public">

		<cfargument name="Save_Directory" required="true">
		<cfparam name="form.Spl_Delete" default="">
			
		<cfloop list="#form.Dealer_Special_ID#" index="sid">

			<cfset variables.Special_Name="form.Spl_Name_#variables.sid#">
			<cfset variables.Start_Date="form.Start_Date_#variables.sid#">
			<cfset variables.End_Date="form.End_Date_#variables.sid#">
			<cfset variables.Hierarchy="form.Hierarchy_#variables.sid#">
			<cfset variables.Spl_Img="form.Spl_Img_#variables.sid#">
			<cfset variables.img_file="">

			<cfif len(trim(evaluate(variables.Spl_Img))) gt 0>
				<cftry>
					<cffile action="upload" filefield="#variables.Spl_Img#" destination="#arguments.Save_Directory#" nameconflict="overwrite">
                        <cfdump var="#cffile#">
                        <cfdump var="#arguments#">
					<cfset variables.img_file=cffile.serverFile>
					<cfimage source="#arguments.Save_Directory#\#variables.img_file#" name="new_image">
					<cfcatch>
						<cfset variables.img_file="">
                        <cfdump var="#cfcatch#">
					</cfcatch>
				</cftry>
			</cfif>

			<cfquery datasource="#arguments.DSN#" name="Update_Nav">
				UPDATE		Dealer_Specials
				SET			Special_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Special_Name)#" maxlength="100">,
							Start_Date = <cfif len(trim(evaluate(variables.Start_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.Start_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
							End_Date = <cfif len(trim(evaluate(variables.End_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.End_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>,
							<cfif len(trim(variables.img_file)) gt 0>
								Special_Image = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.img_file#" maxlength="100">,
							</cfif>
							Hierarchy = <cfif len(trim(evaluate(variables.Hierarchy))) gt 0><cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#evaluate(variables.Hierarchy)#" maxlength="2"><cfelse>0</cfif>
				WHERE		Dealer_Special_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.sid#" maxlength="6">
			</cfquery>

		</cfloop>

		<cfloop list="#form.Spl_Delete#" index="did">

			<cfquery datasource="#arguments.DSN#" name="Delete_Spl">
				DELETE FROM	Dealer_Specials
				WHERE		Dealer_Special_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.did#" maxlength="4">
			</cfquery>
		
		</cfloop>
		
		<cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		Dealer_Special_ID,
						Hierarchy
			FROM		Dealer_Specials
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			Special_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Special_Type_ID#" maxlength="6">
			ORDER BY 	Hierarchy
		</cfquery>
		
		<cfloop query="Get_H">

			<cfquery datasource="#arguments.DSN#" name="Update_H">
				UPDATE		Dealer_Specials
				SET			Hierarchy = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#Get_H.Currentrow#" maxlength="2">
				WHERE		Dealer_Special_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_H.Dealer_Special_ID#" maxlength="6">
				AND			Special_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Special_Type_ID#" maxlength="6">
			</cfquery>
		
		</cfloop>
	
	</cffunction>
	
</cfcomponent>