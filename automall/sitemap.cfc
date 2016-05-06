<cfcomponent>

	<cffunction name="standard" description="custom page content" output="Yes" access="public">
	
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_banner#
				</div>
			</div>
		</cfif>
		<div class="row">
			<div class="col-md-12">
				<cfquery datasource="Automall" name="Get_Pages">
					SELECT     	directory,
								page_name,
								script_name
					FROM		Page_Content
					WHERE		automall_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
					AND 		page_name <> 'vehicle_details.cfm'
					AND 		page_name <> 'sitemap.cfm'
					AND 		page_name not like 'thank_you%'
					ORDER BY 	directory, page_name
				</cfquery>
				<ul>
					<li><b>Pages</b></li>
					<ul>
						<cfloop query="Get_Pages">
							<cfif len(trim(Get_Pages.directory)) eq 0 and Get_Pages.page_name eq "index.cfm">
								<li><a href="http://#cgi.server_name#">http://#cgi.server_name#</a></li>
							</cfif>
							<cfif  len(trim(Get_Pages.directory)) gt 0 and Get_Pages.page_name eq "index.cfm">
								<li><a href="http://#cgi.server_name#/#Get_Pages.directory#">http://#cgi.server_name#/#Get_Pages.directory#</a></li>
							</cfif>
							<cfif Get_Pages.page_name neq "index.cfm">
								<li><a href="http://#cgi.server_name##Get_Pages.script_name#">http://#cgi.server_name##Get_Pages.script_name#</a></li>
							</cfif>
						</cfloop>
					</ul>
				</ul>
				<cfquery datasource="Automall" name="Get_Vehicles" cachedWithin="#createTimeSpan( 0, 0, 10, 0 )#">
					SELECT     	V_New_Used,
								V_Year,
								V_Make,
								V_Model,
								V_Trim, Vin
					FROM		Vehicles
					WHERE     	(Automall_ID = 91)
					AND			(LEN(V_Year) = 4)
					ORDER BY 	V_New_Used, V_Year, V_Make, V_Model, V_Trim
				</cfquery>
				<ul>
					<li><b>Vehicles</b></li>
					<ul>
						<cfloop query="Get_Vehicles">
							<li>
								<a href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.Vin#">
									<cfif Get_Vehicles.V_New_Used eq "N">New<cfelse>Used</cfif> #Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model# #Get_Vehicles.V_Trim#
								</a>
							</li>
						</cfloop>
					</ul>
				</ul>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_footer#
				</div>
			</div>
		</cfif>
	</cffunction>

</cfcomponent>