<cfcomponent>

	<cffunction name="modern_standard" description="Site Search & Results" output="yes" access="public">

		<cfargument name="lookup"  required="true" default="car">
		
		<cfset variables.dsn = "Ultra10">
		<cfif IsDefined("form.lookup") >
			<cfset err_dsp_criteria = #form.lookup# >
			
			<cfset form.lookup = #rereplace(form.lookup,"[?]", "", "all")#>
			
			<cfset clean_criteria = #rereplace(form.lookup," ", " +", "all")#>
			<cfset form.res_style = 1 >
			<cfset clean_criteria = "+#clean_criteria#">
			<cfset pass_lookup = #form.lookup# >
		<cfelse>
			<cfset err_dsp_criteria = #arguments.lookup# >
			
			<cfset arguments.lookup = #rereplace(arguments.lookup,"[?]", "", "all")#>
			
			<cfset clean_criteria = #rereplace(arguments.lookup,"_", " +", "all")#>
			<cfset err_dsp_criteria = #clean_criteria# >
			<cfset form.res_style = 1 >
			<cfset clean_criteria = "#clean_criteria#">
			<cfset pass_lookup = #arguments.lookup# >
		</cfif>
		
	<cfif #url.dealer_id# eq 256 >		<!--- ToBeSure --->
		<cfsearch 	name="qSearch"
				    collection="faulkner" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	
						
						
			<cfsearch 	name="qSearch2"
					    collection="faulkner_txt" 
					    status="s"  
						ContextPassages="1"  
						ContextBytes="1000" 
						contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
					    contextHighlightEnd="</b></span>" 
					    criteria="#clean_criteria#">		
	</cfif>				
	<cfif #url.dealer_id# eq 365 >		<!--- Kelly Nissan --->
		<cfsearch 	name="qSearch"
				    collection="kellynissan" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	
						
						
			<cfsearch 	name="qSearch2"
					    collection="kellynissan_txt" 
					    status="s"  
						ContextPassages="1"  
						ContextBytes="1000" 
						contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
					    contextHighlightEnd="</b></span>" 
					    criteria="#clean_criteria#">						
	</cfif>					
	<cfif #url.dealer_id# eq 366 >		<!--- Wright Vans --->
		<cfsearch 	name="qSearch"
				    collection="wrightvans" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	
						
						
			<cfsearch 	name="qSearch2"
					    collection="wrightvans_txt" 
					    status="s"  
						ContextPassages="1"  
						ContextBytes="1000" 
						contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
					    contextHighlightEnd="</b></span>" 
					    criteria="#clean_criteria#">						
	</cfif>						
	<cfif #url.dealer_id# eq 233 >		<!--- Sample Dealer --->
		<cfsearch 	name="qSearch"
				    collection="sampledealer" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	
						
		  <cfsearch 	name="qSearch2"
				    collection="sampledealer_txt" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">		  
			<!--- <cfset 	qSearch2.recordcount = 0 > --->
	</cfif>								
	<cfif #url.dealer_id# eq 288 >		<!--- AutoBuySmart --->
		<cfsearch 	name="qSearch"
				    collection="autobuysmart" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	
						
		 <cfsearch 	name="qSearch2"
				    collection="autobuysmart_txt" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	  
			<!--- <cfset 	qSearch2.recordcount = 0 > --->
	</cfif>									
	<cfif #url.dealer_id# eq 1 >		<!--- Baierl --->
		<cfsearch 	name="qSearch"
				    collection="baierl" 
				    status="s"  
					ContextPassages="1"  
					ContextBytes="1000" 
					contextHighlightBegin="<span style=""color:red;font-weight:bold""><b>" 
				    contextHighlightEnd="</b></span>" 
				    criteria="#clean_criteria#">	
						
						
			<cfset 		qSearch2.recordcount = 0 >	
	</cfif>			

	<cfquery datasource="ultra10" name="zero_dest">SELECT zero_result_dest FROM Dealers WHERE dealer_id = #url.dealer_id# </cfquery>
	<cfif #zero_dest.zero_result_dest# EQ 1><cfset noresult = "NEW" ><cfelse><cfset noresult = "USED" ></cfif>	
	
		<cfif #form.res_style# EQ 1  >
			<cfset ctr = 0 >
			<cfset pass_vins = "" >
			
			<cfif #qSearch.recordcount# EQ 0 and #qSearch2.recordcount# EQ 0 >
				<cfif #url.dealer_id# NEQ 233 AND  #url.dealer_id# NEQ 288  AND  #url.dealer_id# NEQ 1   AND  #url.dealer_id# NEQ 365 >
					<cfset url.err_dsp_criteria = #err_dsp_criteria# >
					<cflocation url="http://#cgi.server_name#/search/no_results.cfm?err_dsp_criteria=#err_dsp_criteria# " >
				<cfelse>
					<cfset t_err_disp = "#err_dsp_criteria#" >
					<cflocation url="http://#cgi.server_name#/#noresult#/?err_disp=#t_err_disp#" >
				</cfif>
			</cfif>
			
			 <cfif #qSearch.recordcount# EQ 0 and #qSearch2.recordcount# NEQ 0 >
				<cfquery name="text_Detl" datasource="Ultra10">
					SELECT	 ID, dealer_id, Destination_page, keyword, active
					FROM         Site_Search_Keyword
					WHERE 	ID = '#qSearch2.key#'
				 </cfquery> 
				
				<cfif #left(text_Detl.destination_page,4)# eq "http">
				    <script type="text/javascript">
				        window.open("#text_Detl.destination_page#", '_blank');
				    </script>
					<cfexit>
				<cfelse> 
					<cflocation url="http://#cgi.server_name#/#text_Detl.destination_page#" >
				</cfif>

				
				
			</cfif> 
			<!--- If results in both queries, use the test search --->
			 <cfif #qSearch.recordcount# NEQ 0 and #qSearch2.recordcount# NEQ 0 >
				<cfquery name="text_Detl" datasource="Ultra10">
					SELECT	 ID, dealer_id, Destination_page, keyword, active
					FROM         Site_Search_Keyword
					WHERE 	ID = '#qSearch2.key#'
				 </cfquery>  
				<cflocation url="http://#cgi.server_name#/#text_Detl.destination_page#" >
			</cfif> 
			
		    <cfoutput Query="qSearch"> <!--- maxrows="100"  ---> 
				<cfquery name="Vehicle_Detl" datasource="Ultra10">
					SELECT	Vehicle_ID, Dealer_ID, Vin, Stock, Permalink, Img_Urls, Video_Link, V_New_Used, V_Year, V_Make, V_Model, V_Trim, V_Odometer, V_Model_Number, 
			    	        V_Type, V_Style, Interior_Color, Exterior_Color, Transmission, Engine_Size, Cylinders, Doors, Drivetrain, Passengers, Dealer_Comments, Fuel_Type, EPA_City, 
				            EPA_HWY, Adjusted_Baseline, Selling_Price_Label, Selling_Price, MSRP_Label, MSRP_Price, Rebate_Label, Rebate_Price, Incentive_Label, Incentive_Price, 
			    	        Savings_Label, Savings_Price, AIS_Label, AIS_Price, AIS_APR, Certified, Fleet, Luxury, Commercial, Carfax_One_Owner, Autocheck, Dealer_Display_Name, 
				            Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Url, Link_Finance, Link_Service, Link_Sales, Link_Parts, 
				            Link_Directions, Disclaimer, AIS_wID, half_year, V_Half_Year, Date_Updated, User_Edit, Region_ID, dsp_new_used
					FROM    Vehicles
					WHERE 	Vin = '#key#'
					<cfif #url.dealer_id# eq 84 OR  #url.dealer_id# eq 233  OR  #url.dealer_id# eq 288 OR  #url.dealer_id# eq 1 >
				 		and		V_New_Used = '#custom2#' 	 
					 </cfif>
				 </cfquery> 
			<cfset pass_vins = #pass_vins# & "#key#">
			<cfif #ctr# LT 200 >
				<cfset pass_vins = #pass_vins# & ",">
			</cfif>
		
		    </cfoutput>  

			<cfif #url.dealer_id# EQ 233 >
				<!---  <cfif #Vehicle_Detl.V_New_Used# EQ "O" >
					<cflocation url="http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=O&make=#Vehicle_Detl.v_make#&model=#Vehicle_Detl.v_model#&year=#Vehicle_Detl.v_year#" >
				</cfif>    --->
				<cflocation url="http://#cgi.server_name#/#Vehicle_Detl.dsp_new_used#/?make=#Vehicle_Detl.v_make#&model=#Vehicle_Detl.v_model#&year=#Vehicle_Detl.v_year#" >
			</cfif>

				
			<cfset url.lookup_vins = #pass_vins# >	
			<cfif IsDefined("url.lookup_vins") ><cfset url.lookup_vins = #url.lookup_vins#></cfif>
				<cfset url.pass_count = #qSearch.recordcount# >
				<cfinvoke component="/cfcs/vehicles/srp" method="#url.site_mode#_standard">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="site_mode" value="#url.site_mode#"/>
					<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
				</cfinvoke>	
				
			<cfelse>	
			
				<section class="section-site-search">
					<div class="container pad-top-10">
					 	<div class="container-site-search">
							<div class="row"><div class="col-md-12 pad-bottom-10" ><h3>Your search for <i>"#err_dsp_criteria#"</i> found #qSearch.recordcount# vehicle(s)</h3></div></div>  
													
								<cfset arguments.Get_Dealers_Zip = "" />
								<cfset arguments.Get_Dealers_Geo = "" />
								<cfset arguments.My_Zip = "" />
								<cfset arguments.Carfax_One_Owner = "" />
								<cfset arguments.Autocheck = "" />
								<cfset arguments.Disclaimer = "" />
								<cfset arguments.Certified = "" />
								<cfset arguments.AIS_wID = "" />
								<cfset arguments.half_year = "0" />
							
							    <cfoutput Query="qSearch"> 
									<cfquery name="Vehicle_Detl" datasource="Ultra10">
										SELECT	a.Vehicle_ID, a.Dealer_ID, a.Vin, a.Stock, a.Permalink, a.Img_Urls, a.Video_Link, a.V_New_Used, a.V_Year, a.V_Make, a.V_Model, a.V_Trim, a.V_Odometer, a.V_Model_Number, 
								    	        a.V_Type, a.V_Style, a.Interior_Color, a.Exterior_Color, a.Transmission, a.Engine_Size, a.Cylinders, a.Doors, a.Drivetrain, a.Passengers, a.Dealer_Comments, a.Fuel_Type, a.EPA_City, 
									            a.EPA_HWY, a.Adjusted_Baseline, a.Selling_Price_Label, a.Selling_Price, a.MSRP_Label, a.MSRP_Price, a.Rebate_Label, a.Rebate_Price, a.Incentive_Label, a.Incentive_Price, 
								    	        a.Savings_Label, a.Savings_Price, a.AIS_Label, a.AIS_Price, a.AIS_APR, a.Certified, a.Fleet, a.Luxury, a.Commercial, a.Carfax_One_Owner, a.Autocheck, a.Dealer_Display_Name, 
									            a.Dealer_Address_1, a.Dealer_Address_2, a.Dealer_City, a.Dealer_State, a.Dealer_Zip, a.Dealer_Phone, a.Dealer_Url, a.Link_Finance, a.Link_Service, a.Link_Sales, a.Link_Parts, 
									            a.Link_Directions, a.Disclaimer, a.AIS_wID, a.half_year, a.V_Half_Year, a.Date_Updated, a.User_Edit, a.Region_ID, b.ID, b.Region_text
						
										FROM    Vehicles a, Dealer_Regions b
										WHERE 	a.Vin = '#key#'
										 and		a.V_New_Used = '#custom2#' 
										and		a.region_id = b.ID
									 </cfquery>  
														 
									<!---Set Condition in Regular Speak--->
									<cfswitch expression="#Vehicle_Detl.V_New_Used#">
										<cfdefaultcase>
											<cfset variables.itype="Used">
										</cfdefaultcase>
										<cfcase value="N">
											<cfset variables.itype="New">
										</cfcase>
									</cfswitch>
								 	<cfif len(trim(Vehicle_Detl.Permalink)) gt 0 and len(trim(Vehicle_Detl.V_Make)) gt 0 and len(trim(Vehicle_Detl.V_Model)) gt 0 >
										<cfset variables.v_link="#lcase(Vehicle_Detl.V_Make)#/#lcase(Vehicle_Detl.V_Model)#/#lcase(Vehicle_Detl.Permalink)#">
									<cfelse>
										<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
									</cfif>
									 <div class="row  pad-top-10 pad-bottom-10 ">
										 <!---  <div class="col-md-3 pad-top-10 quik-link-btn"> <!--- I removed visible-md visible-lg to have it visible across the board--->
											 Search Inventory 
											<div class="tab-content srch-tabs">
												<div class="tab-pane active" id="srch">
													<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
														<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
														<cfinvokeargument name="btn_pull" value="pull-left"/>
													</cfinvoke>
												</div>
									 		</div>
									 	</div>    --->
									 
									 
										<div class="col-md-5  pull-left">
											  <cfswitch expression="#listlen(Vehicle_Detl.Img_Urls)#">
												<cfdefaultcase>  
													<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
														<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
														<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
														<cfinvokeargument name="img_title" value="#Vehicle_Detl.V_Year# #Vehicle_Detl.V_Make# #Vehicle_Detl.V_Model# #Vehicle_Detl.V_Trim#"/>
														<cfinvokeargument name="img_class" value="vdp-img"/>
														<cfinvokeargument name="Voi_Vin" value="#Vehicle_Detl.Vin#"/>
														<cfinvokeargument name="Permalink" value="#Vehicle_Detl.Permalink#"/>
														<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
														<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
														<cfinvokeargument name="New_Used" value="#Vehicle_Detl.V_New_Used#"/>
														<cfinvokeargument name="Certified" value="#Vehicle_Detl.Certified#"/>
													</cfinvoke>
												 </cfdefaultcase>
												<cfcase value="0">
													<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
														<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
														<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
														<cfinvokeargument name="img_title" value="#Vehicle_Detl.V_Year# #Vehicle_Detl.V_Make# #Vehicle_Detl.V_Model# #Vehicle_Detl.V_Trim#"/>
														<cfinvokeargument name="img_class" value="vdp-img"/>
														<cfinvokeargument name="Voi_Vin" value="#Vehicle_Detl.Vin#"/>
														<cfinvokeargument name="Permalink" value="#Vehicle_Detl.Permalink#"/>
														<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
														<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
													</cfinvoke>
												</cfcase> 
											</cfswitch>  
										</div>
										<div class="col-md-5 srp-specs visible-md visible-lg">
											<cfif len(trim(Vehicle_Detl.Permalink)) gt 0 and len(trim(Vehicle_Detl.V_Make)) gt 0 and len(trim(Vehicle_Detl.V_Model)) gt 0 >
												<cfset variables.v_link="#lcase(Vehicle_Detl.V_Make)#/#lcase(Vehicle_Detl.V_Model)#/#lcase(Vehicle_Detl.Permalink)#?itype=#variables.itype#">
											<cfelse>
												<cfset variables.v_link="vehicle_details.cfm?vin=#Vehicle_Detl.VOI_Vin#&itype=#variables.itype#">
											</cfif>
											
											<cfif #Vehicle_Detl.V_Make# eq "lincoln" >  <!--- Only LINCOLC is in upper case on SRP & VDP displays  01/14/2015 --->
												<a class="srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" 
													title="#Vehicle_Detl.V_Year# #Vehicle_Detl.V_Make# #Vehicle_Detl.V_Model# #Vehicle_Detl.V_Trim#"><h7>#ucase(Vehicle_Detl.V_Year)# #ucase(Vehicle_Detl.V_Make)# #ucase(Vehicle_Detl.V_Model)# #ucase(Vehicle_Detl.V_Trim)#</h7></a>	
											<cfelse>
												<a class="srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" title="#Vehicle_Detl.V_Year# #Vehicle_Detl.V_Make# #Vehicle_Detl.V_Model# #Vehicle_Detl.V_Trim#"><h7>#ucase(Vehicle_Detl.V_Year)# #Vehicle_Detl.V_Make# #Vehicle_Detl.V_Model# #Vehicle_Detl.V_Trim#</h7></a>	
											</cfif>
											
											<cfinvoke component="/cfcs/vehicles/vehicle_specs" method="vdp_default">
												<cfinvokeargument name="New_Used" value="#Vehicle_Detl.v_New_Used#"/>
												<cfinvokeargument name="Stock" value="#Vehicle_Detl.Stock#"/>
												<cfinvokeargument name="Model_Number" value="#Vehicle_Detl.V_Model_Number#"/>
												<cfinvokeargument name="Vin" value="#Vehicle_Detl.Vin#"/>
												<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
												<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
												<cfinvokeargument name="V_Body" value="#Vehicle_Detl.V_Style#"/>
												<cfinvokeargument name="V_Type" value="#Vehicle_Detl.V_Type#"/>
												<cfinvokeargument name="Engine_Size" value="#Vehicle_Detl.Engine_Size#"/>
												<cfinvokeargument name="V_Body" value="#Vehicle_Detl.V_Style#"/>
												<cfinvokeargument name="V_Type" value="#Vehicle_Detl.V_Type#"/>
												<cfinvokeargument name="Cylinders" value="#Vehicle_Detl.Cylinders#"/>
												<cfinvokeargument name="Transmission" value="#Vehicle_Detl.Transmission#"/>
												<cfinvokeargument name="Drivetrain" value="#Vehicle_Detl.Drivetrain#"/>
												<cfinvokeargument name="Odometer" value="#Vehicle_Detl.V_Odometer#"/>
												<cfinvokeargument name="Fuel_Type" value="#Vehicle_Detl.Fuel_Type#"/>
												<cfinvokeargument name="EPA_City" value="#Vehicle_Detl.EPA_City#"/>
												<cfinvokeargument name="EPA_HWY" value="#Vehicle_Detl.EPA_HWY#"/>
												<cfinvokeargument name="Exterior_Color" value="#Vehicle_Detl.Exterior_Color#"/>
												<cfinvokeargument name="Interior_Color" value="#Vehicle_Detl.Interior_Color#"/>
												<cfinvokeargument name="Location" value="#Vehicle_Detl.Dealer_Display_Name#"/>
												<cfinvokeargument name="Dealer_Phone" value="#Vehicle_Detl.Dealer_Phone#"/>
												<cfinvokeargument name="v_link" value="#variables.v_link#"/>
											</cfinvoke>
										</div>
										<div class="col-md-2">
											<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default">
												<cfinvokeargument name="Adjusted_Baseline" value="#Vehicle_Detl.Adjusted_Baseline#"/>
												<cfinvokeargument name="Selling_Price_Label" value="#Vehicle_Detl.Selling_Price_Label#"/>
												<cfinvokeargument name="Selling_Price" value="#Vehicle_Detl.Selling_Price#"/>
												<cfinvokeargument name="MSRP_Label" value="#Vehicle_Detl.MSRP_Label#"/>
												<cfinvokeargument name="MSRP_Price" value="#Vehicle_Detl.MSRP_Price#"/>
												<cfinvokeargument name="Rebate_Label" value="#Vehicle_Detl.Rebate_Label#"/>
												<cfinvokeargument name="Rebate_Price" value="#Vehicle_Detl.Rebate_Price#"/>
												<cfinvokeargument name="Incentive_Label" value="#Vehicle_Detl.Incentive_Label#"/>
												<cfinvokeargument name="Incentive_Price" value="#Vehicle_Detl.Incentive_Price#"/>
												<cfinvokeargument name="Savings_Label" value="#Vehicle_Detl.Savings_Label#"/>
												<cfinvokeargument name="Savings_Price" value="#Vehicle_Detl.Savings_Price#"/>
												<cfinvokeargument name="AIS_Label" value="#Vehicle_Detl.AIS_Label#"/>
												<cfinvokeargument name="AIS_Price" value="#Vehicle_Detl.AIS_Price#"/>
												<cfinvokeargument name="AIS_APR" value="#Vehicle_Detl.AIS_APR#"/>
												<cfinvokeargument name="VOI_Vin" value="#Vehicle_Detl.Vin#"/>
											</cfinvoke> 
										<cfif len(trim(arguments.Disclaimer)) gt 0>
											<a data-toggle="modal" data-target="###Vehicle_Detl.Vin#Modaldisc">* Disclaimer</a><br/>
										</cfif>
										<cfif len(trim(Vehicle_Detl.AIS_wID)) gt 0>
												<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#Vehicle_Detl.Vin#&wID=#Vehicle_Detl.AIS_wID#&zID=#Vehicle_Detl.Dealer_Zip#');">
													** See Incentives
												</a><br/>
										</cfif>
										<cfif Vehicle_Detl.Certified eq 1 and Vehicle_Detl.V_New_Used eq "U">
											<div class="pad-10">
												<cfif #url.dealer_id# neq 82>	
													<img Alt="#Vehicle_Detl.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#Vehicle_Detl.V_Make#.jpg"/>
												<cfelse>								
													<cfif #url.dealer_id# eq 82 and #Vehicle_Detl.V_Make# NEQ "Hyundai"> <!--- 02/02/2015 removed Hyundai Certified from Faulkner Mazda --->
														<img Alt="#Vehicle_Detl.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#Vehicle_Detl.V_Make#.jpg"/>
													</cfif>
												</cfif>
											</div>
										</cfif>
										<cfif url.Carfax eq 1 and Vehicle_Detl.V_New_Used eq "U">
											<div align="center">
												<cfif arguments.Carfax_One_Owner eq 1>
													<!---one owner--->
													<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#Vehicle_Detl.Vin#" target="_blank"><img Alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
												<cfelse>
													<!---carfax--->
													<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#Vehicle_Detl.Vin#" target="_blank"><img Alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
												</cfif>
											</div>
										</cfif>
									
 									<cfif Vehicle_Detl.Autocheck eq 1 and Vehicle_Detl.V_New_Used eq "U">  
											<div>
												 <a class="btn btn-navy" href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#Vehicle_Detl.Vehicle_ID#" target="_blank">
													Vehicle History Report
												</a> 
											</div>
										 </cfif> 
									</div>
								  </div>  
								<cfif len(trim(Vehicle_Detl.Dealer_Comments)) gt 0>
									<div class="row visible-md visible-lg">
										<div class="col-md-12">
											<div class="srp-comments">
												<div class="srp-comment-title">DEALER COMMENTS:</div>
												<a class="srp-comments" href="http://#cgi.server_name#/vehicles/#variables.v_link#">#Vehicle_Detl.Dealer_Comments#</a>
											</div>
										</div>
									</div>
								</cfif>
								<div class="row">
									<div class="col-md-12">
										<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="srp_standard">
											<cfinvokeargument name="Voi_Vin" value="#Vehicle_Detl.Vin#"/>
											<cfinvokeargument name="Permalink" value="#Vehicle_Detl.Permalink#"/>
											<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
											<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
											<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
											<cfinvokeargument name="New_Used" value="#Vehicle_Detl.V_New_Used#"/>
											<cfinvokeargument name="Certified" value="#Vehicle_Detl.Certified#"/>
										</cfinvoke>
									</div>
								</div>
								<cfif len(trim(Vehicle_Detl.Disclaimer)) gt 0>
									<cfinvoke component="/cfcs/ultra10/popups" method="v_disclaimer">
										<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
										<cfinvokeargument name="modal_name" value="#Vehicle_Detl.Vin#Modaldisc"/>
										<cfinvokeargument name="Disclaimer" value="#Vehicle_Detl.Disclaimer#"/>
									</cfinvoke>
								</cfif>
								<cfinvoke component="/cfcs/ultra10/popups" method="test_drive">
									<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
									<cfinvokeargument name="modal_name" value="#Vehicle_Detl.Vin#Modaltd"/>
									<cfinvokeargument name="VOI_Vin" value="#Vehicle_Detl.Vin#"/>
									<cfinvokeargument name="V_Year" value="#Vehicle_Detl.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#Vehicle_Detl.V_Trim#"/>
									<cfinvokeargument name="VOI_New_Used" value="#Vehicle_Detl.V_New_Used#"/>
									<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/popups" method="quick_quote">
									<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
									<cfinvokeargument name="modal_name" value="#Vehicle_Detl.Vin#Modalqq"/>
									<cfinvokeargument name="VOI_Vin" value="#Vehicle_Detl.Vin#"/>
									<cfinvokeargument name="V_Year" value="#Vehicle_Detl.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#Vehicle_Detl.V_Trim#"/>
									<cfinvokeargument name="VOI_New_Used" value="#Vehicle_Detl.V_New_Used#"/>
									<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/popups" method="rfq">
									<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
									<cfinvokeargument name="modal_name" value="#Vehicle_Detl.Vin#Modalrfq"/>
									<cfinvokeargument name="VOI_Vin" value="#Vehicle_Detl.Vin#"/>
									<cfinvokeargument name="V_Year" value="#Vehicle_Detl.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#Vehicle_Detl.V_Trim#"/>
									<cfinvokeargument name="VOI_New_Used" value="#Vehicle_Detl.V_New_Used#"/>
									<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/popups" method="eprc2">
									<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
									<cfinvokeargument name="modal_name" value="#Vehicle_Detl.Vin#Modaleprc2"/>
									<cfinvokeargument name="VOI_Vin" value="#Vehicle_Detl.Vin#"/>
									<cfinvokeargument name="V_Year" value="#Vehicle_Detl.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#Vehicle_Detl.V_Trim#"/>
									<cfinvokeargument name="VOI_New_Used" value="#Vehicle_Detl.V_New_Used#"/>
									<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/popups" method="adddetl">
									<cfinvokeargument name="dealer_id" value="#Vehicle_Detl.dealer_id#"/>
									<cfinvokeargument name="modal_name" value="#Vehicle_Detl.Vin#Modaladddetl"/>
									<cfinvokeargument name="VOI_Vin" value="#Vehicle_Detl.Vin#"/>
									<cfinvokeargument name="V_Year" value="#Vehicle_Detl.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#Vehicle_Detl.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#Vehicle_Detl.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#Vehicle_Detl.V_Trim#"/>
									<cfinvokeargument name="VOI_New_Used" value="#Vehicle_Detl.V_New_Used#"/>
									<cfinvokeargument name="Img_Urls" value="#Vehicle_Detl.Img_Urls#"/>
								</cfinvoke>
					    </cfoutput> 
						</div> 	<!--- close site search container --->
					</div>		<!--- close main container --->
				</section>
		</cfif>	

	</cffunction>

		
	
	<cffunction name="site_search_no_results" description="display if no search results" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
	
		<cfquery datasource="ultra10" name="dlr_name">SELECT Dealer_ID,Display_Name	FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		
		 <!--- <cfmail to="bob@worlddealer.net" from="site_search@worlddealer.net" subject="Zero Search Results from #dlr_name.Display_Name#" type="HTML">	 
		 	
			Somebody did a search for <b><i>"#url.err_dsp_criteria#"</i></b> and it returned no results.<br><br>
			Dealer Name: #dlr_name.Display_Name#<br><br>
			Dealer ID: #url.dealer_id#<br><br>
			Date/Time: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#
			
			<br>
		</cfmail> --->
		
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-12 " align="center" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" ><div class="col-md-12 site-h1">Your search for <b><i>"#url.err_dsp_criteria#"</i></b> found no results</h1></div></div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" ><div class="col-md-12 cta-h4">Please try again !</h4></div></div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" ><div class="col-md-4 col-md-offset-4"><a href="javascript:window.history.back()" class="cta-upper-v1-go-btn"> Go Back</span></a></div></div>
							</div>
						</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
					</div>
			</div>  <!--- container --->
		</section>

		
	</cffunction>
	
	<cffunction name="search_box_no_results" description="display if no search results" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
	
		<cfquery datasource="ultra10" name="dlr_name">SELECT Dealer_ID,Display_Name	FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		
		  <cfmail to="bob@worlddealer.net" from="site_search@worlddealer.net" subject="Zero Search Results from #dlr_name.Display_Name#" type="HTML">	 
		 	
			Somebody did a search for <b><i>"#url.err_dsp_criteria#"</i></b> and it returned no results.<br><br>
			Dealer Name: #dlr_name.Display_Name#<br><br>
			Dealer ID: #url.dealer_id#<br><br>
			Date/Time: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#
			
			<br>
		</cfmail>  
		
		
		<!--- <section class="section-spl"> --->
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-12 " align="center" >	
								<div class="row" Style="margin-top:100px!important;margin-bottom:30px!important" ><div class="col-md-12 site-h1">Your search for <b><i>"#url.err_dsp_criteria#"</i></b> found no results</h1></div></div>
								<div class="row" ><div class="col-md-12 no-results-pgtxt"><h4>Please try again !</h4></div></div>
								<div class="row" ><div class="col-md-4 col-md-offset-4" Style="margin-top:30px!important;margin-bottom:250px!important;font-size:20pt!important"><a href="javascript:window.history.back()"><u>Go Back</u></a></div></div>
							</div>
						</div>
					</div>
			</div>  <!--- container --->
		<!--- </section> --->

		
	</cffunction>
	
	<cffunction name="legacy_standard" description="create standard lease page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">

		<table>
			<tr><td align="left"><h2>Site Search</h2></td></tr>
			<tr><td>&nbsp;</td></tr>			<tr><td>&nbsp;</td></tr>

			<tr><td align="left">Coming Soon</td></tr>	
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
		</table>
		
	</cffunction>
	
	
</cfcomponent>