<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="false">
		<cfargument name="method_name" required="false">
		<cfargument name="display_type" default="">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
			<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Ultra10" name="Get_Control_Details">
			SELECT		Dealer_ID,
						dealer_directory
			FROM		Dealers
			WHERE		Dealer_id = 285
		</cfquery>
		<cfset variables.dlr_dir = #Get_Control_Details.Dealer_Directory#>
				
		<section class="section-spl">
			<div class="container" >
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			 	<div class="row">
					<div class="col-md-4 no-pad" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/CC_Logo_Positive_sm.jpg" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-8 no-pad" align="center" >				 
						<!--- <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png" border="0" class="img-responsive">  --->&nbsp;
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-8 " align="center" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<cfif Not IsDefined("url.error_message")>
									<cfset url.error_message = "Video unavailable">
								</cfif>
								<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
									<cfinvokeargument name="error_message" value="#url.error_message#"/>
								</cfinvoke>
								<br/>
								<a href="javascript:window.history.back()" class="btn btn-primary"><span style="font-size:14pt;color:blue;font-weight:bold">Go Back</span></a>
								<div class="row" >&nbsp;</div>
							</div>
							<div class="col-md-4" align="center"  >	
								 <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/right-side.png" border="0" class="img-responsive"> 
							</div>
						</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
						<div class="row" style="background-color:##0079c2" >&nbsp;</div>
					</div>
			</div>  <!--- container --->
		</section>


	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">
	</cffunction>

</cfcomponent>