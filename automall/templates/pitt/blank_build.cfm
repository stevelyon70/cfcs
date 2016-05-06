<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="vin" required="true">
		<cfargument name="Get_Page_Content" required="true"/>

		<cfinvoke component="/cfcs/automall/build_header" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<cfinvoke component="/cfcs/automall/build_nav" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<cfif len(trim(Get_Page_Content.top_ad)) gt 0>
			<section class="section-ad-leaderboard">
				<div class="container ad-leaderboard">
					<div class="row">
						<div class="col-md-12" align="center">
							<div class="ad-ldr">
								#Get_Page_Content.top_ad#
							</div>
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Automall" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.vin,17)#" maxlength="21">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="2">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>
		
		<section class="section-vdp">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
					</div>
				</div>
				<cfinvoke component="/cfcs/automall/vehicle" method="vdp">
					<cfinvokeargument name="Get_Page_Content" value="#arguments.Get_Page_Content#"/>
					<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
					<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
					<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
					<cfinvokeargument name="Dealer_ID" value="#Get_Vehicle_Details.Dealer_ID#"/>
					<cfinvokeargument name="Vin" value="#Get_Vehicle_Details.Vin#"/>
					<cfinvokeargument name="Stock" value="#Get_Vehicle_Details.Stock#"/>
					<cfinvokeargument name="V_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
					<cfinvokeargument name="V_Year" value="#Get_Vehicle_Details.V_Year#"/>
					<cfinvokeargument name="V_Make" value="#Get_Vehicle_Details.V_Make#"/>
					<cfinvokeargument name="V_Model" value="#Get_Vehicle_Details.V_Model#"/>
					<cfinvokeargument name="V_Trim" value="#Get_Vehicle_Details.V_Trim#"/>
					<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
					<cfinvokeargument name="New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
					<cfinvokeargument name="Model_Number" value="#Get_Vehicle_Details.V_Model_Number#"/>
					<cfinvokeargument name="V_Body" value="#Get_Vehicle_Details.V_Style#"/>
					<cfinvokeargument name="V_Type" value="#Get_Vehicle_Details.V_Type#"/>
					<cfinvokeargument name="Engine_Size" value="#Get_Vehicle_Details.Engine_Size#"/>
					<cfinvokeargument name="V_Style" value="#Get_Vehicle_Details.V_Style#"/>
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
					<cfinvokeargument name="Dealer_Display_Name" value="#Get_Vehicle_Details.Dealer_Display_Name#"/>
					<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicle_Details.Dealer_Comments#"/>
					<cfinvokeargument name="Dealer_Address_1" value="#Get_Vehicle_Details.Dealer_Address_1#"/>
					<cfinvokeargument name="Dealer_Address_2" value="#Get_Vehicle_Details.Dealer_Address_2#"/>
					<cfinvokeargument name="Dealer_City" value="#Get_Vehicle_Details.Dealer_City#"/>
					<cfinvokeargument name="Dealer_State" value="#Get_Vehicle_Details.Dealer_State#"/>
					<cfinvokeargument name="Dealer_Zip" value="#Get_Vehicle_Details.Dealer_Zip#"/>
					<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicle_Details.Inv_Phone#"/>
					<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicle_Details.Dealer_Comments#"/>
					<cfinvokeargument name="Dealer_Url" value="#Get_Vehicle_Details.Dealer_Url#"/>
				</cfinvoke>
				<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Page_Content.page_footer#
						</div>
					</div>
				</cfif>
			</div>
		</section>

		<cfinvoke component="/cfcs/automall/build_footer" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>
		
	</cffunction>

</cfcomponent>