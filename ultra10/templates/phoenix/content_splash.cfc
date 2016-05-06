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
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	srch_method,bxs_new_used, price_srch_method  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.srch_meth = #Chk_Srch.srch_method# >
		<cfif #Chk_Srch.bxs_new_used# eq 0>
			<cfset variables.bx_type = "U" >
		<cfelse>	
			<cfset variables.bx_type = "N" >
		</cfif>
		<cfset variables.price_srch_meth = #Chk_Srch.price_srch_method# >
	<!--- Check for Quick Quote / Search Links / Video --->
		
		<section class="section-splash-spl">
			<div class="container">		
				<div class="container">	
				<div class="row pad-top-10">	
					<div class="col-md-3">
					
						<cfquery name="gt_search" datasource="Ultra10">
							SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
									CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
							FROM    Dealer_CTA_Titles
							where dealer_id = #url.dealer_id#
							AND		active = 1
							AND CTA = 3
							order by hierarchy asc
						</cfquery>
						<div class="row">  
						<cfif #gt_search.recordcount# NEQ 0 >
							<cfloop query="gt_search">
								<cfset ln_1_style="font-family:#gt_search.ft_family#;font-size:#gt_search.ft_size#;color:###gt_search.ft_color#;font-weight:#gt_search.ft_weight#">
								<cfset ln_1_align="#gt_search.txt_align#">
								<cfset ln_2_style="font-family:#gt_search.ft_family_2#;font-size:#gt_search.ft_size_2#;color:###gt_search.ft_color_2#;font-weight:#gt_search.ft_weight_2#">
								<cfset ln_2_align="#gt_search.txt_align_2#">
								<div class="col-md-12  brands-title visible-sm visible-xs visible-lg visible-md" align="#ln_1_align#">
								<cfif #len(gt_search.CTA_image)# GT 0 >
									<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image#"   class="img-responsive" >
								<cfelse>
									<span style="#ln_1_style#">#gt_search.CTA_Title_1#</span>
								</cfif>
								 <cfif #gt_search.CTA_Title_2# NEQ "" or #len(gt_search.CTA_image_2)# GT 0 >
									<br>
									<cfif #len(gt_search.CTA_image_2)# GT 0 >
										<img alt="#gt_search.CTA_Title_1#" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image_2#" class="img-responsive" >
									<cfelse>
										<span style="#ln_2_style#" align="#ln_2_align#">#gt_search.CTA_Title_2#</span>
									</cfif>
								</cfif>	 
								</div>	
							</cfloop>
						<cfelse>
							<div class="col-md-12 pad-top-10 quik-link-btn"> 
							 Search Inventory 
							</div>	
						</cfif>
						
						<div class="tab-content srch-tabs">
							<div class="tab-pane active" id="srch">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
								</cfinvoke>
							</div>
							<cfif #variables.price_srch_meth# NEQ 0 >  <!--- Switchable Price Search Module --->
								<div class="tab-pane active">
									<div class="row pad-top-10 "><div class="tab-pane price_srch-btn ">Search By Price</div></div> 
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
							<!--- Check upper QuickLinks --->
							<cfquery datasource="Ultra10" name="Chk_QL">
								SELECT		Nav_Type_ID
								FROM		Navigation
								WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="4">
								AND			Nav_Type_ID = 42
							</cfquery>
							<cfif #Chk_QL.recordcount# GT 0 > 
								<div class="tab-pane active">
									<div class="row"><div class="tab-pane visible-md visible-lg"> </div></div>     <!--- Quick Links UPPER --->
									<div class="row pad-top 5px tab-pane active">
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
							</cfif>
							</div>
						</div>
					</div>	
									
					<div class="col-md-9 "> 
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
						<div class="row visible-xs visible-sm visible-md visible-lg">
							<div class="col-md-12">
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
					</div>
				</div>
			</div>

		</section>
		
<!--- BRANDS --->  
		<cfquery name="Get_Assigned_OEMs" datasource="Ultra10" >
			SELECT  a.ID, a.dealer_id, a.dealer_oem_id, a.link_to, a.active, a.hierarchy,
					b.OEM_ID, b.Logo,b.OEM_Name
			FROM    Vulcan_Brand_Links a, OEMs b
			where 	a.dealer_id = #url.dealer_id#
			and		a.dealer_oem_id = b.OEM_ID
			and a.active = 1
			order by a.hierarchy ASC
		</cfquery>
		<cfif #url.dealer_id# eq 15 >  <!--- Baierl Truck Depot --->
			<cfset nbr_col = "3" >
		<cfelse>
			<cfset nbr_col = "2" >
		</cfif>
		<!--- <cfset nbr_col = "2" > --->
		<cfif  #Get_Assigned_OEMs.recordcount# GT 0 >
			<cfquery name="gt_brands" datasource="Ultra10">
				SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 2
				order by hierarchy asc
			</cfquery>
			<cfset ln_1_style="font-family:#gt_brands.ft_family#;font-size:#gt_brands.ft_size#;color:###gt_brands.ft_color#;font-weight:#gt_brands.ft_weight#">
			<cfset ln_1_align="#gt_brands.txt_align#">
			<cfset ln_2_style="font-family:#gt_brands.ft_family_2#;font-size:#gt_brands.ft_size_2#;color:###gt_brands.ft_color_2#;font-weight:#gt_brands.ft_weight_2#">
			<cfset ln_2_align="#gt_brands.txt_align_2#">
			<section class="section-brands">
				 <div class="container pad-top-10">
					<cfif #gt_brands.recordcount# NEQ 0 >
						<div class="row"><div class="col-md-12 pad-top-10 brands-title visible-sm visible-xs visible-lg visible-md" align="#ln_1_align#">
							<span style="#ln_1_style#">#gt_brands.CTA_Title_1#</span>
							<cfif #gt_brands.CTA_Title_2# NEQ "">
								<br><span style="#ln_2_style#">#gt_brands.CTA_Title_2#</span>
							</cfif>	
						</div>	
					</cfif>
					<div class="row">
						<div class="col-md-12 pad-left 10px" align="center">
						<div class="row">
						<cfloop query="Get_Assigned_OEMs" >
							<div class="col-md-#nbr_col# pad-left 10px" align="center">
								 <cfif  #len(Get_Assigned_OEMs.Logo)# gt 0 >
								 	<a href="#Get_Assigned_OEMs.link_to#" target="_blank"><img alt="#Get_Assigned_OEMs.OEM_Name#"  src="http://dealers.wdautos.com//images/brand_logos/#Get_Assigned_OEMs.Logo#" class="img-responsive" ></a>
								 <cfelse>
								 	#Get_Assigned_OEMs.OEM_Name#
								 </cfif> 
							</div>
						</cfloop>
						</div>
						</div>
					</div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>
			
<!--- Splash Banners --->
	<cfquery name="Chk_Splash" datasource="Ultra10" >
		SELECT  Nav_ID, Dealer_ID, Nav_Type_ID,Start_Date, End_Date
		FROM    Navigation
		WHERE  	Dealer_ID = #url.dealer_id# 
		AND 	Nav_Type_ID = 41  
		AND GETDATE() between Start_Date AND End_Date 	
	</cfquery>
	<cfif #Chk_Splash.recordcount# NEQ 0 >
		<section class="section-banners">
			<div class="container pad-top-10 visible-md visible-lg">
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
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
	</cfif>
	
<!--- CTA UPPER --->
		<cfquery name="Get_Block2" datasource="Ultra10" maxrows="4" >
			SELECT  ID, dealer_id, Title, image, free_text, button_text, button_link, target, active, create_ts, hierarchy
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
			<cfquery name="gt_CTA_U" datasource="Ultra10">
				SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 0
				order by hierarchy asc
			</cfquery>
			<cfset ln_1_style="font-family:#gt_CTA_U.ft_family#;font-size:#gt_CTA_U.ft_size#;color:###gt_CTA_U.ft_color#;font-weight:#gt_CTA_U.ft_weight#">
			<cfset ln_1_align="#gt_CTA_U.txt_align#">
			<cfset ln_2_style="font-family:#gt_CTA_U.ft_family_2#;font-size:#gt_CTA_U.ft_size_2#;color:###gt_CTA_U.ft_color_2#;font-weight:#gt_CTA_U.ft_weight_2#">
			<cfset ln_2_align="#gt_CTA_U.txt_align_2#">
			<section class="section-cta-upper">
				<div class="container pad-top-5 ">
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
				 	<cfif #gt_CTA_U.recordcount# GT 0 >
						<div class="row"><div class="col-md-12 pad-top-10 brands-title visible-sm visible-xs visible-lg visible-md" align="#ln_1_align#">
							<span style="#ln_1_style#">#gt_CTA_U.CTA_Title_1#</span>
							<cfif #gt_CTA_U.CTA_Title_2# NEQ "">
								<br><span style="#ln_2_style#">#gt_CTA_U.CTA_Title_2#</span>
							</cfif>	
						</div>	
					</cfif>
					<div class="row pad-bottom-10">
						<cfloop index="x" from="1" to="#maxblk#">
							<div class="col-md-3 pad-top-5 <cfif #x# eq 1>verticalBlank<cfelse>verticalLine</cfif>" align="center">
								<div class="row  " style="min-height:50px;align:center"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></div>
								<div class="row pad-top-10 cta-upper-title" >#a_Title[x]#</div>
								<div class="row pad-top-10 pad-10 cta-upper-pgtxt">#a_free_text[x]#</div>
								<div class="row pad-top-10cta-upper-pgtxt" style="min-height:15px;align:center"></div>
								<div class="row pad-top-10 ">
								<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn">#a_button_text[x]#</a>
								<!--- <input class="cta-upper-go-btn" name="Button_Go" type="submit" value="#a_button_text[x]#" onClick="javascript:self.location='#a_button_link[x]#';"> --->
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
					<cfquery name="gt_features" datasource="Ultra10">
						SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
								CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
						FROM    Dealer_CTA_Titles
						where dealer_id = #url.dealer_id#
						AND		active = 1
						AND CTA = 4
						order by hierarchy asc
					</cfquery>
					<cfset ln_1_style="font-family:#gt_features.ft_family#;font-size:#gt_features.ft_size#;color:###gt_features.ft_color#;font-weight:#gt_features.ft_weight#">
					<cfset ln_1_align="#gt_features.txt_align#">
					<cfset ln_2_style="font-family:#gt_features.ft_family_2#;font-size:#gt_features.ft_size_2#;color:###gt_features.ft_color_2#;font-weight:#gt_features.ft_weight_2#">
					<cfset ln_2_align="#gt_features.txt_align_2#">
				<div class="row visible-lg visible-md">
					<div class="col-md-12 pad-10">
						<cfif #gt_features.recordcount# >
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
								<p align="#ln_1_align#"><span  style="#ln_1_style#">#gt_features.CTA_Title_1#</span>
								<cfif #gt_features.CTA_Title_2# NEQ "">
								<br><span style="#ln_2_style#">#gt_features.CTA_Title_2#</span>
							</cfif>
							</div></div>	
						<cfelse>	
							<div title="#arguments.dealer_name# THIS WEEK'S USED CAR DEALS"><span class="spl-search-name">THIS WEEK'S USED CAR DEALS</span></div>
						</cfif>
						<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
					<div class="row"><div class="col-md-12 pad-top 5px  visible-lg visible-md"><div class="page-div"></div>		
					</div>
						<div id="#arguments.assets#-spl-carousel" class="pad-top-10">                        
                        <!-- #now# bxslider from content splash -->
							<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="#variables.bx_type#"/>
								<cfinvokeargument name="minSlides" value="4"/>	
								<cfinvokeargument name="maxSlides" value="12"/>
								<cfinvokeargument name="slideWidth" value="300"/>
								<cfinvokeargument name="slideMargin" value="35"/>
								<cfinvokeargument name="carousel_class" value="fv-carousel"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</div>
		</section>  
			
<!--- LOWER CTA --->
		<cfquery name="Get_Block4" datasource="Ultra10" maxrows="4" >
			SELECT  ID, dealer_id, name, image, link, active, create_ts,target, hierarchy
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
			<cfquery name="gt_CTA_L" datasource="Ultra10">
				SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 1
				order by hierarchy asc
			</cfquery>
			<cfset ln_1_style="font-family:#gt_CTA_L.ft_family#;font-size:#gt_CTA_L.ft_size#;color:###gt_CTA_L.ft_color#;font-weight:#gt_CTA_L.ft_weight#">
			<cfset ln_1_align="#gt_CTA_L.txt_align#">
			<cfset ln_2_style="font-family:#gt_CTA_L.ft_family_2#;font-size:#gt_CTA_L.ft_size_2#;color:###gt_CTA_L.ft_color_2#;font-weight:#gt_CTA_L.ft_weight_2#">
			<cfset ln_2_align="#gt_CTA_L.txt_align_2#">
			<section class="section-cta-lower">
				 <div class="container pad-top-10 pad-bottom-10">
					<div class="row pad-bottom-10">
				 	<cfif #gt_CTA_L.recordcount# GT 0 >
						<div class="row"><div class="col-md-12 pad-top-10 brands-title visible-sm visible-xs visible-lg visible-md" align="#ln_1_align#">
							<span style="#ln_1_style#">#gt_CTA_L.CTA_Title_1#</span>
							<cfif #gt_CTA_L.CTA_Title_2# NEQ "">
								<br><span style="#ln_2_style#">#gt_CTA_L.CTA_Title_2#</span>
							</cfif>	
						</div>	
					</cfif>
						<cfloop index="x" from="1" to="2">
							<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md" align="center">
								<div class="row pad-top-10" style="min-height:40px;align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img alt="#gt_CTA_L.CTA_Title_1#"  class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" style="border:2;border-color:white">
									</a>
								</div>
							</div>
							<cfif #x# EQ 1 >
								<div class="col-md-2"></div>
							</cfif>
						</cfloop>	
					</div>
					<cfif #x# LTE #maxblk# >
					<div class="row pad-bottom-10">
						<cfloop index="x" from="3" to="#maxblk#">
							<div class="col-md-5 pad-top-10 visible-sm visible-xs  visible-lg visible-md" align="center">
								<div class="row pad-top-10" style="min-height:40px;align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img alt="#gt_CTA_L.CTA_Title_1#" class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="1"></a>
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
		
<!--- If a MAP is found, the Commercials go away --->

		<cfset variables.End_Date=Dateformat(now(),"mm/dd/yyyy")>
		<cfquery datasource="Ultra10" name="Chk_Map">
			SELECT		Nav_Type_ID
			FROM		Navigation
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="4">
			AND			Nav_Type_ID = 38
			AND			Start_Date < GETDATE()
			AND			End_Date >= '#variables.End_Date#'
		</cfquery>
		<cfset wch = "Commercial" >
		<cfif #Chk_Map.recordcount# GT 0 >
			<cfset wch = "Map" >
		</cfif>
		
		
		<section class="section-video">
			<div class="container">
				<div class="row">
					<div class="col-md-5 verticalBlank">
						<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >GET A QUOTE</span></div>
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
							<div class="row"><div class="col-md-12 pad-top-5 pad-5 page-div-lite visible-lg visible-md"></div></div>	
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq_big">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
					</div>
					<div class="col-md-3 pad-5 verticalLine visible-md visible-lg" align="left">	
						<cfif #which# EQ "Reviews" >
							<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >REVIEWS</span></div>
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
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
					<div class="spl-search-name pad-top-10 pad-5" align="left"><span class="spl-search-name pad-5" style="color:white" >
					<cfif #wch# EQ "Commercial" >
						OUR COMMERCIALS</span></div>
						<div class="row"><div class="col-md-12 pad-bottom-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
					<cfelse>
						OUR LOCATION</span></div>
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="38"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-map"/>
						</cfinvoke>
					</cfif>	 
					</div>
				</div>
				<div class="row pad-top-10" style="min-height:20px;align:center"></div>
			</div>
		</section>
  
		<section class="section-links">
			<div class="container pad-top-10">
				<cfswitch expression="#url.dealer_id#">
					<cfcase value="18,34,33,32,236">
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