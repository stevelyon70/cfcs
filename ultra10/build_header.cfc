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
		
		
		<!--- SEARCH BAR 03/16/2016 --->
		<cfset variables.srch_err_phrase = "" >
		<cfif IsDefined("url.err_disp") >
			<cfset variables.srch_err_phrase = "Vehicles Found for"  >
			<cfset variables.srch_err_criteria = "#url.err_disp#" >
		</cfif>

		<!--- Check for Site Search Client  --->
			<cfset site_search_trigger = 0 >
			<cfset site_search_style = 0 >
			<cfset search_header_location = 0 ><cfset srp_noresult = "USED" >
			<cfquery datasource="ultra10" name="Chk_site_search">SELECT Dealer_ID, site_search_client, site_search_result , hdr_search_location ,zero_result_dest FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
			<cfif #Chk_site_search.site_search_client# EQ 1><cfset site_search_trigger = 1 ></cfif><cfif #Chk_site_search.site_search_result# EQ 1><cfset site_search_style = 1 ></cfif>
			<cfset search_header_location = #Chk_site_search.hdr_search_location# >
		<cfif #Chk_site_search.zero_result_dest# EQ 1><cfset srp_noresult = "NEW" ><cfelse><cfset srp_noresult = "USED" ></cfif>
			
		<!--- Check for Site Search Client  --->
	
		
		<cfinclude template="\ultra10\dealer\#url.assets#\templates\#arguments.dealer_template_id#\header.cfm">
	
	<cfif IsDefined("url.archive_date") >
			<title>#url.archive_date#</title>
		</cfif>	
	
		<header class="section-hdr">
			<cfif #url.dealer_id# eq 1  >
			<div class="container row-hdr visible-md visible-lg  visible-sm visible-xs">
			<cfelse>
			<div class="container row-hdr visible-md visible-lg ">
			</cfif>
				<cfloop from="1" to="#variables.header_rows#" index="hdr_row">
					<cfset variables.this_row="row_#variables.hdr_row#_cols">
					<div class="row">
						<cfloop from="1" to="#evaluate(variables.this_row)#" index="hdr_col">
							<cfset variables.this_span="col_span_#variables.hdr_col#">
							<div class="col-md-#evaluate(variables.this_span)# hdr-col-#variables.hdr_col+15#"<cfif #url.dealer_id# eq 90>style="align:style="align:center"</cfif> > <!-- 39 -->
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
						<!--- Site Search --->
						 <cfif #site_search_trigger# neq 0 and #url.dealer_id# NEQ 233 >
							<div class="row ">
								<div class=" pad-top-10 col-md-#evaluate(variables.this_span)# hdr-col-#variables.hdr_col+15#" style="align:right"  >
									<cfform action="../../search/index.cfm" method="post" name="form_name" >
										<input type="hidden" name="res_style" value="#site_search_style#">
										<span style="color:##666666">Search</span> <input 	type="text" name="lookup" value="" size="30" maxlength="50" required >
										<input style="background-color:##ffffff;color:##666666;border:1px solid ##666666;border-radius:7px!important;-moz-border-radius:7px!important;-webkit-border-radius:7px!important;padding:2px 2px 2px 2px;"	type="submit"  name="submit"  class="buttonmicro" value="go">
									</cfform>
								</div>
							</div>
						</cfif> 
						<!--- Inventory Search --->
						 <cfif #search_header_location# EQ 1 >
							<div class="container-search-box-hdr" align="right">
								<cfform action="http://#cgi.server_name#/search/index.cfm" method="post" name="news"  >
									<input type="hidden" name="res_style" value="1">
									<input  class="site-srch-input-hdr"	 type="text" name="lookup"  id="searchbar" size="50"  value=""  placeholder="Search #url.dealer_name#s Inventory" required >
									<input class="site-srch-btn-hdr"	type="submit"  name="submit"     value="Search">
								</cfform>
								 <cfif #variables.srch_err_phrase# NEQ "" >
									 &nbsp;&nbsp;<span class="site-srch-count">0 </span><span class="site-srch-error">#variables.srch_err_phrase# "#variables.srch_err_criteria#".<br>Displaying All #srp_noresult# Vehicles in our inventory</span>
								</cfif> 
							</div> 
						</cfif> 
						<!--- Site Search --->
					</div>
				</cfloop>
			</div>
			<div class="container row-hdr visible-sm visible-xs">
				<cfif #url.dealer_id# neq 1  >
					<div class="row row-centered">
					<cfif #url.dealer_id# NEQ 302 and #url.dealer_id# NEQ 306 and #url.dealer_id# NEQ 307 and #url.dealer_id# NEQ 369 >
						<div class="col-md-12 col-centered no-pad" style="align:center">
					<cfelse>
						<div class="col-md-12" style="align:center">	
					</cfif>	
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
				</cfif>
				<cfif #url.dealer_id# NEQ 198 AND #url.dealer_id# NEQ 90 AND  
						#url.dealer_id# NEQ 133 and #url.dealer_id# NEQ 199 AND  
							#url.dealer_id# NEQ 197  AND  #url.dealer_id# NEQ 203 AND  
								#url.dealer_id# NEQ 256 AND  
								#url.dealer_id# NEQ 306 AND  
								#url.dealer_id# NEQ 308 AND  
								#url.dealer_id# NEQ 296 AND   
								#url.dealer_id# NEQ 342 AND  <!--- TurkeyShoot --->
								#url.dealer_id# NEQ 307  > <!--- Remove Get Directions on Mobile Forms --->
					<div class="row visible-sm visible-xs no-pad">
						<div class="col-md-12 no-pad"><!-- contact 101 -->
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