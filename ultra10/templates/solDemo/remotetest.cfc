<cfcomponent>
	<cffunction name="myFunction" access="remote" returntype="any">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>
</cfcomponent>