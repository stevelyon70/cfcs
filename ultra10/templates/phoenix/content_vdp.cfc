<cfcomponent>

	<cffunction name="content" description="vdp page content" output="Yes" access="public">
 
		<!---Get Vehicle Details--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Details" resultset="1">
		</cfstoredproc>
				
		<cfinvoke component="/cfcs/ultra10/vehicles/vehicle" method="vdp">
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
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
			<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicle_Details.Dealer_Phone#"/>
			<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicle_Details.Dealer_Comments#"/>
		</cfinvoke>
				
	</cffunction>

</cfcomponent>