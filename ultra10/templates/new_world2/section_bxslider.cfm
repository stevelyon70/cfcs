<cfoutput>
<div class="container-fluid">
		<section class="section-bxslider">
			<div class="container pad-top-10 visible-md visible-lg ">
					<cfquery name="gt_features" datasource="Ultra10">
						SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
								CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
						FROM    Dealer_CTA_Titles
						where dealer_id = #url.dealer_id#
						AND		active = 1
						AND CTA = 4
					</cfquery>
					<cfset ln_1_style="font-size:#gt_features.ft_size#;color:###gt_features.ft_color#;font-weight:#gt_features.ft_weight#">
					<cfset ln_1_align="#gt_features.txt_align#">
					<cfset ln_2_style="font-size:#gt_features.ft_size_2#;color:###gt_features.ft_color_2#;font-weight:#gt_features.ft_weight_2#">
					<cfset ln_2_align="#gt_features.txt_align_2#">
				<div class="row-centered visible-lg visible-md">
					<div class="col-centered pad-10">
						<cfif #gt_features.recordcount# >
							<div class="row">
								<div class="col-md-12 visible-lg visible-md">
									<p align="center"><span  style="#ln_1_style#">#gt_features.CTA_Title_1# </span>
									<cfif #gt_features.CTA_Title_2# NEQ "">
										<br><span style="#ln_2_style#">#gt_features.CTA_Title_2# </span>
									</cfif>
								</div>
							</div>	
						<cfelse>	
							<cfif #variables.bx_type# EQ "U"><cfset dsp_new_used = "USED"><cfelse><cfset dsp_new_used = "NEW"></cfif>
							<div title="#arguments.dealer_name# THIS WEEK'S USED CAR DEALS"><span class="spl-search-name">THIS WEEK'S #dsp_new_used# CAR DEALS </span></div>
						</cfif>
						<div class="row"><div class="col-md-12  visible-lg visible-md"><div class="gradient"></div></div></div>	
					<div class="row-centered"><div class="col-centered pad-top 5px  visible-lg visible-md"><div class="page-div"></div>		
					</div>
						<div id="#arguments.assets#-spl-carousel" class="pad-top-10">                    
                        <!-- #now# bxslider from section bxslider -->
							<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="#variables.bx_type#"/>
								<cfinvokeargument name="minSlides" value="4"/>	
								<cfinvokeargument name="maxSlides" value="4"/>
								<cfinvokeargument name="slideWidth" value="300"/>
								<cfinvokeargument name="slideMargin" value="10"/>
								<cfinvokeargument name="carousel_class" value="fv-carousel"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</div>

			</div>  
		</section>
</div>	

</cfoutput>
