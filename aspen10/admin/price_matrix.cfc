<cfcomponent>
	
	<cffunction name="get_rules" description="gets active rules" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
	
		<cfif len(trim(arguments.dealer_id)) gt 0>

			<!--- Get Pricing Rules --->
			<cftransaction>
				<cfquery datasource="#arguments.DSN#" name="Get_New_Default">
					SELECT		Price_Rule_ID,
								Dealer_ID,
								Rule_Description,
								Start_Date,
								End_Date
					FROM		Price_Rules
					WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">
					AND			Active = 1
					AND			Default_Rule = 1
					AND			New_Used = 'N'
				</cfquery>
				<cfquery datasource="#arguments.DSN#" name="Get_Used_Default">
					SELECT		Price_Rule_ID,
								Dealer_ID,
								Rule_Description,
								Start_Date,
								End_Date
					FROM		Price_Rules
					WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">
					AND			Active = 1
					AND			Default_Rule = 1
					AND			New_Used = 'U'
				</cfquery>
				<cfquery datasource="#arguments.DSN#" name="Get_Rules">
					SELECT		Price_Rule_ID,
								Dealer_ID,
								Rule_Description,
								Start_Date,
								End_Date,
								Default_Rule,
								Go_Live
					FROM		Price_Rules
					WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">
					AND			Active = 1
					ORDER BY	Default_Rule Desc, Rule_Description
				</cfquery>
			</cftransaction>

			<cfif Get_New_Default.Recordcount eq 0 or Get_Used_Default.Recordcount eq 0>
				<b>Create Default Pricing Rules</b><br/><br/>
				<ul>
					<cfif Get_New_Default.Recordcount eq 0>
						<li><a href="#arguments.form_action#?dealer_id=#arguments.dealer_id#&page_action=edit_default&new_used=N&Price_Rule_ID=0">Create New Vehicle Default Rule</a></li>
					</cfif>
					<cfif  Get_Used_Default.Recordcount eq 0>
						<li><a href="#arguments.form_action#?dealer_id=#arguments.dealer_id#&page_action=edit_default&new_used=U&Price_Rule_ID=0">Create Used Vehicle Default Rule</a></li>
					</cfif>
				</ul>
				<b style="color:red;">Default Rules MUST be created before custom rules</b>
				<cfabort>
			</cfif>
			
			<table style="width:600px" celpadding="3" cellspacing="0">
			    <tr style="background-color:black;color:white;">
			        <td>ID</td>
			        <td>Rule</td>
			        <td align="center">Acion</td>
			    </tr>
				<cfloop query="Get_Rules">
				    <tr>
				        <td>
				        	#Get_Rules.Price_Rule_ID#
						</td>
				        <td>
				        	<a href="#arguments.form_action#?dealer_id=#arguments.dealer_id#&page_action=edit_rule&Price_Rule_ID=#Get_Rules.Price_Rule_ID#">#Get_Rules.Rule_Description#</a>
							<cfif dateformat(Get_Rules.End_Date,"mm/dd/yyyy") lt dateformat(now(),"mm/dd/yyyy")>
								<span style="color:red">EXPIRED #dateformat(Get_Rules.End_Date,"mm/dd/yyyy")#</span>
							<cfelse>
								<cfif Get_Rules.Go_Live eq 1>
									<span style="color:green">Live Rule</span>
								<cfelse>
									<span style="color:red">NOT Live</span>
								</cfif>
							</cfif>
						</td>
				        <td align="center">
				        	<a href="#arguments.form_action#?dealer_id=#arguments.dealer_id#&page_action=edit_rule&Price_Rule_ID=#Get_Rules.Price_Rule_ID#">Edit</a>
				        	<cfif Get_Rules.Default_Rule eq 0>
				        		<a href="#arguments.form_action#?dealer_id=#arguments.dealer_id#&page_action=delete_rule&Price_Rule_ID=#Get_Rules.Price_Rule_ID#">Delete</a>
				        	</cfif>
				        </td>
				    </tr>
				</cfloop>
			    <tr>
			        <td colspan="3">
			        	<a href="#arguments.form_action#?dealer_id=#arguments.dealer_id#&page_action=edit_rule&Price_Rule_ID=0">Create a New Rule
					</td>
			    </tr>
			</table>
	
		</cfif>
	
	</cffunction>
	
	<cffunction name="edit_rule" description="edit pricing rule" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		<cfargument name="new_used" default="N">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="default_rule" default="no">

		<!---If this is a Default Price, make sure this is the only one.--->

		<cfquery datasource="#arguments.DSN#" name="Get_Rule">
			SELECT		Price_Rule_ID,
						Dealer_ID,
						Rule_Description,
						Start_Date,
						End_Date,
						New_Used,
						V_Year,
						Baseline_Price_Name,
						Baseline_Price_Field,
						Destination_Price_Field,
						MSRP_Price_Name,
						MSRP_Price_Field,
						Tertiary_Price_Name,
						Tertiary_Price_Field,
						Price_Adj_Scale,
						Price_Adj_Amt,
						Price_Adj_Type,
						Rebate_Name,
              			Rebate,
						Incentive_Name,
						Incentive,
						Deduction_Mileage,
						Deduction_Age,
						Deduction_Age_Type,
						Deduction_Age_Frequency,
						Deduction_Age_Days,
						Deduction_Freight,
						Savings_Name,
						Selling_Name,
						Override_AIS,
						Disclaimer,
						Default_Rule,
						Go_Live
			FROM		Price_Rules
			WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Makes">
			SELECT		Make_ID,
						Make_Name
			FROM		X_Makes
			WHERE		Make_ID not in (Select Make_ID from Price_Rule_Makes WHERE Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="3">)
			ORDER BY 	Make_Name
		</cfquery>
		
		<cfquery datasource="#arguments.DSN#" name="Get_Assigned_Makes">
			SELECT		Price_Rule_Makes.Price_Rule_Make_ID,
						Price_Rule_Makes.Make_ID,
						X_Makes.Make_Name
			FROM		Price_Rule_Makes
			INNER JOIN	X_Makes
			ON 			Price_Rule_Makes.Make_ID = X_Makes.Make_ID
			WHERE		Price_Rule_Makes.Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="3">
			ORDER BY 	X_Makes.Make_Name
		</cfquery>

		<cfset variables.make_list="">
		<cfloop query="Get_Assigned_Makes">
			<cfset variables.make_list=listappend(variables.make_list,"'#Get_Assigned_Makes.Make_Name#'")>
		</cfloop>
		
		<cfif Get_Assigned_Makes.recordcount eq 1>
			<cfset arguments.Make_ID=Get_Assigned_Makes.Make_ID>
		</cfif>
		
		<cfquery datasource="#arguments.DSN#" name="Get_Model_Codes">
			SELECT		X_Models.Model_Name,
						X_Model_Codes.Model_Code,
						X_Model_Codes.Trim_Level,
						X_Model_Codes.Model_Code_ID
			FROM		X_Models
			INNER JOIN	X_Model_Codes
			ON			X_Models.Model_ID = X_Model_Codes.Model_ID
			WHERE		X_Models.Make_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.make_id#" maxlength="3">
			AND			X_Model_Codes.Model_Code_ID not in (SELECT Model_Code_ID from Price_Rule_Models WHERE Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">)
			ORDER BY 	X_Models.Model_Name, X_Model_Codes.Model_Code
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Assigned_Models">
			SELECT     	Price_Rule_Models.Price_Rule_Model_ID,
						Price_Rule_Models.Model_Code_ID,
						X_Model_Codes.Model_Code,
						X_Model_Codes.Trim_Level,
						X_Models.Model_Name
			FROM		Price_Rule_Models
			INNER JOIN	X_Model_Codes
			ON			Price_Rule_Models.Model_Code_ID = X_Model_Codes.Model_Code_ID
			INNER JOIN	X_Models
			ON			X_Model_Codes.Model_ID = X_Models.Model_ID
			WHERE		Price_Rule_Models.Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
		</cfquery>
		
		<cfset variables.model_code_list="">
		<cfloop query="Get_Assigned_Models">
			<cfset variables.model_code_list=listappend(variables.model_code_list,"'#Get_Assigned_Models.Model_Code#'")>
		</cfloop>

		<cfif Get_Rule.recordcount gt 0>
			<cfset variables.Rule_Description=Get_Rule.Rule_Description>
			<cfset arguments.new_used=Get_Rule.New_Used>
		<cfelse>
			<cfset variables.Rule_Description="Untitled">
		</cfif>
		
		<cfif Get_Rule.Default_Rule eq 1>
			<cfset arguments.default_rule="yes">
		</cfif>

		<cfif arguments.default_rule eq "yes">
			<cfswitch expression="#arguments.new_used#">
				<cfcase value="U">
					<cfset variables.Rule_Description="Used Car Pricing - Default Rule">
					<cfset variables.My_New_Used="Used">
				</cfcase>
				<cfcase value="N">
					<cfset variables.Rule_Description="New Car Pricing - Default Rule">
					<cfset variables.My_New_Used="New">
				</cfcase>
			</cfswitch>
		</cfif>

		<div>
			<h1 title="#variables.Rule_Description#">#variables.Rule_Description#<cfif arguments.price_rule_id gt 0> - #Get_Rule.Price_Rule_ID#</cfif></h1>
		</div>

		<script type="text/javascript">
			function updateMake(){
				document.getElementById('matrix').action = '#arguments.form_action#?page_action=Update_Make&price_rule_id=#arguments.price_rule_id#'
				document.getElementById('matrix').submit();
			}
			function updateModel(){
				document.getElementById('matrix').action = '#arguments.form_action#?page_action=Update_Model&price_rule_id=#arguments.price_rule_id#'
				document.getElementById('matrix').submit();
			}
			function updateExceptions(){
				document.getElementById('matrix').action = '#arguments.form_action#?page_action=Update_Exceptions&price_rule_id=#arguments.price_rule_id#'
				document.getElementById('matrix').submit();
			}
			function previewRule(){
				document.getElementById('matrix').action = '#arguments.form_action#?page_action=preview_rule&price_rule_id=#arguments.price_rule_id#'
				document.getElementById('matrix').submit();
			}
			function goLive(){
				document.getElementById('matrix').action = '#arguments.form_action#?page_action=Go_Live&price_rule_id=#arguments.price_rule_id#'
				document.getElementById('matrix').submit();
			}
			function noLive(){
				document.getElementById('matrix').action = '#arguments.form_action#?page_action=save_rule&price_rule_id=#arguments.price_rule_id#'
				document.getElementById('matrix').submit();
			}
		</script>

		<form id="matrix" name="matrix" action="#arguments.form_action#?page_action=save_rule" method="post">
			
			<input type="hidden" name="Price_Rule_ID" value="#arguments.Price_Rule_ID#">
			<input type="hidden" name="Dealer_ID" value="#arguments.Dealer_ID#">

			<div id="tab-container" class='tab-container'>
				
				<ul class='etabs'>
					<li class='tab'><a class="set_tab" href="##tab1">Setup</a></li>
					<li class='tab'><a class="v_tab" href="##tab2">Choose Vehicles</a></li>
					<li class='tab'><a class="map_tab" href="##tab3">Price Mapping</a></li>
					<li class='tab'><a class="ded_tab" href="##tab4">Deductions</a></li>
					<li class='tab'><a class="reb_tab" href="##tab5">Rebates & Incentives</a></li>
					<li class='tab'><a class="lab_tab" href="##tab6">Labels</a></li>
					<li class='tab'><a class="prev_tab" href="##tab7">Preview</a></li>
					<li class='tab'><a class="ex_tab" href="##tab8">Exceptions</a></li>
				</ul>
			
				<div class='panel-container'>
				
					<!---Setup--->
					<div id="tab1">
						<table cellpadding="10">
							<tr>
								<td><b>Rule Name&nbsp;:&nbsp;</b></td>
								<td>
									<cfif arguments.default_rule eq "no">
										<input type="text" name="Rule_Description" value="#variables.Rule_Description#" maxlenght="50"/>
										<input type="hidden" name="Default_Rule" value="0">
									<cfelse>
										#variables.Rule_Description#
										<input type="hidden" name="Rule_Description" value="#variables.Rule_Description#">
										<input type="hidden" name="Default_Rule" value="1">
									</cfif>
								</td>
							</tr>
							<tr>
								<td><b>Start Date&nbsp;:&nbsp;</b></td>
								<td>
									<cfif arguments.default_rule eq "no">
										<input type="text" name="Start_Date" value="#dateformat(Get_Rule.Start_Date,'mm/dd/yyyy')#" maxlenght="10"/>
									<cfelse>
										#dateformat(Get_Rule.Start_Date,"mm/dd/yyyy")#
										<input type="hidden" name="Start_Date" value="#dateformat(Get_Rule.Start_Date,'mm/dd/yyyy')#">
									</cfif>
								</td>
							</tr>
							<tr>
								<td><b>End Date&nbsp;:&nbsp;</b></td>
								<td>
									<cfif Get_Rule.End_Date eq "12/31/2100">
										<cfset Get_Rule.End_Date="">
									</cfif>
									<cfif arguments.default_rule eq "no">
										<input type="text" name="End_Date" value="#dateformat(Get_Rule.End_Date,'mm/dd/yyyy')#" maxlenght="10"/>
									<cfelse>
										#dateformat(Get_Rule.End_Date,"mm/dd/yyyy")#
										<input type="hidden" name="End_Date" value="#dateformat(Get_Rule.End_Date,'mm/dd/yyyy')#">
									</cfif>
								</td>
							</tr>
							<tr>
								<td valign="top"><b>Disclaimer&nbsp;:&nbsp;</b></td>
								<td>
									<textarea name="Disclaimer">#Get_Rule.Disclaimer#</textarea>
								</td>
							</tr>
						</table>
					</div>
			
					<!---Vehicle--->
					<div id="tab2">
						<cfif arguments.default_rule eq "no" and arguments.price_rule_id gt 0>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td align="center">&nbsp;&nbsp;<b>Type</b>&nbsp;&nbsp;</td>
									<td align="center">&nbsp;&nbsp;<b>Year</b>&nbsp;&nbsp;</td>
									<td align="center">&nbsp;&nbsp;<b>Available Makes</b>&nbsp;&nbsp;</td>
									<td align="center">&nbsp;&nbsp;<b>Assigned Makes</b>&nbsp;&nbsp;</td>
									<cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>
										<td align="center">&nbsp;&nbsp;<b>Available Models</b>&nbsp;&nbsp;</td>
										<td align="center">&nbsp;&nbsp;<b>Assigned Models</b>&nbsp;&nbsp;</td>
									</cfif>
								</tr>
								<tr>
									<td valign="top" align="center">&nbsp;&nbsp;
										<select style="width:150px" name="New_Used">
											<option value="N" <cfif Get_Rule.New_Used eq "N">selected</cfif>>New
											<option value="U" <cfif Get_Rule.New_Used eq "U">selected</cfif>>Used
										</select>
										&nbsp;&nbsp;
									</td>
									<td valign="top" align="center">
										&nbsp;&nbsp;
										<select style="width:150px" name="V_Year">
											<option value="0" <cfif Get_Rule.V_Year eq "0">selected</cfif>>All Years
											<cfloop from="#dateformat(dateadd('yyyy',1,now()),'yyyy')#" to="1923" index="v_year" step="-1">
												<option value="#variables.v_year#" <cfif Get_Rule.V_Year eq variables.v_year>selected</cfif>>#variables.v_year#</option>
											</cfloop>
										</select>
										&nbsp;&nbsp;
									</td>
									<td valign="top" align="center">
										&nbsp;&nbsp;
										<select style="width:150px" id="Make_ID" name="Make_ID" multiple size="10">
											<option value="All">All Makes
											<cfloop query="Get_Makes">
												<option value="#Get_Makes.Make_ID#">#Get_Makes.Make_Name#</option>
											</cfloop>
										</select>
										&nbsp;&nbsp;
									</td>
									<td valign="top" align="center">
										&nbsp;&nbsp;
										<select style="width:150px" id="Assn_Make_ID" name="Assn_Make_ID" multiple size="10">
											<cfloop query="Get_Assigned_Makes">
												<option value="#Get_Assigned_Makes.Price_Rule_Make_ID#">#Get_Assigned_Makes.Make_Name#</option>
											</cfloop>
										</select>
										&nbsp;&nbsp;
									</td>
									<td valign="top" align="center">
										&nbsp;&nbsp;
										<cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>
											<input type="Hidden" name="Make_Model_ID" value="#arguments.Make_ID#" />
											<select style="width:250px" id="Model_Code_ID" name="Model_Code_ID" multiple size="10">
												<option value="All">All Models</option>
												<cfloop query="Get_Model_Codes">
													<option value="#Get_Model_Codes.Model_Code_ID#">#Get_Model_Codes.Model_Code# #Get_Model_Codes.Model_Name# #Get_Model_Codes.Trim_Level#</option>
												</cfloop>
											</select>
										<cfelse>
											<input type="Hidden" id="Model_Code_ID" name="Model_Code_ID" value="" />
										</cfif>
										&nbsp;&nbsp;
									</td>
									<td valign="top" align="center">
										&nbsp;&nbsp;
										<cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>
											<select style="width:250px" id="Assn_Model_Code_ID" name="Assn_Model_Code_ID" multiple size="10">
												<cfloop query="Get_Assigned_Models">
													<option value="#Get_Assigned_Models.Price_Rule_Model_ID#">#Get_Assigned_Models.Model_Code# #Get_Assigned_Models.Model_Name# #Get_Assigned_Models.Trim_Level#</option>
												</cfloop>
											</select>
										<cfelse>
											<input type="Hidden" id="Assn_Model_Code_ID" name="Assn_Model_Code_ID" value="" />
										</cfif>
										&nbsp;&nbsp;
									</td>									
								</tr>
								<tr>
									<td align="center">&nbsp;</td>
									<td align="center">&nbsp;</td>
									<td align="center" colspan="2">
										<input type="button" value="Update Makes" onclick="updateMake()"/>
									</td>
									<td align="center" colspan="2">
										<cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>
											<input type="button" value="Update Models" onclick="updateModel()"/>										
										</cfif>
									</td>
								</tr>								
							</table>
						<cfelse>
							<table cellpadding="10">
								<tr>
									<td>
										<cfif  arguments.default_rule eq "no">
											<b>You Must "Save" This Rule Before Assigining Vehicles</b>
										<cfelse>
											<cfswitch expression="#arguments.new_used#">
												<cfcase value="U">
													<b>All Used Makes & Models - Default Rule</b>
												</cfcase>
												<cfcase value="N">
													<b>All New Makes & Models - Default Rule</b>
												</cfcase>
											</cfswitch>
										</cfif>
									</td>
								</tr>
							</table>
							<input type="hidden" name="New_Used" value="#arguments.New_Used#">
							<input type="hidden" name="All_Makes" value="1">
							<input type="hidden" name="All_Models" value="1">
							<input type="hidden" name="V_Year" value="0">
						</cfif>
					</div>

					<!---Price Mapping--->
					<div id="tab3">
						<table cellpadding="10">
							<tr>
								<td>
									<b>Price Mapping & Labels</b><br />
									The chosen "baseline price field" is used as the starting point for this rule. This price will be altered by this rule and reflected in the advertised selling price.<br />
									For example, to set your vehicles' selling price to be "MSRP minus 10%", you would choose the corresponding Price Field (usually Price Field 1) as the baseline price field.<br />
									The 'MSRP/Retail Price' will not be affected by this rule and will be displayed as a customer reference.<br />
								</td>
							</tr>
							<tr>
								<td>
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td align="right"><b>Baseline Price Field &nbsp;:&nbsp;</b></td>
											<td>
												<select class="table-input-data" name="Baseline_Price_Field">
													<option value="Price_1" <cfif Get_Rule.Baseline_Price_Field eq "Price_1">selected</cfif>>Price Field 1</option>
													<option value="Price_2" <cfif Get_Rule.Baseline_Price_Field eq "Price_2">selected</cfif>>Price Field 2</option>
													<option value="Price_3" <cfif Get_Rule.Baseline_Price_Field eq "Price_3">selected</cfif>>Price Field 3</option>
													<option value="Price_4" <cfif Get_Rule.Baseline_Price_Field eq "Price_4">selected</cfif>>Price Field 4</option>
													<option value="Price_5" <cfif Get_Rule.Baseline_Price_Field eq "Price_5">selected</cfif>>Price Field 5</option>
												</select>
											</td>
											<td style="font-size:10px;">&nbsp;&nbsp;This selection is required.</td>
										</tr>
										<tr>
											<td align="right"><b>MSRP/Retail Price Field &nbsp;:&nbsp;</b></td>
											<td>
												<select class="table-input-data" name="MSRP_Price_Field">
													<option value="None" <cfif Get_Rule.MSRP_Price_Field eq "None">selected</cfif>>None</option>
													<option value="Price_1" <cfif Get_Rule.MSRP_Price_Field eq "Price_1">selected</cfif>>Price Field 1</option>
													<option value="Price_2" <cfif Get_Rule.MSRP_Price_Field eq "Price_2">selected</cfif>>Price Field 2</option>
													<option value="Price_3" <cfif Get_Rule.MSRP_Price_Field eq "Price_3">selected</cfif>>Price Field 3</option>
													<option value="Price_4" <cfif Get_Rule.MSRP_Price_Field eq "Price_4">selected</cfif>>Price Field 4</option>
													<option value="Price_5" <cfif Get_Rule.MSRP_Price_Field eq "Price_5">selected</cfif>>Price Field 5</option>
												</select>
											</td>
											<td style="font-size:10px;">
												&nbsp;&nbsp;Choose "None" to hide this from the customer
											</td>
										</tr>
										<tr>
											<td align="right"><b>Display Only Price Field &nbsp;:&nbsp;</b></td>
											<td>
												<select class="table-input-data" name="Tertiary_Price_Field">
													<option value="None" <cfif Get_Rule.Tertiary_Price_Field eq "None">selected</cfif>>None</option>
													<option value="Price_1" <cfif Get_Rule.Tertiary_Price_Field eq "Price_1">selected</cfif>>Price Field 1</option>
													<option value="Price_2" <cfif Get_Rule.Tertiary_Price_Field eq "Price_2">selected</cfif>>Price Field 2</option>
													<option value="Price_3" <cfif Get_Rule.Tertiary_Price_Field eq "Price_3">selected</cfif>>Price Field 3</option>
													<option value="Price_4" <cfif Get_Rule.Tertiary_Price_Field eq "Price_4">selected</cfif>>Price Field 4</option>
													<option value="Price_5" <cfif Get_Rule.Tertiary_Price_Field eq "Price_5">selected</cfif>>Price Field 5</option>
												</select>
											</td>
											<td style="font-size:10px;">
												&nbsp;&nbsp;Third "Display Only" Price. Often set to Invoice.<br />
												&nbsp;&nbsp;Choose "None" to hide this from the customer (Default Setting)
											</td>
										</tr>
									</table>
									<cfquery datasource="#arguments.DSN#" name="Get_Snapshot">
										SELECT		Top 10
													V_Year,
													V_Make,
													V_Make_Alias,
													V_Model,
													V_Model_Alias,
													New_Used,
													Stock,
													V_Model_Number,
													Price_1,
													Price_2,
													Price_3,
													Price_4,
													Price_5
										FROM		Staging_Inventory
										WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.Dealer_ID#" maxlength="10">
										AND			New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#arguments.New_Used#" maxlength="1">
										<cfif Get_Assigned_Makes.Recordcount gt 0>
											AND		V_Make_Alias in (#PreserveSingleQuotes(variables.make_list)#)
										</cfif>
										<cfif Get_Assigned_Models.Recordcount gt 0>
											AND		V_Model_Number in (#PreserveSingleQuotes(variables.model_code_list)#)
										</cfif>
										<cfif Get_Rule.V_Year neq 0>
											AND		V_Year = '#Get_Rule.V_Year#'
										</cfif>
										ORDER BY 	V_Make, V_Make_Alias, V_Model
									</cfquery>
									<hr>
									<b>
										Raw Inventory Snapshot
										<cfswitch expression="#Get_Rule.New_Used#">
											<cfcase value="A">(All)</cfcase>
											<cfcase value="N">(New)</cfcase>
											<cfcase value="U">(Used)</cfcase>
										</cfswitch>
									</b><br/><br/>
									<table style="font-size:11px;" width="100%" border="1" bordercolorlight="##333333" bordercolordark="##333333" cellpadding="0" cellspacing="0">
										<tr style="background-color:##000;color:##fff;">
											<td><b>Stock</b></td>
											<td><b>Model</b></td>
											<td><b>Vehicle</b></td>
											<td><b>Price 1</b></td>
											<td><b>Price 2</b></td>
											<td><b>Price 3</b></td>
											<td><b>Price 4</b></td>
											<td><b>Price 5</b></td>
										</tr>
										<cfloop query="Get_Snapshot">
											<tr <cfif Get_Snapshot.currentrow mod 2 eq 0>style="background-color:##eee;"</cfif> >
												<td>#Get_Snapshot.Stock#</td>
												<td>#Get_Snapshot.V_Model_Number#</td>
												<td>#Get_Snapshot.V_Year# #Get_Snapshot.V_Make_Alias# #Get_Snapshot.V_Model# <cfif Get_Snapshot.New_Used eq "N">(New)<cfelse>(Used)</cfif> </td>
												<td>#Get_Snapshot.Price_1#</td>
												<td>#Get_Snapshot.Price_2#</td>
												<td>#Get_Snapshot.Price_3#</td>
												<td>#Get_Snapshot.Price_4#</td>
												<td>#Get_Snapshot.Price_5#</td>
											</tr>
										</cfloop>
									</table>
								</td>
							</tr>
						</table>
					</div>

					<!---Deductions--->
					<div id="tab4">
						<div>
							<b>Pricing Adjustment</b><br />
							The price will first be adjusted by the amount chosen below.
						</div><br />
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<select name="Price_Adj_Scale">
										<option value="0" <cfif Get_Rule.Price_Adj_Scale eq 0>selected</cfif>>Add (+)</option>
										<option value="1" <cfif Get_Rule.Price_Adj_Scale eq 1>selected</cfif>>Subtract (-)</option>
									</select>&nbsp;
								</td>
								<td>
									<input type="Text" name="Price_Adj_Amt" value="#Get_Rule.Price_Adj_Amt#" />&nbsp;
								</td>
								<td>
									<select name="Price_Adj_Type">
										<option value="0" <cfif Get_Rule.Price_Adj_Type eq 0>selected</cfif>>Percent (%)</option>
										<option value="1" <cfif Get_Rule.Price_Adj_Type eq 1>selected</cfif>>Dollar ($)</option>
									</select>
								</td>
							</tr>
						</table>
						<br/>
						<div>
							<b>Deductions</b><br />
							You can also offer deductions by age or mileage. If they apply, the numbers below will each be subtracted from the Selling Price.
						</div><br />
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>Deduct&nbsp;</td>
								<td>$&nbsp;</td>
								<td><input type="Text" name="Deduction_Mileage" value="#Get_Rule.Deduction_Mileage#" maxlength="4" />&nbsp;</td>
								<td colspan="5">per mile</td>
							</tr>
							<tr>
								<td>Deduct&nbsp;</td>
								<td>&nbsp;</td>
								<td><input type="Text" name="Deduction_Age" value="#Get_Rule.Deduction_Age#" maxlength="4" /></td>
								<td>
									<select name="Deduction_Age_Type">
										<option value="0" <cfif Get_Rule.Deduction_Age_Type eq 0>selected</cfif>>%</option>
										<option value="1" <cfif Get_Rule.Deduction_Age_Type eq 1>selected</cfif>>$</option>
									</select>&nbsp;
								</td>
								<td>
									<select name="Deduction_Age_Frequency">
										<option value="1" <cfif Get_Rule.Deduction_Age_Frequency eq 1>selected</cfif>>Once</option>
										<option value="2" <cfif Get_Rule.Deduction_Age_Frequency eq 2>selected</cfif>>Daily</option>
										<option value="3" <cfif Get_Rule.Deduction_Age_Frequency eq 3>selected</cfif>>Weekly</option>
										<option value="4" <cfif Get_Rule.Deduction_Age_Frequency eq 4>selected</cfif>>Monthly</option>
									</select>&nbsp;
								</td>
								<td>
									once in stock for&nbsp;
								</td>
								<td>
									<input type="Text" name="Deduction_Age_Days" value="#Get_Rule.Deduction_Age_Days#" maxlength="4">&nbsp;
								</td>
								<td>day(s).</td>
							</tr>
							<tr>
								<td>Freight&nbsp;</td>
								<td>$&nbsp;</td>
								<td colspan="6"><input class="table-input-data" type="Text" name="Deduction_Freight" value="#Get_Rule.Deduction_Freight#" maxlength="4" /></td>
							</tr>
						</table>
					</div>

					<!---Rebates & Incentives--->
					<div id="tab5">
						<div>
							<b>Rebates &amp; Incentives</b><br />
							You can offer rebates and incentives on your vehicles. The numbers below will each be subtracted from the price after the adjustment above is applied.
						</div><br/>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td align="right"><b>Rebate&nbsp;:&nbsp;</b></td>
								<td><b>$</b></td>
								<td><input class="table-input-data" type="Text" name="Rebate" value="#Get_Rule.Rebate#" /></td>
							</tr>
							<tr>
								<td align="right"><b>Incentive&nbsp;:&nbsp;</b></td>
								<td><b>$</b></td>
								<td><input class="table-input-data" type="Text" name="Incentive" value="#Get_Rule.Incentive#" /></td>
							</tr>
							<tr>
								<td align="right"><b>AIS Incentives&nbsp;:&nbsp;</b></td>
								<td></td>
								<td>
									<select name="Override_AIS">
										<option value="1" <cfif Get_Rule.Override_AIS eq 1>selected</cfif>>Hide</option>
										<option value="0" <cfif Get_Rule.Override_AIS eq 0>selected</cfif>>Incorperate into Selling Price</option>
										<!--- This is currently not an option --->
										<option value="1" <cfif Get_Rule.Override_AIS eq 2>selected</cfif>>Display Only</option>
										<!---Don't forget to add this! --->
									</select>
								</td>
							</tr>
						</table>
					</div>

					<!---Labels--->
					<div id="tab6">
						<cfif arguments.default_rule eq "yes" and arguments.price_rule_id eq 0>
							<cfif arguments.New_Used eq "N">
								<cfset variables.MSRP_Price_Name="MSRP">
							<cfelse>
								<cfset variables.MSRP_Price_Name="Retail Price">
							</cfif>
							<cfset variables.Baseline_Price_Name="Selling Price">
							<cfset variables.Rebate_Name="Rebate">
							<cfset variables.Incentive_Name="Incentive">
							<cfset variables.Tertiary_Price_Name="Invoice">
							<cfset variables.Savings_Name="Total Savings">
							<cfset variables.Selling_Name="Sale Price">
						<cfelse>
							<cfset variables.MSRP_Price_Name=Get_Rule.MSRP_Price_Name>
							<cfset variables.Baseline_Price_Name=Get_Rule.Baseline_Price_Name>
							<cfset variables.Rebate_Name=Get_Rule.Rebate_Name>
							<cfset variables.Incentive_Name=Get_Rule.Incentive_Name>
							<cfset variables.Tertiary_Price_Name=Get_Rule.Tertiary_Price_Name>
							<cfset variables.Savings_Name=Get_Rule.Savings_Name>
							<cfset variables.Selling_Name=Get_Rule.Selling_Name>
						</cfif>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td align="right"><b>MSRP/Retail Price Label&nbsp;:&nbsp;</b></td>
								<td>
									<input type="Text" name="MSRP_Price_Name" value="#variables.MSRP_Price_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;MSRP or Retail Pricing
								</td>
							</tr>
							<tr>
								<td align="right"><b>Selling Price Label&nbsp;:&nbsp;</b></td>
								<td>
									<input type="Text" name="Baseline_Price_Name" value="#variables.Baseline_Price_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;Selling Price before Discounts
								</td>
							</tr>
							<tr>
								<td align="right"><b>Rebate Label&nbsp;:&nbsp;</b></td>
								<td>
									<input type="Text" name="Rebate_Name" value="#variables.Rebate_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;Label for "Rebate" Deduction
								</td>
							</tr>
							<tr>
								<td align="right"><b>Incentives Label&nbsp;:&nbsp;</b></td>
								<td>
									<input type="Text" name="Incentive_Name" value="#variables.Incentive_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;Label for "Incentive" Deduction
								</td>
							</tr>
							<tr>
								<td align="right"><b>Tertiary Price Label&nbsp;:&nbsp;</b></td>
								<td>
									<input type="Text" name="Tertiary_Price_Name" value="#variables.Tertiary_Price_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;Third "Display Only" Price. Often set to Invoice.<br />
								</td>
							</tr>
							<tr>
								<td align="right"><b>Total Savings Label&nbsp;:&nbsp;</b></td>
								<td>
									<input class="table-input-data" type="Text" name="Savings_Name" value="#variables.Savings_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;Leave blank to hide this from the customer
								</td>
							</tr>
							<tr>
								<td align="right"><b>Sale Label&nbsp;:&nbsp;</b></td>
								<td>
									<input class="table-input-data" type="Text" name="Selling_Name" value="#variables.Selling_Name#" />
								</td>
								<td style="font-size:10px;">
									&nbsp;&nbsp;This label is required
								</td>
							</tr>
						</table>
					</div>

					<!---Previews--->
					<div id="tab7">
						<cfquery datasource="#arguments.DSN#" name="Get_Vehicles">
							SELECT		Vin,
										V_Year,
										V_Make_Alias,
										V_Model_Alias,
										Stock
							FROM		Staging_Inventory
							WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.Dealer_ID#" maxlength="10">
							AND			New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Get_Rule.New_Used#" maxlength="1">
							<cfif Get_Assigned_Makes.Recordcount gt 0>
								AND		V_Make_Alias in (#PreserveSingleQuotes(variables.make_list)#)
							</cfif>
							<cfif Get_Assigned_Models.Recordcount gt 0>
								AND		V_Model_Number in (#PreserveSingleQuotes(variables.model_code_list)#)
							</cfif>
							<cfif Get_Rule.V_Year neq 0>
								AND		V_Year = '#Get_Rule.V_Year#'
							</cfif>
							ORDER BY 	Stock, V_Make, V_Make_Alias, V_Model
						</cfquery>
						<cfparam name="url.prev_vin" default="#Get_Vehicles.Vin#" >

						<cfif len(trim(url.prev_vin)) gt 0 and arguments.price_rule_id gt 0>
							<cftransaction>

								<cfset variables.This_Rule=arguments.price_rule_id>
								<cfset variables.This_Dealer=Get_Rule.Dealer_ID>
								<cfset variables.This_New_Used=Get_Rule.New_Used>
								<cfset variables.This_Year=Get_Rule.V_Year>
								<cfset variables.This_Baseline_Price_Name=Get_Rule.Baseline_Price_Name>
								<cfset variables.This_Baseline=Get_Rule.Baseline_Price_Field>
								<cfset variables.This_MSRP_Price_Name=Get_Rule.MSRP_Price_Name>
								<cfset variables.This_MSRP=Get_Rule.MSRP_Price_Field>
								<cfset variables.This_Tertiary_Price_Name=Get_Rule.Tertiary_Price_Name>
								<cfset variables.This_Tertiary=Get_Rule.Tertiary_Price_Field>
								<cfset variables.This_Adj_Scale=Get_Rule.Price_Adj_Scale>
								<cfset variables.This_Adj_Amt=Get_Rule.Price_Adj_Amt>
								<cfset variables.This_Adj_Type=Get_Rule.Price_Adj_Type>
								<cfset variables.This_Rebate_Name=Get_Rule.Rebate_Name>
								<cfset variables.This_Rebate=Get_Rule.Rebate>
								<cfset variables.This_Incentive_Name=Get_Rule.Incentive_Name>
								<cfset variables.This_Incentive=Get_Rule.Incentive>
								<cfset variables.This_Deduction_Mileage=Get_Rule.Deduction_Mileage>
								<cfset variables.This_Deduction_Age=Get_Rule.Deduction_Age>
								<cfset variables.This_Deduction_Age_Type=Get_Rule.Deduction_Age_Type>
								<cfset variables.This_Deduction_Age_Frequency=Get_Rule.Deduction_Age_Frequency>
								<cfset variables.This_Deduction_Age_Days=Get_Rule.Deduction_Age_Days>
								<cfset variables.This_Deduction_Freight=Get_Rule.Deduction_Freight>
								<cfset variables.This_Savings_Name=Get_Rule.Savings_Name>
								<cfset variables.This_Selling_Name=Get_Rule.Selling_Name>

								<cfquery datasource="Imports" name="Get_Inventory">
									SELECT		Stage_Inv_ID,
												V_Model_Number,
												#variables.This_Baseline# as Baseline,
												<cfif variables.This_MSRP eq "None">
													'None' as MSRP,
												<cfelse>
													#variables.This_MSRP# as MSRP,
												</cfif>
												<cfif variables.This_Tertiary eq "None">
													'None' as Tertiary,
												<cfelse>
													#variables.This_Tertiary# as Tertiary,
												</cfif>
												V_Year,
												V_Make_Alias,
												V_Model_Alias,
												V_Trim,
												V_Vehicle_Type,
												Stock,
												Vin,
												Mileage,
												New_Used,
												Engine_Size,
												Cylinders,
												Transmission,
												Exterior_Color,
												DriveTrain,
												Doors,
												Passengers,
												Days_In_Stock,
												AIS_Legacy_Name,
												AIS_Legacy_Cash,
												AIS_Legacy_APR,
												AIS_Legacy_Link
									FROM		Staging_Inventory
									WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#variables.This_Dealer#" maxlength="4">
									AND			New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#variables.This_New_Used#" maxlength="1">
									AND			VIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(url.prev_vin,17)#" maxlength="21">
								</cfquery>
							</cftransaction>

							<cfset variables.This_AIS_Name=Get_Inventory.AIS_Legacy_Name>
							<cfset variables.This_AIS_Rebate=Get_Inventory.AIS_Legacy_Cash>

							<!--- Pricing Adjustment --->
							<cfset variables.Price_Adjustment=0>
							<cfif len(trim(variables.This_Adj_Amt)) gt 0>
								<cfswitch expression="#variables.This_Adj_Type#">
									<!--- Percent --->
									<cfcase value="0">
										<cfif variables.This_Adj_Amt gt 0>
											<cfset variables.Price_Adjustment=int(Get_Inventory.Baseline*decimalformat(variables.This_Adj_Amt)/100)>
										</cfif>
									</cfcase>
									<!--- Dollar --->
									<cfcase value="1">
										<cfset variables.Price_Adjustment=variables.This_Adj_Amt>
									</cfcase>
								</cfswitch>
							</cfif>
							
							<!--- Mileage Adjustment --->
							<cfset variables.Mileage_Adjustment=0>
							<cfif len(trim(variables.This_Deduction_Mileage)) gt 0 and variables.This_Deduction_Mileage neq 0>
								<cfset variables.Mileage_Adjustment=variables.This_Deduction_Mileage*Get_Inventory.Mileage>
							</cfif>

							<!--- Freight Adjustment --->
							<cfset variables.Freight_Adjustment=0>
							<cfif len(trim(variables.This_Deduction_Freight)) gt 0 and variables.This_Deduction_Freight neq 0>
								<cfset variables.Freight_Adjustment=variables.This_Deduction_Freight>
							</cfif>
							
							<!--- Age Adjustment --->
							<cfset variables.Age_Adjustment=0>
							<cfif len(trim(variables.This_Deduction_Age)) gt 0 and variables.This_Deduction_Age neq 0>
								<cfswitch expression="#variables.This_Deduction_Age_Type#">
									<!--- Percent --->
									<cfcase value="0">
										<cfif variables.This_Deduction_Age gt 0>
											<cfif Get_Inventory.Days_In_Stock gte variables.This_Deduction_Age_Days>
												<cfset variables.Age_Adjustment=int(Get_Inventory.Baseline*decimalformat(variables.This_Deduction_Age)/100)>
											</cfif>
										</cfif>
									</cfcase>
									<!--- Dollar --->
									<cfcase value="1">
										<cfif Get_Inventory.Days_In_Stock gte variables.This_Deduction_Age_Days>
											<cfset variables.Age_Adjustment=variables.This_Deduction_Age>
										</cfif>
									</cfcase>
								</cfswitch>
							</cfif>

							<cfset variables.This_Selling_Price=Get_Inventory.Baseline>
							<cfif isvalid("integer",variables.This_Selling_Price) eq "no">
								<cfset variables.This_Selling_Price=0>
							</cfif>
							<!--- Add Adjustmjent --->
							<cfif variables.This_Adj_Scale eq 0>
								<cfset variables.This_Selling_Price=variables.This_Selling_Price+variables.Price_Adjustment>
							</cfif>
							<!--- Subtract Adjustment --->
							<cfif variables.This_Adj_Scale eq 1>
								<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.Price_Adjustment>
							</cfif>
							<!--- Subtract Mileage --->
							<cfif isvalid("integer",variables.Mileage_Adjustment) eq "Yes">
								<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.Mileage_Adjustment>
							<cfelse>
								<cfset variables.Mileage_Adjustment=0>
							</cfif>
							<!--- Subtract Age --->
							<cfif isvalid("integer",variables.Age_Adjustment) eq "Yes">
								<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.Age_Adjustment>
							<cfelse>
								<cfset variables.Age_Adjustment=0>
							</cfif>
							<!--- Subtract Freight --->
							<cfif isvalid("integer",variables.Freight_Adjustment) eq "Yes">
								<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.Freight_Adjustment>
							<cfelse>
								<cfset variables.Freight_Adjustment=0>
							</cfif>
							<!--- Determine Price Difference against MSRP --->
							<cfset variables.Price_Difference=0>
							<cfif Get_Inventory.MSRP neq "None" and len(trim(Get_Inventory.MSRP)) neq 0>
								<cfset variables.Price_Difference=Get_Inventory.MSRP-variables.This_Selling_Price>
							</cfif>
							<!--- Create Adjusted Baseline --->
							<cfset variables.Adjusted_Baseline=variables.This_Selling_Price>

							<!--- Subtract Rebate --->
							<cfif isvalid("integer",variables.This_Rebate) eq "Yes">
								<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.This_Rebate>
							<cfelse>
								<cfset variables.This_Rebate=0>
							</cfif>
							<!--- Subtract Incentive --->
							<cfif isvalid("integer",variables.This_Incentive) eq "Yes">
								<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.This_Incentive>
							<cfelse>
								<cfset variables.This_Incentive=0>
							</cfif>

							<!--- Subtract AIS --->
							<cfif Get_Rule.Override_AIS eq 0>
								<cfif isvalid("integer",variables.This_AIS_Rebate) eq "Yes">
									<cfset variables.This_Selling_Price=variables.This_Selling_Price-variables.This_AIS_Rebate>
								<cfelse>
									<cfset variables.This_AIS_Rebate=0>
								</cfif>
							<cfelse>
								<cfset variables.This_AIS_Rebate=0>
							</cfif>


							<table cellpadding="0" cellspacing="0">
								<tr>
									<td><b>Note&nbsp;:&nbsp;You MUST "SAVE" your changes for them to be applied to the preview</b></td>
								</tr>
							</table>
							<br/>

							<table cellpadding="0" cellspacing="0">
								<tr>
									<td align="right"><b>Choose a Vehicle&nbsp;:&nbsp;</b></td>
									<td>
										<select name="prev_vin" onchange="javascript:previewRule();">
											<cfloop query="Get_Vehicles">
												<option value="#Get_Vehicles.Vin#" <cfif url.prev_vin eq Get_Vehicles.Vin>Selected</cfif>>#Get_Vehicles.Stock# - #Get_Vehicles.V_Year# #Get_Vehicles.V_Make_Alias# #Get_Vehicles.V_Model_Alias#</option>
											</cfloop>
										</select>
									</td>
								</tr>
							</table>
							<br/><br/>
							<table>
							    <tr>
							        <td style="width:300px;font-size:12px;" valign="top">
							        	<b style="font-size:20px;">#Get_Inventory.V_Year# #Get_Inventory.V_Make_Alias# #Get_Inventory.V_Model_Alias#</b><br/>
										<b>VIN:</b> #Get_Inventory.Vin#<br/>
										<b>Stock:</b> #Get_Inventory.Stock#<br/>
										<b>Mileage:</b> #Get_Inventory.Mileage#<br/>
										<b>Engine:</b> #Get_Inventory.Engine_Size# #Get_Inventory.Cylinders# Cylinders<br/>
										<b>Transmission:</b> #Get_Inventory.Transmission#<br/>
										<b>Color:</b> #Get_Inventory.Exterior_Color#<br/>
										<b>Drivetrain:</b> #Get_Inventory.DriveTrain#<br/>
										<b>Doors:</b> #Get_Inventory.Doors#<br/>
							        </td>
							        <td style="width:200px;font:bold 12px arial;" valign="top">
										<table style="width:100%;font:bold 12px arial;">
										    <cfif Get_Inventory.MSRP neq "None" and Get_Inventory.MSRP neq variables.This_Selling_Price>
												<tr>
											        <td>#variables.This_MSRP_Price_Name#:</td>
											        <td align="right">$#numberformat(Get_Inventory.MSRP)#</td>
											    </tr>
											</cfif>
										    <cfif Get_Inventory.Tertiary neq "None">
												<tr>
											        <td>#variables.This_Tertiary_Price_Name#:</td>
											        <td align="right">$#numberformat(Get_Inventory.Tertiary)#</td>
											    </tr>
											</cfif>
											<cfif variables.Adjusted_Baseline neq variables.This_Selling_Price and variables.Adjusted_Baseline neq Get_Inventory.MSRP>
												<tr>
											        <td>#variables.This_Baseline_Price_Name#:</td>
											        <td align="right">$#numberformat(variables.Adjusted_Baseline)#</td>
											    </tr>
											</cfif>
											<cfif variables.This_Rebate neq 0>
												<tr>
											        <td>#variables.This_Rebate_Name#:</td>
											        <td style="color:red" align="right">-$#numberformat(variables.This_Rebate)#</td>
											    </tr>
											</cfif>
											<cfif variables.This_Incentive neq 0>
												<tr>
											        <td>#variables.This_Incentive_Name#:</td>
											        <td style="color:red" align="right">-$#numberformat(variables.This_Incentive)#</td>
											    </tr>
											</cfif>
											<cfif Get_Inventory.MSRP eq variables.This_Selling_Price>
												<cfset variables.This_Selling_Name=variables.This_MSRP_Price_Name>
											</cfif>
											<cfif Get_Rule.Override_AIS eq 0>
												<cfif isvalid("integer",variables.This_AIS_Rebate) eq "Yes" and variables.This_AIS_Rebate neq 0>
													<tr>
												        <td>#variables.This_AIS_Name#:</td>
												        <td style="color:red" align="right">-$#numberformat(variables.This_AIS_Rebate)#</td>
												    </tr>
												</cfif>
											</cfif>
											<tr>
										        <td style="font:bold 15px arial">#ucase(variables.This_Selling_Name)#:</td>
										    </tr>
											<tr>
										        <td colspan="2" style="font:bold 30px arial;background-color:red;color:white;padding:5px">$#numberformat(variables.This_Selling_Price)#</td>
										    </tr>
											<cfif len(trim(variables.This_Savings_Name)) gt 0 and variables.This_AIS_Rebate+variables.This_Incentive+variables.This_Rebate+variables.Price_Difference gt 0>
												<tr>
											        <td style="font:bold 15px arial;color:green;" colspan="2">
											        	#ucase(variables.This_Savings_Name)#:
														$#numberformat(variables.This_AIS_Rebate+variables.This_Incentive+variables.This_Rebate+variables.Price_Difference)#
													</td>
											    </tr>
											</cfif>
										</table>
							        </td>
							    </tr>
							</table>
						</cfif>
					</div>

					<!---Rule Exceptions--->
					<div id="tab8">
						<div>
							<b>Rule Exceptions</b><br />
							You can remove specific stock numbers from this rule - if removed, the stock number reverts to the default pricing rule.
						</div><br/>
						<cfif arguments.default_rule eq "no" and arguments.price_rule_id gt 0>

							<cfquery datasource="Imports" name="Get_Ex_Vehicles">
								SELECT		Stage_Inv_ID,
											V_Year,
											V_Make_Alias,
											V_Model_Alias,
											V_Trim,
											Stock,
											Vin
								FROM		Staging_Inventory
								WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.Dealer_ID#" maxlength="10">
								AND			New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Get_Rule.New_Used#" maxlength="1">
								AND			Vin not in (SELECT Vin from Price_Rule_Exceptions WHERE Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">)
								<cfif Get_Assigned_Makes.Recordcount gt 0>
									AND		V_Make_Alias in (#PreserveSingleQuotes(variables.make_list)#)
								</cfif>
								<cfif Get_Assigned_Models.Recordcount gt 0>
									AND		V_Model_Number in (#PreserveSingleQuotes(variables.model_code_list)#)
								</cfif>
								<cfif Get_Rule.V_Year neq 0>
									AND		V_Year = '#Get_Rule.V_Year#'
								</cfif>
								ORDER BY	Stock, V_Year, V_Make_Alias, V_Model_Alias, V_Trim
							</cfquery>

							<cfquery datasource="Imports" name="Get_Ex_Vehicles_Assn">
								SELECT		Price_Rule_Exceptions.Vin,
											Staging_Inventory.Stock,
											Staging_Inventory.V_Year,
											Staging_Inventory.V_Make_Alias,
											Staging_Inventory.V_Model_Alias,
											Staging_Inventory.V_Trim
								FROM		Price_Rule_Exceptions
								INNER JOIN	Staging_Inventory
								ON 			Price_Rule_Exceptions.Vin = Staging_Inventory.Vin
								WHERE		Price_Rule_Exceptions.Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
								AND			Staging_Inventory.Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.Dealer_ID#" maxlength="10">
								ORDER BY	Stock, V_Year, V_Make_Alias, V_Model_Alias, V_Trim
							</cfquery>
	
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top" align="center">
										<b>Available Stock</b>
									</td>
									<td>
										&nbsp;&nbsp;
									</td>
									<td valign="top" align="center">
										<b>Excluded Stock</b>
									</td>
								</tr>
								<tr>
									<td valign="top" align="center">
										&nbsp;&nbsp;
										<select style="width:250px" id="ex_vin" name="ex_vin" multiple size="10">
											<cfloop query="Get_Ex_Vehicles">
												<option value="#Get_Ex_Vehicles.Vin#">#Get_Ex_Vehicles.Stock# - #Get_Ex_Vehicles.V_Year# #Get_Ex_Vehicles.V_Make_Alias# #Get_Ex_Vehicles.V_Model_Alias# #Get_Ex_Vehicles.V_Trim#</option>
											</cfloop>
										</select>
										&nbsp;&nbsp;
									</td>
									<td>
										&nbsp;&nbsp;
									</td>
									<td>
										&nbsp;&nbsp;
										<select style="width:250px" id="assn_ex_vin" name="assn_ex_vin" multiple size="10">
											<cfloop query="Get_Ex_Vehicles_Assn">
												<option value="#Get_Ex_Vehicles_Assn.Vin#">#Get_Ex_Vehicles_Assn.Stock# - #Get_Ex_Vehicles_Assn.V_Year# #Get_Ex_Vehicles_Assn.V_Make_Alias# #Get_Ex_Vehicles_Assn.V_Model_Alias# #Get_Ex_Vehicles_Assn.V_Trim#</option>
											</cfloop>
										</select>
										&nbsp;&nbsp;										
									</td>
								</tr>
								<tr>
									<td colspan="3" align="center">
										<input type="button" value="Update Exceptions" onclick="updateExceptions()"/>
									</td>
								</tr>
							</table>
						<cfelse>
							<div>
								Exceptions are not permitted to this rule.
							</div><br/>
						</cfif>
					</div>

					<!---End Tabs--->
				
				</div>
			</div>

			<div>
				<input type="button" value="Go Back" onclick="location.href='#arguments.form_action#?Dealer_ID=#arguments.Dealer_ID#'"/>
				<input type="submit" value="Save Rule"/></br>
				<cfif Get_Rule.Go_Live eq 1>
					<input style="font:bold 20px arial;color:white;background-color:red" type="button" value="Deactivate Rule"  onclick="noLive()"></br>
				</cfif>
				<cfif Get_Rule.Go_Live eq 0>
					<input style="font:bold 20px arial;color:white;background-color:green" type="button" value="Go Live" onclick="goLive()"/>
				</cfif>
			</div>

		</form>
	
	</cffunction>
	
	<cffunction name="save_rule" description="save pricing rule" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="Dealer_ID" required="yes">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="go_live" default="no">
		
		
		<!---default parameters--->
		<cfparam name="form.Price_Rule_ID" default="0">
		<cfparam name="form.Default_Rule" default="0">
		<cfparam name="form.Rule_Description" default="">
		<cfparam name="form.Start_Date" default="">
		<cfparam name="form.End_Date" default="">
		<cfparam name="form.Override_AIS" default="1">
		<cfparam name="form.Dealer_ID" default="">
		<cfparam name="form.New_Used" default="A">
		<cfparam name="form.V_Year" default="0">
		<cfparam name="form.Price_Adj_Scale" default="0">
		<cfparam name="form.Price_Adj_Amt" default="">
		<cfparam name="form.Price_Adj_Type" default="0">
		<cfparam name="form.Rebate_Name" default="Rebate">
		<cfparam name="form.Rebate" default="">
		<cfparam name="form.Incentive_Name" default="Incentive">
		<cfparam name="form.Incentive" default="">
		<cfparam name="form.Deduction_Mileage" default="">
		<cfparam name="form.Deduction_Age" default="">
		<cfparam name="form.Deduction_Age_Type" default="0">
		<cfparam name="form.Deduction_Age_Frequency" default="1">
		<cfparam name="form.Deduction_Age_Days" default="">
		<cfparam name="form.Deduction_Freight" default="">
		<cfparam name="form.Baseline_Price_Name" default="">
		<cfparam name="form.Baseline_Price_Field" default="">
		<cfparam name="form.Destination_Price_Field" default="">
		<cfparam name="form.MSRP_Price_Name" default="">
		<cfparam name="form.MSRP_Price_Field" default="">
		<cfparam name="form.Tertiary_Price_Name" default="">
		<cfparam name="form.Tertiary_Price_Field" default="">
		<cfparam name="form.Savings_Name" default="">
		<cfparam name="form.Selling_Name" default="">
		<cfparam name="form.Disclaimer" default="">
		<cfparam name="form.All_Makes" default="0">
		<cfparam name="form.All_Models" default="0">
		
		
		<!--- Strip Undesireable Characters --->

		<!--- From Price_Adj_Amt--->
		<cfset form.Price_Adj_Amt=replace(form.Price_Adj_Amt,".00","","all")>
		<cfset form.Price_Adj_Amt=replace(form.Price_Adj_Amt,"$","","all")>
		<!---<cfset form.Price_Adj_Amt=rereplace(form.Price_Adj_Amt, "[^\w]", "", "all")>--->
		<!--- From Rebate --->
		<cfset form.Rebate=replace(form.Rebate,".00","","all")>
		<cfset form.Rebate=rereplace(form.Rebate, "[^\w]", "", "all")>
		<!--- From Incentive --->
		<cfset form.Incentive=replace(form.Incentive,".00","","all")>
		<cfset form.Incentive=rereplace(form.Incentive, "[^\w]", "", "all")>
		<!--- From Deduction Mileage --->
		<cfset form.Deduction_Mileage=replace(form.Deduction_Mileage,".00","","all")>
		<cfset form.Deduction_Mileage=rereplace(form.Deduction_Mileage, "[^\w]", "", "all")>
		<!--- From Deduction Age --->
		<cfset form.Deduction_Age=replace(form.Deduction_Age,".00","","all")>
		<cfset form.Deduction_Age=rereplace(form.Deduction_Age, "[^\w]", "", "all")>
		<!--- From Deduction Age Days--->
		<cfset form.Deduction_Age_Days=replace(form.Deduction_Age_Days,".00","","all")>
		<cfset form.Deduction_Age_Days=rereplace(form.Deduction_Age_Days, "[^\w]", "", "all")>
		<!--- From Deduction Frieght --->
		<cfset form.Deduction_Freight=replace(form.Deduction_Freight,".00","","all")>
		<cfset form.Deduction_Freight=rereplace(form.Deduction_Freight, "[^\w]", "", "all")>
		
		<cfif form.Price_Rule_ID eq 0>
	
			<cfquery datasource="#arguments.DSN#" name="Insert_Rule">

				INSERT INTO	Price_Rules

					(Dealer_ID,
					Rule_Description,
					New_Used,
					Disclaimer,
					Active,
					Default_Rule,
					V_Year,
					Baseline_Price_Name,
					Baseline_Price_Field,
					MSRP_Price_Name,
					MSRP_Price_Field,
					Tertiary_Price_Name,
					Tertiary_Price_Field,
					Price_Adj_Scale,
					Price_Adj_Amt,
					Price_Adj_Type,
					Rebate_Name,
          			Rebate,
					Incentive_Name,
					Incentive,
					Deduction_Mileage,
					Deduction_Age,
					Deduction_Age_Type,
					Deduction_Age_Frequency,
					Deduction_Age_Days,
					Deduction_Freight,
					Savings_Name,
					Selling_Name,
					Override_AIS,
					All_Makes,
					All_Models)

				VALUES

					(<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.Dealer_ID#" maxlength="10">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Rule_Description#" maxlength="50">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.New_Used#" maxlength="1">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Disclaimer#">,
					<cfqueryparam cfsqltype="CF_SQL_BIT" value="1" maxlength="1">,
					<cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Default_Rule#" maxlength="1">,

					<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.V_Year#" maxlength="4">,
					<cfif len(trim(form.Baseline_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Baseline_Price_Name#" maxlength="50"><cfelse>'Selling Price'</cfif>,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Baseline_Price_Field#" maxlength="10">,
					<cfif len(trim(form.MSRP_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MSRP_Price_Name#" maxlength="50"><cfelse>'MSRP'</cfif>,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MSRP_Price_Field#" maxlength="10">,
					<cfif len(trim(form.Tertiary_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Tertiary_Price_Name#" maxlength="50"><cfelse>'Invoice'</cfif>,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Tertiary_Price_Field#" maxlength="10">,
					<cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Price_Adj_Scale#" maxlength="1">,
					<cfif isvalid("numeric" ,form.Price_Adj_Amt) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Price_Adj_Amt#" maxlength="10"><cfelse>Null</cfif>,
					<cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Price_Adj_Type#" maxlength="1">,
					<cfif len(trim(form.Rebate_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Rebate_Name#" maxlength="50"><cfelse>'Rebate'</cfif>,
					<cfif isvalid("integer",form.Rebate) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Rebate#" maxlength="10"><cfelse>Null</cfif>,
					<cfif len(trim(form.Incentive_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Incentive_Name#" maxlength="50"><cfelse>'Incentive'</cfif>,
					<cfif isvalid("integer",form.Incentive) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Incentive#" maxlength="10"><cfelse>Null</cfif>,
					<cfif isvalid("integer",form.Deduction_Mileage) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Mileage#" maxlength="10"><cfelse>Null</cfif>,
					<cfif isvalid("integer",form.Deduction_Age) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Age#" maxlength="10"><cfelse>Null</cfif>,
					<cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Deduction_Age_Type#" maxlength="1">,
					<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.Deduction_Age_Frequency#" maxlength="2">,
					<cfif isvalid("integer",form.Deduction_Age_Days) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Age_Days#" maxlength="10"><cfelse>Null</cfif>,
					<cfif isvalid("integer",form.Deduction_Freight) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Freight#" maxlength="10"><cfelse>Null</cfif>,
					<cfif len(trim(form.Savings_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Savings_Name#" maxlength="50"><cfelse>''</cfif>,
					<cfif len(trim(form.Selling_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Selling_Name#" maxlength="50"><cfelse>'Sale Price'</cfif>,
					<cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.Override_AIS#" maxlength="1">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#form.All_Makes#" maxlength="1">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#form.All_Models#" maxlength="1">)
					
				SELECT SCOPE_IDENTITY() as New_ID

			</cfquery>
			
			<cfset variables.rule_id=Insert_Rule.New_ID>
			
		<cfelse>

			<cfquery datasource="#arguments.DSN#" name="Update_Rule">
				UPDATE	Price_Rules
				SET		Rule_Description = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Rule_Description#" maxlength="50">,
						Start_Date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(form.Start_Date,'mm/dd/yyyy')#" maxlength="10">,
						<cfif len(trim(form.End_Date)) eq 0>
							End_Date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="12/31/2100" maxlength="10">,
						<cfelse>
							End_Date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(form.End_Date,'mm/dd/yyyy')#" maxlength="10">,
						</cfif>
						New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#form.New_Used#" maxlength="1">,
						V_Year = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.V_Year#" maxlength="4">,
						Baseline_Price_Name = <cfif len(trim(form.Rebate_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Baseline_Price_Name#" maxlength="50"><cfelse>'Selling Price'</cfif>,
						Baseline_Price_Field = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Baseline_Price_Field#" maxlength="10">,
						MSRP_Price_Name = <cfif len(trim(form.MSRP_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MSRP_Price_Name#" maxlength="50"><cfelse>'MSRP'</cfif>,
						MSRP_Price_Field = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MSRP_Price_Field#" maxlength="10">,
						Tertiary_Price_Name = <cfif len(trim(form.Tertiary_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Tertiary_Price_Name#" maxlength="50"><cfelse>'Invoice'</cfif>,
						Tertiary_Price_Field = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Tertiary_Price_Field#" maxlength="10">,
						Price_Adj_Scale = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Price_Adj_Scale#" maxlength="1">,
						Price_Adj_Amt = <cfif isvalid("numeric",form.Price_Adj_Amt) eq "Yes"><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Price_Adj_Amt#" maxlength="10"><cfelse>Null</cfif>,
						Price_Adj_Type = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Price_Adj_Type#" maxlength="1">,
						Rebate_Name = <cfif len(trim(form.Rebate_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Rebate_Name#" maxlength="50"><cfelse>'Rebate'</cfif>,
						Rebate = <cfif isvalid("integer",form.Rebate) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Rebate#" maxlength="10"><cfelse>Null</cfif>,
						Incentive_Name = <cfif len(trim(form.Incentive_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Incentive_Name#" maxlength="50"><cfelse>'Incentive'</cfif>,
						Incentive = <cfif isvalid("integer",form.Incentive) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Incentive#" maxlength="10"><cfelse>Null</cfif>,
						Deduction_Mileage = <cfif isvalid("integer",form.Deduction_Mileage) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Mileage#" maxlength="10"><cfelse>Null</cfif>,
						Deduction_Age = <cfif isvalid("integer",form.Deduction_Age) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Age#" maxlength="10"><cfelse>Null</cfif>,
						Deduction_Age_Type = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Deduction_Age_Type#" maxlength="1">,
						Deduction_Age_Frequency = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.Deduction_Age_Frequency#" maxlength="2">,
						Deduction_Age_Days = <cfif isvalid("integer",form.Deduction_Age_Days) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Age_Days#" maxlength="10"><cfelse>Null</cfif>,
						Deduction_Freight = <cfif isvalid("integer",form.Deduction_Freight) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Deduction_Freight#" maxlength="10"><cfelse>Null</cfif>,
						Savings_Name = <cfif len(trim(form.Savings_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Savings_Name#" maxlength="50"><cfelse>''</cfif>,
						Selling_Name = <cfif len(trim(form.Selling_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Selling_Name#" maxlength="50"><cfelse>'Sale Price'</cfif>,
						Disclaimer = <cfif len(trim(form.Disclaimer)) gt 0>'#form.Disclaimer#'<cfelse>NULL</cfif>,
						Override_AIS = <cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.Override_AIS#" maxlength="1">,
						All_Makes = <cfqueryparam cfsqltype="cf_sql_bit" value="#form.All_Makes#" maxlength="1">,
						All_Models = <cfqueryparam cfsqltype="cf_sql_bit" value="#form.All_Models#" maxlength="1">,
						Active = <cfqueryparam cfsqltype="CF_SQL_BIT" value="1" maxlength="1">,
						Go_Live = <cfif arguments.go_live eq "yes">1<cfelse>0</cfif>
				WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.price_rule_id#" maxlength="10">
			</cfquery>
	
			<cfset variables.rule_id=form.Price_Rule_ID>
					
		</cfif>
		
		<cfreturn variables.rule_id>
		
	</cffunction>

	<cffunction name="update_exceptions" description="updates rule exceptions" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		
		<!--- form params --->
		<cfparam name="form.ex_vin" default="">
		<cfparam name="form.assn_ex_vin" default="">

		<cfif len(trim(form.ex_vin)) gt 0>

			<cftransaction>

				<cfloop list="#form.ex_vin#" index="i">

					<cfquery datasource="#arguments.DSN#" name="Insert_Make_Code">
						INSERT INTO		Price_Rule_Exceptions
							(Price_Rule_ID,
							Vin)
						VALUES
							(<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(variables.i,17)#" maxlength="21">)
					</cfquery>

				</cfloop>

			</cftransaction>
		
		</cfif>

		<cfif len(trim(form.assn_ex_vin)) gt 0>
		
			<cfloop list="#form.assn_ex_vin#" index="ex">

				<cfquery datasource="#arguments.DSN#" name="Delete_Exclusion_Code">
					DELETE	Price_Rule_Exceptions
					WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
					AND		Vin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(variables.ex,17)#" maxlength="21">
				</cfquery>

			</cfloop>
		
		</cfif>
		
	</cffunction>
	
	<cffunction name="update_makes" description="updates rule makes" output="no" access="public">
	
		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		
		<!--- form params --->
		<cfparam name="form.Make_ID" default="">
		<cfparam name="form.Assn_Make_ID" default="">
		
		<cfif form.Make_ID Contains "All">

			<cftransaction>
				<cfquery datasource="#arguments.DSN#" name="Clear_Old_Model_Codes">
					DELETE		Price_Rule_Models
					WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>

				<cfquery datasource="#arguments.DSN#" name="Clear_Old_Make_Codes">
					DELETE		Price_Rule_Makes
					WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>
				
				<cfquery datasource="#arguments.DSN#" name="Insert_Model_Codes">
					INSERT INTO		Price_Rule_Makes
						(Price_Rule_ID,
						Make_ID)
						SELECT		#arguments.price_rule_id# as Price_Rule_ID,
									Make_ID
						FROM		X_Makes
						ORDER BY	Make_Name
				</cfquery>

				<cfquery datasource="#arguments.DSN#" name="Update_Rule">
					UPDATE	Price_Rules
					SET		All_Makes = 1,
							All_Models = 1
					WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>
				
			</cftransaction>
		
		<cfelse>
			
			<cfif len(trim(form.Make_ID)) gt 0>

				<cftransaction>
					<cfquery datasource="#arguments.DSN#" name="Clear_Old_Model_Codes">
						DELETE		Price_Rule_Models
						WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
					</cfquery>
				
					<cfloop list="#form.Make_ID#" index="i">
	
						<cfquery datasource="#arguments.DSN#" name="Insert_Make_Code">
							INSERT INTO		Price_Rule_Makes
								(Price_Rule_ID,
								Make_ID)
							VALUES
								(<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">,
								<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#variables.i#" maxlength="10">)
						</cfquery>
	
					</cfloop>

				</cftransaction>
			
			</cfif>
			
			<cfif len(trim(form.Assn_Make_ID)) gt 0>
			
				<cfloop list="#form.Assn_Make_ID#" index="i">

					<cfquery datasource="#arguments.DSN#" name="Delete_Make_Code">
						DELETE	Price_Rule_Makes
						WHERE	Price_Rule_Make_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#variables.i#" maxlength="10">
					</cfquery>

				</cfloop>
			
			</cfif>

			<cftransaction>
			
				<cfquery datasource="#arguments.DSN#" name="Update_Rule">
					UPDATE	Price_Rules
					SET		All_Makes = 0,
							All_Models = 0
					WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>
			
			</cftransaction>
			
		</cfif>
	
	</cffunction>
	
	<cffunction name="update_models" description="updates rule mdoels" output="no" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		
		<!--- form params --->
		<cfparam name="form.Model_Code_ID" default="">
		<cfparam name="form.Assn_Model_Code_ID" default="">
		<cfparam name="form.Make_Model_ID" default="">

		<cfif form.Model_Code_ID Contains "All">
		
			<cftransaction>
				<cfquery datasource="#arguments.DSN#" name="Clear_Old_Model_Codes">
					DELETE		Price_Rule_Models
					WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>

				<cfquery datasource="#arguments.DSN#" name="Insert_Model_Codes">
					INSERT INTO		Price_Rule_Models
						(Price_Rule_ID,
						Model_Code_ID)
						SELECT		#form.Price_Rule_ID# as Price_Rule_ID,
									X_Model_Codes.Model_Code_ID
						FROM		X_Models
						INNER JOIN	X_Model_Codes
						ON			X_Models.Model_ID = X_Model_Codes.Model_ID
						WHERE		X_Models.Make_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Make_Model_ID#" maxlength="3">
						ORDER BY 	X_Models.Model_Name, X_Model_Codes.Model_Code
				</cfquery>

				<cfquery datasource="#arguments.DSN#" name="Update_Rule">
					UPDATE	Price_Rules
					SET		All_Models = 1,
							All_Makes = 0
					WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>
				
			</cftransaction>

		<cfelse>

			<cfif len(trim(form.Model_Code_ID)) gt 0>

				<cftransaction>
	
					<cfloop list="#form.Model_Code_ID#" index="i">
	
						<cfquery datasource="#arguments.DSN#" name="Insert_Model_Code">
							INSERT INTO		Price_Rule_Models
								(Price_Rule_ID,
								Model_Code_ID)
							VALUES
								(<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">,
								<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#variables.i#" maxlength="10">)
						</cfquery>
	
					</cfloop>
				<cftransaction>

			</cfif>

			<cfif len(trim(form.Assn_Model_Code_ID)) gt 0>

				<cftransaction>
	
					<cfloop list="#form.Assn_Model_Code_ID#" index="i">
		
						<cfquery datasource="#arguments.DSN#" name="Delete_Model_Code">
							DELETE	Price_Rule_Models
							WHERE	Price_Rule_Model_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#variables.i#" maxlength="10">
						</cfquery>
	
					</cfloop>

				<cftransaction>

			</cfif>
			
			<cftransaction>

				<cfquery datasource="#arguments.DSN#" name="Update_Rule">
					UPDATE	Price_Rules
					SET		All_Models = 0,
							All_Makes = 0
					WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				</cfquery>

			</cftransaction>
			
		</cfif>

	</cffunction>

	<cffunction name="delete_rule" description="deactivates rule" output="no" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">

		<cftransaction>
			<cfquery datasource="#arguments.DSN#" name="Delete_Rule">
				UPDATE	Price_Rules
				SET		End_Date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">,
						Active = 0,
						Go_Live = 0
				WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
			</cfquery>
		</cftransaction>

	</cffunction>

</cfcomponent>