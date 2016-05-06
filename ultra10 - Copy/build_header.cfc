<cfcomponent>

	<cffunction name="dev" description="shows a standard header" output="Yes" access="public">
		<cfargument name="site_mode" required="true">
		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				<div class="row hdr-row visible-lg visible-md">
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-3 no-pad">
								<a href="http://#cgi.server_name#"><img class="img-responsive" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/logo_nissan.jpg"/></a>
							</div>
							<div class="col-md-3 no-pad">
								<a href="http://women-drivers.com/Kelly-Nissan-reviews" target="_blank"><img class="img-responsive ico-1" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/logo_wd.png"/></a>
							</div>
							<div class="col-md-3 no-pad">
								<a href="http://#cgi.server_name#/dealer/kellynissan/customer_reviews.cfm"><img class="img-responsive ico-2" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/lmp_sm_off.png"/></a>
							</div>
							<div class="col-md-3 no-pad">
								<a href="http://#cgi.server_name#/dealer/kellynissan/live_market_pricing.cfm"><img class="img-responsive ico-3" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/logo_dr.png"/></a>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12 redline no-pad">
								
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 no-pad">
								<div class="hdr-dlr-name">#arguments.dealer_name#</div>
								<div class="hdr-dlr-addr">#arguments.address_1# | #arguments.city#, #arguments.state# #arguments.zip#</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 no-pad">
								<div class="hdr-dlr-phone">Sales : (866) 525-7065 | Service : (866) 609-2208</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row visible-xs visible-sm">
					<div class="col-md-12 no-pad">
						<a href="http://#cgi.server_name#"><img class="img-responsive" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/mobile_header.png"/></a>
					</div>
				</div>
			</cfdefaultcase>
			<cfcase value="legacy">
				<table class="header" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<a href="http://#cgi.server_name#"><img class="img-responsive" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/logo_nissan.jpg" border="0"/></a>
						</td>
						<td>
							<a href="http://women-drivers.com/Kelly-Nissan-reviews" target="_blank"><img class="img-responsive ico-1" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/logo_wd.png" border="0"/></a>
						</td>
						<td>
							<a href="http://#cgi.server_name#/dealer/kellynissan/customer_reviews.cfm"><img class="img-responsive ico-2" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/lmp_sm_off.png" border="0"/></a>
						</td>
						<td>
							<a href="http://#cgi.server_name#/dealer/kellynissan/live_market_pricing.cfm"><img class="img-responsive ico-3" src="http://#cgi.server_name#/dealer/kellynissan/templates/dev/logo_dr.png" border="0"/></a>
						</td>
						<td valign="top">
							<div class="redline"></div>
							<div class="hdr-dlr-name">#arguments.dealer_name#</div>
							<div class="hdr-dlr-addr">#arguments.address_1# | #arguments.city#, #arguments.state# #arguments.zip#</div>
							<div class="hdr-dlr-phone">Sales : (866) 525-7065 | Service : (866) 609-2208</div>
						</td>
					</tr>
				</table>
			</cfcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="twelve" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="data_directory" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="dealer_template_id" required="true">

<cfset variables.columns=5>
<cfset variables.column1="col-md-2">
<cfset variables.column2="col-md-1">
<cfset variables.column3="col-md-1">
<cfset variables.column4="col-md-2">
<cfset variables.column5="col-md-6">

<header class="hdr-container">
	<div class="container hdr-row">
		<div class="row">
			<cfloop from="1" to="#variables.columns#" index="col_num">
				<cfset variables.this_span="variables.column#variables.col_num#">
				<div class="#evaluate(variables.this_span)#">
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="standard">
						<cfinvokeargument name="nav_type_id" value="#variables.col_num#"/>
						<cfinvokeargument name="data_directory" value="#arguments.data_directory#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="dealer_template_id" value="#arguments.dealer_template_id#"/>
					</cfinvoke>
				</div>
			</cfloop>
		</div>
	</div>
</header>

<!---
<header class="container-fluid hdr-fluid">
	<div class="container hdr-row">
		<div class="row-fluid">
			<cfloop from="1" to="#variables.columns#" index="col_num">
				
				<cfset variables.this_span="variables.column#variables.col_num#">
				<span class="#evaluate(variables.this_span)#">
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="standard">
						<cfinvokeargument name="nav_type_id" value="#variables.col_num#"/>
						<cfinvokeargument name="data_directory" value="#arguments.data_directory#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="dealer_template_id" value="#arguments.dealer_template_id#"/>
					</cfinvoke>
				</span>
			</cfloop>
		</div>
	</div>
</header>
--->

	</cffunction>

</cfcomponent>