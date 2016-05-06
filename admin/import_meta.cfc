<cfcomponent>

	<cffunction name="import" description="imports seo" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Legacy_Meta_Info" required="true">

		<cfparam name="url.my_title" default="">
		<cfparam name="url.my_description" default="">
		<cfparam name="url.my_keywords" default="">
		
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"Title","title","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"TITLE","title","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"META","meta","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"Meta","meta","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"Name=","name=","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"NAME=","name=","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"Content=","content=","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,"CONTENT=","content=","All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,'">','"/>',"All")>
		<cfset arguments.Legacy_Meta_Info=replace(arguments.Legacy_Meta_Info,'">','"/>',"All")>

		<cfset url.my_title=REMatch("(?s)<title>.*?</title>", arguments.Legacy_Meta_Info)>
		<cfset url.my_title = ArrayToList(url.my_title, ",")>
		<cfset url.my_title = REReplaceNoCase(url.my_title, '<(.|\n)*?>', '', 'ALL')>

		<cfset url.my_description=REMatch('(?s)<meta name="description" content=".*?"/>', arguments.Legacy_Meta_Info)>
		<cfif arraylen(url.my_description) eq 0>
			<cfset url.my_description=REMatch('(?s)<meta name="description" content=".*?">', arguments.Legacy_Meta_Info)>				
		</cfif>
		<cfset url.my_description = ArrayToList(url.my_description, ",")>
		<cfset url.my_description = replacenocase(url.my_description,'<meta name="description" content="','','all')>
		<cfset url.my_description = replacenocase(url.my_description,'"/>','','all')>
		<cfset url.my_description = replacenocase(url.my_description,'">','','all')>

		<cfset url.my_keywords=REMatch('(?s)<meta name="keywords" content=".*?"/>', arguments.Legacy_Meta_Info)>
		<cfif arraylen(url.my_keywords) eq 0>
			<cfset url.my_keywords=REMatch('(?s)<meta name="keywords" content=".*?">', arguments.Legacy_Meta_Info)>				
		</cfif>
		<cfset url.my_keywords = ArrayToList(url.my_keywords, ",")>
		<cfset url.my_keywords = replacenocase(url.my_keywords,'<meta name="keywords" content="','','all')>
		<cfset url.my_keywords = replacenocase(url.my_keywords,'"/>','','all')>
		<cfset url.my_keywords = replacenocase(url.my_keywords,'">','','all')>
		
		<!---
			#url.my_title#
			<br/><br/>
			#url.my_description#
			<br/><br/>
			#url.my_keywords#
			<br/><br/>
		--->
			
	</cffunction>

</cfcomponent>