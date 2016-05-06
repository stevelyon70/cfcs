<cfoutput>


<!--- This will be the new LOWER Quick Links section --->
		<cfquery name="Get_lower_QL" datasource="Ultra10" >
			SELECT   Nav_ID, dealer_id, Nav_Type_ID
			FROM    Navigation
			where 	dealer_id = #url.dealer_id#
			and 	Nav_Type_ID = 57
		</cfquery>
		<cfset which = "Reviews" >
		<cfif #Get_lower_QL.recordcount# GT 0 >
			<cfset which = "QuickLinks" >
		</cfif>
		
<!--- If a MAP is found, the Commercials go away --->

		<cfset variables.End_Date=Dateformat(now(),"mm/dd/yyyy")>
		<cfquery datasource="Ultra10" name="Chk_Map">
			SELECT		Nav_Type_ID
			FROM		Navigation
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="4">
			AND			Nav_Type_ID = 38
			AND			Start_Date < GETDATE()
			AND			End_Date >= '#variables.End_Date#'
		</cfquery>
		<cfset wch = "Commercial" >
		<cfif #Chk_Map.recordcount# GT 0 >
			<cfset wch = "Map" >
		</cfif>
		
		<section class="section-video">
			<div class="container">
				<div class="row">
				
					<div class="col-md-5 verticalBlank">
				<!--- Sub 1 --->
						<div class="spl-search-name pad-top-10 pad-5" style="align:left"><span class="spl-search-name pad-5" style="color:white" >GET A QUOTE</span></div>
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
							<div class="row"><div class="col-md-12 pad-top-5 pad-5 page-div-lite visible-lg visible-md"></div></div>	
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_qq_big">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
					</div>
				<!--- End Sub 1 --->
				
					<div class="col-md-3 pad-5 verticalLine visible-md visible-lg" style="align:left">	
					
				<!--- Sub 2 --->
						<cfif #which# EQ "Reviews" >
							<div class="spl-search-name pad-top-10 pad-5" style="align:left"><span class="spl-search-name pad-5" style="color:white" >REVIEWS</span></div>
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
							<div class="row"><div class="col-md-12 pad-top-5 page-div-lite visible-lg visible-md"></div></div>
								<cfinvoke component="/cfcs/ultra10/splash_reviews" method="modern_standard_stacked">
								</cfinvoke>
							</div>
						<cfelse >
							<div class="spl-search-name pad-top-10 pad-5" style="align:left"><span class="spl-search-name pad-5" style="color:white" >&nbsp;</span></div>
							<div class="row"><div class="col-md-12 pad-top-5  visible-lg visible-md"></div></div>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="57"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="srch-links-btn"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
							</div>
						</cfif>		
				<!--- End Sub 2 --->	
				
					<div class="col-md-4 pad-5 verticalLine visible-md visible-lg" style="align:left">	
					
				<!--- Sub 3 --->			
					<div class="spl-search-name pad-top-10 pad-5" style="align:left"><span class="spl-search-name pad-5" style="color:white" >
					<cfif #wch# EQ "Commercial" >
						OUR COMMERCIALS</span></div>
						<div class="row"><div class="col-md-12 pad-bottom-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
					<cfelse>
						OUR LOCATION</span></div>
							<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="38"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-map"/>
						</cfinvoke>
					</cfif>	 
					</div>
				<!--- End Sub 3 --->
				</div>
				<div class="row pad-top-10" style="min-height:20px;align:center"></div>
			</div>
		</section>
  



</cfoutput>