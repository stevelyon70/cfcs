<cfoutput>


<cfquery name="gt_title" datasource="Ultra10">
	SELECT	CTA_Title_1,CTA_image, ft_family,ft_size, ft_color, ft_weight, txt_align, 
			CTA_Title_2,CTA_Image_2, ft_family_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
	FROM    Dealer_CTA_Titles
	where dealer_id = #url.dealer_id#
	AND		active = 1
	AND CTA = 5
</cfquery>
<cfset ln_1_style="font-size:#gt_title.ft_size#;color:###gt_title.ft_color#;font-weight:#gt_title.ft_weight#">
<cfset ln_1_align="#gt_title.txt_align#">
<cfset ln_2_style="font-size:#gt_title.ft_size_2#;color:###gt_title.ft_color_2#;font-weight:#gt_title.ft_weight_2#">
<cfset ln_2_align="#gt_title.txt_align_2#">

	<cfif #sub_sec_helpful_2_active# EQ 0 >
		<cfset variables.bx_type 	= "U" >
	<cfelse>
		<cfset variables.bx_type 	= "N" >
	</cfif>

	<cfquery name="gt_features" datasource="Ultra10">
		SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
				CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
		FROM    Dealer_CTA_Titles
		where dealer_id = #url.dealer_id#
		AND		active = 1
		AND CTA = 4
	</cfquery>
	<cfset bln_1_style="font-size:#gt_features.ft_size#;color:###gt_features.ft_color#;font-weight:#gt_features.ft_weight#">
	<cfset bln_1_align="#gt_features.txt_align#">
	<cfset bln_2_style="font-size:#gt_features.ft_size_2#;color:###gt_features.ft_color_2#;font-weight:#gt_features.ft_weight_2#">
	<cfset bln_2_align="#gt_features.txt_align_2#">	
	
<section class="section-helpful pad-top-10 ">
	<div class="container">
		<div class="row visible-lg visible-md">
		
		<cfif #sub_sec_helpful_1_active# EQ 1 >
		<!--- Sub 2 ---> 
			<div class="col-md-8 pad-10">
				<cfif #gt_features.recordcount# >
					<div class="row"><div class="col-md-12  visible-lg visible-md">
						<p style="align:#bln_1_align#"><span  style="#bln_1_style#">#gt_features.CTA_Title_1#</span>
						<cfif #gt_features.CTA_Title_2# NEQ "">
						<br><span style="#bln_2_style#">#gt_features.CTA_Title_2#</span>
					</cfif>
					</div></div>	
				<cfelse>	
					<cfif #variables.bx_type# EQ "U"><cfset dsp_new_used = "USED"><cfelse><cfset dsp_new_used = "NEW"></cfif>
					<div title="#arguments.dealer_name# THIS WEEK'S USED CAR DEALS"><span class="spl-search-name">THIS WEEK'S #dsp_new_used# CAR DEALS </span></div>
				</cfif>
				<!--- <div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	 --->
				<div class="row"><div class="col-md-12 pad-top 5px  visible-lg visible-md"><div class="page-div"></div>		
				<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
						<cfinvokeargument name="dsn" value="ultra10"/>
						<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="new_used" value="#variables.bx_type#"/>
						<cfinvokeargument name="minSlides" value="3"/>	
						<cfinvokeargument name="maxSlides" value="12"/>
						<cfinvokeargument name="slideWidth" value="300"/>
						<cfinvokeargument name="slideMargin" value="15"/>
						<cfinvokeargument name="carousel_class" value="fv-carousel"/>
					</cfinvoke>
				</div>
			</div>
		</cfif>	
		<!--- End Sub 2 ---> 
		
		
			<!--- Sub 1  --->
			<div class="col-md-4 pad-10 pad-top-10">
				<div   class="pad-top-10 container-quik-links">
				<cfif #gt_title.recordcount# gt 0 >
					<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
						<p style="align:#ln_1_align#"><span  style="#ln_1_style#">#gt_title.CTA_Title_1#</span>
						<cfif #gt_title.CTA_Title_2# NEQ "">
						<br><span style="#ln_2_style#">#gt_title.CTA_Title_2#</span>
					</cfif>
					</div></div>	
				<cfelse>	
					<div title="#arguments.dealer_name# Helpful Links"><span class="spl-search-name">Helpful Links</span></div>
				</cfif>
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="nav_type_id" value="57"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="element_class" value="srch-links-helpful-btn"/>
						<cfinvokeargument name="glyph_right" value="true"/>
					</cfinvoke>
				</div>
			</div>	
		<!--- End Sub 1 ---> 
		
		
		
		
		<cfif #sub_sec_helpful_1_active# EQ 2 >
		<!--- Sub 2 ---> 
			<div class="col-md-8 pad-10">
				<cfif #gt_features.recordcount# >
					<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
						<p style="align:#bln_1_align#"><span  style="#bln_1_style#">#gt_features.CTA_Title_1#</span>
						<cfif #gt_features.CTA_Title_2# NEQ "">
							<br><span style="#bln_2_style#">#gt_features.CTA_Title_2#</span>
						</cfif>
					</div></div>	
				<cfelse>	
					<cfif #variables.bx_type# EQ "U"><cfset dsp_new_used = "USED"><cfelse><cfset dsp_new_used = "NEW"></cfif>
					<div title="#arguments.dealer_name# THIS WEEK'S USED CAR DEALS"><span class="spl-search-name">THIS WEEK'S #dsp_new_used# CAR DEALS </span></div>
				</cfif>
				<!--- <div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	 --->
				<div class="row"><div class="col-md-12 pad-top 5px  visible-lg visible-md"><div class="page-div"></div>		
				<div id="#arguments.assets#-spl-carousel" class="pad-top-10">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="v_rand">
						<cfinvokeargument name="dsn" value="ultra10"/>
						<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="new_used" value="#variables.bx_type#"/>
						<cfinvokeargument name="minSlides" value="3"/>	
						<cfinvokeargument name="maxSlides" value="12"/>
						<cfinvokeargument name="slideWidth" value="300"/>
						<cfinvokeargument name="slideMargin" value="15"/>
						<cfinvokeargument name="carousel_class" value="fv-carousel"/>
					</cfinvoke>
				</div>
			</div>
		</cfif>	
		<!--- End Sub 2 ---> 
		
	</div>
</div>	
</section>
  



</cfoutput>

