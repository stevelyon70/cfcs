<cfcomponent>
	
	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_legend" default="Contact Us">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/job_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<!--- Stops the BOTS from throwing an error! Returns to splash page --->
		<cfif NOT IsDefined("url.opp")><cflocation url="http://#cgi.server_name#"></cfif>
		
		<cfquery name="get_opp_detl" datasource="ultra10">
			SELECT  ID, Dealer_ID, Emp_Title, Department, Emp_Location,Emp_Location_ID, Position_Type, Emp_Compensation, Emp_Short_Description,Emp_Description, 
					Emp_Posted, Emp_Expires, Emp_Requirements, Contact_Name, Contact_Title, Contact_Phone, Contact_Email, Active
			FROM    Employment
			WHERE	ID = #url.opp#
		</cfquery>
		
		<cfquery name="dept_list" datasource="Ultra10">
			SELECT  Dept_ID, Department, active
			FROM    Departments
			WHERE	active	=	1
		</cfquery>
		
		<form class="form-horizontal" action="#arguments.form_action#" method="post" enctype="multipart/form-data">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span>First Name</label>
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
					<label class="control-label col-md-3" for="Phone_1"><span class="txt-red">*</span> Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" required>
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
					<label class="control-label col-md-3" for="Address_1">Address</label>
					<div class="col-md-6">
						<input name="Address_1" class="form-control input-md" id="Address_1" type="text" maxlength="100" placeholder="Address">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Address_2">Address Line 2</label>
					<div class="col-md-6">
						<input name="Address_2" class="form-control input-md" id="Address_2" type="text" maxlength="100" placeholder="Address Line 2">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="City"><span class="txt-red">*</span> City</label>
					<div class="col-md-6">
						<input name="City" class="form-control input-md" id="City" type="text" maxlength="50" placeholder="City" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="State"><span class="txt-red">*</span> State</label>
					<div class="col-md-6">
						<cfinvoke component="/cfcs/forms/form_states" method="standard">
							<cfinvokeargument name="state" value="#url.state#"/>
							<cfinvokeargument name="input_class" value="form-control input-md"/>
						</cfinvoke>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Zip"><span class="txt-red">*</span> Zip</label>
					<div class="col-md-6">
						<input name="Zip" class="form-control input-md" id="Zip" type="text" maxlength="5" placeholder="Zip" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Zip"> Position</label>
					<div class="col-md-6">
						<input name="Emp_Title" class="form-control input-md" id="Emp_Title" type="text" value="#get_opp_detl.Emp_Title#" maxlength="50" placeholder="Position" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Dept"><span class="txt-red">*</span> Department</label>
					<div class="col-md-6">
						<select class="form-control input-md" name="Dept" id="Dept" required >
							<option value="" >Select a Department</option>
								<cfloop query="dept_list">
									<option value="#dept_list.Department#" <cfif #get_opp_detl.Department# EQ "#dept_list.Department#" >selected</cfif> >#dept_list.Department#</option>
								</cfloop>
						</select>
						<!--- <select class="form-control input-md" name="Dept" id="Dept" required>
							<option value="Accounting" <cfif #get_opp_detl.Emp_Title# EQ "Accounting">selected</cfif> >Accounting</option>
							<option value="Automotive Sales" <cfif #get_opp_detl.Emp_Title# EQ "Automotive Sales">selected</cfif> >Automotive Sales</option>
							<option value="Body Shop" <cfif #get_opp_detl.Emp_Title# EQ "Body Shop">selected</cfif> >Body Shop</option>
							<option value="Cashier" <cfif #get_opp_detl.Emp_Title# EQ "Cashier">selected</cfif> >Cashier</option>
							<option value="Commercial Truck Sales" <cfif #get_opp_detl.Emp_Title# EQ "Commercial Truck Sales">selected</cfif> >Commercial Truck Sales</option>
							<option value="Detailer" <cfif #get_opp_detl.Emp_Title# EQ "Detailer">selected</cfif> >Detailer</option>
							<option value="Finance" <cfif #get_opp_detl.Emp_Title# EQ "Finance">selected</cfif> >Finance</option>
							<option value="Insurance" <cfif #get_opp_detl.Emp_Title# EQ "Insurance">selected</cfif> >Insurance</option>
							<option value="Internet Sales" <cfif #get_opp_detl.Emp_Title# EQ "Internet Sales">selected</cfif> >Internet Sales</option>
							<option value="Lot Attendant" <cfif #get_opp_detl.Emp_Title# EQ "Lot Attendant">selected</cfif> >Lot Attendant</option>
							<option value="Management" <cfif #get_opp_detl.Emp_Title# EQ "Management">selected</cfif> >Management</option>
							<option value="Mechanic" <cfif #get_opp_detl.Emp_Title# EQ "Mechanic">selected</cfif> >Mechanic</option>
							<option value="New Car Preparation" <cfif #get_opp_detl.Emp_Title# EQ "New Car Preparation">selected</cfif> >New Car Preparation</option>
							<option value="Parts Counter" <cfif #get_opp_detl.Emp_Title# EQ "Parts Counter">selected</cfif> >Parts Counter</option>
							<option value="Parts Driver" <cfif #get_opp_detl.Emp_Title# EQ "Parts Driver">selected</cfif> >Parts Driver</option>
							<option value="Service Center" <cfif #get_opp_detl.Emp_Title# EQ "Service Center">selected</cfif> >Service Center</option>
							<option value="Service Writer" <cfif #get_opp_detl.Emp_Title# EQ "Service Writer">selected</cfif> >Service Writer</option>
							<option value="Technicians" <cfif #get_opp_detl.Emp_Title# EQ "Technicians">selected</cfif> >Technicians</option>
							<option value="Telephone Switchboard" <cfif #get_opp_detl.Emp_Title# EQ "Telephone Switchboard">selected</cfif> >Telephone Switchboard</option>
							<option value="Other" <cfif #get_opp_detl.Emp_Title# EQ "Other">selected</cfif> >Other</option>
						</select> --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Job_Type"><span class="txt-red">*</span> Position Type</label>
					<div class="col-md-6">
						<select class="form-control input-md" name="Job_Type" id="Job_Type" required>
							<option value="Full-Time" <cfif #get_opp_detl.Position_Type# EQ "Full-Time">selected</cfif> >Full-Time</option>
							<option value="Part-Time" <cfif #get_opp_detl.Position_Type# EQ "Part-Time">selected</cfif> >Part-Time</option>
							<option value="Other" <cfif #get_opp_detl.Position_Type# EQ "Other">selected</cfif> >Other</option>
						</select>
					</div>
				</div>
				 <cfif Get_Form_Locations.Recordcount gt 0>  
					<div class="form-group">
						<label class="control-label col-md-3" for="Delivery_Dealer_ID"><span class="txt-red">*</span> Dealership</label>
						<div class="col-md-6">
							<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
								<option value="">Select a Dealer </option>
								<cfloop query="Get_Form_Locations">
									<option value="#Get_Form_Locations.Location_ID#" <cfif #Get_Form_Locations.Location_ID# EQ #get_opp_detl.Emp_Location_ID# >selected</cfif> >#Get_Form_Locations.Display_Name#</option>
								</cfloop> 
							</select>
						</div>
					</div>
				 <cfelse> 
					<div class="form-group">
						<label class="control-label col-md-3" for="Delivery_Dealer_ID"><span class="txt-red">*</span> Dealership</label>
						<div class="col-md-6">
					 <cfquery name="get_loc" datasource="Ultra10">SELECT  Dealer_ID, Display_Name FROM Dealers WHERE Dealer_ID =  #get_opp_detl.Emp_Location_ID#</cfquery> 
					<input type="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#get_loc.Display_Name#">
						</div>
					</div>
				</cfif> 
				<div class="form-group">
					<label class="control-label col-md-3" for="Resume_Available">Resume Available?</label>
					<div class="col-md-6">
						<label class="radio-inline" for="Fuel-0">
							<input name="Resume_Available" id="Resume_Available-0" type="radio" checked="checked" value="Yes">
							Yes
						</label> 
						<label class="radio-inline" for="Fuel-1">
							<input name="Resume_Available" id="Resume_Available-1" type="radio" value="No">
							No
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="References_Available">References Available?</label>
					<div class="col-md-6">
						<label class="radio-inline" for="Fuel-0">
							<input name="References_Available" id="References_Available-0" type="radio" checked="checked" value="Yes">
							Yes
						</label> 
						<label class="radio-inline" for="Fuel-1">
							<input name="References_Available" id="References_Available-1" type="radio" value="No">
							No
						</label>						
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Resume_File">Attach A Resume</label>
					<div class="col-md-6">
						<input name="Resume_File" id="Resume_File" type="file">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments"><span class="txt-red">*</span> Work History</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" col="100" rows="4" placeholder="Work History" maxlength="1000" required></textarea>
					</div>
				</div>
				<div class="form-group">
					<!--- <div class="col-md-3" align="left"><a href="../employment" style="font-size:10pt;font-weight:bold" >Return to Opportunities</a></div> --->
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6" align="right" >
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="SUBMIT APPLICATION">
						<br>
						<a href="../employment" style="font-size:10pt;font-weight:bold" >Return to Opportunities</a>
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
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.address_1" default="">
		<cfparam name="form.address_2" default="">
		<cfparam name="form.city" default="">
		<cfparam name="form.state" default="">
		<cfparam name="form.zip" default="">
		<cfparam name="form.dept" default="">
		<cfparam name="form.job_type" default="">
		<cfparam name="form.resume_available" default="yes">
		<cfparam name="form.references_available" default="yes">
		<cfparam name="form.comments" default="">
		<cfparam name="form.resume_file" default="">

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
		<!--- Address 1: form.address_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Address"/>
			<cfinvokeargument name="text_value" value="#form.address_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="false"/>
		</cfinvoke>
		<!--- Address 2: form.address_2 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Address Line 2"/>
			<cfinvokeargument name="text_value" value="#form.address_2#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="false"/>
		</cfinvoke>
		<!--- City: form.city --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="City"/>
			<cfinvokeargument name="text_value" value="#form.city#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- State: form.state --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="State"/>
			<cfinvokeargument name="text_value" value="#form.state#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- Zip: form.zip --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Zip"/>
			<cfinvokeargument name="text_value" value="#form.zip#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- Department of Interest: form.dept --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Department of Interest"/>
			<cfinvokeargument name="text_value" value="#form.dept#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- Position Type: form.job_type --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Position Type"/>
			<cfinvokeargument name="text_value" value="#form.job_type#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="text_req" value="true"/>
		</cfinvoke>
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Work History"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Position: form.Position --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Position"/>
			<cfinvokeargument name="text_value" value="#form.position#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfset variables.save_file="E:\inetpub\wwwroot\Ultra10\resumes">
		<cfif len(trim(form.resume_file)) neq 0>
			<cftry>
				<cffile action="UPLOAD" filefield="form.resume_file" destination="#variables.save_file#" nameconflict="MAKEUNIQUE" accept="application/msword,text/plain,text/html,application/vnd.openxmlformats-officedocument.wordprocessingml.document">
				<cfcatch>
					<script>
						alert('Resume Uploads are restricted to MS Word, Text, and\nHTML documents. Please review your file type and try again.');
						history.go(-1);
					</script>
					<cfabort>
				</cfcatch>
			</cftry>
			<cfset variables.myresume=ServerFile>
		<cfelse>
			<cfset variables.myresume="">
		</cfif>

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
				<cfinvokeargument name="address_1" value="#form.address_1#"/>
				<cfinvokeargument name="address_2" value="#form.address_2#"/>
				<cfinvokeargument name="city" value="#form.city#"/>
				<cfinvokeargument name="state" value="#form.state#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_job" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="department" value="#form.dept#"/>
				<cfinvokeargument name="position_type" value="#form.job_type#"/>
				<cfinvokeargument name="resume_available" value="#form.resume_available#"/>
				<cfinvokeargument name="references_available" value="#form.references_available#"/>
				<cfinvokeargument name="resume_file" value="#variables.myresume#"/>
			</cfinvoke>
			
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
				<cfinvokeargument name="address_1" value="#form.address_1#"/>
				<cfinvokeargument name="address_2" value="#form.address_2#"/>
				<cfinvokeargument name="city" value="#form.city#"/>
				<cfinvokeargument name="state" value="#form.state#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="job_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="department" value="#form.dept#"/>
				<cfinvokeargument name="position_type" value="#form.job_type#"/>
				<cfinvokeargument name="resume_available" value="#form.resume_available#"/>
				<cfinvokeargument name="references_available" value="#form.references_available#"/>
				<cfinvokeargument name="work_history" value="#form.comments#"/>
				<cfinvokeargument name="position" value="#form.position#"/>
			</cfinvoke>
			
			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<cfparam name="variables.Email_Subject" default="Employment Inquiry from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

			<!--- FOR TESTING ONLY --->
						<!--- <cfmail to="bob@worlddealer.net" from="#variables.From_Email#" subject="#variables.Email_Subject#">
							<cfmailparam name="Reply-To" value="#form.email#">
							<cfif len(trim(variables.myresume)) neq 0><cfmailparam file="#variables.save_file#\#variables.myresume#"></cfif>
							<cfif len(trim(variables.myresume)) neq 0>User has attached a Resume#chr(10)#</cfif>
							#variables.text_email#
						</cfmail> --->
			<!--- FOR TESTING ONLY --->
 
			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>  
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#"> 
							<cfmailparam name="Reply-To" value="#form.email#">
							<cfif len(trim(variables.myresume)) neq 0><cfmailparam file="#variables.save_file#\#variables.myresume#"></cfif>
							<cfif len(trim(variables.myresume)) neq 0>User has attached a Resume#chr(10)#</cfif>
							#variables.text_email#
						</cfmail>
				  </cfif>  

				</cfloop>
			</cfif>
  		
		</cfif>

	</cffunction>

</cfcomponent>