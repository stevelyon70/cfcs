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
		
		<cfif arguments.V_Model eq "FourRunner">
			<cfset arguments.V_Model="4Runner">
		</cfif>

		<cfset Get_Dealers_Zip=arguments.Get_Dealers_Zip>
		
		<cfset Get_Dealers_Geo=arguments.Get_Dealers_Geo>

		<cfif arguments.half_year eq 1>
			<cfset arguments.V_Year=arguments.V_Year & ".5">
		</cfif>

		<!--- Classic Cars --->
		    <cfif IsDefined("url.classic") AND #url.classic# NEQ "" >
			<cfset url.classic=#url.classic#>
			<!--- <cfset url.new_used="z">  --->
			<cfelse>
			<cfset url.classic="">
		</cfif>  
		
		
<!--- start row --->	

		<div class="container-fluid">
		<div class="row">
			<div class="col-md-12 srp-row">
				<div class="row">

					<div class="col-md-3">
						<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
							
							<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#?itype=#variables.itype#">
						<cfelse>
							<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#&itype=#variables.itype#">
						</cfif>
						
						<cfif #arguments.V_Make# eq "lincoln" >  <!--- Only LINCOLC is in upper case on SRP & VDP displays  01/14/2015 --->
							<a class="srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"><h3>#ucase(arguments.V_Year)# #ucase(arguments.V_Make)# #ucase(arguments.V_Model)#</h3>#ucase(arguments.V_Trim)#</a>	
						<cfelse>
							<a class="srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"><h3>#ucase(arguments.V_Year)# #arguments.V_Make# #arguments.V_Model#</h3>#arguments.V_Trim#</a>	
						</cfif>
						<br>
						<cfset url.new_used = #arguments.New_Used# >
						<cfset url.frmscrn = 1 >
						<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default">
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
							
						<div class="row">
							<div class="col-md-12">
								<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="srp_standard">
									<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
									<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
									<cfinvokeargument name="Certified" value="#arguments.Certified#"/>
								</cfinvoke>
							</div>
						</div>		
						
						
						<cfif len(trim(arguments.Disclaimer)) gt 0>
							<a data-toggle="modal" data-target="###arguments.Vin#Modaldisc">* Disclaimer</a><br/>
						</cfif>
						<cfif len(trim(arguments.AIS_wID)) gt 0>
							<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">
								** See Incentives
							</a><br/>
						</cfif>
						<cfif arguments.Certified eq 1 and arguments.New_Used eq "U">
							<div class="pad-10">
								<img Alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
							</div>
						</cfif>
						
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and #len(url.classic)# eq 0 >  
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
						
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" >  
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
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1"  > 
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
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"  >
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
						
						<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U">  
							<div>
								<a class="btn btn-navy" href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
									Vehicle History Report
								</a>
							</div>
						</cfif>
					</div>
					
					<div class="col-md-6">
							<!--- <div class="srp-title visible-sm visible-xs" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"><h7>#ucase(arguments.V_Year)# #ucase(arguments.V_Make)# #ucase(arguments.V_Model)# #ucase(arguments.V_Trim)#</h7>
						</div> --->
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
					
					<div class="col-md-3 srp-specs visible-md visible-lg">
						hold for dealer info

					</div>
				</div>
				
				
				<div class="row">
					<div class="col-md-12">
						<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
							
							<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#?itype=#variables.itype#">
						<cfelse>
							<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#&itype=#variables.itype#">
						</cfif>
						
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
						</cfinvoke>
						
					</div>
				</div>	
				 
				<cfif len(trim(arguments.Dealer_Comments)) gt 0>
					<div class="row visible-md visible-lg">
						<div class="col-md-12">
								<div class="srp-comment-title">
								<!--- <a class="srp-comments" href="##collapsecomments" data-toggle="collapse">DEALER COMMENTS</a> --->
								 <button type="button" class="btn btn-primary">DEALER COMMENTS</button>  
								</div>
  <div class="collapse">
							<div class="srp-comments">
								<a class="srp-comments" href="http://#cgi.server_name#/vehicles/#variables.v_link#">#arguments.Dealer_Comments#</a>
							</div>
</div>								
						</div>
					</div>
				</cfif>
			</div>
			
		</div>
		</div>
 	

 <script>
$(document).ready(function(){
    $(".btn-primary").click(function(){
        $(".collapse").collapse('toggle');
    });
    $(".btn-success").click(function(){
        $(".collapse").collapse('show');
    });
    $(".btn-warning").click(function(){
        $(".collapse").collapse('hide');
    });
});
</script>  

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
		<!--- <cfif #arguments.dealer_id# EQ 1> --->
			<cfinvoke component="/cfcs/ultra10/popups" method="baierl_certified">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="baierlModal"/>
			</cfinvoke>
		<!--- </cfif> --->
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

	<cffunction name="srp_legacy" description="legacy search results page" output="Yes" access="public">
		<!---arguments--->
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
		<cfargument name="Dealer_Display_Name" required="true"/>
		<cfargument name="Dealer_Address_1" required="true"/>
		<cfargument name="Dealer_Address_2" required="true"/>
		<cfargument name="Dealer_City" required="true"/>
		<cfargument name="Dealer_State" required="true"/>
		<cfargument name="Dealer_Zip" required="true"/>
		<cfargument name="Dealer_Phone" required="true"/>
		<cfargument name="Get_Dealers_Zip" default="" />
		<cfargument name="My_Zip" default="" />
		<cfargument name="Carfax_One_Owner" default="0" />
		<cfargument name="Autocheck" default="0" />
		<cfargument name="Certified" default="0"/>
		<cfargument name="half_year" default="0"/>
		<cfargument name="AIS_wID" default=""/>

		<cfif arguments.V_Model eq "FourRunner">
			<cfset arguments.V_Model="4Runner">
		</cfif>

		<cfset Get_Dealers_Zip=arguments.Get_Dealers_Zip>

		<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
			<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
		<cfelse>
			<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
		</cfif>

		<cfif arguments.half_year eq 1>
			<cfset arguments.V_Year=arguments.V_Year & ".5">
		</cfif>
		<table style="width:870px;border:1px solid ##ccc;margin:5px 0px 5px 0px;" cellpadding="0" cellspacing="0">
			<tr>
				<td style="padding:10px;" colspan="3">
					<a class="srp-title" href="http://#cgi.server_name#/vehicles/#variables.v_link#" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#ucase(arguments.V_Year)# #ucase(arguments.V_Make)# #ucase(arguments.V_Model)# #ucase(arguments.V_Trim)#</a>
				</td>
			</tr>
			<tr>
				<td style="width:200px;padding:10px;" valign="top">
					<cfswitch expression="#listlen(arguments.Img_Urls)#">
						<cfdefaultcase>
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="srp-img-legacy"/>
								<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
								<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
								<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
								<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
							</cfinvoke>
						</cfdefaultcase>
						<cfcase value="0">
							<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
								<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
								<cfinvokeargument name="img_class" value="srp-img-legacy"/>
								<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
								<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
								<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
								<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
							</cfinvoke>
						</cfcase> 
					</cfswitch>
				</td>
				<td style="width:380px;padding:10px;" valign="top">
					<cfinvoke component="/cfcs/vehicles/vehicle_specs" method="vdp_default">
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
						<cfinvokeargument name="v_link" value="#variables.v_link#"/>
					</cfinvoke>
				</td>
				<td style="width:200px;padding:10px;" valign="top">
					<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default">
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
					</cfinvoke>
					<cfif len(trim(arguments.AIS_wID)) gt 0>
						<cfif #url.dealer_id# NEQ 1  AND  #url.dealer_id# NEQ 65 AND  #url.dealer_id# NEQ 68 >
							<a href="http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#" target="_blank">
								** See Incentives
							</a><br/>
						</cfif>
						<cfif #url.dealer_id# EQ 1 and #arguments.V_Make# NEQ "Subaru" >
							<a href="http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#" target="_blank">
								** See Incentives
							</a><br/>
						</cfif>
					
					
							
						</cfif>
					<cfif arguments.Certified eq 1 and arguments.New_Used eq "U">
						<div align="center">
							<img Alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
						</div>
					</cfif>
					<cfif url.Carfax eq 1 and arguments.New_Used eq "U" and #len(url.classic)# eq 0 and arguments.Dealer_id neq 36 and arguments.Dealer_id neq 28 and arguments.Dealer_id neq 37 >
						<div align="center">
							<cfif arguments.Carfax_One_Owner eq 1>
								<!---one owner--->
								<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax One Owner"  border="0" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
							<cfelse>
								<!---carfax--->
								<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax"  border="0"src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
							</cfif>
						</div>
					</cfif>
					
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 36 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai")  >  <!--- CarFax only on Toyota Certified for WAM --->
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
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 28 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai")  >  <!--- CarFax only on Toyota Certified for WAM --->
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
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 37 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai")  >  <!--- CarFax only on Toyota Certified for WAM --->
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
					
					
					<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U" and arguments.Dealer_id neq 36>
						<div>
							<a class="btn btn-navy" href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
								Vehicle History Report
							</a>
						</div>
					</cfif>
					
					
						<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U" and arguments.Dealer_id eq 36 >  <!--- Washington AutoMall --->
							<cfif (arguments.V_Make NEQ "Toyota" AND arguments.V_Make NEQ "Hyundai") and arguments.Certified EQ 0 >
								<div>
									<a  href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
										<img class="img-responsive" src="http://dealers.wdautos.com/dealer/washingtonautomall/images/icons/btn_AutoCheck.png" alt="Vehicle History Report" />
									</a>
								</div>
							</cfif>
						</cfif>
					
					<cfswitch expression="#url.Dealer_ID#">
						<cfcase value="66,69">
							<cfif len(trim(arguments.Img_Urls)) gt 0>
								<cfset variables.this_img=listgetat(arguments.Img_Urls,1)>
								<cfset variables.din_photo=variables.this_img>
							<cfelse>
								<cfset variables.din_photo="http://static.wdautos.com/images/inventory/default/coming_soon_250.jpg">
							</cfif>
							<cfinvoke component="/cfcs/ultra10/plug_driveitnow" method="srp">
								<cfinvokeargument name="dealer_id" value="5279 "/>
								<cfinvokeargument name="vin" value="#arguments.Vin#">
								<cfinvokeargument name="stock" value="#arguments.Stock#">
								<cfinvokeargument name="zip" value="89041">
								<cfinvokeargument name="price" value="#arguments.Selling_Price#">
								<cfinvokeargument name="v_year" value="#arguments.V_Year#">
								<cfinvokeargument name="v_make" value="#arguments.V_Make#">
								<cfinvokeargument name="v_model" value="#arguments.V_Model#">
								<cfinvokeargument name="v_style" value="#arguments.V_Style#">
								<cfinvokeargument name="transmission" value="#arguments.Transmission#">
								<cfinvokeargument name="odometer" value="#arguments.Odometer#">
								<cfinvokeargument name="condition" value="#arguments.New_Used#">
								<cfinvokeargument name="v_photo" value="#variables.din_photo#">
							</cfinvoke>
						</cfcase> 
					</cfswitch>
					<cfswitch expression="#arguments.Dealer_ID#">
						<!--- <cfcase value="68">
							<cfif arguments.New_Used eq "N">
								<div style="padding-top:10px;" align="center"><img alt="0 Percent APR" src="http://#cgi.server_name#/images/inventory/icon_INV_0PercentAPR.jpg"/></div>
							</cfif>
						</cfcase> --->
					</cfswitch>
				</td>
			</tr>
			<cfif len(trim(arguments.Dealer_Comments)) gt 0>
				<tr>
					<td style="padding:10px;" colspan="3">
						<div class="srp-comment-title">DEALER COMMENTS:</div>
						<div style="height:30px;overflow:auto;"><a class="srp-comments" href="http://#cgi.server_name#/vehicles/#variables.v_link#">#arguments.Dealer_Comments#</a></div>
					</td>
				</tr>
			</cfif>
			<tr>
				<td style="padding:10px;" colspan="3">
					<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="srp_legacy">
						<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
						<cfinvokeargument name="Permalink" value="#arguments.Permalink#"/>
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
						<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
						<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
						<cfinvokeargument name="Certified" value="#arguments.Certified#"/>
					</cfinvoke>
				</td>
			</tr>
		</table>
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

		<!---Get Vehicle Options--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.vin,17)#" maxlength="21">
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
		
		
		<cfif #url.dealer_id# eq 24 or <!--- Faulkner Mazda Harrisburg --->
				 #url.dealer_id# eq 82 or <!--- Faulkner Mazda Harrisburg --->
					 #url.dealer_id# eq 78 or <!--- Faulkner Nissan Harrisburg --->
						 #url.dealer_id# eq 79> <!--- Faulkner Nissan Trevose --->  
			<script type="text/javascript" src="http://maxinsights.biz/scripts/MAXSEPublishing.js"></script>
			<script type="text/javascript" src="http://maxinsights.biz/scripts/config_website.js"></script>
		</cfif>
		
	<!--- Check for Custom Buttons--->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		
		<cfquery datasource="ultra10" name="Get_Btns">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 3
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_vdp_return_btns = #Get_Btns.recordcount# >
	<!--- Check for Custom Buttons--->
		
		
		<!--- Get dealer Cobalt_url for GM Window Sticker --->
		 
			<!--- <cfquery datasource="Ultra10" name="Get_Cobalt_url">
				SELECT		Dealer_ID, cobalt_url
				FROM		Dealers
				WHERE		dealer_id = #url.dealer_id#
			</cfquery>
			<cfset tmp_Cobalt_url = "" >
			<cfif #Get_Cobalt_url.cobalt_url#  NEQ "" >
				<cfset tmp_Cobalt_url = #Get_Cobalt_url.cobalt_url# >
			</cfif>  --->

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

		 <cfif NOT IsDefined("url.srch") > 
			<cfif #variables.cust_btns# EQ 1 AND #variables.nbr_vdp_return_btns# GT 0 >
				<div class="row">
					<div class="col-md-3 pad-top-10">
						<a href="#cgi.http_referer#" class="btn btn-vdp-return-cust">
							<cfif #Get_Btns.Btn_Image# NEQ "" >
								<img  alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/>&nbsp;	
							<cfelse>
								<i class="glyphicon glyphicon-arrow-left"></i>&nbsp;
							</cfif>
							#Get_Btns.Btn_Title#</a>
					</div>
				</div>
			<cfelse>
				<div class="row">
					<div class="col-md-5 pad-top-10">
						<a href="#cgi.http_referer#" class="btn btn-primary"><i class="glyphicon glyphicon-arrow-left"></i> Back to Inventory</a>
					</div>
				</div>
			</cfif>	
		  <cfelse>
			<div class="row">
				<div class="col-md-12 pad-top-10">
					&nbsp;
						<!--- <a href="#cgi.http_referer#?srch=#url.srch#"
						Style="background-color:##ffffff;color:##666666;border:1px solid ##666666;border-radius:5px!important;-moz-border-radius:5px!important;-webkit-border-radius:5px!important;padding:3px 3px 3px 3px;" 
						class="btn btn-primary"><i class="glyphicon glyphicon-arrow-left"></i> Back to Search Results</a> --->
				</div>
			</div>
		</cfif>	 
		<!--- <cfif #url.dealer_id# eq 236 >
			<div class="row">
				<div class="col-md-12 pad-top-10">
					
					<div id="mmd-widget"></div>
				</div>
			</div>
		
		
		</cfif>  --->
	
		<div class="row">
			<div class="col-md-9">
		<cfif arguments.half_year eq 1>
			<cfset arguments.V_Year=arguments.V_Year & ".5">
		</cfif>
				<h1 class="vdp-title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h1>
				<cfif len(trim(arguments.Dealer_Phone)) gt 0><a class="vdp-store-phone txt-red visible-xs visible-sm" href="tel:#reReplace( arguments.Dealer_Phone, "[^[:digit:]]", '', "all")#"><b>Call Now: #arguments.Dealer_Phone#</b></a></cfif>
				<div class="visible-md visible-lg vdp-text vdp-condition"><b>Condition:</b> #variables.New_Used# | <b>Stock ##:</b> #arguments.Stock# | <b>Model ##:</b> #arguments.Model_Number# | <span class="txt-green"><b>IN STOCK</b></span></div>
                <div class="row">
                	<div class="col-md-12">
                    <cfif arguments.dealer_id eq 15 and arguments.V_New_Used eq "N">
                        <span style="font-weight:bold;font-size:12px;color:red;display:block;padding:5px 0px 5px 10px;">
                            Please call one of our sales consultants at (724) 741-1207 to see if you qualify for additional rebates
                        </span>
                    </cfif>
                    <cfif arguments.dealer_id eq 15 and arguments.V_New_Used neq "N">
                        <span style="font-weight:bold;font-size:12px;color:red;display:block;padding:5px 0px 5px 10px;">
                            All customers qualify for this price. Qualified customers may recieve additional rebates. Please call for details.
                        </span>
                    </cfif>
                    </div>
                </div>
				<div class="row">
					<div class="col-md-8">
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
						<cfif url.dealer_id eq 18 and arguments.V_New_Used eq "N" and arguments.V_Year eq "2014" and arguments.V_Model eq "Altima">
							<div style="padding-top:10px;" align="center"><img alt="Altima"  class="img-responsive" src="http://#cgi.server_name#/images/oem/2014NissanAltima.png"/></div>
						</cfif>
					</div>
					<div class="col-md-4">
						<div class="price-block">
							<cfset url.new_used = #arguments.V_New_Used# >
							<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default">
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
		 				
							
							<cfif len(trim(arguments.Disclaimer)) gt 0>
								<a data-toggle="modal" data-target="##discModal">* Disclaimer</a><br/>
							</cfif>
							
							<!--- <cfif #url.dealer_id# eq 54 >
								<script type="text/javascript" src="http://automarksolutions.com/plugin/IPQ/check/?did=2098&vin=#arguments.Vin#"></script><BR>
								<script type="text/javascript" src="http://automarksolutions.com/plugin/MAO/check/?did=2098&vin=#arguments.Vin#"></script><BR>
								<script type="text/javascript" src="http://automarksolutions.com/plugin/LSO/check/?did=2098&vin=#arguments.Vin#"></script><BR>
							</cfif> --->
							<cfif  #url.dealer_id# eq 52 >
								<script type="text/javascript" src="http://automarksolutions.com/plugin/IPQ/check/?did=2099&vin=#arguments.Vin#"></script><BR>
								<script type="text/javascript" src="http://automarksolutions.com/plugin/MAO/check/?did=2099&vin=#arguments.Vin#"></script><BR>
								<script type="text/javascript" src="http://automarksolutions.com/plugin/LSO/check/?did=2099&vin=#arguments.Vin#"></script><BR>
							</cfif>
							<!--- Unity Works jquery Hack for Findlay Toyota - MK: 6/25/2014 --->
							<cfif url.dealer_id eq 70>
								<div align="center">
									<div id="uwm_#arguments.Vin#" title="popup" width="643" height="360" ></div>
									<div id="uwm_#arguments.Vin#" title="popup"></div>
									<div id="uwm_#arguments.Vin#" title="popup"></div>
								</div>
							<cfelse>
						 	
						 <cfif 	#url.dealer_id# EQ 88 or  <!--- Fuccillo 01/19/2015 --->
									#url.dealer_id# EQ 171 or
						 				#url.dealer_id# EQ 85 or 
						 				#url.dealer_id# EQ 76 or 
						 				#url.dealer_id# EQ 169 or 
						 				#url.dealer_id# EQ 170 or 
											#url.dealer_id# EQ 86 or 
												#url.dealer_id# EQ 87 or
													#url.dealer_id# EQ 89 >
									<script src="http://integrator.swipetospin.com"></script>
							</cfif>      
							
								<!---Video Player--->
								<cfif #url.dealer_id# NEQ 88 and  <!--- Fuccillo 01/02/2015 --->
										#url.dealer_id# NEQ 171 and
										#url.dealer_id# NEQ 85 and 
										#url.dealer_id# NEQ 76 and 
										#url.dealer_id# NEQ 169 and 
										#url.dealer_id# NEQ 170 and 
										#url.dealer_id# NEQ 86 and 
										#url.dealer_id# NEQ 87 and
										#url.dealer_id# NEQ 28 and
										#url.dealer_id# NEQ 89 >
									<cfif len(trim(arguments.Video_Link)) gt 0>
										<cfif #url.dealer_id# EQ 28 and #arguments.V_New_Used# EQ "U" >
											<a href="##" onclick="javascript:getVid('#arguments.Video_Link#');">
												<img src="http://#cgi.server_name#/images/inventory/icon_playvideo_off.png">
											</a>
										</cfif>
										
									</cfif>
								</cfif>
								<cfif #url.dealer_id# EQ 28 and #arguments.V_New_Used# EQ "U" >	  <!--- Washington Honda Used ONLY 03/17 --->
									<a href="##" onclick="javascript:getVid('#arguments.Video_Link#');">
										<img src="http://#cgi.server_name#/images/inventory/icon_playvideo_off.png">
									</a>
								</cfif>
	
							</cfif>
							<cfif len(trim(arguments.AIS_wID)) gt 0>
							
							<cfif #url.dealer_id# NEQ 1  AND  #url.dealer_id# NEQ 65 AND  #url.dealer_id# NEQ 68 >
								<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">
									** See Incentives
								</a><br/>
							</cfif>
							<cfif #url.dealer_id# EQ 1 and #arguments.V_Make# NEQ "Subaru" >
								<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">
									** See Incentives
								</a><br/>
							</cfif>
							
							<!--- 
							
								<a href="##" onclick="javascript:getAIS('http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#');">
									** See Incentives
								</a><br/> --->
							</cfif>

<!--- Findlay Road Test Videos --->					
						<cfif #url.dealer_id# eq 70 >
							<cfif #arguments.V_Model# EQ "Sienna" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Sienna/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "4Runner" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/4Runner/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Avalon" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Avalon/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a>
							</cfif>
							<cfif #arguments.V_Model# EQ "Camry" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Camry/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Camry Hybrid" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Camry Hybrid/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Corolla" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Corolla/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a>
							</cfif>
							<cfif #arguments.V_Model# EQ "FJ Cruiser" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/FJ Cruiser/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Highlander" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Highlander/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Highlander Hybrid" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Highlander Hybrid/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Land Cruiser" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Land Cruiser/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Matrix" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Matrix/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Prius" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Prius/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "RAV4" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/RAV4/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a>
							</cfif>
							<cfif #arguments.V_Model# EQ "Sequoia" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Sequoia/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a>
							</cfif>
							<cfif #arguments.V_Model# EQ "Tacoma" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Tacoma/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a>
							</cfif>
							<cfif #arguments.V_Model# EQ "Tundra" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Tundra/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Venza" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Venza/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Yaris" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Yaris/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Prius v" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Prius v/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Tundra Towing" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Tundra Towing/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
							<cfif #arguments.V_Model# EQ "Prius c" >
								<a onclick="javascript:window.open('http://vehiclestest.com/uYMFrkgR2LBGA2uUEFY8pw/singlevideolinkwidget/Toyota/FindlayToyota/27020/Prius c/','vehicletest','width=485px,height=650')" style="display:block;cursor:pointer;" target="_blank"><img src="http://vehiclestest.com/__images/VehiclesTEST-Video-red.png" width="148px"></a> 
							</cfif>
						</cfif>			
<!--- END Toyota Road Test Videos --->						
						
							<!--- Kelly Nissan 02/10/2015 --->
							  <cfif 	#url.dealer_id# EQ 18 or #url.dealer_id# EQ 17 or #url.dealer_id# EQ 365 >
								<script src="http://integrator.swipetospin.com"></script>
							</cfif>   
						</div>
						<div class="row visible-xs visible-sm">
							<div class="vdp-form-mobile">
								<cfswitch expression="#url.dealer_id#">
									<cfcase value="17,18,32,33,34,35">
										<div class="vdp-form-title">CHECK FOR MORE SAVINGS</div>
									</cfcase>
									<cfcase value="36,37,28,25">
										<div class="vdp-form-title" align="center" >Get e-Price</div>
									</cfcase>
									<cfcase value="82">
										<div class="vdp-form-title" align="center" >GET FAULKNER PRICE</div>
									</cfcase>
									<cfcase value="80">
										<div class="vdp-form-title" align="center" ><span style="color:black">REQUEST A QUOTE</span></div>
									</cfcase>
									<cfcase value="38">
										<div class="vdp-form-title" align="center" ><span style="color:black">REQUEST MORE INFO</span></div>
									</cfcase>
									<cfcase value="179">
										<div class="vdp-form-title" align="center" ><span style="color:black">REQUEST MORE INFO</span></div>
									</cfcase>
									<cfcase value="45">
										<div class="vdp-form-title" align="center" ><span style="color:black">REQUEST MORE INFO</span></div>
									</cfcase>
									<cfdefaultcase>
										<div class="vdp-form-title">REQUEST A QUOTE</div>
									</cfdefaultcase>
								</cfswitch>
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_details">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/vehicles/qq_action.cfm"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="vdp_standard">
									<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="exclude_print" value="yes"/>
								</cfinvoke>
							</div>
						</div>
<div id="section1_ID"></div>	<!--- Anchor for Make My Deal Kelly Ford & CDJR --->
						<div class="vdp-text">
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
								<cfinvokeargument name="Location" value="#arguments.Dealer_Display_Name#"/>
							</cfinvoke>
							<cfif arguments.Certified eq 1 and arguments.New_Used eq "U">
								<div class="pad-10">
									<cfif #url.dealer_id# neq 82 and  #url.dealer_id# neq 249 >	
									<img alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
								<cfelse>								
									<cfif #url.dealer_id# eq 82 and #arguments.V_Make# NEQ "Hyundai"> <!--- 02/02/2015 removed Hyundai Certified from Faulkner Mazda --->
										<img alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
									</cfif>							
									<cfif #url.dealer_id# eq 249 > <!--- Internetautoreno --->
										<img Alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/logo_DealerCertified.png"/>
									</cfif>
								</cfif>
								</div>
							</cfif>
<!--- KellyNissan 07/02/2015 --->					
							<cfif #url.dealer_id# EQ 18 and len(arguments.Video_Link) GT 0 >
								<a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"   src="http://dealers.wdautos.com/images/inventory/btn_LotVantage_Videos.png"/></a>
							</cfif>
							
							<cfif #url.dealer_id# EQ 45 and arguments.New_Used eq "U" and arguments.certified eq "1"  and arguments.V_Make eq "Scion" >
								<br/><img src="http://dealers.wdautos.com/dealer/stoltzscion/images/library/logo_ScionCPO.png"><br/>
							</cfif>
							<cfif #url.dealer_id# EQ 45 ><br/>
								<a href="http://#cgi.server_name#/forms/trade.cfm">
										<img src="http://dealers.wdautos.com/dealer/stoltzscion/images/library/btn_ValueYourTrade_Scion.png">
								</a><br/>
							</cfif>
							<cfif url.Carfax eq 1 and arguments.New_Used eq "U" and ( #url.year# GT 1990 ) AND ( #url.dealer_id# NEQ 36 AND #url.dealer_id# NEQ 28 AND #url.dealer_id# NEQ 37 )>
								<div align="center">
									<cfif arguments.Carfax_One_Owner eq 1>
										<!---one owner--->
										<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
									<cfelse>
										<!---carfax--->
										<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
									</cfif><br>
								</div>
							</cfif>
							
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 36 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
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
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 37 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
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
								
						<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 28 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
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
							
							<!--- Courtesy Certified  --->							
							<cfif (arguments.Dealer_id eq 288 OR  arguments.Dealer_id eq 67) and arguments.New_Used eq "U" and #arguments.V_Year# GT 1991 >
								<div align="center" >
									<a data-toggle="modal" style="cursor:pointer" data-target="##certModal"><img src="http://dealers.wdautos.com/dealer/courtesylotus/images/icons/logo_CertifiedWarranty.jpg" alt="Certified" /></a> 
								</div>
							</cfif>
						
						
						<!--- Baierl Certified 04/20/2015  --->
						   <cfif 	( 	#url.dealer_id# eq 1 OR 
							   			#url.dealer_id# eq 132 OR 
								   		#url.dealer_id# eq 195 OR 
									 	#url.dealer_id# eq 16 OR 
										#url.dealer_id# eq 2 OR 
										#url.dealer_id# eq 14 OR 
										#url.dealer_id# eq 3 OR 
										#url.dealer_id# eq 4 OR 
										#url.dealer_id# eq 6 OR 
										#url.dealer_id# eq 148 OR 
										#url.dealer_id# eq 7 OR 
										#url.dealer_id# eq 8 OR 
										#url.dealer_id# eq 9 OR 
										#url.dealer_id# eq 10 OR 
										#url.dealer_id# eq 162 OR 
										#url.dealer_id# eq 12 OR 
										#url.dealer_id# eq 15 ) and 
										#arguments.V_Make# NEQ "FIAT" and #arguments.New_Used# EQ "U" AND #arguments.Certified# eq 0 AND #arguments.Dealer_Display_Name# NEQ "Baierl Fiat"> 
								<div align="center">
									<a data-toggle="modal" style="cursor:pointer" data-target="##baierlModal"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/baierl/pdfs/SUperCarMobile.jpg" alt="Baierl Certified" /></a>
									
								</div>
						</cfif>   
						
						<!--- Baierl Certified --->
						
<!--- LotVanage Videos 06/26/2015 --->		
							
						<cfquery name="LV_Video" datasource="ultra10" >
								SELECT    a.LotVantage_video, b.lv_on
								FROM      Vehicles a, dealers b
								WHERE	a.vin='#arguments.Vin#'
								AND		a.dealer_id = b.dealer_id
								and		b.lv_on = 1
							</cfquery>
				
						<cfif #LV_Video.LotVantage_video# NEQ "" >
							<br>
							<a onclick="javascript:window.open('#LV_Video.LotVantage_video#','vehicletest','width=650px,height=500')" style="display:block;cursor:pointer;" >
							 <img Alt="Internet Special"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/btn_LotVantage_Videos.png"/></a> 
						</cfif>
						
						
<!--- LotVanage Videos 06/26/2015 --->			
						
						<cfif #url.dealer_id# eq 25 and arguments.New_Used eq "U" >   <!--- 04/08/2015 Fayette Honda --->
							<cfquery name="IS_Fayette" datasource="ultra10" >
								SELECT    Util_fld
								FROM         Vehicles
								WHERE	vin='#arguments.Vin#'
							</cfquery>
							<cfif #IS_Fayette.util_fld# EQ 1 >
								<img Alt="Internet Special"  class="img-responsive" src="http://dealers.wdautos.com/dealer/fayettehonda/images/library/icon_Fayette_InternetSpecial.png"/>
							</cfif>
						</cfif>
						
							<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U" and arguments.Dealer_id neq 36 and arguments.Dealer_id neq 25>
								<div class="pad-10">
									<a class="btn btn-navy" href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
										VEHICLE HISTORY REPORT
									</a>
								</div>
							</cfif>
							
							
					
						<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U" and ( arguments.Dealer_id eq 36  or arguments.Dealer_id eq 25 ) >  <!--- Washington AutoMall --->
							<cfif (arguments.V_Make NEQ "Toyota" AND  arguments.V_Make NEQ "Hyundai") and arguments.Certified EQ 0 >
								<div>
									<a   href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
										<img class="img-responsive" src="http://dealers.wdautos.com/dealer/washingtonautomall/images/icons/btn_AutoCheck.png" alt="Vehicle History Report" />
									</a>
								</div>
							</cfif>
								<cfif arguments.V_Make NEQ "Honda" and arguments.Certified EQ 1 >
								<div>
									<a   href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
										<img class="img-responsive" src="http://dealers.wdautos.com/dealer/washingtonautomall/images/icons/btn_AutoCheck.png" alt="Vehicle History Report" />
									</a>
								</div>
							</cfif>
						</cfif>
							
						   	<cfif url.dealer_id eq 236 and #arguments.New_Used# EQ "N" >
								<div class="pad-10">
									<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
								</div>
							</cfif>   
							
							<cfif url.dealer_id eq 36 and #len(arguments.Video_Link)# GT 0 >
									<div align="center"><a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"  src="http://#cgi.server_name#/images/inventory/icon_playvideo_off_white.png"></a></div>
							</cfif>		
							
							
						   	<cfif (url.dealer_id eq 259 or url.dealer_id eq 252) and #arguments.New_Used# EQ "N" >  <!--- Murrays Ford Window Sticker --->
								<div class="pad-10">
									<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
								</div>
							</cfif>   
							
							
						   	<cfif url.dealer_id eq 6 and #arguments.New_Used# EQ "N" > <!--- Baierl Ford Window Sticker--->
								<div class="pad-10">
									<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
								</div>
							</cfif>   
						   	<cfif url.dealer_id eq 43 and #arguments.New_Used# EQ "N" > <!--- Stoltz Ford Window Sticker- --->
								<div class="pad-10">
									<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/stoltzofstmarys/images/icons/ford_sticker.png"/></a>
								</div>
							</cfif>   
						   	<cfif url.dealer_id eq 43 and ( #arguments.New_Used# EQ "N" OR #arguments.New_Used# EQ "U")> <!--- Stoltz Ford Window Sticker- --->
								<div class="pad-10">
									<script type='text/javascript'>var o={color:'##075CAF',align:'right',headerText:'Send to My Phone',bodyText:'Send this listing to my phone.',logo:'',logoLink:'',startOpen:!0},gid=2714,c=document.createElement('link');c.type='text/css',c.href='https://apps.slicktext.com/IMG/widget/styles/build.css',c.media='all',c.rel='stylesheet',document.body.appendChild(c);var
 j=document.createElement('script');j.type='text/javascript',j.src='https://apps.slicktext.com/IMG/widget/scripts/build.js',document.body.appendChild(j);/*
 NEED SUPPORT? Email: support@TextUps.com
 or call 1.800.278.4670 */</script>

								</div>
							</cfif>   
							 
							 
						   	<cfif url.dealer_id eq 132 and #arguments.New_Used# EQ "N" >  <!---   Northepoint CDJR --->
								<div class="pad-10">
									<a href="http://www.chrysler.com/hostd/windowsticker/getWindowStickerPdf.do?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/northpointeauto/images/icons/logo_sticker.jpg"/></a>
								</div>
							</cfif>    
						   <cfif url.dealer_id eq 195 and #arguments.New_Used# EQ "N" > <!---   Northepoint GM --->
								<div class="pad-10">
									<a href="http://www.northpointecars.com/f_WindowSticker?VIN=#arguments.Vin#&businessAssociate=221869" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/northpointeautogm/images/icons/logo_sticker.jpg"/></a>
								</div>
							</cfif>       
						   	<cfif url.dealer_id eq 83 and #arguments.New_Used# EQ "N" >
								<div class="pad-10">
									<a href="http://www.pinegarchevy.net/f_WindowSticker?VIN=#arguments.Vin#&businessAssociate=118920" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/pinegarchevy/images/icons/logo_sticker.jpg"/></a>
								</div>
							</cfif> 
							<cfif ( #url.dealer_id# eq 24 OR <!--- Faulkner Mazda Harrisburg --->
									 #url.dealer_id# eq 82  OR <!--- Faulkner Mazda Harrisburg --->
									 	#url.dealer_id# eq 78  OR <!--- Faulkner Nissan Harrisburg --->
									 		#url.dealer_id# eq 79 ) and  <!--- Faulkner Nissan Jenkintown --->
									 			arguments.New_Used eq "U">  
								<div align="center">
									<a name="MaxSeLinkPlaceholder" data-vin="#arguments.Vin#"><img alt="Faulkner"  class="img-responsive" src="http://dealers.wdautos.com/dealer/faulknermazdharrisburg/images/icons/image012.png"/></a>
								</div>
							</cfif>	
							
							<!--- Kelly Buick  --->							
							<cfif arguments.Dealer_id eq 32 >
								<div align="center" >
									<a href="http://kellycarbuickgmc.com/dealer/kellybuickgmc/vehicle_range_finder.cfm"><img class="img-responsive" alt="AutoTrader Vehicle Range Finder" src="http://dealers.wdautos.com/dealer/kellybuickgmc/images/library/AutoTrader_Vehicle_Range_Finder.jpg"/></a> 
								</div>
							</cfif>
							
						
							<!--- Faulkner Mazda  --->							
							<!---  <cfif arguments.Dealer_id eq 82  >
								<div align="center" ><br>
									<cfif arguments.V_New_Used eq "U" >
										<a onclick="javascript:window.open('http://applications.contactatonce.com/CaoClientContainer.aspx?MerchantId=4958&amp;Providerid=512&amp;PlacementId=1&amp;OriginationUrl='+encodeURIComponent(location.href),'','resizable=yes,toolbar=no,menubar=no,location=no,scrollbars=no,status=no,height=400,width=600');return false;" href="##"><img onerror="this.height=0;this.width=0" src="http://applications.contactatonce.com/getagentstatusimage.aspx?MerchantId=4958&amp;ProviderId=512&amp;PlacementId=1" border="0" /></a>
									<cfelse>
										<a onclick="javascript:window.open('http://applications.contactatonce.com/CaoClientContainer.aspx?MerchantId=3883&amp;Providerid=435&amp;PlacementId=1&amp;OriginationUrl='+encodeURIComponent(location.href),'','resizable=yes,toolbar=no,menubar=no,location=no,scrollbars=no,status=no,height=400,width=600');return false;" href="##"><img onerror="this.height=0;this.width=0" src="http://applications.contactatonce.com/getagentstatusimage.aspx?MerchantId=3883&amp;ProviderId=435&amp;PlacementId=1" border="0" /></a>
									</cfif>									
								</div>
							</cfif>   --->
										
							
							<cfif   #url.dealer_id# eq 76 or 
										#url.dealer_id# eq 169 or 
											#url.dealer_id# eq 170 or  
												#url.dealer_id# eq 88 or 
													#url.dealer_id# eq 89 or 
														#url.dealer_id# eq 85 or 
															#url.dealer_id# eq 86 or 
																#url.dealer_id# eq 87 or 
																	#url.dealer_id# eq 18 or    <!--- Kelly Nissan --->
																		#url.dealer_id# eq 171 >
									<script src="http://integrator.swipetospin.com"></script>
							</cfif>
							
							<cfif #url.dealer_id# eq 171 >
								<cfif #arguments.V_Model# EQ "K900" >
									<script type="text/javascript">
										var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
										var hl_script = document.createElement("script");
										hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=K900';
										hl_script.type = 'text/javascript';
										hl_script.id = "HL_ScriptCall";
										document.getElementsByTagName('head')[0].appendChild(hl_script);
									</script>
								<cfelseif #arguments.V_Model# EQ "Optima" >
									<script type="text/javascript">
										var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
										var hl_script = document.createElement("script");
										hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=Optima';
										hl_script.type = 'text/javascript';
										hl_script.id = "HL_ScriptCall";
										document.getElementsByTagName('head')[0].appendChild(hl_script);
									</script>
								<cfelseif #arguments.V_Model# EQ "Cadenza" >
									<script type="text/javascript">
										var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
										var hl_script = document.createElement("script");
										hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=Cadenza';
										hl_script.type = 'text/javascript';
										hl_script.id = "HL_ScriptCall";
										document.getElementsByTagName('head')[0].appendChild(hl_script);
									</script>
								<cfelseif #arguments.V_Model# EQ "Sorento" >
									<script type="text/javascript">
										var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
										var hl_script = document.createElement("script");
										hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=Sorento';
										hl_script.type = 'text/javascript';
										hl_script.id = "HL_ScriptCall";
										document.getElementsByTagName('head')[0].appendChild(hl_script);
									</script>
								</cfif>		
							</cfif>						
							<cfif #url.dealer_id# eq 180 >
								<cfif #arguments.V_Model# EQ "K900" >
									<script type="text/javascript"> 
									 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
									 var hl_script = document.createElement("script"); 
									 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=K900';
									 hl_script.type = 'text/javascript'; 
									 hl_script.id = "HL_ScriptCall"; 
									 document.getElementsByTagName('head')[0].appendChild(hl_script);
									 </script>
								<cfelseif #arguments.V_Model# EQ "Optima" >
									<script type="text/javascript"> 
									 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
									 var hl_script = document.createElement("script"); 
									 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=Optima';
									 hl_script.type = 'text/javascript'; 
									 hl_script.id = "HL_ScriptCall"; 
									 document.getElementsByTagName('head')[0].appendChild(hl_script);
									 </script>
								<cfelseif #arguments.V_Model# EQ "Cadenza" >
									<script type="text/javascript"> 
									 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
									 var hl_script = document.createElement("script"); 
									 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=Cadenza';
									 hl_script.type = 'text/javascript'; 
									 hl_script.id = "HL_ScriptCall"; 
									 document.getElementsByTagName('head')[0].appendChild(hl_script);
									 </script>
								<cfelseif #arguments.V_Model# EQ "Sorento" >
									<script type="text/javascript"> 
									 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
									 var hl_script = document.createElement("script"); 
									 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=Sorento';
									 hl_script.type = 'text/javascript'; 
									 hl_script.id = "HL_ScriptCall"; 
									 document.getElementsByTagName('head')[0].appendChild(hl_script);
									 </script>

								</cfif>
							</cfif>
							
							<cfswitch expression="#url.Dealer_ID#">
								<cfcase value="66,69">
									<cfif len(trim(arguments.Img_Urls)) gt 0>
										<cfset variables.this_img=listgetat(arguments.Img_Urls,1)>
										<cfset variables.din_photo=variables.this_img>
									<cfelse>
										<cfset variables.din_photo="http://static.wdautos.com/images/inventory/default/coming_soon_250.jpg">
									</cfif>
									<cfinvoke component="/cfcs/ultra10/plug_driveitnow" method="vdp">
										<cfinvokeargument name="dealer_id" value="5279 "/>
										<cfinvokeargument name="vin" value="#arguments.Vin#">
										<cfinvokeargument name="stock" value="#arguments.Stock#">
										<cfinvokeargument name="zip" value="89041">
										<cfinvokeargument name="price" value="#arguments.Selling_Price#">
										<cfinvokeargument name="v_year" value="#arguments.V_Year#">
										<cfinvokeargument name="v_make" value="#arguments.V_Make#">
										<cfinvokeargument name="v_model" value="#arguments.V_Model#">
										<cfinvokeargument name="v_style" value="#arguments.V_Style#">
										<cfinvokeargument name="transmission" value="#arguments.Transmission#">
										<cfinvokeargument name="odometer" value="#arguments.Odometer#">
										<cfinvokeargument name="condition" value="#arguments.New_Used#">
										<cfinvokeargument name="v_photo" value="#variables.din_photo#">
									</cfinvoke>
								</cfcase> 
							</cfswitch>
						</div>
					</div>
				</div>
				
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
				<!--- Kelly Ford Make My Deal --->
			  <cfif #url.dealer_id# EQ 236 AND  (#arguments.New_Used# EQ "N" OR  #arguments.New_Used# EQ "U")>
					<cfset variables.pass_img = #ListFirst(arguments.Img_Urls)# >
					<div class="row">
					<div id="mmd-widget"></div>
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
<!--- Changed to include Faulkner Nissan Jenkintown 06/30/2014 --->					
				<cfif url.dealer_id neq 66 and url.dealer_id neq 69 and url.dealer_id neq 79  and  url.dealer_id neq 236   and  url.dealer_id neq 265  and  url.dealer_id neq 264  >
					<div class="row vdp-options-box  visible-md visible-lg">
						<div class="col-md-12 vdp-text vdp-pad-10">
							<div class="col-md-12">
								<b>PAYMENT CALCULATOR:</b>
							</div>
							<div class="col-md-12 vdp-pad-10">
								<cfinvoke component="/cfcs/vehicles/calculator" method="vdp">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="Calc_Price" value="#arguments.Selling_Price#"/>
								</cfinvoke>
							</div>
						</div>
					</div>
			<cfelse>	
				<div class="row" ><div class="col-md-12">&nbsp;</div></div>
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
			<div class="col-md-3 visible-md visible-lg vdp-text-sm">
				<cfif #url.dealer_id# NEQ 78 and  #url.dealer_id# NEQ 79  and  #url.dealer_id# NEQ 30>
						<cfset url.new_used = #arguments.New_Used#>
					<cfinvoke component="/cfcs/vehicles/vehicle_store" method="vdp_default">
						<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
						<cfinvokeargument name="Dealer_Address_1" value="#arguments.Dealer_Address_1#"/>
						<cfinvokeargument name="Dealer_Address_2" value="#arguments.Dealer_Address_2#"/>
						<cfinvokeargument name="Dealer_City" value="#arguments.Dealer_City#"/>
						<cfinvokeargument name="Dealer_State" value="#arguments.Dealer_State#"/>
						<cfinvokeargument name="Dealer_Zip" value="#arguments.Dealer_Zip#"/>
						<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
						</cfinvoke>
				<cfelse>											<!--- 	The Faulkner Nissan stores want the active website address & phone displayed regardless 
																			of where the vehicle is located. 07/24/2014 --->
					<cfif #url.dealer_id# neq 30>
					<cfswitch expression="#url.dealer_id#">
						<cfcase value="78"> <!---Faulkner Nissan Harrisburg--->
							<cfset arguments.Dealer_Phone="(717) 798-9970">
						</cfcase>
						<cfcase value="79"> <!---Faulkner Nissan Jenkintown--->
							<cfset arguments.Dealer_Phone="(888) 828-9173">
						</cfcase>
					</cfswitch>
						<cfset url.new_used = #arguments.New_Used#>
					<cfinvoke component="/cfcs/vehicles/vehicle_store" method="vdp_default">
						<cfinvokeargument name="Dealer_Display_Name" value="#url.Dealer_Name#"/>
						<cfinvokeargument name="Dealer_Address_1" value="#url.Address_1#"/>
						<cfinvokeargument name="Dealer_Address_2" value="#url.Address_2#"/>
						<cfinvokeargument name="Dealer_City" value="#url.city#"/>
						<cfinvokeargument name="Dealer_State" value="#url.state#"/>
						<cfinvokeargument name="Dealer_Zip" value="#url.Zip#"/>
						<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
					</cfinvoke>
					</cfif>
				</cfif> 
				<cfif #url.dealer_id# NEQ 30 >
					<a href="http://#cgi.server_name#/dealership/hours_and_directions.cfm" class="btn  btn-grey"><img alt="Get Directions"  class="btn-icon" src="http://#cgi.server_name#/images/inventory/icon_SM_directions_off.png"/>Get Directions</a>
				</cfif>
				<div class="vdp-form-box">
					<cfswitch expression="#url.dealer_id#">
						<cfcase value="17,18,32,33,34,35">
							<cfif arguments.V_New_Used eq "n">
								<div class="vdp-form-title">Check For More Savings</div>
							<cfelse>
								<div class="vdp-form-title">REQUEST A QUOTE</div>
							</cfif>
						</cfcase>
						<cfcase value="78">
							<cfif arguments.V_New_Used eq "n">
								<div class="vdp-form-title">Get e-Price</div>
							<cfelse>
								<div class="vdp-form-title">REQUEST A QUOTE</div>
							</cfif>
						</cfcase>
						<cfcase value="80">
							<div class="vdp-form-title" align="center" ><span style="color:black">REQUEST A QUOTE</span></div>
						</cfcase>
						<cfcase value="36,37,28,25">	
							<div class="vdp-form-title">REQUEST INFORMATION</div>
						</cfcase>
						<cfcase value="82">	
							<div class="vdp-form-title">GET FAULKNER PRICE</div>
						</cfcase>
						<cfcase value="38">	
							<div class="vdp-form-title">REQUEST MORE INFO</div>
						</cfcase>
						<cfcase value="179">	
							<div class="vdp-form-title">REQUEST MORE INFO</div>
						</cfcase>
						<cfcase value="45">	
							<div class="vdp-form-title">REQUEST MORE INFO</div>
						</cfcase>
						<cfcase value="30">	
							<div class="vdp-form-title" align="center"><span style="font:bold 20px verdana!important;color:##cc0000!important;">Get an Internet<BR>Price Now!</span></div>
						</cfcase>
						<cfdefaultcase>
							<div class="vdp-form-title">REQUEST A QUOTE</div>
						</cfdefaultcase>
					</cfswitch>
                    
                    <cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_details">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
                        <cfif url.dealer_id eq 78>
	                        <cfinvokeargument name="button_label" value="Get e-Price"/>   
                        </cfif>                     
						<cfinvokeargument name="form_action" value="http://#cgi.server_name#/vehicles/qq_action.cfm"/>
					</cfinvoke>
                    
                    
					
					<cfset url.newused = #arguments.V_New_Used# >
					<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="vdp_standard">
						<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					</cfinvoke>
					<cfif Get_Similar.recordcount gt 0>
						<cfif #url.dealer_id# EQ 80>
							<div class="vdp-form-title" ><span style="color:black">SIMILAR VEHICLES</span></div>
						<cfelse>
							<div class="vdp-form-title">SIMILAR VEHICLES</div>
						</cfif>
						<cfset url.new_used = #arguments.V_New_Used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_similar" method="vdp_similar">
							<cfinvokeargument name="Get_Similar" value="#Get_Similar#"/>
						</cfinvoke>
					</cfif>
				</div>
			</div>
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
		<!--- <cfif #arguments.dealer_id# EQ 1  > --->
			<cfinvoke component="/cfcs/ultra10/popups" method="baierl_certified">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				<cfinvokeargument name="modal_name" value="baierlModal"/>
			</cfinvoke>
		<!--- </cfif> --->
		
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

	<cffunction name="vdp_legacy" description="vehicle details page" output="Yes" access="public">

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
		<cfargument name="Certified" required="true"/>
		<!---<cfargument name="template_id" required="true"/>--->
		<cfargument name="assets" required="true"/>
		<cfargument name="AIS_wID" required="true"/>

		<cfif arguments.V_Model eq "FourRunner">
			<cfset arguments.V_Model="4Runner">
		</cfif>

		<cfset url.year=arguments.V_Year>
		<cfset url.make=arguments.V_Make>
		<cfset url.model=arguments.V_Model>
		<cfset url.new_used=arguments.V_New_Used>

		<!---dealer specific parameters--->
		<cfparam name="url.v_disclaimer" default="">

		<cfparam name="url.form_action" default="">

		<!---Get Vehicle Options--->
		<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Options">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.vin,17)#" maxlength="21">
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

		<table width="100%">
			<tr>
				<td colspan="2">
					<a href="javascript:window.history.back()" class="btn btn-primary"><i class="glyphicon glyphicon-arrow-left"></i> Back to Inventory</a>	
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="nav_type_id" value="52"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="element_class" value="page-banner"/>
						<cfif arguments.V_New_Used eq "n">
							<cfinvokeargument name="page_id" value="/new/index.cfm"/>
						<cfelse>
							<cfinvokeargument name="page_id" value="/used/index.cfm"/>
						</cfif>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<h1 class="vdp-title" title="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#">#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h1>
				</td>
			</tr>
			<tr>
				<td style="730px" valign="top">
					<table style="width:100%">
						<tr>
							<td valign="top">
								<div style="width:430px;overflow:hidden">
									<div class="vdp-condition"><b>Condition:</b> #variables.New_Used# | <b>Stock ##:</b> #arguments.Stock# | <b>Model ##:</b> #arguments.Stock# | <span class="txt-green"><b>IN STOCK</b></span></div>
									<cfswitch expression="#listlen(arguments.Img_Urls)#">
										<cfdefaultcase>
											<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="wow_slider">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
												<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
												<cfinvokeargument name="img_class" value="vdp-leg-img"/>
											</cfinvoke>
										</cfdefaultcase>
										<cfcase value="1">
											<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
												<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
												<cfinvokeargument name="img_class" value="vdp-leg-img"/>
											</cfinvoke>
										</cfcase>
										<cfcase value="0">
											<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="no_photo">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
												<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
												<cfinvokeargument name="img_class" value="vdp-leg-img"/>
											</cfinvoke>
										</cfcase> 
									</cfswitch>
								</div>
								<cfif url.dealer_id eq 18 and arguments.V_New_Used eq "N" and arguments.V_Year eq "2014" and arguments.V_Model eq "Altima">
									<div style="padding-top:10px;" align="center"><img  alt="Altima" class="img-responsive" src="http://#cgi.server_name#/images/oem/2014NissanAltima.png"/></div>
								</cfif>
							</td>
							<td style="width:300px" valign="top">
								<div class="price-block">
						<cfset url.new_used = #arguments.V_New_Used# >
									<cfinvoke component="/cfcs/vehicles/vehicle_pricing" method="vdp_default">
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
									</cfinvoke>
									<cfif len(trim(arguments.AIS_wID)) gt 0>
									
							<cfif #url.dealer_id# NEQ 1 >
								<a href="http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#" target="_blank">
											** See Incentives
										</a><br/>
							</cfif>
							<cfif #url.dealer_id# EQ 1 and #arguments.V_Make# NEQ "Subaru" >
								<a href="http://onecar.aisrebates.com/dlr2/inline/IncentiveOutput.php?vID=#arguments.Vin#&wID=#arguments.AIS_wID#&zID=#arguments.Dealer_Zip#" target="_blank">
											** See Incentives
										</a><br/>
							</cfif>
									
									
										
									</cfif>
								</div>
								<div class="vdp-text">
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
										<cfinvokeargument name="Location" value="#arguments.Dealer_Display_Name#"/>
									</cfinvoke>
									<cfswitch expression="#url.Dealer_ID#">
										<cfcase value="66,69">
											<cfif len(trim(arguments.Img_Urls)) gt 0>
												<cfset variables.this_img=listgetat(arguments.Img_Urls,1)>
												<cfset variables.din_photo=variables.this_img>
											<cfelse>
												<cfset variables.din_photo="http://static.wdautos.com/images/inventory/default/coming_soon_250.jpg">
											</cfif>
											<cfinvoke component="/cfcs/ultra10/plug_driveitnow" method="vdp">
												<cfinvokeargument name="dealer_id" value="5279 "/>
												<cfinvokeargument name="vin" value="#arguments.Vin#">
												<cfinvokeargument name="stock" value="#arguments.Stock#">
												<cfinvokeargument name="zip" value="89041">
												<cfinvokeargument name="price" value="#arguments.Selling_Price#">
												<cfinvokeargument name="v_year" value="#arguments.V_Year#">
												<cfinvokeargument name="v_make" value="#arguments.V_Make#">
												<cfinvokeargument name="v_model" value="#arguments.V_Model#">
												<cfinvokeargument name="v_style" value="#arguments.V_Style#">
												<cfinvokeargument name="transmission" value="#arguments.Transmission#">
												<cfinvokeargument name="odometer" value="#arguments.Odometer#">
												<cfinvokeargument name="condition" value="#arguments.New_Used#">
												<cfinvokeargument name="v_photo" value="#variables.din_photo#">
											</cfinvoke>
										</cfcase> 
									</cfswitch>
									<cfif arguments.Certified eq 1 and arguments.New_Used eq "U">
										<div style="padding-top:10px;">
											<img alt="#arguments.V_Make#"  src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
										</div>
									</cfif>
									<cfif url.Carfax eq 1 and arguments.New_Used eq "U">
										<div style="padding-top:10px;">
											<cfif arguments.Carfax_One_Owner eq 1>
												<!---one owner--->
												<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img alt="Carfax"  border="0" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
											<cfelse>
												<!---carfax--->
												<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img alt="Carfax"  border="0" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
											</cfif>
										</div>
									</cfif>
									<cfswitch expression="#arguments.Dealer_ID#">
										<!--- <cfcase value="68">
											<cfif arguments.New_Used eq "N">
												<div style="padding-top:10px;" align="center"><img alt="0 Percent" src="http://#cgi.server_name#/images/inventory/icon_INV_0PercentAPR.jpg"/></div>
											</cfif>
										</cfcase> --->
									</cfswitch>
								</div>								
							</td>
						</tr>
					</table>
					<div class="row vdp-options-box">
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
							<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_default">
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
						<div class="col-md-12 srp-disclaimer">
							<cfif len(trim(url.v_disclaimer)) gt 0>
								#url.v_disclaimer#
							<cfelse>
								Price plus tax, license, document preparation charge, and finance charges and smog fees (used vehicles only), where applicable. While every effort has been made to ensure display of accurate data and pricing, this listing may not reflect all accurate vehicle data or pricing and is subject to human error. All Inventory listed is subject to prior sale. The photo shown, if any, may be an example only. Please consult dealership personnel for further details.
							</cfif>
						</div>
					</div>
				</td>
				<td style="width:260px" valign="top">
						<cfset url.new_used = #arguments.v_New_Used#>
					<cfinvoke component="/cfcs/vehicles/vehicle_store" method="vdp_default">
						<cfinvokeargument name="Dealer_Display_Name" value="#arguments.Dealer_Display_Name#"/>
						<cfinvokeargument name="Dealer_Address_1" value="#arguments.Dealer_Address_1#"/>
						<cfinvokeargument name="Dealer_Address_2" value="#arguments.Dealer_Address_2#"/>
						<cfinvokeargument name="Dealer_City" value="#arguments.Dealer_City#"/>
						<cfinvokeargument name="Dealer_State" value="#arguments.Dealer_State#"/>
						<cfinvokeargument name="Dealer_Zip" value="#arguments.Dealer_Zip#"/>
						<cfinvokeargument name="Dealer_Phone" value="#arguments.Dealer_Phone#"/>
					</cfinvoke>
					<a style="display:block" class="btn btn-grey" href="http://#cgi.server_name#/dealership/hours_and_directions.cfm">
						<img alt="Hours & Directions" style="display:block;float:left" class="btn-icon" src="http://#cgi.server_name#/images/inventory/icon_SM_directions_off.png" border="0"/>
						<span style="display:block;float:left;padding:9px 0px 0px 0px;">Get Directions</span>
						<div style="clear:both"></div>
					</a>
					<div class="vdp-form-box">
						<div class="vdp-form-title">REQUEST A QUOTE</div>
						<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_details">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="VOI_New_Used" value="#arguments.V_New_Used#"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/vehicles/qq_action.cfm"/>
						</cfinvoke>
						<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="vdp_legacy">
							<cfinvokeargument name="VOI_Vin" value="#arguments.Vin#"/>
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						</cfinvoke>
						<cfif Get_Similar.recordcount gt 0>
						
						<cfif #url.dealer_id# EQ 80>
							<div class="vdp-form-title" ><span style="color:black">SIMILAR VEHICLES</span></div>
						<cfelse>
							<div class="vdp-form-title">SIMILAR VEHICLES</div>
						</cfif>
							<cfinvoke component="/cfcs/vehicles/vehicle_similar" method="vdp_similar_legacy">
								<cfinvokeargument name="Get_Similar" value="#Get_Similar#"/>
							</cfinvoke>
						</cfif>
					</div>					
				</td>
			</tr>
		</table>

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