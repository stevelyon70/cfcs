<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<cfquery datasource="Ultra10" name="Get_Specials">
			SELECT		Dealer_Special_ID,
						Special_Type_ID,
						Dealer_ID,
						Special_Name,
						Special_Image,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		Dealer_Specials
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="10">
			AND			Special_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Special_Type_ID#" maxlength="6">
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			ORDER BY 	Dealer_ID, Hierarchy
		</cfquery>
		 
		<cfif Get_Specials.Recordcount gt 0>
			<cfloop query="Get_Specials">
				<div class="row">
					<div class="col-md-12" align="center">
						<cfif len(trim(Get_Specials.Special_Image)) gt 0>
							<img alt="Specials"  class="img-responsive" src="http://#cgi.server_name#/dealer/#url.assets#/images/icons/#Get_Specials.Special_Image#"/>
						</cfif>
					</div>
				</div>
			</cfloop>
		<cfelse>
			<div class="row">
				<div class="col-md-12" align="center">
					<img alt="Specials"  class="img-responsive" src="http://#cgi.server_name#/images/inventory/ads_header.png"/>
				</div>
			</div>
			<cfset variables.img_url="http://#cgi.server_name#/images/inventory">
			<div class="row">
				<div class="col-md-6">
					<a class="btn btn-grey" href="http://#cgi.server_name#/new/"><img class="btn-icon img-responsive" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>SEARCH NEW INVENTORY</a>
				</div>
				<div class="col-md-6">
					<a class="btn btn-grey" href="http://#cgi.server_name#/new/special_offers.cfm"><img class="btn-icon img-responsive" src="#variables.img_url#/icon_SM_Finance_off.png" alt="View Details"/>VIEW NEW SPECIALS</a>
				</div>
				<div class="col-md-6">
					<a class="btn btn-grey" href="http://#cgi.server_name#/used/"><img class="btn-icon img-responsive" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>SEARCH USED INVENTORY</a>
				</div>
				<div class="col-md-6">
					<a class="btn btn-grey" href="http://#cgi.server_name#/used/special_offers.cfm"><img class="btn-icon img-responsive" src="#variables.img_url#/icon_SM_Finance_off.png" alt="View Details"/>VIEW USED SPECIALS</a>
				</div>
			</div>
		</cfif>

			
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">

		<cfquery datasource="Ultra10" name="Get_Specials">
			SELECT		Dealer_Special_ID,
						Special_Type_ID,
						Dealer_ID,
						Special_Name,
						Special_Image,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		Dealer_Specials
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="10">
			AND			Special_Type_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Special_Type_ID#" maxlength="6">
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			ORDER BY 	Dealer_ID, Hierarchy
		</cfquery>
		<table width="100%">
		<cfif Get_Specials.Recordcount gt 0>
			<cfloop query="Get_Specials">
				<tr>
					<td align="center">
						<cfif len(trim(Get_Specials.Special_Image)) gt 0>
							<img alt="Buttons"  src="http://#cgi.server_name#/dealer/#url.assets#/images/icons/#Get_Specials.Special_Image#"/>
						</cfif>
					</td>
				</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td align="center">
					<img alt="Buttons" class="img-responsive" src="http://#cgi.server_name#/images/inventory/ads_header.png"/>
				</td>
			</tr>
			<cfset variables.img_url="http://#cgi.server_name#/images/inventory">
			<tr>
				<td align="left" width="50%">
					<a class="btn btn-grey" href="http://#cgi.server_name#/new/"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>SEARCH NEW INVENTORY</a>
				</td>
				<td align="left" width="50%">
					<a class="btn btn-grey" href="http://#cgi.server_name#/new/special_offers.cfm"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" alt="View Details"/>VIEW NEW SPECIALS</a>
				</td>
			<tr>
				<td align="left" width="50%">
					<a class="btn btn-grey" href="http://#cgi.server_name#/used/"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>SEARCH USED INVENTORY</a>
				</td>
				<td align="left" width="50%">
					<a class="btn btn-grey" href="http://#cgi.server_name#/used/special_offers.cfm"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" alt="View Details"/>VIEW USED SPECIALS</a>
				</td>
			</tr>
		</cfif>
		</table>
		
	</cffunction>

</cfcomponent>