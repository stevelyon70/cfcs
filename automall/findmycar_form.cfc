<cfcomponent>

	<cffunction name="contact_form" description="contact form for automall" output="Yes" access="public">
		
		<cfargument name="automall_id" required="true">
	
		<!---Get Dealers --->
		<cfstoredproc datasource="Ultra10" procedure="Get_Automall_Dealers">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
			<cfprocresult name="Get_All_Dealers" resultset="1">
		</cfstoredproc>

		<div class="row">
			<div class="col-md-12">
				<cfparam name="url.first_name" default="">
				<cfparam name="url.last_name" default="">
				<cfparam name="url.email" default="">
				<cfparam name="url.phone_1" default="">
				<cfparam name="url.voi_new_used" default="">
				<cfparam name="url.voi_year_min" default="">
				<cfparam name="url.voi_year_max" default="">
				<cfparam name="url.voi_make" default="">
				<cfparam name="url.voi_model" default="">
				<cfparam name="url.voi_odometer" default="">
				<cfparam name="url.voi_price" default="">
				<cfparam name="url.comments" default="">
				<cfparam name="url.timeframe" default="">
				<cfparam name="url.delivery_dealer_id" default="">

				<cfif dateformat(now(),"mm") lt 6>
					<cfif len(trim(url.voi_year_min)) eq 0><cfset url.voi_year_min=dateformat(now(),"yyyy")-1></cfif>
					<cfif len(trim(url.voi_year_max)) eq 0><cfset url.voi_year_max=dateformat(now(),"yyyy")></cfif>
				<cfelse>
					<cfif len(trim(url.voi_year_min)) eq 0><cfset url.voi_year_min=dateformat(now(),"yyyy")></cfif>
					<cfif len(trim(url.voi_year_max)) eq 0><cfset url.voi_year_max=dateformat(now(),"yyyy")+1></cfif>					
				</cfif>

				<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="post">
					<fieldset>
						<input type="hidden" name="Automall_ID" value="#arguments.Automall_ID#"/>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<div class="col-md-5"></div>
									<div class="col-md-7" align="center">
										<b>Tell Us About Yourself</b>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="first_name"><em>*</em> First Name</label>
									<div class="col-md-7">
										<input name="first_name" class="form-control input-md" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="last_name"><em>*</em> Last Name</label>  
									<div class="col-md-7">
										<input name="last_name" class="form-control input-md" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="email"><em>*</em> Email</label>  
									<div class="col-md-7">
										<input name="email" class="form-control input-md" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="phone"> Phone</label>  
									<div class="col-md-7">
										<input name="phone_1" class="form-control input-md" id="phone_1" type="text" placeholder="Phone" maxlength="10" value="#url.phone_1#" />
										<span class="help-block">Numbers Only - no hypens or parentheses</span>  
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-5"></div>
									<div class="col-md-7" align="center">
										<b>Search Parameters</b>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="timeframe"><em>*</em> Search Timeframe</label>
									<div class="col-md-7">
										<select id="timeframe" name="timeframe" class="form-control input-md" required>
											<option value="">Search Timeframe</option>
											<option value="7" <cfif url.timeframe eq 7>selected</cfif>>1 Week</option>
											<option value="14" <cfif url.timeframe eq 14>selected</cfif>>2 Weeks</option>
											<option value="28" <cfif url.timeframe eq 28>selected</cfif>>4 Weeks</option>
											<option value="56" <cfif url.timeframe eq 56>selected</cfif>>8 Weeks</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="delivery_dealer_id"><em>*</em> Select A Dealer</label>
									<div class="col-md-7">
										<select id="delivery_dealer_id" name="delivery_dealer_id" class="form-control input-md" required>
											<option value="">Select A Dealer</option>
											<cfloop query="Get_All_Dealers">
												<option value="#Get_All_Dealers.Dealer_ID#" <cfif Get_All_Dealers.Dealer_ID eq url.delivery_dealer_id>selected</cfif>>#Get_All_Dealers.Display_Name#</option>
											</cfloop>
										</select>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<div class="col-md-3"></div>
									<div class="col-md-7" align="center">
										<b>Tell Us About Your Vehicle of Interest</b>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="voi_year"><em>*</em> Condition</label>
									<div class="col-md-7">
										<select id="voi_new_used" name="voi_new_used" class="form-control input-md" required>
											<option value="N" <cfif url.voi_new_used eq "N">selected</cfif>>New</option>
											<option value="U" <cfif url.voi_new_used eq "U">selected</cfif>>Pre-Owned</option>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_year_min"><em>*</em> Year Range</label>
									<div class="col-md-3">
										<select id="voi_year_min" name="voi_year_min" class="form-control input-md" required>
											<option value="">Oldest</option>
											<cfloop from="#dateformat(now(),'yyyy')#" to="#dateformat(now(),'yyyy')-20#" step="-1" index="min_year">
												<option value="#variables.min_year#" <cfif url.voi_year_min eq variables.min_year>selected</cfif>>#variables.min_year#</option>
											</cfloop>
										</select>
										<div class="form-pad visible-sm visible-xs"></div>
									</div>
									<div class="col-md-1 visible-md visible-lg" align="center">
										<label class="control-label">to</label>
									</div>
									<div class="col-md-3">
										<select id="voi_year_max" name="voi_year_max" class="form-control input-md" required>
											<option value="">Newest</option>
											<cfloop from="#dateformat(now(),'yyyy')+1#" to="#dateformat(now(),'yyyy')-20#" step="-1" index="max_year">
												<option value="#variables.max_year#" <cfif url.voi_year_max eq variables.max_year>selected</cfif>>#variables.max_year#</option>
											</cfloop>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_make"><em>*</em> Make</label>
									<div class="col-md-7">
										<select name="voi_make" id="voi_make" class="form-control input-md">
											<cfinvoke component="/cfcs/vehicles/build_options" method="get_all">
												<cfinvokeargument name="dealer_id" value="91"/>
												<cfinvokeargument name="dsn" value="ultra8"/>
												<cfinvokeargument name="data_field" value="Vehicle_Make"/>
												<cfinvokeargument name="data_table" value="Chrome_Reviews"/>
												<cfinvokeargument name="default_option" value="Choose a Make"/>
											</cfinvoke>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_model"><em>*</em> Model</label>
									<div class="col-md-7">
										<select name="voi_model" id="voi_model" class="form-control input-md">
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<!---<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_make"><em>*</em> Make</label>
									<div class="col-md-7">
										<input name="voi_make" class="form-control input-md" id="voi_make" type="text" placeholder="Make" maxlength="50" value="#url.voi_make#" required/>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_model"><em>*</em> Model</label>
									<div class="col-md-7">
										<input name="voi_model" class="form-control input-md" id="voi_model" type="text" placeholder="Model" maxlength="50" value="#url.voi_model#" required/>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>--->
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_odometer"> Mileage</label>
									<div class="col-md-7">
										<select id="voi_odometer" name="voi_odometer" class="form-control input-md">
											<option value="">Mileage</option>
											<option value="1" <cfif url.voi_odometer eq "1">selected</cfif>>Under 10,000</option>
											<option value="2" <cfif url.voi_odometer eq "2">selected</cfif>>10,000 - 20,000</option>
											<option value="3" <cfif url.voi_odometer eq "3">selected</cfif>>20,000 - 30,000</option>
											<option value="4" <cfif url.voi_odometer eq "4">selected</cfif>>30,000 - 50,000</option>
											<option value="5" <cfif url.voi_odometer eq "5">selected</cfif>>Over 50,000</option>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_price"> Price Range</label>
									<div class="col-md-7">
										<select id="voi_price" name="voi_price" class="form-control input-md">
											<option value="">Price Range</option>
											<option value="1" <cfif url.voi_price eq "1">selected</cfif>>Under $10,000</option>
											<option value="2" <cfif url.voi_price eq "2">selected</cfif>>$10,000 - $20,000</option>
											<option value="3" <cfif url.voi_price eq "3">selected</cfif>>$20,000 - $30,000</option>
											<option value="4" <cfif url.voi_price eq "4">selected</cfif>>$30,000 - $50,000</option>
											<option value="4" <cfif url.voi_price eq "5">selected</cfif>>$50,000 - $75,000</option>
											<option value="5" <cfif url.voi_price eq "6">selected</cfif>>Over $75,000</option>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="comments">Comments</label>
									<div class="col-md-7">                     
										<textarea name="comments" class="form-control" id="comments" maxlength="1000" placeholder="Comments">#url.comments#</textarea>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="control-group">
									<label class="col-md-3 control-label" for="reset"></label>
									<div class="col-md-7" align="center">
										<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
										<input type="submit" class="btn btn-primary" id="submit" value="Find My Car"/>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>								
							</div>
						</div>

					</fieldset>
				</form>
			</div>
		</div>
		<script>
			$(function() {
				var $voi_make = $('##voi_make')
				var $voi_model = $('##voi_model')
				$voi_model.load('../sites/#arguments.automall_name#/data/fmc.cfm?make=');
				$voi_make.change(function(){
					var makeName = $voi_make.val();
					$voi_model.load('../sites/#arguments.automall_name#/data/fmc.cfm?make=' + makeName);
				});
			});
		</script>

	</cffunction>
	
	<cffunction name="submit_form" description="contact form for automall" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Automall_ID" required="true">

		<!--- defaults --->
		<cfparam name="form.dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Automall_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.voi_new_used" default="U">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_odometer" default="">
		<cfparam name="form.voi_price" default="">
		<cfparam name="form.voi_year_min" default="">
		<cfparam name="form.voi_year_max" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.timeframe" default="">
		<cfparam name="form.delivery_dealer_id" default="">

		<cfif form.voi_new_used eq "N">
			<cfset variables.lead_type_id="23">
			<cfset variables.lead_send_id="4">
		<cfelse>
			<cfset variables.lead_type_id="24">
			<cfset variables.lead_send_id="6">
		</cfif>
		
		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.First_Name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.Last_Name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Last Name: form.Last_Name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.Last_Name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.Email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.Phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Select Timeframe: form.timeframe --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Timeframe"/>
			<cfinvokeargument name="int_value" value="#form.timeframe#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select a Timeframe"/>
		</cfinvoke>
		<!--- Select Dealership: form.Delivery_Dealer_ID --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Preferred Dealership"/>
			<cfinvokeargument name="int_value" value="#form.Delivery_Dealer_ID#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select a Dealership"/>
		</cfinvoke>
		<!--- Condition: form.voi_new_used --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Condition"/>
			<cfinvokeargument name="text_value" value="#form.voi_new_used#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Select Minimum Year: form.voi_year_min --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Start Year"/>
			<cfinvokeargument name="int_value" value="#form.voi_year_min#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select A Start Year"/>
		</cfinvoke>
		<!--- Select Maximum Year: form.voi_year_max --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="End Year"/>
			<cfinvokeargument name="int_value" value="#form.voi_year_max#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select An End Year"/>
		</cfinvoke>
		<!--- Make: form.voi_make --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Make"/>
			<cfinvokeargument name="text_value" value="#form.voi_make#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Model: form.voi_model --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Model"/>
			<cfinvokeargument name="text_value" value="#form.voi_model#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Select Mileage: form.voi_odometer --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Mileage"/>
			<cfinvokeargument name="int_value" value="#form.voi_odometer#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select A Mileage Range"/>
		</cfinvoke>
		<!--- Select Price Range: form.voi_price --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Price Range"/>
			<cfinvokeargument name="int_value" value="#form.voi_price#"/>
			<cfinvokeargument name="int_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Please Select A Price Range"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>

		<cfelse>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#variables.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#form.Dealer_ID#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#form.Delivery_Dealer_ID#"/>
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
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfparam name="variables.mileage_min" default="">
			<cfparam name="variables.mileage_max" default="">
			
			<cfswitch expression="#form.voi_odometer#">
				<cfcase value="1">
					<cfset variables.mileage_min="0">
					<cfset variables.mileage_max="10000">
				</cfcase>
				<cfcase value="2">
					<cfset variables.mileage_min="10001">
					<cfset variables.mileage_max="20000">
				</cfcase>
				<cfcase value="3">
					<cfset variables.mileage_min="20001">
					<cfset variables.mileage_max="30000">
				</cfcase>
				<cfcase value="4">
					<cfset variables.mileage_min="30001">
					<cfset variables.mileage_max="50000">
				</cfcase>
				<cfcase value="5">
					<cfset variables.mileage_min="50001">
					<cfset variables.mileage_max="10000000">
				</cfcase>
			</cfswitch>

			<cfparam name="variables.price_min" default="">
			<cfparam name="variables.price_max" default="">

			<cfswitch expression="#form.voi_price#">
				<cfcase value="1">
					<cfset variables.price_min="0">
					<cfset variables.price_max="10000">
				</cfcase>
				<cfcase value="2">
					<cfset variables.price_min="10001">
					<cfset variables.price_max="20000">
				</cfcase>
				<cfcase value="3">
					<cfset variables.price_min="20001">
					<cfset variables.price_max="30000">
				</cfcase>
				<cfcase value="4">
					<cfset variables.price_min="30001">
					<cfset variables.price_max="50000">
				</cfcase>
				<cfcase value="5">
					<cfset variables.price_min="50001">
					<cfset variables.price_max="75000">
				</cfcase>
				<cfcase value="6">
					<cfset variables.price_min="75001">
					<cfset variables.price_max="10000000">
				</cfcase>
			</cfswitch>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="1"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="fmc_start_date" value="#dateformat(now(),"mm/dd/yyyy")#"/>
				<cfinvokeargument name="fmc_end_date" value="#dateformat(dateadd("d","#form.timeframe#",now()),"mm/dd/yyyy")#"/>
				<cfinvokeargument name="mileage_min" value="#variables.mileage_min#"/>
				<cfinvokeargument name="mileage_max" value="#variables.mileage_max#"/>
				<cfinvokeargument name="price_min" value="#variables.price_min#"/>
				<cfinvokeargument name="price_max" value="#variables.price_max#"/>
				<cfinvokeargument name="year_min" value="#form.voi_year_min#"/>
				<cfinvokeargument name="year_max" value="#form.voi_year_max#"/>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#variables.lead_send_id#" maxlength="10">
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

			<!---Get Automall Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#variables.lead_send_id#" maxlength="10">
				<cfprocresult name="Get_Automall_Addresses" resultset="1">
			</cfstoredproc>
			<cfloop query="Get_Automall_Addresses">
				<cfset variables.recipient_list=listappend(variables.recipient_list,Get_Automall_Addresses.Email)>
			</cfloop>

			<!---If no Automall delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Automall_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Dealer_ID#" maxlength="10">
					<cfprocresult name="Get_Automall_Addresses" resultset="1">
				</cfstoredproc>
				<cfloop query="Get_Automall_Addresses">
					<cfset variables.recipient_list=listappend(variables.recipient_list,Get_Automall_Addresses.Email)>
				</cfloop>
			</cfif>

			<!---Generate Text Email--->

			<cfinvoke component="/cfcs/emails/text_gen" method="contact_text" returnvariable="text_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>


			<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="new_used" value="#form.VOI_New_Used#"/>
				<cfinvokeargument name="year_min" value="#form.voi_year_min#"/>
				<cfinvokeargument name="year_max" value="#form.voi_year_max#"/>
				<cfinvokeargument name="v_make" value="#form.VOI_Make#"/>
				<cfinvokeargument name="v_model" value="#form.VOI_Model#"/>
				<cfinvokeargument name="mileage_min" value="#variables.mileage_min#"/>
				<cfinvokeargument name="mileage_max" value="#variables.mileage_max#"/>
				<cfinvokeargument name="price_min" value="#variables.price_min#"/>
				<cfinvokeargument name="price_max" value="#variables.price_max#"/>
				<cfinvokeargument name="fmc_start_date" value="#dateformat(now(),"mm/dd/yyyy")#"/>
				<cfinvokeargument name="fmc_end_date" value="#dateformat(dateadd("d","#form.timeframe#",now()),"mm/dd/yyyy")#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Source" value="TribLive"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="buy"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year_max#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_price" value="#variables.price_max#"/>
				<cfinvokeargument name="v_mileage" value="#variables.mileage_max#"/>
				<cfinvokeargument name="v_comments" value="Delivery by: #dateformat(dateadd("d","#form.timeframe#",now()),"mm/dd/yyyy")#"/>
			</cfinvoke>

			<cfset variables.this_dealer_id=form.Delivery_Dealer_ID>
			
			<cfinvoke component="/cfcs/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="provider_trib" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfparam name="variables.Email_Subject" default="Find My Car Request from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@pittsburghautosuperstore.com">
			<!---bcc--->
			<cfparam name="variables.WD_BCC" default="wdleads@gmail.com,wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

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

			<cfif Get_Automall_Addresses.Recordcount gt 0>
				<cfloop query="Get_Automall_Addresses">
					<!---Send Text Emails--->
<cfmail to="#Get_Automall_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
<cfmailparam name="Reply-To" value="#form.email#">
#variables.text_email#
</cfmail>
				</cfloop>
			</cfif>
			
			<!---
			#form.Dealer_ID#<br/>
			#form.Delivery_Dealer_ID#<br/>
			#form.First_Name#<br/>
			#form.Last_Name#<br/>
			#form.Phone_1#<br/>
			#form.Email#<br/>
			Lead ID - #variables.New_ID#<br/>
			Contact ID - #variables.Contact_ID#
			#variables.recipient_list#
			--->
			
			<cflocation url="thank_you.cfm">

		</cfif>
	
	</cffunction>
</cfcomponent>