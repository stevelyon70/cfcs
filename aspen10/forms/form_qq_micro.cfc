<cfcomponent>

	
	<cffunction name="qq_micro" description="quick quote open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="quick_quote">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		<cfargument name="voi_new_used" default="N">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
			
		<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
								<p class="help-block" align="left" style="color: red">* = Required </p>
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Name" name="Name" type="text" placeholder="Name*" maxlength="70" required >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	&nbsp;<!--- <label class="micro-label" for="Dealership">&nbsp;&nbsp;Dealership/Group:</label> --->
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Dealership" name="Dealership" type="text" placeholder="Dealership/Group*" maxlength="50" required  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 &nbsp;	<!--- <label class="micro-label" for="Email">&nbsp;&nbsp;Email:</label> --->
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Email" name="Email" type="text" placeholder="Email*" maxlength="50" required  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	&nbsp;<!--- <label class="micro-label" for="Phone">&nbsp;&nbsp;Phone:</label> --->
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="Phone" maxlength="50"    >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	&nbsp;<!--- <label class="micro-label" for="Website">&nbsp;&nbsp;Current Website:</label> --->
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Website" name="Website" type="text" placeholder="Current Website" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12" align="center">
							&nbsp;
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12" align="center">
							&nbsp;
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-1" align="center">
							&nbsp;
						</div>
						<div class="col-md-10" align="center" >
							<input   type="submit"  style="background-color:##2caa59;border:none;color: ##ffffff;font-size:12pt;font-weight:bold;-moz-border-radius: 10px;-webkit-border-radius: 10px;border-radius: 10px;border: none;cursor:pointer;" value=" Make My Site Responsive! ">
						</div>
					</div>
				</fieldset>
			</form>
	
  			<h3 align="center" class="visible-sm visible-xs"><a href="tel:18664858800">Or tap to call (866) 485-8800</a></h3>
		    <h3 align="center" class="visible-md visible-lg">Or call us to get started<br>(866) 485-8800</h3>
			
	</cffunction>
	
	<cffunction name="qq_micro_rwd" description="quick quote RWD form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="quick_quote">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		<cfargument name="voi_new_used" default="N">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
			
		<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<!--- <div class="row">
								<div class="col-md-12">
								<p class="help-block" align="left" style="color: red">* Required </p>
								</div>	
							</div>	 --->
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Name" name="Name" type="text" placeholder="Name*" maxlength="70" required >
								</div>	
							</div>	
						</div>
					</div>
					<!--- <div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Dealership" name="Dealership" type="text" placeholder="Dealership/Group*" maxlength="50" required  >
								</div>	
							</div>	
						</div>
					</div> --->
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Email" name="Email" type="text" placeholder="Email*" maxlength="50" required  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<!--- <div class="row">
								<div class="col-md-12 ">
								 	&nbsp;<!--- <label class="micro-label" for="Phone">&nbsp;&nbsp;Phone:</label> --->
								</div>	
							</div>	 --->
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="Phone" maxlength="50"  required    >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-1" align="center">
							&nbsp;
						</div>
						<div class="col-md-10" align="center" >
							<input class="srch-tabs-green"  type="submit" value=" Please Contact Me ">
						</div>
					</div>
				</fieldset>
			</form>
	<!--- 
  			<h3 align="center" class="visible-sm visible-xs"><a href="tel:18664858800">Or tap to call (866) 485-8800</a></h3>
		    <h3 align="center" class="visible-md visible-lg">Or call us to get started<br>(866) 485-8800</h3>
			 --->
	</cffunction>
	
	<cffunction name="register_micro" description="Registration open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="quick_quote">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		<cfargument name="voi_new_used" default="N">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="GET OUR BEST PRICE NOW">
					
		<cfargument name="show_labels" default="false">


		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
			
		<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<cfif #url.Dealer_ID# EQ 199>
						<input name="authorization" id="authorization" type="hidden"  value="74686"/>
						<input id="Current_Vehicle" name="Current_Vehicle" type="hidden" value="" >
						</cfif>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Name" name="Name" type="text" placeholder="* Name" size="30" maxlength="50" required >
								</div>
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Address1" name="Address1" type="text" placeholder="Address 1" size="30" maxlength="50"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Address2" name="Address2" type="text" placeholder="Address 2" size="30" maxlength="50"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="City" name="City" type="text" placeholder="City" size="30" maxlength="50"   >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="State" name="State" type="text" placeholder="State" size="30" maxlength="50"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Zip" name="Zip" type="text" placeholder="Zip" size="10" maxlength="10"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<cfif #url.dealer_id# eq 199 >
										<input  class="form-control" id="Email" name="Email" type="text" placeholder="* Email" size="30" maxlength="50"  required   >
									<cfelse>	
										<input  class="form-control" id="Email" name="Email" type="text" placeholder="Email" size="30" maxlength="50"     >
									</cfif>	
								</div>	<!--- <span style="font-size:12pt;font-weight:bold;color:red" >*</span> --->
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<cfif #url.dealer_id# eq 199 >
										<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="* Phone" maxlength="30" required  >
									<cfelse>
										<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="Phone" maxlength="30"    >
									</cfif>
								</div>	<!--- <span style="font-size:12pt;font-weight:bold;color:red" >*</span> --->
							</div>	
						</div>
					</div>
					<cfif #url.Dealer_ID# NEQ 199>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Current_Vehicle" name="Current_Vehicle" type="text" placeholder="Current Vehicle" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					</cfif>	
					<cfif #url.Dealer_ID# NEQ 199>
						<div class="form-group qq-input">
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-5">
										<input  class="form-control" id="Authorization" name="Authorization" type="text" placeholder="* Authorization" size="5" maxlength="5" required >
										<span class="help-block no-pad red-help">&nbsp;* Sales Associate Only</span>
									</div>	
								</div>	
							</div>
						</div>
					</cfif>	
					<!--- <div class="form-group qq-input">
						<div class="col-md-12" align="center"> 
						</div>
					</div> --->
					<div class="form-group qq-input">
						<div class="col-md-12"<cfif #url.Dealer_ID# NEQ 199> align="right"<cfelse> align="center"</cfif>>
							<input type="image" src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/BigSubmit.png" class="img-responsive" id="submit" name="submit" value=""  >
						</div>
					</div>
				</fieldset>
			</form>
	
	</cffunction>
	
	<cffunction name="register_micro_short" description="Registration open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="quick_quote">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		<cfargument name="voi_new_used" default="N">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="GET OUR BEST PRICE NOW">
					
		<cfargument name="show_labels" default="false">


		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
			
		<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<cfif #url.dealer_id# eq 203 >
						<input name="authorization" id="authorization" type="hidden"  value="74686"/>
						<input name="Address1" id="Address1" type="hidden"  value=""/>
						<input name="Address2" id="Address2" type="hidden"  value=""/>
						<input name="City" id="City" type="hidden"  value=""/>
						<input name="State" id="State" type="hidden"  value=""/>
						<input name="Zip" id="Zip" type="hidden"  value=""/>
					</cfif>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Name" name="Name" type="text" placeholder="* First and Last Name" size="30" maxlength="50" required >
								</div>
							</div>	
						</div>
					</div>
					<!--- 
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Address1" name="Address1" type="text" placeholder="Address 1" size="30" maxlength="50"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Address2" name="Address2" type="text" placeholder="Address 2" size="30" maxlength="50"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="City" name="City" type="text" placeholder="City" size="30" maxlength="50"   >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="State" name="State" type="text" placeholder="State" size="30" maxlength="50"  >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Zip" name="Zip" type="text" placeholder="Zip" size="10" maxlength="10"  >
								</div>	
							</div>	
						</div>
					</div> --->
					
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="* Phone" maxlength="30" required  >
								</div>	 
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<cfif #url.dealer_id# eq 203 >
										<input  class="form-control" id="Email" name="Email" type="text" placeholder="* Email" size="30" maxlength="50"  required   >
									<cfelse>	
										<input  class="form-control" id="Email" name="Email" type="text" placeholder="Email" size="30" maxlength="50"     >
									</cfif>	
								</div>	 
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Current_Vehicle" name="Current_Vehicle" type="text" placeholder="Current Vehicle" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<!--- 
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<cfif #url.dealer_id# eq 199 >
										<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="* Phone" maxlength="30" required  >
									<cfelse>
										<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="Phone" maxlength="30"    >
									</cfif>
								</div>	<!--- <span style="font-size:12pt;font-weight:bold;color:red" >*</span> --->
							</div>	
						</div>
					</div>
					<cfif #url.Dealer_ID# NEQ 199>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md ">
								</div>
								<div class="col-md-11">
									<input  class="form-control" id="Current_Vehicle" name="Current_Vehicle" type="text" placeholder="Current Vehicle" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					</cfif>	
					<cfif #url.Dealer_ID# NEQ 199>
						<div class="form-group qq-input">
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-5">
										<input  class="form-control" id="Authorization" name="Authorization" type="text" placeholder="* Authorization" size="5" maxlength="5" required >
										<span class="help-block no-pad red-help">&nbsp;* Sales Associate Only</span>
									</div>	
								</div>	
							</div>
						</div>
					</cfif>	 --->
					 <div class="form-group qq-input">
						<div class="col-md-12" align="center"> &nbsp;
						</div>
					</div>  
					<div class="form-group qq-input">
						<div class="col-md-12"align="center">
							<input type="image" src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/BigSubmit.png" class="img-responsive" id="submit" name="submit" value=""  >
						</div>
					</div>
				</fieldset>
			</form>
	
	</cffunction>
	
	<cffunction name="form_submit" description="default contact layout" output="yes" access="public">
  	
		<cfquery NAME="InsertUType" datasource="Aspen10">
		  INSERT into WD_Micro_Leads ( 	dealer_id ,  
		  								name ,  
										dealership ,  
										email ,  
										phone ,  
										website )
		  					VALUES ( 	#Form.Dealer_ID#,
										'#Form.name#',
										'#Form.dealership#',
										'#Form.email#',
										'#Form.phone#',
										<cfif #Form.website# NEQ "" >
											'#Form.website#'
										<cfelse>
											'None Provided'
										</cfif>  )
		</cfquery>
	
	<cfif #form.dealer_id# EQ 133>
		<CFMAIL to="paul@worlddealer.net,dan@worlddealer.net,kelly@worlddealer.net" 
				from="WDRWD@worlddealer.net"
					bcc="bob@worlddealer.net"
					type="HTML"
					subject="Toyota WorldDealer RWD Microsite" > 
					
					<font style="font-size: 12pt ; font-weight: bold; color: black">
					Greetings,
					<BR><BR>	
					<font style="font-size: 12pt ; font-weight: bold; color: black">
					The following was received from the Toyota WorldDealer RWD Microsite:
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						<ul>
							<li>Name: #Form.name#</li>
							<li>Dealership: #Form.dealership#</li>
							<li>Email: #Form.email#</li>
							<li>Phone: #Form.phone#</li>
							<li>Website: #Form.website#</li>
							<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
						</ul>
					<BR><BR>
			</cfmail>
	<cfelse>		
		<CFMAIL to="paul@worlddealer.net,dan@worlddealer.net,kelly@worlddealer.net" 
				from="WDRWD@worlddealer.net"
					bcc="bob@worlddealer.net"
					type="HTML"
					subject="Generic WorldDealer RWD Microsite" > 
					
					<font style="font-size: 12pt ; font-weight: bold; color: black">
					Greetings,
					<BR><BR>	
					<font style="font-size: 12pt ; font-weight: bold; color: black">
					The following was received from the Generic WorldDealer RWD Microsite:
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						<ul>
							<li>Name: #Form.name#</li>
							<li>Dealership: #Form.dealership#</li>
							<li>Email: #Form.email#</li>
							<li>Phone: #Form.phone#</li>
							<li>Website: #Form.website#</li>
							<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
						</ul>
					<BR><BR>
			</cfmail>
		</cfif>

	</cffunction>
	
	<cffunction name="form_submit_rwd" description="AutoVIEW RWD contact info" output="yes" access="public">
  	
		<cfquery NAME="InsertUType" datasource="Aspen10">
		  INSERT into WD_Micro_Leads ( 	dealer_id ,  
		  								name ,  
										dealership ,  
										email ,  
										phone ,  
										website )
		  					VALUES ( 	#Form.Dealer_ID#,
										'#Form.name#',
										null,
										'#Form.email#',
										'#Form.phone#',
										null  )
		</cfquery>
	
		
		<CFMAIL to="Sales@worlddealer.net" 
				bcc="bob@worlddealer.net"
				from="AutoVIEW@worlddealer.net"
				type="HTML"
				subject="AutoVIEW Microsite" > 
					
					<font style="font-size: 12pt ; font-family:verdana, sans-serif; font-weight: bold; color: black">
					Greetings,
					<BR><BR>	
					<font style="font-size: 12pt ; font-family:verdana, sans-serif; font-weight: bold; color: black">
					The following was received from the AutoVIEW Microsite:
						<font style="font-size: 12pt ; font-family:verdana, sans-serif; font-weight: bold; color: black">
						<ul>
							<li>Name: #Form.name#</li>
							<li>Email: #Form.email#</li>
							<li>Phone: #Form.phone#</li>
							<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
						</ul>
					<BR><BR>
			</cfmail>
		<cfif #Form.email# NEQ "" >
			<CFMAIL to="#Form.email#" 
					bcc="bob@worlddealer.net"
					from="AutoVIEW@worlddealer.net"
					type="HTML"
					subject="AutoVIEW Thanks You" > 
				
				<font style="font-size: 12pt ;  font-family:verdana, sans-serif;font-weight: bold; color: black">
				Greetings #RTrim(Form.name)#,
				<BR><BR>	
				<font style="font-size: 12pt ; font-family:verdana, sans-serif; font-weight: bold; color: black">
				Thank you for your interest in AutoView, the NEW Responsive Website platform from WorldDealer.<br>
				One of our sales associates will be contacting you shortly.<br><br>
				Best Regards, <br><br>
				Team WorldDealer
					<BR><BR>
				</cfmail>
			</cfif>	

	</cffunction>
	
	<cffunction name="form_register_submit" description="default Contest Registration DB Comit" output="yes" access="public">
	
		<cfif #form.authorization# NEQ "74686">
			<cfset url.error_message = "yes">
		<cfelse>
			<cfquery NAME="InsertUType" datasource="Aspen10">
			  INSERT into WD_Contest_Registration ( 	dealer_id,  
			  											name,  
														address1,  
														address2,
														city,
														state,
														zip,
														email ,  
														phone ,  
														current_vehicle )
						  					VALUES ( 	#Form.Dealer_ID#,
														'#Form.name#',
														'#Form.address1#',
														'#Form.address2#',
														'#Form.city#',
														'#Form.state#',
														'#Form.zip#',
														'#Form.email#',
														'#Form.phone#',
														<cfif #Form.current_vehicle# NEQ "" >
															'#Form.current_vehicle#'
														<cfelse>
															'None Provided'
														</cfif>  )
			</cfquery>
	
			<cfif #url.dealer_id# eq 196 >   <!--- Baierl Ford --->
				<CFMAIL to="bob@worlddealer.net" 
						from="WDContest@worlddealer.net"
						type="HTML"
						subject="Toby Keith Registration Confirmation" > 
						
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						Greetings,
						<BR><BR>	
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						The following was received from the Baierl Ford Toby Keith Microsite:
							<font style="font-size: 12pt ; font-weight: bold; color: black">
							<ul>
								<li>Name: #Form.name#</li>
								<li>Address 1: #Form.address1#</li>
								<li>Address 2: #Form.address2#</li>
								<li>City: #Form.city#</li>
								<li>State: #Form.state#</li>
								<li>Zip: #Form.zip#</li>
								<li>Email: #Form.email#</li>
								<li>Phone: #Form.phone#</li>
								<li>Vehicle: #Form.current_vehicle#</li>
								<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
							</ul>
						<BR><BR>
				</cfmail>
			</cfif>
			<cfif #url.dealer_id# eq 199 >   <!--- Fuccillo --->
				<CFMAIL to="buffalogiveaway@fuccillo.com" 
						from="FuccilloContest@worlddealer.net"
						bcc="bob@pinto302.com" 
						type="HTML"
						subject="Fuccillo Contest Registration Confirmation" > 
						
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						Greetings,
						<BR><BR>	
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						The following was received from the Fuccillo Contest Microsite:
							<font style="font-size: 12pt ; font-weight: bold; color: black">
							<ul>
								<li>Name: #Form.name#</li>
								<li>Address 1: #Form.address1#</li>
								<li>Address 2: #Form.address2#</li>
								<li>City: #Form.city#</li>
								<li>State: #Form.state#</li>
								<li>Zip: #Form.zip#</li>
								<li>Email: #Form.email#</li>
								<li>Phone: #Form.phone#</li>
								<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
							</ul>
						<BR><BR>
				</cfmail>
			</cfif>
			<cfif #url.dealer_id# eq 197 >   <!--- Stuckey --->
				<CFMAIL to="bob@worlddealer.net" 
						from="StuckeyContest@worlddealer.net"
						bcc="bob@pinto302.com" 
						type="HTML"
						subject="Stuckey Ford Subaru Contest Registration" > 
						
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						Greetings,
						<BR><BR>	
						<font style="font-size: 12pt ; font-weight: bold; color: black">
						The following was received from the Stuckey Ford Subaru Contest Microsite:
							<font style="font-size: 12pt ; font-weight: bold; color: black">
							<ul>
								<li>Name: #Form.name#</li>
								<li>Address 1: #Form.address1#</li>
								<li>Address 2: #Form.address2#</li>
								<li>City: #Form.city#</li>
								<li>State: #Form.state#</li>
								<li>Zip: #Form.zip#</li>
								<li>Email: #Form.email#</li>
								<li>Phone: #Form.phone#</li>
								<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
							</ul>
						<BR><BR>
				</cfmail>
			</cfif>
			
			<cfif #url.dealer_id# eq 203 >   <!--- Baierl Subaru --->
				<CFMAIL to="bob@worddealer.net" 
						from="BaierlOutbackRunback@worlddealer.net"
						type="HTML"
						subject="Baierl Subaru Contest Registration Confirmation" > 
						
						<font style="font-family:Arial, Helvetica, sans-serif;font-size: 12pt ; font-weight: bold; color: ##000066">
						Greetings,
						<BR><BR>	
						<font style="font-family:Arial, Helvetica, sans-serif;font-size: 12pt ; font-weight: bold; color: ##000066">
						The following was received from the Baierl Subaru Contest Microsite:
							<font style="font-family:Arial, Helvetica, sans-serif;font-size: 12pt ; font-weight: bold; color: ##000066">
							<ul>
								<li>Name: #Form.name#</li>
								<!--- <li>Address 1: #Form.address1#</li>
								<li>Address 2: #Form.address2#</li>
								<li>City: #Form.city#</li>
								<li>State: #Form.state#</li>
								<li>Zip: #Form.zip#</li> --->
							 	<li>Phone: #Form.phone#</li>  
								<li>Email: #Form.email#</li> 
							 	<li>Current Vehicle: #Form.current_vehicle#</li> 
								<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
							</ul>
						<BR><BR>
				</cfmail>
				<CFMAIL to="#Form.email#" 
						from="BaierlOutbackRunback@worlddealer.net"
						type="HTML"
						subject="Baierl Subaru Contest Registration Confirmation" > 
						
						<font style="font-family:Arial, Helvetica, sans-serif;font-size: 12pt ; font-weight: bold; color: ##000066">
						Greetings Pitt Fan, 
						<BR><BR>	
						<font style="font-family:Arial, Helvetica, sans-serif;font-size: 12pt ; font-weight: bold; color: ##000066">
						Thank You For Your Registration and Good Luck!<br><br>
						<BR>	
						<font style="font-family:Arial, Helvetica, sans-serif;font-size: 12pt ; font-weight: bold; color: ##000066">
							Throughout the years, Pitt-Panther fans have enjoyed watching All-American Panthers Marino, Fralic, Green and Dorsett do their thing.<br><br>
							In celebration of the Pitt-Panther's 125th anniversary, we are offering Pitt fans these All-American Baierl Subaru coupons!<br>
							Hail to Pitt!
							<br><br>
						<font style="font-family:Arial, Helvetica, sans-serif;font-size: 20pt ; font-weight: bold; color: ##000066">
						<table border="0" >
						<tr><td valign="TOP" >
						<img src="http://dealers.wdautos.com/dealer/baierloutbackrunback/images/icons/TheFralic2.jpg" alt="The Fralic" border="0" class="img-responsive"> 	
						</td>
						<!--- </tr>
						<tr> --->
						<td valign="TOP" >
						<img src="http://dealers.wdautos.com/dealer/baierloutbackrunback/images/icons/TheDorsett2.jpg" alt="The Dorsett" border="0" class="img-responsive"> 	
						</td>
						</tr>
						<tr><td valign="TOP" >
						<img src="http://dealers.wdautos.com/dealer/baierloutbackrunback/images/icons/TheGreen2.jpg" alt="The Green" border="0" class="img-responsive"> 	
						</td>
						<!--- </tr>
						<tr> --->
						<td valign="TOP" >
						<img src="http://dealers.wdautos.com/dealer/baierloutbackrunback/images/icons/TheMarino2.jpg" alt="The Marino" border="0" class="img-responsive"> 	
						</td></tr>
						</table>
						<BR><BR>
				</cfmail>
			</cfif>
	
		</cfif>
	</cffunction>

</cfcomponent>
