<cfcomponent>

	<cffunction name="standard" description="shows a standard navbar" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" default="modern">

		<!---Get Nav--->
		<cfstoredproc datasource="Automall" procedure="Get_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="2">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="1" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@now_date" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>

		<cfif cgi.http_user_agent contains "MSIE 8.0" or cgi.http_user_agent contains "MSIE 7.0" or cgi.http_user_agent contains "MSIE 6.0">
			<cfset arguments.site_mode="legacy">
		</cfif>

		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				<nav class="navbar navbar-default site-nav" role="navigation">
					<div class="container">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##main-nav">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>
						<div class="collapse navbar-collapse" id="main-nav">
							<ul class="nav navbar-nav">
								<cfloop query="Get_Nav">
			
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
			
									<cfif Get_Nav.Nav_Link contains "?">
										<cfset Get_Nav.Nav_Link="#Get_Nav.Nav_Link#&zip=#cookie.savezip#">
									<cfelse>
										<cfset Get_Nav.Nav_Link="#Get_Nav.Nav_Link#?zip=#cookie.savezip#">
									</cfif>
				
									<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
										<cfcase value="1">
											<cfif len(trim(Get_Nav.Nav_Mobile_Link)) eq 0>
												<li><a class="nav-basic" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>								
											<cfelse>
												<li class="visible-md visible-lg"><a class="nav-basic" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
												<li class="visible-xs visible-sm"><a class="nav-basic" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>
											</cfif>
										</cfcase>
										<cfcase value="2">
											<cfif len(trim(Get_Nav.Nav_Mobile_Link)) eq 0>
												<li><a class="nav-basic" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
											<cfelse>
												<li class="visible-md visible-lg"><a class="nav-basic" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>
												<li class="visible-xs visible-sm"><a class="nav-basic" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>
											</cfif>								
										</cfcase>
										<cfcase value="3">
											<li class="nav-basic">#Get_Nav.Nav_Name#</li>
										</cfcase>
									</cfswitch>
			
								</cfloop>
							</ul>
						</div><!-- /.navbar-collapse -->
					</div>
				</nav>
			</cfdefaultcase>
			<cfcase value="legacy">
				<table style="width:100%">
					<tr>
						<td align="center">
							<table style="width:990px;background-color:##000">
								<tr>
									<cfloop query="Get_Nav">
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
										<cfif Get_Nav.Nav_Link contains "?">
											<cfset Get_Nav.Nav_Link="#Get_Nav.Nav_Link#&zip=#cookie.savezip#">
										<cfelse>
											<cfset Get_Nav.Nav_Link="#Get_Nav.Nav_Link#?zip=#cookie.savezip#">
										</cfif>
										<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
											<cfcase value="1">
												<td><a class="nav-basic" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></td>								
											</cfcase>
											<cfcase value="2">
												<td><a class="nav-basic" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></td>						
											</cfcase>
											<cfcase value="3">
												<td class="nav-basic">#Get_Nav.Nav_Name#</td>
											</cfcase>
										</cfswitch>
									</cfloop>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</cfcase>
		</cfswitch>

	</cffunction>

</cfcomponent>