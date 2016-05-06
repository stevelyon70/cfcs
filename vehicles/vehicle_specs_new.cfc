<cfcomponent>

<cffunction name="new_vdp_default" description="shows default vdp pricing" output="Yes" access="public">
  
  <!--- arguments --->
  <cfargument name="New_Used" default="">
  <cfargument name="Stock" default="">
  <cfargument name="Model_Number" default="">
  <cfargument name="Vin" default="">
  <cfargument name="v_link" default="">
  <cfargument name="V_Make" default="">
  <cfargument name="V_Model" default="">
  <cfargument name="V_Body" default="">
  <cfargument name="V_Type" default="">
  <cfargument name="Engine_Size" default="">
  <cfargument name="Cylinders" default="">
  <cfargument name="Transmission" default="">
  <cfargument name="Drivetrain" default="">
  <cfargument name="Odometer" default="">
  <cfargument name="Fuel_Type" default="">
  <cfargument name="EPA_City" default="">
  <cfargument name="EPA_HWY" default="">
  <cfargument name="Exterior_Color" default="">
  <cfargument name="Interior_Color" default="">
  <cfargument name="Doors" default="2">
  <cfargument name="Passengers" default="4">
  <cfargument name="Location" default="">
  <cfargument name="Dealer_Phone" default="">
  <cfargument name="Autocheck" default="0" />
  <cfargument name="Vehicle_ID" default="" />
  <cfargument name="came_from" default="0" />
   
  <!---Set Condition in Regular Speak--->
  <cfswitch expression="#arguments.New_Used#">
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
 
	 <cfquery name="get_car" datasource="Ultra10" >
		SELECT     Vehicle_ID, Dealer_ID, Vin, Stock, Permalink, Img_Urls, Video_Link, V_New_Used, V_Year, V_Make, V_Model, V_Trim, V_Odometer, V_Model_Number, 
		           V_Type, V_Style, Interior_Color, Exterior_Color, Transmission, Engine_Size, Cylinders, Doors, Drivetrain, Passengers, Dealer_Comments, Fuel_Type, EPA_City, 
		           EPA_HWY, Adjusted_Baseline, Selling_Price_Label, Selling_Price, MSRP_Label, MSRP_Price, Rebate_Label, Rebate_Price, Incentive_Label, Incentive_Price, 
		           Savings_Label, Savings_Price, AIS_Label, AIS_Price, AIS_APR, Certified, Fleet, Luxury, Commercial, Carfax_One_Owner, Autocheck, Dealer_Display_Name, 
		           Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Url, Link_Finance, Link_Service, Link_Sales, Link_Parts, 
		           Link_Directions, Disclaimer, AIS_wID, half_year, V_Half_Year, Date_Updated, User_Edit, Region_ID, Util_fld, LotVantage_Video, dsp_new_used, Date_in_Stock, 
		           Special_Invoice,on_lot_status
		FROM       Vehicles
		where Vin = '#arguments.vin#'
	</cfquery>  
	
	<cfset status_msg = "IN STOCK" >

	 <cfif #LCase(get_car.on_lot_status)# EQ "in-transit" >
		<cfset status_msg = "IN TRANSIT" >
	</cfif>   
	
	
<cfif #arguments.came_from# EQ 1 >			<!--- From VDP --->
	<div class="container-fluid">
		<section class="section-internal-video">
			<div class="container" >
				<div class="row pad-top-10" >
			 		<div class="col-md-3" align="left">
						<cfinvoke component="/cfcs/vehicles/vehicle_store" method="vdp_default">
							<cfinvokeargument name="Dealer_Display_Name" value="#get_car.Dealer_Display_Name#"/>
							<cfinvokeargument name="Dealer_Address_1" value="#get_car.Dealer_Address_1#"/>
							<cfinvokeargument name="Dealer_Address_2" value="#get_car.Dealer_Address_2#"/>
							<cfinvokeargument name="Dealer_City" value="#get_car.Dealer_City#"/>
							<cfinvokeargument name="Dealer_State" value="#get_car.Dealer_State#"/>
							<cfinvokeargument name="Dealer_Zip" value="#get_car.Dealer_Zip#"/>
						  	<cfinvokeargument name="Dealer_Phone" value="#get_car.Dealer_Phone#"/> 
						</cfinvoke>
					</div>
			 		<div class="col-md-9" align="left">
						<h5><b>KEY FEATURES:</b></h5>
						<div class="row" >
					 		<div class="col-md-4">
						  		Condition: <span itemprop="itemCondition">#variables.New_Used#</span> | <span class="txt-green"><b>#status_msg#</b></span>
						 	</div>
							<div class="col-md-4">
						     Engine Size: <span itemprop="name">#arguments.Engine_Size#</span> 
						 	</div>
							
					 		<div class="col-md-4">
					    		 Vehicle Type: <span itemprop="vehicletype">#arguments.V_Type#</span>
							 </div>
<!--- 					 		<div class="col-md-4">
					    		 MPG Range: <span itemprop="fuelEfficiency">#arguments.EPA_City#/#arguments.EPA_HWY#</span>
							 </div> --->
						</div>	
						<div class="row">
					 		<div class="col-md-4">
					    		Stock ##: #arguments.Stock#
						 	</div>
							<div class="col-md-4">
							    Transmission: <span itemprop="vehicleTransmission">#arguments.Transmission#</span>
							</div>	
							<div class="col-md-4"> 
					 			 Exterior Color: <span itemprop="color">#arguments.Exterior_Color#</span> 
						 	</div>
						</div>
						
						<div class="row">
					 		<div class="col-md-4">
					    		VIN: #arguments.vin#
						 	</div>
					 		<div class="col-md-4">
								Drivetrain: #arguments.Drivetrain#
							</div>	
					 		<div class="col-md-4">
						      	Interior Color: <span itemprop="vehicleInteriorColor">#arguments.Interior_Color#</span> 
							</div>	
					 		
						</div>	
						<div class="row">
					 		<div class="col-md-4">
					    		Model ##: <span itemprop="model">#arguments.Model_Number#</span>
						 	</div>
					 		<div class="col-md-4">
						     	&nbsp;
							</div>	
					 		<div class="col-md-4">
					   			&nbsp; 
							</div>	
						</div>	
						
					</div>
				</div>	
			</div>
			<div class="row pad-top-10">&nbsp;</div>
		</section>
	</div>			
<cfelse>			<!--- From SRP --->
	<div class="container-fluid">
		<section class="section-internal-video">
			<div class="container" >
				<div class="row" >
			 		<div class="col-md-12" align="left">
						<h5><b>KEY FEATURES:</b></h5> 
						<div class="row" >
					 		<div class="col-md-4">
						  		Condition: <span itemprop="itemCondition">#variables.New_Used#</span> | <span class="txt-green"><b>#status_msg#</b></span>
						 	</div>
							<div class="col-md-4">
						     Engine Size: <span itemprop="name">#arguments.Engine_Size#</span> 
						 	</div>
					 		<!--- <div class="col-md-4">
					    		 MPG Range: <span itemprop="fuelEfficiency">#arguments.EPA_City#/#arguments.EPA_HWY#</span>
							 </div> --->
					 		<div class="col-md-4">
					    		 Vehicle Type: <span itemprop="vehicletype">#arguments.V_Type#</span>
							 </div>
						</div>	
						<div class="row">
					 		<div class="col-md-4">
					    		Stock ##: #arguments.Stock#
						 	</div>
							<div class="col-md-4">
							   Transmission: <span itemprop="vehicleTransmission">#arguments.Transmission#</span>
							</div>	
							<div class="col-md-4"> 
					 			 Exterior Color: <span itemprop="color">#arguments.Exterior_Color#</span> 
						 	</div>
						</div>
						
						<div class="row">
					 		<div class="col-md-4">
					    		VIN: #arguments.vin#
						 	</div>
					 		<div class="col-md-4">
								Drivetrain: #arguments.Drivetrain#
							</div>	
					 		<div class="col-md-4">
						      	Interior Color: <span itemprop="vehicleInteriorColor">#arguments.Interior_Color#</span> 
							</div>	
					 		
						</div>	
						<div class="row">
					 		<div class="col-md-4">
					    		Model ##: <span itemprop="model">#arguments.Model_Number#</span>
						 	</div>
					 		<div class="col-md-4">
						     	&nbsp;
							</div>	
					 		<div class="col-md-4">
					   			&nbsp; 
							</div>	
						</div>	
						
					</div>
				</div>
			</div>
		</section>
	</div>			
</cfif>	

  
</cffunction>

</cfcomponent>
