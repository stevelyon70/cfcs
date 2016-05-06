<cfcomponent>
	<cffunction name="getAllActiveDealers" access="public" returntype="query">
		<cfquery name="qDealers" datasource="#application.dsn#">
        	select *
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    		ORDER BY 	Dealer_Name ASC
        </cfquery>
		<cfreturn qDealers>
	</cffunction>
    <cffunction name="getAllActiveBlogDealers" access="public" returntype="query">
		<cfquery name="qDealers" datasource="#application.dsn#">
        	select *
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
            	and seo_blogs = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    		ORDER BY 	Dealer_Name ASC
        </cfquery>
		<cfreturn qDealers>
	</cffunction>
    <cffunction name="getDealerById" access="public" returntype="query">
    <cfargument name="dealerID" default="0">
		<cfquery name="qDealer" datasource="#application.dsn#">
        	select *
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
          	  and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
   			 ORDER BY 	Dealer_Name ASC
        </cfquery>
		<cfreturn qDealer>
	</cffunction>
    
    <cffunction name="getDealerCodeById" access="public" returntype="string">
    <cfargument name="dealerID" default="0">
		<cfquery name="qDealer" datasource="#application.dsn#">
        	select dealercode
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
          	  and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
        </cfquery>
		<cfreturn qDealer.dealercode>
	</cffunction>
    
    <cffunction name="getDealerDisplayNameById" access="public" returntype="string">
    <cfargument name="dealerID" default="0">
		<cfquery name="qDealer" datasource="#application.dsn#">
        	select display_name
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
          	  and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
   			 ORDER BY 	Dealer_Name ASC
        </cfquery>
		<cfreturn qDealer.display_name>
	</cffunction>
    
    <cffunction name="getDealerURLById" access="public" returntype="string">
    <cfargument name="dealerID" default="0">
		<cfquery name="qDealer" datasource="#application.dsn#">
        	select primary_url
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
          	  and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
   			 ORDER BY 	Dealer_Name ASC
        </cfquery>
		<cfreturn qDealer.primary_url>
	</cffunction>
    
    <cffunction name="getDealerDirectoryById" access="public" returntype="string">
    <cfargument name="dealerID" default="0">
		<cfquery name="qDealer" datasource="#application.dsn#">
        	select dealer_directory
            from dbo.dealers
            where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
          	  and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
   			 ORDER BY 	Dealer_Name ASC
        </cfquery>
		<cfreturn qDealer.dealer_directory>
	</cffunction>
    
    <cffunction name="getDealerUrl" access="public" returntype="query">
    <cfargument name="dealerID" default="0">
    	
        
        <cfquery datasource="#application.dsn#" name="Get_Urls">
			SELECT		Dealer_URLs.Dealer_ID,
						Dealer_URLs.URL_Type,
						Dealer_URLs.template_id,
						Dealer_URLs.dealer_template_id,
						Dealer_URLs.header_cols,
						Dealers.Dealer_Directory
			FROM		Dealer_URLs
			INNER JOIN	Dealers
			ON			Dealer_URLs.Dealer_ID = Dealers.Dealer_ID
			WHERE		Dealer_URLs.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#" maxlength="3">
			AND			Dealers.Active = 1
		</cfquery>
        
        <cfreturn get_urls>
    </cffunction>
    
    <cffunction name="getSecureDealersList" access="public" returntype="query">
    	<cfquery name="q1" datasource="#application.dsn#">
        	SELECT d10.[Dealer_ID],d8.[Dealercode],d8.[Dealer_Name],d8.[Display_Name],d10.Dealer_ID,d10.Primary_URL 
            FROM [Ultra8].[dbo].[Dealers] as d8, ultra10.dbo.dealers as d10  
            where d8.dealercode = d10.dealercode  
            order by d8.Display_Name
        </cfquery>
    	<cfreturn q1>
    
    </cffunction>
    
</cfcomponent>