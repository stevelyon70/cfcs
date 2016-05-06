<cfoutput>

		<cfquery name="gt_search" datasource="Ultra10">
			SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
					CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
			FROM    Dealer_CTA_Titles
			where dealer_id = #url.dealer_id#
			AND		active = 1
			AND CTA = 7
			order by hierarchy asc
		</cfquery>
 
	
	<section class="section-horizontal-srch">
		<div class="container-fluid pad-top-10 ">
		
		
		
			<div class="row row-centered   visible-xs visible-sm visible-lg visible-md">   <!--- r1 --->
		
		
				<div class="col-md-12  pad-top-10   visible-xs visible-sm visible-lg visible-md" >  <!--- c1 --->
					<div class="row row-centered" >
					<cfif #gt_search.recordcount# NEQ 0 >
						<cfset cols = 10 >
						<div class="col-md-2 " style="margin-bottom:10px; "  align="center">		<!--- removed offset-1 01/20 --->
							<cfif #gt_search.recordcount# NEQ 0 >
								<cfloop query="gt_search">
									<cfset ln_1_style="font-family:#gt_search.ft_family#;font-size:#gt_search.ft_size#;color:###gt_search.ft_color#;font-weight:#gt_search.ft_weight#">
									<cfset ln_1_align="#gt_search.txt_align#">
									<cfset ln_2_style="font-family:#gt_search.ft_family_2#;font-size:#gt_search.ft_size_2#;color:###gt_search.ft_color_2#;font-weight:#gt_search.ft_weight_2#">
									<cfset ln_2_align="#gt_search.txt_align_2#">
									<div class="col-md-12   visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
									<cfif #len(gt_search.CTA_image)# GT 0 >
										<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image#"   class="img-responsive" >
									<cfelse>
										<span  class="horizontal-titles" style="#ln_1_style#">#gt_search.CTA_Title_1#</span>
									</cfif>
									 <cfif #gt_search.CTA_Title_2# NEQ "" or #len(gt_search.CTA_image_2)# GT 0 >
										<br>
										<cfif #len(gt_search.CTA_image_2)# GT 0 >
											<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image_2#" class="img-responsive" >
										<cfelse>
											<span  class="horizontal-titles" style="#ln_2_style#" style="align:#ln_2_align#">#gt_search.CTA_Title_2#</span>
										</cfif>
									</cfif>	 
									</div>	
								</cfloop>
							<cfelse>
								 &nbsp;
							</cfif> 
						</div>
					<cfelse>	
						<cfset cols = 10 >
					</cfif>	
					<div class="col-md-#cols# col-md-offset-2" align="center">
						<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_search_huge">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="btn_pull" value="pull-right"/>
						</cfinvoke>	
					</div> <!--- end search columns --->
						
					</div>  <!--- end row --->
				</div>  <!--- c1 --->
				
				
				
				
			</div>   <!--- r1 --->
			
			
			
			
		</div>     <!--- container fluid --->
		
	</section>
		
</cfoutput>		

