<cfoutput> 

<link href='http://fonts.googleapis.com/css?family=Jura' rel='stylesheet' type='text/css'>

<cfquery name="gtxt3" datasource="Ultra10">SELECT * FROM Variable_Multi_Section WHERE dealer_id=#url.dealer_id# AND template_id=10  AND hierarchy=3 AND active=1 ORDER BY hierarchy ASC </cfquery>

<cfset c_left_buttons 	= 0 >
<cfset c_right_buttons 	= 0 >

<cfset nbr_cols = 6 >
<cfif #url.dealer_id# eq 374  OR  #url.dealer_id# eq 376  >
	<cfset nbr_cols = 12 >
</cfif>

<cfif #gtxt3.split_box1_on# EQ 1 >
	<cfquery name="gbtn3_left" datasource="Ultra10">SELECT * FROM Variable_Multi_Section_Buttons where dealer_id=#url.dealer_id# AND section_id=#gtxt3.ID# AND section_left_right=0 AND	active=1 ORDER BY hierarchy</cfquery>
	<cfif #gbtn3_left.recordcount# NEQ 0 ><cfset c_left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt3.split_box2_on# EQ 1 >
	<cfquery name="gbtn3_right" datasource="Ultra10">SELECT	* FROM Variable_Multi_Section_Buttons where dealer_id=#url.dealer_id# AND section_id=#gtxt3.ID# AND	section_left_right=1 AND active=1 ORDER BY hierarchy</cfquery>
	<cfif #gbtn3_right.recordcount# NEQ 0 ><cfset c_right_buttons = 1 ></cfif>
</cfif>

<cfset wireframe_c = "#gtxt3.wireframe_status#" >

<cfif #gtxt3.split_box1_on# EQ 1 AND  #gtxt3.split_box2_on# EQ 1 >		<!--- Adjust section height if Left & Right blocks active  --->
	<cfset mbl_hght = #Val(gtxt3.section_height)# * 1.75 >
	<cfset mbl_hght = "#mbl_hght#px" >
<cfelse>	
	<cfset mbl_hght = "#gtxt3.section_height#" >
</cfif>	

<style type="text/css">

.c-section_multi{   min-height:<cfoutput>#gtxt3.section_height#</cfoutput>!important;  background: url('<cfoutput>#gtxt3.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt3.background_color#</cfoutput>!important; border:<cfoutput>#wireframe_c#</cfoutput>; }
.c-main-ic { 	width:	<cfoutput>#gtxt3.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt3.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt3.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt3.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt3.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_c#</cfoutput>; }
.c-left-block { 	 width:<cfoutput>#gtxt3.split_box1_width#</cfoutput>!important; margin-top:<cfoutput>#gtxt3.split_box1_top_pad#</cfoutput>!important; margin-left:<cfoutput>#gtxt3.split_box1_top_left_pad#</cfoutput>!important;
				margin-right: 	<cfoutput>#gtxt3.split_box1_top_right_pad#</cfoutput>!important; margin-bottom: 	<cfoutput>#gtxt3.split_box1_top_bottom_pad#</cfoutput>!important; float:center!important;
				border:<cfoutput>#wireframe_c#</cfoutput>; }
.c-left-title-block {   width:100%;border-left:<cfoutput>#gtxt3.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt3.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt3.split_box1_top_bottom_pad#</cfoutput>; font-family:jura!important;font-size:30pt!important; float:center; }
				
.c-right-block { 	 width:	<cfoutput>#gtxt3.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt3.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt3.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt3.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt3.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_c#</cfoutput>;  }
.c-right-title-block {   width:100%;border-left:<cfoutput>#gtxt3.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt3.split_box2_right_border#</cfoutput>; }

	
	@media (max-width: 600px) {
		.c-section_multi{     min-height: 50%!important;  height: auto!important;padding-top:10px!important;/*  background-color: <cfoutput>###gtxt3.background_color#</cfoutput>!important; background:!important; */ }
		.c-main-ic {  ;	width:	100%!important;height: 100%!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:center!important; 
						/* background-color:##666666!important; */ }
		.c-left-block {   width:90%!important;  margin-left:3px; float:center!important;  }
		.c-left-title-block {   width:100%!important; }
		.c-right-block {   width:90%!important;  margin-left:3px; float:right!important;  }
		.c-right-title-block {   width:100%!important; }
	} /* end 600 */

</style>
			
<cfif #gtxt3.recordcount# EQ 1 >	 
	<section class="c-section_multi">
				
		<div class="col-md-#nbr_cols# no-pad" >
			<cfif #gtxt3.split_box1_on# EQ 1 >
				<div class="c-left-block" >
					<div class="col-md-12  c-left-title-block " >
						 #gtxt3.split_box1_title#
					</div>	
				</div>
			</cfif>
		</div>
						
		<cfif #url.dealer_id# NEQ 374 AND  #url.dealer_id# NEQ 376>		
				<div class="col-md-6 no-pad pull-left" >
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
									margin-bottom: <cfoutput>#gbtn3_right.space_bt_btns#</cfoutput>!important; margin-left:<cfoutput>#gbtn3_right.button_margin_left#</cfoutput>!important;
									padding:<cfoutput>#gbtn3_right.button_padding#</cfoutput>!important;}
								
									@media (max-width: 600px) {
										.c-right-btn-spec-#gbtn3_right.currentrow# { 
										min-width:100%!important;height:50px!important;text-align:center!important;font-size:16pt!important;margin-bottom:10px!important;margin-left:0px!important;padding:2px 2px 2px 2px!important;float:center!important;}
										}
								
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn3_right.button_destination#" target="#gbtn3_right.button_target#" class="btn c-right-btn-spec-#gbtn3_right.currentrow#">#gbtn3_right.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
					
				</div>		
			</cfif>	
			</div>		
			<!--- <div class="row"><div class="col-md-12 ">&nbsp;</div></div> --->
			<div class="clearfix"></div>
	</section>
</cfif>




</cfoutput>