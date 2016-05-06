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
	
	<!--- Check for Quick Quote / Search Links  / Video --->
		<cfset variables.srch_meth = 0 >
		<cfset variables.price_srch_meth = 0 >  
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	srch_method, price_srch_method  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.srch_meth = #Chk_Srch.srch_method# >
		<cfset variables.price_srch_meth = #Chk_Srch.price_srch_method# >
	<!--- Check for Quick Quote / Search Links / Video --->
	
		
		<section class="section-spl">
			<div class="container">		
				<div class="container">	
				<div class="row pad-top-10">
				
<!--- Modified --->	<cfif #variables.srch_meth# eq 1 >  
						<div class="col-md-3 pad-top-10 visible-md visible-lg">
							<ul class="nav nav-tabs spl-tabs">
								<li class="active"><a href="##srch" data-toggle="tab">Search</a></li>
								<li><a href="##qq" data-toggle="tab">Quick Quote</a></li>
							</ul>
							<div class="tab-content srch-tabs">
								<div class="tab-pane active" id="srch">
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
									</cfinvoke>
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="42"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="srch-links-btn-m"/>
										<cfinvokeargument name="glyph_right" value="true"/>
									</cfinvoke>
								</div>
								<div class="tab-pane" id="qq">
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
										<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
									</cfinvoke>
								</div>
							</div>
						</div>
<!--- Videos --->	<cfelseif #variables.srch_meth# eq 2 >  
						<div class="col-md-3 pad-top-10 visible-md visible-lg">
							<div class="spl-search-name" title="#arguments.dealer_name# Videos"><span class="spl-search-title">View Our Videos</span></div>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="30"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="video-link"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
						</div>
<!--- Default --->	<cfelse>
						<div class="col-md-3">
							<div class="row">
								<div class="col-md-12 pad-top-10 quik-link-btn"> 
									 Search Inventory 
									<div class="tab-content srch-tabs">
										<div class="tab-pane active" id="srch">
											<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="btn_pull" value="pull-right"/>
											</cfinvoke>
										</div>
										<cfif #variables.price_srch_meth# NEQ 0 >  <!--- Switchable Price Search Module --->
											<div class="tab-pane active">
												<div class="row pad-top-10 "><div class="tab-pane quik-link-btn ">Search By Price</div></div> 
												<cfif IsDefined("url.err_msg")>
													<div class="row"><div class="col-md-12" align="center"><span style="color:red;font-size:9pt;font-weight:bold">#url.err_msg#</span></div></div>	
												</cfif>
												<div class="row srch-tabs-price active">
													<cfinvoke component="/cfcs/forms/form_price_search" method="price_srch">
														<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
														<cfinvokeargument name="VOI_Vin" value=""/>
														<cfinvokeargument name="VOI_New_Used" value="#variables.price_srch_meth#"/>
														<cfinvokeargument name="form_name" value="price_search"/>
														<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/price_search_action.cfm"/>
													</cfinvoke>  
												</div>
											</div>
										</cfif>
										<div class="tab-pane active">
											<div class="row"><div class="tab-pane visible-md visible-lg"> </div></div>     <!--- Quick Links UPPER --->
											<div class="row pad-top-10 tab-pane active">
											<cfif #url.dealer_ID# eq 30 >
													  <cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
														<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
														<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
														<cfinvokeargument name="nav_type_id" value="12"/>
														<cfinvokeargument name="assets" value="#arguments.assets#"/>
														<cfinvokeargument name="element_class" value="spl-tools-btn"/>
														<cfinvokeargument name="glyph_left" value="true"/>
													</cfinvoke>   
											</cfif>
												<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
													<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
													<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
													<cfinvokeargument name="nav_type_id" value="42"/>
													<cfinvokeargument name="assets" value="#arguments.assets#"/>
													<cfinvokeargument name="element_class" value="srch-links-btn"/>
													<cfinvokeargument name="glyph_left" value="true"/>
												</cfinvoke>
											</div>
										</div>
									</div>
								</div>
							</div>	
						</div>	
				</cfif>	
				
			 
					
					
					<div class="col-md-9 "> <!--- remover the pad-top-10  10-14 --->
						<div class="row visible-xs visible-sm">
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
						<cfif #ss_trigger# eq 1>   			  
                            <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">	<!--- Toyota Slideshow --->
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
						<!--- <div class="row visible-sm visible-xs">
							<div class="col-md-12">
								<br/><br/>
								<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
									<cfinvokeargument name="form_id" value="carfinderFormMbl"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<br/>
							</div>
						</div> --->
					</div>
				</div>
			</div>
		
		</section>	
		<section class="section-banners">
<!--- Splash Banners like Baierl 10/27/2014 --->
			<div class="container pad-top-10 visible-md visible-lg">
				<div class="row splash-logos-row">
					<div class="col-md-12 no-pad" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="41"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke>
					</div>
				</div>
			</div>  
		
		</section>
		
<!--- This will be the new table for the Block 2 section --->
		<cfquery name="Get_Block2" datasource="Ultra10" maxrows="4" >
			SELECT  ID, dealer_id, Title, image, free_text, button_text, button_link, active, target, create_ts, hierarchy
			FROM    Nav_Block_2
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		<cfif #Get_Block2.recordcount# NEQ 0 >
			<cfset a_title = ArrayNew(1)>
			<cfset a_image = ArrayNew(1)>
			<cfset a_free_text = ArrayNew(1)>
			<cfset a_button_text = ArrayNew(1)>
			<cfset a_button_link = ArrayNew(1)>
			<cfset a_button_target = ArrayNew(1)>
	  		<cfset maxblk = #Get_Block2.recordcount# >
			<cfset y = 0>
			<cfloop query="Get_Block2">
				<cfset y = #y#+1>
				<cfset a_Title[y] = #Get_Block2.Title# >
				<cfset a_image[y] = #Get_Block2.image#>
				<cfset a_free_text[y] = #Get_Block2.free_text#>
				<cfset a_button_text[y] = #Get_Block2.button_text#>
				<cfset a_button_link[y] = #Get_Block2.button_link#>
				<cfset a_button_target[y] ="">
				<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target[y] = "_blank"></cfif>
			</cfloop>
			<section class="section-blk2">
				 <div class="container pad-top-5 ">
					<!--- <div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	 --->
					<div class="row pad-bottom-10">
						<cfloop index="x" from="1" to="#maxblk#">
							<div class="col-md-3 pad-top-5 <cfif #x# eq 1>verticalBlank<cfelse>verticalLine</cfif>" align="center">
								<div class="row  " style="min-height:50px;align:center"><img  alt="#a_title[x]#" class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></div>
								<cfif #url.dealer_id# EQ 30 and #left(a_Title[x],2)# EQ 'EZ' >
									<div class="row pad-top-10" style="font-size:14pt;font-weight:bold;align:center;color:##cc0000">#a_Title[x]#</div>
								<cfelse>
									<div class="row pad-top-10" style="font-size:14pt;font-weight:bold;align:center">#a_Title[x]#</div>
								</cfif>
								<div class="row pad-top-10 pad-10" style="min-height:60px;font-size:10pt;font-weight:normal;align:center">#a_free_text[x]#</div>
								<div class="row pad-top-10" style="min-height:15px;align:center"></div>
								<div class="row pad-top-10 ">
								<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn">#a_button_text[x]#</a>
								<!--- <input class="blk2-btn" name="Button_Go" type="submit" value="#a_button_text[x]#" onClick="javascript:self.location='#a_button_link[x]#';"> --->
								</div>
								<div class="row pad-top-10" style="min-height:10px;align:center"></div>
							</div>
						</cfloop>	
					</div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>
	
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
				<div class="row visible-lg visible-md">
					<div class="col-md-12 pad-10">
						<div title="#arguments.dealer_name# THIS WEEK'S USED CAR DEALS"><span class="spl-search-name">THIS WEEK'S USED CAR DEALS</span></div>
					<div class="row"><div class="col-md-12 pad-top-5  visible-lg visible-md"><div class="page-div"></div>		
				</div>
						<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
								<cfif #url.dealer_id# NEQ 233 >
									<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="new_used" value="U"/>
									<cfinvokeargument name="minSlides" value="4"/>	
									<cfinvokeargument name="maxSlides" value="12"/>
									<cfinvokeargument name="slideWidth" value="300"/>
									<cfinvokeargument name="slideMargin" value="35"/>
									<cfinvokeargument name="carousel_class" value="fv-carousel"/>
								</cfinvoke>
							<cfelse>
									<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="new_used" value="U"/>
									<cfinvokeargument name="minSlides" value="8"/>	
									<cfinvokeargument name="maxSlides" value="12"/>
									<cfinvokeargument name="slideWidth" value="300"/>
									<cfinvokeargument name="slideMargin" value="35"/>
									<cfinvokeargument name="carousel_class" value="fv-carousel"/>
								</cfinvoke>	
							</cfif>
						</div>
					</div>
				</div>
			</div>
		</section>  
			
<!--- This will be the new table for the Block 4 section --->
		<cfquery name="Get_Block4" datasource="Ultra10" maxrows="4" >
			SELECT  ID, dealer_id, name, image, link, active, create_ts, target, hierarchy
			FROM    Nav_Block_4
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		<cfif #Get_Block4.recordcount# NEQ 0 >
			<cfset a_name = ArrayNew(1)>
			<cfset a_image = ArrayNew(1)>
			<cfset a_link = ArrayNew(1)>
			<cfset a_target = ArrayNew(1)>
	  		<cfset maxblk = #Get_Block4.recordcount# >
			<cfset y = 0>
			<cfloop query="Get_Block4">
				<cfset y = #y#+1>
				<cfset a_name[y] = #Get_Block4.name# >
				<cfset a_image[y] = #Get_Block4.image#>
				<cfset a_link[y] = #Get_Block4.link#>
				<cfset a_target[y] ="">
				<cfif #Get_Block4.target# NEQ "" ><cfset a_target[y] = "_blank"></cfif>
			</cfloop>
			<section class="section-blk4">
				 <div class="container pad-top-10 pad-bottom-10">
					<div class="row"><div class="col-md-12  visible-lg visible-md"><div class="gradient"></div></div></div>	
					<div class="row pad-bottom-10">
						<cfloop index="x" from="1" to="2">
							<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md" align="center">
								<div class="row pad-top-10" style="min-height:40px;align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img  alt="#a_name[x]#" class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" style="border:2;border-color:white">
									</a>
								</div>
							</div>
							<cfif #x# EQ 1 >
								<div class="col-md-2"></div>
							</cfif>
						</cfloop>	
					</div>
					<div class="row"><div class="col-md-12 pad-top-10  visible-lg visible-md"><div class="gradient"></div></div></div>	
					<cfif #x# LTE #maxblk# >
					<div class="row pad-bottom-10">
						<cfloop index="x" from="3" to="#maxblk#">
							<div class="col-md-5 pad-top-10 visible-sm visible-xs  visible-lg visible-md" align="center">
								<div class="row pad-top-10" style="min-height:40px;align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img  alt="#a_name[x]#" class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="1"></a>
								</div>
							</div>
							<cfif #x# EQ 3 >
								<div class="col-md-2"></div>
							</cfif>
						</cfloop>	
					</div>
					</cfif>
					<div class="row pad-top-10" style="min-height:20px;align:center"></div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>	

<!--- This will be the new LOWER Quick Links section --->
		<cfquery name="Get_lower_QL" datasource="Ultra10" >
			SELECT   Nav_ID, dealer_id, Nav_Type_ID
			FROM    Navigation
			where 	dealer_id = #url.dealer_id#
			and 	Nav_Type_ID = 57
		</cfquery>
		<cfset which = "Reviews" >
		<cfif #Get_lower_QL.recordcount# GT 0 >
			<cfset which = "QuickLinks" >
		</cfif>
		
		<section class="section-video">
			<div class="container">
				<div class="row">
					<div class="col-md-5 verticalBlank">
						<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >GET A QUOTE</span></div>
							<div class="row"><div class="col-md-12 pad-top-5 pad-5 page-div-lite visible-lg visible-md"></div></div>	
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq_big">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
					</div>
					<div class="col-md-3 pad-5 verticalLine visible-md visible-lg" align="left">	
						<cfif #which# EQ "Reviews" >
							<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >REVIEWS</span></div>
							<div class="row"><div class="col-md-12 pad-top-5 page-div-lite visible-lg visible-md"></div></div>
								<cfinvoke component="/cfcs/ultra10/splash_reviews" method="modern_standard_stacked">
								</cfinvoke>
							</div>
						<cfelse >
							<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >&nbsp;</span></div>
							<div class="row"><div class="col-md-12 pad-top-5  visible-lg visible-md"></div></div>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="57"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="srch-links-btn"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
							</div>
						</cfif>			
					<div class="col-md-4 pad-5 verticalLine visible-md visible-lg" align="left">				
					<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >OUR LOCATION</span></div>
					<div class="row"><div class="col-md-12 pad-top-5 pad-5 page-div-lite visible-lg visible-md"></div></div>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="38"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-map"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row pad-top-10" style="min-height:20px;align:center"></div>
			</div>
		</section>
  
  		<cfinclude template="section_about_us.cfm" >
  
		<section class="section-links">
			<div class="container pad-top-10">
			<!--- <div class="row">
				<div class="col-md-12 pad-top-5  visible-lg visible-md">
				<div class="gradient"></div>		
				</div>
			</div>	 --->
				<cfswitch expression="#url.dealer_id#">
					<cfcase value="18">
						<div class="row">
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
							<div class="col-md-6">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="37"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="right"/>
								</cfinvoke>								
							</div>
						</div>
					</cfcase>
					<cfdefaultcase>
						<!--- <div class="row">
							<div class="col-md-12">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</div>
						</div> --->
					</cfdefaultcase>
				</cfswitch>
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
					 <!---  <div class="col-md-3 visible-md visible-lg">
						<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="dsn" value="#url.DSN#"/>
							<cfinvokeargument name="title_class" value="ftr-title"/>
							<cfinvokeargument name="input_class" value="ftr-input"/>
							<cfinvokeargument name="button_class" value="ftr-contact-input"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
						</cfinvoke>
					</div>   --->
				</div>
			</div>		
			 
								<div class="clearfix"></div>
			
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:195px;padding:10px 10px 10px 0px;" valign="top">
							<div>
								<div style="padding-top:5px">
									<div class="spl-search-name">#arguments.dealer_name#</div>
									<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
									</cfinvoke>
									<div style="padding-right:10px;">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="42"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="srch-links-btn"/>
											<cfinvokeargument name="glyph_right" value="true"/>
										</cfinvoke>
									</div>
								</div>
							</div>
						</td>
						<td class="pad-top-10" style="width:785px" valign="top">
							<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>
							<br/><br/>
						</td>
					</tr>
				</table>
			</div>			
		</div>

		<div class="section-carousel">
			<div class="container pad-top-10" align="center">
				<table style="width:990px;">
					<tr>
						<td>
							<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="31"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="4"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="35"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel-legacy"/>
								<cfinvokeargument name="element_class" value="specials-icon-legacy"/>
								<cfinvokeargument name="slideWidth" value="230"/>
								<cfinvokeargument name="slideMargin" value="17"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
			<div class="container pad-top-10" align="center">
				<table style="width:990px;">
					<tr>
						<td>
							<div id="#arguments.assets#-btn-carousel">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="36"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="btns-oblong-leg"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
								<div class="clearfix"></div>
								<div class="pad-top-10"></div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-video">
			<div class="container">
				<table style="width:100%">
					<tr>
						<td style="width:50%" class="pad-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
							</cfinvoke>
						</td>
						<td style="width:50%" class="pad-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="38"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-links">
			<div class="container pad-top-10">

				<table style="width:100%;margin-bottom:10px;" cellpadding="0" cellspacing="0">
					<cfswitch expression="#url.dealer_id#">
						<cfcase value="18">
							<tr>
								<td style="width:50%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="28"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="left"/>
									</cfinvoke>
								</td>
								<td style="width:50%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="37"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="right"/>
									</cfinvoke>								
								</td>
							</tr>
						</cfcase>
						<cfdefaultcase>
							<tr>
								<td style="width:100%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="28"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="left"/>
									</cfinvoke>
								</td>
							</tr>
						</cfdefaultcase>
					</cfswitch>
				</table>
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
							<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer_leg">
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="dsn" value="#url.DSN#"/>
								<cfinvokeargument name="title_class" value="ftr-title"/>
								<cfinvokeargument name="input_class" value="ftr-input"/>
								<cfinvokeargument name="button_class" value="ftr-contact-input"/>
								<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>