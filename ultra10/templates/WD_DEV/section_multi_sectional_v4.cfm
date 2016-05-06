<cfoutput> 

<cfquery name="gtxt4" datasource="Ultra10">
	SELECT	*
	FROM    Variable_Multi_Section WHERE dealer_id = #url.dealer_id# AND template_id=10  AND hierarchy = 4 AND active = 1 ORDER BY hierarchy ASC
</cfquery>

<cfset d_left_buttons 	= 0 >
<cfset d_right_buttons 	= 0 >

<cfif #gtxt4.split_box1_on# EQ 1 >
	<cfquery name="gbtn4_left" datasource="Ultra10">
		SELECT	*
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt4.ID# AND	section_left_right = 0 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn4_left.recordcount# NEQ 0 ><cfset d_left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt4.split_box2_on# EQ 1 >
	<cfquery name="gbtn4_right" datasource="Ultra10">
		SELECT	*
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt4.ID# AND	section_left_right = 1 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn4_right.recordcount# NEQ 0 ><cfset d_right_buttons = 1 ></cfif>
</cfif>

<cfset wireframe_d = "#gtxt4.wireframe_status#" >


<style type="text/css">

.d-section_multi{ height:<cfoutput>#gtxt4.section_height#</cfoutput>;  background: url('<cfoutput>#gtxt4.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt4.background_color#</cfoutput>; border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-main-ic { 	width:	<cfoutput>#gtxt4.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt4.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt4.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt4.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt4.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-left-block { 	 width:<cfoutput>#gtxt4.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt4.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt4.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt4.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt4.split_box1_top_bottom_pad#</cfoutput>; float:left;
				border:<cfoutput>#wireframe_d#</cfoutput>;  }
.d-left-title-block {   width:100%;border-left:<cfoutput>#gtxt4.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt4.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt4.split_box1_top_bottom_pad#</cfoutput>; }
				
.d-right-block { 	  width:	<cfoutput>#gtxt4.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt4.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt4.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt4.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt4.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-right-title-block {   width:100%;border-left:<cfoutput>#gtxt4.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt4.split_box2_right_border#</cfoutput>; }

</style>




			
<cfif #gtxt4.recordcount# EQ 1 >
	<section class="d-section_multi">
				<div class="d-main-ic">
					<cfif #gtxt4.split_box1_on# EQ 1 >
						<div class="d-left-block" >
							<div class="col-md-12 d-left-title-block" >
								 #gtxt4.split_box1_title#
							</div>	
							<cfif #d_left_buttons# EQ 1 >
								<cfloop query="gbtn4_left" >
									<style type="text/css">
									.d-left-btn-spec-#gbtn4_left.currentrow# { 
									min-width:<cfoutput>#gbtn4_left.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn4_left.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn4_left.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn4_left.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn4_left.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn4_left.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn4_left.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn4_left.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn4_left.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn4_left.button_destination#" class="btn d-left-btn-spec-#gbtn4_left.currentrow#"><cfif #gbtn4_left.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-right"></span></cfif>#gbtn4_left.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
					
					<cfif #gtxt4.split_box2_on# EQ 1 >
						<div class="d-right-block" >
							<div class="col-md-12 d-right-title-block" >
								 #gtxt4.split_box2_title# 
							</div>		
							<cfif #d_right_buttons# EQ 1 >
								<cfloop query="gbtn4_right" >
									<style type="text/css">
									.d-right-btn-spec-#gbtn4_right.currentrow# { 
									min-width:<cfoutput>#gbtn4_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn4_right.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn4_right.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn4_right.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn4_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn4_right.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn4_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn4_right.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn4_right.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn4_right.button_destination#" class="btn d-right-btn-spec-#gbtn4_right.currentrow#"><cfif #gbtn4_right.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-left"></span></cfif>#gbtn4_right.button_text#</a>
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