<cfcomponent>

	<cffunction name="create_folder" description="generates folder" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="server_location" required="true">
		<cfargument name="folder_name" required="true">
		
		<cfdirectory action="list" directory="#arguments.server_location#\#arguments.folder_name#" name="check_dir">
		
		<cfif check_dir.recordcount eq 0>

			<!--- If no directory, Create directory. --->
			<cftry>
				<cfdirectory action="CREATE" directory="#arguments.server_location#\#arguments.folder_name#">
				<cfcatch></cfcatch>
			</cftry>

			<!--- If no directory, Create ph.txt (placeholder) file. --->
			<cftry>
				<cffile action="WRITE" file="#arguments.server_location#\#arguments.folder_name#\ph.txt" addnewline="No" output="#dateformat(now(),'mm/dd/yyyy')# #timeformat(now(),'hh:mm tt')#" nameconflict="OVERWRITE">
				<cfcatch></cfcatch>
			</cftry>
			
		</cfif>

	</cffunction>

	<cffunction name="create_file" description="generates file" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="server_location" required="true">
		<cfargument name="file_name" required="true">
		<cfargument name="file_output" required="true">
		
		<cftry>
			<cffile action="WRITE" file="#arguments.server_location#\#arguments.file_name#" addnewline="No" output="#arguments.file_output#" nameconflict="OVERWRITE">
			<cfcatch><cfdump var="#cfcatch#"></cfcatch>
		</cftry>

	</cffunction>

</cfcomponent>