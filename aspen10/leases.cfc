<cfcomponent>

<!--- Data Collection --->
		<cfset variables.dsn = "Aspen10">
		
		<cfquery name="get_pg_list" datasource="#variables.DSN#">
			SELECT  ID ,  Dealer_ID ,  Dealercode ,  StartDate ,  ExpireDate ,  Image ,  Page_Title ,BodyText ,  hierarchy ,img_location ,  Active  
			FROM   	Dealer_Lease_Page  
			WHERE	Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			and 	active = 1
			ORDER BY hierarchy ASC
		</cfquery>
		
		<cfquery datasource="#variables.DSN#" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset today_is = #dateformat(now(),"mm/dd/yyyy")# >
		
		<cfset variables.imgfldr = "images\library">
		<cfset variables.fullpath = "http://#cgi.server_name#/dealer/#Get_Dealer_Details.Dealer_Directory#/#variables.imgfldr#/">

	<cffunction name="modern_standard" description="create standard lease page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">

		
		<div class="row">
			<div class="col-md-12">
				<h2>Lease Specials at #Get_Dealer_Details.Display_Name#</h2>
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<cfloop query="get_pg_list" >
				<cfif (#get_pg_list.expiredate# NEQ "" AND  #dateformat(get_pg_list.expiredate,"mm/dd/yyyy")# LT #today_is# )>
					<cfquery name="" datasource="#variables.DSN#">
						Update 		Dealer_Lease_Page
						SET			ACTIVE 		= 0
						WHERE		ID 	= #get_pg_list.ID#
					</cfquery>
				<cfelse>
					<cfif #get_pg_list.img_location# EQ 1 AND #get_pg_list.Image# NEQ "" >
						<div class="row">
							<div class="col-md-12">
								<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#Get_Dealer_Details.Dealer_Directory#/images/library/#get_pg_list.Image#" border="0" >
							</div>
						</div>	
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
					</cfif>
					<div class="row">
						<div class="col-md-12">
							#get_pg_list.BodyText#
						</div>
					</div>
					<cfif #get_pg_list.img_location# EQ 0 AND #get_pg_list.Image# NEQ "" >
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-md-12">
								<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#Get_Dealer_Details.Dealer_Directory#/images/library/#get_pg_list.Image#" border="0" >
							</div>
						</div>	
					</cfif>
				</cfif>
			</cfloop>
	</cffunction>

	<cffunction name="legacy_standard" description="create standard lease page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">

		<table>
			<tr><td align="left"><h2>Lease Specials at #Get_Dealer_Details.Display_Name#</h2></td></tr>
			<tr><td>&nbsp;</td></tr>
				<cfloop query="get_pg_list" >
					<cfif (#get_pg_list.expiredate# NEQ "" AND  #dateformat(get_pg_list.expiredate,"mm/dd/yyyy")# LT #today_is# )>
						<cfquery name="" datasource="#variables.DSN#">
							Update 		Dealer_Lease_Page
							SET			ACTIVE 		= 0
							WHERE		ID 	= #get_pg_list.ID#
						</cfquery>
					<cfelse>	
						<cfif #get_pg_list.img_location# EQ 1 AND #get_pg_list.Image# NEQ "" >
							<tr><td align="center"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#Get_Dealer_Details.Dealer_Directory#/images/library/#get_pg_list.Image#" border="0" ></td></tr>	
							<tr><td>&nbsp;</td></tr>
						</cfif>
						<tr><td align="left">#get_pg_list.BodyText#</td></tr>	
						<tr><td>&nbsp;</td></tr>
						<cfif #get_pg_list.img_location# EQ 0 AND #get_pg_list.Image# NEQ "" >
							<tr><td align="center"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#Get_Dealer_Details.Dealer_Directory#/images/library/#get_pg_list.Image#" border="0" ></td></tr>	
							<tr><td>&nbsp;</td></tr>
						</cfif>
					</cfif>
				</cfloop>
		</table>
		
	</cffunction>

</cfcomponent>