<cfcomponent>

	<cffunction name="standard" description="shows standard dealer hours" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true" >
	
		<cfquery datasource="Ultra10" name="Get_Dealer_Pages">
			SELECT		page_name,
						script_name,
						Dealer_Wordpress_ID,
						Chrome_Model_ID
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			script_name <> '/sitemap.cfm'
			AND			script_name not like '/forms/thank_you%'
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			ORDER BY 	page_name
		</cfquery>
		
		<cfquery datasource="Ultra10" name="Chk_Showroom">
			SELECT		page_name,
						script_name,
						Dealer_Wordpress_ID,
						Chrome_Model_ID
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			script_name <> '/sitemap.cfm'
			AND			script_name not like '/forms/thank_you%'
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			Chrome_Model_ID is not null
			ORDER BY 	page_name
		</cfquery>
		<cfquery datasource="Ultra10" name="Chk_Blog">
			SELECT		page_name,
						script_name,
						Dealer_Wordpress_ID,
						Chrome_Model_ID
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			script_name <> '/sitemap.cfm'
			AND			script_name not like '/forms/thank_you%'
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			Dealer_Wordpress_ID is not null
			ORDER BY 	page_name
		</cfquery>

		<cfquery datasource="Ultra10" name="Get_NV">
			SELECT     	V_Year,
						V_Make,
						V_Model,
						V_Trim,
						Permalink,
						Vin
			FROM		Vehicles
			WHERE		Dealer_ID IN
						(SELECT DISTINCT Share_ID
						FROM          	Dealer_Shares
						WHERE			Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
						AND				New_Used = 'N')
			AND			V_New_Used = 'N'
			ORDER BY	V_Year, V_Make, V_Model, V_Trim
		</cfquery>

		<cfquery datasource="Ultra10" name="Get_UV">
			SELECT     	V_Year,
						V_Make,
						V_Model,
						V_Trim,
						Permalink,
						Vin
			FROM		Vehicles
			WHERE		Dealer_ID IN
						(SELECT DISTINCT Share_ID
						FROM          	Dealer_Shares
						WHERE			Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
						AND				New_Used = 'U')
			AND			V_New_Used = 'U'
			ORDER BY	V_Year, V_Make, V_Model, V_Trim
		</cfquery>
	
		<div class="row">
			<div class="col-md-12">
				<ul>
					<li>Main Navigation</li>
					<ul>
						<cfloop query="Get_Dealer_Pages">
							<cfif 	len(trim(Get_Dealer_Pages.Dealer_Wordpress_ID)) eq 0 and
									len(trim(Get_Dealer_Pages.Chrome_Model_ID)) eq 0>	
								<li><a href="http://#lcase(cgi.server_name)##lcase(Get_Dealer_Pages.script_name)#" title="#Get_Dealer_Pages.page_name#">#Get_Dealer_Pages.page_name#</a></li>
							</cfif>
						</cfloop>
					</ul>
					<cfif Chk_Blog.Recordcount gt 0>
						<li>Blog Posts</li>
						<ul>
							<cfloop query="Get_Dealer_Pages">
								<cfif len(trim(Get_Dealer_Pages.Dealer_Wordpress_ID)) gt 0>
									<li><a href="http://#lcase(cgi.server_name)##lcase(Get_Dealer_Pages.script_name)#" title="#Get_Dealer_Pages.page_name#">#Get_Dealer_Pages.page_name#</a></li>
								</cfif>
							</cfloop>
						</ul>
					</cfif>
					<cfif Chk_Showroom.Recordcount gt 0>
						<li>Vehicle Showrooms</li>
						<ul>
							<cfloop query="Get_Dealer_Pages">
								<cfif len(trim(Get_Dealer_Pages.Chrome_Model_ID)) gt 0>
									<li><a href="http://#lcase(cgi.server_name)##lcase(Get_Dealer_Pages.script_name)#?chrome_model_id=#Get_Dealer_Pages.Chrome_Model_ID#" title="#Get_Dealer_Pages.page_name#">#Get_Dealer_Pages.page_name#</a></li>
								</cfif>
							</cfloop>
						</ul>
					</cfif>
					<cfif Get_NV.Recordcount gt 0>
						<li>New Vehicles - #numberformat(Get_NV.recordcount)#</li>
						<ul>
							<cfif len(trim(Get_NV.Permalink)) gt 0>
								<cfloop query="Get_NV">
									<li><a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_NV.V_Make)#/#lcase(Get_NV.V_Model)#/#lcase(Get_NV.Permalink)#" title="New #Get_NV.V_Year# #Get_NV.V_Make# #Get_NV.V_Model# #Get_NV.V_Trim#">New #Get_NV.V_Year# #Get_NV.V_Make# #Get_NV.V_Model# #Get_NV.V_Trim#</a></li>
								</cfloop>
							</cfif>
						</ul>
					</cfif>
					<cfif Get_UV.Recordcount gt 0>
						<li>Used Vehicles - #numberformat(Get_UV.recordcount)#</li>
						<ul>
							<cfif len(trim(Get_UV.Permalink)) gt 0>
								<cfloop query="Get_UV">
									<li><a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_UV.V_Make)#/#lcase(Get_UV.V_Model)#/#lcase(Get_UV.Permalink)#" title="Used #Get_UV.V_Year# #Get_UV.V_Make# #Get_UV.V_Model# #Get_UV.V_Trim#">Used #Get_UV.V_Year# #Get_UV.V_Make# #Get_UV.V_Model# #Get_UV.V_Trim#</a></li>
								</cfloop>
							</cfif>
						</ul>
					</cfif>
				</ul>				
			</div>
		</div>

		
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">
	
	</cffunction>

</cfcomponent>