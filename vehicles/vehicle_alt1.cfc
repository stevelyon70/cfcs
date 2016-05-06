<cfcomponent>

	<cffunction name="srp" description="search results page" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Vehicle_ID" required="true"/>
		<cfargument name="Dealer_ID" required="true"/>
		<cfargument name="Permalink" default="" />
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
		<cfargument name="Get_Dealers_Geo" default="" />
		<cfargument name="My_Zip" default="" />
		<cfargument name="Carfax_One_Owner" default="0" />
		<cfargument name="Autocheck" default="0" />
		<cfargument name="Disclaimer" default="" />
		<cfargument name="Certified" default="0"/>
		<cfargument name="AIS_wID" default=""/>
		<cfargument name="half_year" default="0"/>

		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#arguments.New_Used#">
			<cfdefaultcase>
				<cfset variables.itype="Used">
			</cfdefaultcase>
			<cfcase value="N">
				<cfset variables.itype="New">
			</cfcase>
		</cfswitch>
		<cfif arguments.Certified eq 1>
			<cfset variables.itype="Certified">
		</cfif>
		
<!--- Check SRP Style --->
		<cfset srp_style = 0 >
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srp_type,vdp_type FROM Dealers WHERE dealer_id = #url.dealer_id# AND srp_type = 1 </cfquery>
		<cfif #chk_srp_style.recordcount# NEQ 0 ><cfset srp_style = 1 ></cfif>		 
		
		<!--- SRP Marketing flag --->
		<cfset nbr_banners = 0 >	<!--- DEFAULT  --->
		<cfquery datasource="ultra10" name="srp_mrkt">SELECT srp_marketing FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfif #srp_mrkt.srp_marketing# NEQ 0 >
			<cfset nbr_banners = #srp_mrkt.srp_marketing# >
		</cfif>
		
		<cfif arguments.V_Model eq "FourRunner">
			<cfset arguments.V_Model="4Runner">
		</cfif>
		
		<!--- Check on lot status 12/22/2015 --->
		<cfquery name="on_lot" datasource="Ultra10" >SELECT on_lot_status FROM Vehicles	where Vin = '#arguments.vin#' </cfquery>  
		<cfset status_msg = "IN STOCK" ><cfif #LCase(on_lot.on_lot_status)# EQ "in-transit" ><cfset status_msg = "IN TRANSIT" ></cfif> 
		<!--- Check on lot status 12/22/2015 --->  
		
		<cfset Get_Dealers_Zip=arguments.Get_Dealers_Zip>
		
		<cfset Get_Dealers_Geo=arguments.Get_Dealers_Geo>

		<cfif arguments.half_year eq 1>
			<cfset arguments.V_Year=arguments.V_Year & ".5">
		</cfif>

		<!--- Classic Cars --->
		<cfif IsDefined("url.classic") AND #url.classic# NEQ "" >
			<cfset url.classic=#url.classic#>
		<cfelse>
			<cfset url.classic="">
		</cfif>  
		
		
<!--- start row --->	
	<div class="row">
		<div class="col-md-12 srp-row">
			<div class="row">
				<div class="col-md-3">
					<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
						<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#?itype=#variables.itype#">
					<cfelse>
						<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.Vin#&itype=#variables.itype#">
					</cfif>
					<cfif #arguments.V_Make# eq "lincoln" >  <!--- Only LINCOLC is in upper case on SRP & VDP displays  01/14/2015 --->
						<a class="new-srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"><h7>#ucase(arguments.V_Year)# #ucase(arguments.V_Make)# #ucase(arguments.V_Model)# #ucase(arguments.V_Trim)#</h7></a><br>
					<cfelse>
						<a class="new-srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"><h7>#ucase(arguments.V_Year)# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h7></a><br>
					</cfif>
<div class="price-break"></div>
					<cfset url.frmscrn = 1 >
					<cfset url.new_used = #arguments.New_Used# >
					<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="srp_default_new">
						<cfinvokeargument name="Adjusted_Baseline" value="#arguments.Adjusted_Baseline#"/>
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
						<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
					</cfinvoke>							

					<cfif len(trim(arguments.Disclaimer)) gt 0>		<!--- 02-18-2016 --->
						<a data-toggle="modal" data-target="###arguments.Vin#Modaldisc">* Disclaimer</a><br/>
					</cfif>
					<cfif len(trim(arguments.AIS_wID)) gt 0 AND #arguments.AIS_Price# GT 0 >
						<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">
							** See Incentives
						</a><br/>
					</cfif>
                    
					<cfscript>
						priceAlertObj =  new cfcs.views.priceAlert();
							writeoutput(priceAlertObj.vehicleModule('ultra10', url.dealer_id, arguments.vin, arguments.v_make, arguments.v_model, arguments.V_New_Used, arguments.Selling_Price, arguments.v_year, arguments.v_trim, 'srp', arguments.Stock));
					</cfscript>	

					<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="srp_new">
						<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
						<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
						<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
						<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
						<cfinvokeargument name="Certified" value="#arguments.Certified#"/>
						<cfinvokeargument name="v_link" value="#variables.v_link#"/>
					</cfinvoke>
					
							
					</div>
					<div class="col-md-6" >
						<cfswitch expression="#listlen(arguments.Img_Urls)#">
							<cfdefaultcase>
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
									<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
									<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
									<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
									<cfinvokeargument name="Certified" value="#arguments.Certified#"/>
								</cfinvoke>
							</cfdefaultcase>
							<cfcase value="0">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
									<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
									<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
								</cfinvoke>
							</cfcase> 
						</cfswitch>
					
					</div>
			 		<div class="col-md-3" align="left">
						<cfinvoke component="/cfcs/vehicles/vehicle_store" method="srp_default">
							<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
							<cfinvokeargument name="Dealer_Address_1" value="#arguments.Dealer_Address_1#"/>
							<cfinvokeargument name="Dealer_Address_2" value="#arguments.Dealer_Address_2#"/>
							<cfinvokeargument name="Dealer_City" value="#arguments.Dealer_City#"/>
							<cfinvokeargument name="Dealer_State" value="#arguments.Dealer_State#"/>
							<cfinvokeargument name="Dealer_Zip" value="#arguments.Dealer_Zip#"/>
						  	<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/> 
						</cfinvoke>
						<!--- <cfif len(trim(arguments.Disclaimer)) gt 0>
							<a data-toggle="modal" data-target="###arguments.Vin#Modaldisc">* Disclaimer</a><br/>
						</cfif> --->
											
						<cfif arguments.Certified eq 1 and arguments.New_Used eq "U">
							<div class="pad-10">
								<img Alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
							</div>
						</cfif>
						
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U" > 
							<div align="center">
								<cfif arguments.Carfax_One_Owner eq 1>
									<!---one owner--->
									<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
								<cfelse>
									<!---carfax--->
									<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
								</cfif>
							</div>
						</cfif>
						<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U"  >  
							<div>
								<a class="btn btn-navy" href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">Vehicle History Report</a>
							</div>
						</cfif>
					
						<!---Video Player--->
						<cfif len(trim(arguments.Video_Link)) gt 0>
								
							<cfif #url.dealer_id# neq 36 and #url.dealer_id# neq 18 and #url.dealer_id# neq 365 >
								<div align="center"><a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"  src="http://#cgi.server_name#/images/inventory/icon_playvideo_off.png"></a></div>
							<cfelse>
								<cfif #url.dealer_id# EQ 18 or  #url.dealer_id# EQ 365 >
									<div align="center" style="margin-top:15px!important" ><a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"   src="http://dealers.wdautos.com/images/inventory/btn_LotVantage_Videos.png"/></a></div>
								<cfelse>
									<div align="center" style="margin-top:15px!important" ><a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"  src="http://#cgi.server_name#/images/inventory/icon_playvideo_off_white.png"></a></div>
								</cfif>
							</cfif>
									
						</cfif>
							
					
					
						<!--- LotVanage Videos 06/26/2015 --->		
						<cfquery name="LV_Video" datasource="ultra10" >SELECT    a.LotVantage_video, b.lv_on FROM Vehicles a, dealers b WHERE	a.vin='#arguments.Vin#' AND	a.dealer_id = b.dealer_id and b.lv_on = 1</cfquery>
						<cfif #LV_Video.LotVantage_video# NEQ "" >
							<a onclick="javascript:window.open('#LV_Video.LotVantage_video#','vehicletest','width=650px,height=500')" style="display:block;cursor:pointer;" >
							 <img Alt="Internet Special"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/btn_LotVantage_Videos.png"/></a> 
						</cfif>
						<!--- LotVanage Videos 06/26/2015 --->						

					</div>
					
				</div>	<!--- END PRIMARY ROW --->
				
				<div class="row ">
					<div class="col-md-12 pull-left no-pad">
						<cfinvoke component="/cfcs/vehicles/vehicle_specs_new" method="new_vdp_default">
							<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
							<cfinvokeargument name="Stock" value="#arguments.Stock#"/>
							<cfinvokeargument name="Model_Number" value="#arguments.Model_Number#"/>
							<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
							<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
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
							<cfinvokeargument name="v_link" value="#variables.v_link#"/>
							<cfinvokeargument name="came_from" value="0"/>
						</cfinvoke>			 
					</div>
				</div>	
				  <div class="row ">
					<div class="col-md-12">
						<cfinclude template="section_srp_details.cfm" >
					</div>
				</div>  
				<div class="row">
			 		<div class="col-md-12 srp-car-break">&nbsp;</div>	
				</div>	
			</div>
			
   
  	<cfif #nbr_banners# GT 0 and #url.car_cnt# EQ #nbr_banners# >	<!--- banner every x number of cars from Dealer Record 04-01-2016 --->
		<cfquery name="g_banner_tot" datasource="Ultra10">SELECT ID FROM Dealer_SRP_Banners where dealer_id=#url.dealer_id# AND active=1 </cfquery>
		<cfif #g_banner_tot.recordcount# NEQ 0 >
			<cfquery name="g_banner" datasource="Ultra10">SELECT ID,banner,banner_link,banner_target FROM Dealer_SRP_Banners where dealer_id=#url.dealer_id# AND banner_sequence=#url.banner_up# AND active=1</cfquery>
			<cfif #g_banner.recordcount# NEQ 0 >
				<div class="row ">
					<div class="col-md-12 col-centered" style="margin-top:5px!important;margin-bottom:5px!important;">
						<cfif #g_banner.banner_link# NEQ "" >
							<a href="#g_banner.banner_link#" target="#g_banner.banner_target#" ><img class="img-responsive" alt="" src="#g_banner.banner#"/></a>  
						<cfelse>
							<img class="img-responsive" alt="" src="#g_banner.banner#"/>
						</cfif>
						 <cfset url.car_cnt=0>
						 <cfif #url.banner_up# LT #nbr_banners# AND  #url.banner_up# LT #g_banner_tot.recordcount#>
						 	<cfset url.banner_up=#url.banner_up#+1>
						<cfelse>	
						 	<cfset url.banner_up=1>
						 </cfif>
					</div>
				</div> 
				<div class="row">
			 		<div class="col-md-12 srp-car-break">&nbsp;</div>	
				</div>	
			<cfelse>	
				<cfset url.banner_up=1>
			</cfif>
		</cfif>
	</cfif>	     
			
			
		</div>
<!--- End row --->		


		<cfif len(trim(arguments.Disclaimer)) gt 0>
			<cfinvoke component="/cfcs/ultra10/popups" method="v_disclaimer">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="#arguments.Vin#Modaldisc"/>
				<cfinvokeargument name="Disclaimer" value="#arguments.Disclaimer#"/>
			</cfinvoke>
		</cfif>
		<cfif #arguments.dealer_id# EQ 67 OR #arguments.dealer_id# EQ 288>
			<cfinvoke component="/cfcs/ultra10/popups" method="courtesy_certified">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="certModal"/>
			</cfinvoke>
		</cfif>
		 <cfif 	( 	#arguments.dealer_id# eq 1 OR 
							   			#arguments.dealer_id# eq 132 OR 
								   		#arguments.dealer_id# eq 195 OR 
									 	#arguments.dealer_id# eq 16 OR 
										#arguments.dealer_id# eq 2 OR 
										#arguments.dealer_id# eq 14 OR 
										#arguments.dealer_id# eq 3 OR 
										#arguments.dealer_id# eq 4 OR 
										#arguments.dealer_id# eq 6 OR 
										#arguments.dealer_id# eq 148 OR 
										#arguments.dealer_id# eq 7 OR 
										#arguments.dealer_id# eq 8 OR 
										#arguments.dealer_id# eq 9 OR 
										#arguments.dealer_id# eq 10 OR 
										#arguments.dealer_id# eq 162 OR 
										#arguments.dealer_id# eq 12 OR 
										#arguments.dealer_id# eq 15 ) > 
			<cfinvoke component="/cfcs/ultra10/popups" method="baierl_certified">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="baierlModal"/>
			</cfinvoke>
		  </cfif> 
		<cfif #arguments.dealer_id# EQ 33 >
			<cfinvoke component="/cfcs/ultra10/popups" method="makemydeal">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="mmdModal"/>
				<cfinvokeargument name="Selling_Price" value="#arguments.Selling_Price#">
				<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
				<cfinvokeargument name="stock" value="#arguments.stock#"/>
				<cfinvokeargument name="v_year" value="#arguments.V_Year#">
				<cfinvokeargument name="v_make" value="#arguments.V_Make#">
				<cfinvokeargument name="v_model" value="#arguments.V_Model#">
				<cfinvokeargument name="v_style" value="#arguments.V_Style#">
				<cfinvokeargument name="transmission" value="#arguments.Transmission#">
				<cfinvokeargument name="odometer" value="#arguments.Odometer#">
				<cfinvokeargument name="New_Used" value="#arguments.New_Used#">
				<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
				<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
			</cfinvoke>
		</cfif>
		<cfif #arguments.dealer_id# EQ 34 >
			<cfinvoke component="/cfcs/ultra10/popups" method="makemydeal">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="mmdModal"/>
				<cfinvokeargument name="Selling_Price" value="#arguments.Selling_Price#">
				<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
				<cfinvokeargument name="stock" value="#arguments.stock#"/>
				<cfinvokeargument name="v_year" value="#arguments.V_Year#">
				<cfinvokeargument name="v_make" value="#arguments.V_Make#">
				<cfinvokeargument name="v_model" value="#arguments.V_Model#">
				<cfinvokeargument name="v_style" value="#arguments.V_Style#">
				<cfinvokeargument name="transmission" value="#arguments.Transmission#">
				<cfinvokeargument name="odometer" value="#arguments.Odometer#">
				<cfinvokeargument name="New_Used" value="#arguments.New_Used#">
				<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
				<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
			</cfinvoke>
		</cfif>
		<cfif #arguments.dealer_id# EQ 288 >
			<cfinvoke component="/cfcs/ultra10/popups" method="makemydeal">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="mmdModal"/>
				<cfinvokeargument name="Selling_Price" value="#arguments.Selling_Price#">
				<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
				<cfinvokeargument name="stock" value="#arguments.stock#"/>
				<cfinvokeargument name="v_year" value="#arguments.V_Year#">
				<cfinvokeargument name="v_make" value="#arguments.V_Make#">
				<cfinvokeargument name="v_model" value="#arguments.V_Model#">
				<cfinvokeargument name="v_style" value="#arguments.V_Style#">
				<cfinvokeargument name="transmission" value="#arguments.Transmission#">
				<cfinvokeargument name="odometer" value="#arguments.Odometer#">
				<cfinvokeargument name="New_Used" value="#arguments.New_Used#">
				<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
				<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
			</cfinvoke>
		</cfif>
		<cfinvoke component="/cfcs/ultra10/popups" method="test_drive">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="#arguments.Vin#Modaltd"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/ultra10/popups" method="quick_quote">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="#arguments.Vin#Modalqq"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/ultra10/popups" method="rfq">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="#arguments.Vin#Modalrfq"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		
		<cfinvoke component="/cfcs/ultra10/popups" method="eprc2">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="#arguments.Vin#Modaleprc2"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		
		<cfinvoke component="/cfcs/ultra10/popups" method="adddetl">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="#arguments.Vin#Modaladddetl"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		
	</cffunction>


	<cffunction name="vdp" description="vehicle details page" output="Yes" access="public">
		<!---arguments--->
		<cfargument name="Vehicle_ID" required="true"/>
		<cfargument name="Dealer_ID" required="true"/>
		<cfargument name="Vin" required="true"/>
		<cfargument name="Stock" required="true"/>
		<cfargument name="V_New_Used" required="true"/>
		<cfargument name="V_Year" required="true"/>
		<cfargument name="V_Make" required="true"/>
		<cfargument name="V_Model" required="true"/>
		<cfargument name="V_Trim" required="true"/>
		<cfargument name="Img_Urls" required="true"/>
		<cfargument name="Video_Link" required="true"/>
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
		<cfargument name="Adjusted_Baseline" required="true"/>
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
		<cfargument name="Carfax_One_Owner" required="true"/>
		<cfargument name="Autocheck" default="0" />
		<cfargument name="half_year" default="0" />
		<cfargument name="Disclaimer" required="true"/>
		<cfargument name="Certified" required="true"/>
		<!---<cfargument name="template_id" required="true"/>--->
		<cfargument name="assets" required="true"/>
		<cfargument name="AIS_wID" required="true"/>
		<cfargument name="on_lot_status" required="true"/>

		<cfset url.year=arguments.V_Year>
		<cfset url.make=arguments.V_Make>
		<cfset url.model=arguments.V_Model>
		<cfset url.new_used=arguments.V_New_Used>

		<cfif arguments.V_Model eq "FourRunner">
			<cfset arguments.V_Model="4Runner">
		</cfif>

		<!---dealer specific parameters--->
		<cfparam name="url.v_disclaimer" default="">

		<cfparam name="url.form_action" default="">
		
		<!--- Check VDP Style 12/21/2015--->
				<cfset vdp_style = 0 ><cfset vdp_photo_location = 0 >
				<cfquery datasource="ultra10" name="chk_vdp_style">SELECT vdp_type,vdp_photo_location FROM Dealers WHERE dealer_id = #url.dealer_id# AND	( vdp_type = 1 OR vdp_type = 2 )</cfquery>
				<cfif #chk_vdp_style.recordcount# NEQ 0 ><cfset vdp_style = #chk_vdp_style.vdp_type# ><cfset vdp_photo_location = #chk_vdp_style.vdp_photo_location# ></cfif>	
		<!--- Check VDP Style 12/21/2015--->	
		
<cfif #url.dealer_id# EQ 365 AND #cgi.server_name# EQ "4ultra10.wddemos.com" ><cfset vdp_style = "2" ></cfif>			
		
		
		<!--- Check Similar Range --->
		<cfset srp_srchbar = 0 ><cfset vdp_srchbar = 0 ><cfset srp_noresult = "USED" >
		<cfset similar_over_under = 0 >
		<cfset similar_over_under_high = 0 >
		<cfset similar_low = 0 >
		<cfset similar_high = 0 >
		<cfset get_it = 0 >
		<cfset similar_over_under_new = 0 >
		<cfset similar_over_under_new_high = 0 >
		<cfset similar_low_new = 0 >
		<cfset similar_high_new = 0 >
		<cfquery datasource="ultra10" name="chk_similar">
			SELECT		srp_type,vdp_type,similar_range,similar_range_new,similar_range_high,similar_range_new_high,srp_search_location,vdp_search_location,zero_result_dest
			FROM		Dealers
			WHERE		dealer_id = #url.dealer_id#
		</cfquery>
		<cfset srp_srchbar = #chk_similar.srp_search_location# ><cfset vdp_srchbar = #chk_similar.vdp_search_location# >
		<cfif #chk_similar.zero_result_dest# EQ 1><cfset srp_noresult = "NEW" ><cfelse><cfset srp_noresult = "USED" ></cfif>
		<cfset similar_over_under = #chk_similar.similar_range# > 
		<cfset similar_over_under_high = #chk_similar.similar_range_high# > 
		<cfset similar_over_under_new = #chk_similar.similar_range_new# > 
		<cfset similar_over_under_new_high = #chk_similar.similar_range_new_high# > 
		 <cfif (#similar_over_under# GT 0 OR  #similar_over_under_high# GT 0) AND ( #arguments.selling_price# GT 0 AND #arguments.selling_price# NEQ 10000000 ) >
		 	<cfset get_it = 1 >
			<cfset similar_low=#arguments.selling_price#-#similar_over_under# >
			<cfset similar_high=#arguments.selling_price#+#similar_over_under# >
		</cfif>   
		<cfif (#similar_over_under_new# GT 0 OR  #similar_over_under_new_high# GT 0)  AND ( #arguments.selling_price# GT 0 AND #arguments.selling_price# NEQ 10000000 ) >
			<cfset get_it = 1 >
			<cfset similar_low_new=#arguments.selling_price#-#similar_over_under_new# >
			<cfset similar_high_new=#arguments.selling_price#+#similar_over_under_new_high# >
		</cfif>  
		
		<!---Get Vehicle Options--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.vin,17)#" maxlength="21">
			<cfprocresult name="Get_Vehicle_Options" resultset="1">
		</cfstoredproc>

		<cflock timeout="60">
			<cfquery datasource="Ultra10" name="Get_Similar">
				SELECT		TOP (4) Dealer_ID,
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
				<cfif (#similar_over_under# GT 0 OR  #similar_over_under_high# GT 0) AND arguments.V_New_Used eq "U" AND #get_it# eq 1 >
					AND		Selling_Price > #similar_low# AND Selling_Price < #similar_high#
				</cfif>  
				<cfif ( #similar_over_under_new# GT 0 OR  #similar_over_under_new_high# GT 0) AND arguments.V_New_Used eq "N" AND #get_it# eq 1 >
					AND		Selling_Price > #similar_low_new# AND Selling_Price < #similar_high_new#
				</cfif>  
				<cfif arguments.V_New_Used eq "N">
					AND		V_Make=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.V_Make#" maxlength="50">
				</cfif>
				<cfif arguments.V_New_Used eq "U">
					AND		V_Model <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.V_Model#" maxlength="50">
				</cfif>
			</cfquery>
		</cflock>
		
		<cfif #url.dealer_id# eq 24 or <!--- Faulkner Mazda Harrisburg --->
				 #url.dealer_id# eq 82 or <!--- Faulkner Mazda Harrisburg --->
					 #url.dealer_id# eq 78 or <!--- Faulkner Nissan Harrisburg --->
						 #url.dealer_id# eq 79> <!--- Faulkner Nissan Trevose --->  
			<script type="text/javascript" src="http://maxinsights.biz/scripts/MAXSEPublishing.js"></script>
			<script type="text/javascript" src="http://maxinsights.biz/scripts/config_website.js"></script>
		</cfif>
		<cfif url.dealer_id eq 171>
        	<!-- Segment Pixel - SY - Fuccillo Auto World - Sales - Site - DO NOT MODIFY --> 
            <img src="http://ib.adnxs.com/seg?add=5029805&t=2" width="1" height="1" /> 
            <!-- End of Segment Pixel --> 
        </cfif>
		<!--- Check for Custom Buttons--->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		<cfquery datasource="ultra10" name="Get_Btns">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id# AND	Btn_Type = 3 AND	active = 1 ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_vdp_return_btns = #Get_Btns.recordcount# >
		<!--- Check for Custom Buttons--->

		<!--- Check on lot status 12/22/2015 --->
		<cfquery name="on_lot" datasource="Ultra10" >SELECT on_lot_status FROM Vehicles	where Vin = '#arguments.vin#' </cfquery>  
		<cfset status_msg = "IN STOCK" ><cfif #LCase(on_lot.on_lot_status)# EQ "in-transit" ><cfset status_msg = "IN TRANSIT" ></cfif> 
		<!--- Check on lot status 12/22/2015 --->  
			
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

	<div class="container-fluid">
		<section class="section-internal-video">
			<div class="container" >		
		
		<cfset url.is_vdp_page = "Y" >  <!--- To pick up Banner on VDP 08/29/2014 --->
		
		<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="nav_type_id" value="52"/>
			<cfinvokeargument name="assets" value="#arguments.assets#"/>
			<cfinvokeargument name="element_class" value="page-banner"/>
            <cfinvokeargument name="displayPageVal" value="2,3"/>
			<cfif arguments.V_New_Used eq "n">
				<cfinvokeargument name="page_id" value="/new/index.cfm"/>
			<cfelse>
				<cfinvokeargument name="page_id" value="/used/index.cfm"/>
			</cfif>
		</cfinvoke>
		
		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
		
		<cfif #url.dealer_id# EQ 62  >		<!--- Preston SUperstore 10/06/2015 --->
			<div class="row">
				<div class="col-md-12" style="align:center">
					<div class="fatwin-div"><img src="http://dealers.wdautos.com/dealer/prestonsuperstore/images/icons/img_TradeAppraisalPlus2_off1.gif"/></div>
				</div>
			</div>  
		</cfif>

		<!--- Check for Custom SEO Text   --->		
		<cfset pg_nbr = 0 ><cfset go_vdp_custom = 0 >
		<cfif #arguments.V_New_Used# eq "U" OR  #arguments.V_New_Used# eq "O"><cfset pg_nbr = 94 ><cfelseif #arguments.V_New_Used# eq "N"><cfset pg_nbr = 95 ></cfif>
		<cfquery name="chk_txt" datasource="Ultra10">SELECT id, page_type FROM Variable_Template_Dealer_Content where dealer_id=#url.dealer_id# AND (page_type = #pg_nbr#) AND active = 1</cfquery>
		<cfif #chk_txt.recordcount# NEQ 0 ><cfset go_vdp_custom = 1 ></cfif>  
	 	<!--- Check for Custom SEO Text --->		
 
		 <cfif #go_vdp_custom# EQ 1  >   
			<div class="row">
				<div class="col-md-12 no-pad">
					<cfset came_from = 1 >
					<cfset n_u_flag = #arguments.V_New_Used# >
					<cfinclude template="section_srp_vdp_text.cfm" >
				</div>
			</div>  	
		<cfelse>
			<!--- SEO Text 04/09/2015 --->		
			<cfquery name="get_dealer_vdp" datasource="Ultra10">SELECT ID,dealer_id,seo_content,active FROM Dealer_VDP_SEO_Content WHERE dealer_id=#URL.dealer_id# and active=1</cfquery>
			<cfquery name="get_dealer_proximity" datasource="Ultra10">SELECT proximity FROM Dealers WHERE dealer_id=#URL.dealer_id#</cfquery>
			<cfif #get_dealer_vdp.recordcount# EQ 1 >
				<div class="row">
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$NU$", "#variables.New_Used#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$COLOR$", "#arguments.Exterior_Color#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$MAKE$", "#arguments.V_Make#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$MODEL$", "#arguments.V_Model#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$YEAR$", "#arguments.V_Year#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$WHERE$", "#arguments.Dealer_Display_Name#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$CITY$", "#arguments.Dealer_City#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$STATE$", "#arguments.Dealer_State#", "ALL")# >
					<cfset get_dealer_vdp.seo_content = #replace(get_dealer_vdp.seo_content,"$PROXIMITY$", "#get_dealer_proximity.proximity#", "ALL")# >
					<div class="col-md-12 pad-bottom-10">
						#get_dealer_vdp.seo_content# 
					</div>
				</div>
			</cfif>
			<!--- SEO Text 04/09/2015 --->			
		</cfif>			 

		 <cfif NOT IsDefined("url.srch") > <!--- Back to Inventory Button  --->
			<div class="row"><div class="col-md-5 pad-top-10"><a href="#cgi.http_referer#" class="btn vdp-back-inv"><i class="glyphicon glyphicon-arrow-left"></i>&nbsp;Back to Inventory</a></div></div>
		  <cfelse>
			<div class="row"><div class="col-md-12 pad-top-10">&nbsp;</div></div>
		</cfif>	 
		
		<div class="row">
			<cfif #vdp_photo_location# EQ 0 >	<!--- begin RIGHT PHOTO --->	
			<div class="col-md-12 no-pad">
				<div class="col-md-5 no-pad">
					<cfif arguments.half_year eq 1><cfset arguments.V_Year=arguments.V_Year & ".5"></cfif>
					<h1 class="vdp-title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h1>
					<cfif len(trim(arguments.Dealer_Phone)) gt 0><a class="vdp-store-phone txt-red visible-xs visible-sm" href="tel:#reReplace( arguments.Dealer_Phone, "[^[:digit:]]", '', "all")#"><b>Call Now: #arguments.Dealer_Phone#</b></a></cfif>
					<div class="visible-md visible-lg vdp-text vdp-condition"><b>Condition:</b> #variables.New_Used# | <b>Stock ##:</b> #arguments.Stock# | <b>Model ##:</b> #arguments.Model_Number# | <span class="txt-green"><b>#status_msg#</b></span></div>
					<div class="price-block visible-md visible-lg">
						<cfset url.new_used = #arguments.V_New_Used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default_new">
							<cfinvokeargument name="Adjusted_Baseline" value="#arguments.Adjusted_Baseline#"/>
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
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						</cfinvoke>							
							
						<cfif len(trim(arguments.Disclaimer)) gt 0><br/><a data-toggle="modal" data-target="##discModal">* Disclaimer</a><br/></cfif>
							
						<cfif len(trim(arguments.AIS_wID)) gt 0><br/>
							<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">** See Incentives</a><br/>
						</cfif>
							
						<cfinclude template="vdp_addons.cfm" >	<!--- ALL EXTRA BUTTONS & SCRIPTS FOR THE VDP SHOULD GO IN THIS INCLUDE FILE  --->	
							
						<div class="vdp-form-title pad-top-10">&nbsp;&nbsp;GET A VEHICLE QUOTE</div>
		                <cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_details_new">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
		                    <cfif url.dealer_id eq 78>
			                   <cfinvokeargument name="button_label" value="Get e-Price"/>   
		                    </cfif>                     
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/vehicles/qq_action.cfm"/>
						</cfinvoke>
					</div>
				</div> <!--- end 4 column --->
				<div class="col-md-7 no-pad">
					<cfswitch expression="#listlen(arguments.Img_Urls)#">
						<cfdefaultcase>
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="wow_slider">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="vdp-img"/>
							</cfinvoke>
						</cfdefaultcase>
						<cfcase value="1">
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="vdp-img"/>
							</cfinvoke>
						</cfcase>
						<cfcase value="0">
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="vdp-img"/>
							</cfinvoke>
						</cfcase> 
					</cfswitch>
				</div> <!--- end 7 column --->
			</div> <!--- end 12 column --->
			<!--- end RIGHT PHOTO --->			
		<cfelse>
			<!--- begin LEFT PHOTO --->		
			<div class="col-md-12 pad-top-10">
				<div class="col-md-7 pad-right-10">
					<cfswitch expression="#listlen(arguments.Img_Urls)#">
						<cfdefaultcase>
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="wow_slider">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="vdp-img"/>
							</cfinvoke>
						</cfdefaultcase>
						<cfcase value="1">
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="vdp-img"/>
							</cfinvoke>
						</cfcase>
						<cfcase value="0">
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="vdp-img"/>
							</cfinvoke>
						</cfcase> 
					</cfswitch>
				</div>  <!--- end 7 column --->
				<div class="col-md-5 pad-left-10 pull-right">
					<cfif arguments.half_year eq 1><cfset arguments.V_Year=arguments.V_Year & ".5"></cfif>
					<h1 class="vdp-title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h1>
					<cfif len(trim(arguments.Dealer_Phone)) gt 0><a class="vdp-store-phone txt-red visible-xs visible-sm" href="tel:#reReplace( arguments.Dealer_Phone, "[^[:digit:]]", '', "all")#"><b>Call Now: #arguments.Dealer_Phone#</b></a></cfif>
					<div class="visible-md visible-lg vdp-text vdp-condition"><b>Condition:</b> #variables.New_Used# | <b>Stock ##:</b> #arguments.Stock# | <b>Model ##:</b> #arguments.Model_Number# | <span class="txt-green"><b>#status_msg#</b></span></div>
					<div class="price-block visible-md visible-lg">
						<cfset url.new_used = #arguments.V_New_Used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default_new">
							<cfinvokeargument name="Adjusted_Baseline" value="#arguments.Adjusted_Baseline#"/>
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
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						</cfinvoke>							

						<cfif len(trim(arguments.Disclaimer)) gt 0><br/><a data-toggle="modal" data-target="##discModal">* Disclaimer</a><br/></cfif>
							
						<cfif len(trim(arguments.AIS_wID)) gt 0><br/>
							<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">** See Incentives</a><br/>
						</cfif>
							
						<cfinclude template="vdp_addons.cfm" >	<!--- ALL EXTRA BUTTONS & SCRIPTS FOR THE VDP SHOULD GO IN THIS INCLUDE FILE  --->	
							
						<div class="vdp-form-title pad-top-10">&nbsp;&nbsp;GET A VEHICLE QUOTE</div>
	                    <cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_details_new">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
	                        <cfif url.dealer_id eq 78>
		                        <cfinvokeargument name="button_label" value="Get e-Price"/>   
	                        </cfif>                     
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/vehicles/qq_action.cfm"/>
						</cfinvoke>
					</div>
				</div> <!--- end 5 column --->
			</div> <!--- end 12 column --->
			<!--- end LEFT PHOTO --->			
		</cfif>					
		
		<div class="row visible-xs visible-sm">
			<div class="vdp-form-mobile">
				<div class="vdp-form-title">REQUEST A QUOTE</div>
				<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_details">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
					<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
					<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
					<cfinvokeargument name="form_action" value="http://#cgi.server_name#/vehicles/qq_action.cfm"/>
				</cfinvoke>
				<cfset url.newused = #arguments.V_New_Used# >
				<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="vdp_standard">
					<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="exclude_print" value="yes"/>
				</cfinvoke>
			</div>
		</div> <!--- end MOBILE --->
		</div> <!--- END ROW --->
	</div> <!--- END CONTAINER --->
				
	<cfif #url.dealer_id# eq 78  and  #arguments.New_Used# eq "N" and  
			( (#arguments.V_Year# eq "2016"  and  #arguments.V_Make# eq "Nissan" and  #arguments.V_Model# eq "Maxima") OR 
			 	(#arguments.V_Year# eq "2015"  and  #arguments.V_Make# eq "Nissan" and  #arguments.V_Model# eq "Murano") OR 
			 		(#arguments.V_Year# eq "2016"  and  #arguments.V_Make# eq "Nissan" and  #arguments.V_Model# eq "GT-R")  )>  <!--- Faulkner Nissan Harrisburg 04/07/2015 --->
		<div align="right">
		<a data-toggle="modal" data-target="###arguments.Vin#Modaleprc2"><img  Alt="Faulkner" class="img-responsive" src="http://dealers.wdautos.com/dealer/faulknernissan/images/icons/btn_GetEprice.jpg"/></a>
		</div>
	</cfif>	     
							
	<cfif #url.dealer_id# eq 30 > <!--- Ron Hibbard Toyota 02/02/2015 --->
		<div class="row">
		<div class="col-md-8" align="left">
			<cfif #arguments.New_Used# eq "U"> 
				<a href='http://www.purecars.com/comparison/20618/#arguments.Vin#' target='_blank'><img alt="Comparison"  class="img-responsive" src='http://www.purecars.com/images/graph.aspx?id=20618&vin=#arguments.Vin#' border='0' /></a> 
			<cfelse>
				&nbsp;
			</cfif>
		</div>
		<div class="col-md-4" align="left">
			<a href="http://ronhibbardtoyota.com/dealer/ronhibbard/dealerrater_reviews.cfm"><img  alt="DealerReater Awards" class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/ronhibbard/images/icons/icon_RHT_DealerRaterAwards.png"/></a>
		</div>
		</div>
	</cfif>	
				
	<!--- Kelly CDJR Make My Deal --->
	<cfif #url.dealer_id# EQ 33 AND  (#arguments.New_Used# EQ "N" OR  #arguments.New_Used# EQ "U")>
		<cfset variables.pass_img = #ListFirst(arguments.Img_Urls)# >
		<div class="row  visible-md visible-lg visible-xs visible-sm">

		<div id="mmd-widget"></div>

		<script id="mmd-widget-script" 
 					src="http://w.makemydeal.com/mmd.widget.v2.js" 
			data-isMobile = "true"
		    data-dealer-id="405" 
		    data-sponsor="worlddealer">
		</script>
		
		<cfif #arguments.New_Used# EQ "N">
			<script>
			    mmd.loadWidget({
		        listedPrice: #arguments.Selling_Price#,
		        vehicleStatus: 1,
		        vin: "#arguments.Vin#",
		        year: #arguments.V_Year#,
		        make: "#arguments.V_Make#",
		        model: "#arguments.V_Model#",
		        trim: "#arguments.V_Trim#",
		        img: "#variables.pass_img#",
		        stock: "#arguments.Stock#",
		        mileage: #arguments.Odometer#,
		        url: document.URL,
		        widgetType: "compact",
		        onLoadedFunction: function() { 
		        console.log('widget loaded'); 
		        },
		        onHidingFunction: function() { 
		        console.log('widget not showing');
		       }
			   	});
			</script>
		<cfelse>
			<script>
			    mmd.loadWidget({
		        listedPrice: #arguments.Selling_Price#,
		        vehicleStatus: 0,
		        vin: "#arguments.Vin#",
		        year: #arguments.V_Year#,
		        make: "#arguments.V_Make#",
		        model: "#arguments.V_Model#",
		        trim: "#arguments.V_Trim#",
		        img: "#variables.pass_img#",
		        stock: "#arguments.Stock#",
		        mileage: #arguments.Odometer#,
		        url: document.URL,
		        widgetType: "compact",
		        onLoadedFunction: function() { 
		        console.log('widget loaded'); 
		        },
		        onHidingFunction: function() { 
		        console.log('widget not showing');
		       }
			   	});
			</script>
		</cfif>
		</div>
	</cfif>					
	<!--- Kelly Mitsubishi Make My Deal --->
	<cfif #url.dealer_id# EQ 34 AND  (#arguments.New_Used# EQ "N" OR  #arguments.New_Used# EQ "U")>
		<cfset variables.pass_img = #ListFirst(arguments.Img_Urls)# >
		<div class="row  visible-md visible-lg visible-xs visible-sm">

		<div id="mmd-widget"></div>
			
		<script id="mmd-widget-script" 
		  src="http://w.makemydeal.com/widget.js" 
		  data-dealer-id="752" 
		  data-sponsor="worlddealer"
		  data-version="4.0.0">
		</script>


		</div>
	</cfif>	

    <cfif #url.dealer_id# EQ 288 AND  (#arguments.New_Used# EQ "N" OR  #arguments.New_Used# EQ "U")>
		<cfset variables.pass_img = #ListFirst(arguments.Img_Urls)# >
		<div class="row  visible-md visible-lg visible-xs visible-sm">

		<div id="mmd-widget"></div>

                <script id="mmd-widget-script" 
                  src="http://w.makemydeal.com/widget.js" 
                  data-dealer-id="971" 
                  data-sponsor="worlddealer"
                  data-version="4.0.0">
                </script>


	
		</div>
	</cfif>	

	<!--- NEW VDP TABS 12/21/2015 --->						
	<cfif #vdp_style# eq 0 >
				
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
			    <cfif #url.dealer_id# eq 80 and #Get_Vehicle_Options.recordcount# eq 0 >   <!--- Hack to get DealerSpecialties Options 12/29/2014 bob --->
			 		<cfquery datasource="imports" name="Get_standard_Options">
						SELECT  Options
						FROM    Stage_Inventory_Old
						WHERE	vin = '#arguments.Vin#'
					</cfquery>
					<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_default">
						<cfinvokeargument name="Installed" value=""/>
						<cfinvokeargument name="Safety" value=""/>
						<cfinvokeargument name="Interior" value=""/>
						<cfinvokeargument name="Exterior" value=""/>
						<cfinvokeargument name="Mechanical" value=""/>
						<cfinvokeargument name="Misc" value="#Get_standard_Options.Options#"/>
					</cfinvoke>
				<cfelse>    
					<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_default">
						<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
						<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
						<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
						<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
						<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
						<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
					</cfinvoke>
		 	  	</cfif>  	  
			</div>
		</div>
	<cfelse>
 			<div class="row ">		 
			<div class="col-md-12">
				
				<cfinvoke component="/cfcs/vehicles/vehicle_specs_new" method="new_vdp_default">
					<cfinvokeargument name="New_Used" value="#arguments.V_New_Used#"/>
					<cfinvokeargument name="Stock" value="#arguments.Stock#"/>
					<cfinvokeargument name="Model_Number" value="#arguments.Model_Number#"/>
					<cfinvokeargument name="Vin" value="#arguments.Vin#"/>
					<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
					<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
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
					<cfinvokeargument name="came_from" value="1"/>
					<!--- <cfinvokeargument name="v_link" value="#variables.v_link#"/> --->
				</cfinvoke>			 
			</div>
		</div> 

		<div class="row pad-top-10">
	 		<div class="col-md-12 vdp-car-break">&nbsp;</div>	
		</div>	
        
		<div class="row visible-md visible-lg">
			<div class="col-md-12 no-pad">
				<cfset ln = "" >
				<cfif vdp_style EQ 1 >
					<cfset vert_tabs = "1" >
			  		<cfinclude template="section_vdp_details.cfm" >      
			    </cfif>
				<cfif vdp_style EQ 2 >
			 		<cfset vert_tabs = "1" >
				 	<cfinclude template="section_vdp_details_vertical.cfm" >
				</cfif>	    
			</div>
		</div>
		
	</cfif>

				
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
			<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_mobile">
				<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
				<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
				<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
				<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
				<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
				<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
			</cfinvoke>
		</div>							
	</div>

	<!--- NEW VDP TABS 12/21/2015 EXCLUDE CALCULATOR IF VERTICAL TABS ARE ON --->	 
			
	<cfif vert_tabs EQ 0  >
		<div class="row  visible-md visible-lg">
			<div class="col-md-12 vdp-text vdp-pad-10">
				<div class="col-md-8">
					<b>PAYMENT CALCULATOR:</b>
				</div>
				<div class="col-md-8 vdp-options-box vdp-pad-10">
					<cfinvoke component="/cfcs/vehicles/calculator" method="vdp">
						<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
						<cfinvokeargument name="Calc_Price" value="#arguments.Selling_Price#"/>
					</cfinvoke>
				</div>
				<div class="col-md-4">
					
					 <div class="row">
							<div class="col-md-2">&nbsp;</div>
						<div class="col-md-8">							
							<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="vdp_standard">
								<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
								<!--- <cfinvokeargument name="Permalink" value="#arguments.Permalink#"/> --->
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
								<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
								<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
								<cfinvokeargument name="Certified" value="#arguments.Certified#"/>
							</cfinvoke>
						</div>
					</div>		 
				</div>
			</div>
		</div>
	</cfif>
			
  	<cfif Get_Similar.recordcount gt 0>
	 
		<div class="row pad-top-10">
	 		<div class="col-md-12 vdp-car-break">&nbsp;</div>	
		</div>	
		<div class="row">
			<div class="col-md-12 srp-disclaimer">
				<div class="vdp-form-title">SIMILAR VEHICLES</div>
		<div class="row">
			<div class="col-md-12">
				<cfset url.new_used = #arguments.V_New_Used# >
				<cfinvoke component="/cfcs/vehicles/vehicle_similar" method="vdp_similar_new">
					<cfinvokeargument name="Get_Similar" value="#Get_Similar#"/>
				</cfinvoke>
			</div>
		</div>   
			</div>
		</div>   
	</cfif>
		<div class="row">
			<div class="col-md-12 srp-disclaimer">
				<cfif len(trim(url.v_disclaimer)) gt 0>
					#url.v_disclaimer#
				<cfelse>
					Price plus tax, license, document preparation charge, and finance charges and smog fees (used vehicles only), where applicable. While every effort has been made to ensure display of accurate data and pricing, this listing may not reflect all accurate vehicle data or pricing and is subject to human error. All Inventory listed is subject to prior sale. The photo shown, if any, may be an example only. Please consult dealership personnel for further details.
				</cfif>
			</div>
		</div>
	</div>
			
	</div>
		
	</div>
	</section>
	</div>	
		
		<cfif len(trim(arguments.Disclaimer)) gt 0>
			<cfinvoke component="/cfcs/ultra10/popups" method="v_disclaimer">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="Disclaimer" value="#arguments.Disclaimer#"/>
			</cfinvoke>
		</cfif>
		
		<cfif len(trim(arguments.Video_Link)) gt 0>
			<script type="text/javascript">
				function getVid(loc){
					document.getElementById("iframe_video_frame").src=loc;
					$('##video_frame').modal({
						show: true
					});
				}
				function closeVid(){
					document.getElementById("iframe_video_frame").src='http://#cgi.server_name#/blank.html';
				}
			</script>
			<cfinvoke component="/cfcs/ultra10/popups" method="iframe">
				<cfinvokeargument name="pop_name" value="video_frame"/>
				<cfinvokeargument name="iframe_src" value="http://#cgi.server_name#/blank.html"/>
				<cfinvokeargument name="width" value="500"/>
				<cfinvokeargument name="height" value="400"/>
				<cfinvokeargument name="close_function" value="closeVid()"/>
			</cfinvoke>
		</cfif>

		<cfif len(trim(arguments.AIS_wID)) gt 0>
			<script type="text/javascript">
				function getAIS(loc){
					document.getElementById("iframe_AIS_frame").src=loc;
					$('##AIS_frame').modal({
						show: true
					});
				}
				function closeAIS(){
					document.getElementById("iframe_AIS_frame").src='http://#cgi.server_name#/blank.html';
				}
			</script>
			<cfinvoke component="/cfcs/ultra10/popups" method="iframe">
				<cfinvokeargument name="pop_name" value="AIS_frame"/>
				<cfinvokeargument name="iframe_src" value="http://#cgi.server_name#/blank.html"/>
				<cfinvokeargument name="width" value="900"/>
				<cfinvokeargument name="height" value="500"/>
				<cfinvokeargument name="scrolling" value="yes"/>
				<cfinvokeargument name="close_function" value="closeAIS()"/>
			</cfinvoke>
		</cfif>
	
		<cfif #arguments.dealer_id# EQ 67 OR #arguments.dealer_id# EQ 288>
			<cfinvoke component="/cfcs/ultra10/popups" method="courtesy_certified">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="certModal"/>
			</cfinvoke>
		</cfif>
		 <cfif 	( 	#arguments.dealer_id# eq 1 OR 
							   			#arguments.dealer_id# eq 132 OR 
								   		#arguments.dealer_id# eq 195 OR 
									 	#arguments.dealer_id# eq 16 OR 
										#arguments.dealer_id# eq 2 OR 
										#arguments.dealer_id# eq 14 OR 
										#arguments.dealer_id# eq 3 OR 
										#arguments.dealer_id# eq 4 OR 
										#arguments.dealer_id# eq 6 OR 
										#arguments.dealer_id# eq 148 OR 
										#arguments.dealer_id# eq 7 OR 
										#arguments.dealer_id# eq 8 OR 
										#arguments.dealer_id# eq 9 OR 
										#arguments.dealer_id# eq 10 OR 
										#arguments.dealer_id# eq 162 OR 
										#arguments.dealer_id# eq 12 OR 
										#arguments.dealer_id# eq 15 ) > 
			<cfinvoke component="/cfcs/ultra10/popups" method="baierl_certified">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="baierlModal"/>
			</cfinvoke>
		 </cfif> 
		
		<cfinvoke component="/cfcs/ultra10/popups" method="test_drive">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/ultra10/popups" method="quick_quote">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/ultra10/popups" method="make_an_offer">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/ultra10/popups" method="send_friend">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
 
		<cfinvoke component="/cfcs/ultra10/popups" method="adddetl">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke> 


		<cfinvoke component="/cfcs/ultra10/popups" method="eprc2">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="#arguments.Vin#Modaleprc2"/>
			<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
			<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
			<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
			<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
			<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
			<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
			<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
		</cfinvoke>
		<cfif arguments.dealer_id eq 82>
        <!-- Edmunds CarCode--><script src='https://www.carcodesms.com/widgets/966.js' type='text/javascript'></script><!--CLOSING Edmunds CarCode-->
        </cfif>
	</cffunction>

	<cffunction name="srp_legacy" description="legacy search results page" output="Yes" access="public">
	</cffunction>	
	
	<cffunction name="vdp_legacy" description="vehicle details page" output="Yes" access="public">
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
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.vin,17)#" maxlength="21">
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
						<cfswitch expression="#listlen(arguments.Img_Urls)#">
							<cfdefaultcase>
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</cfdefaultcase>
							<cfcase value="0">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</cfcase> 
						</cfswitch>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 vdp-pad-10">
						<cfset url.new_used = #arguments.v_New_Used#>
						<cfinvoke component="/cfcs/vehicles/vehicle_store" method="vdp_default">
							<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
							<cfinvokeargument name="Dealer_Address_1" value="#arguments.Dealer_Address_1#"/>
							<cfinvokeargument name="Dealer_Address_2" value="#arguments.Dealer_Address_2#"/>
							<cfinvokeargument name="Dealer_City" value="#arguments.Dealer_City#"/>
							<cfinvokeargument name="Dealer_State" value="#arguments.Dealer_State#"/>
							<cfinvokeargument name="Dealer_Zip" value="#arguments.Dealer_Zip#"/>
                            <cfif arguments.dealer_id eq 78 or arguments.dealer_id eq 79>
								<cfinvokeargument name="Dealer_Phone" value=""/>
                            <cfelse>
                            	<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
                            </cfif>
						</cfinvoke>
					</div>
					<div class="col-md-6 vdp-pad-10">
						<cfset url.new_used = #arguments.V_New_Used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default">
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
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<cfinvoke component="/cfcs/vehicles/vehicle_specs" method="vdp_default">
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
						<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_mobile">
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
		<div class="row">
			<div class="col-md-12 srp-disclaimer">
				Price plus tax, license, document preparation charge, and finance charges and smog fees (used vehicles only), where applicable. While every effort has been made to ensure display of accurate data and pricing, this listing may not reflect all accurate vehicle data or pricing and is subject to human error. All Inventory listed is subject to prior sale. The photo shown, if any, may be an example only. Please consult dealership personnel for further details.
			</div>
		</div>

	</cffunction>
	
</cfcomponent>