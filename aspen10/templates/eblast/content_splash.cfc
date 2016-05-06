
<cfcomponent>


	<cffunction name="modern" description="eblast landing page" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
		<section class="section-spl">
			<div class="container" >
				<div class="row">
					<div class="col-md-12 " align="center" >	
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/ChryslerVideoPage2015.jpg" border="0" class="img-responsive"> 
					</div>
				</div>
			</div>  <!--- container --->
		</section>
		
	</cffunction>

	<cffunction name="modernregthankyou" description="shows a standard header" output="Yes" access="public">

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>

</cfcomponent>