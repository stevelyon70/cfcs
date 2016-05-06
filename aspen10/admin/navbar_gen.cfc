<cfcomponent>

	<cffunction name="create_line" description="writes a data line" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="new_line" default="true">
		<cfargument name="DSN" required="true">
		<cfargument name="Dealer_ID" required="true">
		
		<cfset variables.End_Date=Dateformat(now(),"mm/dd/yyyy")>
		<cfquery datasource="#arguments.DSN#" name="Get_Nav">
			SELECT		Nav_Element_ID,
						Dealer_ID,
						Nav_Type_ID,
						Dealer_Template_ID,
						Main_Nav_ID,
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
						robot_food,
						End_Date,
						Hierarchy
			FROM		Nav_Elements
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="13" maxlength="6">
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
		<cffile action="WRITE" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<ul class="nav">' addnewline="no">

		<cfloop query="Get_Nav">

			<cfset variables.main_ID=Get_Nav.Nav_Element_ID>
			<cfset variables.main_title=Get_Nav.Nav_Title>
			<cfset variables.main_alt=Get_Nav.Nav_Alt>
			<cfset variables.main_link=Get_Nav.Link_Path>
			<cfset variables.main_b=Get_Nav.Nav_Behaviour_ID>
		
			<!---link path--->
			<cfif len(trim(variables.main_link)) gt 0>
				<cfif left(variables.main_link,4) neq "http">
					<cfquery datasource="#arguments.DSN#" name="Get_Primary_URL">
						SELECT		Dealer_URL,
									URL_Type
						FROM		Dealer_URLs
						WHERE		(URL_Type = 1 or URL_Type = 5)
						AND			Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
					</cfquery>
					<cfif len(trim(Get_Primary_URL.Dealer_URL)) gt 0>
						<cfif Get_Primary_URL.URL_Type eq 5>
							<cfset Get_Primary_URL.Dealer_URL="www.#Get_Primary_URL.Dealer_URL#">
						</cfif>
						<cfif variables.main_link eq "index.cfm">
							<cfset variables.main_link="http://#Get_Primary_URL.Dealer_URL#">
						<cfelse>
							<cfif left(variables.main_link,1) neq "/">
								<cfset variables.main_link="http://#Get_Primary_URL.Dealer_URL#/#variables.main_link#">
							<cfelse>
								<cfset variables.main_link="http://#Get_Primary_URL.Dealer_URL##variables.main_link#">
							</cfif>
						</cfif>
					
					</cfif>
				</cfif>
			</cfif>
			<cfif len(trim(variables.main_link)) eq 0><cfset variables.main_link="##"></cfif>
			<cfset variables.main_link=lcase(variables.main_link)>
			
			<cfquery datasource="#arguments.DSN#" name="Get_Sub_Nav">
				SELECT		Nav_Element_ID,
							Dealer_ID,
							Nav_Type_ID,
							Dealer_Template_ID,
							Nav_Title,
							Nav_Alt,
							Nav_Color,
							Nav_Bg_Color,
							Nav_Rollover_Color,
							Nav_Bg_Rollover,
							Nav_Weight,
							Nav_Size,
							Nav_Family,
							Text_Decoration,
							Nav_Style,
							Image_File,
							Link_Path,
							Rollover_File,
							Nav_Behaviour_ID,
							Start_Date,
							End_Date,
							Hierarchy
				FROM		Nav_Elements
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
				AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="14" maxlength="6">
				AND			Main_Nav_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Nav.Nav_Element_ID#" maxlength="6">
				ORDER BY	Hierarchy
			</cfquery>

			<cfif Get_Sub_Nav.Recordcount gt 0>
				<cfset variables.this_class="dropdown-toggle nav_#variables.main_ID# main-nav-link">
			<cfelse>
				<cfset variables.this_class="nav_#variables.main_ID# main-nav-link">
			</cfif>

			<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">

				<cfcase value="12">
					<cfset variables.this_line='<a id="nav_#variables.main_ID#" class="#variables.this_class#" href="##" title="#variables.main_alt#">#variables.main_title#</a>'>
				</cfcase>

				<cfcase value="13">
					<cfset variables.this_line='<a id="nav_#variables.main_ID#" class="#variables.this_class#" href="#variables.main_link#" title="#variables.main_alt#">#variables.main_title#</a>'>
				</cfcase>

				<cfcase value="14">
					<cfset variables.this_line='<a id="nav_#variables.main_ID#" class="#variables.this_class#" href="#variables.main_link#" title="#variables.main_alt#" target="_blank">#variables.main_title#</a>'>
				</cfcase>

			</cfswitch>
			
			<cfif Get_Sub_Nav.Recordcount gt 0>
				
				<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<li class="dropdown">#variables.this_line#' addnewline="no">	
				
			<cfelse>

				<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<li>#variables.this_line#' addnewline="no">	
	
			</cfif>
			
			
				<cfif Get_Sub_Nav.Recordcount gt 0>
					
					<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<ul class="dropdown-menu">' addnewline="no">
					
						<cfloop query="Get_Sub_Nav">

							<cfset variables.sub_ID=Get_Sub_Nav.Nav_Element_ID>
							<cfset variables.sub_title=Get_Sub_Nav.Nav_Title>
							<cfset variables.sub_alt=Get_Sub_Nav.Nav_Alt>
							<cfset variables.sub_link=Get_Sub_Nav.Link_Path>
							<cfset variables.sub_b=Get_Sub_Nav.Nav_Behaviour_ID>
							
							<!---link path--->
							<cfif len(trim(variables.sub_link)) gt 0>
								<cfif left(variables.sub_link,4) neq "http">
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
										<cfif variables.sub_link eq "index.cfm">
											<cfset variables.sub_link="http://#Get_Primary_URL.Dealer_URL#">
										<cfelse>
											<cfif left(variables.sub_link,1) neq "/">
												<cfset variables.sub_link="http://#Get_Primary_URL.Dealer_URL#/#variables.sub_link#">
											<cfelse>
												<cfset variables.sub_link="http://#Get_Primary_URL.Dealer_URL##variables.sub_link#">
											</cfif>
										</cfif>
									
									</cfif>
								</cfif>
							</cfif>
							<cfif len(trim(variables.sub_link)) eq 0><cfset variables.sub_link="##"></cfif>
							<cfset variables.sub_link=lcase(variables.sub_link)>
				
							<cfswitch expression="#variables.sub_b#">
				
								<cfcase value="20">
									<cfset variables.sub_line='<a id="nav_#variables.sub_ID#" class="nav_#variables.sub_ID#" href="##" title="#variables.sub_alt#">#variables.sub_title#</a>'>
								</cfcase>
				
								<cfcase value="21">
									<cfset variables.sub_line='<a id="nav_#variables.sub_ID#" class="nav_#variables.sub_ID#" href="#variables.sub_link#" title="#variables.sub_alt#">#variables.sub_title#</a>'>
								</cfcase>
				
								<cfcase value="22">
									<cfset variables.sub_line='<a id="nav_#variables.sub_ID#" class="nav_#variables.sub_ID#" href="#variables.sub_link#" title="#variables.sub_alt#" target="_blank">#variables.sub_title#</a>'>
								</cfcase>
				
							</cfswitch>
				
							<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<li>#variables.sub_line#</li>' addnewline="no">
				
						</cfloop>
					
					<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output="</ul>" addnewline="no">
				
				</cfif>

			<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output="</li>" addnewline="no">	

		</cfloop>
		
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output="</ul>" addnewline="no">


<!---<li class="dropdown">
	    <a href="moo.cfm" class="dropdown-toggle">Filters <b class="caret"></b></a>
	    <ul class="dropdown-menu">
	        <li><a href="moo.cfm">Filter1</a></li>
	        <li><a href="##">Filter2</a></li>
	    </ul>
	</li>--->

<!---					
		<cffile action="WRITE" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output="" addnewline="false">
		
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.title_list="#variables.title_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.alt_list="#variables.alt_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.behaviour_list="#variables.behaviour_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.link_list="#variables.link_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.script_list="#variables.script_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.img_list="#variables.img_list#">' addnewline="#arguments.new_line#">
		<cffile action="APPEND" file="#variables.data_file#\nav_data_#url.Nav_Type_ID#.cfm" output='<cfset variables.roll_list="#variables.roll_list#">' addnewline="#arguments.new_line#">--->
	
	</cffunction>

</cfcomponent>