<cfoutput>

		
		<cfif NOT IsDefined("url.v_make") >
			<cfset url.v_make = "" >
		</cfif>
	<cfquery datasource="Ultra10" name="get_content">
		SELECT	ID, dealer_id, Vehicle_Make, Title, title_font_family, title_font_size, title_font_color, title_font_weight, title_decoration, text_section, text_font_family, 
                text_font_size, text_font_color, text_font_weight, text_decoration, button_text, btn_background, btn_text_font_size, btn_text_font_color, btn_text_font_family, 
                btn_text_font_weight, btn_text_decoration, button_link, Video, Video_Image, Video_position, link_1_text, link_1, link_2_text, link_2, link_3_text, link_3, link_4_text, 
                link_4, link_5_text, link_5, link_6_text, link_6, link_font_color, link_font_family, link_font_size, link_font_weight, link_decoration, active, hierarchy
		FROM    Dealer_Internal_Video
		WHERE	dealer_id = #url.dealer_id#
		<cfif IsDefined("url.v_make") and #url.v_make# NEQ "" >
			AND		Vehicle_Make = '#url.v_make#'
			AND		page_type = 4
		<cfelseif #url.dealer_id# eq 233>	
			AND page_type = 0
		<cfelse>	
			AND page_type = 8
		</cfif>
		AND		active = 1
		ORDER BY hierarchy ASC
	</cfquery>
<div class="container-fluid">
	<cfif #get_content.recordcount# NEQ 0 >
		<section class="section-internal-video">
			<div class="container">
			<cfloop query="get_content" >
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
					<div class="row">
						<cfif #get_content.Video_position# EQ 0 >
							<div class="col-md-4 pad-top-10 pad-5" style="align:left">
								<div class="row"><div class="col-md-12 pad-bottom-10 visible-sm visible-xs visible-lg visible-md"></div></div>	
									<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="video_var">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="30"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="video-link"/>
										<cfinvokeargument name="glyph_left" value="true"/>
										<cfinvokeargument name="pass_make" value="#url.v_make#"/>
										<cfinvokeargument name="pass_video" value="#get_content.id#"/>
									</cfinvoke>
								</div>
						</cfif>
					
					
						<div class="col-md-8">
							<cfif #get_content.link_1_text# NEQ "" >
								<cfset f_color = "###get_content.link_font_color#" >
								<cfset f_size = "#get_content.link_font_size#" >
								<cfset f_weight = "#get_content.link_font_weight#" >
								<cfset f_familiy = "#get_content.link_font_family#" >
								<cfset f_decor = "#get_content.link_decoration#" >
								<div class="row">&nbsp;</div>	
								<div class="row">
					
							 		<div class="col-md-2 pull-left pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
										<a href="#get_content.link_1#"><span style="font-style:#f_decor#;color:#f_color#;font-size:#f_size#;font-weight:#f_weight#;font-family:#f_familiy#">#get_content.link_1_text#</span></a>
									</div>
							 		<div class="col-md-2 pull-left pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
										<a href="#get_content.link_2#"><span style="font-style:#f_decor#;color:#f_color#;font-size:#f_size#;font-weight:#f_weight#;font-family:#f_familiy#">#get_content.link_2_text#</span></a>
									</div>
									<div class="col-md-2 pull-left pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
										<a href="#get_content.link_3#"><span style="font-style:#f_decor#;color:#f_color#;font-size:#f_size#;font-weight:#f_weight#;font-family:#f_familiy#">#get_content.link_3_text#</span></a>
									</div>
									<div class="col-md-2 pull-left pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
										<a href="#get_content.link_4#"><span style="font-style:#f_decor#;color:#f_color#;font-size:#f_size#;font-weight:#f_weight#;font-family:#f_familiy#">#get_content.link_4_text#</span></a>
									</div>
									<div class="col-md-2 pull-left pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
										<a href="#get_content.link_5#"><span style="font-style:#f_decor#;color:#f_color#;font-size:#f_size#;font-weight:#f_weight#;font-family:#f_familiy#">#get_content.link_5_text#</span></a>
									</div>
									<div class="col-md-2 pull-left pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
										<a href="#get_content.link_6#"><span style="font-style:#f_decor#;color:#f_color#;font-size:#f_size#;font-weight:#f_weight#;font-family:#f_familiy#">#get_content.link_6_text#</span></a>
									</div> 
								</div>
								<div class="row">&nbsp;</div>	
							</cfif>
							
								<cfset tf_color = "###get_content.title_font_color#" >
								<cfset tf_size = "#get_content.title_font_size#" >
								<cfset tf_weight = "#get_content.title_font_weight#" >
								<cfset tf_familiy = "#get_content.title_font_family#" >
								<cfset tf_decor = "#get_content.title_decoration#" >
							<div class="spl-search-name pad-top-10 pad-5" style="align:left"><span style="font-style:#tf_decor#;color:#tf_color#;font-size:#tf_size#;font-weight:#tf_weight#;font-family:#tf_familiy#">#get_content.Title#</span></div>
								<div class="row">
									<cfset txtf_color = "###get_content.text_font_color#" >
									<cfset txtf_size = "#get_content.text_font_size#" >
									<cfset txtf_weight = "#get_content.text_font_weight#" >
									<cfset txtf_familiy = "#get_content.text_font_family#" >
									<cfset txtf_decor = "#get_content.text_decoration#" >
									<div class="col-md-12 pad-top-5 pad-5 visible-lg visible-md">
										<span style="font-style:#txtf_decor#;color:#txtf_color#;font-size:#txtf_size#;font-weight:#txtf_weight#;font-family:#txtf_familiy#">#get_content.text_section#
									</div>
								</div>		
								<div class="row">
									<div class="col-md-12 pad-top-5 pad-5 visible-lg visible-md">
										<cfset btnf_bkgrnd = "###get_content.btn_background#" >
										<cfset btnf_color = "###get_content.btn_text_font_color#" >
										<cfset btnf_size = "#get_content.btn_text_font_size#" >
										<cfset btnf_weight = "#get_content.btn_text_font_weight#" >
										<cfset btnf_familiy = "#get_content.btn_text_font_family#" >
										<cfset btnf_decor = "#get_content.btn_text_decoration#" >
										<cfif #get_content.button_text# NEQ "" >
											<a href="../#get_content.button_link#" ><input type="button" class="btn " style="background-color:#btnf_bkgrnd#;font-style:#btnf_decor#;color:#btnf_color#;font-size:#btnf_size#;font-weight:#btnf_weight#;font-family:#btnf_familiy#" id="#get_content.button_text#" value="#get_content.button_text#"></a>
										<cfelse>
											&nbsp;	
										</cfif>
									</div>
								</div>	
						</div>
						
						<cfif #get_content.Video_position# EQ 1 >
							<div class="col-md-4 pad-top-10 pad-5" style="align:left">
								<div class="row"><div class="col-md-12 pad-bottom-10 visible-sm visible-xs visible-lg visible-md"></div></div>	
									<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="video_var">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="30"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="video-link"/>
										<cfinvokeargument name="glyph_left" value="true"/>
										<cfinvokeargument name="pass_make" value="#url.v_make#"/>
										<cfinvokeargument name="pass_video" value="#get_content.id#"/>
									</cfinvoke>
							</div>
						</cfif>
					</div>
					<div class="row pad-top-10" style="min-height:20px;align:center"></div>
			</cfloop>	
			</div>
		</section>
  </cfif>	
</div>	
</cfoutput>