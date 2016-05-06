

<cfcomponent>

  <cfset attributes.dealer_id=66>     <!--- <cfset attributes.dealer_id=#url.dealer_id#>  ---> 

	<cffunction name="modern_standard_legacy" description="shows coupons from legacy system" output="Yes" access="public">

<cfquery datasource="Aspen10" name="Get_Classics">
	SELECT	 Vehicle_ID, Dealer_ID, Vin, Stock, Permalink, 
			 Img_Urls, Video_Link, V_New_Used, V_Year, V_Make, V_Model, V_Trim, V_Odometer, V_Model_Number, V_Type, V_Style, 
			 Interior_Color, Exterior_Color, Transmission, Engine_Size, Cylinders, Doors, Drivetrain, Passengers, Dealer_Comments, Fuel_Type, 
			 EPA_City, EPA_HWY, Adjusted_Baseline, Selling_Price_Label, Selling_Price, MSRP_Label, MSRP_Price, Rebate_Label, Rebate_Price, 
			 Incentive_Label, Incentive_Price, Savings_Label, Savings_Price, AIS_Label, AIS_Price, AIS_APR, Certified, Fleet, Luxury, Commercial, 
			 Carfax_One_Owner, Autocheck, Dealer_Display_Name, Dealer_Address_1, Dealer_Address_2, Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, 
			 Dealer_Url, Link_Finance, Link_Service, Link_Sales, Link_Parts, Link_Directions, Disclaimer, AIS_wID
	FROM     Vehicles
	WHERE    V_Year < 1991
	AND		 V_New_Used = 'U'
	AND		 Dealer_ID IN (SELECT Share_ID FROM dealer_shares WHERE Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.dealer_id#" maxlength="10"> AND New_Used = 'U')
	ORDER BY V_Year ASC
</cfquery>
<cfoutput>

		<cfset a_V_Make = ArrayNew(1) >
		<cfset a_V_Model = ArrayNew(1) >
		<cfset a_V_Year = ArrayNew(1) >
		<cfset a_V_Trim = ArrayNew(1) >
		<cfset a_Vin = ArrayNew(1) >
		<cfset a_Img_Urls = ArrayNew(1) >
		<cfset a_Dealer_Comments = ArrayNew(1) >
		<cfset a_Stock = ArrayNew(1) >
		<cfset a_V_Model_Number = ArrayNew(1) >
		<cfset a_V_Style = ArrayNew(1) >
		<cfset a_Exterior_Color = ArrayNew(1) >
		<cfset a_Interior_Color = ArrayNew(1) >
		<cfset a_V_Odometer = ArrayNew(1) >
		<cfset a_Engine_Size = ArrayNew(1) >
		<cfset a_Transmission = ArrayNew(1) >
		<cfset a_DriveTrain = ArrayNew(1) >
		<cfset a_Last = 0 >
		
		<cfset x = 0 >
		<cfif #Get_Classics.recordcount# NEQ 0 >
			<cfloop query="Get_Classics">
				<cfset x = #x#+1 >
				<cfset a_V_Make[x] = "#Get_Classics.V_Make#" >
				<cfset a_V_Model[x] = "#Get_Classics.V_Model#" >
				<cfset a_V_Year[x] = "#Get_Classics.V_Year#" >
				<cfset a_V_Trim[x] = "#Get_Classics.V_Trim#" >
				<cfset a_Vin[x] = "#Get_Classics.Vin#" >
				<cfset a_Dealer_Comments[x] ="#Get_Classics.Dealer_Comments#" >
				<cfset a_Stock[x] = "#Get_Classics.Stock#" >
				<cfif #Get_Classics.Img_Urls# NEQ "" >
					<cfset a_Img_Urls[x] = "#Get_Classics.Img_Urls#" >
				<cfelse>		
					<cfset a_Img_Urls[x] = "staff.jpg" >
				</cfif>
				<cfset a_V_Model_Number[x] = "#Get_Classics.V_Model_Number#" >
				<cfset a_V_Style[x] = "#Get_Classics.V_Style#" >
				<cfset a_Exterior_Color[x] = "#Get_Classics.Exterior_Color#" >
				<cfset a_Interior_Color[x] = "#Get_Classics.Interior_Color#" >
				<cfset a_V_Odometer[x] = "#Get_Classics.V_Odometer#" >
				<cfset a_Engine_Size[x] = "#Get_Classics.Engine_Size#" >
				<cfset a_Transmission[x] = "#Get_Classics.Transmission#" >
				<cfset a_DriveTrain[x] = "#Get_Classics.DriveTrain#" >
			</cfloop>
			<cfset a_Last = #x# >
		</cfif>
	<!--- <h1 id="inv-h1" title="Search #attributes.Get_Site_Info.Display_Name#'s Classic Cars &amp; Trucks">Search #attributes.Get_Site_Info.Display_Name#'s Classic Cars &amp; Trucks</h1> --->
		<cfif #a_Last# LT 3 >
			<cfset stepper = #a_Last#  >
		<cfelse>	
			<cfset stepper =   3  >
		</cfif>
		<cfloop index="x" from="1" to="#a_Last#" step="#stepper#" >
			<cfset nxt = 0 >
			<div class="row">
				<div class="col-md-4">
					<p align="center"><strong>#a_V_Year[x]# #a_V_Make[x]# #a_V_Model[x]# #a_V_Trim[x]#</strong></p>
				<cfset variables.v_link="http://#cgi.Server_Name#/Used/vehicle_details.cfm?vin=#a_Vin[x]#">
				<cfif #a_Img_Urls[x]# NEQ "">  
					<img src="#listgetat(a_Img_Urls[x],1)#" class="img-responsive" alt="#a_V_Year[x]# #a_V_Make[x]# #a_V_Model[x]#"  border="0" >
			  	</cfif> 
				<div class="col-md-3"   align="center" style="font-size:8pt" >
				<a class="special-link" href="#variables.v_link#">Details</a>
				</div>
				<div class="col-md-4" align="center" style="font-size:8pt" >
				<a class="special-link" href="http://#cgi.Server_Name#/popups/quick_quote.cfm?vin=#a_Vin[x]#&amp;title=Request Information">Request Info</a>
				</div>
				<div class="col-md-5" align="center" style="font-size:8pt" >
				<a class="special-link" href="http://#cgi.Server_Name#/popups/send_friend.cfm?vin=#a_Vin[x]#">Send to a Friend</a>
				</div>
				<br>
				<textarea rows="5" cols="50" style="font-size:8pt">#a_Dealer_Comments[x]#</textarea><br>
				Stock: #a_Stock[x]#<br/>
				Vin: #a_Vin[x]#<br/>
				<cfif len(trim(a_V_Model_Number[x])) gt 0>Model Number : #a_V_Model_Number[x]#<br/></cfif>
				<cfif len(trim(a_V_Style[x])) gt 0>Style : #a_V_Style[x]#<br/></cfif>
				<cfif len(trim(a_Exterior_Color[x])) gt 0>Exterior : #a_Exterior_Color[x]#<br/></cfif>
				<cfif len(trim(a_Interior_Color[x])) gt 0>Interior : #a_Interior_Color[x]#<br/></cfif>
				<cfif a_V_Odometer[x] neq "0">Miles : #numberformat(a_V_Odometer[x])#<br/></cfif>
				<cfif len(trim(a_Engine_Size[x])) gt 0>Engine : #a_Engine_Size[x]# <br/></cfif>
				<cfif len(trim(a_Transmission[x])) gt 0>Transmission : #a_Transmission[x]#<br/></cfif>
				<cfif len(trim(a_DriveTrain[x])) gt 0>Drivetrain : #a_DriveTrain[x]#<br/></cfif>
				</p>				
				<br>
			</div>
			<cfset nxt = #x#+1 >
			<cfif #nxt# LTE #a_Last# >
				<div class="col-md-4">
					<p align="center"><strong>#a_V_Year[nxt]# #a_V_Make[nxt]# #a_V_Model[nxt]# #a_V_Trim[nxt]#</strong></p>				 
				<cfset variables.v_link="http://#cgi.Server_Name#/Used/#a_V_Make[nxt]#/#a_V_Model[x]#/Inventory_Details.cfm?Vin=#a_Vin[nxt]#">
				<cfif #a_Img_Urls[nxt]# NEQ "">  
					<img src="#listgetat(a_Img_Urls[nxt],1)#" class="img-responsive" alt="#a_V_Year[nxt]# #a_V_Make[nxt]# #a_V_Model[nxt]#"  border="0" >
			  	</cfif>  
				<!--- <br> --->
				<div class="col-md-3"   align="center" style="font-size:8pt" >
				<a class="special-link" href="#variables.v_link#">Details</a>
				</div>
				<div class="col-md-4" align="center" style="font-size:8pt" >
				<a class="special-link" href="http://#cgi.Server_Name#/popups/quick_quote.cfm?vin=#a_Vin[nxt]#&amp;title=Request Information">Request Info</a>
				</div>
				<div class="col-md-5" align="center" style="font-size:8pt" >
				<a class="special-link" href="http://#cgi.Server_Name#/popups/send_friend.cfm?vin=#a_Vin[nxt]#">Send to a Friend</a>
				</div>
				<br>
				<textarea rows="5" cols="50" style="font-size:8pt">#a_Dealer_Comments[nxt]#</textarea><br>
				Stock: #a_Stock[nxt]#<br/>
				Vin: #a_Vin[nxt]#<br/>
				<cfif len(trim(a_V_Model_Number[nxt])) gt 0>Model Number : #a_V_Model_Number[nxt]#<br/></cfif>
				<cfif len(trim(a_V_Style[nxt])) gt 0>Style : #a_V_Style[nxt]#<br/></cfif>
				<cfif len(trim(a_Exterior_Color[nxt])) gt 0>Exterior : #a_Exterior_Color[nxt]#<br/></cfif>
				<cfif len(trim(a_Interior_Color[nxt])) gt 0>Interior : #a_Interior_Color[nxt]#<br/></cfif>
				<cfif a_V_Odometer[nxt] neq "0">Miles : #numberformat(a_V_Odometer[nxt])#<br/></cfif>
				<cfif len(trim(a_Engine_Size[nxt])) gt 0>Engine : #a_Engine_Size[nxt]# <br/></cfif>
				<cfif len(trim(a_Transmission[nxt])) gt 0>Transmission : #a_Transmission[nxt]#<br/></cfif>
				<cfif len(trim(a_DriveTrain[nxt])) gt 0>Drivetrain : #a_DriveTrain[nxt]#<br/></cfif>
				</p>				
				<br>
			</div>
			</cfif>
			<cfset nxt = #nxt#+1 >
			<cfif #nxt# LTE #a_Last# >
				<div class="col-md-4">
					<p align="center"><strong>#a_V_Year[nxt]# #a_V_Make[nxt]# #a_V_Model[nxt]# #a_V_Trim[nxt]#</strong></p>
				<cfset variables.v_link="http://#cgi.Server_Name#/Used/#a_V_Make[nxt]#/#a_V_Model[x]#/Inventory_Details.cfm?Vin=#a_Vin[nxt]#">
				<cfif #a_Img_Urls[nxt]# NEQ "">  
					<img src="#listgetat(a_Img_Urls[nxt],1)#" class="img-responsive" alt="#a_V_Year[nxt]# #a_V_Make[nxt]# #a_V_Model[nxt]#"  border="0" >
			  	</cfif>  
				<div class="col-md-3"   align="center" style="font-size:8pt" >
				<a class="special-link" href="#variables.v_link#">Details</a>
				</div>
				<div class="col-md-4" align="center" style="font-size:8pt" >
				<a class="special-link" href="http://#cgi.Server_Name#/popups/quick_quote.cfm?vin=#a_Vin[nxt]#&amp;title=Request Information">Request Info</a>
				</div>
				<div class="col-md-5" align="center" style="font-size:8pt" >
				<a class="special-link" href="http://#cgi.Server_Name#/popups/send_friend.cfm?vin=#a_Vin[nxt]#">Send to a Friend</a>
				</div>
				<br>
				<textarea rows="5" cols="50" style="font-size:8pt">#a_Dealer_Comments[nxt]#</textarea><br>
				Stock: #a_Stock[nxt]#<br/>
				Vin: #a_Vin[nxt]#<br/>
				<cfif len(trim(a_V_Model_Number[nxt])) gt 0>Model Number : #a_V_Model_Number[nxt]#<br/></cfif>
				<cfif len(trim(a_V_Style[nxt])) gt 0>Style : #a_V_Style[nxt]#<br/></cfif>
				<cfif len(trim(a_Exterior_Color[nxt])) gt 0>Exterior : #a_Exterior_Color[nxt]#<br/></cfif>
				<cfif len(trim(a_Interior_Color[nxt])) gt 0>Interior : #a_Interior_Color[nxt]#<br/></cfif>
				<cfif a_V_Odometer[nxt] neq "0">Miles : #numberformat(a_V_Odometer[nxt])#<br/></cfif>
				<cfif len(trim(a_Engine_Size[nxt])) gt 0>Engine : #a_Engine_Size[nxt]# <br/></cfif>
				<cfif len(trim(a_Transmission[nxt])) gt 0>Transmission : #a_Transmission[nxt]#<br/></cfif>
				<cfif len(trim(a_DriveTrain[nxt])) gt 0>Drivetrain : #a_DriveTrain[nxt]#<br/></cfif>
				</p>				
				<br>
			</div>
		</cfif>
	</div>	
	</cfloop>
	
</cfoutput>
</cffunction>

<cffunction name="legacy_standard_legacy" description="shows coupons from legacy system" output="Yes" access="public">
</cffunction>

</cfcomponent>