<cfcomponent >
	<cffunction name="getRolebyID" access="public" returntype="query">
		<cfargument name="userID" required="yes" type="numeric">        
		<cfquery datasource="#application.dsn#" name="myResult">
            SELECT ut.User_Type_Description, u.email, u.user_type, u.user_id, u.firstname, u.lastname
            FROM [Ultra10].[dbo].[Admin_User_Types] as ut, [Ultra10].[dbo].[Admin_Users] as u
            WHERE u.user_id = #arguments.userID# 
                AND u.User_Type = ut.User_Type_ID                 
        </cfquery>
		<cfreturn myResult>
	</cffunction>
</cfcomponent>