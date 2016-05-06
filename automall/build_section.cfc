<cfcomponent>

	<cffunction name="pitt" description="shows a standard header" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">

		<!---Get Participating Dealers--->
		<cfstoredproc datasource="Automall" procedure="Get_Automall_Dealers">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="2">
			<cfprocresult name="Get_Dealers" resultset="1">
		</cfstoredproc>		

		<cfquery datasource="Automall" name="Get_Makes" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT DISTINCT	V_Make
			FROM         	Vehicles
			WHERE     		Automall_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.automall_id#" maxlength="2">
			AND				V_New_Used = 'U'
			ORDER BY 		V_Make
		</cfquery>
		<cfset variables.col_1=ceiling(Get_Makes.recordcount/3)>
		<cfset variables.col_2=variables.col_1+1>
		<cfset variables.col_2_end=variables.col_2+variables.col_1-1>
		<cfset variables.col_3=variables.col_2_end+1>
		<cfset variables.col_3_end=variables.col_3+variables.col_1-1>

		<div class="row">
			<div class="col-md-8">
				<div class="row visible-sm visible-xs">
					<div class="col-md-12">
						<div class="spl-search-title">VEHICLE SEARCH</div>
						<div align="center">
							<cfinvoke component="/cfcs/automall/form_search" method="vehicle_search">
								<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
								<cfinvokeargument name="form_id" value="searchForm_m"/>
								<cfinvokeargument name="form_class" value="mbl-spl-form"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
							</cfinvoke>
						</div>
						<cfcache action="cache" timespan="#createtimespan(0,0,2,0)#">
						<div align="center">
							<cfinvoke component="/cfcs/automall/form_search" method="dealer_search">
								<cfinvokeargument name="form_id" value="drlSearch"/>
								<cfinvokeargument name="form_class" value="mbl-spl-form"/>
								<cfinvokeargument name="Get_Dealers" value="#Get_Dealers#"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							</cfinvoke>
						</div>
						</cfcache>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 no-pad">
						<cfinvoke component="/cfcs/automall/slideshow" method="default">
							<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
							<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
							<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 no-pad">
						<a href="http://#cgi.server_name#/findmycar"><img class="btn-cf max-width" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_carfinder.png"/></a>
					</div>
				</div>
				<cfset variables.srp_action="http://#cgi.server_name#/vehicles/srp_action.cfm">
				<div class="row visible-sm visible-xs">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-6 no-pad half-width pull-left">
								<div class="search-price">
									<div class="search-title-black">Find By Price</div>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=5000&zip=#cookie.savezip#">Under $5000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=10000&zip=#cookie.savezip#">Under $10,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=15000&zip=#cookie.savezip#">Under $15,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=20000&zip=#cookie.savezip#">Under $20,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=25000&zip=#cookie.savezip#">Under $25,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=30000&zip=#cookie.savezip#">Under $30,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=35000&zip=#cookie.savezip#">Under $35,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=N&maxprice=40000&zip=#cookie.savezip#">Under $40,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=N&maxprice=45000&zip=#cookie.savezip#">Under $45,000</a>
									<a class="search-link-blue" href="#variables.srp_action#?new_used=N&minprice=50000&zip=#cookie.savezip#">Over $50,000</a>
								</div>
							</div>
							<div class="col-md-6 no-pad half-width pull-right">
								<div class="search-type txt-center">
									<div class="search-title-black">Browse By Type</div>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Sedan&zip=#cookie.savezip#">Sedans</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Coupe&zip=#cookie.savezip#">Coupes</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Truck&zip=#cookie.savezip#">Trucks</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Convertible&zip=#cookie.savezip#">Convertibles</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=SUV&zip=#cookie.savezip#">SUVs</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Van&zip=#cookie.savezip#">Vans</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Hybrid&zip=#cookie.savezip#">Hybrids</a>
									<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Wagon&zip=#cookie.savezip#">Wagons</a>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="search-brand-mbl">
								<div class="search-title-white">Browse by Brands</div>
								<div class="row no-pad">
									<div class="col-md-4 pull-left third-width">
										<cfloop query="Get_Makes" endrow="#variables.col_1#">
											<a class="search-link-white" href="#variables.srp_action#?new_used=U&make=#Get_Makes.V_Make#&zip=#cookie.savezip#" title="#Get_Makes.V_Make#">#Get_Makes.V_Make#</a>
										</cfloop>
									</div>
									<div class="col-md-4 pull-left third-width">
										<cfloop query="Get_Makes" startrow="#variables.col_2#" endrow="#variables.col_2_end#">
											<a class="search-link-white" href="#variables.srp_action#?new_used=U&make=#Get_Makes.V_Make#&zip=#cookie.savezip#" title="#Get_Makes.V_Make#">#Get_Makes.V_Make#</a>
										</cfloop>
									</div>
									<div class="col-md-4 pull-left third-width">
										<cfloop query="Get_Makes" startrow="#variables.col_3#" endrow="#variables.col_3_end#">
											<a class="search-link-white" href="#variables.srp_action#?new_used=U&make=#Get_Makes.V_Make#&zip=#cookie.savezip#" title="#Get_Makes.V_Make#">#Get_Makes.V_Make#</a>
										</cfloop>
									</div>
								</div>
							</div>							
						</div>
					</div>
				</div>
				<div class="row visible-md visible-lg">
					<div class="col-md-3 no-pad">
						<div class="search-price">
							<div class="search-title-black">Find By Price</div>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=5000&zip=#cookie.savezip#">Under $5000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=10000&zip=#cookie.savezip#">Under $10,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=15000&zip=#cookie.savezip#">Under $15,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=20000&zip=#cookie.savezip#">Under $20,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=25000&zip=#cookie.savezip#">Under $25,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=30000&zip=#cookie.savezip#">Under $30,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=U&maxprice=35000&zip=#cookie.savezip#">Under $35,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=N&maxprice=40000&zip=#cookie.savezip#">Under $40,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=N&maxprice=45000&zip=#cookie.savezip#">Under $45,000</a>
							<a class="search-link-blue" href="#variables.srp_action#?new_used=N&minprice=50000&zip=#cookie.savezip#">Over $50,000</a>
						</div>
					</div>
					<div class="col-md-3 no-pad">
						<div class="search-type">
							<div class="search-title-black">Browse By Type</div>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Sedan&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_sedan.png"/>Sedans</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&?body=Coupe&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_coupe.png"/>Coupes</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Truck&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_truck.png"/>Trucks</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Convertible&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_convertible.png"/>Convertibles</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=SUV&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_suv.png"/>SUVs</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Van&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_van.png"/>Vans</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Hybrid&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_hybrid.png"/>Hybrids</a>
							<a class="search-link-type" href="#variables.srp_action#?new_used=N&body=Wagon&zip=#cookie.savezip#"><img class="spl-img-type" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/spl_icon_wagon.png"/>Wagons</a>
						</div>
					</div>
					<div class="col-md-6 no-pad">
						<div class="search-brand">
							<div class="search-title-white">Browse by Brands</div>
							<div class="row">
								<div class="col-md-4">
									<cfloop query="Get_Makes" endrow="#variables.col_1#">
										<a class="search-link-white" href="#variables.srp_action#?new_used=U&make=#Get_Makes.V_Make#&zip=#cookie.savezip#" title="#Get_Makes.V_Make#">#Get_Makes.V_Make#</a>
									</cfloop>
								</div>
								<div class="col-md-4">
									<cfloop query="Get_Makes" startrow="#variables.col_2#" endrow="#variables.col_2_end#">
										<a class="search-link-white" href="#variables.srp_action#?new_used=U&make=#Get_Makes.V_Make#&zip=#cookie.savezip#" title="#Get_Makes.V_Make#">#Get_Makes.V_Make#</a>
									</cfloop>
								</div>
								<div class="col-md-4">
									<cfloop query="Get_Makes" startrow="#variables.col_3#" endrow="#variables.col_3_end#">
										<a class="search-link-white" href="#variables.srp_action#?new_used=U&make=#Get_Makes.V_Make#&zip=#cookie.savezip#" title="#Get_Makes.V_Make#">#Get_Makes.V_Make#</a>
									</cfloop>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="row">
					<div class="col-md-12 visible-md visible-lg">
						<div class="spl-search-title">VEHICLE SEARCH</div>
						<div align="center">
							<cfinvoke component="/cfcs/automall/form_search" method="vehicle_search">
								<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
								<cfinvokeargument name="form_id" value="searchForm"/>
								<cfinvokeargument name="form_class" value="spl-form"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
							</cfinvoke>
						</div>
						<div align="center">
							<cfinvoke component="/cfcs/automall/form_search" method="dealer_search">
								<cfinvokeargument name="form_id" value="drlSearch"/>
								<cfinvokeargument name="form_class" value="spl-form"/>
								<cfinvokeargument name="Get_Dealers" value="#Get_Dealers#"/>
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							</cfinvoke>
						</div>
					</div>
				</div>
				<cfif len(trim(Get_Page_Content.side_ad_1)) gt 0>
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-12" align="center">
								<div class="ad-dis">
									#Get_Page_Content.side_ad_1#
								</div>
							</div>
						</div>
					</div>
				</cfif>
				<cfif len(trim(Get_Page_Content.side_ad_2)) gt 0>
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-12" align="center">
								<div class="ad-dis">
									#Get_Page_Content.side_ad_2#
								</div>
							</div>
						</div>
					</div>
				</cfif>
			</div>
		</div>
	</cffunction>

</cfcomponent>