<cfcomponent>

	<cffunction name="create_line" description="writes a data line" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="new_line" default="true">
		<cfargument name="DSN" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		
		<cfset variables.End_Date=Dateformat(now(),"mm/dd/yyyy")>
		<cfquery datasource="#arguments.DSN#" name="Get_Nav">
			SELECT		Nav_Element_ID,
						Dealer_ID,
						Nav_Type_ID,
						Dealer_Template_ID,
						Nav_Title,
						Nav_Alt,
						Nav_Color,
						Nav_Weight,
						Nav_Size,
						Nav_Family,
						Nav_Style,
						Image_File,
						Link_Path,
						Nav_Script,
						Rollover_File,
						Nav_Behaviour_ID,
						Start_Date,
						End_Date,Robot_Food,
						Hierarchy
			FROM		Nav_Elements
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Nav_Type_ID#" maxlength="6">
			AND			Nav_Type_ID <> 13
			AND			Start_Date < GETDATE()
			AND			End_Date >= '#variables.End_Date#'
			ORDER BY	Hierarchy
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Dealer_Details">
			SELECT		Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset variables.data_file="E:\inetpub\wwwroot\Aspen10\dealer\#Get_Dealer_Details.Dealer_Directory#\data">
		
		<cfset variables.nav_id_list="">
		<cfset variables.title_list="">
		<cfset variables.alt_list="">
		<cfset variables.behaviour_list="">
		<cfset variables.link_list="">
		<cfset variables.script_list="">
		<cfset variables.img_list="">
		<cfset variables.roll_list="">
				
		<cfloop query="Get_Nav">
		
			<!---nav id--->
			<cfif len(trim(Get_Nav.Nav_Element_ID)) eq 0><cfset Get_Nav.Nav_Element_ID="NULL"></cfif>
			<cfset variables.nav_id_list=listappend(variables.nav_id_list,"#Get_Nav.Nav_Element_ID#","^")>
			<!---nav title--->
			<cfif len(trim(Get_Nav.Nav_Title)) eq 0><cfset Get_Nav.Nav_Title="NULL"></cfif>
			<cfset variables.title_list=listappend(variables.title_list,"#Get_Nav.Nav_Title#","^")>
			<!---nav alt --->
			<cfif len(trim(Get_Nav.Nav_Alt)) eq 0><cfset Get_Nav.Nav_Alt="NULL"></cfif>
			<cfset variables.alt_list=listappend(variables.alt_list,"#Get_Nav.Nav_Alt#","^")>
			<!---nav behaviour--->
			<cfif len(trim(Get_Nav.Nav_Behaviour_ID)) eq 0><cfset Get_Nav.Nav_Behaviour_ID="NULL"></cfif>
			<cfset variables.behaviour_list=listappend(variables.behaviour_list,"#Get_Nav.Nav_Behaviour_ID#","^")>
			<!---link path--->
			<cfif len(trim(Get_Nav.Link_Path)) gt 0>
				<cfif left(Get_Nav.Link_Path,4) neq "http">
					<cfquery datasource="#arguments.DSN#" name="Get_Primary_URL">
						SELECT		Dealer_URL,
									URL_Type
						FROM		Dealer_URLs
						WHERE		(URL_Type = 1 or URL_Type = 5)
						AND			Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
					</cfquery>
					<cfif Get_Primary_URL.URL_Type eq 5>
						<cfset Get_Primary_URL.Dealer_URL="www.#Get_Primary_URL.Dealer_URL#">
					</cfif>
					<cfif len(trim(Get_Primary_URL.Dealer_URL)) gt 0>
						<cfif Get_Nav.Link_Path eq "index.cfm">
							<cfset Get_Nav.Link_Path="http://#Get_Primary_URL.Dealer_URL#">
						<cfelse>
							<cfif left(Get_Nav.Link_Path,1) neq "/">
								<cfset Get_Nav.Link_Path="http://#Get_Primary_URL.Dealer_URL#/#Get_Nav.Link_Path#">
							<cfelse>
								<cfset Get_Nav.Link_Path="http://#Get_Primary_URL.Dealer_URL##Get_Nav.Link_Path#">
							</cfif>
						</cfif>
					
					</cfif>
				</cfif>
			</cfif>
			<cfset Get_Nav.Link_Path=lcase(Get_Nav.Link_Path)>
			<cfif len(trim(Get_Nav.Link_Path)) eq 0><cfset Get_Nav.Link_Path="NULL"></cfif>
			<cfset variables.link_list=listappend(variables.link_list,"#Get_Nav.Link_Path#","^")>
			<!---nav script--->
			<cfif len(trim(Get_Nav.Nav_Script)) eq 0><cfset Get_Nav.Nav_Script="NULL"></cfif>
			<cfset variables.script_list=listappend(variables.script_list,"#Get_Nav.Nav_Script#","^")>
			<!---image--->
			<cfif len(trim(Get_Nav.Image_File)) eq 0><cfset Get_Nav.Image_File="NULL"></cfif>
			<cfset variables.img_list=listappend(variables.img_list,"#Get_Nav.Image_File#","^")>
			<!---rollover--->
			<cfif len(trim(Get_Nav.Rollover_File)) eq 0><cfset Get_Nav.Rollover_File="NULL"></cfif>
			<cfset variables.roll_list=listappend(variables.roll_list,"#Get_Nav.Rollover_File#","^")>
		
		</cfloop>
		
		<cffile action="WRITE" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output="" addnewline="false">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.nav_id_list="#variables.nav_id_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.title_list="#variables.title_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.alt_list="#variables.alt_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.behaviour_list="#variables.behaviour_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.link_list="#variables.link_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.script_list="#variables.script_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.img_list="#variables.img_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.roll_list="#variables.roll_list#">' addnewline="#arguments.new_line#">
	
	</cffunction>

</cfcomponent>