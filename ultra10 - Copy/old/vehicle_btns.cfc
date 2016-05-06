<cfcomponent>

	<cffunction name="vdp_standard" description="shows default standard vdp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->

		<cfargument name="VOI_Vin" required="true">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_fin" default="no">
		<cfargument name="exclude_friend" default="no">
		<cfargument name="exclude_print" default="no">

		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
	
		<cfif arguments.exclude_td eq "no">
			<a class="btn btn-grey" data-toggle="modal" data-target="##tdModal"><img class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png"/>Schedule A Test Drive</a>
		</cfif>
		<cfif arguments.exclude_qq eq "no">
			<a class="btn btn-grey" data-toggle="modal" data-target="##qqModal"><img class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
		</cfif>
		<cfif arguments.exclude_fin eq "no">
			<a class="btn btn-grey"><img class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
		</cfif>
		<cfif arguments.exclude_friend eq "no">
			<a class="btn btn-grey" data-toggle="modal" data-target="##friendModal"><img class="btn-icon" src="#varibales.img_url#/icon_SM_SendtoFriend_off.png"/>Send to a Friend</a>
		</cfif>
		<cfif arguments.exclude_print eq "no">
			<a href="http://#cgi.server_name#/inventory/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank"><img class="btn-icon" src="#varibales.img_url#/icon_SM_print_off.png"/>Print Vehicle</a>
		</cfif>
	</cffunction>

	<cffunction name="srp_standard" description="shows default standard srp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->

		<cfargument name="VOI_Vin" required="true">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_info" default="no">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_details" default="no">
		
		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
	
		<cfif arguments.exclude_qq eq "no">
			<div class="col-md-3 srp-btn visible-md visible-lg">
				<a class="btn btn-grey"><img class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
			</div>
		</cfif>
		<cfif arguments.exclude_info eq "no">
			<div class="col-md-3 srp-btn visible-md visible-lg">
				<a class="btn btn-grey"><img class="btn-icon" src="#varibales.img_url#/icon_SM_Info_off.png"/>Request Info</a>
			</div>
		</cfif>
		<cfif arguments.exclude_td eq "no">
			<div class="col-md-3 srp-btn visible-md visible-lg">
				<a class="btn btn-grey"><img class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png"/>Schedule A Test Drive</a>
			</div>
		</cfif>
		<cfif arguments.exclude_details eq "no">
			<div class="col-md-3 srp-btn">
				<a class="btn btn-grey"><img class="btn-icon" src="#varibales.img_url#/icon_SM_Details_off.png"/>Vehicle Details</a>
			</div>
		</cfif>
	</cffunction>

</cfcomponent>