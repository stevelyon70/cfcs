<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="site_mode" required="true">
		<cfargument name="template_id" required="true">	
		<cfargument name="dealer_template_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		
		<!--- Check for Site Search Client  --->
			<cfset site_search_trigger = 0 >
			<cfset site_search_style = 0 >
			<cfquery datasource="ultra10" name="Chk_site_search">SELECT Dealer_ID, site_search_client, site_search_result FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
			<cfif #Chk_site_search.site_search_client# EQ 1><cfset site_search_trigger = 1 ></cfif><cfif #Chk_site_search.site_search_result# EQ 1><cfset site_search_style = 1 ></cfif>
		<!--- Check for Site Search Client  --->
	

		<cfset variables.use_pre_header = 0 >
		<cfinclude template="\ultra10\dealer\#url.assets#\templates\#arguments.dealer_template_id#\header.cfm">

		<!--- <cfif #url.dealer_id# NEQ 376 > --->
		<header class="section-hdr ">	<!--- PRE-HEADER LINE --->
		<!--- <cfelse>
		<header class="section-hdr navbar-fixed-top">	<!--- PRE-HEADER LINE --->
		</cfif> --->
			<cfif  #variables.use_pre_header# EQ 1 >
				<cfquery name="GetPHdr" datasource="Ultra10">
					SELECT	ID, dealer_id, header_text, image_name, link_destination, link_target, background_color, font_family, font_size, font_color, header_height, header_width, 
			                header_left_border, header_right_border, header_top_pad, header_bottom_pad, hierarchy, active, start_dt, expires_dt, create_dt
					FROM    Variable_Pre_Header 
					where 	dealer_id=#url.dealer_id# and active=1
				</cfquery>
				<cfif #GetPHdr.recordcount# NEQ 0 >  <!--- Defaults to template_min.css if recs = 0 --->
					<cfif #url.dealer_id# eq 366 >
						<style type="text/css">
							.pre-header-define{ max-width:<cfoutput>#GetPHdr.header_width#</cfoutput>!important;height:<cfoutput>#GetPHdr.header_height#</cfoutput>!important;
												font-size:<cfoutput>#GetPHdr.font_size#</cfoutput>!important;color:<cfoutput>###GetPHdr.font_color#</cfoutput>!important;
												background-color:<cfoutput>###GetPHdr.background_color#</cfoutput>!important;
												border:0px solid ##cc0000!important;border-bottom:0px solid ##cc0000!important;border-radius: 0px!important;
												-moz-border-radius: 0px!important;-webkit-border-radius: 0px!important;padding:00px;margin-left: auto;margin-right: auto; }
							.pre-header-text{ font-size:<cfoutput>#GetPHdr.font_size#</cfoutput>!important;color:<cfoutput>###GetPHdr.font_color#</cfoutput>!important;;margin-right: 25px;	padding-top:15px; }
							
							@media (max-width: 990px) {
								.pre-header-define { min-width:100%!important;height:51px!important;}
								.pre-header-text{ font-size:8pt!important;margin-left: 1px!important;margin-right: 1px!important;margin-top: 1px!important;	 }
								.navbar-toggle{margin-top:0px!important;}
									}
							
						</style>
					<cfelseif #url.dealer_id# eq 376 >
						<style type="text/css">
							.pre-header-define{ max-width:<cfoutput>#GetPHdr.header_width#</cfoutput>!important;height:<cfoutput>#GetPHdr.header_height#</cfoutput>!important;
												font-size:<cfoutput>#GetPHdr.font_size#</cfoutput>!important;color:<cfoutput>###GetPHdr.font_color#</cfoutput>!important;
												background-color:<cfoutput>###GetPHdr.background_color#</cfoutput>!important;
												border:0px solid ##cc0000!important;border-bottom:0px solid ##cc0000!important;border-radius: 0px!important;
												-moz-border-radius: 0px!important;-webkit-border-radius: 0px!important;padding:0px 0px 3px 0px!important;margin-left: auto;margin-right: auto; }
							.pre-header-text{ font-size:<cfoutput>#GetPHdr.font_size#</cfoutput>!important;color:<cfoutput>###GetPHdr.font_color#</cfoutput>!important;margin-right:40px!important; 
												margin-top: -20px!important;}
							
							@media (max-width: 600px) {
								.pre-header-define { min-width:100%!important;height:20px!important;margin-left: 20px!important;margin-right: 20px!important;}
								.pre-header-text{ font-size:8pt!important;margin-left: 10px!important;margin-right: 1px!important;margin-top: 1px!important;	 }
									}
							
						</style>
					<cfelse>
						<style type="text/css">
							.pre-header-define{ max-width:<cfoutput>#GetPHdr.header_width#</cfoutput>!important;height:<cfoutput>#GetPHdr.header_height#</cfoutput>!important;
												font-size:<cfoutput>#GetPHdr.font_size#</cfoutput>!important;color:<cfoutput>###GetPHdr.font_color#</cfoutput>!important;
												background-color:<cfoutput>###GetPHdr.background_color#</cfoutput>!important;
												border:0px solid ##cc0000!important;border-bottom:0px solid ##cc0000!important;border-radius: 0px!important;
												-moz-border-radius: 0px!important;-webkit-border-radius: 0px!important;padding:10px 10px 3px 20px;margin-left: auto;margin-right: auto; }
							.pre-header-text{ font-size:<cfoutput>#GetPHdr.font_size#</cfoutput>!important;color:<cfoutput>###GetPHdr.font_color#</cfoutput>!important;;margin-right: 25px;	 }
							
							@media (max-width: 600px) {
								.pre-header-define { min-width:100%!important;height:20px!important;}
								.pre-header-text{ font-size:8pt!important;margin-left: 1px!important;margin-right: 1px!important;margin-top: 1px!important;	 }
									}
							
						</style>	
					</cfif>
				</cfif>
				<div class=" visible-md visible-lg  visible-sm visible-xs no-pad">
					<cfif url.dealer_id neq 366><div class="row"></cfif>
						<div class=" pre-header-define"  align="right" >
							<cfif  #url.dealer_id# EQ 233 OR  #url.dealer_id# EQ 366  OR  #url.dealer_id# EQ 376    >
								<cfinvoke component="/cfcs/ultra10/build_navigation" method="pre_header">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="pre_head_text" value="#GetPHdr.header_text#"/>
								</cfinvoke>
							<cfelse> 
							<div class="visible-md visible-lg pre-header-text pull-right" >#GetPHdr.header_text#&nbsp;&nbsp;&nbsp;</div> 
							</cfif>
						</div>
					<cfif url.dealer_id neq 366></div></cfif>
				</div>					
			</cfif>
			
		 
			
			<div class="container row-hdr visible-md visible-lg  visible-sm visible-xs  ">	
			<cfif #url.dealer_id# EQ 365 OR  #url.dealer_id# EQ 32 OR  #url.dealer_id# EQ 366 OR  #url.dealer_id# EQ 376 >								<!--- Kelly Nissan  moves mobile menu BELOW directions 02/09/2016 --->
				<div class="container row-hdr visible-sm visible-xs">
					<div class="row">
						<div class="col-md-12" style="align:center">	 <!--- <div class="navbar"></div> --->
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="4"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="hdr-mobile"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
						</div>
					</div>
					<div class="row visible-sm visible-xs">
						<div class="visible-sm visible-xs" >&nbsp;</div> 
						<div class="col-md-12">
							<cfinvoke component="/cfcs/ultra10/contact" method="phone_mobile">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
								<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
								<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
								<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
								<cfinvokeargument name="city" value="#arguments.city#"/>
								<cfinvokeargument name="state" value="#arguments.state#"/>
								<cfinvokeargument name="zip" value="#arguments.zip#"/>
								<cfinvokeargument name="title_class" value="side-title"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							</cfinvoke>
						</div>
					</div>
				</div>	
			</cfif>
			
				<cfloop from="1" to="#variables.header_rows#" index="hdr_row">
					<cfset variables.this_row="row_#variables.hdr_row#_cols">
					<div class="row">
						<cfloop from="1" to="#evaluate(variables.this_row)#" index="hdr_col">   <!--- #evaluate(variables.this_row)# --->
							<cfset variables.this_span="col_span_#variables.hdr_col#">
							<div class="col-md-#evaluate(variables.this_span)# hdr-col-#variables.hdr_col#  visible-md visible-lg"  style="z-index:700!important;">  
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="#variables.hdr_col+15#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="header-#variables.hdr_col+15#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
								</cfinvoke>
							</div>
						</cfloop>
						
					   	<cfif  #url.dealer_id# NEQ 302 and #url.dealer_id# NEQ 233  and #url.dealer_id# NEQ 366    and #url.dealer_id# NEQ 376  and #url.dealer_id# NEQ 46 >  <!--- BYPASS for AutoBuySmart Portal 12-08-2015 --->  
						  	<p class="col-md-8 hdr-col-#variables.hdr_col#  visible-md visible-lg  visible-sm visible-xs  navbar-v1 pull-right "  >    
								<cfinvoke component="/cfcs/ultra10/build_navigation" method="#arguments.site_mode#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								</cfinvoke>
							</p>  
						</cfif>		
						<cfif   #url.dealer_id# EQ 376  >  <!--- BYPASS for AutoBuySmart Portal 12-08-2015 --->  
						  	<p class="col-md-12 hdr-col-#variables.hdr_col#  visible-md visible-lg   navbar-v1 pull-right "  >    
								<cfinvoke component="/cfcs/ultra10/build_navigation_corp" method="#arguments.site_mode#">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
									<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
									<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
									<cfinvokeargument name="city" value="#arguments.city#"/>
									<cfinvokeargument name="state" value="#arguments.state#"/>
									<cfinvokeargument name="zip" value="#arguments.zip#"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								</cfinvoke>
							</p>  
						</cfif>	
					</div>	<!--- END Row --->
				</cfloop>
			</div>
			
 	
			<div class="container row-hdr visible-sm visible-xs">
				<cfif #url.dealer_id# neq 1 AND  #url.dealer_id# neq 24  AND  #url.dealer_id# neq 82    >
					<div class="row">
						<cfif #url.dealer_id# NEQ 302 and #url.dealer_id# NEQ 306 and #url.dealer_id# NEQ 307  and #url.dealer_id# NEQ 233  
								 and #url.dealer_id# NEQ 365  and #url.dealer_id# NEQ 32  and #url.dealer_id# NEQ 366  and #url.dealer_id# NEQ 376    >
							<div class="col-md-12" style="align:center">
						<cfelse>
							<div class="col-md-12" style="align:left">	
						</cfif>	
						<cfif  #url.dealer_id# NEQ 341 AND  #url.dealer_id# NEQ 302  AND  #url.dealer_id# NEQ 365   AND  #url.dealer_id# NEQ 32   AND  #url.dealer_id# NEQ 376  
								 AND  #url.dealer_id# NEQ 366    >	<!--- 302 has no nav, 341 has right-side header navigation 12-08-2015 --->
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="4"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="hdr-mobile"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
						 </cfif>	
						</div>
					</div>
				</cfif>
						
				<cfif #url.dealer_id# NEQ 198 AND #url.dealer_id# NEQ 90 AND  
						#url.dealer_id# NEQ 133 and #url.dealer_id# NEQ 199 AND  
							#url.dealer_id# NEQ 197  AND  #url.dealer_id# NEQ 203 AND  
								#url.dealer_id# NEQ 256 AND  
								#url.dealer_id# NEQ 306 AND  
								#url.dealer_id# NEQ 308 AND  
								#url.dealer_id# NEQ 296 AND  
								#url.dealer_id# NEQ 341 AND  
								#url.dealer_id# NEQ 307 AND  
								#url.dealer_id# NEQ 365 AND   
								#url.dealer_id# NEQ 32 AND  
								#url.dealer_id# NEQ 366  AND  
								#url.dealer_id# NEQ 376  > <!--- Remove Get Directions on Mobile Forms --->
					<div class="row visible-sm visible-xs">
						<div class="col-md-12"><!-- contact 101 -->
							<cfinvoke component="/cfcs/ultra10/contact" method="phone_mobile">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
								<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
								<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
								<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
								<cfinvokeargument name="city" value="#arguments.city#"/>
								<cfinvokeargument name="state" value="#arguments.state#"/>
								<cfinvokeargument name="zip" value="#arguments.zip#"/>
								<cfinvokeargument name="title_class" value="side-title"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							</cfinvoke>
						</div>
					</div>
				</cfif>
			</div>
			</div>
			
			
		</header>

	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="site_mode" required="true" >
		<cfargument name="dealer_template_id" required="true" >	

		<cfinclude template="\ultra10\dealer\#url.assets#\templates\#arguments.dealer_template_id#\header.cfm">

		<div class="section-hdr">
			<div class="container row-hdr">
				<table class="table-hdr" cellpadding="0" cellspacing="0">
					<cfloop from="1" to="#variables.header_rows#" index="hdr_row">
						<cfset variables.this_row="row_#variables.hdr_row#_cols">
						<tr>
							<cfloop from="1" to="#evaluate(variables.this_row)#" index="hdr_col">
								<cfset variables.this_span="col_span_#variables.hdr_col#">
								<td class=" hdr-col-#variables.hdr_col+15#" width="#8.33*evaluate(variables.this_span)#%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="#variables.hdr_col+15#"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="header-#variables.hdr_col+15#"/>
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
										<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
										<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
										<cfinvokeargument name="city" value="#arguments.city#"/>
										<cfinvokeargument name="state" value="#arguments.state#"/>
										<cfinvokeargument name="zip" value="#arguments.zip#"/>
									</cfinvoke>
								</td>
							</cfloop>
						</tr>
					</cfloop>
				</table>
			</div>
		</div>

	</cffunction>

</cfcomponent>
