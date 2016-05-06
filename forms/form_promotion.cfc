<cfcomponent>

	<cffunction name="show_offer_v1" description="display trade-in form for featured offer variation 1" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/promotion_action.cfm">
		<cfargument name="form_mode" default="standard">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfquery datasource="Ultra10" name="Get_Popup" result="r1">
			SELECT     	Top 1 
						Dealer_ID,
						Popup_Name,
						Popup_Type,
						Nav_Image,
						Nav_Link,
						Nav_Behaviour_ID,
						Disclaimer,
						Script_Name,
						Start_Date,
						End_Date,
						BG_Color,
						Font_Color
			FROM		Dealer_Popups
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="10">
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			Nav_Behaviour_ID = 5 <cfif url.dealer_id eq 83> or nav_behaviour_id = 10</cfif>
			 
			ORDER BY	Dealer_Popup_ID
		</cfquery>
        
			<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
				<input type="hidden" id="leadLabel" name="leadLabel" value="Special Promo">
				<br/>
					<div class="row">
						<div class="col-md-12">
							&nbsp;<cfif len(Get_Popup.nav_image)>
                            		<img src="/dealer/#url.assets#/images/popups/#Get_Popup.nav_image#" class="img-responsive" />
                                   </cfif>
						</div>
						<div class="col-md-12">
							<div class="row">		
                            <div class="col-md-4" align="center"></div>						
									<div class="col-md-4 form-divider" align="center">
										<b>CONTACT INFO</b>
									</div>
							</div>
							<div class="form-group">
                            <div class="col-md-4" align="center"></div>
								<div class="col-md-4">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</div>
							</div>
							<div class="form-group">
                            <div class="col-md-4" align="center"></div>
								<div class="col-md-4">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</div>
							</div>
							<div class="form-group">
                            <div class="col-md-4" align="center"></div>
								<div class="col-md-4">
									<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
									<p class="help-block">Numbers Only - no hyphens or parentheses</p>
								</div>
							</div>
							<div class="form-group">
                            <div class="col-md-4" align="center"></div>
								<div class="col-md-4">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
									<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
								</div>
							</div>
							<div class="form-group">
                            <div class="col-md-4" align="center"></div>
								<div class="col-md-4">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Register Now">
								</div>
							</div>
						</div>
						
						
						<!--- 
						
						<div class="col-md-1">
							&nbsp;
						</div>
						<div class="col-md-4">
							<div class="row">
								<cfif arguments.form_mode eq "popup">
									<div style="color:###Get_Popup.Font_Color#;margin:5px;font-size:20px;font-weight:bold;" class="col-md-12" align="center">
										<b>YOUR CURRENT VEHICLE</b>
									</div>
								<cfelse>
									<div class="col-md-12 form-divider" align="center">
										<b>YOUR CURRENT VEHICLE</b>
									</div>
								</cfif>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" placeholder="Year" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" placeholder="Make" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" placeholder="Model" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" placeholder="Miles/Odometer" required>
								</div>
							</div>
							<cfif Get_Form_Locations.Recordcount gt 0>
								<div class="form-group">
									<div class="col-md-12">
										<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
											<option value="">Select a Dealer</option>
											<cfloop query="Get_Form_Locations">
												<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
											</cfloop> 
										</select>
									</div>
								</div>
							<cfelse>
								<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
							</cfif>
							<div class="form-group">
								<div class="col-md-12">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Register Now">
								</div>
							</div>
						</div>
						
						 --->
						
					</div>
			</form>
			<br/>

	</cffunction>

	
	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Ultra10">
		<cfargument name="leadlabel" default="Trade-In Valuation">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">

		<cfparam name="form.trade_vin" default="">
		<cfparam name="form.trade_year" default="">
		<cfparam name="form.trade_make" default="">
		<cfparam name="form.trade_model" default="">
		<cfparam name="form.trade_odometer" default="">
		<cfparam name="form.comments" default="">

		<cfparam name="form.voi_vin" default="">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.voi_stock" default="">
		<cfparam name="form.voi_year" default="">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">
		<cfparam name="form.sales_rep" default="">

		<cfif len(trim(form.voi_vin)) gt 0>
			<!---Get Vehicle Details--->
			<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Vehicle_Details">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(form.voi_vin,17)#" maxlength="21">
				<cfprocresult name="Get_Vehicle_Details" resultset="1">
			</cfstoredproc>
			<cfset form.voi_new_used=Get_Vehicle_Details.V_New_Used>
			<cfset form.voi_vin=Get_Vehicle_Details.Vin>
			<cfset form.voi_year=Get_Vehicle_Details.V_Year>
			<cfset form.voi_make=Get_Vehicle_Details.V_Make>
			<cfset form.voi_model=Get_Vehicle_Details.V_Model>
			<cfset form.voi_trim=Get_Vehicle_Details.V_Trim>
			<cfset form.voi_price=Get_Vehicle_Details.Selling_Price>
			<cfset form.delivery_dealer_id=Get_Vehicle_Details.Dealer_ID>
		</cfif>

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.first_name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Last Name: form.Last_Name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>

		<cfif len(form.trade_year) GT 0 >
				<!--- Trade Year: form.trade_year --->
				<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
					<cfinvokeargument name="text_name" value="Trade Year"/>
					<cfinvokeargument name="text_value" value="#form.trade_year#"/>
					<cfinvokeargument name="text_req" value="true"/>
					<cfinvokeargument name="error_message" value="#variables.error_message#"/>
				</cfinvoke>
				<!--- Trade Make: form.trade_make --->
				<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
					<cfinvokeargument name="text_name" value="Trade Make"/>
					<cfinvokeargument name="text_value" value="#form.trade_make#"/>
					<cfinvokeargument name="text_req" value="true"/>
					<cfinvokeargument name="error_message" value="#variables.error_message#"/>
				</cfinvoke>
				<!--- Trade Model: form.trade_model --->
				<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
					<cfinvokeargument name="text_name" value="Trade Model"/>
					<cfinvokeargument name="text_value" value="#form.trade_model#"/>
					<cfinvokeargument name="text_req" value="true"/>
					<cfinvokeargument name="error_message" value="#variables.error_message#"/>
				</cfinvoke>
				<!--- Trade Miles: form.trade_odometer --->
				<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
					<cfinvokeargument name="text_name" value="Trade Miles"/>
					<cfinvokeargument name="text_value" value="#form.trade_odometer#"/>
					<cfinvokeargument name="text_req" value="true"/>
					<cfinvokeargument name="error_message" value="#variables.error_message#"/>
				</cfinvoke>
		</cfif>
		<!--- Trade Vin: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Trade Vin"/>
			<cfinvokeargument name="text_value" value="#form.trade_vin#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Trade Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- VOI Condition: form.voi_new_used --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Condition"/>
			<cfinvokeargument name="text_value" value="#form.voi_new_used#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- VOI Make: form.voi_make --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Make"/>
			<cfinvokeargument name="text_value" value="#form.voi_make#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- VOI Model: form.voi_model --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Model"/>
			<cfinvokeargument name="text_value" value="#form.voi_model#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<!---<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>--->
			
			<cfset url.error_message=variables.error_message>

		<cfelse>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#arguments.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#form.dealer_id#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#form.delivery_dealer_id#"/>
				<cfinvokeargument name="remote_addr" value="#cgi.Remote_Addr#">
				<cfinvokeargument name="http_user_agent" value="#cgi.Http_User_Agent#">
			</cfinvoke>
	
			<cfinvoke component="/cfcs/forms/form_save" method="insert_contact" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Contact_Type_ID" value="1"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="2"/>
				<cfinvokeargument name="v_vin" value="#form.trade_vin#"/>
				<cfinvokeargument name="v_year" value="#form.trade_year#"/>
				<cfinvokeargument name="v_make" value="#form.trade_make#"/>
				<cfinvokeargument name="v_model" value="#form.trade_model#"/>
				<cfinvokeargument name="v_mileage" value="#form.trade_odometer#"/>
				<cfinvokeargument name="v_comments" value="#form.comments#"/>
			</cfinvoke>

			<cfif len(trim(form.voi_vin)) gt 0>
				<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
					<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
					<cfinvokeargument name="Vehicle_Type_ID" value="1"/>
					<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
					<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
					<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
					<cfinvokeargument name="v_year" value="#form.voi_year#"/>
					<cfinvokeargument name="v_make" value="#form.voi_make#"/>
					<cfinvokeargument name="v_model" value="#form.voi_model#"/>
					<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
					<cfinvokeargument name="v_price" value="#form.voi_price#"/>
				</cfinvoke>
			</cfif>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.delivery_dealer_id#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_send_id#" maxlength="10">
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
					<cfprocresult name="Get_Lead_Addresses" resultset="1">
				</cfstoredproc>
				<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>
			</cfif>

			<!---Generate Text Email--->

			<cfinvoke component="/cfcs/emails/text_gen" method="contact_text" returnvariable="text_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="trade_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="v_vin" value="#form.trade_vin#"/>
				<cfinvokeargument name="v_year" value="#form.trade_year#"/>
				<cfinvokeargument name="v_make" value="#form.trade_make#"/>
				<cfinvokeargument name="v_model" value="#form.trade_model#"/>
				<cfinvokeargument name="v_mileage" value="#form.trade_odometer#"/>
				<cfinvokeargument name="v_comments" value="#form.comments#"/>
			</cfinvoke>

			<cfif len(trim(form.voi_vin)) gt 0>
				<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
					<cfinvokeargument name="text_email" value="#variables.text_email#"/>
					<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
					<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
					<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
					<cfinvokeargument name="v_year" value="#form.voi_year#"/>
					<cfinvokeargument name="v_make" value="#form.voi_make#"/>
					<cfinvokeargument name="v_model" value="#form.voi_model#"/>
					<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
					<cfinvokeargument name="v_price" value="#form.voi_price#"/>
				</cfinvoke>
			</cfif>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="trade-in"/>
				<cfinvokeargument name="v_vin" value="#form.trade_vin#"/>
				<cfinvokeargument name="v_year" value="#form.trade_year#"/>
				<cfinvokeargument name="v_make" value="#form.trade_make#"/>
				<cfinvokeargument name="v_model" value="#form.trade_model#"/>
				<cfinvokeargument name="v_mileage" value="#form.trade_odometer#"/>
				<cfinvokeargument name="v_comments" value="#form.comments#"/>
			</cfinvoke>

			<cfif len(trim(form.voi_vin)) gt 0>
				<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
					<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
					<cfinvokeargument name="interest" value="buy"/>
					<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
					<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
					<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
					<cfinvokeargument name="v_year" value="#form.voi_year#"/>
					<cfinvokeargument name="v_make" value="#form.voi_make#"/>
					<cfinvokeargument name="v_model" value="#form.voi_model#"/>
					<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
					<cfinvokeargument name="v_price" value="#form.voi_price#"/>
				</cfinvoke>
			</cfif>

			<cfset variables.this_dealer_id=form.Delivery_Dealer_ID>
			
			<cfinvoke component="/cfcs/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfparam name="variables.Email_Subject" default="#arguments.leadLabel# from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
						<cfmailparam name="Reply-To" value="#form.email#">
							#variables.text_email#
						</cfmail>
						<!---<li>#Get_Lead_Addresses.Email# - Text</li>--->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
						<cfmailparam name="Reply-To" value="#form.email#">
						#variables.adf_email#
						</cfmail>
						<!---<li>#Get_Lead_Addresses.Email# - ADF</li>--->					
					</cfif>

				</cfloop>
			</cfif>
			
		</cfif>

	</cffunction>
</cfcomponent>