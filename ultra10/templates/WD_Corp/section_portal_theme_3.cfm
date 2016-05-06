<!--- section_portal_theme_3.cfm
		NEEDS SETUP SO BACKGROUND IMAG CAN BE DATABASE FEED. 02-09-2016		 
				
 --->
 
 
<style type="text/css">
 
.container{
	margin-left:auto!important;
	margin-right:auto!important;
	max-width:100%!important;
	max-height:1048px!important;  
	background: url('http://dealers.wdautos.com/dealer/fuccillohugecreditapp/images/icons/BG_HugeCreditApp.jpg') repeat-x center top; 
				-webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;background-size: cover; 
}
.container-mbl{
	margin-left:45px!important;
	margin-right:auto!important;
	max-width:100%!important;
	max-height:auto!important;  
	align:center!important;  
}

</style>
	

<cfoutput>
	<cfquery name="Get_Block2" datasource="Ultra10"  >
		SELECT  ID, dealer_id, Title, page_type, image, free_text, button_text, button_link, target, 
				active, create_ts, hierarchy, soc_media_link_one, soc_media_link_two, soc_media_link_three
		FROM    Nav_Block_2
		where 	dealer_id = #url.dealer_id#
		and 	active = 1
		order by hierarchy ASC
	</cfquery>
	<cfset maxblk = #Get_Block2.recordcount# >
	<cfset y = 0>
	
	
	<section class="section-spl" >		
		
		<div class="container-mbl visible-sm visible-xs" style="margin-bottom:40px!important">
			<div class="row-centerd" style="margin-top:10px!important">					 
				<div class="col-centerd  visible-sm visible-xs" style="margin-right:5px!important">
					<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/Logo_Mobile.png" border="0">
					<div class=" portal-upper-title"> CHOOSE YOUR DEALERSHIP: </div>
				</div>
			</div>	
			<div class="row-centerd" style="margin-top:10px!important">					 
				<div class="col-centerd  visible-sm visible-xs ">
					<cfloop query="Get_Block2">
						<cfset a_button_target ="">
						<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target = "_blank"></cfif>
	 					<div class="col-md-3  visible-sm visible-xs" style="align:center"  >
							<div class="visible-sm visible-xs  pad-top-10">  
								<a href="#Get_Block2.button_link#" target="#a_button_target#" >
									<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Block2.image#" border="0">
                                </a>
							</div>
					  	</div>  
						 <cfif Get_Block2.currentRow mod 2 eq 0>
							</div></div><div class="row-centerd"><div class="col-centerd  visible-sm visible-xs ">  
						</cfif> 
					</cfloop>	
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
				</div>  
			</div>		 
		</div>	
	 	
		<div class="container   visible-lg visible-md" style="margin-bottom:180px!important">
			<div class="row" style="margin-top:180px!important">					 
				<div class="col-md-11 pull-left visible-lg visible-md" style="align:left!important;margin-left:3px!important">
					
					<cfloop query="Get_Block2">
						<cfset a_button_target ="">
						<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target = "_blank"></cfif>
	 					<div class="col-md-3  visible-lg visible-md"  >
							<div class=" visible-lg visible-md pad-top-10">  
								<a href="#Get_Block2.button_link#" target="#a_button_target#" >
									<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Block2.image#" border="0">
                                </a>
							</div>
					  	</div>  
						 <cfif Get_Block2.currentRow mod 2 eq 0>
							</div></div><div class="row"><div class="col-md-11 visible-lg visible-md">  
						</cfif> 
					</cfloop>	
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
					<div class="row" >&nbsp;</div>
				</div>  
			</div>		 
		</div>	
		
	</section>
    
</cfoutput>
