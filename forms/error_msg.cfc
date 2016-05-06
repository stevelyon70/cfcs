<cfcomponent>

	<cffunction name="form_errors" description="shows errors from form submission" output="Yes" access="public">

		<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
			<cfinvokeargument name="error_message" value="#url.error_message#"/>
		</cfinvoke>
		<br/>
		<a href="javascript:window.history.back()" class="btn btn-primary"><i class="glyphicon glyphicon-arrow-left"></i> Go Back</a>
		<br/><br/>

	</cffunction>

</cfcomponent>