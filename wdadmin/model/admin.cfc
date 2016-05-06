<cfcomponent>
	<cffunction name="getActiveRoles" access="public" returntype="query">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminRoles
            where active = <cfqueryparam cfsqltype="cf_sql_bit" value="true"> 
        </cfquery>		
		<cfreturn myResult>
	</cffunction>
    <cffunction name="getAllRoles" access="public" returntype="query">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminRoles
        </cfquery>		
		<cfreturn myResult>
	</cffunction>
    <cffunction name="getActiveModules" access="public" returntype="query">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminModules
            where active = <cfqueryparam cfsqltype="cf_sql_bit" value="true"> 
        </cfquery>		
		<cfreturn myResult>
	</cffunction>
    <cffunction name="getAllModules" access="public" returntype="query">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminModules 
            order by modName
        </cfquery>		
		<cfreturn myResult>
	</cffunction>
     <cffunction name="isModInRole" access="public" returntype="numeric">     
	    <cfargument name="roleID" default="0">        
	    <cfargument name="modID" default="0">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminRoleModXref
            where roleId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roleId#"> 
            and modId= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.modId#"> 
        </cfquery>		
		<cfreturn myResult.recordcount>
	</cffunction>
    
    <cffunction name="getActiveModulesByRole" access="public" returntype="query">
	    <cfargument name="roleID" default="0">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminModules AS m, wdAdminRoles AS r, wdAdminRoleModXref AS x            
            where m.wdModuleID = x.modID
	            and x.roleID = r.wdAdminRoleID            
    	        and m.active = <cfqueryparam cfsqltype="cf_sql_bit" value="true"> 
        </cfquery>		
		<cfreturn myResult>
	</cffunction>
    <cffunction name="getRoleById" access="public" returntype="query">
	    <cfargument name="roleID" default="0">    
		<cfquery datasource="#application.dsn#" name="myResult">
        	select *
            from wdAdminRoles
            where wdAdminRoleId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roleID#"> 
        </cfquery>		
		<cfreturn myResult>
	</cffunction>
    <cffunction name="updateRoleByID" access="public" returntype="void">
	    <cfargument name="_form" default="">
        <cfparam name="arguments._form.active" default="0">
        <cfif arguments._form.roleId>
        <cfquery datasource="#application.dsn#" name="myResult">
        	update wdAdminRoles 
            set roleTitle='#arguments._form.roleTitle#',
            roleDescr='#arguments._form.roleDescr#',
            active=#arguments._form.active#
            where wdAdminRoleId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments._form.roleID#"> 
        </cfquery>	
        <cfquery datasource="#application.dsn#" name="myResult">
        	delete
            from wdAdminRoleModXref
            where roleId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments._form.roleID#"> 
        </cfquery>	
        
        <cfloop list="#_form.mods#" index="i">
        <cfquery datasource="#application.dsn#" name="myResult">
        	insert into wdAdminRoleModXref
            (roleId, modID)
            values
            (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments._form.roleID#"> , <cfqueryparam cfsqltype="cf_sql_integer" value="#i#"> )
        </cfquery>	
        </cfloop>
        
        	
        <cfelse>
		<cfquery datasource="#application.dsn#" name="myResult">
        	insert into wdAdminRoles 
            (roleTitle, roleDescr, active)
            values
            ('#arguments._form.roleTitle#', '#arguments._form.roleDescr#', 1)
        </cfquery>		
        </cfif>
        
        
	</cffunction>
    
</cfcomponent>