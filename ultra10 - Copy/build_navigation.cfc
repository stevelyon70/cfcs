<cfcomponent>

	<cffunction name="dev" description="standard navbar" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_ID" default="true">
		<cfargument name="Nav_Type_ID" required="true">
	
		<!---Get Nav--->
		<cfstoredproc datasource="Ultra10" procedure="Get_All_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#arguments.Dealer_ID#" value="#arguments.dealer_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="#arguments.Nav_Type_ID#" maxlength="3">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>

		<div class="visible-lg visible-md">
			<nav class="navbar yamm navbar-default navbar-dt" role="navigation">
				<div class="container sitenav">
					<div class="no-pad" id="dt_nav">
						<ul class="nav navbar-nav no-pad">
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Nav_Link eq "index.cfm">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
									</cfif>
								</cfif>
								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1">
										<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>								
									</cfcase>
									<cfcase value="2">
										<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
									</cfcase>
									<cfcase value="3">
										<li class="navbar-link-dt">#Get_Nav.Nav_Name#</li>
									</cfcase>
								</cfswitch>
							</cfloop>
							<!---<li class="dropdown dropdown-dt  yamm-fw">
								<a href="##" class="dropdown-toggle navbar-link-dt" data-toggle="dropdown">yamm <b class="caret"></b></a>
								<ul class="dropdown-menu dropdown-menu-dt">
									<li class="dropdown"><a href="##">Action</a></li>
								</ul>
							</li>--->
							<!---<li class="dropdown dropdown-dt">
								<a href="##" class="dropdown-toggle navbar-link-dt" data-toggle="dropdown">Pre-Owned <b class="caret"></b></a>
								<ul class="dropdown-menu dropdown-menu-dt">
									<li><a href="##">Action</a></li>
								</ul>
							</li>--->
						</ul>
					</div>
				</div>
			</nav>
		</div>
		<div class="visible-xs visible-sm">
			<nav class="navbar navbar-inverse" role="navigation">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##mobile_nav">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				</div>
				<div class="collapse navbar-collapse no-pad" id="mobile_nav">
					<ul class="nav navbar-nav">
						<cfloop query="Get_Nav">
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
								<cfcase value="1">
									<li><a class="navbar-link-mb" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>								
								</cfcase>
								<cfcase value="2">
									<li><a class="navbar-link-mb" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
								</cfcase>
								<cfcase value="3">
									<li class="navbar-link-mb">#Get_Nav.Nav_Name#</li>
								</cfcase>
							</cfswitch>
						</cfloop>
						<!---<li>
							<a href="http://#cgi.server_name#">Home</a>
						</li>
						<li class="dropdown">
							<a href="##" class="dropdown-toggle" data-toggle="dropdown">New Cars <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a class="navbar-link-mob" href="##">Action</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="##" class="dropdown-toggle" data-toggle="dropdown">Pre-Owned <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a class="navbar-link-mob" href="##">Action</a></li>
							</ul>
						</li>--->
					</ul>
				</div>
			</nav>
		</div>
	
	</cffunction>

</cfcomponent>