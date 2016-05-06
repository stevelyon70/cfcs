<cfcomponent>
	
	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/trade_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Contact Information</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Tell Us About Your Trade</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Trade_Vin">Vin</label>
					<div class="col-md-6">
						<input name="Trade_Vin" class="form-control input-md" id="Trade_Vin" type="text" maxlength="50" placeholder="Vin">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Trade_Year"><span class="txt-red">*</span> Year</label>
					<div class="col-md-6">
						<input name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" placeholder="Year" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Trade_Make"><span class="txt-red">*</span> Make</label>
					<div class="col-md-6">
						<input name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" placeholder="Make" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Trade_Model"><span class="txt-red">*</span> Model</label>
					<div class="col-md-6">
						<input name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" placeholder="Model" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Trade_Odometer"><span class="txt-red">*</span> Miles</label>
					<div class="col-md-6">
						<input name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" placeholder="Miles/Odometer" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Additional Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-9 form-divider" align="center">
						<b>Vehicle of Interest</b>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_New_Used">Condition</label>
					<div class="col-md-6">
						<select class="form-control input-md" name="Voi_New_Used" id="Voi_New_Used">
							<option value="N" selected="selected">New</option>
							<option value="U">Pre-Owned</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Make">Make</label>
					<div class="col-md-6">
						<select  class="form-control input-md" name="Voi_Make" id="Voi_Make">
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Model">Model</label>
					<div class="col-md-6">
						<select  class="form-control input-md" name="Voi_Model" id="Voi_Model">
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Year">Year</label>
					<div class="col-md-6">
						<select  class="form-control input-md" name="Voi_Year" id="Voi_Year">
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Voi_Stock">Stock ##</label>
					<div class="col-md-6">
						<input name="Voi_Stock" class="form-control input-md" id="Voi_Stock" type="text" maxlength="50" placeholder="Stock ##">
					</div>
				</div>
				<cfif Get_Form_Locations.Recordcount gt 0>
					<div class="form-group">
						<label class="control-label col-md-3" for="Delivery_Dealer_ID">Preferred Dealership</label>
						<div class="col-md-6">
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
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Value My Trade">
					</div>
				</div>
			</fieldset>
		</form>

		<script>
			$(function() {
				var $new_used = $('##Voi_New_Used')
				var $make = $('##Voi_Make')
				var $model = $('##Voi_Model')
				var $year = $('##Voi_Year')
				$make.load('http://#cgi.server_name#/global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#&noFilter=1');
				$model.load('http://#cgi.server_name#/global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#&noFilter=1');
				$year.load('http://#cgi.server_name#/global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#&noFilter=1');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('http://#cgi.server_name#/global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#&noFilter=1');
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#&noFilter=1');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('http://#cgi.server_name#/global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#&noFilter=1');
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#&noFilter=1');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#&noFilter=1');
				});
			});
		</script>

	</cffunction>
	
	<cffunction name="tap_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-small">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/trade_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<div class="col-md-12" align="center">
					<span style="font-size:16pt;color:##000000;font-weight:bold">Enter Your PIN</span>
					</div>
					<div class="col-md-12" align="center">
						<input name="user_pin"  id="user_pin" type="text" size="50"  maxlength="50" placeholder="" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12 form-divider" align="left">
						<b>Tell Us About Your Trade-In:</b>
					</div>
				</div>
				
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Year"><span class="txt-red">*</span> Year</label> --->
					<div class="col-md-8" align="left">
						<input name="Trade_Year"    id="Trade_Year" type="text" size="40"  maxlength="4" placeholder="Year" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Make"><span class="txt-red">*</span> Make</label> --->
					<div class="col-md-8" align="left">
						<input name="Trade_Make"   id="Trade_Make" type="text" size="40"  maxlength="50" placeholder="Make" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Model"><span class="txt-red">*</span> Model</label> --->
					<div class="col-md-8" align="left">
						<input name="Trade_Model"   id="Trade_Model" type="text" size="40"  maxlength="50" placeholder="Model" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Odometer"><span class="txt-red">*</span> Miles</label> --->
					<div class="col-md-8" align="left">
						<input name="Trade_Odometer"  id="Trade_Odometer" type="text" size="40"  maxlength="10" placeholder="Miles/Odometer" required>
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="col-md-12 form-divider" align="left">
						<b>Your Information</b>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="First_Name"><span class="txt-red">*</span> First Name</label> --->
					<div class="col-md-8" align="left">
						<input name="First_Name"  id="First_Name" type="text" size="40"  maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Last_Name"><span class="txt-red">*</span> Last Name</label> --->
					<div class="col-md-8" align="left">
						<input name="Last_Name"  id="Last_Name" type="text" size="40"  maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Email"><span class="txt-red">*</span> Email</label> --->
					<div class="col-md-8" align="left">
						<input name="Email"  id="Email" type="email" size="40"  maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Phone_1">Phone</label> --->
					<div class="col-md-8" align="left">
						<input name="Phone_1"   id="Phone_1" type="text" size="40"  maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					
					<div class="col-md-12" align="center">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="SUBMIT">
					</div>
				</div>
			</fieldset>
		</form>

		<script>
			$(function() {
				var $new_used = $('##Voi_New_Used')
				var $make = $('##Voi_Make')
				var $model = $('##Voi_Model')
				var $year = $('##Voi_Year')
				$make.load('http://#cgi.server_name#/global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('http://#cgi.server_name#/global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('http://#cgi.server_name#/global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('http://#cgi.server_name#/global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('http://#cgi.server_name#/global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('http://#cgi.server_name#/global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>

	</cffunction>
	
	<cffunction name="megaticket_default" description="display default CONTEST ENTRY form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_class" default="">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/megaticket_action.cfm">

			
			<cfquery datasource="Ultra10" name="Get_program_Details">
				SELECT	ID, dealer_id, contest_name, form_header, your_info_title, question_title, trade_title, thankyou_page_text, confirmation_email, confirmation_email_subject, 
                      	confirmation_email_text,confirmation_email_from, questions_on, tradein_form, lead_email, rules_regs, lead_email_subject, lead_email_type, lead_email_from, drawing_dt, 
					  	start_dt, expires_dt, created_ts, active, bcc_emails,
					  	image_page1, image_page2,image_email, entries_per_email 
				FROM    Contest_Control
				WHERE	Dealer_id = #url.dealer_ID#
			</cfquery>
			<cfset draw_dt = #dateformat(Get_program_Details.drawing_dt,"mm/dd/yyyy")# >
		<form id="tap_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#Get_program_Details.dealer_id#">
				<input type="hidden" id="contest_id" name="contest_id" value="#Get_program_Details.ID#">
				<input type="hidden" id="entries_per_email" name="entries_per_email" value="#Get_program_Details.entries_per_email#">
				
				<div class="form-group">
					<div class="col-md-12" style="color:##000000;font-size:12pt" align="center">
						<cfif #Get_program_Details.form_header# NEQ "" >
							#Get_program_Details.form_header#
						</cfif>
					</div>
				</div>
			 
		<cfif #Get_program_Details.questions_on# EQ 1 >
		
				<cfquery name="get_questions" datasource="Ultra10">
					SELECT  ID, dealer_id, contest_id, question, q_type, active, hierarchy
					FROM    Contest_Entry_Questions
					where	dealer_id = #url.dealer_id#
					AND		contest_id = #Get_program_Details.ID#
					AND		active = 1
					order by hierarchy ASC
				</cfquery>
		
				<cfif #get_questions.recordcount# NEQ 0 >
					<div class="form-group">
						<div class="col-md-12" style="background-color:##000000;color:##ffffff;font-size:16pt" align="left">
							<cfif #Get_program_Details.question_title# NEQ "" >
								<b>#Get_program_Details.question_title#</b>
							</cfif>
						</div>
					</div>
					<cfset qnbr = 0 >
					<cfloop query="get_questions">
						<cfset qnbr = #qnbr#+1 >
						<cfif #get_questions.q_type# EQ 1 >
							<div class="form-group">
								<div class="col-md-12" style="margin-bottom:5px" align="left">
									<span style="font-size:10pt">#get_questions.question#&nbsp;
									<input name="answer_#qnbr#"  class=""   id="answer_#qnbr#" type="radio" value="Yes"> Yes&nbsp;
									<input name="answer_#qnbr#"  class=""   id="answer_#qnbr#" type="radio" checked value="No"> No</span>
									<input type="hidden" name="q_type_#qnbr#" value="#get_questions.q_type#" >
									<input type="hidden" name="question_#qnbr#" value="#get_questions.question#" >
								</div>
							</div>
						</cfif>
						<cfif #get_questions.q_type# EQ 2 >
							<div class="form-group">
								<div class="col-md-12" style="margin-bottom:5px" align="left">
									<span style="font-size:10pt">#get_questions.question#&nbsp;
									<input name="answer_#qnbr#"  class=""   id="answer_#qnbr#" type="checkbox" value="Yes"> Yes&nbsp;</span>
									<input type="hidden" name="q_type_#qnbr#" value="#get_questions.q_type#" >
									<input type="hidden" name="question_#qnbr#" value="#get_questions.question#" >
								</div>
							</div>
						</cfif>
						<cfif #get_questions.q_type# EQ 0 >
							<div class="form-group">
								<div class="col-md-12" style="margin-bottom:5px" align="left">
									<input name="answer_#qnbr#"  class="#arguments.input_class#"  id="answer_#qnbr#" type="text" size="60"  maxlength="100" required placeholder="#get_questions.question#">
									<input type="hidden" name="q_type_#qnbr#" value="#get_questions.q_type#" >
									<input type="hidden" name="question_#qnbr#" value="#get_questions.question#" >
								</div>
							</div>
						</cfif>
						<cfif #get_questions.q_type# EQ 3 >
							<div class="form-group">
								<div class="col-md-12" style="margin-bottom:5px" align="left">
									<textarea name="answer_#qnbr#" class="#arguments.input_class#" id="answer_#qnbr#" placeholder="#get_questions.question# - Maximum 1,000 characters" cols="50" maxlength="1000"></textarea>
									<input type="hidden" name="q_type_#qnbr#" value="#get_questions.q_type#" >
									<input type="hidden" name="question_#qnbr#" value="#get_questions.question#" >
								</div>
							</div>
						</cfif>
					</cfloop>
				</cfif>
				<br> 
			</cfif>				
			<!--- Trade-In Form --->
			<cfif #Get_program_Details.tradein_form# eq 1 >
				<div class="form-group">
					<div class="col-md-12" style="background-color:##000000;color:##ffffff;font-size:16pt"  align="left">
						<cfif #Get_program_Details.trade_title# NEQ "" >
							<b>#Get_program_Details.trade_title#</b>
						</cfif>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Year"><span class="txt-red">*</span> Year</label> --->
					<div class="col-md-12" style="margin-bottom:5px" align="left">
						<input name="Trade_Year"    id="Trade_Year" type="text" size="40"  maxlength="4" placeholder="Year" >
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Make"><span class="txt-red">*</span> Make</label> --->
					<div class="col-md-12" style="margin-bottom:5px" align="left">
						<input name="Trade_Make"   id="Trade_Make" type="text" size="40"  maxlength="50" placeholder="Make" >
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Model"><span class="txt-red">*</span> Model</label> --->
					<div class="col-md-12" style="margin-bottom:5px" align="left">
						<input name="Trade_Model"   id="Trade_Model" type="text" size="40"  maxlength="50" placeholder="Model" >
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Trade_Odometer"><span class="txt-red">*</span> Miles</label> --->
					<div class="col-md-12" style="margin-bottom:5px" align="left">
						<input name="Trade_Odometer"  id="Trade_Odometer" type="text" size="40"  maxlength="10" placeholder="Miles/Odometer"  >
					</div>
				</div>
				<br> 
			</cfif>
			
			<!--- Your Information Form --->				
				<div class="form-group">
					<div class="col-md-12" style="background-color:##000000;color:##ffffff;font-size:16pt;margin-bottom:5px"  align="left">
						<cfif #Get_program_Details.your_info_title# NEQ "" >
							<b>#Get_program_Details.your_info_title#</b>
						</cfif>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12" align="left">
					<p class="help-block">Only One Entry Please. Multiple entries will be disqualified.</p>
					</div>
				</div>
				
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="First_Name"><span class="txt-red">*</span> First Name</label> --->
					<div class="col-md-12 pad-bottom-10" style="margin-bottom:5px" align="left">
						<input name="First_Name"  class="#arguments.input_class#" id="First_Name" type="text" size="50"  maxlength="50" placeholder="First Name *" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Last_Name"><span class="txt-red">*</span> Last Name</label> --->
					<div class="col-md-12 pad-bottom-10" style="margin-bottom:5px" align="left">
						<input name="Last_Name"  class="#arguments.input_class#" id="Last_Name" type="text" size="50"  maxlength="50" placeholder="Last Name *" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Email"><span class="txt-red">*</span> Email</label> --->
					<div class="col-md-12 pad-bottom-10" style="margin-bottom:5px" align="left">
						<input name="Email"  class="#arguments.input_class#" id="Email" type="email" size="50"  maxlength="100" placeholder="Email *" required>
					</div>
				</div>
				<div class="form-group">
					<!--- <label class="control-label col-md-4" for="Phone_1">Phone</label> --->
					<div class="col-md-12 pad-bottom-10" style="margin-bottom:10px" align="left">
						<input name="Phone_1"  class="#arguments.input_class#"  id="Phone_1" type="text" size="50"  maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					
					<div class="col-md-12" align="center">
						<cfif #dateformat(now(),"mm/dd/yyyy")# LT #draw_dt# >
							<input type="submit" class="btn btn-primary"  id="Submit" value="SUBMIT">
						</cfif>
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>


	<cffunction name="show_offer" description="display trade-in form for featured offer" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/trade_offer_action.cfm">
		<cfargument name="form_mode" default="standard">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfquery datasource="Ultra10" name="Get_Popup">
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
			<cfif #arguments.dealer_id# NEQ 35 >
				AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			</cfif>
			AND			Nav_Behaviour_ID = 2
			OR			Nav_Behaviour_ID = 9
			ORDER BY	Dealer_Popup_ID
		</cfquery>
	
		<cfif Get_Popup.Recordcount eq 1>
			<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
				<cfif len(trim(Get_Popup.Nav_Image)) gt 0>
					<div class="row">
						<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0"><cfelse><div class="col-md-2">&nbsp;</div></cfif>
						<div class="col-md-9" align="center">
							<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/popups/#Get_Popup.Nav_Image#"/>
						</div>
					</div>
				</cfif>
				<br/>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div align="center">
						<table style="width:600px;">
							<tr>
								<td style="width:250px;" valign="top">
									<div align="center"><b>CONTACT INFO</b></div>
									<input style="width:100%" name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'"><br/>
									<input style="width:100%" name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
									<input style="width:100%" name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" onkeypress="return isNumberKey(event)" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'"><br/>
									<div class="help-block">Numbers Only - no hyphens or parentheses</div>
									<input style="width:100%" name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
								</td>
								<td style="width:50px;">&nbsp;
									
								</td>
								<td style="width:250px;" valign="top">
									<div align="center"><b>TELL US ABOUT YOUR CURRENT VEHICLE</b></div>							
									<input style="width:100%" name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" value="Year" onfocus="if (this.value=='Year') this.value = ''" onblur="if (this.value=='') this.value = 'Year'"><br/>
									<input style="width:100%" name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" value="Make" onfocus="if (this.value=='Make') this.value = ''" onblur="if (this.value=='') this.value = 'Make'"><br/>
									<input style="width:100%" name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" value="Model" onfocus="if (this.value=='Model') this.value = ''" onblur="if (this.value=='') this.value = 'Model'"><br/>
									<input style="width:100%" name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" value="Miles" onfocus="if (this.value=='Miles') this.value = ''" onblur="if (this.value=='') this.value = 'Miles'"><br/>
									<cfif Get_Form_Locations.Recordcount gt 0>
										<select style="width:100%" name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
											<option value="">Select a Dealer</option>
											<cfloop query="Get_Form_Locations">
												<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
											</cfloop> 
										</select><br/>
									<cfelse>
										<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
									</cfif>
									<br/><input type="submit" class="btn btn-primary" id="Contact_Us" value="Register Now">
								</td>
							</tr>
						</table>
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-2">
							&nbsp;
						</div>
						<div class="col-md-4">
							<div class="row">
								<cfif arguments.form_mode eq "popup">
									<div style="color:###Get_Popup.Font_Color#;margin:5px;font-size:20px;font-weight:bold;" class="col-md-12" align="center">
										<b>CONTACT INFO</b>
									</div>
								<cfelse>
									<div class="col-md-12 form-divider" align="center">
										<b>CONTACT INFO</b>
									</div>
								</cfif>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
									<p class="help-block">Numbers Only - no hyphens or parentheses</p>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
								</div>
							</div>
						</div>
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
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Value My Trade">
								</div>
							</div>
						</div>
					</div>
				</cfif>
			</form>
			<br/>
			<cfif len(trim(Get_Popup.Disclaimer)) gt 0>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div class="row" align="center">
						#Get_Popup.Disclaimer#
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-2">&nbsp;</div>
						<div class="col-md-9" <cfif arguments.form_mode eq "popup">style="color:###Get_Popup.Font_Color#;margin:5px;font-size:12px;"</cfif>>
							#Get_Popup.Disclaimer#
						</div>
					</div>
				</cfif>
			</cfif>
		</cfif>

	</cffunction>


	<cffunction name="used_car_buy" description="display form for Used Car Buy" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/used_car_buy_action.cfm">
		<cfargument name="form_mode" default="standard">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfquery datasource="Ultra10" name="Get_Popup">
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
			AND			( Nav_Behaviour_ID = 6 OR Nav_Behaviour_ID = 8 )
			ORDER BY	Dealer_Popup_ID
		</cfquery>
	
		<cfif Get_Popup.Recordcount eq 1>
			<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
				<cfif len(trim(Get_Popup.Nav_Image)) gt 0>
					<div class="row">
						<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0"><cfelse><div class="col-md-2">&nbsp;</div></cfif>
						<div class="col-md-9" align="center">
							<img class="img-responsive" alt="We Buy Used Cars" src="http://dealers.wdautos.com/dealer/#url.assets#/images/popups/#Get_Popup.Nav_Image#"/>
						</div>
					</div>
				</cfif>
				<br/>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div align="center">
						<table style="width:600px;">
							<tr>
								<td style="width:250px;" valign="top">
									<div align="center"><b>CONTACT INFO</b></div>
									<input style="width:100%" name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'"><br/>
									<input style="width:100%" name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
									<input style="width:100%" name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" onkeypress="return isNumberKey(event)" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'"><br/>
									<div class="help-block">Numbers Only - no hyphens or parentheses</div>
									<input style="width:100%" name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
								</td>
								<td style="width:50px;">&nbsp;
									
								</td>
								<td style="width:250px;" valign="top">
									<div align="center"><b>TELL US ABOUT YOUR CURRENT VEHICLE</b></div>							
									<input style="width:100%" name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" value="Year" onfocus="if (this.value=='Year') this.value = ''" onblur="if (this.value=='') this.value = 'Year'"><br/>
									<input style="width:100%" name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" value="Make" onfocus="if (this.value=='Make') this.value = ''" onblur="if (this.value=='') this.value = 'Make'"><br/>
									<input style="width:100%" name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" value="Model" onfocus="if (this.value=='Model') this.value = ''" onblur="if (this.value=='') this.value = 'Model'"><br/>
									<input style="width:100%" name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" value="Miles" onfocus="if (this.value=='Miles') this.value = ''" onblur="if (this.value=='') this.value = 'Miles'"><br/>
									<cfif Get_Form_Locations.Recordcount gt 0>
										<select style="width:100%" name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
											<option value="">Select a Dealer</option>
											<cfloop query="Get_Form_Locations">
												<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
											</cfloop> 
										</select><br/>
									<cfelse>
										<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
									</cfif>
									<br/><input type="submit" class="btn btn-primary" id="Contact_Us" value="Contact Me">
								</td>
							</tr>
						</table>
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-<cfif arguments.dealer_id neq 83>2<cfelse>4</cfif>">
							&nbsp;
						</div>
						<div class="col-md-4">
							<div class="row">
								<cfif arguments.form_mode eq "popup">
									<div style="color:###Get_Popup.Font_Color#;margin:5px;font-size:20px;font-weight:bold;" class="col-md-12" align="center">
										<b>CONTACT INFO</b>
									</div>
								<cfelse>
									<div class="col-md-12 form-divider" align="center">
										<b>CONTACT INFO</b>
									</div>
								</cfif>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
									<p class="help-block">Numbers Only - no hyphens or parentheses</p>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
								</div>
							</div>
                            <cfif url.dealer_id eq 83>
                            <div class="form-group">
								<div class="col-md-12">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Submit & Get Coupon">
								</div>
							</div>
                            </cfif>
						</div>
                        <cfif arguments.dealer_id neq 83>
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
									<input name="Trade_Vin" class="form-control input-md" id="Trade_Vin" type="text" maxlength="50" placeholder="VIN" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" placeholder="Miles/Odometer" required>
								</div>
							</div>
							<cfif #arguments.dealer_id# NEQ 17 AND 
									#arguments.dealer_id# NEQ 18  AND 
										#arguments.dealer_id# NEQ 34  AND 
											#arguments.dealer_id# NEQ 33  AND 
												#arguments.dealer_id# NEQ 32  AND 
													#arguments.dealer_id# NEQ 35 >
							
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
							<cfelse>
							<!--- SPECIAL for Kelly We Buy Used Cars 09/17/2015 --->
									<div class="form-group">
										<div class="col-md-12">
											<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
												<option value="">Select a Dealer</option>
													<option value="339">Kelly Risk Free >>>Easton</option>
													<option value="340">Kelly Risk Free >>>Emmaus</option>
											</select>
										</div>
									</div>
									
							</cfif> 
							
							<div class="form-group">
								<div class="col-md-12">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Contact Me">
								</div>
							</div>
						</div>
                    </cfif>
					</div>
				</cfif>
			</form>
			<br/>
			<cfif len(trim(Get_Popup.Disclaimer)) gt 0>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div class="row" align="center">
						#Get_Popup.Disclaimer#
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-2">&nbsp;</div>
						<div class="col-md-9" <cfif arguments.form_mode eq "popup">style="color:###Get_Popup.Font_Color#;margin:5px;font-size:12px;"</cfif>>
							#Get_Popup.Disclaimer#
						</div>
					</div>
				</cfif>
			</cfif>
		</cfif>

	</cffunction>




	<cffunction name="show_offer_v1" description="display trade-in form for featured offer variation 1" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/trade_offer_action.cfm">
		<cfargument name="form_mode" default="standard">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfquery datasource="Ultra10" name="Get_Popup">
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
			<cfif #arguments.dealer_id# NEQ 35 >
				AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			</cfif>
			AND			Nav_Behaviour_ID = 2
			ORDER BY	Dealer_Popup_ID
		</cfquery>
	
		<cfif Get_Popup.Recordcount eq 1>
			<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
				<cfif len(trim(Get_Popup.Nav_Image)) gt 0>
					<div class="row">
						<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0"><cfelse><div class="col-md-2">&nbsp;</div></cfif>
						<div class="col-md-9" align="center">
							<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/popups/#Get_Popup.Nav_Image#"/>
						</div>
					</div>
				</cfif>
				<br/>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div align="center">
						<table style="width:600px;">
							<tr>
								<td style="width:250px;" valign="top">
									<div align="center"><b>CONTACT INFO</b></div>
									<input style="width:100%" name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'"><br/>
									<input style="width:100%" name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
									<input style="width:100%" name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" onkeypress="return isNumberKey(event)" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'"><br/>
									<div class="help-block">Numbers Only - no hyphens or parentheses</div>
									<input style="width:100%" name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
								</td>
								<td style="width:50px;">&nbsp;
									
								</td>
								<td style="width:250px;" valign="top">
									<div align="center"><b>TELL US ABOUT YOUR CURRENT VEHICLE</b></div>							
									<input style="width:100%" name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" value="Year" onfocus="if (this.value=='Year') this.value = ''" onblur="if (this.value=='') this.value = 'Year'"><br/>
									<input style="width:100%" name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" value="Make" onfocus="if (this.value=='Make') this.value = ''" onblur="if (this.value=='') this.value = 'Make'"><br/>
									<input style="width:100%" name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" value="Model" onfocus="if (this.value=='Model') this.value = ''" onblur="if (this.value=='') this.value = 'Model'"><br/>
									<input style="width:100%" name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" value="Miles" onfocus="if (this.value=='Miles') this.value = ''" onblur="if (this.value=='') this.value = 'Miles'"><br/>
									<cfif Get_Form_Locations.Recordcount gt 0>
										<select style="width:100%" name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
											<option value="">Select a Dealer</option>
											<cfloop query="Get_Form_Locations">
												<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
											</cfloop> 
										</select><br/>
									<cfelse>
										<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
									</cfif>
									<br/><input type="submit" class="btn btn-primary" id="Contact_Us" value="Register Now">
								</td>
							</tr>
						</table>
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-4">
							&nbsp;
						</div>
						<div class="col-md-4">
							<div class="row">
								<cfif arguments.form_mode eq "popup">
									<div style="color:###Get_Popup.Font_Color#;margin:5px;font-size:20px;font-weight:bold;" class="col-md-12" align="center">
										<b>CONTACT INFO</b>
									</div>
								<cfelse>
									<div class="col-md-12 form-divider" align="center">
										<b>CONTACT INFO</b>
									</div>
								</cfif>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
									<p class="help-block">Numbers Only - no hyphens or parentheses</p>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
									<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
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
				</cfif>
			</form>
			<br/>
			<cfif len(trim(Get_Popup.Disclaimer)) gt 0>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div class="row" align="center">
						#Get_Popup.Disclaimer#
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-2">&nbsp;</div>
						<div class="col-md-9" <cfif arguments.form_mode eq "popup">style="color:###Get_Popup.Font_Color#;margin:5px;font-size:12px;"</cfif>>
							#Get_Popup.Disclaimer#
						</div>
					</div>
				</cfif>
			</cfif>
		</cfif>

	</cffunction>

	<cffunction name="show_contact" description="display Contact Us form for featured offer" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/pop_contact_action2.cfm">
		<cfargument name="form_mode" default="standard">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfquery datasource="Ultra10" name="Get_Popup">
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
			AND			Nav_Behaviour_ID = 3
			ORDER BY	Dealer_Popup_ID
		</cfquery>
	
		<cfif Get_Popup.Recordcount eq 1>
			<form id="test_drive" class="form-horizontal" action="#arguments.form_action#" method="post">
				<cfif len(trim(Get_Popup.Nav_Image)) gt 0>
					<div class="row">
						<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0"><cfelse><div class="col-md-2">&nbsp;</div></cfif>
						<div class="col-md-9" align="center">
							<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/popups/#Get_Popup.Nav_Image#"/>
						</div>
					</div>
				</cfif>
				<br/>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div align="center">
						<table style="width:600px;">
							<tr>
								<td style="width:250px;" valign="top">
									<div align="center"><b>CONTACT INFO</b></div>
									<input style="width:100%" name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'"><br/>
									<input style="width:100%" name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
									<input style="width:100%" name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" onkeypress="return isNumberKey(event)" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'"><br/>
									<div class="help-block">Numbers Only - no hyphens or parentheses</div>
									<input style="width:100%" name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
								</td>
								<td style="width:50px;">&nbsp;
									
								</td>
								<td style="width:250px;" valign="top">
									<!--- <div align="center"><b>TELL US ABOUT YOUR CURRENT VEHICLE</b></div>							
									<input style="width:100%" name="Trade_Year" class="form-control input-md" id="Trade_Year" type="text" maxlength="4" value="Year" onfocus="if (this.value=='Year') this.value = ''" onblur="if (this.value=='') this.value = 'Year'"><br/>
									<input style="width:100%" name="Trade_Make" class="form-control input-md" id="Trade_Make" type="text" maxlength="50" value="Make" onfocus="if (this.value=='Make') this.value = ''" onblur="if (this.value=='') this.value = 'Make'"><br/>
									<input style="width:100%" name="Trade_Model" class="form-control input-md" id="Trade_Model" type="text" maxlength="50" value="Model" onfocus="if (this.value=='Model') this.value = ''" onblur="if (this.value=='') this.value = 'Model'"><br/>
									<input style="width:100%" name="Trade_Odometer" class="form-control input-md" id="Trade_Odometer" type="text" maxlength="10" value="Miles" onfocus="if (this.value=='Miles') this.value = ''" onblur="if (this.value=='') this.value = 'Miles'"><br/>
									<cfif Get_Form_Locations.Recordcount gt 0>
										<select style="width:100%" name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
											<option value="">Select a Dealer</option>
											<cfloop query="Get_Form_Locations">
												<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
											</cfloop> 
										</select><br/>
									<cfelse> --->
										<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
									<!--- </cfif>
									<br/><input type="submit" class="btn btn-primary" id="Contact_Us" value="Submit"> --->
								</td>
							</tr>
						</table>
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-4">
							&nbsp;
						</div>
						<div class="col-md-4">
							<div class="row">
								<cfif arguments.form_mode eq "popup">
									<div style="color:###Get_Popup.Font_Color#;margin:5px;font-size:20px;font-weight:bold;" class="col-md-12" align="center">
										<b>CONTACT INFO</b>
									</div>
								<cfelse>
									<div class="col-md-12 form-divider" align="center">
										<b>CONTACT INFO</b>
									</div>
								</cfif>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
									<p class="help-block">Numbers Only - no hyphens or parentheses</p>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
								</div>
							</div>
                            <div class="form-group">
								<div class="col-md-12">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Submit & Get Coupon">
								</div>
							</div>
						</div>
						<div class="col-md-1">
							&nbsp;
						</div>
						<div class="col-md-4">
							<!--- <div class="row">
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
							<cfelse> --->
								<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
							<!--- </cfif> --->
							<!---<div class="form-group">
								<div class="col-md-12">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Submit">
								</div>
							</div>--->
						</div>
					</div>
				</cfif>
			</form>
			<br/>
			<cfif len(trim(Get_Popup.Disclaimer)) gt 0>
				<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
					<div class="row" align="center">
						#Get_Popup.Disclaimer#
					</div>
				<cfelse>
					<div class="row">
						<div class="col-md-2">&nbsp;</div>
						<div class="col-md-9" <cfif arguments.form_mode eq "popup">style="color:###Get_Popup.Font_Color#;margin:5px;font-size:12px;"</cfif>>
							#Get_Popup.Disclaimer#
						</div>
					</div>
				</cfif>
			</cfif>
		</cfif>

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

			<cfparam name="variables.Email_Subject" default="Trade-In Valuation from #lcase(cgi.Server_Name)#">
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
	
<cffunction name="form_submit_pop" description="action page for form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Ultra10">
		
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

		<!--- Trade Year: form.trade_make --->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
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
 --->
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
<!--- 
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
			</cfif> --->

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

			<!--- <cfinvoke component="/cfcs/emails/text_gen" method="trade_text" returnvariable="text_email">
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
			</cfif> --->

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
<!--- 
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
			</cfif> --->

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

			<cfparam name="variables.Email_Subject" default="Special Offer Submission from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdpittsburgh@hotmail.com,wdsupport@worlddealer.net,slyon@worlddealer.net">

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

	
<cffunction name="form_submit_megaticket" description="action page for CONTEST ENTRY form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Ultra10">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.Trade_Year" default="">
		<cfparam name="form.Trade_Make" default="">
		<cfparam name="form.Trade_Model" default="">
		<cfparam name="form.Trade_Odometer" default="">

		<cfloop index="x" from="1" to="10" >
			<cfparam name="form.answer_#x#" default="">
			<cfparam name="form.q_type_#x#" default="">
			<cfparam name="form.question_#x#" default="">
		</cfloop>
		
		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<!--- <cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke> --->

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
			
			<!--- Check for multiple entries --->
			<cfquery name="get_leads" datasource="Ultra10">
				SELECT	ID, dealer_id, contest_id, first_name, last_name, email, phone, question1, question2, question3, question4, question5, question6, question7, question8, 
			            question9, question10, trade_year, trade_make, trade_model, trade_miles, submitted_ts
				FROM    Contest_Entries
				WHERE	contest_id = #form.contest_id#
				AND		(email = '#form.email#' OR phone = '#form.phone_1#' )
			</cfquery>
	
			<cfif #get_leads.recordcount# GTE #form.entries_per_email# >
				<cfset variables.error_message="Yes">
				<cfset url.entry_id="#get_leads.ID#">
			</cfif>
		<cfif listlen(variables.error_message) gt 0>
	
			<cfset url.error_message=variables.error_message>

		<cfelse>
		
			<cfquery datasource="ultra10" name="Insert_LEAD">
				INSERT INTO	contest_entries
							( 	contest_id, 
								dealer_id, 
								first_name, 
								last_name, 
								email, 
								phone, 
								trade_year,
								trade_make,
								trade_model,
								trade_miles,
								question1, question2, question3, question4, question5, question6, question7, question8,question9, question10 )
					VALUES
							(<cfqueryparam value="#form.contest_id#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
							<cfqueryparam value="#form.Dealer_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
							<cfqueryparam value="#UCase(form.first_name)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#UCase(form.last_name)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
							<cfqueryparam value="#form.phone_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="40">,
							<cfqueryparam value="#form.Trade_Year#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
							<cfqueryparam value="#form.Trade_Make#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.Trade_Model#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.Trade_Odometer#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
							<cfqueryparam value="#form.answer_1#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_2#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_3#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_4#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_5#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_6#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_7#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_8#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_9#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
							<cfqueryparam value="#form.answer_10#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> )
		 	</cfquery>

			<cfquery datasource="Ultra10" name="qryLast_id">SELECT A.ID FROM	contest_entries A ORDER BY A.ID DESC</cfquery>
			<cfset Last_ID = #qryLast_id.ID#>
			
			<cfquery datasource="Ultra10" name="Get_program_Details">
				SELECT	ID, dealer_id, contest_name, form_header, your_info_title, question_title, trade_title, thankyou_page_text, confirmation_email, confirmation_email_subject, 
                      	confirmation_email_text,confirmation_email_from, questions_on, tradein_form, lead_email, rules_regs, lead_email_subject, lead_email_type, lead_email_from, drawing_dt, 
					  	start_dt, expires_dt, created_ts, active, bcc_emails,
					  	image_page1, image_page2,image_email 
				from	Contest_Control		
				WHERE		Dealer_id = #form.dealer_ID#
				AND			ID = #form.contest_id#
			</cfquery>
		
			<cfset url.entry_id = #Last_ID# >
			
			<cfset variables.recipient_list=valuelist(Get_program_Details.lead_email)>

			
			<cfset drw_dt = #dateformat(Get_program_Details.drawing_dt,"mm/dd/yyyy")# >
			<cfset Get_program_Details.confirmation_email_text=replace(Get_program_Details.confirmation_email_text,"$CUST1$","#UCase(form.first_name)#","All")>
			<cfset Get_program_Details.confirmation_email_text=replace(Get_program_Details.confirmation_email_text,"$CUST2$","#UCase(form.last_name)#","All")>
			<cfset Get_program_Details.confirmation_email_text=replace(Get_program_Details.confirmation_email_text,"$CEMAIL$","#form.email#","All")>
			<cfset Get_program_Details.confirmation_email_text=replace(Get_program_Details.confirmation_email_text,"$WHERE$","#Get_program_Details.contest_name#","All")>
			<cfset Get_program_Details.confirmation_email_text=replace(Get_program_Details.confirmation_email_text,"$WHEN$","#drw_dt#","All")>
			<cfset Get_program_Details.confirmation_email_text=replace(Get_program_Details.confirmation_email_text,"$SERVER$","#lcase(cgi.Server_Name)#","All")>
			
			<!--- Lead Subject --->
			<cfif Get_program_Details.lead_email_subject NEQ "" >
				<cfset Get_program_Details.lead_email_subject=replace(Get_program_Details.lead_email_subject,"$CUST1$","#UCase(form.first_name)#","All")>
				<cfset Get_program_Details.lead_email_subject=replace(Get_program_Details.lead_email_subject,"$CUST2$","#UCase(form.last_name)#","All")>
				<cfset Get_program_Details.lead_email_subject=replace(Get_program_Details.lead_email_subject,"$CEMAIL$","#form.email#","All")>
				<cfset Get_program_Details.lead_email_subject=replace(Get_program_Details.lead_email_subject,"$WHERE$","#Get_program_Details.contest_name#","All")>
				<cfset Get_program_Details.lead_email_subject=replace(Get_program_Details.lead_email_subject,"$SERVER$","#lcase(cgi.Server_Name)#","All")>
			</cfif>
			<!--- Confirmation Subject --->
			<cfif Get_program_Details.confirmation_email_subject NEQ "" >
				<cfset Get_program_Details.confirmation_email_subject=replace(Get_program_Details.confirmation_email_subject,"$CUST1$","#UCase(form.first_name)#","All")>
				<cfset Get_program_Details.confirmation_email_subject=replace(Get_program_Details.confirmation_email_subject,"$CUST2$","#UCase(form.last_name)#","All")>
				<cfset Get_program_Details.confirmation_email_subject=replace(Get_program_Details.confirmation_email_subject,"$CEMAIL$","#form.email#","All")>
				<cfset Get_program_Details.confirmation_email_subject=replace(Get_program_Details.confirmation_email_subject,"$WHERE$","#Get_program_Details.contest_name#","All")>
				<cfset Get_program_Details.confirmation_email_subject=replace(Get_program_Details.confirmation_email_subject,"$SERVER$","#lcase(cgi.Server_Name)#","All")>
			</cfif>
			
			
			<!---Generate Text Emails--->

			<cfparam name="variables.Lead_Email_Subject" default="#Get_program_Details.lead_email_subject#">
			<cfparam name="variables.Email_Subject" default="#Get_program_Details.confirmation_email_subject#">
			<cfparam name="variables.From_Email_lead" default="#Get_program_Details.lead_email_from#">
			<cfparam name="variables.From_Email" default="#Get_program_Details.confirmation_email_from#">
			<!--- <cfparam name="variables.WD_BCC" default="dan@worlddealer.net,bob@pinto302.com">  --->
			<cfparam name="variables.WD_BCC" default="#Get_program_Details.bcc_emails#"> 

			<!---Send Text Emails--->
			<cfmail to="#variables.recipient_list#" from="#variables.From_Email_lead#" type="HTML" subject="#variables.Lead_Email_Subject#" bcc="#variables.WD_BCC#">
					
				<table cellpadding="0" width="70%" cellspacing="0">
					<tr>
						<td align="left" > 
							Name: #UCase(form.First_Name)# #UCase(form.Last_Name)#<br>
							Phone: #form.Phone_1#<br>
							Email: #form.Email#<br><br>
								<cfif #form.Trade_Year# NEQ "" or #form.Trade_Make# NEQ ""  or #form.Trade_Model# NEQ ""  or #form.Trade_Odometer# NEQ "" >
									Trade-In: #form.Trade_Year# #form.Trade_Make# #form.Trade_Model# <br>
									Odometer: #form.Trade_Odometer#
									<br><br> 
								</cfif>
								<cfif #form.question_1# NEQ "" >
									#form.question_1# : 
									<cfif #form.answer_1# NEQ "" >
										<b>#form.answer_1#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_2# NEQ "" >
									#form.question_2# :  
									<cfif #form.answer_2# NEQ "" >
										<b>#form.answer_2#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_3# NEQ "" >
									#form.question_3# : 
									<cfif #form.answer_3# NEQ "" >
										<b>#form.answer_3#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_4# NEQ "" >
									#form.question_4# : 
									<cfif #form.answer_4# NEQ "" >
										<b>#form.answer_4#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_5# NEQ "" >
									#form.question_5# :  
									<cfif #form.answer_5# NEQ "" >
										<b>#form.answer_5#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_6# NEQ "" >
									#form.question_6# :   
									<cfif #form.answer_6# NEQ "" >
										<b>#form.answer_6#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_7# NEQ "" >
									#form.question_7# :    
									<cfif #form.answer_7# NEQ "" >
										<b>#form.answer_7#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_8# NEQ "" >
									#form.question_8# :    
									<cfif #form.answer_8# NEQ "" >
										<b>#form.answer_8#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_9# NEQ "" >
									#form.question_9# :     
									<cfif #form.answer_9# NEQ "" >
										<b>#form.answer_9#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
								<cfif #form.question_10# NEQ "" >
									#form.question_10# :      
									<cfif #form.answer_10# NEQ "" >
										<b>#form.answer_10#</b><br>
									<cfelse>	
										<b>NO RESPONSE</b><br>
									</cfif>	
								</cfif>
						 </td>
					</tr>
					<tr><td>&nbsp;</td></tr>
				</table>  
			</cfmail>
			
			<!---Send Entrant Text Emails--->
			<cfif #Get_program_Details.confirmation_email# EQ 1 > 
				<cfmail to="#form.Email#" from="#variables.From_Email#" type="HTML" subject="#variables.Email_Subject#" >
						
					<table cellpadding="0" width="80%" align="left" cellspacing="0">
						<tr>
							<td align="left" > 
								#rtrim(Get_program_Details.confirmation_email_text)#
							 </td>
						</tr>
						<tr>
							<td align="left" > 
								 <img src="http://dealers.wdautos.com/dealer/baierlmegaticket/images/icons/#Get_program_Details.image_email#" alt="#Get_program_Details.contest_name#"  class="img-responsive" border="0">
							 </td>
						</tr>
						<tr><td>&nbsp;</td></tr>
					</table>  
				</cfmail>
			</cfif>
			
		</cfif>

	</cffunction>
	
	
	
	
	
</cfcomponent>