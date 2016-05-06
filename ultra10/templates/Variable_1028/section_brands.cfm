
<cfoutput>
<!--- BRANDS --->  
		<cfquery name="Get_Assigned_OEMs" datasource="Ultra10" >
			SELECT  a.ID, a.dealer_id, a.dealer_oem_id, a.link_to,a.website_link,a.website_target, a.active, a.hierarchy,
					b.OEM_ID, b.Logo,b.OEM_Name
			FROM    Vulcan_Brand_Links a, OEMs b
			where 	a.dealer_id = #url.dealer_id#
			and		a.dealer_oem_id = b.OEM_ID
			and a.active = 1
			order by a.hierarchy ASC
		</cfquery>
		<cfset nbr_col = "2" >
		<cfif  #Get_Assigned_OEMs.recordcount# GT 0 >
			<cfset howmany = #Get_Assigned_OEMs.recordcount# >
			<cfquery name="gt_brands" datasource="Ultra10">
				SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 2
			</cfquery>
			<cfset ln_1_style="font-size:#gt_brands.ft_size#;color:###gt_brands.ft_color#;font-weight:#gt_brands.ft_weight#;font-family:Times New Roman">
			<cfset ln_1_align="#gt_brands.txt_align#">
			<cfset ln_2_style="font-size:#gt_brands.ft_size_2#;color:###gt_brands.ft_color_2#;font-weight:#gt_brands.ft_weight_2#">
			<cfset ln_2_align="#gt_brands.txt_align_2#">
			
			
			<section class="section-brands">
				 <div class="container pad-top-10">
				 	<div class="container-brands">
						<cfif #gt_brands.recordcount# NEQ 0 >
							<div class="row">
								<div class="col-md-12 pad-top-10 brands-title visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
									<span style="#ln_1_style#">#gt_brands.CTA_Title_1#</span>
									<cfif #gt_brands.CTA_Title_2# NEQ "">
										<br><span style="#ln_2_style#">#gt_brands.CTA_Title_2#</span>
									</cfif>	
								</div>	
							</div>
						</cfif>
						<div class="row">
							<cfset whats_left = #Get_Assigned_OEMs.recordcount# >
							<cfset do_once = 1 >
							<cfset off_set = 0 >
							<div class="col-md-12 " style="align:center">
								<cfloop query="Get_Assigned_OEMs" >
									<!--- <cfif #whats_left# lt 5 AND #do_once# EQ 1 >
										<cfset off_set = 6 - #whats_left# >
										<cfset do_once = 0 >
									<cfelse>	<cfset off_set = 0 >
									</cfif> --->
									<cfif #Get_Assigned_OEMs.website_target# EQ "" OR #Get_Assigned_OEMs.website_target# EQ "0"><cfset where = ""><cfelse><cfset where = "_blank"></cfif>
									<div class="col-md-#nbr_col# col-md-offset-#off_set# pad-top-10" style="align:center">
										 <cfif  #len(Get_Assigned_OEMs.Logo)# gt 0 >
										 	<a href="#Get_Assigned_OEMs.website_link#" target="#where#" ><img src="http://dealers.wdautos.com//images/brand_logos/#Get_Assigned_OEMs.Logo#" alt="#Get_Assigned_OEMs.oem_name#" border="0" class="img-responsive" ></a>
										 <cfelse>
										 	#Get_Assigned_OEMs.OEM_Name#
										 </cfif> 
									</div>
										<cfset whats_left = #whats_left# - 1>
								</cfloop>
							</div>
						</div>
					</div>
				</div>	
				<div class="clearfix"></div>
			</section>
		</cfif>



</cfoutput>