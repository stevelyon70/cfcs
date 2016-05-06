<cfcomponent>

	<cffunction name="contact_text" description="add contact info to text email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="Lead_ID" required="true">
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
		<cfargument name="name" default="">
		<cfargument name="ref_name" default="">
		<cfargument name="ref_email" default="">
		<cfargument name="friend_name" default="">
		
		<cfif #arguments.Lead_ID# NEQ "" >
			<cfset variables.text_email="Lead ID: #arguments.Lead_ID#">
		<cfelse>	
			<cfset variables.text_email="Recall Check Request">
		</cfif>
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "Origin: #lcase(cgi.Server_Name)#">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">

		<cfset variables.text_email=variables.text_email & "Contact Info">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "--------------------">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">

		<cfif len(trim(arguments.name)) gt 0>
			<cfset variables.text_email=variables.text_email & "Name: #arguments.name#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.first_name)) gt 0>
			<cfset variables.text_email=variables.text_email & "First Name: #arguments.first_name#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.last_name)) gt 0>
			<cfset variables.text_email=variables.text_email & "Last Name: #arguments.last_name#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.friend_name)) gt 0>
			<cfset variables.text_email=variables.text_email & "Name: #arguments.friend_name#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.email)) gt 0>
			<cfset variables.text_email=variables.text_email & "Email: #arguments.email#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.phone_1)) gt 0>
			<cfset arguments.phone_1=rereplace(arguments.phone_1, "[^\w]", "", "all")>
			<cfset arguments.phone_1="#left(arguments.phone_1,3)#-#mid(arguments.phone_1,4,3)#-#right(arguments.phone_1,4)#">		
			<cfif isvalid("telephone" ,arguments.phone_1) eq "Yes">
				<cfset variables.text_email=variables.text_email & "Daytime Phone: #arguments.phone_1#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
		</cfif>

		<cfif len(trim(arguments.phone_2)) gt 0>
			<cfset arguments.phone_2=rereplace(arguments.phone_2, "[^\w]", "", "all")>
			<cfset arguments.phone_2="#left(arguments.phone_2,3)#-#mid(arguments.phone_2,4,3)#-#right(arguments.phone_2,4)#">
			<cfif isvalid("telephone" ,arguments.phone_2) eq "Yes">
				<cfset variables.text_email=variables.text_email & "Evening Phone: #arguments.phone_2#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
		</cfif>

		<cfif len(trim(arguments.address_1)) gt 0>
			<cfset variables.text_email=variables.text_email & "Address: #arguments.address_1#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.address_2)) gt 0>
			<cfset variables.text_email=variables.text_email & "Address Line 2: #arguments.address_2#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.city)) gt 0>
			<cfset variables.text_email=variables.text_email & "City: #arguments.city#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.state)) gt 0>
			<cfset variables.text_email=variables.text_email & "State: #arguments.state#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.zip)) gt 0>
			<cfset variables.text_email=variables.text_email & "Zip: #arguments.zip#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>
		
		<cfif len(trim(arguments.best_method)) gt 0>
			<cfset variables.text_email=variables.text_email & "Best Contact Method: #arguments.best_method#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.best_time)) gt 0>
			<cfset variables.text_email=variables.text_email & "Best Contact Time: #arguments.best_time#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.sales_rep)) gt 0>
			<cfset variables.text_email=variables.text_email & "Sales Rep: #arguments.sales_rep#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>
		
		<cfif len(trim(arguments.comments)) gt 0>
			<cfset variables.text_email=variables.text_email & "Comments:">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "#arguments.comments#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.ref_name)) gt 0 or len(trim(arguments.ref_email))>
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "Referred By">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "--------------------">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.ref_name)) gt 0>
			<cfset variables.text_email=variables.text_email & "Referral Name: #arguments.ref_name#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.ref_email)) gt 0>
			<cfset variables.text_email=variables.text_email & "Referral Email: #arguments.ref_email#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>
		
		<cfreturn variables.text_email>
	
	</cffunction>

	<cffunction name="vehicle_text" description="add vehicle info to text email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="text_email" required="true">
		<cfargument name="new_used" default="N">
		<cfargument name="v_year" default="">
		<cfargument name="v_make" default="">
		<cfargument name="v_model" default="">
		<cfargument name="v_miles" default="">
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
		<cfargument name="v_payload" default="">
		<cfargument name="v_wheels" default="">
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
		<cfargument name="td_date" default="">
		<cfargument name="td_time" default="">
		<cfargument name="fmc_start_date" default="">
		<cfargument name="fmc_end_date" default="">
		<cfargument name="mileage_min" default="">
		<cfargument name="mileage_max" default="">
		<cfargument name="year_min" default="">
		<cfargument name="year_max" default="">
		<cfargument name="price_min" default="">
		<cfargument name="price_max" default="">

		<cfset variables.text_email=arguments.text_email>

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

		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "Vehicle Info">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "--------------------">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">

		<cfif len(trim(arguments.v_vin)) gt 0>
			<cfset variables.text_email=variables.text_email & "Vin: #arguments.v_vin#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_stock)) gt 0>
			<cfset variables.text_email=variables.text_email & "Stock: #arguments.v_stock#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.new_used)) gt 0>
			<cfif arguments.v_miles eq ""	>
				<cfif arguments.new_used eq 'N'>
					<cfset variables.text_email=variables.text_email & "Condition: New">
				<cfelse>
					<cfset variables.text_email=variables.text_email & "Condition: Used">
				</cfif>
				<cfset variables.text_email=variables.text_email & "#chr(10)#">		
			</cfif>	
		</cfif>

		<cfif len(trim(arguments.v_year)) gt 0>
			<cfset variables.text_email=variables.text_email & "Year: #arguments.v_year#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.year_min)) gt 0>
			<cfset variables.text_email=variables.text_email & "Year Range: #arguments.year_min# - #arguments.year_max#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_make)) gt 0>
			<cfset variables.text_email=variables.text_email & "Make: #arguments.v_make#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_model)) gt 0>
			<cfset variables.text_email=variables.text_email & "Model: #arguments.v_model#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_miles)) gt 0>
			<cfset variables.text_email=variables.text_email & "Mileage: #arguments.v_miles#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>
		
		<cfif len(trim(arguments.v_mileage)) gt 0>
			<cfset variables.text_email=variables.text_email & "Mileage: #arguments.v_mileage#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.price_min)) gt 0>
			<cfset variables.text_email=variables.text_email & "Price Range: #arguments.price_min# - #arguments.price_max#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.mileage_min)) gt 0>
			<cfset variables.text_email=variables.text_email & "Mileage Range: #arguments.mileage_min# - #arguments.mileage_max#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_body)) gt 0>
			<cfset variables.text_email=variables.text_email & "Body: #arguments.v_body#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_payload)) gt 0>
			<cfset variables.text_email=variables.text_email & "Payload: #arguments.v_payload#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_wheels)) gt 0>
			<cfset variables.text_email=variables.text_email & "Wheels: #arguments.v_wheels#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_engine)) gt 0>
			<cfset variables.text_email=variables.text_email & "Engine: #arguments.v_engine#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.td_date)) gt 0>
			<cfset variables.text_email=variables.text_email & "Test Drive Date: #arguments.td_date# - #arguments.td_time#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.parts_comments)) gt 0>
			<cfset variables.text_email=variables.text_email & "Parts Requested:">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "#arguments.parts_comments#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfreturn variables.text_email>

	</cffunction>

	<cffunction name="job_text" description="add employment info to text email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="text_email" required="true">
		<cfargument name="department" default="">
		<cfargument name="position_type" default="">
		<cfargument name="position" default="">
		<cfargument name="resume_available" default="yes">
		<cfargument name="references_available" default="yes">
		<cfargument name="work_history" default="">
		
		<cfset variables.text_email=arguments.text_email>

		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "Employment Inquiry">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "--------------------">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">

		<cfif len(trim(arguments.department)) gt 0>
			<cfset variables.text_email=variables.text_email & "Department of Interest:">
			<cfset variables.text_email=variables.text_email & "#arguments.department#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.position_type)) gt 0>
			<cfset variables.text_email=variables.text_email & "Position Type:">
			<cfset variables.text_email=variables.text_email & "#arguments.position_type#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.position)) gt 0>
			<cfset variables.text_email=variables.text_email & "Position:">
			<cfset variables.text_email=variables.text_email & "#arguments.position#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.resume_available)) gt 0>
			<cfset variables.text_email=variables.text_email & "Resume Available:">
			<cfset variables.text_email=variables.text_email & "#arguments.resume_available#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.references_available)) gt 0>
			<cfset variables.text_email=variables.text_email & "References Available:">
			<cfset variables.text_email=variables.text_email & "#arguments.references_available#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfif len(trim(arguments.work_history)) gt 0>
			<cfset variables.text_email=variables.text_email & "Work History:">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "#arguments.work_history#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>
		
		<cfreturn variables.text_email>

	</cffunction>
	
	<cffunction name="service_text" description="add service appt info to text email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="text_email" required="true">
		<cfargument name="appt_datetime_1" default="">
		<cfargument name="appt_datetime_2" default="">
		<cfargument name="appt_datetime_3" default="">
		<cfargument name="appt_contact" default="0">
		<cfargument name="appt_comments" default="">
		<cfargument name="appt_recall" default="0">

		<cfset variables.text_email=arguments.text_email>

		<cfif len(trim(arguments.appt_recall)) eq 0>
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "Service Description">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "--------------------">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
	
			<cfif len(trim(arguments.appt_comments)) gt 0>
				<cfset variables.text_email=variables.text_email & "Service Request:">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
				<cfset variables.text_email=variables.text_email & "#arguments.appt_comments#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
		<cfelse>
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "Comments">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "--------------------">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
	
			<cfif len(trim(arguments.appt_comments)) gt 0>
				<cfset variables.text_email=variables.text_email & "#arguments.appt_comments#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
		</cfif>
		
		<cfif arguments.appt_contact eq 1>

			<cfset variables.text_email=variables.text_email & "Service Date/Time: Please contact me to schedule an appointment.">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
	
		<cfelse>

			<cfif len(trim(arguments.appt_datetime_1)) gt 0>
				<cfset variables.text_email=variables.text_email & "First Choice Date/Time: #arguments.appt_datetime_1#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
	
			<cfif len(trim(arguments.appt_datetime_2)) gt 0>
				<cfset variables.text_email=variables.text_email & "Second Choice Date/Time: #arguments.appt_datetime_2#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
	
			<cfif len(trim(arguments.appt_datetime_3)) gt 0>
				<cfset variables.text_email=variables.text_email & "Third Choice Date/Time: #arguments.appt_datetime_3#">
				<cfset variables.text_email=variables.text_email & "#chr(10)#">
			</cfif>
	
		</cfif>

		<cfreturn variables.text_email>

	</cffunction>

	<cffunction name="trade_text" description="add vehicle info to text email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="text_email" required="true">
		<cfargument name="v_vin" default="">
		<cfargument name="v_year" default="">
		<cfargument name="v_make" default="">
		<cfargument name="v_model" default="">
		<cfargument name="v_mileage" default="">
		<cfargument name="v_comments" default="">

		<cfset variables.text_email=arguments.text_email>

		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "Trade Info">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "--------------------">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">

		<cfif len(trim(arguments.v_vin)) gt 0>
			<cfset variables.text_email=variables.text_email & "Trade Vin: #arguments.v_vin#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_year)) gt 0>
			<cfset variables.text_email=variables.text_email & "Trade Year: #arguments.v_year#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_make)) gt 0>
			<cfset variables.text_email=variables.text_email & "Trade Make: #arguments.v_make#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_model)) gt 0>
			<cfset variables.text_email=variables.text_email & "Trade Model: #arguments.v_model#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_mileage)) gt 0>
			<cfset variables.text_email=variables.text_email & "Mileage: #arguments.v_mileage#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">		
		</cfif>

		<cfif len(trim(arguments.v_comments)) gt 0>
			<cfset variables.text_email=variables.text_email & "Trade Comments:">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
			<cfset variables.text_email=variables.text_email & "#arguments.v_comments#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfif>

		<cfreturn variables.text_email>

	</cffunction>

	<cffunction name="rec_text" description="add recipient info to text email" output="No" access="public">

		<!--- arguments --->
		<cfargument name="text_email" required="true">
		<cfargument name="recipient_list" required="true">

		<cfset variables.text_email=arguments.text_email>		
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "Recipient List">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfset variables.text_email=variables.text_email & "--------------------">
		<cfset variables.text_email=variables.text_email & "#chr(10)#">
		<cfloop list="#arguments.recipient_list#" index="i">
			<cfset variables.text_email=variables.text_email & "#variables.i#">
			<cfset variables.text_email=variables.text_email & "#chr(10)#">
		</cfloop>

		<cfreturn variables.text_email>

	</cffunction>

</cfcomponent>