<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<cfif Get_Meta_Info.End_Date gte dateformat(now(),"mm/dd/yyyy") and Get_Meta_Info.Start_Date lte dateformat(now(),"mm/dd/yyyy")>
			<cfif len(trim(Get_Meta_Info.iframe)) eq 0>
				#Get_Meta_Info.page_content#
			<cfelse>
				<cfif Get_Meta_Info.iframe_scroll eq "0">
					<cfset Get_Meta_Info.iframe_scroll="no">
				<cfelse>
					<cfset Get_Meta_Info.iframe_scroll="yes">
				</cfif>
				<iframe src="#Get_Meta_Info.iframe#" width="#Get_Meta_Info.iframe_width#" height="#Get_Meta_Info.iframe_height#" scrolling="#Get_Meta_Info.iframe_scroll#" frameborder="0"></iframe>
			</cfif>
		</cfif>

	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">

		<cfif Get_Meta_Info.End_Date gte dateformat(now(),"mm/dd/yyyy") and Get_Meta_Info.Start_Date lte dateformat(now(),"mm/dd/yyyy")>
			<cfif len(trim(Get_Meta_Info.iframe)) eq 0>
				#Get_Meta_Info.page_content#
			<cfelse>
				<cfif Get_Meta_Info.iframe_scroll eq "0">
					<cfset Get_Meta_Info.iframe_scroll="no">
				<cfelse>
					<cfset Get_Meta_Info.iframe_scroll="yes">
				</cfif>
				<iframe src="#Get_Meta_Info.iframe#" width="#Get_Meta_Info.iframe_width#" height="#Get_Meta_Info.iframe_height#" scrolling="#Get_Meta_Info.iframe_scroll#" frameborder="0"></iframe>
			</cfif>
		</cfif>
	
	</cffunction>

</cfcomponent>