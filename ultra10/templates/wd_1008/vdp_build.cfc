<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Vehicle_Details" required="true">

		<cfinvoke component="/cfcs/ultra10/build_header_v" method="#arguments.site_mode#">
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

		<cfinvoke component="/cfcs/ultra10/build_navigation_v" method="#arguments.site_mode#">
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

				<section class="section-vdp">
					<div class="container pad-top-10">	
						<!--- Page Break Bar --->
					 	 <div class="row">
							<div class="col-md-12 pad-top-5 visible-lg visible-md">
								<div class="gradient" ></div>		
							</div>
						</div>	   
						
						<cfinvoke component="/cfcs/vehicles/vdp" method="#url.site_mode#_standard">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
							<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
							<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
							<cfinvokeargument name="city" value="#arguments.city#"/>
							<cfinvokeargument name="state" value="#arguments.state#"/>
							<cfinvokeargument name="zip" value="#arguments.zip#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							<cfinvokeargument name="Get_Vehicle_Details" value="#Get_Vehicle_Details#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						</cfinvoke>
						<div class="div-10"></div>
					</div>
				</section>
		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				
				<section class="section-links">
					<div class="container pad-top-10">
					<div class="row">
						<div class="col-md-12 pad-top-10  visible-lg visible-md">
							<div class="gradient"></div>		
						</div>
					</div>	
						<cfswitch expression="#url.dealer_id#">
							<cfcase value="18">
								<div class="row">
									<div class="col-md-6 no-pad">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="28"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="sm-link"/>
											<cfinvokeargument name="pull" value="left"/>
										</cfinvoke>
									</div>
									<div class="col-md-6 no-pad">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="37"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="sm-link"/>
											<cfinvokeargument name="pull" value="right"/>
										</cfinvoke>								
									</div>
								</div>
							</cfcase>
							<cfdefaultcase>
								<div class="row visible-sm visible-xs">
									<div class="col-md-12">
										  <cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="28"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="sm-link"/>
											<cfinvokeargument name="pull" value="left"/>
										</cfinvoke> 
									</div>
								</div>
							</cfdefaultcase>
						</cfswitch>
						<div class="row">
							<div class="row pad-top-10 ">
								<div class="col-md-3 ">
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
								<!--- <div class="col-md-3 visible-md visible-lg">
									<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
										<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
										<cfinvokeargument name="dsn" value="#url.DSN#"/>
										<cfinvokeargument name="title_class" value="ftr-title"/>
										<cfinvokeargument name="input_class" value="ftr-input"/>
										<cfinvokeargument name="button_class" value="ftr-contact-input"/>
										<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
									</cfinvoke>
								</div> --->
							</div>
						</div>
					</div>			
				</section>
			</cfdefaultcase>
			<cfcase value="legacy">
				<div class="section-spl">
					<div class="container">
						<cfinvoke component="/cfcs/vehicles/vdp" method="#url.site_mode#_standard">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
							<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
							<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
							<cfinvokeargument name="city" value="#arguments.city#"/>
							<cfinvokeargument name="state" value="#arguments.state#"/>
							<cfinvokeargument name="zip" value="#arguments.zip#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							<cfinvokeargument name="Get_Vehicle_Details" value="#Get_Vehicle_Details#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						</cfinvoke>
						<div class="div-10"></div>
					</div>
				</div>
				<div class="section-links">
					<div class="container pad-top-10">
						<table style="width:100%;margin-bottom:10px;" cellpadding="0" cellspacing="0">
							<cfswitch expression="#url.dealer_id#">
								<cfcase value="18">
									<tr>
										<td style="width:50%" valign="top">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="28"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="sm-link"/>
												<cfinvokeargument name="pull" value="left"/>
											</cfinvoke>
										</td>
										<td style="width:50%" valign="top">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="37"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="sm-link"/>
												<cfinvokeargument name="pull" value="right"/>
											</cfinvoke>								
										</td>
									</tr>
								</cfcase>
								<cfdefaultcase>
									<tr>
										<td style="width:100%" valign="top">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="28"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="sm-link"/>
												<cfinvokeargument name="pull" value="left"/>
											</cfinvoke>
										</td>
									</tr>
								</cfdefaultcase>
							</cfswitch>
						</table>
						<table style="width:100%;" cellpadding="0" cellspacing="0">
							<tr>
								<td style="width:25%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="7"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="info-link"/>
										<cfinvokeargument name="bold_top" value="true"/>
									</cfinvoke>
								</td>
								<td style="width:25%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="8"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="info-link"/>
										<cfinvokeargument name="bold_top" value="true"/>
									</cfinvoke>
								</td>
								<td style="width:25%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="9"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="info-link"/>
										<cfinvokeargument name="bold_top" value="true"/>
									</cfinvoke>
								</td>
								<td style="width:25%" valign="top">
									<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer_leg">
										<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
										<cfinvokeargument name="dsn" value="#url.DSN#"/>
										<cfinvokeargument name="title_class" value="ftr-title"/>
										<cfinvokeargument name="input_class" value="ftr-input"/>
										<cfinvokeargument name="button_class" value="ftr-contact-input"/>
										<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
									</cfinvoke>
								</td>
							</tr>
						</table>
					</div>			
				</div>
			</cfcase> 
		</cfswitch>

		<cfswitch expression="#arguments.dealer_id#">
			<cfdefaultcase>
				<cfinvoke component="/cfcs/ultra10/build_footer_v" method="#url.site_mode#">
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
				<cfinvoke component="/cfcs/ultra10/build_footer_v" method="nissan_#url.site_mode#">
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