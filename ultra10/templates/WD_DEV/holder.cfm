
<!--- Page Text --->  
	<cfif NOT IsDefined("pg_nbr") >
		<cfset pg_nbr = 0 >
	</cfif>
	<cfset nbr_col = "2" >
	<cfquery name="gt_divider" datasource="Ultra10">
		SELECT	   id, dealer_id, page_type, usage, make, title, title_font_family, title_font_size, title_font_color, title_font_weight, title_font_decoration, page_text, 
                      page_font_family, page_font_size, page_font_color, page_font_weight, page_font_decoration, trailer, trailer_font_family, trailer_font_size, trailer_font_color, 
                      trailer_font_weight, trailer_font_decoration, link1, link1_btn_background, link1_btn_text_font_size, link1_btn_text_font_color, link1_btn_text_font_family, 
                      link1_btn_text_font_weight, link1_btn_text_decoration, link_target1, link_txt1, link2, link2_btn_background, link2_btn_text_font_size, link2_btn_text_font_color, 
                      link2_btn_text_font_family, link2_btn_text_font_weight, link2_btn_text_decoration, link_target2, link_txt2, link3, link3_btn_background, link3_btn_text_font_size, 
                      link3_btn_text_font_color, link3_btn_text_font_family, link3_btn_text_font_weight, link3_btn_text_decoration, link_target3, link_txt3, link4, link4_btn_background, 
                      link4_btn_text_font_size, link4_btn_text_font_color, link4_btn_text_font_family, link4_btn_text_font_weight, link4_btn_text_decoration, link_target4, link_txt4, link5, 
                      link5_btn_background, link5_btn_text_font_size, link5_btn_text_font_color, link5_btn_text_font_family, link5_btn_text_font_weight, link5_btn_text_decoration, 
                      link_target5, link_txt5, link6, link6_btn_background, link6_btn_text_font_size, link6_btn_text_font_color, link6_btn_text_font_family, link6_btn_text_font_weight, 
                      link6_btn_text_decoration, link_target6, link_txt6, link_font_color, link_font_family, link_font_size, link_font_weight, link_decoration, active, hierarchy
		FROM         Variable_Template_Dealer_Content
		WHERE	dealer_id = #url.dealer_id#
		AND		page_type = #pg_nbr#
		AND		hierarchy = 1
		AND		active = 1
	</cfquery>
	
<cfset more_txt = "Learn More" >
<style type="text/css">
	
		/* START OF COLLAPSE 12/31/2015  */	
		.section-collapsable-new { background: url('http://dealers.wdautos.com/dealer/pintotest/images/slideshow/bg-road.jpg') no-repeat center top; 
				-webkit-background-size: cover;  
				-moz-background-size: cover;  
				-o-background-size: cover;
	 			background-size: cover; }
				
		.ac-container-#gt_divider.currentrow# { width: 50%; border:0px solid ##ffffff; margin: 10px auto 0px auto; }
		.ac-container-#gt_divider.currentrow# label {
						font-family: 'BebasNeueRegular', 'Arial Narrow', Arial, sans-serif;
						padding: 5px 5px;
						text-align:left;
						position: relative;
						z-index: 20;
						display: block;
						height: 80%;
						border:0px solid ##000000;
						cursor: pointer;
						color: ##000000;
						text-shadow: 1px 1px 1px rgba(255,255,255,0.8);
						line-height: 25px;
						font-size: 14px;
						background: linear-gradient(top, ##ffffff 1%,##eaeaea 100%);
						box-shadow: 0px 0px 0px 0px rgba(155,155,155,0.3), 0px 0px 0px 0px rgba(255,255,255,0.9) inset, 0px 0px 0px rgba(0,0,0,0.1);
		}
		.ac-container-#gt_divider.currentrow#  label:hover{ background: ##fff; }
		.ac-container-#gt_divider.currentrow#  input:checked + label,.ac-container-#gt_divider.currentrow#  input:checked + label:hover{
						background: ##ffffff;
						color: ##000000;
						text-shadow: 0px 1px 1px rgba(255,255,255, 0.6);
						box-shadow: 
						0px 0px 0px 0px rgba(155,155,155,0.3), 
						0px 0px 0px rgba(0,0,0,0.1);
		}
		.ac-container-#gt_divider.currentrow#  label:after,
		.ac-container-#gt_divider.currentrow#  input:checked + label:after{ content: '<cfoutput>#more_txt#</cfoutput>'; color:##cc0000!important; margin-left:5px; }
		.ac-container-#gt_divider.currentrow#  input:checked + label:after{ content: 'Less'; color:##cc0000!important; position: absolute; margin-left:5px; }
		.ac-container-#gt_divider.currentrow#  input{ display: none; }
		.ac-container-#gt_divider.currentrow#  article{
						background: rgba(255, 255, 255, 0.5);
						margin-top: 15px;
						text-align:left;
						overflow: hidden;
						height: 0px;
						position: relative;
						z-index: 10;
						transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
		}
		.ac-container-#gt_divider.currentrow#  input:checked ~ article { transition: height 0.5s ease-in-out, box-shadow 0.1s linear; box-shadow: 0px 0px 0px 0px rgba(155,155,155,0.3); }
		.ac-container-#gt_divider.currentrow#  article  p{ color: ##777; line-height: 23px; font-size: 14px; padding: 0px; text-shadow: 1px 1px 1px rgba(255,255,255,0.8); }
		.ac-container-#gt_divider.currentrow#  input:checked ~ article.ac-small-#gt_divider.currentrow# { height: auto; }
		.ac-container-#gt_divider.currentrow#  input:checked ~ article.ac-medium-#gt_divider.currentrow# { height: auto; }
		.ac-container-#gt_divider.currentrow#  input:checked ~ article.ac-large-#gt_divider.currentrow# { height: auto; }
		/* END OF COLLAPSE  */

</style>
	
	
	
<div class="container-fluid">	
	<section class="section-collapsable-new no-pad">
				
	  <cfif #gt_divider.recordcount# NEQ 0 >
			<div class="row-centered">
				<div class="col-centered pad-top-10 visible-sm visible-xs visible-lg visible-md" style="align:left">
					<section class="ac-container-#gt_divider.currentrow# ">
						<div>
							<input id="ac-1-#gt_divider.currentrow# " name="accordian-1" type="checkbox"   />
							<label for="ac-1-#gt_divider.currentrow# ">#gt_divider.title#</label>
							<article class="ac-large-#gt_divider.currentrow# "><p>#rtrim(gt_divider.page_text)#</p></article  >
						</div>
					</section>
				</div>
			</div>
	</cfif>  
	</div>
</div>	


