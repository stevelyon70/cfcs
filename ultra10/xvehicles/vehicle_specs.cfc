<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp pricing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="New_Used" default="">
		<cfargument name="Stock" default="">
		<cfargument name="Model_Number" default="">
		<cfargument name="Vin" default="">
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

		<cfif len(trim(variables.New_Used)) gt 0><b>Condition:</b> #variables.New_Used#<br/></cfif>
		<cfif len(trim(arguments.Stock)) gt 0><b>Stock ##:</b> #arguments.Stock#<br/></cfif>
		<cfif len(trim(arguments.Model_Number)) gt 0><b>Model ##:</b> #arguments.Model_Number#<br/></cfif>
		<cfif len(trim(arguments.Vin)) gt 0><b>Vin:</b> #arguments.Vin#<br/></cfif>
		<cfif len(trim(arguments.V_Body)) gt 0><b>Style:</b> #arguments.V_Body#<br/></cfif>
		<cfif len(trim(arguments.V_Type)) gt 0><b>Vehicle Type:</b> #arguments.V_Type#<br/></cfif>
		<cfif len(trim(arguments.Engine_Size)) gt 0 and len(trim(arguments.Cylinders)) gt 0>
			<b>Engine:</b> #arguments.Engine_Size# #arguments.Cylinders# Cylinders<br/>
		<cfelse>
			<cfif len(trim(arguments.Engine_Size)) gt 0><b>Engine Size:</b> #arguments.Engine_Size#<br/></cfif>
			<cfif len(trim(arguments.Cylinders)) gt 0><b>Cylinders:</b> #arguments.Cylinders#<br/></cfif>
		</cfif>
		<cfif len(trim(arguments.Transmission)) gt 0><b>Transmission:</b> #arguments.Transmission#<br/></cfif>
		<cfif len(trim(arguments.Drivetrain)) gt 0><b>Drivetrain:</b> #arguments.Drivetrain#<br/></cfif>
		<cfif arguments.New_Used neq "n">
			<cfif len(trim(arguments.Odometer)) gt 0><b>Mileage:</b> #arguments.Odometer#<br/></cfif>
		</cfif>
		<cfif len(trim(arguments.Fuel_Type)) gt 0><b>Fuel Type:</b> #arguments.Fuel_Type#<br/></cfif>
		<cfif len(trim(arguments.EPA_City)) gt 0 and len(trim(arguments.EPA_HWY)) gt 0>
			<b>MPG Range:</b> #arguments.EPA_City#/#arguments.EPA_HWY#<br/>
		<cfelse>
			<cfif len(trim(arguments.EPA_City)) gt 0><b>EPA City:</b> #arguments.EPA_City#<br/></cfif>
			<cfif len(trim(arguments.EPA_HWY)) gt 0><b>EPA HWY:</b> #arguments.EPA_HWY#<br/></cfif>
		</cfif>
		<cfif len(trim(arguments.Exterior_Color)) gt 0><b>Exterior Color:</b> #arguments.Exterior_Color#<br/></cfif>
		<cfif len(trim(arguments.Interior_Color)) gt 0><b>Interior Color:</b> #arguments.Interior_Color#<br/></cfif>
		<cfif len(trim(arguments.Doors)) gt 0><b>Doors:</b> #arguments.Doors#<br/></cfif>
		<cfif len(trim(arguments.Passengers)) gt 0><b>Passengers:</b> #arguments.Passengers#<br/></cfif>
		<cfif len(trim(arguments.Location)) gt 0><b>Location:</b> #arguments.Location#<br/></cfif>
		<cfif len(trim(arguments.Dealer_Phone)) gt 0><div class="v-phone">Phone: #arguments.Dealer_Phone#</div></cfif>

	</cffunction>

</cfcomponent>