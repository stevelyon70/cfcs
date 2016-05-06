<cfcomponent>

	<cffunction name="full_width" description="builds the vdp page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="data_directory" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="dealer_name" required="true">
		<cfargument name="address_1" required="true">
		<cfargument name="address_2" required="true">
		<cfargument name="city" required="true">
		<cfargument name="state" required="true">
		<cfargument name="zip" required="true">
		<cfargument name="wordpress_cat" required="true">
		<cfargument name="page_component" required="true">
		<cfargument name="component_method" required="true">

		<cfargument name="Get_Meta_Info" required="true">
		<cfset Get_Meta_Info=arguments.Get_Meta_Info>
	
		<header class="section-hdr">
			<div class="container">
				<cfinvoke component="/cfcs/ultra10/build_header" method="dev">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</header>

		<cfinvoke component="/cfcs/ultra10/build_navigation" method="dev">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="nav_type_id" value="1"/>
		</cfinvoke>

		<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
			<section class="section-banner">
				<div class="container" align="center">
					<div class="row page-banner">
						<div class="col-md-12">
							#Get_Meta_Info.page_banner#
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<section class="section-title container">
			<div class="container">
				<div class="row">
					<h1 class="col-md-12 page-title" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
				</div>
			</div>
		</section>

		<div class="container">
			<div class="row">
				<div class="col-md-12 content-pad">
					<cfinvoke component="#arguments.page_component#" method="#arguments.component_method#">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="data_directory" value="#arguments.data_directory#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
						<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
						<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
						<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
						<cfinvokeargument name="city" value="#arguments.city#"/>
						<cfinvokeargument name="state" value="#arguments.state#"/>
						<cfinvokeargument name="zip" value="#arguments.zip#"/>
						<cfinvokeargument name="wordpress_cat" value="#arguments.wordpress_cat#"/>
					</cfinvoke>
				</div>
			</div>
		</div>
		
		<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
			<section class="section-banner">
				<div class="container" align="center">
					<div class="row page-banner">
						<div class="col-md-12">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<footer>
			<div class="container">
				<cfinvoke component="/cfcs/ultra10/build_footer" method="nissan">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</footer>
			
	</cffunction>

</cfcomponent>