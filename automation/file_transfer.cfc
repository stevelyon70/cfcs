<!--- cfcomponent that writes a bat file to trasfer a file from one server to another. MK - 4/28/2012 --->

<!--- dev params --->
<!--- <cfset attributes.bat_file="E:\Inetpub\wwwroot\Matchbox\sandbox\Mike\inventory\test.bat">
<cfset attributes.source="E:\Inetpub\wwwroot\Matchbox\sandbox\Mike\inventory\moo.txt">
<cfset attributes.destination="\\Wdsql4\Imports"> --->

<cfcomponent>
	
	<cffunction name="transfer" description="transfer files" output="Yes" access="public">
	
		<!--- required arguments --->
		<cfargument name="bat_file" required="yes">
		<cfargument name="source" required="yes">
		<cfargument name="destination" required="yes">
		<cfset variables.sArg = "/U Worlddealer\administrator /P op71mu5Pr1m3!">
		
		<li>Creating #arguments.bat_file#</li>
		<cffile action="write" file="#arguments.bat_file#" output="" addnewline="No">
		<li>#arguments.bat_file# Created</li>
		<li>Adding #arguments.source# to #arguments.bat_file#</li>
		<cffile action="append" file="#arguments.bat_file#" output="xcopy #arguments.source# #arguments.destination# /E /Y /D" addnewline="No">
		<li>#arguments.source# Added to #arguments.bat_file#</li>
		<li>Attempting to Copy #arguments.source# to #arguments.destination#</li><br/><br/>
		<cftry>
			<cfexecute name = "#arguments.bat_file#" timeout = "60" arguments="#variables.sArg#"></cfexecute>
			<cfcatch>
				<cfset variables.file_error=1>
				<li>File Copy Timed Out</li>
				<cfmail to="mikekosior@worlddealer.net" from="messages@worlddealer.net" subject="ERROR: Photo File Copy Timed Out">
					File copy to #arguments.bat_file# server timed out.
				</cfmail>
			</cfcatch>
		</cftry>
		<br/><br/>
		<li>#arguments.source# Sucessfully Copied to #arguments.destination#</li>
		
		<!--- Test Variables
		#attributes.bat_file#<br/>
		#attributes.source#<br/>
		#attributes.destination#<br/> --->

	</cffunction>

</cfcomponent>
