<cfcomponent>

	<cffunction name="srp" description="srp filters" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="Get_Bodies" required="true" />
		<cfargument name="Get_Drivetrains" required="true" />
		<cfargument name="Get_Transmissions" required="true" />
		<cfargument name="Get_Colors" required="true" />
		<cfargument name="Get_Regions" required="false" />
		<cfargument name="Get_Styles" required="false" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
        
		
		<cfif IsDefined("url.geo") and isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
			<cfset url.geo=0>
		</cfif>
		
        <cfparam name="url.style" default="">
        <cfset url.model = urlencodedformat(url.model)>
		<div class="row">
			<div class="col-md-12">
				<div align="center" class="srp-results">Search Results #numberformat(arguments.Recordcount)# </div>
				
				<div class="row">
					<div class="col-md-6">
						<div class="srp-filters">Cars Per Page</div>		
					</div>
					<div class="col-md-6 no-pad" style="padding-top:3px;">
						<cfif result_set eq 10>
							<span class="btn-srp-sel pull-left">10</span>
						<cfelse>
							<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=10&sortblock=#url.sortblock#&geo=#url.geo#&style=#url.style#">10</a>
						</cfif>
						<cfif result_set eq 30>
							<span class="btn-srp-sel pull-left">30</span>
						<cfelse>
							<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=30&sortblock=#url.sortblock#&geo=#url.geo#&style=#url.style#">30</a>
						</cfif>
						<cfif result_set eq 50>
							<span class="btn-srp-sel pull-left">50</span>
						<cfelse>
							<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=50&sortblock=#url.sortblock#&geo=#url.geo#&style=#url.style#">50</a>
						</cfif>
						<cfif result_set eq 100>
							<span class="btn-srp-sel pull-left">100</span>
						<cfelse>
							<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=100&sortblock=#url.sortblock#&geo=#url.geo#&style=#url.style#">100</a>
						</cfif>
					</div>
				</div>
				<div class="srp-filters">Search by Stock ##</div>
                <!-- stock search -->
				<form action="http://#cgi.server_name#/vehicles/stock_search.cfm" method="post">
					<input type="hidden" name="new_used" value="#url.new_used#">
					<div class="row">
						<div class="col-md-8">
							<input class="srp-input" type="text" name="stock" placeholder="Enter Stock ##"/>	
						</div>
						<div class="col-md-3">
							<input class="srp-btn-search btn btn-default" type="submit" value="Go"/>
						</div>
					</div>
				</form>
				<div class="srp-filters">Current Filters</div>
				<cfif url.new_used eq "B"><span class="btn-srp-sel pull-left">ALL VEHICLES</span></cfif>
				<cfif url.new_used eq "N"><span class="btn-srp-sel pull-left">NEW</span></cfif>
				<cfif url.new_used eq "U"><span class="btn-srp-sel pull-left">USED</span></cfif>
				<cfif url.new_used eq "C"><span class="btn-srp-sel pull-left">CERTIFIED</span></cfif>
				<cfif url.new_used eq "A"><span class="btn-srp-sel pull-left">COMMERCIAL</span></cfif>
                
				<cfif len(trim(url.dealer_id)) gt 0>
					<cfloop query="Get_Dealers">
						<cfif url.dealer_id eq Get_Dealers.Dealer_ID>
							<span class="btn-srp-sel pull-left">
								<cfswitch expression="#url.dealer_id#">
									<cfdefaultcase>
										#ucase(Get_Dealers.Dealer_Display_Name)#
									</cfdefaultcase>
									<cfcase value="25,28,51,7,57,27,160,200">   <!--- Honda Dealers --->
										#Get_Dealers.Dealer_Display_Name#
									</cfcase>
								</cfswitch>	
							</span>
							<cfbreak>                             
						</cfif>
					</cfloop>
				</cfif>
				<cfif len(trim(url.year)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.year)#</span></cfif>
				<cfif len(trim(url.make)) gt 0><cfset url.make = #reReplace(url.make,"(^[a-z])","\U\1","ALL")# ><span class="btn-srp-sel pull-left"> #url.make#</span></cfif>
				<cfif len(trim(url.model)) gt 0><span class="btn-srp-sel pull-left">#ucase(replace(urldecode(url.model),"FourRunner","4Runner","all"))#</span></cfif>
				<cfif len(trim(url.body)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.body)#</span></cfif>
				<cfif len(trim(url.drivetrain)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.drivetrain)#</span></cfif>
                <cfif len(trim(url.style)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.style)#</span></cfif>
				<cfif url.minprice neq -1><span class="btn-srp-sel pull-left">OVER $#LSParseNumber(url.minprice)#</span></cfif>
				<cfif url.maxprice neq 11000000  ><span class="btn-srp-sel pull-left">UNDER $#LSParseNumber(url.maxprice)#</span></cfif>
				<cfif url.fleet eq 1><span class="btn-srp-sel pull-left">FLEET</span></cfif>
				<cfif url.luxury eq 1><span class="btn-srp-sel pull-left">LUXURY</span></cfif> 
				<cfif url.geo>
					<cftry>
					<cfquery datasource="Ultra10" name="qRegion" result="r1">
					  SELECT Region_text
					  FROM ultra10.dbo.Dealer_Regions
					  where active =1 and Dealer_ID = #url.dealer_id# and ID = #url.geo# 
					</cfquery>
					<cfif qRegion.recordcount>
						<span class="btn-srp-sel pull-left">#ucase(qRegion.Region_text)#</span>
					</cfif>
					<cfcatch></cfcatch>
					</cftry>
				</cfif>
				<div class="clearfix"></div>
				<div class="srp-filters">Refine Your Search</div>
				<div class="panel-group" id="accordion">
					<cfif url.dealer_id eq 84>
						
					<cftry>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseGeo">
									Region
									<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
								</a>
							</div>
							<div id="collapseGeo" class="panel-collapse collapse<cfif not url.geo> in</cfif>">
								<div class="panel-body">
									<cfloop query="Get_Regions">
										<cfquery datasource="Ultra10" name="qRegionTxt" result="r1">
										  SELECT Region_text
										  FROM ultra10.dbo.Dealer_Regions
										  where active =1 and Dealer_ID = #url.dealer_id# and ID = #Get_Regions.Region_ID# 
										</cfquery>
										<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#Get_Regions.Region_ID#&style=#url.style#">#qRegionTxt.Region_text#</a>	
									</cfloop>
								</div>
							</div>
						</div>
					<cfcatch></cfcatch>
					</cftry>
					
					</cfif>
					
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseMake">
								Make
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseMake" class="panel-collapse collapse in">
							<div class="panel-body">
                                <cfif url.dealer_id eq 15 and url.new_used is 'n'>
                                <a class="btn-srp-filt pull-left" href="https://baierlchevy.worktrucksolutions.com">Chevrolet</a>
                                </cfif>
								<cfloop query="Get_Makes">
									<!---<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#Get_Makes.V_Make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#">#Get_Makes.V_Make#</a>--->	                                    
                                    <a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=&make=#Get_Makes.V_Make#&model=&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Makes.V_Make#</a>                                    
								</cfloop>
							</div>
						</div>
					</div>
					<cfif len(trim(url.make)) gt 0>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseModel">
									Model
									<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
								</a>
							</div>
							<div id="collapseModel" class="panel-collapse collapse">
								<div class="panel-body">
									<cfloop query="Get_Models">
										<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#urlencodedformat(Get_Models.V_Model)#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#replace(Get_Models.V_Model,"FourRunner","4Runner","all")#</a>	
									</cfloop>
								</div>
							</div>
						</div>
					</cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseYear">
								Year<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>	
							</a>
						</div>
						<div id="collapseYear" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Years">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#Get_Years.V_Year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Years.V_Year#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseBody">
								Body
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseBody" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Bodies">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#Get_Bodies.V_Type#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Bodies.V_Type#</a>	
								</cfloop>
							</div>
						</div>
					</div>
                    <cfif Get_Styles.recordcount>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseStyle">
								Style
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseStyle" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Styles">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#Get_Styles.V_Style#">#Get_Styles.V_Style#</a>	
								</cfloop>
							</div>
						</div>
					</div>
                    </cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseTransmission">
								Transmission
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseTransmission" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Transmissions">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#Get_Transmissions.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#">#Get_Transmissions.Transmission#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseDrivetrain">
								Drivetrain
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseDrivetrain" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Drivetrains">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#Get_Drivetrains.Drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#">#Get_Drivetrains.Drivetrain#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseColor">
								Color
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseColor" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Colors">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#Get_Colors.Exterior_Color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Colors.Exterior_Color#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapsePrice">
								Price Range
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapsePrice" class="panel-collapse collapse">
							<div class="panel-body">
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=10000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">Under $10,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=20000&minprice=10000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$10,000-$20,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=30000&minprice=20000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$20,000-$30,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=50000&minprice=30000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$30,000-$50,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=75000&minprice=50000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$50,000-$75,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&minprice=75000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">Over $75,000</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</cffunction>


	<cffunction name="srp_new" description="Alternate 1 srp filters" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="Get_Bodies" required="true" />
		<cfargument name="Get_Drivetrains" required="true" />
		<cfargument name="Get_Transmissions" required="true" />
		<cfargument name="Get_Colors" required="true" />
		<cfargument name="Get_Regions" required="false" />
		<cfargument name="Get_Styles" required="false" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
        
		<cfset a_condition = ArrayNew(1) >
		<cfset a_condition[1] = "New Cars" >
		<cfset a_pass_condition[1] = "N" >
		<cfset a_condition[2] = "Used Cars" >
		<cfset a_pass_condition[2] = "U" >
		<cfset a_condition[3] = "Certified Cars" >
		<cfset a_pass_condition[3] = "C" >
		
		
		
        <cfparam name="url.style" default="">
		<div class="row">
			<div class="col-md-12">
				<div align="center" class="srp-results-new">
					Current Results: #numberformat(arguments.Recordcount)# 
				</div>
				
				<div style="margin-right:10px;width:40%!important">
					<input type="button" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=N'" value="Clear" class="srp-btn-search btn btn-default">	
				</div>
				
				<div class="srp-filters-new">Search by Stock ##</div>
				<form action="http://#cgi.server_name#/vehicles/stock_search.cfm" method="post">
					<input type="hidden" name="new_used" value="#url.new_used#">
					<div class="row">
						<div class="col-md-7">
							<input class="srp-input" type="text" name="stock" placeholder="Enter Stock ##"/>	
						</div>
						<div class="col-md-4 pull-left">
							<input class="srp-btn-search btn btn-default" type="submit" value="Go"/>
						</div>
					</div>
				</form>
				<div class="srp-filters-new">Current Filters</div>
				<cfif url.new_used eq "B"><span class="btn-srp-sel-new pull-left">ALL VEHICLES</span></cfif>
				<cfif url.new_used eq "N"><span class="btn-srp-sel-new pull-left">NEW&nbsp;</span></cfif>
				<cfif url.new_used eq "U"><span class="btn-srp-sel-new pull-left">USED&nbsp;</span></cfif>
				<cfif url.new_used eq "C"><span class="btn-srp-sel-new pull-left">CERTIFIED&nbsp;</span></cfif>
				<cfif url.new_used eq "A"><span class="btn-srp-sel-new pull-left">COMMERCIAL&nbsp;</span></cfif>
				<cfif len(trim(url.year)) gt 0><span class="btn-srp-sel-new pull-left">#ucase(url.year)#</span></cfif>
				<cfif len(trim(url.make)) gt 0><cfset url.make = #reReplace(url.make,"(^[a-z])","\U\1","ALL")# ><span class="btn-srp-sel-new pull-left"> #url.make#&nbsp;</span></cfif>
				<cfif len(trim(url.model)) gt 0><span class="btn-srp-sel-new pull-left">#ucase(replace(url.model,"FourRunner","4Runner","all"))#</span></cfif>
				<cfif len(trim(url.body)) gt 0><span class="btn-srp-sel-new pull-left">#ucase(url.body)#</span></cfif>
				<cfif len(trim(url.drivetrain)) gt 0><span class="btn-srp-sel-new pull-left">#ucase(url.drivetrain)#</span></cfif>
                <cfif len(trim(url.style)) gt 0><span class="btn-srp-sel-new pull-left">#ucase(url.style)#</span></cfif>
				<cfif url.minprice neq -1><span class="btn-srp-sel-new pull-left">OVER $#LSParseNumber(url.minprice)#</span></cfif>
				<cfif url.maxprice neq 11000000  ><span class="btn-srp-sel-new pull-left">UNDER $#LSParseNumber(url.maxprice)#</span></cfif>
				<cfif url.fleet eq 1><span class="btn-srp-sel-new pull-left">FLEET</span></cfif>
				<cfif url.luxury eq 1><span class="btn-srp-sel-new pull-left">LUXURY</span></cfif> 
				
				<div class="clearfix"></div>
				<div class="srp-filters-new">Refine Your Search</div>
				<div class="panel-group" id="accordion">
				
				  <div class="panel panel-default">
					<div class="panel-heading">
						<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseCondition">
							Condition
							<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
						</a>
					</div>
					<div id="collapseCondition" class="panel-collapse collapse">
						<div class="panel-body">
							<cfloop index="c" from="1" to="3">
							<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#a_pass_condition[c]#&year=#url.year#&make=&model=&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#a_condition[c]#</a>	
							</cfloop>
						</div>
					</div>
				</div>   
				
				<div class="panel panel-default">
					<div class="panel-heading">
						<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseMake">
							Make
							<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
						</a>
					</div>
					<div id="collapseMake" class="panel-collapse collapse in">
						<div class="panel-body">
                        	<cfif url.dealer_id eq 15 and url.new_used is 'n'>
	                        	<a class="btn-srp-filt-new pull-left" href="https://baierlchevy.worktrucksolutions.com">Chevrolet</a>
                           	</cfif>
							<cfloop query="Get_Makes">
                            	<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=&make=#Get_Makes.V_Make#&model=&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Makes.V_Make#</a>                                    
							</cfloop>
						</div>
					</div>
				</div>
				
					<cfif len(trim(url.make)) gt 0>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseModel">
									Model
									<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
								</a>
							</div>
							<div id="collapseModel" class="panel-collapse collapse">
								<div class="panel-body">
									<cfloop query="Get_Models">
										<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#Get_Models.V_Model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#replace(Get_Models.V_Model,"FourRunner","4Runner","all")#</a>	
									</cfloop>
								</div>
							</div>
						</div>
					</cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseYear">
								Year<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>	
							</a>
						</div>
						<div id="collapseYear" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Years">
									<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#Get_Years.V_Year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Years.V_Year#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseBody">
								Body
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseBody" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Bodies">
									<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#Get_Bodies.V_Type#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Bodies.V_Type#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseTransmission">
								Transmission
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseTransmission" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Transmissions">
									<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#Get_Transmissions.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#">#Get_Transmissions.Transmission#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseDrivetrain">
								Drivetrain
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseDrivetrain" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Drivetrains">
									<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#Get_Drivetrains.Drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#">#Get_Drivetrains.Drivetrain#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseColor">
								Color
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseColor" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Colors">
									<a class="btn-srp-filt-new pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#Get_Colors.Exterior_Color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">#Get_Colors.Exterior_Color#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapsePrice">
								Price Range
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapsePrice" class="panel-collapse collapse">
							<div class="panel-body">
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=10000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">Under $10,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=20000&minprice=10000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$10,000-$20,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=30000&minprice=20000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$20,000-$30,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=50000&minprice=30000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$30,000-$50,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=75000&minprice=50000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">$50,000-$75,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&minprice=75000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#">Over $75,000</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</cffunction>

	

	<cffunction name="srp_new_v2" description="Alternate 1 srp filters Checkbox Version" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="Get_Bodies" required="true" />
		<cfargument name="Get_Drivetrains" required="true" />
		<cfargument name="Get_Transmissions" required="true" />
		<cfargument name="Get_Colors" required="true" />
		<cfargument name="Get_Interior_Colors" required="true" />
		<cfargument name="Get_Regions" required="false" />
		<cfargument name="Get_Styles" required="false" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
        
        <cfparam name="url.style" default="">
        <cfparam name="url.interiorcolor" default="">
		
		<cfset a_condition = ArrayNew(1) >
		<cfset a_pass_condition = ArrayNew(1) >
		<cfset a_condition[1] = "New Cars" >
		<cfset a_pass_condition[1] = "N" >
		<cfset a_condition[2] = "Used Cars" >
		<cfset a_pass_condition[2] = "U" >
		<cfset a_condition[3] = "Certified Cars" >
		<cfset a_pass_condition[3] = "C" >
		
		
		<cfset stack = "in" >
		<cfset state = "1" >
		<cfset glypher = "" >	<!--- glyphicon-chevron-down --->
		
		<!--- <cfquery datasource="ultra10" name="Get_Assigned_OEMs">
			SELECT			OEMs.OEM_Name,Join_Dealer_OEM.OEM_ID AS OID,
							Join_Dealer_OEM.Dealer_OEM_ID
			FROM			OEMs
			INNER JOIN		Join_Dealer_OEM
			ON				OEMs.OEM_ID = Join_Dealer_OEM.OEM_ID
			WHERE     		Join_Dealer_OEM.Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="5">
		</cfquery>
		<cfif #Get_Assigned_OEMs.recordcount# NEQ 0 AND ( Not IsDefined("url.make") OR #url.make# EQ "" ) ><cfset url.make = "#Get_Assigned_OEMs.OEM_Name#"></cfif>--->
		<cfif #url.dealer_id# EQ 365 and #url.new_used# EQ "N" ><cfset url.make = "Nissan"></cfif> 
		<div class="row">
			<div class="col-md-12">
				<div align="center" class="srp-results-new">
					<span style="font-size:16px!important">Current Results: #numberformat(arguments.Recordcount)#</span>
				</div>
				
				<div style="margin-right:10px;">
					<input type="button" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=N'" value="Clear" class="srp-btn-search btn btn-default">	
				</div>
				
				<div class="srp-filters-new">Search by Stock ##</div>
				<form action="http://#cgi.server_name#/vehicles/stock_search.cfm" method="post">
					<input type="hidden" name="new_used" value="#url.new_used#">
					<div class="row">
						<div class="col-md-9">
							<input class="srp-input" type="text" name="stock" placeholder="Enter Stock ##"/>	
						</div>
						<div class="col-md-3 pull-left" align="left"  >
							<input class="btn btn-default srp-btn-search-new " type="submit" value="Go"/>
						</div>
					</div>
				</form>
				<div class="srp-filters-new">Search by VIN</div>
				<form action="http://#cgi.server_name#/vehicles/vin_search.cfm" method="post">
					<input type="hidden" name="new_used" value="#url.new_used#">
					<div class="row">
						<div class="col-md-9">
							<input class="srp-input" type="text" name="vin" placeholder="Enter VIN"/>	
						</div>
						<div class="col-md-3 pull-left" align="left"  >
							<input class="btn btn-default srp-btn-search-new " type="submit" value="Go"/>
						</div>
					</div>
				</form>
				<div class="clearfix"></div>
				<div class="srp-filters-new">Refine Your Search</div>
				<div class="panel-group" id="accordion">
				
				  <div class="panel panel-default">
					<div class="panel-heading">
						<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseCondition"> </cfif>
							<span style="font-size:16px!important">Condition</span>
							<span class="glyphicon #glypher# pull-right"></span>
						</a>
					</div>
					<div id="collapseCondition" class="panel-collapse collapse #stack#">
						<div class="panel-body">
							<cfloop index="c" from="1" to="3">
							<input type="checkbox" <cfif #url.new_used# EQ #a_pass_condition[c]# >checked</cfif>  name="new_used_#c#" class="btn-srp-filt-new-v2 pull-left" 
							onclick="javascript:location.href='#arguments.srp_action#?&new_used=#a_pass_condition[c]#'">&nbsp;#a_condition[c]#<br>
							<br>
							</cfloop>
						</div>
					</div>
				</div>
				
				<div class="panel panel-default">
					<div class="panel-heading">
						<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseMake"></cfif>
							<span style="font-size:16px!important">Make
							<span class="glyphicon #glypher# pull-right"></span>
						</a>
					</div>
					<div id="collapseMake" class="panel-collapse collapse #stack#">
						<div class="panel-body">
							<cfloop query="Get_Makes">
                            	<input type="checkbox" <cfif #url.make# EQ #Get_Makes.v_make# >checked</cfif>  name="make_#Get_Makes.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=&make=#Get_Makes.V_Make#&model=&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&interiorcolor=#url.interiorcolor#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Makes.V_Make#<br>
								<br>
							</cfloop>
						</div>
					</div>
				</div>
				
					<cfif len(trim(url.make)) gt 0>
						<div class="panel panel-default">
							<div class="panel-heading">
								<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseModel"></cfif>
									<span style="font-size:16px!important">Model
									<span class="glyphicon #glypher# pull-right"></span>
								</a>
							</div>
							<div id="collapseModel" class="panel-collapse collapse #stack# <cfif #url.model# NEQ "" >in</cfif> " >
								<div class="panel-body">
									<cfloop query="Get_Models">
										<input type="checkbox" <cfif #url.model# EQ #Get_Models.v_model# >checked</cfif>  name="model_#get_models.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#Get_Models.V_Model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#replace(Get_Models.V_Model,"FourRunner","4Runner","all")#<br>
										<br>
									</cfloop>
								</div>
							</div>
						</div>
					</cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseYear"></cfif>
								<span style="font-size:16px!important">Year</span>
								<span class="glyphicon #glypher# pull-right"></span>	
							</a>
						</div>
						<div id="collapseYear" class="panel-collapse collapse #stack#<cfif #url.year# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Years">
									<input type="checkbox" <cfif #url.year# EQ #Get_Years.v_year# >checked</cfif>  name="year_#get_years.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#Get_Years.V_Year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Years.V_Year#<br>	
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseBody"></cfif>
								<span style="font-size:16px!important">Body</span>
								<span class="glyphicon #glypher# pull-right"></span>
							</a>
						</div>
						<div id="collapseBody" class="panel-collapse collapse #stack#<cfif #url.body# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Bodies">
									<input type="checkbox" <cfif #url.body# EQ #Get_Bodies.V_Type# >checked</cfif>  name="body_#Get_Bodies.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#Get_Bodies.V_Type#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Bodies.V_Type#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseTransmission"></cfif>
								<span style="font-size:16px!important">Transmission</span>
								<span class="glyphicon #glypher# pull-right"></span>
							</a>
						</div>
						<div id="collapseTransmission" class="panel-collapse collapse #stack#<cfif #url.transmission# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Transmissions">
									<input type="checkbox" <cfif #url.transmission# EQ #Get_Transmissions.transmission# >checked</cfif>  name="transmission_#get_models.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#Get_Transmissions.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&interiorcolor=#url.interiorcolor#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Transmissions.Transmission#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseDrivetrain"></cfif>
								<span style="font-size:16px!important">Drivetrain</span>
								<span class="glyphicon #glypher# pull-right"></span>
							</a>
						</div>
						<div id="collapseDrivetrain" class="panel-collapse collapse #stack#<cfif #url.drivetrain# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Drivetrains">
									<input type="checkbox" <cfif #url.Drivetrain# EQ #Get_Drivetrains.Drivetrain# >checked</cfif>  name="Drivetrain_#Get_Drivetrains.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#Get_Drivetrains.Drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&interiorcolor=#url.interiorcolor#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Drivetrains.Drivetrain#<br>	
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseColor"></cfif>
								<span style="font-size:16px!important">Exterior Color</span>
								<span class="glyphicon #glypher# pull-right"></span>
							</a>
						</div>
						<div id="collapseColor" class="panel-collapse collapse #stack#<cfif #url.color# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Colors">
									<input type="checkbox" <cfif #url.color# EQ #Get_Colors.Exterior_Color# >checked</cfif>  name="color_#Get_Colors.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#Get_Colors.Exterior_Color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Colors.Exterior_Color#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseInteriorColor"></cfif>
								<span style="font-size:16px!important">Interior Color</span>
								<span class="glyphicon #glypher# pull-right"></span>
							</a>
						</div>
						<div id="collapseInteriorColor" class="panel-collapse collapse #stack#<cfif #url.color# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Interior_Colors">
									<input type="checkbox" <cfif #url.interiorcolor# EQ #Get_Interior_Colors.Interior_Color# >checked</cfif> 
									 name="Interior_color_#Get_Colors.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&interiorcolor=#Get_Interior_Colors.Interior_Color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Interior_Colors.Interior_Color#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<cfif #state# EQ 0 ><a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapsePrice"></cfif>
								<span style="font-size:16px!important">Price Range</span>
								<span class="glyphicon #glypher# pull-right"></span>
							</a>
						</div>
						<div id="collapsePrice" class="panel-collapse collapse #stack# ">
							<div class="panel-body">
								<input type="checkbox" <cfif #url.maxprice# EQ "10000" >checked</cfif>  name="max_1" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=10000&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;Under $10,000<br>
								<br><input type="checkbox" <cfif #url.maxprice# LTE "20000"  AND #url.minprice# GTE "10000">checked</cfif>  name="max_2" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=20000&minprice=10000&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$10,000-$20,000<br>
								<br><input type="checkbox" <cfif #url.maxprice# LTE "30000" AND #url.minprice# GTE "20000" >checked</cfif>  name="max_3" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=30000&minprice=20000&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$20,000-$30,000<br>
								<br><input type="checkbox" <cfif #url.maxprice# LTE "50000" AND #url.minprice# GTE "30000" >checked</cfif>  name="max_4" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=50000&minprice=30000&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$30,000-$50,000<br>
								<br><input type="checkbox" <cfif #url.maxprice# LTE "75000" AND #url.minprice# GTE "50000" >checked</cfif>  name="max_5" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=75000&minprice=50000&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$50,000-$75,000<br>
								<br><input type="checkbox" <cfif #url.minprice# GTE "75000" >checked</cfif>  name="max_6" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&minprice=75000&classic=#url.classic#&result_set=#url.result_set#&interiorcolor=#url.interiorcolor#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;Over $75,000<br>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</cffunction>


	<cffunction name="srp_new_v3" description="Alternate 1 srp filters Checkbox / MULTI-SELECT Version" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="Get_Bodies" required="true" />
		<cfargument name="Get_Drivetrains" required="true" />
		<cfargument name="Get_Transmissions" required="true" />
		<cfargument name="Get_Colors" required="true" />
		<cfargument name="Get_Regions" required="false" />
		<cfargument name="Get_Styles" required="false" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
        
        <cfparam name="url.style" default="">
		
		
		<cfquery datasource="ultra10" name="Get_Assigned_OEMs">
			SELECT			OEMs.OEM_Name,Join_Dealer_OEM.OEM_ID AS OID,
							Join_Dealer_OEM.Dealer_OEM_ID
			FROM			OEMs
			INNER JOIN		Join_Dealer_OEM
			ON				OEMs.OEM_ID = Join_Dealer_OEM.OEM_ID
			WHERE     		Join_Dealer_OEM.Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="5">
		</cfquery>
		<cfif #Get_Assigned_OEMs.recordcount# NEQ 0 AND ( Not IsDefined("url.make") OR #url.make# EQ "" ) ><cfset url.make = "#Get_Assigned_OEMs.OEM_Name#"></cfif>
		
		<div class="row">
			<div class="col-md-12">
				<div align="center" class="srp-results-new">
					Current Results: #numberformat(arguments.Recordcount)#
				</div>
				
				<div style="margin-right:10px;">
					<input type="button" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=N'" value="Clear" class="srp-btn-search btn btn-default">	
				</div>
				
				<div class="srp-filters-new">Search by Stock ##</div>
				<form action="http://#cgi.server_name#/vehicles/stock_search.cfm" method="post">
					<input type="hidden" name="new_used" value="#url.new_used#">
					<div class="row">
						<div class="col-md-9">
							<input class="srp-input" type="text" name="stock" placeholder="Enter Stock ##"/>	
						</div>
						<div class="col-md-3 pull-left" align="left"  >
							<input class="btn btn-default srp-btn-search-new " type="submit" value="Go"/>
						</div>
					</div>
				</form>
				<div class="srp-filters-new">Search by VIN</div>
				<form action="http://#cgi.server_name#/vehicles/vin_search.cfm" method="post">
					<input type="hidden" name="new_used" value="#url.new_used#">
					<div class="row">
						<div class="col-md-9">
							<input class="srp-input" type="text" name="vin" placeholder="Enter VIN"/>	
						</div>
						<div class="col-md-3 pull-left" align="left"  >
							<input class="btn btn-default srp-btn-search-new " type="submit" value="Go"/>
						</div>
					</div>
				</form>
				<div class="clearfix"></div>
				<div class="srp-filters-new">Refine Your Search</div>
				<div class="panel-group" id="accordion">
				<div class="panel panel-default">
					<div class="panel-heading">
						<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseMake">
							Make
							<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
						</a>
					</div>
					<div id="collapseMake" class="panel-collapse collapse in">
						<div class="panel-body">
							<cfloop query="Get_Makes">
                            	<input type="checkbox" <cfif #url.make# EQ #Get_Makes.v_make# >checked</cfif>  name="make_#Get_Makes.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=&make=#Get_Makes.V_Make#&model=&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Makes.V_Make#<br>
								<br>
							</cfloop>
						</div>
					</div>
				</div>
				
					<cfif len(trim(url.make)) gt 0>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseModel">
									Model
									<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
								</a>
							</div>
							<div id="collapseModel" class="panel-collapse collapse <cfif #url.model# NEQ "" >in</cfif> " >
								<div class="panel-body">
									<cfloop query="Get_Models">
										<input type="checkbox" <cfif (#url.model# EQ #Get_Models.v_model#) >checked</cfif>  name="model_#get_models.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#Get_Models.V_Model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#replace(Get_Models.V_Model,"FourRunner","4Runner","all")#<br>
										<br>
									</cfloop>
								</div>
							</div>
						</div>
					</cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseYear">
								Year<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>	
							</a>
						</div>
						<div id="collapseYear" class="panel-collapse collapse <cfif #url.year# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Years">
									<input type="checkbox" <cfif #url.year# EQ #Get_Years.v_year# >checked</cfif>  name="year_#get_years.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#Get_Years.V_Year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Years.V_Year#<br>	
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseBody">
								Body
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseBody" class="panel-collapse collapse <cfif #url.body# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Bodies">
									<input type="checkbox" <cfif #url.body# EQ #Get_Bodies.V_Type# >checked</cfif>  name="body_#Get_Bodies.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#Get_Bodies.V_Type#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Bodies.V_Type#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseTransmission">
								Transmission
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseTransmission" class="panel-collapse collapse <cfif #url.transmission# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Transmissions">
									<input type="checkbox" <cfif #url.transmission# EQ #Get_Transmissions.transmission# >checked</cfif>  name="transmission_#get_models.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#Get_Transmissions.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Transmissions.Transmission#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseDrivetrain">
								Drivetrain
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseDrivetrain" class="panel-collapse collapse <cfif #url.drivetrain# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Drivetrains">
									<input type="checkbox" <cfif #url.Drivetrain# EQ #Get_Drivetrains.Drivetrain# >checked</cfif>  name="Drivetrain_#Get_Drivetrains.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#Get_Drivetrains.Drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Drivetrains.Drivetrain#<br>	
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseColor">
								Color
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseColor" class="panel-collapse collapse <cfif #url.color# NEQ "" >in</cfif> ">
							<div class="panel-body">
								<cfloop query="Get_Colors">
									<input type="checkbox" <cfif #url.color# EQ #Get_Colors.Exterior_Color# >checked</cfif>  name="color_#Get_Colors.currentrow#" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#Get_Colors.Exterior_Color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;#Get_Colors.Exterior_Color#<br>
									<br>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapsePrice">
								Price Range
								<span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif> class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapsePrice" class="panel-collapse collapse ">
							<div class="panel-body">
								<input type="checkbox" <cfif #url.maxprice# EQ "10000" >checked</cfif>  name="max_1" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=10000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;Under $10,000<br>
								<input type="checkbox" <cfif #url.maxprice# LTE "20000"  AND #url.minprice# GTE "10000">checked</cfif>  name="max_2" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=20000&minprice=10000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$10,000-$20,000<br>
								<input type="checkbox" <cfif #url.maxprice# LTE "30000" AND #url.minprice# GTE "20000" >checked</cfif>  name="max_3" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=30000&minprice=20000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$20,000-$30,000<br>
								<input type="checkbox" <cfif #url.maxprice# LTE "50000" AND #url.minprice# GTE "30000" >checked</cfif>  name="max_4" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=50000&minprice=30000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$30,000-$50,000<br>
								<input type="checkbox" <cfif #url.maxprice# LTE "75000" AND #url.minprice# GTE "50000" >checked</cfif>  name="max_5" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=75000&minprice=50000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;$50,000-$75,000<br>
								<input type="checkbox" <cfif #url.minprice# GTE "75000" >checked</cfif>  name="max_6" class="btn-srp-filt-new-v2 pull-left" onclick="javascript:location.href='#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&minprice=75000&classic=#url.classic#&result_set=#url.result_set#&geo=#url.geo#&sortblock=#url.sortblock#&style=#url.style#'">&nbsp;Over $75,000<br>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</cffunction>

	
	
	
	
	
	<cffunction name="srp_legacy" description="srp filters" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="Get_Years" required="true" />
		<cfargument name="Get_Makes" required="true" />
		<cfargument name="Get_Models" required="true" />
		<cfargument name="Get_Dealers" required="true" />
		<cfargument name="Get_Bodies" required="true" />
		<cfargument name="Get_Drivetrains" required="true" />
		<cfargument name="Get_Transmissions" required="true" />
		<cfargument name="Get_Colors" required="true" />

		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>

		<div class="row">
			<div class="col-md-12">
				<div align="center" class="srp-results">Search Results #numberformat(arguments.Recordcount)#</div>
				<div class="srp-filters">Cars Per Page</div>		
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center">
							<cfif result_set eq 10>
								<span class="btn-srp-sel pull-left">10</span>
							<cfelse>
								<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=10&sortblock=#url.sortblock#">10</a>
							</cfif>
						</td>
						<td align="center">
							<cfif result_set eq 30>
								<span class="btn-srp-sel pull-left">30</span>
							<cfelse>
								<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=30&sortblock=#url.sortblock#">30</a>
							</cfif>
						</td>
						<td align="center">
							<cfif result_set eq 50>
								<span class="btn-srp-sel pull-left">50</span>
							<cfelse>
								<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=50&sortblock=#url.sortblock#">50</a>
							</cfif>
						</td>
						<td align="center">
							<cfif result_set eq 100>
								<span class="btn-srp-sel pull-left">100</span>
							<cfelse>
								<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#&classic=#url.classic#&result_set=100&sortblock=#url.sortblock#">100</a>
							</cfif>
						</td>
					</tr>
				</table>
				<div class="srp-filters">Search by Stock ##</div>
				<form action="http://#cgi.server_name#/vehicles/stock_search.cfm" method="post">
					<table style="width:100%" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><input class="srp-input" type="text" name="stock" placeholder="Enter Stock ##"/></td>
							<td align="center"><input class="srp-btn-search btn btn-default" type="submit" value="Go"/></td>
						</tr>
					</table>
				</form>
				<div class="srp-filters">Current Filters</div>
				<cfif url.new_used eq "B"><span class="btn-srp-sel pull-left">ALL VEHICLES</span></cfif>
				<cfif url.new_used eq "N"><span class="btn-srp-sel pull-left">NEW</span></cfif>
				<cfif url.new_used eq "U"><span class="btn-srp-sel pull-left">USED</span></cfif>
				<cfif url.new_used eq "C"><span class="btn-srp-sel pull-left">CERTIFIED</span></cfif>
				<cfif len(trim(url.dealer_id)) gt 0>
					<cfloop query="Get_Dealers">
						<cfif url.dealer_id eq Get_Dealers.Dealer_ID>
							<span class="btn-srp-sel pull-left">
								<cfswitch expression="#url.dealer_id#">
									<cfdefaultcase>
										#ucase(Get_Dealers.Dealer_Display_Name)#
									</cfdefaultcase>
									<cfcase value="25,28,51,7,57,27,160,200">    <!--- Honda Dealers --->
										#Get_Dealers.Dealer_Display_Name#
									</cfcase>
								</cfswitch>	
							</span>
							<cfbreak>
						</cfif>
					</cfloop>
				</cfif>
				<cfif len(trim(url.year)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.year)#</span></cfif>
				<cfif len(trim(url.make)) gt 0><cfset url.make = #reReplace(url.make,"(^[a-z])","\U\1","ALL")# ><span class="btn-srp-sel pull-left"> #url.make#</span></cfif>
				<cfif len(trim(url.model)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.model)#</span></cfif>
				<cfif len(trim(url.body)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.body)#</span></cfif>
				<cfif len(trim(url.drivetrain)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.drivetrain)#</span></cfif>
				<cfif url.minprice neq -1><span class="btn-srp-sel pull-left">OVER $#numberformat(url.minprice)#</span></cfif>
				<cfif url.maxprice neq 11000000><span class="btn-srp-sel pull-left">UNDER $#numberformat(url.maxprice)#</span></cfif>
				<cfif url.fleet eq 1><span class="btn-srp-sel pull-left">FLEET</span></cfif>
				<cfif url.luxury eq 1><span class="btn-srp-sel pull-left">LUXURY</span></cfif>
				<div class="clearfix"></div>
				<div class="srp-filters">Refine Your Search</div>
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:0px 0px 3px 0px">Make</h4>
						</div>
						<div>
							<form action="#arguments.srp_action#" method="post">
								<select name="make" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Make</option>
									<cfloop query="Get_Makes">
										<option value="#Get_Makes.V_Make#" <cfif Get_Makes.V_Make eq url.make>selected="selected"</cfif>>#Get_Makes.V_Make#</option>
									</cfloop>
								</select>
								<input type="hidden" name="new_used" value="#url.new_used#"/>
								<input type="hidden" name="year" value="#url.year#"/>
								<input type="hidden" name="model" value="#url.model#"/>
								<input type="hidden" name="drivetrain" value="#url.drivetrain#"/>
								<input type="hidden" name="transmission" value="#url.transmission#"/>
								<input type="hidden" name="color" value="#url.color#"/>
								<input type="hidden" name="body" value="#url.body#"/>
								<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
								<input type="hidden" name="zip" value="#url.zip#"/>
								<input type="hidden" name="radius" value="#url.radius#"/>
								<input type="hidden" name="maxprice" value="#url.maxprice#"/>
								<input type="hidden" name="minprice" value="#url.minprice#"/>
								<input type="hidden" name="old_year" value="#url.year#"/>
								<input type="hidden" name="old_make" value="#url.make#"/>
								<input type="hidden" name="sortblock" value="#url.sortblock#"/>
								<input type="hidden" name="result_set" value="#url.result_set#"/>
								<input type="hidden" name="geo" value="#url.geo#"/>
							</form>
						</div>
					</div>
					<cfif len(trim(url.make)) gt 0>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 style="padding:0px;margin:3px 0px 3px 0px">Model</h4>
							</div>
							<div>
								<form action="#arguments.srp_action#" method="post">
									<select name="model" class="srp-input" onchange="this.form.submit()">
										<option value="">Select A Model</option>
										<cfloop query="Get_Models">
											<option value="#Get_Models.V_Model#" <cfif Get_Models.V_Model eq url.model>selected="selected"</cfif>>#Get_Models.V_Model#</option>
										</cfloop>
									</select>
									<input type="hidden" name="new_used" value="#url.new_used#"/>
									<input type="hidden" name="year" value="#url.year#"/>
									<input type="hidden" name="make" value="#url.make#"/>
									<input type="hidden" name="drivetrain" value="#url.drivetrain#"/>
									<input type="hidden" name="transmission" value="#url.transmission#"/>
									<input type="hidden" name="color" value="#url.color#"/>
									<input type="hidden" name="body" value="#url.body#"/>
									<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
									<input type="hidden" name="zip" value="#url.zip#"/>
									<input type="hidden" name="radius" value="#url.radius#"/>
									<input type="hidden" name="maxprice" value="#url.maxprice#"/>
									<input type="hidden" name="minprice" value="#url.minprice#"/>
									<input type="hidden" name="old_year" value="#url.year#"/>
									<input type="hidden" name="old_make" value="#url.make#"/>
									<input type="hidden" name="sortblock" value="#url.sortblock#"/>
									<input type="hidden" name="geo" value="#url.geo#"/>
									<input type="hidden" name="result_set" value="#url.result_set#"/>
								</form>
							</div>
						</div>
					</cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:3px 0px 3px 0px">Year</h4>
						</div>
						<div>
							<form action="#arguments.srp_action#" method="post">
								<select name="year" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Year</option>
									<cfloop query="Get_Years">
										<option value="#Get_Years.V_Year#" <cfif Get_Years.V_Year eq url.year>selected="selected"</cfif>>#Get_Years.V_Year#</option>
									</cfloop>
								</select>
								<input type="hidden" name="new_used" value="#url.new_used#"/>
								<input type="hidden" name="make" value="#url.make#"/>
								<input type="hidden" name="model" value="#url.model#"/>
								<input type="hidden" name="drivetrain" value="#url.drivetrain#"/>
								<input type="hidden" name="transmission" value="#url.transmission#"/>
								<input type="hidden" name="color" value="#url.color#"/>
								<input type="hidden" name="body" value="#url.body#"/>
								<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
								<input type="hidden" name="zip" value="#url.zip#"/>
								<input type="hidden" name="radius" value="#url.radius#"/>
								<input type="hidden" name="maxprice" value="#url.maxprice#"/>
								<input type="hidden" name="minprice" value="#url.minprice#"/>
								<input type="hidden" name="old_year" value="#url.year#"/>
								<input type="hidden" name="old_make" value="#url.make#"/>
								<input type="hidden" name="sortblock" value="#url.sortblock#"/>
								<input type="hidden" name="geo" value="#url.geo#"/>
								<input type="hidden" name="result_set" value="#url.result_set#"/>
							</form>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:3px 0px 3px 0px">Body</h4>
						</div>
						<div>
							<form action="#arguments.srp_action#" method="post">
								<select name="body" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Body</option>
									<cfloop query="Get_Bodies">
										<option value="#Get_Bodies.V_Type#" <cfif Get_Bodies.V_Type eq url.body>selected="selected"</cfif>>#Get_Bodies.V_Type#</option>
									</cfloop>
								</select>
								<input type="hidden" name="new_used" value="#url.new_used#"/>
								<input type="hidden" name="year" value="#url.year#"/>
								<input type="hidden" name="make" value="#url.make#"/>
								<input type="hidden" name="model" value="#url.model#"/>
								<input type="hidden" name="drivetrain" value="#url.drivetrain#"/>
								<input type="hidden" name="transmission" value="#url.transmission#"/>
								<input type="hidden" name="color" value="#url.color#"/>
								<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
								<input type="hidden" name="zip" value="#url.zip#"/>
								<input type="hidden" name="radius" value="#url.radius#"/>
								<input type="hidden" name="maxprice" value="#url.maxprice#"/>
								<input type="hidden" name="minprice" value="#url.minprice#"/>
								<input type="hidden" name="old_year" value="#url.year#"/>
								<input type="hidden" name="old_make" value="#url.make#"/>
								<input type="hidden" name="sortblock" value="#url.sortblock#"/>
								<input type="hidden" name="geo" value="#url.geo#"/>
								<input type="hidden" name="result_set" value="#url.result_set#"/>
							</form>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:3px 0px 3px 0px">Transmission</h4>
						</div>
						<div>
							<form action="#arguments.srp_action#" method="post">
								<select name="transmission" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Transmission</option>
									<cfloop query="Get_Transmissions">
										<option value="#Get_Transmissions.transmission#" <cfif Get_Transmissions.transmission eq url.transmission>selected="selected"</cfif>>#Get_Transmissions.transmission#</option>
									</cfloop>
								</select>
								<input type="hidden" name="new_used" value="#url.new_used#"/>
								<input type="hidden" name="year" value="#url.year#"/>
								<input type="hidden" name="make" value="#url.make#"/>
								<input type="hidden" name="model" value="#url.model#"/>
								<input type="hidden" name="drivetrain" value="#url.drivetrain#"/>
								<input type="hidden" name="body" value="#url.body#"/>
								<input type="hidden" name="color" value="#url.color#"/>
								<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
								<input type="hidden" name="zip" value="#url.zip#"/>
								<input type="hidden" name="radius" value="#url.radius#"/>
								<input type="hidden" name="maxprice" value="#url.maxprice#"/>
								<input type="hidden" name="minprice" value="#url.minprice#"/>
								<input type="hidden" name="old_year" value="#url.year#"/>
								<input type="hidden" name="old_make" value="#url.make#"/>
								<input type="hidden" name="sortblock" value="#url.sortblock#"/>
								<input type="hidden" name="geo" value="#url.geo#"/>
								<input type="hidden" name="result_set" value="#url.result_set#"/>
							</form>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:3px 0px 3px 0px">Drivetrain</h4>
						</div>
						<div>
							<form action="#arguments.srp_action#" method="post">
								<select name="drivetrain" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Drivetrain</option>
									<cfloop query="Get_Drivetrains">
										<option value="#Get_Drivetrains.drivetrain#" <cfif Get_Drivetrains.drivetrain eq url.drivetrain>selected="selected"</cfif>>#Get_Drivetrains.drivetrain#</option>
									</cfloop>
								</select>
								<input type="hidden" name="new_used" value="#url.new_used#"/>
								<input type="hidden" name="year" value="#url.year#"/>
								<input type="hidden" name="make" value="#url.make#"/>
								<input type="hidden" name="model" value="#url.model#"/>
								<input type="hidden" name="transmission" value="#url.transmission#"/>
								<input type="hidden" name="body" value="#url.body#"/>
								<input type="hidden" name="color" value="#url.color#"/>
								<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
								<input type="hidden" name="zip" value="#url.zip#"/>
								<input type="hidden" name="radius" value="#url.radius#"/>
								<input type="hidden" name="maxprice" value="#url.maxprice#"/>
								<input type="hidden" name="minprice" value="#url.minprice#"/>
								<input type="hidden" name="old_year" value="#url.year#"/>
								<input type="hidden" name="old_make" value="#url.make#"/>
								<input type="hidden" name="sortblock" value="#url.sortblock#"/>
								<input type="hidden" name="geo" value="#url.geo#"/>
								<input type="hidden" name="result_set" value="#url.result_set#"/>
							</form>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:3px 0px 3px 0px">Color</h4>
						</div>
						<div>
							<form action="#arguments.srp_action#" method="post">
								<select name="color" class="srp-input" onchange="this.form.submit()">
									<option value="">Select A Color</option>
									<cfloop query="Get_Colors">
										<option value="#Get_Colors.Exterior_Color#" <cfif Get_Colors.Exterior_Color eq url.color>selected="selected"</cfif>>#Get_Colors.Exterior_Color#</option>
									</cfloop>
								</select>
								<input type="hidden" name="new_used" value="#url.new_used#"/>
								<input type="hidden" name="year" value="#url.year#"/>
								<input type="hidden" name="make" value="#url.make#"/>
								<input type="hidden" name="model" value="#url.model#"/>
								<input type="hidden" name="transmission" value="#url.transmission#"/>
								<input type="hidden" name="body" value="#url.body#"/>
								<input type="hidden" name="drivetrain" value="#url.drivetrain#"/>
								<input type="hidden" name="dealer_id" value="#url.dealer_id#"/>
								<input type="hidden" name="zip" value="#url.zip#"/>
								<input type="hidden" name="radius" value="#url.radius#"/>
								<input type="hidden" name="maxprice" value="#url.maxprice#"/>
								<input type="hidden" name="minprice" value="#url.minprice#"/>
								<input type="hidden" name="old_year" value="#url.year#"/>
								<input type="hidden" name="old_make" value="#url.make#"/>
								<input type="hidden" name="sortblock" value="#url.sortblock#"/>
								<input type="hidden" name="geo" value="#url.geo#"/>
								<input type="hidden" name="result_set" value="#url.result_set#"/>
							</form>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="padding:0px;margin:3px 0px 3px 0px">Price Range</h4>
						</div>
						<div>
							<div class="panel-body">
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=10000&result_set=#url.result_set#">Under $10,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=20000&minprice=10000&result_set=#url.result_set#">$10,000-$20,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=30000&minprice=20000&result_set=#url.result_set#">$20,000-$30,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=50000&minprice=30000&result_set=#url.result_set#">$30,000-$50,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=75000&minprice=50000&result_set=#url.result_set#">$50,000-$75,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&minprice=75000&result_set=#url.result_set#">Over $75,000</a>
							</div>
						</div>
					</div>
					<br/>
				</div>
			</div>
		</div>

	</cffunction>

</cfcomponent>