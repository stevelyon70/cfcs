<cfcomponent>

	<cffunction name="validate" description="Server Side Validation of Form Data" output="no" access="public">

		<!--- arguments --->
		<cfargument name="pin" default="">
		<cfargument name="pin_req" default="false">
		<cfargument name="first_name" default="">
		<cfargument name="first_name_req" default="true">
		<cfargument name="last_name" default="">
		<cfargument name="last_name_req" default="true">
		<cfargument name="email" default="">
		<cfargument name="email_req" default="true">
		<cfargument name="phone_1" default="">
		<cfargument name="phone_1_name" default="Daytime Phone">
		<cfargument name="phone_1_req" default="false">
		<cfargument name="phone_2" default="">
		<cfargument name="phone_2_name" default="Evening Phone">
		<cfargument name="phone_2_req" default="false">
		<cfargument name="address_1" default="">
		<cfargument name="address_1_req" default="">
		<cfargument name="address_2" default="">
		<cfargument name="address_2_req" default="">
		<cfargument name="city" default="">
		<cfargument name="city_req" default="">
		<cfargument name="state" default="">
		<cfargument name="state_req" default="">
		<cfargument name="zip" default="">
		<cfargument name="zip_req" default="">
		<cfargument name="comments" default="">
		<cfargument name="comments_req" default="false">
		<cfargument name="v_year" default="">
		<cfargument name="v_make" default="">
		<cfargument name="v_model" default="">
		<cfargument name="v_trim" default="">

		<!--- error message --->
		<cfset variables.error_message="">
		
		<!--- First Name Validation --->
		<cfif arguments.first_name eq "First Name"><cfset arguments.first_name=""></cfif>
		<cfif arguments.first_name_req eq "true" and  arguments.last_name_req eq "true">
			<cfif len(trim(arguments.first_name)) gt 0 and len(trim(arguments.last_name)) gt 0>
				<cfif arguments.first_name eq arguments.last_name>
					<cfset variables.error_message=listappend(variables.error_message,"First Name and Last Name cannot be the same.")>
				</cfif>
			</cfif>
		</cfif>
		<cfif arguments.first_name_req eq "true">
			<cfif len(trim(arguments.first_name)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"First Name cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.first_name)) gt 0>
			<cfif REFind("<[^>]*>", arguments.first_name) neq 0 or arguments.first_name contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your First Name.")>
			</cfif>
		</cfif>

		<!--- Last Name Validation --->
		<cfif arguments.last_name eq "Last Name"><cfset arguments.last_name=""></cfif>
		<cfif arguments.last_name_req eq "true">
			<cfif len(trim(arguments.last_name)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"Last Name cannot be blank.")>			
			</cfif>
		</cfif>
		<cfif len(trim(arguments.last_name)) gt 0>
			<cfif REFind("<[^>]*>", arguments.last_name) neq 0 or arguments.last_name contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your Last Name.")>
			</cfif>
		</cfif>

		<!---Email Validation--->
		<cfif arguments.email eq "Email"><cfset arguments.email=""></cfif>
		<cfif arguments.email_req eq "true" or len(trim(arguments.email)) gt 0>
			<cfif isvalid("email",arguments.email) eq "No" >
				<cfset variables.error_message=listappend(variables.error_message,"Invalid Email Address.")>
			</cfif>
		</cfif>

		<!---Phone 1 Validation--->
		<cfif arguments.phone_1 eq "Phone"><cfset arguments.phone_1=""></cfif>
		<cfif arguments.phone_1_req eq "true" or len(trim(arguments.phone_1)) gt 0>
			<cfif isvalid("telephone",arguments.phone_1) eq "No" >
				<cfset variables.error_message=listappend(variables.error_message,"Invalid #arguments.phone_1_name#.")>
			</cfif>
		</cfif>

		<!---Phone 2 Validation--->
		<cfif arguments.phone_2 eq "Phone"><cfset arguments.phone_2=""></cfif>
		<cfif arguments.phone_2_req eq "true" or len(trim(arguments.phone_2)) gt 0>
			<cfif isvalid("telephone",arguments.phone_2) eq "No" >
				<cfset variables.error_message=listappend(variables.error_message,"Invalid #arguments.phone_2_name#.")>
			</cfif>
		</cfif>

		<!--- Address Validation --->
		<cfif arguments.address_1_req eq "true">
			<cfif len(trim(arguments.address_1)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"Address Line 1 cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.address_1)) gt 0>
			<cfif REFind("<[^>]*>", arguments.address_1) neq 0 or arguments.address_1 contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your Address Line 1.")>
			</cfif>
		</cfif>

		<!--- Address 2 Validation --->
		<cfif arguments.address_2_req eq "true">
			<cfif len(trim(arguments.address_2)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"Address Line 2 cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.address_2)) gt 0>
			<cfif REFind("<[^>]*>", arguments.address_2) neq 0 or arguments.address_2 contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your Address Line 2.")>
			</cfif>
		</cfif>

		<!--- City Validation --->
		<cfif arguments.city_req eq "true">
			<cfif len(trim(arguments.city)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"City cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.city)) gt 0>
			<cfif REFind("<[^>]*>", arguments.city) neq 0 or arguments.city contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your City.")>
			</cfif>
		</cfif>

		<!--- State Validation --->
		<cfif arguments.state_req eq "true">
			<cfif len(trim(arguments.state)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"State cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.state)) gt 0>
			<cfif REFind("<[^>]*>", arguments.state) neq 0 or arguments.state contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your State.")>
			</cfif>
		</cfif>
		
		<!---Zip Validation--->
		<cfif arguments.zip_req eq "true" or len(trim(arguments.zip)) gt 0>
			<cfif isvalid("zipcode",arguments.zip) eq "No" >
				<cfset variables.error_message=listappend(variables.error_message,"Invalid Zipcode.")>
			</cfif>
		</cfif>

		<!---Comments Validation--->
		<cfif arguments.comments eq "Comments"><cfset arguments.comments=""></cfif>
		<cfif arguments.comments_req eq "true">
			<cfif len(trim(arguments.comments)) eq 0>
				<cfset variables.error_message=listappend(variables.error_message,"Comments cannot be blank.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.comments)) gt 0>
			<cfif REFind("<[^>]*>", arguments.comments) neq 0 or arguments.comments contains "http">
				<cfset variables.error_message=listappend(variables.error_message,"Please do not include ANY code&##44; email addresses or links in your Comments.")>
			</cfif>
		</cfif>

		<cfreturn variables.error_message>
		
	</cffunction>

	<cffunction name="insert_lead" description="Inserts basic lead data into db" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="lead_type_id" required="true">
		<cfargument name="department_id" default="0">
		<cfargument name="dealer_id" default="0">
		<cfargument name="delivery_dealer_id" default="0">
		<cfargument name="myid" default="#replace(createUUID(),'-','','all')#">
		<cfargument name="date_submitted" default="#now()#">
		<cfargument name="remote_addr" default="#cgi.remote_addr#">
		<cfargument name="http_user_agent" default="#cgi.http_user_agent#">
		<cfargument name="application_type" default="">
		<cfargument name="credit_type" default="">
		<cfargument name="privacy_affiliates" default="0">
		<cfargument name="privacy_market" default="0">
		<cfargument name="toyota_motor_credit" default="0">
		<cfargument name="dealercode_legacy" default="">
		<cfargument name="delivery_id_legacy" default="">
		<cfargument name="lead_id_legacy" default="0">

		
		<cfif #url.dealer_id# EQ 233 >
			<cfset arguments.delivery_dealer_id = #url.dealer_id# >
					<!--- cf_sql_integer" #arguments.lead_type_id#,<br>
					cf_sql_integer" #ReReplaceNoCase(arguments.dealer_id,'[^0-9]','','ALL')#,<br>
					cf_sql_integer" #ReReplaceNoCase(arguments.dealer_id,'[^0-9]','','ALL')#,<br>
					cf_sql_integer" #arguments.department_id#,<br>
					cf_sql_varchar" #arguments.myid#,<br>
					#createodbcdatetime(arguments.date_submitted)#,<br>
					cf_sql_varchar" #left(arguments.remote_addr,20)#,<br>
					cf_sql_varchar" #left(arguments.http_user_agent,500)#,<br>
					cf_sql_varchar" #arguments.application_type#<br>
					cf_sql_varchar" #arguments.credit_type#<br>
					cf_sql_bit" #arguments.privacy_affiliates#,<br>
					cf_sql_bit" #arguments.privacy_market#,<br>
					cf_sql_bit" #arguments.toyota_motor_credit#><br>
					
		<cfabort>			 --->
		
		</cfif>
		
		
		
	
		<cfquery datasource="Leads" name="Insert_Lead">
			INSERT INTO	Leads
				(	
					Lead_Type_ID,
					Dealer_ID,
					Delivery_Dealer_ID,
					Department_ID,
					UUID,
					Date_Submitted,
                    Remote_Addr,
                    Http_User_Agent,
					Application_Type,
					Credit_Type,
					Privacy_Affiliates,
					Privacy_Market,
					Toyota_Motor_Credit<!--- ,				<!--- 12/03/2015 --->
                    Dealercode_Legacy,
                    Delivery_ID_Legacy --->
				)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.lead_type_id#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#ReReplaceNoCase(arguments.dealer_id,'[^0-9]','','ALL')#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#ReReplaceNoCase(arguments.delivery_dealer_id,'[^0-9]','','ALL')#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.department_id#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.myid#" maxlength="50">,
					#createodbcdatetime(arguments.date_submitted)#,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.remote_addr,20)#" maxlength="20">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.http_user_agent,500)#" maxlength="500">,
					<cfif len(trim(arguments.application_type)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.application_type#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.credit_type)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.credit_type#" maxlength="50"><cfelse>NULL</cfif>,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.privacy_affiliates#" maxlength="1">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.privacy_market#" maxlength="1">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.toyota_motor_credit#" maxlength="1"><!--- ,
					<cfif len(trim(arguments.dealercode_legacy)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dealercode_legacy#" maxlength="30"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.delivery_id_legacy)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.delivery_id_legacy#" maxlength="30"><cfelse>NULL</cfif>  --->
				)
				
			SELECT SCOPE_IDENTITY() as New_ID
		</cfquery>
	
		<cfreturn Insert_Lead.New_ID>
	
	</cffunction>

	<cffunction name="insert_contact" description="insert contact info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="New_ID" required="true">
		<cfargument name="Contact_Type_ID" required="true">

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

		<cfif len(trim(arguments.phone_1)) gt 0>
			<cfset arguments.phone_1=rereplace(arguments.phone_1, "[^\w]", "", "all")>
			<cfset arguments.phone_1="#left(arguments.phone_1,3)#-#mid(arguments.phone_1,4,3)#-#right(arguments.phone_1,4)#">		
		</cfif>
		<cfif len(trim(arguments.phone_2)) gt 0>
			<cfset arguments.phone_2=rereplace(arguments.phone_2, "[^\w]", "", "all")>
			<cfset arguments.phone_2="#left(arguments.phone_2,3)#-#mid(arguments.phone_2,4,3)#-#right(arguments.phone_2,4)#">		
		</cfif>
		

		<cfquery datasource="Leads" name="Save_Contact">
			INSERT INTO	Contacts
				(	
					Lead_ID,
					Contact_Type_ID,
					First_Name,
					Middle_Name,
					Last_Name,
					Suffix,
                    Email,
                    Phone_1,
                    Phone_2,
                    Fax,
                    Address_1,
                    Address_2,
                    City,
                    State,
                    Zip,
                    SSN,
                    DOB,
                    License,
                    Comments,
                    Business_Name,
                    Tax_ID,
                    Sales_Rep,
                    Best_Time,
                    Best_Method,
                    Relationship
				)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.New_ID#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Contact_Type_ID#" maxlength="10">,
					<cfif len(trim(arguments.first_name)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#" maxlength="100"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.middle_name)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.middle_name,1)#" maxlength="1"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.last_name)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#" maxlength="100"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.suffix)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.suffix#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif isvalid("email",arguments.email) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#" maxlength="100"><cfelse>NULL</cfif>,
					<cfif isvalid("telephone",arguments.phone_1) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_1#" maxlength="20"><cfelse>NULL</cfif>,
					<cfif isvalid("telephone",arguments.phone_2) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_2#" maxlength="20"><cfelse>NULL</cfif>,
					<cfif isvalid("telephone",arguments.fax) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.fax#" maxlength="20"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.address_1)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address_1#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.address_2)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address_2#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.city)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.state)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif isvalid("zipcode",arguments.zip) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zip#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.ssn)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ssn#" maxlength="12"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.dob)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dob#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.license)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.license#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif 	len(trim(arguments.comments)) gt 0 
							and REFind("<[^>]*>", arguments.comments) eq 0 
							and arguments.comments does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.comments,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>,
					<cfif len(trim(arguments.business_name)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.business_name#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.tax_id)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Tax_ID#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.sales_rep)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sales_rep#" maxlength="100"><cfelse>NULL</cfif>,
					<cfif 	len(trim(arguments.best_time)) gt 0
							and REFind("<[^>]*>", arguments.best_time) eq 0 
							and arguments.best_time does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.best_time#" maxlength="50">
					<cfelse>
						NULL
					</cfif>,
					<cfif 	len(trim(arguments.best_method)) gt 0
							and REFind("<[^>]*>", arguments.best_method) eq 0 
							and arguments.best_method does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.best_method#" maxlength="50">
					<cfelse>
						NULL
					</cfif>,
					<cfif len(trim(arguments.relationship)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.relationship#" maxlength="50"><cfelse>NULL</cfif>
				)
				
			SELECT SCOPE_IDENTITY() as Contact_ID
		</cfquery>
		
		<cfreturn Save_Contact.Contact_ID>
	
	</cffunction>
	
	<cffunction name="insert_vehicle" description="insert vehicle info" output="Yes" access="public">

		<!---	Vehicle Types
			1 - Buy
			2 - Trade
			3 - Service
			4 - Test Drive
			5 - Rent
			6 - Service
			7 - Parts
			8 - Send To Friend
		--->
		
		<!--- arguments --->
		<cfargument name="New_ID" required="true">
		<cfargument name="Vehicle_Type_ID" required="true">

		<cfargument name="new_used" default="">
		<cfargument name="v_year" default="">
		<cfargument name="v_make" default="">
		<cfargument name="v_model" default="">
		<cfargument name="v_trim" default="">
		<cfargument name="v_price" default="">
		<cfargument name="v_offer" default="">
		<cfargument name="v_vin" default="">
		<cfargument name="v_stock" default="">
		<cfargument name="v_body" default="">
		<cfargument name="v_payload" default="">
		<cfargument name="v_wheels" default="">
		<cfargument name="v_fuel" default="">
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

<!--- Try to remove commas from integer fields 08/12/2015 --->		
		<cfset arguments.price_min = replace(arguments.price_min,",","","ALL") >
		<cfset arguments.price_max = replace(arguments.price_max,",","","ALL") >
		
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

		<cfset var Save_Vehicle = "">
		
		<cfquery datasource="Leads" name="Save_Vehicle">
			INSERT INTO		Vehicles

				( 	
					Lead_ID,
					Vehicle_Type_ID,

					V_NewUsed,
					Vin,
					Stock,
					V_Year,
					V_Make,
					V_Model,
					V_Trim,
					V_Selling_Price,
					V_Offer,
					V_Body,
					V_Payload,
					V_Wheels,
					V_Fuel,
					V_Exterior_Color,
					V_Exterior_Color_2,
					V_Interior_Color,
					V_Interior_Color_2,
					V_Transmission,
					V_Engine,
					V_Options,
					V_Seating,
					V_License_Plate,
					V_Mileage,
					V_Cash_Down, 
					V_Monthly_Payment,
					V_Balance,
					V_Estimated_Value,
					V_Condition,
					Comments,

					Parts_Comments,
					
					Purchase_Timeframe,
					Payment_Plan,
					
					FMC_Start_Date,
					FMC_End_Date,
					Mileage_Min,
					Mileage_Max,
					Year_Min,
					Year_Max,
					Price_Min,
					Price_Max

				)
			VALUES

				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.New_ID#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Vehicle_Type_ID#" maxlength="10">,

					<cfif len(trim(arguments.New_Used)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.New_Used#" maxlength="1"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_vin)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.v_vin,17)#" maxlength="21"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_stock)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_stock#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_year) eq "Yes" ><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_year#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_make)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_make#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_model)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_model#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_trim)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_trim#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_price) eq "Yes" ><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_price#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_offer) eq "Yes" ><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_offer#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_body)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_body#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_payload)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_payload#" maxlength="100"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_wheels)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_wheels#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_fuel)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_fuel#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_ext_color_1)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_ext_color_1#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_ext_color_2)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_ext_color_2#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_int_color_1)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_int_color_1#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_int_color_2)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_int_color_2#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_transmission)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_transmission#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_engine)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_engine#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif 	len(trim(arguments.v_options)) gt 0 
							and REFind("<[^>]*>", arguments.v_options) eq 0 
							and arguments.v_options does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.v_options,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>,
					<cfif 	len(trim(arguments.v_seating)) gt 0 
							and REFind("<[^>]*>", arguments.v_seating) eq 0 
							and arguments.v_seating does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.v_seating,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>,
					<cfif len(trim(arguments.v_license_plate)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_license_plate#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_mileage) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#replace(arguments.v_mileage, chr(44), '')#" maxlength="10"><cfelse>NULL</cfif>,					
					<cfif isvalid("integer",arguments.v_cash_down) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_cash_down#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_monthly_payment) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_monthly_payment#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_balance) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_balance#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.v_estimate) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.v_estimate#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.v_condition)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.v_condition#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif 	len(trim(arguments.v_comments)) gt 0 
							and REFind("<[^>]*>", arguments.v_comments) eq 0 
							and arguments.v_comments does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.v_comments,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>,

					<cfif 	len(trim(arguments.parts_comments)) gt 0 
							and REFind("<[^>]*>", arguments.parts_comments) eq 0 
							and arguments.parts_comments does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.parts_comments,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>,
					
					<cfif len(trim(arguments.purchase_timeframe)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.purchase_timeframe#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.payment_plan)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.payment_plan#" maxlength="10"><cfelse>NULL</cfif>,

					<cfif isvalid("usdate" ,arguments.fmc_start_date) eq "Yes"><cfqueryparam cfsqltype="cf_sql_date" value="#arguments.fmc_start_date#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("usdate",arguments.fmc_end_date) eq "Yes"><cfqueryparam cfsqltype="cf_sql_date" value="#arguments.fmc_end_date#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.mileage_min) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#REReplaceNoCase(arguments.mileage_min, ",", "" , "ALL" )#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.mileage_max) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#REReplaceNoCase(arguments.mileage_max, ",", "" , "ALL" )#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.year_min) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.year_min#" maxlength="4"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.year_max) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.year_max#" maxlength="4"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.price_min) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.price_min#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.price_max) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.price_max#" maxlength="10"><cfelse>NULL</cfif>
				)
		</cfquery>
			
	</cffunction>

	<cffunction name="insert_appt" description="insert appt info" output="Yes" access="public">

		<!--- Appt Types
			1 - Test Drive
			2 - Service
			3 - Finance
			 --->
		
		
		<!--- arguments --->
		<cfargument name="New_ID" required="true">
		<cfargument name="appt_type_ID" required="true">

		<cfargument name="appt_datetime_1" default="">
		<cfargument name="appt_datetime_2" default="">
		<cfargument name="appt_datetime_3" default="">
		<cfargument name="appt_contact" default="">
		<cfargument name="appt_comments" default="">

		<cfset var Save_Appt = "">
		
		<cfquery datasource="Leads" name="Save_Appt">
			INSERT INTO	Appointments
				(
					Lead_ID,
					Appt_Type_ID,
					Appt_DateTime_1,
					Appt_DateTime_2,
					Appt_DateTime_3,
					Appt_Contact,
					Appt_Comments
				)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.New_ID#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appt_type_ID#" maxlength="10">,
					<cfif len(trim(arguments.appt_datetime_1)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appt_datetime_1#" maxlength="30"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.appt_datetime_2)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appt_datetime_2#" maxlength="30"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.appt_datetime_3)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appt_datetime_3#" maxlength="30"><cfelse>NULL</cfif>,
					<cfif arguments.appt_contact eq 1>1<cfelse>0</cfif>,
					<cfif 	len(trim(arguments.appt_comments)) gt 0 
							and REFind("<[^>]*>", arguments.appt_comments) eq 0 
							and arguments.appt_comments does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.appt_comments,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>
				)
		</cfquery>

	</cffunction>

	<cffunction name="insert_residence" description="insert residence info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="New_ID" required="true">
		<cfargument name="Contact_ID" required="true">
		<cfargument name="res_ownership" default="">
		<cfargument name="res_length" default="">
		<cfargument name="res_mortgage" default="">
		<cfargument name="res_payment" default="">
		<cfargument name="res_previous" default="">

		<cfset var Save_Residence = "">
		
		<cfquery datasource="Leads" name="Save_Residence">
			INSERT INTO	Residences
				(
					Lead_ID,
					Contact_ID,
					Res_Ownership,
					Res_Length,
					Res_Mortgage,
					Res_Payment,
					Res_Previous
				)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.New_ID#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Contact_ID#" maxlength="10">,

					<cfif len(trim(arguments.res_ownership)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.res_ownership#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.res_length)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.res_length#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.res_mortgage)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.res_mortgage#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.res_payment)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.res_payment#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif 	len(trim(arguments.res_previous)) gt 0 
							and REFind("<[^>]*>", arguments.res_previous) eq 0 
							and arguments.res_previous does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.res_previous,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>
				)
		</cfquery>

	</cffunction>

	<cffunction name="insert_employment" description="insert employment info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="New_ID" required="true">
		<cfargument name="Contact_ID" required="true">
		<cfargument name="employer" default="">
		<cfargument name="business_type" default="">
		<cfargument name="title" default="">
		<cfargument name="income" default="">
		<cfargument name="emp_length" default="">
		<cfargument name="work_address_1" default="">
		<cfargument name="work_address_2" default="">
		<cfargument name="work_city" default="">
		<cfargument name="work_state" default="">
		<cfargument name="work_zip" default="">
		<cfargument name="work_phone" default="">
		<cfargument name="other_income" default="">
		<cfargument name="other_income_source" default="">
		<cfargument name="other_income_length" default="">
		<cfargument name="emp_prev" default="">

		<cfset var Save_Employment = "">
		
		<cfquery datasource="Leads" name="Save_Employment">
			INSERT INTO	Employers
				(
					Lead_ID,
					Contact_ID,
					Employer,
					Title,
					Business_Type,
					Income,
					Emp_Length,
					Address_1,
					Address_2,
					City,
					State,
					Zip,
					Phone,
					Other_Income,
					Other_Income_Source,
					Other_Income_Length,
					Emp_Prev
				)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.New_ID#" maxlength="10">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Contact_ID#" maxlength="10">,

					<cfif len(trim(arguments.employer)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.employer#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.title)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.business_type)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.business_type#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.income) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.income#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.emp_length)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emp_length#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.work_address_1)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_address_1#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.work_address_2)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_address_2#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.work_city)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_city#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.work_state)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_state#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif isvalid("zipcode",arguments.work_zip) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_zip#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif isvalid("telephone",arguments.work_phone) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_phone#" maxlength="20"><cfelse>NULL</cfif>,
					<cfif isvalid("integer",arguments.other_income) eq "Yes"><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.other_income#" maxlength="10"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.other_income_source)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.other_income_source#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.other_income_length)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.other_income_length#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif 	len(trim(arguments.emp_prev)) gt 0 
							and REFind("<[^>]*>", arguments.emp_prev) eq 0 
							and arguments.emp_prev does not contain "http">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.emp_prev,1000)#" maxlength="1000">
					<cfelse>
						NULL
					</cfif>
				)
		</cfquery>

	</cffunction>

	<cffunction name="insert_job" description="insert job info" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="New_ID" required="true">
		<cfargument name="department" default="">
		<cfargument name="position_type" default="">
		<cfargument name="resume_available" default="yes">
		<cfargument name="references_available" default="yes">
		<cfargument name="resume_file" default="">
		
		<cfset var Save_Job = "">
		
		<cfquery datasource="Leads" name="Save_Job">
			INSERT INTO	Jobs
				(
					Lead_ID,
					Department,
					Position_Type,
					Resume,
					Job_References,
					Resume_File
				)
			VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.New_ID#" maxlength="10">,
					<cfif len(trim(arguments.department)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.department#" maxlength="100"><cfelse>NULL</cfif>,
					<cfif len(trim(arguments.position_type)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.position_type#" maxlength="50"><cfelse>NULL</cfif>,
					<cfif arguments.resume_available eq "yes">1<cfelse>0</cfif>,
					<cfif arguments.references_available eq "yes">1<cfelse>0</cfif>,
					<cfif len(trim(arguments.resume_file)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.resume_file#" maxlength="100"><cfelse>NULL</cfif>
				)
		</cfquery>

	</cffunction>
	
	<cffunction name="check_submit" description="Checks to see if a user is submitting multiple times - designed to prevent spambots" output="Yes" access="public">
	
		<cfset var Check_IP="">
		<cfset var check_last_submit=DateAdd("n", -10, "#now()#")>

		<cfset variables.tech_email="bob@worlddealer.net">
		
		<cfquery datasource="Leads" name="Check_IP">
			SELECT 	count(Lead_id) as count
			FROM	Leads
			WHERE	Remote_Addr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(cgi.remote_addr,20)#" maxlength="20">
			AND		Date_Submitted > #createodbcdatetime(check_last_submit)#
			AND		Remote_Addr not like '172.16.25%'
		</cfquery>
		
		<cfif Check_IP.count gte 10>

			<div>We're sorry.</div> 
			<div>Our system has detected that you have submitted 10 or more inquiries in the past 10 minutes.</div>
			<div>Please wait a bit before submitting more inquiries.</div>
	
			<cfquery datasource="Leads" name="Check_Warning">
				SELECT     	Remote_Addr,
							Warned,
							Server_Name
				FROM        Lead_Warnings
				WHERE		Remote_Addr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(cgi.remote_addr,20)#" maxlength="20">
			</cfquery>
	
			<cfif Check_Warning.Recordcount eq 0>

				<cfquery datasource="Leads" name="Log_Warning">
					INSERT INTO	Lead_Warnings
						(Remote_Addr,
						Server_Name)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(cgi.remote_addr,20)#" maxlength="20">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(cgi.server_name,100)#" maxlength="100">
						)
				</cfquery>
					
				<cfmail to="#variables.tech_email#" from="form_security@WorldDealer.net" subject="Alert! Possible Spambot Detected!">
					Warning issued to ip address: #cgi.remote_addr# - #cgi.server_name#
				</cfmail>
			</cfif>

			<cfabort>
	
		</cfif>

	</cffunction>

</cfcomponent>