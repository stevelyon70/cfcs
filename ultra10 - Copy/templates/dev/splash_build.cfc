<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">

		<header class="section-hdr">
			Header
		</header>

		<div class="container">
			Navigation
		</div>

		<section class="section-marketing">
			<div class="container">
				Marketing Area
			</div>
		</section>

		<footer class="section-ftr">
			<div class="container">
				Footer
			</div>
		</footer>

	</cffunction>

</cfcomponent>