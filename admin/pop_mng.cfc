<cfcomponent>

	<cffunction name="get_pops" description="gets current video listing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="Table_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Get_Popups">
			SELECT		Dealer_Popup_ID,
						Popup_Name,
						Popup_Type,
						Start_Date,
						End_Date
			FROM		#arguments.Table_Name#
			WHERE		#arguments.Site_ID_Name# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Site_ID#" maxlength="6">
		</cfquery>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=bulk_update&#arguments.Site_ID_Name#=#arguments.Site_ID#" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<table style="font:normal 12px arial;" cellpadding="3" cellspacing="0">
				<tr>
					<td>
						<b>Popup Name</b>
					</td>
					<td>
						<b>Start Date</b>
					</td>
					<td>
						<b>End Date</b>
					</td>
					<td align="center">
						<b>Edit</b>
					</td>
					<td align="center">
						<b>Delete</b>
					</td>
				</tr>
				<cfloop query="Get_Popups">
					<input type="hidden" name="Dealer_Popup_ID" value="#Get_Popups.Dealer_Popup_ID#"/>
					<tr <cfif Get_Popups.currentRow mod 2 eq 0>style="background-color:##eeeeee"</cfif>>
						<td>
							<input type="text" name="Pop_Name_#Get_Popups.Dealer_Popup_ID#" value="#Get_Popups.Popup_Name#" maxlength="100"/>
						</td>
						<td>
							<input type="text" name="Start_Date_#Get_Popups.Dealer_Popup_ID#" value="#dateformat(Get_Popups.Start_Date,'mm/dd/yyyy')#" maxlength="10"/>
						</td>
						<td>
							<cfif dateformat(Get_Popups.End_Date,"mm/dd/yyyy") eq "12/31/2100">
								<input type="text" name="End_Date_#Get_Popups.Dealer_Popup_ID#" value="" maxlength="10"/>
							<cfelse>
								<input type="text" name="End_Date_#Get_Popups.Dealer_Popup_ID#" value="#dateformat(Get_Popups.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
							</cfif>
						</td>
						<td align="center">
							<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_pop&Dealer_Popup_ID=#Get_Popups.Dealer_Popup_ID#&#arguments.Site_ID_Name#=#arguments.Site_ID#">Edit</a>
						</td>
						<td align="center">
							<input type="checkbox" name="Pop_Delete" value="#Get_Popups.Dealer_Popup_ID#"/>
						</td>
					</tr>
				</cfloop>
				<tr>
					<td><input type="submit" value="Update Popups"/></td>
				</tr>
			</table>
		</form>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=add_pop" method="post">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<input type="text" name="Popup_Name" maxlength="100"/>
			<input type="submit" value="Add Popup"/>
		</form>
	
	</cffunction>

	<cffunction name="edit_pop" description="Adds a new listing" output="Yes" access="public">
	
		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Dealer_Popup_ID" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Get_Behaviours">
			SELECT		Nav_Behaviour_ID,
						Nav_Desc
			FROM		Nav_Behaviours
			WHERE		Nav_Behaviour_ID < 4
			ORDER BY 	Nav_Behaviour_ID
		</cfquery>

		<cfquery datasource="#arguments.DSN#" name="Get_Pop">
			SELECT		Dealer_Popup_ID,
						Dealer_ID,
						Popup_Name,
						Popup_Type,
						Nav_Image,
						BG_Color,
						Font_Color,
						Nav_Link,
						Nav_Behaviour_ID,
						Script_Name,
						YouTube_Video_Link,
						Start_Date,
						End_Date,
						Disclaimer
			FROM		Dealer_Popups
			WHERE		Dealer_Popup_ID = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#arguments.Dealer_Popup_ID#" maxlength="6">
		</cfquery>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=update_pop&Dealer_Popup_ID=#arguments.Dealer_Popup_ID#" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<input type="hidden" name="Dealer_Popup_ID" value="#arguments.Dealer_Popup_ID#"/>
			<table cellpadding="4" cellspacing="4">
				<tr>
					<td>Name</td>
					<td><input type="text" name="Nav_Name" value="#Get_Pop.Popup_Name#" maxlength="100"/></td>
				</tr>
				<tr>
					<td>Image</td>
					<td><input type="File" name="Nav_Image" value="#Get_Pop.Nav_Image#" maxlength="100"/></td>
				</tr>
				<tr>
					<td>Image File:</td>
					<td>
						<cfif len(trim(Get_Pop.Nav_Image)) gt 0>
							<a href="http://#cgi.server_name#/dealer/#arguments.Template_ID#/images/#arguments.Store#/#Get_Pop.Nav_Image#" target="_blank">#Get_Pop.Nav_Image#</a> - 
							<a href="#arguments.form_action#?page_action=delete_img&Dealer_Popup_ID=#Get_Pop.Dealer_Popup_ID#&Site_ID=#arguments.Site_ID#">delete</a>
						<cfelse>
							no image uploaded
						</cfif>
					</td>
				</tr>
				<tr>
					<td>Background Color</td>
					<td>
						<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
							<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
							<cfinvokeargument name="select_name" value="BG_Color"/>
							<cfinvokeargument name="select_value" value="#Get_Pop.BG_Color#"/>
							<cfinvokeargument name="hide_none" value="1"/>
						</cfinvoke>						
					</td>
				</tr>
				<tr>
					<td>Font Color</td>
					<td>
						<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
							<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
							<cfinvokeargument name="select_name" value="Font_Color"/>
							<cfinvokeargument name="select_value" value="#Get_Pop.Font_Color#"/>
							<cfinvokeargument name="hide_none" value="1"/>
						</cfinvoke>
					</td>
				</tr>
				<tr>
					<td>Popup Behaviour</td>
					<td>
						<select name="Nav_Behaviour_ID">
							<option value="1" <cfif Get_Pop.Nav_Behaviour_ID eq 1>selected="selected"</cfif> >Image only</option>
							<option value="2" <cfif Get_Pop.Nav_Behaviour_ID eq 2>selected="selected"</cfif>>Popup Trade-In Form</option>
							<option value="9" <cfif Get_Pop.Nav_Behaviour_ID eq 9>selected="selected"</cfif>>Trade-In Form NO POPUP</option>
							<option value="3" <cfif Get_Pop.Nav_Behaviour_ID eq 3>selected="selected"</cfif>>Popup Contact Us Form</option>
							<option value="10" <cfif Get_Pop.Nav_Behaviour_ID eq 10>selected="selected"</cfif>>Contact Us Form NO POPUP</option>
							<option value="4" <cfif Get_Pop.Nav_Behaviour_ID eq 4>selected="selected"</cfif>>Popup Coupon Test Drive Form</option>
							<option value="5" <cfif Get_Pop.Nav_Behaviour_ID eq 5>selected="selected"</cfif>>Popup Special Promotion Form</option>
							<option value="6" <cfif Get_Pop.Nav_Behaviour_ID eq 6>selected="selected"</cfif>>We Buy Used Cars Form</option>
							<option value="8" <cfif Get_Pop.Nav_Behaviour_ID eq 8>selected="selected"</cfif>>We Buy Used Cars Form NO POPUP</option>
							<option value="7" <cfif Get_Pop.Nav_Behaviour_ID eq 7>selected="selected"</cfif>>YouTube Video Link</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Page Link</td>
					<td><input type="text" name="Nav_Link" value="#Get_Pop.Nav_Link#" size="80" maxlength="200"/></td>
				</tr>
				<tr>
					<td valign="top">YouTube Video Link</td>
					<td><textarea name="YouTube_Video_Link" cols="80" rows="5">#Get_Pop.YouTube_Video_Link#</textarea></td>
				</tr>
				<tr>
					<td valign="top">Disclaimer</td>
					<td>
						<textarea name="Disclaimer" cols="80" rows="5">#Get_Pop.Disclaimer#</textarea>
					</td>
				</tr>
				<tr>
					<td>Start Date</td>
					<td><input type="text" name="Start_Date" value="#dateformat(Get_Pop.Start_Date,'mm/dd/yyyy')#" maxlength="10"/></td>
				</tr>
				<tr>
					<td>End Date</td>
					<td>
						<cfif dateformat(Get_Pop.End_Date,"mm/dd/yyyy") eq "12/31/2100">
							<input type="text" name="End_Date" value="" maxlength="10"/>
						<cfelse>
							<input type="text" name="End_Date" value="#dateformat(Get_Pop.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
						</cfif>
					</td>
				</tr>
				<tr>
					<td align="center">
						<!---<input type="button" value="Go Back" onclick="location.href='#arguments.form_action#?&dealer_id=#url.dealer_id#'"/>--->
					</td>
					<td>
						<input type="submit" value="Update Pop"/>
					</td>
				</tr>
			</table>
		</form>
	
	</cffunction>

	<cffunction name="update_pop" description="detailed update of a p" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Dealer_Popup_ID" required="true">
		<cfargument name="Save_Directory" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		
		<cfparam name="form.Nav_Image" default="">

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

		<cfquery datasource="#arguments.DSN#" name="Update_Nav">
			UPDATE		#arguments.Table_Name#
			SET			Popup_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Name#" maxlength="100">,
						Nav_Link = <cfif len(trim(form.Nav_Link)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Nav_Link#" maxlength="500"><cfelse>NULL</cfif>,
						Start_Date = <cfif len(trim(form.Start_Date)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(form.Start_Date,'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
						End_Date = <cfif len(trim(form.End_Date)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(form.End_Date,'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>,
						Disclaimer = <cfif len(trim(form.Disclaimer)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Disclaimer#"><cfelse>NULL</cfif>,
						YouTube_Video_Link = <cfif len(trim(form.YouTube_Video_Link)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.YouTube_Video_Link#"><cfelse>NULL</cfif>,
						Nav_Behaviour_ID = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.Nav_Behaviour_ID#" maxlength="3">,
						BG_Color = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.BG_Color#" maxlength="6">,
						Font_Color = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Font_Color#" maxlength="6">
						<cfif len(trim(form.Nav_Image)) gt 0>
							,Nav_Image = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#variables.new_img_file#" maxlength="100">
						</cfif>
			WHERE		Dealer_Popup_ID = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.Dealer_Popup_ID#" maxlength="3">
		</cfquery>
	
	</cffunction>

	<cffunction name="add_pop" description="Adds a new listing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Site_ID_Name" default="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Insert_Pop">
			INSERT INTO #arguments.Table_Name#
				(#arguments.Site_ID_Name#,
				Popup_Name,
				Popup_Type,
				Script_Name
				)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Site_ID#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.Popup_Name#" maxlength="100">,
				1,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="/index.cfm" maxlength="200">
				)
		</cfquery>
		
	</cffunction>

	<cffunction name="bulk_update" description="updates current popup listing" output="Yes" access="public">
	
		<cfparam name="form.Pop_Delete" default="">
	
		<cfloop list="#form.Dealer_Popup_ID#" index="pid">

			<cfset variables.Pop_Name="form.Pop_Name_#variables.pid#">
			<cfset variables.Start_Date="form.Start_Date_#variables.pid#">
			<cfset variables.End_Date="form.End_Date_#variables.pid#">

			<cfif len(trim(evaluate(variables.Pop_Name))) gt 0>
				<cfquery datasource="#arguments.DSN#" name="Update_Nav">
					UPDATE		#arguments.Table_Name#
					SET			Popup_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate(variables.Pop_Name)#" maxlength="100">,
								Start_Date = <cfif len(trim(evaluate(variables.Start_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.Start_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
								End_Date = <cfif len(trim(evaluate(variables.End_Date))) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(evaluate(variables.End_Date),'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>
					WHERE		Dealer_Popup_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.pid#" maxlength="6">
				</cfquery>
			</cfif>

		</cfloop>
		
		<cfloop list="#form.Pop_Delete#" index="pid">

			<cfquery datasource="#arguments.DSN#" name="Delete_Vid">
				DELETE FROM	#arguments.Table_Name#
				WHERE		Dealer_Popup_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.pid#" maxlength="4">
			</cfquery>
		
		</cfloop>
		
	</cffunction>

</cfcomponent>