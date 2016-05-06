<cfoutput> 

<cfquery name="gtxt3" datasource="Ultra10">SELECT * FROM Variable_Multi_Section WHERE dealer_id=#url.dealer_id# AND template_id=10  AND hierarchy=3 AND active=1 ORDER BY hierarchy ASC </cfquery>

<cfset c_left_buttons 	= 0 >
<cfset c_right_buttons 	= 0 >

<cfif #gtxt3.split_box1_on# EQ 1 >
	<cfquery name="gbtn3_left" datasource="Ultra10">SELECT * FROM Variable_Multi_Section_Buttons where dealer_id=#url.dealer_id# AND section_id=#gtxt3.ID# AND section_left_right=0 AND	active=1 ORDER BY hierarchy</cfquery>
	<cfif #gbtn3_left.recordcount# NEQ 0 ><cfset c_left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt3.split_box2_on# EQ 1 >
	<cfquery name="gbtn3_right" datasource="Ultra10">SELECT	* FROM Variable_Multi_Section_Buttons where dealer_id=#url.dealer_id# AND section_id=#gtxt3.ID# AND	section_left_right=1 AND active=1 ORDER BY hierarchy</cfquery>
	<cfif #gbtn3_right.recordcount# NEQ 0 ><cfset c_right_buttons = 1 ></cfif>
</cfif>

<cfset wireframe_c = "#gtxt3.wireframe_status#" >

<style type="text/css">

.c-section_multi{ height:<cfoutput>#gtxt3.section_height#</cfoutput>; background: url('<cfoutput>#gtxt3.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt3.background_color#</cfoutput>; border:<cfoutput>#wireframe_c#</cfoutput>; }
.c-main-ic { 	width:	<cfoutput>#gtxt3.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt3.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt3.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt3.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt3.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_c#</cfoutput>; }
.c-left-block { 	 width:<cfoutput>#gtxt3.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt3.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt3.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt3.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt3.split_box1_top_bottom_pad#</cfoutput>; float:left;
				border:<cfoutput>#wireframe_c#</cfoutput>; }
.c-left-title-block {   width:100%;border-left:<cfoutput>#gtxt3.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt3.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt3.split_box1_top_bottom_pad#</cfoutput>; }
				
.c-right-block { 	 width:	<cfoutput>#gtxt3.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt3.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt3.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt3.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt3.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_c#</cfoutput>;  }
.c-right-title-block {   width:100%;border-left:<cfoutput>#gtxt3.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt3.split_box2_right_border#</cfoutput>; }

</style>
			
<cfif #gtxt3.recordcount# EQ 1 >	 
	<section class="c-section_multi">
				<div class="main-ic">
					<cfif #gtxt3.split_box1_on# EQ 1 >
						<div class="c-left-block" >
							<div class="col-md-12 c-left-title-block" >
								 #gtxt3.split_box1_title#
							</div>	
							<cfif #c_left_buttons# EQ 1 >
								<cfloop query="gbtn3_left" >
									<style type="text/css">
										.c-left-btn-spec-#gbtn3_left.currentrow# { 
											min-width:<cfoutput>#gbtn3_left.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn3_left.button_size_height#</cfoutput>!important; 
											text-align:<cfoutput>#gbtn3_left.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn3_left.button_background#</cfoutput>!important; 
											border: <cfoutput>#gbtn3_left.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn3_left.button_font_color#</cfoutput>!important ; 
											font-size:<cfoutput>#gbtn3_left.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn3_left.button_font_weight#</cfoutput>!important ; 
											margin-bottom: <cfoutput>#gbtn3_left.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn3_left.button_destination#" class="btn c-left-btn-spec-#gbtn3_left.currentrow#"><cfif #gbtn3_left.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-right"></span></cfif>#gbtn3_left.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
					
					<cfif #gtxt3.split_box2_on# EQ 1 >
						<div class="c-right-block" >
							<div class="col-md-12 c-right-title-block" >
								 #gtxt3.split_box2_title# 
							</div>		
							<cfif #c_right_buttons# EQ 1 >
								<cfloop query="gbtn3_right" >
									<style type="text/css">
									.c-right-btn-spec-#gbtn3_right.currentrow# { 
									min-width:<cfoutput>#gbtn3_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn3_right.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn3_right.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn3_right.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn3_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn3_right.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn3_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn3_right.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn3_right.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn3_right.button_destination#" class="btn c-right-btn-spec-#gbtn3_right.currentrow#"><cfif #gbtn3_right.glyph_on# EQ 2><span class="glyphicon glyphicon-chevron-left"></span></cfif>#gbtn3_right.button_text#</a>
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