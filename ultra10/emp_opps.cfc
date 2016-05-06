<cfcomponent>

<!--- Data Collection --->
		<cfset variables.dsn = "Ultra10">
		
		<cfquery datasource="#variables.DSN#" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,directions,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset where_the_step_2 = "../../employment/employment_step2.cfm" >
		

	<cffunction name="modern_standard" description="create standard Opportunity page" output="yes" access="public">

		<cfquery name="get_opp_list" datasource="#variables.DSN#">
			SELECT  ID, Dealer_ID, Emp_Title, Department, Emp_Location,Emp_Location_ID, Position_Type, Emp_Compensation, Emp_Short_Description,Emp_Description, 
					Emp_Posted, Emp_Expires, Emp_Requirements, Contact_Name, Contact_Title, Contact_Phone, Contact_Email, Active, External_link
			FROM    Employment
			WHERE	active = 1
			and 	( Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			or		Emp_Location_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6"> ) 
			
			<cfswitch expression="#url.Dealer_ID#">    
				<cfcase value="311">or		Emp_Location_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="286" maxlength="6"> </cfcase>
				<cfcase value="132,312,1,14,3,4,5,6,148,7,8,9,10,162,11,12,15,341">or		Emp_Location_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="380" maxlength="6"> </cfcase>
			</cfswitch>
			order by Department ASC, Emp_Location ASC, Emp_Posted DESC
		</cfquery>
				
		<cfset today_is = #dateformat(now(),"mm/dd/yyyy")# >
		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">

		<cfset hld_dept = "" >
		<cfloop query="get_opp_list" >
			<cfif (#get_opp_list.Emp_Expires# NEQ "" AND  #dateformat(get_opp_list.Emp_Expires,"mm/dd/yyyy")# LT #today_is# )>
				<cfquery name="" datasource="#variables.DSN#">Update	Employment	SET	ACTIVE=0 WHERE	ID=#get_opp_list.ID#</cfquery>
			<cfelse> 
				<cfif #get_opp_list.Department# NEQ #hld_dept# >
					<cfif #hld_dept# NEQ "" >
						<div class="row"><div class="col-md-12"><hr width="100%" color="darkgray" style="height:3px;"></hr></div></div>
					</cfif>
					<div class="row"><div class="col-md-12" style="font-size:18pt; font-weight:bold">#get_opp_list.Department#</div></div> 
					<cfset hld_dept = "#get_opp_list.Department#" >
				</cfif>
				<div class="row"><div class="col-md-1"></div><div class="col-md-11" style="font-size:16pt; font-weight:bold">#get_opp_list.Emp_Title#</div></div>
				<div class="row"><div class="col-md-1"></div><div class="col-md-11">Location: <b>#get_opp_list.Emp_Location#</b></div></div>
				<div class="row"><div class="col-md-1"></div><div class="col-md-11">Type    : <b>#get_opp_list.Position_Type#</b></div></div>
				<div class="row"><div class="col-md-1"></div><div class="col-md-11">Posted  : <b>#dateformat(get_opp_list.Emp_Posted,"mm/dd/yyyy")#</b></div></div><p></p>
				<div class="row"><div class="col-md-1"></div><div class="col-md-11">#get_opp_list.Emp_Short_Description#</div></div>
				<div class="row">&nbsp;</div>
				<div class="row"><div class="col-md-1"></div><div class="col-md-11">
				<cfif #get_opp_list.external_link# NEQ "" >
					<a href="#get_opp_list.external_link#" target="_blank"><input type="button" class="btn btn-primary" id="Contact_Us" value="LEARN MORE AND APPLY"></a>
				<cfelse>	
					<a href="#where_the_step_2#?emp_opp_id=#get_opp_list.ID#"><input type="button" class="btn btn-primary" id="Contact_Us" value="LEARN MORE AND APPLY"></a>
				</cfif>	
				<!--- <a href="#where_the_step_2#?emp_opp_id=#get_opp_list.ID#">LEARN MORE AND APPLY</a> --->
				</div></div> 
				<p>&nbsp;</p>
			</cfif> 
		</cfloop>
	</cffunction>

	

	<cffunction name="modern_standard_step_two" description="create Detail Opportunity page" output="yes" access="public">

		<cfquery name="get_opp_list" datasource="#variables.DSN#">
			SELECT  ID, Dealer_ID, Emp_Title, Department, Emp_Location,Emp_Location_ID, Position_Type, Emp_Compensation, Emp_Short_Description,Emp_Description, 
					Emp_Posted, Emp_Expires, Emp_Requirements, Contact_Name, Contact_Title, Contact_Phone, Contact_Email, Active
			FROM    Employment
			WHERE	<!--- Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			and 	 --->ID = #url.emp_opp_id#
		</cfquery>
		
		<cfset where_the_application = "../forms/emp_opp.cfm" >
		
		<cfset today_is = #dateformat(now(),"mm/dd/yyyy")# >
		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">

		<div class="row"><div class="col-md-12" style="font-size:18pt; font-weight:bold">#get_opp_list.Department#</div></div> 
		<div class="row"><div class="col-md-1"></div><div class="col-md-11" style="font-size:16pt; font-weight:bold">#get_opp_list.Emp_Title#</div></div>
		<div class="row"><div class="col-md-1"></div><div class="col-md-11">Location : <b>#get_opp_list.Emp_Location#</b></div></div>
		<div class="row"><div class="col-md-1"></div><div class="col-md-11">Type     : <b>#get_opp_list.Position_Type#</b></div></div>
		<div class="row"><div class="col-md-1"></div><div class="col-md-11">Posted   : <b>#dateformat(get_opp_list.Emp_Posted,"mm/dd/yyyy")#</b></div></div>
		<cfif #len(get_opp_list.Emp_Description)# GT 0 >
			<p></p>
			<div class="row"><div class="col-md-1"></div><div class="col-md-11" style="font-size:14pt; font-weight:bold">Job Duties:</div></div> 
			<div class="row"><div class="col-md-1"></div><div class="col-md-11">#get_opp_list.Emp_Description#</div></div>
		</cfif>
		<cfif #len(get_opp_list.Emp_Requirements)# GT 0 >
			<p></p>
			<div class="row"><div class="col-md-1"></div><div class="col-md-11" style="font-size:14pt; font-weight:bold">Skills/Qualifications:</div></div> 
			<div class="row"><div class="col-md-1"></div><div class="col-md-11">#get_opp_list.Emp_Requirements#</div></div>
		</cfif>
		<cfif #len(get_opp_list.Emp_Compensation)# GT 0 >
			<p></p>
			<div class="row"><div class="col-md-1"></div><div class="col-md-11" style="font-size:14pt; font-weight:bold">Compensation:</div></div> 
			<div class="row"><div class="col-md-1"></div><div class="col-md-11">#get_opp_list.Emp_Compensation#</div></div>
		</cfif>
		<div class="row">
			<div class="col-md-1"></div><div class="col-md-11" align="left"><a href="#where_the_application#?opp=#get_opp_list.ID#" style="font-size:20pt;font-weight:bold" ><input type="button" class="btn btn-primary" id="Contact_Us" value="APPLY NOW!"></a>
			<p></p><a href="../employment" style="font-size:10pt;font-weight:bold" >Return to Opportunities</a></div>
		</div> 
		<p>&nbsp;</p>

	</cffunction>

	
	
	
	
	<cffunction name="legacy_standard" description="create standard lease page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">

		<table>
			<tr><td align="left"><h2>Career Opportunities at #Get_Dealer_Details.Display_Name#</h2></td></tr>
			<tr><td>&nbsp;</td></tr>			<tr><td>&nbsp;</td></tr>

			<tr><td align="left">Coming Soon</td></tr>	
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
		</table>
		
	</cffunction>
	
	<cffunction name="legacy_standard_step_two" description="create standard lease page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">

		<table>
			<tr><td align="left"><h2>Career Opportunities at #Get_Dealer_Details.Display_Name#</h2></td></tr>
			<tr><td>&nbsp;</td></tr>			<tr><td>&nbsp;</td></tr>

			<tr><td align="left">Coming Soon</td></tr>	
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
		</table>
		
	</cffunction>

</cfcomponent>