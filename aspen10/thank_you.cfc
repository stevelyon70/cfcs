<cfcomponent>

	<cffunction name="generic" description="shows generic thank you message" output="Yes" access="public">
			
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
			<div class="container">
			 	<div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Header --->
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/webheader.jpg" border="0" class="img-responsive"> 
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container">
					<div class="row">
						<div class="row">
							<div class="col-md-12 no-pad" align="center" >	
								<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/ThankYou.jpg" border="0" class="img-responsive"> 
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pull right" align="right"  >	
								
							</div>
						</div>
					</div>
	
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row"> 
							<div class="col-md-6 pull left" align="left" >	
<!--- <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_640x360_V1.jpg" border="0" class="img-responsive">  --->
							</div>		
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
					 <div class="row">
						<div class="col-md-12 no-pad visible-md visible-lg" align="center">
							
						</div>
					</div>	  
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Toy_TradeIn_Booster_640x244_footer.jpg" border="0" class="img-responsive">  --->
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
			</div>  <!--- container --->
		</section>

	</cffunction>

	<cffunction name="service" description="shows generic thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You For Your Request.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="offlease" description="shows off lease thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>

</cfcomponent>