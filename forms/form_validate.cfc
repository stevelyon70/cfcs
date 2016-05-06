<cfcomponent>

	<cffunction name="text_area" description="Server Side Validation of text areas" output="no" access="public">

		<!---arguments--->
		<cfargument name="text_name" required="yes">
		<cfargument name="text_value" required="yes">
		<cfargument name="text_name_2" default="">
		<cfargument name="text_value_2" default="">
		<cfargument name="error_message" required="yes">
		<cfargument name="text_req" default="false">
		<cfargument name="check_email" default="false">
		<cfargument name="check_phone" default="false">
		<cfargument name="check_name" default="false">
		
		<cfif arguments.text_name eq arguments.text_value><cfset arguments.text_value=""></cfif>

		<!---Compare First and Last Names--->
		<cfif arguments.check_name eq "true">
			<cfif arguments.text_value eq arguments.text_value_2>
				<cfset arguments.error_message=listappend(arguments.error_message,"#arguments.text_name# and #arguments.text_name_2# cannot be the same.")>
			</cfif>
		</cfif>
		
		<!--- universal validation --->
		<cfif arguments.text_req eq "true">
			<cfif len(trim(arguments.text_value)) eq 0>
				<cfset arguments.error_message=listappend(arguments.error_message,"#arguments.text_name# cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.text_value)) gt 0>
			<cfif REFind("<[^>]*>", arguments.text_value) neq 0 or arguments.text_value contains "http">
				<cfset arguments.error_message=listappend(arguments.error_message,"Please do not include ANY code&##44; email addresses or links in your #arguments.text_name#.")>
			</cfif>
		</cfif>

		<!---Validate an email address--->
		<cfif arguments.check_email eq "true">
			<cfif arguments.text_req eq "true">
				<cfif isvalid("email",arguments.text_value) eq "No">
					<cfset arguments.error_message=listappend(arguments.error_message,"Invalid #arguments.text_name#.")>
				</cfif>
			</cfif>
		</cfif>

		<!---Validate a phone number--->
		<cfif arguments.check_phone eq "true">
			<cfif arguments.text_req eq "true">
				<cfset arguments.text_value=rereplace(arguments.text_value, "[^\w]", "", "all")>
				<cfset arguments.text_value="#left(arguments.text_value,3)#-#mid(arguments.text_value,4,3)#-#right(arguments.text_value,4)#">
				<cfif isvalid("telephone" ,arguments.text_value) eq "No">
					<cfset arguments.error_message=listappend(arguments.error_message,"Invalid #arguments.text_name#.")>
				</cfif>
			</cfif>
		</cfif>

		<cfreturn arguments.error_message>
		
	</cffunction>

	<cffunction name="integer" description="Server Side Validation of integers" output="no" access="public">
		
		<!---arguments--->
		<cfargument name="int_name" required="yes">
		<cfargument name="int_value" required="yes">
		<cfargument name="error_message" required="yes">
		<cfargument name="int_req" default="false">
		<cfargument name="int_error_msg" default="Invalid #arguments.int_name#.">

		<!---Validate an Integer--->
		<cfif arguments.int_req eq "true">
			<cfif isvalid("integer" ,arguments.int_value) eq "No">
				<cfset arguments.error_message=listappend(arguments.error_message,"#arguments.int_error_msg#")>
			</cfif>
		</cfif>
		
		<cfreturn arguments.error_message>
			
	</cffunction>	
	
	<cffunction name="display_error" description="Displays Server Side Validation Error Messages" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="error_message" required="true">

		<cfloop list="#arguments.error_message#" index="i">
			<li class="form-errors-list">#variables.i#</li>
		</cfloop>
		
	</cffunction>

</cfcomponent>