<cfoutput>
	
<!--- CTA UPPER --->

		<cfquery name="Get_Block2" datasource="Ultra10" maxrows="4" >
			SELECT  ID, dealer_id, Title, image, free_text, button_text, button_link, target, active, create_ts, hierarchy
			FROM    Nav_Block_2
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		<cfif #Get_Block2.recordcount# NEQ 0 >
			<cfset a_title = ArrayNew(1)>
			<cfset a_image = ArrayNew(1)>
			<cfset a_free_text = ArrayNew(1)>
			<cfset a_button_text = ArrayNew(1)>
			<cfset a_button_link = ArrayNew(1)>
			<cfset a_button_target = ArrayNew(1)>
			<cfset a_button_txt_color = ArrayNew(1)>
	  		<cfset maxblk = #Get_Block2.recordcount# >
			<cfset y = 0>
			<cfloop query="Get_Block2">
				<cfset y = #y#+1>
				<cfset a_Title[y] = #Get_Block2.Title# >
				<cfset a_image[y] = #Get_Block2.image#>
				<cfset a_free_text[y] = #Get_Block2.free_text#>
				<cfset a_button_text[y] = #Get_Block2.button_text#>
				<cfset a_button_link[y] = #Get_Block2.button_link#>
				<cfif #y# EQ 1 >
					<cfset a_button_txt_color[y] = "999999">
				<cfelseif #y# EQ 2 >
					<cfset a_button_txt_color[y] = "0063ad">
				<cfelseif #y# EQ 3 >
					<cfset a_button_txt_color[y] = "cc0000">
				<cfelse>
					<cfset a_button_txt_color[y] = "000000">
				</cfif>
				<cfset a_button_target[y] ="">
				<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target[y] = "_blank"></cfif>
			</cfloop>
			<cfquery name="gt_CTA_U" datasource="Ultra10">
				SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 0
			</cfquery>
			<cfset ln_1_style="font-size:#gt_CTA_U.ft_size#;color:###gt_CTA_U.ft_color#;font-weight:#gt_CTA_U.ft_weight#">
			<cfset ln_1_align="#gt_CTA_U.txt_align#">
			<cfset ln_2_style="font-size:#gt_CTA_U.ft_size_2#;color:###gt_CTA_U.ft_color_2#;font-weight:#gt_CTA_U.ft_weight_2#">
			<cfset ln_2_align="#gt_CTA_U.txt_align_2#">
			<section class="section-portal">
				<div class="container pad-top-5 ">
				<div class="row"><div class="col-md-12 pad-top-10 visible-lg visible-md">&nbsp;</div></div>	
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="page-divider"></div></div></div>	
					
					
					<div class="row pad-bottom-10" >
					<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md">
						<cfif #maxblk# LT 4><cfset liner = "center"><cfelse><cfset liner = "left"></cfif>
						<ul  style="min-height: 325px; -webkit-column-count: 3; -moz-column-count: 3; column-count:3;"  >
						<cfloop index="x" from="1" to="#maxblk#">
		 					<div class="portal-container " >
								<li style="display: inline-block;" >
									 <div class="col-md-3 col-md-offset-2 pad-top-10 portal-upper-title">  
										<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0">
									  </div>		 
									<br>
									<div class="col-md-3  col-md-offset-2 pad-top-10 portal-upper-title" ><h4>#a_Title[x]#</h4></div>
									<br>
									<cfif #a_free_text[x]# NEQ "" >
										<div class="col-md-3 col-md-offset-2 pad-top-10  portal-upper-pgtxt" style="min-height:15px;align:center" >#a_free_text[x]#</div>
										<div class="col-md-3 col-md-offset-2 pad-top-10 portal-upper-pgtxt" style="min-height:15px;align:center"></div>
										<br>
									</cfif>
									<div class="col-md-3 col-md-offset-1 pad-top-10 portal-upper-pgtxt" >
										<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="portal-upper-go-btn" style="color:###a_button_txt_color[x]#">#a_button_text[x]#</a>
									</div>
								</li>	  
							 </div>
						</cfloop>	
						</ul>
 
					</div>
					</div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>


</cfoutput>