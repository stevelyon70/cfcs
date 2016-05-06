<cfcomponent>

	<cffunction name="srp_default" description="shows default vdp page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true" >
		<cfargument name="srp_btns" default="0">

		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicles">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="70" maxlength="10">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@new_used" value="U" maxlength="1">
			<cfprocresult name="Get_Vehicles" resultset="1">
		</cfstoredproc>
	
		<section>
			<div class="container">
				<div class="row">
					<div class="col-md-12 visible-md visible-lg">
						Search Dropdowns
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 visible-md visible-lg">
						Filters						
					</div>
					<div class="col-md-9">
						<cfloop query="Get_Vehicles">
							<!---Set Condition in Regular Speak--->
							<cfswitch expression="#Get_Vehicles.V_New_Used#">
								<cfdefaultcase>
									<cfset variables.New_Used="Used">
								</cfdefaultcase>
								<cfcase value="N">
									<cfset variables.New_Used="New">
								</cfcase>
								<cfcase value="U">
									<cfset variables.New_Used="Used">
								</cfcase>
							</cfswitch>
							<div class="row">
								<div class="col-md-12 srp-row">
									<div class="row">
										<div class="col-md-5">
											<div class="visible-xs visible-sm">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model# #Get_Vehicles.V_Trim#</div>
											<cfinvoke component="/cfcs/ultra10/vehicle_photos" method="single_photo">
												<cfinvokeargument name="Img_Urls" value="#Get_Vehicles.Img_Urls#"/>
												<cfinvokeargument name="img_title" value="#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model# #Get_Vehicles.V_Trim#"/>
											</cfinvoke>
										</div>
										<div class="col-md-4 visible-md visible-lg">
											<div>#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model# #Get_Vehicles.V_Trim#</div>
											<div>
												<cfinvoke component="/cfcs/ultra10/vehicle_specs" method="vdp_default">
													<cfinvokeargument name="New_Used" value="#variables.New_Used#"/>
													<cfinvokeargument name="Stock" value="#Get_Vehicles.Stock#"/>
													<cfinvokeargument name="Model_Number" value="#Get_Vehicles.V_Model_Number#"/>
													<cfinvokeargument name="Vin" value="#Get_Vehicles.Vin#"/>
													<cfinvokeargument name="V_Body" value="#Get_Vehicles.V_Style#"/>
													<cfinvokeargument name="V_Type" value="#Get_Vehicles.V_Type#"/>
													<cfinvokeargument name="Engine_Size" value="#Get_Vehicles.Engine_Size#"/>
													<cfinvokeargument name="V_Body" value="#Get_Vehicles.V_Style#"/>
													<cfinvokeargument name="V_Type" value="#Get_Vehicles.V_Type#"/>
													<cfinvokeargument name="Cylinders" value="#Get_Vehicles.Cylinders#"/>
													<cfinvokeargument name="Transmission" value="#Get_Vehicles.Transmission#"/>
													<cfinvokeargument name="Drivetrain" value="#Get_Vehicles.Drivetrain#"/>
													<cfinvokeargument name="Odometer" value="#Get_Vehicles.V_Odometer#"/>
													<cfinvokeargument name="Fuel_Type" value="#Get_Vehicles.Fuel_Type#"/>
													<cfinvokeargument name="EPA_City" value="#Get_Vehicles.EPA_City#"/>
													<cfinvokeargument name="EPA_HWY" value="#Get_Vehicles.EPA_HWY#"/>
													<cfinvokeargument name="Exterior_Color" value="#Get_Vehicles.Exterior_Color#"/>
													<cfinvokeargument name="Interior_Color" value="#Get_Vehicles.Interior_Color#"/>
													<cfinvokeargument name="Doors" value="#Get_Vehicles.Doors#"/>
													<cfinvokeargument name="Passengers" value="#Get_Vehicles.Passengers#"/>
													<cfinvokeargument name="Location" value="#Get_Vehicles.Dealer_Display_Name#"/>
												</cfinvoke>
											</div>
										</div>
										<div class="col-md-3">
											<cfinvoke component="/cfcs/ultra10/vehicle_pricing" method="vdp_default">
												<cfinvokeargument name="Selling_Price_Label" value="#Get_Vehicles.Selling_Price_Label#"/>
												<cfinvokeargument name="Selling_Price" value="#Get_Vehicles.Selling_Price#"/>
												<cfinvokeargument name="MSRP_Label" value="#Get_Vehicles.MSRP_Label#"/>
												<cfinvokeargument name="MSRP_Price" value="#Get_Vehicles.MSRP_Price#"/>
												<cfinvokeargument name="Rebate_Label" value="#Get_Vehicles.Rebate_Label#"/>
												<cfinvokeargument name="Rebate_Price" value="#Get_Vehicles.Rebate_Price#"/>
												<cfinvokeargument name="Incentive_Label" value="#Get_Vehicles.Incentive_Label#"/>
												<cfinvokeargument name="Incentive_Price" value="#Get_Vehicles.Incentive_Price#"/>
												<cfinvokeargument name="Savings_Label" value="#Get_Vehicles.Savings_Label#"/>
												<cfinvokeargument name="Savings_Price" value="#Get_Vehicles.Savings_Price#"/>
												<cfinvokeargument name="AIS_Label" value="#Get_Vehicles.AIS_Label#"/>
												<cfinvokeargument name="AIS_Price" value="#Get_Vehicles.AIS_Price#"/>
												<cfinvokeargument name="AIS_APR" value="#Get_Vehicles.AIS_APR#"/>
											</cfinvoke>
										</div>
									</div>
									<cfif len(trim(Get_Vehicles.Dealer_Comments)) gt 0>
										<div class="row visible-md visible-lg">
											<div class="col-md-12">
												Comments:<br/>
												#Get_Vehicles.Dealer_Comments#
											</div>
										</div>
									</cfif>
									<div class="row">
										<cfswitch expression="#arguments.srp_btns#">
											<cfdefaultcase>
												<cfinvoke component="/cfcs/ultra10/vehicle_btns" method="srp_standard">
													<cfinvokeargument name="VOI_Vin" value="xxx"/>
												</cfinvoke>
											</cfdefaultcase>
											<cfcase value="1">
												Custom Button Layout xxx
											</cfcase>
										</cfswitch>
									</div>
								</div>
							</div>
						</cfloop>
					</div>
				</div>
			</div>
		</section>
	
	</cffunction>

</cfcomponent>