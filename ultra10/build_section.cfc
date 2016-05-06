<cfcomponent>

	<cffunction name="contact_right" description="component with links left & contact right" output="Yes" access="public">

		<cfparam name="url.first_name" default="">
		<cfparam name="url.last_name" default="">
		<cfparam name="url.email" default="">
		<cfparam name="url.phone" default="">
		<cfparam name="url.comments" default="">
		<!---<div class="row">
			<div class="col-md-12">
				social media links
			</div>
		</div>--->
		<div class="row">
			<div class="col-md-7">
				<div class="row">
					<div class="col-md-4 visible-lg visible-md">
						<cfinvoke component="/cfcs/ultra10/build_section" method="info_links">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="nav_type_id" value="7"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 visible-lg visible-md">
						<cfinvoke component="/cfcs/ultra10/build_section" method="info_links">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="nav_type_id" value="8"/>
						</cfinvoke>
					</div>
					<div class="col-md-4 visible-lg visible-md">
						<cfinvoke component="/cfcs/ultra10/build_section" method="info_links">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="nav_type_id" value="9"/>
						</cfinvoke>
					</div>
				</div>
			</div>
			<div class="col-md-5">
				<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="post">
					<div class="row">
						<div class="col-md-12 ftr-form-pad link-info-title" align="center">
							CONTACT US
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 ftr-form-pad">
							<input name="first_name" class="form-control input-md" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
						</div>
						<div class="col-md-6 ftr-form-pad">
							<input name="last_name" class="form-control input-md" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 ftr-form-pad">
							<input name="email" class="form-control input-md" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
						</div>
						<div class="col-md-6 ftr-form-pad">
							<input name="phone" class="form-control input-md" id="phone" type="text" placeholder="Phone" maxlength="10" value="#url.phone#"/>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 ftr-form-pad">
							<textarea name="comments" class="form-control" id="comments" maxlength="1000" placeholder="Comments" required>#url.comments#</textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 ftr-form-pad" align="center">
							<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
							<input type="submit" class="btn btn-primary" id="submit" value="Contact Us"/>
						</div>
					</div>
				</div>
			</form>
		</div>
		<!---<div class="row">
			<div class="col-md-8">	
				#arguments.dealer_name# &copy;#dateformat(now(),"yyyy")#
			</div>
			<div class="col-md-4">
				<a class="pull-right" href="##">[More about #arguments.dealer_name#]</a>
			</div>
		</div>--->
	
	</cffunction>

	<cffunction name="info_links" description="info links" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="Dealer_ID" default="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="nav_class" default="link-info">


		<!---Get Nav--->
		<cfstoredproc datasource="Ultra10" procedure="Get_All_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#arguments.Dealer_ID#" value="#arguments.dealer_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="#arguments.Nav_Type_ID#" maxlength="3">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>

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
					<a class="#arguments.nav_class#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>								
				</cfcase>
				<cfcase value="2">
					<a class="#arguments.nav_class#"href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
				</cfcase>
				<cfcase value="3">
					<div class="#arguments.nav_class#-title">#ucase(Get_Nav.Nav_Name)#</div>
				</cfcase>
			</cfswitch>
		</cfloop>

	</cffunction>


	<cffunction name="video_map" description="component with video & map/tabs" output="Yes" access="public">
		
		<div class="row">
			<div class="col-md-4">
				video
			</div>
			<div class="col-md-8">
				map
			</div>
		</div>
			
	</cffunction>

	<cffunction name="dev_specials" description="component that creates a specials carousel" output="Yes" access="public">

		<cfargument name="assets" required="true">
		
		<!---Get Nav--->
		<cfstoredproc datasource="Ultra10" procedure="Get_All_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#arguments.Dealer_ID#" value="#arguments.dealer_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="5" maxlength="3">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>
			
		<div class="row visible-lg visible-md">
			<div class="col-md-12">
				<ul class="desk_fv_carousel">
					<cfloop query="Get_Nav">
						<li class="slide">
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
								<cfcase value="1">
									<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
										<img alt="#Get_Nav.Nav_Alt#"  src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
									</a>								
								</cfcase>
								<cfcase value="2">
									<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
										<img alt="#Get_Nav.Nav_Alt#"  src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
									</a>						
								</cfcase>
								<cfcase value="3">
									<img alt="#Get_Nav.Nav_Alt#"  src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
								</cfcase>
							</cfswitch>
						</li>
					</cfloop>
				</ul>
			</div>
		</div>
		<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" async src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.desk_fv_carousel').bxSlider({slideWidth: 275,minSlides: 4,maxSlides: 20,slideMargin: 10,pager: false,auto: true,autoHover: true,moveSlides: 1});">
		<div class="row visible-sm visible-xs">
			<cfloop query="Get_Nav">
				<div class="col-md-3 max-width" align="center">
					<cfif Get_Nav.Nav_Link eq "index.cfm">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
					<cfelse>
						<cfif left(Get_Nav.Nav_Link,4) neq "http">
							<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
						</cfif>
					</cfif>
					<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
						<cfcase value="1">
							<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
								<img alt="#Get_Nav.Nav_Alt#"  class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
							</a>								
						</cfcase>
						<cfcase value="2">
							<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
								<img alt="#Get_Nav.Nav_Alt#"  class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
							</a>						
						</cfcase>
						<cfcase value="3">
							<img alt="#Get_Nav.Nav_Alt#"  class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
						</cfcase>
					</cfswitch>
				</div>
			</cfloop>
		</div>
	</cffunction>

	<cffunction name="dev_btns" description="component that creates a buttons carousel" output="Yes" access="public">

		<cfargument name="assets" required="true">
		
		<!---Get Nav--->
		<cfstoredproc datasource="Ultra10" procedure="Get_All_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#arguments.Dealer_ID#" value="#arguments.dealer_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="6" maxlength="3">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>
			
		<div class="row visible-lg visible-md">
			<div class="col-md-12" align="center">
				<ul>
					<cfloop query="Get_Nav">
						<li class="carousel-li pull-left">
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
								<cfcase value="1">
									<a class="carousel-btn rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
										<img alt="#Get_Nav.Nav_Alt#"  class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
									</a>								
								</cfcase>
								<cfcase value="2">
									<a class="carousel-btn rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
										<img alt="#Get_Nav.Nav_Alt#"  class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
									</a>						
								</cfcase>
								<cfcase value="3">
									<img alt="#Get_Nav.Nav_Alt#"  class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
								</cfcase>
							</cfswitch>
						</li>
					</cfloop>
				</ul>
			</div>
		</div>

		<div class="row visible-xs visible-sm">
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
						<div align="center">
							<a  class="col-md-2 no-pad" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
								<img alt="#Get_Nav.Nav_Alt#"  class="carousel-btn-mbl img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
							</a>
						</div>
					</cfcase>
					<cfcase value="2">
						<div align="center">
							<a  class="col-md-2 no-pad" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
								<img alt="#Get_Nav.Nav_Alt#"  class="carousel-btn-mbl img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
							</a>
						</div>
					</cfcase>
					<cfcase value="3">
						<div class="col-md-2 no-pad" align="center">
							<img alt="#Get_Nav.Nav_Alt#" class="carousel-btn-mbl img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#"/>
						</div>
					</cfcase>
				</cfswitch>
			</cfloop>
		</div>
			
	</cffunction>

</cfcomponent>