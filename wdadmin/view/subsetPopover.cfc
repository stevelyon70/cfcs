<cfcomponent>
	   
    
    <cffunction name="displayActiveModulesByRole" access="public" returntype="any">
	    <cfargument name="roleID" default="0">
		<cfquery datasource="#application.dsn#" name="myResult">
        	select m.*
            from wdAdminModules AS m, wdAdminRoles AS r, wdAdminRoleModXref AS x            
            where m.wdModuleID = x.modID
	            and x.roleID = r.wdAdminRoleID            
    	        and m.active = <cfqueryparam cfsqltype="cf_sql_bit" value="true"> 
                and x.roleID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.roleID#">
        </cfquery>  
        <cfset results = "<ul>">
           	
        <cfoutput query="myResult">
 	    	<cfset results = results & '<li>' & modName & '</li>'>
        </cfoutput>
        <cfset results = results & '</ul>'>
		<cfreturn results>
	</cffunction>
    
    <cffunction name="displayActiveVehicleSpecsByVin" access="public" returntype="any">
	    <cfargument name="Vin" default="0">
		<cfquery name="vehicles" datasource="#application.dsn#">
            SELECT dealer_id, V_Make, v_model, Vin, V_Trim, V_Year, V_Style, V_Odometer, Exterior_Color, Transmission, Cylinders, Doors, permalink, v_new_used, interior_color, img_urls
            FROM    vehicles
            WHERE vin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Vin#">            
            ORDER BY v_make 
        </cfquery> 
        <cfset results = "<ul>">
           	
        <cfoutput query="vehicles">
 	    	<cfset results = results & '<li>Trim : ' & v_trim & '</li>'>
            <cfset results = results & '<li>Style : ' & replace(V_Style, '"', '') & '</li>'>
            <cfset results = results & '<li>Odometer : ' & V_Odometer & '</li>'>
            <cfset results = results & '<li>Ext Color : ' & Exterior_Color & '</li>'>
            <cfset results = results & '<li>Int Color : ' & interior_color & '</li>'>
            <cfset results = results & '<li>Cylinders : ' & Cylinders & '</li>'>
            <cfset results = results & '<li>Doors : ' & Doors & '</li>'>            
        </cfoutput>
        <cfset results = results & '</ul>'>
		<cfreturn results>
	</cffunction>
    
</cfcomponent>