<!--- section_portal_theme_2.cfm

	Defines the Dealership Links section of a portal site. 
		 
				
 --->

<!--- 
<style type="text/css">
 
.body-style{
	<cfif #bg_img# NEQ "" >
		background-image: url('#bg_img#');
		background-repeat: no-repeat;
		background-position:center center;
		  background-attachment:fixed;  
		-webkit-background-size: 100%;
		-moz-background-size: 100%;
		-o-background-size: 100%; 
		background-size:100%;  
	</cfif>
	margin-right:auto;
	margin-left:auto;
} 
 .body-style {
	background-position:0 0 ; 
	}
</style>
 --->
 <!--- <cfset bg_img = "http://dealers.wdautos.com/dealer/fuccillokiaportal/images/icons/bg_stage_tmp.jpg" >   --->
 <cfset bg_img = "">
  <cfset bg_img = "http://dealers.wdautos.com/dealer/fuccillokiaportal/images/icons/img_KiaBackground.jpg" >    
<!---   <cfset bg_img = "" >   --->
<cfset contained = 1 >
<cfset bordered = "" >
<!--- <cfset bordered = "border:1px solid ##cc0000;" > --->

<cfoutput>
	<cfquery name="Get_Block2" datasource="Ultra10"  >
		SELECT  ID, dealer_id, Title, page_type, image, free_text, button_text, button_link, target, 
				active, create_ts, hierarchy, soc_media_link_one, soc_media_link_two, soc_media_link_three
		FROM    Nav_Block_Special
		where 	dealer_id = #url.dealer_id#
		and 	active = 1
		order by hierarchy ASC
	</cfquery>
	<cfset maxblk = #Get_Block2.recordcount# >
	<cfset y = 0>
	
	 <!---<div class="row">&nbsp;</div>	 <div class="row">&nbsp;</div>	--->
	<section class="section-spl" >			
		<div class="container visible-sm visible-xs  visible-lg visible-md">
		  <header class="section-hdr" id="headerNew"></header> 
			<div class="row">					 
				<div class="col-md-12  visible-sm visible-xs visible-lg visible-md">
					<cfset liner = "center">
					<cfloop query="Get_Block2">
						<cfset a_button_target ="">
						<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target = "_blank"></cfif>
	 					<div class="col-md-3  visible-sm visible-xs visible-lg visible-md" style="align:left"  >
							<div class="visible-sm visible-xs visible-lg visible-md pad-top-10">  
								<a href="#Get_Block2.button_link#" target="#a_button_target#" >
									<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Block2.image#" border="0">
                                </a>
							</div>
					  	</div>  
						 <cfif Get_Block2.currentRow mod 2 eq 0>
							</div></div><div class="row"><div class="col-md-12  visible-sm visible-xs visible-lg visible-md">  
						</cfif> 
					</cfloop>	
				</div>  
			</div>		 
			<div class="row">&nbsp;</div>	
			<!---<div class="row">&nbsp;</div>	
			<div class="row">&nbsp;</div>	
			<div class="row">&nbsp;</div>--->
			<div class="clearfix"></div>            
		</div>	
	</section>
	<cfset bg_style= "border:1px solid gray;background-color:white" >
	<!--- 
	<section class="section-portal-2">
		<div class="row">&nbsp;</div>	
		<div class="container-fluid  visible-sm visible-xs  visible-lg visible-md">
			<div class="row">
				<div class="col-md-3 col-md-offset-2  pad-bottom-10 visible-sm visible-xs  visible-lg visible-md" style="#bg_style#">	
				<div class="row"><div class="col-md-12" style="background-color:##AE0F1E;margin-top:5px;margin-left:5px;margin-right:5px;margin-bottom:10px;max-width:98%"> <span class="spl-search-name pad-5" style="color:white" >Find Your Vehicle</span></div></div>
				   <cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
					</cfinvoke>     
					<div class="row">&nbsp;</div>	
				</div>
				<div class="col-md-3 col-md-offset-2 visible-sm visible-xs  visible-lg visible-md" style="#bg_style#">	
				<div class="row"><div class="col-md-12" style="background-color:##AE0F1E;margin-top:5px;margin-left:5px;margin-right:5px;margin-bottom:10px;max-width:98%"> <span class="spl-search-name pad-5" style="color:white" >Get A Quote</span></div></div>
					<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
					</cfinvoke> 
					<div class="row">&nbsp;</div>	
				</div>
			</div>		
			<div class="row">&nbsp;</div>	
			<div class="row">&nbsp;</div>		
			<div class="clearfix"></div>
		</div>	
	</section> --->
	
	<script>	    
		org = $('header:first').html();
		$('##headerNew').html(org);
		$('header:first').remove();
    </script>
    
</cfoutput>
