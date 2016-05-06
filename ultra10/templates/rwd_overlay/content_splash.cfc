
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
						<img alt="Car" src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/car.gif" border="0" class="img-responsive"> 
					</div>
				</div> 
				<div class="row"><div class="col-md-12">&nbsp;</div></div>
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container">
					<div class="row" >
						<cfset main_image = "BlackFridayBaierlSub_off.jpg" >
						<cfset site_addr = "rwd.worlddealer.net" >
						<div class="col-md-12 no-pad" align="center">	
							<img alt="Main" src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/#main_image#" border="0" class="img-responsive"> 
						</div>
					</div>
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive"> --->
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
					<div class="row">
						<div class="row">
							<div class="col-md-12" align="center" style="color:##231f20 ;font-family: Helvetica, Arial, sans-serif;font-size:12pt" >	<!--- Body Text --->
							  		<h3><i><b>This is a Test of the Emergency Site "Take-Over" Page.</b></i></h3>

							</div>
						</div>
					</div>
	
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive"> --->
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
					 <div class="row">
						<div class="col-md-12 no-pad visible-md visible-lg" align="center">
							<a href="http://fuccillo.com" style="font-size:20pt;color:blue"  ><u>Click Here to end up where you wanted to go in the first place!</u></a>
						</div>
					</div>	  
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive"> --->
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