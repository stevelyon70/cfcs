<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		
	<link href='http://fonts.googleapis.com/css?family=Jura' rel='stylesheet' type='text/css'>
<cfif #lcase(cgi.script_name)# NEQ "/seo_launch/seo_launch_questionnaire.cfm" >

		 
		  <div class="navigation">
          <div class="nav">
			  <nav id="cbp-hrmenu" class="cbp-hrmenu">
					<ul> 
                    <!---    <div class="visible-sm visible-xs" style="margin-left:50px!important"> <a href="/index.cfm"><b>HOME</b></a></div> --->
					  
                       <li> <a onclick="javascript:location.href='http://#cgi.server_name#'"  href="##" ><b>HOME</b></a> </li>
                        <li>
                            <a href="##">SERVICES</a>
                            <div class="cbp-hrsub">

								<div class="cbp-hrsub-inner">
									<div>
									
										<h4><a href="/dealer/aspenmarketing/traditional_marketing.cfm">Traditional Marketing</a></h4>
										<ul>
											<li><a href="/dealer/aspenmarketing/media_planning_and_buying.cfm">Media Planning & Buying</a></li>
											<li><a href="/dealer/aspenmarketing/broadcast_production.cfm">TV/Radio Production</a></li>
                                            <li><a href="/dealer/aspenmarketing/print_production.cfm">Print Production</a></li>
                                            <li><a href="/dealer/aspenmarketing/pop_identity.cfm">POP/Identity</a></li>
                                            <li><a href="/dealer/aspenmarketing/mail2web_programs.cfm">Mail2Web Programs</a></li>
                                            </ul>
										</div>
									<div>
										<h4><a href="/dealer/aspenmarketing/digital_marketing.cfm">Digital Marketing</h4>
										<ul>
                                       		<li><a href="/dealer/aspenmarketing/responsive_websites.cfm">Responsive Websites</a></li>
											<li><a href="/dealer/aspenmarketing/seo.cfm">SEO</a></li>
                                            <li><a href="/dealer/aspenmarketing/sem_paid_search.cfm">Conversion Based SEM</a></li>
                                            <li><a href="/dealer/aspenmarketing/sem_paid_search.cfm##dynamic-inventory-retargeting">Dynamic Inventory Retargeting</a></li>
                                            <li><a href="/dealer/aspenmarketing/sem_paid_search.cfm##geo-targeting">Geo Targeting</a></li>
                                            <li><a href="/dealer/aspenmarketing/email_marketing.cfm">Email Marketing</a></li>
                                            <li><a href="/dealer/aspenmarketing/social_media.cfm">Social Media</a></li>
                                            <li><a href="/dealer/aspenmarketing/reputation_management.cfm">Reputation Management</a></li>
                                            <li><a href="/dealer/aspenmarketing/reputation_management.cfm##brand-analytics">Brand Analytics/Visibility</a></li>
										</ul>
                                  </div>
								</div><!-- /cbp-hrsub-inner -->
							</div><!-- /cbp-hrsub -->
						</li>
						
						<li>
							<a href="##">PORTFOLIO</a>
                          <div class="cbp-hrsub">
								<div class="cbp-hrsub-inner">
									<div>
										<!--- <h4><a href="/dealer/aspenmarketing/traditional_marketing.cfm">Traditional Marketing</a></h4> --->
										<ul>
											<li><a href="/dealer/aspenmarketing/broadcast_production.cfm##new-tv-commercials">New TV Commercials</a></li>
											<li><a href="/dealer/aspenmarketing/broadcast_production.cfm##used-tv-commercials">Used TV Commercials</a></li>
											<li><a href="/dealer/aspenmarketing/mail2web_programs.cfm">Mail2Web Programs</a></li>
                                            <li><a href="/dealer/aspenmarketing/print_production.cfm##new-vehicle-print-ads">New Print Ads</a></li>
                                            <li><a href="/dealer/aspenmarketing/print_production.cfm##used-vehicle-print-ads">Used Print Ads</a></li>
                                            </ul>
										</div>
									<div>
										<!--- <h4><a href="##">Digital Marketing</a></h4> --->
										<ul>
                                            <li><a href="/dealer/aspenmarketing/email_marketing.cfm">Email Marketing</a></li>
                                            <li><a href="/dealer/aspenmarketing/reputation_management.cfm">Reputation Management</a></li>
                                            <li><a href="/dealer/aspenmarketing/social_media.cfm">Social Media Management</a></li>
                                       		<li><a href="/dealer/aspenmarketing/responsive_websites.cfm##dealership-responsive-sites">Dealership Responsive Websites</a></li>
                                       		<li><a href="/dealer/aspenmarketing/responsive_websites.cfm##corporate-responsive-sites">Corporate Responsive Websites</a></li>
										</ul>
                                  </div>
								</div>
							</div>
						</li>
						<li>
							<a href="##">ABOUT</a>
							<div class="cbp-hrsub">
								<div class="cbp-hrsub-inner">
									<div>
										<h4><a href="/dealer/aspenmarketing/about_us.cfm">About World Dealer</a></h4>
										<ul>
											<li><a href="/dealer/aspenmarketing/about_us.cfm##testimonials">Testimonials</a></li>
                                            <li><a href="/dealer/aspenmarketing/careers.cfm">Careers</a></li>
                                            </ul>
										</div>
									<div>
										<h4><a href="/forms/contact.cfm">Contact Now!</a></h4>
										<ul>
                                       		<li><a href="tel:+18664858800">Toll Free: (866) 485-8800</a></li>
											<li><a href="tel:+17247597840">Local: (724) 759-7840</a></li>
                                            <li><a href="mailto:wdsupport@worlddealer.net?subject=Email Contact From WorldDealer.net">Email: wdsupport@worlddealer.net</a></li>
                                         </ul>
                                  </div>
								</div><!-- /cbp-hrsub-inner -->
							</div><!-- /cbp-hrsub -->
                        </li>
                        
                        <li ><a href="tel:+18664858800" style=" font-family: 'Jura', sans-serif; font-weight:bold!important;font-size:11pt!important; color: ##4261ad!important; padding-left: 30px!important;">CONTACT US! (866) 485-8800</a></li>
                        </ul>
				</nav>
                </div>
		</div>

</cfif>
	</cffunction>

</cfcomponent>