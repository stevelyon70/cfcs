<cfcomponent>

	<cffunction name="header_adf" description="add contact info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="Lead_ID" required="true">
		<cfargument name="Source" default="WorldDealer">
		
	<cfif IsDefined("url.dealer_id") >
		<!--- Check for Vanity Lead Source 12/30/2015 --->
		<cfquery name="lead_srce" datasource="Ultra10" >SELECT vanity_lead_source FROM Dealers	where dealer_id = #url.dealer_id# </cfquery>  
		<cfif #lead_srce.vanity_lead_source# NEQ "" ><cfset arguments.Source = #lead_srce.vanity_lead_source# ></cfif>
		<!--- Check for Vanity Lead Source 12/30/2015 --->
	</cfif>
		
		<cfset variables.adf_email="">
		<cfset info = GetTimeZoneInfo()>
		<cfset adf.DateTimeString="#dateformat(now(),'YYYY-MM-DD')#T#timeformat(now(),'HH:MM:SS')#-0#info.utcHourOffset#:00">
		<cfset adftimestamp="#dateformat(now(),'mmddyy')##timeformat(now(),'hhmmss')#">

		<cfset variables.adf_email=variables.adf_email & '<?xml version="1.0"?>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '<?ADF version="1.0"?>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '<adf>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '<prospect status="new">' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '<id sequence="1" source="#arguments.Source#">#arguments.Lead_ID#</id>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '<requestdate>#adf.DateTimeString#</requestdate>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>

	<cffunction name="contact_adf" description="add contact info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">
		<cfargument name="pin" default="">
		<cfargument name="first_name" default="">
		<cfargument name="middle_name" default="">
		<cfargument name="last_name" default="">
		<cfargument name="suffix" default="">
		<cfargument name="email" default="">
		<cfargument name="phone_1" default="">
		<cfargument name="phone_2" default="">
		<cfargument name="fax" default="">
		<cfargument name="address_1" default="">
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="ssn" default="">
		<cfargument name="dob" default="">
		<cfargument name="license" default="">
		<cfargument name="comments" default="">
		<cfargument name="business_name" default="">
		<cfargument name="tax_id" default="">
		<cfargument name="sales_rep" default="">
		<cfargument name="best_time" default="">
		<cfargument name="best_method" default="">
		<cfargument name="relationship" default="">
		<cfargument name="newsletter" default="">

		<cfset variables.adf_email=arguments.adf_email>

		<cfset variables.adf_email=variables.adf_email & '<customer>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<contact>' & "#chr(10)#">
				<cfif len(trim(arguments.first_name)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<name part="first">#arguments.first_name#</name>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(arguments.last_name)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<name part="last">#arguments.last_name#</name>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(arguments.email)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<email>#arguments.email#</email>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(arguments.phone_1)) gt 0>
					<cfset arguments.phone_1=rereplace(arguments.phone_1, "[^\w]", "", "all")>
					<cfset arguments.phone_1="#left(arguments.phone_1,3)#-#mid(arguments.phone_1,4,3)#-#right(arguments.phone_1,4)#">		
					<cfif isvalid("telephone" ,arguments.phone_1) eq "Yes">
						<cfset variables.adf_email=variables.adf_email & '<phone type="phone" time="day">#arguments.phone_1#</phone>' & "#chr(10)#">
					</cfif>
				</cfif>
				<cfif len(trim(arguments.phone_2)) gt 0>
					<cfset arguments.phone_2=rereplace(arguments.phone_2, "[^\w]", "", "all")>
					<cfset arguments.phone_2="#left(arguments.phone_2,3)#-#mid(arguments.phone_2,4,3)#-#right(arguments.phone_2,4)#">
					<cfif isvalid("telephone" ,arguments.phone_2) eq "Yes">
						<cfset variables.adf_email=variables.adf_email & '<phone type="phone" time="evening">#arguments.phone_2#</phone>' & "#chr(10)#">
					</cfif>
				</cfif>
				
				<cfif len(trim(arguments.newsletter)) gt 0>
					<cfif arguments.newsletter EQ 1 >
						<cfset variables.adf_email=variables.adf_email & '<newsletter>YES</newsletter>' & "#chr(10)#">
					<cfelseif arguments.newsletter EQ 0 >
						<cfset variables.adf_email=variables.adf_email & '<newsletter>NO</newsletter>' & "#chr(10)#">	
					</cfif>
				</cfif>
				<cfif len(trim(arguments.pin)) gt 0>
					<cfset arguments.pin=rereplace(arguments.pin, "[^\w]", "", "all")>
						<cfset variables.adf_email=variables.adf_email & '<purl>#arguments.pin#</purl>' & "#chr(10)#">
				</cfif>
				
				<cfif 	len(trim(arguments.address_1)) gt 0 or
								len(trim(arguments.address_2)) gt 0 or
								len(trim(arguments.city)) gt 0 or
								len(trim(arguments.state)) gt 0 or
								len(trim(arguments.zip)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<address>' & "#chr(10)#">
						<cfif len(trim(arguments.address_1)) gt 0>
							<cfset variables.adf_email=variables.adf_email & '<street line="1">#arguments.address_1#</street>' & "#chr(10)#">
						</cfif>
						<cfif len(trim(arguments.address_2)) gt 0>
							<cfset variables.adf_email=variables.adf_email & '<street line="2">#arguments.address_2#</street>' & "#chr(10)#">
						</cfif>
						<cfif len(trim(arguments.city)) gt 0>
							<cfset variables.adf_email=variables.adf_email & '<city>#arguments.city#</city>' & "#chr(10)#">
						</cfif>
						<cfif len(trim(arguments.state)) gt 0>
							<cfset variables.adf_email=variables.adf_email & '<regioncode>#arguments.state#</regioncode>' & "#chr(10)#">
						</cfif>
						<cfif len(trim(arguments.zip)) gt 0>
							<cfset variables.adf_email=variables.adf_email & '<postalcode>#arguments.zip#</postalcode>' & "#chr(10)#">
						</cfif>
					<cfset variables.adf_email=variables.adf_email & '</address>' & "#chr(10)#">
				</cfif>
			<cfset variables.adf_email=variables.adf_email & '</contact>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<comments>#arguments.comments#</comments>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '</customer>' & "#chr(10)#">

		<cfreturn variables.adf_email>
	
	</cffunction>

	<cffunction name="vehicle_adf" description="add vehicle info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">
		<cfargument name="interest" required="true">
		<cfargument name="new_used" default="N">
		<cfargument name="v_year" default="">
		<cfargument name="v_make" default="">
		<cfargument name="v_model" default="">
		<cfargument name="v_trim" default="">
		<cfargument name="v_price" default="">
		<cfargument name="v_offer" default="">
		<cfargument name="v_vin" default="">
		<cfargument name="v_stock" default="">
		<cfargument name="v_body" default="">
		<cfargument name="v_ext_color_1" default="">
		<cfargument name="v_ext_color_2" default="">
		<cfargument name="v_int_color_1" default="">
		<cfargument name="v_int_color_2" default="">
		<cfargument name="v_transmission" default="">
		<cfargument name="v_engine" default="">
		<cfargument name="v_options" default="">
		<cfargument name="v_seating" default="">
		<cfargument name="v_license_plate" default="">
		<cfargument name="v_mileage" default="">
		<cfargument name="v_cash_down" default="">
		<cfargument name="v_monthly_payment" default="">
		<cfargument name="v_balance" default="">
		<cfargument name="v_estimate" default="">
		<cfargument name="v_condition" default="">
		<cfargument name="v_comments" default="">
		<cfargument name="parts_comments" default="">
		<cfargument name="purchase_timeframe" default="">
		<cfargument name="payment_plan" default="">
		<cfargument name="fmc_start_date" default="">
		<cfargument name="fmc_end_date" default="">
		<cfargument name="mileage_min" default="">
		<cfargument name="mileage_max" default="">
		<cfargument name="year_min" default="">
		<cfargument name="year_max" default="">
		<cfargument name="price_min" default="">
		<cfargument name="price_max" default="">

		<cfset variables.adf_email=arguments.adf_email>

		<cfif len(trim(arguments.v_vin)) gt 0>
			<cfstoredproc datasource="Ultra10" procedure="Get_Vehicle_Details">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(arguments.v_vin,17)#" maxlength="21">
				<cfprocresult name="Get_Vehicle_Details" resultset="1">
			</cfstoredproc>
			<cfif Get_Vehicle_Details.Recordcount gt 0>
				<cfset arguments.v_stock=Get_Vehicle_Details.Stock>
				<cfset arguments.new_used=Get_Vehicle_Details.V_New_Used>
				<cfset arguments.v_year=Get_Vehicle_Details.V_Year>
				<cfset arguments.v_make=Get_Vehicle_Details.V_Make>
				<cfset arguments.v_model=Get_Vehicle_Details.V_Model>
				<cfset arguments.v_trim=Get_Vehicle_Details.V_Trim>
				<cfif Get_Vehicle_Details.Selling_Price neq "10000000">
					<cfset arguments.v_price=Get_Vehicle_Details.Selling_Price>
				</cfif>
			</cfif>
		</cfif>

		<cfswitch expression="#arguments.interest#">
			<cfdefaultcase>
				<cfset variables.adf_email=variables.adf_email & '<vehicle interest="#arguments.interest#">' & "#chr(10)#">
			</cfdefaultcase>
			<cfcase value="buy">
				<cfif arguments.new_used eq "N">
					<cfset arguments.new_used="new">
				<cfelse>
					<cfset arguments.new_used="used">
				</cfif>
				<cfset variables.adf_email=variables.adf_email & '<vehicle interest="buy" status="#arguments.new_used#">' & "#chr(10)#">
			</cfcase> 
		</cfswitch>
			<cfif len(trim(arguments.v_vin)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<vin>#arguments.v_vin#</vin>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_year)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<year>#arguments.v_year#</year>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_make)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<make>#arguments.v_make#</make>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_model)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<model>#arguments.v_model#</model>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_body)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<bodystyle>#arguments.v_body#</bodystyle>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_stock)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<stock>#arguments.v_stock#</stock>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_transmission)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<transmission>#arguments.v_transmission#</transmission>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_mileage)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<odometer units="mi">#arguments.v_mileage#</odometer>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_condition)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<condition>#arguments.v_condition#</condition>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_ext_color_1)) gt 0 or len(trim(arguments.v_int_color_1)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<colorcombination>' & "#chr(10)#">
				<cfif len(trim(arguments.v_int_color_1)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<interiorcolor>#arguments.v_int_color_1#</interiorcolor>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(arguments.v_ext_color_1)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<exteriorcolor>#arguments.v_ext_color_1#</exteriorcolor>' & "#chr(10)#">
				</cfif>
				<cfset variables.adf_email=variables.adf_email & '</colorcombination>' & "#chr(10)#">	
			</cfif>
			<cfif len(trim(arguments.v_ext_color_2)) gt 0 or len(trim(arguments.v_int_color_2)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<colorcombination>' & "#chr(10)#">
				<cfif len(trim(arguments.v_int_color_2)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<interiorcolor>#arguments.v_int_color_2#</interiorcolor>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(arguments.v_ext_color_2)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<exteriorcolor>#arguments.v_ext_color_2#</exteriorcolor>' & "#chr(10)#">
				</cfif>
				<cfset variables.adf_email=variables.adf_email & '</colorcombination>' & "#chr(10)#">	
			</cfif>
			<cfif len(trim(arguments.v_price)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<price>#arguments.v_price#</price>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_estimate)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<price type="appraisal">#arguments.v_estimate#</price>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_balance)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<finance>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<balance>#arguments.v_balance#</balance>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '</finance>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_condition)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<condition>#arguments.v_condition#</condition>' & "#chr(10)#">
			</cfif>
			<cfif len(trim(arguments.v_comments)) gt 0>
				<cfset variables.adf_email=variables.adf_email & '<comments>#arguments.v_comments#</comments>' & "#chr(10)#">
			</cfif>
		<cfset variables.adf_email=variables.adf_email & '</vehicle>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>

	<cffunction name="vendor_adf" description="add vendor info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">
		<cfargument name="dealer_id" required="true">

		<cfstoredproc datasource="Ultra10" procedure="Get_Dealer_Info">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
			<cfprocresult name="Get_Dealer_Info" resultset="1">
		</cfstoredproc>
		<cfif len(trim(Get_Dealer_Info.Primary_Phone)) eq 0><cfset Get_Dealer_Info.Primary_Phone=0></cfif>
		<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Phone">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@phone_id" value="#Get_Dealer_Info.Primary_Phone#" maxlength="10">
			<cfprocresult name="Get_Primary_Phone" resultset="1">
		</cfstoredproc>
		<cfstoredproc datasource="Ultra10" procedure="Get_Primary_URL">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
			<cfprocresult name="Get_Primary_URL" resultset="1">
		</cfstoredproc>

		<cfset variables.adf_email=arguments.adf_email>

		<cfset variables.adf_email=variables.adf_email & '<vendor>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<vendorname>#Get_Dealer_Info.Display_Name#</vendorname>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<contact>' & "#chr(10)#">
				<cfif len(trim(Get_Dealer_Info.Store_Contact)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<name part="full">#Get_Dealer_Info.Store_Contact#</name>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(Get_Dealer_Info.Store_Contact_Email)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<email>#Get_Dealer_Info.Store_Contact_Email#</email>' & "#chr(10)#">
				</cfif>
				<cfif len(trim(Get_Primary_Phone.Area_Code)) gt 0>
					<cfset variables.adf_email=variables.adf_email & '<phone type="phone">#Get_Primary_Phone.Area_Code#-#Get_Primary_Phone.Prefix#-#Get_Primary_Phone.Line_Number#</phone>' & "#chr(10)#">
				</cfif>
				<cfset variables.adf_email=variables.adf_email & '<address>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="1">#Get_Dealer_Info.Address_1#</street>' & "#chr(10)#">
					<cfif len(trim(Get_Dealer_Info.Address_2)) gt 0>
						<cfset variables.adf_email=variables.adf_email & '<street line="2">#Get_Dealer_Info.Address_2#</street>' & "#chr(10)#">
					</cfif>
					<cfset variables.adf_email=variables.adf_email & '<city>#Get_Dealer_Info.City#</city>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<regioncode>#Get_Dealer_Info.State#</regioncode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<postalcode>#Get_Dealer_Info.Zip#</postalcode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<country>USA</country>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<url>http://#Get_Primary_URL.Dealer_URL#</url>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '</address>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '</contact>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '</vendor>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>

	<cffunction name="provider_adf" description="add provider info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">
		<cfargument name="vanity_Source" default="">

		<cfif #arguments.vanity_Source# EQ "" >
			<cfset vanity_Source = "WorldDealer, Inc." >
			<cfset vanity_part2 = "Automotive Website Provider" >
	 	<cfelse>
			<!--- Check for Vanity Lead Source 12/30/2015 --->	
			<cfquery name="lead_srce" datasource="Ultra10" >SELECT vanity_lead_source FROM Dealers	where dealer_id = #url.dealer_id# </cfquery>  
			<cfif #lead_srce.vanity_lead_source# NEQ "" ><cfset vanity_Source = #lead_srce.vanity_lead_source# ></cfif>   
		</cfif>	
		
		<cfset vanity_part2 = "#lcase(cgi.Server_Name)#" >

		<cfset variables.adf_email=arguments.adf_email>

		<cfset variables.adf_email=variables.adf_email & '<provider>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<id sequence="1" source="GM">750037</id>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<type>Dealer Third Party Direct</type>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<name part="full" type="business">#vanity_Source#</name>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<service part="full">#vanity_part2#</service>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<url>http://www.worlddealer.net</url>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<email>wdsupport@worlddealer.net</email>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<phone type="voice">866-485-8800</phone>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<contact>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<name part="full">Kelly Brent</name>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<email>wdsupport@worlddealer.net</email>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<phone type="voice">866-485-8800</phone>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<address>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="1">101 North Meadows Drive</street>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="2">Suite 125</street>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<city>Wexford</city>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<regioncode>PA</regioncode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<postalcode>15090</postalcode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<country>USA</country>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '</address>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '</contact>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '</provider>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>


	<cffunction name="provider_purl" description="add provider info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">
		<cfargument name="vanity_Source" default="">

		<cfif #arguments.vanity_Source# EQ "" >
			<cfset vanity_Source = "WorldDealer, Inc." >
			<cfset vanity_part2 = "Automotive Website Provider" >
		<cfelse>
			<cfset vanity_Source = #arguments.vanity_Source# >
			<cfset vanity_part2 = "Marketing" >	
		</cfif>	
		
		<!--- Check for Vanity Lead Source 12/30/2015 --->	
		  <cfquery name="lead_srce" datasource="Ultra10" >SELECT vanity_lead_source FROM Dealers	where dealer_id = #url.dealer_id# </cfquery>  
		<cfif #lead_srce.vanity_lead_source# NEQ "" ><cfset vanity_Source = #lead_srce.vanity_lead_source# ><cfset vanity_part2 = "" ></cfif>   
		<!--- Check for Vanity Lead Source 12/30/2015 --->
		
		<cfset variables.adf_email=arguments.adf_email>

		<cfset variables.adf_email=variables.adf_email & '<provider>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<id sequence="1" source="GM">750037</id>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<type>Dealer Third Party Direct</type>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<name part="full" type="business">#vanity_Source#</name>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<service part="full">#vanity_part2#</service>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<url>http://www.worlddealer.net</url>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<email>wdsupport@worlddealer.net</email>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<phone type="voice">866-485-8800</phone>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<contact>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<name part="full">Kelly Brent</name>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<email>wdsupport@worlddealer.net</email>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<phone type="voice">866-485-8800</phone>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<address>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="1">101 North Meadows Drive</street>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="2">Suite 125</street>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<city>Wexford</city>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<regioncode>PA</regioncode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<postalcode>15090</postalcode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<country>USA</country>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '</address>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '</contact>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '</provider>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>

	<cffunction name="provider_trib" description="add provider info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">

		<cfset variables.adf_email=arguments.adf_email>

		<cfset variables.adf_email=variables.adf_email & '<provider>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<type>Dealer Third Party Direct</type>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<name part="full" type="business">TribLive</name>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<service part="full">News and Media</service>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<url>http://triblive.com</url>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<email>mzigarovich@tribweb.com</email>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<phone type="voice">412-321-6460</phone>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '<contact>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<name part="full">Mark Zigarovich</name>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<email>mzigarovich@tribweb.com</email>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<phone type="voice">412-321-6460</phone>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '<address>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="1">503 Martindale Street</street>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<street line="2">D.L. Clark Building, 3rd Floor</street>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<city>Pittsburgh</city>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<regioncode>PA</regioncode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<postalcode>15212</postalcode>' & "#chr(10)#">
					<cfset variables.adf_email=variables.adf_email & '<country>USA</country>' & "#chr(10)#">
				<cfset variables.adf_email=variables.adf_email & '</address>' & "#chr(10)#">
			<cfset variables.adf_email=variables.adf_email & '</contact>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '</provider>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>

	<cffunction name="footer_adf" description="add footer info to adf email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="adf_email" required="true">

		<cfset variables.adf_email=arguments.adf_email>
		<cfset variables.adf_email=variables.adf_email & '</prospect>' & "#chr(10)#">
		<cfset variables.adf_email=variables.adf_email & '</adf>' & "#chr(10)#">

		<cfreturn variables.adf_email>

	</cffunction>

</cfcomponent>