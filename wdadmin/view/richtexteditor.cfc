<cfcomponent>
	<cffunction name="rteFieldInstance" access="public" returntype="string">
		<cfargument name="class" type="string" required="no" default="form-control">
		<cfargument name="rows" type="string" required="no" default="5">
		<cfargument name="id" type="string" required="no" default="instance1">
		<cfargument name="name" type="string" required="no" default="instance1">
		<cfargument name="toolbar" type="string" required="no" default="Basic">
		<cfargument name="value" type="string" required="no" default="">
		<cfsavecontent variable="c1">
		<cftextarea class="#arguments.class#" rows="#arguments.rows#" id="#arguments.id#" name="#arguments.name#" richtext="yes" toolbar="#arguments.toolbar#">
			<cfoutput>#arguments.value#</cfoutput>
        </cftextarea>
        </cfsavecontent>
        <cfreturn c1>
   	</cffunction>
</cfcomponent>