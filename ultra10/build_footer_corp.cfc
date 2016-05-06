<cfcomponent>

	<cffunction name="modern" description="shows a standard footer" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		
		<footer class="section-ftr">
			<div class="container row-ftr no-pad">
				<div class="row no-pad">
					<div style="background-color: ##ffffff; border-top: 0px solid ##e2e2e2;">
 						<div class="FeaturedContent">
						    <div style="width:50%; margin:0 auto;margin-top:10 auto;">
						       <center>
							  	<cfif  #url.dealer_id# EQ 376  >
								    <div class="footer-link"><a href="/dealer/aspenmarketing/aspen_microsites.cfm"><img src="http://dealers.wdautos.com/dealer/aspenmarketing/images/icons/wd-logo1.png" width="100%" style="max-width: 150px;" alt="WorldDealer Retail Automotive Advertising"/></a></div>
						            <div class="footer-link"><a href="/dealer/aspenmarketing/careers.cfm">Careers</a></div>
	             					<div class="footer-link"><a href="sitemap.cfm">Site Map</a></div>
	             					<div class="footer-link"><a href="/dealer/aspenmarketing/about_us.cfm">About Us</a></div>
	             					<div class="footer-link"><a href="https://www.facebook.com/WorldDealer/" target="_blank"><img src="http://dealers.wdautos.com/dealer/aspenmarketing/images/icons/icon_facebook.jpg" width="20" alt=""/> </a><a href="https://twitter.com/world_dealer" target="_blank"><img src="http://dealers.wdautos.com/dealer/aspenmarketing/images/icons/icon_twitter.jpg" width="20" alt=""/> </a><a href="https://www.youtube.com/user/worlddealer"><img src="http://dealers.wdautos.com/dealer/aspenmarketing/images/icons/icon_youtube.jpg" width="20" alt=""/></a></div>
								</cfif>
							  	<cfif  #url.dealer_id# EQ 374  >
								    <div class="footer-link"><a href="/dealer/worlddealercorp/aspen_microsites.cfm"><img src="http://dealers.wdautos.com/dealer/worlddealercorp/images/icons/wd-logo1.png" width="100%" style="max-width: 150px;" alt="WorldDealer Retail Automotive Advertising"/></a></div>
						            <div class="footer-link"><a href="/dealer/worlddealercorp/careers.cfm">Careers</a></div>
	             					<div class="footer-link"><a href="sitemap.cfm">Site Map</a></div>
	             					<div class="footer-link"><a href="/dealer/worlddealercorp/about_us.cfm">About Us</a></div>
	             					<div class="footer-link"><a href="https://www.facebook.com/WorldDealer/" target="_blank"><img src="http://dealers.wdautos.com/dealer/worlddealercorp/images/icons/icon_facebook.jpg" width="20" alt=""/> </a><a href="https://twitter.com/world_dealer" target="_blank"><img src="http://dealers.wdautos.com/dealer/worlddealercorp/images/icons/icon_twitter.jpg" width="20" alt=""/> </a><a href="https://www.youtube.com/user/worlddealer"><img src="http://dealers.wdautos.com/dealer/worlddealercorp/images/icons/icon_youtube.jpg" width="20" alt=""/></a></div>
								</cfif>								
             					</center>
								 <div class="footer-link"></div>
             					<div class="footer-link"></p></div> 
							</div>
						</div>
					</div>
				</div>
			</div>	
			
		</footer>
		
		
		
		
		
		
	</cffunction>
	
	<cffunction name="legacy" description="shows a standard footer" output="Yes" access="public">
	</cffunction>

</cfcomponent>