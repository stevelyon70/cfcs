<cfcomponent>
	
	
	<cffunction name="v_rand_two" description="loads bx slider populated by random vehicles from inventory" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="new_used" default="N">
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
		
	 	<!--- Clicks Tracker 02/29/2016 --->
		<cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfset click_tracker = #t_clik.track_clicks# >
		
		<cfif #arguments.new_used# EQ "U" >
			<cfset pass_type = "Used" >
		<cfelse>
			<cfset pass_type = "New" >	
		</cfif>
        <cfif cgi.remote_addr eq '172.16.25.102'><script>console.log(#url.dealer_id#);</script></cfif>
		<!--- 
		chanaged the query to pull top 12 specials then top 12 vehicles from inventory
		
		ranks them by specials first then pulls the top 12 overall and uses that for the box slider
		
		10/16/15 slyon
		--->
        <cfif url.dealer_id neq 264 and url.dealer_id neq 265 and url.dealer_id neq 76><!------>
	        <cfset arguments.results = arguments.minSlides>
		</cfif>
        <cfquery datasource="#arguments.dsn#" name="Get_Vehicles_2">
		SELECT top #arguments.results#    vs.Vehicle_Year as v_year,vs.Make as v_make,vs.Model as v_model, '' as v_trim,vs.Is_Price as Selling_Price, v.Img_Urls,vs.Vin,vs.Stock,vs.Model_Number as v_model_number,'' as permalink,0 as rank,'special' as type, vs.dealer_id
		  FROM [dbo].[Vehicle_Specials] AS vs, vehicles as V
		  where 0=0
          		and vs.vin = v.vin
			  and vs.Dealer_ID IN 
						(	SELECT 	Share_ID 
							FROM 	ultra10.dbo.Dealer_Shares 
							WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
							AND 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">)
			  AND vs.special_class_id =  2
			  and vs.Special_Type = 'specific'
			  and vs.Start_Date <= getdate()
			  and (vs.Expiration_date >= getdate()    or vs.Expiration_date is null)              
               <cfif arguments.dealer_id eq 88>
              and (vs.Is_Price > 0 and not vs.Is_Price = '' and vs.Is_Price < 1000000)
              </cfif>
              <cfswitch expression="#arguments.dealer_id#">
					<cfcase value="52,54,18,365">   <!--- Pittsburgh East & West Hills Nissan & Kelly Nissan --->
						AND vs.Make='Nissan'
					</cfcase> 
					<cfcase value="25,28,151,7,27">		<!--- Honda --->
						AND vs.Make='Honda'
					</cfcase>  
					<cfcase value="24,82">		<!---  Mazda --->
						AND vs.Make='Mazda'
					</cfcase>   
					<cfcase value="87,168,6">		<!---  Ford --->
						AND vs.Make='Ford'
					</cfcase>    
					<cfcase value="169">		<!--- Hyundai --->
						AND vs.Make='Hyundai'
					</cfcase>     
					<cfcase value="170">		<!--- Hyundai --->
						AND vs.Make='Hyundai'
					</cfcase>       
					<cfcase value="65">		<!--- Kia --->
						AND vs.Make='Kia'
					</cfcase>         
					<cfcase value="68,375">		<!--- Mazda --->
						AND vs.Make='Mazda'
					</cfcase>   
					<cfcase value="89">		<!---  Mitsubishi --->
						AND vs.Make='Mitsubishi'
					</cfcase>    
					<cfcase value="8,171,172,180,181,303">		<!--- Kia --->
						AND vs.Make='Kia'
					</cfcase>  
					<cfcase value="37,73,46,74">		<!--- Washington Toyota Fuccillo Toyota --->
						AND			(vs.Make = 'Toyota' or vs.MAKE = 'Scion')
					</cfcase>  
					<cfcase value="30,12">		<!--- Ron Hibbard Toyota Baierl Toyota --->
						AND			vs.Make = 'Toyota'
					</cfcase> 
					<cfcase value="132">		<!--- Northepoint CDJR --->
						AND ( vs.Make='Chrysler' OR  vs.Make='Dodge' OR  vs.Make='Jeep' OR  vs.Make='Ram')
					</cfcase> 
					<cfcase value="195">		<!--- Northepoint GM --->
						AND ( vs.Make='Chevrolet' OR  vs.Make='Cadillac')
					</cfcase> 
				</cfswitch>
              
              
              
         order by newid()<!---<cfif cgi.remote_addr neq '172.16.25.102'>ROW_NUMBER() over (partition by vs.dealer_id order by vs.dealer_id), vs.dealer_id </cfif><cfif cgi.remote_addr eq '172.16.25.102'></cfif>--->		  
		</cfquery>
        <cfif cgi.remote_addr eq '172.16.25.102'><script>console.log(#Get_Vehicles_2.recordcount# +'-resutls'+ #arguments.results#);</script></cfif>
        <cfset request.hasSpecials = 0>        
        <cfif Get_Vehicles_2.recordcount>
	        <cfset request.hasSpecials = 1>
        </cfif>
		

        <cfif Get_Vehicles_2.recordcount lt arguments.results>        
        <!--- 
			*******************
			
			if not 12 specials then need to get 12-# of specials from inventory and then insert those into Get_Vehicles_2 query
			
			
			******************			
		--->
        <cfset _leftover = (arguments.results-Get_Vehicles_2.recordcount)>
        <cfif cgi.remote_addr eq '172.16.25.102'><script>console.log(#_leftover#);</script></cfif>
        <cfquery datasource="#arguments.dsn#" name="Get_Vehicles_2INV">		  
		  select top #_leftover# V_Year,	V_Make,	V_Model,V_Trim,	Selling_Price,Img_Urls,	Vin,Stock,V_Model_Number,Permalink,	1 as rank,'inventory' as type, dealer_id
		  from Vehicles
		  where dealer_id IN 
						(	SELECT 	Share_ID 
							FROM 	dbo.Dealer_Shares 
							WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
							AND 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">)
			AND			V_New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			<cfif arguments.Certified neq 0>
				AND		Certified = 1
			</cfif>
				<cfswitch expression="#arguments.dealer_id#">
					<cfcase value="52,54,18,365">   <!--- Pittsburgh East & West Hills Nissan & Kelly Nissan --->
						AND V_Make='Nissan'
					</cfcase> 
					<cfcase value="25,28,151,7,27">		<!--- Honda --->
						AND V_Make='Honda'
					</cfcase>  
					<cfcase value="24,82">		<!---  Mazda --->
						AND V_Make='Mazda'
					</cfcase>   
					<cfcase value="87,168,6">		<!---  Ford --->
						AND V_Make='Ford'
					</cfcase>    
					<cfcase value="169">		<!--- Hyundai --->
						AND V_Make='Hyundai'
					</cfcase>     
					<cfcase value="170">		<!--- Hyundai --->
						AND V_Make='Hyundai'
					</cfcase>       
					<cfcase value="65">		<!--- Kia --->
						AND V_Make='Kia'
					</cfcase>         
					<cfcase value="68,375">		<!--- Mazda --->
						AND V_Make='Mazda'
					</cfcase>   
					<cfcase value="89">		<!---  Mitsubishi --->
						AND V_Make='Mitsubishi'
					</cfcase>    
					<cfcase value="8,171,172,180,181,303">		<!--- Kia --->
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
             <cfif arguments.dealer_id eq 88>
              and (Selling_Price > 0 and not Selling_Price = '' and Selling_Price < 1000000)
              </cfif>
			 <cfif #url.dealer_id# eq 62 >						<!--- Preston Superstore 03/16/2015 Bob --->
				AND			Selling_Price < 10000
				AND			Selling_Price <> 0
			</cfif> 
			 <cfif #url.dealer_id# eq 288 >						<!--- AutoBuySmart 04/29/2015 Bob --->
				AND			Selling_Price < 15000
				AND			Selling_Price <> 0
			</cfif> 
			AND			Img_Urls IS NOT NULL
			<cfif isvalid("integer",arguments.price_ceiling) eq "yes">
				AND		Selling_Price <= 0
			</cfif>
		</cfquery>
        
        <cfloop query="Get_Vehicles_2INV">
        
        <cfset tmp = queryAddRow(Get_Vehicles_2, {V_Year = "#Get_Vehicles_2INV.V_Year#", V_Make = "#Get_Vehicles_2INV.V_Make#", V_Model = "#Get_Vehicles_2INV.V_Model#",V_Trim = "#Get_Vehicles_2INV.V_Trim#", Selling_Price = "#Get_Vehicles_2INV.Selling_Price#",Img_Urls = "#Get_Vehicles_2INV.Img_Urls#",Vin = "#Get_Vehicles_2INV.Vin#",Stock = "#Get_Vehicles_2INV.Stock#",V_Model_Number = "#Get_Vehicles_2INV.V_Model_Number#",Permalink = "#Get_Vehicles_2INV.Permalink#",rank = "#Get_Vehicles_2INV.rank#",type = "#Get_Vehicles_2INV.type#", dealer_id = "#Get_Vehicles_2INV.dealer_id#"})>
        
        </cfloop>
        </cfif>

		<ul class="#arguments.carousel_class#" style="align:center">
       
			<cfloop query="Get_Vehicles_2">
				<cfif #Get_Vehicles_2.Selling_Price# EQ "10000000" or #Get_Vehicles_2.Selling_Price# EQ 0 or len(Get_Vehicles_2.selling_price) eq 0>
					<cfif #url.dealer_id# NEQ 55 >
						<cfset price_msg = "Call for Price">
					<cfelse>
						<cfset price_msg = "You Are Approved" >	<!--- Jim Butner 01/19/2015 bob --->
					</cfif>
				<cfelse>
					<cfset price_msg = "Only $#numberformat(Get_Vehicles_2.Selling_Price)#">
				</cfif>
				
				<cfif #Get_Vehicles_2.Img_Urls# NEQ "" >	<!--- 09-01-2015 --->
				
                <cfif url.dealer_id eq 264 or url.dealer_id eq 265 or url.dealer_id eq 76><!--- style="float: left;list-style: none;position: relative;width: 250px;margin-right: 35px;"--->
	                <li class="slide #arguments.carousel_class#_slide">
                <cfelse>
    	            <li class="col-md-#int(12/arguments.minSlides)#" style="list-style: none;" >
                </cfif>                
		
					<cfif #url.dealer_id# NEQ 30 and 
							#url.dealer_id# NEQ 62 and 
								#url.dealer_id# NEQ 1 and 
									#url.dealer_id# NEQ 12  and 
										#url.dealer_id# NEQ 4   and 
											#url.dealer_id# NEQ 3 and 
												#url.dealer_id# NEQ 7  and 
													#url.dealer_id# NEQ 8   and 
														#url.dealer_id# NEQ 27   and 
															#url.dealer_id# NEQ 6   and 
																#url.dealer_id# NEQ 15  and 
																	#url.dealer_id# NEQ 264 and 
																		#url.dealer_id# NEQ 265 and 
																			#url.dealer_id# NEQ 287 and
																			#url.dealer_id# NEQ 311 and 
																				#url.dealer_id# NEQ 288  and 
																				#url.dealer_id# NEQ 333  and 
																				#url.dealer_id# NEQ 369 and 
																				#url.dealer_id# NEQ 365 and 
																				#url.dealer_id# neq 366 and 
																				#url.dealer_id# neq 76>
					<cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#" >
                    <cfelse>                        
                        <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#?itype=#pass_type#">
                    </cfif>                          
                          <cftry>
                            <cfset myImage=ImageNew(listgetat(Get_Vehicles_2.Img_Urls,1))> 
							<cfset ImageResize(myImage,"","185","highestPerformance")> 
                            <cfimage                          
                                action = "writeToBrowser" 
                                source = "#myImage#"
                                format="jpg" 
                                border="0" class="img-responsive #arguments.carousel_class#_img" alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#">
                           <cfcatch>
                                <img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>                                
                            </cfcatch>
                            </cftry>                     
                            
						</a>
							#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 333>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                        <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#?itype=#pass_type#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 311>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                        <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#<br/>
							<span style="color:##000000;font-size:15pt;font-weight:bold">#price_msg#</span><br/>
					<cfelseif #url.dealer_id# EQ 1>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 369>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 365>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img bx-image-detl" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 366>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img bx-image-detl" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Info" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 12>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 366>
	                    <cfif Get_Vehicles_2.type is 'special'>
    	                    <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
        	            <cfelse>                        
            	           <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                	    </cfif>
						<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
						<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
						<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
						<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 15>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 27>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 4>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 3>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 7>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 8>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 6>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 287>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#?itype=#pass_type#">
                    </cfif>
						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 288>
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>    
                           
                            
							<div class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</div> 
							<div class="bx-vehicle-price" style="align:center">#price_msg#</div>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 264 or #url.dealer_id# EQ 265  or url.dealer_id eq 76 >
                    <cfif Get_Vehicles_2.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#?itype=#pass_type#">
                    </cfif>
						
							<img alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#"  class="img-responsive #arguments.carousel_class#_img " style="vertical-align:bottom;" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/><!---min-height:180px--->
							<div class="bx-vehicle-detail" style="align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</div>
							<div class="bx-vehicle-price" style="align:center">#price_msg#</div><!--- <br/> <br> --->
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';"></p>
						</a>	
					<cfelse>
                    <cfif Get_Vehicles_2.type is 'special'>
						<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings --->
							<a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=3&spec=1&vin=#Get_Vehicles_2.vin#">
						<cfelse>
			                <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_2.vin#">
						</cfif>	
                    <cfelse> 
						<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings ---> 
							<cfset tmp_link = "" >
							<cfset tmp_link="#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
						    <a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=3&vin=#Get_Vehicles_2.Vin#&v_link=#tmp_link#">
						<cfelse>
	                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#">
						</cfif>	
					
					</cfif>
						
							<img  alt="#Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles_2.Img_Urls,1)#"/>
							<span style="color:black;font-weight:bold;text-align:center">#Get_Vehicles_2.V_Year# #Get_Vehicles_2.V_Make# #Get_Vehicles_2.V_Model#</span><br/>
							<span style="color:red;font-weight:bold;text-align:center">#price_msg#</span><br/> 
							<input class="blk4-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles_2.V_Make)#/#lcase(Get_Vehicles_2.V_Model)#/#lcase(Get_Vehicles_2.Permalink)#';">
						</a>	
					</cfif>
				</li>
			</cfif>	
			</cfloop>
            
		</ul>
            <cfif url.dealer_id eq 264  or url.dealer_id eq 165 or url.dealer_id eq 76>
            <cfelse>
            <cfparam default="0"  name="request.script_defer">
			<script>
            <cfsavecontent variable="request.bxslider_vrand_two">
				<cfif request.hasSpecials>
				$('##bxslider_view_more_btn').attr("href", "/new/special_offers.cfm");
				<cfelse>
				$('##bxslider_view_more_btn').attr("href", "/new/");
				</cfif>
             </cfsavecontent>
				<cfif request.script_defer neq 1>
                 	#request.bxslider_vrand_two#
                <cfelse>
                <cfset url.Dom_Functions = url.Dom_Functions & request.bxslider_vrand_two> 
                </cfif>  
			</script>
            </cfif>
<!--- tried to add  async  here but it screws up the display --->	
		
		<cfparam name="url.timecheck" default=1> 
		<cfif arguments.addScript eq "true">
        	<cfif url.timecheck eq 1>
            <cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider412/jquery.bxslider.min.js"></script>'>
            <cfelse>            
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
            </cfif>
		</cfif><!------>
		<cfif #url.dealer_id# EQ 264 or  #url.dealer_id# EQ 265 or url.dealer_id eq 76>	<!--- 04-02-2015 add to dealer settings --->
			<cfset arguments.auto = "false" >
		</cfif>
		
		<cfif url.dealer_id eq 264 or url.dealer_id eq 265 or url.dealer_id eq 76>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
        </cfif>
	 
	</cffunction>

</cfcomponent>