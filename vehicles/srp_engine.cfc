<cfcomponent>

	<cffunction name="srp_default" description="srp search engine" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="form_id" default="srp_form"/>
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		
		<cfset Get_Years=arguments.Get_Years>
		<cfset Get_Makes=arguments.Get_Makes>
		<cfset Get_Models=arguments.Get_Models>
		<cfset Get_Dealers=arguments.Get_Dealers>
		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		<cfif IsDefined("url.geo") and ( #url.geo# NEQ "" and #url.geo#  NEQ 0 ) >  <!--- Regional Search 12/13/2014--->
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		<cfparam default="" name="form.sortblock">
		<!-- srp engine #url.new_used#  #url.sortblock# #form.sortblock#-->
		<form id="#arguments.form_id#" name="#arguments.form_id#" action="#arguments.srp_action#" method="post">
			<div class="row srp-form">
				<div class="col-md-2">
					<select name="new_used" class="srp-input" onchange="this.form.submit()">
						<!---<option value="B" <cfif url.new_used eq "B">selected</cfif>>All Vehicles</option>--->
						<cfif #url.dealer_id# NEQ 249 and 
								#url.dealer_id# NEQ 47  and 
									url.dealer_id neq "262"  and 
										url.dealer_id neq "55"  and 
											url.dealer_id neq "264"  and 
												url.dealer_id neq "265" and 
												url.dealer_id neq "288"  and 
													url.dealer_id neq "14"  and 
													url.dealer_id neq "330" and 
													url.dealer_id neq "333" and 
													url.dealer_id neq "369"  >   
							<option value="N" <cfif url.new_used eq "N">selected</cfif>>New #srch_txt_new#</option>
						</cfif>	
						
					<cfif url.dealer_id neq "1" and  url.dealer_id neq "288" and  url.dealer_id neq "67">
						<option value="U" <cfif url.new_used eq "U">selected</cfif>>Used #srch_txt_used#</option>
					</cfif>	
						
						
						<cfif #url.dealer_id# NEQ 51 
							<!--- and  #url.dealer_id# NEQ 249  --->
								and  #url.dealer_id# NEQ 55 
									and  #url.dealer_id# NEQ 14  
										and  #url.dealer_id# NEQ 1 
											and #url.dealer_id# NEQ 67 
												and url.dealer_id neq 288  and 
													url.dealer_id neq "333" and 
													url.dealer_id neq "369">
							<option value="C" <cfif url.new_used eq "C">selected</cfif>>Certified #srch_txt_certified#</option>
						<cfelse>
                        	<cfif url.dealer_id neq 14 and url.dealer_id neq 288 and url.dealer_id neq 333 and url.dealer_id neq 369>
								<option value="U" <cfif (url.dealer_id eq 1 and url.new_used eq "U") or (url.new_used eq "U") >selected</cfif>>
                                	<cfif url.dealer_id neq 1>Certified </cfif>Pre-Owned #srch_txt_used#
                                </option>	
                            </cfif>
                            <cfif url.dealer_id eq "288">
                                <option value="U" <cfif url.new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned</option>	
                            </cfif>	
						</cfif>  
						
					<!---  <cfif url.dealer_id eq "1" >
						<option value="q" <cfif url.new_used eq "q">selected</cfif>>Baierl Budget Cars</option>
					</cfif>	   --->
					 
					   <cfif url.dealer_id eq "66" OR  url.dealer_id eq "67"   OR  url.dealer_id eq "288"   >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif url.new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>     
                   
                    	<cfif  url.dealer_id eq 78>
                        	<option value="A"<cfif url.new_used eq "a">selected="selected"</cfif>>Commercial Vehicles</option>
                        </cfif>
                    
					</select>
				</div>
				<div class="col-md-2">
					<select name="make" class="srp-input" onchange="this.form.submit()">
						<cfif #srch_style# eq 1 >
						<option value="">Make</option>
						<cfelse>
						<option value="">Select A Make</option>
						</cfif>
                        <cfif url.dealer_id eq 15 and url.new_used eq "N">
	                        <option value="Chevrolet">Chevrolet</option>
                        </cfif>
						<cfloop query="Get_Makes">
							<cfif #url.dealer_id# NEQ 30  >
							<option value="#Get_Makes.V_Make#" <cfif url.make eq Get_Makes.V_Make>selected</cfif>>#Get_Makes.V_Make#</option>	
							<cfelse>
							<cfif (#url.make# EQ "" or #url.make# NEQ "Toyota") and  url.new_used eq "N" >
							 <cfset url.make = "toyota">  
							<option value="toyota" selected >Toyota </option>	
							<cfelse>
							<option value="#Get_Makes.V_Make#" <cfif url.make eq Get_Makes.V_Make>selected</cfif>>#Get_Makes.V_Make#</option>	
							</cfif>
							</cfif>
						</cfloop>
					</select>
				</div>
				<div class="col-md-2">
					<cfif len(trim(url.make)) gt 0>
						<select name="model" class="srp-input" onchange="this.form.submit()">
						<cfif #srch_style# eq 1 >
						<option value="">Model</option>
						<cfelse>
							<option value="">Select A Model</option>
						</cfif>	
							<cfloop query="Get_Models">
	                            <cfset variables.this_model=Get_Models.V_Model>
								<!---<cfset variables.this_model=replace(Get_Models.V_Model,"&","%26","all" )>
								<cfset variables.this_model=replace(variables.this_model," ","%20","all" )>--->
								<option value="#variables.this_model#" <cfif url.model eq Get_Models.V_Model>selected</cfif>>#replace(Get_Models.V_Model,"FourRunner","4Runner","all")#</option>	
							</cfloop>
						</select>
					<cfelse>
						<select name="model" class="srp-input" disabled="true">
						<cfif#srch_style# eq 1 >
						<option value="">Model</option>
						<cfelse>
							<option value="">Select A Model</option>
						</cfif>	
						</select>
					</cfif>
				</div>
				<div class="col-md-2">
					<select name="year" class="srp-input" onchange="this.form.submit()">
						<cfif #srch_style# eq 1 >
						<option value="">Year</option>
						<cfelse>
						<option value="">Select A Year</option>
						</cfif>
						<cfloop query="Get_Years">
							<option value="#Get_Years.V_Year#" <cfif url.year eq Get_Years.V_Year>selected</cfif>>#Get_Years.V_Year#</option>	
						</cfloop>
					</select>
				</div>
				<div class="col-md-2 visible-md visible-lg">
					<select name="sortblock" class="srp-input" onchange="this.form.submit()">
						<option value="">Sort By</option>
						<option value="1" <cfif url.sortblock eq "1">selected</cfif>>Sort By Make,Model</option>
						<option value="2" <cfif url.sortblock eq "2">selected</cfif>>Sort By Price (low to high)</option>
						<option value="3" <cfif url.sortblock eq "3">selected</cfif>>Sort By Price (high to low)</option>
						<cfif url.new_used neq "N" and url.new_used neq "A"><option value="4" <cfif url.sortblock eq "4">selected</cfif>>Sort By Mileage (low to high)</option></cfif>
						<cfif url.new_used neq "N" and url.new_used neq "A"><option value="5" <cfif url.sortblock eq "5">selected</cfif>>Sort By Mileage (high to low)</option></cfif>
						<option value="6" <cfif url.sortblock eq "6">selected</cfif>>Sort By Year (low to high)</option>
						<option value="7" <cfif url.sortblock eq "7">selected</cfif>>Sort By Year (high to low)</option>
						<cfif len(trim(url.dealer_id)) gt 0><option value="8" <cfif url.sortblock eq "8">selected</cfif>>Sort By Stock Number</option></cfif>
						<cfif #url.dealer_id# eq 14>
						 <option value="9" <cfif url.sortblock eq "9">selected</cfif>>Show Luxury</option>
						 </cfif>
					</select>
				</div>
				<cfif #url.dealer_id# NEQ 366 >
				
					<!--- <cfif #url.dealer_id# EQ 46 >
						<div class="col-md-2">
							<input class="srp-btn-search btn btn-default" type="button" value="Reset Search" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#&sortblock=7&zip=#url.zip#&radius=#url.radius#&classic=#url.classic#'"/><!---&geo=#url.geo#--->
						</div>
					<cfelse>	 --->
						<div class="col-md-2">
							<input class="srp-btn-search btn btn-default" type="button" value="Clear" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#&zip=#url.zip#&radius=#url.radius#&classic=#url.classic#'"/><!---&geo=#url.geo#--->
						</div>
					<!--- </cfif>	 --->
				<cfelse>
				<div class="col-md-1 visible-md visible-lg">&nbsp;</div>
				<div class="col-md-1 visible-md visible-lg">
					<input class="srp-btn-search btn btn-default" type="button" value="Clear" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#&zip=#url.zip#&radius=#url.radius#&classic=#url.classic#'"/><!---&geo=#url.geo#--->
				</div>
				<div class="col-md-1 visible-sm visible-xs">
					<input class="srp-btn-search-mbl btn btn-default" type="button" value="Clear" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#&zip=#url.zip#&radius=#url.radius#&classic=#url.classic#'"/><!---&geo=#url.geo#--->
				</div>
				</cfif>

			</div>
			<input type="hidden" name="body" value="#url.body#"/>
			<input type="hidden" name="zip" value="#url.zip#"/>
			<input type="hidden" name="radius" value="#url.radius#"/>
			<input type="hidden" name="maxprice" value="#url.maxprice#"/>
			<input type="hidden" name="minprice" value="#url.minprice#"/>
			<input type="hidden" name="old_year" value="#url.year#"/>
			<input type="hidden" name="old_make" value="#url.make#"/>
			<input type="hidden" name="classic" value="#url.classic#"/>
			<input type="hidden" name="geo" value="#url.geo#"/>

		</form>
		
		<cfif #url.dealer_id# eq 1>
		<div class="row">
			<div class="col-md-3" align="left">
				<a href="http://www.baierlbudgetcars.com/used" class="srch-links-btn-2" target="_blank"><span class="glyphicon glyphicon-chevron-right" > </span> Baierl Budget Used Cars</a>
			</div>
		</div>
		</cfif>
		
		<div class="row srp-form visible-xs visible-sm">
			<div class="col-md-12">
				<form action="http://#cgi.server_name#/vehicles/stock_search.cfm" method="post">
					<div class="row">
						<div class="col-md-12">
							<input class="srp-input" type="text" name="stock" placeholder="Enter Stock ##"/>		
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<input class="srp-btn-search btn btn-default" type="submit" value="Search by Stock"/>
						</div>
					</div>
				</form>
			</div>
		</div>

	</cffunction>

	<cffunction name="srp_new" description="srp search engine for Alt1 SRP Layout" output="Yes" access="public">

		<!---arguments--->
		  <cfargument name="form_id" default="srp_new_form"/>
		  <cfargument name="pass_params" default=""/>
		<cfargument name="srp_action" default="http://#cgi.server_name#"/>
		<cfif IsDefined("url.sortblock") >
			<cfset url.sortblock = #url.sortblock# >
		<cfelse>	
			<cfset url.sortblock = "1" >
		</cfif> 
		
		<form id="#arguments.form_id#" name="#arguments.form_id#" action="#arguments.srp_action##arguments.pass_params#" method="post">
				<!--- <div class="col-md-12 visible-md visible-lg no-pad" align="left" > --->
					
					<select name="sortblock" class="srp-input-new" onchange="this.form.submit()">
						<option value="" >Sort By</option>
						<option value="1" <cfif url.sortblock eq "1">selected</cfif>>Sort By Make,Model</option>
						<option value="2" <cfif url.sortblock eq "2">selected</cfif>>Sort By Price (low to high)</option>
						<option value="3" <cfif url.sortblock eq "3">selected</cfif>>Sort By Price (high to low)</option>
						<cfif url.new_used neq "N" and url.new_used neq "A"><option value="4" <cfif url.sortblock eq "4">selected</cfif>>Sort By Mileage (low to high)</option></cfif>
						<cfif url.new_used neq "N" and url.new_used neq "A"><option value="5" <cfif url.sortblock eq "5">selected</cfif>>Sort By Mileage (high to low)</option></cfif>
						<option value="6" <cfif url.sortblock eq "6">selected</cfif>>Sort By Year (low to high)</option>
						<option value="7" <cfif url.sortblock eq "7">selected</cfif>>Sort By Year (high to low)</option>
						<cfif len(trim(url.dealer_id)) gt 0><option value="8" <cfif url.sortblock eq "8">selected</cfif>>Sort By Stock Number</option></cfif>
						<cfif #url.dealer_id# eq 14>
						 <option value="9" <cfif url.sortblock eq "9">selected</cfif>>Show Luxury</option>
						 </cfif>
					</select>
				<!--- </div> --->
			<input type="hidden" name="script_content" value="#cgi.script_name#"/>
			<input type="hidden" name="body" value="#url.body#"/>
			<input type="hidden" name="zip" value="#url.zip#"/>
			<input type="hidden" name="radius" value="#url.radius#"/>
			<input type="hidden" name="maxprice" value="#url.maxprice#"/>
			<input type="hidden" name="minprice" value="#url.minprice#"/>
			<input type="hidden" name="old_year" value="#url.year#"/>
			<input type="hidden" name="old_make" value="#url.make#"/>
			<input type="hidden" name="classic" value="#url.classic#"/>
			<input type="hidden" name="geo" value="#url.geo#"/>

		</form>
		 

	</cffunction>
	
	<cffunction name="srp_legacy" description="srp search engine" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="form_id" default="srp_form"/>
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		
		<cfset Get_Years=arguments.Get_Years>
		<cfset Get_Makes=arguments.Get_Makes>
		<cfset Get_Models=arguments.Get_Models>
		<cfset Get_Dealers=arguments.Get_Dealers>
		
		<cfif IsDefined("url.geo") and ( #url.geo# NEQ "" and #url.geo#  NEQ 0 ) >  <!--- Regional Search 12/13/2014--->
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		<!-- srp engine -->
		<form id="#arguments.form_id#" name="#arguments.form_id#" action="#arguments.srp_action#" method="post">
			<div class="row srp-form">
				<table width="100%" cellpadding="0">
					<tr>
						<td>
							<select name="new_used" class="srp-input" onchange="this.form.submit()">
								<!---<option value="B" <cfif url.new_used eq "B">selected</cfif>>All Vehicles</option>--->
								<option value="N" <cfif url.new_used eq "N">selected</cfif>>New Vehicles</option>
								<option value="U" <cfif url.new_used eq "U">selected</cfif>>Used Vehicles</option>
								<option value="C" <cfif url.new_used eq "C">selected</cfif>>Certified Vehicles</option>
							</select>							
						</td>
						<td>
							<select name="make" class="srp-input" onchange="this.form.submit()">
								<option value="">Select A Make</option>
								<cfloop query="Get_Makes">
									<option value="#Get_Makes.V_Make#" <cfif url.make eq Get_Makes.V_Make>selected</cfif>>#Get_Makes.V_Make#</option>	
								</cfloop>
							</select>
						</td>
						<td>
							<cfif len(trim(url.make)) gt 0>
								<select name="model" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Model</option>
									<cfloop query="Get_Models">
										<cfset variables.this_model=replace(Get_Models.V_Model,"&","%26","all" )>
										<cfset variables.this_model=replace(variables.this_model," ","%20","all" )>
										<option value="#variables.this_model#" <cfif url.model eq Get_Models.V_Model>selected</cfif>>#Get_Models.V_Model#</option>	
									</cfloop>
								</select>
							<cfelse>
								<select name="model" class="srp-input" disabled="true">
									<option value="">Select A Model</option>
								</select>
							</cfif>
						</td>
						<td>
							<select name="year" class="srp-input" onchange="this.form.submit()">
								<option value="">Select A Year</option>
								<cfloop query="Get_Years">
									<option value="#Get_Years.V_Year#" <cfif url.year eq Get_Years.V_Year>selected</cfif>>#Get_Years.V_Year#</option>	
								</cfloop>
							</select>
						</td>
						<td>
							<select name="sortblock" class="srp-input" onchange="this.form.submit()">
								<option value="">Sort By</option>
								<option value="1" <cfif url.sortblock eq "1">selected</cfif>>Sort By Make,Model</option>
								<option value="2" <cfif url.sortblock eq "2">selected</cfif>>Sort By Price (low to high)</option>
								<option value="3" <cfif url.sortblock eq "3">selected</cfif>>Sort By Price (high to low)</option>
								<cfif url.new_used neq "N"><option value="4" <cfif url.sortblock eq "4">selected</cfif>>Sort By Mileage (low to high)</option></cfif>
								<cfif url.new_used neq "N"><option value="5" <cfif url.sortblock eq "5">selected</cfif>>Sort By Mileage (high to low)</option></cfif>
								<option value="6" <cfif url.sortblock eq "6">selected</cfif>>Sort By Year (low to high)</option>
								<option value="7" <cfif url.sortblock eq "7">selected</cfif>>Sort By Year (high to low)</option>
								<cfif len(trim(url.dealer_id)) gt 0><option value="8" <cfif url.sortblock eq "8">selected</cfif>>Sort By Stock Number</option></cfif>
								<!--- <option value="9" <cfif url.sortblock eq "9">selected</cfif>>Show Luxury</option>
								<option value="10" <cfif url.sortblock eq "10">selected</cfif>>Show Fleet</option>
								<option value="11" <cfif url.sortblock eq "11">selected</cfif>>Show Commercial</option> --->
							</select>
						</td>
						<td>
							<input class="srp-btn-search btn btn-default" type="button" value="Reset Search" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#&zip=#url.zip#&radius=#url.radius#&geo=#url.geo#'"/>							
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="body" value="#url.body#"/>
			<input type="hidden" name="zip" value="#url.zip#"/>
			<input type="hidden" name="radius" value="#url.radius#"/>
			<input type="hidden" name="maxprice" value="#url.maxprice#"/>
			<input type="hidden" name="minprice" value="#url.minprice#"/>
			<input type="hidden" name="old_year" value="#url.year#"/>
			<input type="hidden" name="old_make" value="#url.make#"/>
			<input type="hidden" name="geo" value="#url.geo#"/>

		</form>
	
	</cffunction>
		
</cfcomponent>