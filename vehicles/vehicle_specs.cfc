<cfcomponent>
<cffunction name="vdp_default" description="shows default vdp pricing" output="Yes" access="public">
  
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
  <cfargument name="Doors" default="">
  <cfargument name="Passengers" default="">
  <cfargument name="Location" default="">
  <cfargument name="Dealer_Phone" default="">
  <cfargument name="Autocheck" default="0" />
  <cfargument name="Vehicle_ID" default="" />
  <cfargument name="Certified" default="0" />
  
  <cfswitch expression="#url.dealer_id#">
    <cfcase value="78">
    <!---Faulkner Nissan Harrisburg--->
    <cfset arguments.Location=url.dealer_name>
    <cfset arguments.Dealer_Phone="(717) 798-9970">
    </cfcase>
    <cfcase value="79">
    <!---Faulkner Nissan Jenkintown--->
    <cfset arguments.Location=url.dealer_name>
    <cfset arguments.Dealer_Phone="(888) 828-9173">
    </cfcase>
    <cfcase value="24">
    <!---Faulkner Mazda Harrisburg--->
    <cfset arguments.Location=url.dealer_name>
    <cfset arguments.Dealer_Phone="(888) 346-0464">
    </cfcase>
    <cfcase value="82">
    <!---Faulkner Mazda Trevose--->
    <cfset arguments.Location=url.dealer_name>
    <cfset arguments.Dealer_Phone="(888) 478-9566">
    </cfcase>
  </cfswitch>
  
		<!--- Check on lot status 12/22/2015 --->
		<cfquery name="on_lot" datasource="Ultra10" >SELECT on_lot_status FROM Vehicles	where Vin = '#arguments.vin#' </cfquery>  
		<cfset status_msg = "IN STOCK" ><cfif #LCase(on_lot.on_lot_status)# EQ "in-transit" ><cfset status_msg = "IN TRANSIT" ></cfif> 
		<!--- Check on lot status 12/22/2015 ---> 
		
  <!---Set Condition in Regular Speak--->
  <cfswitch expression="#arguments.New_Used#">
    <cfdefaultcase>
		<cfif #url.dealer_id# NEQ 172 >
		    <cfset variables.New_Used="Used">
		<cfelse>	
			<cfif #arguments.certified# EQ 0 >
			    <cfset variables.New_Used="Used">
			<cfelse>
			    <cfset variables.New_Used="Certified">
			</cfif>		
		</cfif>
    </cfdefaultcase>
    <cfcase value="N">
    <cfset variables.New_Used="New">
    </cfcase>
    <cfcase value="U">
		<cfif #url.dealer_id# NEQ 172 >
		    <cfset variables.New_Used="Used">
		<cfelse>	
			<cfif #arguments.certified# EQ 0 >
			    <cfset variables.New_Used="Used">
			<cfelse>
			    <cfset variables.New_Used="Certified">
			</cfif>		
		</cfif>
    </cfcase>
  </cfswitch>
  
  <span  itemprop="itemOffered" itemscope itemtype="http://schema.org/Car">
  <cfif len(trim(arguments.v_link)) gt 0>
    <a class="srp-specs" href="http://#cgi.server_name#/vehicles/#arguments.v_link#">
  </cfif>
  <cfif len(trim(variables.New_Used)) gt 0>  
    <b>Condition:</b> <span itemprop="itemCondition">#variables.New_Used#</span> | <span class="txt-green"><b>#status_msg#</b></span> <br/>  
  </cfif>
  <cfif len(trim(arguments.Stock)) gt 0>
    <b>Stock ##:</b> #arguments.Stock#<br/>
  </cfif>
  <cfif len(trim(arguments.Model_Number)) gt 0>
    <b>Model ##:</b> <span itemprop="model">#arguments.Model_Number#</span><br/>
  </cfif>
  <cfif len(trim(arguments.Vin)) gt 0>
    <b>Vin:</b> <span itemprop="vehicleIdentificationNumber">#arguments.Vin#</span><br/>
  </cfif>
  <cfif len(trim(arguments.V_Body)) gt 0>
    <b>Style:</b> #arguments.V_Body#<br/>
  </cfif>
  <cfif len(trim(arguments.V_Type)) gt 0>
    <b>Vehicle Type:</b> #arguments.V_Type#<br/>
  </cfif>
  <span itemprop="vehicleEngine" itemscope itemtype="http://schema.org/EngineSpecification">
  <cfif #url.dealer_id# NEQ 62 >
    <cfif len(trim(arguments.Engine_Size)) gt 0 and len(trim(arguments.Cylinders)) gt 0>
      <b>Engine:</b> <span itemprop="name">#arguments.Engine_Size# #arguments.Cylinders# Cylinders</span><br/>
      <cfelse>
      <cfif len(trim(arguments.Engine_Size)) gt 0>
        <b>Engine Size:</b> <span itemprop="name">#arguments.Engine_Size#</span><br/>
      </cfif>
      <cfif len(trim(arguments.Cylinders)) gt 0>
        <b>Cylinders:</b> <span itemprop="name">#arguments.Cylinders#</span><br/>
      </cfif>
    </cfif>
    <cfelse>
    <cfif len(trim(arguments.Engine_Size)) gt 0>
      <b>Engine:</b> <span itemprop="name">#arguments.Engine_Size#</span><br/>
    </cfif>
  </cfif>
  </span>
  <cfif len(trim(arguments.Transmission)) gt 0>
    <b>Transmission:</b> <span itemprop="vehicleTransmission">#arguments.Transmission#</span><br/>
  </cfif>
  <cfif len(trim(arguments.Drivetrain)) gt 0>
    <b>Drivetrain:</b> #arguments.Drivetrain#<br/>
  </cfif>
  <cfif arguments.New_Used neq "n">
    <cfif len(trim(arguments.Odometer)) gt 0>
      <b>Mileage:</b> <span itemprop="mileageFromOdometer">#arguments.Odometer#</span><br/>
    </cfif>
  </cfif>
  <cfif len(trim(arguments.Fuel_Type)) gt 0>
    <b>Fuel Type:</b> <span itemprop="fuelType">#arguments.Fuel_Type#</span><br/>
  </cfif>
  <cfswitch expression="#url.dealer_id#">
    <cfdefaultcase>
    <cfif len(trim(arguments.EPA_City)) gt 0 and len(trim(arguments.EPA_HWY)) gt 0>
      <b>MPG Range:</b> <span itemprop="fuelEfficiency">#arguments.EPA_City#/#arguments.EPA_HWY#</span><br/>
      <cfelse>
      <cfif len(trim(arguments.EPA_City)) gt 0>
        <b>EPA City:</b> <span itemprop="fuelEfficiency">#arguments.EPA_City#</span><br/>
      </cfif>
      <cfif len(trim(arguments.EPA_HWY)) gt 0>
        <b>EPA HWY:</b> <span itemprop="fuelEfficiency">#arguments.EPA_HWY#</span><br/>
      </cfif>
    </cfif>
    </cfdefaultcase>
    <cfcase value="25,28,51,7,57,27,160,200,80">
    <!--- Honda Dealers and Pinegar Chevrolet (80)--->
    </cfcase>
  </cfswitch>
  <cfif len(trim(arguments.Exterior_Color)) gt 0>
    <b>Exterior Color:</b> <span itemprop="color">#arguments.Exterior_Color#</span><br/>
  </cfif>
  <cfif len(trim(arguments.Interior_Color)) gt 0>
    <b>Interior Color:</b> <span itemprop="vehicleInteriorColor">#arguments.Interior_Color#</span><br/>
  </cfif>
  <cfif len(trim(arguments.Doors)) gt 0>
    <b>Doors:</b> <span itemprop="numberOfDoors">#arguments.Doors#</span><br/>
  </cfif>
  <cfif len(trim(arguments.Passengers)) gt 0>
    <b>Passengers:</b> <span itemprop="vehicleSeatingCapacity">#arguments.Passengers#</span><br/>
  </cfif>
  <cfif #url.dealer_id# NEQ 65 and #url.dealer_id# NEq 68 >
    <cfif len(trim(arguments.Location)) gt 0>
      <b>Location:</b> #arguments.Location#<br/>
    </cfif>
  </cfif>
  <cfif len(trim(arguments.v_link)) gt 0>
    </a>
  </cfif>
  <cfif url.dealer_id neq 78 and url.dealer_id neq 79>
  	<cfif len(trim(arguments.Dealer_Phone)) gt 0>
	
	
		<cfif #url.dealer_id# NEQ 326 >
		    <div class="v-phone">Phone: #arguments.Dealer_Phone#</div>
		<cfelse>
			<cfif #arguments.Location# EQ "Henderson Kia" >
		    	<div class="v-phone">Phone: (702) 757-4677</div>
			<cfelseif #arguments.Location# EQ "Henderson Mazda" >
		    	<div class="v-phone">Phone: (702) 551-7124</div>
			<cfelse>
			    <div class="v-phone">Phone: #arguments.Dealer_Phone#</div>	
			</cfif>
		</cfif>
	
		<!--- <cfif #url.dealer_id# NEQ 326 >
		    <div class="v-phone">Phone: #arguments.Dealer_Phone#</div>
		</cfif> --->
			
	</cfif>
  </cfif>
  </span>
  <!--- Pittsburgh East Nissan kbb --->
  <cfif #url.dealer_id# eq 54 and #variables.New_Used# EQ "Used" >
    <br />
    <a title="Click here to view the Kelley Blue Book Price Advisor Report for this vehicle" target="_blank" href="http://www.kbbreport.com/#arguments.Vin#"> <img width="110" height="33" alt="Kelley Blue Book Price Advisor Report Logo" src="//www.kbbreport.com/images/banners/kbb_report_110x33.png" style="border: 0px;" /></a>
  </cfif>
  
  <!--- reserveit button for Stuckey Ford Subaru --->
  
  <cfif url.dealer_id eq 31 >
    <br/>
    <a href="http://stuckeyforyou.com/forms/reserve_it.cfm?vin=#arguments.vin#" ><img alt="Reserve It"  class="img-responsive" border="0" src="http://stuckeyforyou.com/dealer/stuckeyforyou/images/library/icon_reserveit.png"/></a>
  </cfif>
  
  <!--- Instant Trade Appraisal button for Lamacchia Honda --->
  <cfif url.dealer_id eq 51 and 0 eq 1>
    <br/>
    <a href="http://lamacchiahonda.com/forms/trade.cfm" ><img alt="Edmunds"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/lamacchiahonda/images/icons/img_edmundstrade_button.png"/></a>
  </cfif>
  <!--- Courtesy Mazda ---> 
  <!--- 	<cfif url.dealer_id eq 68 and #arguments.New_Used# EQ "N" >
			<br/><img alt="0 Percent APR"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/courtesymazda/images/icons/icon_INV_0PercentAPR.jpg"/></a>
		</cfif>     ---> 
  <!--- Kelly Ford Melbourne ---> 
  <!--- <cfif url.dealer_id eq 236 and #arguments.New_Used# EQ "N" >
			<br/><a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
		</cfif>  --->
  
</cffunction>
</cfcomponent>
