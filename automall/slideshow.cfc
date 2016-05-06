<cfcomponent>

	<cffunction name="default" description="slideshow" output="Yes" access="public">

		<!---Get Nav--->
		<cfstoredproc datasource="Automall" procedure="Get_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="2">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="3" maxlength="2">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@now_date" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>
	
		<cfif Get_Nav.Recordcount gt 1>
			<cfif Get_Nav.Nav_Link eq "index.cfm">
				<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
			<cfelse>
				<cfif left(Get_Nav.Nav_Link,4) neq "http">
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
				</cfif>
			</cfif>
			<cfif Get_Nav.Nav_Mobile_Link eq "index.cfm">
				<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#">
			<cfelse>
				<cfif left(Get_Nav.Nav_Mobile_Link,4) neq "http">
					<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Mobile_Link#">
				</cfif>
			</cfif>

			<div id="wowslider-container1">
				<div class="ws_images">
					<ul>
						<cfset variables.img_row=0>
						<cfloop query="Get_Nav">
							<cfset variables.img_row=variables.img_row+1>
							<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
								<cfif Get_Nav.Nav_Link eq "index.cfm">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
									</cfif>
								</cfif>
								<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
								<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>
								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1">
										<li>
											<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="max-width" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.img_row-1#"/>
											</a>
										</li>
									</cfcase>
									<cfcase value="2">
										<li>
											<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="max-width" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.img_row-1#"/>
											</a>
										</li>
									</cfcase>
									<cfcase value="3">
										<li>
											<img class="max-width" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.img_row-1#"/>
										</li>
									</cfcase>
								</cfswitch>
							</cfif>
						</cfloop>
					</ul>
				</div>
				<div class="ws_bullets">
					<div>
						<cfset variables.nav_row=0>
						<cfloop query="Get_Nav">
							<cfset variables.nav_row=variables.nav_row+1>
							<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
								<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
								<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>
								<a href="##" title="#variables.img_title#">#variables.nav_row#</a>
							</cfif>
						</cfloop>
					</div>
				</div>
				<div class="ws_shadow"></div>
			</div>

			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/#arguments.automall_name#/engine1/wowslider.js"></script>'>
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/#arguments.automall_name#/engine1/script.js"></script>'>

		<cfelse>

			<cfif Get_Nav.Nav_Link eq "index.cfm">
				<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
			<cfelse>
				<cfif left(Get_Nav.Nav_Link,4) neq "http">
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
				</cfif>
			</cfif>
			<cfif Get_Nav.Nav_Mobile_Link eq "index.cfm">
				<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#">
			<cfelse>
				<cfif left(Get_Nav.Nav_Mobile_Link,4) neq "http">
					<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Mobile_Link#">
				</cfif>
			</cfif>

			<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><img class="max-width" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/slideshow/#Get_Nav.Nav_Image#"/></a>

		</cfif>
		
	</cffunction>

</cfcomponent>