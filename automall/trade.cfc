<cfcomponent>

	<cffunction name="pitt" description="trade in tool for pitt" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Get_Page_Content" required="true"/>
		<cfset Get_Page_Content=arguments.Get_Page_Content>

		<div class="row">
			<div class="col-md-12">
				<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_banner#
				</div>
			</div>
		</cfif>
		<div align="center">
			<iframe style="width:650px;height:960px;" src="https://www.nadaguideswindowlink.com/9742" frameborder="0"></iframe>
		</div>
		<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_footer#
				</div>
			</div>
		</cfif>
	</cffunction>

</cfcomponent>