<cfcomponent>

	<cffunction name="modern_standard" description="create standard vdp page" output="yes" access="public">

		<!---arguments--->
		<cfargument name="Get_Vehicle_Details" required="true">
		
		<!--- Check VDP Style 12/21/2015--->
				<cfset vdp_style = 0 >
				<cfquery datasource="ultra10" name="chk_vdp_style">SELECT vdp_type FROM Dealers WHERE dealer_id = #url.dealer_id# AND	( vdp_type = 1 OR vdp_type = 2 )</cfquery>
				<cfif #chk_vdp_style.recordcount# NEQ 0 ><cfset vdp_style = #chk_vdp_style.vdp_type# ></cfif>	
		<!--- Check VDP Style 12/21/2015--->	 
  <cfif #url.dealer_id# EQ 365 AND #cgi.server_name# EQ "4ultra10.wddemos.com" ><cfset vdp_style = "2" ></cfif>	 			
		<cfif #vdp_style# EQ 0 >
				<cfinvoke component="/cfcs/vehicles/vehicle" method="vdp">
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="Vehicle_ID" value="#Get_Vehicle_Details.Vehicle_ID#"/>
					<cfinvokeargument name="Dealer_ID" value="#Get_Vehicle_Details.Dealer_ID#"/>
					<cfinvokeargument name="Vin" value="#Get_Vehicle_Details.Vin#"/>
					<cfinvokeargument name="Stock" value="#Get_Vehicle_Details.Stock#"/>
					<cfinvokeargument name="V_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
					<cfinvokeargument name="V_Year" value="#Get_Vehicle_Details.V_Year#"/>
					<cfinvokeargument name="V_Make" value="#Get_Vehicle_Details.V_Make#"/>
					<cfinvokeargument name="V_Model" value="#Get_Vehicle_Details.V_Model#"/>
					<cfinvokeargument name="V_Trim" value="#Get_Vehicle_Details.V_Trim#"/>
					<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
					<cfinvokeargument name="Video_Link" value="#Get_Vehicle_Details.Video_Link#"/>
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
					<cfinvokeargument name="Adjusted_Baseline" value="#Get_Vehicle_Details.Adjusted_Baseline#"/>
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
					<cfinvokeargument name="Carfax_One_Owner" value="#Get_Vehicle_Details.Carfax_One_Owner#"/>
					<cfinvokeargument name="Autocheck" value="#Get_Vehicle_Details.Autocheck#"/>			
					<cfinvokeargument name="Disclaimer" value="#Get_Vehicle_Details.Disclaimer#"/>
					<cfinvokeargument name="Certified" value="#Get_Vehicle_Details.Certified#"/>
					<cfinvokeargument name="AIS_wID" value="#Get_Vehicle_Details.AIS_wID#"/>
					<cfinvokeargument name="half_year" value="#Get_Vehicle_Details.half_year#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
				</cfinvoke>
			<cfelse>	
				<cfinvoke component="/cfcs/vehicles/vehicle_alt1" method="vdp">
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="Vehicle_ID" value="#Get_Vehicle_Details.Vehicle_ID#"/>
					<cfinvokeargument name="Dealer_ID" value="#Get_Vehicle_Details.Dealer_ID#"/>
					<cfinvokeargument name="Vin" value="#Get_Vehicle_Details.Vin#"/>
					<cfinvokeargument name="Stock" value="#Get_Vehicle_Details.Stock#"/>
					<cfinvokeargument name="V_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
					<cfinvokeargument name="V_Year" value="#Get_Vehicle_Details.V_Year#"/>
					<cfinvokeargument name="V_Make" value="#Get_Vehicle_Details.V_Make#"/>
					<cfinvokeargument name="V_Model" value="#Get_Vehicle_Details.V_Model#"/>
					<cfinvokeargument name="V_Trim" value="#Get_Vehicle_Details.V_Trim#"/>
					<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
					<cfinvokeargument name="Video_Link" value="#Get_Vehicle_Details.Video_Link#"/>
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
					<cfinvokeargument name="Adjusted_Baseline" value="#Get_Vehicle_Details.Adjusted_Baseline#"/>
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
					<cfinvokeargument name="Carfax_One_Owner" value="#Get_Vehicle_Details.Carfax_One_Owner#"/>
					<cfinvokeargument name="Autocheck" value="#Get_Vehicle_Details.Autocheck#"/>			
					<cfinvokeargument name="Disclaimer" value="#Get_Vehicle_Details.Disclaimer#"/>
					<cfinvokeargument name="Certified" value="#Get_Vehicle_Details.Certified#"/>
					<cfinvokeargument name="AIS_wID" value="#Get_Vehicle_Details.AIS_wID#"/>
					<cfinvokeargument name="half_year" value="#Get_Vehicle_Details.half_year#"/>
					<cfinvokeargument name="on_lot_status" value=""/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
				</cfinvoke>
			</cfif>		
<cfif url.dealer_id eq 365>
<!--AutoHook New VDP Script--> 
<script type="text/javascript">
var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
var hl_script = document.createElement("script");
hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/kelly/Delivery.aspx?SiteID=15975131&PgID=<cfif #url.new_used# eq "N">new_details</cfif><cfif #url.new_used# eq "U">used_details</cfif>';
hl_script.type = 'text/javascript';
hl_script.id = "HL_ScriptCall";
document.getElementsByTagName('head')[0].appendChild(hl_script);
</script>
<!--End AutoHook New VDP Script-->
<!--End AutoHook New SRP Script--> 
</cfif>
<cfif url.dealer_id eq 34>
<!--AutoHook New VDP Script--> 
<script type="text/javascript">
var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
var hl_script = document.createElement("script");
hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/kelly/Delivery.aspx?SiteID=123487&PgID=<cfif #url.new_used# eq "N">new_details</cfif><cfif #url.new_used# eq "U">used_details</cfif>';
hl_script.type = 'text/javascript';
hl_script.id = "HL_ScriptCall";
document.getElementsByTagName('head')[0].appendChild(hl_script);
</script>
<!--End AutoHook New VDP Script-->
<!--End AutoHook New SRP Script--> 
</cfif>
<cfif url.dealer_id eq 32>
<!--AutoHook New VDP Script--> 
<script type="text/javascript">
var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
var hl_script = document.createElement("script");
hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/kelly/Delivery.aspx?SiteID=1184725&PgID=<cfif #url.new_used# eq "N">new_details</cfif><cfif #url.new_used# eq "U">used_details</cfif>';
hl_script.type = 'text/javascript';
hl_script.id = "HL_ScriptCall";
document.getElementsByTagName('head')[0].appendChild(hl_script);
</script>
<!--End AutoHook New VDP Script-->
<!--End AutoHook New SRP Script--> 
</cfif>
	</cffunction>

	<cffunction name="legacy_standard" description="create legacy vdp page" output="yes" access="public">

		<cfinvoke component="/cfcs/vehicles/vehicle" method="vdp_legacy">
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="Vehicle_ID" value="#Get_Vehicle_Details.Vehicle_ID#"/>
			<cfinvokeargument name="Dealer_ID" value="#Get_Vehicle_Details.Dealer_ID#"/>
			<cfinvokeargument name="Vin" value="#Get_Vehicle_Details.Vin#"/>
			<cfinvokeargument name="Stock" value="#Get_Vehicle_Details.Stock#"/>
			<cfinvokeargument name="V_New_Used" value="#Get_Vehicle_Details.V_New_Used#"/>
			<cfinvokeargument name="V_Year" value="#Get_Vehicle_Details.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#Get_Vehicle_Details.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#Get_Vehicle_Details.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#Get_Vehicle_Details.V_Trim#"/>
			<cfinvokeargument name="Img_Urls" value="#Get_Vehicle_Details.Img_Urls#"/>
			<cfinvokeargument name="Video_Link" value="#Get_Vehicle_Details.Video_Link#"/>
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
			<cfinvokeargument name="Adjusted_Baseline" value="#Get_Vehicle_Details.Adjusted_Baseline#"/>
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
			<cfinvokeargument name="Carfax_One_Owner" value="#Get_Vehicle_Details.Carfax_One_Owner#"/>
			<cfinvokeargument name="Certified" value="#Get_Vehicle_Details.Certified#"/>
			<cfinvokeargument name="AIS_wID" value="#Get_Vehicle_Details.AIS_wID#"/>
			<cfinvokeargument name="half_year" value="#Get_Vehicle_Details.half_year#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
		</cfinvoke>
	
	</cffunction>

</cfcomponent>