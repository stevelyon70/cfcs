<cfoutput>

<cfset price_alert = 1>
	<cfquery name="get_car" datasource="Ultra10" >
		SELECT     Vehicle_ID, Dealer_ID, Vin, Stock, Permalink, Img_Urls, Video_Link, V_New_Used, V_Year, V_Make, V_Model, V_Trim, V_Odometer, V_Model_Number, 
		           V_Type, V_Style, Interior_Color, Exterior_Color, Transmission, Engine_Size, Cylinders, Doors, Drivetrain, Passengers, Dealer_Comments, Fuel_Type, EPA_City, 
		           EPA_HWY, Adjusted_Baseline, Selling_Price_Label, Selling_Price, MSRP_Label, MSRP_Price, Rebate_Label, Rebate_Price, Incentive_Label, Incentive_Price, 
		           Savings_Label, Savings_Price, AIS_Label, AIS_Price, AIS_APR, Certified, Fleet, Luxury, Commercial, Carfax_One_Owner, Autocheck, Dealer_Display_Name, 
		           Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Url, Link_Finance, Link_Service, Link_Sales, Link_Parts, 
		           Link_Directions, Disclaimer, AIS_wID, half_year, V_Half_Year, Date_Updated, User_Edit, Region_ID, Util_fld, LotVantage_Video, dsp_new_used, Date_in_Stock, 
		           Special_Invoice
		FROM       Vehicles
		where Vehicle_ID = #url.v_id#
	</cfquery>
	
	<!---Set Condition in Regular Speak--->
	<cfswitch expression="#get_car.V_New_Used#">
		<cfdefaultcase>
			<cfset variables.itype="Used">
		</cfdefaultcase>
		<cfcase value="N">
			<cfset variables.itype="New">
		</cfcase>
	</cfswitch>
	
	<cfif len(trim(get_car.Permalink)) gt 0 and len(trim(get_car.V_Make)) gt 0 and len(trim(get_car.V_Model)) gt 0 >
		<cfset variables.v_link="#lcase(get_car.V_Make)#/#lcase(get_car.V_Model)#/#lcase(get_car.Permalink)#?itype=#variables.itype#">
	<cfelse>
		<cfset variables.v_link="vehicle_details.cfm?vin=#get_car.Vin#">
	</cfif>

	<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">

	<cfset active_class = ArrayNew(1) >
	<cfset content_active_class = ArrayNew(1) >
	<cfloop index="x" from="1" to="4" ><cfset active_class[x] = "" ><cfset content_active_class[x] = "" ></cfloop>

	<cfif #len(get_car.Dealer_Comments)# GT 1 AND  #left(get_car.Dealer_Comments, 2)# NEQ "  " >		
		<div class="container-fluid">
			<section class="section-internal-video">
				<div class="container">
					<div class="row">  
						<div class="col-md-12 pad-bottom-10 visible-lg visible-md visible-sm visible-xs"  align="left">
							<ul class="nav nav-tabs"> 
								<cfif #arguments.Dealer_Comments# NEQ "" >
							  		<li> <a class="#active_class[1]# nav-tabs" data-toggle="tab" href="##tab1_#url.currentRow#"><h5><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;<b>DEALER COMMENTS</b></h5></a></li>
								</cfif>
							</ul>
							<div class="tab-content">
								<div id="tab1_#url.currentRow#" class="tab-pane fade #content_active_class[1]#">
									<p>#get_car.Dealer_Comments#	
									<div align="left" ><a data-toggle="tab" href="##tabclear_#url.currentRow#"><span  style="font-weight:bold;color:red!important;">Close</span></a></div></p>
								</div>
								<div id="tabclear_#url.currentRow#" class="tab-pane fade "></div>   <!--- Content Close --->
							</div>
						</div>
					</div> 
			   </div>
			</section>
		</div>	
	</cfif>	
</cfoutput>