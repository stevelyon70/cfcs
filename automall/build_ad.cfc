<cfcomponent>

	<cffunction name="leaderboard" description="leaderboard ad" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">

		<div class="row">
			<div class="col-md-12" align="center">
				<div class="ad-ldr">728 x 90</div>
			</div>
		</div>

	</cffunction>

	<cffunction name="display" description="display ad" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">

		<div class="row">
			<div class="col-md-12" align="center">
				<div class="ad-dis">300 x 250</div>
			</div>
		</div>

	</cffunction>	

</cfcomponent>