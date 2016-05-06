<cfcomponent>

	<cffunction name="full_page" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="component_name" required="true">
		<cfargument name="component_method" required="true">
		<cfargument name="Get_Page_Content" required="true"/>
		
		<cfinvoke component="/cfcs/automall/build_header" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<cfinvoke component="/cfcs/automall/build_nav" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<cfif len(trim(Get_Page_Content.top_ad)) gt 0>
			<section class="section-ad-leaderboard">
				<div class="container ad-leaderboard">
					<div class="row">
						<div class="col-md-12" align="center">
							<div class="ad-ldr">
								#Get_Page_Content.top_ad#
							</div>
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<section>
			<div class="container">
				<cfinvoke component="#arguments.component_name#" method="#arguments.component_method#">
					<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
					<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
					<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
					<cfinvokeargument name="Get_Page_Content" value="#arguments.Get_Page_Content#"/>
				</cfinvoke>
			</div>
		</section>

		<cfif len(trim(Get_Page_Content.bot_ad)) gt 0>
			<section class="section-ad-leaderboard">
				<div class="container ad-leaderboard">
					<div class="row">
						<div class="col-md-12" align="center">
							<div class="ad-ldr">
								#Get_Page_Content.bot_ad#
							</div>
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<cfinvoke component="/cfcs/automall/build_footer" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>
		
	</cffunction>

</cfcomponent>