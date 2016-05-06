<cfoutput> 

<cfset left_buttons 	= 0 >
<cfset right_buttons 	= 0 >

<cfquery name="gtxt" datasource="Ultra10">
	SELECT	ID, dealer_id, template_id, section_height, background_image, background_color, wireframe_status, main_ic_width, main_ic_pad_top, main_ic_pad_left, main_ic_pad_right, 
            main_ic_pad_bottom, split_box1_on, split_box1_width,split_box1_left_border,split_box1_right_border, split_box1_top_pad, split_box1_top_left_pad, split_box1_top_right_pad, split_box1_top_bottom_pad, 
            split_box1_title, split_box2_on, split_box2_width,split_box2_left_border,split_box2_right_border, split_box2_top_pad, split_box2_top_left_pad, split_box2_top_right_pad, split_box2_top_bottom_pad, 
            split_box2_title, active, hierarchy
	FROM    Variable_Multi_Section
	WHERE	dealer_id = #url.dealer_id#
	AND		hierarchy = 1
	AND		template_id = 10
	AND		active = 1
	ORDER BY hierarchy ASC
</cfquery>

<cfif #gtxt.split_box1_on# EQ 1 >
	<cfquery name="gbtn_left" datasource="Ultra10">
		SELECT	ID, dealer_id, section_id, section_left_right, space_bt_btns, button_text, button_destination, button_size_width, button_size_height, button_text_align, 
		        button_border_color, button_border_radius, button_background, button_font_color, button_font_family, button_font_size, button_font_weight, button_margin_left, button_padding, 
		        button_hover_background, button_hover_font_color, button_hover_font_family, button_hover_font_size, button_hover_font_weight, button_target, glyph_on, hierarchy, active
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt.ID# AND	section_left_right = 0 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn_left.recordcount# NEQ 0 ><cfset left_buttons = 1 ></cfif>							
</cfif>

<cfif #gtxt.split_box2_on# eq 1>
	<cfquery name="gbtn_right" datasource="Ultra10">
		SELECT	ID, dealer_id, section_id, section_left_right, space_bt_btns, button_text, button_destination, button_size_width, button_size_height, button_text_align, 
		        button_border_color, button_border_radius, button_background, button_font_color, button_font_family, button_font_size, button_font_weight,  button_margin_left, button_padding, 
		        button_hover_background, button_hover_font_color, button_hover_font_family, button_hover_font_size, button_hover_font_weight, button_target, glyph_on, hierarchy, active
		FROM    Variable_Multi_Section_Buttons where dealer_id = #url.dealer_id# AND section_id = #gtxt.ID# AND	section_left_right = 1 AND	active = 1 ORDER BY hierarchy
	</cfquery>
	<cfif #gbtn_right.recordcount# NEQ 0 ><cfset right_buttons = 1 ></cfif>
</cfif>



<cfset wireframe_a = "#gtxt.wireframe_status#" >		<!--- FOR TESTING ONLY  --->

<!--- <cfif #gtxt.split_box1_on# EQ 1 AND  #gtxt.split_box2_on# EQ 1 > --->		<!--- Adjust section height if Left & Right blocks active  --->
	<cfset mbl_hght = #Val(gtxt.section_height)# * 1.75 >
	<cfset mbl_hght = "#mbl_hght#px" >
<!--- <cfelse>	
	<cfset mbl_hght = "#gtxt.section_height#" >
</cfif>	 --->

<cfset nbr_cols = 6 >
<cfif #url.dealer_id# eq 374 >
	<cfset nbr_cols = 12 >
</cfif>
<cfif #url.dealer_id# eq 162 >
	<cfset nbr_cols = 12 >
</cfif>


<style type="text/css">

.a-section_multi{    min-height:<cfoutput>#gtxt.section_height#</cfoutput>!important;   background: url('<cfoutput>#gtxt.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt.background_color#</cfoutput>; border:<cfoutput>#wireframe_a#</cfoutput>; }
.main-ic {  	width:	<cfoutput>#gtxt.main_ic_width#</cfoutput>!important; margin-top: 	<cfoutput>#gtxt.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt.main_ic_pad_left#!important</cfoutput>;
			margin-right: 	<cfoutput>#gtxt.main_ic_pad_right#!important</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.main_ic_pad_bottom#</cfoutput>;  border:<cfoutput>#wireframe_a#</cfoutput>; }
.left-block {   width:<cfoutput>#gtxt.split_box1_width#!important</cfoutput>; margin-top:<cfoutput>#gtxt.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.split_box1_top_bottom_pad#</cfoutput>; float:left; 
				border:<cfoutput>#wireframe_a#</cfoutput>; }
.left-title-block {   width:100%;border-left:<cfoutput>#gtxt.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#gtxt.split_box1_right_border#</cfoutput>; margin-bottom: <cfoutput>#gtxt.split_box1_top_bottom_pad#</cfoutput>; }
.right-block { 	width:	<cfoutput>#gtxt.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_a#</cfoutput>;  }
.right-title-block {   width:100%;border-left:<cfoutput>#gtxt.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#gtxt.split_box2_right_border#</cfoutput>; }

	
	@media (max-width: 400px) {
		.a-section_multi{   min-height: !important;  height: auto!important;padding-top:10px!important; background-color: <cfoutput>###gtxt.background_color#</cfoutput>!important;   background-size: contain!important;  }
		.main-ic {  width:	100%!important;height: auto!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:center!important; 
						/* background-color:##666666!important; */ }
		.left-block {   width:100%!important;  margin-left:3px; float:center!important;  }
		.left-title-block {   width:100%!important; }
		.right-block {   width:100%!important;  margin-left:3px; float:right!important;  }
		.right-title-block {   width:100%!important; }
	} /* end 600 */

</style>



	<section class="a-section_multi container-fluid-section visible-md visible-lg">	<!--- fluid-secion contains multi-sections seperate from nav, links and footer 04-25-2016 --->
		
		<div class="row">
			<div class="col-md-12 visible-md visible-lg" >
				<div class="col-md-5 " style="border:1px ##cccccc solid;max-width:90%!important" ></div><div class="col-md-1"  >&nbsp;</div>
				<div class="col-md-6 "  style="border:1px ##cccccc solid;max-width:90%!important" ></div>
			</div>
		</div>
		<div class="main-ic">
			<div class="row">
				<div class="col-md-3 no-pad" >
					<div class="sp-page-text-title" style="margin-bottom:10px!important">I’m Kevin, let my 24 years of experience work for you. I am in contact with several lenders and many of which on a personal level. I have the contact you need.</div>
					<div class="sp-page-text-left" style="margin-bottom:10px!important">Do you need Credit financing? Re-Establish your Credit? Slow Pay, First Time Buyer? Then you have come to the right place. I Can Help! My Finance Department is committed to helping  customers with their credit approval needs. All applications are accepted and as a result we are able to provide you with more.</div>
					<div class="sp-page-text-title-red" >Go no further and contact me today!</div>
					<div class="sp-page-text-left" style="margin-bottom:5px!important">Phone: (814) 371-3333</div>
				</div>	
				<div class="col-md-3 "  style="padding-left:20px!important;margin-bottom:10px!important;" >
					<img alt="Kevin London"  style="margin-top:10px!important" src="http://dealers.wdautos.com/dealer/stoltzcreditconnection/images/library/Headshot_KevinLondon.jpg" class="img-responsive" >
					<div class="sp-page-text-left pull-left" style="margin-top:15px!important"> <!--- <a href="mailto:sales@stoltztoyota.com?cc=shawn@stoltztoyota.com" class="stoltz-email-btn">Email Kevin London</a> ---></div>
				</div>	
		 		<div class="col-md-6 no-pad" >
					<div class="right-block" style="margin-bottom:20px!important;border:1px ##cccccc solid; background-color: ##cccccc!important;" >
						<cfinvoke component="/cfcs/forms/form_contact" method="modern_stoltz">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dsn" value="Ultra10"/>
						</cfinvoke>
					</div>
				</div>	
			</div>
		</div>		
		<div class="row"><div class="col-md-12 ">&nbsp;</div></div> 
		<div class="clearfix"></div>
		
	</section>

	<section class="container-fluid-section visible-sm visible-xs">	
		
		<div class="row">
			<div class="col-md-12  " >
				<div class="col-md-5 " style="border:1px ##cccccc solid;max-width:100%!important" ></div><div class="col-md-1"  >&nbsp;</div>
			</div>
		</div>
		<div class="main-ic">
			<div class="row row-centered">
				<div class="col-md-6 no-pad"  style="margin-left:10px!important;margin-right:10px!important;margin-bottom:10px!important;"  >
					<div class="sp-page-text-title" style="margin-left:10px!important;margin-right:10px!important;margin-bottom:10px!important">I’m Kevin, let my 24 years of experience work for you. I am in contact with several lenders and many of which on a personal level. I have the contact you need.</div>
					<div class="sp-page-text-left" style="margin-left:10px!important;margin-right:10px!important;margin-bottom:10px!important">Do you need Credit financing? Re-Establish your Credit? Slow Pay, First Time Buyer? Then you have come to the right place. I Can Help! My Finance Department is committed to helping  customers with their credit approval needs. All applications are accepted and as a result we are able to provide you with more.</div>
					<div class="sp-page-text-title-red" >Go no further and contact me today!</div>
					<div class="sp-page-text-left" style="margin-left:10px!important;margin-right:10px!important;margin-bottom:5px!important">Phone: (814) 371-3333</div>
				</div>	
				<div class="col-md-6 col-centered"  style="align:center!important;margin-left:30px!importantpadding-left:5px!important;margin-bottom:10px!important;float:center!important" >
					<img alt="Kevin London"  style="margin-top:10px!important" src="http://dealers.wdautos.com/dealer/stoltzcreditconnection/images/library/Headshot_KevinLondon.jpg" class="img-responsive" >
					<div class="sp-page-text-left pull-left" style="margin-top:15px!important"><!---  <a href="mailto:sales@stoltztoyota.com?cc=shawn@stoltztoyota.com" class="stoltz-email-btn">Email Kevin London</a> ---></div>
				</div>	
				 <div class="row">
					<div class="col-md-12  " >
						<div class="col-md-5 " style="border:1px ##cccccc solid;max-width:100%!important" ></div><div class="col-md-1"  >&nbsp;</div>
					</div>
				</div>
				<div class="col-md-12 col-centered no-pad" >
					<div class="right-block" style="margin-left:5px!important;margin-right:5px!important;margin-bottom:20px!important;border:1px ##cccccc solid; background-color: ##cccccc!important;" >
						<cfinvoke component="/cfcs/forms/form_contact" method="modern_stoltz">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dsn" value="Ultra10"/>
						</cfinvoke>
					</div>
				</div>	
			</div>
		</div>		
		<div class="row"><div class="col-md-12 ">&nbsp;</div></div> 
		<div class="clearfix"></div>
		
	</section>



</cfoutput>





<cfoutput> 


<!--- 
	<section class="a-section_multi container-fluid-section">	<!--- fluid-secion contains multi-sections seperate from nav, links and footer 04-25-2016 --->
		<div class="main-ic"> 
			
			<div class="col-md-6 no-pad" >
				&nbsp;
			</div>	

			
		 	 
		 	<div class="col-md-1 no-pad"  >&nbsp;</div>
			<div class="col-md-5 no-pad pull-left" style="border:1px ##cccccc solid; background-color: ##cccccc!important;" >
				<cfinvoke component="/cfcs/forms/form_contact" method="modern_stoltz">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dsn" value="Ultra10"/>
				</cfinvoke>
			</div>	
		 			
		</div>		
		<!--- <div class="row"><div class="col-md-12 ">&nbsp;</div></div> --->
		<div class="clearfix"></div>
	</section>
 


 --->
</cfoutput>