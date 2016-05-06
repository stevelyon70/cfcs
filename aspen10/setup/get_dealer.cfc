<cfcomponent>

	<cffunction name="get_dir" description="get the asset directory associated with an url" output="yes" access="public" returntype="query">

		<!--- arguments --->
		<cfargument name="server_name" required="true">
		<cfargument name="dsn" required="true">

		<cfset variables.eval_name=replace(arguments.server_name,"www.","")>

		<cfif 	left(REMOTE_ADDR,7) eq "10.0.0." or
				left(REMOTE_ADDR,10) eq "172.16.25." or
				left(REMOTE_ADDR,9) eq "70.192.13" or
				left(REMOTE_ADDR,10) eq "66.179.17.">
			<cfset variables.my_cache=createTimeSpan( 0, 0, 0, 0 )>
		<cfelse>
			<cfset variables.my_cache=createTimeSpan( 0, 0, 3, 0 )>
		</cfif>

		<cfquery datasource="Aspen10" name="Get_Urls" cachedWithin="#variables.my_cache#">
			SELECT		Dealer_URLs.Dealer_ID,
						Dealer_URLs.URL_Type,
						Dealer_URLs.template_id,
						Dealer_URLs.dealer_template_id,
						Dealer_URLs.header_cols,
						Dealers.Dealer_Directory
			FROM		Dealer_URLs
			INNER JOIN	Dealers
			ON			Dealer_URLs.Dealer_ID = Dealers.Dealer_ID
			WHERE		Dealer_URL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.eval_name#" maxlength="100">
			AND			Dealers.Active = 1
		</cfquery>
		
		<!--- Stored proceedure commented out because they can't be cached.
			<cfstoredproc datasource="Ultra10" procedure="Get_Urls" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@val_name" value="#variables.eval_name#" maxlength="100">
				<cfprocresult name = "Get_Urls" resultset="1">
			</cfstoredproc>
		--->

		<!---No result - stop page processing--->
		<cfif Get_Urls.Recordcount eq 0>a10 Bad Url<cfabort></cfif>

		

		<cfquery datasource="Aspen10" name="Get_Primary_URL">
			SELECT		TOP 1
						Dealer_URL,
						Url_Type
			FROM		Dealer_URLs
			WHERE		(Dealer_ID = #Get_Urls.dealer_id#)
			AND			(URL_Type = 1 OR URL_Type = 5 OR URL_Type = 3)
			ORDER BY	URL_Type
		</cfquery>

		
		
		<!--- 
		<cfstoredproc datasource="#arguments.DSN#" procedure="Get_Primary_URL">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#Get_Urls.Dealer_ID#" maxlength="100">
			<cfprocresult name = "Get_Primary_URL" resultset="1">
		</cfstoredproc> --->

		<cfswitch expression="#Get_Primary_URL.Url_Type#">
			<cfcase value="1">
				<cfset variables.my_url="http://#Get_Primary_URL.Dealer_URL#">
				<cfif lcase(cgi.script_name) neq "/index.cfm">
					<cfset variables.my_url="http://#Get_Primary_URL.Dealer_URL##cgi.script_name#">
				</cfif>
				<cfif len(trim(cgi.query_string)) gt 0><cfset variables.my_url=variables.my_url & "?#cgi.query_string#"></cfif>
			</cfcase>
			<cfcase value="5">
				<cfset variables.my_url="http://www.#Get_Primary_URL.Dealer_URL#">
				<cfif lcase(cgi.script_name) neq "/index.cfm">
					<cfset variables.my_url="http://www.#Get_Primary_URL.Dealer_URL##cgi.script_name#">
				</cfif>
				<cfif len(trim(cgi.query_string)) gt 0><cfset variables.my_url=variables.my_url & "?#cgi.query_string#"></cfif>
			</cfcase>
		</cfswitch>
		
		<cfswitch expression="#Get_Urls.Url_Type#">
			<cfcase value="1">
				<cfif arguments.server_name neq Get_Primary_URL.Dealer_URL>
					<cflocation url="#lcase(variables.my_url)#" statuscode="301" addtoken="no">
				</cfif>
			</cfcase>
			<cfcase value="2">
				<cflocation url="#lcase(variables.my_url)#" statuscode="301" addtoken="no">
			</cfcase> 
			<!--- <cfcase value="5">
				<cfif left(variables.eval_name,4) neq "www.">
					<cflocation url="#lcase(variables.my_url)#" statuscode="301">
				</cfif>
			</cfcase> --->
		</cfswitch>

		<cfreturn Get_Urls>

	</cffunction>

</cfcomponent>