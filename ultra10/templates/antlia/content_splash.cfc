<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<section class="section-spl">
			<div class="container">
				<div class="row spl-marketing">
					<div class="col-md-5 no-pad">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="32"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-button"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
					</div>
					<div class="col-md-7 no-pad">
						<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="34"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="31"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-row"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/locations" method="modern_standard">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="show_service" value="yes"/>
							<cfinvokeargument name="label_service" value=""/>
							<cfinvokeargument name="store_class" value="loc-store-name"/>
							<cfinvokeargument name="address_class" value="loc-address-class"/>
							<cfinvokeargument name="phone_class" value="loc-phone-class"/>
							<cfinvokeargument name="service_btn_class" value="loc-service-btn-class"/>
							<cfinvokeargument name="show_service_btn" value="yes"/>
							<cfinvokeargument name="service_label" value=""/>
						</cfinvoke>
					</div>
				</div>
			</div>
				<div class="row">
					<div class="col-md-12" align="center">
						<cfinclude template="section_about_us.cfm">
					</div>
				</div>
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td style="padding:10px 10px 10px 0px;" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="32"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-button"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
						</td>
						<td class="pad-top-10" valign="top">
							<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="34"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<cfinvoke component="/cfcs/ultra10/locations" method="legacy_standard">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="show_service" value="yes"/>
								<cfinvokeargument name="label_service" value=""/>
								<cfinvokeargument name="store_class" value="loc-store-name"/>
								<cfinvokeargument name="address_class" value="loc-address-class"/>
								<cfinvokeargument name="phone_class" value="loc-phone-class"/>
								<cfinvokeargument name="service_btn_class" value="loc-service-btn-class"/>
								<cfinvokeargument name="show_service_btn" value="yes"/>
								<cfinvokeargument name="service_label" value=""/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>