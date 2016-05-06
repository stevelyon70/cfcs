<cfoutput>
<!--- Page Text --->  
	<cfset nbr_col = "2" >
	<cfquery name="gt_text" datasource="Ultra10">
		SELECT	   id, dealer_id, page_type, usage, make, title, title_font_family, title_font_size, title_font_color, title_font_weight, title_font_decoration, page_text, 
                      page_font_family, page_font_size, page_font_color, page_font_weight, page_font_decoration, trailer, trailer_font_family, trailer_font_size, trailer_font_color, 
                      trailer_font_weight, trailer_font_decoration, link1, link1_btn_background, link1_btn_text_font_size, link1_btn_text_font_color, link1_btn_text_font_family, 
                      link1_btn_text_font_weight, link1_btn_text_decoration, link_target1, link_txt1, link2, link2_btn_background, link2_btn_text_font_size, link2_btn_text_font_color, 
                      link2_btn_text_font_family, link2_btn_text_font_weight, link2_btn_text_decoration, link_target2, link_txt2, link3, link3_btn_background, link3_btn_text_font_size, 
                      link3_btn_text_font_color, link3_btn_text_font_family, link3_btn_text_font_weight, link3_btn_text_decoration, link_target3, link_txt3, link4, link4_btn_background, 
                      link4_btn_text_font_size, link4_btn_text_font_color, link4_btn_text_font_family, link4_btn_text_font_weight, link4_btn_text_decoration, link_target4, link_txt4, link5, 
                      link5_btn_background, link5_btn_text_font_size, link5_btn_text_font_color, link5_btn_text_font_family, link5_btn_text_font_weight, link5_btn_text_decoration, 
                      link_target5, link_txt5, link6, link6_btn_background, link6_btn_text_font_size, link6_btn_text_font_color, link6_btn_text_font_family, link6_btn_text_font_weight, 
                      link6_btn_text_decoration, link_target6, link_txt6, link_font_color, link_font_family, link_font_size, link_font_weight, link_decoration, active, hierarchy
		FROM         Variable_Template_Dealer_Content
		WHERE	dealer_id = #url.dealer_id#
		AND		page_type = 0  <!---  #pg_nbr# --->
		AND		active = 1
	</cfquery>
		
			
	<cfif #gt_text.recordcount# NEQ 0 >
		<section class="section-page-text">
			<div class="container ">
				<cfloop query="gt_text" >
					<cfif #gt_text.title# NEQ "" >
						<cfset f_color = "###gt_text.title_font_color#" >
						<cfset f_size = "#gt_text.title_font_size#" >
						<cfset f_weight = "#gt_text.title_font_weight#" >
						<cfset f_familiy = "#gt_text.title_font_family#" >
						<cfset f_decor = "#gt_text.title_font_decoration#" >
						<div class="row">
							<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
								<span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.title#</span>
							</div>	
						</div>
					</cfif>
					<div class="row">
						<cfset f_color = "###gt_text.page_font_color#" >
						<cfset f_size = "#gt_text.page_font_size#" >
						<cfset f_weight = "#gt_text.page_font_weight#" >
						<cfset f_familiy = "#gt_text.page_font_family#" >
						<cfset f_decor = "#gt_text.page_font_decoration#" >
						<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
							<span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.page_text#</span>
						</div>	
					</div>
					<cfif #gt_text.trailer# NEQ "" >
						<cfset f_color = "###gt_text.trailer_font_color#" >
						<cfset f_size = "#gt_text.trailer_font_size#" >
						<cfset f_weight = "#gt_text.trailer_font_weight#" >
						<cfset f_familiy = "#gt_text.trailer_font_family#" >
						<cfset f_decor = "#gt_text.trailer_font_decoration#" >
						<div class="row">
							<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
								<span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.trailer#</span>
							</div>	
						</div>
					</cfif>
					<cfif #gt_text.link1# NEQ "" >
							
							<div class="row">
								<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="center">
							<cfif #gt_text.link1# NEQ "" >
								<cfif #gt_text.link1_btn_background# NEQ "">
									<cfset f_background = "###gt_text.link1_btn_background#" ><cfset f_color = "###gt_text.link1_btn_text_font_color#" >
									<cfset f_size = "#gt_text.link1_btn_text_font_size#" ><cfset f_weight = "#gt_text.link1_btn_text_font_weight#" >
									<cfset f_familiy = "#gt_text.link1_btn_text_font_family#" ><cfset f_decor = "#gt_text.link1_btn_text_decoration#" >
								<cfelse>
									<cfset f_background = "" ><cfset f_color = "###gt_text.link_font_color#" >
									<cfset f_size = "#gt_text.link_font_size#" ><cfset f_weight = "#gt_text.link_font_weight#" >
									<cfset f_familiy = "#gt_text.link_font_family#" ><cfset f_decor = "#gt_text.link_decoration#" >	
								</cfif>		
								<cfif #gt_text.link_target1# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link1#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link1#"></cfif>
								<a href="#destination#" target="#f_target#" ><span  class=" shop-now-btn" style="background-color:#f_background#;font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt1#</span></a>
								<!--- </div> --->	
							</cfif>	
							<cfif #gt_text.link2# NEQ "" >
								<cfif #gt_text.link2_btn_background# NEQ "">
									<cfset f_background = "###gt_text.link2_btn_background#" ><cfset f_color = "###gt_text.link2_btn_text_font_color#" >
									<cfset f_size = "#gt_text.link2_btn_text_font_size#" ><cfset f_weight = "#gt_text.link2_btn_text_font_weight#" >
									<cfset f_familiy = "#gt_text.link2_btn_text_font_family#" ><cfset f_decor = "#gt_text.link2_btn_text_decoration#" >
								<cfelse>
									<cfset f_background = "" ><cfset f_color = "###gt_text.link_font_color#" >
									<cfset f_size = "#gt_text.link_font_size#" ><cfset f_weight = "#gt_text.link_font_weight#" >
									<cfset f_familiy = "#gt_text.link_font_family#" ><cfset f_decor = "#gt_text.link_decoration#" >	
								</cfif>	
								<cfif #gt_text.link_target2# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link2#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link2#"></cfif>
								<!--- <div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left"> --->
									<a href="#destination#" target="#f_target#" ><span  class=" shop-now-btn"  style="background-color:#f_background#;font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt2#</span></a>
								<!--- </div>	 --->
							</cfif>	
							<cfif #gt_text.link3# NEQ "" >
								<cfif #gt_text.link3_btn_background# NEQ "">
									<cfset f_background = "###gt_text.link3_btn_background#" ><cfset f_color = "###gt_text.link3_btn_text_font_color#" >
									<cfset f_size = "#gt_text.link3_btn_text_font_size#" ><cfset f_weight = "#gt_text.link3_btn_text_font_weight#" >
									<cfset f_familiy = "#gt_text.link3_btn_text_font_family#" ><cfset f_decor = "#gt_text.link3_btn_text_decoration#" >
								<cfelse>
									<cfset f_background = "" ><cfset f_color = "###gt_text.link_font_color#" >
									<cfset f_size = "#gt_text.link_font_size#" ><cfset f_weight = "#gt_text.link_font_weight#" >
									<cfset f_familiy = "#gt_text.link_font_family#" ><cfset f_decor = "#gt_text.link_decoration#" >	
								</cfif>	
								<cfif #gt_text.link_target3# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link3#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link3#"></cfif>
								<!--- <div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left"> --->
									<a href="#destination#" target="#f_target#" ><span  class=" shop-now-btn"  style="background-color:#f_background#;font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt3#</span></a>
								<!--- </div>	 --->
							</cfif>	
							<cfif #gt_text.link4# NEQ "" >
								<cfif #gt_text.link4_btn_background# NEQ "">
									<cfset f_background = "###gt_text.link4_btn_background#" ><cfset f_color = "###gt_text.link4_btn_text_font_color#" >
									<cfset f_size = "#gt_text.link4_btn_text_font_size#" ><cfset f_weight = "#gt_text.link4_btn_text_font_weight#" >
									<cfset f_familiy = "#gt_text.link4_btn_text_font_family#" ><cfset f_decor = "#gt_text.link4_btn_text_decoration#" >
								<cfelse>
									<cfset f_background = "" ><cfset f_color = "###gt_text.link_font_color#" >
									<cfset f_size = "#gt_text.link_font_size#" ><cfset f_weight = "#gt_text.link_font_weight#" >
									<cfset f_familiy = "#gt_text.link_font_family#" ><cfset f_decor = "#gt_text.link_decoration#" >	
								</cfif>	
								<cfif #gt_text.link_target4# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link4#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link4#"></cfif>
								<!--- <div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left"> --->
									<a href="#destination#" target="#f_target#" ><span  class=" shop-now-btn"  style="background-color:#f_background#;font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt4#</span></a>
								<!--- </div>	 --->
							</cfif>	
							<cfif #gt_text.link5# NEQ "" >
								<cfif #gt_text.link5_btn_background# NEQ "">
									<cfset f_background = "###gt_text.link5_btn_background#" ><cfset f_color = "###gt_text.link5_btn_text_font_color#" >
									<cfset f_size = "#gt_text.link5_btn_text_font_size#" ><cfset f_weight = "#gt_text.link5_btn_text_font_weight#" >
									<cfset f_familiy = "#gt_text.link5_btn_text_font_family#" ><cfset f_decor = "#gt_text.link5_btn_text_decoration#" >
								<cfelse>
									<cfset f_background = "" ><cfset f_color = "###gt_text.link_font_color#" >
									<cfset f_size = "#gt_text.link_font_size#" ><cfset f_weight = "#gt_text.link_font_weight#" >
									<cfset f_familiy = "#gt_text.link_font_family#" ><cfset f_decor = "#gt_text.link_decoration#" >	
								</cfif>	
								<cfif #gt_text.link_target5# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link5#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link5#"></cfif>
								<!--- <div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left"> --->
									<a href="#destination#" target="#f_target#" ><span  class=" shop-now-btn"  style="background-color:#f_background#;font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt5#</span></a>
								<!--- </div>	 --->
							</cfif>	
							<cfif #gt_text.link6# NEQ "" >
								<cfif #gt_text.link6_btn_background# NEQ "">
									<cfset f_background = "###gt_text.link6_btn_background#" ><cfset f_color = "###gt_text.link6_btn_text_font_color#" >
									<cfset f_size = "#gt_text.link6_btn_text_font_size#" ><cfset f_weight = "#gt_text.link6_btn_text_font_weight#" >
									<cfset f_familiy = "#gt_text.link6_btn_text_font_family#" ><cfset f_decor = "#gt_text.link6_btn_text_decoration#" >
								<cfelse>
									<cfset f_background = "" ><cfset f_color = "###gt_text.link_font_color#" >
									<cfset f_size = "#gt_text.link_font_size#" ><cfset f_weight = "#gt_text.link_font_weight#" >
									<cfset f_familiy = "#gt_text.link_font_family#" ><cfset f_decor = "#gt_text.link_decoration#" >	
								</cfif>	
								<cfif #gt_text.link_target6# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link6#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link6#"></cfif>
								<!--- <div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left"> --->
									<a href="#destination#" target="#f_target#" ><span  class=" shop-now-btn"  style="background-color:#f_background#;font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt6#</span></a>
								<!--- </div>	 --->
							</cfif>	
						</div>
					</cfif>
					<!--- <div class="row">
						<div class="col-md-12 pad-top-10 pad-bottom-10 visible-sm visible-xs visible-lg visible-md">
							<div class="gradient"></div>
						</div>
					</div>	 --->
				</cfloop>
			</div>	
			<div class="clearfix"></div>
			<BR><BR>
		</section>
	</cfif>



</cfoutput>