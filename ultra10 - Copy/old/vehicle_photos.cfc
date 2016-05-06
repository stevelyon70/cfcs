<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp photo" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Img_Urls" required="true">

		<cfif len(trim(arguments.Img_Urls)) gt 0>
			<cfset variables.first_image=listgetat(arguments.Img_Urls,1)>
		<cfelse>
			<cfset variables.first_image="none">
		</cfif>
		
		<!---<img class="vdp-img" src="#variables.first_image#"/>--->
		<!---Number of Photos: #listlen(arguments.Img_Urls)#--->

		<cfset arguments.Img_Urls=arguments.Img_Urls>
		<cfinvoke component="/cfcs/ultra10/wow_slider" method="inv_slider">
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>

	</cffunction>
	
	<cffunction name="single_photo" description="shows a single photo" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Img_Urls" required="true">
		<cfargument name="img_title" default="" >
		<cfargument name="img_class" default="">

		<cfif len(trim(arguments.Img_Urls)) gt 0>
			<cfset variables.first_image=listgetat(arguments.Img_Urls,1)>
		<cfelse>
			<cfset variables.first_image="none">
		</cfif>
	
		<cfif len(trim(arguments.img_class)) gt 0>
			<img class="#arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
		<cfelse>
			<img style="width:100%" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
		</cfif>
			
	</cffunction>

</cfcomponent>