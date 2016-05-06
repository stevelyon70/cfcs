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
		<cfargument name="minSlides" default="3">
		<cfargument name="maxSlides" default="20">
		<cfargument name="auto" default="true">
		<cfargument name="moveSlides" default="1">
		<cfargument name="slideWidth" default="200">
		<cfargument name="slideMargin" default="10">
		<cfargument name="addScript" default="true">

		<cfif #arguments.new_used# EQ "U" >
			<cfset pass_type = "Used" >
		<cfelse>
			<cfset pass_type = "New" >	
		</cfif>
		
		
		<cfquery datasource="#arguments.dsn#" name="Get_Vehicles" maxrows="#arguments.maxslides#">
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
							FROM 	ultra10.dbo.Dealer_Shares 
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
					<cfcase value="68">		<!--- Mazda --->
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
			ORDER BY 	NEWID()
		</cfquery>
		 
		<ul class="#arguments.carousel_class#" style="align:center">
			<cfloop query="Get_Vehicles">
				<cfif #Get_Vehicles.Selling_Price# EQ "10000000" or #Get_Vehicles.Selling_Price# EQ 0 >
					<cfif #url.dealer_id# NEQ 55 >
						<cfset price_msg = "Call for Price">
					<cfelse>
						<cfset price_msg = "You Are Approved" >	<!--- Jim Butner 01/19/2015 bob --->
					</cfif>
				<cfelse>
					<cfset price_msg = "Only $#numberformat(Get_Vehicles.Selling_Price)#">
				</cfif>
				
				<cfif #Get_Vehicles.Img_Urls# NEQ "" >	<!--- 09-01-2015 --->
				
				<li class="slide #arguments.carousel_class#_slide" >
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
																				#url.dealer_id# NEQ 82  and 
																				#url.dealer_id# NEQ 333 >
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 333>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 311>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							<span style="color:##000000;font-size:15pt;font-weight:bold">#price_msg#</span><br/>
					<cfelseif #url.dealer_id# EQ 1>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 82>		<!--- Faulkner Mazda 11/02/2015 --->
	                                          
							<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#"  style="text-decoration:none!important;">
								<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
								<span class="bx-vehicle-detail visible-md visible-lg" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/> 
								<span class="bx-vehicle-price visible-md visible-lg" style="align:center">#price_msg#</span><br/> 
								<p style="align:center"><input class="bx-vehicle-btn visible-md visible-lg" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
							
								<span class="bx-vehicle-detail-mbl visible-sm visible-xs" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span>  
								<span class="bx-vehicle-price-mbl visible-sm visible-xs" style="align:center">#price_msg#</span>  
								<p style="align:center"><input class="bx-vehicle-btn-mbl visible-sm visible-xs" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
							</a>							
						 
						
					<cfelseif #url.dealer_id# EQ 12>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 15>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 27>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 4>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 3>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 7>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 8>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 6>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 287>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 288>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<div class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</div> 
							<div class="bx-vehicle-price" style="align:center">#price_msg#</div>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 264 or #url.dealer_id# EQ 265  >
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
							<img alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#"  class="img-responsive #arguments.carousel_class#_img " style="vertical-align:bottom;min-height:180px" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<div class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</div>
							<div class="bx-vehicle-price" style="align:center">#price_msg#</div><!--- <br/> <br> --->
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelse>
						<a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span style="color:black;font-weight:bold;text-align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span style="color:red;font-weight:bold;text-align:center">#price_msg#</span><br/> 
							<input class="blk4-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';">
						</a>	
					</cfif>
				</li>
			</cfif>	
			</cfloop>
		</ul>
	 
<!--- tried to add  async  here but it screws up the display --->		
		<cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfif #url.dealer_id# EQ 264 or  #url.dealer_id# EQ 265>	<!--- 04-02-2015 add to dealer settings --->
			<cfset arguments.auto = "false" >
		</cfif>
		
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	
	</cffunction>

	<cffunction name="v_limited" description="loads bx slider populated by random vehicles from inventory" output="yes" access="public">

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

		<cfif #arguments.new_used# EQ "U" >
			<cfset pass_type = "Used" >
		<cfelse>
			<cfset pass_type = "New" >	
		</cfif>
		
<!--- 		
		<cfquery datasource="#arguments.dsn#" name="Get_Vehicles" maxrows="#arguments.maxslides#">
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
							FROM 	ultra10.dbo.Dealer_Shares 
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
					<cfcase value="68">		<!--- Mazda --->
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
			ORDER BY 	NEWID()
		</cfquery>
 --->		 
				<cfoutput>
 
 <cfset car_pics = ArrayNew(1) >
 <cfset car_pics[1] = "chevy.jpg" >
 <cfset car_pics[2] = "image-1.jpg" >
 <cfset car_pics[3] = "image-2.jpg" >
 <cfset car_pics[4] = "image-3.jpg" >
 <cfset car_pics[5] = "image-4.jpg" >
 <cfset car_pics[6] = "image-5.jpg" >
 <cfset variables.nav_count = 6>
<div id="wowslider-container1">
	<div class="ws_images">
		 
		<ul  >
			<cfloop index="x" from="2" to="6">
				<cfimage source="http://#cgi.server_name#/dealer/kellycar/inventory/#car_pics[x]#" name="myImage"> 
<cfset ImageSetAntialiasing(myImage,"on")> 

				<cfset ImageScaleToFit(myimage,300,"")>
				<li  >
							<!--- <img  alt="#car_pics[x]#" class="img-responsive" id="wows1_#variables.nav_count-1#" src="http://#cgi.server_name#/dealer/kellycar/inventory/#myimage#"/> --->
							<cfimage source="#myImage#" action="writeToBrowser">
				</li> 
				
			</cfloop>
		</ul>
		
	</div>
</div>	
		</cfoutput>
	 
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/880/engine1/wowslider.js"></script>'>
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/880/engine1/script.js"></script>'>
			
<!--- tried to add  async  here but it screws up the display --->		
		<!--- <cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfif #url.dealer_id# EQ 264 or  #url.dealer_id# EQ 265>	<!--- 04-02-2015 add to dealer settings --->
			<cfset arguments.auto = "false" >
		</cfif>
		
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	 --->
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
					AND Vehicle_Specials.Make='Nissan'
				</cfcase> 
				<cfcase value="25,28,7">		<!--- Fayette Honda --->
					AND Vehicle_Specials.Make='Honda'
				</cfcase> 
				<cfcase value="24,82">		<!--- Faulkner Mazda --->
					AND Vehicle_Specials.Make='Mazda'
				</cfcase>   
					<cfcase value="87,168,6">		<!--- Fuccillo Ford --->
						AND Vehicle_Specials.Make='Ford'
					</cfcase>        
					<cfcase value="65">		<!--- Kia --->
						AND Vehicle_Specials.Make='Kia'
					</cfcase>         
					<cfcase value="68">		<!--- Mazda --->
						AND Vehicle_Specials.Make='Mazda'
					</cfcase>  
					<cfcase value="169">		<!--- Fuccillo Hyundai --->
						AND Vehicle_Specials.Make='Hyundai'
					</cfcase>  
					<!--- <cfcase value="170">		<!--- Fuccillo Hyundai --->
						AND Vehicle_Specials.Make='Hyundai'
					</cfcase>   --->
				<cfcase value="37,73,46,74">		<!--- Washington Toyota --->
					AND Vehicle_Specials.Make='Toyota'
				</cfcase>  
				<cfcase value="30, 12">		<!--- Ron Hibbard Toyota --->
					AND Vehicle_Specials.Make='Toyota'
				</cfcase> 
				<cfcase value="132">		<!--- Northepoint CDJR --->
					AND ( Vehicle_Specials.Make='Chrysler' OR  Vehicle_Specials.Make='Dodge' OR  Vehicle_Specials.Make='Jeep' OR  Vehicle_Specials.Make='Ram')
				</cfcase> 
				<cfcase value="195">		<!--- Northepoint GM --->
					AND ( Vehicle_Specials.Make='Chevrolet' OR  Vehicle_Specials.Make='Cadillac')
				</cfcase> 
			</cfswitch>
			AND			Vehicle_Specials.Vehicle_Image IS NOT NULL
			AND			Vehicle_Specials.Special_Type='Specific'
			ORDER BY	Vehicle_Specials.Hierarchy
		</cfquery>
   

  	<cfif  #Get_Vehicles.recordcount# LTE 4 >
		<cfquery datasource="ultra10" name="Get_Vehicles">
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
							FROM 	ultra10.dbo.Dealer_Shares 
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
					<cfcase value="65">		<!--- Kia --->
						AND V_Make='Kia'
					</cfcase>         
					<cfcase value="68">		<!--- Mazda --->
						AND V_Make='Mazda'
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
						<img class="img-responsive" src="#listgetat(Get_Vehicles.Img_Urls,1)#" />
						<cfelse> --->
						<img alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#"  class="img-responsive" src="#listgetat(Get_Vehicles.img_urls,1)#" />
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
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" async  src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
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
		<cfargument name="glyph_left" default="false">

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
												<img alt="#Get_Nav.Nav_Alt#"  class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
											</a>
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img  alt="#Get_Nav.Nav_Alt#" class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
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
												<img alt="#Get_Nav.Nav_Alt#"  class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
											</a>						
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img  alt="#Get_Nav.Nav_Alt#" class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
											</a>
										</cfif>
									</cfif>					
								</cfcase>
								<cfcase value="3">
									<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
										<div id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
									<cfelse>
										<div id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">
											<img  alt="#Get_Nav.Nav_Alt#" class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
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
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript"   src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
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
												<img alt="#Get_Nav.Nav_Alt#"  class="#arguments.element_class# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
												<span class="#arguments.element_class#_desc">#Get_Nav.Nav_Name#</span>
												<span class="#arguments.element_class#_price">#Get_Nav.Nav_Alt#</span>
											</a>
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class#_link nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
												<img  alt="#Get_Nav.Nav_Alt#" class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
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
												<img  alt="#Get_Nav.Nav_Alt#" class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
												<span class="#arguments.element_class#_desc">#Get_Nav.Nav_Name#</span>
												<span class="#arguments.element_class#_price">#Get_Nav.Nav_Alt#</span>
											</a>						
										<cfelse>
											<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
												<img alt="#Get_Nav.Nav_Alt#"  class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
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
											<img alt="#Get_Nav.Nav_Alt#" class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
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
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript"   src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	
	</cffunction>


	<cffunction name="no_slide" description="loads bx slider populated by random vehicles from inventory" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="new_used" default="U">
		<cfargument name="certified" default="0">
		<cfargument name="price_ceiling" default="">
		<cfargument name="results" default="12">
		<cfargument name="carousel_class" default="carousel_v_rand">
		<cfargument name="minSlides" default="4">
		<cfargument name="maxSlides" default="4">
		<cfargument name="auto" default="true">
		<cfargument name="moveSlides" default="1">
		<cfargument name="slideWidth" default="200">
		<cfargument name="slideMargin" default="10">
		<cfargument name="addScript" default="true">

		<cfif #arguments.new_used# EQ "U" >
			<cfset pass_type = "Used" >
		<cfelse>
			<cfset pass_type = "New" >	
		</cfif>
        
		<!--- 
		chanaged the query to pull top 12 specials then top 12 vehicles from inventory
		
		ranks them by specials first then pulls the top 12 overall and uses that for the box slider
		
		10/16/15 slyon
		--->
		<cfquery datasource="#arguments.dsn#" name="Get_Vehicles" result="r1">
		select top 4 * from 
			(SELECT top 4 
			   [Vehicle_Year] as v_year
			  ,[Make] as v_make
			  ,[Model] as v_model
			  , '' as v_trim
			  ,[Is_Price] as Selling_Price
			  ,[Vehicle_Image] as Img_Urls
			  ,[Vin]
			  ,[Stock]
			  ,[Model_Number] as v_model_number
			  ,'' as permalink   
			  ,0 as rank
			  ,'special' as type
		  FROM [Ultra10].[dbo].[Vehicle_Specials]
		  where 0=0
			  and Dealer_ID IN 
						(	SELECT 	Share_ID 
							FROM 	ultra10.dbo.Dealer_Shares 
							WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
							AND 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">)
			AND			special_class_id =  2
			  and Special_Type = 'specific'
			  and [Start_Date] <= getdate()
			  and ([Expiration_date] >= getdate()    or Expiration_date is null) 
		  order by newid()
		  
		  union 
		  
		  select top 4 V_Year,	V_Make,	V_Model,V_Trim,	Selling_Price,Img_Urls,	Vin,Stock,V_Model_Number,Permalink,	1 as rank,'inventory' as type
		  from Vehicles
		  where dealer_id IN 
						(	SELECT 	Share_ID 
							FROM 	ultra10.dbo.Dealer_Shares 
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
					<cfcase value="68">		<!--- Mazda --->
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
		  
		  )as cars
		  order by  rank
		</cfquery>
		<ul class="#arguments.carousel_class#" style="align:center">
        
			<cfloop query="Get_Vehicles">
				<cfif #Get_Vehicles.Selling_Price# EQ "10000000" or #Get_Vehicles.Selling_Price# EQ 0 >
					<cfif #url.dealer_id# NEQ 55 >
						<cfset price_msg = "Call for Price">
					<cfelse>
						<cfset price_msg = "You Are Approved" >	<!--- Jim Butner 01/19/2015 bob --->
					</cfif>
				<cfelse>
					<cfset price_msg = "Only $#numberformat(Get_Vehicles.Selling_Price)#">
				</cfif>
				
				<cfif #Get_Vehicles.Img_Urls# NEQ "" >	<!--- 09-01-2015 --->
				
				<li class="slide #arguments.carousel_class#_slide" >
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
																				#url.dealer_id# NEQ 333>
					<cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                        <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
                    </cfif>
							

                            <cftry><!-- just you #now()#  -->
                            <cfset myImage=ImageNew(listgetat(Get_Vehicles.Img_Urls,1))> 
							<cfset ImageResize(myImage,"","185","highestPerformance")> 
                            <cfimage                          
                                action = "writeToBrowser" 
                                source = "#myImage#"
                                format="jpg" 
                                border="0" class="img-responsive #arguments.carousel_class#_img" alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#">
                           <cfcatch>
                                <img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
                            </cfcatch>
                            </cftry>
                            
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 333>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                        <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							#price_msg#<br/>
					<cfelseif #url.dealer_id# EQ 311>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                        <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
						</a>
							#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#<br/>
							<span style="color:##000000;font-size:15pt;font-weight:bold">#price_msg#</span><br/>
					<cfelseif #url.dealer_id# EQ 1>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/><br />
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 12>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 15>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 27>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 4>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 3>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 7>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> 
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 8>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 6>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 287>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
                    </cfif>
						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span class="bx-vehicle-price" style="align:center">#price_msg#</span><br/> <br>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 288>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<div class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</div> 
							<div class="bx-vehicle-price" style="align:center">#price_msg#</div>
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelseif #url.dealer_id# EQ 264 or #url.dealer_id# EQ 265  >
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#pass_type#">
                    </cfif>
						
							<img alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#"  class="img-responsive #arguments.carousel_class#_img " style="vertical-align:bottom;min-height:180px" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<div class="bx-vehicle-detail" style="align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</div>
							<div class="bx-vehicle-price" style="align:center">#price_msg#</div><!--- <br/> <br> --->
							<p style="align:center"><input class="bx-vehicle-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';"></p>
						</a>	
					<cfelse>
                    <cfif Get_Vehicles.type is 'special'>
                        <a href="/vehicles/vehicle_details.cfm?vin=#Get_Vehicles.vin#">
                    <cfelse>                        
                       <a href="http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#">
                    </cfif>
						
							<img  alt="#Get_Vehicles.V_Make# #Get_Vehicles.V_Model#" class="img-responsive #arguments.carousel_class#_img" src="#listgetat(Get_Vehicles.Img_Urls,1)#"/>
							<span style="color:black;font-weight:bold;text-align:center">#Get_Vehicles.V_Year# #Get_Vehicles.V_Make# #Get_Vehicles.V_Model#</span><br/>
							<span style="color:red;font-weight:bold;text-align:center">#price_msg#</span><br/> 
							<input class="blk4-btn" name="Button_Go" type="submit" value="Get Details" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#';">
						</a>	
					</cfif>
				</li>
			</cfif>	
			</cfloop>
		</ul>
	 
<!--- tried to add  async  here but it screws up the display --->		
		<!--- <cfif arguments.addScript eq "true">
			<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
		</cfif>
		<cfif #url.dealer_id# EQ 264 or  #url.dealer_id# EQ 265>	<!--- 04-02-2015 add to dealer settings --->
			<cfset arguments.auto = "false" >
		</cfif>
		
		<cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
	 --->
	</cffunction>

	
	
	
	
	
	
	
</cfcomponent>
