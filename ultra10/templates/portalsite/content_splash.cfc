
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
<cfif #url.dealer_id# NEQ 234 >
		<section class="section-spl">
			<div class="container">
				<div class="wrapper">
					<div class="row" >
						<div class="col-md-12 padding-top 15px" align="center">	
							<a href="http://northpointeauto.com">
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_NorthPointe2_off.png" border="0" class="img-responsive"></a> 
							<div class="row"><div class="col-md-12">&nbsp;</div></div>
							<div class="row">
								<div class="col-md-12 padding-left 5px" align="left" style="font-family: Helvetica, Arial, sans-serif;font-size:12pt" >	<!--- Body Text --->
									<p>At Northpointe Automotive, a Baierl Family Dealership, our goal is to treat you as family when you are doing business with us. We strive to make sure you are 100% satisfied 100% of the time. While here you can browse our new or pre-owned inventory, order parts and accessories or schedule your next service appointment all from the comfort of your home or office 24/7. </p>
								</div>
							</div>
						</div>
					</div>
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
				 			<div class="col-md-12" align="center" style="font-family: Helvetica, Arial, sans-serif;font-size:20pt" >	
								<p>Please choose a brand below to begin your search!</p>
							</div>
						</div>
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
				 			<div class="row">
				 				<div class="col-md-6" align="center" >	
									<a href="http://northpointechrysler.com" target="_blank" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_CJDR.png" border="0" class="img-responsive"></a>
									<div class="row">
							 			<div class="col-md-2" ></div>
									 	<div class="col-md-10  padding-left 5px" align="left"  style="font-family: Helvetica, Arial, sans-serif;font-size:12pt;font-weight:bold" >	
											<br>Northpointe Chrysler<br>3485 State Route 257<br>Seneca, PA 16346<br><strong>Phone: 814-676-7000</strong>
											<br>
											<p align="left"><a href="http://northpointechrysler.com/used" class="button" target="_blank" >> Search Used</a></p>
											<p align="left"><a href="http://northpointechrysler.com/new" class="button" target="_blank" >> Search New</a></p>
											<p align="left"><a href="http://northpointechrysler.com/dealership/hours_and_directions.cfm" class="button" target="_blank" >> Hours & Directions</a></p>
											<p align="left"><a href="http://northpointechrysler.com/forms/service_request.cfm" class="button" target="_blank" >> Schedule Service</a></p>
											<p align="left"><a href="http://northpointechrysler.com/forms/trade.cfm"   target="_blank" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/icon_kbb.jpg" border="0" class="img-responsive"></a></p>
										</div>
									</div>	
								</div>
							 	<div class="col-md-6" align="center" >	
									<a href="http://northpointechevrolet.com" target="_blank" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_cadillac.png" border="0" class="img-responsive"></a>
									<div class="row">
							 			<div class="col-md-2" ></div>
									 	<div class="col-md-10  padding-left 5px" align="left"  style="font-family: Helvetica, Arial, sans-serif;font-size:12pt;font-weight:bold" >	
											<br>Northpointe Cadillac<br>3485 State Route 257<br>Seneca, PA 16346<br><strong>Phone: 814-676-7000</strong>
											<br>
											<p align="left"><a href="http://northpointechevrolet.com/used" class="button" target="_blank" >> Search Used</a></p>
											<p align="left"><a href="http://northpointechevrolet.com/new" class="button" target="_blank" >> Search New</a></p>
											<p align="left"><a href="http://northpointechevrolet.com/dealership/hours_and_directions.cfm" class="button" target="_blank" >> Hours & Directions</a></p>
											<p align="left"><a href="http://northpointechevrolet.com/forms/service_request.cfm" class="button" target="_blank" >> Schedule Service</a></p>
											<p align="left"><a href="http://northpointechevrolet.com/forms/trade.cfm"   target="_blank" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/icon_kbb.jpg" border="0" class="img-responsive"></a></p>
										</div>
									</div>	
								</div> 
							</div>
						</div> <!--- end Wrapper --->
					</div> <!--- end container --->
			</section>
<cfelse>
		<section class="section-spl">
			<div class="container">
				<div class="wrapper">
					<div class="row" >
						<div class="col-md-12" align="center" >
						<cflocation url="http://25ultra10.wddemos.com/dealer/findlayautocdjr/findlayautocdjr.cfm">
						
						</div>
					</div>
				</div> <!--- end Wrapper --->
			</div> <!--- end container --->
		</section>

</cfif>		

	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">
	</cffunction>
</cfcomponent>