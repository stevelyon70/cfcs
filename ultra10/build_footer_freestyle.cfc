<cfcomponent>

	<cffunction name="modern" description="shows a standard footer" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfquery name="get_ftr_img" datasource="Ultra10">SELECT   wd_logo_img FROM   Dealers WHERE	Dealer_ID=#url.dealer_id#</cfquery>
		<cfset ftr_img = "#rtrim(get_ftr_img.wd_logo_img)#" >
		<cfif #len(ftr_img)# EQ 0 ><cfset use_ftr_img = 0><cfelse><cfset use_ftr_img = 1></cfif>
		
		<footer class="section-ftr" style="max-width:1350px!important">
			<div class="container row-ftr no-pad" style="max-width:1350px!important">
				<div class="row no-pad">
					<div style="background-color: ##000000; border-top:0px solid ##ffffff;">
					    <div style="margin-top:20px!important;">
					       	<center>
						   	<div class="row no-pad  visible-lg visible-md">
								<div class="col-md-12" align="center" >
									<img alt="#url.dealer_name#"  src="http://dealers.wdautos.com/dealer/baierlservice/images/icons/footer_logo.png" class="img-responsive" ></a>
								</div>
							</div>
						   	<div class="row no-pad  visible-lg visible-md">
								<div class="col-md-12" align="center" >
									 #arguments.dealer_name# &copy; #dateformat(now(),"yyyy")# 
								</div>
							</div>
						   	<div class="row no-pad  visible-lg visible-md">
								<div class="col-md-12" align="center"  style="margin-top:10px!important;margin-bottom:20px!important;">
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
							</div>	
						   </center>
						</div>
					</div>
				</div>
			</div>	
			
		</footer>
		
		
		
		
		
		
	</cffunction>
	
	<cffunction name="legacy" description="shows a standard footer" output="Yes" access="public">
	</cffunction>

</cfcomponent>
