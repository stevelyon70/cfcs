<cfcomponent>

	<cffunction name="modern" description="shows a standard footer" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		
		
		
		<cfif url.dealer_id eq 366>
        <footer class="section-ftr">
			<div class="container row-ftr">
				<div class="row no-pad visible-lg visible-md">
					<div class="col-md-4">
						<cfswitch expression="#url.dealer_id#">
							<cfdefaultcase>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</cfdefaultcase>
							<cfcase value="18,32,34,33,51,36,24,236,257"></cfcase> 
						</cfswitch>
					</div>
					<div class="col-md-3">
						<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0 and #dealer_id# NEQ 1 > 
							<a class="footer-pgtxt" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
						</cfif>
					</div>
					<div class="col-md-5  visible-lg visible-md" align="right">
						#arguments.dealer_name#  &copy; #dateformat(now(),"yyyy")#
					</div>					
				</div>
				<div class="row no-pad  visible-lg visible-md">
					<!--- <cfif #url.dealer_id# NEQ 288 > --->
					<div class="col-md-12" align="right" >
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
							</cfif> 
					</div>					
				</div>
                <div class="row visible-sm visible-xs padTopMargin15">
					<div class="col-md-12">
						<cfswitch expression="#url.dealer_id#">
							<cfdefaultcase>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="social-footer-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</cfdefaultcase>
							<cfcase value="18,32,34,33,51,36,24,236,257"></cfcase> 
						</cfswitch>
					</div>
                 </div>
              	 <div class="row visible-sm visible-xs padTopMargin15">
                 	<div class="col-md-12 visible-xs visible-sm" align="center">
							 #arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>                            
									<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>								
							</cfif> 
					</div>
                 </div>
                
			</div>
			<br><br>
		</footer>
        <cfelse>
		<footer class="section-ftr">
			<div class="container row-ftr">
				<div class="row no-pad">
					<div class="col-md-4">
						<cfswitch expression="#url.dealer_id#">
							<cfdefaultcase>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</cfdefaultcase>
							<cfcase value="18,32,34,33,51,36,24,236,257"></cfcase> 
						</cfswitch>
					</div>
					<div class="col-md-3">
						<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0 and #dealer_id# NEQ 1 > 
							<a class="footer-pgtxt" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
						</cfif>
					</div>
					<div class="col-md-5  visible-lg visible-md" align="right">
						<cfif #url.dealer_id# Neq 17 >
							 #arguments.dealer_name#  <cfif #url.dealer_id# eq 288 >a division of Lotus of Las Vegas</cfif> &copy; #dateformat(now(),"yyyy")# 
							<cfif #url.dealer_id# eq 288 >DLR41084</cfif>
						</cfif>	
					</div>
					<div class="col-md-4  visible-xs visible-sm" align="center">
						<cfif #url.dealer_id# Neq 17 >
							 #arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<cfif #url.dealer_id# Neq 371 >
									<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
								<cfelse>
									<a class="footer-pgtxt" href="http://worlddealer.net/dealer/worlddealernet/aspen_microsites.cfm"  ><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
								</cfif>	
							</cfif> 
						</cfif>	
					</div>
				</div>
				<div class="row no-pad  visible-lg visible-md">
					<!--- <cfif #url.dealer_id# NEQ 288 > --->
					<div class="col-md-12" align="right" >
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<cfif #url.dealer_id# Neq 371 >
									<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
								<cfelse>
									<a class="footer-pgtxt" href="http://worlddealer.net/dealer/worlddealernet/aspen_microsites.cfm"  ><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
								</cfif>	
							</cfif> 
					</div>
					<!--- <cfelse>
					<div class="col-md-4" align="left" style="background-color:##ffffff;margin-top:5px!important" >
							<img alt="WorldDealer"  src="http://dealers.wdautos.com/dealer/autobuysmart/images/icons/AutoBuySmart_FooterLogo.png" class="img-responsive" > 
					</div>
					<div class="col-md-8" align="right" style="background-color:##ffffff;padding-bottom:31px!important;margin-top:5px!important" >
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<cfif #url.dealer_id# Neq 371 >
									<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
								<cfelse>
									<a class="footer-pgtxt" href="http://worlddealer.net/dealer/worlddealernet/aspen_microsites.cfm"  ><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
								</cfif>	
							</cfif> 
					</div>
					</cfif> --->
				</div>
			</div>
			<br><br>
		</footer>
		</cfif>
		
		
		
		
		
	</cffunction>

	<cffunction name="modern_portal" description="Puts the header at the bottom of the screen on PORTAL sites" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		
		<footer class="section-ftr">
			<div class="container row-ftr">
				<div class="row no-pad">
					<div class="col-md-9">
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
							<cfinvokeargument name="template_id" value="#url.template_id#"/>
							<cfinvokeargument name="dealer_template_id" value="#url.dealer_template_id#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						</cfinvoke> 
					</div>
					<div class="col-md-3 " align="right">
						#arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
						<cfif #use_ftr_img# eq 0 >
							Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
						<cfelse>
							<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer,Inc" src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
						</cfif>
					</div>
				</div>
			</div>
			<br><br>
		</footer>
	</cffunction>

	<cffunction name="legacy" description="shows a standard footer" output="Yes" access="public">

		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		
		<div class="section-ftr">
			<div class="container row-ftr pad-top-10">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:50%">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="28"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="sm-link"/>
							</cfinvoke>
						</td>
						<td style="width:50%" align="right">
							#arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
						<cfif #use_ftr_img# eq 0 >
							Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
						<cfelse>
							<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer, Inc"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
						</cfif>
						</td>
					</tr>
				</table>
			</div>
		</div>

	</cffunction>

	<cffunction name="modern_center" description="shows a standard footer with sm centered" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		
	
		<footer class="section-ftr">
			<div class="container">
				<div class="row visible-md visible-lg">
					<div class="col-md-12 sm-footer-top" align="center">
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 sm-footer" align="center">
						<span class="sm-span">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="28"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="sm-link"/>
								<cfinvokeargument name="pull" value="left"/>
							</cfinvoke>
							<div class="clearfix"></div>
						</span>
					</div>
				</div>
			</div>
			<div class="container row-ftr">
				<div class="row pad-top-10">
					<div class="col-md-4">

					</div>
					<div class="col-md-4" align="center">
						<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0>
							<a class="footer-pgtxt" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
						</cfif>
					</div>
					<div class="col-md-4" align="right">
						#arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
						<cfif #use_ftr_img# eq 0 >
							Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
						<cfelse>
							<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer,Inc"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
						</cfif>
					</div>
				</div>
				
			</div>
			<br><br>
		</footer>

	</cffunction>

	<cffunction name="legacy_center" description="shows a standard footer with sm centered" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
	
		<footer class="section-ftr">
			<div class="container">
				<div class="row visible-md visible-lg">
					<div class="col-md-12 sm-footer-top" align="center">
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 sm-footer" align="center">
						<span class="sm-span">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="28"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="sm-link"/>
								<cfinvokeargument name="pull" value="left"/>
							</cfinvoke>
							<div class="clearfix"></div>
						</span>
					</div>
				</div>
			</div>
			<div class="container row-ftr">
				<div class="row pad-top-10">
					<div class="col-md-5">

					</div>
					<div class="col-md-4">
						<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0>
							<a class="footer-pgtxt" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
						</cfif>
					</div>
					<div class="col-md-3">
						#arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
						Website Powered by WorldDealer
					</div>
				</div>
			</div>
		</footer>

	</cffunction>

	<cffunction name="nissan_modern" description="shows a nissan compliant footer" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" required="true">
		<cfargument name="address_1" required="true">
		<cfargument name="address_2" required="true">
		<cfargument name="city" required="true">
		<cfargument name="state" required="true">
		<cfargument name="zip" required="true">
	  
	  
		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		
	  
	  
		  <cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0>
			
			<cfswitch expression="#url.dealer_id#">
					<cfdefaultcase>
						<div class="container">
							<div class="row nissan-ftr">
								<div class="col-md-12" align="right">
									<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0>
										<a class="nissan-ftr-link" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
									</cfif>
								</div>
							</div>
						</div>	
					</cfdefaultcase>
					<cfcase value="41">
						<div class="container-large">
							<div class="container">
								<div class="row nissan-ftr">
									<div class="col-md-12" align="right">
										<div class="col-md-6">
											<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
												<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
												<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
												<cfinvokeargument name="nav_type_id" value="28"/>
												<cfinvokeargument name="assets" value="#arguments.assets#"/>
												<cfinvokeargument name="element_class" value="sm-link"/>
												<cfinvokeargument name="pull" value="left"/>
											</cfinvoke>
										</div>
										<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0>
											<a class="nissan-ftr-link" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
										</cfif>
									</div>
								</div>
								</div>
							</div>
						</div>	
					</cfcase>
			</cfswitch>
		</cfif>
		
	
		<footer class="section-nissan-ftr">
			<div class="container">
				<div class="row nissan-ftr">
					<div class="col-md-6 visible-md visible-lg">
						<cfif #url.dealer_id# NEQ 365 >
								#arguments.address_1#
								#arguments.address_2#
								#arguments.city#
								#arguments.state#
								#arguments.zip#
						<cfelse>	
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>	
						</cfif>		
					</div>
					<div class="col-md-6 visible-sm visible-xs" style="margin-bottom:15px!important" align="center">
						<cfif #url.dealer_id# NEQ 365 >
								#arguments.address_1#
								#arguments.address_2#
								#arguments.city#
								#arguments.state#
								#arguments.zip#
						<cfelse>	
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>	
						</cfif>		
					</div>
					<div class="col-md-6 visible-md visible-lg">
						<div class="row pull-right">
							<a class="nissan-ftr-link" data-toggle="modal" data-target="##copyModal">Copyright</a>
							|<a class="nissan-ftr-link" href="http://#cgi.server_name#/forms/contact.cfm">Contact Us</a>
							<cfswitch expression="#url.dealer_id#">
								<cfdefaultcase>
									|<a class="nissan-ftr-link" href="http://#cgi.server_name#/finance/privacy.cfm">Privacy Statement</a>
								</cfdefaultcase>
								<cfcase value="18">
									|<a class="nissan-ftr-link" href="http://kellycar.com/dealer/kellycar/pdfs/privacy.pdf" target="_blank">Privacy Statement</a>
								</cfcase>
							</cfswitch>
							<a class="nissan-ftr-logo" href="http://www.nissanusa.com/" target="_blank"><img alt="Nissan"  src="http://#cgi.server_name#/images/oem/nissan/nissan_footer.png"/></a>
						</div>
					</div>
				</div>
					<div class="col-md-6 visible-sm visible-xs">
						<div class="row" align="center" style="margin-bottom:10px!important;margin-top:10px!important">
							<a class="nissan-ftr-link" data-toggle="modal" data-target="##copyModal">Copyright</a>
							|<a class="nissan-ftr-link" href="http://#cgi.server_name#/forms/contact.cfm">Contact Us</a>
							<cfswitch expression="#url.dealer_id#">
								<cfdefaultcase>
									|<a class="nissan-ftr-link" href="http://#cgi.server_name#/finance/privacy.cfm">Privacy Statement</a>
								</cfdefaultcase>
								<cfcase value="18">
									|<a class="nissan-ftr-link" href="http://kellycar.com/dealer/kellycar/pdfs/privacy.pdf" target="_blank">Privacy Statement</a>
								</cfcase>
							</cfswitch>
							<a class="nissan-ftr-logo" href="http://www.nissanusa.com/" target="_blank"><img alt="Nissan"  src="http://#cgi.server_name#/images/oem/nissan/nissan_footer.png"/></a>
						</div>
					</div>
				</div>
				<div class="row nissan-ftr">
					<div class="col-md-12 visible-md visible-lg" align="right">
						<cfif #use_ftr_img# eq 0 >
							Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
						<cfelse>
							<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
						</cfif> 
					</div>
					<div class="col-md-12 visible-sm visible-xs" align="center">
						<cfif #use_ftr_img# eq 0 >
							Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
						<cfelse>
							<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
						</cfif> 
					</div>
				</div>	
			</div>
			<br><br>
		</footer>
		<!--- Copyright Modal Window --->
		<cfinvoke component="/cfcs/ultra10/popups" method="nissan_copyright">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
		</cfinvoke>

	</cffunction>

	<cffunction name="nissan_legacy" description="shows a nissan compliant footer" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" required="true">
		<cfargument name="address_1" required="true">
		<cfargument name="address_2" required="true">
		<cfargument name="city" required="true">
		<cfargument name="state" required="true">
		<cfargument name="zip" required="true">

		<div class="section-ftr">
			<div class="container nissan-ftr pad-top-10">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:50%">
							#arguments.address_1#
							#arguments.address_2#
							#arguments.city#
							#arguments.state#
							#arguments.zip#	
						</td>
						<td style="width:50%" align="right">
							|<a class="nissan-ftr-link" href="##" onclick="openWin();">Copyright</a>
							|<a class="nissan-ftr-link" href="http://#cgi.server_name#/forms/contact.cfm">Contact Us</a>
							|<a class="nissan-ftr-link" href="http://#cgi.server_name#/finance/privacy.cfm">Privacy Statement</a>
							<a class="nissan-ftr-logo" href="http://www.nissanusa.com/" target="_blank"><img alt="Nissan" src="http://#cgi.server_name#/images/oem/nissan/nissan_footer.png" border="0"/></a>							
						</td>
					</tr>
				</table>
			</div>
		</div>
		<script>
		function openWin()
			{ var myWindow = window.open("","myWindow","width=200,height=100");
			  myWindow.document.write("The Nissan names, logos, product names, feature names, and slogans are trademarks owned by or licensed to Nissan Motor Co. Ltd. and/or Nissan North America, Inc. 2002-#dateformat(now(),'yyyy')# Nissan North America, Inc. All rights reserved. Materials contained on this Web site may not be used or reproduced without written permission from Nissan North America, Inc.");
			}
		</script>

	</cffunction>

	
	

</cfcomponent>