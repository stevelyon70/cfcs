<cfoutput> 

<cfquery name="gtxt7" datasource="Ultra10">SELECT * FROM Variable_Multi_Section WHERE dealer_id=#url.dealer_id# AND template_id=10 	AND hierarchy=7 AND active=1 ORDER BY hierarchy ASC </cfquery>

<cfset g_left_buttons 	= 0 >
<cfset g_right_buttons 	= 0 >

<cfif #gtxt7.split_box1_on# EQ 1 >
	<cfquery name="gbtn7_left" datasource="Ultra10">SELECT * FROM Variable_Multi_Section_Buttons where dealer_id=#url.dealer_id# AND section_id=#gtxt7.ID# AND section_left_right=0 AND	active=1 ORDER BY hierarchy</cfquery>
	<cfif #gbtn7_left.recordcount# NEQ 0 ><cfset g_left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt7.split_box2_on# EQ 1 >
	<cfquery name="gbtn7_right" datasource="Ultra10">SELECT * FROM Variable_Multi_Section_Buttons where dealer_id=#url.dealer_id# AND section_id=#gtxt7.ID# AND	section_left_right=1 AND active=1 ORDER BY hierarchy</cfquery>
	<cfif #gbtn7_right.recordcount# NEQ 0 ><cfset g_right_buttons = 1 ><cfset r_btn_cnt = 1 > 
		<cfloop query="gbtn7_right" >
			<cfif #r_btn_cnt# EQ 1 >
				<style type="text/css">
					.g-right-btn-spec{ min-width:<cfoutput>#gbtn7_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn7_right.button_size_height#</cfoutput>!important; 
								 text-align:<cfoutput>#gbtn7_right.button_text_align#</cfoutput>!important; 
								 background-color: <cfoutput>###gbtn7_right.button_background#</cfoutput>!important; 
								 border: <cfoutput>#gbtn7_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn7_right.button_font_color#</cfoutput>!important ; 
								 font-size:<cfoutput>#gbtn7_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn7_right.button_font_weight#</cfoutput>!important ; 
								 margin-bottom: <cfoutput>#gbtn7_right.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
				</style>
				<cfset r_btn_cnt = 2 >
			</cfif>
		</cfloop>	
	</cfif>
</cfif>

<cfset wireframe_d = "#gtxt7.wireframe_status#" >


<style type="text/css">

.g-section_multi{ /* height:<cfoutput>#gtxt7.section_height#</cfoutput>; */  background: url('<cfoutput>#gtxt7.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt7.background_color#</cfoutput>; border:<cfoutput>#wireframe_d#</cfoutput>; }
.g-main-ic { 	width:	<cfoutput>#gtxt7.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt7.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt7.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt7.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt7.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_d#</cfoutput>; }
.g-left-block { 	 width:<cfoutput>#gtxt7.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt7.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt7.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt7.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt7.split_box1_top_bottom_pad#</cfoutput>; float:left!important;
				border:<cfoutput>#wireframe_d#</cfoutput>;  }
.g-left-title-block {   width:100%;border-left:<cfoutput>#gtxt7.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt7.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt7.split_box1_top_bottom_pad#</cfoutput>; }
				
.g-right-block { 	  width:	<cfoutput>#gtxt7.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt7.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt7.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt7.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt7.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_d#</cfoutput>; }
.g-right-title-block {   width:100%;border-left:<cfoutput>#gtxt7.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt7.split_box2_right_border#</cfoutput>; }

</style>
<cfset nbr_cols = 6 >
<cfset nbr_cols_right = 6 >
<cfif #url.dealer_id# eq 162  >
	<cfset nbr_cols = 12 >
	<cfset nbr_cols_right = 0 >
</cfif>
<div class="container-fluid" >
<cfif #gtxt7.recordcount# EQ 1 >
	<section class="g-section_multi">
				<div class="g-main-ic">
			<div class="col-md-#nbr_cols# no-pad" >
					<cfif #gtxt7.split_box1_on# EQ 1 >
						<div class="g-left-block" >
							<div class="col-md-#nbr_cols# g-left-title-block no-pad" >
								 #gtxt7.split_box1_title#
							</div>	
							<cfif #d_left_buttons# EQ 1 >
								<cfloop query="gbtn7_left" >
									<style type="text/css">
									.g-left-btn-spec-#gbtn7_left.currentrow# { 
									min-width:<cfoutput>#gbtn7_left.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn7_left.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn7_left.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn7_left.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn7_left.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn7_left.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn7_left.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn7_left.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn7_left.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn7_left.button_destination#" target="#gbtn7_left.button_target#"  class="btn g-left-btn-spec-#gbtn7_left.currentrow#">#gbtn7_left.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
				</div>	
					<cfif #gtxt7.split_box2_on# EQ 1 >
				<div class="col-md-#nbr_cols_right# no-pad" >
						<div class="g-right-block" >
							<div class="col-md-12 d-right-title-block" >
								 #gtxt7.split_box2_title# 
							</div>		
							<cfif #g_right_buttons# EQ 1 >
								<cfloop query="gbtn7_right" >
									<style type="text/css">
									.g-right-btn-spec-#gbtn7_right.currentrow# { 
									min-width:<cfoutput>#gbtn7_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn7_right.button_size_height#</cfoutput>!important; 
									text-align:<cfoutput>#gbtn7_right.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn7_right.button_background#</cfoutput>!important; 
									border: <cfoutput>#gbtn7_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn7_right.button_font_color#</cfoutput>!important ; 
									font-size:<cfoutput>#gbtn7_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn7_right.button_font_weight#</cfoutput>!important ; 
									margin-bottom: <cfoutput>#gbtn7_right.space_bt_btns#</cfoutput>!important; margin-left:20px!important;padding:5px 5px 5px 5px!important}
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn7_right.button_destination#" target="#gbtn7_right.button_target#"  class="btn g-right-btn-spec-#gbtn7_right.currentrow#">#gbtn7_right.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
				</div>	
					</cfif>
				</div>	
				</div>		
			<div class="clearfix"></div>
	</section>
</cfif>	
</div>


</cfoutput>