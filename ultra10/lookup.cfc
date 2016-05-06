<cfcomponent>

	<cffunction name="get_nav" description="get site navigation" output="yes" access="public" returntype="query">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">

		<cfif 	left(REMOTE_ADDR,7) eq "10.0.0." or
				left(REMOTE_ADDR,10) eq "172.16.25." or
				left(REMOTE_ADDR,9) eq "70.192.13" or
				left(REMOTE_ADDR,10) eq "66.179.17.">
			<cfset variables.my_cache=createTimeSpan( 0, 0, 0, 0 )>
		<cfelse>
			<cfset variables.my_cache=createTimeSpan( 0, 0, 3, 0 )>
		</cfif>
		<cfquery datasource="#arguments.DSN#" name="Get_Nav" cachedWithin="#variables.my_cache#">
			SELECT		Nav_ID,
						Nav_Name,
						Nav_Alt,
						Nav_Link,
						Nav_Mobile_Link,
						Snippet,
						Pull,
						Align,
						Text_Color,
						Font_Family,
						Font_Weight,
						Font_Size,
						Margin_Left,
						Margin_Right,
						Margin_Top,
						Margin_Bottom,
						Nav_Image,
						Nav_Rollover,
						Nav_Behaviour_ID,
						Nav_Type_ID,
						Parent_Nav_ID,
						Phone_ID,
						Width,
						Height,
						Script_Name,
						Nav_Image_Code,
						Robot_Food,
						hierarchy,					<!--- added 12/31/2015 bob --->
                        displayPage
			FROM		Navigation
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="10">
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			ORDER BY 	Nav_Type_ID, Hierarchy
		</cfquery>

		<cfreturn Get_Nav>

	</cffunction>

	<cffunction name="get_phones" description="get phones" output="yes" access="public" returntype="query">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">

		<cfquery datasource="#arguments.DSN#" name="Get_Phones"  cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
				SELECT		Phone_ID,
							Phone_Label,
							Area_Code,
							Prefix,
							Line_Number,
							Vanity_Number,
							Dealer_Dept_ID
				FROM		Dealer_Phones
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
				ORDER BY 	Hierarchy
		</cfquery>

		<cfreturn Get_Phones>

	</cffunction>

</cfcomponent>