<cfcomponent>

	<cffunction name="vin" description="search results page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="click_dir" required="true"/>
		<cfargument name="vin" required="true"/>
		<cfargument name="description" required="true"/>
		
		<cfif cgi.HTTP_USER_AGENT does not contain "bot">
		
			<cfparam name="variables.write_file" default="no">
	
			<cftry>
			
				<cffile action="READ" file="#arguments.click_dir#\#url.vin#\#dateformat(now(),'yyyymmdd')#.txt" variable="check_count">
			
				<cfcatch><cfset variables.write_file="Yes"></cfcatch>
			
			</cftry>
			
			<cfif variables.write_file eq "Yes">
			
				<!---Check to see if the vehicle data directory exists--->
				<cfdirectory action="list" directory="#arguments.click_dir#\#arguments.vin#" name="check_dir" >
			
				<cfif check_dir.Recordcount eq 0>
					<!---If not - create it--->
					<cftry>
						<cfdirectory action="create" directory="#arguments.click_dir#\#arguments.vin#" >
						<cfcatch></cfcatch>
					</cftry>
				</cfif>
			
				<cffile action="WRITE" file="#arguments.click_dir#\#arguments.vin#\#dateformat(now(),'yyyymmdd')#.txt" output="1">
			
			<cfelse>
				<cffile action="WRITE" file="#arguments.click_dir#\#arguments.vin#\#dateformat(now(),'yyyymmdd')#.txt" output="#check_count+1#">
			</cfif>
	
			<cfparam name="variables.write_desc" default="no">
	
			<cftry>
			
				<cffile action="READ" file="#arguments.click_dir#\#url.vin#\desc.txt" variable="check_count">
			
				<cfcatch><cfset variables.write_desc="Yes"></cfcatch>
			
			</cftry>
	
			<cfif variables.write_desc eq "Yes">
			
				<cffile action="WRITE" file="#arguments.click_dir#\#arguments.vin#\desc.txt" output="#arguments.description#">
			
			</cfif>
			
		</cfif>
		
	</cffunction>

	<cffunction name="dealer" description="search results page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="click_dir" required="true"/>
		<cfargument name="dealer_id" required="true"/>

		<cfif cgi.HTTP_USER_AGENT does not contain "bot">
		
			<cfparam name="variables.write_file" default="no">
	
			<cftry>
			
				<cffile action="READ" file="#arguments.click_dir#\#url.dealer_id#\#dateformat(now(),'yyyymmdd')#.txt" variable="check_count">
			
				<cfcatch><cfset variables.write_file="Yes"></cfcatch>
			
			</cftry>
			
			<cfif variables.write_file eq "Yes">
			
				<!---Check to see if the vehicle data directory exists--->
				<cfdirectory action="list" directory="#arguments.click_dir#\#arguments.dealer_id#" name="check_dir" >
			
				<cfif check_dir.Recordcount eq 0>
					<!---If not - create it--->
					<cftry>
						<cfdirectory action="create" directory="#arguments.click_dir#\#arguments.dealer_id#" >
						<cfcatch></cfcatch>
					</cftry>
					
				</cfif>
			
				<cffile action="WRITE" file="#arguments.click_dir#\#arguments.dealer_id#\#dateformat(now(),'yyyymmdd')#.txt" output="1">
			
			<cfelse>
				<cffile action="WRITE" file="#arguments.click_dir#\#arguments.dealer_id#\#dateformat(now(),'yyyymmdd')#.txt" output="#check_count+1#">
			</cfif>
		
		</cfif>
		
	</cffunction>
	
</cfcomponent>