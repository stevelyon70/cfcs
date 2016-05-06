<cfoutput>
	 
		<cfquery name="Get_Social" datasource="Ultra10"  >
			SELECT  	ID, dealer_id, page_text, image_name, link_destination, link_target, hierarchy, active, start_dt, expires_dt, create_dt
			FROM    	Dealer_Social_Page
			where 	dealer_id = #url.dealer_id#
			and 	active = 1
			order by hierarchy ASC
		</cfquery>
		<cfif #Get_Social.recordcount# NEQ 0 >
				<div class="container-fluid">
						<section class="section-social ">
							<div class="row" >
								<div class="col-md-6 visible-sm visible-xs visible-lg visible-md">
									<ul>
										<cfloop query="Get_Social">
											<cfif #Get_Social.hierarchy# EQ 1 >
												<cfset address_line = #Get_Social.page_text# >
											</cfif>
											<li style="display: inline-block;" >
													<a href="#Get_Social.link_destination#" target="#Get_Social.link_target#"  >
													<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Social.image_name#" border="0"></a>
											</li>	  
										</cfloop>	
									</ul>
								</div>
								<div class="col-md-6 visible-sm visible-xs visible-lg visible-md" align="right">
									#address_line#
								</div>
							</div>
						</section>
				</div>			
		</cfif>


</cfoutput>