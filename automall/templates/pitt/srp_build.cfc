<cfcomponent>

	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="new_used" required="true">
		<cfargument name="Get_Page_Content" required="true"/>

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<cfparam name="url.year" default="">
		<cfparam name="url.make" default="">
		<cfparam name="url.model" default="">
		<cfparam name="url.maxprice" default="11000000">
		<cfparam name="url.minprice" default="-1">
		<cfparam name="url.sortblock" default="2">   <!--- was 1 02/19 --->
		<cfparam name="url.luxury" default="">
		<cfparam name="url.fleet" default="">
		<cfparam name="url.certified" default="">
		<cfparam name="url.body" default="">
		<cfparam name="url.drivetrain" default="">
		<cfparam name="url.transmission" default="">
		<cfparam name="url.color" default="">
		<cfparam name="url.zip" default="">
		<cfparam name="url.radius" default="">
		<cfparam name="form.srp_Vin" default="0">
		<cfparam name="url.form_action" default="0">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">
		<cfparam name="url.old_dealer_id" default="">
		
		<!--- sortblock kung fu ---> 
		<cfswitch expression="#url.sortblock#">
			<cfcase value="9">
				<cfset url.luxury=1>
			</cfcase>
			<cfcase value="10">
				<cfset url.fleet=1>
			</cfcase>
		</cfswitch>

		<!---maxprice kung fu--->
		<cfswitch expression="#url.maxprice#">
			<cfcase value="5000,10000,15000,20000,25000,30000,35000,40000,45000,50000,75000,100000">
				<cfset url.maxprice=url.maxprice>
			</cfcase>
			<cfdefaultcase>
				<cfset url.maxprice=11000000>
			</cfdefaultcase>
		</cfswitch>

		<!---minprice kung fu--->
		<cfswitch expression="#url.minprice#">
			<cfcase value="10000,20000,30000,50000,75000">
				<cfset url.minprice=url.minprice>
			</cfcase>
			<cfdefaultcase>
				<cfset url.minprice=-1>
			</cfdefaultcase>
		</cfswitch>

		<cfinvoke component="/cfcs/automall/build_header" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<cfinvoke component="/cfcs/automall/build_nav" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<cfif len(trim(Get_Page_Content.top_ad)) gt 0>
			<section class="section-ad-leaderboard">
				<div class="container ad-leaderboard">
					<div class="row">
						<div class="col-md-12" align="center">
							<div class="ad-ldr">
								#Get_Page_Content.top_ad#
							</div>
						</div>
					</div>
				</div>
			</section>
		</cfif>
		
		<cfif IsValid("zipcode", url.zip) eq "Yes">

			<cfif len(trim(url.radius)) eq 0>
				<cfset url.radius="25">
			</cfif>
	
			<cfquery datasource="Ultra10" name="Get_Dealers_Zip" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
				SELECT		Dealer_ID,
							Dealercode,
							Dealer_Name,
							Zip,
							Zip.dbo.EarthZipDistance(#left(url.zip,5)#, Zip) AS Distance
				FROM		Dealers
				WHERE		Dealer_ID in(SELECT Dealer_ID FROM Automall.dbo.Join_Automall_Dealers where Automall_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="3">)
				AND			Dealer_ID in(SELECT DISTINCT Dealer_ID FROM Automall.dbo.Vehicles where Automall_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="3">)
				AND			Zip.dbo.EarthZipDistance(#left(url.zip,5)#, Zip) is not null
				ORDER BY	Distance, Dealer_Name
			</cfquery>

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
	
			<cfif Get_Dealers_Zip.Recordcount gt 0>
				<cfinvoke component="/cfcs/automall/vehicle_queries" method="srp_zip" returnvariable="Get_Vehicles">
					<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
					<cfinvokeargument name="new_used" value="#arguments.new_used#"/>
					<cfinvokeargument name="Get_Dealers_Zip" value="#Get_Dealers_Zip#"/>
				</cfinvoke>
			<cfelse>
				<cfset cookie.savezip="">
				<cfset variables.inv_url="http://#lcase(cgi.server_name)#">
				<!--- inventory type --->
				<cfswitch expression="#url.new_used#">
					<cfcase value="N">
						<cfset variables.inv_url=variables.inv_url & "/new/zip_error.cfm?">
					</cfcase>
					<cfcase value="U">
						<cfset variables.inv_url=variables.inv_url & "/used/zip_error.cfm?">
					</cfcase>
					<cfcase value="C">
						<cfset variables.inv_url=variables.inv_url & "/certified/zip_error.cfm?">
					</cfcase>
				</cfswitch>
				<!---add maxprice--->
				<cfif url.maxprice neq 11000000>
					<cfset variables.inv_url=variables.inv_url & "&maxprice=#url.maxprice#">
				</cfif>
				<!---add make--->
				<cfif len(trim(make)) gt 0>
					<cfset variables.inv_url=variables.inv_url & "&make=#make#">
				</cfif>
				<!---add model--->
				<cfif len(trim(model)) gt 0>
					<cfset variables.inv_url=variables.inv_url & "&model=#model#">
				</cfif>
				<!---add radius--->
				<cfif len(trim(radius)) gt 0>
					<cfset variables.inv_url=variables.inv_url & "&radius=#radius#">
				</cfif>
				<cflocation url="#variables.inv_url#">
			</cfif>
		<cfelse>
			<cflocation url="http://#lcase(replace(cgi.server_name,"www.","","all"))#/used/zip.cfm?new_used=U&maxprice=#url.maxprice#&radius=#radius#">
		</cfif>

		<!---Get Dropdown/Filter Data--->
		<cfquery datasource="Automall" name="Get_Years">
			SELECT		DISTINCT V_Year
			FROM		Vehicles
			WHERE		Automall_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			AND			Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)
			<cfif arguments.new_used eq 'N' or arguments.new_used eq 'U'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			</cfif>
			<cfif arguments.new_used eq 'C'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="U" maxlength="1">
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
			<cfif url.certified eq 1>
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
			ORDER BY	V_Year
		</cfquery>
		<cfquery datasource="Automall" name="Get_Makes">
			SELECT		DISTINCT V_Make
			FROM		Vehicles
			WHERE		Automall_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			AND			Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)
			<cfif arguments.new_used eq 'N' or arguments.new_used eq 'U'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			</cfif>
			<cfif arguments.new_used eq 'C'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="U" maxlength="1">
			</cfif>
			<cfif len(trim(url.year)) gt 0>
				AND		V_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.year#" maxlength="4">
			</cfif>
			<cfif len(trim(url.dealer_id)) gt 0>
				AND		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="3">
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
			<cfif url.certified eq 1>
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
			ORDER BY	V_Make
		</cfquery>
		<cfquery datasource="Automall" name="Get_Models">
			SELECT		DISTINCT V_Model
			FROM		Vehicles
			WHERE		Automall_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			AND			Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)
			<cfif arguments.new_used eq 'N' or arguments.new_used eq 'U'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			</cfif>
			<cfif arguments.new_used eq 'C'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="U" maxlength="1">
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
			<cfif url.certified eq 1>
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
			AND			V_Model is not null
			ORDER BY	V_Model
		</cfquery>
		<cfquery datasource="Automall" name="Get_Dealers">
			SELECT		Distinct Dealer_ID,
						Dealer_Display_Name
			FROM		Vehicles
			WHERE		Automall_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.automall_id#" maxlength="4">
			AND			Dealer_ID in (#PreserveSingleQuotes(variables.dealer_order)#)
			<cfif arguments.new_used eq 'N' or arguments.new_used eq 'U'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			</cfif>
			<cfif arguments.new_used eq 'C'>
				AND		V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="U" maxlength="1">
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
			<cfif len(trim(url.drivetrain)) gt 0>
				AND		Drivetrain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.drivetrain#" maxlength="100">
			</cfif>
			<cfif len(trim(url.transmission)) gt 0>
				AND		Transmission = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.transmission#" maxlength="50">
			</cfif>
			<cfif url.certified eq 1>
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
			ORDER BY	Dealer_Display_Name
		</cfquery>
		<cfquery dbtype="query" name="Get_Bodies">
			SELECT Distinct V_Type
			FROM			Get_Vehicles
			WHERE			V_Type is not null
			ORDER BY		V_Type
		</cfquery>
		<cfquery dbtype="query" name="Get_Drivetrains">
			SELECT Distinct Drivetrain
			FROM			Get_Vehicles
			WHERE			Drivetrain is not null
			ORDER BY		Drivetrain
		</cfquery>
		<cfquery dbtype="query" name="Get_Transmissions">
			SELECT Distinct Transmission
			FROM			Get_Vehicles
			WHERE			Transmission is not null
			ORDER BY		Transmission
		</cfquery>
		<cfquery dbtype="query" name="Get_Colors">
			SELECT Distinct Exterior_Color
			FROM			Get_Vehicles
			WHERE			Exterior_Color is not null
			ORDER BY		Exterior_Color
		</cfquery>
		
		<cfparam name="URL.page" default="1">
		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 10>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Vehicles.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Vehicles.recordCount><cfset variables.endRow = Get_Vehicles.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		
		<section class="section-srp">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
					</div>
				</div>
				<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Page_Content.page_banner#
						</div>
					</div>
				</cfif>
				<div class="row">
					<div class="col-md-12 srp-form">
						<cfinvoke component="/cfcs/automall/build_srp_form" method="srp_default">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Get_Years" value="#Get_Years#"/>
							<cfinvokeargument name="Get_Makes" value="#Get_Makes#"/>
							<cfinvokeargument name="Get_Models" value="#Get_Models#"/>
							<cfinvokeargument name="Get_Dealers" value="#Get_Dealers#"/>
						</cfinvoke>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 visible-md visible-lg">
						<cfinvoke component="/cfcs/automall/vehicle_filters" method="srp">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
							<cfinvokeargument name="Get_Years" value="#Get_Years#"/>
							<cfinvokeargument name="Get_Makes" value="#Get_Makes#"/>
							<cfinvokeargument name="Get_Models" value="#Get_Models#"/>
							<cfinvokeargument name="Get_Dealers" value="#Get_Dealers#"/>
							<cfinvokeargument name="Get_Bodies" value="#Get_Bodies#"/>
							<cfinvokeargument name="Get_Drivetrains" value="#Get_Drivetrains#"/>
							<cfinvokeargument name="Get_Transmissions" value="#Get_Transmissions#"/>
							<cfinvokeargument name="Get_Colors" value="#Get_Colors#"/>
						</cfinvoke>
					</div>
					<div class="col-md-9">
						<div class="row no-pad visible-md visible-lg">
							<cfinvoke component="/cfcs/automall/vehicle_pagination" method="srp_pages">
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
								<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
							</cfinvoke>
						</div>
						<cfif variables.startRow gt 0>
							<cfloop query="Get_Vehicles" startrow="#variables.startRow#" endrow="#variables.endRow#">
								<cfinvoke component="/cfcs/automall/vehicle" method="srp">
									<cfinvokeargument name="Get_Page_Content" value="#arguments.Get_Page_Content#"/>
									<cfinvokeargument name="Dealer_ID" value="#Get_Vehicles.Dealer_ID#"/>
									<cfinvokeargument name="Vin" value="#Get_Vehicles.Vin#"/>
									<cfinvokeargument name="Stock" value="#Get_Vehicles.Stock#"/>
									<cfinvokeargument name="V_New_Used" value="#Get_Vehicles.V_New_Used#"/>
									<cfinvokeargument name="V_Year" value="#Get_Vehicles.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#Get_Vehicles.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#Get_Vehicles.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#Get_Vehicles.V_Trim#"/>
									<cfinvokeargument name="Img_Urls" value="#Get_Vehicles.Img_Urls#"/>
									<cfinvokeargument name="New_Used" value="#Get_Vehicles.V_New_Used#"/>
									<cfinvokeargument name="Model_Number" value="#Get_Vehicles.V_Model_Number#"/>
									<cfinvokeargument name="V_Body" value="#Get_Vehicles.V_Style#"/>
									<cfinvokeargument name="V_Type" value="#Get_Vehicles.V_Type#"/>
									<cfinvokeargument name="Engine_Size" value="#Get_Vehicles.Engine_Size#"/>
									<cfinvokeargument name="V_Style" value="#Get_Vehicles.V_Style#"/>
									<cfinvokeargument name="Cylinders" value="#Get_Vehicles.Cylinders#"/>
									<cfinvokeargument name="Transmission" value="#Get_Vehicles.Transmission#"/>
									<cfinvokeargument name="Drivetrain" value="#Get_Vehicles.Drivetrain#"/>
									<cfinvokeargument name="Odometer" value="#Get_Vehicles.V_Odometer#"/>
									<cfinvokeargument name="Fuel_Type" value="#Get_Vehicles.Fuel_Type#"/>
									<cfinvokeargument name="EPA_City" value="#Get_Vehicles.EPA_City#"/>
									<cfinvokeargument name="EPA_HWY" value="#Get_Vehicles.EPA_HWY#"/>
									<cfinvokeargument name="Exterior_Color" value="#Get_Vehicles.Exterior_Color#"/>
									<cfinvokeargument name="Interior_Color" value="#Get_Vehicles.Interior_Color#"/>
									<cfinvokeargument name="Doors" value="#Get_Vehicles.Doors#"/>
									<cfinvokeargument name="Passengers" value="#Get_Vehicles.Passengers#"/>
									<cfinvokeargument name="Location" value="#Get_Vehicles.Dealer_Display_Name#"/>
									<cfinvokeargument name="Selling_Price_Label" value="#Get_Vehicles.Selling_Price_Label#"/>
									<cfinvokeargument name="Selling_Price" value="#Get_Vehicles.Selling_Price#"/>
									<cfinvokeargument name="MSRP_Label" value="#Get_Vehicles.MSRP_Label#"/>
									<cfinvokeargument name="MSRP_Price" value="#Get_Vehicles.MSRP_Price#"/>
									<cfinvokeargument name="Rebate_Label" value="#Get_Vehicles.Rebate_Label#"/>
									<cfinvokeargument name="Rebate_Price" value="#Get_Vehicles.Rebate_Price#"/>
									<cfinvokeargument name="Incentive_Label" value="#Get_Vehicles.Incentive_Label#"/>
									<cfinvokeargument name="Incentive_Price" value="#Get_Vehicles.Incentive_Price#"/>
									<cfinvokeargument name="Savings_Label" value="#Get_Vehicles.Savings_Label#"/>
									<cfinvokeargument name="Savings_Price" value="#Get_Vehicles.Savings_Price#"/>
									<cfinvokeargument name="AIS_Label" value="#Get_Vehicles.AIS_Label#"/>
									<cfinvokeargument name="AIS_Price" value="#Get_Vehicles.AIS_Price#"/>
									<cfinvokeargument name="AIS_APR" value="#Get_Vehicles.AIS_APR#"/>
									<cfinvokeargument name="Dealer_Display_Name" value="#Get_Vehicles.Dealer_Display_Name#"/>
									<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicles.Dealer_Comments#"/>
									<cfinvokeargument name="Dealer_Address_1" value="#Get_Vehicles.Dealer_Address_1#"/>
									<cfinvokeargument name="Dealer_Address_2" value="#Get_Vehicles.Dealer_Address_2#"/>
									<cfinvokeargument name="Dealer_City" value="#Get_Vehicles.Dealer_City#"/>
									<cfinvokeargument name="Dealer_State" value="#Get_Vehicles.Dealer_State#"/>
									<cfinvokeargument name="Dealer_Zip" value="#Get_Vehicles.Dealer_Zip#"/>
									<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicles.Inv_Phone#"/>
									<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicles.Dealer_Comments#"/>
									<cfinvokeargument name="Dealer_Url" value="#Get_Vehicles.Dealer_Url#"/>
									<cfif IsValid("zipcode", url.zip) eq "Yes">
										<cfinvokeargument name="My_Zip" value="#url.zip#"/>
										<cfinvokeargument name="Get_Dealers_Zip" value="#Get_Dealers_Zip#"/>
									</cfif>
								</cfinvoke>
							</cfloop>
						</cfif>
						<div class="row no-pad visible-md visible-lg">
							<cfinvoke component="/cfcs/automall/vehicle_pagination" method="srp_pages">
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
								<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
							</cfinvoke>
						</div>
						<div class="row no-pad visible-sm visible-xs">
							<cfinvoke component="/cfcs/automall/vehicle_pagination" method="srp_next">
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
								<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
							</cfinvoke>
						</div>
						<cfif len(trim(Get_Page_Content.bot_ad)) gt 0>
							<div class="row">
								<div class="col-md-12" align="center">
									<div class="ad-ldr">
										#Get_Page_Content.bot_ad#
									</div>
								</div>
							</div>
						</cfif>
					</div>
				</div>			
				<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
					<div class="row">
						<div class="col-md-12">
							#Get_Page_Content.page_footer#
						</div>
					</div>
				</cfif>
			</div>
		</section>

		<cfinvoke component="/cfcs/automall/build_footer" method="standard">
			<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
			<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
			<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
		</cfinvoke>

		<div class="modal fade" id="qqModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">
							<iframe id="qqBox" width="100%" height="350" frameborder="0" scrolling="no" src="about:blank"></iframe>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="tdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">
							<iframe id="tdBox" width="100%" height="450" frameborder="0" scrolling="no" src="about:blank"></iframe>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">
							<iframe id="infoBox" width="100%" height="350" frameborder="0" scrolling="no" src="about:blank"></iframe>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!---formsubmissions--->

		<script type="text/javascript">
			function getQuote(loc){
				document.getElementById("qqBox").src=loc;
				$('##qqModal').modal({
					show: true
				});
			}
			function getInfo(loc){
				document.getElementById("infoBox").src=loc;
				$('##infoModal').modal({
					show: true
				});
			}
			function getTD(loc){
				document.getElementById("tdBox").src=loc;
				$('##tdModal').modal({
					show: true
				});
			}
		</script>
		
	</cffunction>

</cfcomponent>