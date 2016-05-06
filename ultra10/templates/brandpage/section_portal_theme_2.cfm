<!--- section_portal_theme_2.cfm

	Defines the Dealership Links section of a portal site. 
		Generates Dealership Links, LEFT SIDE of screen, for as many Dealerships as required.
				
 --->

 
 
 <cfset bg_img = "http://dealers.wdautos.com/dealer/tobesurenissan/images/icons/bg_main.jpg" >  
<!---   <cfset bg_img = "" >   --->
<cfset contained = 0 >
<cfset bordered = "" >
<!--- <cfset bordered = "border:1px solid ##cc0000;" > --->
<cfset body_width = "width:900px;" >
<cfset backgrd_color = "background-color:transparent!important;" >

<cfoutput>

<style type="text/css">
body{
	#backgrd_color#
	color:black;
	font-family:verdana!important;
}
.body-style{
	<cfif #contained# eq 1 >
		#body_width#
	</cfif>
	<cfif #bordered# Neq "" >
		#bordered#
		border-radius: 7px!important;
		-moz-border-radius: 7px!important;
		-webkit-border-radius: 7px!important;
	</cfif>
	<cfif #bg_img# NEQ "" >
		background-image: url('#bg_img#');
		background-repeat: repeat-y;
	</cfif>
    #backgrd_color#
	margin-right:auto;
	margin-left:auto;
}
.container{
	<cfif #bordered# Neq "" >
		#bordered#
		border-radius: 10px!important;
		-moz-border-radius: 10px!important;
		-webkit-border-radius: 10px!important;
	</cfif> 
	max-width:1048px;  
}
</style>

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
			<section class="section-portal-2">
			
				<div class="container-fluid pad-top-05  visible-sm visible-xs  visible-lg visible-md">
				
					<div class="row">	  
					
						 <div class="col-md-2 pad-top-05   visible-lg visible-md" style="align:center"> &nbsp;</div>
							 
							<cfloop query="Get_Block2">
								<cfset a_button_target ="">
								<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target = "_blank"></cfif>
			 					<div class="col-md-6   portal-container-2  visible-sm visible-xs visible-lg visible-md" style="align:center"  >
									<div class="visible-sm visible-xs visible-lg visible-md pad-top-10 portal-upper-title">  
										<a href="#Get_Block2.button_link#" target="#a_button_target#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Block2.image#" border="0"></a>
										<div class="portal-upper-title pad-top-05" style="align:center" > #Get_Block2.Title# </div>
											<cfif #Get_Block2.free_text# NEQ "" >
												<div class="portal-upper-pgtxt" style="min-height:50px;align:center" >#Get_Block2.free_text#</div>
												<div class="portal-upper-pgtxt" style="min-height:15px;align:center">&nbsp;</div>
											</cfif>
											<cfif #Get_Block2.button_text# NEQ "" >
												<div class="portal-upper-pgtxt no-pad visible-sm visible-xs visible-lg visible-md" >
													<a href="#Get_Block2.button_link#" target="#a_button_target#" class="portal-upper-go-btn" >#Get_Block2.button_text#</a>
												</div>
											</cfif>
										</div>
								  </div>  
								   <div class="col-md-1 pad-top-10   visible-lg visible-md" style="align:center"> &nbsp;</div>
								
							</cfloop>	
						<!--- </div>   --->
						
						
					</div>  
<div class="row">&nbsp;</div>
				<div class="clearfix"></div>
				</div>	
			</section>
		</cfif>


</cfoutput>
