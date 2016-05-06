<cfcomponent>

	<cffunction name="page_build" description="builds the vdp page" output="Yes" access="public">

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

		<div style="padding-bottom:10px;" class="container">
			<cfinvoke component="/cfcs/ultra10/templates/#arguments.template_id#/content_vdp" method="content">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="vin" value="#arguments.vin#"/>
				<cfinvokeargument name="data_directory" value="#arguments.data_directory#"/>
				<cfinvokeargument name="assets" value="#arguments.assets#"/>
				<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
			</cfinvoke>
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