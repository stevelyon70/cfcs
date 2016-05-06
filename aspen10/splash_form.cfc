<cfcomponent>

	<cffunction name="modern_trade" description="shows standard splash trade form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="input_class" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/trade_action.cfm">

		<cfset Get_Nav=arguments.Get_Nav>
		
		<cfloop query="Get_Nav">
		
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfstoredproc datasource="Aspen10" procedure="Get_Form_Locations">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocresult name = "Get_Form_Locations" resultset="1">
				</cfstoredproc>
	
				<div class="container visible-md visible-lg">
					<div class="row">
						<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
							<div class="col-md-6">
								<img class="nav_#Get_Nav.Nav_ID#" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
							</div>
							<div class="col-md-3">
								<div class="spl-form-title" title="Contact Information">Contact Information</div>
								<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name" required><br/>
								<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required><br/>
								<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email" required><br/>
								<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)"><br/>
								<cfif Get_Form_Locations.Recordcount gt 0>
									<select class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
										<option value="">Select a Dealer</option>
										<cfloop query="Get_Form_Locations">
										<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
										</cfloop>
									</select><br/>
								<cfelse>
									<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
								</cfif>
							</div>
							<div class="col-md-3">
								<div class="spl-form-title" title="Trade-In Information">Trade-In Information</div>
								<input class="#arguments.input_class#" name="trade_year" id="trade_year" type="text" maxlength="4" onkeypress="return isNumberKey(event)" placeholder="Trade Year" required><br/>
								<input class="#arguments.input_class#" name="trade_make" id="trade_make" type="text" maxlength="50" placeholder="Trade Make" required><br/>
								<input class="#arguments.input_class#" name="trade_model" id="trade_model" type="text" maxlength="50" placeholder="Trade Model" required><br/>
								<input class="#arguments.input_class#" name="trade_odometer" id="trade_odometer" type="text" maxlength="50" onkeypress="return isNumberKey(event)" placeholder="Trade Mileage" required><br/>
								<input class="spl-form-btn #arguments.btn_pull#" type="submit" value="Value Your Trade">
							</div>
						</form>
					</div>
				</div>
				<cfbreak>
	
			</cfif>
			
		</cfloop>

	</cffunction>

	<cffunction name="legacy_trade" description="shows standard legacy splash trade form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="input_class" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/trade_action.cfm">

		<cfset Get_Nav=arguments.Get_Nav>
		
		<cfloop query="Get_Nav">
		
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfstoredproc datasource="Aspen10" procedure="Get_Form_Locations">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocresult name = "Get_Form_Locations" resultset="1">
				</cfstoredproc>
	
				<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
					<table style="width:100%;" cellpadding="0" cellspacing="0">
						<tr>
							<td style="width:500px">
								<img class="nav_#Get_Nav.Nav_ID#" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" border="0"/>
							</td>
							<td style="width:235px;padding:5px;">
								<div class="spl-form-title" title="Contact Information">Contact Information</div>
								<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'"><br/>
								<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
								<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
								<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" value="Phone" onkeypress="return isNumberKey(event)"  onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'"><br/>
								<cfif Get_Form_Locations.Recordcount gt 0>
									<select class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
										<option value="">Select a Dealer</option>
										<cfloop query="Get_Form_Locations">
										<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
										</cfloop>
									</select><br/>
								<cfelse>
									<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
								</cfif>
							</td>
							<td style="width:235px;padding:5px;">
								<div class="spl-form-title" title="Trade-In Information">Trade-In Information</div>
								<input class="#arguments.input_class#" name="trade_year" id="trade_year" type="text" maxlength="4" onkeypress="return isNumberKey(event)" value="Trade Year" onfocus="if (this.value=='Trade Year') this.value = ''" onblur="if (this.value=='') this.value = 'Trade Year'" required><br/>
								<input class="#arguments.input_class#" name="trade_make" id="trade_make" type="text" maxlength="50" value="Trade Make" onfocus="if (this.value=='Trade Make') this.value = ''" onblur="if (this.value=='') this.value = 'Trade Make'"><br/>
								<input class="#arguments.input_class#" name="trade_model" id="trade_model" type="text" maxlength="50" value="Trade Model" onfocus="if (this.value=='Trade Model') this.value = ''" onblur="if (this.value=='') this.value = 'Trade Model'"><br/>
								<input class="#arguments.input_class#" name="trade_odometer" id="trade_odometer" type="text" maxlength="50" value="Trade Miles" onkeypress="return isNumberKey(event)"  onfocus="if (this.value=='Trade Miles') this.value = ''" onblur="if (this.value=='') this.value = 'Trade Miles'"><br/>
								<input class="spl-form-btn #arguments.btn_pull#" type="submit" value="Value Your Trade">
							</td>
						</tr>
					</table>
				</form>
				<cfbreak>
	
			</cfif>
			
		</cfloop>
	
	</cffunction>

</cfcomponent>