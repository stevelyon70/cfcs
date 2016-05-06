<cfcomponent>

<!--- Dealer ID 370 is a PORTAL SITE. There is NO HEADER, NAVIGATION, LINKS or FOOTER 02/09/2016 --->

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

<cfif #url.dealer_id# NEQ 374 > 		<!--- Header OFF for WorldDealer Site 02/24/2016  --->

		 
<cfif #url.dealer_id# NEQ 198 AND  #url.dealer_id# NEQ 302  AND  #url.dealer_id# NEQ 336  AND  #url.dealer_id# NEQ 17 
		AND  #url.dealer_id# NEQ 365 AND  #url.dealer_id# NEQ 233  AND  #url.dealer_id# NEQ 341   AND  #url.dealer_id# NEQ 24   
			AND  #url.dealer_id# NEQ 82   AND  #url.dealer_id# NEQ 46   AND  #url.dealer_id# NEQ 370   AND  #url.dealer_id# NEQ 162  AND  #url.dealer_id# NEQ 32   >
		<cfinvoke component="/cfcs/ultra10/build_header_full" method="#arguments.site_mode#">
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
<cfif  (#url.dealer_id# EQ 233 AND  #cgi.server_name# EQ "11ultra10.wddemos.com")  OR  
			 #url.dealer_id# EQ 82 OR  #url.dealer_id# EQ 365  OR  #url.dealer_id# EQ 32    OR  #url.dealer_id# EQ 46      >
		<cfinvoke component="/cfcs/ultra10/build_header_full_v1" method="#arguments.site_mode#">
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
			<cfif #url.dealer_id# NEQ 365 AND #url.dealer_id# NEQ 32 AND  #url.dealer_id# NEQ 358 >
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
	</cfif>	




		
		<cfquery datasource="Ultra10" name="Chk_Nav">
			SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
			FROM    Variable_template_dealer_layout
			WHERE	dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#">
			AND		module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="19">
			and	page_type = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.page#">
			AND		active = 1
		</cfquery>
		<cfif #Chk_Nav.recordcount# EQ 0 >
			<cfset disp_nav = 0 >
			<cfset contain_nav = 0 >	
		<cfelse>
			<cfif #Chk_Nav.variable_spl2# EQ 0  >
				<cfset disp_nav = 1 >	
				<cfset contain_nav = #Chk_Nav.variable_spl1# >	
			<cfelseif #Chk_Nav.variable_spl2# EQ 1  >
				<cfset disp_nav = 0 >	
				<cfset contain_nav = #Chk_Nav.variable_spl1# >		
			<cfelseif #Chk_Nav.variable_spl2# EQ 2  >
				<cfset disp_nav = 0 >	
				<cfset contain_nav = 0 >		
			</cfif>
		</cfif>
		
		<!--- <cfinclude template="section_utility_1.cfm"> Caused a spae between header and wowslider 02-11-2016  --->
		
	<cfif #url.dealer_id# NEQ 198 AND #url.dealer_id# NEQ 341 AND  #url.dealer_id# NEQ 365 AND  #url.dealer_id# NEQ 32    AND #url.dealer_id# NEQ 370  >
			
		<cfif #disp_nav# EQ 1 >
				<cfif #url.dealer_id# NEQ 311 and #url.dealer_id# NEQ 341 >
		<cfif #url.dealer_id# eq 162 or  #url.dealer_id# eq 383 ><div class="container-fluid" ></cfif>	
					<cfif #contain_nav# EQ 1 ><div class="container"></cfif>
						<cfinvoke component="/cfcs/ultra10/build_navigation" method="#arguments.site_mode#">
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
					<cfif #contain_nav# EQ 1 ></div></cfif>
			<cfif #url.dealer_id# eq 162  or  #url.dealer_id# eq 383 ></div></cfif>			
				<cfelse>
					
					<cfif #contain_nav# EQ 1 ><div class="container-fluid"></cfif>
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
					<cfif #contain_nav# EQ 1 ></div></cfif>
				</cfif>
		</cfif>
		
	</cfif>

</cfif>		<!--- Header OFF for WorldDealer Site 02/24/2016  --->

		
		<!--- <cfset url.ss_type = 3> --->
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



<cfif #url.dealer_id# NEQ 374 >		<!--- Footer OFF for WorldDealer Site 02/24/2016  --->


		
	<cfif #url.dealer_id# NEQ 198  AND  #url.dealer_id# NEQ 302    AND  #url.dealer_id# NEQ 296    AND  
			#url.dealer_id# NEQ 17   AND  #url.dealer_id# NEQ 341    AND  #url.dealer_id# NEQ 233    
				AND  #url.dealer_id# NEQ 24     AND  #url.dealer_id# NEQ 82     AND  #url.dealer_id# NEQ 365   AND  #url.dealer_id# NEQ 370    
					AND  #url.dealer_id# NEQ 374     AND  #url.dealer_id# NEQ 358    AND  #url.dealer_id# NEQ 162    AND  #url.dealer_id# NEQ 383       >

		<cfinvoke component="/cfcs/ultra10/build_footer" method="#url.site_mode#">
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
		<cfquery name="chk_about" datasource="Ultra10">
			SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
			FROM    Variable_template_dealer_layout
			WHERE	dealer_id = #url.dealer_id#
			AND		page_type = #arguments.page#
			AND		active = 1
			ORDER BY  hierarchy ASC
		</cfquery>
		<cfif #chk_about.recordcount# EQ 1 >
			<cfset pg_nbr = #arguments.page# >
	 		<cfinclude template="section_about_us.cfm"> 
		</cfif>
			
	</cfif>
	
	<cfif #url.dealer_id# eq 365 >
	
		<cfinvoke component="/cfcs/ultra10/build_footer" method="nissan_#url.site_mode#">
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
	</cfif>
	<cfif #url.dealer_id# eq 296 OR  #url.dealer_id# eq 383 >
	
		<cfinvoke component="/cfcs/ultra10/build_footer" method="#url.site_mode#">
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
	</cfif>
	
	
	<cfif #url.dealer_id# EQ 302>
		<cfinvoke component="/cfcs/ultra10/build_footer" method="modern_portal">
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
	</cfif>
	<cfif #url.dealer_id# EQ 17>
		<cfinvoke component="/cfcs/ultra10/build_footer_v1" method="modern">
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
	</cfif>
	<cfif #url.dealer_id# EQ 341 or  #url.dealer_id# EQ 233 or  #url.dealer_id# EQ 24 or  #url.dealer_id# EQ 82>
		<cfinvoke component="/cfcs/ultra10/build_footer_v2" method="modern">
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
	</cfif>
	
	
	<cfif #url.dealer_id# EQ 162>
	<div class="container-fluid">
		<cfinvoke component="/cfcs/ultra10/build_footer_freestyle" method="#url.site_mode#">
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
	</div>	
	</cfif>	
	
	
	<cfif #url.dealer_id# EQ 374>
		<cfinvoke component="/cfcs/ultra10/build_footer_v3" method="modern_center">
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
	</cfif>
	
</cfif>		<!--- Footer OFF for WorldDealer Site 02/24/2016 --->


	
	</cffunction>

</cfcomponent>