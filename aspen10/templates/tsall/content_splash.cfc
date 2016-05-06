
<cfcomponent>


	<cffunction name="modern" description="SALL Form" output="Yes" access="public">
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
		
		<cfif IsDefined("url.page2")>
		
		<section class="section-spl">
			<div class="container" >
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			 	<div class="row">
					<div class="col-md-8 no-pad" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/logo.png" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-4 no-pad" align="center" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png" border="0" class="img-responsive"> 
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-8 " align="right" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<cfinvoke component="/cfcs/aspen10/forms/form_trade" method="sall_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/sall_action.cfm"/>
								</cfinvoke>  
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

		<cfelse>
<!--- Page 2 --->		
		<section class="section-spl">
			<div class="container" >
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			 	<div class="row">
					<div class="col-md-8 no-pad" align="left" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/logo.png" border="0" class="img-responsive"> 
					</div>
					<div class="col-md-4 no-pad" align="center" >				 
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/header-right.png" border="0" class="img-responsive"> 
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container" >
					<div class="row">
						<div class="row">
							<div class="col-md-8 " align="right" >	
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<div class="row" >&nbsp;</div>
								<cfinvoke component="/cfcs/aspen10/forms/form_trade" method="sall_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/sall_action.cfm"/>
								</cfinvoke>  
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
		
		</cfif>
		
	</cffunction>

	<cffunction name="modernregthankyou" description="shows a standard header" output="Yes" access="public">

	</cffunction>

	<cffunction name="modernbaierlregthankyou" description="shows a Baierl Thanks Page" output="Yes" access="public">

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>

</cfcomponent>