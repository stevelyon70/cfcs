<cfcomponent >
	<cffunction name="init">
    	<cfset VARIABLES.securityObj = new cfcs.wdadmin.model.security()>
    </cffunction>

	<cffunction name="getRolebyID" access="public" returntype="query">
		<cfargument name="userID" required="yes" type="numeric">        
		<cfquery datasource="#application.dsn#" name="myResult">
            SELECT    Admin_Users.email, Admin_Users.user_type, Admin_Users.user_id, Admin_Users.dealer_id, wdAdminRoles.roleTitle
			FROM         Ultra10.dbo.wdAdminRoles INNER JOIN
                      Ultra10.dbo.Admin_Users INNER JOIN
                      Ultra10.dbo.wdAdminUserRoleXref ON Ultra10.dbo.Admin_Users.User_ID = Ultra10.dbo.wdAdminUserRoleXref.userID ON 
                      Ultra10.dbo.wdAdminRoles.wdAdminRoleID = Ultra10.dbo.wdAdminUserRoleXref.roleID  
            WHERE Admin_Users.user_id = #arguments.userID#       
        </cfquery>
		<cfreturn myResult>
	</cffunction>
    
    <cffunction name="getRoleIDbyUserID" access="public" returntype="numeric">
		<cfargument name="userID" required="yes" type="numeric">        
		<cfquery datasource="#application.dsn#" name="myResult">
            SELECT    wdAdminRoles.wdAdminRoleID
			FROM         Ultra10.dbo.wdAdminRoles INNER JOIN
                      Ultra10.dbo.Admin_Users INNER JOIN
                      Ultra10.dbo.wdAdminUserRoleXref ON Ultra10.dbo.Admin_Users.User_ID = Ultra10.dbo.wdAdminUserRoleXref.userID ON 
                      Ultra10.dbo.wdAdminRoles.wdAdminRoleID = Ultra10.dbo.wdAdminUserRoleXref.roleID  
            WHERE Admin_Users.user_id = #arguments.userID#       
        </cfquery>
		<cfreturn numberformat(myResult.wdAdminRoleID, "0")>
	</cffunction>
    
    <cffunction name="getActiveUsers" access="public" returntype="query">
   		<cfquery datasource="#application.dsn#" name="myResult">
            SELECT    Admin_Users.*
			FROM      Ultra10.dbo.Admin_Users  
            WHERE Admin_Users.active = <cfqueryparam cfsqltype="cf_sql_integer" value="-1">
        </cfquery>
		<cfreturn myResult>    
    </cffunction>
    
    <cffunction name="getUserById" access="public" returntype="query">
		<cfargument name="userID" required="yes" type="numeric">       
   		<cfquery datasource="#application.dsn#" name="myResult">
            SELECT    Admin_Users.*
			FROM      Ultra10.dbo.Admin_Users  
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userID#"> 
            	AND Admin_Users.active = <cfqueryparam cfsqltype="cf_sql_integer" value="-1">
        </cfquery>
        <cfreturn myResult>
    </cffunction>
    
     <cffunction name="setUserInactive" access="public" returntype="void">
		<cfargument name="userID" required="yes" type="numeric">       
   		<cfquery datasource="#application.dsn#" name="myResult">
            UPDATE  Ultra10.dbo.Admin_Users  
            set active = 0
            WHERE Admin_Users.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userID#">
        </cfquery>
    </cffunction>
    
    <cffunction name="updateUserByID" access="public" returntype="void">
		<cfargument name="formFields" required="yes" type="struct">
        <!--- insert default roles and dealer if not supplied--->
        <cfif isdefined("arguments.formFields.userID")>   
        <cfset variables.userID = arguments.formFields.userID>            
            <cfquery datasource="#application.dsn#" name="myResult">
                Update  Admin_Users  
                set [Firstname] = '#arguments.formFields.firstname#'
                  ,[Lastname] = '#arguments.formFields.lastname#'
                  ,[Phone] = '#arguments.formFields.phone#'
                  ,[Email] = '#arguments.formFields.email#'
                  ,[Pwd] = '#arguments.formFields.pwd#'
                  ,[Dealer_ID] = '#arguments.formFields.dealer_id#'            
                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.formFields.userID#">             
            </cfquery>   
		<cfelse>
        	<cfquery datasource="#application.dsn#">
            	insert into Admin_Users
                (firstname, lastname,phone,email,pwd,dealer_id, user_type, active)
                values
                ('#arguments.formFields.firstname#','#arguments.formFields.lastname#',
                	'#arguments.formFields.phone#','#arguments.formFields.email#',
                   '#arguments.formFields.pwd#','#arguments.formFields.dealer_id#',0,-1 )
             </cfquery>
             <cfquery datasource="#application.dsn#" name="userIDMax">
             	select max(user_id) as maxid
                from Admin_Users
             </cfquery>
             <cfset variables.userID = userIDMax.maxid>      
        </cfif>        
        <cfset  VARIABLES.securityObj.setUserRole(variables.userID,#arguments.formFields.roles#)>        
    </cffunction>    
    
    <cffunction name="sendCredentialEmailById" access="public" output="no" returntype="void">
    	<cfargument name="userID" required="yes" type="numeric"> 
        <cfset qUser = this.getUserById(arguments.userID)>
        
        <cfmail to="#qUser.email#" from="noreplay@worlddealer.net" type="html" subject="Credentials">
        	This email includes your login credentials for the <a href="http://ultra10.wddemos.com/wdadmin/index.cfm">world dealer administrator</a>.<br/><br/>
            
            username : #qUser.email#<br/><br/>
            password : #qUser.pwd#<br/><br/>
            
            #now()#
        </cfmail>
        
    </cffunction>
</cfcomponent>