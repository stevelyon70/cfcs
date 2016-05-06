<cfoutput>
<cfif  left(cgi.remote_addr,13) eq "172.16.25.112">

<cfset left_buttons 	= 0 >
<cfset right_buttons 	= 0 >

<cfquery name="gtxt8" datasource="Ultra10">
	SELECT	ID, dealer_id, template_id, section_height, background_image, background_color, wireframe_status, main_ic_width, main_ic_pad_top, main_ic_pad_left, main_ic_pad_right, 
            main_ic_pad_bottom, split_box1_on, split_box1_width,split_box1_left_border,split_box1_right_border, split_box1_top_pad, split_box1_top_left_pad, split_box1_top_right_pad, split_box1_top_bottom_pad, 
            split_box1_title, split_box2_on, split_box2_width,split_box2_left_border,split_box2_right_border, split_box2_top_pad, split_box2_top_left_pad, split_box2_top_right_pad, split_box2_top_bottom_pad, 
            split_box2_title, active, hierarchy
	FROM    Variable_Multi_Section
	WHERE	dealer_id = #url.dealer_id#
	AND		hierarchy = 8
	AND		template_id = 10
	AND		active = 1
	ORDER BY hierarchy ASC
</cfquery>

<cfif #gtxt8.split_box1_on# EQ 1 >
	<cfquery name="gbtn_left8" datasource="Ultra10">
		SELECT	ID, dealer_id, section_id, section_left_right, space_bt_btns, button_text, button_destination, button_size_width, button_size_height, button_text_align, 
		        button_border_color, button_border_radius, button_background, button_font_color, button_font_family, button_font_size, button_font_weight, button_margin_left, button_padding, 
		        button_hover_background, button_hover_font_color, button_hover_font_family, button_hover_font_size, button_hover_font_weight, glyph_on, hierarchy, active
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt8.ID# AND	section_left_right = 0 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn_left8.recordcount# NEQ 0 ><cfset left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt8.split_box2_on# eq 1>
	<cfquery name="gbtn_right8" datasource="Ultra10">
		SELECT	ID, dealer_id, section_id, section_left_right, space_bt_btns, button_text, button_destination, button_size_width, button_size_height, button_text_align, 
		        button_border_color, button_border_radius, button_background, button_font_color, button_font_family, button_font_size, button_font_weight,  button_margin_left, button_padding, 
		        button_hover_background, button_hover_font_color, button_hover_font_family, button_hover_font_size, button_hover_font_weight, glyph_on, hierarchy, active
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt8.ID# AND	section_left_right = 1 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn_right8.recordcount# NEQ 0 ><cfset right_buttons = 1 ></cfif>
</cfif>



<cfset wireframe_bx = "#gtxt8.wireframe_status#" >		<!--- FOR TESTING ONLY  --->

<!--- <cfif #gtxt8.split_box1_on# EQ 1 AND  #gtxt8.split_box2_on# EQ 1 > --->		<!--- Adjust section height if Left & Right blocks active  --->
	<cfset mbl_hght = #Val(gtxt8.section_height)# * 1.75 >
	<cfset mbl_hght = "#mbl_hght#px" >
<!--- <cfelse>	
	<cfset mbl_hght = "#gtxt8.section_height#" >
</cfif>	 --->


<style type="text/css">

.ns-section_multi{    min-height:<cfoutput>#gtxt8.section_height#</cfoutput>!important;   background: url('<cfoutput>#gtxt8.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt8.background_color#</cfoutput>; border:<cfoutput>#wireframe_bx#</cfoutput>; }
.main-ic {  	width:	<cfoutput>#gtxt8.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt8.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt8.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt8.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt8.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_bx#</cfoutput>; }
.left-block {   width:<cfoutput>#gtxt8.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt8.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt8.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt8.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt8.split_box1_top_bottom_pad#</cfoutput>; float:left; 
				border:<cfoutput>#wireframe_bx#</cfoutput>; }
.left-title-block {   width:100%;border-left:<cfoutput>#gtxt8.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt8.split_box1_right_border#</cfoutput>; margin-bottom: <cfoutput>#gtxt8.split_box1_top_bottom_pad#</cfoutput>; }
.right-block { 	width:	<cfoutput>#gtxt8.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt8.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt8.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt8.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt8.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_bx#</cfoutput>;  }
.right-title-block {   width:100%;border-left:<cfoutput>#gtxt8.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt8.split_box2_right_border#</cfoutput>; }

	
	@media (max-width: 768px) {
		.ns-section_multi{    min-height: 50%!important;  height: auto!important;padding-top:10px!important; /* background-color: <cfoutput>###gtxt8.background_color#</cfoutput>!important;   background-size: contain!important; */ }
		.main-ic {  width:	100%!important;height: 100%!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:center!important; 
						/* background-color:##666666!important; */ }
		.left-block {   width:90%!important;  margin-left:3px; float:center!important;  }
		.left-title-block {   width:100%!important; }
		.right-block {   width:90%!important;  margin-left:3px; float:right!important;  }
		.right-title-block {   width:100%!important; }
	} /* end 600 */

</style>



<cfif #gtxt8.recordcount# EQ 1 >	 
	<section class="ns-section_multi">
		<div class="main-ic">
			<div class="col-md-6 no-pad" >
			<cfif #gtxt8.split_box1_on# EQ 1 >
				<div class="left-block" >
					<div class="col-md-12 left-title-block" >
						 #gtxt8.split_box1_title#
					</div>	
					<cfif #left_buttons# EQ 1 >
						<cfloop query="gbtn_left8" >
							<style type="text/css">
								.a-left-btn-spec-#gbtn_left8.currentrow# { 
									min-width:<cfoutput>#gbtn_left8.button_size_width#</cfoutput>!important;height:<cfoutput>#gbtn_left8.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn_left8.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn_left8.button_background#</cfoutput>!important; 
								 	border: <cfoutput>#gbtn_left8.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn_left8.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn_left8.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn_left8.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn_left8.space_bt_btns#</cfoutput>!important; margin-left:<cfoutput>#gbtn_left8.button_margin_left#</cfoutput>!important;
									padding:<cfoutput>#gbtn_left8.button_padding#</cfoutput>!important;}
									
								@media (max-width: 768px) {
									.a-left-btn-spec-#gbtn_left8.currentrow# { 
										min-width:100%!important;height:50px!important;text-align:center!important;font-size:16pt!important;margin-bottom:10px!important;margin-left:0px!important;padding:2px 2px 2px 2px!important;float:center!important;}
								}
								
							</style> 
							<div class="row">
								<div class="col-md-12 ">
									 <a href="#gbtn_left8.button_destination#" class="btn a-left-btn-spec-#gbtn_left8.currentrow#"><cfif #gbtn_left8.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-right"></span></cfif>&nbsp;&nbsp;&nbsp;#gbtn_left8.button_text#</a>
								</div>	
							</div>
						</cfloop>
					</cfif>
				</div>
			</cfif>
			</div>	
					
			<div class="col-md-6 no-pad" >
			<cfif #gtxt8.split_box2_on# EQ 1 >
				<div class="right-block" >
					<div class="col-md-12 right-title-block" >
						 #gtxt8.split_box2_title# 
					</div>		
					<cfif #right_buttons# EQ 1 >
						<cfloop query="gbtn_right8" >
							<style type="text/css">
							.a-right-btn-spec-#gbtn_right8.currentrow# { 
								min-width:<cfoutput>#gbtn_right8.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn_right8.button_size_height#</cfoutput>!important; 
								text-align:<cfoutput>#gbtn_right8.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn_right8.button_background#</cfoutput>!important; 
								border: <cfoutput>#gbtn_right8.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn_right8.button_font_color#</cfoutput>!important ; 
								font-size:<cfoutput>#gbtn_right8.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn_right8.button_font_weight#</cfoutput>!important ; 
								margin-bottom: <cfoutput>#gbtn_right8.space_bt_btns#</cfoutput>!important;  margin-left:<cfoutput>#gbtn_right8.button_margin_left#</cfoutput>!important;
								padding:<cfoutput>#gbtn_right8.button_padding#</cfoutput>!important;}
								
								@media screen only and (min-width: 768px) {
								.a-right-btn-spec-#gbtn_right8.currentrow# { min-width:100%!important;height:50px!important;text-align:center!important;font-size:18pt!important;
																			 margin-bottom:10px!important;margin-left:0px!important;padding:2px 2px 2px 2px!important;float:center!important;} }
								@media screen only and (min-width: 992px) {
								.a-right-btn-spec-#gbtn_right8.currentrow# { min-width:100%!important;height:50px!important;text-align:center!important;font-size:18pt!important;
																			 margin-bottom:10px!important;margin-left:0px!important;padding:2px 2px 2px 2px!important;float:center!important;} }
								
							</style>
							<div class="row">
								<div class="col-md-12 ">
									 <a href="#gbtn_right8.button_destination#" class="btn a-right-btn-spec-#gbtn_right8.currentrow#"><cfif #gbtn_right8.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-left"></span></cfif>#gbtn_right8.button_text#</a>
								</div>	
							</div>
						</cfloop>
					</cfif>
				</div>
			</cfif>
			</div>	
				
</cfif>	









<!--- slider starts here --->
	<!--- <div class="container-fluid"> --->
		<section class="section-90-percent">
			<div class="container pad-top-10 visible-md visible-lg ">
					<div class="row"><div class="col-md-12  visible-lg visible-md"><div class="gradient"></div></div></div>	
					<div class="row-centered"><div class="col-centered pad-top 5px  visible-lg visible-md"><div class="page-div"></div>		
					</div>
						<div id="#arguments.assets#-spl-carousel" class="col-md-12 pad-top-10"> 
						
						
						
						<cfinvoke component="/cfcs/ultra10/bxslider" method="v_limited">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="N"/>
								<cfinvokeargument name="minSlides" value="4"/>	
								<cfinvokeargument name="maxSlides" value="4"/>
								<cfinvokeargument name="slideWidth" value="300"/>
								<cfinvokeargument name="slideMargin" value="10"/>
								<cfinvokeargument name="carousel_class" value="fv-carousel"/>
							</cfinvoke>
						
						
						<!--- <cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="31"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke>  --->
						</div>
					</div>
				</div>
		</section>
	<!--- </div>	 --->

		</div>		
		<!--- <div class="row"><div class="col-md-12 ">&nbsp;</div></div> --->
		<div class="clearfix"></div>
	</section>
	
</cfif>	
</cfoutput>
