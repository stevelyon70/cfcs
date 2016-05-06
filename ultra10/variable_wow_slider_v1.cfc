<cfcomponent>

	<cffunction name="wide" description="slideshow" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="pg_nbr" default=0>
 
 
		<!--- Check for Slider Bullets  --->
			<cfset bullets_trigger = 0 >
			<cfquery datasource="ultra10" name="Chk_site_search">SELECT Dealer_ID, ws_bullets_off FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
			<cfif #Chk_site_search.ws_bullets_off# EQ 1><cfset bullets_trigger = 1 ></cfif>
		<!--- Check for Slider Bullets  --->
	
 
		<cfquery datasource="ultra10" name="Get_Nav_Var" result="r1">
			SELECT     Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
    	                  Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
        	              Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
	                      Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
			FROM         navigation_var
			WHERE		Dealer_ID = #url.dealer_id#
				AND			Nav_Type_ID = #arguments.nav_type_id#
                and CONVERT(VARCHAR(10),Start_Date,120) <= CONVERT(VARCHAR(10),GETDATE(),120)
 				and CONVERT(VARCHAR(10),End_Date,120) >= CONVERT(VARCHAR(10),GETDATE(),120) 
				<!---AND GETDATE() between Start_Date AND End_Date 	--->
			<cfif #arguments.pg_nbr# EQ 4 >
				AND	Nav_Name like '%#arguments.car_make#%'
			</cfif>
			ORDER BY 	Hierarchy
		</cfquery>
        
		<cfset Get_Nav=Get_Nav_Var>
		
		<cfset variables.slide_count=0>
		<cfloop query="Get_Nav">
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
				<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
					<cfset variables.slide_count=variables.slide_count+1>
				</cfif>
			</cfif>
		</cfloop>
		<cfif variables.slide_count GTE 1>
        <!-- variable_wow_slider_v1 -->
		<div class="container-fluid ">
		<div class="row-centered no-pad">
			<div id="wowslider-container1"> 
				<div class="ws_images ">			<!--- removed col-centered --->
					<ul>
				
						<cfset variables.nav_count=0>
				
						<cfloop query="Get_Nav">
							
							<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
					
								<cfset variables.nav_count=variables.nav_count+1>
	
								<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
									</cfif>
								</cfif>

								<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
								<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>

								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1"> <!--- Direct Link --->
										<li>
											<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
											</a>
										</li>
									</cfcase>
									<cfcase value="2">	<!--- New Window --->
										<li>
											<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
											</a>
										</li>
									</cfcase>
									<cfcase value="3"> <!--- No Link --->
										<li>
											<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
										</li>
									</cfcase>
								</cfswitch>
							</cfif>
						</cfloop>
					</ul>
				</div>				
				<cfif #bullets_trigger# EQ 0 >
					 <div class="row-centered">	
						<!--- <cfif #url.dealer_id# NEQ 341><div style="background-color:##cb0101;min-height:30px;margin-left:15px;margin-right:15px"></cfif> --->
							<div class=" col-centered" style="align:center">
								<div class="ws_bullets"> 
									<div style="top:12px">
										<cfset variables.nav_count=0>
										<cfloop query="Get_Nav">
											<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
												<cfset variables.nav_count=variables.nav_count+1>
												<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
													<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
													<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>
													<a href="##" title="#variables.img_title#">#variables.nav_count#</a>
												</cfif>
											</cfif>
										</cfloop>					
									</div> 	 
								</div>
								<div class="ws_shadow"></div>
							</div>
						</div>
					</div> 
				</cfif>					
				 
			</div>  <!--- wowslider container --->
		</div>
		</div>  <!--- container-fluid --->
				
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/1600/engine1/wowslider.js"></script>'>
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/1600/engine1/script.js"></script>'>

		<cfelse>
	
			<cfloop query="Get_Nav">
				
				<cfset variables.nav_count=0>

				<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
		
					<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
						<cfset variables.nav_count=variables.nav_count+1>
		
						<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
							<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
						<cfelse>
							<cfif left(Get_Nav.Nav_Link,4) neq "http">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
							</cfif>
						</cfif>
		
						<cfset variables.img_title_ext=right(#Get_Nav.Nav_Image#,4)>
						<cfset variables.img_title=replace(Get_Nav.Nav_Image,"#variables.img_title_ext#","","all" )>
		
						<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
							<cfcase value="1">
								<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
								</a>
							</cfcase>
							<cfcase value="2">
								<a href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
								</a>
							</cfcase>
							<cfcase value="3">
								<img class="img-responsive" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" alt="#variables.img_title#" title="#variables.img_title#" id="wows1_#variables.nav_count-1#"/>
							</cfcase>
						</cfswitch>

					</cfif>

				</cfif>

			</cfloop>

		</cfif>
		
	</cffunction>

</cfcomponent>