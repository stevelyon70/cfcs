<cfoutput>

<cfquery name="gt_title" datasource="Ultra10">
	SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
			CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
	FROM    Dealer_CTA_Titles
	where dealer_id = #url.dealer_id#
	AND		active = 1
	AND CTA = 6
</cfquery>
<cfset ln_1_style="font-size:#gt_title.ft_size#;color:###gt_title.ft_color#;font-weight:#gt_title.ft_weight#">
<cfset ln_1_align="#gt_title.txt_align#">
<cfset ln_2_style="font-size:#gt_title.ft_size_2#;color:###gt_title.ft_color_2#;font-weight:#gt_title.ft_weight_2#">
<cfset ln_2_align="#gt_title.txt_align_2#">

		
		<section class="section-video-v1">
			<div class="container">
				<div class="row">
				<cfif #sub_sec_v1_active# EQ 1 >
				<!--- Sub 1 --->			
					<div class="col-md-5  pad-top-10  visible-sm visible-xs  visible-md visible-lg">
						<div class="container-video-v1" style="border:1px solid white">
						<div class="row">
							<div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="30"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="video-link"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
							</div>
						</div>	
						</div>
					</div>
				</cfif>	
					
				<!--- Sub 2 --->
					<div class="col-md-7 pad-top-10 pad-5  visible-sm visible-xs  visible-md visible-lg">	
						<div class="container-contact-us">
							<cfif #sub_sec_v2_active# EQ 0 >	
								<cfif #gt_title.recordcount# gt 0 >
									<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
										<p style="align:#ln_1_align#"><span  style="#ln_1_style#">#gt_title.CTA_Title_1#</span>
										<cfif #gt_title.CTA_Title_2# NEQ "">
											<br><span style="#ln_2_style#">#gt_title.CTA_Title_2#</span>
										</cfif>
									</div></div>	
							<cfelse>	
								<div class="spl-search-name pad-top-10 pad-5" style="align:left">
									<span class="spl-search-name pad-5" style="color:white" >CONTACT US</span>
								</div>
							</cfif>				
								<div class="row">
									<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md">	
										<cfinvoke component="/cfcs/forms/form_contact" method="contact_splash_v1">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="dsn" value="Ultra10"/>
										</cfinvoke>
									</div>
								</div>
							
							<!--- <cfelseif #sub_sec_v2_active# EQ 1 >	
								<div class="spl-search-name pad-top-10 pad-5" style="align:left">
									<span class="spl-search-name pad-5" style="color:white" >Test Drive</span>
								</div>
								<div class="row">
									<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md">	
										<cfinvoke component="/cfcs/forms/form_test_drive" method="show_default">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
										</cfinvoke> 
									</div>
								</div> --->
							
							<cfelseif #sub_sec_v2_active# EQ 2 >	
								<cfif #gt_title.recordcount# gt 0 >
									<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
										<p style="align:#ln_1_align#"><span  style="#ln_1_style#">#gt_title.CTA_Title_1#</span>
										<cfif #gt_title.CTA_Title_2# NEQ "">
											<br><span style="#ln_2_style#">#gt_title.CTA_Title_2#</span>
										</cfif>
									</div></div>	
							<cfelse>	
								<div class="spl-search-name pad-top-10 pad-5" style="align:left">
									<span class="spl-search-name pad-5" style="color:white" >REQUEST A QUOTE</span>
								</div>
							</cfif>	
								<div class="row">
									<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md">	
										<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq_big">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
										</cfinvoke> 
									</div>
								</div>
							
							</cfif>	
						</div>
					</div>
								
				<cfif #sub_sec_v1_active# EQ 2 >
				<!--- Sub 1 --->			
					<div class="col-md-5  pad-top-10  visible-sm visible-xs  visible-md visible-lg">
						<div class="container-video_v1">
						<!--- <div class="spl-search-name pad-top-10 pad-5">
							<span class="spl-search-name pad-5" style="color:white" >OUR COMMERCIALS</span>
						</div> --->
						<div class="row">
							<div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="30"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="video-link"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
							</div>
						</div>	
						</div>
					</div>
				</cfif>	
				</div>
				<div class="row pad-top-10" style="min-height:20px;align:center"></div>
			</div>
		</section>
  



</cfoutput>
