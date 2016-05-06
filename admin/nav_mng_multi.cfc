<!--- 
			nav_mng_multi.cfc
			Used for the Multi-Banner Dividers in the variable template world
			12/31/2015
 --->

<cfcomponent>

	<cffunction name="get_nav" description="gets current nav listing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" required="true">
		<cfargument name="Site_ID_Name" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="image_mode" default="off">
		<cfargument name="sub_nav" default="false">
		<cfargument name="passhierarcy" default="1">
		
		<cfquery datasource="#arguments.DSN#" name="Get_Behaviours">
			SELECT		Nav_Behaviour_ID,
						Nav_Desc
			FROM		Nav_Behaviours
			ORDER BY 	Nav_Behaviour_ID
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Dealer_Details">
			SELECT		Display_Name,
						Address_1,
						Address_2,
						City,
						State,
						Zip
			FROM		Ultra10.dbo.Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Phones">
			SELECT		Phone_ID,
						Phone_Label,
						Area_Code,
						Prefix,
						Line_Number
			FROM		Ultra10.dbo.Dealer_Phones
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			ORDER BY 	Hierarchy
		</cfquery>
		
		<cfset Get_Nav=arguments.Get_Nav>
		
		<form class="form-horizontal" action="#arguments.form_action#?page_action=bulk_update&Nav_Type_ID=#arguments.Nav_Type_ID#" method="post">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<table style="border-radius:10px;-moz-border-radius:10px;-webkit-border-radius:10px;background-color:##CBDDDD">
				<tr>
					<th>Nav Name</th>
					<th>Link</th>
					<th>Link Behaviour</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Hierarchy</th>
					<th>Action</th>
					<th>Delete</th>
					<!--- <th>Robot Food</th> --->
				</tr>
				<cfloop query="Get_Nav">
				<cfif #Get_Nav.Hierarchy# EQ #arguments.passhierarcy# >
					<input type="hidden" name="Nav_ID" value="#Get_Nav.Nav_ID#"/>
					<tr style="background-color:###iif(currentrow MOD 2,DE('C0C0C0'),DE('B4B6B6'))#">
						<td>
							<input style="width:200px;font:normal 11px arial;" type="text" name="Nav_Name_#Get_Nav.Nav_ID#" value="#Get_Nav.Nav_Name#" maxlength="100"/>
						</td>
						<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
							<cfdefaultcase>
								<td>
									<input style="width:300px;font:normal 11px arial;" type="text" name="Nav_Link_#Get_Nav.Nav_ID#" value="#Get_Nav.Nav_Link#" maxlength="500"/>
								</td>
								<input type="hidden" name="Phone_#Get_Nav.Nav_ID#" value=""/>
							</cfdefaultcase>
							<cfcase value="10,11">
								<td>
									#left(Get_Dealer_Details.Address_1,30)# ...
								</td>							
								<input type="hidden" name="Nav_Link_#Get_Nav.Nav_ID#" value=""/>
								<input type="hidden" name="Phone_#Get_Nav.Nav_ID#" value=""/>
							</cfcase>
							<cfcase value="6">
								<td>
									<select style="width:300px;font:normal 11px arial;" name="Phone_#Get_Nav.Nav_ID#">
										<option value="">Select Phone</option>
										<cfloop query="Get_Phones">
											<option value="#Get_Phones.Phone_ID#" <cfif Get_Nav.Phone_ID eq Get_Phones.Phone_ID>Selected</cfif>>#Get_Phones.Phone_Label# - (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</option>									
										</cfloop>
									</select>
								</td>
								<input type="hidden" name="Nav_Link_#Get_Nav.Nav_ID#" value=""/>
							</cfcase>
						</cfswitch>
						<td>
							<select style="width:300px;font:normal 11px arial;" name="Nav_Behaviour_ID_#Get_Nav.Nav_ID#">
								<cfloop query="Get_Behaviours">
									<option value="#Get_Behaviours.Nav_Behaviour_ID#" <cfif Get_Behaviours.Nav_Behaviour_ID eq Get_Nav.Nav_Behaviour_ID>selected="selected"</cfif> >#Get_Behaviours.Nav_Desc#</option>
								</cfloop>
							</select>
						</td>
						<td width="10%">
							<input type="text" name="Start_Date_#Get_Nav.Nav_ID#" value="#dateformat(Get_Nav.Start_Date,'mm/dd/yyyy')#" size="12" maxlength="10"/>
						</td>
						<td width="10%">
							<cfif dateformat(Get_Nav.End_Date,"mm/dd/yyyy") eq "12/31/2100">
								<input type="text" name="End_Date_#Get_Nav.Nav_ID#" value="" size="12" maxlength="10"/>
							<cfelse>
								<input type="text" name="End_Date_#Get_Nav.Nav_ID#" value="#dateformat(Get_Nav.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
							</cfif>
						</td>
						<td  width="10%">
							<input type="text" name="Hierarchy_#Get_Nav.Nav_ID#" value="#Get_Nav.Hierarchy#" size="3" maxlength="3"/>
						</td>
						<td align="center">
							<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_nav&Nav_ID=#Get_Nav.Nav_ID#&dealer_id=#url.dealer_id#&">Edit</a>
						</td>
						<td align="center">
							<input type="checkbox" name="Nav_Delete" value="#Get_Nav.Nav_ID#"/>
						</td>
						<!--- <td align="center">
							<input type="checkbox" name="robot_food_#Get_Nav.Nav_ID#" <cfif Get_Nav.robot_food EQ 1 >checked</cfif>  value="1"/>
						</td> --->
					</tr>
					<cfif arguments.sub_nav eq "true">
						<tr>
							<td align="right"><a href="#arguments.form_action#?page_action=edit_sub&Parent_Nav_ID=#Get_Nav.Nav_ID#&Site_ID=#arguments.Site_ID#">Edit Subnav</a></td>
						</tr>
					</cfif>
					<cfif 	arguments.image_mode eq "on" and
							Get_Nav.Nav_Behaviour_ID neq 6 and 
							Get_Nav.Nav_Behaviour_ID neq 10 and 
							Get_Nav.Nav_Behaviour_ID neq 11>
						<tr style="background-color:###iif(currentrow MOD 2,DE('C0C0C0'),DE('B4B6B6'))#">
							<td colspan="3">
								image : <cfif len(trim(Get_Nav.Nav_Image)) gt 0>#Get_Nav.Nav_Image#<cfelse>No image uploaded</cfif>
							</td>
							<td colspan="6">
								rollover : <cfif len(trim(Get_Nav.Nav_Rollover)) gt 0>#Get_Nav.Nav_Rollover#<cfelse>No image uploaded</cfif>
							</td>
						</tr>
					</cfif>
				</cfif>	
				</cfloop>
				<tr>
					<td><input class="Tabbutton" type="submit" value="Update Nav"/></td>
				</tr>
			</table>
		</form>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=add_nav&Nav_Type_ID=#arguments.Nav_Type_ID#" method="post">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<input type="text" name="Nav_Name" maxlength="100"/><br><br>
			<input  class="Tabbutton" type="submit" value="Add Nav"/>
		</form>
	
	</cffunction>
	
	<cffunction name="get_sub" description="gets current sub nav" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="Parent_Nav_ID" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="image_mode" default="off">
		<cfargument name="passhierarcy" default="1">

		<!---Get Nav--->
		<cfstoredproc datasource="#arguments.DSN#" procedure="Get_All_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#arguments.Site_ID_Name#" value="#arguments.Site_ID#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="1" maxlength="3">
			<cfprocresult name="Get_Main_Nav" resultset="1">
		</cfstoredproc>

		<cfquery datasource="#arguments.DSN#" name="Get_Behaviours">
			SELECT		Nav_Behaviour_ID,
						Nav_Desc
			FROM		Nav_Behaviours
			ORDER BY 	Nav_Behaviour_ID
		</cfquery>

		<table style="font:normal 12px arial" cellpadding="5" cellspacing="0">
			<cfloop query="Get_Main_Nav">
				<tr>
					<td colspan="9">
						<a href="#arguments.form_action#?dealer_id=#arguments.site_id#&Nav_Type_ID=1">#Get_Main_Nav.Nav_Name#</a>
						<cfif arguments.Parent_Nav_ID neq Get_Main_Nav.Nav_ID> - <a href="#arguments.form_action#?page_action=edit_sub&Parent_Nav_ID=#Get_Main_Nav.Nav_ID#&Site_ID=#arguments.Site_ID#">Edit Subnav</a></cfif>
					</td>
				</tr>
				<cfif arguments.Parent_Nav_ID eq Get_Main_Nav.Nav_ID>
					<cfquery datasource="#arguments.DSN#" name="Get_Nav">
						SELECT		Nav_ID,
									Dealer_ID,
									Nav_Type_ID,
									Parent_Nav_ID,
									Nav_Behaviour_ID,
									Nav_Name,
									Nav_Alt,
									Nav_Link,
									Nav_Mobile_Link,
									Nav_Image,
									Nav_Rollover,
									Phone_ID, 
									Start_Date,
									End_Date,
									Display_Mode,robot_food,var_page_nbr ,
									Hierarchy,snippet,pull,nav_image,width,height,
									Pull,
									Align
						FROM		Navigation
						WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4">
						AND			Nav_Type_ID = 2
						AND			Parent_Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Parent_Nav_ID#" maxlength="6">
						ORDER BY 	Hierarchy
					</cfquery>
					<cfif Get_Nav.Recordcount gt 0>
						<form class="form-horizontal" action="#arguments.form_action#?page_action=bulk_update&Nav_Type_ID=#arguments.Nav_Type_ID#" method="post">
							<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
							<input type="hidden" name="Parent_Nav_ID" value="#arguments.Parent_Nav_ID#"/>
							<tr>
								<th>Nav Name</th>
								<th>Link</th>
								<th>Link Behaviour</th>
								<th>Start Date</th>
								<th>End Date</th>
								<th>Hierarchy</th>
								<th>Action</th>
								<th>Delete</th>
								<!--- <th>Robot Food</th> --->
							</tr>
							<cfloop query="Get_Nav">
								<input type="hidden" name="Nav_ID" value="#Get_Nav.Nav_ID#"/>
								<tr <cfif Get_Nav.currentrow mod 2 eq 0> style="background-color:##aa9d88;"</cfif> >
									<cfif #Get_Nav.Nav_Mobile_Link# NEQ "" ><td align="right" style="width:50px">*</td><cfelse><td style="width:50px">&nbsp;</td></cfif>
									<td>
										<input type="text" name="Nav_Name_#Get_Nav.Nav_ID#" value="#Get_Nav.Nav_Name#" size="30" maxlength="100"/>
									</td>
									<td>
										<input type="text" name="Nav_Link_#Get_Nav.Nav_ID#" value="#Get_Nav.Nav_Link#"  size="50" maxlength="200"/>
									</td>
									<input type="hidden" name="Phone_#Get_Nav.Nav_ID#" value=""/>
									<td>
										<select name="Nav_Behaviour_ID_#Get_Nav.Nav_ID#">
											<cfloop query="Get_Behaviours">
												<option value="#Get_Behaviours.Nav_Behaviour_ID#" <cfif Get_Behaviours.Nav_Behaviour_ID eq Get_Nav.Nav_Behaviour_ID>selected="selected"</cfif> >#Get_Behaviours.Nav_Desc#</option>
											</cfloop>
										</select>
									</td>
									<td>
										<input type="text" name="Start_Date_#Get_Nav.Nav_ID#" value="#dateformat(Get_Nav.Start_Date,'mm/dd/yyyy')#" size="12" maxlength="10"/>
									</td>
									<td>
										<cfif dateformat(Get_Nav.End_Date,"mm/dd/yyyy") eq "12/31/2100">
											<input type="text" name="End_Date_#Get_Nav.Nav_ID#" value="" size="12" maxlength="10"/>
										<cfelse>
											<input type="text" name="End_Date_#Get_Nav.Nav_ID#" value="#dateformat(Get_Nav.End_Date,'mm/dd/yyyy')#" size="12" maxlength="10"/>
										</cfif>
									</td>
									<td width="10%">
										<input type="text" name="Hierarchy_#Get_Nav.Nav_ID#" value="#Get_Nav.Hierarchy#" size="3" maxlength="3"/>
									</td>
									<td align="center">
										<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_nav&Nav_ID=#Get_Nav.Nav_ID#&">Edit</a>
									</td>
									<td align="center">
										<input type="checkbox" name="Nav_Delete" value="#Get_Nav.Nav_ID#"/>
									</td>
									<!--- <td align="center"> 
										<input type="checkbox" name="robot_food_#Get_Nav.Nav_ID#" <cfif Get_Nav.robot_food eq 1 >checked</cfif> value="1"/>
									</td> --->
								</tr>
							</cfloop>
							<tr>
								<td style="width:50px">&nbsp;</td>
								<td><input class="Tabbutton" type="submit" value="Update Nav"/></td>
							</tr>
						</form>
					</cfif>
					<tr>
						<td style="width:50px">&nbsp;</td>
						<td>
							<form class="form-horizontal" action="#arguments.form_action#?page_action=add_sub&Nav_Type_ID=#arguments.Nav_Type_ID#" method="post">
								<input type="hidden" name="Parent_Nav_ID" value="#arguments.Parent_Nav_ID#"/>
								<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
								<input type="text" name="Nav_Name" maxlength="100"/><br><br>
								<input class="Tabbutton" type="submit" value="Add Nav"/>
							</form>
						</td>
					</tr>
				</cfif>
			</cfloop>
		<table>
		
	</cffunction>

	<cffunction name="cache_nav" description="caches current nav listing into cfm include" output="Yes" access="public">
	
		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Dealer_Directory" required="true">
		<cfargument name="passhierarcy" default="1">
	
	</cffunction>
	
	<cffunction name="bulk_update" description="gets current nav listing" output="Yes" access="public">
	
		<cfargument name="passhierarcy" default="1">
		<cfloop list="#form.Nav_ID#" index="nid">

			<cfparam name="form.Nav_Delete" default="">
			<cfset variables.Nav_Name="form.Nav_Name_#variables.nid#">
			<cfset variables.Nav_Link="form.Nav_Link_#variables.nid#">
			<cfset variables.Nav_Behaviour_ID="form.Nav_Behaviour_ID_#variables.nid#">
			<cfset variables.Start_Date="form.Start_Date_#variables.nid#">
			<cfset variables.End_Date="form.End_Date_#variables.nid#">
			<cfset variables.Hierarchy="form.Hierarchy_#variables.nid#">
			<cfset variables.Phone_ID="form.Phone_#variables.nid#">
			<!--- <cfif IsDefined("form.Robot_Food_#variables.nid#") >
				<cfset variables.Robot_Food="form.Robot_Food_#variables.nid#">
			<cfelse>	 --->
				<cfset variables.Robot_Food="0">
			<!--- </cfif> --->
			
			<cfif len(trim(evaluate(variables.Nav_Name))) gt 0>
				<cfquery datasource="#arguments.DSN#" name="Update_Nav">
					UPDATE		Navigation
					SET			Nav_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Nav_Name)#" maxlength="100">,
								Nav_Link = <cfif len(trim(evaluate(variables.Nav_Link))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Nav_Link)#" maxlength="500"><cfelse>NULL</cfif>,
								Nav_Behaviour_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#evaluate(variables.Nav_Behaviour_ID)#" maxlength="2">,
								Start_Date = <cfif len(trim(evaluate(variables.Start_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.Start_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
								End_Date = <cfif len(trim(evaluate(variables.End_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.End_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>,
								Phone_ID = <cfif evaluate(variables.Phone_ID) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(evaluate(variables.Phone_ID))#" maxlength="6"><cfelse>NULL</cfif>,
								Robot_Food = <cfif evaluate(variables.Robot_Food) eq 1 >1<cfelse>0</cfif>,
								Hierarchy = #arguments.passhierarcy#
					WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.nid#" maxlength="10">
				</cfquery>
			</cfif>

		</cfloop>

		<cfloop list="#form.Nav_Delete#" index="did">

			<cfquery datasource="#arguments.DSN#" name="Update_Nav">
				DELETE FROM	Navigation
				WHERE		Nav_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.did#" maxlength="10">
			</cfquery>
		
		</cfloop>
		<!--- 
		<cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		Nav_ID,
						Hierarchy
			FROM		Navigation
			WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Nav_Type_ID#" maxlength="6">
			ORDER BY	Hierarchy
		</cfquery>
		
		<cfloop query="Get_H">

			<cfquery datasource="#arguments.DSN#" name="Update_H">
				UPDATE		Navigation
				SET			Hierarchy = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#Get_H.Currentrow#" maxlength="2">
				WHERE		Nav_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_H.Nav_ID#" maxlength="6">
			</cfquery>
		
		</cfloop> --->
		
	</cffunction>
	
	<cffunction name="add_nav" description="gets current nav listing" output="Yes" access="public">	

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="passhierarcy" default="1">

		<!--- <cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		max(Hierarchy) as max_h
			FROM		#arguments.Table_Name#
			WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Nav_Type_ID#" maxlength="6">
		</cfquery> --->
			
		<cfset variables.Hierarchy=#arguments.passhierarcy#>
			
		<cfquery datasource="#arguments.DSN#" name="Insert_Nav">
			INSERT INTO #arguments.Table_Name#
				(#arguments.Site_ID_Name#,
				Nav_Type_ID,
				Nav_Name,
				Nav_Alt,
				Nav_Behaviour_ID,
				Hierarchy)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Nav_Type_ID#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1" maxlength="2">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="2">)
		</cfquery>
		
	</cffunction>

	<cffunction name="add_sub" description="gets current nav listing" output="Yes" access="public">	

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="Parent_Nav_ID" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="passhierarcy" default="1">

		<cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		max(Hierarchy) as max_h
			FROM		#arguments.Table_Name#
			WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Nav_Type_ID#" maxlength="6">
			AND			Parent_Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Parent_Nav_ID#" maxlength="6">
		</cfquery>
			
		<cfif len(trim(Get_H.max_h)) eq 0>
			<cfset variables.Hierarchy=1>
		<cfelse>
			<cfset variables.Hierarchy=Get_H.max_h+1>
		</cfif>
			
		<cfquery datasource="#arguments.DSN#" name="Insert_Sub">
			INSERT INTO #arguments.Table_Name#
				(#arguments.Site_ID_Name#,
				Nav_Type_ID,
				Parent_Nav_ID,
				Nav_Name,
				Nav_Alt,
				Nav_Behaviour_ID,
				Hierarchy)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="2" maxlength="1">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Parent_Nav_ID#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1" maxlength="2">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="2">)
		</cfquery>
		
	</cffunction>

	<cffunction name="edit_nav" description="detailed edit of a nav element" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" required="true">
		<cfargument name="Site_ID_Name" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Template_ID" default="">
		<cfargument name="Store" default="">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="image_mode" default="off">
		<cfargument name="image_only" default="off">
		<cfargument name="passhierarcy" default="1">

		<cfquery datasource="#arguments.DSN#" name="Get_Behaviours">
			SELECT		Nav_Behaviour_ID,
						Nav_Desc
			FROM		Nav_Behaviours
			ORDER BY 	Nav_Behaviour_ID
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Dealer_Details">
			SELECT		Display_Name,
						Address_1,
						Address_2,
						City,
						State,
						Zip
			FROM		Ultra10.dbo.Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Phones">
			SELECT		Phone_ID,
						Phone_Label,
						Area_Code,
						Prefix,
						Line_Number
			FROM		Ultra10.dbo.Dealer_Phones
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			ORDER BY 	Hierarchy
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Colors">
			SELECT     	CSS_Color_ID,
						Color_Name,
						Hex_Code,
						Short_Hand
			FROM		Ultra10.dbo.CSS_Colors
			ORDER BY	Hex_Code	
		</cfquery>

		<cfset Get_Nav=arguments.Get_Nav>

		<!--- Display_Mode, ---> 
		<form class="form-horizontal" action="#arguments.form_action#?page_action=update_nav&Nav_Type_ID=#arguments.Nav_Type_ID#&dealer_id=#url.dealer_id#" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<input type="hidden" name="Nav_ID" value="#Get_Nav.Nav_ID#"/>
			<table>
				<tr>
					<td>Name</td>
					<td><input type="text" name="Nav_Name" value="#Get_Nav.Nav_Name#" size="50" maxlength="100"/></td>
				</tr>
				<tr>
					<td>Alt/Title</td>
					<td><input type="text" name="Nav_Alt" value="#Get_Nav.Nav_Alt#" size="50" maxlength="100"/></td>
				</tr>
				<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
					<cfdefaultcase>
						<tr>
							<td>Link</td>
							<td><input type="text" name="Nav_Link" value="#Get_Nav.Nav_Link#" size="120" maxlength="500"/></td>
						</tr>
						<tr>
							<td>Mobile Link</td>
							<td><input type="text" name="Nav_Mobile_Link" value="#Get_Nav.Nav_Mobile_Link#" size="120" maxlength="500"/></td>
						</tr>
						<input type="hidden" name="Phone_ID" value=""/>
					</cfdefaultcase>
					<cfcase value="10,11">
						<td>
							Address
						</td>
						<td>
							#left(Get_Dealer_Details.Address_1,30)# ...
						</td>
						<input type="hidden" name="Phone_ID" value=""/>
						<input type="hidden" name="Nav_Link" value=""/>
						<input type="hidden" name="Nav_Mobile_Link" value=""/>
					</cfcase>
					<cfcase value="6">
						<td>
							Phone
						</td>
						<td>
							<select name="Phone_ID">
								<option value="">Select Phone</option>
								<cfloop query="Get_Phones">
									<option value="#Get_Phones.Phone_ID#" <cfif Get_Nav.Phone_ID eq Get_Phones.Phone_ID>Selected</cfif>>#Get_Phones.Phone_Label# - (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</option>									
								</cfloop>
							</select>
						</td>
						<input type="hidden" name="Nav_Link" value=""/>
						<input type="hidden" name="Nav_Mobile_Link" value=""/>
					</cfcase>
					<cfcase value="17">
						<tr>
							<td>Iframe Embed</td>
							<td><input type="text" name="Nav_Link" value="#Get_Nav.Nav_Link#" maxlength="500"/></td>
						</tr>
						<tr>
							<td>Iframe Width</td>
							<td><input type="text" name="Width" value="#Get_Nav.Width#" maxlength="4"/></td>
						</tr>
						<tr>
							<td>Iframe Height</td>
							<td><input type="text" name="Height" value="#Get_Nav.Height#" maxlength="4"/></td>
						</tr>
						<input type="hidden" name="Phone_ID" value=""/>
						<input type="hidden" name="Nav_Mobile_Link" value=""/>
					</cfcase>
				</cfswitch>
				<tr>
					<td>Link Behaviour</td>
					<td>
						<select name="Nav_Behaviour_ID">
							<cfloop query="Get_Behaviours">
								<option value="#Get_Behaviours.Nav_Behaviour_ID#" <cfif Get_Behaviours.Nav_Behaviour_ID eq Get_Nav.Nav_Behaviour_ID>selected="selected"</cfif> >#Get_Behaviours.Nav_Desc#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<cfif #Get_Nav.nav_type_id# EQ 58 or #Get_Nav.nav_type_id# EQ 59 or #Get_Nav.nav_type_id# EQ 60 or #Get_Nav.nav_type_id# EQ 68 >
					<tr>
						<td>Page Number</td>
							<td><input type="text" name="var_page_nbr" value="#Get_Nav.var_page_nbr#" size="5" maxlength="5"/>
								<span style="color:red;font-size:8pt"><b>Variable Template ONLY</b></span></td>
					</tr>
				<cfelse>
					<input type="hidden" name="var_page_nbr" value="#Get_Nav.var_page_nbr#"/>
				</cfif>
                <cfif Get_Nav.nav_type_id EQ 52>
					<tr>
						<td>Display Page</td>
							<td><select name="displayPage">
								<option value="1" <cfif Get_Nav.displayPage eq "1">selected="selected"</cfif>>SRP</option>
								<option value="2" <cfif Get_Nav.displayPage eq "2">selected="selected"</cfif>>VDP</option>
								<option value="3" <cfif Get_Nav.displayPage eq "3">selected="selected"</cfif>>Both SRP and VDP</option>
								<option value="4" <cfif Get_Nav.displayPage eq "4">selected="selected"</cfif>>None</option>
							</select></td>
					</tr>
				<cfelse>
					<input type="hidden" name="displayPage" value="4"/>
				</cfif>
				<cfif arguments.image_only eq "off">
					  <tr>
						<td valign="top">Code Snippet</td>
						<td>
							<cfif #arguments.Nav_Type_ID# EQ 68 ><span style="color:red;font-weight:bold">Max Width= 324 Max Height=224</span><br></cfif>
							<textarea name="Snippet" cols="100" rows="10">#trim(Get_Nav.Snippet)#</textarea>
						</td>
					</tr> 
					<tr>
						<td valign="top">Pull</td>
						<td>
							<select name="Pull">
								<option value="">none</option>
								<option value="left" <cfif Get_Nav.Pull eq "left">selected="selected"</cfif>>left</option>
								<option value="right" <cfif Get_Nav.Pull eq "right">selected="selected"</cfif>>right</option>
								<option value="clear" <cfif Get_Nav.Pull eq "clear">selected="selected"</cfif>>clear</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Text Color</td>
						<td>
							<select name="Text_Color">
								<option value="">default</option>
								<cfloop query="Get_Colors">
									<option value="#Get_Colors.Hex_Code#" <cfif Get_Colors.Hex_Code eq Get_Nav.Text_Color>selected</cfif>>#Get_Colors.Hex_Code# <cfif Get_Colors.Color_Name neq Get_Colors.Hex_Code>- #Get_Colors.Color_Name#</cfif></option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Font Weight</td>
						<td>
							<select name="Font_Weight">
								<option value="">default</option>
								<option value="normal" <cfif Get_Nav.Font_Weight eq "normal">selected="selected"</cfif>>normal</option>
								<option value="bold" <cfif Get_Nav.Font_Weight eq "bold">selected="selected"</cfif>>bold</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Font Size</td>
						<td>
							<select name="Font_Size">
								<option value="">default</option>
								<cfloop from="8" to="100" index="i">
									<option value="#i#" <cfif Get_Nav.Font_Size eq "#i#">selected="selected"</cfif>>#i#px</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Margin Top</td>
						<td>
							<select name="Margin_Top">
								<option value="">none</option>
								<cfloop from="1" to="200" index="i">
									<option value="#i#" <cfif Get_Nav.Margin_Top eq "#i#">selected="selected"</cfif>>#i#px</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Margin Bottom</td>
						<td>
							<select name="Margin_Bottom">
								<option value="">none</option>
								<cfloop from="1" to="200" index="i">
									<option value="#i#" <cfif Get_Nav.Margin_Bottom eq "#i#">selected="selected"</cfif>>#i#px</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Margin Left</td>
						<td>
							<select name="Margin_Left">
								<option value="">none</option>
								<cfloop from="1" to="200" index="i">
									<option value="#i#" <cfif Get_Nav.Margin_Left eq "#i#">selected="selected"</cfif>>#i#px</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top">Margin Right</td>
						<td>
							<select name="Margin_Right">
								<option value="">none</option>
								<cfloop from="1" to="200" index="i">
									<option value="#i#" <cfif Get_Nav.Margin_Right eq "#i#">selected="selected"</cfif>>#i#px</option>
								</cfloop>
							</select>
						</td>
					</tr>
				</cfif>
				<cfif 	arguments.image_mode eq "on" and 
						Get_Nav.Nav_Behaviour_ID neq 6 and 
						Get_Nav.Nav_Behaviour_ID neq 10 and 
						Get_Nav.Nav_Behaviour_ID neq 11>
					<tr>
						<td>Image</td>
						<td><input  type="File" name="Nav_Image" value="#Get_Nav.Nav_Image#" size="40" maxlength="100"/></td>
					</tr>
					<tr>
						<td>Image File:</td>
						<td>
							<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
								<a href="http://#cgi.server_name#/sites/#arguments.Template_ID#/images/#arguments.Store#/#Get_Nav.Nav_Image#" target="_blank">#Get_Nav.Nav_Image#</a> - 
								<a href="#arguments.form_action#?page_action=delete_img&Nav_ID=#Get_Nav.Nav_ID#&Site_ID=#arguments.Site_ID#&Nav_Type_ID=#arguments.Nav_Type_ID#">delete</a>
							<cfelse>
								no image uploaded
							</cfif>
						</td>
					</tr>
					 <tr>
						<td>3rd Party Image:</td>
						<td>
							<input type="text" name="Nav_Image_Code" value="#Get_Nav.Nav_Image_Code#" size="80" maxlength="200"/>
						</td>
					</tr>  

					<cfif len(trim(Get_Nav.Nav_Image)) gt 0>
						<tr>
							<td>Rollover</td>
							<td><input type="File" name="Nav_Rollover" value="#Get_Nav.Nav_Rollover#" size="80" maxlength="100"/></td>
						</tr>
						<tr>
							<td>Rollover File :</td>
							<td>
								<cfif len(trim(Get_Nav.Nav_Rollover)) gt 0>
									<a href="http://#cgi.server_name#/sites/#arguments.Template_ID#/images/#arguments.Store#/#Get_Nav.Nav_Rollover#" target="_blank">#Get_Nav.Nav_Rollover#</a> - 
									<a href="#arguments.form_action#?page_action=delete_roll&Nav_ID=#Get_Nav.Nav_ID#&Site_ID=#arguments.Site_ID#&Nav_Type_ID=#arguments.Nav_Type_ID#">delete</a>
								<cfelse>
									no image uploaded
								</cfif>
							</td>
						</tr>
					</cfif>
				</cfif>
				<tr>
					<td valign="top">Align</td>
					<td>
						<select name="Align">
							<option value="">default</option>
							<option value="left" <cfif Get_Nav.Align eq "left">selected="selected"</cfif>>left</option>
							<option value="center" <cfif Get_Nav.Align eq "center">selected="selected"</cfif>>center</option>
							<option value="right" <cfif Get_Nav.Align eq "right">selected="selected"</cfif>>right</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Start Date</td>
					<td><input type="text" name="Start_Date" value="#dateformat(Get_Nav.Start_Date,'mm/dd/yyyy')#" maxlength="10"/></td>
				</tr>
				<tr>
					<td>End Date</td>
					<td>
						<cfif dateformat(Get_Nav.End_Date,"mm/dd/yyyy") eq "12/31/2100">
							<input type="text" name="End_Date" value="" maxlength="10"/>
						<cfelse>
							<input type="text" name="End_Date" value="#dateformat(Get_Nav.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
						</cfif>
					</td>
				</tr>
				<cfif Get_Nav.Nav_Type_ID eq "52">
					<cfquery datasource="Ultra10" name="Get_Dealer_Pages">
						SELECT		page_name,
									script_name,
									Dealer_Wordpress_ID,
									Chrome_Model_ID
						FROM		Dealer_Pages
						WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
						AND			script_name not like '/blog/%'
						AND			script_name not like '/showroom/%'
						ORDER BY 	page_name
					</cfquery>
					<tr>
						<td>Page</td>
						<td>
							<select name="Script_Name">
								<option value="">none</option>
								<cfloop query="Get_Dealer_Pages">
									<option value="#Get_Dealer_Pages.Script_Name#" <cfif Get_Nav.script_name eq Get_Dealer_Pages.Script_Name>selected="selected"</cfif>>#Get_Dealer_Pages.page_name#</option>
								</cfloop>
							</select>						
						</td>
					</tr>
				</cfif>
				<tr>
					<td align="center">
						<cfif Get_Nav.Parent_Nav_ID eq 0>
							<input class="Tabbutton" type="button" value="Go Back" onclick="location.href='#arguments.form_action#?#arguments.Site_ID_Name#=#arguments.Site_ID#&Nav_Type_ID=#arguments.Nav_Type_ID#'"/>
						<cfelse>
							<input class="Tabbutton" type="button" value="Go Back" onclick="location.href='#arguments.form_action#?page_action=edit_sub&site_id=#arguments.site_id#&Nav_Type_ID=2&Parent_Nav_ID=#Get_Nav.Parent_Nav_ID#'"/>
						</cfif>	
					</td>
					<td>
						<input class="Tabbutton" type="submit" value="Update Nav"/>
					</td>
				</tr>
			</table>
		</form>
	
	</cffunction>

	<cffunction name="update_nav" description="detailed edit of a nav element" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="Save_Directory" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="image_only" default="off">
		<cfargument name="passhierarcy" default="1">
		
		<cfparam name="form.Nav_Image" default="">
		<cfparam name="form.Nav_Rollover" default="">
		<cfparam name="form.Snippet" default="">
		<cfparam name="form.Pull" default="">
		<cfparam name="form.Align" default="">
		<cfparam name="form.Text_Color" default="">
		<cfparam name="form.Font_Weight" default="">
		<cfparam name="form.Margin_Left" default="">
		<cfparam name="form.Margin_Right" default="">
		<cfparam name="form.Margin_Top" default="">
		<cfparam name="form.Margin_Bottom" default="">
		<cfparam name="form.Width" default="">
		<cfparam name="form.Height" default="">
		<cfparam name="form.Script_Name" default="">
		<cfparam name="form.Nav_Image_Code" default="">
		<cfparam name="form.Robot_Food" default="false">
		<cfparam name="form.var_page_nbr" default="0">
		<cfparam name="form.displayPage" default="4">

		<cfif len(trim(form.Nav_Image)) gt 0>
			<cftry>
				<cffile action="upload" filefield="Nav_Image" destination="#arguments.Save_Directory#" nameconflict="makeunique">
				<cfset variables.img_file=cffile.serverFile>
				<cfset variables.img_file_ext=right(cffile.serverFile,4)>
				<cfimage source="#arguments.Save_Directory#\#variables.img_file#" name="new_image">
				<cfset variables.img_file_width=ImageGetWidth(variables.new_image)>
				<cfset variables.img_file_height=ImageGetHeight(variables.new_image)>
				<cfcatch>
					<cfset form.Nav_Image="">
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfif len(trim(form.Nav_Image)) gt 0>
			<cfset variables.new_img_file=replace(variables.img_file,"_off","","all" )>
			<cfset variables.new_img_file=replace(variables.new_img_file,"#variables.img_file_ext#","","all" )>
			<cfset variables.new_img_file="#variables.new_img_file#_off#variables.img_file_ext#">
			<cftry>
				<cffile action="copy" source="#arguments.Save_Directory#\#variables.img_file#" destination="#arguments.Save_Directory#\#variables.new_img_file#">
				<cfcatch></cfcatch>
			</cftry>
		</cfif>

		<cfif len(trim(form.Nav_Rollover)) gt 0>
			<cftry>
				<cffile action="upload" filefield="Nav_Rollover" destination="#arguments.Save_Directory#" nameconflict="makeunique">
				<cfset variables.roll_file=cffile.serverFile>
				<cfcatch>
					<cfset form.Nav_Rollover="">
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfif len(trim(form.Nav_Rollover)) gt 0>
			<cfquery datasource="#arguments.DSN#" name="Get_Image_File">
				SELECT		Nav_Image
				FROM		#arguments.Table_Name#
				WHERE		Nav_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.Nav_ID#" maxlength="10">
			</cfquery>
			<cfset variables.roll_file_ext=right(Get_Image_File.Nav_Image,4)>
			<cfset variables.new_roll_file=replace(Get_Image_File.Nav_Image,"_off","","all" )>
			<cfset variables.new_roll_file=replace(variables.new_roll_file,"#variables.roll_file_ext#","","all" )>
			<cfset variables.new_roll_file="#variables.new_roll_file#_on#variables.roll_file_ext#">
		
			<cffile action="rename" source="#arguments.Save_Directory#\#variables.roll_file#" destination="#arguments.Save_Directory#\#variables.new_roll_file#">
		
		</cfif>

		<cfquery datasource="#arguments.DSN#" name="Update_Nav">
			UPDATE		#arguments.Table_Name#
			SET			Nav_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100">,
						Nav_Alt = <cfif len(trim(form.Nav_Alt)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Alt#" maxlength="100"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100"></cfif>,
						Nav_Link = <cfif len(trim(form.Nav_Link)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Link#" maxlength="500"><cfelse>NULL</cfif>,
						Nav_Mobile_Link = <cfif len(trim(form.Nav_Mobile_Link)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.Nav_Mobile_Link)#" maxlength="200"><cfelse>NULL</cfif>,
						var_page_nbr = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.var_page_nbr#" maxlength="6">,
							
						<cfif arguments.image_only eq "off">
							Snippet = <cfif len(trim(form.Snippet)) gt 0>'#trim(form.Snippet)#'<cfelse>NULL</cfif>,
							Pull = <cfif len(trim(form.Pull)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.Pull)#" maxlength="10"><cfelse>NULL</cfif>,
							Align = <cfif len(trim(form.Align)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.Align)#" maxlength="10"><cfelse>NULL</cfif>,
							Text_Color = <cfif len(trim(form.Text_Color)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.Text_Color)#" maxlength="10"><cfelse>NULL</cfif>,
							Font_Weight = <cfif len(trim(form.Font_Weight)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.Font_Weight)#" maxlength="10"><cfelse>NULL</cfif>,
							Font_Size = <cfif len(trim(form.Font_Size)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Font_Size)#" maxlength="10"><cfelse>NULL</cfif>,
							Margin_Left = <cfif len(trim(form.Margin_Left)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Margin_Left)#" maxlength="10"><cfelse>NULL</cfif>,
							Margin_Right = <cfif len(trim(form.Margin_Right)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Margin_Right)#" maxlength="10"><cfelse>NULL</cfif>,
							Margin_Top = <cfif len(trim(form.Margin_Top)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Margin_Top)#" maxlength="10"><cfelse>NULL</cfif>,
							Margin_Bottom = <cfif len(trim(form.Margin_Bottom)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Margin_Bottom)#" maxlength="10"><cfelse>NULL</cfif>,
						</cfif>
					<cfif IsDefined("form.Width") >
						Width = <cfif len(trim(form.Width)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Width)#" maxlength="10"><cfelse>NULL</cfif>,
						Height = <cfif len(trim(form.Height)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#lcase(form.Height)#" maxlength="10"><cfelse>NULL</cfif>,
					</cfif>
						Nav_Behaviour_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.Nav_Behaviour_ID#" maxlength="2">,
						Phone_ID = <cfif len(trim(form.Phone_ID)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#form.Phone_ID#" maxlength="10"><cfelse>NULL</cfif>,
						Start_Date = <cfif len(trim(form.Start_Date)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(form.Start_Date,'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
						End_Date = <cfif len(trim(form.End_Date)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(form.End_Date,'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>,
					
					<cfif IsDefined("form.Script_Name") >
						Script_Name = <cfif len(trim(form.Script_Name)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Script_Name#" maxlength="200"><cfelse>null</cfif>,
						Nav_Image_Code = <cfif len(trim(form.Nav_Image_Code)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Image_Code#" maxlength="200"><cfelse>null</cfif>
					</cfif>	
						<cfif len(trim(form.Nav_Image)) gt 0>
							,Nav_Image = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.new_img_file#" maxlength="100">
							,Nav_Rollover = NULL
						</cfif>
						<cfif len(trim(form.Nav_Rollover)) gt 0 and len(trim(form.Nav_Image)) eq 0>
							,Nav_Rollover = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.new_roll_file#" maxlength="100">
						</cfif>
                        <cfif arguments.Nav_Type_ID eq 52>
                        ,displayPage = #form.displayPage#
                        </cfif>
			WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.Nav_ID#" maxlength="10">
		</cfquery>
	
	</cffunction>

	<cffunction name="delete_img" description="delete image & rollover" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" default="true">
		<cfargument name="Save_Directory" required="true">
		<cfargument name="passhierarcy" default="1">
	
		<cfquery datasource="#arguments.DSN#" name="Get_Image_File">
			SELECT		Nav_Image,
						Nav_Rollover
			FROM		#arguments.Table_Name#
			WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_ID#" maxlength="10">
		</cfquery>

		<cfif len(trim(Get_Image_File.Nav_Image)) gt 0>
			<cffile action="delete" file="#arguments.Save_Directory#\#Get_Image_File.Nav_Image#">
		</cfif>

		<cfif len(trim(Get_Image_File.Nav_Rollover)) gt 0>
			<cffile action="delete" file="#arguments.Save_Directory#\#Get_Image_File.Nav_Rollover#">
		</cfif>

		<cfquery datasource="#arguments.DSN#" name="Clear_Image_File">
			UPDATE		#arguments.Table_Name#
			SET			Nav_Image = NULL,
						Nav_Rollover = NULL
			WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_ID#" maxlength="10">
		</cfquery>
		
	</cffunction>

	<cffunction name="delete_roll" description="delete rollover" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" default="true">
		<cfargument name="Save_Directory" required="true">
		<cfargument name="passhierarcy" default="1">
	
		<cfquery datasource="#arguments.DSN#" name="Get_Image_File">
			SELECT		Nav_Rollover
			FROM		#arguments.Table_Name#
			WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_ID#" maxlength="10">
		</cfquery>

		<cfif len(trim(Get_Image_File.Nav_Rollover)) gt 0>
			<cffile action="delete" file="#arguments.Save_Directory#\#Get_Image_File.Nav_Rollover#">
		</cfif>

		<cfquery datasource="#arguments.DSN#" name="Clear_Image_File">
			UPDATE		#arguments.Table_Name#
			SET			Nav_Rollover = NULL
			WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_ID#" maxlength="10">
		</cfquery>
		
	</cffunction>

	<cffunction name="legacy_dealer" description="gets legacy dealers" output="Yes" access="public">	

		<!--- arguments --->
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfargument name="passhierarcy" default="1">
		
		<cfquery datasource="Ultra8" name="Get_Dealers">
			SELECT DISTINCT		Nav_Custom.Dealercode,
								Dealers.Display_Name,
								Dealers.City,
								Dealers.State
			FROM         		Nav_Custom
			INNER JOIN			Dealers
			ON					Nav_Custom.Dealercode = Dealers.Dealercode
			WHERE				Nav_Custom.Nav_Type_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Nav_Type_ID#" maxlength="10">    
			ORDER BY 			Dealers.Display_Name
		</cfquery>
	
		<form class="form-horizontal" action="#arguments.form_action#?page_action=get_legacy_nav&#arguments.Site_ID_Name#=#arguments.Site_ID#&Nav_Type_ID=#url.Nav_Type_ID#" method="post">
			<select name="dealercode">
				<cfloop query="Get_Dealers">
					<option value="#Get_Dealers.Dealercode#">#Get_Dealers.Display_Name# - #Get_Dealers.City#, #Get_Dealers.State#</option>
				</cfloop>
			</select>
			<input class="Tabbutton" type="submit" value="Choose Slides"/>
		</form>		
	
	</cffunction>
	
	<cffunction name="get_legacy_nav" description="gets dealer legacy videos" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Site_ID" required="true">
		<cfargument name="Site_ID_Name" required="true">
		<cfargument name="Nav_Type_ID" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
	
		<cfquery datasource="Ultra8" name="Get_Legacy_Nav">
			SELECT		Nav_Custom_ID,
						Nav_Custom_Name,
						File_Path,
						Icon_Image,
						Hierarchy,
						Start_Date,
						End_Date
			FROM		Nav_Custom
			WHERE		Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Dealercode#" maxlength="30">
			AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Nav_Type_ID#" maxlength="10">
			AND			Nav_Custom_ID not in (Select Legacy_Nav_Custom_ID from Ultra10.dbo.Navigation where #arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4"> and Legacy_Nav_Custom_ID is not null)
			ORDER BY 	Hierarchy
		</cfquery>
		
		<form action="#arguments.form_action#?page_action=import_legacy&#arguments.Site_ID_Name#=#arguments.Site_ID#&Nav_Type_ID=#url.Nav_Type_ID#" method="post">
			<table>
				<tr>
					<td>Slide Name</td>
					<td>Start Date</td>
					<td>End Date</td>
					<td>Order</td>
					<td>Select</td>
				</tr>
				<cfloop query="Get_Legacy_Nav">
					<tr>
						<td>#Get_Legacy_Nav.Nav_Custom_Name#</td>
						<td>#dateformat(Get_Legacy_Nav.Start_Date,"mm/dd/yyyy")#</td>
						<td>#dateformat(Get_Legacy_Nav.End_Date,"mm/dd/yyyy")#</td>
						<td align="center">#Get_Legacy_Nav.Hierarchy#</td>
						<td align="center"><input name="Nav_Custom_ID" type="checkbox" value="#Get_Legacy_Nav.Nav_Custom_ID#"/></td>
					</tr>
				</cfloop>
			</table>
			<input class="Tabbutton" type="submit" value="Import Slides"/>
		</form>

	</cffunction>

	<cffunction name="import_legacy" description="gets dealer legacy videos" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Site_ID" required="true">
		<cfargument name="Site_ID_Name" required="true">
		<cfargument name="Save_Directory" default="images\icons">
		
		<cfif listlen(form.Nav_Custom_ID) gt 0>

			<cffile action="write" file="E:\transfers\import_img.bat" output="" addnewline="No">

			<cfloop list="#form.Nav_Custom_ID#" index="myid">

				<cfquery datasource="Ultra8" name="Get_Legacy_Nav">
					SELECT		Dealercode,
								Nav_Custom_ID,
								Nav_Custom_Name,
								Alt_Text,
								File_Path,
								Icon_Image,
								Icon_Rollover,
								Hierarchy,
								Start_Date,
								End_Date,
								Behavior_ID,
								Nav_Type_ID
					FROM		Nav_Custom
					WHERE		Nav_Custom_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.myid#" maxlength="10">
				</cfquery>
				<cfquery datasource="Ultra8" name="Get_Dealer">
					SELECT	File_Dir
					FROM	Dealers
					WHERE	Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Legacy_Nav.Dealercode#" maxlength="30">
				</cfquery>
				<cfquery datasource="Ultra10" name="Get_New_Dealer">
					SELECT	Dealer_Directory
					FROM	Dealers
					WHERE	#arguments.Site_ID_Name#=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
				</cfquery>

				<cfif len(trim(Get_Legacy_Nav.Icon_Image)) gt 0>
					<cffile action="append" file="E:\transfers\import_img.bat" output="copy \\WDWEB4\inetpub\wwwroot\Ultra9\dealer\#Get_Dealer.File_Dir#\#arguments.Save_Directory#\#Get_Legacy_Nav.Icon_Image# E:\inetpub\wwwroot\Ultra10\dealer\#Get_New_Dealer.Dealer_Directory#\#arguments.Save_Directory# /Y" addnewline="Yes">
				</cfif>

				<cfif len(trim(Get_Legacy_Nav.Icon_Rollover)) gt 0>
					<cffile action="append" file="E:\transfers\import_img.bat" output="copy \\WDWEB4\inetpub\wwwroot\Ultra9\dealer\#Get_Dealer.File_Dir#\#arguments.Save_Directory#\#Get_Legacy_Nav.Icon_Rollover# E:\inetpub\wwwroot\Ultra10\dealer\#Get_New_Dealer.Dealer_Directory#\#arguments.Save_Directory# /Y" addnewline="Yes">
				</cfif>

				<cfquery datasource="Ultra10" name="Get_H">
					SELECT		max(Hierarchy) as max_h
					FROM		#arguments.Table_Name#
					WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4">
					AND			Nav_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_Type_ID#" maxlength="10">
				</cfquery>

				<cfif len(trim(Get_H.max_h)) eq 0>
					<cfset variables.Hierarchy=1>
				<cfelse>
					<cfset variables.Hierarchy=Get_H.max_h+1>
				</cfif>

				<cfquery datasource="Ultra10" name="Insert_Nav">
					INSERT INTO #arguments.Table_Name#
						(#arguments.Site_ID_Name#,
						Nav_Type_ID,
						Nav_Name,
						Nav_Alt,
						Hierarchy,
						Nav_Image,
						Nav_Rollover,
						Nav_Link,
						Start_Date,
						End_Date,
						Nav_Behaviour_ID,
						Legacy_Nav_Custom_ID)
					VALUES
						(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="10">,
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_Type_ID#" maxlength="10">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Nav_Custom_Name#" maxlength="100">,
						<cfif Get_Legacy_Nav.Nav_Type_ID eq 86>
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Alt_Text#" maxlength="100">,
						<cfelse>
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Nav_Custom_Name#" maxlength="100">,
						</cfif>
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="4">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Icon_Image#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Icon_Rollover#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.File_Path#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Start_Date#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.End_Date#">,
						<cfif Get_Legacy_Nav.Nav_Type_ID eq 86>
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1" maxlength="1">,
						<cfelse>
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Legacy_Nav.Behavior_ID#" maxlength="10">,
						</cfif>

						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.myid#">)
				</cfquery>
				
				<li>#variables.myid#</li>
	
			</cfloop>

			<cfset variables.sArg = "/U Worlddealer\administrator /P op71mu5Pr1m3!">
			<cftry>
				<cfexecute name = "E:\transfers\import_img.bat" timeout = "60" arguments="#variables.sArg#"></cfexecute>
				<cfcatch>
					<cfset variables.file_error=1>
					<li>File Copy Timed Out</li>
				</cfcatch>
			</cftry>
	
		</cfif>

	</cffunction>
	
	
</cfcomponent>
