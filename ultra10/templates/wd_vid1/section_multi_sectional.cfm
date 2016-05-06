<cfoutput> 

<cfif NOT IsDefined("url.pg_nbr") >
	<cfset url.pg_nbr = 1 >
</cfif>

<cfquery name="gtxt" datasource="Ultra10">
	SELECT	ID, dealer_id, template_id, background_image, background_color, wireframe_status, main_ic_width, main_ic_pad_top, main_ic_pad_left, main_ic_pad_right, 
            main_ic_pad_bottom, split_box1_on, split_box1_width, split_box1_top_pad, split_box1_top_left_pad, split_box1_top_right_pad, split_box1_top_bottom_pad, 
            split_box1_title, split_box1_title_font, split_box1_title_size, split_box1_title_color, split_box1_title_weight, split_box1_title_decoration, split_box1_title_align, 
            split_box1_title_bottom_margin, split_box1_text, split_box1_text_font, split_box1_text_size, split_box1_text_color, split_box1_text_weight, 
            split_box1_text_decoration, split_box1_text_align, split_box1_text_bottom_margin, full_box_width, full_box_pad, full_box_left_pad, full_box_right_pad, 
            full_box_bottom_pad, split_box2_on, split_box2_width, split_box2_top_pad, split_box2_top_left_pad, split_box2_top_right_pad, split_box2_top_bottom_pad, 
            split_box2_title, split_box2_title_font, split_box2_title_size, split_box2_title_color, split_box2_title_weight, split_box2_title_decoration, split_box2_title_align, 
            split_box2_title_bottom_margin, split_box2_text, split_box2_text_font, split_box2_text_size, split_box2_text_color, split_box2_text_weight, 
            split_box2_text_decoration, split_box2_text_align2, split_box2_text_bottom_margin, active, hierarchy
	FROM    Variable_Multi_Section
	WHERE	dealer_id = #url.dealer_id#
	AND		hierarchy = #url.pg_nbr#
	AND		active = 1
	ORDER BY hierarchy ASC
</cfquery>

<cfset wireframe = "#gtxt.wireframe_status#" >


<style type="text/css">

.section_multi{ background: url('<cfoutput>#gtxt.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###gtxt.background_color#</cfoutput>; border:<cfoutput>#wireframe#</cfoutput>; }
.main-ic { 	width:	<cfoutput>#gtxt.main_ic_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt.main_ic_pad_top#</cfoutput>; margin-left: 	<cfoutput>#gtxt.main_ic_pad_left#</cfoutput>;
			margin-right: 	<cfoutput>#gtxt.main_ic_pad_right#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.main_ic_pad_bottom#</cfoutput>;float:left;  border:<cfoutput>#wireframe#</cfoutput>; }
.left-block { 	height:350px; width:<cfoutput>#gtxt.split_box1_width#</cfoutput>; margin-top:<cfoutput>#gtxt.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#gtxt.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.split_box1_top_bottom_pad#</cfoutput>; float:left; }
.left-block-title {	font-family: <cfoutput>#gtxt.split_box1_title_font#</cfoutput>; font-size: <cfoutput>#gtxt.split_box1_title_size#</cfoutput>; font-weight: <cfoutput>#gtxt.split_box1_title_weight#</cfoutput>;
					color: <cfoutput>###gtxt.split_box1_title_color#</cfoutput>; font-style:	<cfoutput>#gtxt.split_box1_title_decoration#</cfoutput>; 
					text-align: <cfoutput>#gtxt.split_box1_title_align#</cfoutput>;
					margin-bottom: <cfoutput>#gtxt.split_box1_title_bottom_margin#</cfoutput>; border:<cfoutput>#wireframe#</cfoutput>;  }
.left-block-text { 	font-family: <cfoutput>#gtxt.split_box1_text_font#</cfoutput>; font-size: <cfoutput>#gtxt.split_box1_text_size#</cfoutput>; font-weight: <cfoutput>#gtxt.split_box1_text_weight#</cfoutput>;
					color: <cfoutput>###gtxt.split_box1_text_color#</cfoutput>; font-style: 	<cfoutput>#gtxt.split_box1_text_decoration#</cfoutput>; text-align: <cfoutput>#gtxt.split_box1_text_align#</cfoutput>;
					margin-bottom: <cfoutput>#gtxt.split_box1_text_bottom_margin#</cfoutput>; border:<cfoutput>#wireframe#</cfoutput>;  }
.right-block { 	width:	<cfoutput>#gtxt.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#gtxt.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe#</cfoutput>; }
.right-block-title {	font-family: <cfoutput>#gtxt.split_box2_title_font#</cfoutput>; font-size: <cfoutput>#gtxt.split_box2_title_size#</cfoutput>; font-weight: <cfoutput>#gtxt.split_box2_title_weight#</cfoutput>;
					color: <cfoutput>###gtxt.split_box2_title_color#</cfoutput>; font-style:	<cfoutput>#gtxt.split_box2_title_decoration#</cfoutput>; text-align: <cfoutput>#gtxt.split_box2_title_align#</cfoutput>;
					margin-bottom: <cfoutput>#gtxt.split_box2_title_bottom_margin#</cfoutput>; border:<cfoutput>#wireframe#</cfoutput>;  }
.right-block-text { 	font-family: <cfoutput>#gtxt.split_box2_text_font#</cfoutput>; font-size: <cfoutput>#gtxt.split_box2_text_size#</cfoutput>; font-weight: <cfoutput>#gtxt.split_box2_text_weight#</cfoutput>;
					color: <cfoutput>###gtxt.split_box2_text_color#</cfoutput>; font-style: 	<cfoutput>#gtxt.split_box2_text_decoration#</cfoutput>; text-align: <cfoutput>#gtxt.split_box2_text_align2#</cfoutput>;
					margin-bottom: <cfoutput>#gtxt.split_box2_text_bottom_margin#</cfoutput>; border:<cfoutput>#wireframe#</cfoutput>;  }
.full-block { 	width:	<cfoutput>#gtxt.full_box_width#</cfoutput>; margin-top: 	<cfoutput>#gtxt.full_box_pad#</cfoutput>; margin-left: <cfoutput>#gtxt.full_box_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#gtxt.full_box_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#gtxt.full_box_bottom_pad#</cfoutput>; border:<cfoutput>#wireframe#</cfoutput>;  }
	
</style>




			
	 
<section class="section_multi">
	<!--- <div class="row-centered"> --->
		<!--- <div class="col-centered visible-sm visible-xs visible-lg visible-md" > --->
			<!--- <div class="main-ic"> --->
				<div class="main-ic">
					<!--- <div class="col-centered visible-sm visible-xs visible-lg visible-md" > --->
					<cfif #gtxt.split_box1_on# EQ 1 >
						<div class="left-block" >
							<!--- <div class="row"> --->
								<div class="col-md-12 left-block-title" >
									 #gtxt.split_box1_title#
								</div>	
							<!--- </div> --->
							<cfif #gtxt.split_box1_text# NEQ "" >
								<!--- <div class="row"> --->
									<div class="col-md-12 left-block-text" >
										 #gtxt.split_box1_text# 
									</div>	
								<!--- </div> --->
							</cfif>
						</div>
					</cfif>
					
					<!--- <div class="full-block" >
					<!--- 	<div class="row"> --->
							<div class="col-md-12 " >
								 &nbsp;
							</div>	
						<!--- </div> --->
					</div>  --->
						
					<cfif #gtxt.split_box2_on# EQ 1 >
						<div class="right-block" >
							<!--- <div class="row"> --->
								<div class="col-md-12 right-block-title" >
									 #gtxt.split_box2_title# 
								</div>	
							<!--- </div> --->
							<cfif #gtxt.split_box2_text# NEQ "" >
								<!--- <div class="row"> --->
									<div class="col-md-12 right-block-text" >
										 #gtxt.split_box2_text# 
									</div>	
							<!--- 	</div> --->
							</cfif>
						</div>
					</cfif>
					
				</div>		

			<!---   </div>   --->
			<div class="clearfix"></div>
			
		<!--- </div> --->
	<!--- </div> --->
</section>
	



</cfoutput>