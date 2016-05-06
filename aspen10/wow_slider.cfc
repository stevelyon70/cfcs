<cfcomponent>

	<cffunction name="wide" description="slideshow" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">

		
		<cfset variables.slide_count=0>
		<cfloop query="Get_Nav">
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
				<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
					<cfset variables.slide_count=variables.slide_count+1>
				</cfif>
			</cfif>
		</cfloop>
		<cfif variables.slide_count gt 1>
			<div id="wowslider-container1">
				<div class="ws_images">
					<ul>
				
						<cfset variables.nav_count=0>
				
						<cfloop query="Get_Nav">
							
							<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
					
								<cfset variables.nav_count=variables.nav_count+1>
	
								<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
									</cfif>
								</cfif>

								<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
								<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>

								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1">
										<li>
											<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
											</a>
										</li>
									</cfcase>
									<cfcase value="2">
										<li>
											<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
											</a>
										</li>
									</cfcase>
									<cfcase value="3">
										<li>
											<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
										</li>
									</cfcase>
								</cfswitch>
							</cfif>
						</cfloop>
					</ul>
				</div>
				<div class="ws_bullets">
					<div style="top:25px">
						<cfset variables.nav_count=0>
						<cfloop query="Get_Nav">
							<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
								<cfset variables.nav_count=variables.nav_count+1>
								<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
									<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
									<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>
									<a href="##" title="#variables.img_title#">#variables.nav_count#</a>
								</cfif>
							</cfif>
						</cfloop>
					</div>
				</div>
				<div class="ws_shadow"></div>
			</div>

			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/880/engine1/wowslider.js"></script>'>
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/880/engine1/script.js"></script>'>

		<cfelse>
	
			<cfloop query="Get_Nav">
				
				<cfset variables.nav_count=0>

				<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
		
					<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
						<cfset variables.nav_count=variables.nav_count+1>
		
						<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
							<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
						<cfelse>
							<cfif left(Get_Nav.Nav_Link,4) neq "http">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
							</cfif>
						</cfif>
		
						<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
						<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>
		
						<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
							<cfcase value="1">
								<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
								</a>
							</cfcase>
							<cfcase value="2">
								<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
								</a>
							</cfcase>
							<cfcase value="3">
								<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
							</cfcase>
						</cfswitch>

					</cfif>

				</cfif>

			</cfloop>

		</cfif>
		
	</cffunction>

</cfcomponent>