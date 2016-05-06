<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="v_vin" required="true">
		<cfargument name="vdp_btns" default="0">

		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.v_vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>

		<!---Get Vehicle Options--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.v_vin,17)#" maxlength="21">
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
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_char" value="#Get_Vehicle_Details.dealer_id#" maxlength="3">
				AND			V_New_Used = <cfqueryparam cfsqltype="cf_sql_char" value="#Get_Vehicle_Details.V_New_Used#" maxlength="1">
				AND			V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vehicle_Details.V_Type#" maxlength="100">
				AND			Vin <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.v_vin,17)#" maxlength="21">
				<cfif Get_Vehicle_Details.V_New_Used eq "N">
					AND		V_Make=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vehicle_Details.V_Make#" maxlength="50">
				</cfif>
				<cfif Get_Vehicle_Details.V_New_Used eq "U">
					AND		V_Model <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vehicle_Details.V_Model#" maxlength="50">
				</cfif>
			</cfquery>
		</cflock>

		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#Get_Vehicle_Details.V_New_Used#">
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

		<section>
			<div class="container">
				<div class="row">
					<div class="col-md-9">
						<h1 class="v_title" title="#Get_Vehicle_Details.V_Year# #Get_Vehicle_Details.V_Make# #Get_Vehicle_Details.V_Model# #Get_Vehicle_Details.V_Trim#">#Get_Vehicle_Details.V_Year# #Get_Vehicle_Details.V_Make# #Get_Vehicle_Details.V_Model# #Get_Vehicle_Details.V_Trim#</h1>
						<div class="visible-md visible-lg vdp-text vdp-condition"><b>Condition:</b> #variables.New_Used# | <b>Stock ##:</b> #Get_Vehicle_Details.Stock# | <b>Model ##:</b> #Get_Vehicle_Details.Stock# | <span class="txt-green"><b>IN STOCK</b></span></div>
						<div class="row">
							<div class="col-md-8">
								<ul id="myTab" class="nav nav-tabs">
									<li class="active"><a href="##photos" data-toggle="tab" onclick='jwplayer().stop()'>Vehicles Photos</a></li>
									<li><a href="##videos" data-toggle="tab">Videos</a></li>
									<li><a href="##reviews" data-toggle="tab" onclick='jwplayer().stop()'>Reviews</a></li>
								</ul>
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade in active" style="padding-top:10px;" id="photos">
										<!---<cfinvoke component="/cfcs/ultra10/vehicle_photos" method="vdp_default">
											<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
										</cfinvoke>--->
									</div>
									<div class="tab-pane fade" id="videos">
										<!---<div id='playerXcOnlhnYWkKu'></div>
										<script type='text/javascript'>
										    jwplayer('playerXcOnlhnYWkKu').setup({
										        file: 'http://clips.vorwaerts-gmbh.de/VfE_html5.mp4',
										        width: '100%',
										        aspectratio: '16:9'
										    });
										</script>--->
									</div>
									<div class="tab-pane fade" id="reviews">
										Reviews
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="price-block">
									<cfinvoke component="/cfcs/ultra10/vehicle_pricing" method="vdp_default">
										<cfinvokeargument name="Selling_Price_Label" value="#Get_Vehicle_Details.Selling_Price_Label#"/>
										<cfinvokeargument name="Selling_Price" value="#Get_Vehicle_Details.Selling_Price#"/>
										<cfinvokeargument name="MSRP_Label" value="#Get_Vehicle_Details.MSRP_Label#"/>
										<cfinvokeargument name="MSRP_Price" value="#Get_Vehicle_Details.MSRP_Price#"/>
										<cfinvokeargument name="Rebate_Label" value="#Get_Vehicle_Details.Rebate_Label#"/>
										<cfinvokeargument name="Rebate_Price" value="#Get_Vehicle_Details.Rebate_Price#"/>
										<cfinvokeargument name="Incentive_Label" value="#Get_Vehicle_Details.Incentive_Label#"/>
										<cfinvokeargument name="Incentive_Price" value="#Get_Vehicle_Details.Incentive_Price#"/>
										<cfinvokeargument name="Savings_Label" value="#Get_Vehicle_Details.Savings_Label#"/>
										<cfinvokeargument name="Savings_Price" value="#Get_Vehicle_Details.Savings_Price#"/>
										<cfinvokeargument name="AIS_Label" value="#Get_Vehicle_Details.AIS_Label#"/>
										<cfinvokeargument name="AIS_Price" value="#Get_Vehicle_Details.AIS_Price#"/>
										<cfinvokeargument name="AIS_APR" value="#Get_Vehicle_Details.AIS_APR#"/>
									</cfinvoke>
								</div>
								<div class="row visible-xs visible-sm">
									<div class="vdp-form-mobile">
										<div class="vdp-form-title">REQUEST A QUOTE</div>
										<cfinvoke component="/cfcs/forms/form_quote" method="qq_default">
											<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
											<cfinvokeargument name="VOI_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
											<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
										</cfinvoke>
									</div>
									<cfswitch expression="#arguments.vdp_btns#">
										<cfdefaultcase>
											<cfinvoke component="/cfcs/ultra10/vehicle_btns" method="vdp_standard">
												<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
											</cfinvoke>
										</cfdefaultcase>
										<cfcase value="1">
											Custom Button Layout xxx
										</cfcase>
									</cfswitch>
								</div>
								<div class="vdp-text">
									<cfinvoke component="/cfcs/ultra10/vehicle_specs" method="vdp_default">
										<cfinvokeargument name="New_Used" value="#variables.New_Used#"/>
										<cfinvokeargument name="Stock" value="#Get_Vehicle_Details.Stock#"/>
										<cfinvokeargument name="Model_Number" value="#Get_Vehicle_Details.V_Model_Number#"/>
										<cfinvokeargument name="Vin" value="#Get_Vehicle_Details.Vin#"/>
										<cfinvokeargument name="V_Body" value="#Get_Vehicle_Details.V_Style#"/>
										<cfinvokeargument name="V_Type" value="#Get_Vehicle_Details.V_Type#"/>
										<cfinvokeargument name="Engine_Size" value="#Get_Vehicle_Details.Engine_Size#"/>
										<cfinvokeargument name="V_Body" value="#Get_Vehicle_Details.V_Style#"/>
										<cfinvokeargument name="V_Type" value="#Get_Vehicle_Details.V_Type#"/>
										<cfinvokeargument name="Cylinders" value="#Get_Vehicle_Details.Cylinders#"/>
										<cfinvokeargument name="Transmission" value="#Get_Vehicle_Details.Transmission#"/>
										<cfinvokeargument name="Drivetrain" value="#Get_Vehicle_Details.Drivetrain#"/>
										<cfinvokeargument name="Odometer" value="#Get_Vehicle_Details.V_Odometer#"/>
										<cfinvokeargument name="Fuel_Type" value="#Get_Vehicle_Details.Fuel_Type#"/>
										<cfinvokeargument name="EPA_City" value="#Get_Vehicle_Details.EPA_City#"/>
										<cfinvokeargument name="EPA_HWY" value="#Get_Vehicle_Details.EPA_HWY#"/>
										<cfinvokeargument name="Exterior_Color" value="#Get_Vehicle_Details.Exterior_Color#"/>
										<cfinvokeargument name="Interior_Color" value="#Get_Vehicle_Details.Interior_Color#"/>
										<cfinvokeargument name="Doors" value="#Get_Vehicle_Details.Doors#"/>
										<cfinvokeargument name="Passengers" value="#Get_Vehicle_Details.Passengers#"/>
										<cfinvokeargument name="Location" value="#Get_Vehicle_Details.Dealer_Display_Name#"/>
									</cfinvoke>
								</div>
							</div>
						</div>
						<div class="row vdp-options-box visible-md visible-lg">
							<cfif len(trim(Get_Vehicle_Details.Dealer_Comments)) gt 0>
								<div class="col-md-12 vdp-text vdp-pad-10">
									<b>DEALER COMMENTS:</b>
								</div>
								<div class="col-md-12 vdp-comments vdp-text-sm">
									#Get_Vehicle_Details.Dealer_Comments#	
								</div>
							</cfif>
							<div class="col-md-12 vdp-text vdp-pad-10">
								<b>VEHICLE DETAILS:</b>
							</div>
							<div class="col-md-12 vdp-text-sm vdp-options-div">
								<cfinvoke component="/cfcs/ultra10/vehicle_options" method="vdp_default">
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
							<cfif len(trim(Get_Vehicle_Details.Dealer_Comments)) gt 0>
								<div class="col-md-12 vdp-text vdp-pad-10">
									<b>DEALER COMMENTS:</b>
								</div>
								<div class="col-md-12 vdp-text-sm">
									#Get_Vehicle_Details.Dealer_Comments#	
								</div>
							</cfif>
							<div class="col-md-12 vdp-text vdp-pad-10">
								<b>VEHICLE DETAILS:</b>
							</div>
							<div class="col-md-12 vdp-text-sm ">
								<cfinvoke component="/cfcs/ultra10/vehicle_options" method="vdp_mobile">
									<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
									<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
									<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
									<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
									<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
									<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
								</cfinvoke>
							</div>							
						</div>
						<div class="row">
							Calculator
						</div>
					</div>
					<div class="col-md-3 visible-md visible-lg vdp-text-sm">
						<div class="vdp-store">
							<cfinvoke component="/cfcs/ultra10/vehicle_store" method="vdp_default">
								<cfinvokeargument name="Dealer_Display_Name" value="#Get_Vehicle_Details.Dealer_Display_Name#"/>
								<cfinvokeargument name="Dealer_Address_1" value="#Get_Vehicle_Details.Dealer_Address_1#"/>
								<cfinvokeargument name="Dealer_Address_2" value="#Get_Vehicle_Details.Dealer_Address_2#"/>
								<cfinvokeargument name="Dealer_City" value="#Get_Vehicle_Details.Dealer_City#"/>
								<cfinvokeargument name="Dealer_State" value="#Get_Vehicle_Details.Dealer_State#"/>
								<cfinvokeargument name="Dealer_Zip" value="#Get_Vehicle_Details.Dealer_Zip#"/>
								<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicle_Details.Dealer_Phone#"/>
							</cfinvoke>
						</div>
						<a class="btn btn-grey">Get Hours &amp; Directions</a>
						<div class="vdp-form-box">
							<div class="vdp-form-title">REQUEST A QUOTE</div>
							<cfswitch expression="#url.form_action#">
								<cfdefaultcase>
									<cfinvoke component="/cfcs/forms/form_quote" method="qq_default">
										<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
										<cfinvokeargument name="VOI_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
									</cfinvoke>
								</cfdefaultcase>
								<cfcase value="form_submit">
									<cfif form.VOI_New_Used eq "N">
										<cfset variables.lead_type_id=4> <!---New--->
									<cfelse>
										<cfset variables.lead_type_id=6> <!---Used--->
									</cfif>
									<cfinvoke component="/cfcs/forms/form_quote" method="form_submit">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="lead_type_id" value="#variables.lead_type_id#"/>
										<cfinvokeargument name="email_subject" value="Quick Quote Request from #lcase(cgi.Server_Name)#"/>
									</cfinvoke>
								</cfcase> 
							</cfswitch>
							<cfswitch expression="#arguments.vdp_btns#">
								<cfdefaultcase>
									<cfinvoke component="/cfcs/ultra10/vehicle_btns" method="vdp_standard">
										<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
									</cfinvoke>
								</cfdefaultcase>
								<cfcase value="1">
									Custom Button Layout
								</cfcase>
							</cfswitch>
							<cfif Get_Similar.recordcount gt 0>
								<div class="vdp-form-title">SIMILAR VEHICLES</div>
								<cfinvoke component="/cfcs/ultra10/vehicle_similar" method="vdp_similar">
									<cfinvokeargument name="Get_Similar" value="#Get_Similar#"/>
								</cfinvoke>
							</cfif>
						</div>
					</div>
				</div>
			</div>			

			<div class="modal fade" id="tdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="container">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Schedule A Test Drive on this #Get_Vehicle_Details.V_Year#  #Get_Vehicle_Details.V_Make#  #Get_Vehicle_Details.V_Model#  #Get_Vehicle_Details.V_Trim#</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<div class="pop-form-box">
											<cfinvoke component="/cfcs/automall/form_test_drive" method="form_popup">
												<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
												<cfinvokeargument name="VOI_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
											</cfinvoke>
										</div>
									</div>
									<div class="col-md-6">
										<cfinvoke component="/cfcs/ultra10/vehicle_photos" method="single_photo">
											<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
											<cfinvokeargument name="img_class" value="form-img"/>
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
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Get a Quote on this #Get_Vehicle_Details.V_Year#  #Get_Vehicle_Details.V_Make#  #Get_Vehicle_Details.V_Model#  #Get_Vehicle_Details.V_Trim#</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<div class="pop-form-box">
											<cfinvoke component="/cfcs/automall/form_quick_quote" method="qq_default">
												<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
												<cfinvokeargument name="VOI_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
												<cfinvokeargument name="btn_label" value="GET MY QUICK QUOTE"/>
											</cfinvoke>
										</div>
									</div>
									<div class="col-md-6">
										<cfinvoke component="/cfcs/ultra10/vehicle_photos" method="single_photo">
											<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
											<cfinvokeargument name="img_class" value="form-img"/>
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
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Send this #Get_Vehicle_Details.V_Year#  #Get_Vehicle_Details.V_Make#  #Get_Vehicle_Details.V_Model#  #Get_Vehicle_Details.V_Trim# to a Friend</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<div class="pop-form-box">
											<cfinvoke component="/cfcs/forms/form_send_friend" method="qq_default">
												<cfinvokeargument name="VOI_Vin" value="#Get_Vehicle_Details.Vin#"/>
												<cfinvokeargument name="VOI_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
												<cfinvokeargument name="btn_label" value="SEND NOW"/>
											</cfinvoke>
										</div>
									</div>
									<div class="col-md-6">
										<cfinvoke component="/cfcs/ultra10/vehicle_photos" method="single_photo">
											<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
											<cfinvokeargument name="img_class" value="form-img"/>
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

		</section>
	
	</cffunction>

	<cffunction name="data" description="shows unformated vehicle data" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="v_vin" required="true">

		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.v_vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>

		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@var" value="#left(arguments.v_vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Options" resultset="1">
		</cfstoredproc>
		
		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#Get_Vehicle_Details.V_New_Used#">
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

		
		<section>
			
			<div class="container">

				<!---
				<div class="row">
					<div class="col-md-12">
						<li><b>Vehicle ID:</b> #Get_Vehicle_Details.Vehicle_ID#</li>
						<li><b>Dealer ID:</b> #Get_Vehicle_Details.Dealer_ID#</li>
						<li><b>Permalink:</b> #Get_Vehicle_Details.Permalink#</li>
						<li><b>Number of Photos:</b> #listlen(Get_Vehicle_Details.Img_Urls)#</li>
						<li><b>Img Urls:</b></li>
						<cfif len(trim(Get_Vehicle_Details.Img_Urls)) gt 0>
							<ol>
								<cfloop list="#Get_Vehicle_Details.Img_Urls#" index="i">
									<li>#variables.i#</li>
								</cfloop> 
							</ol>
						</cfif>
					</div>
				</div>
				--->

				<div class="row">
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12">
								<h1 title="#Get_Vehicle_Details.V_Year# #Get_Vehicle_Details.V_Make# #Get_Vehicle_Details.V_Model# #Get_Vehicle_Details.V_Trim#">#Get_Vehicle_Details.V_Year# #Get_Vehicle_Details.V_Make# #Get_Vehicle_Details.V_Model# #Get_Vehicle_Details.V_Trim#</h1>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div style="padding:10px;">
									<cfinvoke component="/cfcs/ultra10/vehicle_photos" method="single_photo">
										<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
										<cfinvokeargument name="img_title" value="#Get_Vehicle_Details.V_Year# #Get_Vehicle_Details.V_Make# #Get_Vehicle_Details.V_Model# #Get_Vehicle_Details.V_Trim#"/>
									</cfinvoke>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="col-md-6">
									<cfinvoke component="/cfcs/ultra10/vehicle_store" method="vdp_default">
										<cfinvokeargument name="Dealer_Display_Name" value="#Get_Vehicle_Details.Dealer_Display_Name#"/>
										<cfinvokeargument name="Dealer_Address_1" value="#Get_Vehicle_Details.Dealer_Address_1#"/>
										<cfinvokeargument name="Dealer_Address_2" value="#Get_Vehicle_Details.Dealer_Address_2#"/>
										<cfinvokeargument name="Dealer_City" value="#Get_Vehicle_Details.Dealer_City#"/>
										<cfinvokeargument name="Dealer_State" value="#Get_Vehicle_Details.Dealer_State#"/>
										<cfinvokeargument name="Dealer_Zip" value="#Get_Vehicle_Details.Dealer_Zip#"/>
										<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicle_Details.Dealer_Phone#"/>
									</cfinvoke>						
								</div>
								<div class="col-md-6">
									<cfinvoke component="/cfcs/ultra10/vehicle_pricing" method="vdp_default">
										<cfinvokeargument name="Selling_Price_Label" value="#Get_Vehicle_Details.Selling_Price_Label#"/>
										<cfinvokeargument name="Selling_Price" value="#Get_Vehicle_Details.Selling_Price#"/>
										<cfinvokeargument name="MSRP_Label" value="#Get_Vehicle_Details.MSRP_Label#"/>
										<cfinvokeargument name="MSRP_Price" value="#Get_Vehicle_Details.MSRP_Price#"/>
										<cfinvokeargument name="Rebate_Label" value="#Get_Vehicle_Details.Rebate_Label#"/>
										<cfinvokeargument name="Rebate_Price" value="#Get_Vehicle_Details.Rebate_Price#"/>
										<cfinvokeargument name="Incentive_Label" value="#Get_Vehicle_Details.Incentive_Label#"/>
										<cfinvokeargument name="Incentive_Price" value="#Get_Vehicle_Details.Incentive_Price#"/>
										<cfinvokeargument name="Savings_Label" value="#Get_Vehicle_Details.Savings_Label#"/>
										<cfinvokeargument name="Savings_Price" value="#Get_Vehicle_Details.Savings_Price#"/>
										<cfinvokeargument name="AIS_Label" value="#Get_Vehicle_Details.AIS_Label#"/>
										<cfinvokeargument name="AIS_Price" value="#Get_Vehicle_Details.AIS_Price#"/>
										<cfinvokeargument name="AIS_APR" value="#Get_Vehicle_Details.AIS_APR#"/>
									</cfinvoke>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<h3 title="Vehicle Specs">Vehicle Specs</h3>
								<cfinvoke component="/cfcs/ultra10/vehicle_specs" method="vdp_default">
									<cfinvokeargument name="New_Used" value="#variables.New_Used#"/>
									<cfinvokeargument name="Stock" value="#Get_Vehicle_Details.Stock#"/>
									<cfinvokeargument name="Model_Number" value="#Get_Vehicle_Details.V_Model_Number#"/>
									<cfinvokeargument name="Vin" value="#Get_Vehicle_Details.Vin#"/>
									<cfinvokeargument name="V_Body" value="#Get_Vehicle_Details.V_Style#"/>
									<cfinvokeargument name="V_Type" value="#Get_Vehicle_Details.V_Type#"/>
									<cfinvokeargument name="Engine_Size" value="#Get_Vehicle_Details.Engine_Size#"/>
									<cfinvokeargument name="V_Body" value="#Get_Vehicle_Details.V_Style#"/>
									<cfinvokeargument name="V_Type" value="#Get_Vehicle_Details.V_Type#"/>
									<cfinvokeargument name="Cylinders" value="#Get_Vehicle_Details.Cylinders#"/>
									<cfinvokeargument name="Transmission" value="#Get_Vehicle_Details.Transmission#"/>
									<cfinvokeargument name="Drivetrain" value="#Get_Vehicle_Details.Drivetrain#"/>
									<cfinvokeargument name="Odometer" value="#Get_Vehicle_Details.V_Odometer#"/>
									<cfinvokeargument name="Fuel_Type" value="#Get_Vehicle_Details.Fuel_Type#"/>
									<cfinvokeargument name="EPA_City" value="#Get_Vehicle_Details.EPA_City#"/>
									<cfinvokeargument name="EPA_HWY" value="#Get_Vehicle_Details.EPA_HWY#"/>
									<cfinvokeargument name="Exterior_Color" value="#Get_Vehicle_Details.Exterior_Color#"/>
									<cfinvokeargument name="Interior_Color" value="#Get_Vehicle_Details.Interior_Color#"/>
									<cfinvokeargument name="Doors" value="#Get_Vehicle_Details.Doors#"/>
									<cfinvokeargument name="Passengers" value="#Get_Vehicle_Details.Passengers#"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<h3 title="Dealer Comments">Dealer Comments</h3>
								#Get_Vehicle_Details.Dealer_Comments#
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<h3 title="Vehicle Options">Vehicle Options</h3>
						<div style="padding:0px 0px 0px 20px">
							<cfinvoke component="/cfcs/ultra10/vehicle_options" method="vdp_mobile">
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
				<div class="col-md-12" align="center">
					<a class="btn btn-navy" href="##" onclick="javascript:window.print();" title="CLICK HERE TO PRINT">CLICK HERE TO PRINT</a>
				</div>
			</div>
			
		<section>
			
		<script>
			window.print()
		</script>

	</cffunction>

</cfcomponent>