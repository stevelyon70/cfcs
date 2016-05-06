<cfcomponent>

	<cffunction name="srp_default" description="shows default srp queies" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="automall_id" default="">
		<cfargument name="new_used" default="">
	
		<cfif url.new_used eq "B">
			<cfset variables.new_used="">
		<cfelse>
			<cfset variables.new_used=url.new_used>
		</cfif>
		<cfif url.new_used eq "C">
			<cfset variables.new_used="U">
			<cfset variables.certified="1">
		<cfelse>
			<cfset variables.certified="0">
		</cfif>
		<cfif url.year eq "2014.5">
			<cfset url.year="3014">
		</cfif>		

		<cfquery datasource="Automall" name="Get_Vehicles" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		Dealer_ID,
						Vin,
						Stock,
						Permalink,
						Img_Urls,
						Video_Link,
						V_New_Used,
						V_Year,
						V_Make,
						V_Model,
						V_Trim,
						V_Odometer,
						V_Model_Number,
						V_Type,
						V_Style,
						Interior_Color,
						Exterior_Color,
						Transmission,
						Engine_Size,
						Cylinders,
						Doors,
						Drivetrain,
						Passengers,
						Dealer_Comments,
						Fuel_Type,
						EPA_City,
						EPA_HWY,
						Selling_Price_Label, 
						Selling_Price,
						MSRP_Label,
						MSRP_Price,
						Rebate_Label,
						Rebate_Price,
						Incentive_Label,
						Incentive_Price,
						Savings_Label,
						Savings_Price,
						AIS_Label,
						AIS_Price, 
						AIS_APR,
						Certified,
						Fleet,
						Luxury,
						Carfax_One_Owner,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Inv_Phone,
						Dealer_Url
			FROM		Vehicles
			WHERE		Automall_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			<cfif len(trim(variables.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			<cfif len(trim(url.dealer_id)) gt 0>
				AND		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="3">
			</cfif>
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
			</cfif>
			<cfif len(trim(url.model)) gt 0>
				AND		V_Model = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.model#" maxlength="50">
			</cfif>
			<cfif len(trim(url.model)) gt 0>
				AND		V_Model = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.model#" maxlength="50">
			</cfif>
			<cfif len(trim(url.body)) gt 0>
				AND		V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.body#" maxlength="100">
			</cfif>
			<cfif len(trim(url.color)) gt 0>
				AND		Exterior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.color#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.maxprice#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.minprice#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			ORDER BY
			<cfswitch expression="#url.sortblock#">
				<cfdefaultcase>V_Make, V_Model, Selling_Price ASC</cfdefaultcase>
				<cfcase value="2">Selling_Price ASC, V_Make, V_Model</cfcase>
				<cfcase value="3">Selling_Price DESC, V_Make, V_Model</cfcase>
				<cfcase value="4">V_Odometer ASC, V_Make, V_Model</cfcase>
				<cfcase value="5">V_Odometer DESC, V_Make, V_Model</cfcase>
				<cfcase value="6">V_Year ASC, V_Make, V_Model</cfcase>
				<cfcase value="7">V_Year DESC, V_Make, V_Model</cfcase>
				<cfcase value="8">Stock ASC</cfcase>
			</cfswitch>
		</cfquery>

		<cfreturn Get_Vehicles>

	</cffunction>

	<cffunction name="srp_zip" description="shows default srp queies" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="automall_id" required="true" >
		<cfargument name="new_used" required="true" >
		<cfargument name="Get_Dealers_Zip" required="true" >
	
		<cfset variables.dealer_order="">

		<cfloop query="Get_Dealers_Zip">
			<cfif Get_Dealers_Zip.Distance lte url.radius>
				<cfset variables.dealer_order=listappend(variables.dealer_order,"'#Get_Dealers_Zip.Dealer_ID#'")>
			</cfif>
		</cfloop>

		<cfif listlen(variables.dealer_order) eq 0>
			<cfloop query="Get_Dealers_Zip">
				<cfset variables.dealer_order=listappend(variables.dealer_order,"'#Get_Dealers_Zip.Dealer_ID#'")>
			</cfloop>
		</cfif>

		<cfif url.new_used eq "B">
			<cfset variables.new_used="">
		<cfelse>
			<cfset variables.new_used=url.new_used>
		</cfif>
		<cfif url.new_used eq "C">
			<cfset variables.new_used="U">
			<cfset variables.certified="1">
		<cfelse>
			<cfset variables.certified="0">
		</cfif>
		<cfif url.year eq "2014.5">
			<cfset url.year="3014">
		</cfif>		
<cfif left(cgi.remote_addr,7) eq "10.0.0." or left(cgi.remote_addr,10) eq "192.168.5." or left(cgi.remote_addr,10) eq "172.16.25.">
<cfquery datasource="Automall" name="Get_Vehicles" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		Vehicles.Dealer_ID,
						Vin,
						Stock,
						Permalink,
						Img_Urls,
						Video_Link,
						V_New_Used,
						V_Year,
						V_Make,
						V_Model,
						V_Trim,
						V_Odometer,
						V_Model_Number,
						V_Type,
						V_Style,
						Interior_Color,
						Exterior_Color,
						Transmission,
						Engine_Size,
						Cylinders,
						Doors,
						Drivetrain,
						Passengers,
						Dealer_Comments,
						Fuel_Type,
						EPA_City,
						EPA_HWY,
						Selling_Price_Label, 
						Selling_Price,
						MSRP_Label,
						MSRP_Price,
						Rebate_Label,
						Rebate_Price,
						Incentive_Label,
						Incentive_Price,
						Savings_Label,
						Savings_Price,
						AIS_Label,
						AIS_Price, 
						AIS_APR,
						Certified,
						Fleet,
						Luxury,
						Carfax_One_Owner,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Inv_Phone,
						Dealer_Url,
                        Zip.dbo.EarthZipDistance(#left(url.zip,5)#, Zip) AS Distance
			FROM		Vehicles, ultra10.dbo.Dealers as Dealers
			WHERE		0=0
            	AND Vehicles.dealer_id = Dealers.dealer_id
                AND Dealers.Dealer_ID in(SELECT Dealer_ID FROM Automall.dbo.Join_Automall_Dealers where Automall_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="3">)
				AND			Dealers.Dealer_ID in(SELECT DISTINCT Dealer_ID FROM Automall.dbo.Vehicles where Automall_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="3">)
				AND			Zip.dbo.EarthZipDistance(#left(url.zip,5)#, Zip) is not null
                
                
            AND Vehicles.Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)
			AND			Automall_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			<cfif len(trim(variables.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			<cfif len(trim(url.dealer_id)) gt 0>
				AND		Vehicles.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="3">
			</cfif>
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
			</cfif>
			<cfif len(trim(url.model)) gt 0>
				AND		V_Model = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.model#" maxlength="50">
			</cfif>
			<cfif len(trim(url.model)) gt 0>
				AND		V_Model = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.model#" maxlength="50">
			</cfif>
			<cfif len(trim(url.body)) gt 0>
				AND		V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.body#" maxlength="100">
			</cfif>
			<cfif len(trim(url.color)) gt 0>
				AND		Exterior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.color#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.maxprice#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.minprice#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			ORDER BY	Distance, <!--- removed the following to allow price search  02/19 --->
			 <!---   CASE Dealer_ID
			      <cfloop query="Get_Dealers_Zip">
				  	WHEN '#Get_Dealers_Zip.Dealer_ID#' THEN #Get_Dealers_Zip.CurrentRow#
				  </cfloop>
			   END --->
			<cfswitch expression="#url.sortblock#">		<!--- need leading comma if above is turned back on  02/19  --->
				<cfdefaultcase>
					Selling_Price ASC, V_Make, V_Model
				</cfdefaultcase>
				<cfcase value="1">V_Make, V_Model, Selling_Price ASC</cfcase>
				<!--- <cfcase value="2">,Selling_Price ASC, V_Make, V_Model</cfcase> --->
				<cfcase value="3">Selling_Price DESC, V_Make, V_Model</cfcase>
				<cfcase value="4">V_Odometer ASC, V_Make, V_Model</cfcase>
				<cfcase value="5">V_Odometer DESC, V_Make, V_Model</cfcase>
				<cfcase value="6">V_Year ASC, V_Make, V_Model</cfcase>
				<cfcase value="7">V_Year DESC, V_Make, V_Model</cfcase>
				<cfcase value="8">Stock ASC</cfcase>
			</cfswitch>
		</cfquery>			
<cfelse>
		<cfquery datasource="Automall" name="Get_Vehicles" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		Dealer_ID,
						Vin,
						Stock,
						Permalink,
						Img_Urls,
						Video_Link,
						V_New_Used,
						V_Year,
						V_Make,
						V_Model,
						V_Trim,
						V_Odometer,
						V_Model_Number,
						V_Type,
						V_Style,
						Interior_Color,
						Exterior_Color,
						Transmission,
						Engine_Size,
						Cylinders,
						Doors,
						Drivetrain,
						Passengers,
						Dealer_Comments,
						Fuel_Type,
						EPA_City,
						EPA_HWY,
						Selling_Price_Label, 
						Selling_Price,
						MSRP_Label,
						MSRP_Price,
						Rebate_Label,
						Rebate_Price,
						Incentive_Label,
						Incentive_Price,
						Savings_Label,
						Savings_Price,
						AIS_Label,
						AIS_Price, 
						AIS_APR,
						Certified,
						Fleet,
						Luxury,
						Carfax_One_Owner,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Inv_Phone,
						Dealer_Url
			FROM		Vehicles
			WHERE		Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)
			AND			Automall_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			<cfif len(trim(variables.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			<cfif len(trim(url.dealer_id)) gt 0>
				AND		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="3">
			</cfif>
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
			</cfif>
			<cfif len(trim(url.model)) gt 0>
				AND		V_Model = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.model#" maxlength="50">
			</cfif>
			<cfif len(trim(url.model)) gt 0>
				AND		V_Model = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.model#" maxlength="50">
			</cfif>
			<cfif len(trim(url.body)) gt 0>
				AND		V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.body#" maxlength="100">
			</cfif>
			<cfif len(trim(url.color)) gt 0>
				AND		Exterior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.color#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.maxprice#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.minprice#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			ORDER BY	<!--- removed the following to allow price search  02/19 --->
			 <!---   CASE Dealer_ID
			      <cfloop query="Get_Dealers_Zip">
				  	WHEN '#Get_Dealers_Zip.Dealer_ID#' THEN #Get_Dealers_Zip.CurrentRow#
				  </cfloop>
			   END --->
			<cfswitch expression="#url.sortblock#">		<!--- need leading comma if above is turned back on  02/19  --->
				<cfdefaultcase>
					Selling_Price ASC, V_Make, V_Model
				</cfdefaultcase>
				<cfcase value="1">V_Make, V_Model, Selling_Price ASC</cfcase>
				<!--- <cfcase value="2">,Selling_Price ASC, V_Make, V_Model</cfcase> --->
				<cfcase value="3">Selling_Price DESC, V_Make, V_Model</cfcase>
				<cfcase value="4">V_Odometer ASC, V_Make, V_Model</cfcase>
				<cfcase value="5">V_Odometer DESC, V_Make, V_Model</cfcase>
				<cfcase value="6">V_Year ASC, V_Make, V_Model</cfcase>
				<cfcase value="7">V_Year DESC, V_Make, V_Model</cfcase>
				<cfcase value="8">Stock ASC</cfcase>
			</cfswitch>
		</cfquery>			

</cfif>
		<cfreturn Get_Vehicles>

	</cffunction>

</cfcomponent>