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
<cfif #url.dealer_id# eq 374 OR  #url.dealer_id# eq 376  >
	<cfset nbr_cols = 12 >
</cfif>
 <cfset poster =  "http://dealers.wdautos.com/dealer/worlddealercorp/videos/wd-net_poster.jpg" >

<style type="text/css">

.a-section_multi{   /* min-height:<cfoutput>#gtxt.section_height#</cfoutput>!important; */   height: auto!important;  background: url('<cfoutput>#gtxt.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
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

	
	@media (max-width: 600px) {
	 	.a-section_multi{ height: auto!important;padding-top:10px!important; background-color: <cfoutput>###gtxt.background_color#</cfoutput>!important;   background-size: contain!important;  } 

	/* .a-section_multi{    height: auto!important;  background: url('<cfoutput>#poster#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt.background_color#</cfoutput>; border:<cfoutput>#wireframe_a#</cfoutput>; }
*/
	
		.main-ic {  width:	100%!important;height: 100%!important; margin-left: 2px!important;	margin-right: 0px!important; margin-bottom:3px!important;float:center!important; 
						/* background-color:##666666!important; */ }
		.left-block {   width:90%!important;  margin-left:3px; float:center!important;  }
		.left-title-block {   width:100%!important; }
		.right-block {   width:90%!important;  margin-left:3px; float:right!important;  }
		.right-title-block {   width:100%!important; }
	} /* end 600 */

</style>



<cfif #gtxt.recordcount# EQ 1 >	 
	<section class="a-section_multi">
	 <div id="video-wrap" class="video-wrap">
	 
	 
       	<!-- START VIDEO BACKGROUND -->
           <video preload="metadata" autoplay loop id="my-video">
              <source src="http://dealers.wdautos.com/dealer/worlddealercorp/videos/worlddealerdotnet_rev2.mp4" type="video/mp4">    
             <!--- <source src="/dealer/aspenmarketing/videos/demovideo_1.mp4" type="video/mp4"> ---> 
           </video>
          	<!-- END PARALLAX VIDEO BACKGROUND -->
           <!-- START VIDEO OVERLAY -->
           <div class="content-overlay visible-md visible-lg">
               <h1 align="center">- WorldDealer -<br>ONE COMPANY. ONE CALL. ALL MEDIA.</h1>
           </div>
           <div class="content-overlay-mbl visible-xs visible-sm">
               <h2 align="center">- WorldDealer -<br>ONE COMPANY.<br>ONE CALL.<br>ALL MEDIA.</h2>
           </div>
           <!-- END VIDEO OVERLAY -->
       </div>
		<div class="clearfix"></div>
	</section>
</cfif>	

</cfoutput>