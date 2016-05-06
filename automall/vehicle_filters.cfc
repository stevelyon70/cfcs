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

		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>

		<div class="row">
			<div class="col-md-12">
				<div align="center" class="srp-results">Search Results #numberformat(arguments.Recordcount)#</div>
				<div class="srp-filters">Current Filters</div>
				<cfif url.new_used eq "B"><span class="btn-srp-sel pull-left">ALL VEHICLES</span></cfif>
				<cfif url.new_used eq "N"><span class="btn-srp-sel pull-left">NEW</span></cfif>
				<cfif url.new_used eq "U"><span class="btn-srp-sel pull-left">USED</span></cfif>
				<cfif url.new_used eq "C"><span class="btn-srp-sel pull-left">CERTIFIED</span></cfif>
				<cfif len(trim(url.dealer_id)) gt 0>
					<cfloop query="Get_Dealers">
						<cfif url.dealer_id eq Get_Dealers.Dealer_ID>
							<span class="btn-srp-sel pull-left">#ucase(Get_Dealers.Dealer_Display_Name)#</span>
							<cfbreak>
						</cfif>
					</cfloop>
				</cfif>
				<cfif len(trim(url.year)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.year)#</span></cfif>
				<cfif len(trim(url.make)) gt 0><span class="btn-srp-sel pull-left">#ucase(url.make)#</span></cfif>
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
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapsePrice">
								Price Range
								<span class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapsePrice" class="panel-collapse collapse in">
							<div class="panel-body">
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=10000">Under $10,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=20000&minprice=10000">$10,000-$20,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=30000&minprice=20000">$20,000-$30,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=50000&minprice=30000">$30,000-$50,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&maxprice=75000&minprice=50000">$50,000-$75,000</a>
								<a class="btn-sm btn-srp-price" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&dealer_id=#url.dealer_id#&color=#url.color#&minprice=75000">Over $75,000</a>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseYear">
								Year<span class="glyphicon glyphicon-chevron-down pull-right"></span>	
							</a>
						</div>
						<div id="collapseYear" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Years">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#Get_Years.V_Year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Years.V_Year#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseMake">
								Make
								<span class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseMake" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Makes">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#Get_Makes.V_Make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Makes.V_Make#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<cfif len(trim(url.make)) gt 0>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseModel">
									Model
									<span class="glyphicon glyphicon-chevron-down pull-right"></span>
								</a>
							</div>
							<div id="collapseModel" class="panel-collapse collapse">
								<div class="panel-body">
									<cfloop query="Get_Models">
										<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#Get_Models.V_Model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Models.V_Model#</a>	
									</cfloop>
								</div>
							</div>
						</div>
					</cfif>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseBody">
								Body
								<span class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseBody" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Bodies">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#Get_Bodies.V_Type#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Bodies.V_Type#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseTransmission">
								Transmission
								<span class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseTransmission" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Transmissions">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#Get_Transmissions.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Transmissions.Transmission#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseDrivetrain">
								Drivetrain
								<span class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseDrivetrain" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Drivetrains">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#Get_Bodies.V_Type#&drivetrain=#Get_Drivetrains.Drivetrain#&transmission=#url.transmission#&color=#url.color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Drivetrains.Drivetrain#</a>	
								</cfloop>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="center-block" data-toggle="collapse" data-parent="##accordion" href="##collapseColor">
								Color
								<span class="glyphicon glyphicon-chevron-down pull-right"></span>
							</a>
						</div>
						<div id="collapseColor" class="panel-collapse collapse">
							<div class="panel-body">
								<cfloop query="Get_Colors">
									<a class="btn-srp-filt pull-left" href="#arguments.srp_action#?&zip=#cookie.savezip#&new_used=#url.new_used#&year=#url.year#&make=#url.make#&model=#url.model#&body=#url.body#&drivetrain=#url.drivetrain#&transmission=#url.transmission#&color=#Get_Colors.Exterior_Color#&dealer_id=#url.dealer_id#&minprice=#url.minprice#&maxprice=#url.maxprice#">#Get_Colors.Exterior_Color#</a>	
								</cfloop>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</cffunction>

</cfcomponent>