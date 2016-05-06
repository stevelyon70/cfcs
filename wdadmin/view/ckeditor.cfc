<cfcomponent>
	<cffunction name="textareaForm" access="public" returntype="void" output="yes">
		<cfargument name="_height" type="string" required="yes">
        <cfargument name="_id" type="string" required="yes">
        <cfargument name="_name" type="string" required="yes">
        <cfargument name="_toolbar" type="string" required="yes">
        <cfargument name="_height" type="string" required="yes">
        <cfargument name="_content" type="string" required="yes">
        
		
        <cftextarea class="form-control" height="#arguments._height#" id="#arguments._id#" name="#arguments._name#" richtext="yes" toolbar="#arguments._toolbar#">
			<cfoutput>#arguments._content#</cfoutput>
        </cftextarea>
        
	</cffunction>
</cfcomponent>