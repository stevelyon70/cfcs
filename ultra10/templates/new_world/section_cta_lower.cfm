<cfoutput>
<div class="container-fluid">
<!--- LOWER CTA --->
		<cfquery name="Get_Block4" datasource="Ultra10" maxrows="4" >
			SELECT  ID, dealer_id, name, image, link, active, create_ts,target, hierarchy
			FROM    Nav_Block_4
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		<cfif #Get_Block4.recordcount# NEQ 0 >
			<cfset a_name = ArrayNew(1)>
			<cfset a_image = ArrayNew(1)>
			<cfset a_link = ArrayNew(1)>
			<cfset a_target = ArrayNew(1)>
	  		<cfset maxblk = #Get_Block4.recordcount# >
			<cfset y = 0>
			<cfloop query="Get_Block4">
				<cfset y = #y#+1>
				<cfset a_name[y] = #Get_Block4.name# >
				<cfset a_image[y] = #Get_Block4.image#>
				<cfset a_link[y] = #Get_Block4.link#>
				<cfset a_target[y] ="">
				<cfif #Get_Block4.target# NEQ "" ><cfset a_target[y] = "_blank"></cfif>
			</cfloop>
			<cfquery name="gt_CTA_L" datasource="Ultra10">
				SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 1
			</cfquery>
			<cfset ln_1_style="font-size:#gt_CTA_L.ft_size#;color:###gt_CTA_L.ft_color#;font-weight:#gt_CTA_L.ft_weight#">
			<cfset ln_1_align="#gt_CTA_L.txt_align#">
			<cfset ln_2_style="font-size:#gt_CTA_L.ft_size_2#;color:###gt_CTA_L.ft_color_2#;font-weight:#gt_CTA_L.ft_weight_2#">
			<cfset ln_2_align="#gt_CTA_L.txt_align_2#">
			<section class="section-cta-lower">
				<!---  <div class="container pad-top-10 pad-bottom-10"> --->
					<div class="row pad-bottom-10"><div class="col-md-2"></div>
				 	<cfif #gt_CTA_L.recordcount# GT 0 >
						<div class="row"><div class="col-md-12 pad-top-10 brands-title visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
							<span style="#ln_1_style#">#gt_CTA_L.CTA_Title_1#</span>
							<cfif #gt_CTA_L.CTA_Title_2# NEQ "">
								<br><span style="#ln_2_style#">#gt_CTA_L.CTA_Title_2#</span>
							</cfif>	
						</div>	
					</cfif>
						<cfloop index="x" from="1" to="2">
							<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md" style="align:center">
								<div class="row pad-top-10" style="min-height:40px;align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" style="border:2;border-color:white">
									</a>
								</div>
							</div>
							<!--- <cfif #x# EQ 1 >
								<div class="col-md-2"></div>
							</cfif> --->
						</cfloop>	
					</div>
					<cfif #x# LTE #maxblk# >
					<div class="row pad-bottom-10"><div class="col-md-2"></div>
						<cfloop index="x" from="3" to="#maxblk#">
							<div class="col-md-5 pad-top-10 visible-sm visible-xs  visible-lg visible-md" style="align:center">
								<div class="row pad-top-10" style="min-height:40px;align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="1"></a>
								</div>
							</div>
							<!--- <cfif #x# EQ 3 >
								<div class="col-md-2"></div>
							</cfif> --->
						</cfloop>	
					</div>
					</cfif>
					<div class="row pad-top-10" style="min-height:20px;align:center"></div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>	
</div>			
</cfoutput>
