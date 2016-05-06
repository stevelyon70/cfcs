<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="data_directory" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="dealer_name" required="true">
		<cfargument name="address_1" required="true">
		<cfargument name="address_2" required="true">
		<cfargument name="city" required="true">
		<cfargument name="state" required="true">
		<cfargument name="zip" required="true">
		<cfargument name="wordpress_cat" required="true">

		<header class="section-hdr">
			<div class="container">
				<cfinvoke component="/cfcs/ultra10/build_header" method="dev">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</header>

		<!---<cfinvoke component="/cfcs/ultra10/build_navigation" method="dev">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="nav_type_id" value="1"/>
		</cfinvoke>

		<section class="section-slideshow">
			<div class="slideshow container">
				<!---<div class="col-md-2 no-pad visible-lg visible-md">
					Search Tabs
				</div>--->
				<div class="col-md-12 no-pad">
					<cfinvoke component="/cfcs/ultra10/wow_slider" method="dev">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
					</cfinvoke>
				</div>
			</div>
		</section>

		<section class="section-carousel-specials">
			<div class="container carousel-specials">
				<cfinvoke component="/cfcs/ultra10/build_section" method="dev_specials">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
				</cfinvoke>
			</div>
		</section>

		<section class="section-carousel-btns">
			<div class="container carousel-btns">
				<cfinvoke component="/cfcs/ultra10/build_section" method="dev_btns">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
				</cfinvoke>
			</div>
		</section>

		<!---<section class="section-video-map">
			<div class="container video-map">
				<cfinvoke component="/cfcs/ultra10/build_section" method="video_map">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				</cfinvoke>
			</div>
		</section>--->

		<section class="section-links-contact">
			<div class="container links-contact">
				<cfinvoke component="/cfcs/ultra10/build_section" method="contact_right">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</section>

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
		</footer>--->
		
	</cffunction>

</cfcomponent>