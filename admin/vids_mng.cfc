<cfcomponent>

	<cffunction name="get_vids" description="gets current video listing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="Table_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Get_Videos">
			SELECT		Dealer_Video_ID,
						Dealer_ID,
						Video_Name,
						Thumbnail,
						FLV_URL,
						HTML5_URL,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		#arguments.Table_Name#
			WHERE		#arguments.Site_ID_Name#=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			ORDER BY 	Hierarchy
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Address_1,
						Address_2,
						City,
						State,
						Zip
			FROM		Dealers
			WHERE		#arguments.Site_ID_Name#=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<form class="form-horizontal" action="#arguments.form_action#?page_action=bulk_update&#arguments.Site_ID_Name#=#arguments.Site_ID#" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<table style="font:normal 12px arial;" cellpadding="3" cellspacing="0">
				<tr>
					<td>
						<b>Video Name</b>
					</td>
					<td>
						<b>Thumbnail</b>
					</td>
					<td>
						<b>FLV URL (case sensative)</b>
					</td>
					<td>
						<b>HTML5 URL (case sensative)</b>
					</td>
					<td>
						<b>Start Date</b>
					</td>
					<td>
						<b>End Date</b>
					</td>
					<td>
						<b>Hierarchy</b>
					</td>
					<td align="center">
						<b>Delete</b>
					</td>
				</tr>
				<cfloop query="Get_Videos">
					<input type="hidden" name="Dealer_Video_ID" value="#Get_Videos.Dealer_Video_ID#"/>
					<tr <cfif Get_Videos.currentRow mod 2 eq 0>style="background-color:##eeeeee"</cfif>>
						<td>
							<input type="text" name="Vid_Name_#Get_Videos.Dealer_Video_ID#" value="#Get_Videos.Video_Name#" maxlength="100"/>
						</td>
						<td>
							<input type="file" name="Vid_TN_#Get_Videos.Dealer_Video_ID#"/>
						</td>
						<td>
							<input type="text" name="Vid_FLV_#Get_Videos.Dealer_Video_ID#" value="#Get_Videos.FLV_URL#" maxlength="200"/>
						</td>
						<td>
							<input type="text" name="Vid_HTML5_#Get_Videos.Dealer_Video_ID#" value="#Get_Videos.HTML5_URL#" maxlength="200"/>
						</td>
						<td>
							<input type="text" name="Start_Date_#Get_Videos.Dealer_Video_ID#" value="#dateformat(Get_Videos.Start_Date,'mm/dd/yyyy')#" maxlength="10"/>
						</td>
						<td>
							<cfif dateformat(Get_Videos.End_Date,"mm/dd/yyyy") eq "12/31/2100">
								<input type="text" name="End_Date_#Get_Videos.Dealer_Video_ID#" value="" maxlength="10"/>
							<cfelse>
								<input type="text" name="End_Date_#Get_Videos.Dealer_Video_ID#" value="#dateformat(Get_Videos.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
							</cfif>
						</td>
						<td>
							<input type="text" name="Hierarchy_#Get_Videos.Dealer_Video_ID#" value="#Get_Videos.Hierarchy#" maxlength="3"/>
						</td>
						<td align="center">
							<input type="checkbox" name="Vid_Delete" value="#Get_Videos.Dealer_Video_ID#"/>
						</td>
					</tr>
					<tr <cfif Get_Videos.currentRow mod 2 eq 0>style="background-color:##eeeeee"</cfif>>
						<td>&nbsp;</td>
						<td valign="top">
							current : <cfif len(trim(Get_Videos.Thumbnail)) gt 0>#Get_Videos.Thumbnail#<cfelse><span class="color:red">No image uploaded</span></cfif>
						</td>
						<td valign="top" colspan="6">
							current flv: <cfif len(trim(Get_Videos.FLV_URL)) gt 0>#Get_Videos.FLV_URL#<cfelse><span style="color:red">No flv uploaded</span></cfif><br/>
							current html5: <cfif len(trim(Get_Videos.HTML5_URL)) gt 0>#Get_Videos.HTML5_URL#<cfelse><span style="color:red">No HTML5 file uploaded</span></cfif><br/>
						</td>

					</tr>
				</cfloop>
				<tr>
					<td><input type="submit" value="Update Videos"/></td>
				</tr>
			</table>
		</form>
		<form class="form-horizontal" action="#arguments.form_action#?page_action=add_nav" method="post">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<input type="text" name="Video_Name" maxlength="100"/>
			<input type="submit" value="Add Video"/>
		</form>

<cfif #Get_Dealer_Details.dealer_id# neq 65 and #Get_Dealer_Details.dealer_id# neq 68 >
		<input type="button" value="Import Videos from Legacy" onclick="location.href='#arguments.form_action#?page_action=legacy_dealer&#arguments.Site_ID_Name#=#arguments.Site_ID#'"/>
</cfif>	
	</cffunction>

	<cffunction name="legacy_dealer" description="gets legacy dealers" output="Yes" access="public">	

		<!--- arguments --->
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		
		<cfquery datasource="Ultra8" name="Get_Dealers">
			SELECT DISTINCT		Nav_Custom.Dealercode,
								Dealers.Display_Name,
								Dealers.City,
								Dealers.State
			FROM         		Nav_Custom
			INNER JOIN			Dealers
			ON					Nav_Custom.Dealercode = Dealers.Dealercode
			WHERE				Nav_Custom.Nav_Type_ID = 15
			ORDER BY 			Dealers.Display_Name
		</cfquery>
	
		<form class="form-horizontal" action="#arguments.form_action#?page_action=get_legacy_nav&#arguments.Site_ID_Name#=#arguments.Site_ID#" method="post">
			<select name="dealercode">
				<cfloop query="Get_Dealers">
					<option value="#Get_Dealers.Dealercode#">#Get_Dealers.Display_Name# - #Get_Dealers.City#, #Get_Dealers.State#</option>
				</cfloop>
			</select>
			<input type="submit" value="Choose Videos"/>
		</form>		
	
	</cffunction>

	<cffunction name="get_legacy_nav" description="gets dealer legacy videos" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
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
			AND			Nav_Type_ID = 15
			AND			Nav_Custom_ID not in (Select Legacy_Nav_Custom_ID from Ultra10.dbo.Dealer_Videos where #arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4">)
			ORDER BY 	Hierarchy
		</cfquery>
		
		<form action="#arguments.form_action#?page_action=import_legacy&#arguments.Site_ID_Name#=#arguments.Site_ID#" method="post">
			<table>
				<tr>
					<td>Video Name</td>
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
			<input type="submit" value="Import Videos"/>
		</form>
	</cffunction>

	<cffunction name="import_legacy" description="gets dealer legacy videos" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		
		<cfif listlen(form.Nav_Custom_ID) gt 0>

			<cfloop list="#form.Nav_Custom_ID#" index="myid">

				<cfquery datasource="Ultra8" name="Get_Legacy_Nav">
					SELECT		Dealercode,
								Nav_Custom_ID,
								Nav_Custom_Name,
								File_Path,
								Icon_Image,
								Hierarchy,
								Start_Date,
								End_Date
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
					<cftry>
						<cfhttp method="get" url="http://static.wdautos.com/dealer/#Get_Dealer.File_Dir#/videos/thumbs/#Get_Legacy_Nav.Icon_Image#" path="E:\inetpub\wwwroot\Ultra10\dealer\#Get_New_Dealer.Dealer_Directory#\videos" file="#Get_Legacy_Nav.Icon_Image#" timeout="60"></cfhttp>
						<cfcatch></cfcatch>
					</cftry>
				</cfif>

				<cfquery datasource="Ultra10" name="Get_H">
					SELECT		max(Hierarchy) as max_h
					FROM		#arguments.Table_Name#
					WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4">
				</cfquery>

				<cfif len(trim(Get_H.max_h)) eq 0>
					<cfset variables.Hierarchy=1>
				<cfelse>
					<cfset variables.Hierarchy=Get_H.max_h+1>
				</cfif>

				<cfquery datasource="Ultra10" name="Insert_Nav">
					INSERT INTO #arguments.Table_Name#
						(#arguments.Site_ID_Name#,
						Video_Name,
						Hierarchy,
						Thumbnail,
						FLV_URL,
						Start_Date,
						End_Date,
						Legacy_Nav_Custom_ID)
					VALUES
						(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="10">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Nav_Custom_Name#" maxlength="100">,
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="4">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Icon_Image#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.File_Path#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.Start_Date#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Get_Legacy_Nav.End_Date#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.myid#">)
				</cfquery>
				
				<li>#variables.myid#</li>
	
			</cfloop>
	
		</cfif>

	</cffunction>
		
	<cffunction name="add_nav" description="gets current nav listing" output="Yes" access="public">	

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		max(Hierarchy) as max_h
			FROM		#arguments.Table_Name#
			WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="4">
		</cfquery>
			
		<cfif len(trim(Get_H.max_h)) eq 0>
			<cfset variables.Hierarchy=1>
		<cfelse>
			<cfset variables.Hierarchy=Get_H.max_h+1>
		</cfif>
			
		<cfquery datasource="#arguments.DSN#" name="Insert_Nav">
			INSERT INTO #arguments.Table_Name#
				(#arguments.Site_ID_Name#,
				Video_Name,
				Hierarchy)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="10">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Video_Name#" maxlength="100">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Hierarchy#" maxlength="4">)
		</cfquery>
		
	</cffunction>
	
	<cffunction name="bulk_update" description="updates current video listing" output="Yes" access="public">
	
		<cfargument name="Save_Directory" required="true">
		<cfparam name="form.Vid_Delete" default="">
	
		<cfloop list="#form.Dealer_Video_ID#" index="vid">

			<cfset variables.Vid_Name="form.Vid_Name_#variables.vid#">
			<cfset variables.Vid_TN="form.Vid_TN_#variables.vid#">
			<cfset variables.Vid_FLV="form.Vid_FLV_#variables.vid#">
			<cfset variables.Vid_HTML5="form.Vid_HTML5_#variables.vid#">
			<cfset variables.Start_Date="form.Start_Date_#variables.vid#">
			<cfset variables.End_Date="form.End_Date_#variables.vid#">
			<cfset variables.Hierarchy="form.Hierarchy_#variables.vid#">
			<cfset variables.img_file="">

			<cfif len(trim(evaluate(variables.Vid_TN))) gt 0>
				<cftry>
					<cffile action="upload" filefield="#variables.Vid_TN#" destination="#arguments.Save_Directory#" nameconflict="makeunique">
					<cfset variables.img_file=cffile.serverFile>
					<cfimage source="#arguments.Save_Directory#\#variables.img_file#" name="new_image">
					<cfcatch>
						<cfset variables.img_file="">
					</cfcatch>
				</cftry>
			</cfif>

			<cfif len(trim(evaluate(variables.Vid_Name))) gt 0>
				<cfquery datasource="#arguments.DSN#" name="Update_Nav">
					UPDATE		#arguments.Table_Name#
					SET			Video_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Vid_Name)#" maxlength="100">,
								FLV_URL = <cfif len(trim(evaluate(variables.Vid_FLV))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Vid_FLV)#" maxlength="200"><cfelse>NULL</cfif>,
								HTML5_URL = <cfif len(trim(evaluate(variables.Vid_HTML5))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Vid_HTML5)#" maxlength="200"><cfelse>NULL</cfif>,
								Start_Date = <cfif len(trim(evaluate(variables.Start_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.Start_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
								End_Date = <cfif len(trim(evaluate(variables.End_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.End_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>,
								<cfif len(trim(variables.img_file)) gt 0>
									Thumbnail = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.img_file#" maxlength="200">,
								</cfif>
								Hierarchy = <cfif len(trim(evaluate(variables.Hierarchy))) gt 0><cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#evaluate(variables.Hierarchy)#" maxlength="2"><cfelse>0</cfif>
					WHERE		Dealer_Video_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.vid#" maxlength="6">
				</cfquery>
			</cfif>

		</cfloop>
		
		<cfloop list="#form.Vid_Delete#" index="did">

			<cfquery datasource="#arguments.DSN#" name="Delete_Vid">
				DELETE FROM	#arguments.Table_Name#
				WHERE		Dealer_Video_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.did#" maxlength="4">
			</cfquery>
		
		</cfloop>
		
		<cfquery datasource="#arguments.DSN#" name="Get_H">
			SELECT		Dealer_Video_ID,
						Hierarchy
			FROM		#arguments.Table_Name#
			WHERE		#arguments.Site_ID_Name#=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">
			ORDER BY 	Hierarchy
		</cfquery>
		
		<cfloop query="Get_H">

			<cfquery datasource="#arguments.DSN#" name="Update_H">
				UPDATE		#arguments.Table_Name#
				SET			Hierarchy = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#Get_H.Currentrow#" maxlength="2">
				WHERE		Dealer_Video_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_H.Dealer_Video_ID#" maxlength="6">
			</cfquery>
		
		</cfloop>
		
	</cffunction>
	
</cfcomponent>