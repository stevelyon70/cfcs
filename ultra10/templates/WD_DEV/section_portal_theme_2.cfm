<!--- section_portal_theme_2.cfm

	Defines the Dealership Links section of a portal site. 
		Generates Dealership Links, LEFT SIDE of screen, for as many Dealerships as required.
				
 --->

 
 <cfoutput>
		<cfquery name="Get_Block2" datasource="Ultra10"  >
			SELECT  ID, dealer_id, Title, page_type, image, free_text, button_text, button_link, target, 
					active, create_ts, hierarchy, soc_media_link_one, soc_media_link_two, soc_media_link_three
			FROM    Nav_Block_Special
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		
		<cfif #Get_Block2.recordcount# NEQ 0 >
	  		<cfset maxblk = #Get_Block2.recordcount# >
			<cfset y = 0>
			
			<div class="container-fluid ">
				<div class="container  pad-top-05  visible-sm visible-xs  visible-lg visible-md"> 
					<div class="row">	  
						<div class="col-md-12  visible-sm visible-xs visible-lg visible-md"   >
							<div class="row row-centered visible-sm visible-xs visible-lg visible-md ">	  
								<cfloop query="Get_Block2">
										<cfset a_button_target ="">
										<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target = "_blank"></cfif>
					 					<div class="col-md-6 portal-container-2 visible-sm visible-xs visible-lg visible-md" >
											<div class="col-centered" >
												<a href="#Get_Block2.button_link#" target="#a_button_target#" ><img src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Block2.image#" class="img-responsive"  border="0"></a>
											</div>
											<div class="portal-upper-title pad-top-05" >
												#Get_Block2.Title#
											</div>
											<cfif #Get_Block2.free_text# NEQ "" >
												<div class="portal-upper-pgtxt visible-sm visible-xs visible-lg visible-md" style="min-height:150px; " >
													#Get_Block2.free_text#
												</div>
											</cfif>
											<cfif #Get_Block2.button_text# NEQ "" >
												<div class="portal-upper-pgtxt pad-top-10  col-centered visible-sm visible-xs visible-lg visible-md"   >
													<a href="#Get_Block2.button_link#" target="#a_button_target#" class="portal-upper-go-btn" >#Get_Block2.button_text#</a>
												</div>
											</cfif>
										 </div> 
									</cfloop>	
								</div>	
							</div>	
						</div>  
					</div>	 
				</div>
		</cfif>


</cfoutput>
