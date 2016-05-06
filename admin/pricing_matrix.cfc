<cfcomponent>
	
	<cffunction name="get_rules" description="gets active rules" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		
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
			</cftransaction>

			<cfif Get_New_Default.Recordcount eq 0 or Get_Used_Default.Recordcount eq 0>
				<table class="table-std" cellpadding="0" cellspacing="0">
					<tr>
						<td class="table-title" align="center">Create Default Pricing Rules</td>
					</tr>
					<cfif Get_New_Default.Recordcount eq 0>
						<tr>
							<td class="table-data">
								<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?dealer_id=#arguments.dealer_id#&page_action=edit_default&new_used=N&Price_Rule_ID=0">Create New Vehicle Default Rule</a>
							</td>
						</tr>
					</cfif>
					<cfif Get_Used_Default.Recordcount eq 0>
						<tr>
							<td class="table-data">
								<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?dealer_id=#arguments.dealer_id#&page_action=edit_default&new_used=U&Price_Rule_ID=0">Create Used Vehicle Default Rule</a>
							</td>
						</tr>
					</cfif>
					<tr>
						<td class="table-data" align="center"><b style="color:red;">Default Rules MUST be created before custom rules</b></td>
					</tr>
				</table>
			</cfif>
	
			<!---<cfif Get_New_Default.Recordcount eq 1 and Get_Used_Default.Recordcount eq 1>
				<!--- Get Pricing Rules --->
				<cftransaction>
					<cfquery datasource="#arguments.DSN#" name="Get_Rules">
						SELECT		Price_Rule_ID,
									Dealer_ID,
									Rule_Description,
									Start_Date,
									End_Date
						FROM		Price_Rules
						WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">
						AND			Active = 1
					</cfquery>
				</cftransaction>
	
				<table class="table-std" cellpadding="0" cellspacing="0">
					<tr>
						<td class="table-title">Rule</td>
						<td class="table-title">Start Date</td>
						<td class="table-title">End Date</td>
						<td class="table-title" align="center">Action</td>
					</tr>
					<cfloop query="Get_Rules">
						<tr>
							<td class="table-data">#Get_Rules.Rule_Description#</td>
							<td class="table-data">#dateformat(Get_Rules.Start_Date,"mm/dd/yyyy")#</td>
							<td class="table-data"><cfif Get_Rules.End_Date eq "12/31/2100">Does Not Expire<cfelse>#dateformat(Get_Rules.End_Date,"mm/dd/yyyy")#</cfif></td>
							<td class="table-data">
								<a class="table-link" href="#arguments.form_action#?page_action=Modify_Rule&Price_Rule_ID=#Get_Rules.Price_Rule_ID#">Modify</a> | 
								<a class="table-link" href="#arguments.form_action#?page_action=Delete_Rule&Price_Rule_ID=#Get_Rules.Price_Rule_ID#&Dealer_ID=#arguments.dealer_id#">Delete</a>
							</td>
						</tr>
					</cfloop>
					<tr>
						<td colspan="4">
							<a class="table-link" href="#arguments.form_action#?page_action=Create_Rule&Dealer_ID=#arguments.dealer_id#">Create A New Rule</a>
						</td>
					</tr>
				</table>
			</cfif>
		
			<form>
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h1>Rule Name</h1>	
						</div>
					</div>
					<div class="row">
						<div class="">
							<div class="bs-example bs-example-tabs">
								<ul id="myTab" class="nav nav-tabs">
									<li class="active"><a href="##Vehicles" data-toggle="tab">Select Vehicles</a></li>
									<li><a href="##Lables" data-toggle="tab">Set Labels</a></li>
								</ul>
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade in active" id="Vehicles">
										Vehicles
									</div>
									<div class="tab-pane fade" id="Lables">
										Labels
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="" align="right">
							<input type="submit" value="Save"/>	
						</div>
					</div>
				</div>
			</form>--->


		</cfif>
				
	</cffunction>

	<cffunction name="edit_rule" description="setup default rule" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		<cfargument name="new_used" default="U">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="default_rule" default="no">

		<cftransaction>
			<cfquery datasource="#arguments.DSN#" name="Get_Rule">
				SELECT		Price_Rule_ID,
							Dealer_ID,
							Rule_Description,
							Start_Date,
							End_Date
				FROM		Price_Rules
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">
				AND			Default_Rule = 1
				AND			New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.new_used#" maxlength="1">
			</cfquery>
		</cftransaction>

		<cfif len(trim(Get_Rule.Price_Rule_ID)) gt 0>
			<cfset arguments.price_rule_id=Get_Rule.Price_Rule_ID>
		<cfelse>
			<cfset arguments.price_rule_id=0>
		</cfif>

		<cfif arguments.price_rule_id neq 0>
			<cfquery datasource="#arguments.DSN#" name="Get_Rule">
				SELECT		Price_Rule_ID,
							Dealer_ID,
							Rule_Description,
							Start_Date,
							End_Date
				FROM		Price_Rules
				WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.price_rule_id#" maxlength="10">
			</cfquery>
		</cfif>

		<cfswitch expression="#arguments.new_used#">
			<cfdefaultcase>
				<cfset variables.Rule_Description="Default Rule - Used Cars">
				<cfset variables.My_New_Used="Used">
			</cfdefaultcase>
			<cfcase value="N">
				<cfset variables.Rule_Description="Default Rule - New Cars">
				<cfset variables.My_New_Used="Used">
			</cfcase>
		</cfswitch>

		<div class="container">
			<form style="padding:20px;" action="#arguments.form_action#" method="post">
				<div class="row">
					<div class="col-md-12">
						<h1>#variables.Rule_Description#</h1>	
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="bs-example bs-example-tabs">
							<ul id="myTab" class="nav nav-tabs">
								<li class="active"><a href="##Vehicles" data-toggle="tab">Setup</a></li>
								<li><a href="##Lables" data-toggle="tab">Set Labels</a></li>
							</ul>
							<div id="myTabContent" class="tab-content">
								<div class="tab-pane fade in active" id="Vehicles">
									Setup
								</div>
								<div class="tab-pane fade" id="Lables">
									Labels
								</div>
							</div>
						</div>
						<!---<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade in active" id="Vehicles">
								<table>
									<tr>
										<td>Rule Name&nbsp;:&nbsp;</td>
										<td><input type="text" name="Rule_Description" value="#variables.Rule_Description#"/></td>
									</tr>
								</table>
							</div>
							<div class="tab-pane fade" id="Lables">
								Labels
							</div>
						</div>--->
					</div>
				</div>
				<!---<div class="row">
					<div class="col-md-12">
						<input class="btn btn-primary" type="button" value="Save">	
					</div>
				</div>

				Vehicle Type&nbsp;:&nbsp;
				#variables.My_New_Used#
				<br/><br/>
				Disclaimer&nbsp;:&nbsp;
				<textarea name="Disclaimer"></textarea>
				<br/><br/>
				
				<br/><br/>
	
				<input type="hidden" name="Rule_Description" value="#variables.Rule_Description#">
				<input type="hidden" name="New_Used" value="#arguments.New_Used#">
				<input type="hidden" name="Price_Rule_ID" value="#arguments.price_rule_id#">
				<input type="hidden" name="All_Makes" value="1">
				<input type="hidden" name="All_Models" value="1">
				<input type="hidden" name="Go_Live" value="1">
				<input type="hidden" name="Default_Rule" value="1">--->
				
			</form>
		</div>

	</cffunction>
	
	<cffunction name="delete_rule" description="deactivates rule" output="no" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">

		<cftransaction>
			<cfquery datasource="#arguments.DSN#" name="Delete_Rule">
				UPDATE	Price_Rules
				SET		End_Date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10">,
						Active = 0
				WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
			</cfquery>
		</cftransaction>
		
		<cflocation url="#arguments.form_action#?Dealer_ID=#arguments.dealer_id#">

	</cffunction>
	
	<cffunction name="create_rule" description="creates new rule" output="no" access="public">
	
		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">

		<cfif len(trim(arguments.dealer_id)) gt 0>
		
			<cftransaction>
				<cfquery datasource="#arguments.DSN#" name="Start_Rule">
					INSERT INTO	Price_Rules
						(Dealer_ID,
						Rule_Description,
						Active)
					VALUES
						(<cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Untitled" maxlength="50">,
						<cfqueryparam cfsqltype="CF_SQL_BIT" value="0" maxlength="1">)
				</cfquery>
				<cfquery datasource="#arguments.DSN#" name="Get_New_Rule">
					SELECT	max(Price_Rule_ID) as New_ID
					FROM	Price_Rules
					WHERE	Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.dealer_id#" maxlength="10">
					AND		Active = <cfqueryparam cfsqltype="CF_SQL_BIT" value="0" maxlength="1">
				</cfquery>
			</cftransaction>
			
			<cflocation url="#arguments.form_action#?page_action=Modify_Rule&Price_Rule_ID=#Get_New_Rule.New_ID#">
			
		</cfif>
	
	</cffunction>

	<cffunction name="modify_rule" description="modifies an existing rule" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		<cfargument name="make_id" required="yes">
		
		<!--- url params --->
		<cfparam name="url.updated" default="No">

		<cfif len(trim(arguments.price_rule_id)) gt 0>
			
			<cftransaction>
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
								Disclaimer
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
				
				<cfquery datasource="#arguments.DSN#" name="Get_Snapshot">
					SELECT		Top 5
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
					WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#Get_Rule.Dealer_ID#" maxlength="10">
					<cfif Get_Rule.New_Used neq "A">
						AND		New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Get_Rule.New_Used#" maxlength="1">
					</cfif>
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
			</cftransaction>
			
			<!--- <cf_randomquery DataSource="Get_Snapshot" Name="Get_Snapshot" MaxRows="5"> --->

			<script type="text/javascript">
				function updateMake(){
					document.getElementById('Price_Form').action = '#arguments.form_action#?page_action=Update_Make'
					document.getElementById('Price_Form').submit();
				}
				function updateModel(){
					document.getElementById('Price_Form').action = '#arguments.form_action#?page_action=Update_Model'
					document.getElementById('Price_Form').submit();
				}
				function previewRule(){
					document.getElementById('Price_Form').action = '#arguments.form_action#?page_action=Preview_Rule&price_rule_id=#arguments.price_rule_id#'
					document.getElementById('Price_Form').submit();
				}
			</script>
			
			<form id="Price_Form" name="Price_Form" action="#arguments.form_action#?page_action=Update_Rule" method="post">

				<!--- hidden variables --->
				<input type="Hidden" name="Price_Rule_ID" value="#arguments.price_rule_id#" />
				<input type="Hidden" name="Dealer_ID" value="#Get_Rule.Dealer_ID#" />
				<cfif Get_Assigned_Makes.recordcount eq 1>
					<input type="Hidden" name="Make_Model_ID" value="#arguments.Make_ID#" />
				<cfelse>
					<input type="Hidden" name="Make_Model_ID" value="0" />
				</cfif>
				
				
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div class="div-std">
								<cfif url.updated eq "yes"><div class="updated-div">Rule Updated</div></cfif>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data">Rule Name :</td>
										<td class="table-data"><input class="table-input-data" type="Text" name="Rule_Description" value="#Get_Rule.Rule_Description#" maxlength="50" /></td>
										<td class="table-data">Start Date :</td>
										<td class="table-data"><input class="table-input-data" type="Text" name="Start_Date" value="#dateformat(Get_Rule.Start_Date,'mm/dd/yyyy')#" maxlength="10" /></td>
										<td class="table-data">End Date :</td>
										<cfif Get_Rule.End_Date eq "12/31/2100">
											<td class="table-data"><input class="table-input-data" type="Text" name="End_Date" value="" maxlength="10" /></td>							
										<cfelse>
											<td class="table-data"><input class="table-input-data" type="Text" name="End_Date" value="#dateformat(Get_Rule.End_Date,'mm/dd/yyyy')#" maxlength="10" /></td>
										</cfif>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
									The vehicles selected below will be affected by this Pricing Matrix Rule.
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data">Type :</td>
										<td class="table-data">Year :</td>
										<td class="table-data">Available Makes :</td>
										<td class="table-data">Assigned Makes :</td>
										<td class="table-data"><cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>Availble Models :</cfif></td>
										<td class="table-data"><cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>Assigned Models :</cfif></td>
									</tr>
									<tr>
										<td class="table-data" valign="top">
											<select class="table-input-data" name="New_Used">
												<!---<option value="A" <cfif Get_Rule.New_Used eq "A">selected</cfif>>All Types--->
												<option value="N" <cfif Get_Rule.New_Used eq "N">selected</cfif>>New
												<option value="U" <cfif Get_Rule.New_Used eq "U">selected</cfif>>Used
											</select>
										</td>
										<td class="table-data" valign="top">
											<select class="table-input-data" name="V_Year">
												<option value="0" <cfif Get_Rule.V_Year eq "0">selected</cfif>>All Years
												<cfloop from="#dateformat(dateadd('yyyy',1,now()),'yyyy')#" to="1923" index="v_year" step="-1">
													<option value="#variables.v_year#" <cfif Get_Rule.V_Year eq variables.v_year>selected</cfif>>#variables.v_year#</option>
												</cfloop>
											</select>
										</td>
										<td class="table-data" valign="top">
											<select class="table-input-data table-select-data" id="Make_ID" name="Make_ID" multiple size="10" onblur="javascript:updateMake();">
												<option value="All">All Makes
												<cfloop query="Get_Makes">
													<option value="#Get_Makes.Make_ID#">#Get_Makes.Make_Name#</option>
												</cfloop>
											</select>
										</td>
										<td class="table-data" valign="top">
											<select class="table-input-data table-select-data" id="Assn_Make_ID" name="Assn_Make_ID" multiple size="10" onblur="javascript:updateMake();">
												<cfloop query="Get_Assigned_Makes">
													<option value="#Get_Assigned_Makes.Price_Rule_Make_ID#">#Get_Assigned_Makes.Make_Name#</option>
												</cfloop>
											</select>
										</td>
										<td class="table-data" valign="top">
											<cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>
												<select class="table-input-data table-select-data" id="Model_Code_ID" name="Model_Code_ID" multiple size="10" onblur="javascript:updateModel();">
													<option value="All">All Models</option>
													<cfloop query="Get_Model_Codes">
														<option value="#Get_Model_Codes.Model_Code_ID#">#Get_Model_Codes.Model_Code# #Get_Model_Codes.Model_Name# #Get_Model_Codes.Trim_Level#</option>
													</cfloop>
												</select>
											<cfelse>
												<input type="Hidden" id="Model_Code_ID" name="Model_Code_ID" value="" />
											</cfif>
										</td>
										<td class="table-data" valign="top">
											<cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1>
												<select class="table-input-data table-select-data" id="Assn_Model_Code_ID" name="Assn_Model_Code_ID" multiple size="10" onblur="javascript:updateModel();">
													<cfloop query="Get_Assigned_Models">
														<option value="#Get_Assigned_Models.Price_Rule_Model_ID#">#Get_Assigned_Models.Model_Code# #Get_Assigned_Models.Model_Name# #Get_Assigned_Models.Trim_Level#</option>
													</cfloop>
												</select>
											<cfelse>
												<input type="Hidden" id="Assn_Model_Code_ID" name="Assn_Model_Code_ID" value="" />
											</cfif>
										</td>
									</tr>
									<tr>
										<td colspan="2">&nbsp;</td>
										<td colspan="2" align="center"><input class="form-bnt-a" type="Button" value="Update Makes" /></td>
										<td colspan="2" align="center"><cfif arguments.Make_ID gt 0 and listlen(arguments.Make_ID) eq 1><input class="form-bnt-a" type="Button" value="Update Models" /></cfif></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
								Price Mapping & Labels<br />
								The chosen "baseline price field" is used as the starting point for this rule. This price will be altered by this rule and reflected in the advertised selling price.<br />
								For example, to set your vehicles' selling price to be "MSRP minus 10%", you would choose the corresponding Price Field (usually Price Field 1) as the baseline price field.<br />
								The 'MSRP/Retail Price' will not be affected by this rule and will be displayed as a customer reference.<br />
								All 'Pricing Labels' are fully customizable.
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data">Baseline Price Label :</td>
										<td class="table-data">
											<input class="table-input-data" type="Text" name="Baseline_Price_Name" value="#Get_Rule.Baseline_Price_Name#" />
										</td>
										<td class="table-data">Baseline Price Field :</td>
										<td class="table-data">
											<select class="table-input-data" name="Baseline_Price_Field">
												<option value="Price_1" <cfif Get_Rule.Baseline_Price_Field eq "Price_1">selected</cfif>>Price Field 1</option>
												<option value="Price_2" <cfif Get_Rule.Baseline_Price_Field eq "Price_2">selected</cfif>>Price Field 2</option>
												<option value="Price_3" <cfif Get_Rule.Baseline_Price_Field eq "Price_3">selected</cfif>>Price Field 3</option>
												<option value="Price_4" <cfif Get_Rule.Baseline_Price_Field eq "Price_4">selected</cfif>>Price Field 4</option>
												<option value="Price_5" <cfif Get_Rule.Baseline_Price_Field eq "Price_5">selected</cfif>>Price Field 5</option>
											</select>
										</td>
										<td>This selection is required.</td>
										<!--- <td class="table-data">Destination Price Field :</td>
										<td class="table-data">
											<select class="table-input-data" name="Destination_Price_Field">
												<option value="Selling_Price" <cfif Get_Rule.Baseline_Price_Field eq "Selling_Price">selected</cfif>>Selling Price</option>
											</select>
										</td> --->
									</tr>
									<tr>
										<td class="table-data">MSRP/Retail Price Label :</td>
										<td class="table-data">
											<input class="table-input-data" type="Text" name="MSRP_Price_Name" value="#Get_Rule.MSRP_Price_Name#" />
										</td>
										<td class="table-data">MSRP/Retail Price Field :</td>
										<td class="table-data">
											<select class="table-input-data" name="MSRP_Price_Field">
												<option value="None" <cfif Get_Rule.MSRP_Price_Field eq "None">selected</cfif>>None</option>
												<option value="Price_1" <cfif Get_Rule.MSRP_Price_Field eq "Price_1">selected</cfif>>Price Field 1</option>
												<option value="Price_2" <cfif Get_Rule.MSRP_Price_Field eq "Price_2">selected</cfif>>Price Field 2</option>
												<option value="Price_3" <cfif Get_Rule.MSRP_Price_Field eq "Price_3">selected</cfif>>Price Field 3</option>
												<option value="Price_4" <cfif Get_Rule.MSRP_Price_Field eq "Price_4">selected</cfif>>Price Field 4</option>
												<option value="Price_5" <cfif Get_Rule.MSRP_Price_Field eq "Price_5">selected</cfif>>Price Field 5</option>
											</select>
										</td>
										<td class="table-data">
											Choose "None" to hide this from the customer
										</td>
									</tr>
									<tr>
										<td class="table-data">Tertiary Price Label :</td>
										<td class="table-data">
											<input class="table-input-data" type="Text" name="Tertiary_Price_Name" value="#Get_Rule.Tertiary_Price_Name#" />
										</td>
										<td class="table-data">Display Only Price Field :</td>
										<td class="table-data">
											<select class="table-input-data" name="Tertiary_Price_Field">
												<option value="None" <cfif Get_Rule.Tertiary_Price_Field eq "None">selected</cfif>>None</option>
												<option value="Price_1" <cfif Get_Rule.Tertiary_Price_Field eq "Price_1">selected</cfif>>Price Field 1</option>
												<option value="Price_2" <cfif Get_Rule.Tertiary_Price_Field eq "Price_2">selected</cfif>>Price Field 2</option>
												<option value="Price_3" <cfif Get_Rule.Tertiary_Price_Field eq "Price_3">selected</cfif>>Price Field 3</option>
												<option value="Price_4" <cfif Get_Rule.Tertiary_Price_Field eq "Price_4">selected</cfif>>Price Field 4</option>
												<option value="Price_5" <cfif Get_Rule.Tertiary_Price_Field eq "Price_5">selected</cfif>>Price Field 5</option>
											</select>
										</td>
										<td class="table-data">
											Third "Display Only" Price. Often set to Invoice.<br />Choose "None" to hide this from the customer (Default Setting)
										</td>
									</tr>
									<tr>
										<td class="table-data">Total Savings Label :</td>
										<td class="table-data">
											<input class="table-input-data" type="Text" name="Savings_Name" value="#Get_Rule.Savings_Name#" />
										</td>
										<td colspan="2" class="table-data">
											Leave blank to hide this from the customer
										</td>
									</tr>
									<tr>
										<td class="table-data">Sale Label :</td>
										<td class="table-data">
											<input class="table-input-data" type="Text" name="Selling_Name" value="#Get_Rule.Selling_Name#" />
										</td>
										<td colspan="2" class="table-data">
											This label is required
										</td>
									</tr>
								</table>
								<div class="table-title-sm">
									Raw Inventory Snapshot
									<cfswitch expression="#Get_Rule.New_Used#">
										<cfcase value="A">(All)</cfcase>
										<cfcase value="N">(New)</cfcase>
										<cfcase value="U">(Used)</cfcase>
									</cfswitch>
								</div>
								<table width="100%" border="1" bordercolorlight="##333333" bordercolordark="##333333" cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data-sm-title">Stock</td>
										<td class="table-data-sm-title">Model</td>
										<td class="table-data-sm-title">Vehicle</td>
										<td class="table-data-sm-title">Price 1</td>
										<td class="table-data-sm-title">Price 2</td>
										<td class="table-data-sm-title">Price 3</td>
										<td class="table-data-sm-title">Price 4</td>
										<td class="table-data-sm-title">Price 5</td>
									</tr>
									<cfloop query="Get_Snapshot">
										<tr>
											<td class="table-data-sm-data">#Get_Snapshot.Stock#</td>
											<td class="table-data-sm-data">#Get_Snapshot.V_Model_Number#</td>
											<td class="table-data-sm-data">#Get_Snapshot.V_Year# #Get_Snapshot.V_Make_Alias# #Get_Snapshot.V_Model# <cfif Get_Snapshot.New_Used eq "N">(New)<cfelse>(Used)</cfif> </td>
											<td class="table-data-sm-data">#Get_Snapshot.Price_1#</td>
											<td class="table-data-sm-data">#Get_Snapshot.Price_2#</td>
											<td class="table-data-sm-data">#Get_Snapshot.Price_3#</td>
											<td class="table-data-sm-data">#Get_Snapshot.Price_4#</td>
											<td class="table-data-sm-data">#Get_Snapshot.Price_5#</td>
										</tr>
									</cfloop>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
									Pricing Adjustment<br />
									The price will first be adjusted by the amount chosen below.
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data">
											<select class="table-input-data" name="Price_Adj_Scale">
												<option value="0" <cfif Get_Rule.Price_Adj_Scale eq 0>selected</cfif>>Add (+)</option>
												<option value="1" <cfif Get_Rule.Price_Adj_Scale eq 1>selected</cfif>>Subtract (-)</option>
											</select>
										</td>
										<td class="table-data">
											<input class="table-input-data" type="Text" name="Price_Adj_Amt" value="#Get_Rule.Price_Adj_Amt#" />
										</td>
										<td class="table-data">
											<select class="table-input-data" name="Price_Adj_Type">
												<option value="0" <cfif Get_Rule.Price_Adj_Type eq 0>selected</cfif>>Percent (%)</option>
												<option value="1" <cfif Get_Rule.Price_Adj_Type eq 1>selected</cfif>>Dollar ($)</option>
											</select>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
									Rebates &amp; Incentives<br />
									You can offer rebates and incentives on your vehicles. The numbers below will each be subtracted from the price after the adjustment above is applied.
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data"><input class="table-input-data" type="Text" name="Rebate_Name" value="#Get_Rule.Rebate_Name#" /></td>
										<td class="table-data">$</td>
										<td class="table-data"><input class="table-input-data" type="Text" name="Rebate" value="#Get_Rule.Rebate#" /></td>
									</tr>
									<tr>
										<td class="table-data"><input class="table-input-data" type="Text" name="Incentive_Name" value="#Get_Rule.Incentive_Name#" /></td>
										<td class="table-data">$</td>
										<td class="table-data"><input class="table-input-data" type="Text" name="Incentive" value="#Get_Rule.Incentive#" /></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
									Deductions<br />
									You can also offer deductions by age or mileage. If they apply, the numbers below will each be subtracted from the Selling Price.
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data" class="table-input-data">Deduct</td>
										<td class="table-data" class="table-input-data">$</td>
										<td class="table-data" class="table-input-data"><input class="table-input-data" type="Text" name="Deduction_Mileage" value="#Get_Rule.Deduction_Mileage#" maxlength="4" /></td>
										<td class="table-data" class="table-input-data" colspan="5">per mile</td>
									</tr>
									<tr>
										<td class="table-data" class="table-input-data">Deduct</td>
										<td class="table-data" class="table-input-data"></td>
										<td class="table-data" class="table-input-data"><input class="table-input-data" type="Text" name="Deduction_Age" value="#Get_Rule.Deduction_Age#" maxlength="4" /></td>
										<td class="table-data" class="table-input-data">
											<select class="table-input-data" name="Deduction_Age_Type">
												<option value="0" <cfif Get_Rule.Deduction_Age_Type eq 0>selected</cfif>>%</option>
												<option value="1" <cfif Get_Rule.Deduction_Age_Type eq 1>selected</cfif>>$</option>
											</select>
										</td>
										<td class="table-data" class="table-input-data">
											<select class="table-input-data" name="Deduction_Age_Frequency">
												<option value="1" <cfif Get_Rule.Deduction_Age_Frequency eq 1>selected</cfif>>Once</option>
												<option value="2" <cfif Get_Rule.Deduction_Age_Frequency eq 2>selected</cfif>>Daily</option>
												<option value="3" <cfif Get_Rule.Deduction_Age_Frequency eq 3>selected</cfif>>Weekly</option>
												<option value="4" <cfif Get_Rule.Deduction_Age_Frequency eq 4>selected</cfif>>Monthly</option>
											</select>
										</td>
										<td class="table-data" class="table-input-data">
											once in stock for
										</td>
										<td class="table-data" class="table-input-data">
											<input class="table-input-data" type="Text" name="Deduction_Age_Days" value="#Get_Rule.Deduction_Age_Days#" maxlength="4">
										</td>
										<td class="table-data" class="table-input-data">day(s).</td>
									</tr>
									<tr>
										<td class="table-data" class="table-input-data">Freight</td>
										<td class="table-data" class="table-input-data">$</td>
										<td class="table-data" class="table-input-data" colspan="6"><input class="table-input-data" type="Text" name="Deduction_Freight" value="#Get_Rule.Deduction_Freight#" maxlength="4" /></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
									Disclaimer
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data">
											<textarea name="Disclaimer" cols="100" rows="5">#Get_Rule.Disclaimer#</textarea>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="div-std">
								<div class="table-title-sm">
									Miscellaneous Options
								</div>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="table-data">Override AIS Incentives :</td>
										<td class="table-data">
											<input class="table-input-data" type="radio" name="Override_AIS" value="1" <cfif Get_Rule.Override_AIS eq 1>checked</cfif> >Yes
											<input class="table-input-data" type="radio" name="Override_AIS" value="0" <cfif Get_Rule.Override_AIS eq 0>checked</cfif>>No											
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<input class="form-bnt-a" type="Button" value="Go Back" onclick="javascript:location.href='#arguments.form_action#?Dealer_ID=#arguments.dealer_id#';" />
							<input class="form-bnt-a" type="Submit" value="Save Rule" />
							<input class="form-bnt-a" type="Button" value="Preview Rule" onclick="javascript:previewRule();" />
						</td>
					</tr>
				</table>
	
			</form>
			
		</cfif>
		
	</cffunction>
	
	<cffunction name="update_rule" description="updates an existing rule" output="no" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">

		<!--- form params --->
		<cfparam name="form.Price_Rule_ID" default="">
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
		
		<!--- Strip Undesireable Characters --->

		<!--- From Price_Adj_Amt--->
		<cfset form.Price_Adj_Amt=replace(form.Price_Adj_Amt,".00","","all")>
		<cfset form.Price_Adj_Amt=rereplace(form.Price_Adj_Amt, "[^\w]", "", "all")>
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
		
		<cftransaction>
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
						<!--- Destination_Price_Field = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Destination_Price_Field#" maxlength="50">, --->
						MSRP_Price_Name = <cfif len(trim(form.MSRP_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MSRP_Price_Name#" maxlength="50"><cfelse>'MSRP'</cfif>,
						MSRP_Price_Field = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MSRP_Price_Field#" maxlength="10">,
						Tertiary_Price_Name = <cfif len(trim(form.Tertiary_Price_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Tertiary_Price_Name#" maxlength="50"><cfelse>'Invoice'</cfif>,
						Tertiary_Price_Field = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Tertiary_Price_Field#" maxlength="10">,
						Price_Adj_Scale = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Price_Adj_Scale#" maxlength="1">,
						Price_Adj_Amt = <cfif isvalid("integer",form.Price_Adj_Amt) eq "Yes"><cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#form.Price_Adj_Amt#" maxlength="10"><cfelse>Null</cfif>,
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
						Override_AIS = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.Override_AIS#" maxlength="1">,
						Active = <cfqueryparam cfsqltype="CF_SQL_BIT" value="1" maxlength="1">
				WHERE	Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
			</cfquery>
		</cftransaction>
	
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
	
	<cffunction name="preview_rule" description="modifies an existing rule" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="form_action" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="price_rule_id" required="yes">
		
		<cftransaction>
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
							All_Makes,
							All_Models
				FROM		Price_Rules
				WHERE		Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
			</cfquery>

			<cfquery datasource="#arguments.DSN#" name="Get_Makes">
				SELECT		Price_Rule_Makes.Make_ID,
							X_Makes.Make_Name
				FROM		Price_Rule_Makes
				INNER JOIN	X_Makes
				ON			Price_Rule_Makes.Make_ID = X_Makes.Make_ID
				WHERE		Price_Rule_Makes.Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
				ORDER BY	X_Makes.Make_Name
			</cfquery>

			<cfif Get_Makes.Recordcount eq 1>
				<cfswitch expression="#Get_Rule.All_Models#">
					<cfcase value="0">
						<cfquery datasource="#arguments.DSN#" name="Get_Models">
							SELECT		X_Model_Codes.Model_Code
							FROM		Price_Rule_Models
							INNER JOIN	X_Model_Codes
							ON			Price_Rule_Models.Model_Code_ID = X_Model_Codes.Model_Code_ID
							WHERE		Price_Rule_Models.Price_Rule_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#arguments.price_rule_id#" maxlength="10">
						</cfquery>
					</cfcase>
					<cfcase value="1">
						<cfquery datasource="#arguments.DSN#" name="Get_Models">
							SELECT		X_Makes.Make_Name,
										X_Models.Model_Name,
										'All' as Model_Code
							FROM		X_Models
							INNER JOIN	X_Makes
							ON			X_Models.Make_ID = X_Makes.Make_ID
							WHERE		X_Models.Make_ID IN (#valuelist(Get_Makes.Make_ID)#)
							ORDER BY	X_Makes.Make_Name, X_Models.Model_Name
						</cfquery>
					</cfcase>
				</cfswitch>
			<cfelse>
				<cfquery datasource="#arguments.DSN#" name="Get_Models">
					SELECT		X_Makes.Make_Name,
								X_Models.Model_Name,
								'All' as Model_Code
					FROM		X_Models
					INNER JOIN	X_Makes
					ON			X_Models.Make_ID = X_Makes.Make_ID
					WHERE		X_Models.Make_ID IN (#valuelist(Get_Makes.Make_ID)#)
					ORDER BY	X_Makes.Make_Name, X_Models.Model_Name
				</cfquery>
				<cfset Get_Makes.Make_Name="All">
			</cfif>
			
		</cftransaction>
		
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
		
		<cfif Get_Models.Recordcount gt 0>

			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<cfloop query="Get_Models">
							<cftransaction>
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
												Mileage,
												New_Used,
												Engine_Size,
												Cylinders,
												Transmission,
												Exterior_Color,
												DriveTrain,
												Doors,
												Passengers,
												Days_In_Stock
									FROM		Staging_Inventory
									WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_SMALLINT" value="#variables.This_Dealer#" maxlength="4">
									AND			New_Used = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#variables.This_New_Used#" maxlength="1">
									<cfif variables.This_Year neq "0">
										AND			V_Year = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.This_Year#" maxlength="4">
									</cfif>
									<cfif Get_Makes.Make_Name neq "All">
										AND			V_Make_Alias = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Makes.Make_Name#" maxlength="50">
									<cfelse>
										AND			V_Make_Alias = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Models.Make_Name#" maxlength="50">
									</cfif>
									<cfif Get_Models.Model_Code neq "All">
										AND			V_Model_Number = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Models.Model_Code#" maxlength="50">
									<cfelse>
										AND			V_Model_Alias = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Models.Model_Name#" maxlength="50">
									</cfif>
									ORDER BY	V_Make_Alias, V_Model_Alias
								</cfquery>
							</cftransaction>
								
							<cfif Get_Inventory.Recordcount gt 0>

								<cfset variables.inventory_break=0>

								<cfloop query="Get_Inventory">

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
									<cfif Get_Inventory.MSRP neq "None">
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

									<div class="inv-row">
										<img class="inv-img" src="http://static.wdautos.com/images/inventory/default/coming_soon_200.jpg" />
										<div class="v-details">
											#Get_Inventory.V_Year# #Get_Inventory.V_Make_Alias# #Get_Inventory.V_Model_Alias# #Get_Inventory.V_Trim#<br />
											<div class="v-specs">
												Engine: #Get_Inventory.Engine_Size# #Get_Inventory.Cylinders# cyl<br />
												Transmission: #Get_Inventory.Transmission#<br />
												Exterior Color: #Get_Inventory.Exterior_Color#<br />
												Stock: #Get_Inventory.Stock#<br />
												Model Code: #Get_Inventory.V_Model_Number#<br />
											</div>
											<div class="v-specs">
												Drivetrain: #Get_Inventory.DriveTrain#<br />
												Style: #Get_Inventory.Doors#dr #Get_Inventory.V_Vehicle_Type#<cfif len((trim(Get_Inventory.Passengers)))> #Get_Inventory.Passengers# Psgr</cfif> V#Get_Inventory.Cylinders# #Get_Inventory.DriveTrain# #Get_Inventory.V_Trim#<br />
												Type: #Get_Inventory.V_Vehicle_Type#<br />
												<cfif New_Used neq "N">Mileage: #numberformat(Get_Inventory.Mileage)#<br /></cfif>
											</div>
											<span class="clear"></span>
										</div>
										<div class="v-prices">
											<cfif Get_Inventory.MSRP neq "None" and Get_Inventory.MSRP neq variables.This_Selling_Price><span class="price-lab">#variables.This_MSRP_Price_Name#:</span><span class="price-data">$#numberformat(Get_Inventory.MSRP)#</span><br class="clear" /></cfif>
											<cfif Get_Inventory.Tertiary neq "None"><span class="price-lab">#variables.This_Tertiary_Price_Name#:</span><span class="price-data">$#numberformat(Get_Inventory.Tertiary)#</span><br class="clear" /></cfif>
											<cfif variables.Adjusted_Baseline neq variables.This_Selling_Price><span class="price-lab">#variables.This_Baseline_Price_Name#:</span><span class="price-data">$#numberformat(variables.Adjusted_Baseline)#</span><br class="clear" /></cfif>
											<cfif variables.This_Rebate neq 0><span class="price-lab">#variables.This_Rebate_Name#:</span><span class="price-data">-$#numberformat(variables.This_Rebate)#</span><br class="clear" /></cfif>
											<cfif variables.This_Incentive neq 0><span class="price-lab">#variables.This_Incentive_Name#:</span><span class="price-data">-$#numberformat(variables.This_Incentive)#</span><br class="clear" /></cfif>
											<cfif len(trim(variables.This_Savings_Name)) gt 0 and variables.This_Incentive+variables.This_Rebate+variables.Price_Difference gt 0><span class="price-lab">#variables.This_Savings_Name#:</span><span class="price-data">$#numberformat(variables.This_Incentive+variables.This_Rebate+variables.Price_Difference)#</span><br class="clear" /><div class="divider clear"></div></cfif>
											<span class="sell-lab">#variables.This_Selling_Name#:</span><span class="sell-data">$#numberformat(variables.This_Selling_Price)#</span><br class="clear" />
										</div>
										<span class="clear"></span>
									</div>
									<div class="div-chide">
										Deductions (not visible on live display):
										<table cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td class="table-title-sm" align="center">Baseline Price</td>
												<td class="table-title-sm" align="center">Price Adjustment</td>
												<td class="table-title-sm" align="center">#variables.This_Rebate_Name#</td>
												<td class="table-title-sm" align="center">#variables.This_Incentive_Name#</td>
												<td class="table-title-sm" align="center">Mileage Deduction</td>
												<td class="table-title-sm" align="center">Age Deduction</td>
												<td class="table-title-sm" align="center">Freight Deduction</td>
												<td class="table-title-sm" align="center">Selling Price</td>
											</tr>
											<tr>
												<td class="table-data" align="center">$#Get_Inventory.Baseline#</td>
												<td class="table-data" align="center">
													<cfif variables.This_Adj_Scale eq 1>-$#variables.Price_Adjustment#</cfif>
													<cfif variables.This_Adj_Scale eq 0>+$#variables.Price_Adjustment#</cfif>
												</td>
												<td class="table-data" align="center">-$#variables.This_Rebate#</td>
												<td class="table-data" align="center">-$#variables.This_Incentive#</td>
												<td class="table-data" align="center">-$#variables.Mileage_Adjustment#</td>
												<td class="table-data" align="center"> -$#variables.Age_Adjustment#</td>
												<td class="table-data" align="center">-$#variables.Freight_Adjustment#</td>
												<td class="table-data" align="center">$#variables.This_Selling_Price#</td>												
											</tr>
										</table>
									</div>
								</cfloop>
								<cfset variables.inventory_break=variables.inventory_break+1>
								<cfif variables.inventory_break eq 10><cfbreak></cfif>
							</cfif>

						</cfloop>
					</td>
				</tr>
			</table>
						
		</cfif>
	
	</cffunction>
	
</cfcomponent>