<cfcomponent>

	<cffunction name="wide" description="slideshow" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
				
		<!---<cfoutput>#arguments.dealer_Id#</cfoutput> --->
		
		<!--- Check for Slider Bullets  --->
			<cfset bullets_trigger = 0 >
			<cfquery datasource="ultra10" name="Chk_site_search">SELECT Dealer_ID, ws_bullets_off FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
			<cfif #Chk_site_search.ws_bullets_off# EQ 1><cfset bullets_trigger = 1 ></cfif>
		<!--- Check for Slider Bullets  --->
		<!--- Check for Slider Bullets  --->
			<cfset exclude_optional = 0 >
			<cfquery datasource="ultra10" name="Chk_opt_excl">SELECT tdds_exclude_optional FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
			<cfif #Chk_opt_excl.tdds_exclude_optional# EQ 1><cfset exclude_optional = 1 ></cfif>
		<!--- Check for Slider Bullets  --->
	
		
		<cfquery datasource="ULTRA10" name="Get_Slides">
			SELECT		Distinct c.Nav_ID,
						c.Dealer_ID,
						c.Nav_Type_ID,
						c.Nav_Behaviour_ID,
						c.Nav_Name,
						c.width,
						c.height,
						c.Nav_Alt,
						c.Nav_Link,
						c.Nav_Mobile_Link,
						c.Nav_Image,					
						c.Hierarchy,
						c.From_Dealer,
						c.tmsomni_events_1,
						c.tmsomni_events_2,
						c.tmsomni_products_1,
						c.tddslink,
						c.tddsRequired,
						c.ImageSearchTerms
			FROM		CAMNAVIGATION c												
			WHERE	c.Dealer_ID = #arguments.dealer_id#  
			<cfif #exclude_optional# EQ 1 >
			    AND ( c.tddsRequired != 'false'  OR c.tddsRequired is NULL )  
			</cfif>	
		 	  AND ( GETDATE() >= c.Start_Date AND GETDATE() <= c.End_Date )	     
			order BY Hierarchy ASC
			
			<!---
			 AND c.width = 1024 AND c.height = 320 AND Nav_Name LIKE '%1024x320%'
			 AND c.width = 960 AND c.height = 298 
			--->
		</cfquery>
		
	
		<cfset variables.slide_count=0>
		
		<cfloop query="Get_Slides">
			<cfif Get_Slides.Nav_Type_ID eq arguments.nav_type_id>
				<cfif len(trim(Get_Slides.Nav_Image)) gt 0>
					<cfset variables.slide_count=variables.slide_count+1>					
				</cfif>
			</cfif>
		</cfloop>
		
				
		<!--- <cfif variables.slide_count gt 1> --->
		
			<div id="wowslider-container1" >
			<br />
				<div class="ws_images" >
				
					<ul >
				
						<cfset variables.nav_count=0>
				
						<cfloop query="Get_Slides">
							
							<cfif Get_Slides.Nav_Type_ID eq arguments.nav_type_id>
					
								<cfset variables.nav_count=variables.nav_count+1>
	
								<cfif left(Get_Slides.Nav_Link,4) eq "http">
									<cfset Get_Slides.Nav_Link="#lcase(Get_Slides.Nav_Link)#">
								<cfelse>
									<cfif Get_Nav.Nav_Link neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
									</cfif>
								</cfif> 

								<cfset variables.img_title_ext=right(#Get_Slides.Nav_Image#,4)>
                                <cfif len(variables.img_title_ext)>
									<cfset variables.img_title=replace(Get_Slides.Nav_Image,"#variables.img_title_ext#","","all" )>
                                </cfif>

								<cfswitch expression="#Get_Slides.Nav_Behaviour_ID#">
									
									<cfcase value="1">
										<li>
										<cfif #Get_Slides.From_Dealer# eq "1" >
										
											<a href="#Get_Slides.Nav_Link#" alt="#Get_Slides.Nav_Alt#" title="#Get_Slides.Nav_Alt#" "onClick="
                                                   var s=s_gi('tdds-prod'); 
                                                    tmsomni.linkTrackVars = "#Get_Slides.Nav_Name#,img,mr;events";
													tmsomni.linkTrackVars = "#Get_Slides.tmsomni_products_1#,evar43,evar49;events"; 
                                                    tmsomni.linkTrackEvents = "#Get_Slides.tmsomni_events_1#";
                                                    tmsomni.products = "#Get_Slides.Nav_Name#;;;#Get_slides.tmsomni_events_1#=1";
                                                    tmsomni.events = "#Get_Slides.tmsomni_events_1#,#Get_Slides.tmsomni_events_2#";
													tmsomni.required = "#Get_Slides.tddsRequired#";
                                                    s.tl(#Get_Slides.Nav_Link#,'o',' #Get_Slides.tddslink#');"">                               																								
											<img class="img-responsive" src="#Get_Slides.Nav_Image#"  alt="#Get_Slides.ImageSearchTerms#" title="#Get_Slides.Nav_Alt#" id="wows1_#variables.nav_count-1#"/>
											</a>											
										<cfelse>										
											<a href="#Get_Slides.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Slides.Nav_Image#"  alt="#Get_Slides.ImageSearchTerms#" title="#Get_Slides.Nav_Alt#" id="wows1_#variables.nav_count-1#"/>
											</a>
											
										</cfif>											
										</li>
									</cfcase>
									
									<cfcase value="2">
										<li>
										<cfif #Get_Slides.From_Dealer# eq "1" >
											<a href="#Get_Slides.Nav_Link#" target="_blank" alt="#Get_Slides.Nav_Alt#" title="#Get_Slides.Nav_Alt#" "onClick="
                                                   var s=s_gi('tdds-prod'); //For production use tdds-prod
                                                    tmsomni.linkTrackVars = "#Get_Slides.Nav_Name#,img,mr;events";
													tmsomni.linkTrackVars = "#Get_Slides.tmsomni_products_1#,evar43,evar49;events"; //products
                                                    tmsomni.linkTrackEvents = "#Get_Slides.tmsomni_events_1#";
                                                    tmsomni.products = "#Get_Slides.Nav_Name#;;;#Get_slides.tmsomni_events_1#=1";
                                                    tmsomni.events = "#Get_Slides.tmsomni_events_1#,#Get_Slides.tmsomni_events_2#";
													tmsomni.required = "#Get_Slides.tddsRequired#";
                                                    s.tl(#Get_Slides.Nav_Link#,'o',' #Get_Slides.tddslink#');"">                                                    	
												<img class="img-responsive" src="#Get_Slides.Nav_Image#" alt="#Get_Slides.ImageSearchTerms#" title="#Get_Slides.Nav_Alt#" width="1024" height="320" />
												</a>
										<cfelse>
											<a href="#Get_Slides.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank" id="wows1_#variables.nav_count-1#">
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Slides.Nav_Image#"     alt="#Get_Slides.ImageSearchTerms#" title="#Get_Slides.Nav_Alt#" id="wows1_#variables.nav_count-1#"/>
											</a>
										</cfif>									
											
										</li>
									</cfcase>
									
									
									<cfcase value="3">
										<li>
											<cfif #Get_Slides.From_Dealer# eq "1" >
												<img class="img-responsive" alt="#Get_Slides.ImageSearchTerms#" src="#Get_Slides.Nav_Image#" title="#Get_Slides.Nav_Alt#" id="wows1_#variables.nav_count-1#" />
											<cfelse>
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Slides.Nav_Image#"    alt="#Get_Slides.ImageSearchTerms#" title="#Get_Slides.Nav_Alt#" id="wows1_#variables.nav_count-1#"/>
											</cfif>
										</li>
									</cfcase>
									
								</cfswitch>
							</cfif>
						</cfloop>
					</ul>
					
				</div>
				<cfif  #bullets_trigger# EQ 0 >	 						
				<div class="ws_bullets">
					<div style="top:25px">
						<cfset variables.nav_count=0>
						<cfloop query="Get_Slides">
							<cfif Get_Slides.Nav_Type_ID eq arguments.nav_type_id>
								<cfset variables.nav_count=variables.nav_count+1>
								<cfif len(trim(Get_Slides.Nav_Image)) gt 0>
									<cfset variables.img_title_ext=right(#Get_Slides.Nav_Image#,4)>
									<cfset variables.img_title=replace(Get_Slides.Nav_Image,"#variables.img_title_ext#","","all" )>
									<a href="##" title="#variables.img_title#">#variables.nav_count#</a>
								</cfif>
							</cfif>
						</cfloop>
					</div>
				</div>
				<div class="ws_shadow"></div>
				</cfif>
			</div>

			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript"   src="http://#cgi.server_name#/wowslider/880/engine1/wowslider.js"></script>'>
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript"   src="http://#cgi.server_name#/wowslider/880/engine1/script.js"></script>'>

		<!---<cfelse>
	
			<cfloop query="Get_Slides">
				
				<cfset variables.nav_count=0>

				<cfif Get_Slides.Nav_Type_ID eq arguments.nav_type_id>
		
					<cfif len(trim(Get_Slides.Nav_Image)) gt 0>
						<cfset variables.nav_count=variables.nav_count+1>
		
						<cfif Get_Slides.Nav_Link eq "index.cfm" or len(trim(Get_Slides.Nav_Link )) eq 0>
							<cfset Get_Slides.Nav_Link="http://#lcase(cgi.server_name)#">
						<cfelse>
							<cfif left(Get_Slides.Nav_Link,4) neq "http">
								<cfset Get_Slides.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Slides.Nav_Link)#">
							</cfif>
						</cfif>
		
						<cfset variables.img_title_ext=right(#Get_Slides.Nav_Image#,4)>
						<cfset variables.img_title=replace(Get_Slides.Nav_Image,"#variables.img_title_ext#","","all" )>
		
						<cfswitch expression="#Get_Slides.Nav_Behaviour_ID#">
							<cfcase value="1">
								<a href="#Get_Slides.Nav_Link#" title="#Get_Slides.Nav_Alt#">
									*<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Slides.Nav_Image#" border="0"  alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
								</a>
							</cfcase>
							<cfcase value="2">
								<a href="#Get_Slides.Nav_Link#" title="#Get_Slides.Nav_Alt#" target="_blank">
									**<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Slides.Nav_Image#" border="0"  alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
								</a>
							</cfcase>
							<cfcase value="3">
								***<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Slides.Nav_Image#"  border="0" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
							</cfcase>
						</cfswitch>

					</cfif>

				</cfif>

			</cfloop>

		</cfif> --->
		
	</cffunction>

</cfcomponent>