<cfoutput>
		
		<cfset where_the_step_2 = "../../employment/employment_step2.cfm" >
	
		<cfquery name="get_opp_list" datasource="Ultra10">
			SELECT  ID, Dealer_ID, Emp_Title, Department, Emp_Location,Emp_Location_ID, Position_Type, Emp_Compensation, Emp_Short_Description,Emp_Description, 
					Emp_Posted, Emp_Expires, Emp_Requirements, Contact_Name, Contact_Title, Contact_Phone, Contact_Email, Active, External_link
			FROM    Employment
			WHERE	active = 1
			and 	( Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			or		Emp_Location_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6"> ) 
			<cfif #url.Dealer_ID# EQ 311 >
				or		Emp_Location_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="286" maxlength="6"> 
			</cfif>
			order by Department ASC, Emp_Location ASC, Emp_Posted DESC
		</cfquery>
				
		<cfset today_is = #dateformat(now(),"mm/dd/yyyy")# >
		
	 <div class="container-fluid">
<section class="section-banners">
	 <div class="container pad-top-10">
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
				<div class="row">
					<div class="col-md-1">&nbsp;</div>
					<div class="col-md-11">
					<cfif #get_opp_list.external_link# NEQ "" >
						<a href="#get_opp_list.external_link#" target="_blank"><input type="button" class="btn btn-primary" id="Contact_Us" value="LEARN MORE AND APPLY"></a>
					<cfelse>	
						<a href="#where_the_step_2#?emp_opp_id=#get_opp_list.ID#"><input type="button" class="btn btn-primary" id="Contact_Us" value="LEARN MORE AND APPLY"></a>
					</cfif>	
				</div>
				</div> 
				<p>&nbsp;</p>
			</cfif> 
		</cfloop>
	</div>
</section>
	</div>
</cfoutput>