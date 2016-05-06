<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="display_type" default="">
		<cfargument name="show_primary" default="no">
		<cfargument name="label_primary" default="Store">
		<cfargument name="show_primary_btn" default="no">
		<cfargument name="primary_label" default="Visit Website">
		<cfargument name="show_nv" default="no">
		<cfargument name="label_nv" default="Sales">
		<cfargument name="show_nv_btn" default="no">
		<cfargument name="nv_label" default="Contact Sales">
		<cfargument name="show_service" default="no">
		<cfargument name="label_service" default="Service">
		<cfargument name="show_service_btn" default="no">
		<cfargument name="service_label" default="Schedule Service Now">
		<cfargument name="show_parts" default="no">
		<cfargument name="label_parts" default="Parts">
		<cfargument name="show_parts_btn" default="no">
		<cfargument name="parts_label" default="Order Parts">


		<cfinvoke component="/cfcs/ultra10/build_header" method="#arguments.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
			<cfinvokeargument name="dealer_template_id" value="#arguments.dealer_template_id#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
		</cfinvoke>

		<section class="section-subhdr">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="39"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="subhdr-link"/>
							<cfinvokeargument name="pull" value="left"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</section>

		<cfinvoke component="/cfcs/ultra10/build_navigation" method="#arguments.site_mode#">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
			<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
			<cfinvokeargument name="city" value="#arguments.city#"/>
			<cfinvokeargument name="state" value="#arguments.state#"/>
			<cfinvokeargument name="zip" value="#arguments.zip#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
		</cfinvoke>

		<section class="section-spl">
			<div class="container">
			
				<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
					<div class="row">
						<div class="col-md-12">
							<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
						</div>
					</div>
				</cfif>
				<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Meta_Info.page_banner#
						</div>
					</div>
				</cfif>
				
				<cfinvoke component="/cfcs/ultra10/locations" method="modern_standard">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
					<cfinvokeargument name="show_service" value="yes"/>
					<cfinvokeargument name="store_class" value="loc-store-name"/>
					<cfinvokeargument name="address_class" value="loc-address-class"/>
					<cfinvokeargument name="phone_class" value="loc-phone-class"/>
					<cfinvokeargument name="service_btn_class" value="loc-service-btn-class"/>

					<cfinvokeargument name="show_primary" value="#arguments.show_primary#"/>
					<cfinvokeargument name="label_primary" value="#arguments.label_primary#"/>
					<cfinvokeargument name="show_primary_btn" value="#arguments.show_primary_btn#"/>
					<cfinvokeargument name="primary_label" value="#arguments.primary_label#"/>

					<cfinvokeargument name="show_nv" value="#arguments.show_nv#"/>
					<cfinvokeargument name="label_nv" value="#arguments.label_nv#"/>
					<cfinvokeargument name="show_nv_btn" value="#arguments.show_nv_btn#"/>
					<cfinvokeargument name="nv_label" value="#arguments.nv_label#"/>

					<cfinvokeargument name="show_service" value="#arguments.show_service#"/>
					<cfinvokeargument name="label_service" value="#arguments.label_service#"/>
					<cfinvokeargument name="show_service_btn" value="#arguments.show_service_btn#"/>
					<cfinvokeargument name="service_label" value="#arguments.service_label#"/>

					<cfinvokeargument name="show_parts" value="#arguments.show_parts#"/>
					<cfinvokeargument name="label_parts" value="#arguments.label_parts#"/>
					<cfinvokeargument name="show_parts_btn" value="#arguments.show_parts_btn#"/>
					<cfinvokeargument name="parts_label" value="#arguments.parts_label#"/>

				</cfinvoke>

				<br/><br/>
				<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
				</cfif>
			</div>
		</section>

		<section class="section-links">
			<div class="container pad-top-10">
				<div class="row pad-top-10">
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="7"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="8"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="9"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="10"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
				</div>
			</div>			
		</section>

		<cfswitch expression="#arguments.dealer_id#">
			<cfdefaultcase>
				<cfinvoke component="/cfcs/ultra10/build_footer" method="#url.site_mode#">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
					<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
				</cfinvoke>
			</cfdefaultcase>
			<cfcase value="18">
				<cfinvoke component="/cfcs/ultra10/build_footer" method="nissan_#url.site_mode#">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
					<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
				</cfinvoke>			
			</cfcase> 
		</cfswitch> 

	</cffunction>

</cfcomponent>