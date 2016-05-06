<cfcomponent>

	<cffunction name="default" description="default icon display" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="nav_type_id" required="true">
		<cfargument name="icon_ceiling" default="">
		<cfargument name="img_class" default="img-responsive">
		<cfargument name="txt_class" default="">

		<!---Get Nav--->
		<cfstoredproc datasource="Automall" procedure="Get_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="2">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="#arguments.nav_type_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@now_date" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>
		
		<cfif len(trim(arguments.icon_ceiling)) gt 0>
			<cfset variables.ceiling=arguments.icon_ceiling>
		<cfelse>
			<cfset variables.ceiling=Get_Nav.Recordcount>
		</cfif>

		<cfloop query="Get_Nav" endrow="#variables.ceiling#">

			<cfif Get_Nav.Nav_Link eq "index.cfm">
				<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
			<cfelse>
				<cfif left(Get_Nav.Nav_Link,4) neq "http">
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
				</cfif>
			</cfif>
			<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
				<cfif Get_Nav.Nav_Mobile_Link eq "index.cfm">
					<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Mobile_Link,4) neq "http">
						<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Mobile_Link#">
					</cfif>
				</cfif>
			</cfif>

			<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
				<cfcase value="1">
					<cfif len(trim(Get_Nav.Nav_Mobile_Link)) eq 0>
						<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
							<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/></a>
						<cfelse>
							<a class="#arguments.txt_class#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
						</cfif>
					<cfelse>
						<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
							<a class="visible-md visible-lg" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/></a>
							<a class="visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/></a>
						<cfelse>
							<a class="visible-md visible-lg #arguments.txt_class#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
							<a class="visible-sm visible-xs #arguments.txt_class#" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="2">
					<cfif len(trim(Get_Nav.Nav_Mobile_Link)) eq 0>
						<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
							<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/></a>
						<cfelse>
							<a class="#arguments.txt_class#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
						</cfif>
					<cfelse>
						<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
							<a class="visible-md visible-lg" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/></a>
							<a class="visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/></a>
						<cfelse>
							<a class="visible-md visible-lg #arguments.txt_class#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
							<a class="visible-sm visible-xs #arguments.txt_class#" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
						</cfif>
					</cfif>								
				</cfcase>
				<cfcase value="3">
					<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
						<img class="#arguments.img_class#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icons/#Get_Nav.Nav_Image#" alt="#Get_Nav.Nav_Alt#" title="#Get_Nav.Nav_Alt#"/>
					<cfelse>
						<div class="#arguments.txt_class#-none">#Get_Nav.Nav_Name#</div>
					</cfif>
				</cfcase>
			</cfswitch>

		</cfloop>
	
	</cffunction>

</cfcomponent>