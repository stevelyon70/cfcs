<cfcomponent>

	<cffunction name="modern_standard" description="create standard srp page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<cfparam name="url.year" default="">
		<cfparam name="url.new_used" default="">
		<cfparam name="url.make" default="">
		<cfparam name="url.model" default="">
		<cfparam name="url.maxprice" default="11000000">
		<cfparam name="url.minprice" default="-1">
		<cfparam name="url.sortblock" default="1">
		<cfparam name="url.luxury" default="">
		<cfparam name="url.fleet" default="">
		<cfparam name="url.commercial" default="">
		<cfparam name="url.certified" default="">
		<cfparam name="url.body" default="">
		<cfparam name="url.drivetrain" default="">
		<cfparam name="url.style" default="">
		<cfparam name="url.transmission" default="">
		<cfparam name="url.color" default="">
		<cfparam name="url.zip" default="">
		<cfparam name="url.geo" default="">
		<cfparam name="url.radius" default="">
		
	  	<cfparam name="url.classic" default="">  
		
		<cfparam name="url.form_action" default="0">

		<!---dealer specific parameters--->
		<cfparam name="url.v_disclaimer" default="">

		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">

		<!--- Classic Cars --->
		    <cfif IsDefined("url.classic") AND #url.classic# NEQ "" >
			<cfset url.classic=#url.classic#>
			<!--- <cfset url.new_used="z">  --->
			<cfelse>
			<cfset url.classic="">
		</cfif>  
		
		<!--- SEARCH BAR 03/16/2016 --->
		<cfset variables.srch_err_phrase = "" >
		<cfif IsDefined("url.err_disp") >
			<cfset variables.srch_err_phrase = "Vehicles Found for"  >
			<cfset variables.srch_err_criteria = "#url.err_disp#" >
		</cfif>
		
		<!--- sortblock kung fu ---> 
		<cfswitch expression="#url.sortblock#">
			<cfcase value="9">
				<cfset url.luxury=1>
			</cfcase>
			<cfcase value="10">
				<cfset url.fleet=1>
			</cfcase>
			<cfcase value="11">
				<cfset url.commercial=1>
			</cfcase>
		</cfswitch>

		<cfif IsDefined("url.geo") and ( #url.geo# NEQ "" and #url.geo#  NEQ 0 ) >  <!--- Regional Search 12/13/2014--->
			<cfset url.geo=url.geo>
		<cfelse>	
			<cfset url.geo="0">
		</cfif>	
		
		
		<cfif IsDefined("url.ft") >  <!--- Free-text price entry 10/31/2014--->
			<cfset url.maxprice=url.maxprice>
			<cfset url.minprice=url.minprice>
		<cfelse>		
			<!---maxprice kung fu--->
			<cfswitch expression="#url.maxprice#">
				<cfcase value="1000,2000,3000,4000,5000,6000,7000,8000,9000,10000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="11000,12000,13000,14000,15000,16000,17000,18000,19000,20000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="21000,22000,23000,24000,25000,26000,27000,28000,29000,30000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="31000,32000,33000,34000,35000,36000,37000,38000,39000,40000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="41000,42000,43000,44000,45000,46000,47000,48000,49000,50000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="51000,52000,53000,54000,55000,56000,57000,58000,59000,60000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="61000,62000,63000,64000,65000,66000,67000,68000,69000,70000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="71000,72000,73000,74000,75000,76000,77000,78000,79000,80000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="81000,82000,83000,84000,85000,86000,87000,88000,89000,90000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="91000,92000,93000,94000,95000,96000,97000,98000,99000,100000">
					<cfset url.maxprice=url.maxprice>
				</cfcase>
				<cfcase value="110000,120000,130000,140000,150000,160000,170000,180000,190000,200000">
					<cfset url.maxprice=url.maxprice>
				</cfcase> 
				<cfdefaultcase>
					<cfset url.maxprice=11000000>
				</cfdefaultcase>
			</cfswitch>
			<!---minprice kung fu--->
			<cfswitch expression="#url.minprice#">
				<cfcase value="3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,12000,15000,20000,25000,30000,35000,40000,45000,50000,75000,100000">
					<cfset url.minprice=url.minprice>
				</cfcase>
				<cfdefaultcase>
					<cfset url.minprice=-1>
				</cfdefaultcase>
			</cfswitch>
		</cfif>
		
		
		<!---Get Vehicles--->
		<cfif IsDefined("url.lookup_vins")>  <!--- from Collections search --->
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_srchbox" returnvariable="Get_Vehicles">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
	
			<!---Get Dropdown/Filter Data--->
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_years" returnvariable="Get_Years">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_makes" returnvariable="Get_Makes">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_models" returnvariable="Get_Models">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_geo" returnvariable="Get_Geo">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			
		<cfelse>
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_default" returnvariable="Get_Vehicles">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>	
	
			<!---Get Dropdown/Filter Data--->
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_years" returnvariable="Get_Years">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_makes" returnvariable="Get_Makes">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_models" returnvariable="Get_Models">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>
			
			<cfinvoke component="/cfcs/vehicles/lookups" method="srp_geo" returnvariable="Get_Geo">
				<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			</cfinvoke>

		</cfif>
		
		
		<cfquery dbtype="query" name="Get_Dealers">
			SELECT Distinct Dealer_ID,
							Dealer_Display_Name
			FROM			Get_Vehicles
			WHERE			Dealer_Display_Name is not null
			ORDER BY		Dealer_Display_Name
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
		<cfquery dbtype="query" name="Get_Interior_Colors">
			SELECT Distinct interior_Color
			FROM			Get_Vehicles
			WHERE			interior_Color is not null
			ORDER BY		interior_Color
		</cfquery>
		<cfquery dbtype="query" name="Get_Regions">
			SELECT Distinct Region_ID
			FROM			Get_Geo
			WHERE			Region_ID is not null
			ORDER BY		Region_ID
		</cfquery>
		<cfquery dbtype="query" name="Get_Styles">
			SELECT Distinct V_Style
			FROM			Get_Vehicles
			WHERE			V_Style is not null and V_Style != ''
			ORDER BY		V_Style
		</cfquery>


		<cfparam name="url.page" default="1">
		<cfparam name="url.result_set" default="10">
		<cfif isvalid("integer",url.result_set) eq "No"><cfset url.result_set=10></cfif>
		<cfif url.result_set gt 100>
			<cfset url.result_set=100>
		</cfif>
		<cfif isvalid("integer",url.page) eq "No"><cfset url.page=1></cfif>
		<cfif url.page lte 0><cfset url.page=1></cfif>

		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<!--- Setup paging --->
		<cfset variables.pageSize = url.result_set><!--- cars per page --->
		<!---<cfset variables.pageSize = 10>--->
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

		
<!--- Check SRP Style --->
		<cfset srp_style = 0 ><cfset srp_filter_style = "" ><cfset srp_searchbar_desk = 0 >
		<cfquery datasource="ultra10" name="chk_srp_style">
			SELECT		srp_type,srp_filter_type,srp_searchbar_desk
			FROM		Dealers
			WHERE		dealer_id = #url.dealer_id#
			AND 		srp_type = 1
		</cfquery>
		<cfif #chk_srp_style.recordcount# NEQ 0 ><cfset srp_style = 1 ><cfif #chk_srp_style.srp_filter_type# EQ 1><cfset srp_filter_style = "_v2" ></cfif>	</cfif>		 
		<cfquery datasource="ultra10" name="chk_srp_sb">SELECT		srp_searchbar_desk	FROM	Dealers	WHERE dealer_id = #url.dealer_id#</cfquery>
		<cfset srp_searchbar_desk = #chk_srp_sb.srp_searchbar_desk# >	
		<cfif #url.dealer_id# EQ 365 AND #cgi.server_name# EQ "4ultra10.wddemos.com" ><cfset srp_filter_style = "_v2" ></cfif>	 

<!--- Check SRP/VDP SEARCH BAR Style 03/16/2016 --->
		<cfset srp_srchbar = 0 ><cfset vdp_srchbar = 0 ><cfset srp_noresult = "USED" >
		<cfquery datasource="ultra10" name="chk_srp_srch">SELECT srp_search_location,vdp_search_location,zero_result_dest FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfset srp_srchbar = #chk_srp_srch.srp_search_location# ><cfset vdp_srchbar = #chk_srp_srch.vdp_search_location# >
		<cfif #chk_srp_srch.zero_result_dest# EQ 1><cfset srp_noresult = "NEW" ><cfelse><cfset srp_noresult = "USED" ></cfif>
		<cfif url.dealer_id eq 171>
        	<!-- Segment Pixel - SY - Fuccillo Auto World - Sales - Site - DO NOT MODIFY --> 
            <img src="http://ib.adnxs.com/seg?add=5029805&t=2" width="1" height="1" /> 
            <!-- End of Segment Pixel --> 
        </cfif>
		<section class="section-srp">
			<div class="container srp-container">
			<!--- Gradient Navbar for Template = Vulcan --->	
			<cfif #url.dealer_id# eq 36 or #url.dealer_id# eq 84 >
				<!--- Page Break Bar --->
			    <div class="row">
					<div class="col-md-12 pad-top-5  visible-lg visible-md">
						<div class="gradient" ></div>		
					</div>
				</div>	 
			</cfif>
			 
			
		 	<cfif #url.dealer_id# eq 54  or #url.dealer_id# eq 52 >   
				<section class="section-spl">
					<div class="container" >
						<div class="row ">
							<div class="col-md-12 pad-top-10  " align="center">
							 <cfif #url.dealer_id# eq 54 > 
								<!--- <a href="http://pittsburgheastnissan.com/dealer/pittsburgheastnissan/daily_offers.cfm"><img class="img-responsive" src="http://images.automarksolutions.com/autopics/i/2098/dd_banner.png" border="0" ALT="Daily Deals"></a><BR>
									<!---<div style="text-align: center;">
									<script type="text/javascript"  src="http://automarksolutions.com/plugin/DPF/check/?did=2098&pid=0&im=450"></script>
									<script type="text/javascript"  src="http://automarksolutions.com/plugin/TRI/check/?did=2098&im=450"></script>
									</div>--->
                                    <a href="http://pittsburgheastnissan.com/forms/trade.cfm">
                                    	<img src="http://images.automarksolutions.com/autopics/i/2098/450_tri.png" border="0" ALT="Trade In Tool">
                                    </a> --->


							  <cfelse>				
								<!---<a href="http://westhillsnissan.com/dealer/westhillsnissan/daily_offers.cfm"><img class="img-responsive" src="http://images.automarksolutions.com/autopics/i/2099/dd_banner.png" border="0" ALT="Daily Deals"></a><BR>--->
									<div style="text-align: center; ">
									<script type="text/javascript" src="http://automarksolutions.com/plugin/DPF/check/?did=2099&pid=0&im=450"></script>
									<a href="http://westhillsnissan.com/dealer/westhillsnissan/value_your_trade.cfm"><img src="http://images.automarksolutions.com/autopics/i/2129/450_tri.png" border="0" ALT="Trade In"></a>
									</div>
							</cfif>  
							</div>
						</div>	
						<div class="row">&nbsp;</div>
					</div>	
				</section>
			</cfif> 
            <cfswitch expression="#url.dealer_id#" >
            	<cfcase value="33,34">
                	<cfset request.mmd_dealer_id = 752>
                </cfcase>
                <cfcase value="288">
                	<cfset request.mmd_dealer_id = 971>
                </cfcase>
                <cfcase value="52">
                	<cfset request.mmd_dealer_id = 1213>
                </cfcase>
                <cfcase value="54">
                	<cfset request.mmd_dealer_id = 1227>
                </cfcase>
            </cfswitch>
			<cfif url.dealer_id eq 33
				or url.dealer_id eq 34
				or url.dealer_id eq 288
				or url.dealer_id eq 52
				or url.dealer_id eq 54>
            	<script>
					var mmd_srp_listings = [];			
				</script>
                <script id="mmd-srp-script" 
                    src="https://widget.makemydeal.com/srp.js" 
                    data-dealer-id="#request.mmd_dealer_id#" 
                    data-sponsor="worlddealer" 
                    data-version="2.0.0">
                </script>

            </cfif>

<!--- Check for Custom SEO Text --->
		<cfset pg_nbr = 0 ><cfset go_srp_custom = 0 >
		<cfif #url.new_used# eq "U"><cfset pg_nbr = 91 ><cfelseif #url.new_used# eq "N"><cfset pg_nbr = 92 ><cfelseif #url.new_used# eq "C"><cfset pg_nbr = 93 ></cfif>
		<cfif #url.dealer_id# NEQ 288 AND #url.dealer_id# NEQ 365 >
			<cfquery name="chk_txt" datasource="Ultra10">SELECT id, page_type FROM Variable_Template_Dealer_Content where dealer_id=#url.dealer_id# AND (page_type = #pg_nbr#) AND active = 1</cfquery>
			<cfif #chk_txt.recordcount# NEQ 0 ><cfset go_srp_custom = 1 ></cfif>
		</cfif>
<!--- Check for Custom SEO Text --->
			
<!--- Search Bar 03/16/2016 ---> 
<cfif #srp_srchbar# EQ 2  >			 
 	<div class="container-search-box" align="left">
		<br>
			<cfform action="../../search/index.cfm" method="post" name="news"  >
				<input type="hidden" name="res_style" value="1">
				<input  class="site-srch-input"	 type="text" name="lookup"  id="searchbar" size="50"  value=""  placeholder="Search #url.dealer_name#s Inventory" required >
				<input class="site-srch-btn"	type="submit"  name="submit"     value="Search">
			<cfif #variables.srch_err_phrase# NEQ "" >
				 &nbsp;&nbsp;<span class="site-srch-count">0 </span><span class="site-srch-error">#variables.srch_err_phrase# "#variables.srch_err_criteria#".<br>Displaying All #srp_noresult# Vehicles in our inventory</span>
			</cfif>
			</cfform>
		</div> 
</cfif>
  
		  <cfif #go_srp_custom# EQ 0 >  
				<div class="row">
					<div class="col-md-12">
						<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
					</div>
				</div>  
				<cfif #Get_Meta_Info.page_banner# NEQ "" >
					<div class="row">
						<div class="col-md-12" style="text-align:center">
							#Get_Meta_Info.page_banner#
						</div>
					</div>  
				</cfif>
		  	<cfelse>
				<div class="row">
					<div class="col-md-12 no-pad">
						<cfset came_from = 0 >
						<cfset n_u_flag = #url.new_used# >
						<cfinclude template="section_srp_vdp_text.cfm" >
					</div>
				</div>  	
			</cfif>  
			
            <cfif url.dealer_id eq 288>
				<div class="mmd-zone" data-asset-name='leaderboard' data-asset-type='leaderboard' data-width='728'></div>
				<script id="mmd-marketer" src="http://cdn.makemydeal.com/media/banner-ads/marketeer/marketeer.js" data-dealer-id="971"></script>
            </cfif>
            
            
			<cfif Not Isdefined("url.lookup_vins")>
				<cfset url.is_vdp_page = "Y" >    <!--- To pick up Banner on VDP 08/29/2014 --->
				<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="nav_type_id" value="52"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="element_class" value="page-banner"/>
                    <cfinvokeargument name="displayPageVal" value="1,3"/>
					<cfif lcase(cgi.script_name) contains "/new/">
						<cfinvokeargument name="page_id" value="/new/index.cfm"/>
					<cfelse>
						<cfinvokeargument name="page_id" value="/used/index.cfm"/>
					</cfif>
				</cfinvoke>
			</cfif>	


<!--- Search Bar 03/16/2016 ---> 
<cfif #srp_srchbar# EQ 1  >			 
 	<div class="container-search-box" align="left">
		<br>
			<cfform action="../../search/index.cfm" method="post" name="news"  >
				<input type="hidden" name="res_style" value="1">
				<input  class="site-srch-input"	 type="text" name="lookup"  id="searchbar" size="50"  value=""  placeholder="Search #url.dealer_name#s Inventory" required >
				<input class="site-srch-btn"	type="submit"  name="submit"     value="Search">
			<cfif #variables.srch_err_phrase# NEQ "" >
				 &nbsp;&nbsp;<span class="site-srch-count">0 </span><span class="site-srch-error">#variables.srch_err_phrase# "#variables.srch_err_criteria#".<br>Displaying All #srp_noresult# Vehicles in our inventory</span>
			</cfif>
			</cfform>
		</div> 
</cfif>
  



			
<cfif #url.dealer_id# EQ 366 or  #url.dealer_id# EQ 233><cfset srp_style = 0 ></cfif>			
<cfif #cgi.server_name# EQ "4ultra10.wddemos.com"><cfset srp_style = 0 ><cfset srp_searchbar_desk = 0 ></cfif>			
<cfif #srp_style# EQ 0 >		<!--- 12/14/2015 --->

				<cfif #srp_searchbar_desk# EQ 1 >		<!--- Searchbar On/Off for Desktop --->
					<div class="visible-sm visible-xs visible-lg visible-md">
				<cfelse>	
					<div class="visible-sm visible-xs">
				</cfif>					
				<cfinvoke component="/cfcs/vehicles/srp_engine" method="srp_default">
					<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
					<cfinvokeargument name="Get_Years" value="#Get_Years#"/>
					<cfinvokeargument name="Get_Makes" value="#Get_Makes#"/>
					<cfinvokeargument name="Get_Models" value="#Get_Models#"/>
					<cfinvokeargument name="Get_Dealers" value="#Get_Dealers#"/>
				</cfinvoke>
				</div>

		<cfif #cgi.server_name# EQ "4ultra10.wddemos.com"><cfset srp_style = 1 ></cfif>	
	<cfif #url.dealer_id# EQ 366 or  #url.dealer_id# EQ 233><cfset srp_style = 1 ></cfif>					
</cfif>
			</div>
			<div class="container srp-container">
<cfif #srp_style# EQ 0 >		<!--- 12/14/2015 --->
				<div class="col-md-3 visible-lg visible-md">
				<cfif IsDefined("url.pass_count")><cfset url.pass_count = #url.pass_count# ></cfif>
					<cfinvoke component="/cfcs/vehicles/vehicle_filters" method="srp">
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
						<cfinvokeargument name="Get_Regions" value="#Get_Regions#"/>									
						<cfinvokeargument name="Get_Styles" value="#Get_Styles#"/>
						
					</cfinvoke>
					<!--- Reset Button for left menu... wah. --->
						<div style="margin-right:10px;"><input type="button" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=#url.new_used#'" value="Reset Search" class="srp-btn-search btn btn-default">	</div>
									
				</div>
				<div class="col-md-9">
					<div class="row no-pad visible-md visible-lg">
						<cfset hold_new_used = #url.new_used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pagination" method="srp_pages">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
						</cfinvoke>
					</div>					
<cfelse>

				<div class="col-md-3 visible-lg visible-md">
				<cfif IsDefined("url.pass_count")><cfset url.pass_count = #url.pass_count# ></cfif>
					<cfinvoke component="/cfcs/vehicles/vehicle_filters" method="srp_new#srp_filter_style#">
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
						<cfinvokeargument name="Get_Interior_Colors" value="#Get_Interior_Colors#"/>										
						<cfinvokeargument name="Get_Regions" value="#Get_Regions#"/>									
						<cfinvokeargument name="Get_Styles" value="#Get_Styles#"/>
						
					</cfinvoke>
					<!--- Reset Button for left menu... wah. --->
						<!--- <div style="margin-right:10px;"><input type="button" onclick="javascript:location.href='http://#cgi.server_name#/vehicles/srp_action.cfm?new_used=N'" value="Reset Search" class="srp-btn-search btn btn-default">	</div> --->
									
				</div>
				<div class="col-md-9">
					<div class="row no-pad visible-md visible-lg">
						<cfset hold_new_used = #url.new_used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pagination_new" method="srp_pages">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
						</cfinvoke>
					</div>
</cfif>
					<!--- <div class="row no-pad visible-md visible-lg">
						<cfset hold_new_used = #url.new_used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pagination" method="srp_pages">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
						</cfinvoke>
					</div> --->
					
					
	 	<!--- Clicks Tracker & SRP Marketing flag --->
		<cfquery datasource="ultra10" name="t_clik">SELECT track_clicks,srp_marketing FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfset click_tracker = #t_clik.track_clicks# >
		
		<cfset url.car_cnt=0>   <!--- SRP Marketing 04-04-2016 --->
		<cfset url.banner_up=0>   <!--- SRP Marketing 04-04-2016 --->
		<cfif #t_clik.srp_marketing# NEQ 0 >
			<cfset nbr_banners = #t_clik.srp_marketing# >
			<cfset url.banner_up = 1 >
		</cfif>
					
					<cfif variables.startRow gt 0>
						<cfloop query="Get_Vehicles" startrow="#variables.startRow#" endrow="#variables.endRow#">
						
                        <cfset url.car_cnt=#url.car_cnt#+1>
                        <cfset url.banner_up=#url.banner_up#>
						
						 <cfif #click_tracker# EQ 1 >	<!--- Set in Dealer Settings 02/29/2016 --->
						
							<cfif ( IsDefined("url.make") AND #url.make#  NEQ "" ) AND ( IsDefined("url.model") AND #url.model#  NEQ "" ) >

									<cfquery datasource="Ultra10" name="Chk_Vin">
										SELECT ID, dealer_id, vin
										FROM   Vehicle_Click_Stats
										WHERE	VIN=<cfqueryparam value="#Get_Vehicles.vin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
									</cfquery>
									<cfif #Chk_Vin.recordcount# EQ 0 >
										<cfquery NAME="InsertUType" datasource="Ultra10">
											INSERT into Vehicle_Click_Stats ( 	dealer_id,  vin , create_ts )
											VALUES ( 	#url.dealer_id#,	'#Get_Vehicles.vin#',	#CreateODBCDateTime(now())# )
										</cfquery>
									</cfif>
									<cfquery datasource="Ultra10" name="Get_Clicks">
										SELECT ID, dealer_id,vin,srp_click FROM Vehicle_Click_Stats WHERE VIN=<cfqueryparam value="#Get_Vehicles.vin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
									</cfquery>
									<cfset get_clicks.srp_click = #Get_Clicks.srp_click# + 1 >
									<cfquery datasource="Ultra10" name="Update_Click">
										UPDATE Vehicle_Click_Stats SET srp_click=<cfqueryparam value="#Get_Clicks.srp_click#" cfsqltype="CF_SQL_INTEGER">,last_Upd=#CreateODBCDateTime(now())#
										WHERE		VIN=<cfqueryparam value="#Get_Vehicles.vin#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
									</cfquery>  
					
							</cfif>
							
						</cfif> 
						
						
                        <cfif url.dealer_id eq 33
							or url.dealer_id eq 34
							or url.dealer_id eq 288
							or url.dealer_id eq 52
							or url.dealer_id eq 54>
									<cfif len(trim(Get_Vehicles.Permalink)) gt 0 and len(trim(Get_Vehicles.V_Make)) gt 0 and len(trim(Get_Vehicles.V_Model)) gt 0 >							
										<cfset variables.v_link="#lcase(Get_Vehicles.V_Make)#/#lcase(Get_Vehicles.V_Model)#/#lcase(Get_Vehicles.Permalink)#?itype=#iif(Get_Vehicles.V_New_Used is 'N', de('New'), de('Used'))#">
									<cfelse>				
										<cfset variables.v_link="vehicle_details.cfm?vin=#Get_Vehicles.Vin#&itype=#iif(Get_Vehicles.V_New_Used is 'N',  de('New'), de('Used'))#">
									</cfif>
                        	<cfsavecontent variable="request.mmdListing">
                            <div data-mmd-id='mmd-listing'></div>
							<script type="text/javascript">
                                mmd_srp_listings.push({
                                    listedPrice: #Get_Vehicles.Selling_Price#,
                                    retailPrice: #iif(Get_Vehicles.MSRP_Price gt 0,Get_Vehicles.MSRP_Price, Get_Vehicles.Selling_Price)#,
                                    mileage: #Get_Vehicles.V_Odometer#,
                                    vehicleStatus: #iif(Get_Vehicles.V_New_Used is 'U', 0 , 1)#,
                                    vin: "#Get_Vehicles.Vin#",
                                    year: #Get_Vehicles.V_Year#,
                                    make: "#Get_Vehicles.V_Make#",
                                    model: "#Get_Vehicles.V_Model#",
                                    trim: "#Get_Vehicles.V_Trim#",
                                    stock: "#Get_Vehicles.Stock#",
                                         img: '<cftry>#listgetat(Get_Vehicles.img_urls,1)#<cfcatch></cfcatch></cftry>',
                                    vdpLink: "http://#cgi.server_name#/vehicles/#variables.v_link#",
                                });
                            </script>
                            </cfsavecontent>

                        </cfif>
    <cfif #url.dealer_id# EQ 365 AND #cgi.server_name# EQ "4ultra10.wddemos.com" ><cfset srp_style = "1" ></cfif>	
					 	<cfif #srp_style# Neq 1 >  
							<cfinvoke component="/cfcs/vehicles/vehicle" method="srp">
								<cfinvokeargument name="Vehicle_ID" value="#Get_Vehicles.Vehicle_ID#"/>
								<cfinvokeargument name="Dealer_ID" value="#Get_Vehicles.Dealer_ID#"/>
								<cfinvokeargument name="Vin" value="#Get_Vehicles.Vin#"/>
								<cfinvokeargument name="Permalink" value="#Get_Vehicles.Permalink#"/>
								<cfinvokeargument name="Stock" value="#Get_Vehicles.Stock#"/>
								<cfinvokeargument name="V_New_Used" value="#Get_Vehicles.V_New_Used#"/>
								<cfinvokeargument name="V_Year" value="#Get_Vehicles.V_Year#"/>
								<cfinvokeargument name="V_Make" value="#Get_Vehicles.V_Make#"/>
								<cfinvokeargument name="V_Model" value="#Get_Vehicles.V_Model#"/>
								<cfinvokeargument name="V_Trim" value="#Get_Vehicles.V_Trim#"/>
								<cfinvokeargument name="Img_Urls" value="#Get_Vehicles.Img_Urls#"/>
								<cfinvokeargument name="Video_Link" value="#Get_Vehicles.Video_Link#"/>
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
								<cfinvokeargument name="Adjusted_Baseline" value="#Get_Vehicles.Adjusted_Baseline#"/>
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
								<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicles.Dealer_Phone#"/>
								<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicles.Dealer_Comments#"/>
								<cfinvokeargument name="Carfax_One_Owner" value="#Get_Vehicles.Carfax_One_Owner#"/>
								<cfinvokeargument name="Autocheck" value="#Get_Vehicles.Autocheck#"/>
								<cfinvokeargument name="Disclaimer" value="#Get_Vehicles.Disclaimer#"/>
								<cfinvokeargument name="Certified" value="#Get_Vehicles.Certified#"/>
								<cfinvokeargument name="AIS_wID" value="#Get_Vehicles.AIS_wID#"/>
								<cfinvokeargument name="half_year" value="#Get_Vehicles.half_year#"/>
							</cfinvoke>
					<cfelse> 
						 	<cfset url.currentrow = #get_vehicles.currentrow#> 
						 	<cfset url.v_id = #get_vehicles.vehicle_id#>
							<cfinvoke component="/cfcs/vehicles/vehicle_alt1" method="srp">
								<cfinvokeargument name="Vehicle_ID" value="#Get_Vehicles.Vehicle_ID#"/>
								<cfinvokeargument name="Dealer_ID" value="#Get_Vehicles.Dealer_ID#"/>
								<cfinvokeargument name="Vin" value="#Get_Vehicles.Vin#"/>
								<cfinvokeargument name="Permalink" value="#Get_Vehicles.Permalink#"/>
								<cfinvokeargument name="Stock" value="#Get_Vehicles.Stock#"/>
								<cfinvokeargument name="V_New_Used" value="#Get_Vehicles.V_New_Used#"/>
								<cfinvokeargument name="V_Year" value="#Get_Vehicles.V_Year#"/>
								<cfinvokeargument name="V_Make" value="#Get_Vehicles.V_Make#"/>
								<cfinvokeargument name="V_Model" value="#Get_Vehicles.V_Model#"/>
								<cfinvokeargument name="V_Trim" value="#Get_Vehicles.V_Trim#"/>
								<cfinvokeargument name="Img_Urls" value="#Get_Vehicles.Img_Urls#"/>
								<cfinvokeargument name="Video_Link" value="#Get_Vehicles.Video_Link#"/>
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
								<cfinvokeargument name="Adjusted_Baseline" value="#Get_Vehicles.Adjusted_Baseline#"/>
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
								<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicles.Dealer_Phone#"/>
								<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicles.Dealer_Comments#"/>
								<cfinvokeargument name="Carfax_One_Owner" value="#Get_Vehicles.Carfax_One_Owner#"/>
								<cfinvokeargument name="Autocheck" value="#Get_Vehicles.Autocheck#"/>
								<cfinvokeargument name="Disclaimer" value="#Get_Vehicles.Disclaimer#"/>
								<cfinvokeargument name="Certified" value="#Get_Vehicles.Certified#"/>
								<cfinvokeargument name="AIS_wID" value="#Get_Vehicles.AIS_wID#"/>
								<cfinvokeargument name="half_year" value="#Get_Vehicles.half_year#"/>
								<cfinvokeargument name="on_lot_status" value="#Get_Vehicles.on_lot_status#"/>
							</cfinvoke>
					
					</cfif>	
					</cfloop>
						<cfif url.dealer_id eq 33 
							or url.dealer_id eq 34
							or url.dealer_id eq 288
							or url.dealer_id eq 52
							or url.dealer_id eq 54>
                        <script type="text/javascript">
							MakeMyDeal.srp.configure(mmd_srp_listings);
							MakeMyDeal.srp.load();
						</script>
                        </cfif>
					</cfif>
					<div class="row no-pad visible-md visible-lg">
						<cfset url.new_used = #hold_new_used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pagination" method="srp_pages">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
						</cfinvoke>
					</div>
					<div class="row no-pad visible-sm visible-xs">
						<cfset url.new_used = #hold_new_used# >
						<cfinvoke component="/cfcs/vehicles/vehicle_pagination" method="srp_next">
							<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
							<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
						</cfinvoke>
					</div>
					<div class="row">
						<div class="col-md-12 srp-disclaimer">
							<cfif len(trim(url.v_disclaimer)) gt 0>
								#url.v_disclaimer#
							<cfelse>
								Price plus tax, license, document preparation charge, and finance charges and smog fees (used vehicles only), where applicable. While every effort has been made to ensure display of accurate data and pricing, this listing may not reflect all accurate vehicle data or pricing and is subject to human error. All Inventory listed is subject to prior sale. The photo shown, if any, may be an example only. Please consult dealership personnel for further details.
							</cfif>
						</div>
					</div>
				</div>
				<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
					
					
                    <div class="row">
						<div class="col-md-11">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
                    
                    
				</cfif>
			</div>
		</section>
        
<cfif url.dealer_id eq 365>
<!--AutoHook New SRP Script--> 
<script type="text/javascript">
var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
var hl_script = document.createElement("script");
hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/kelly/Delivery.aspx?SiteID=15975131&PgID=<cfif #url.new_used# eq "N">new_inventory</cfif><cfif #url.new_used# eq "U">used_inventory</cfif>';
hl_script.type = 'text/javascript';
hl_script.id = "HL_ScriptCall";
document.getElementsByTagName('head')[0].appendChild(hl_script);
</script>
<!--End AutoHook New SRP Script--> 
</cfif>
<cfif url.dealer_id eq 34>
<!--AutoHook New SRP Script--> 
<script type="text/javascript">
var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
var hl_script = document.createElement("script");
hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/kelly/Delivery.aspx?SiteID=123487&PgID=<cfif #url.new_used# eq "N">new_inventory</cfif><cfif #url.new_used# eq "U">used_inventory</cfif>';
hl_script.type = 'text/javascript';
hl_script.id = "HL_ScriptCall";
document.getElementsByTagName('head')[0].appendChild(hl_script);
</script>
<!--End AutoHook New SRP Script--> 
</cfif>
<cfif url.dealer_id eq 32>
<!--AutoHook New SRP Script--> 
<script type="text/javascript">
var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
var hl_script = document.createElement("script");
hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/kelly/Delivery.aspx?SiteID=1184725&PgID=<cfif #url.new_used# eq "N">new_inventory</cfif><cfif #url.new_used# eq "U">used_inventory</cfif>';
hl_script.type = 'text/javascript';
hl_script.id = "HL_ScriptCall";
document.getElementsByTagName('head')[0].appendChild(hl_script);
</script>
<!--End AutoHook New SRP Script--> 
</cfif>
		<script type="text/javascript">
			function getVid(loc){
				document.getElementById("iframe_video_frame").src=loc;
				$('##video_frame').modal({
					show: true
				});
			}
			function closeVid(){
				document.getElementById("iframe_video_frame").src='http://#cgi.server_name#/blank.html';
			}
		</script>
		<cfinvoke component="/cfcs/ultra10/popups" method="iframe">
			<cfinvokeargument name="pop_name" value="video_frame"/>
			<cfinvokeargument name="iframe_src" value="http://#cgi.server_name#/blank.html"/>
			<cfinvokeargument name="width" value="500"/>
			<cfinvokeargument name="height" value="400"/>
			<cfinvokeargument name="close_function" value="closeVid()"/>
		</cfinvoke>

		<script type="text/javascript">
			function getAIS(loc){
				document.getElementById("iframe_AIS_frame").src=loc;
				$('##AIS_frame').modal({
					show: true
				});
			}
			function closeAIS(){
				document.getElementById("iframe_AIS_frame").src='http://#cgi.server_name#/blank.html';
			}
		</script>
		<cfinvoke component="/cfcs/ultra10/popups" method="iframe">
			<cfinvokeargument name="pop_name" value="AIS_frame"/>
			<cfinvokeargument name="iframe_src" value="http://#cgi.server_name#/blank.html"/>
			<cfinvokeargument name="width" value="900"/>
			<cfinvokeargument name="height" value="500"/>
			<cfinvokeargument name="scrolling" value="yes"/>
			<cfinvokeargument name="close_function" value="closeAIS()"/>
		</cfinvoke>
		
	</cffunction>

	<cffunction name="legacy_standard" description="create standard srp page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<cfparam name="url.year" default="">
		<cfparam name="url.new_used" default="">
		<cfparam name="url.make" default="">
		<cfparam name="url.model" default="">
		<cfparam name="url.maxprice" default="11000000">
		<cfparam name="url.minprice" default="-1">
		<cfparam name="url.sortblock" default="1">
		<cfparam name="url.luxury" default="">
		<cfparam name="url.fleet" default="">
		<cfparam name="url.commercial" default="">
		<cfparam name="url.certified" default="">
		<cfparam name="url.body" default="">
		<cfparam name="url.drivetrain" default="">
		<cfparam name="url.transmission" default="">
		<cfparam name="url.color" default="">
		<cfparam name="url.zip" default="">
		<cfparam name="url.radius" default="">
		<cfparam name="url.form_action" default="0">	

	  	<cfparam name="url.classic" default="">  
		
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">

		<!---dealer specific parameters--->
		<cfparam name="url.v_disclaimer" default="">

		<!--- sortblock kung fu ---> 
		<cfswitch expression="#url.sortblock#">
			<cfcase value="9">
				<cfset url.luxury=1>
			</cfcase>
			<cfcase value="10">
				<cfset url.fleet=1>
			</cfcase>
			<cfcase value="11">
				<cfset url.commercial=1>
			</cfcase>
		</cfswitch>

		<!---maxprice kung fu--->
		<cfswitch expression="#url.maxprice#">
			<cfcase value="5000,10000,12000,15000,20000,25000,30000,35000,40000,45000,50000,75000,100000">
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

		<!---Get Vehicles--->
		<cfinvoke component="/cfcs/vehicles/lookups" method="srp_default" returnvariable="Get_Vehicles">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
		</cfinvoke>

		<!---Get Dropdown/Filter Data--->
		<cfinvoke component="/cfcs/vehicles/lookups" method="srp_years" returnvariable="Get_Years">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/vehicles/lookups" method="srp_makes" returnvariable="Get_Makes">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
		</cfinvoke>
		<cfinvoke component="/cfcs/vehicles/lookups" method="srp_models" returnvariable="Get_Models">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
		</cfinvoke>

		<cfquery dbtype="query" name="Get_Dealers">
			SELECT Distinct Dealer_ID,
							Dealer_Display_Name
			FROM			Get_Vehicles
			WHERE			Dealer_Display_Name is not null
			ORDER BY		Dealer_Display_Name
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

		<cfparam name="url.page" default="1">
		<cfparam name="url.result_set" default="10">
		<cfif isvalid("integer",url.result_set) eq "No"><cfset url.result_set=10></cfif>
		<cfif url.result_set gt 100>
			<cfset url.result_set=100>
		</cfif>
		<cfif isvalid("integer",url.page) eq "No"><cfset url.page=1></cfif>
		<cfif url.page lte 0><cfset url.page=1></cfif>

		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<!--- Setup paging --->
		<cfset variables.pageSize = url.result_set><!--- cars per page --->
		<!---<cfset variables.pageSize = 10>--->
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
		
		<div class="section-srp srp-container">
			<div class="container pad-top-10">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="banner">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="52"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="page-banner"/>
								<cfif lcase(cgi.script_name) contains "/new/">
									<cfinvokeargument name="page_id" value="/new/index.cfm"/>
								<cfelse>
									<cfinvokeargument name="page_id" value="/used/index.cfm"/>
								</cfif>
							</cfinvoke>
							<cfinvoke component="/cfcs/vehicles/srp_engine" method="srp_legacy">
								<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
								<cfinvokeargument name="Get_Years" value="#Get_Years#"/>
								<cfinvokeargument name="Get_Makes" value="#Get_Makes#"/>
								<cfinvokeargument name="Get_Models" value="#Get_Models#"/>
								<cfinvokeargument name="Get_Dealers" value="#Get_Dealers#"/>
							</cfinvoke>
						</td>
					</tr>
					<tr>
						<td>
							<table style="width:100%" cellpadding="0" cellspacing="0">
								<tr>
									<td style="width:250px;" valign="top">
										<cfinvoke component="/cfcs/vehicles/vehicle_filters" method="srp_legacy">
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
									</td>
									<td style="width:740px;padding:10px 0px 10px 5px;" valign="top">
										<div>
											<cfinvoke component="/cfcs/vehicles/vehicle_pagination" method="srp_pages_legacy">
												<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
												<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
											</cfinvoke>
										</div>
										<cfloop query="Get_Vehicles" startrow="#variables.startRow#" endrow="#variables.endRow#">
											<cfinvoke component="/cfcs/vehicles/vehicle" method="srp_legacy">
												<cfinvokeargument name="Vehicle_ID" value="#Get_Vehicles.Vehicle_ID#"/>
												<cfinvokeargument name="Dealer_ID" value="#Get_Vehicles.Dealer_ID#"/>
												<cfinvokeargument name="Vin" value="#Get_Vehicles.Vin#"/>
												<cfinvokeargument name="Permalink" value="#Get_Vehicles.Permalink#"/>
												<cfinvokeargument name="Stock" value="#Get_Vehicles.Stock#"/>
												<cfinvokeargument name="V_New_Used" value="#Get_Vehicles.V_New_Used#"/>
												<cfinvokeargument name="V_Year" value="#Get_Vehicles.V_Year#"/>
												<cfinvokeargument name="V_Make" value="#Get_Vehicles.V_Make#"/>
												<cfinvokeargument name="V_Model" value="#Get_Vehicles.V_Model#"/>
												<cfinvokeargument name="V_Trim" value="#Get_Vehicles.V_Trim#"/>
												<cfinvokeargument name="Img_Urls" value="#Get_Vehicles.Img_Urls#"/>
												<cfinvokeargument name="Video_Link" value="#Get_Vehicles.Video_Link#"/>
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
												<cfinvokeargument name="Adjusted_Baseline" value="#Get_Vehicles.Adjusted_Baseline#"/>
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
												<cfinvokeargument name="Dealer_Phone" value="#Get_Vehicles.Dealer_Phone#"/>
												<cfinvokeargument name="Dealer_Comments" value="#Get_Vehicles.Dealer_Comments#"/>
												<cfinvokeargument name="Carfax_One_Owner" value="#Get_Vehicles.Carfax_One_Owner#"/>
												<cfinvokeargument name="Autocheck" value="#Get_Vehicles.Autocheck#"/>
												<cfinvokeargument name="Certified" value="#Get_Vehicles.Certified#"/>
												<cfinvokeargument name="AIS_wID" value="#Get_Vehicles.AIS_wID#"/>
												<!--- <cfinvokeargument name="half_year" value="#Get_Vehicles.half_year#"/> --->
											</cfinvoke>
										</cfloop>
										<div>
											<cfinvoke component="/cfcs/vehicles/vehicle_pagination" method="srp_pages_legacy">
												<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/srp_action.cfm"/>
												<cfinvokeargument name="Recordcount" value="#Get_Vehicles.Recordcount#"/>
											</cfinvoke>
										</div>
										<div class="row">
											<div class="col-md-12 srp-disclaimer">
												<cfif len(trim(url.v_disclaimer)) gt 0>
													#url.v_disclaimer#
												<cfelse>
													Price plus tax, license, document preparation charge, and finance charges and smog fees (used vehicles only), where applicable. While every effort has been made to ensure display of accurate data and pricing, this listing may not reflect all accurate vehicle data or pricing and is subject to human error. All Inventory listed is subject to prior sale. The photo shown, if any, may be an example only. Please consult dealership personnel for further details.
												</cfif>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>			
		</div>
		
	</cffunction>

</cfcomponent>