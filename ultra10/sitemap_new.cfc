<cfcomponent>

	<cffunction name="standard" description="shows standard dealer hours" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true" >
	
		<cfset cols = 0 >
		<cfquery datasource="Ultra10" name="Get_Dealer_Pages">
			SELECT		page_name,
						script_name,
						Dealer_Wordpress_ID,
						Chrome_Model_ID
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			script_name <> '/sitemap.cfm'
			AND			script_name not like '/forms/thank_you%'
			AND			script_name not like '/showroom%'
			AND			script_name not like '/blog%'
			
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			ORDER BY 	page_name
		</cfquery>
		
		<cfquery datasource="Ultra10" name="Get_Dealer_blog_Pages">
			SELECT		page_name,
						script_name,
						Dealer_Wordpress_ID,
						Chrome_Model_ID
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			script_name <> '/sitemap.cfm'
			AND			script_name not like '/forms/thank_you%'
			AND			script_name not like '/showroom%'
			AND			Dealer_Wordpress_ID <> 0
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			ORDER BY 	page_name
		</cfquery>
		<cfif #Get_Dealer_blog_Pages.recordcount#>
			<cfset cols = #cols# + 1 >
		</cfif>
		
		<cfquery datasource="Ultra10" name="Get_Showroom_Pages">
			SELECT		page_name,
						script_name,
						Dealer_Wordpress_ID,
						Chrome_Model_ID
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
			AND			script_name <> '/sitemap.cfm'
			AND			script_name not like '/forms/thank_you%'
			AND			script_name like '/showroom%'
			AND			Chrome_Model_ID <> 0
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			ORDER BY 	page_name
		</cfquery>
		<cfif #Get_Showroom_Pages.recordcount#>
			<cfset cols = #cols# + 1 >
		</cfif>

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
		<cfif #Get_NV.recordcount#>
			<cfset cols = #cols# + 1 >
		</cfif>

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
		<cfif #Get_UV.recordcount#>
			<cfset cols = #cols# + 1 >
		</cfif>

		<cfif #cols# eq 1 >
			<cfset cols = 12 >
		<cfelseif #cols# eq 2 >
			<cfset cols = 6 >
		<cfelseif #cols# eq 3 >
			<cfset cols = 4 >
		<cfelseif #cols# eq 4 >
			<cfset cols = 4 >
		<cfelseif #cols# eq 5 >
			<cfset cols = 4 >
		<cfelse>	
			<cfset cols = 4 >
		</cfif>
		
	
		<div class="row">
			<div class="col-md-#cols#">
				<ul>
					<li>Main Navigation (#Get_Dealer_Pages.Recordcount#)</li>
					<ul>
						<cfloop query="Get_Dealer_Pages">
							<cfif 	len(trim(Get_Dealer_Pages.Dealer_Wordpress_ID)) eq 0 and
									len(trim(Get_Dealer_Pages.Chrome_Model_ID)) eq 0>	
								<li><a href="http://#lcase(cgi.server_name)##lcase(Get_Dealer_Pages.script_name)#" title="#Get_Dealer_Pages.page_name#">#Get_Dealer_Pages.page_name#</a></li>
							</cfif>
						</cfloop>
					</ul>
				</ul>
					<cfif Get_UV.Recordcount gt 0>
						<ul>
							<li>Used Vehicles (#Get_UV.Recordcount#)</li>
							<ul> 
								<cfif len(trim(Get_UV.Permalink)) gt 0>
									<cfloop query="Get_UV">
										 
										<li><a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_UV.V_Make)#/#lcase(Get_UV.V_Model)#/#lcase(Get_UV.Permalink)#" title="Used #Get_UV.V_Year# #Get_UV.V_Make# #Get_UV.V_Model# #Get_UV.V_Trim#">Used #Get_UV.V_Year# #Get_UV.V_Make# #Get_UV.V_Model# #Get_UV.V_Trim#</a></li>
										
									</cfloop>
								</cfif>
							</ul>
						</ul>
					</cfif>  
			</div>	
			<div class="col-md-#cols#">	
				<cfif Get_Showroom_Pages.Recordcount gt 0>
					<ul> 
						<li>Vehicle Showrooms (#Get_Showroom_Pages.Recordcount#)</li>
						<ul>
							<cfloop query="Get_Showroom_Pages">
								<cfif len(trim(Get_Showroom_Pages.Chrome_Model_ID)) gt 0>
									<li><a href="http://#lcase(cgi.server_name)##lcase(Get_Showroom_Pages.script_name)#?chrome_model_id=#Get_Showroom_Pages.Chrome_Model_ID#" title="#Get_Showroom_Pages.page_name#">#Get_Showroom_Pages.page_name#</a></li>
								</cfif>
							</cfloop>
						</ul>	
					</ul>
				</cfif>
			  	<cfif Get_NV.Recordcount gt 0>
					<ul>
						<li>New Vehicles (#Get_NV.Recordcount#)</li>
						<ul>
							<cfif len(trim(Get_NV.Permalink)) gt 0>
								<cfloop query="Get_NV">
									<li><a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_NV.V_Make)#/#lcase(Get_NV.V_Model)#/#lcase(Get_NV.Permalink)#" title="New #Get_NV.V_Year# #Get_NV.V_Make# #Get_NV.V_Model# #Get_NV.V_Trim#">New #Get_NV.V_Year# #Get_NV.V_Make# #Get_NV.V_Model# #Get_NV.V_Trim#</a></li>
								</cfloop>
							</cfif>
						</ul>
					</ul>
				</cfif>
			</div>		
			<div class="col-md-#cols#">
				<cfif Get_Dealer_blog_Pages.Recordcount gt 0>
					<ul>
						<li>Blog Posts (#Get_Dealer_blog_Pages.Recordcount#)</li>
						<ul>
							<cfloop query="Get_Dealer_blog_Pages">
								<cfif len(trim(Get_Dealer_blog_Pages.Dealer_Wordpress_ID)) gt 0>
									<li><a href="http://#lcase(cgi.server_name)##lcase(Get_Dealer_blog_Pages.script_name)#" title="#Get_Dealer_blog_Pages.page_name#">#Get_Dealer_blog_Pages.page_name#</a></li>
								</cfif>
							</cfloop>
						</ul>
					</ul>
				</cfif>
			</div>	
		</div>

		
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">
	
	</cffunction>

</cfcomponent>