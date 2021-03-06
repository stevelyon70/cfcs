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
	  		<cfset maxblk = #Get_Block2.recordcount# >
			<cfset y = 0>
			<cfloop query="Get_Block2">
				<cfset y = #y#+1>
				<cfset a_Title[y] = #Get_Block2.Title# >
				<cfset a_image[y] = #Get_Block2.image#>
				<cfset a_free_text[y] = #Get_Block2.free_text#>
				<cfset a_button_text[y] = #Get_Block2.button_text#>
				<cfset a_button_link[y] = #Get_Block2.button_link#>
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
			<section class="section-cta-v1-upper">
				<div class="row pad-bottom-10 pad-top-10">&nbsp;</div>
				 <div class="container pad-top-10 pad-bottom-10">
					<div class="row pad-bottom-10">
				 	<cfif #gt_CTA_U.recordcount# GT 0 >
						<div class="row">
							<div class="col-md-11 col-md-offset-1 pad-top-10 brands-title visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
								<span style="#ln_1_style#">#gt_CTA_U.CTA_Title_1#</span>
								<cfif #gt_CTA_U.CTA_Title_2# NEQ "">
									<br><span style="#ln_2_style#">#gt_CTA_U.CTA_Title_2#</span>
								</cfif>	
							</div>	
					</cfif>
					<cfloop index="x" from="1" to="2">
						<div class="col-md-5 col-md-offset-1 pad-top-5" style="border:1px solid white;align:center">
							<div class="row" style="min-height:100px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div>
							<div class="row cta-upper-v1-title " ><h4 class="cta-h4">#a_Title[x]#</h4></div>
							<cfif #a_free_text[x]# NEQ "" >
								<div class="row pad-top-10 pad-10 cta-upper-v1-pgtxt" >#a_free_text[x]#</div>
							</cfif>
							<div class="row pad-top-10" style="align:center">
							<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-v1-go-btn"><span class="glyphicon glyphicon-chevron-right"></span>&nbsp;&nbsp;#a_button_text[x]#</a>
							</div>
						</div>
					</cfloop>	
					</div>
					<div class="row pad-bottom-10 pad-top-10">&nbsp;</div>
					<div class="row pad-bottom-10 pad-top-10">&nbsp;</div>
					<cfif #x# LTE #maxblk# >
						<cfloop index="x" from="3" to="#maxblk#">
							<div class="col-md-5 col-md-offset-1  pad-top-5" style="border:1px solid white;align:center">
								<div class="row" style="min-height:100px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div>
								<div class="row cta-upper-v1-title" ><h4 class="cta-h4">#a_Title[x]#</h4></div>
								<cfif #a_free_text[x]# NEQ "" >
									<div class="row pad-top-10 pad-10 cta-upper-v1-pgtxt" >#a_free_text[x]#</div>
								</cfif>
								<div class="row pad-top-10" style="align:center">
								<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-v1-go-btn"><span class="glyphicon glyphicon-chevron-right"></span>&nbsp;&nbsp;#a_button_text[x]#</a>
								</div>
							</div>
						</cfloop>	
					</cfif>
					</div>
					<div class="row pad-bottom-10 pad-top-10">&nbsp;</div>
					<div class="row pad-bottom-10 pad-top-10">&nbsp;</div>
					<cfif #x# LTE #maxblk# >
						<cfloop index="x" from="5" to="#maxblk#">
							<div class="col-md-5 col-md-offset-1  pad-top-5" style="border:1px solid white;align:center">
								<div class="row" style="min-height:100px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div>
								<div class="row cta-upper-v1-title" ><h4 class="cta-h4">#a_Title[x]#</h4></div>
								<cfif #a_free_text[x]# NEQ "" >
									<div class="row pad-top-10 pad-10 cta-upper-v1-pgtxt" >#a_free_text[x]#</div>
								</cfif>
								<div class="row pad-top-10" style="align:center">
								<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-v1-go-btn"><span class="glyphicon glyphicon-chevron-right"></span>&nbsp;&nbsp;#a_button_text[x]#</a>
								</div>
							</div>
						</cfloop>	
					</cfif>
					</div>
					<div class="row pad-top-10" style="min-height:20px;align:center"></div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>

</cfoutput>