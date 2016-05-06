<!--- section_portal_theme_4.cfm

	Defines the Dealership Links section of a portal site. 
		Generates 3 across, full width of screen, for as many Dealerships as required.
				
C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   				
				COLORS ARE SET FOR AUTOBUYSMART
C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   C*A*U*T*I*O*N   
 --->
 
 
 <cfset bg_img = "" >  
<!---   <cfset bg_img = "" >   --->
<cfset contained = 1 >
<cfset bordered = "" >
<!--- <cfset bordered = "border:1px solid ##cc0000;" > --->
<cfset body_width = "width:900px;" >
<cfset backgrd_color = "background-color:##DBDBDB;" >

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
		border-radius: 10px!important;
		-moz-border-radius: 10px!important;
		-webkit-border-radius: 10px!important;
	</cfif>
	<cfif #bg_img# NEQ "" >
		background-image: url('#bg_img#');
		background-repeat: repeat-x;
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
	max-width:900px;  
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
	<cfset maxblk = #Get_Block2.recordcount# >
	<cfset y = 0>
	<section class="section-portal-1">
			
		<div class="container-fluid visible-sm visible-xs  visible-lg visible-md">
				
			<div class="row">	  
					
				<div class="col-md-12  visible-sm visible-xs visible-lg visible-md">
					<cfset liner = "center">
					<cfloop query="Get_Block2">
						<cfset a_button_target ="">
						<cfif #Get_Block2.target# NEQ "" ><cfset a_button_target = "_blank"></cfif>
	 					<div class="col-md-4  portal-container-1  pad-top-5 visible-sm visible-xs visible-lg visible-md" >
							<div class="visible-sm visible-xs visible-lg visible-md pad-top-10  portal-upper-title">  
								<a href="#Get_Block2.button_link#" target="#a_button_target#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#Get_Block2.image#" border="0"></a>
							</div>
					  	</div>  
						<cfif Get_Block2.currentRow mod 3 eq 0>
							</div></div><div class="row">&nbsp;</div><div class="row"><div class="col-md-12   visible-sm visible-xs visible-lg visible-md">
						</cfif>
					</cfloop>	
				</div>  
			</div>  

			<div class="clearfix"></div>
		</div>	
	</section>

	<cfquery name="get_text" datasource="Ultra10" dbtype="ODBC">
		SELECT  ID, dealer_id, title, image_source, page_text, page_type, hierarchy, active
		FROM    Portal_Text_Section
		WHERE	dealer_id	=	#URL.dealer_id#
		and 	active = 1
		order by hierarchy ASC
	</cfquery>		
		
	<section class="section-portal-2">
		
		<div class="container-fluid  visible-sm visible-xs  visible-lg visible-md">
				
			<div class="row">	  
					
				<div class="col-md-12  visible-sm visible-xs visible-lg visible-md">
				<!--- 	<cfif #get_text.Title# NEQ "" > --->
						<div class="portal-upper-title"><h2>#get_text.Title#</h2></div>
					<!--- </cfif> --->
					<CFSET STYLER = "border:1px solid ##DBDBDB;border-radius: 7px!important;-moz-border-radius: 7px!important;-webkit-border-radius: 7px!important" >
					<div class="col-md-5 visible-sm visible-xs visible-lg visible-md" >
						<img   class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#get_text.image_source#" border="0"></a>
					</div>		
					<div class="col-md-7 pad-bottom-10 portal-upper-pgtxt visible-sm visible-xs visible-lg visible-md" >
						#get_text.page_text#  
					</div>		
					
				</div>  
				
			</div>  

			<div class="clearfix"></div>
		</div>	
	</section>


</cfoutput>
