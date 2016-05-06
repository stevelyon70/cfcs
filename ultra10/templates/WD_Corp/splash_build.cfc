<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<!--- <cfargument name="page" required="true"> --->
		
	<!--- Video & Background --->	
		<cfset bkgrnd_on_off = 0 >
		<cfset poster = "" ><cfset mp4_vid = "" ><cfset webm_vid = "" ><cfset ogg_vid = "" ><cfset spkr = "" ><cfset autoplay = "" > 	
		<cfquery name="chk_bkgrnd" datasource="Ultra10">
			SELECT	background_image_mp4,background_image_webm,background_image_ogg,audio,autoplay,poster_image FROM    Dealer_Video_Background	WHERE dealer_id=#url.dealer_id# AND active=1 </cfquery>
		<cfif #chk_bkgrnd.recordcount# NEQ 0 >
			<cfset bkgrnd_on_off = 1 ><cfset poster="#chk_bkgrnd.poster_image#"><cfset mp4_vid="#chk_bkgrnd.background_image_mp4#"><cfset webm_vid="#chk_bkgrnd.background_image_webm#">
			<cfset ogg_vid="#chk_bkgrnd.background_image_ogg#"><cfset spkr="#chk_bkgrnd.audio#"><cfset autoplay="#chk_bkgrnd.autoplay#"> 	
		</cfif>
		<cfif #bkgrnd_on_off# eq 1 >
			 <div class="fullscreen-bg">
		    	    <video 	loop #spkr# #autoplay#  width="1900" poster="#poster#" class="fullscreen-bg__video" >
			            	<source id="mp4" src="#mp4_vid#" type="video/mp4"/>
				         <source id="webm" src="#webm_vid#"  type="video/webm"/>
	            			<source id="ogv" src="#ogg_vid#" type="video/ogg"/>  
	    			</video>
			</div>  
		</cfif>
	<!--- END Video & Background --->			
		
		
		<cfif NOT IsDefined("arguments.page") >
			<cfset arguments.page = 0 >
		</cfif>

 
		<cfinvoke component="/cfcs/ultra10/build_header_corp" method="#arguments.site_mode#">
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
		<cfif arguments.site_mode eq "modern">
			<cfif #url.dealer_id# NEQ 376 AND  #url.dealer_id# NEQ 374>
				<div container-fluid >
				<section class="section-subhdr visible-md visible-lg">
					<div class="container">
						<div class="row row-centered">
							<div class="col-centered">
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
				</div>			
			</cfif>
		</cfif>

<!--- <cfif #left(cgi.remote_addr,13)# eq "172.16.25.112" >  --->

					<!--- <div class="container-fluid">
						<cfinvoke component="/cfcs/ultra10/build_navigation_right" method="#arguments.site_mode#">
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
					</div> --->
<!--- </cfif> --->
		
		 
		 <cfset url.page_type = #arguments.page# > 
		<cfinvoke component="/cfcs/ultra10/templates/#url.template_id#/content_variable" method="#url.site_mode#">
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
		</cfinvoke>


		<cfinvoke component="/cfcs/ultra10/build_footer_corp" method="#url.site_mode#">
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

 

	
	</cffunction>

</cfcomponent>