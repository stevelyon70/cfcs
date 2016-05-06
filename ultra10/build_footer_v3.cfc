<cfcomponent>

	<cffunction name="modern" description="shows a standard footer" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		<div class="container-fluid">
		<footer class="section-ftr">
			<div class="container row-ftr"> 
				 <div class="row">
					<div class="col-md-12 pad-bot-10  visible-lg visible-md">
						<div class="gradient"></div>		
					</div>
				</div>	  
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
							<cfcase value="32,34,33,51,36,24,82,233"></cfcase> 
						</cfswitch>
					</div>
					<div class="col-md-4">
						<cfif len(trim(Get_Meta_Info.legacy_page_text)) gt 0> 
							<a class="footer-pgtxt" href="##" data-toggle="modal" data-target="##pgtxtModal">More About #arguments.dealer_name#</a>
						</cfif>
					</div>
					<div class="col-md-4  visible-lg visible-md" align="right">
						<cfif #url.dealer_id# Neq 17 >
							 #arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
							</cfif> 
						</cfif>	
					</div>
					<div class="col-md-4  visible-xs visible-sm" align="center">
						<cfif #url.dealer_id# Neq 17 >
							 #arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
							</cfif> 
						</cfif>	
					</div>
				</div>
				<cfif #url.dealer_id# eq 17 >
					<div class="row no-pad">
						<div class="col-md-6">
							<img src="http://12ultra10.wddemos.com/dealer/kellycar/images/icons/kelly_logo_opt1_off.png" class="img-responsive" border="0">
						</div>
						<div class="col-md-6" align="right">
							#arguments.dealer_name# &copy; #dateformat(now(),"yyyy")#<br/>
							<cfif #use_ftr_img# eq 0 >
								Website Powered by <a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank">WorldDealer</a>
							<cfelse>
								<a class="footer-pgtxt" href="http://www.worlddealer.net" target="_blank"><img alt="WorldDealer"  src="http://dealers.wdautos.com/images/wd_logos/#ftr_img#" class="img-responsive" ></a>
							</cfif>
						</div>
					</div>
				</cfif>
			</div>
			<br><br>
		</footer>
	</div>	

		
		
		
	</cffunction>

	<cffunction name="legacy" description="shows a standard footer" output="Yes" access="public">


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
					<div class="col-md-12 wd-ftr" align="center">
						WorldDealer, Inc.
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 wd-ftr" align="center">
						101 North Meadows Dr. | Wexford, PA 15106
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 wd-ftr" align="center">
						(866) 485-8800
					</div>
				</div>
			</div>
			
			<br><br>
		</footer>

	</cffunction>

	<cffunction name="legacy_center" description="shows a standard footer with sm centered" output="Yes" access="public">

	</cffunction>

	<cffunction name="nissan_modern" description="shows a nissan compliant footer" output="Yes" access="public">

	</cffunction>

	<cffunction name="nissan_legacy" description="shows a nissan compliant footer" output="Yes" access="public">

	</cffunction>

	
	

</cfcomponent>