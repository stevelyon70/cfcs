<cfoutput>
	
				<cfquery datasource="Ultra10" name="Get_Service_Locations">
					SELECT		Dealer_Locations.Dealer_Location_ID,
								Dealer_Locations.Location_ID,
								Dealers.Display_Name,
								Dealers.City,
								Dealers.Zip,
								Dealers.dealer_id,
								Dealers.Link_Service,
								Dealer_Locations.Hierarchy
					FROM		Dealer_Locations
					INNER JOIN	Dealers
					ON			Dealer_Locations.Location_ID = Dealers.Dealer_ID
					WHERE		Dealer_Locations.Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
					ORDER BY 	Dealers.Display_Name
				</cfquery>

<!--- CTA UPPER --->

		<cfquery name="Get_Block2" datasource="Ultra10" maxrows="4" >
			SELECT	ID, dealer_id, Title, image, image_position, free_text, button_text, button_link, target, Make, page_type, active, create_ts, hierarchy, soc_media_link_one, 
	                soc_media_link_two, soc_media_link_three, title_font_family, title_font_size, title_font_color, title_font_weight, title_font_decoration, button_background, 
	                button_border, button_border_color, button_font_color, button_font_family, button_font_size, button_font_weight, button_decoration, button_hover_background, 
	                button_hover_border, button_hover_border_color, button_hover_font_color, button_hover_font_family, button_hover_font_size, button_hover_font_weight, 
	                button_hover_decoration, background_color, free_text_font_family, free_text_font_size, free_text_font_color, free_text_font_weight, free_text_font_decoration
			FROM    Nav_Block_2
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		<cfif #Get_Block2.recordcount# NEQ 0 >
			<cfset a_title = ArrayNew(1)>
			<cfset a_image = ArrayNew(1)>
			<cfset a_free_text = ArrayNew(1)>
			
			<cfset a_title_font_family = ArrayNew(1)>
			<cfset a_title_font_size = ArrayNew(1)>
			<cfset a_title_font_color = ArrayNew(1)>
			<cfset a_title_font_weight = ArrayNew(1)>
			<cfset a_title_font_decoration = ArrayNew(1)>
			
			<cfset a_free_text_font_family = ArrayNew(1)>
			<cfset a_free_text_font_size = ArrayNew(1)>
			<cfset a_free_text_font_color = ArrayNew(1)>
			<cfset a_free_text_font_weight = ArrayNew(1)>
			<cfset a_free_text_font_decoration = ArrayNew(1)>
			
			<cfset a_button_text = ArrayNew(1)>
			<cfset a_button_link = ArrayNew(1)>
			<cfset a_button_target = ArrayNew(1)>
			
			<cfset a_background_color = ArrayNew(1)>
			
			<cfset a_button_background = ArrayNew(1)>
			<cfset a_button_border = ArrayNew(1)>
			<cfset a_button_border_color = ArrayNew(1)>
			<cfset a_button_font_color = ArrayNew(1)>
			<cfset a_button_font_family = ArrayNew(1)>
			<cfset a_button_font_size = ArrayNew(1)>
			<cfset a_button_font_weight = ArrayNew(1)>
			<cfset a_button_decoration = ArrayNew(1)>
			
			<cfset a_button_hover_background = ArrayNew(1)>
			<cfset a_button_hover_border = ArrayNew(1)>
			<cfset a_button_hover_border_color = ArrayNew(1)>
			<cfset a_button_hover_font_color = ArrayNew(1)>
			<cfset a_button_hover_font_family = ArrayNew(1)>
			<cfset a_button_hover_font_size = ArrayNew(1)>
			<cfset a_button_hover_font_weight = ArrayNew(1)>
			<cfset a_button_hover_decoration = ArrayNew(1)>
			
	  		<cfset maxblk = #Get_Block2.recordcount# >
			<cfset y = 0>
			<cfloop query="Get_Block2">
				<cfset y = #y#+1>
				<cfset a_Title[y] = #Get_Block2.Title# >
				<cfset a_image[y] = #Get_Block2.image#>
				<cfset a_free_text[y] = #Get_Block2.free_text#>
				
				<cfset a_title_font_family[y] = #Get_Block2.title_font_family#>
				<cfset a_title_font_size[y] = #Get_Block2.title_font_size#>
				<cfset a_title_font_color[y] = #Get_Block2.title_font_color#>
				<cfset a_title_font_weight[y] = #Get_Block2.title_font_weight#>
				
				<cfset a_free_text_font_family[y] = #Get_Block2.free_text_font_family#>
				<cfset a_free_text_font_size[y] = #Get_Block2.free_text_font_size#>
				<cfset a_free_text_font_color[y] = #Get_Block2.free_text_font_color#>
				<cfset a_free_text_font_weight[y] = #Get_Block2.free_text_font_weight#>
				
				<cfset a_button_text[y] = #Get_Block2.button_text#>
				<cfset a_button_link[y] = #Get_Block2.button_link#>
				<cfset a_background_color[y] = #Get_Block2.background_color#>
				
				<cfset a_button_background[y] = #Get_Block2.button_background#>
				<cfset a_button_border[y] = #Get_Block2.button_border#>
				<cfset a_button_border_color[y] = #Get_Block2.button_border_color#>
				<cfset a_button_font_color[y] = #Get_Block2.button_font_color#>
				<cfset a_button_font_family[y] = #Get_Block2.button_font_family#>
				<cfset a_button_font_size[y] = #Get_Block2.button_font_size#>
				<cfset a_button_font_weight[y] = #Get_Block2.button_font_weight#>
				
				<cfset a_button_hover_background[y] = #Get_Block2.button_hover_background#>
				<cfset a_button_hover_border[y] = #Get_Block2.button_hover_border#>
				<cfset a_button_hover_border_color[y] = #Get_Block2.button_hover_border_color#>
				<cfset a_button_hover_font_color[y] = #Get_Block2.button_hover_font_color#>
				<cfset a_button_hover_font_family[y] = #Get_Block2.button_hover_font_family#>
				<cfset a_button_hover_font_size[y] = #Get_Block2.button_hover_font_size#>
				<cfset a_button_hover_font_weight[y] = #Get_Block2.button_hover_font_weight#>
				
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
<div class="container-fluid" >
			<section class="section-cta-upper no-pad">
				<!--- <div class="container pad-top-5 "> --->
				<!--- <div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="page-divider"></div></div></div>	 --->
				 	<!--- <cfif #gt_CTA_U.recordcount# GT 0 >
						<div class="row"><div class="col-md-12 no-pad brands-title visible-sm visible-xs visible-lg visible-md" style="align:#ln_1_align#">
							<span style="#ln_1_style#">#gt_CTA_U.CTA_Title_1#</span>
							<cfif #gt_CTA_U.CTA_Title_2# NEQ "">
								<br><span style="#ln_2_style#">#gt_CTA_U.CTA_Title_2#</span>
							</cfif>	
						</div>	
					</cfif> --->
					<div class="row no-pad" style="min-height:400px">
					

					
<!--- column start --->		
				 		
						
<style>
	.quarter_1 { background-color: <cfoutput>###a_background_color[1]#!important</cfoutput>; }
	
	.cta-upper-title-q1{ 	font-family:<cfoutput>#a_title_font_family[1]#!important</cfoutput>; font-size:<cfoutput>#a_title_font_size[1]#!important</cfoutput>; 
							font-weight:<cfoutput>#a_title_font_weight[1]#!important</cfoutput>; color:<cfoutput>###a_title_font_color[1]#!important</cfoutput>;}
							
	.cta-upper-pgtxt-q1{ 	font-family:<cfoutput>#a_free_text_font_family[1]#!important</cfoutput>; font-size:<cfoutput>#a_free_text_font_size[1]#!important</cfoutput>; 
							font-weight:<cfoutput>#a_free_text_font_weight[1]#!important</cfoutput>; color:<cfoutput>###a_free_text_font_color[1]#!important</cfoutput>; }
							
	.cta-upper-go-btn-q1{	font-family:<cfoutput>#a_button_font_family[1]#!important</cfoutput>; background-color: <cfoutput>###a_button_background[1]#!important</cfoutput>; 
							border:<cfoutput>#a_button_border[1]#!important ###a_button_border_color[1]#!important</cfoutput>; 
							color: <cfoutput>###a_button_font_color[1]#!important</cfoutput>; font-family:<cfoutput>#a_button_font_family[1]#!important</cfoutput>;
						 	font-size:<cfoutput>#a_button_font_size[1]#!important</cfoutput>; font-weight:<cfoutput>#a_button_font_weight[1]#!important</cfoutput>; }
							
	.cta-upper-go-btn-q1:hover{ font-family:<cfoutput>#a_button_font_family[1]#!important</cfoutput>; background-color: <cfoutput>###a_button_hover_background[1]#!important</cfoutput>; 
								color: <cfoutput>###a_button_hover_font_color[1]#!important</cfoutput>; }

</style>
					<cfset x = 1>
							  <div class="col-md-3 pad-top-5 quarter_#x# " align="center">
								<!--- <div class="row  " style="min-height:50px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div> --->
								 <div class="row pad-top-10 cta-upper-title-q#x#" >#a_Title[x]#</div>
								<cfif #a_free_text[x]# NEQ "" >
									<div class="row pad-top-10 pad-10 cta-upper-pgtxt-q#x#" >#a_free_text[x]#</div>
									<div class="row pad-top-10 cta-upper-pgtxt" style="min-height:15px;align:center"></div>
								</cfif>  
								
								<cfif #x# EQ 1 >
								
									  <div class="row  cta-upper-pgtxt-q#x#" >
									<!--- <iframe width="100%" height="350px" src="https://wl.tireconnect.ca/tireconnect/index?dealer_id=3332&sa" frameborder="0" zindex="50" allowfullscreen></iframe> --->
									 <a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn-q#x#">&nbsp;&nbsp;#a_button_text[x]#</a>
									</div>		  	
									
								</cfif>
								<div class="row pad-top-10" style="min-height:10px;align:center"></div>
							</div>
<!--- column stop --->						
						


<!--- column start --->					
						 
						
						
<style>
	.quarter_2 { background-color: ###a_background_color[2]#!important; }
	
	.cta-upper-title-q2{ 	font-family:#a_title_font_family[2]#!important; font-size:#a_title_font_size[2]#!important; 
							font-weight:#a_title_font_weight[2]#!important; color:###a_title_font_color[2]#!important;}
	
	.cta-upper-pgtxt-q2{ 	font-family:#a_free_text_font_family[2]#!important; font-size:#a_free_text_font_size[2]#!important; 
							font-weight:#a_free_text_font_weight[2]#!important; color:###a_free_text_font_color[2]#!important; }
	
	.cta-upper-go-btn-q2{	font-family:#a_button_font_family[2]#!important; background-color: ###a_button_background[2]#!important; 
							border:#a_button_border[2]#!important ###a_button_border_color[2]#!important; 
						 	color: ###a_button_font_color[2]#!important; font-family:#a_button_font_family[2]#!important;
						 	font-size:#a_button_font_size[2]#!important; font-weight:#a_button_font_weight[2]#!important; }
	
	.cta-upper-go-btn-q2:hover{ font-family:#a_button_font_family[2]#!important; background-color: ###a_button_hover_background[2]#!important; 
								color: ###a_button_hover_font_color[2]#!important; }

</style>
							<cfset x = 2 >
							<div class="col-md-3 pad-top-5 quarter_#x# " align="center">
								<!--- <div class="row  " style="min-height:50px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div> --->
								<div class="row pad-top-10 cta-upper-title-q#x#" >#a_Title[x]#</div>
								<cfif #a_free_text[x]# NEQ "" >
									<div class="row pad-top-10 pad-10 cta-upper-pgtxt-q#x#" >#a_free_text[x]#</div>
									<div class="row pad-top-10 cta-upper-pgtxt" style="min-height:15px;align:center"></div>
								</cfif>
								<cfif #x# EQ 2  >
									<div class="row pad-top-10" style="align:center">
										<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn-q#x#">&nbsp;&nbsp;#a_button_text[x]#</a>
									</div> 
								</cfif>
								<div class="row pad-top-10" style="min-height:10px;align:center"></div>
							</div>
					 
<!--- column stop --->						
					
<!--- column start --->					
						
						
<style>

	.quarter_3 { background-color: ###a_background_color[3]#; }
	.cta-upper-title-q3{ font-family:#a_title_font_family[3]#; font-size:#a_title_font_size[3]#; font-weight:#a_title_font_weight[3]#; color:###a_title_font_color[3]#!important;}
	.cta-upper-pgtxt-q3{ font-family:#a_free_text_font_family[3]#; font-size:#a_free_text_font_size[3]#; font-weight:#a_free_text_font_weight[3]#; color:###a_free_text_font_color[3]#!important; }
	.cta-upper-go-btn-q3{font-family:#a_button_font_family[3]#!important; background-color: ###a_button_background[3]#!important; border:#a_button_border[3]# ###a_button_border_color[3]#; border-color: ###a_button_border_color[3]#!important; 
						 color: ###a_button_font_color[3]#!important; font-family:#a_button_font_family[3]#!important;
						 font-size:#a_button_font_size[3]#!important; font-weight:#a_button_font_weight[3]#!important; }
	.cta-upper-go-btn-q3:hover{ font-family:#a_button_font_family[3]#; background-color: ###a_button_hover_background[3]#!important; color: ###a_button_hover_font_color[3]#!important; }
</style>
						<cfset x = 3 >
							<div class="col-md-3 pad-top-5 quarter_#x# " align="center">
								<!--- <div class="row  " style="min-height:50px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div> --->
								<div class="row pad-top-10 cta-upper-title-q#x#" >#a_Title[x]#</div>
								<cfif #a_free_text[x]# NEQ "" >
									<div class="row pad-top-10 pad-10 cta-upper-pgtxt-q#x#" >#a_free_text[x]#</div>
									<div class="row pad-top-10 cta-upper-pgtxt-q#x#" style="min-height:15px;align:center"></div>
								</cfif>
								<cfif #x# EQ 3 or #x# EQ 4 >
									<div class="row pad-top-10 visible-md visible-lg" style="align:center">
										<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn-q#x#">&nbsp;&nbsp;#a_button_text[x]#</a>
									</div>
									<div class="row pad-top-10 visible-sm visible-xs" style="align:center">
										<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn-q#x#"><span style="font-size:10pt">FIND A BAIERL SERVICE CENTER</span></a>
									</div>
									<cfif #x# EQ 4 >
										<div class="row " ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/tires.png" border="0"></div>									
									</cfif>
								</cfif>
								
								<div class="row pad-top-10" style="min-height:10px;align:center"></div>
							</div>
<!--- column stop --->				
<!--- column start --->					
						
						
<style>

	.quarter_4 { background-color: ###a_background_color[4]#; }
	.cta-upper-title-q4{ font-family:#a_title_font_family[4]#; font-size:#a_title_font_size[4]#; font-weight:#a_title_font_weight[4]#; color:###a_title_font_color[4]#!important;}
	.cta-upper-pgtxt-q4{ font-family:#a_free_text_font_family[4]#; font-size:#a_free_text_font_size[4]#; font-weight:#a_free_text_font_weight[4]#; color:###a_free_text_font_color[4]#!important; }
	.cta-upper-go-btn-q4{font-family:#a_button_font_family[4]#; background-color: ###a_button_background[4]#; border:#a_button_border[4]# ###a_button_border_color[4]#; border-color: ###a_button_border_color[4]#; 
						 color: ###a_button_font_color[4]#; font-family:#a_button_font_family[4]#;
						 font-size:#a_button_font_size[4]#; font-weight:#a_button_font_weight[4]#; }
	.cta-upper-go-btn-q4:hover{ font-family:#a_button_font_family[4]#; background-color: ###a_button_hover_background[4]#; color: ###a_button_hover_font_color[4]#!important; }
</style>
						<cfset x = 4 >
							<div class="col-md-3 pad-top-5 quarter_#x# " align="center">
								<!--- <div class="row  " style="min-height:50px;align:center"><a href="#a_button_link[x]#" target="#a_button_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" border="0"></a></div> --->
								<div class="row pad-top-10 cta-upper-title-q#x#" >#a_Title[x]#</div>
								<cfif #a_free_text[x]# NEQ "" >
									<div class="row pad-top-10 pad-10 cta-upper-pgtxt-q#x#" >#a_free_text[x]#</div>
									<div class="row pad-top-10 cta-upper-pgtxt-q#x#" style="min-height:29px;align:center"></div>
								</cfif>
								<cfif #x# EQ 2 or #x# EQ 4 >
									<div class="row pad-top-10" style="align:center">
										<a href="#a_button_link[x]#" target="#a_button_target[x]#" class="cta-upper-go-btn-q#x#">&nbsp;&nbsp;#a_button_text[x]#</a>
									</div>
									<cfif #x# EQ 4 >
										<div class="row quarter_4_img" ><img class="img-responsive " src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/tires.png" border="0"></div>									
									</cfif>
								</cfif>
								
								<div class="row pad-top-10" style="min-height:10px;align:center"></div>
							</div>
<!--- column stop --->						
						
					</div>
				</div>	
				<div class="clearfix"></div>
			</section>
</div>						
		</cfif>

</cfoutput>



