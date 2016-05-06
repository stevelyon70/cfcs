<cfoutput> 

<link href='http://fonts.googleapis.com/css?family=Jura' rel='stylesheet' type='text/css'>

<cfquery name="gtxt2" datasource="Ultra10">
	SELECT	*
	FROM    Variable_Multi_Section WHERE dealer_id = #url.dealer_id# AND template_id=10 AND hierarchy = 2 AND active = 1 ORDER BY hierarchy ASC
</cfquery>

<cfset b_left_buttons 	= 0 >
<cfset b_right_buttons 	= 0 >

<cfset nbr_cols = 6 >
<cfif #url.dealer_id# eq 374  OR  #url.dealer_id# eq 376  >
	<cfset nbr_cols = 12 >
</cfif>

<cfif #gtxt2.split_box1_on# EQ 1 >
	<cfquery name="gbtn2_left" datasource="Ultra10">
		SELECT	*
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt2.ID# AND	section_left_right = 0 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn2_left.recordcount# NEQ 0 ><cfset b_left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt2.split_box2_on# EQ 1 >
	<cfquery name="gbtn2_right" datasource="Ultra10">
		SELECT	*
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt2.ID# AND	section_left_right = 1 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn2_right.recordcount# NEQ 0 ><cfset b_right_buttons = 1 ></cfif>
</cfif>


<cfset wireframe_b = "#gtxt2.wireframe_status#" >

<cfif #gtxt2.split_box1_on# EQ 1 AND  #gtxt2.split_box2_on# EQ 1 >		<!--- Adjust section height if Left & Right blocks active  --->
	<cfset mbl_hght = #Val(gtxt2.section_height)# * 1.75 >
	<cfset mbl_hght = "#mbl_hght#px" >
<cfelse>	
	<cfset mbl_hght = "#gtxt2.section_height#" >
</cfif>	


<style type="text/css">

.b-section_multi{   /* max-height:<cfoutput>#gtxt2.section_height#</cfoutput>; */  height: auto!important; background: url('<cfoutput>#gtxt2.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt2.background_color#</cfoutput>; border:<cfoutput>#wireframe_b#</cfoutput>; }
.b-main-ic { 	width:	<cfoutput>#gtxt2.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt2.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt2.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt2.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt2.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_b#</cfoutput>; }
.b-left-block { 	  width:<cfoutput>#gtxt2.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt2.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt2.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt2.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt2.split_box1_top_bottom_pad#</cfoutput>; float:center; 
				border:<cfoutput>#wireframe_b#</cfoutput>; font-family:jura!important;font-size:30pt!important; 	}
.b-left-title-block {   width:100%;border-left:<cfoutput>#gtxt2.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt2.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt2.split_box1_top_bottom_pad#</cfoutput>;  font-family:jura!important;font-size:30pt!important; float:center; }

.b-right-block {  	width:	<cfoutput>#gtxt2.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt2.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt2.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt2.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt2.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_b#</cfoutput>; }
.b-right-title-block {   width:100%;border-left:<cfoutput>#gtxt2.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt2.split_box2_right_border#</cfoutput>; }

	
	@media (max-width: 600px) {
		.b-section_multi{    min-height: 50%!important;  height: auto!important;padding-top:10px!important;/* background-color: <cfoutput>###gtxt2.background_color#</cfoutput>!important; background:!important;background-size: cover; */ }
		.b-main-ic {  ;	width:	100%!important;height: 100%!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:center!important; 
						/* background-color:##666666!important; */ } 
		.b-left-block {   width:90%!important;  margin-left:3px; float:center!important;  }
		.b-left-title-block {   width:100%!important; }
		.b-right-block {   width:90%!important;  margin-left:3px; float:right!important;  }
		.b-right-title-block {   width:100%!important; }
	} /* end 600 */
</style>
			
	<cfif #gtxt2.recordcount# EQ 1 >	 
		<section class="b-section_multi">
			<!--- <div class="b-main-ic"> --->
				<div class="col-md-#nbr_cols# no-pad" >
					<cfif #gtxt2.split_box1_on# EQ 1 >
						<div class="b-left-block" >
							<div class="col-md-12 b-left-title-block" >
								 #gtxt2.split_box1_title#
							</div>	
						</div>
					</cfif>
				</div>	
				
		<cfif #url.dealer_id# NEQ 374 AND  #url.dealer_id# NEQ 376>		
				<div class="col-md-6 no-pad pull-left" >
					<cfif #gtxt2.split_box2_on# EQ 1 >
						<div class="b-right-block" >
							<div class="col-md-12 b-right-title-block" >
								 #gtxt2.split_box2_title# 
							</div>		
							<cfif #b_right_buttons# EQ 1 >
								<cfloop query="gbtn2_right" >
									<style type="text/css">
									.b-right-btn-spec-#gbtn2_right.currentrow# { 
										min-width:<cfoutput>#gbtn2_right.button_size_width#</cfoutput>!important; height:<cfoutput>#gbtn2_right.button_size_height#</cfoutput>!important; 
										text-align:<cfoutput>#gbtn2_right.button_text_align#</cfoutput>!important;background-color: <cfoutput>###gbtn2_right.button_background#</cfoutput>!important; 
										border: <cfoutput>#gbtn2_right.button_border_color#</cfoutput>!important;color:<cfoutput>###gbtn2_right.button_font_color#</cfoutput>!important ; 
										font-size:<cfoutput>#gbtn2_right.button_font_size#</cfoutput>!important ;font-weight:<cfoutput>#gbtn2_right.button_font_weight#</cfoutput>!important ; 
										margin-bottom: <cfoutput>#gbtn2_right.space_bt_btns#</cfoutput>!important; margin-left:<cfoutput>#gbtn2_left.button_margin_left#</cfoutput>!important;padding:5px 5px 5px 5px!important}
									@media (max-width: 600px) {
										.b-right-btn-spec-#gbtn2_right.currentrow# { 
										min-width:100%!important;height:50px!important;text-align:center!important;font-size:16pt!important;margin-bottom:10px!important;margin-left:0px!important;padding:2px 2px 2px 2px!important;float:center!important;}
									}
									
									</style>
									<div class="row">
										<div class="col-md-12 ">
											 <a href="#gbtn2_right.button_destination#" target="#gbtn2_right.button_target#" class="btn b-right-btn-spec-#gbtn2_right.currentrow#">#gbtn2_right.button_text#</a>
										</div>	
									</div>
								</cfloop>
							</cfif>
						</div>
					</cfif>
					
				</div>		
			</cfif>	
			<!--- </div>	 --->	
			<!--- <div class="row"><div class="col-md-12 ">&nbsp;</div></div> --->
			<div class="clearfix"></div>
		</section>
	</cfif>	



</cfoutput>