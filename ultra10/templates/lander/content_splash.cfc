
<cfcomponent>


	<cffunction name="modern" description="Portal Site" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
		<cfif #url.dealer_id# eq 234 >		<!--- Findlay CDJR 10-02-2014 --->
			<section class="section-spl">
				<div class="container">
					<div class="wrapper">
						<div class="row" >
							<div class="col-md-12" align="center" >
							<img name="splash_CJDR"  src="dealer/findlayautocdjr/splash_CJDR.jpg" width="860" height="538" id="splash_CJDR" usemap="##m_splash_CJDR" alt="Findlay CDJR" />
							<map name="m_splash_CJDR" id="m_splash_CJDR">
							<area shape="poly" coords="440,263,840,263,840,399,440,399,440,263" href="http://www.postfallschryslerjeepdodgeram.com" target="_blank" title="Findlay Chrysler Jeep Dodge Ram of Post Falls, ID" alt="Findlay Chrysler Jeep Dodge Ram of Post Falls, ID" />
							<area shape="poly" coords="20,263,420,263,420,399,20,399,20,263" href="http://findlaycjdr.com/" target="_blank" title="Findlay Chrysler Jeep Dodge Ram of Wilsonville, OR" alt="Findlay Chrysler Jeep Dodge Ram of Wilsonville, OR" />
							</map>
							</div>
						</div>
					</div> <!--- end Wrapper --->
				</div> <!--- end container --->
			</section> <!--- end section --->
		</cfif>

	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">
	</cffunction>
</cfcomponent>