<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		
	<!--- Check for Toyota Dealer  --->
		<cfset ss_trigger = 0 >
		<cfquery datasource="ultra10" name="Chk_tdds">SELECT Dealer_ID,	OEM_Key, TDDS, TDDS_region,	TDDS_tda,TDDS_district,	TDDS_autogroup FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfif #Chk_tdds.TDDS# EQ 1><cfset ss_trigger = 1 ></cfif>
	<!--- Check for Toyota Dealer  --->
	
	<!--- Carousel Type --->
		<cfquery datasource="ultra10" name="Chk_BX">SELECT Dealer_ID,bxs_new_used FROM Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfif #Chk_BX.bxs_new_used# eq 0><cfset variables.bx_type = "U" ><cfelse><cfset variables.bx_type = "N" ></cfif>
	<!--- Carousel Type --->
	
		<section class="section-spl">
			<div class="container">
				<div class="row">
					<div class="col-md-3 pad-top-10 visible-md visible-lg">
						<ul class="nav nav-tabs spl-tabs">
							<li class="active"><a href="##srch" data-toggle="tab">Search</a></li>
							<li><a href="##qq" data-toggle="tab" <cfif url.dealer_id EQ 37> onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(true, 'o', 'quickquote');" </cfif>>Get A Quick Quote</a></li>
						</ul>
						<div class="tab-content srch-tabs">
							<div class="tab-pane active" id="srch">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="none"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="42"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="srch-links-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
							<div class="tab-pane" id="qq">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="none"/>
									<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
							</div>
						</div>
					</div>
					<div class="col-md-9 pad-top-10">
						<div class="row  visible-sm visible-xs">
							<div class="col-md-12">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="13"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-tools-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row">
						 <!---<cfif #arguments.dealer_id# eq 12>
						<cfoutput>#url.dealer_Id#**</cfoutput>--->						 
				  <cfif #ss_trigger# eq 1 >   				  
                            <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  <cfelse>
                            <cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  </cfif>
						</div>
						<div class="row visible-sm visible-xs">
							<div class="col-md-12">
								<br/><br/>
								<cfif #url.dealer_id# NEQ 330 >
									<div class="spl-search-title"align="center" title="CAR FINDER">CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
										<cfinvokeargument name="form_id" value="carfinderFormMbl"/>
									</cfinvoke>
								<cfelse>
									<div class="spl-search-title-mbl"align="center" title="CAR FINDER">CAR FINDER</div>			<!--- internatautoboise --->
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search_mbl">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
										<cfinvokeargument name="form_id" value="carfinderFormMbl"/>
									</cfinvoke>
								</cfif>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<br/>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="container visible-md visible-lg">
				<div class="row">
					<div class="col-md-12  pad-top-10" align="center">
					 <cfif #url.dealer_id# EQ 17 >
					
						<cfquery name="Get_Assigned_OEMs" datasource="Ultra10" >
							SELECT  Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
    	                			Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
	    	                  		Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
	        	              		Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, old_nav_id
							FROM    Navigation
							WHERE   (Dealer_ID = 17) AND (Nav_Type_ID = 41)
							ORDER BY Hierarchy ASC
						</cfquery>
						<cfset nbr_col = "12" >
						<cfif #Get_Assigned_OEMs.recordcount# NEQ 0>
							<div class="row pad-top-10  ">
									<div class="col-md-12  pad-top-10 pad-bottom-10 "   <!---  style="border:1px solid"  --->    align="left">
									<ul>
								<cfloop query="Get_Assigned_OEMs" >
									  <cfif #Get_Assigned_OEMs.Hierarchy# EQ 10 >
										   <br><br>
									  </cfif>
									<li style="display: inline-block;" >
									 <cfif  #len(Get_Assigned_OEMs.Nav_Image)# gt 0 >
									 	<a href="#Get_Assigned_OEMs.Nav_Link#" target="_blank"><img  alt="#Get_Assigned_OEMs.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Assigned_OEMs.Nav_Image#" class="img-responsive" ></a>
									 <cfelse>
									 	#Get_Assigned_OEMs.Nav_Name#
									 </cfif> 
									 </li>
									  <cfif #Get_Assigned_OEMs.Hierarchy# NEQ 9 >
										  &nbsp;&nbsp;&nbsp;&nbsp; 
									  </cfif>
								</cfloop>
								</ul>
									</div>
							</div>
							
						</cfif>		
					<cfelse> 
							 
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="41"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke> 
						 
					</cfif>	 
				<!--- <div class="row">
					<div class="col-md-12  pad-top-10" align="center">&nbsp;
					</div>
				</div>	 --->
						
					</div>
				</div>
			</div>
			
			<cfif #url.dealer_id# NEQ 35 AND  #url.dealer_id# NEQ 17>
			<div class="container">
				<div class="row visible-md visible-lg">
					<div class="col-md-12  visible-md visible-lg" align="left">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="31"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-row"/>
						</cfinvoke>
					</div>
				</div>
			</div>
			</cfif>
			<cfif #url.dealer_id# EQ 35 OR  #url.dealer_id# EQ 17 >
				<div class="container">
					<div class="row visible-sm visible-xs">
						<div class="col-md-12 visible-sm visible-xs" align="left">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="31"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-row"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</cfif>
			
<!--- removed 09-24-2015 --->
			<!--- <cfinvoke component="/cfcs/ultra10/splash_form" method="modern_trade">
				<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
				<cfinvokeargument name="nav_type_id" value="44"/>
				<cfinvokeargument name="assets" value="#arguments.assets#"/>
				<cfinvokeargument name="element_class" value="splash-form-img"/>
				<cfinvokeargument name="input_class" value="splash-form-input"/>
				<cfinvokeargument name="btn_pull" value="pull-right"/>
			</cfinvoke> --->

			<div class="container visible-md visible-lg">
				<div class="row">
					<div class="col-md-12 pad-top-10 visible-md visible-lg">
						<cfinvoke component="/cfcs/ultra10/splash_reviews" method="#url.site_mode#_standard">
						</cfinvoke>
					</div>
				</div>
			</div>			
		
		</section>

		<section class="section-offers">
			<div class="container">
				<div class="row visible-sm visible-xs">
					<div class="col-md-12 pad-10">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="43"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="spl-special-ofr-link"/>
							<cfinvokeargument name="glyph_right" value="true"/>
						</cfinvoke>
					</div>
				</div>
				<cfif #url.dealer_id# NEQ 178 AND
						  #url.dealer_id# NEQ 89 AND  
						  	#url.dealer_id# NEQ 167 AND
						  		#url.dealer_id# NEQ 86  AND
						  			#url.dealer_id# NEQ 171  AND
						  				#url.dealer_id# NEQ 169   AND
							  				#url.dealer_id# NEQ 170   AND
							  					#url.dealer_id# NEQ 172  AND
							  						#url.dealer_id# NEQ 181  AND
								  						#url.dealer_id# NEQ 168  AND
								  							#url.dealer_id# NEQ 73  AND
								  								#url.dealer_id# NEQ 85  AND
								  									#url.dealer_id# NEQ 76 AND
								  										#url.dealer_id# NEQ 180 AND
								  											#url.dealer_id# NEQ 88 AND
								  												#url.dealer_id# NEQ 87 AND
								  												#url.dealer_id# NEQ 373   >  <!--- Fuccillo Portal increase the number of featured vehicles to 3 and shrink the Special Offers box --->
					<div class="row">
						<div class="col-md-5 pad-10 visible-md visible-lg">
							<div class="spl-special_offers">
								<div class="spl-special-title-top">Special Offers</div>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="43"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-special-ofr-link"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
						</div>
						<div class="col-md-7 pad-10">
							<div title="#arguments.dealer_name# FEATURED VEHICLES" class="pad-bot-10"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">FEATURED VEHICLES</span>  <span><a href="" class="btn btn-primary pull-right" id="bxslider_view_more_btn">View more</a></span><!------></div>
							<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
                            <!-- bxslider 1 on sol content splash -->
								<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="new_used" value="U"/>
									<cfinvokeargument name="minSlides" value="2"/>
									<cfinvokeargument name="maxSlides" value="12"/>
									<cfinvokeargument name="slideWidth" value="300"/>
									<cfinvokeargument name="slideMargin" value="35"/>
									<cfinvokeargument name="carousel_class" value="fv-carousel"/>
								</cfinvoke>
							</div>
						</div>
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-4 pad-10 visible-md visible-lg">
							<div class="spl-special_offers">
								<div class="spl-special-title-top">Special Offers</div>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="43"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-special-ofr-link"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
						</div>
						<div class="col-md-8 pad-10">
								
							<div title="#arguments.dealer_name# FEATURED VEHICLES" class="pad-bot-10"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">FEATURED VEHICLES</span>
							<span><cfif #url.dealer_id# NEQ 264 and  #url.dealer_id# NEQ 265 and url.dealer_id neq 76 and url.dealer_id neq 373>	<a href="" class="btn btn-primary pull-right" id="bxslider_view_more_btn">View more</a></cfif>
							<cfif #url.dealer_id# EQ 373>	<a href="new" class="btn btn-primary pull-right" <!--- id="bxslider_view_more_btn" --->>View more</a></cfif>   <!--- 03-17-2016  --->
							</span></div>
						
						 <!--- <cfif #url.dealer_id# eq 373 > 
							<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
								<cfinvoke component="/cfcs/ultra10/bxslider" method="v_specials_legacy">
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="new_used" value="#variables.bx_type#"/>
									<cfinvokeargument name="minSlides" value="3"/>	
									<cfinvokeargument name="maxSlides" value="12"/>
									<cfinvokeargument name="slideWidth" value="300"/>
									<cfinvokeargument name="slideMargin" value="35"/>
									<cfinvokeargument name="carousel_class" value="fv-carousel"/>
								</cfinvoke>
							</div>
						<cfelse> --->
							<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
                            <!-- bxslider 2 on sol content splash -->
								<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="new_used" value="#variables.bx_type#"/>
									<cfinvokeargument name="minSlides" value="3"/>	
									<cfinvokeargument name="maxSlides" value="12"/>
									<cfinvokeargument name="slideWidth" value="300"/>
									<cfinvokeargument name="slideMargin" value="35"/>
									<cfinvokeargument name="carousel_class" value="fv-carousel"/>
								</cfinvoke>
							</div>
						<!--- </cfif>	 --->
						</div>
					</div>
				</cfif>
			</div>
		</section>

		<section class="section-video">
			<div class="container">
				<div class="row">
					<div class="col-md-6 pad-10 visible-md visible-lg" align="center">				
						<cfif #url.dealer_id# NEQ 249  and  #url.dealer_id# NEQ 330>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="38"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
							</cfinvoke>
						<cfelse>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
						</cfif>
						
					</div>
					<div class="col-md-6 pad-10">
						<div class="spl-td">
							<div class="spl-td-title" title="Schedule a Test Drive">Schedule a Test Drive</div>
							<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_td">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="btn_pull" value="pull-right"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/forms/test_drive_action.cfm"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<!--- About Us Text Area --->		
				<cfinclude template="section_about_us.cfm" >
				

		<section class="section-links">
			<div class="container pad-top-10">
				<div class="row pad-top-10">
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="7"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="8"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="9"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="10"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
				</div>
			</div>			
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	<!--- Check for Toyota Dealer  --->
		<cfset ss_trigger = 0 >
		<cfquery datasource="ultra10" name="Chk_tdds">SELECT Dealer_ID,	OEM_Key, TDDS, TDDS_region,	TDDS_tda,TDDS_district,	TDDS_autogroup FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfif #Chk_tdds.TDDS# EQ 1><cfset ss_trigger = 1 ></cfif>
	<!--- Check for Toyota Dealer  --->
	
		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:290px;padding:5px 5px 5px 5px;" valign="top">
						
						
						
							<div>
								<div style="padding-top:5px">
									<div class="spl-search-name">#arguments.dealer_name#</div>
									<!--- <div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
									</cfinvoke>
								</div> --->
							</div>
						</td>
						<td class="pad-top-10" style="width:785px" valign="top">
				 <cfif #ss_trigger# eq 999 > 				  
                            <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  <cfelse>
                            <cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
                                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                                <cfinvokeargument name="nav_type_id" value="3"/>
                                <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            </cfinvoke>
                  </cfif>
							<!---<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>--->
							<br/><br/>
						</td>
					</tr>
				</table>
			</div>
			<div class="container">
				<div class="row splash-logos-row-leg">
					<div class="col-md-12 no-pad" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="41"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons-leg"/>
							<cfinvokeargument name="pull" value="left"/>
						</cfinvoke>
					</div>
				</div>
			</div>
			<div class="container pad-top-10">
				<cfinvoke component="/cfcs/ultra10/splash_form" method="legacy_trade">
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="nav_type_id" value="44"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="element_class" value="splash-form-img"/>
					<cfinvokeargument name="input_class" value="splash-form-input"/>
					<cfinvokeargument name="btn_pull" value="pull-right"/>
				</cfinvoke>
			</div>
			<div class="container pad-top-10">
				<cfinvoke component="/cfcs/ultra10/splash_reviews" method="#url.site_mode#_standard">
				</cfinvoke>
			</div>
			<div class="container pad-top-10" valign="top">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:340px;" class="spl-special-offers-leg">
							<div class="spl-special-title-top">Special Offers</div>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="43"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="spl-spcl-ofr-link-leg"/>
								<cfinvokeargument name="glyph_right" value="true"/>
							</cfinvoke>
						</td>
						<td>&nbsp;</td>
						<td style="width:640px" valign="top">
							<div title="#arguments.dealer_name# FEATURED VEHICLES"><span class="spl-search-name">#arguments.dealer_name#</span> <span class="spl-search-title">FEATURED VEHICLES</span></div>
							<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
							<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="2"/>
								<cfinvokeargument name="maxSlides" value="12"/>
								<cfinvokeargument name="slideWidth" value="300"/>
								<cfinvokeargument name="slideMargin" value="35"/>
								<cfinvokeargument name="carousel_class" value="fv-carousel"/>
							</cfinvoke>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="container">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="38"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
							</cfinvoke>
						</td>
						<td class="spl-td-leg" valign="top">
							<div class="spl-td-title" title="Schedule a Test Drive">Schedule a Test Drive</div>
							<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_td_leg">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="btn_pull" value="pull-right"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/forms/test_drive_action.cfm"/>
							</cfinvoke>							
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-links">
			<div class="container pad-top-10">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="8"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="9"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="10"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>