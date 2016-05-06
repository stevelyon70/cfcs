<cfoutput>
	
<!--- CTA UPPER --->
<link href='http://fonts.googleapis.com/css?family=Jura' rel='stylesheet' type='text/css'>

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
<cfset nbr_cols = 4 >
<cfif #url.dealer_id# eq 374 or #url.dealer_id# eq 376 ><cfset nbr_cols = 4 ></cfif>			
			<cfset ln_1_style="font-family:jura;font-size:#gt_CTA_U.ft_size#;color:###gt_CTA_U.ft_color#;font-weight:800;align:#gt_CTA_U.txt_align#">
			<cfset ln_1_align="align:#gt_CTA_U.txt_align#">
			<cfset ln_2_style="font-size:#gt_CTA_U.ft_size_2#;color:###gt_CTA_U.ft_color_2#;font-weight:#gt_CTA_U.ft_weight_2#">
			<cfset ln_2_align="#gt_CTA_U.txt_align_2#">
			<section class="section-cta-upper">
<div class="section-80-percent" >		<!--- NEW 10/30/2015 --->
				<div class="container ">
				 	<cfif #gt_CTA_U.recordcount# GT 0 >
						<div class="row-centered">
							<div class="col-centered pad-top-10 visible-sm visible-xs visible-lg visible-md">
								<div style="#ln_1_style#">#gt_CTA_U.CTA_Title_1#</div>
								<cfif #gt_CTA_U.CTA_Title_2# NEQ "">
									 <span style="#ln_2_style#">#gt_CTA_U.CTA_Title_2#</span>
								</cfif>	
							</div>	
						</div>	
					</cfif>
					<div class="row pad-bottom-10" style="min-height:50px">
						<cfloop index="x" from="1" to="#maxblk#" >
							<div class="col-md-#nbr_cols#  visible-lg visible-md pad-top-5 " align="center">
								<div class="row" >
									<div class="col-md-12" >
									<!-- START FEATURED COLUMN 1 -->
					                <div class="Featured-Third" style="align:center;">  
										<a href="#a_button_link[x]#" target="#a_button_target[x]#"  >
										<img src="http://dealers.wdautos.com/dealer/worlddealercorp/images/icons/#a_image[x]#" class="img-responsive" width="90" height="90" style="text-align:center;" alt="#a_Title[x]# Services from WorldDealer" /></a>
        								<h3 align="center">#a_Title[x]#</h3>
										<div class="col-md-12 cta-upper-pgtxt" align="left" >
											#a_free_text[x]#
										</div>
										<div class="col-md-12" align="center" >
											<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn"><!--- <span class="glyphicon glyphicon-chevron-right"></span> --->&nbsp;&nbsp;#a_button_text[x]#</a>
										</div>
			        			 	</div>  
                    				<!-- END FEATURED COLUMN 1 -->
									</div>
								</div>
							</div>
							<div class="col-md-12 visible-sm visible-xs pad-top-5 "align="center">
								<div class="row" > 
									<div class="col-md-12 visible-sm visible-xs " >
									<!-- START FEATURED COLUMN 1 -->
					               <!---  <div class="Featured-Third"  style="align:center;border:1px solid red" >   --->
										<a href="#a_button_link[x]#" target="#a_button_target[x]#"  >
										<img src="http://dealers.wdautos.com/dealer/worlddealercorp/images/icons/#a_image[x]#" class="img-responsive " style="text-align:center;" alt="#a_Title[x]# Services from WorldDealer" /></a>
        								<h3 align="center">#a_Title[x]#</h3>
										<div class="col-md-12 cta-upper-pgtxt" align="left" >
											#a_free_text[x]#
										</div>
										<div class="col-md-12" align="center" >
											<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn">&nbsp;&nbsp;#a_button_text[x]#</a>
										</div>
			        			 	<!--- </div>   --->
                    				<!-- END FEATURED COLUMN 1 -->
									</div>
								</div>
							</div>
						</cfloop>	
					</div>
				</div>	
				<div class="clearfix"></div>
		</div>		
			</section>
		</cfif>

</cfoutput>