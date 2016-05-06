<cfcomponent>

	<cffunction name="standard" description="locations page" output="Yes" access="public">
			<cfargument name="automall_id" required="true">
			<cfargument name="automall_name" required="true">
			<cfargument name="template_id" required="true">
	
			<!---Get Dealers --->
			<cfstoredproc datasource="Ultra10" procedure="Get_Automall_Dealers">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
				<cfprocresult name="Get_All_Dealers" resultset="1">
			</cfstoredproc>

			<div class="row">
				<div class="col-md-12">
					<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
				</div>
			</div>
			<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
				<div class="row">
					<div class="col-md-12">
						#Get_Page_Content.page_banner#
					</div>
				</div>
			</cfif>
			<div class="row">
				<cfloop query="Get_All_Dealers">
					<cfquery datasource="Automall" name="Get_Phones">
						SELECT		Dealer_Phone,
									Inv_Phone_New,
									Inv_Phone_Used
						FROM		Join_Automall_Dealers
						WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_All_Dealers.Dealer_ID#" maxlength="3">
						AND			Automall_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.automall_id#" maxlength="3">
					</cfquery>
					<!--- <cfif len(trim(Get_Phones.Dealer_Phone)) gt 0> --->
						<cfquery datasource="Ultra10" name="Get_Dealer_Phone">
							SELECT		Area_Code,
										Prefix,
										Line_Number,
										Vanity_Number
							FROM		Dealer_Phones
							WHERE		Phone_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Phones.Dealer_Phone#" maxlength="3">
						</cfquery>
					<!--- <cfelse>
						<cfset Get_Dealer_Phone.Vanity_Number="">
						<cfset Get_Dealer_Phone.Area_Code="">
						<cfset Get_Dealer_Phone.Prefix="">
						<cfset Get_Dealer_Phone.Line_Number="">
					</cfif> --->
					<div class="col-md-4">
						<div class="loc-dlr-div">
							<cfif len(trim(Get_All_Dealers.Display_Name)) gt 0><span class="vdp-store-name"><b>#Get_All_Dealers.Display_Name#</b></span><br/></cfif>
							<cfif len(trim(Get_All_Dealers.Address_1)) gt 0>#Get_All_Dealers.Address_1#<br/></cfif>
							<cfif len(trim(Get_All_Dealers.Address_2)) gt 0>#Get_All_Dealers.Address_2#<br/></cfif>
							<cfif len(trim(Get_All_Dealers.City)) gt 0>#Get_All_Dealers.City#, #Get_All_Dealers.State# #Get_All_Dealers.Zip#<br/></cfif>
							<!--- <cfif len(trim(Get_Dealer_Phone.Vanity_Number)) gt 0>
								#Get_All_Dealers.Vanity_Number#<br/>
							<cfelse> --->
								<cfif len(trim(Get_Dealer_Phone.Area_Code)) gt 0>(#Get_Dealer_Phone.Area_Code#) #Get_Dealer_Phone.Prefix#-#Get_Dealer_Phone.Line_Number#<br/></cfif>
							<!--- </cfif> --->
							<!--- <cfif len(trim(Get_All_Dealers.Phone)) gt 0>#Get_All_Dealers.Dealer_Phone#<br/></cfif> --->
							<cfif len(trim(Get_All_Dealers.Primary_URL)) gt 0><a class="btn btn-grey" href="http://#cgi.server_name#/clicks/web_click.cfm?dealer_id=#Get_All_Dealers.Dealer_ID#" target="_blank"><img class="btn-icon" src="http://#cgi.server_name#/images/inventory/icon_SM_WWW_off.png"/>Dealer Website</a></cfif>
							<!---<cfif len(trim(Get_All_Dealers.Link_Finance)) gt 0><a class="btn btn-grey" href="#Get_All_Dealers.Link_Finance#" target="_blank"><img class="btn-icon" src="http://#cgi.server_name#/images/inventory/icon_SM_Finance_off.png"/>Get Pre-Approved</a></cfif>--->
						</div>
					</div>
					<cfif Get_All_Dealers.Currentrow mod 3 eq 0>
						</div>
						<div class="row">
					</cfif>
				</cfloop>
			</div>
			<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
				<div class="row">
					<div class="col-md-12">
						#Get_Page_Content.page_footer#
					</div>
				</div>
			</cfif>
	</cffunction>

</cfcomponent>