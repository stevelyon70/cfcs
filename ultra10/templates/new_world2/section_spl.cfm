<cfoutput>
<div class="container-fluid">	

	
		<section class="section-splash-spl   visible-sm visible-xs   visible-lg visible-md  no-pad">	
			<!---    <div class="section-splash-spl-mbl  visible-sm visible-xs">     --->
				<!--- <div class="container"> --->	
				<!--- Sub 1 --->
					<div class="row-centered no-pad">	
					 <CFIF #spl1# EQ 1 > 
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
									<div class="col-md-12 srch-tabs-block  visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
									<cfif #len(gt_search.CTA_image)# GT 0 >
										<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image#"   class="img-responsive" >
									<cfelse>
										<span  class="srch-tabs-title" style="#ln_1_style#">#gt_search.CTA_Title_1#</span>
									</cfif>
									 <cfif #gt_search.CTA_Title_2# NEQ "" or #len(gt_search.CTA_image_2)# GT 0 >
										<br>
										<cfif #len(gt_search.CTA_image_2)# GT 0 >
											<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image_2#" class="img-responsive" >
										<cfelse>
											<span  class="srch-tabs-title" style="#ln_2_style#" style="align:#ln_2_align#">#gt_search.CTA_Title_2#</span>
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
										<div class="row"><div class="col-md-12" style="align:center"><span style="color:red;font-size:9pt;font-weight:bold">#url.err_msg#</span></div></div>	
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
					
				</CFIF>	<!--- End Sub 1 --->
				
				<!--- Sub 2 NO Slideshow--->
				 <CFIF #spl2# EQ 0 >
				 	<cfif #spl1# EQ 0 >
						<cfset nbr_cols = 12 >
						<div class="row">&nbsp;</div>
					</cfif>
				 	<cfif #spl1# EQ 1 >
						<cfset nbr_cols = 9 >
					</cfif>
				 	<cfif #spl1# EQ 2 >
						<cfset nbr_cols = 9 >
					</cfif>
					<div class="col-md-#nbr_cols#" style="align:center">
					&nbsp;
					  </div>
				</CFIF>	
				
				<!--- Sub 2 Slideshow--->
				 <CFIF #spl2# EQ 1 >
				 	<cfif #spl1# EQ 0 >
						<cfset nbr_cols = 12 >
						<div class="row">&nbsp;</div>
					</cfif>
				 	<cfif #spl1# EQ 1 >
						<cfset nbr_cols = 9 >
					</cfif>
				 	<cfif #spl1# EQ 2 >
						<cfset nbr_cols = 9 >
					</cfif>
					<div class="col-md-#nbr_cols#" style="align:center">
					<cfif #ss_trigger# eq 1>   			  
                        <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">	<!--- Toyota Slideshow --->
                            <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                            <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                            <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
                            <cfinvokeargument name="assets" value="#arguments.assets#"/>
                         </cfinvoke>
            	      <cfelse>
                         <cfinvoke component="/cfcs/ultra10/variable_wow_slider_v1" method="wide">
                            <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                            <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                            <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
                            <cfinvokeargument name="assets" value="#arguments.assets#"/>
                            <cfinvokeargument name="pg_nbr" value="#pg_nbr#"/>
							<cfif #pg_nbr# EQ 4 >
								<cfinvokeargument name="car_make" value="#url.v_make#"/>
							</cfif>
                         </cfinvoke>
                	  </cfif>
					  </div>
					<!--- </div> --->
				</CFIF>	
				 
				<!--- End Sub 2  Slideshow--->
				
				<!--- Sub 2 Carousel --->
				 <CFIF #spl2# EQ 2 >
				 	<cfif #spl1# EQ 0 >
						<cfset nbr_cols = 12 >
						<div class="row">&nbsp;</div>
					</cfif>
				 	<cfif #spl1# EQ 1 >
						<cfset nbr_cols = 9 >
					</cfif>
				 	<cfif #spl1# EQ 2 >
						<cfset nbr_cols = 9 >
					</cfif>
					<div class="col-md-#nbr_cols#" style="align:center">
					
					<cfquery name="gt_features" datasource="Ultra10">
						SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
								CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
						FROM    Dealer_CTA_Titles
						where dealer_id = #url.dealer_id#
						AND		active = 1
						AND CTA = 4
					</cfquery>
					<cfset ln_1_style="font-size:#gt_features.ft_size#;color:###gt_features.ft_color#;font-weight:#gt_features.ft_weight#">
					<cfset ln_1_align="#gt_features.txt_align#">
					<cfset ln_2_style="font-size:#gt_features.ft_size_2#;color:###gt_features.ft_color_2#;font-weight:#gt_features.ft_weight_2#">
					<cfset ln_2_align="#gt_features.txt_align_2#">
				<div class="row visible-lg visible-md">
					<div class="col-md-12 pad-10">
						<cfif #gt_features.recordcount# >
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
								<p style="align:#ln_1_align#"><span  style="#ln_1_style#">#gt_features.CTA_Title_1#</span>
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
                        <!-- here section spl -->
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
					
					  </div>
					<!--- </div> --->
				</CFIF>	
				 
				<!--- End Sub 2 Carousel --->
							 
				
				<!--- Sub 1 --->
					<div class="row pad-top-10">	
					 <CFIF #spl1# EQ 2 > 
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
									<div class="col-md-12 srch-tabs-block  visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
									<cfif #len(gt_search.CTA_image)# GT 0 >
										<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image#"   class="img-responsive" >
									<cfelse>
										<span  class="srch-tabs-title" style="#ln_1_style#">#gt_search.CTA_Title_1#</span>
									</cfif>
									 <cfif #gt_search.CTA_Title_2# NEQ "" or #len(gt_search.CTA_image_2)# GT 0 >
										<br>
										<cfif #len(gt_search.CTA_image_2)# GT 0 >
											<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image_2#" class="img-responsive" >
										<cfelse>
											<span  class="srch-tabs-title" style="#ln_2_style#" style="align:#ln_2_align#">#gt_search.CTA_Title_2#</span>
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
										<div class="row"><div class="col-md-12" style="align:center"><span style="color:red;font-size:9pt;font-weight:bold">#url.err_msg#</span></div></div>	
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
					
				</CFIF>	<!--- End Sub 1 --->
				
				<!--- End Sub 1 --->
			</div>
				  <!--- </div> --->     <!--- special --->
			</section>
<!---  --->
			
			
			
			
<!---  --->		
		</div>
<!---  --->		
		
		
		
		
		
		
		
		
</div>
</cfoutput>		