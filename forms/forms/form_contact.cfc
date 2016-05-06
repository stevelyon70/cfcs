<cfcomponent>

	<cffunction name="contact_splash_v1" description="display  contact us form for Variable Template Splash" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="title_class" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="">
		<cfargument name="button_text" default="Send Email">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form action="#arguments.form_action#" method="post">
			<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">

			<div class="col-md-6 visible-sm visible-xs  visible-lg visible-md">	
				<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="First Name" required>
				<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="Last Name" required>
				<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:5px" maxlength="100" placeholder="Email" required>
				<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:5px" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
			</div>
			<div class="col-md-6 visible-sm visible-xs  visible-lg visible-md">	
				<textarea class="#arguments.input_class#" name="Comments" id="Comments" placeholder="Comments" rows="7"   maxlength="1000" required></textarea>
				<br><input class="#arguments.button_class# btn-primary   pull-right" name="Contact_Us" id="Contact_Us" type="submit" value="#arguments.button_text#">
			</div>	
		</form>

	</cffunction>

	<cffunction name="mailing_list" description="Mailing List Opt-In form for Variable Template Splash" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="title_class" default="">
		<cfargument name="input_class" default="input-sm">
		<cfargument name="button_class" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form action="#arguments.form_action#" method="post">
			<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">

			<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md">	
				<!--- <input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:5px" type="text" size="15" maxlength="50" placeholder="First Name*" required>
				<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" size="15" maxlength="50" placeholder="Last Name*" required> --->
				<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:5px" size="40" maxlength="100" placeholder="Email*" required>
				<!--- <input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:5px" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)"> --->
			<!--- </div> --->
			<!--- <div class="col-md-6 visible-sm visible-xs  visible-lg visible-md">	 --->
				<!--- <input class="#arguments.input_class#" name="Comments" id="Comments" type="text" style="margin-bottom:5px" size="30" maxlength="100" placeholder="Makes/Models of Interest" > --->
				<input class="#arguments.button_class# mailing-list-go-btn  " name="Contact_Us" id="Contact_Us" type="submit" value="Subscribe">
			</div>	
		</form>

	</cffunction>

	<cffunction name="wish_list" description="Wish List Option for SRP tabs" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="title_class" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		
		<cfargument name="V_Year" default="">
		<cfargument name="V_Make" default="">
		<cfargument name="V_Model" default="">
		<cfargument name="V_Trim" default="">
		<cfargument name="V_stock" default="">
 
		 
		<form action="#arguments.form_action#" method="post">
			<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
<div class="row no-pad" >
			<div class="col-md-6 visible-sm visible-xs  visible-lg visible-md">	
				<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:5px" type="text" size="15" maxlength="50" placeholder="First Name*" required>
				<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" size="15" maxlength="50" placeholder="Last Name*" required>  
				<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:5px" size="40" maxlength="100" placeholder="Email*" required>
				<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:5px" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">    
				<input class="#arguments.input_class#" name="Comments" id="Comments" type="text" style="margin-bottom:5px" size="30" maxlength="100" 
						value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim# Stock##: #arguments.V_stock#" placeholder="Makes/Models of Interest" >  
				<input class="#arguments.button_class# mailing-list-go-btn  " name="Contact_Us" id="Contact_Us" type="submit" value="Register">
			 </div>  
			 <div class="col-md-6 visible-sm visible-xs  visible-lg visible-md" style="align:center;">	
			 	<span style="font-size:18pt;color:##cc0000;font-weight:bold">REGISTER NOW!</span><br><span style="font-size:14pt;color:##000000;font-weight:normal">We'll send you an email if the price on this <b>#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</b> changes!</span>
			</div>	
</div>			
		</form>
		 

	</cffunction>

	<cffunction name="data" description="display default contact us form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form class="" action="#arguments.form_action#?form_action=form_submit" method="post">
		
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
		
			<label class="" for="First_Name">First Name</label>
			<input class="" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
			<br/>
		
			<label class="" for="Last_Name">Last Name</label>
			<input class="" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
			<br/>
			
			<label class="" for="Phone_1">Daytime Phone</label>
			<input class="" name="Phone_1" id="Phone_1" type="number" minlength="10" maxlength="10" placeholder="Daytime Phone">
			<br/>
			
			<label class="" for="Phone_2">Evening Phone</label>
			<input class="" name="Phone_2" id="Phone_2" type="number" minlength="10" maxlength="10" placeholder="Evening Phone">
			<br/>
			
			<label class="" for="Email">Email</label>
			<input class="" name="Email" id="Email" type="email" maxlength="100" placeholder="Email" required>
			<br/>

			<label class="" for="Zip">Zip</label>
			<input class="" name="Zip" id="Zip" type="zip" maxlength="5" placeholder="Zip Code">
			<br/>
			
			<label class="" for="Best_Method">Best Contact Method</label>
			<select class="" name="Best_Method" id="Best_Method">
				<cfif #arguments.dealer_id# EQ 18 >
					<option value="Daytime Phone">Daytime Phone</option>
					<option value="Email">Email</option>
				<cfelse>	
					<option value="Email">Email</option>
					<option value="Daytime Phone">Daytime Phone</option>
				</cfif>
				
				<option value="Evening Phone">Evening Phone</option>
				<option value="Text Daytime Phone">Text Daytime Phone</option>
				<option value="Text Evening Phone">Text Evening Phone</option>
			</select>
			<br/>
			
			<label class="" for="Best_Time">Best Contact Time</label>
			<select class="" name="Best_Time" id="Best_Time">
				<option value="Evening">Evening</option>
				<option value="Afternoon">Afternoon</option>
				<option value="Morning">Morning</option>
			</select>
			<br/>
			
			<label class="" for="Sales_Rep">Rep Name</label>
			<input class="" name="Sales_Rep" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
			<br/>
			
			<cfif Get_Form_Locations.Recordcount gt 0>
			
				<label class="" for="Delivery_Dealer_ID">Preferred Dealership</label>
				<select class="" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
					<option value="">Select a Dealer</option>
					<cfloop query="Get_Form_Locations">
						<cfif #Get_Form_Locations.Location_ID# NEQ 286>
							<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
						</cfif>	
					</cfloop>
				</select>
				<br/>
			
			<cfelse>
			
				<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			
			</cfif>
			
			<label class="" for="Comments">Comments</label>
			<textarea class="" name="Comments" id="Comments" placeholder="Comments" maxlength="1000" required></textarea>
			<br/>
			
			<input class="" name="Contact_Us" id="Contact_Us" type="submit" value="Contact Us">
		
		</form>

	</cffunction>

	<cffunction name="data_v1" description="display SHORT contact us form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/contact_short_action.cfm">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="title_class" default="">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form class="" action="#arguments.form_action#?form_action=form_submit" method="post">
			<div class="row">
			<div class="col-md-1  visible-lg visible-md">&nbsp;</div>
			<div class="col-md-4  visible-sm visible-xs  visible-lg visible-md" >	
				<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
			
				<!--- <label class="" for="First_Name">First Name</label> --->
				<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name*" required>
				<br/>
			
				<!--- <label class="" for="Last_Name">Last Name</label> --->
				<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name*" required>
				<br/>
				
				<!--- <label class="" for="Phone_1">Phone</label> --->
				<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="number" size="10" maxlength="10" placeholder="Phone">
				<br/>
				
				<!--- <label class="" for="Email">Email</label> --->
				<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email*" required>
				<br/>
				
				
					<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
				
				<!--- <label class="" for="Comments">Comments</label> --->
				<textarea class="#arguments.input_class#" name="Comments" id="Comments" placeholder="What can we do for you?" maxlength="1000" ></textarea>
				<br/>
				
				<input class=" spl-search-btn pull-right" name="Contact_Us" id="Contact_Us" type="submit" value="Contact Us">
			</div>
			  <div class="col-md-1  visible-lg visible-md">&nbsp;</div> 
			<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md"  >	 
			

				<cfquery datasource="Ultra10" name="Get_Phones">
					SELECT		Departments.Department,
								Dealer_Phones.Area_Code,
								Dealer_Phones.Prefix,
								Dealer_Phones.Line_Number,
								Dealer_Phones.Vanity_Number,
								Dealer_Phones.Phone_Label, 
								Dealer_Phones.Dealer_Dept_ID as phoner,
								Join_Dealer_Dept.Dealer_Dept_ID as dphone
					FROM		Dealer_Phones
					INNER JOIN	Join_Dealer_Dept
					ON			Dealer_Phones.Dealer_Dept_ID = Join_Dealer_Dept.Dealer_Dept_ID
					INNER JOIN	Departments
					ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
					WHERE		Dealer_Phones.Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
					ORDER BY 	Dealer_Phones.Hierarchy
				</cfquery>

				<cfquery datasource="Ultra10" name="Get_Departments">
					SELECT		Join_Dealer_Dept.Dealer_Dept_ID,
								Departments.Department
					FROM		Join_Dealer_Dept
					INNER JOIN	Departments
					ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
					WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
					AND			Join_Dealer_Dept.Dealer_Dept_ID IN (SELECT Dealer_Dept_ID FROM Dealer_Dept_Hours)
					ORDER BY 	Join_Dealer_Dept.Hierarchy
				</cfquery>
				
				<div class="row">
					<cfloop query="Get_Departments">
						<cfquery datasource="Ultra10" name="Get_Hours">
							SELECT		Line_Desc,
										Line_Value
							FROM		Dealer_Dept_Hours
							WHERE		Dealer_Dept_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Departments.Dealer_Dept_ID#" maxlength="6">
							AND			active = 1
							ORDER BY 	Hierarchy
						</cfquery>
						<div class="col-md-6">
							<div class="dept-name" title="#Get_Departments.Department#"><b>#Get_Departments.Department#</b></div>
							
							<cfloop query="Get_Hours">
								<div class="dept-hours" title="#Get_Hours.Line_Desc#: #Get_Hours.Line_Value#"><b>#Get_Hours.Line_Desc#:</b> #Get_Hours.Line_Value#</div>
							</cfloop>
							<br/> 
						</div>
						<cfif Get_Departments.currentRow mod 2 eq 0>
							</div><div class="row">
						</cfif>
					</cfloop>
				</div>
			<div class="content-phone" title="#arguments.dealer_name#">#arguments.dealer_name#</div>
			<div class="content-dealer" title="#arguments.address_1#" >#arguments.address_1#</div>
			<div class="content-dealer" title="#arguments.address_2#">#arguments.address_2#</div>
			<div class="content-dealer" title="#arguments.city#, #arguments.state# #arguments.zip#">
           		#arguments.city#, #arguments.state# #arguments.zip#
			</div>
			
				<br/><br/>
			<cfloop query="Get_Phones">
				<cfif len(trim(Get_Phones.Vanity_Number)) gt 0>
					<div class="content-phone" title="#Get_Phones.Vanity_Number#" ><b>#Get_Phones.Phone_Label#:</b> #Get_Phones.Vanity_Number#</div>
				<cfelse>
					<div class="content-phone" title="#Get_Phones.Phone_Label#: (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#"><b>#Get_Phones.Phone_Label#:</b> (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</div>
				</cfif>
			</cfloop>
            </div>
        </div>
        </div>
				
				
			</div>
		</div>
		</form>

	</cffunction>

	<cffunction name="data_v2" description="display SHORT contact us form for Hot List pages" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/hotlist_inquiry_action.cfm">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="title_class" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">

		<cfset var Get_Form_Locations="">
		
		<cfquery datasource="Ultra10" name="Get_Logo">
			SELECT		*
			FROM		navigation
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			AND			nav_type_id  = 73
			ORDER BY 	Hierarchy
		</cfquery>
		<cfif left(Get_Logo.Nav_Link,4) neq "http">
			<cfset Get_Logo.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Logo.Nav_Link)#">
		</cfif>
		
			<cfset arguments.responsive = "true" >
			<cfset variables.element_class="">
				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Logo.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Logo.Align#;">
				</cfif>
				<cfif len(trim(Get_Logo.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Logo.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Logo.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Logo.Font_Size#pt!important;">
				</cfif>
				<cfif len(trim(Get_Logo.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Logo.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Logo.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Logo.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Logo.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Logo.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Logo.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Logo.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Logo.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Logo.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Logo.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Logo.Margin_Right#px;">
				</cfif>
				<cfif get_nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset get_nav.pull="">
				</cfif>
				
				<cfif len(trim(get_nav.pull)) neq 0>
					<cfset arguments.pull=get_nav.pull>
				</cfif>
				
				<cfif get_nav.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif get_nav.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>


		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>
<br><br>
		<form class="" action="#arguments.form_action#?form_action=form_submit" method="post">
			<div class="row">
			<div class="col-md-1  visible-lg visible-md">&nbsp;</div>
			<div class="col-md-4  visible-sm visible-xs  visible-lg visible-md" >	
				<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" name="hotlistinquiry" id="hotlistinquiry" value="1">
			
				<!--- <label class="" for="First_Name">First Name</label> --->
				<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name*" required>
				<br/>
			
				<!--- <label class="" for="Last_Name">Last Name</label> --->
				<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name*" required>
				<br/>
				
				<!--- <label class="" for="Phone_1">Phone</label> --->
				<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="number" size="10" maxlength="10" placeholder="Phone">
				<br/>
				
				<!--- <label class="" for="Email">Email</label> --->
				<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email*" required>
				<br/>
				
				
			<cfif Get_Form_Locations.Recordcount gt 0>
			
				<!--- <label class="" for="Delivery_Dealer_ID">Preferred Dealership</label> --->
				<select class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
					<option value="">Select a Dealer</option>
					<cfloop query="Get_Form_Locations">
						<cfif #Get_Form_Locations.Location_ID# NEQ 132 AND  
								#Get_Form_Locations.Location_ID# NEQ 195  AND #Get_Form_Locations.Location_ID# NEQ 14  AND #Get_Form_Locations.Location_ID# NEQ 15 >
							<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
						</cfif>	
					</cfloop>
				</select>
				
			
			<cfelse>
			
				<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			
			</cfif>
				
				<br/>
				<!--- <label class="" for="Comments">Comments</label> --->
				<textarea class="#arguments.input_class#" name="Comments" id="Comments" placeholder="Comments" maxlength="1000" ></textarea>
				<br/>
				
				<input class=" spl-search-btn pull-right" name="Contact_Us" id="Contact_Us" type="submit" value="Contact Us">
			</div>
			  <div class="col-md-1  visible-lg visible-md">&nbsp;</div> 
			<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md"  >	
			
			<p align="center">
			
				<!--- Direct Link --->
		<cfif len(trim(Get_Logo.Nav_Mobile_Link)) gt 0>
			<cfif len(trim(Get_Logo.Nav_Image)) eq 0>
				<a id="nav_#Get_Logo.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Logo.Nav_Mobile_Link#" title="#Get_Logo.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Logo.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
			<cfelse>
				<cfif len(trim(Get_Logo.pull)) eq 0 and  len(trim(Get_Logo.Align)) neq 0><div style="align:#Get_Logo.Align#"></cfif>
				<a id="nav_#Get_Logo.Nav_ID#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Logo.Nav_Mobile_Link#" title="#Get_Logo.Nav_Alt#">
					<img style="#variables.element_style#"  class="#Get_Logo.Nav_ID# img-responsive" alt="#Get_Logo.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Logo.Nav_Image#" />
				<br><span style="#variables.element_style#">#Get_Logo.Snippet#</span>
				</a>
				<cfif len(trim(Get_Logo.pull)) eq 0 and  len(trim(Get_Logo.Align)) neq 0></div></cfif>
			</cfif>
			<cfset variables.element_class="#variables.element_class# visible-lg visible-md">
		</cfif>
		<cfif len(trim(Get_Logo.Nav_Image)) eq 0>
			<a id="nav_#Get_Logo.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Logo.Nav_ID#" href="#Get_Logo.Nav_Link#" title="#Get_Logo.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif><cfif #url.dealer_ID# eq 30 and arguments.nav_type_id eq 12>style="color:##ffffff;"</cfif>  class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Logo.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
		<cfelse>
			<cfif len(trim(Get_Logo.Nav_Rollover)) eq 0>
				<cfif len(trim(Get_Logo.pull)) eq 0 and  len(trim(Get_Logo.Align)) neq 0><div style="align:#Get_Logo.Align#"></cfif>
				<a id="nav_#Get_Logo.nav_id#" class="#variables.element_class# nav_#Get_Logo.Nav_ID#" href="#Get_Logo.Nav_Link#" title="#Get_Logo.Nav_Alt#">
					<img style="#variables.element_style#"  class="nav_#Get_Logo.Nav_ID# img-responsive " alt="#Get_Logo.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Logo.Nav_Image#" />
				<br><span style="#variables.element_style#">#Get_Logo.Snippet#</span>
				</a>
				<cfif len(trim(Get_Logo.pull)) eq 0 and  len(trim(Get_Logo.Align)) neq 0></div></cfif>
			<cfelse>
				<cfif len(trim(Get_Logo.pull)) eq 0 and  len(trim(Get_Logo.Align)) neq 0><div style="align:#Get_Logo.Align#"></cfif>
				<a id="nav_#Get_Logo.Nav_ID#" class="#variables.element_class# nav_#Get_Logo.Nav_ID# rollover" href="#Get_Logo.Nav_Link#" title="#Get_Logo.Nav_Alt#">
					<img style="#variables.element_style#"  class="#Get_Logo.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Logo.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Logo.Nav_Image#" />
				<br><span style="#variables.element_style#">#Get_Logo.Snippet#</span>
				</a>
				<cfif len(trim(Get_Logo.pull)) eq 0 and  len(trim(Get_Logo.Align)) neq 0></div></cfif>
			</cfif>
		</cfif>
			
			
			
				<!--- <img class="img-responsive" src="http://dealers.wdautos.com/dealer/baierl/images/slideshow/#get_logo.nav_image#" alt="#get_logo.nav_name#" border="none" /> --->
			</p>
			
			<!--- 

				<cfquery datasource="Ultra10" name="Get_Phones">
					SELECT		Departments.Department,
								Dealer_Phones.Area_Code,
								Dealer_Phones.Prefix,
								Dealer_Phones.Line_Number,
								Dealer_Phones.Vanity_Number,
								Dealer_Phones.Phone_Label, 
								Dealer_Phones.Dealer_Dept_ID as phoner,
								Join_Dealer_Dept.Dealer_Dept_ID as dphone
					FROM		Dealer_Phones
					INNER JOIN	Join_Dealer_Dept
					ON			Dealer_Phones.Dealer_Dept_ID = Join_Dealer_Dept.Dealer_Dept_ID
					INNER JOIN	Departments
					ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
					WHERE		Dealer_Phones.Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
					ORDER BY 	Dealer_Phones.Hierarchy
				</cfquery>

				<cfquery datasource="Ultra10" name="Get_Departments">
					SELECT		Join_Dealer_Dept.Dealer_Dept_ID,
								Departments.Department
					FROM		Join_Dealer_Dept
					INNER JOIN	Departments
					ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
					WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
					AND			Join_Dealer_Dept.Dealer_Dept_ID IN (SELECT Dealer_Dept_ID FROM Dealer_Dept_Hours)
					ORDER BY 	Join_Dealer_Dept.Hierarchy
				</cfquery> 
				
				<div class="row">
					<cfloop query="Get_Departments">
						<cfquery datasource="Ultra10" name="Get_Hours">
							SELECT		Line_Desc,
										Line_Value
							FROM		Dealer_Dept_Hours
							WHERE		Dealer_Dept_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Departments.Dealer_Dept_ID#" maxlength="6">
							AND			active = 1
							ORDER BY 	Hierarchy
						</cfquery>
						<div class="col-md-6">
							<div class="dept-name" title="#Get_Departments.Department#"><b>#Get_Departments.Department#</b></div>
							
							<cfloop query="Get_Hours">
								<div class="dept-hours" title="#Get_Hours.Line_Desc#: #Get_Hours.Line_Value#"><b>#Get_Hours.Line_Desc#:</b> #Get_Hours.Line_Value#</div>
							</cfloop>
							<br/> 
						</div>
						<cfif Get_Departments.currentRow mod 2 eq 0>
							</div><div class="row">
						</cfif>
					</cfloop>
				</div>
			<div class="content-phone" title="#arguments.dealer_name#">#arguments.dealer_name#</div>
			<div class="content-dealer" title="#arguments.address_1#" >#arguments.address_1#</div>
			<div class="content-dealer" title="#arguments.address_2#">#arguments.address_2#</div>
			<div class="content-dealer" title="#arguments.city#, #arguments.state# #arguments.zip#">
           		#arguments.city#, #arguments.state# #arguments.zip#
			</div>
			
				<br/><br/>
			<cfloop query="Get_Phones">
				<cfif len(trim(Get_Phones.Vanity_Number)) gt 0>
					<div class="content-phone" title="#Get_Phones.Vanity_Number#" ><b>#Get_Phones.Phone_Label#:</b> #Get_Phones.Vanity_Number#</div>
				<cfelse>
					<div class="content-phone" title="#Get_Phones.Phone_Label#: (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#"><b>#Get_Phones.Phone_Label#:</b> (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</div>
				</cfif>
			</cfloop>
            </div> --->
        </div>
		<div class="row pad-top-10">&nbsp;</div>
		<div class="row">&nbsp;</div>
        </div>
				
				
			</div>
		</div><br><br><br><br><br><br>
		</form>

	</cffunction>

	<cffunction name="sidebar_modern" description="display sidebar modern contact us form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="title_class" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form action="#arguments.form_action#" method="post">
			<div class="#arguments.title_class#" title="Contact Us">Contact Us</div>
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
			<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
				<input style="width:100%" class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'"><br/>
				<input style="width:100%" class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
				<input style="width:100%" class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'"><br/>
				<p class="help-block">numbers only - no hyphens or parentheses</p>
				<input style="width:100%" class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
				<cfif Get_Form_Locations.Recordcount gt 0>
					<select style="width:100%" class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
						<option value="">Select a Dealer</option>
						<cfloop query="Get_Form_Locations">
						<cfif #Get_Form_Locations.Location_ID# NEQ 286>
							<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
						</cfif>	
						</cfloop>
					</select><br/>
				<cfelse>
					<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
				</cfif>
				<textarea style="width:100%" class="#arguments.input_class#" name="Comments" id="Comments" placeholder="Comments" maxlength="1000" onfocus="if (this.value=='Comments') this.value = ''" onblur="if (this.value=='') this.value = 'Comments'">Comments</textarea><br/>
			<cfelse>
				<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name" required><br/>
				<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required><br/>
				<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone"><br/>
				<p class="help-block">numbers only - no hyphens or parentheses</p>
				<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email" required><br/>
				<cfif Get_Form_Locations.Recordcount gt 0>
					<select class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
						<option value="">Select a Dealer</option>
						<cfloop query="Get_Form_Locations">
						<cfif #Get_Form_Locations.Location_ID# NEQ 286>
							<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
						</cfif>	
						</cfloop>
					</select><br/>
				<cfelse>
					<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
				</cfif>
				<textarea class="#arguments.input_class#" name="Comments" id="Comments" placeholder="Comments" maxlength="1000" required></textarea><br/>
			</cfif>
			<input class="#arguments.button_class# btn-primary" name="Contact_Us" id="Contact_Us" type="submit" value="Contact Us">
		</form>

	</cffunction>

	<cffunction name="contact_footer" description="display sidebar modern contact us form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="title_class" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfif #url.dealer_id# eq 365 >
			<div class="#arguments.title_class# pull-left" title="Contact Us"  >Contact #url.dealer_name#</div>
		<cfelse>	
			<div class="#arguments.title_class# pull-left" title="Contact Us"  >Contact Us</div>
		</cfif>
		<form action="#arguments.form_action#" method="post">
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
			<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name" required><br/>
			<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required><br/>
			<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email" required><br/>
			<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)"><br/>
			<cfif Get_Form_Locations.Recordcount gt 0>
				<select class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
					<option value="">Select a Dealer</option>
					<cfloop query="Get_Form_Locations">
						<cfif #Get_Form_Locations.Location_ID# NEQ 286>
							<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
						</cfif>	
					</cfloop>
				</select><br/>
			<cfelse>
				<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			</cfif>
			<textarea class="#arguments.input_class#" name="Comments" id="Comments" placeholder="Comments" maxlength="1000" required></textarea><br/>
			<input class="#arguments.button_class# btn-ftr-primary pull-right" name="Contact_Us" id="Contact_Us" type="submit" value="Contact Us">
		</form>

	</cffunction>

	<cffunction name="contact_footer_leg" description="display sidebar modern contact us form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="title_class" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form action="#arguments.form_action#" method="post">
			<div class="#arguments.title_class#" title="Contact Us">Contact Us</div>
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
			<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'" required><br/>
			<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'"><br/>
			<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'"><br/>
			<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'" onkeypress="return isNumberKey(event)"><br/>
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
			<textarea class="#arguments.input_class#" name="Comments" id="Comments" maxlength="1000" onfocus="if (this.value=='Comments') this.value = ''" onblur="if (this.value=='') this.value = 'Comments'">Comments</textarea><br/>
			<input class="#arguments.button_class# btn-primary pull-right" name="Contact_Us" id="Contact_Us" type="submit" value="Contact Us">
		</form>

	</cffunction>
	
	<cffunction name="modern_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_legend" default="Contact Us">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/contact_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name">First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name">Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Daytime Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Daytime Phone" onkeypress="return isNumberKey(event)">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_2">Evening Phone</label>
					<div class="col-md-6">
						<input name="Phone_2" class="form-control input-md" id="Phone_2" type="text" minlength="10" maxlength="10" placeholder="Evening Phone" onkeypress="return isNumberKey(event)">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email">Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Zip">Zip</label>
					<div class="col-md-6">
						<input name="Zip" class="form-control input-md" id="Zip" type="text" maxlength="5" placeholder="Zip Code" onkeypress="return isNumberKey(event)">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Best_Method">Best Contact Method</label>
					<div class="col-md-6">
						<select name="Best_Method" class="form-control input-md" id="Best_Method">
							<cfif #arguments.dealer_id# EQ 18 >
								<option value="Daytime Phone">Daytime Phone</option>
								<option value="Email">Email</option>
							<cfelse>	
								<option value="Email">Email</option>
								<option value="Daytime Phone">Daytime Phone</option>
							</cfif>
							<option value="Evening Phone">Evening Phone</option>
							<option value="Text Daytime Phone">Text Daytime Phone</option>
							<option value="Text Evening Phone">Text Evening Phone</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Best_Time">Best Contact Time</label>
					<div class="col-md-6">
						<select name="Best_Time" class="form-control input-md" id="Best_Time">
							<option value="Evening">Evening</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Morning">Morning</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<cfif Get_Form_Locations.Recordcount gt 0>
					<div class="form-group">
						<label class="control-label col-md-3" for="Delivery_Dealer_ID">Preferred Dealership</label>
						<div class="col-md-6">
							<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
								<option value="">Select a Dealer</option>
								<cfloop query="Get_Form_Locations">
						<cfif #Get_Form_Locations.Location_ID# NEQ 286>
							<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
						</cfif>	
								</cfloop> 
							</select>
						</div>
					</div>
				<cfelse>
					<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
				</cfif>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000" required></textarea>
					</div>
				</div>
				<div class="form-group" style="margin-top:20px">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Contact Us">
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>

	<cffunction name="legacy_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_legend" default="Contact Us">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/contact_action.cfm">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form class="form-horizontal" action="#arguments.form_action#" method="post">
			<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
			<table style="width:100%" cellpadding="0" cellspacing="0">
				<tr>
					<td style="width:50%;" valign="top">
						<table style="width:75%">
							<tr>
								<td style="width:50%;" align="right">
									<label for="First_Name"><span class="txt-red">*</span> First Name</label>
								</td>
								<td style="width:50%;">
									<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Last_Name"><span class="txt-red">*</span> Last Name</label>
								</td>
								<td style="width:50%;">
									<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Phone_1"><span class="txt-red">*</span> Phone</label>
								</td>
								<td style="width:50%;">
									<input name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" required onkeypress="return isNumberKey(event)"><br/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									Numbers Only - no hyphens or parentheses
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Email"><span class="txt-red">*</span> Email</label>
								</td>
								<td style="width:50%;">
									<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Zip">Zip Code</label>
								</td>
								<td style="width:50%;">
									<input name="Zip" class="form-control input-md" id="Zip" type="zip" maxlength="5" placeholder="Zip" onkeypress="return isNumberKey(event)">
								</td>
							</tr>
						</table>
					</td>
					<td style="width:50%;" valign="top">
						<table style="width:75%">
							<tr>
								<td style="width:50%;" align="right">
									<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
								</td>
								<td style="width:50%;">
									<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Service Representative"><br/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									If you are already working with someone.
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label class="control-label col-md-3" for="Delivery_Dealer_ID"><span class="txt-red">*</span> Preferred Dealership</label>
								</td>
								<td style="width:50%;">
									<select name="Delivery_Dealer_ID" class="form-control input-md" id="Delivery_Dealer_ID" required>
										<option value="">Select a Dealer</option>
										<cfloop query="Get_Form_Locations">
											<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
										</cfloop> 
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:50%;" align="right">
									<label for="Comments"><span class="txt-red">*</span> Comments</label>
								</td>
								<td style="width:50%;">
									<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Service Requested" maxlength="1000" required></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type="submit" class="btn btn-primary" id="Contact_Us" value="Contact Us">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br/><br/>
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
		<cfparam name="form.phone_2" default="">
		<cfparam name="form.best_method" default="">
		<cfparam name="form.best_time" default="">
		<cfparam name="form.sales_rep" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.zip" default="">
		<cfparam name="form.hotlistinquiry" default="0">

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
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Select Dealership: form.Zip --->
		<cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Zip Code"/>
			<cfinvokeargument name="int_value" value="#form.zip#"/>
			<cfinvokeargument name="int_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Invalid Zip Code"/>
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
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
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
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

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
			
<!--- 01/28/2016 --->
			<cfif #form.hotlistinquiry# EQ 0 >
				<cfparam name="variables.Email_Subject" default="Contact Request from #lcase(cgi.Server_Name)#">
			<cfelse>
				<cfparam name="variables.Email_Subject" default="Hot List Inquiry from #lcase(cgi.Server_Name)#">
			</cfif>
			
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

	
	<cffunction name="form_submit_ml" description="action page for mailing list form" output="Yes" access="public">

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
		<cfparam name="form.phone_2" default="">
		<cfparam name="form.best_method" default="">
		<cfparam name="form.best_time" default="">
		<cfparam name="form.sales_rep" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.zip" default="">

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.first_name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke> --->
		<!--- Last Name: form.Last_Name --->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke> --->
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke> --->
		<!--- Comments: form.Comments --->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke> --->
		<!--- Select Dealership: form.Zip --->
		<!--- <cfinvoke component="/cfcs/forms/form_validate" method="integer" returnvariable="error_message">
			<cfinvokeargument name="int_name" value="Zip Code"/>
			<cfinvokeargument name="int_value" value="#form.zip#"/>
			<cfinvokeargument name="int_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="int_error_msg" value="Invalid Zip Code"/>
		</cfinvoke> --->

		<!--- 
		SELECT     TOP (200) ID, dealer_id, firstname, lastname, email, phone, comments, active, create_ts, last_contact, opt_out
		FROM         Dealer_Mailing_List
		 --->
		
		
		<!--- check for duplicates based on email address --->
		
		
		<cfquery name="dup_chk" datasource="Ultra10">
			SELECT     ID, dealer_id, firstname, lastname, email, phone, comments, active, create_ts, last_contact, opt_out
			FROM       Dealer_Mailing_List
			WHERE	email = '#form.email#'
		</cfquery>
		
		<cfif #dup_chk.recordcount# eq 1 >
			<cfset variables.error_message= "Email Address Already Registered" >
		</cfif>
		
		<cfif listlen(variables.error_message) gt 0>
	
			<!---<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>--->
			
			<cfset url.error_message=variables.error_message>

		<cfelse>

			<cfquery NAME="InsertEmail" datasource="Ultra10">
			  INSERT into Dealer_Mailing_List ( 	Dealer_ID, firstname, lastname, email, phone, comments )
  									VALUES ( 	#Form.Dealer_ID#,'#Form.first_name#','#Form.last_name#','#Form.email#','#Form.phone_1#','#Form.comments#' )
			</cfquery>
			
			<cfset go_live = 0 >
			<cfquery datasource="Ultra10" name="qryLast_id">SELECT A.ID,a.create_ts FROM	Dealer_Mailing_List A ORDER BY A.ID DESC</cfquery>
			<cfset Last_id = #qryLast_id.ID#>
			<cfset when = #dateformat(qryLast_id.create_ts,"mm/dd/yyyy")#>
			
		<cfif #go_live# EQ 1 >
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
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="zip" value="#form.zip#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="phone_2" value="#form.phone_2#"/>
				<cfinvokeargument name="sales_rep" value="#form.sales_rep#"/>
				<cfinvokeargument name="best_time" value="#form.best_time#"/>
				<cfinvokeargument name="best_method" value="#form.best_method#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

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

			<cfparam name="variables.Email_Subject" default="Mailing List Registration from #lcase(cgi.Server_Name)#">
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdsupport@worlddealer.net">

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
			
			
			<cfelse>
				<!--- Lead Email --->
				<cfparam name="variables.Email_Subject" default="Mailing List Registration from #lcase(cgi.Server_Name)#">
				<cfparam name="variables.From_Email" default="maillist@worlddealer.net">
				<cfparam name="variables.WD_BCC" default="wdsupport@worlddealer.net">
			
				<cfmail to="digitalfaulkner@gmail.com" from="#variables.From_Email#" bcc="bob@worlddealer.net"  subject="#variables.Email_Subject#" type="HTML" >
					<br>
					The following visitor registered for the Mailing List:<br><br>
					
					<!--- Name: #Form.first_name# #Form.last_name#<br> --->
					Email: #Form.email#<br>
					<!--- Phone: #Form.phone_1#<br>
					Make(s): #Form.comments#<br> --->
					ID: #Last_id#<br>
					Date: #when#
				</cfmail>
				<!--- Customer Email --->
				<cfparam name="variables.Email_Subject" default="Thanks for Registering  #lcase(cgi.Server_Name)#">
				<cfparam name="variables.From_Email" default="maillist@worlddealer.net">
				<cfparam name="variables.WD_BCC" default="wdsupport@worlddealer.net">
			<!--- 
				<cfmail to="bob@worlddealer.net" from="#variables.From_Email#" subject="#variables.Email_Subject#" type="HTML" >
					<br>
					Thank You, #Form.first_name# #Form.last_name#<br><br>

					Coupon or whatever
				</cfmail> --->
			
			</cfif> <!--- end live check --->
			
			
		</cfif>

	</cffunction>
	
	
</cfcomponent>