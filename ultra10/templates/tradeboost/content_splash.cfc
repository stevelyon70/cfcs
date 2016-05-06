
<cfcomponent>


	<cffunction name="modern" description="WorldDealer Form" output="Yes" access="public">
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
		
		<section class="section-spl">
			<div class="container">
			 	<div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Header --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/webheader.jpg" border="0" class="img-responsive"> 
					</div>
				</div> 
					<!--- <div class="row" >
						<cfset main_image = "Toy_TradeIn_Booster_960x200_SubHeader.jpg" >
						<cfset site_addr = "rwd.worlddealer.net" >
						<div class="col-md-12 no-pad" align="center">	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/#main_image#" border="0" class="img-responsive"> 
						</div>
					</div> --->
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container">
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					
					<!---  <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	  --->
					<div class="row">
						<div class="row">
							<div class="col-md-7 pull right" align="right" style="color:##231f20 ;font-family: Helvetica, Arial, sans-serif;font-size:10pt" >	
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_640x360_V2.jpg" border="0" class="img-responsive"> <br>
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/Toy_TradeIn_Booster_640x244_footer.jpg" border="0" class="img-responsive"> 
							</div>
							<div class="col-md-5 pull right" align="center" style="color:##231f20 ;font-family: Helvetica, Arial, sans-serif;font-size:10pt" >	
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_R-SIDE-TEXT.jpg" border="0" class="img-responsive"> 
									<div class="col-md-12 no-pad"><B>OFFER ENDS DECEMBER 31, 2014</B></div>
										
								<!--- <div class="row"> --->
									<div class="col-md-12 pull right" align="right"  >	
										<cfinvoke component="/cfcs/forms/form_trade" method="tap_default">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="VOI_Vin" value=""/>
											<cfinvokeargument name="VOI_New_Used" value=""/>
											<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
											<cfinvokeargument name="form_action" value="http://#cgi.server_name#/dealer/#variables.dlr_dir#/micro_qq_action.cfm"/>
										</cfinvoke>  
									</div>
								<!--- </div> --->
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pull right" align="right"  >	
								
							</div>
						</div>
					</div>
	
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row"> 
							<div class="col-md-6 pull left" align="left" style="color:##231f20 ;font-family: Helvetica, Arial, sans-serif;font-size:12pt" >	
<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_640x360_V1.jpg" border="0" class="img-responsive">  --->
							</div>		
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_R-SIDE-TEXT.jpg" border="0" class="img-responsive">  --->
						</div>
					</div>	 
					 <div class="row">
						<div class="col-md-12 no-pad visible-md visible-lg" align="center">
							
						</div>
					</div>	  
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/Toy_TradeIn_Booster_640x244_footer.jpg" border="0" class="img-responsive">  --->
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
			</div>  <!--- container --->
		</section>

	</cffunction>

	<cffunction name="modernregthankyou" description="shows a standard header" output="Yes" access="public">

	</cffunction>

	<cffunction name="modernbaierlregthankyou" description="shows a Baierl Thanks Page" output="Yes" access="public">

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>

</cfcomponent>