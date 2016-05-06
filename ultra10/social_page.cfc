<cfcomponent>

	<cffunction name="modern_standard" description="shows dealer Social Reviews Page" output="Yes" access="public">
		
		<cfquery datasource="Ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfquery datasource="Ultra10" name="Get_Primary">
			SELECT  	ID, dealer_id, page_text, image_name, link_destination, link_target, hierarchy, active, start_dt, expires_dt, create_dt
			FROM    	Dealer_Social_Page
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="6">
			AND			hierarchy = 1
			ORDER BY 	Hierarchy ASC
		</cfquery>
		
		
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-12" align="center">
						<h2>#Get_Dealer_Details.Display_Name#</h2>
						#Get_Primary.page_text#
					</div>
				</div>	
				<!--- <div class="row">
					<div class="col-md-12" align="center">
						#Get_Primary.page_text#
					</div>
				</div>	 --->
				<!--- <div class="row"><div class="col-md-12" align="center">&nbsp;</div></div> --->
				<div class="row">
					<cfif #Get_Primary.image_name# EQ "" >
						<div class="col-md-4 col-md-offset-4" style="border:1px solid black;min-height:300px;max-width:350px" align="center">
							<br><br><br>Large Image goes here<br>(Suggested Size: 350x300)<br><b>#Get_Primary.link_destination#</b>
						</div>
					<cfelse>
						<div class="col-md-4 col-md-offset-4" style="min-height:300px;max-width:350px" align="center">
							<a href="#Get_Primary.link_destination#" target="#Get_Primary.link_target#">
							<img src="http://dealers.wdautos.com/dealer/#Get_Dealer_Details.Dealer_Directory#/images/library/#Get_Primary.image_name#" class="img-responsive"></a>
						</div>	
					</cfif>
				</div>	
			</div>
		</div>
		<!--- <div class="row"><div class="col-md-12" align="center">&nbsp;</div></div> --->
		<!--- <div class="row"><div class="col-md-12" align="center">&nbsp;</div></div> --->
		
		<cfquery datasource="Ultra10" name="Get_Remainder">
			SELECT  	ID, dealer_id, page_text, image_name, link_destination, link_target, hierarchy, active, start_dt, expires_dt, create_dt
			FROM    	Dealer_Social_Page
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="6">
			AND			hierarchy <> 1
			ORDER BY 	Hierarchy ASC
		</cfquery>
		
		
		<div class="row">
			<cfloop query="Get_Remainder">
				<cfif #Get_Remainder.image_name# EQ "" >
					<div class="col-md-3"align="center" style="border:1px solid black;max-width:250px;min-height:100px;margin-right:10px" >
						<div >Small Image goes here<br>(Suggested Size: 250x100)<br><b>#Get_Remainder.link_destination#</b></div>
					</div>
				<cfelse>
					<div class="col-md-3" style="min-height:250px;max-width:300px" align="center">
						<a href="#Get_Remainder.link_destination#" target="#Get_Remainder.link_target#">
						<img src="http://dealers.wdautos.com/dealer/#Get_Dealer_Details.Dealer_Directory#/images/library/#Get_Remainder.image_name#" alt="" class="img-responsive">
						</a>
					</div>	
				</cfif>	
				<cfif Get_Remainder.currentRow mod 4 eq 0>
					</div><div class="row">&nbsp;</div><div class="row">
				</cfif>
			</cfloop>
		</div>
		<!--- <div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div> --->
		
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">

	</cffunction>

</cfcomponent>