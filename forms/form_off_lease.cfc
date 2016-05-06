<cfcomponent>
	
	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/off_lease.cfm">

		<cfset var Get_Form_Locations="">
	<!--- 	
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc> --->

		<div class="row">
			<div class="form-group">
				<div class="col-md-12" align="center">
					<img src="http://faulknermazda.com/dealer/faulknermazda/images/img_MazdaCapitalServices.jpg" alt="Mazda Capital Services"/>
						<div class="row">&nbsp;</div><div class="row"><div class="col-md-3"></div>
							<div class="col-md-6 " align="left">
					We hope you have enjoyed leasing your Mazda vehicle; we want to continue to provide you with excellent service as you approach the end of your lease.  If you are within 90 days of your Mazda lease turn-in date, now is the time to schedule your lease end analysis.<br/><br/>
					You have options regarding your Mazda lease end and we know you may have questions regarding the lease turn-in procedure, such as:<br/><br/>
					<ul>
						<li>Where do I drop off my leased Mazda?</li>
						<li>Will I owe any fees?</li>
						<li>Does it make sense to lease another Mazda?</li>
					</ul>
					<br/><br/>
					At Faulkner Mazda, our lease end coordinator is ready to assist you in any way they can to make your Mazda lease end transition as smooth as possible.  Please use the form to the right to schedule your Lease End Analysis today!
				</div></div>
				</div>
			</div>
		</div>
		<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" id="voi_new_used" name="voi_new_used" value="N">
				<div class="form-group">
					<div class="col-md-2"></div>
					<div class="col-md-8 form-divider" align="center">
						<b>Contact Information</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-5">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-5">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Phone_1"><span class="txt-red">*</span>Daytime Phone</label>
					<div class="col-md-5">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" required>
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Phone_2">Evening Phone</label>
					<div class="col-md-5">
						<input name="Phone_2" class="form-control input-md" id="Phone_2" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-5">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="best_contact">Best Contact Method :</label>
					<div class="col-md-5">                     
						<select class="form-control input-md" name="best_contact" id="best_contact">
									<option value="Email">Email</option>
									<option value="Daytime Phone">Daytime Phone</option>
									<option value="Evening Phone">Evening Phone</option>
								</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="best_time">Best Contact Time :</label>
					<div class="col-md-5">                     
						<select class="form-control input-md" name="best_time" id="best_time">
									<option value="Morning">Morning</option>
									<option value="Afternoon">Afternoon</option>
									<option value="Evening" selected="selected">Evening</option>
								</select>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-2"></div>
					<div class="col-md-8 form-divider" align="center">
						<b>Vehicle Information</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Trade_Vin">Vin</label>
					<div class="col-md-5">
						<input name="Trade_Vin" class="form-control input-md" id="Trade_Vin" type="text" maxlength="50" placeholder="Vin">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Trade_Year"><span class="txt-red">*</span> Year</label>
					<div class="col-md-5">
						<input name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" placeholder="Year" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Trade_Make"><span class="txt-red">*</span> Make</label>
					<div class="col-md-5">
						<input name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" placeholder="Make" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Trade_Model"><span class="txt-red">*</span> Model</label>
					<div class="col-md-5">
						<input name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" placeholder="Model" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="Trade_Odometer"><span class="txt-red">*</span> Miles</label>
					<div class="col-md-5">
						<input name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" placeholder="Miles/Odometer" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="trade_accident">Has the vehicle ever been in an accident? : </label>
					<div class="col-md-5">
						<input type="Radio" name="trade_accident" id="trade_accident" value="Yes"> Yes
								<input type="Radio" name="trade_accident" id="trade_accident" value="No" checked="checked"> No
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="comments">If yes, please describe the damage sustained : </label>
					<div class="col-md-5">
						<textarea class="form-comments-small" name="comments" id="comments" cols="70" rows="5"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="trade_frame">Has the vehicle sustained frame or Unibody damage? : </label>
					<div class="col-md-5">
						<input type="Radio" name="trade_frame" id="trade_frame" value="Yes"> Yes
								<input type="Radio" name="trade_frame" id="trade_frame" value="No" checked="checked"> No
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="trade_paint">Has the vehicle been painted anywhere? : </label>
					<div class="col-md-5">
						<input type="Radio" name="trade_paint" id="trade_paint" value="Yes"> Yes
								<input type="Radio" name="trade_paint" id="trade_paint" value="No" checked="checked"> No
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="trade_mech">To your knowledge, is the vehicle mechanically sound? : </label>
					<div class="col-md-5">
						<input type="Radio" name="trade_mech" id="trade_mech" value="Yes"> Yes
								<input type="Radio" name="trade_mech" id="trade_mech" value="No" checked="checked"> No
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="trade_lights">Are there any check engine lights on? : </label>
					<div class="col-md-5">
						<input type="Radio" name="trade_lights" id="trade_lights" value="Yes"> Yes
								<input type="Radio" name="trade_lights" id="trade_lights" value="No" checked="checked"> No
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="trade_brakes">Are the brakes in need of service or repair? : </label>
					<div class="col-md-5">
						<input type="Radio" name="trade_brakes" id="trade_brakes" value="Yes"> Yes
								<input type="Radio" name="trade_brakes" id="trade_brakes" value="No" checked="checked"> No
					</div>
				</div>
				
				<div class="form-group"> 
					<div class="col-md-2"></div>
					<div class="col-md-8 form-divider" align="center">
						<b>Lender Information</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="lender_name"><span class="txt-red">*</span>Lender Name : </label>
					<div class="col-md-5">
						<input class="form-control input-md" name="lender_name" id="lender_name" type="text" maxlength="50"/ required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="lender_last_pay">Date of Last Payment :</label>
					<div class="col-md-5">
						<input class="form-control input-md" id="lender_last_pay" name="lender_last_pay" value="" maxlength="50" type="text"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="lender_pay_left">Payments Remaining :</label>
					<div class="col-md-5">
						<input class="form-control input-md" id="lender_pay_left" name="lender_pay_left" value="" maxlength="3" type="text"/>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-5" for="Contact_Us"></label>
					<div class="col-md-5">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Submit">
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>
	
	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">
 
		<!--- arguments --->
 		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Ultra10"> 
		
		<!---default parameters--->
		  <cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.phone_2" default="">
		<cfparam name="form.best_contact" default="Email">
		<cfparam name="form.best_time" default="Evening">

		<cfparam name="form.trade_vin" default="">
		<cfparam name="form.trade_year" default="">
		<cfparam name="form.trade_make" default="">
		<cfparam name="form.trade_model" default="">
		<cfparam name="form.trade_odometer" default="">
		<cfparam name="form.trade_accident" default="No">
		<cfparam name="form.comments" default="">
		<cfparam name="form.trade_frame" default="No">
		<cfparam name="form.trade_paint" default="No">
		<cfparam name="form.trade_mech" default="No">
		<cfparam name="form.trade_lights" default="No">
		<cfparam name="form.trade_brakes" default="No">
		<cfparam name="form.lender_name" default="">
		<cfparam name="form.lender_last_pay" default="">
		<cfparam name="form.lender_pay_left" default="">

		<cfset variables.WD_BCC  ="wdsupport@worlddealer.net">
		

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

		<cfif listlen(variables.error_message) gt 0>
	
			<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>
			
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
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="best_method" value="#form.best_contact#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
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
				
				<!--- <cfmail to="bob@worlddealer.net" from="leads@worlddealer.net" subject="Off Lease Request"> --->

				 <cfmail to="#variables.recipient_list#" from="leads@worlddealer.net" bcc="#variables.WD_BCC#" subject="Off Lease Request">  
					Lead ID:  #variables.New_ID#  
					#chr(10)#
					Name: #form.first_Name# #form.last_Name#
					Daytime Phone: #form.phone_1#
					Evening Phone: #form.phone_2#
					Email: #form.email#
					Best Contact Method: #form.best_contact#
					Best Contact Time: #form.best_time#
					#chr(10)#
					Lease Year: #form.trade_year#
					Lease Make: #form.trade_make#
					Lease Model: #form.trade_model#
					Lease Miles\Odometer: #form.trade_odometer#
					Has the vehicle ever been in an accident? : #form.trade_accident#
					If yes, please describe the damage sustained :
					#form.comments#
					Has the vehicle sustained frame or Unibody damage? : #form.trade_frame#
					Has the vehicle been painted anywhere? : #form.trade_paint#
					To your knowledge, is the vehicle mechanically sound? : #form.trade_mech#
					Are there any check engine lights on? : #form.trade_lights#
					Are the brakes in need of service or repair? : #form.trade_brakes#
					#chr(10)#
					Lender Name : #form.lender_name#
					Date of Last Payment : #form.lender_last_pay#
					Payments Remaining : #form.lender_pay_left#
					#chr(10)#
				</cfmail>
	</cffunction>
</cfcomponent>