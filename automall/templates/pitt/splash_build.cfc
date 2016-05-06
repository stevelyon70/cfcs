<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="Get_Page_Content" required="true"/>

		<cfinvoke component="/cfcs/automall/build_header" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<div class="container no-pad">
			<cfinvoke component="/cfcs/automall/build_nav" method="standard">
				<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
				<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
				<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
			</cfinvoke>
		</div>

		<section class="section-main-content">
			<div class="container main-content">
				<cfinvoke component="/cfcs/automall/build_section" method="pitt">
					<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
					<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
					<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
					<cfinvokeargument name="Get_Page_Content" value="#arguments.Get_Page_Content#"/>
				</cfinvoke>
			</div>
		</section>


		<cfinvoke component="/cfcs/automall/build_btns" method="pitt_splash">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		
		<section class="section-featured-vehicles">
			<div class="container featured-vehicles">
				<cfinvoke component="/cfcs/automall/build_carousel" method="featured">
					<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
					<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
					<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
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

		<!--- Payment Calculator Modal --->
		<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
			<cfinvoke component="/cfcs/automall/calculator" method="modal">
				<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			</cfinvoke>
		</cfcache>

	</cffunction>

</cfcomponent>