<cfcomponent>

	<cffunction name="srp" description="search results page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Dealer_ID" required="true"/>
		<cfargument name="Vin" required="true"/>
		<cfargument name="Stock" required="true"/>
		<cfargument name="V_New_Used" required="true"/>
		<cfargument name="V_Year" required="true"/>
		<cfargument name="V_Make" required="true"/>
		<cfargument name="V_Model" required="true"/>
		<cfargument name="V_Trim" required="true"/>
		<cfargument name="Img_Urls" required="true"/>
		<cfargument name="New_Used" required="true"/>
		<cfargument name="Model_Number" required="true"/>
		<cfargument name="V_Style" required="true"/>
		<cfargument name="V_Body" required="true"/>
		<cfargument name="V_Type" required="true"/>
		<cfargument name="Engine_Size" required="true"/>
		<cfargument name="Cylinders" required="true"/>
		<cfargument name="Transmission" required="true"/>
		<cfargument name="Drivetrain" required="true"/>
		<cfargument name="Odometer" required="true"/>
		<cfargument name="Fuel_Type" required="true"/>
		<cfargument name="EPA_City" required="true"/>
		<cfargument name="EPA_HWY" required="true"/>
		<cfargument name="Exterior_Color" required="true"/>
		<cfargument name="Interior_Color" required="true"/>
		<cfargument name="Doors" required="true"/>
		<cfargument name="Passengers" required="true"/>
		<cfargument name="Location" required="true"/>
		<cfargument name="Selling_Price_Label" required="true"/>
		<cfargument name="Selling_Price" required="true"/>
		<cfargument name="MSRP_Label" required="true"/>
		<cfargument name="MSRP_Price" required="true"/>
		<cfargument name="Rebate_Label" required="true"/>
		<cfargument name="Rebate_Price" required="true"/>
		<cfargument name="Incentive_Label" required="true"/>
		<cfargument name="Incentive_Price" required="true"/>
		<cfargument name="Savings_Label" required="true"/>
		<cfargument name="Savings_Price" required="true"/>
		<cfargument name="AIS_Label" required="true"/>
		<cfargument name="AIS_Price" required="true"/>
		<cfargument name="AIS_APR" required="true"/>
		<cfargument name="Dealer_Display_Name" required="true"/>
		<cfargument name="Dealer_Address_1" required="true"/>
		<cfargument name="Dealer_Address_2" required="true"/>
		<cfargument name="Dealer_City" required="true"/>
		<cfargument name="Dealer_State" required="true"/>
		<cfargument name="Dealer_Zip" required="true"/>
		<cfargument name="Dealer_Phone" required="true"/>
		<cfargument name="Get_Dealers_Zip" default="" />
		<cfargument name="My_Zip" default="" />

		<cfset Get_Dealers_Zip=arguments.Get_Dealers_Zip>

		<div class="row">
			<div class="col-md-12 srp-row">
				<div class="row">
					<div class="col-md-4">
						<div class="srp-title  visible-sm visible-xs" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#ucase(arguments.V_Year)# #ucase(arguments.V_Make)# #ucase(arguments.V_Model)# #ucase(arguments.V_Trim)#</div>
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_photos" method="single_photo">
							<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
							<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
							<cfinvokeargument name="img_class" value="img-responsive"/>
						</cfinvoke>
						<cfif len(trim(arguments.My_Zip)) gt 0>
							<cfloop query="Get_Dealers_Zip">
								<cfif Get_Dealers_Zip.Dealer_ID eq arguments.Dealer_ID>
									<div align="center"><b>#round(Get_Dealers_Zip.Distance)# miles from #arguments.My_Zip#</b></div>
								</cfif>
							</cfloop>
						</cfif>
					</div>
					<div class="col-md-5 srp-specs visible-md visible-lg">
						<div class="srp-title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#ucase(arguments.V_Year)# #ucase(arguments.V_Make)# #ucase(arguments.V_Model)# #ucase(arguments.V_Trim)#</div>	
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_specs" method="vdp_default">
							<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
							<cfinvokeargument name="Stock" value="#arguments.Stock#"/>
							<cfinvokeargument name="Model_Number" value="#arguments.Model_Number#"/>
							<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="V_Body" value="#arguments.V_Style#"/>
							<cfinvokeargument name="V_Type" value="#arguments.V_Type#"/>
							<cfinvokeargument name="Engine_Size" value="#arguments.Engine_Size#"/>
							<cfinvokeargument name="V_Body" value="#arguments.V_Style#"/>
							<cfinvokeargument name="V_Type" value="#arguments.V_Type#"/>
							<cfinvokeargument name="Cylinders" value="#arguments.Cylinders#"/>
							<cfinvokeargument name="Transmission" value="#arguments.Transmission#"/>
							<cfinvokeargument name="Drivetrain" value="#arguments.Drivetrain#"/>
							<cfinvokeargument name="Odometer" value="#arguments.Odometer#"/>
							<cfinvokeargument name="Fuel_Type" value="#arguments.Fuel_Type#"/>
							<cfinvokeargument name="EPA_City" value="#arguments.EPA_City#"/>
							<cfinvokeargument name="EPA_HWY" value="#arguments.EPA_HWY#"/>
							<cfinvokeargument name="Exterior_Color" value="#arguments.Exterior_Color#"/>
							<cfinvokeargument name="Interior_Color" value="#arguments.Interior_Color#"/>
							<cfinvokeargument name="Location" value="#arguments.Dealer_Display_Name#"/>
							<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_pricing" method="vdp_default">
							<cfinvokeargument name="Selling_Price_Label" value="#arguments.Selling_Price_Label#"/>
							<cfinvokeargument name="Selling_Price" value="#arguments.Selling_Price#"/>
							<cfinvokeargument name="MSRP_Label" value="#arguments.MSRP_Label#"/>
							<cfinvokeargument name="MSRP_Price" value="#arguments.MSRP_Price#"/>
							<cfinvokeargument name="Rebate_Label" value="#arguments.Rebate_Label#"/>
							<cfinvokeargument name="Rebate_Price" value="#arguments.Rebate_Price#"/>
							<cfinvokeargument name="Incentive_Label" value="#arguments.Incentive_Label#"/>
							<cfinvokeargument name="Incentive_Price" value="#arguments.Incentive_Price#"/>
							<cfinvokeargument name="Savings_Label" value="#arguments.Savings_Label#"/>
							<cfinvokeargument name="Savings_Price" value="#arguments.Savings_Price#"/>
							<cfinvokeargument name="AIS_Label" value="#arguments.AIS_Label#"/>
							<cfinvokeargument name="AIS_Price" value="#arguments.AIS_Price#"/>
							<cfinvokeargument name="AIS_APR" value="#arguments.AIS_APR#"/>
						</cfinvoke>
					</div>
				</div>
				<cfif len(trim(arguments.Dealer_Comments)) gt 0>
					<div class="row visible-md visible-lg">
						<div class="col-md-12">
							<div class="srp-comments">
								<div class="srp-comment-title">DEALER COMMENTS:</div>
								#arguments.Dealer_Comments#
							</div>
						</div>
					</div>
				</cfif>
				<div class="row">
					<div class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_btns" method="srp_standard">
							<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</div>

	</cffunction>

	<cffunction name="vdp" description="search results page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Dealer_ID" required="true"/>
		<cfargument name="Vin" required="true"/>
		<cfargument name="Stock" required="true"/>
		<cfargument name="V_New_Used" required="true"/>
		<cfargument name="V_Year" required="true"/>
		<cfargument name="V_Make" required="true"/>
		<cfargument name="V_Model" required="true"/>
		<cfargument name="V_Trim" required="true"/>
		<cfargument name="Img_Urls" required="true"/>
		<cfargument name="New_Used" required="true"/>
		<cfargument name="Model_Number" required="true"/>
		<cfargument name="V_Style" required="true"/>
		<cfargument name="V_Body" required="true"/>
		<cfargument name="V_Type" required="true"/>
		<cfargument name="Engine_Size" required="true"/>
		<cfargument name="Cylinders" required="true"/>
		<cfargument name="Transmission" required="true"/>
		<cfargument name="Drivetrain" required="true"/>
		<cfargument name="Odometer" required="true"/>
		<cfargument name="Fuel_Type" required="true"/>
		<cfargument name="EPA_City" required="true"/>
		<cfargument name="EPA_HWY" required="true"/>
		<cfargument name="Exterior_Color" required="true"/>
		<cfargument name="Interior_Color" required="true"/>
		<cfargument name="Doors" required="true"/>
		<cfargument name="Passengers" required="true"/>
		<cfargument name="Location" required="true"/>
		<cfargument name="Selling_Price_Label" required="true"/>
		<cfargument name="Selling_Price" required="true"/>
		<cfargument name="MSRP_Label" required="true"/>
		<cfargument name="MSRP_Price" required="true"/>
		<cfargument name="Rebate_Label" required="true"/>
		<cfargument name="Rebate_Price" required="true"/>
		<cfargument name="Incentive_Label" required="true"/>
		<cfargument name="Incentive_Price" required="true"/>
		<cfargument name="Savings_Label" required="true"/>
		<cfargument name="Savings_Price" required="true"/>
		<cfargument name="AIS_Label" required="true"/>
		<cfargument name="AIS_Price" required="true"/>
		<cfargument name="AIS_APR" required="true"/>
		<cfargument name="Dealer_Comments" required="true"/>
		<cfargument name="Dealer_Display_Name" required="true"/>
		<cfargument name="Dealer_Address_1" required="true"/>
		<cfargument name="Dealer_Address_2" required="true"/>
		<cfargument name="Dealer_City" required="true"/>
		<cfargument name="Dealer_State" required="true"/>
		<cfargument name="Dealer_Zip" required="true"/>
		<cfargument name="Dealer_Phone" required="true"/>
		<cfargument name="template_id" required="true"/>
		<cfargument name="assets" required="true"/>

		<cfparam name="url.form_action" default="">

		<!---Get Vehicle Options--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Options" resultset="1">
		</cfstoredproc>

		<cflock timeout="60">
			<cfquery datasource="Ultra10" name="Get_Similar">
				SELECT		TOP (3) Dealer_ID,
							Vin,
							V_New_Used,
							Stock,
							V_Year,
							V_Make,
							V_Model,
							V_Trim,
							V_Model_Number,
							Selling_Price,
							Img_Urls,
							Certified,
							Permalink,
							V_Type
				FROM		Vehicles
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.dealer_id#" maxlength="3">
				AND			V_New_Used = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.V_New_Used#" maxlength="1">
				AND			V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.V_Type#" maxlength="100">
				AND			Vin <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.vin,17)#" maxlength="21">
				<cfif arguments.V_New_Used eq "N">
					AND		V_Make=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.V_Make#" maxlength="50">
				</cfif>
				<cfif arguments.V_New_Used eq "U">
					AND		V_Model <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.V_Model#" maxlength="50">
				</cfif>
			</cfquery>
		</cflock>

		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#arguments.V_New_Used#">
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

		<!---vdp track code--->
		<!---<cfinvoke component="/cfcs/ultra10/vehicles/click_track" method="vin">
			<cfinvokeargument name="vin" value="#arguments.vin#"/>
			<cfinvokeargument name="click_dir" value="E:\inetpub\wwwroot\automall\clicks\vdp"/>
		</cfinvoke>--->

		<div class="row">
			<div class="col-md-12">
				<a href="javascript:window.history.back()" class="btn btn-primary"><i class="glyphicon glyphicon-arrow-left"></i> Back to Inventory</a>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9">
				<h1 class="v_title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h1>
				<div class="visible-md visible-lg vdp-text vdp-condition"><b>Condition:</b> #variables.New_Used# | <b>Stock ##:</b> #arguments.Stock# | <b>Model ##:</b> #arguments.Stock# | <span class="txt-green"><b>IN STOCK</b></span></div>
				<div class="row">
					<div class="col-md-8">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_photos" method="bx_slider">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
							<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
							<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
							<cfinvokeargument name="img_class" value="vdp-img"/>
						</cfinvoke>
					</div>
					<div class="col-md-4">
						<div class="price-block">
							<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_pricing" method="vdp_default">
								<cfinvokeargument name="Selling_Price_Label" value="#arguments.Selling_Price_Label#"/>
								<cfinvokeargument name="Selling_Price" value="#arguments.Selling_Price#"/>
								<cfinvokeargument name="MSRP_Label" value="#arguments.MSRP_Label#"/>
								<cfinvokeargument name="MSRP_Price" value="#arguments.MSRP_Price#"/>
								<cfinvokeargument name="Rebate_Label" value="#arguments.Rebate_Label#"/>
								<cfinvokeargument name="Rebate_Price" value="#arguments.Rebate_Price#"/>
								<cfinvokeargument name="Incentive_Label" value="#arguments.Incentive_Label#"/>
								<cfinvokeargument name="Incentive_Price" value="#arguments.Incentive_Price#"/>
								<cfinvokeargument name="Savings_Label" value="#arguments.Savings_Label#"/>
								<cfinvokeargument name="Savings_Price" value="#arguments.Savings_Price#"/>
								<cfinvokeargument name="AIS_Label" value="#arguments.AIS_Label#"/>
								<cfinvokeargument name="AIS_Price" value="#arguments.AIS_Price#"/>
								<cfinvokeargument name="AIS_APR" value="#arguments.AIS_APR#"/>
							</cfinvoke>
						</div>
						<div class="row visible-xs visible-sm">
							<div class="vdp-form-mobile">
								<div class="vdp-form-title">REQUEST A QUOTE</div>
								<cfinvoke component="/cfcs/forms/form_quote" method="qq_default">
									<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_btns" method="vdp_standard">
									<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="exclude_print" value="yes"/>
								</cfinvoke>
							</div>
						</div>
						<div class="vdp-text">
							<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_specs" method="vdp_default">
								<cfinvokeargument name="New_Used" value="#arguments.V_New_Used#"/>
								<cfinvokeargument name="Stock" value="#arguments.Stock#"/>
								<cfinvokeargument name="Model_Number" value="#arguments.Model_Number#"/>
								<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
								<cfinvokeargument name="V_Body" value="#arguments.V_Style#"/>
								<cfinvokeargument name="V_Type" value="#arguments.V_Type#"/>
								<cfinvokeargument name="Engine_Size" value="#arguments.Engine_Size#"/>
								<cfinvokeargument name="V_Body" value="#arguments.V_Style#"/>
								<cfinvokeargument name="V_Type" value="#arguments.V_Type#"/>
								<cfinvokeargument name="Cylinders" value="#arguments.Cylinders#"/>
								<cfinvokeargument name="Transmission" value="#arguments.Transmission#"/>
								<cfinvokeargument name="Drivetrain" value="#arguments.Drivetrain#"/>
								<cfinvokeargument name="Odometer" value="#arguments.Odometer#"/>
								<cfinvokeargument name="Fuel_Type" value="#arguments.Fuel_Type#"/>
								<cfinvokeargument name="EPA_City" value="#arguments.EPA_City#"/>
								<cfinvokeargument name="EPA_HWY" value="#arguments.EPA_HWY#"/>
								<cfinvokeargument name="Exterior_Color" value="#arguments.Exterior_Color#"/>
								<cfinvokeargument name="Interior_Color" value="#arguments.Interior_Color#"/>
								<cfinvokeargument name="Doors" value="#arguments.Doors#"/>
								<cfinvokeargument name="Passengers" value="#arguments.Passengers#"/>
								<cfinvokeargument name="Location" value="#arguments.Dealer_Display_Name#"/>
							</cfinvoke>
						</div>
					</div>
				</div>
				<div class="row vdp-options-box visible-md visible-lg">
					<cfif len(trim(arguments.Dealer_Comments)) gt 0>
						<div class="col-md-12 vdp-text vdp-pad-10">
							<b>DEALER COMMENTS:</b>
						</div>
						<div class="col-md-12 vdp-comments vdp-text-sm">
							#arguments.Dealer_Comments#	
						</div>
					</cfif>
					<div class="col-md-12 vdp-text vdp-pad-10">
						<b>VEHICLE DETAILS:</b>
					</div>
					<div class="col-md-12 vdp-text-sm vdp-options-div">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_options" method="vdp_default">
							<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
							<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
							<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
							<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
							<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
							<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row visible-xs visible-sm">
					<cfif len(trim(arguments.Dealer_Comments)) gt 0>
						<div class="col-md-12 vdp-text vdp-pad-10">
							<b>DEALER COMMENTS:</b>
						</div>
						<div class="col-md-12 vdp-text-sm">
							#arguments.Dealer_Comments#	
						</div>
					</cfif>
					<div class="col-md-12 vdp-text vdp-pad-10">
						<b>VEHICLE DETAILS:</b>
					</div>
					<div class="col-md-12 vdp-text-sm ">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_options" method="vdp_mobile">
							<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
							<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
							<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
							<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
							<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
							<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
						</cfinvoke>
					</div>							
				</div>
				<div class="row vdp-options-box  visible-md visible-lg">
					<div class="col-md-12 vdp-text vdp-pad-10">
						<div class="col-md-12">
							<b>PAYMENT CALCULATOR:</b>
						</div>
						<div class="col-md-12 vdp-pad-10">
							<cfinvoke component="/cfcs/ultra10/vehicles/calculator" method="vdp">
								<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
								<cfinvokeargument name="Calc_Price" value="#arguments.Selling_Price#"/>
							</cfinvoke>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3 visible-md visible-lg vdp-text-sm">
				<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_store" method="vdp_default">
					<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
					<cfinvokeargument name="Dealer_Address_1" value="#arguments.Dealer_Address_1#"/>
					<cfinvokeargument name="Dealer_Address_2" value="#arguments.Dealer_Address_2#"/>
					<cfinvokeargument name="Dealer_City" value="#arguments.Dealer_City#"/>
					<cfinvokeargument name="Dealer_State" value="#arguments.Dealer_State#"/>
					<cfinvokeargument name="Dealer_Zip" value="#arguments.Dealer_Zip#"/>
					<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
				</cfinvoke>
				<a class="btn btn-grey" href="http://#cgi.server_name#/clicks/web_click.cfm?dealer_id=#arguments.Dealer_ID#" target="_blank"><img class="btn-icon" src="http://#cgi.server_name#/images/inventory/icon_SM_WWW_off.png"/>Dealer Website</a>
				<div class="vdp-form-box">
					<div class="vdp-form-title">REQUEST A QUOTE</div>
					<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_quote_form" method="qq_default">
						<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
					</cfinvoke>
					<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_btns" method="vdp_standard">
						<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					</cfinvoke>
					<cfif Get_Similar.recordcount gt 0>
						<div class="vdp-form-title">SIMILAR VEHICLES</div>
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_similar" method="vdp_similar">
							<cfinvokeargument name="Get_Similar" value="#Get_Similar#"/>
						</cfinvoke>
					</cfif>
				</div>
			</div>
		</div>
		<div class="modal fade" id="tdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog-form">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Schedule A Test Drive on this #arguments.V_Year#  #arguments.V_Make#  #arguments.V_Model#  #arguments.V_Trim#</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<div class="pop-form-box">
										<cfinvoke component="/cfcs/ultra10/vehicles/form_test_drive" method="form_popup">
											<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
											<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
										</cfinvoke>
									</div>
								</div>
								<div class="col-md-6">
									<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_photos" method="single_photo">
										<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
										<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
										<cfinvokeargument name="img_class" value="img-responsive"/>
									</cfinvoke>
								</div>									
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="qqModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog-form">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Request a Quick Quote on this #arguments.V_Year#  #arguments.V_Make#  #arguments.V_Model#  #arguments.V_Trim#</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<div class="pop-form-box">
										<cfinvoke component="/cfcs/ultra10/vehicles/form_quick_quote" method="form_popup">
											<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
											<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
											<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
										</cfinvoke>
									</div>
								</div>
								<div class="col-md-6">
									<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_photos" method="single_photo">
										<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
										<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
										<cfinvokeargument name="img_class" value="img-responsive"/>
									</cfinvoke>
								</div>									
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="friendModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog-form">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Send info on this #arguments.V_Year#  #arguments.V_Make#  #arguments.V_Model#  #arguments.V_Trim# to a friend</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<div class="pop-form-box">
										<cfinvoke component="/cfcs/ultra10/vehicles/form_send_friend" method="form_popup">
											<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
											<cfinvokeargument name="VOI_Title" value="#arguments.V_Year#  #arguments.V_Make#  #arguments.V_Model#  #arguments.V_Trim#"/>
											<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
										</cfinvoke>
									</div>
								</div>
								<div class="col-md-6">
									<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_photos" method="single_photo">
										<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
										<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
										<cfinvokeargument name="img_class" value="img-responsive"/>
									</cfinvoke>
								</div>									
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!---formsubmissions--->

		<cfswitch expression="#url.form_action#">
			<cfcase value="submit_quote">
				<cfinvoke component="/cfcs/ultra10/vehicles/form_quick_quote" method="form_submit">
					<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
					<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
				</cfinvoke>
			</cfcase>
			<cfcase value="td_submit">
				<cfinvoke component="/cfcs/ultra10/vehicles/form_test_drive" method="form_submit">
					<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
					<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
				</cfinvoke>
			</cfcase>
			<cfcase value="friend_submit">
				<cfinvoke component="/cfcs/ultra10/vehicles/form_send_friend" method="form_submit">
					<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
					<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
				</cfinvoke>			
			</cfcase>
		</cfswitch>


	</cffunction>

	<cffunction name="data" description="search results page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Dealer_ID" required="true"/>
		<cfargument name="Vin" required="true"/>
		<cfargument name="Stock" required="true"/>
		<cfargument name="V_New_Used" required="true"/>
		<cfargument name="V_Year" required="true"/>
		<cfargument name="V_Make" required="true"/>
		<cfargument name="V_Model" required="true"/>
		<cfargument name="V_Trim" required="true"/>
		<cfargument name="Img_Urls" required="true"/>
		<cfargument name="New_Used" required="true"/>
		<cfargument name="Model_Number" required="true"/>
		<cfargument name="V_Style" required="true"/>
		<cfargument name="V_Body" required="true"/>
		<cfargument name="V_Type" required="true"/>
		<cfargument name="Engine_Size" required="true"/>
		<cfargument name="Cylinders" required="true"/>
		<cfargument name="Transmission" required="true"/>
		<cfargument name="Drivetrain" required="true"/>
		<cfargument name="Odometer" required="true"/>
		<cfargument name="Fuel_Type" required="true"/>
		<cfargument name="EPA_City" required="true"/>
		<cfargument name="EPA_HWY" required="true"/>
		<cfargument name="Exterior_Color" required="true"/>
		<cfargument name="Interior_Color" required="true"/>
		<cfargument name="Doors" required="true"/>
		<cfargument name="Passengers" required="true"/>
		<cfargument name="Location" required="true"/>
		<cfargument name="Selling_Price_Label" required="true"/>
		<cfargument name="Selling_Price" required="true"/>
		<cfargument name="MSRP_Label" required="true"/>
		<cfargument name="MSRP_Price" required="true"/>
		<cfargument name="Rebate_Label" required="true"/>
		<cfargument name="Rebate_Price" required="true"/>
		<cfargument name="Incentive_Label" required="true"/>
		<cfargument name="Incentive_Price" required="true"/>
		<cfargument name="Savings_Label" required="true"/>
		<cfargument name="Savings_Price" required="true"/>
		<cfargument name="AIS_Label" required="true"/>
		<cfargument name="AIS_Price" required="true"/>
		<cfargument name="AIS_APR" required="true"/>
		<cfargument name="Dealer_Comments" required="true"/>
		<cfargument name="Dealer_Display_Name" required="true"/>
		<cfargument name="Dealer_Address_1" required="true"/>
		<cfargument name="Dealer_Address_2" required="true"/>
		<cfargument name="Dealer_City" required="true"/>
		<cfargument name="Dealer_State" required="true"/>
		<cfargument name="Dealer_Zip" required="true"/>
		<cfargument name="Dealer_Phone" required="true"/>

		<cfparam name="url.form_action" default="">

		<!---print track code--->
		<!---<cfinvoke component="/cfcs/ultra10/vehicles/click_track" method="vin">
			<cfinvokeargument name="vin" value="#arguments.vin#"/>
			<cfinvokeargument name="click_dir" value="E:\inetpub\wwwroot\automall\clicks\print"/>
		</cfinvoke>--->

		<!---Get Vehicle Options--->
		<cfstoredproc datasource="Automall" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Options" resultset="1">
		</cfstoredproc>
		
		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#arguments.V_New_Used#">
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
			<div class="col-md-12 vdp-pad-10">
				<h1 class="v_title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_photos" method="single_photo">
							<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
							<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 vdp-pad-10">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_store" method="vdp_default">
							<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
							<cfinvokeargument name="Dealer_Address_1" value="#arguments.Dealer_Address_1#"/>
							<cfinvokeargument name="Dealer_Address_2" value="#arguments.Dealer_Address_2#"/>
							<cfinvokeargument name="Dealer_City" value="#arguments.Dealer_City#"/>
							<cfinvokeargument name="Dealer_State" value="#arguments.Dealer_State#"/>
							<cfinvokeargument name="Dealer_Zip" value="#arguments.Dealer_Zip#"/>
							<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_specs" method="vdp_default">
							<cfinvokeargument name="New_Used" value="#arguments.V_New_Used#"/>
							<cfinvokeargument name="Stock" value="#arguments.Stock#"/>
							<cfinvokeargument name="Model_Number" value="#arguments.Model_Number#"/>
							<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="V_Body" value="#arguments.V_Style#"/>
							<cfinvokeargument name="V_Type" value="#arguments.V_Type#"/>
							<cfinvokeargument name="Engine_Size" value="#arguments.Engine_Size#"/>
							<cfinvokeargument name="V_Body" value="#arguments.V_Style#"/>
							<cfinvokeargument name="V_Type" value="#arguments.V_Type#"/>
							<cfinvokeargument name="Cylinders" value="#arguments.Cylinders#"/>
							<cfinvokeargument name="Transmission" value="#arguments.Transmission#"/>
							<cfinvokeargument name="Drivetrain" value="#arguments.Drivetrain#"/>
							<cfinvokeargument name="Odometer" value="#arguments.Odometer#"/>
							<cfinvokeargument name="Fuel_Type" value="#arguments.Fuel_Type#"/>
							<cfinvokeargument name="EPA_City" value="#arguments.EPA_City#"/>
							<cfinvokeargument name="EPA_HWY" value="#arguments.EPA_HWY#"/>
							<cfinvokeargument name="Exterior_Color" value="#arguments.Exterior_Color#"/>
							<cfinvokeargument name="Interior_Color" value="#arguments.Interior_Color#"/>
							<cfinvokeargument name="Doors" value="#arguments.Doors#"/>
							<cfinvokeargument name="Passengers" value="#arguments.Passengers#"/>
						</cfinvoke>
					</div>
					<div class="col-md-6">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_pricing" method="vdp_default">
							<cfinvokeargument name="Selling_Price_Label" value="#arguments.Selling_Price_Label#"/>
							<cfinvokeargument name="Selling_Price" value="#arguments.Selling_Price#"/>
							<cfinvokeargument name="MSRP_Label" value="#arguments.MSRP_Label#"/>
							<cfinvokeargument name="MSRP_Price" value="#arguments.MSRP_Price#"/>
							<cfinvokeargument name="Rebate_Label" value="#arguments.Rebate_Label#"/>
							<cfinvokeargument name="Rebate_Price" value="#arguments.Rebate_Price#"/>
							<cfinvokeargument name="Incentive_Label" value="#arguments.Incentive_Label#"/>
							<cfinvokeargument name="Incentive_Price" value="#arguments.Incentive_Price#"/>
							<cfinvokeargument name="Savings_Label" value="#arguments.Savings_Label#"/>
							<cfinvokeargument name="Savings_Price" value="#arguments.Savings_Price#"/>
							<cfinvokeargument name="AIS_Label" value="#arguments.AIS_Label#"/>
							<cfinvokeargument name="AIS_Price" value="#arguments.AIS_Price#"/>
							<cfinvokeargument name="AIS_APR" value="#arguments.AIS_APR#"/>
						</cfinvoke>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-12">
						<b>VEHICLE DETAILS:</b>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/vehicles/vehicle_options" method="vdp_mobile">
							<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
							<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
							<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
							<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
							<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
							<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</div>

	</cffunction>
	
</cfcomponent>