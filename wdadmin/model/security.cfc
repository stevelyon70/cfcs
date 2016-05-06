<cfcomponent>
	<cffunction name="isModAuth" access="public" returntype="boolean">
		<cfargument name="module" type="string" default="/">
        <cfargument name="moduleID" type="numeric" default="-1">
        
			<cfquery name="getAuth" datasource="#application.dsn#" dbtype="ODBC" result="r1">
                SELECT     dbo.wdAdminModules.module
				FROM         dbo.wdAdminRoles INNER JOIN
                      dbo.Admin_Users INNER JOIN
                      dbo.wdAdminUserRoleXref ON dbo.Admin_Users.User_ID = dbo.wdAdminUserRoleXref.userID ON 
                      dbo.wdAdminRoles.wdAdminRoleID = dbo.wdAdminUserRoleXref.roleID INNER JOIN
                      dbo.wdAdminModules INNER JOIN
                      dbo.wdAdminRoleModXref ON dbo.wdAdminModules.wdModuleID = dbo.wdAdminRoleModXref.modID ON 
                      dbo.wdAdminRoles.wdAdminRoleID = dbo.wdAdminRoleModXref.roleID
                 WHERE 0=0
                 <cfif arguments.moduleID neq -1>
                 	AND dbo.wdAdminModules.wdModuleID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.moduleID#">
                 <cfelse>
                 	AND dbo.wdAdminModules.module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
                 </cfif>
                 AND dbo.Admin_Users.User_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">       
                 AND wdAdminRoles.active =<cfqueryparam cfsqltype="cf_sql_bit" value="1">
                 AND wdAdminModules.active = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
                 AND Admin_Users.active = <cfqueryparam cfsqltype="cf_sql_integer" value="-1">               
            </cfquery>      
         <cfset variables.auth = false>  
   		<cfif getAuth.recordcount>
	        <cfset variables.auth = true>        
        </cfif>	   
		<cfreturn variables.auth>
	</cffunction>
    
    <cffunction name="getAllRoles" access="public" returntype="query">
    	<cfquery name="qRoles" datasource="#application.dsn#" dbtype="ODBC">
            SELECT  [wdAdminRoleID],[roleTitle],[roleDescr],[active]
            FROM         dbo.wdAdminRoles
             WHERE 0=0                   
             	AND wdAdminRoles.active =<cfqueryparam cfsqltype="cf_sql_bit" value="1">             
        </cfquery>           		
		<cfreturn qRoles>
    </cffunction>
    
    <cffunction name="setUserRole" access="public" returntype="void">    
		<cfargument name="userID" type="numeric" default="0">
		<cfargument name="roleID" type="numeric" default="0">
    	<cfquery datasource="#application.dsn#" dbtype="ODBC">
             DELETE 
             FROM wdAdminUserRoleXref
             WHERE 0=0                   
             	AND userID =<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userID#">             
        </cfquery>   
    	<cfquery datasource="#application.dsn#" dbtype="ODBC">
             insert into wdAdminUserRoleXref
             (userID, roleID)
             values
             (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userID#">,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roleID#">)
        </cfquery>   	
    </cffunction>
    
</cfcomponent>