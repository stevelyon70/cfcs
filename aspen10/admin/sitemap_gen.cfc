<cfcomponent>

	<cffunction name="gen_sitemap" description="writes the sitemap xml" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" default="Aspen10">
		<cfargument name="Dealer_ID" default="true">

		<cfquery datasource="#arguments.DSN#" name="Get_Dealers">
			SELECT DISTINCT		Dealer_ID
			FROM         		Navigation
			<!---If Dealer ID is passed in, just generate for this dealer - otherwise generate for all dealers--->
			<cfif arguments.Dealer_ID neq 0>
				WHERE			Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Dealer_ID#" maxlength="6">
			</cfif>
			ORDER BY 			Dealer_ID
		</cfquery>
	
		<cfif Get_Dealers.Recordcount gt 0>
			<cfloop query="Get_Dealers">

				<!---Get Dealer Direcvtory--->
				<cfquery datasource="#arguments.DSN#" name="Get_Directory">
					SELECT     	Dealer_Directory
					FROM		Dealers
					WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Dealers.Dealer_ID#" maxlength="6">
				</cfquery>

				<cfstoredproc datasource="#arguments.DSN#" procedure="Get_Primary_URL">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#Get_Dealers.Dealer_ID#" maxlength="100">
					<cfprocresult name = "Get_Primary_URL" resultset="1">
				</cfstoredproc>
	
				<cfset variables.my_directory=Get_Directory.Dealer_Directory>
	
				<!---If the Dealer directory doens't exist yet, don't do anything--->
				<cfif len(trim(variables.my_directory)) gt 0>

					<!---Check to see if the dealer's diretcory has been created--->
					<cfset variables.sitemap_location="E:\inetpub\wwwroot\Aspen10\dealer\#variables.my_directory#">
					<cfdirectory action="list" directory="#variables.sitemap_location#" name="Check_Dir">
	
					<cfif Check_Dir.Recordcount gt 0>

						<li>Generating <a href="http://#lcase(Get_Primary_URL.Dealer_URL)#\dealer\#variables.my_directory#\sitemap.xml" target="_blank">http://#lcase(Get_Primary_URL.Dealer_URL)#\dealer\#variables.my_directory#\sitemap.xml</a></li>
		
						<cffile action="WRITE" file="#variables.sitemap_location#\sitemap.xml" addnewline="Yes" output='<?xml version="1.0" encoding="UTF-8"?>' nameconflict="OVERWRITE">
						<cffile action="APPEND" file="#variables.sitemap_location#\sitemap.xml" addnewline="Yes" output='<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'>

						<cfquery datasource="Aspen10" name="Get_Dealer_Pages">
							SELECT		page_name,
										script_name,
										Dealer_Wordpress_ID,
										Chrome_Model_ID
							FROM		Dealer_Pages
							WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Dealers.Dealer_ID#" maxlength="6">
							AND			script_name <> '/sitemap.cfm'
							AND			script_name not like '/forms/thank_you%'
							AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
							AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
							ORDER BY 	page_name
						</cfquery>

						<cfloop query="Get_Dealer_Pages">
							<cfset Get_Dealer_Pages.script_name=(replace(Get_Dealer_Pages.script_name,"&","&amp;"))>
							<cffile action="APPEND" file="#variables.sitemap_location#\sitemap.xml" addnewline="Yes" output='<url><loc>http://#lcase(Get_Primary_URL.Dealer_URL)##lcase(Get_Dealer_Pages.script_name)#</loc><lastmod>#dateformat(now(),'yyyy-mm-dd')#</lastmod><changefreq>weekly</changefreq></url>'>
						</cfloop>

						<cfquery datasource="Aspen10" name="Get_NV">
							SELECT     	V_Make,
										V_Model,
										Permalink,
										Vin
							FROM		Vehicles
							WHERE		Dealer_ID IN
										(SELECT DISTINCT Share_ID
										FROM          	Dealer_Shares
										WHERE			Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Dealers.Dealer_ID#" maxlength="6">
										AND				New_Used = 'N')
							AND			V_New_Used = 'N'
						</cfquery>

						<cfif len(trim(Get_NV.Permalink)) gt 0>
							<cfloop query="Get_NV">
								<cfset Get_NV.V_Make=(replace(Get_NV.V_Make,"&","&amp;"))>
								<cfset Get_NV.V_Model=(replace(Get_NV.V_Model,"&","&amp;"))>
								<cfset Get_NV.Permalink=(replace(Get_NV.Permalink,"&","&amp;"))>
								<cffile action="APPEND" file="#variables.sitemap_location#\sitemap.xml" addnewline="Yes" output='<url><loc>http://#lcase(Get_Primary_URL.Dealer_URL)#/vehicles/#lcase(Get_NV.V_Make)#/#lcase(Get_NV.V_Model)#/#lcase(Get_NV.Permalink)#</loc><lastmod>#dateformat(now(),'yyyy-mm-dd')#</lastmod><changefreq>weekly</changefreq></url>'>
							</cfloop>
						</cfif>

						<cfquery datasource="Aspen10" name="Get_UV">
							SELECT     	V_Make,
										V_Model,
										Permalink,
										Vin
							FROM		Vehicles
							WHERE		Dealer_ID IN
										(SELECT DISTINCT Share_ID
										FROM          	Dealer_Shares
										WHERE			Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Dealers.Dealer_ID#" maxlength="6">
										AND				New_Used = 'U')
							AND			V_New_Used = 'U'
						</cfquery>

						<cfif len(trim(Get_UV.Permalink)) gt 0>
							<cfloop query="Get_UV">
								<cfset Get_UV.V_Make=(replace(Get_UV.V_Make,"&","&amp;"))>
								<cfset Get_UV.V_Model=(replace(Get_UV.V_Model,"&","&amp;"))>
								<cfset Get_UV.Permalink=(replace(Get_UV.Permalink,"&","&amp;"))>
								<cffile action="APPEND" file="#variables.sitemap_location#\sitemap.xml" addnewline="Yes" output='<url><loc>http://#lcase(Get_Primary_URL.Dealer_URL)#/vehicles/#lcase(Get_UV.V_Make)#/#lcase(Get_UV.V_Model)#/#lcase(Get_UV.Permalink)#</loc><lastmod>#dateformat(now(),'yyyy-mm-dd')#</lastmod><changefreq>weekly</changefreq></url>'>
							</cfloop>
						</cfif>
						
						<cffile action="APPEND" file="#variables.sitemap_location#\sitemap.xml" addnewline="Yes" output='</urlset>'>

					</cfif>
	
				</cfif>
	
			</cfloop>
		</cfif>
	
	</cffunction>

</cfcomponent>