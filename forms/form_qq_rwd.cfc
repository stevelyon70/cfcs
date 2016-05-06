<cfcomponent>

	
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
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
                <p class="name">
                 <input  class="input-sm" id="firstName" name="firstName" type="text" placeholder="Name*" size="40" maxlength="30" required >
                </p>
                <p class="email">
                  <input  class="input-sm" id="Email" name="Email" type="text" placeholder="Email" size="40"  maxlength="50" required  >
                </p>
                <p class="dealership">
                  <input  class="input-sm" id="Dealership" name="Dealership" type="text" size="40"  placeholder="Dealership*" required maxlength="50" >
                </p>
                <p class="phone">
                  <input  class="input-sm" id="Phone" name="Phone" type="text" placeholder="Phone*" size="40"  maxlength="50"  required    >
                </p>
                <p class="submit">
                  <input type="submit" value="Send" />
                </p>
              </form>
		<!--<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<div class="form-group">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<input  class="input-sm" id="firstName" name="firstName" type="text" placeholder="First Name*" size="40" maxlength="30" required >
									<input  class="input-sm" id="lastName" name="lastName" type="text" placeholder="Last Name*" size="40" maxlength="30" required >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<input  class="input-sm" id="Email" name="Email" type="text" placeholder="Email* eg: your.name@gmail.com" size="40"  maxlength="50" required  >
									<input  class="input-sm" id="Phone" name="Phone" type="text" placeholder="Phone* eg: (412) 555-1212" size="40"  maxlength="50"  required    >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<input  class="input-sm" id="Dealership" name="Dealership" type="text" size="40"  placeholder="Dealership Name*" required maxlength="50" >
									 <input type="submit" value="Get Started!" class="RWDButtons">
								</div>	
							</div>	
						</div>
					</div>
				</fieldset>
			</form>-->
		</cffunction>
		
	<cffunction name="form_submit_rwd" description="AutoVIEW RWD contact info" output="yes" access="public">
  	
		<cfquery NAME="InsertUType" datasource="Ultra10">
		  INSERT into WD_Micro_Leads ( 	dealer_id ,  
		  								firstname , 
										dealership ,  
										email ,  
										phone  )
		  					VALUES ( 	#Form.Dealer_ID#,
										'#Form.firstname#',
										'#Form.dealership#',
										'#Form.email#',
										'#Form.phone#' )
		</cfquery>
	<!--- Sales@worlddealer.net --->
		
		<CFMAIL to="Sales@worlddealer.net" 
				bcc="techsupport@worlddealer.net"
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
							<li>Name: #Form.firstname#</li>
							<li>Email: #Form.email#</li>
							<li>Phone: #Form.phone#</li>
							<li>Dealership: #Form.dealership#</li>
							<li>Submitted: #dateformat(now(),"mm/dd/yyyy")# @ #timeformat(now(),"hh:mm tt")#</li>
						</ul>
					<BR><BR>
			</cfmail>
		<cfif #Form.email# NEQ "" >
			<CFMAIL to="#Form.email#" 
					bcc="techsupport@worlddealer.net"
					from="AutoVIEW@worlddealer.net"
					type="HTML"
					subject="AutoVIEW Thanks You" > 
				
				<font style="font-size: 12pt ;  font-family:verdana, sans-serif;font-weight: bold; color: black">
				Greetings #Form.firstname#,
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

</cfcomponent>
