<cfcomponent>

	<cffunction name="get_pages" description="gets current page listing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Get_Pages" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfset Get_Pages=arguments.Get_Pages>
		
		<form class="form-horizontal" action="#arguments.form_action#?page_action=bulk_update" method="post">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<table style="font:normal 12px arial;" cellpadding="3" cellspacing="0">
				<tr>
					<td>
						<b>Page Name</b>
					</td>
					<td>
						<b>Start Date</b>
					</td>
					<td>
						<b>End Date</b>
					</td>
					<td align="center">
						<b>Action</b>
					</td>
				</tr>
				<tr>
					<td style="padding:0px 0px 10px 0px;" colspan="4"><hr/></td>
				</tr>
				<cfloop query="Get_Pages">
					<input type="hidden" name="Page_ID" value="#Get_Pages.Page_ID#"/>
					<tr <cfif Get_Pages.CurrentRow mod 2 eq 0>style="background-color:##ddd;"</cfif>>
						<td>
							<cfif Get_Pages.global eq "1">
								<cfif Get_Pages.script_name eq "/index.cfm">
									<b>#Get_Pages.script_name#</b>
								<cfelse>
									<b>#replace(Get_Pages.script_name,"/index.cfm","")#</b>
								</cfif>
								<input type="hidden" name="script_name_#Get_Pages.Page_ID#" value="#Get_Pages.script_name#"/>
							<cfelse>
								<input type="text" name="script_name_#Get_Pages.Page_ID#" value="#Get_Pages.script_name#" maxlength="200"/>
							</cfif>
						</td>
						<td>
							<cfif Get_Pages.global eq "1">
								<div align="center">N/A</div>
								<input type="hidden" name="Start_Date_#Get_Pages.Page_ID#" value="#Get_Pages.script_name#"/>
							<cfelse>
								<input type="text" name="Start_Date_#Get_Pages.Page_ID#" value="#dateformat(Get_Pages.Start_Date,'mm/dd/yyyy')#" maxlength="10"/>
							</cfif>
						</td>
						<td>
							<cfif Get_Pages.global eq "1">
								<div align="center">N/A</div>
								<input type="hidden" name="End_Date_#Get_Pages.Page_ID#" value="#Get_Pages.End_Date#"/>
							<cfelse>
								<cfif dateformat(Get_Pages.End_Date,"mm/dd/yyyy") eq "12/31/2100">
									<input type="text" name="End_Date_#Get_Pages.Page_ID#" value="" maxlength="10"/>
								<cfelse>
									<input type="text" name="End_Date_#Get_Pages.Page_ID#" value="#dateformat(Get_Pages.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
								</cfif>
							</cfif>
						</td>
						<td align="center">
							<a href="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_page&Page_ID=#Get_Pages.Page_ID#">Edit</a>
						</td>
					</tr>
					<tr <cfif Get_Pages.CurrentRow mod 2 eq 0>style="background-color:##ddd;"</cfif>>
						<td colspan="4" style="font:normal 10px arial;">
							&nbsp;&nbsp; - url: <a href="http://#cgi.Server_Name##replace(Get_Pages.script_name,"/index.cfm","")#" target="_blank">http://#cgi.Server_Name##replace(Get_Pages.script_name,"/index.cfm","")#</a>
						</td>						
					</tr>
				</cfloop>
			</table>
		</form>
	
	</cffunction>

	<cffunction name="edit_page" description="get page details" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Site_ID" default="true">
		<cfargument name="Page_ID" default="true">
		<cfargument name="Get_Page_Details" required="true">
		<cfargument name="Ad_Mode" default="False"> 
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">
		<cfset Get_Page_Details=arguments.Get_Page_Details>

		<form class="form-horizontal" action="#arguments.form_action#?page_action=update_page" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Site_ID" value="#arguments.Site_ID#"/>
			<input type="hidden" name="Page_ID" value="#arguments.Page_ID#"/>
			<table>
				<tr>
					<td>Name :</td>
					<td>
						<cfif Get_Page_Details.global eq "1">
							<cfif Get_Page_Details.script_name eq "/index.cfm">
								<b>#Get_Page_Details.script_name#</b>
							<cfelse>
								<b>#replace(Get_Page_Details.script_name,"/index.cfm","")#</b>
							</cfif>
							<input type="hidden" name="script_name" value="#Get_Page_Details.script_name#"/>
						<cfelse>
							<input type="text" name="script_name" value="#Get_Page_Details.script_name#" maxlength="200"/>
						</cfif>
					</td>
				</tr>
				<tr>
					<td>Page Title :</td>
					<td><input type="text" name="page_title" value="#Get_Page_Details.page_title#" maxlength="200"/></td>
				</tr>
				<tr>
					<td valign="top">Page Banner :</td>
					<td>
						<textarea class="page_content" name="page_banner" cols="50" rows="10">#Get_Page_Details.page_banner#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Page Content :</td>
					<td>
						<textarea class="page_content" name="page_content" cols="50" rows="10">#Get_Page_Details.page_content#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Page Footer :</td>
					<td>
						<textarea class="page_content" name="page_footer" cols="50" rows="10">#Get_Page_Details.page_footer#</textarea>
					</td>
				</tr>
				<tr>
					<td>Start Date :</td>
					<td><input type="text" name="Start_Date" value="#dateformat(Get_Page_Details.Start_Date,'mm/dd/yyyy')#" maxlength="10"/></td>
				</tr>
				<tr>
					<td>End Date :</td>
					<td>
						<cfif dateformat(Get_Page_Details.End_Date,"mm/dd/yyyy") eq "12/31/2100">
							<input type="text" name="End_Date" value="" maxlength="10"/>
						<cfelse>
							<input type="text" name="End_Date" value="#dateformat(Get_Page_Details.End_Date,'mm/dd/yyyy')#" maxlength="10"/>
						</cfif>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<br/>
					</td>
				</tr>
				<tr>
					<td style="background-color:##ddd" colspan="2">
						<b>SEO</b>
					</td>
				</tr>
				<tr>
					<td valign="top">Meta Title :</td>
					<td>
						<textarea name="meta_title" cols="50" rows="3">#Get_Page_Details.meta_title#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Meta Description :</td>
					<td>
						<textarea name="meta_description" cols="50" rows="3">#Get_Page_Details.meta_description#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Meta Keywords :</td>
					<td>
						<textarea name="meta_keywords" cols="50" rows="3">#Get_Page_Details.meta_keywords#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Page Text :</td>
					<td>
						<textarea name="page_text" cols="50" rows="3">#Get_Page_Details.page_text#</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<br/>
					</td>
				</tr>
				<tr>
					<td style="background-color:##ddd" colspan="2">
						<b>Third Party Scripts - This Page Only</b>
					</td>
				</tr>
				<tr>
					<td valign="top">Inside &lt;head&gt; :</td>
					<td>
						<textarea name="scripts_head" cols="50" rows="3">#Get_Page_Details.scripts_head#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Above &lt;body&gt; :</td>
					<td>
						<textarea name="scripts_above_body" cols="50" rows="3">#Get_Page_Details.scripts_above_body#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Below &lt;body&gt; :</td>
					<td>
						<textarea name="scripts_body_top" cols="50" rows="3">#Get_Page_Details.scripts_body_top#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Above &lt;/body&gt; :</td>
					<td>
						<textarea name="scripts_body_bottom" cols="50" rows="3">#Get_Page_Details.scripts_body_bottom#</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">Below &lt;/body&gt; :</td>
					<td>
						<textarea name="scripts_after_body" cols="50" rows="3">#Get_Page_Details.scripts_after_body#</textarea>
					</td>
				</tr>
				<cfif arguments.Ad_Mode eq "true">
					<tr>
						<td style="background-color:##ddd" colspan="2">
							<b>Ad Units - This Page Only</b>
						</td>
					</tr>
					<tr>
						<td valign="top">Top :</td>
						<td>
							<textarea name="top_ad" cols="50" rows="3">#Get_Page_Details.top_ad#</textarea>
						</td>
					</tr>
					<tr>
						<td valign="top">Bottom :</td>
						<td>
							<textarea name="bot_ad" cols="50" rows="3">#Get_Page_Details.bot_ad#</textarea>
						</td>
					</tr>
					<tr>
						<td valign="top">Side 1 :</td>
						<td>
							<textarea name="side_ad_1" cols="50" rows="3">#Get_Page_Details.side_ad_1#</textarea>
						</td>
					</tr>
					<tr>
						<td valign="top">Side 2 :</td>
						<td>
							<textarea name="side_ad_2" cols="50" rows="3">#Get_Page_Details.side_ad_2#</textarea>
						</td>
					</tr>
				<cfelse>
					<input type="hidden" name="top_ad" value=""/>
					<input type="hidden" name="bot_ad" value=""/>
					<input type="hidden" name="side_ad_1" value=""/>
					<input type="hidden" name="side_ad_2" value=""/>
				</cfif>
				<tr>
					<td align="center">
						<input type="button" value="Go Back" onclick="location.href='#arguments.form_action#'"/>
					</td>
					<td>
						<input type="submit" value="Update Page"/>
					</td>
				</tr>
			</table>
			
		</form>

	</cffunction>

	<cffunction name="update_page" description="update page details" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="true">
		<cfargument name="Table_Name" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#">

		<cfquery datasource="#arguments.DSN#" name="Update_Page">
			UPDATE		#arguments.Table_Name#

			SET			page_title = <cfif len(trim(form.page_title)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.page_title#" maxlength="200"><cfelse>NULL</cfif>,
						page_banner = <cfif len(trim(form.page_banner)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.page_banner#"><cfelse>NULL</cfif>,
						page_content = <cfif len(trim(form.page_content)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.page_content#"><cfelse>NULL</cfif>,
						page_footer = <cfif len(trim(form.page_footer)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.page_footer#"><cfelse>NULL</cfif>,
						page_text = <cfif len(trim(form.page_text)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.page_text#"><cfelse>NULL</cfif>,

						meta_title = <cfif len(trim(form.meta_title)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.meta_title#"><cfelse>NULL</cfif>,
						meta_description = <cfif len(trim(form.meta_description)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.meta_description#"><cfelse>NULL</cfif>,
						meta_keywords = <cfif len(trim(form.meta_keywords)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.meta_keywords#"><cfelse>NULL</cfif>,

						scripts_head = <cfif len(trim(form.scripts_head)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.scripts_head#"><cfelse>NULL</cfif>,
						scripts_above_body = <cfif len(trim(form.scripts_above_body)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.scripts_above_body#"><cfelse>NULL</cfif>,
						scripts_body_top = <cfif len(trim(form.scripts_body_top)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.scripts_body_top#"><cfelse>NULL</cfif>,
						scripts_body_bottom = <cfif len(trim(form.scripts_body_bottom)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.scripts_body_bottom#"><cfelse>NULL</cfif>,
						scripts_after_body = <cfif len(trim(form.scripts_after_body)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.scripts_after_body#"><cfelse>NULL</cfif>,

						top_ad = <cfif len(trim(form.top_ad)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.top_ad#"><cfelse>NULL</cfif>,
						bot_ad = <cfif len(trim(form.bot_ad)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.bot_ad#"><cfelse>NULL</cfif>,
						side_ad_1 = <cfif len(trim(form.side_ad_1)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.side_ad_1#"><cfelse>NULL</cfif>,
						side_ad_2 = <cfif len(trim(form.side_ad_2)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.side_ad_2#"><cfelse>NULL</cfif>,

						Start_Date = <cfif len(trim(form.Start_Date)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(form.Start_Date,'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(now(),'mm/dd/yyyy')#" maxlength="10"></cfif>,
						End_Date = <cfif len(trim(form.End_Date)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dateformat(form.End_Date,'mm/dd/yyyy')#" maxlength="10"><cfelse><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="12/31/2100" maxlength="10"></cfif>

			WHERE		Page_ID = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.Page_ID#" maxlength="10">
		</cfquery>
		
	</cffunction>

</cfcomponent>