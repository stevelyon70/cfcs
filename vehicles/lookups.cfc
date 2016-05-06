<cfcomponent>

	<cffunction name="srp_default" description="shows default srp queies" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="dealer_id" default="">
		<cfargument name="new_used" default="">
		<cfargument name="classic" default="">
		<cfparam default="" name="url.style">
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
		
		<!--- Trying to clean up errors generated  10/28/2015 --->
		
				<cfif NOT Isnumeric(url.maxprice) >
					<cfset url.maxprice=replace(url.maxprice,"$","","All")>
					<cfset url.maxprice=replace(url.maxprice,",","","All")>
					<cfset url.maxprice=replace(url.maxprice,".","","All")>
				</cfif>
				
				<cfif NOT Isnumeric(url.minprice) >
					<cfset url.minprice=replace(url.minprice,"$","","All")>
					<cfset url.minprice=replace(url.minprice,",","","All")>
					<cfset url.minprice=replace(url.minprice,".","","All")>
				</cfif>
				
				<cfif url.year eq "Loading">
					<cfset url.year="#dateformat(now(),"yyyy")#">
				</cfif>	
				
				<cfif isvalid('integer',url.sortblock) eq "No">
					<cfset url.sortblock=1>
				</cfif>
				
				<cfif IsDefined("url.geo") and  isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
					<cfset url.geo=0>
				</cfif>
		
        <!---  --->
		
		
        <cfif url.new_used eq "A">
			<cfset variables.new_used="N">
			<cfset url.commercial="1">
		<cfelse>
			<cfset url.commercial="0">
		</cfif>
        
		<cfset fiat_used = 0 >
		<cfif url.new_used eq "q">
			<cfset variables.new_used="U">
			<cfset fiat_used = 1 >
		</cfif>
		
		<cfif url.year eq "2014.5">
			<cfset url.year="3014">
		</cfif>	
		
		<cfif IsDefined("url.geo") AND (#url.geo# neq "0" AND #url.geo# neq "") >
			<cfset url.geo=#url.geo#>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		
		<cfset url.year = #left(url.year,4)# >			<!--- Clean-up Year 11/24/2014 --->

		<cfif 	left(REMOTE_ADDR,7) eq "10.0.0." or
				left(REMOTE_ADDR,10) eq "172.16.25." or
				left(REMOTE_ADDR,9) eq "70.192.13" or
				left(REMOTE_ADDR,10) eq "66.179.17.">
			<cfset variables.my_cache=createTimeSpan( 0, 0, 0, 0 )>
		<cfelse>
			<cfset variables.my_cache=createTimeSpan( 0, 0, 3, 0 )>
		</cfif>
		
		<cfif isvalid('integer',arguments.dealer_id) eq "No">
			<cfset arguments.dealer_id=url.dealer_id>
		</cfif>
		
<cftry>
		<cfquery datasource="#arguments.dsn#" name="Get_Vehicles" cachedWithin="#variables.my_cache#" result="r1">
			SELECT		Vehicle_ID,
						Dealer_ID,
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
						Adjusted_Baseline,
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
						Autocheck,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Disclaimer,
						AIS_wID,
						region_id,
						on_lot_status,
						half_year
			FROM		Vehicles
			WHERE		Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
						<cfif len(trim(variables.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
						</cfif>
					)
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			
			<cfif IsDefined("url.geo") AND #url.geo# gt 0>
				AND		Region_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.geo#" maxlength="4">
			</cfif>
			<cfif len(trim(variables.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
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
			<cfif IsDefined("url.interiorcolor") AND len(trim(url.interiorcolor)) gt 0>
				AND		Interior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.interiorcolor#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.style)) gt 0>
				AND		V_Style = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.style#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
			
			<cfif #variables.new_used# EQ 'N' AND  arguments.dealer_id eq 375 >
				AND			V_Make = 'Mazda'
			</cfif>
				
			<cfif #variables.new_used# EQ 'U' AND #fiat_used# EQ 0 AND (	arguments.dealer_id eq 1 or arguments.dealer_id eq 132 or arguments.dealer_id eq 195 or arguments.dealer_id eq 16 or 
													arguments.dealer_id eq 2 or arguments.dealer_id eq 3 or arguments.dealer_id eq 4 or arguments.dealer_id eq 6 or 
													arguments.dealer_id eq 148 or arguments.dealer_id eq 7 or arguments.dealer_id eq 8 or arguments.dealer_id eq 9 or 
													arguments.dealer_id eq 10 or arguments.dealer_id eq 162 or arguments.dealer_id eq 11 or arguments.dealer_id eq 12 or arguments.dealer_id eq 15  ) >
					AND	Dealer_Display_Name <> 'Baierl Fiat'
			</cfif>
			
			<cfif #variables.new_used# EQ 'U' AND #fiat_used# EQ 1 AND (	arguments.dealer_id eq 1 or arguments.dealer_id eq 132 or arguments.dealer_id eq 195 or arguments.dealer_id eq 16 or 
													arguments.dealer_id eq 2 or arguments.dealer_id eq 3 or arguments.dealer_id eq 4 or arguments.dealer_id eq 6 or 
													arguments.dealer_id eq 148 or arguments.dealer_id eq 7 or arguments.dealer_id eq 8 or arguments.dealer_id eq 9 or 
													arguments.dealer_id eq 10 or arguments.dealer_id eq 162 or arguments.dealer_id eq 11 or arguments.dealer_id eq 12 or	arguments.dealer_id eq 15  ) >
					AND	Dealer_Display_Name = 'Baierl Fiat'
			</cfif>
			
			<cfif variables.certified eq 1 AND (arguments.dealer_id neq 1 AND  arguments.dealer_id neq 132 AND arguments.dealer_id neq 195 AND arguments.dealer_id neq 16 AND 
												arguments.dealer_id neq 2 AND arguments.dealer_id neq 14 AND arguments.dealer_id neq 3 AND arguments.dealer_id neq 4 AND 
												arguments.dealer_id neq 6 AND arguments.dealer_id neq 148 AND arguments.dealer_id neq 7 AND arguments.dealer_id neq 8 AND 
												arguments.dealer_id neq 9 AND arguments.dealer_id neq 10 AND arguments.dealer_id neq 162 AND arguments.dealer_id neq 12 AND 
												 arguments.dealer_id neq 11 AND arguments.dealer_id neq 15  ) >
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
				
				<cfif arguments.dealer_id eq 82 >
					AND			V_Make <> 'Hyundai'
				</cfif>
				<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or 
						arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
					AND			V_Make = 'Nissan'
				</cfif>
				<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or 
						arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
					AND			V_Make = 'Honda'
				</cfif>
				<cfif arguments.dealer_id eq 37>
					AND			(V_Make = 'Toyota')
				</cfif>
				<cfif arguments.dealer_id eq 46>
					AND			(V_Make = 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 46>
					AND			(V_Make = 'Toyota' )
				</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 15>  <!--- Baierl Trucks --->
					AND			( V_Make = 'Ford' or V_Make = 'Chevrolet'	or	V_Make = 'Isuzu'	or	V_Make = 'Toyota' )
				</cfif> 
				<cfif arguments.dealer_id eq 132>  <!--- Northpointe CDJR --->
					AND			( V_Make = 'Chrysler' or V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
				</cfif> 
				<cfif arguments.dealer_id eq 195>  <!--- Northpointe GM --->
					AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
				</cfif> 
				<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82  or arguments.dealer_id eq 68   >
					AND			V_Make = 'Mazda'
				</cfif>
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
            
			<cfif url.commercial eq 1>
				AND		Commercial = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.maxprice)#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.minprice)#" maxlength="10">
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
				<cfdefaultcase>
					<cfif arguments.dealer_id eq "70" and variables.new_used eq "n">
						V_Make DESC, V_Model ASC, Selling_Price ASC
					<cfelseif arguments.dealer_id eq "37" and variables.new_used eq "n">
						V_Make DESC, V_Model ASC, Selling_Price ASC
					<cfelseif arguments.dealer_id eq "78" and variables.new_used eq "n">
						dealer_display_name ASC, V_Make, V_Model, Selling_Price ASC
					<cfelseif arguments.dealer_id eq "79" and variables.new_used eq "n">
						dealer_display_name DESC, V_Make, V_Model, Selling_Price ASC
					<cfelseif arguments.dealer_id eq "35" and variables.new_used eq "u">  <!--- Kelly Risk Free --->
						Selling_Price ASC, V_Make, V_Model
					<cfelse>
						V_Make, V_Model, Selling_Price ASC
					</cfif>
				</cfdefaultcase>
				<cfcase value="2">Selling_Price ASC, V_Make, V_Model</cfcase>
				<cfcase value="3">Selling_Price DESC, V_Make, V_Model</cfcase>
				<cfcase value="4">V_Odometer ASC, V_Make, V_Model</cfcase>
				<cfcase value="5">V_Odometer DESC, V_Make, V_Model</cfcase>
				<cfcase value="6">V_Year ASC, V_Make, V_Model</cfcase>
				<cfcase value="7">V_Year DESC, V_Make, V_Model</cfcase>
				<cfcase value="8">Stock ASC</cfcase>
			</cfswitch>
		</cfquery>
		<cfcatch>
        <cfquery datasource="#arguments.dsn#" name="Get_Vehicles" cachedWithin="#variables.my_cache#" result="r1">
			SELECT		Vehicle_ID,
						Dealer_ID,
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
						Adjusted_Baseline,
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
						Autocheck,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Disclaimer,
						AIS_wID,
						region_id,
						on_lot_status,
						half_year
			FROM		Vehicles
			WHERE		0=1			
		</cfquery>
        </cfcatch>
        </cftry>
		
        <!---<cfif cgi.remote_addr eq '172.16.25.102'>
        	<h1>TESTING INTERNAL DISPLAY ONLY</h1>
        	<cfdump var="#r1#" >
            </cfif>--->
		<cfreturn Get_Vehicles>

	</cffunction>

	<cffunction name="srp_zip" description="shows default srp queies" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true" >
		<cfargument name="new_used" required="true" >
		<cfargument name="Get_Dealers_Zip" required="true" >
		<cfargument name="classic" default="">
	
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

		<!--- Trying to clean up errors generated  10/28/2015 --->
		
				<cfif NOT Isnumeric(url.maxprice) >
					<cfset url.maxprice=replace(url.maxprice,"$","","All")>
					<cfset url.maxprice=replace(url.maxprice,",","","All")>
					<cfset url.maxprice=replace(url.maxprice,".","","All")>
				</cfif>
				
				<cfif NOT Isnumeric(url.minprice) >
					<cfset url.minprice=replace(url.minprice,"$","","All")>
					<cfset url.minprice=replace(url.minprice,",","","All")>
					<cfset url.minprice=replace(url.minprice,".","","All")>
				</cfif>
				
				<cfif url.year eq "Loading">
					<cfset url.year="#dateformat(now(),"yyyy")#">
				</cfif>	
				
				<cfif isvalid('integer',url.sortblock) eq "No">
					<cfset url.sortblock=1>
				</cfif>
		
				<cfif IsDefined("url.geo") and  isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
					<cfset url.geo=0>
				</cfif>
		
        <!---  --->
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "" AND url.geo neq "Loading") >
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		
		<cfquery datasource="Ultra10" name="Get_Vehicles">
			SELECT		Vehicle_ID,
						Dealer_ID,
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
						Adjusted_Baseline,
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
						Autocheck,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Inv_Phone,
						Dealer_Url,
						Disclaimer,
						AIS_wID,
						region_id,
						on_lot_status,
						half_year
			FROM		Vehicles
			WHERE		Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)

			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			
			<cfif IsDefined("url.geo") AND #url.geo# gt 0>
				AND		Region_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.geo#" maxlength="4">
			</cfif>


			<cfif len(trim(variables.new_used)) gt 0  >
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
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
			<cfif IsDefined("url.interiorcolor") AND len(trim(url.interiorcolor)) gt 0>
				AND		Interior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.interiorcolor#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>

			<cfif #variables.new_used# EQ 'N' AND  arguments.dealer_id eq 375 >
				AND			V_Make = 'Mazda'
			</cfif>
				
			
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">

								
<!--- 02/02/2015 --->	<cfif arguments.dealer_id eq 82 >
							AND			V_Make <> 'Hyundai'
						</cfif>
								


				
				<cfif arguments.dealer_id eq 15>  <!--- Baierl Trucks --->
					AND			( V_Make = 'Ford' or V_Make = 'Chevrolet'	or	V_Make = 'Isuzu'	or	V_Make = 'Toyota' )
				</cfif> 

				<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
					AND			V_Make = 'Nissan'
				</cfif>
				<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
					AND			V_Make = 'Honda'
				</cfif>
				<cfif arguments.dealer_id eq 37>
					AND			(V_Make = 'Toyota')
				</cfif>
				<cfif arguments.dealer_id eq 46>
					AND			(V_Make = 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 45 >		<!--- Toltz Scion --->
					AND			(V_Make = 'Scion' )
				</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 132>  <!--- Northpointe CDJR --->
					AND			( V_Make = 'Chrysler' or V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
				</cfif> 
				<cfif arguments.dealer_id eq 195>  <!--- Northpointe GM --->
					AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
				</cfif> 
				<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82  or arguments.dealer_id eq 68    >
					AND			V_Make = 'Mazda'
				</cfif>
			
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.maxprice)#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.minprice)#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			ORDER BY
			   CASE Dealer_ID
			      <cfloop query="Get_Dealers_Zip">
				  	WHEN '#Get_Dealers_Zip.Dealer_ID#' THEN #Get_Dealers_Zip.CurrentRow#
				  </cfloop>
			   END
			<cfswitch expression="#url.sortblock#">
				<cfdefaultcase>
					,V_Make, V_Model, Selling_Price ASC
				</cfdefaultcase>
				<cfcase value="2">,Selling_Price ASC, V_Make, V_Model</cfcase>
				<cfcase value="3">,Selling_Price DESC, V_Make, V_Model</cfcase>
				<cfcase value="4">,V_Odometer ASC, V_Make, V_Model</cfcase>
				<cfcase value="5">,V_Odometer DESC, V_Make, V_Model</cfcase>
				<cfcase value="6">,V_Year ASC, V_Make, V_Model</cfcase>
				<cfcase value="7">,V_Year DESC, V_Make, V_Model</cfcase>
				<cfcase value="8">,Stock ASC</cfcase>
			</cfswitch>
		</cfquery>			

		<cfreturn Get_Vehicles>

	</cffunction>
	
	<cffunction name="srp_years" description="filter years" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="dealer_id" default="">
		<cfargument name="new_used" default="">
		<cfargument name="classic" default="">
	
		<!---New/Used filter--->
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
        <cfif url.new_used eq "A">
        	<cfset variables.new_used="N">
        	<cfset url.commercial = 1>
        </cfif>

		
		<!--- Trying to clean up errors generated  10/28/2015 --->
		
				<cfif NOT Isnumeric(url.maxprice) >
					<cfset url.maxprice=replace(url.maxprice,"$","","All")>
					<cfset url.maxprice=replace(url.maxprice,",","","All")>
					<cfset url.maxprice=replace(url.maxprice,".","","All")>
				</cfif>
				
				<cfif NOT Isnumeric(url.minprice) >
					<cfset url.minprice=replace(url.minprice,"$","","All")>
					<cfset url.minprice=replace(url.minprice,",","","All")>
					<cfset url.minprice=replace(url.minprice,".","","All")>
				</cfif>
				
				<cfif url.year eq "Loading">
					<cfset url.year="#dateformat(now(),"yyyy")#">
				</cfif>	
				
				<cfif isvalid('integer',url.sortblock) eq "No">
					<cfset url.sortblock=1>
				</cfif>
		
				<cfif IsDefined("url.geo") and  isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
					<cfset url.geo=0>
				</cfif>
				
        <!---  --->
		
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "") >
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		
		<cfquery datasource="#arguments.dsn#" name="Get_Years" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		DISTINCT V_Year
			FROM		Vehicles
			WHERE		Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
						<cfif len(trim(variables.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
						</cfif>
					)

			<cfif IsDefined("url.geo") AND #url.geo# gt 0>
				AND		Region_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.geo#" maxlength="4">
			</cfif>
			
			<cfif len(trim(url.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
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
			<cfif IsDefined("url.interiorcolor") AND len(trim(url.interiorcolor)) gt 0>
				AND		Interior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.interiorcolor#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
					
			<cfif url.commercial eq 1>
				AND		Commercial = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			
			<cfif #variables.new_used# EQ 'N' AND  arguments.dealer_id eq 375 >
				AND			V_Make = 'Mazda'
			</cfif>
				
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">

				
<!--- 02/02/2015 --->	<cfif arguments.dealer_id eq 82 >
							AND			V_Make <> 'Hyundai'
						</cfif>


				
				<cfif arguments.dealer_id eq 15>  <!--- Baierl Trucks --->
					AND			( V_Make = 'Ford' or V_Make = 'Chevrolet'	or	V_Make = 'Isuzu'	or	V_Make = 'Toyota' )
				</cfif> 

				<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
					AND			V_Make = 'Nissan'
				</cfif>
				<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
					AND			V_Make = 'Honda'
				</cfif>
				<cfif arguments.dealer_id eq 37>
					AND			(V_Make = 'Toyota')
				</cfif>
				<cfif arguments.dealer_id eq 46>
					AND			(V_Make = 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 45 >		<!--- Toltz Scion --->
					AND			(V_Make = 'Scion' )
				</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 132>  <!--- Northpointe CDJR --->
					AND			( V_Make = 'Chrysler' or V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
				</cfif> 
				<cfif arguments.dealer_id eq 195>  <!--- Northpointe GM --->
					AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
				</cfif> 
				<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82 or arguments.dealer_id eq 68  >
					AND			V_Make = 'Mazda'
				</cfif>
			
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.maxprice)#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.minprice)#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			ORDER BY	V_Year
		</cfquery>
		<cfreturn Get_Years>
	</cffunction>

	<cffunction name="srp_makes" description="filter makes" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="dealer_id" default="">
		<cfargument name="new_used" default="">
		<cfargument name="classic" default="">
		
		<!---New/Used filter--->
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
        <cfif url.new_used eq "A">
        	<cfset variables.new_used="N">
        	<cfset url.commercial = 1>
        </cfif>
        
		<!--- Trying to clean up errors generated  10/28/2015 --->
		
				<cfif NOT Isnumeric(url.maxprice) >
					<cfset url.maxprice=replace(url.maxprice,"$","","All")>
					<cfset url.maxprice=replace(url.maxprice,",","","All")>
					<cfset url.maxprice=replace(url.maxprice,".","","All")>
				</cfif>
				
				<cfif NOT Isnumeric(url.minprice) >
					<cfset url.minprice=replace(url.minprice,"$","","All")>
					<cfset url.minprice=replace(url.minprice,",","","All")>
					<cfset url.minprice=replace(url.minprice,".","","All")>
				</cfif>
				
				<cfif url.year eq "Loading">
					<cfset url.year="#dateformat(now(),"yyyy")#">
				</cfif>	
				
				
				<cfif isvalid('integer',url.sortblock) eq "No">
					<cfset url.sortblock=1>
				</cfif>
		
				<cfif IsDefined("url.geo") and  isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
					<cfset url.geo=0>
				</cfif>
        <!---  --->
	
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "" AND url.geo neq "Loading") >
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		
		<cfquery datasource="#arguments.dsn#" name="Get_Makes" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		DISTINCT V_Make
			FROM		Vehicles
			WHERE		Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
						<cfif len(trim(variables.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
						</cfif>
					)

			<cfif IsDefined("url.geo") AND #url.geo# gt 0>
				AND		Region_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.geo#" maxlength="4">
			</cfif>
			
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
	<!--- Courtesy Imports Classic Used Cars --->
			<cfif len(trim(url.classic)) gt 0 and  ( #arguments.dealer_id# EQ 66 OR #arguments.dealer_id# EQ 40 OR  arguments.dealer_id eq "67"  OR  url.dealer_id eq "288"    ) >
				AND		V_Year < 1991
			</cfif>		
	<!--- Courtesy Imports NOT Classic Used Cars --->
	
			<cfif  (#arguments.dealer_id# EQ 66  OR  arguments.dealer_id eq "67"  OR  url.dealer_id eq "288"  )  and len(trim(url.classic)) EQ 0  >
				AND		V_Year > 1990
			</cfif>		

			<cfif len(trim(url.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.body)) gt 0>
				AND		V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.body#" maxlength="100">
			</cfif>
			<cfif len(trim(url.color)) gt 0>
				AND		Exterior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.color#" maxlength="100">
			</cfif>
			<cfif IsDefined("url.interiorcolor") AND len(trim(url.interiorcolor)) gt 0>
				AND		Interior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.interiorcolor#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
					

			<cfif url.commercial eq 1>
				AND		Commercial = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
            
			<cfif #variables.new_used# EQ 'N' AND  arguments.dealer_id eq 375 >
				AND			V_Make = 'Mazda'
			</cfif>
				
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">

				
<!--- 02/02/2015 --->	<cfif arguments.dealer_id eq 82 >
							AND			V_Make <> 'Hyundai'
						</cfif>

				
				
				<cfif arguments.dealer_id eq 15>  <!--- Baierl Trucks --->
					AND			( V_Make = 'Ford' or V_Make = 'Chevrolet'	or	V_Make = 'Isuzu'	or	V_Make = 'Toyota' )
				</cfif> 
				<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
					AND			V_Make = 'Nissan'
				</cfif>
				<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
					AND			V_Make = 'Honda'
				</cfif>
				<cfif arguments.dealer_id eq 37>
					AND			(V_Make = 'Toyota')
				</cfif>
				<cfif arguments.dealer_id eq 46>
					AND			(V_Make = 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 45 >		<!--- Toltz Scion --->
					AND			(V_Make = 'Scion' )
				</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 132>  <!--- Northpointe CDJR --->
					AND			( V_Make = 'Chrysler' or V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
				</cfif> 
				<cfif arguments.dealer_id eq 195>  <!--- Northpointe GM --->
					AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
				</cfif> 
				<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82 or arguments.dealer_id eq 68  >
					AND			V_Make = 'Mazda'
				</cfif>
			
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.maxprice)#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.minprice)#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			
			<cfelse>
				ORDER BY	V_Make
			</cfif>
		</cfquery>
		<cfreturn Get_Makes>
	</cffunction>

	<cffunction name="srp_models" description="filter models" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="dealer_id" default="">
		<cfargument name="new_used" default="">
		<cfargument name="classic" default="">
	
		<!---New/Used filter--->
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
        <cfif url.new_used eq "A">
        	<cfset variables.new_used="N">
        	<cfset url.commercial = 1>
        </cfif>

		<!--- Trying to clean up errors generated  10/28/2015 --->
		
				<cfif NOT Isnumeric(url.maxprice) >
					<cfset url.maxprice=replace(url.maxprice,"$","","All")>
					<cfset url.maxprice=replace(url.maxprice,",","","All")>
					<cfset url.maxprice=replace(url.maxprice,".","","All")>
				</cfif>
				
				<cfif NOT Isnumeric(url.minprice) >
					<cfset url.minprice=replace(url.minprice,"$","","All")>
					<cfset url.minprice=replace(url.minprice,",","","All")>
					<cfset url.minprice=replace(url.minprice,".","","All")>
				</cfif>
				
				<cfif url.year eq "Loading">
					<cfset url.year="#dateformat(now(),"yyyy")#">
				</cfif>	
				
				<cfif isvalid('integer',url.sortblock) eq "No">
					<cfset url.sortblock=1>
				</cfif>
		
				<cfif IsDefined("url.geo") and  isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
					<cfset url.geo=0>
				</cfif>
        <!---  --->
		
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "" and url.geo neq "Loading" ) >
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		<cfquery datasource="#arguments.dsn#" name="Get_Models" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		DISTINCT V_Model
			FROM		Vehicles
			WHERE		Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
						<cfif len(trim(variables.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
						</cfif>
					)

			<cfif IsDefined("url.geo") AND #url.geo# gt 0>
				AND		Region_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.geo#" maxlength="4">
			</cfif>
	
			<cfif len(trim(url.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			</cfif>
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
			</cfif>
			<cfif len(trim(url.body)) gt 0>
				AND		V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.body#" maxlength="100">
			</cfif>
			<cfif len(trim(url.color)) gt 0>
				AND		Exterior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.color#" maxlength="100">
			</cfif>
			<cfif IsDefined("url.interiorcolor") AND len(trim(url.interiorcolor)) gt 0>
				AND		Interior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.interiorcolor#" maxlength="100">
			</cfif>
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
					
 
			
			<cfif url.commercial eq 1>
				AND		Commercial = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			
			<cfif #variables.new_used# EQ 'N' AND  arguments.dealer_id eq 375 >
				AND			V_Make = 'Mazda'
			</cfif>
				
			<cfif variables.certified eq 1>
				AND		Certified = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
				
<!--- 02/02/2015 --->	<cfif arguments.dealer_id eq 82 >
							AND			V_Make <> 'Hyundai'
						</cfif>

				

				<cfif arguments.dealer_id eq 15>  <!--- Baierl Trucks --->
					AND			( V_Make = 'Ford' or V_Make = 'Chevrolet'	or	V_Make = 'Isuzu'	or	V_Make = 'Toyota' )
				</cfif> 
				<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
					AND			V_Make = 'Nissan'
				</cfif>
				<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
					AND			V_Make = 'Honda'
				</cfif>
				<cfif arguments.dealer_id eq 37>
					AND			(V_Make = 'Toyota')
				</cfif>
				<cfif arguments.dealer_id eq 46>
					AND			(V_Make = 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 45 >		<!--- Toltz Scion --->
					AND			(V_Make = 'Scion' )
				</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
				<cfif arguments.dealer_id eq 132>  <!--- Northpointe CDJR --->
					AND			( V_Make = 'Chrysler' or V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
				</cfif> 
				<cfif arguments.dealer_id eq 195>  <!--- Northpointe GM --->
					AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
				</cfif> 
				<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82  or arguments.dealer_id eq 68  >
					AND			V_Make = 'Mazda'
				</cfif>
			
			</cfif>
			<cfif url.luxury eq 1>
				AND		Luxury = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			<cfif url.fleet eq 1>
				AND		Fleet = <cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">
			</cfif>
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.maxprice)#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.minprice)#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			AND			V_Model is not null
			ORDER BY	V_Model
		</cfquery>
		<cfreturn Get_Models>
	</cffunction>

	<!---  --->
	
	<cffunction name="srp_geo" description="filter models" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="dealer_id" default="">
		<cfargument name="new_used" default="">
		<cfargument name="classic" default="">
	
		
	
		<!---New/Used filter--->
		<cfif url.new_used eq "B">
			<cfset variables.new_used="">
		<cfelse>
			<cfset variables.new_used=url.new_used>
		</cfif>
		
		
				<cfif IsDefined("url.geo") and  isvalid('integer',url.geo) eq "No">	<!--- 12/03/2015 --->
					<cfset url.geo=0>
				</cfif>
				
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "") >
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		
		<cfif url.new_used eq "C">
			<cfset variables.new_used="U">
			<cfset variables.certified="1">
		<cfelse>
			<cfset variables.certified="0">
		</cfif>
 
		<!--- Trying to clean up errors generated  10/28/2015 --->
		
				<cfif NOT Isnumeric(url.maxprice) >
					<cfset url.maxprice=replace(url.maxprice,"$","","All")>
					<cfset url.maxprice=replace(url.maxprice,",","","All")>
					<cfset url.maxprice=replace(url.maxprice,".","","All")>
				</cfif>
				
				<cfif NOT Isnumeric(url.minprice) >
					<cfset url.minprice=replace(url.minprice,"$","","All")>
					<cfset url.minprice=replace(url.minprice,",","","All")>
					<cfset url.minprice=replace(url.minprice,".","","All")>
				</cfif>
				
				<cfif url.year eq "Loading">
					<cfset url.year="#dateformat(now(),"yyyy")#">
				</cfif>	
				
				<cfif isvalid('integer',url.sortblock) eq "No">
					<cfset url.sortblock=1>
				</cfif>
				
        <!---  --->
		
		<cfquery datasource="#arguments.dsn#" name="Get_Geo" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT		DISTINCT region_id
			FROM		Vehicles
			WHERE		Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
						<cfif len(trim(variables.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
						</cfif>
					)

 
			<cfif len(trim(url.new_used)) gt 0>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.new_used#" maxlength="1">
			<cfelse>
				AND		V_New_Used = 'N'
			</cfif>
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			
			<cfif len(trim(url.make)) gt 0>
				AND		V_Make = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.make#" maxlength="50">
			
			</cfif>
			
			<cfif len(trim(url.body)) gt 0>
				AND		V_Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.body#" maxlength="100">
			</cfif>
			<cfif len(trim(url.color)) gt 0>
				AND		Exterior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.color#" maxlength="100">
			</cfif>
			<cfif IsDefined("url.interiorcolor") AND len(trim(url.interiorcolor)) gt 0>
				AND		Interior_Color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.interiorcolor#" maxlength="100">
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
			AND			Selling_Price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.maxprice)#" maxlength="10">
			AND			Selling_Price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#LSParseNumber(url.minprice)#" maxlength="10">
			<cfif url.sortblock eq 2 or  url.sortblock eq 3>
				AND		Selling_Price <> 0
				AND		Selling_Price <> 10000000
			</cfif>
			<cfif url.sortblock eq 4 or  url.sortblock eq 5>
				AND		V_Odometer <> 0
				AND		V_New_Used = 'U'
			</cfif>
			AND			region_id is not null
			AND			region_id <> 0
			ORDER BY	region_id
		</cfquery>
		<cfset Get_Dealers_Geo = get_geo >
		<cfreturn Get_Dealers_Geo>
	</cffunction>


	<cffunction name="srp_srchbox" description="shows default srp queies from collection" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="dealer_id" default="">
		<cfargument name="new_used" default="">
		<cfargument name="classic" default="">
	
	
		<cfif 	left(REMOTE_ADDR,7) eq "10.0.0." or
				left(REMOTE_ADDR,10) eq "172.16.25." or
				left(REMOTE_ADDR,9) eq "70.192.13" or
				left(REMOTE_ADDR,10) eq "66.179.17.">
			<cfset variables.my_cache=createTimeSpan( 0, 0, 0, 0 )>
		<cfelse>
			<cfset variables.my_cache=createTimeSpan( 0, 0, 3, 0 )>
		</cfif>
		<!---  
		#url.lookup_vins# --->
	
		<cfquery datasource="#arguments.dsn#" name="Get_Vehicles" cachedWithin="#variables.my_cache#">
			SELECT		Vehicle_ID,
						Dealer_ID,
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
						Adjusted_Baseline,
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
						Autocheck,
						Dealer_Display_Name,
						Dealer_Address_1,
						Dealer_Address_2,
						Dealer_City,
						Dealer_State,
						Dealer_Zip, 
						Dealer_Phone,
						Disclaimer,
						AIS_wID,
						region_id,
						on_lot_status,
						half_year
			FROM		Vehicles
			WHERE		VIN IN ( <cfqueryparam value="#url.lookup_vins#" cfsqltype="cf_sql_varchar" list="yes" /> )
			
			<!--- 
			WHERE		Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
					)
			AND		VIN IN ( <cfqueryparam value="#url.lookup_vins#" cfsqltype="cf_sql_varchar" list="yes" /> ) --->

			ORDER BY Selling_Price ASC, V_Make, V_Model
		</cfquery>
		
		<!--- testing
		#Get_Vehicles.recordcount#
		<cfabort> --->
		
		<cfreturn Get_Vehicles>

	</cffunction>

	
	
	
</cfcomponent>