<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="true">
		<cfargument name="method_name" required="true">
		<cfargument name="display_type" default="">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		
				<style type="text/css">
				</style>
		
		<cfset g = 1 >  <!--- Default Image --->
		<cfset g_img = "header_aboutus.jpg" >  <!--- Default Image --->
		
		<cfif  #url.dealer_id# EQ 376 >
			<cfif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/about_us.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_aboutus.jpg" >  
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/traditional_marketing.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_traditionalmedia.jpg" >  
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/broadcast_production.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_tvproduction.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/new_vehicle_commercial.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_tvproduction.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/brand_analytics.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_aboutus.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/digital_marketing.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_digitalmedia.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/email_marketing.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_emailmarketing.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/mail2web_programs.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_mail2web.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/media_planning_and_buying.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_mediabuying.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/pop_identity.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_pop-brandidentity.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/print_production.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_printproduction.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/reputation_management.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_repmanagement.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/responsive_websites.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_responsivedesign.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/sem_paid_search.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_sem.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/seo.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_seo.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/social_media.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_social.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/aspenmarketing/careers.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_careers.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/forms/contact_us.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_contact.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/seo_launch/seo_launch_questionnaire.cfm" >
				<cfset g = 1 >
				<cfset g_img = "" > 
			</cfif>
		</cfif>
		
		<cfif  #url.dealer_id# EQ 374 >
			<cfif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/about_us.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_aboutus.jpg" >  
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/traditional_marketing.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_traditionalmedia.jpg" >  
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/broadcast_production.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_tvproduction.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/new_vehicle_commercial.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_tvproduction.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/brand_analytics.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_aboutus.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/digital_marketing.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_digitalmedia.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/email_marketing.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_emailmarketing.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/mail2web_programs.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_mail2web.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/media_planning_and_buying.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_mediabuying.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/pop_identity.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_pop-brandidentity.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/print_production.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_printproduction.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/reputation_management.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_repmanagement.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/responsive_websites.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_responsivedesign.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/sem_paid_search.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_sem.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/seo.cfm" >
				<cfset g = 2 >
				<cfset g_img = "header_seo.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/social_media.cfm" >
				<cfset g = 3 >
				<cfset g_img = "header_social.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/dealer/worlddealercorp/careers.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_careers.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/forms/contact_us.cfm" >
				<cfset g = 1 >
				<cfset g_img = "header_contact.jpg" > 
			<cfelseif #lcase(cgi.script_name)# EQ "/seo_launch/seo_launch_questionnaire.cfm" >
				<cfset g = 1 >
				<cfset g_img = "" > 
			</cfif>
		</cfif>
		
		<style type="text/css">
							
			/* PAGE HEADER GRAPHICS */
			.header-graphic {
				width: 100%;
				height: 290px!important;
				margin-top:50px!important;
				background-color: ##ffffff!important;
				background-image:url(http://dealers.wdautos.com/dealer/#url.assets#/images/icons/<cfoutput>#g_img#</cfoutput>);
				background-attachment:fixed;
				background-size:contain;
				background-postition: right;
				}
			.header-no-graphic {
				width: 100%;
				/*height: 90px!important; */
				margin-top:80px!important;
				background-color: ##ffffff!important;
				background-image:url();
				background-attachment:fixed;
				background-size:contain;
				background-postition: right;
				}
				
			.header-graphic {
				background-image:url(http://dealers.wdautos.com/dealer/aspenmarketing/images/icons/<cfoutput>#g_img#</cfoutput>);
			}

							
				@media  (max-width: 400px) { 				/* remove header graphic on mobile  */
					.header-graphic {
					background-image:url()!important; 
								
					}
			.header-no-graphic {
				width: 100%;
				/*height: 90px!important; */
				margin-top:80px!important;
				background-color: ##ffffff!important;
				background-image:url();
				background-attachment:fixed;
				background-size:contain;
				background-postition: right;
				}
					 }	
 
			
			
			/* STATIC FOOTER 03-28-2016 ONLY ON INTERNAL PAGES */
			footer {
				position:static; border-top:1px solid ##666666!important;
				bottom:0;height: 50px;margin-top:0px!important;
				z-index: 2000;
				}
					
		</style>	
						
						
						
<div class="container-fluid" >

 <!-- START HEADER GRAPHIC -->
    <cfif #g_img# NEQ "" >
	    <div class="header-graphic visible-md visible-lg">

        </div>
	<cfelse>	
	    <div class="header-no-graphic visible-md visible-lg visible-sm visible-xs">

        </div>
	</cfif>	
 <div class="section-80-percent">	 <!--- NEW 10/30/2015 Applies to all internal pages --->
		<!--- <section class="section-spl section-int"> --->
			<div class="container int-container">
			
				<cfswitch expression="#arguments.display_type#">
					
					<cfdefaultcase>
						<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
							<div class="row">
								<div class="col-md-12">
									<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
								</div>
							</div>
						</cfif>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="52"/>
							<cfinvokeargument name="assets" value="#url.assets#"/>
							<cfinvokeargument name="element_class" value="page-banner"/>
							<cfswitch expression="#lcase(cgi.script_name)#">
								<cfdefaultcase><cfinvokeargument name="page_id" value="#lcase(cgi.script_name)#"/></cfdefaultcase>
								<cfcase value="/new/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								</cfcase>
								<cfcase value="/used/special_offers.cfm,/certified/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfcase>
							</cfswitch>
						</cfinvoke>
						<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
							<div class="row">
								<div class="col-md-12">
									#Get_Meta_Info.page_banner#
								</div>
							</div>
						</cfif>
						
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
						</div>
					</cfdefaultcase>

					<cfcase value="col_right">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="52"/>
							<cfinvokeargument name="assets" value="#url.assets#"/>
							<cfinvokeargument name="element_class" value="page-banner"/>
							<cfswitch expression="#lcase(cgi.script_name)#">
								<cfdefaultcase><cfinvokeargument name="page_id" value="#lcase(cgi.script_name)#"/></cfdefaultcase>
								<cfcase value="/new/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								</cfcase>
								<cfcase value="/used/special_offers.cfm,/certified/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfcase>
							</cfswitch>
						</cfinvoke>
						<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
							<div class="row">
								<div class="col-md-12">
									#Get_Meta_Info.page_banner#
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-9 pad-top-10">
								<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
									<div class="row">
										<div class="col-md-12">
											<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
										</div>
									</div>
								</cfif>
								<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
							<div class="col-md-3 pad-top-10 contact-div visible-md visible-lg">
								<div class="content-contact">
									<cfif cgi.script_name neq "/forms/contact.cfm">
										<cfinvoke component="/cfcs/forms/form_contact" method="sidebar_modern">
											<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
											<cfinvokeargument name="dsn" value="#url.DSN#"/>
											<cfinvokeargument name="title_class" value="side-title"/>
											<cfinvokeargument name="input_class" value="side-input"/>
											<cfinvokeargument name="button_class" value="button-input"/>
											<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
										</cfinvoke>
										<hr>
									</cfif>
									<cfinvoke component="/cfcs/ultra10/contact" method="phone_corp">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
										<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
										<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
										<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
										<cfinvokeargument name="city" value="#arguments.city#"/>
										<cfinvokeargument name="state" value="#arguments.state#"/>
										<cfinvokeargument name="zip" value="#arguments.zip#"/>
										<cfinvokeargument name="title_class" value="side-title"/>
									</cfinvoke>
								</div>
							</div>
						</div>
					</cfcase>

					<cfcase value="col_left">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="52"/>
							<cfinvokeargument name="assets" value="#url.assets#"/>
							<cfinvokeargument name="element_class" value="page-banner"/>
							<cfswitch expression="#lcase(cgi.script_name)#">
								<cfdefaultcase><cfinvokeargument name="page_id" value="#lcase(cgi.script_name)#"/></cfdefaultcase>
								<cfcase value="/new/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								</cfcase>
								<cfcase value="/used/special_offers.cfm,/certified/special_offers.cfm">
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfcase>
							</cfswitch>
						</cfinvoke>
						<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
							<div class="row">
								<div class="col-md-12">
									#Get_Meta_Info.page_banner#
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-3 pad-top-10 contact-div">
								<div class="content-contact">
									<cfinvoke component="/cfcs/forms/form_contact" method="sidebar_modern">
										<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
										<cfinvokeargument name="dsn" value="#url.DSN#"/>
										<cfinvokeargument name="title_class" value="side-title"/>
										<cfinvokeargument name="input_class" value="side-input"/>
										<cfinvokeargument name="button_class" value="button-input"/>
										<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
									</cfinvoke>
									<hr>
									<cfinvoke component="/cfcs/ultra10/contact" method="phone_corp">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
										<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
										<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
										<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
										<cfinvokeargument name="city" value="#arguments.city#"/>
										<cfinvokeargument name="state" value="#arguments.state#"/>
										<cfinvokeargument name="zip" value="#arguments.zip#"/>
										<cfinvokeargument name="title_class" value="side-title"/>
									</cfinvoke>
								</div>
							</div>
							<div class="col-md-9 pad-top-10">
								<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
									<div class="row">
										<div class="col-md-12">
											<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
										</div>
									</div>
								</cfif>
								<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
								</cfinvoke>
							</div>
						</div>
					</cfcase>

				</cfswitch>
				<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
				</cfif>
			</div>
			<div class="div-10"></div>
		<!--- </section> --->
	  </div>  	


	</cffunction>

</cfcomponent>