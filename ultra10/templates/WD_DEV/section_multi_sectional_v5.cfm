<cfoutput> 

<cfif NOT IsDefined("url.pg_nbr") >
	<cfset url.pg_nbr = 2 >
</cfif>

<cfquery name="gtxt5" datasource="Ultra10">
	SELECT	*
	FROM    Variable_Multi_Section
	WHERE	dealer_id = #url.dealer_id#
	AND		hierarchy = 5
	 AND template_id=10 
	AND		active = 1
	ORDER BY hierarchy ASC
</cfquery>

<cfset d_left_buttons 	= 0 >
<cfset d_right_buttons 	= 0 >

<cfif #gtxt5.split_box1_on# EQ 1 >
	<cfquery name="gbtn5_left" datasource="Ultra10">
		SELECT	*
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt5.ID# AND	section_left_right = 0 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn5_left.recordcount# NEQ 0 ><cfset d_left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt5.split_box2_on# EQ 1 >
	<cfquery name="gbtn5_right" datasource="Ultra10">
		SELECT	*
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt5.ID# AND	section_left_right = 1 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn5_right.recordcount# NEQ 0 ><cfset d_right_buttons = 1 ><cfset r_btn_cnt = 1 > 
		<cfloop query="gbtn5_right" >
			<cfif #r_btn_cnt# EQ 1 >
				<style type="text/css">
					.d-right-btn-spec{ min-width:<cfoutput>#gbtn5_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn5_right.button_size_height#</cfoutput>!important; 
								 text-align:<cfoutput>#gbtn5_right.button_text_align#</cfoutput>!important; 
								 background-color: <cfoutput>###gbtn5_right.button_background#</cfoutput>!important; 
								 border: <cfoutput>#gbtn5_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn5_right.button_font_color#</cfoutput>!important ; 
								 font-size:<cfoutput>#gbtn5_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn5_right.button_font_weight#</cfoutput>!important ; 
								 margin-bottom: <cfoutput>#gbtn5_right.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
				</style>
				<cfset r_btn_cnt = 2 >
			</cfif>
		</cfloop>	
	</cfif>
</cfif>

<cfset wireframe_d = "#gtxt5.wireframe_status#" >


<style type="text/css">

.d-section_multi{ height:<cfoutput>#gtxt5.section_height#</cfoutput>;  background: url('<cfoutput>#gtxt5.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt5.background_color#</cfoutput>; border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-main-ic { 	width:	<cfoutput>#gtxt5.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt5.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt5.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt5.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt5.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-left-block { 	 width:<cfoutput>#gtxt5.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt5.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt5.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt5.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt5.split_box1_top_bottom_pad#</cfoutput>; float:left;
				border:<cfoutput>#wireframe_d#</cfoutput>;  }
.d-left-title-block {   width:100%;border-left:<cfoutput>#gtxt3.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt3.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt3.split_box1_top_bottom_pad#</cfoutput>; }
				
.d-right-block { 	  width:	<cfoutput>#gtxt5.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt5.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt5.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt5.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt5.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-right-title-block {   width:100%;border-left:<cfoutput>#gtxt3.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt3.split_box2_right_border#</cfoutput>; }

</style>




			
<cfif #gtxt5.recordcount# EQ 1 >
	<section class="d-section_multi">
				<div class="d-main-ic">
					<cfif #gtxt5.split_box1_on# EQ 1 >
						<div class="d-left-block" >
							<div class="col-md-12 d-left-title-block" >
								 #gtxt5.split_box1_title#
							</div>	
							<cfif #d_left_buttons# EQ 1 >
								<cfloop query="gbtn5_left" >
									<style type="text/css">
									.d-left-btn-spec-#gbtn5_left.currentrow# { 
									min-width:<cfoutput>#gbtn5_left.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn5_left.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn5_left.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn5_left.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn5_left.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn5_left.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn5_left.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn5_left.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn5_left.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn5_left.button_destination#" class="btn d-left-btn-spec-#gbtn5_left.currentrow#"><cfif #gbtn5_left.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-right"></span></cfif>#gbtn5_left.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
					
					<cfif #gtxt5.split_box2_on# EQ 1 >
						<div class="d-right-block" >
							<div class="col-md-12 d-right-title-block" >
								 #gtxt5.split_box2_title# 
							</div>		
							<cfif #d_right_buttons# EQ 1 >
								<cfloop query="gbtn5_right" >
									<style type="text/css">
									.d-right-btn-spec-#gbtn5_right.currentrow# { 
									min-width:<cfoutput>#gbtn5_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn5_right.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn5_right.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn5_right.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn5_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn5_right.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn5_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn5_right.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn5_right.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn5_right.button_destination#" class="btn d-right-btn-spec-#gbtn5_right.currentrow#"><cfif #gbtn5_right.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-left"></span></cfif>#gbtn5_right.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
					
				</div>		
			<div class="clearfix"></div>
	</section>
</cfif>	



</cfoutput>