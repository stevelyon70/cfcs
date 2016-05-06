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
		
		<cfset variables.use_pre_header = 0 >
		<cfinclude template="\ultra10\dealer\#url.assets#\templates\#arguments.dealer_template_id#\header.cfm">

		<header class="section-hdr ">	<!--- PRE-HEADER LINE --->
			
			<div class="container row-hdr visible-md visible-lg  visible-sm visible-xs  ">	
			<cfif   #url.dealer_id# EQ 376 OR   #url.dealer_id# EQ 374 >								
				<div class="container row-hdr visible-sm visible-xs">
					<div class="row">
						<div class="col-md-12" style="align:center;margin-top:10px!important;margin-bottom:20px!important">	 <!--- <div class="navbar"></div> --->
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
						<!--- <div class="visible-sm visible-xs" >&nbsp;</div>  ---> 
						<div class="col-md-12">
							<cfif   #url.dealer_id# NEQ 376 AND   #url.dealer_id# NEQ 374 >
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
							<cfelse>
							&nbsp;
							</cfif>
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
						
						
						 <cfif   #url.dealer_id# EQ 376  OR   #url.dealer_id# EQ 374   >  <!---  --->  
						  	<p class="col-md-12 hdr-col-#variables.hdr_col#  visible-md visible-lg   navbar-v1 pull-right "  >    
								<!--- <cfinvoke component="/cfcs/ultra10/build_navigation_corp" method="#arguments.site_mode#">
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
								</cfinvoke> --->
							</p>  
						</cfif>	 
						
					   <!--- 	<cfif   #url.dealer_id# NEQ 376  >   ---><!--- BYPASS for AutoBuySmart Portal 12-08-2015 --->  
						<!--- <cfif #left(cgi.remote_addr,13)# eq "172.16.25.112" >  --->
						  
<cfif #lcase(cgi.script_name)# NEQ "/seo_launch/seo_launch_questionnaire.cfm" > 
							<p class="col-md-8 hdr-col-#variables.hdr_col#  visible-md visible-lg  visible-sm visible-xs  navbar-v1 pull-right "  >    
								<cfinvoke component="/cfcs/ultra10/build_navigation_right" method="#arguments.site_mode#">
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
						<!--- </cfif>		 --->
						
					</div>	<!--- END Row --->
				</cfloop>
			</div>
			
 	
			<div class="container row-hdr visible-sm visible-xs" style="margin-top:0px!important">
				<cfif #url.dealer_id# neq 1 AND  #url.dealer_id# neq 24  AND  #url.dealer_id# neq 82    >
					<div class="row">
						<cfif  #url.dealer_id# NEQ 376 AND  #url.dealer_id# NEQ 374    >
							<div class="col-md-12" style="align:center">
						<cfelse>
							<div class="col-md-12" style="align:left">	
						</cfif>	
						<cfif   #url.dealer_id# NEQ 376  AND  #url.dealer_id# NEQ 374    >	<!--- 302 has no nav, 341 has right-side header navigation 12-08-2015 --->
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
						
				
			</div>
			</div>
			<div class="row-hdr visible-sm visible-xs" style="margin-bottom:20px!important"><div class="col-md-12">&nbsp;</div></div>
			
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
