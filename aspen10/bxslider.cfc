<cfcomponent>

	<cffunction name="v_rand" description="loads bx slider populated by random vehicles from inventory" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="new_used" default="U">
		<cfargument name="certified" default="0">
		<cfargument name="price_ceiling" default="">
		<cfargument name="results" default="12">
		<cfargument name="carousel_class" default="carousel_v_rand">
		<cfargument name="minSlides" default="4">
		<cfargument name="maxSlides" default="20">
		<cfargument name="auto" default="true">
		<cfargument name="moveSlides" default="1">
		<cfargument name="slideWidth" default="200">
		<cfargument name="slideMargin" default="10">
		<cfargument name="addScript" default="true">

		
		
		<cfquery datasource="#arguments.dsn#" name="Get_Vehicles">
			SELECT		TOP (#arguments.results#) 
						V_Year,
						V_Make,
						V_Model,
						V_Trim,
						Selling_Price,
						Img_Urls,
						Vin,
						Stock,
						V_Model_Number,
						Permalink
			FROM		Vehicles
			WHERE		Dealer_ID IN 
						(	SELECT 	Share_ID 
							FROM 	Aspen10.dbo.Dealer_Shares 
							WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
							AND 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">)
			AND			V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			<cfif arguments.Certified neq 0>
				AND		Certified = 1
			</cfif>
				<cfswitch expression="#arguments.dealer_id#">
					<cfcase value="52,54">   <!--- Pittsburgh East & West Hills Nissan --->
						AND V_Make='Nissan'
					</cfcase> 
					<cfcase value="25,28,151">		<!--- Fayette Honda Washington Honda --->
						AND V_Make='Honda'
					</cfcase>  
					<cfcase value="24,82">		<!--- Faulkner Mazda --->
						AND V_Make='Mazda'
					</cfcase>   
					<cfcase value="87,168">		<!--- Fuccillo Ford --->
						AND V_Make='Ford'
					</cfcase>    
					<cfcase value="169">		<!--- Fuccillo Hyundai --->
						AND V_Make='Hyundai'
					</cfcase>     
					<cfcase value="170">		<!--- Fuccillo Hyundai --->
						AND V_Make='Hyundai'
					</cfcase>   
					<cfcase value="89">		<!--- Fuccillo Mitsubishi --->
						AND V_Make='Mitsubishi'
					</cfcase>    
					<cfcase value="181">		<!--- Fuccillo Kia --->
						AND V_Make='Kia'
					</cfcase>  
					<cfcase value="37,73,46,74">		<!--- Washington Toyota Fuccillo Toyota --->
						AND			(V_Make = 'Toyota' or V_MAKE = 'Scion')
					</cfcase>  
					<cfcase value="30,12">		<!--- Ron Hibbard Toyota Baierl Toyota --->
						AND			V_Make = 'Toyota'
					</cfcase> 
					<cfcase value="132">		<!--- Northepoint CDJR --->
						AND ( V_Make='Chrysler' OR  V_Make='Dodge' OR  V_Make='Jeep' OR  V_Make='Ram')
					</cfcase> 
					<cfcase value="195">		<!--- Northepoint GM --->
						AND ( V_Make='Chevrolet' OR  V_Make='Cadillac')
					</cfcase> 
				</cfswitch>
			<!--- <cfif #url.dealer_id# neq 55 >
				AND			Selling_Price <> 10000000
				AND			Selling_Price <> 0
			</cfif> --->
			AND			Img_Urls IS NOT NULL
			<cfif isvalid("integer",arguments.price_ceiling) eq "yes">
				AND		Selling_Price <= 0
			</cfif>
			ORDER BY 	NEWID()
		</cfquery>
		
		<ul class="#arguments.carousel_class#" align="center">
			<cfloop query="Get_Vehicles">
				<cfif #Get_Vehicles.Selling_Price# EQ "10000000" or #Get_Vehicles.Selling_Price# EQ 0 >
					<cfset price_msg = "Call for Price">
				<cfelse>
					<cfset price_msg = "Only $#numberformat(Get_Vehicles.Selling_Price)#">
				</cfif>
				<li class="slide #arguments.carousel_class#_slide" >
					<cfif #url.dealer_id# NEQ 30 and #url.dealer_id# NEQ 62 and #url.dealer_id# NEQ 1 and #url.dealer_id# NEQ 12  and #url.dealer_id# NEQ 4   and #url.dealer_id# NEQ 3 and #url.dealer_id# NEQ 7 >
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 1>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" align="center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" align="center">#price_msg#</span><br/> 
							<p align="center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 12>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" align="center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" align="center">#price_msg#</span><br/> 
							<p align="center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 4>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" align="center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" align="center">#price_msg#</span><br/> 
							<p align="center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 3>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" align="center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" align="center">#price_msg#</span><br/> 
							<p align="center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 7>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" align="center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" align="center">#price_msg#</span><br/> 
							<p align="center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelse>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span style="color:black;font-weight:bold;text-align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span style="color:red;font-weight:bold;text-align:center">#price_msg#</span><br/> 
							<input class="blk4-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';">
						</a>	
					</cfif>
				</li>
			</cfloop>
		</ul>
		
		<cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	
	</cffunction>

	<cffunction name="v_specials_legacy" description="loads bx slider populated by random vehicles from inventory" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="new_used" default="U">
		<cfargument name="certified" default="0">
		<cfargument name="price_ceiling" default="">
		<cfargument name="results" default="12">
		<cfargument name="carousel_class" default="carousel_v_rand">
		<cfargument name="minSlides" default="4">
		<cfargument name="maxSlides" default="20">
		<cfargument name="auto" default="true">
		<cfargument name="moveSlides" default="1">
		<cfargument name="slideWidth" default="154">
		<cfargument name="slideMargin" default="10">
		<cfargument name="addScript" default="true">
		<cfargument name="site_mode" default="modern">

 		<cfquery datasource="Ultra8" name="Get_Vehicles">
			SELECT		Vehicle_Specials.Dealercode,
						Vehicle_Specials.Vehicle_Year as V_Year,
						Vehicle_Specials.Make as V_Make,
						Vehicle_Specials.Model as V_Model,
						Vehicle_Specials.Vin as vin,
						Vehicle_Specials.Stock as stock,
						Vehicle_Specials.Is_Price as Selling_Price,
						Vehicle_Specials.Vehicle_Image as Img_Urls,
						Inventory.Vehicle_Trim as V_Trim,
						Inventory.Page_ID as Permalink,
						Inventory.New_Used as new_used
			FROM		Vehicle_Specials
			INNER JOIN	Inventory
			ON 			Vehicle_Specials.Vin = Inventory.Vin
			WHERE		Vehicle_Specials.Dealercode IN 
						(	SELECT DISTINCT Shared_Dealercode
							FROM Inventory_Share
							WHERE 	Dealercode = <cfqueryparam value="#url.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
							<cfif arguments.new_used neq "B">AND 	New_Used=<cfqueryparam value="#arguments.new_used#" cfsqltype="CF_SQL_VARCHAR" maxlength="1"></cfif>
						)
			AND 		Vehicle_Specials.Start_Date <= { fn NOW() }
			AND			(Vehicle_Specials.Expiration_Date >= { fn NOW() } or Vehicle_Specials.Expiration_Date is null)
			
			<cfswitch expression="#arguments.new_used#">
				<cfcase value="N">AND	Vehicle_Specials.Special_Class_ID=1</cfcase>
				<cfcase value="U">AND	Vehicle_Specials.Special_Class_ID=2</cfcase>
			</cfswitch>
			<cfswitch expression="#arguments.dealer_id#">
				<cfcase value="52,54">   <!--- Pittsburgh East & West Hills Nissan --->
					AND V_Make='Nissan'
				</cfcase> 
				<cfcase value="25,28">		<!--- Fayette Honda --->
					AND V_Make='Honda'
				</cfcase> 
				<cfcase value="24,82">		<!--- Faulkner Mazda --->
					AND V_Make='Mazda'
				</cfcase>   
					<cfcase value="87,168">		<!--- Fuccillo Ford --->
						AND V_Make='Ford'
					</cfcase>  
					<cfcase value="169">		<!--- Fuccillo Hyundai --->
						AND V_Make='Hyundai'
					</cfcase>  
					<!--- <cfcase value="170">		<!--- Fuccillo Hyundai --->
						AND V_Make='Hyundai'
					</cfcase>   --->
				<cfcase value="37,73,46,74">		<!--- Washington Toyota --->
					AND V_Make='Toyota'
				</cfcase>  
				<cfcase value="30, 12">		<!--- Ron Hibbard Toyota --->
					AND V_Make='Toyota'
				</cfcase> 
				<cfcase value="132">		<!--- Northepoint CDJR --->
					AND ( V_Make='Chrysler' OR  V_Make='Dodge' OR  V_Make='Jeep' OR  V_Make='Ram')
				</cfcase> 
				<cfcase value="195">		<!--- Northepoint GM --->
					AND ( V_Make='Chevrolet' OR  V_Make='Cadillac')
				</cfcase> 
			</cfswitch>
			AND			Vehicle_Specials.Vehicle_Image IS NOT NULL
			AND			Vehicle_Specials.Special_Type='Specific'
			ORDER BY	Vehicle_Specials.Hierarchy
		</cfquery>
   

  	<cfif  #Get_Vehicles.recordcount# LTE 4 >
		<cfquery datasource="Aspen10" name="Get_Vehicles">
			SELECT		TOP (#arguments.results#) 
						V_Year,
						V_Make,
						V_Model,
						V_Trim,
						Selling_Price,
						Img_Urls,
						Vin,
						Stock,
						V_Model_Number,
						Permalink
			FROM		Vehicles
			WHERE		Dealer_ID IN 
						(	SELECT 	Share_ID 
							FROM 	Aspen10.dbo.Dealer_Shares 
							WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
							AND 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">)
			AND			V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			<cfif arguments.Certified neq 0>
				AND		Certified = 1
				<cfswitch expression="#arguments.dealer_id#">
					<cfcase value="52,54">   <!--- Pittsburgh East & West Hills Nissan --->
						AND V_Make='Nissan'
					</cfcase> 
					<cfcase value="25,28">		<!--- Fayette Honda Washington Honda --->
						AND V_Make='Honda'
					</cfcase>  
					<cfcase value="24,82">		<!--- Faulkner Mazda --->
						AND V_Make='Mazda'
					</cfcase>  
					<cfcase value="37">		<!--- Washington Toyota --->
						AND V_Make='Toyota'
					</cfcase> 
					<cfcase value="132">		<!--- Northepoint CDJR --->
						AND ( V_Make='Chrysler' OR  V_Make='Dodge' OR  V_Make='Jeep' OR  V_Make='Ram')
					</cfcase> 
					<cfcase value="195">		<!--- Northepoint GM --->
						AND ( V_Make='Chevrolet' OR  V_Make='Cadillac')
					</cfcase> 
				</cfswitch>
			</cfif>
			AND			Selling_Price <> 10000000
			AND			Selling_Price <> 0
			AND			Img_Urls IS NOT NULL
			<cfif isvalid("integer",arguments.price_ceiling) eq "yes">
				AND		Selling_Price <= 0
			</cfif>
			ORDER BY 	NEWID()
		</cfquery> 
		<cfset get_vehicles.vehicle_image = #Get_Vehicles.img_urls# >
</cfif>

		
		<ul class="#arguments.carousel_class#">
			<cfloop query="Get_Vehicles">
				<cfif #Get_Vehicles.Selling_Price# EQ "10000000" or #Get_Vehicles.Selling_Price# EQ 0  or #Get_Vehicles.Selling_Price# EQ "" >
					<cfset price_msg = "Call for Price">
				<cfelse>
					<cfset price_msg = "Only $#numberformat(Get_Vehicles.Selling_Price)#">
				</cfif>
			<cfif #Get_Vehicles.img_urls# NEQ "" >
				<li class="slide #carousel_class#_slide">
					<a href="http://#lcase(cgi.server_name)#/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
						<!--- <cfif #wch# EQ 1 >
						<img class="img-responsive" src="#listgetat(Get_Vehicles.Img_Urls,1)#" border="0"/>
						<cfelse> --->
						<img class="img-responsive" src="#listgetat(Get_Vehicles.img_urls,1)#" border="0"/>
						<!--- </cfif> --->
						#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
						#price_msg#<br/>  
					</a>
					<cfif arguments.site_mode eq "legacy">
						<br/>
					</cfif>
				</li>
				</cfif>
			</cfloop>
		</ul>
		
		<cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	
	</cffunction>

	<cffunction name="carousel" description="loads bx slider icons carousel" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="carousel_class" default="carousel_icons">
		<cfargument name="minSlides" default="4">
		<cfargument name="maxSlides" default="20">
		<cfargument name="auto" default="true">
		<cfargument name="moveSlides" default="1">
		<cfargument name="slideWidth" default="200">
		<cfargument name="slideMargin" default="10">
		<cfargument name="addScript" default="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="nav_type_id" required="true">
		<cfargument name="site_mode" default="modern">

		<cfset Get_Nav=arguments.Get_Nav>

		<cfquery dbtype="query" name="Check_Nav">
			SELECT	Nav_ID
			FROM	Get_Nav
			WHERE	Nav_Type_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.nav_type_id#" maxlength="6">
		</cfquery>
		
		<cfif Check_Nav.Recordcount gt 0>
			<ul class="#arguments.carousel_class#">
	
				<cfset variables.nav_count=0>
				
				<cfloop query="Get_Nav">
	
					<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
	
						<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
							<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
						<cfelse>
							<cfif left(Get_Nav.Nav_Link,4) neq "http">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
							</cfif>
						</cfif>
						
						<cfset variables.nav_count=variables.nav_count+1>
		
						<li class="slide #carousel_class#_slide">
	
							<!---nav switches--->
							<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
								<cfcase value="1">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
									<cfelse>
										<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
											<a id="nav_#Get_Nav.nav_id#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
											</a>
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
											</a>
										</cfif>
									</cfif>
								</cfcase>
								<cfcase value="2">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
									<cfelse>
										<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
											</a>						
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
											</a>
										</cfif>
									</cfif>					
								</cfcase>
								<cfcase value="3">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<div id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
									<cfelse>
										<div id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">
											<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
										</div>
									</cfif>					
								</cfcase>
							</cfswitch>
							<cfif arguments.site_mode eq "legacy">
								<br/>
							</cfif>
						</li>
		
					</cfif>
	
				</cfloop>
			</ul>
			
		</cfif>
		
		<cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	
	</cffunction>

	<cffunction name="misc" description="loads bx slider icons carousel" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="carousel_class" default="carousel_icons">
		<cfargument name="minSlides" default="4">
		<cfargument name="maxSlides" default="20">
		<cfargument name="auto" default="true">
		<cfargument name="moveSlides" default="1">
		<cfargument name="slideWidth" default="200">
		<cfargument name="slideMargin" default="10">
		<cfargument name="addScript" default="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="nav_type_id" required="true">
		<cfargument name="site_mode" default="modern">

		<cfset Get_Nav=arguments.Get_Nav>

		<cfquery dbtype="query" name="Check_Nav">
			SELECT	Nav_ID
			FROM	Get_Nav
			WHERE	Nav_Type_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.nav_type_id#" maxlength="6">
		</cfquery>
		
		<cfif Check_Nav.Recordcount gt 0>
			<ul class="#arguments.carousel_class#">
	
				<cfset variables.nav_count=0>
				
				<cfloop query="Get_Nav">
	
					<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
	
						<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
							<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
						<cfelse>
							<cfif left(Get_Nav.Nav_Link,4) neq "http">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
							</cfif>
						</cfif>
						
						<cfset variables.nav_count=variables.nav_count+1>
		
						<li class="slide #carousel_class#_slide">
							<!---nav switches--->
							<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
								<cfcase value="1">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>
									<cfelse>
										<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
											<a id="nav_#Get_Nav.nav_id#" class="#arguments.element_class#_link nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="#arguments.element_class# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
												<span class="#arguments.element_class#_desc">#Get_Nav.Nav_Name#</span>
												<span class="#arguments.element_class#_price">#Get_Nav.Nav_Alt#</span>
											</a>
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class#_link nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
												<span class="#arguments.element_class#_desc">#Get_Nav.Nav_Name#</span>
												<span class="#arguments.element_class#_price">#Get_Nav.Nav_Alt#<span>
											</a>
										</cfif>
									</cfif>
								</cfcase>
								<cfcase value="2">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
									<cfelse>
										<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
												<span class="#arguments.element_class#_desc">#Get_Nav.Nav_Name#</span>
												<span class="#arguments.element_class#_price">#Get_Nav.Nav_Alt#</span>
											</a>						
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
												<span class="#arguments.element_class#_desc">#Get_Nav.Nav_Name#</span>
												<span class="#arguments.element_class#_price">#Get_Nav.Nav_Alt#</span>
											</a>
										</cfif>
									</cfif>					
								</cfcase>
								<cfcase value="3">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<div id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
									<cfelse>
										<div id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">
											<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
										</div>
									</cfif>					
								</cfcase>
							</cfswitch>
							<cfif arguments.site_mode eq "legacy">
								<br/>
							</cfif>
						</li>
		
					</cfif>
	
				</cfloop>
			</ul>
			
		</cfif>
		
		<cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	
	</cffunction>

</cfcomponent>