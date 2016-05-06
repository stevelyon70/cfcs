<cfoutput>

		<cfquery name="gt_search" datasource="Ultra10">
			SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
					CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
			FROM    Dealer_CTA_Titles
			where dealer_id = #url.dealer_id#
			AND		active = 1
			AND CTA = 8
			order by hierarchy asc
		</cfquery>

		<section class="container-mailing-list">
			<div class="container pad-top-10 visible-md visible-lg visible-sm visible-xs">
				<div class="row">
					<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" style="align:center;border:1px solid white">  
							<cfif #gt_search.recordcount# NEQ 0 >
								<cfloop query="gt_search">
									<cfset ln_1_style="font-family:#gt_search.ft_family#;font-size:#gt_search.ft_size#;color:###gt_search.ft_color#;font-weight:#gt_search.ft_weight#">
									<cfset ln_1_align="#gt_search.txt_align#">
									<cfset ln_2_style="font-family:#gt_search.ft_family_2#;font-size:#gt_search.ft_size_2#;color:###gt_search.ft_color_2#;font-weight:#gt_search.ft_weight_2#">
									<cfset ln_2_align="#gt_search.txt_align_2#">
									<div class="col-md-12 srch-tabs-block  visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
									<cfif #len(gt_search.CTA_image)# GT 0 >
										<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image#"   class="img-responsive" >
									<cfelse>
										<span  class="srch-tabs-title" style="#ln_1_style#">#gt_search.CTA_Title_1#</span>
									</cfif>
									 <cfif #gt_search.CTA_Title_2# NEQ "" or #len(gt_search.CTA_image_2)# GT 0 >
										<br>
										<cfif #len(gt_search.CTA_image_2)# GT 0 >
											<img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#gt_search.CTA_image_2#" class="img-responsive" >
										<cfelse>
											<span  class="srch-tabs-title" style="#ln_2_style#;align:#ln_2_align#">#gt_search.CTA_Title_2#</span>
										</cfif>
									</cfif>	 
									</div>	
								</cfloop>
							<cfelse>
								 &nbsp;
							</cfif> 
					</div>		
					</div>		
				<div class="row">
					<div class="col-md-12  pad-top-10" style="align:center">
						<cfinvoke component="/cfcs/forms/form_contact" method="mailing_list">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/maillist_action.cfm"/>
						</cfinvoke> 
					</div>
				</div>
			</div>  	
				<div class="row">&nbsp;</div>
		</section>
		
</cfoutput>		
