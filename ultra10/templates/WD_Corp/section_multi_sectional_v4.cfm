<cfoutput> 

<!---<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>--->
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
<script src="http://ultra10.wddemos.com/wdsite/js/owl.carousel2.0.js"></script>

<cfquery name="gtxt4" datasource="Ultra10">
	SELECT	*
	FROM    Variable_Multi_Section WHERE dealer_id = #url.dealer_id# AND template_id=10  AND hierarchy = 4 AND active = 1 ORDER BY hierarchy ASC
</cfquery>

<cfset d_left_buttons 	= 0 >
<cfset d_right_buttons 	= 0 >

<cfset nbr_cols = 6 >
<cfif #url.dealer_id# eq 374  OR  #url.dealer_id# eq 376  >
	<cfset nbr_cols = 12 >
</cfif>

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

<cfif #gtxt4.split_box1_on# EQ 1 AND  #gtxt4.split_box2_on# EQ 1 >		<!--- Adjust section height if Left & Right blocks active  --->
	<cfset mbl_hght = #Val(gtxt4.section_height)# * 1.75 >
	<cfset mbl_hght = "#mbl_hght#px" >
<cfelse>	
	<cfset mbl_hght = "#gtxt4.section_height#" >
</cfif>	


<style type="text/css">

.d-section_multi{   min-height:<cfoutput>#gtxt4.section_height#</cfoutput>!important;    background: url('<cfoutput>#gtxt4.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt4.background_color#</cfoutput>!important; border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-main-ic { 	width:	<cfoutput>#gtxt4.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt4.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt4.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt4.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt4.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-left-block { 	 width:<cfoutput>#gtxt4.split_box1_width#</cfoutput>!important; margin-top:<cfoutput>#gtxt4.split_box1_top_pad#</cfoutput>!important; margin-left:<cfoutput>#gtxt4.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt4.split_box1_top_right_pad#</cfoutput>!important; margin-bottom: 	<cfoutput>#gtxt4.split_box1_top_bottom_pad#</cfoutput>!important; float:center!important;
				border:<cfoutput>#wireframe_d#</cfoutput>;  }
.d-left-title-block {   width:100%;border-left:<cfoutput>#gtxt4.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt4.split_box1_right_border#</cfoutput>; 
						margin-bottom: <cfoutput>#gtxt4.split_box1_top_bottom_pad#</cfoutput>; }
				
.d-right-block { 	  width:	<cfoutput>#gtxt4.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt4.split_box2_top_pad#</cfoutput>; 
				margin-left: <cfoutput>#gtxt4.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt4.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt4.split_box2_top_bottom_pad#</cfoutput>; float:center!important;  
				border:<cfoutput>#wireframe_d#</cfoutput>; }
.d-right-title-block {   width:100%;border-left:<cfoutput>#gtxt4.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt4.split_box2_right_border#</cfoutput>; }

	@media (max-width: 600px) {
		.d-section_multi{   min-height: 50%!important; height: auto!important;padding-top:10px!important; /*  background-color: <cfoutput>###gtxt4.background_color#</cfoutput>!important;  background:!important; */ }
		.d-main-ic {  width:	100%!important;height: 100%!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:left!important; 
						/* background-color:##666666!important; */  }
		.d-left-block {   width:90%!important;  margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:center!important;  }
		.d-left-title-block {   width:100%!important; }
		.d-right-block {   width:90%!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important; float:left!important;   }
		.d-right-title-block {   width:100%!important;  }
	} /* end 600 */

</style>




			
<cfif #gtxt4.recordcount# EQ 1 >
	<section class="d-section_multi">

			<div class="col-md-#nbr_cols# no-pad" >
				<cfif #gtxt4.split_box1_on# EQ 1 >
					<div class="d-left-block no-pad">
						<div class="col-md-12 d-left-title-block" >
							 #gtxt4.split_box1_title#
						</div>	
					</div>
				</cfif>
			</div>
				
		<cfif #url.dealer_id# NEQ 374 AND  #url.dealer_id# NEQ 376>		
			<div class="col-md-6 no-pad">
				<cfif #gtxt4.split_box2_on# EQ 1 >
					<div class="d-right-block   no-pad" >
						<div class="col-md-12  d-right-title-block" >
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
								margin-bottom: <cfoutput>#gbtn4_right.space_bt_btns#</cfoutput>!important; margin-left:<cfoutput>#gbtn4_right.button_margin_left#</cfoutput>!important;
									padding:<cfoutput>#gbtn4_right.button_padding#</cfoutput>!important;}
								
									@media (max-width: 600px) {
										.d-right-btn-spec-#gbtn4_right.currentrow# { 
										min-width:100%!important;height:50px!important;text-align:center!important;font-size:16pt!important;
										margin-bottom:10px!important;margin-left:0px!important;padding:2px 2px 2px 2px!important;float:left!important;}
										}
								
								</style>
								<div class="row">
									<div class="col-md-12 ">
										 <a href="#gbtn4_right.button_destination#" target="#gbtn4_right.button_target#" class="btn d-right-btn-spec-#gbtn4_right.currentrow#">#gbtn4_right.button_text#</a>
									</div>	
								</div>
							</cfloop>
						</cfif>
					</div>
				</cfif>
					
				</div>		
			</cfif>	 
			<!--- <div class="row"><div class="col-md-12 ">&nbsp;</div></div> --->
			<div class="clearfix"></div>
	</section>
</cfif>	



</cfoutput>