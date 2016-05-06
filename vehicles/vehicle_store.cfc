<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp store info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_Display_Name" default="">
		<cfargument name="Dealer_Address_1" default="">
		<cfargument name="Dealer_Address_2" default="">
		<cfargument name="Dealer_City" default="">
		<cfargument name="Dealer_State" default="">
		<cfargument name="Dealer_Zip" default="">
		<cfargument name="Dealer_Phone" default="">
		
		
		<!--- Check VDP Style 12/21/2015--->
				<cfset vdp_style = 0 >
				<cfquery datasource="ultra10" name="chk_vdp_style">SELECT vdp_type FROM Dealers WHERE dealer_id = #url.dealer_id# AND	( vdp_type = 1 OR vdp_type = 2 )</cfquery>
				<cfif #chk_vdp_style.recordcount# NEQ 0 ><cfset vdp_style = #chk_vdp_style.vdp_type# ></cfif>	
		<!--- Check VDP Style 12/21/2015--->	 

		
		
		<cfswitch expression="#url.dealer_id#">
	    <cfcase value="78,79">    <!---Faulkner Nissan--->
		    <cfset arguments.Dealer_Display_Name=url.dealer_name>
		    <cfset arguments.Dealer_Address_1=url.ADDRESS_1>
		    <cfset arguments.Dealer_Address_2=url.ADDRESS_2>
		    <cfset arguments.Dealer_City=url.CITY>
		    <cfset arguments.Dealer_State=url.STATE>
		    <cfset arguments.Dealer_Zip=url.ZIP>
	    </cfcase>
	  </cfswitch>
		<div class="vdp-store-text">
			Vehicle Located At<br/>
			<cfif len(trim(arguments.Dealer_Display_Name)) gt 0><div class="vdp-store-name">
				<b>
					<cfswitch expression="#url.dealer_id#">
						<cfdefaultcase>
							<cfif #url.dealer_id# eq 65 or #url.dealer_id# EQ 68 and #url.new_used# EQ "U">
								HENDERSON KIA MAZDA
							<cfelse>							
								<cfif #vdp_style# EQ 0 >
									#ucase(arguments.Dealer_Display_Name)#
								<cfelse>
<!--- NEW Layout 12/21/2015 --->	<a href="http://#cgi.server_name#/dealership/hours_and_directions.cfm" ><span class="glyphicon glyphicon-map-marker"></span>#ucase(arguments.Dealer_Display_Name)#</a>                    
								</cfif>
							</cfif>  
						</cfdefaultcase>
						<cfcase value="25,28,51,7,57,27,160,200">    <!--- Honda Dealers --->
							#arguments.Dealer_Display_Name#
						</cfcase>
					</cfswitch>	
				</b></div>
			</cfif>
			<cfif len(trim(arguments.Dealer_Address_1)) gt 0>#arguments.Dealer_Address_1#<br/></cfif>
			<cfif len(trim(arguments.Dealer_Address_2)) gt 0>#arguments.Dealer_Address_2#<br/></cfif>
			<cfif len(trim(arguments.Dealer_City)) gt 0>#arguments.Dealer_City#, #arguments.Dealer_State# #arguments.Dealer_Zip#<br/></cfif>
			<cfif len(trim(arguments.Dealer_Phone)) gt 0>
				<cfif #url.dealer_id# NEQ 326 >
					<cfif #vdp_style# EQ 0 >
						<div class="vdp-store-phone txt-red"><b>#arguments.Dealer_Phone#</b></div>
					<cfelse>
						<cfset variables.dial=#arguments.Dealer_Phone#>
						<cfset variables.dial=replace(variables.dial,"(","","All")>
						<cfset variables.dial=replace(variables.dial,")","","All")>
						<cfset variables.dial=replace(variables.dial,"-","","All")>
						<cfset variables.dial=replace(variables.dial," ","","All")>
						<div class="visible-sm visible-xs">
							<a class="vdp-store-name txt-red" title="Click to Call: #arguments.Dealer_Phone#" href="tel:#variables.dial#" ><img alt="#arguments.Dealer_Phone#" width="21" height="19"  src="http://#cgi.server_name#/images/inventory/icon_SM_clicktocall.png"/><span style="color:##cc0033!important"><b>#arguments.Dealer_Phone#</span></a>
						</div>
						<div class="visible-md visible-lg vdp-store-phone txt-red">
							<b>#arguments.Dealer_Phone#</b>
						</div>
					</cfif>
				<cfelse>	
					<cfif #arguments.Dealer_Display_Name# EQ "Henderson Kia" >
						<div class="vdp-store-phone txt-red"><b>(702) 757-4677</b></div>
					<cfelseif #arguments.Dealer_Display_Name# EQ "Henderson Mazda">
						<div class="vdp-store-phone txt-red"><b>(702) 551-7124</b></div>
					</cfif>
				</cfif> 
			
			</cfif>
	
		</div>

	</cffunction>
	
	<cffunction name="srp_default" description="shows default srp store info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_Display_Name" default="">
		<cfargument name="Dealer_Address_1" default="">
		<cfargument name="Dealer_Address_2" default="">
		<cfargument name="Dealer_City" default="">
		<cfargument name="Dealer_State" default="">
		<cfargument name="Dealer_Zip" default="">
		<cfargument name="Dealer_Phone" default="">
		
		
		<!--- Check VDP Style 12/21/2015--->
				<cfset vdp_style = 0 >
				<cfquery datasource="ultra10" name="chk_vdp_style">SELECT vdp_type FROM Dealers WHERE dealer_id = #url.dealer_id# AND	( vdp_type = 1 OR vdp_type = 2 )</cfquery>
				<cfif #chk_vdp_style.recordcount# NEQ 0 ><cfset vdp_style = #chk_vdp_style.vdp_type# ></cfif>	
		<!--- Check VDP Style 12/21/2015--->	 

		
		<div class="vdp-store-text">
			Vehicle Located At<br/>
			<cfif len(trim(arguments.Dealer_Display_Name)) gt 0>
				<div class="vdp-store-name">
					<cfswitch expression="#url.dealer_id#">
						<cfdefaultcase>
							<a href="http://#cgi.server_name#/dealership/hours_and_directions.cfm" >
							<span class="glyphicon glyphicon-map-marker"></span><b>#ucase(arguments.Dealer_Display_Name)#</b></a>	
						</cfdefaultcase>
					</cfswitch>	
				</div>
			</cfif>
			
			<cfif len(trim(arguments.Dealer_Address_1)) gt 0>#arguments.Dealer_Address_1#<br/></cfif>
			<cfif len(trim(arguments.Dealer_Address_2)) gt 0>#arguments.Dealer_Address_2#<br/></cfif>
			<cfif len(trim(arguments.Dealer_City)) gt 0>#arguments.Dealer_City#, #arguments.Dealer_State# #arguments.Dealer_Zip#<br/></cfif>
			<cfif len(trim(arguments.Dealer_Phone)) gt 0>
			<div class="srp-store-phone txt-red">
					<cfif #vdp_style# EQ 0 >
						<div class="srp-store-phone txt-red"><b>#arguments.Dealer_Phone#</b></div>
					<cfelse>
						<cfset variables.dial=#arguments.Dealer_Phone#>
						<cfset variables.dial=replace(variables.dial,"(","","All")>
						<cfset variables.dial=replace(variables.dial,")","","All")>
						<cfset variables.dial=replace(variables.dial,"-","","All")>
						<cfset variables.dial=replace(variables.dial," ","","All")>
						<div class="visible-sm visible-xs">
							<a class="srp-store-phone txt-red" title="Click to Call: #arguments.Dealer_Phone#" href="tel:#variables.dial#" >
							<img alt="#arguments.Dealer_Phone#" width="21" height="19"  src="http://#cgi.server_name#/images/inventory/icon_SM_clicktocall.png"/> <b><span style="color:##cc0033!important">#arguments.Dealer_Phone#</span></b></a>
						</div>
						<div class="vdp-store-phone txt-red visible-md visible-lg">
							<b>#arguments.Dealer_Phone#</b>
						</div>
					</cfif>
			
			</div>
			</cfif>
		</div>


		
		
	</cffunction>

	
	
	<cffunction name="horizontal" description="shows default vdp store info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_Display_Name" default="">
		<cfargument name="Dealer_Address_1" default="">
		<cfargument name="Dealer_Address_2" default="">
		<cfargument name="Dealer_City" default="">
		<cfargument name="Dealer_State" default="">
		<cfargument name="Dealer_Zip" default="">
		<cfargument name="Dealer_Phone" default="">

		<div class="vdp-store-text">
			<cfif len(trim(arguments.Dealer_Display_Name)) gt 0>Vehicle Located At : <span class="vdp-store-name"><b>
					<cfswitch expression="#url.dealer_id#">
						<cfdefaultcase>
							#ucase(arguments.Dealer_Display_Name)#
						</cfdefaultcase>
						<cfcase value="25,28,51,7,57,27,160,200">    <!--- Honda Dealers --->
							#arguments.Dealer_Display_Name#
						</cfcase>
					</cfswitch>	
					</b></span></cfif>
			<cfif len(trim(arguments.Dealer_Address_1)) gt 0>#arguments.Dealer_Address_1# |</cfif>
			<cfif len(trim(arguments.Dealer_Address_2)) gt 0>#arguments.Dealer_Address_2#</cfif>
			<cfif len(trim(arguments.Dealer_City)) gt 0>#arguments.Dealer_City#, #arguments.Dealer_State# #arguments.Dealer_Zip# | </cfif>
			<cfif len(trim(arguments.Dealer_Phone)) gt 0><span class="vdp-store-phone txt-red"><b>#arguments.Dealer_Phone#</b></span></cfif>
		</div>

	</cffunction>

</cfcomponent>