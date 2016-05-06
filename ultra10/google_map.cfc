<cfcomponent>

	<cffunction name="v3" description="shows standard google map" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="show_pop" default="true">
		<cfargument name="map_class" default="map-large">
		
		<cfquery datasource="ultra10" name="Get_Map">
			SELECT		Longitude,
						Latitude
			FROM		Dealers
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
		</cfquery>
	<cfif #arguments.dealer_id# NEQ 70 >
		<cfif len(trim(Get_Map.Longitude)) gt 0 and len(trim(Get_Map.Latitude)) gt 0>

			<cfset variables.disp_name="#url.dealer_name#" >
			<cfset variables.address="#arguments.address_1# #arguments.city#, #arguments.state# #arguments.zip#">
			<cfset variables.dir_address="#variables.address#">
			<cfset variables.dir_address=replace(dir_address," ","+","All")>
			<cfset variables.directions_to="http://maps.google.com/maps?f=d&source=s_d&saddr=&daddr=#dir_address#&hl=en&geocode=&mra=ls&sll=#Get_Map.Latitude#,#Get_Map.Longitude#&sspn=0.040373,0.090981&ie=UTF8&z=16">
			<cfset variables.directions_from="http://maps.google.com/maps?f=d&source=s_d&daddr=&saddr=#dir_address#&hl=en&geocode=&mra=ls&sll=#Get_Map.Latitude#,#Get_Map.Longitude#&sspn=0.040373,0.090981&ie=UTF8&z=16">

			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX7XWXSDZ3B3WD2AmmjADV9Ehn1CW7hyI&sensor=false"></script>
			<script type="text/javascript">
				function initialize() {        
				var store = new google.maps.LatLng(#Get_Map.Latitude#,#Get_Map.Longitude#);
				var marker;
				var map;
				var mapOptions = {
					center: new google.maps.LatLng(#Get_Map.Latitude#,#Get_Map.Longitude#),
					zoom: 15,mapTypeId: google.maps.MapTypeId.ROADMAP};
					var map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);
					marker = new google.maps.Marker({
						map:map,
						draggable:false,
						animation:google.maps.Animation.DROP,
						position: store  
					});
					<cfif arguments.show_pop eq "true">
						var contentString = '<span style="color:black;font-size:12pt;font-weight:bold">#variables.disp_name#</span><br /><span style="color:black;">#variables.address#</span><br />Directions : <a href="#variables.directions_to#" target="_blank">To Here</a> - <a href="#variables.directions_from#" target="_blank">From Here</a><br />';
						var infowindow = new google.maps.InfoWindow({    content: contentString});
						infowindow.open(map,marker);
						google.maps.event.addListener(marker, 'click', function() {    infowindow.open(map,marker);  });
					</cfif>
				}      
				google.maps.event.addDomListener(window, 'load', initialize);
			</script>
			<div class="#arguments.map_class#" id="map-canvas"></div>
		<cfelse>
			Please enter latitude and longitude
		</cfif>
	<cfelse>		
		<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3225.8785462886276!2d-115.02095899999999!3d36.047669899999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80c8d11817b9300b%3A0x8b0b805501ccff4e!2sFindlay+Toyota!5e0!3m2!1sen!2sus!4v1440524791809" width="750" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>
	</cfif>
	</cffunction>


	<cffunction name="v2" description="shows google map WITHOUT the popup" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="show_pop" default="false">
		<cfargument name="map_class" default="map-large">
		
		<cfquery datasource="ultra10" name="Get_Map">
			SELECT		Longitude,
						Latitude
			FROM		Dealers
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
		</cfquery>
	<cfif #arguments.dealer_id# NEQ 70 >
		<cfif len(trim(Get_Map.Longitude)) gt 0 and len(trim(Get_Map.Latitude)) gt 0>

			<cfset variables.address="#arguments.address_1# #arguments.city#, #arguments.state# #arguments.zip#">
			<cfset variables.dir_address="#variables.address#">
			<cfset variables.dir_address=replace(dir_address," ","+","All")>
			<cfset variables.directions_to="http://maps.google.com/maps?f=d&source=s_d&saddr=&daddr=#dir_address#&hl=en&geocode=&mra=ls&sll=#Get_Map.Latitude#,#Get_Map.Longitude#&sspn=0.040373,0.090981&ie=UTF8&z=16">
			<cfset variables.directions_from="http://maps.google.com/maps?f=d&source=s_d&daddr=&saddr=#dir_address#&hl=en&geocode=&mra=ls&sll=#Get_Map.Latitude#,#Get_Map.Longitude#&sspn=0.040373,0.090981&ie=UTF8&z=16">

			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX7XWXSDZ3B3WD2AmmjADV9Ehn1CW7hyI&sensor=false"></script>
			<script type="text/javascript">
				function initialize() {        
				var store = new google.maps.LatLng(#Get_Map.Latitude#,#Get_Map.Longitude#);
				var marker;
				var map;
				var mapOptions = {
					center: new google.maps.LatLng(#Get_Map.Latitude#,#Get_Map.Longitude#),
					zoom: 15,mapTypeId: google.maps.MapTypeId.ROADMAP};
					var map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);
					marker = new google.maps.Marker({
						map:map,
						draggable:false,
						animation:google.maps.Animation.DROP,
						position: store  
					});
					<cfif arguments.show_pop eq "true">
						var contentString = '<br /><span style="color:black;">#variables.address#</span><br />Directions : <a href="#variables.directions_to#" target="_blank">To Here</a> - <a href="#variables.directions_from#" target="_blank">From Here</a><br />';
						var infowindow = new google.maps.InfoWindow({    content: contentString});
						infowindow.open(map,marker);
						google.maps.event.addListener(marker, 'click', function() {    infowindow.open(map,marker);  });
					</cfif>
				}      
				google.maps.event.addDomListener(window, 'load', initialize);
			</script>
			<div class="#arguments.map_class#" id="map-canvas"></div>
		<cfelse>
			Please enter latitude and longitude
		</cfif>
	<cfelse>		
		<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3225.8785462886276!2d-115.02095899999999!3d36.047669899999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80c8d11817b9300b%3A0x8b0b805501ccff4e!2sFindlay+Toyota!5e0!3m2!1sen!2sus!4v1440524791809" width="750" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>
	</cfif>
	</cffunction>

</cfcomponent>