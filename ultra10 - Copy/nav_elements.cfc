<!--- nav types
	1 - Text
	2 - Link - Direct
	3 - Link - New Window
	4 - Image
	5 - Image - Direct Link
	6 - Image - New Window
	7 - Text - Modal Window
	8 - Image - Modal Window
	10 - Nissan Redline
	11 - 3rd Party Script
	12 - Null
 --->

<cfcomponent>

	<cffunction name="standard" description="shows a standard nav element" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="data_directory" required="true">
		<cfargument name="nav_type_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="dealer_template_id" required="true">

		<cfinclude template="#arguments.data_directory#/nav_data_#nav_type_id#.cfm" >
		
		<cfset variables.nav_count=0>

			<cfloop list="#variables.title_list#" index="main_nav" delimiters="^">

				<cfset variables.nav_count=variables.nav_count+1>

				<!--- nav id --->
				<cfset variables.nav_id="nav_#listgetat(variables.nav_id_list,'#variables.nav_count#','^')#">

				<!--- nav behaviour --->
				<cfset variables.behaviour="#listgetat(variables.behaviour_list,'#variables.nav_count#','^')#">

				<!--- alt text --->
				<cfset variables.alt="#listgetat(variables.alt_list,'#variables.nav_count#','^')#">
				<cfif variables.alt eq "NULL"><cfset variables.alt=""></cfif>

				<!--- nav link --->
				<cfset variables.nav_link="#listgetat(variables.link_list,'#variables.nav_count#','^')#">
				<cfif variables.nav_link eq "NULL"><cfset variables.nav_link=""></cfif>

				<!--- nav img --->
				<cfset variables.nav_img="#listgetat(variables.img_list,'#variables.nav_count#','^')#">
				<cfif variables.nav_img eq "NULL"><cfset variables.nav_img=""></cfif>

				<!--- nav rollover img --->
				<cfset variables.nav_roll_img="#listgetat(variables.roll_list,'#variables.nav_count#','^')#">
				<cfif variables.nav_roll_img eq "NULL"><cfset variables.nav_roll_img=""></cfif>
				
				<!---nav switches--->
				<cfswitch expression="#variables.behaviour#">
					<cfcase value="1">
						<span id="#variables.nav_id#" class="#variables.nav_id#" title="#variables.alt#">#variables.main_nav#</span>
					</cfcase>
					<cfcase value="2">
						<a id="#variables.nav_id#" class="#variables.nav_id#" href="#variables.nav_link#" title="#variables.alt#">#variables.main_nav#</a>	
					</cfcase>
					<cfcase value="3">
						<a id="#variables.nav_id#" class="#variables.nav_id#" href="#variables.nav_link#" title="#variables.alt#" target="_blank">#variables.main_nav#</a>
					</cfcase>
					<cfcase value="4">
						<img class="#variables.nav_id#" src="http://#cgi.server_name#/dealer/#arguments.assets#/templates/#arguments.dealer_template_id#/#variables.nav_img#" title="#variables.alt#" alt="#variables.alt#"/>
					</cfcase>
					<cfcase value="5">
						<a id="#variables.nav_id#" class="#variables.nav_id#<cfif len(trim(variables.nav_roll_img)) gt 0> rollover</cfif>" href="#variables.nav_link#" title="#variables.alt#"><img class="#variables.nav_id# .img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/templates/#arguments.dealer_template_id#/#variables.nav_img#" alt="#variables.alt#"/></a>
					</cfcase>
					<cfcase value="6">
						<a id="#variables.nav_id#" class="#variables.nav_id#<cfif len(trim(variables.nav_roll_img)) gt 0> rollover</cfif>" href="#variables.nav_link#" title="#variables.alt#" target="_blank"><img class="#variables.nav_id#" src="http://#cgi.server_name#/dealer/#arguments.assets#/templates/#arguments.dealer_template_id#/#variables.nav_img#" alt="#variables.alt#"/></a>
					</cfcase>
					<cfcase value="7">
						
					</cfcase>
					<cfcase value="8">
						
					</cfcase>
					<cfcase value="10">
						<div id="#variables.nav_id#" class="#variables.nav_id#"></div>
					</cfcase>
					<cfcase value="11">
						
					</cfcase>
					<cfcase value="12">
						
					</cfcase>
				</cfswitch>
			</cfloop>
	</cffunction>

</cfcomponent>