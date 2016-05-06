<cfoutput>
<!--- Page Text --->  
	<cfset nbr_col = "2" >
	<cfquery name="gt_text" datasource="Ultra10">
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

<div class="container-fluid">	
	<section class="section-collapsable">
				
	  <cfif #gt_text.recordcount# NEQ 0 >
			<div class="row-centered">
				<div class="col-centered pad-top-10 visible-sm visible-xs visible-lg visible-md" style="align:left">
					<section class="ac-container">
						<div>
							<input id="ac-1" name="accordian-1" type="checkbox"   />
							<label for="ac-1">#gt_text.title#</label>
							<article class="ac-large"><p>#rtrim(gt_text.page_text)#</p></article>
						</div>
					</section>
				</div>
			</div>
	</cfif>  
	</div>
</div>	

</cfoutput>
