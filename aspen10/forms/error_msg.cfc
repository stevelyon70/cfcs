<cfcomponent>

	<cffunction name="form_errors" description="shows errors from form submission" output="Yes" access="public">

		<cfinvoke component="/cfcs/aspen10/forms/form_validate" method="display_error">
			<cfinvokeargument name="error_message" value="#url.error_message#"/>
		</cfinvoke>
		<br/>
		<a href="javascript:window.history.back()" class="btn btn-primary"><span style="font-size:14pt;color:blue;font-weight:bold">Go Back</span></a>
		<br/><br/>

	</cffunction>

</cfcomponent>