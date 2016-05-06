<cfcomponent>
	
	<cffunction name="vdp" description="DriveItNow Plugin for VDP" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="yes">
		<cfargument name="vin" required="yes">
		<cfargument name="stock" required="yes">
		<cfargument name="zip" required="yes">
		<cfargument name="price" required="yes">
		<cfargument name="v_year" required="yes">
		<cfargument name="v_make" required="yes">
		<cfargument name="v_model" required="yes">
		<cfargument name="v_style" required="yes">
		<cfargument name="transmission" required="yes">
		<cfargument name="odometer" required="yes">
		<cfargument name="condition" required="yes">
		<cfargument name="v_photo" required="yes">
		<script type="text/javascript" src="http://www.driveitnow.net/javascript/din_lightwindow.inc.js"></script>
		<script language="JavaScript" id="din_#arguments.vin#">
			var DealerID = '#arguments.dealer_id#';
			var vehicleVIN = '#arguments.vin#';
			var vehicleStockNum = '#arguments.stock#';
			var vehicleZipCode = '#arguments.zip#';
			var vehiclePrice = '#arguments.price#';
			var vehicleYear = '#arguments.v_year#';
			var vehicleMake = '#arguments.v_make#';
			var vehicleModel = '#arguments.v_model#';
			var vehicleStyle = '#arguments.v_style#';
			var vehicleTransmission = '#arguments.transmission#';
			var vehicleOdometer = '#arguments.odometer#';
			var vehicleCondition = '#arguments.condition#';
			var vehiclePhoto = '#arguments.v_photo#';
			var mode = (document.documentElement.clientWidth < 500) ? 'mobile' : 'vdp';
			drive_it_now_button();
		</script>
	</cffunction>

	<cffunction name="srp" description="DriveItNow Plugin for srp" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="yes">
		<cfargument name="vin" required="yes">
		<cfargument name="stock" required="yes">
		<cfargument name="zip" required="yes">
		<cfargument name="price" required="yes">
		<cfargument name="v_year" required="yes">
		<cfargument name="v_make" required="yes">
		<cfargument name="v_model" required="yes">
		<cfargument name="v_style" required="yes">
		<cfargument name="transmission" required="yes">
		<cfargument name="odometer" required="yes">
		<cfargument name="condition" required="yes">
		<cfargument name="v_photo" required="yes">
		<script type="text/javascript" src="http://www.driveitnow.net/javascript/din_lightwindow.inc.js"></script>
		<script language="JavaScript" id="din_#arguments.vin#">
			var DealerID = '#arguments.dealer_id#';
			var vehicleVIN = '#arguments.vin#';
			var vehicleStockNum = '#arguments.stock#';
			var vehicleZipCode = '#arguments.zip#';
			var vehiclePrice = '#arguments.price#';
			var vehicleYear = '#arguments.v_year#';
			var vehicleMake = '#arguments.v_make#';
			var vehicleModel = '#arguments.v_model#';
			var vehicleStyle = '#arguments.v_style#';
			var vehicleTransmission = '#arguments.transmission#';
			var vehicleOdometer = '#arguments.odometer#';
			var vehicleCondition = '#arguments.condition#';
			var vehiclePhoto = '#arguments.v_photo#';
			var mode = (document.documentElement.clientWidth < 500) ? 'mobile' : 'srp';
			drive_it_now_button();
		</script>
	</cffunction>

	<cffunction name="mobile" description="DriveItNow Plugin for Mobile" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="yes">
		<cfargument name="vin" required="yes">
		<cfargument name="stock" required="yes">
		<cfargument name="zip" required="yes">
		<cfargument name="price" required="yes">
		<cfargument name="v_year" required="yes">
		<cfargument name="v_make" required="yes">
		<cfargument name="v_model" required="yes">
		<cfargument name="v_style" required="yes">
		<cfargument name="transmission" required="yes">
		<cfargument name="odometer" required="yes">
		<cfargument name="condition" required="yes">
		<cfargument name="v_photo" required="yes">
		<script type="text/javascript" src="http://www.driveitnow.net/javascript/din_lightwindow.inc.js"></script>
		<script language="JavaScript" id="din_#arguments.vin#">
			var DealerID = '#arguments.dealer_id#';
			var vehicleVIN = '#arguments.vin#';
			var vehicleStockNum = '#arguments.stock#';
			var vehicleZipCode = '#arguments.zip#';
			var vehiclePrice = '#arguments.price#';
			var vehicleYear = '#arguments.v_year#';
			var vehicleMake = '#arguments.v_make#';
			var vehicleModel = '#arguments.v_model#';
			var vehicleStyle = '#arguments.v_style#';
			var vehicleTransmission = '#arguments.transmission#';
			var vehicleOdometer = '#arguments.odometer#';
			var vehicleCondition = '#arguments.condition#';
			var vehiclePhoto = '#arguments.v_photo#';
			var mode = 'mobile';
			drive_it_now_button();
		</script>
	</cffunction>
	
</cfcomponent>