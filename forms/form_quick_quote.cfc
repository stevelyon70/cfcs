<cfcomponent>

	<cffunction name="qq_default" description="default quick-quote layout" output="yes" access="public">
		<form class="form-horizontal" action="" id="quick_quote" name="quick_quote" method="post" >
			<fieldset>
				<input name="vin" id="vin" type="hidden"  value="#left(arguments.v_vin,17)#"/>
				<div class="form-group">
					<div class="col-md-12">
						<input  class="form-control input-md" id="first_name" name="first_name" type="text" placeholder="First Name" required="">
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12">
						<input class="form-control input-md" id="last_name" name="last_name" type="text" placeholder="Last Name" required="">
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12">
						<input class="form-control input-md bfh-phone" id="phone_1" name="phone_1" type="text" placeholder="Phone" data-format="ddd-ddd-dddd">
						<span class="help-block">format: xxx-xxx-xxxx</span>  
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12">
						<input class="form-control input-md" id="email" name="email" type="email" placeholder="Email" required="">
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12">                     
						<textarea class="form-control" id="comments" name="comments" placeholder="Comments"></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12">
						<input class="btn btn-primary" type="submit" id="submit" name="submit" value="SCHEDULE YOUR TEST DRIVE">
					</div>
				</div>
			</fieldset>
		</form>
	</cffunction>

	<cffunction name="qq_details" description="quick quote open form" output="yes" access="public">

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
		<!--- 
			<cfswitch expression="#arguments.dealer_id#">
				<cfcase value="36,37,28,25">	
					<cfargument name="button_label" default="Get e-Price--">
					
				</cfcase>	
				<cfdefaultcase>	
					<cfargument name="button_label" default="GET OUR BEST PRICE NOW">
				</cfdefaultcase>	
			</cfswitch> --->
			
		<cfargument name="show_labels" default="false">
		
		<cfif #arguments.dealer_id# EQ 18 > <!--- Kelly Nissan of Rt33 --->
			<cfset arguments.button_label = "CHECK FOR MORE SAVINGS" >
		</cfif>
		  <cfif #arguments.dealer_id# EQ 30 >  
			<cfset arguments.button_label = "Send Your Request" >
		</cfif>   
		<cfif #arguments.dealer_id# EQ 36 or #arguments.dealer_id# EQ 37 or #arguments.dealer_id# EQ 28 or #arguments.dealer_id# EQ 25   >  
			<cfset arguments.button_label = "Get ePrice" >
			
		</cfif>
		<cfif #url.dealer_id# EQ 38 OR  #url.dealer_id# EQ 179  OR  #url.dealer_id# EQ 45  >  
			<cfset arguments.button_label = "Send" >
			
		</cfif>
		<!--- <cfif  #arguments.dealer_id# EQ 78 and  #arguments.voi_new_used# EQ "N" >  
			<cfset arguments.button_label = "Get ePrice" >
			
		</cfif> --->
	
		<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
			<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
				<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
				<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
				<div class="form-group  qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control" id="First_Name" name="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
					</div>
				</div>
				<div class="form-group  qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control" id="Last_Name" name="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control input-md" id="Phone_1" name="Phone_1" type="text" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<p class="help-block">Numbers Only - no hyphens or parenthesesx</p>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control" id="Email" name="Email" type="Email" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">                     
						<textarea style="width:100%" class="form-control" id="Comments" name="Comments"  value="Comments" onfocus="if (this.value=='Comments') this.value = ''" onblur="if (this.value=='') this.value = 'Comments'">Comments</textarea>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12"> 
							<cfif #url.dealer_id# NEQ 38 and  #url.dealer_id# NEQ 179 and  #url.dealer_id# NEQ 45 >
								<input class="btn btn-navy" type="submit" id="submit" name="submit" value="#arguments.button_label#" <cfif url.sdds eq 1> onclick="tmsomni.linkTrackEvents = 'event54';"</cfif>>
							<cfelse>
								<input class="btn btn-primary" type="submit" id="submit" name="submit" value="Send" <cfif url.sdds eq 1> onclick="tmsomni.linkTrackEvents = 'event54';"</cfif>>
							</cfif>	
						<!--- <input class="btn btn-navy" type="submit" id="submit" name="submit" value="#arguments.button_label#"> --->
					</div>
				</div>
			</form>		
		<cfelse>
			<!--- VDP Button --->
			<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<input  class="form-control" id="First_Name" name="First_Name" type="text" placeholder="First Name" maxlength="50" required>
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<input class="form-control" id="Last_Name" name="Last_Name" type="text" placeholder="Last Name" maxlength="50" required>
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<input class="form-control input-md" id="Phone_1" name="Phone_1" type="text" placeholder="Phone" maxlength="10">
							<p class="help-block">Numbers Only - no hyphens or parentheses</p>
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<input class="form-control" id="Email" name="Email" type="Email" placeholder="Email" required>
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">                     
							<textarea class="form-control" id="Comments" name="Comments" placeholder="Comments"></textarea>
						</div>
					</div>
					<div class="form-group qq-input">
						<cfif #arguments.dealer_id# EQ 36 or #arguments.dealer_id# EQ 37 or #arguments.dealer_id# EQ 28 or #arguments.dealer_id# EQ 25 or #arguments.dealer_id# EQ 30  > 
							<div class="col-md-12" >
							  <input class="btn btn-green" type="submit" id="submit" name="submit" value="#arguments.button_label#" <cfif url.dealer_id EQ 37> onSubmit = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(true, 'o', 'getquickquote');" </cfif>> <!--- small form on detail page --->
						<cfelse>	
							<div class="col-md-12">
							<cfif #url.dealer_id# NEQ 38 and #url.dealer_id# NEQ 179 and  #url.dealer_id# NEQ 45  >
								<input class="btn btn-navy" type="submit" id="submit" name="submit" value="#arguments.button_label#" <cfif url.sdds eq 1> onclick="tmsomni.linkTrackEvents = 'event54';"</cfif>>
							<cfelse>
								<input class="btn btn-primary" type="submit" id="submit" name="submit" value="Send" <cfif url.sdds eq 1> onclick="tmsomni.linkTrackEvents = 'event54';"</cfif>>	
							</cfif>	
						</cfif>	
						</div>
					</div>
				</fieldset>
			</form>
			
		</cfif>
	
	</cffunction>


	<cffunction name="qq_details_new" description="quick quote open form" output="yes" access="public">

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
		<cfargument name="button_label" default="LOCK IN YOUR SAVINGS">
			
		<cfargument name="show_labels" default="false">
		
		<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
			<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
				<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
				<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
				<div class="form-group  qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control" id="First_Name" name="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
					</div>
				</div>
				<div class="form-group  qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control" id="Last_Name" name="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control input-md" id="Phone_1" name="Phone_1" type="text" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<p class="help-block">Numbers Only - no hyphens or parenthesesx</p>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">
						<input style="width:100%" class="form-control" id="Email" name="Email" type="Email" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12">                     
						<textarea style="width:100%" class="form-control" id="Comments" name="Comments"  value="Comments" onfocus="if (this.value=='Comments') this.value = ''" onblur="if (this.value=='') this.value = 'Comments'">Comments</textarea>
					</div>
				</div>
				<div class="form-group qq-input">
					<div class="col-md-12"> 
							<cfif #url.dealer_id# NEQ 38 and  #url.dealer_id# NEQ 179 and  #url.dealer_id# NEQ 45 >
								<input class="btn btn-navy" type="submit" id="submit" name="submit" value="#arguments.button_label#">
							<cfelse>
								<input class="btn btn-primary" type="submit" id="submit" name="submit" value="Send">	
							</cfif>	
						<!--- <input class="btn btn-navy" type="submit" id="submit" name="submit" value="#arguments.button_label#"> --->
					</div>
				</div>
			</form>		
		<cfelse>
			<!--- VDP Button --->
			<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<input  class="form-control" id="First_Name" name="First_Name" type="text" placeholder="First Name" maxlength="50" required>
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<input class="form-control" id="Last_Name" name="Last_Name" type="text" placeholder="Last Name" maxlength="50" required>
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<input class="form-control input-md" id="Phone_1" name="Phone_1" type="text" placeholder="Phone (Numbers Only)" maxlength="10">
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<input class="form-control" id="Email" name="Email" type="Email" placeholder="Email" required>
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">                     
							<textarea class="form-control" id="Comments" name="Comments" cols="50" rows="4" placeholder="Comments"></textarea>
						</div>
					</div>
					<div class="form-group qq-input">
						<cfif #arguments.dealer_id# EQ 36 or #arguments.dealer_id# EQ 37 or #arguments.dealer_id# EQ 28 or #arguments.dealer_id# EQ 25 or #arguments.dealer_id# EQ 30  > 
							<div class="col-md-12" >
							  <input class="btn btn-green" type="submit" id="submit" name="submit" value="#arguments.button_label#" <cfif url.dealer_id EQ 37> onSubmit = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(true, 'o', 'getquickquote');" </cfif>> <!--- small form on detail page --->
						<cfelse>	
							<div class="col-md-12">
							<cfif #url.dealer_id# NEQ 38 and #url.dealer_id# NEQ 179 and  #url.dealer_id# NEQ 45  >
								<input class="btn btn-srp-form" type="submit" id="submit" name="submit" value="#arguments.button_label#">
							<cfelse>
								<input class="btn btn-primary" type="submit" id="submit" name="submit" value="Send">	
							</cfif>	
						</cfif>	
						</div>
					</div>
				</fieldset>
			</form>
			
		</cfif>
	
	</cffunction>

	<cffunction name="form_popup" description="quick quote open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Get a Quote">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/qq_action.cfm">
		<cfargument name="form_name" default="quick_quote">

		<form id="quick_quote_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
						
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>   <!---  Fayette Honda 10-07 Bob  --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<cfif #url.dealer_id# neq 25  and #url.dealer_id# neq 36 and #url.dealer_id# neq 37 and #url.dealer_id# neq 28 >  <!--- WAM 10-08 bob --->
							<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
						<cfelse>
							
							<input type="submit" class="btn btn-primary" id="Contact_Us" value="Check Availability">
						</cfif>
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>


	<cffunction name="form_mao_popup" description="Make an Offer open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Get a Quote">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/qq_action.cfm">
		<cfargument name="form_name" default="quick_quote">

		<form id="quick_quote_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>    
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments"><span class="txt-red">*</span> Make an Offer</label>
					<div class="col-md-6">                     
						<input name="Comments" class="form-control input-md" id="Comments" type="text" maxlength="50" placeholder="Make an Offer" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
							<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>

	<!--- eprice--->
	
	<cffunction name="form_ePrice" description="ePrice form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Get a Quote">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/qq_action.cfm?mode=ePrice">
		<cfargument name="form_name" default="quick_quote">

		<form id="quick_quote_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>   <!---  Fayette Honda 10-07 Bob  --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<!---<cfif #url.dealer_id# neq 25  and #url.dealer_id# neq 36 and #url.dealer_id# neq 37 and #url.dealer_id# neq 28 >  <!--- WAM 10-08 bob --->
							<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
						<cfelse>													
						</cfif>--->
						
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Get e-Price">
					</div>
				</div>
			</fieldset>
		</form>
		
	</cffunction>

	<!--- eprice--->
	
	<cffunction name="form_addsave" description="Additional Savings form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Get a Quote">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/qq_action.cfm?mode=aSaving">
		<cfargument name="form_name" default="quick_quote">

		<form id="quick_quote_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>   <!---  Fayette Honda 10-07 Bob  --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<!---<cfif #url.dealer_id# neq 25  and #url.dealer_id# neq 36 and #url.dealer_id# neq 37 and #url.dealer_id# neq 28 >  <!--- WAM 10-08 bob --->
							<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
						<cfelse>													
						</cfif>--->
						
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Get Savings">
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>
	
	
	
	
	
	
	<!---eprice --->
	
	<cffunction name="form_popup_available" description="quick quote form for AVAILABILTY" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Check Availability">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/qq_action.cfm">
		<cfargument name="form_name" default="quick_quote">

		<form id="quick_quote_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
			<input name="chk_avail" id="chk_avail" type="hidden"  value="xxx"/>
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<div class="form-group">
					<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					<div class="col-md-6">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					<div class="col-md-6">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>   <!---  Fayette Honda 10-07 Bob  --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					<div class="col-md-6">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
						<p class="help-block">If you are already working with someone.</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Comments">Comments</label>
					<div class="col-md-6">                     
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Check Availability">
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>


	<cffunction name="form_popup_legacy" description="quick quote open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Get a Quote">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/qq_action.cfm">
		<cfargument name="form_name" default="quick_quote">

		<form id="quick_quote_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>

			<table style="width:100%">
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="First_Name"><span class="txt-red">*</span> First Name</label>
					</td>
					<td style="width:50%;">
						<input name="First_Name" class="form-control input-md" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Last_Name"><span class="txt-red">*</span> Last Name</label>
					</td>
					<td style="width:50%;">
						<input name="Last_Name" class="form-control input-md" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Phone_1">Phone</label>
					</td>
					<td style="width:50%;">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					</td>
					<td style="width:50%;">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Sales_Rep">Rep Name</label>
					</td>
					<td style="width:50%;">
						<input name="Sales_Rep" class="form-control input-md" id="Sales_Rep" type="text" maxlength="100" placeholder="Dealership Representative">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<p class="help-block">If you are already working with someone.</p>
					</td>
				</tr>
				<tr>
					<td style="width:50%;" align="right">
						<label class="control-label col-md-3" for="Comments">Comments</label>
					</td>
					<td style="width:50%;">
						<textarea name="Comments" class="form-control input-md" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="#arguments.btn_label#">
					</td>
				</tr>
			</table>
		</form>
	
	</cffunction>
	
	<cffunction name="qq_chrome" description="default quick-quote layout" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		<cfargument name="voi_new_used" default="N">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="Request Quote">
		<cfargument name="show_labels" default="false">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<form class="" action="#arguments.form_action#" method="post">
		
			<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
			<input type="hidden" name="voi_new_used" id="voi_new_used" value="#arguments.voi_new_used#">
			<input type="hidden" name="voi_vin" id="voi_vin" value="#arguments.voi_vin#">
			<input type="hidden" name="voi_year" id="voi_year" value="#arguments.voi_year#">
			<input type="hidden" name="voi_make" id="voi_make" value="#arguments.voi_make#">
			<input type="hidden" name="voi_model" id="voi_model" value="#arguments.voi_model#">
		
			<cfif arguments.show_labels eq "true">
				<label class="" for="First_Name">First Name</label>
			</cfif>
			<input class="#arguments.input_class#" name="First_Name" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
			<br/>
		
			<cfif arguments.show_labels eq "true">
				<label class="" for="Last_Name">Last Name</label>
			</cfif>
			<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
			<br/>
			
			<cfif arguments.show_labels eq "true">
				<label class="" for="Phone_1">Phone</label>
			</cfif>
			<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone"><br/>
			<p class="help-block">numbers only - no hyphens or parentheses</p>
			
			<cfif arguments.show_labels eq "true">
				<label class="" for="Email">Email</label>
			</cfif>
			<input class="#arguments.input_class#" name="Email" id="Email" type="email" maxlength="100" placeholder="Email" required>
			<br/>
			
			<cfif Get_Form_Locations.Recordcount gt 0>
			
				<cfif arguments.show_labels eq "true">
					<label class="" for="Delivery_Dealer_ID">Preferred Dealership</label>
				</cfif>
				<select class="#arguments.input_class#" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" required>
					<option value="">Select a Dealer</option>
					<cfloop query="Get_Form_Locations">
					<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
					</cfloop>
				</select>
				<br/>
			
			<cfelse>
			
				<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
			
			</cfif>
			
			<cfif arguments.show_labels eq "true">
				<label class="" for="Comments">Comments</label>
			</cfif>
			<textarea class="#arguments.input_class#" name="Comments" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
			<br/>
			
			<input class="#arguments.button_class# btn-primary" name="Contact_Us" id="Contact_Us" type="submit" value="#arguments.button_label#">
		
		</form>
	
	</cffunction>

	
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
		<cfargument name="button_label" default="GET OUR BEST PRICE NOW">
					
		<cfargument name="show_labels" default="false">
			
		<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
					<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	<label class="micro-label" for="Name">&nbsp;&nbsp;Name:</label>
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Name" name="Name" type="text" placeholder="" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	<label class="micro-label" for="Dealership">&nbsp;&nbsp;Dealership/Group:</label>
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Dealership" name="Dealership" type="text" placeholder="" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	<label class="micro-label" for="Email">&nbsp;&nbsp;Email:</label>
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Email" name="Email" type="text" placeholder="" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	<label class="micro-label" for="Phone">&nbsp;&nbsp;Phone:</label>
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Phone" name="Phone" type="text" placeholder="" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12 ">
								 	<label class="micro-label" for="Website">&nbsp;&nbsp;Current Website:</label>
								</div>	
							</div>	
							<div class="row">
								<div class="col-md-12">
									<input  class="form-control" id="Website" name="Website" type="text" placeholder="" maxlength="50" >
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group qq-input">
						<div class="col-md-12" align="center">
							<input class="btn btn-icon" type="submit" id="submit" name="submit" value=""  ><img src="http://dealers.wdautos.com/dealer/bobscars/images/icons/BigSubmit.png" border="0" class="img-responsive">
						</div>
					</div>
				</fieldset>
			</form>
	
	</cffunction>

	
	
	<cffunction name="form_submit" description="default quick-quote layout" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="lead_type_id" required="true">
		<cfargument name="lead_send_id" required="true">
		<cfargument name="delivery_dealer_id" required="true">
		<cfargument name="dsn" default="Ultra10">
		
		<!---default parameters--->
		<cfparam name="form.dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.delivery_dealer_id" default="#arguments.Dealer_ID#">
		<cfparam name="form.first_name" default="">
		<cfparam name="form.last_name" default="">
		<cfparam name="form.email" default="">
		<cfparam name="form.phone_1" default="">
		<cfparam name="form.comments" default="">
		<cfparam name="form.voi_new_used" default="N">
		<cfparam name="form.voi_vin" default="">
		<cfparam name="form.voi_stock" default="">
		<cfparam name="form.voi_year" default="">
		<cfparam name="form.voi_make" default="">
		<cfparam name="form.voi_model" default="">
		<cfparam name="form.voi_trim" default="">
		<cfparam name="form.voi_price" default="">

		<cfif len(trim(form.voi_vin)) gt 0>
			<!---Get Vehicle Details--->
			<cfstoredproc datasource="#arguments.dsn#" procedure="Get_Vehicle_Details">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@vin" value="#left(form.voi_vin,17)#" maxlength="21">
				<cfprocresult name="Get_Vehicle_Details" resultset="1">
			</cfstoredproc>
			<cfset form.voi_new_used=Get_Vehicle_Details.V_New_Used>
			<cfset form.voi_vin=Get_Vehicle_Details.Vin>
			<cfset form.voi_year=Get_Vehicle_Details.V_Year>
			<cfset form.voi_make=Get_Vehicle_Details.V_Make>
			<cfset form.voi_model=Get_Vehicle_Details.V_Model>
			<cfset form.voi_trim=Get_Vehicle_Details.V_Trim>
			<cfset form.voi_price=Get_Vehicle_Details.Selling_Price>
			<cfset form.delivery_dealer_id=Get_Vehicle_Details.Dealer_ID>
			
<!--- Clicks Tracker --->
<cfoutput> <cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.Dealer_ID#</cfquery>
<cfif #t_clik.track_clicks# EQ 1 >
	<cfquery datasource="Ultra10" name="g_Clk">SELECT ID,quote_srp_click FROM Vehicle_Click_Stats WHERE VIN='#form.VOI_Vin#' </cfquery>
	<cfif #g_Clk.recordcount# NEQ 0 ><cfset g_Clk.quote_srp_click = #g_Clk.quote_srp_click# + 1 > 
	<cfquery datasource="Ultra10" name="U_Clk">UPDATE Vehicle_Click_Stats SET quote_srp_click=#g_Clk.quote_srp_click#,last_Upd=#CreateODBCDateTime(now())#WHERE VIN='#form.VOI_Vin#'</cfquery></cfif>
</cfif> </cfoutput>    
<!--- Clicks Tracker --->
		
			
			
		</cfif>

		<cfset url.year=form.voi_year>
		<cfset url.make=form.voi_make>
		<cfset url.model=form.voi_model>
		<cfset url.new_used=form.voi_new_used>

		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>

		<!---Server Side Form Validation--->

		<cfset variables.error_message="">

		<!--- First Name: form.First_Name--->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="First Name"/>
			<cfinvokeargument name="text_value" value="#form.first_name#"/>
			<cfinvokeargument name="text_name_2" value="Last Name"/>
			<cfinvokeargument name="text_value_2" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_name" value="true"/>
		</cfinvoke>
		<!--- Last Name: form.Last_Name --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Last Name"/>
			<cfinvokeargument name="text_value" value="#form.last_name#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>
		<!--- Email: form.Email --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Email"/>
			<cfinvokeargument name="text_value" value="#form.email#"/>
			<cfinvokeargument name="text_req" value="true"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_email" value="true"/>
		</cfinvoke>
		<!--- Daytime Phone: form.Phone_1 --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Phone"/>
			<cfinvokeargument name="text_value" value="#form.phone_1#"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			<cfinvokeargument name="check_phone" value="true"/>
		</cfinvoke>
		<!--- Comments: form.Comments --->
		<cfinvoke component="/cfcs/forms/form_validate" method="text_area" returnvariable="error_message">
			<cfinvokeargument name="text_name" value="Comments"/>
			<cfinvokeargument name="text_value" value="#form.comments#"/>
			<cfinvokeargument name="text_req" value="false"/>
			<cfinvokeargument name="error_message" value="#variables.error_message#"/>
		</cfinvoke>

		<cfif listlen(variables.error_message) gt 0>
	
			<!---<cfinvoke component="/cfcs/forms/form_validate" method="display_error">
				<cfinvokeargument name="error_message" value="#variables.error_message#"/>
			</cfinvoke>--->
			
			<cfset url.error_message=variables.error_message>

		<cfelse>

			<!---lead delivery hack   Faulkner--->
			 <cfswitch expression="#url.dealer_id#">
				<cfcase value="78,79,82,24">
					<cfset form.dealer_id=url.dealer_id>
					<cfset form.delivery_dealer_id=url.dealer_id>
					<!--- <cfset arguments.lead_send_id=url.dealer_id> --->
				</cfcase>
			</cfswitch> 
	
			<cfinvoke component="/cfcs/forms/form_save" method="insert_lead" returnvariable="New_ID">
				<cfinvokeargument name="lead_type_id" value="#arguments.lead_type_id#"/>
				<cfinvokeargument name="dealer_id" value="#form.dealer_id#"/>
				<cfinvokeargument name="delivery_dealer_id" value="#form.delivery_dealer_id#"/>
				<cfinvokeargument name="remote_addr" value="#cgi.Remote_Addr#">
				<cfinvokeargument name="http_user_agent" value="#cgi.Http_User_Agent#">
			</cfinvoke>
	
			<cfinvoke component="/cfcs/forms/form_save" method="insert_contact" returnvariable="Contact_ID">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Contact_Type_ID" value="1"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/forms/form_save" method="insert_vehicle">
				<cfinvokeargument name="New_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="Vehicle_Type_ID" value="1"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
			</cfinvoke>

			<!---Get Lead Delivery Addresses--->
			<cfstoredproc datasource="Ultra10" procedure="Get_Lead_Addresses">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.delivery_dealer_id#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@lead_type_id" value="#arguments.lead_send_id#" maxlength="10">
				<cfprocresult name="Get_Lead_Addresses" resultset="1">
			</cfstoredproc>
			<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>

			<!---If no delivery addresses are setup for these leads, get primary lead address--->
			<cfif Get_Lead_Addresses.Recordcount eq 0>
				<cfstoredproc datasource="Ultra10" procedure="Get_Primary_Lead_Address">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#form.Delivery_Dealer_ID#" maxlength="10">
					<cfprocresult name="Get_Lead_Addresses" resultset="1">
				</cfstoredproc>
				<cfset variables.recipient_list=valuelist(Get_Lead_Addresses.Email)>
			</cfif>

			<!---Generate Text Email--->

			<cfinvoke component="/cfcs/emails/text_gen" method="contact_text" returnvariable="text_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>


			<cfinvoke component="/cfcs/emails/text_gen" method="vehicle_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/text_gen" method="rec_text" returnvariable="text_email">
				<cfinvokeargument name="text_email" value="#variables.text_email#"/>
				<cfinvokeargument name="recipient_list" value="#variables.recipient_list#"/>
			</cfinvoke>

			<!---Generate ADF Email--->

			<cfinvoke component="/cfcs/emails/adf_gen" method="header_adf" returnvariable="adf_email">
				<cfinvokeargument name="Lead_ID" value="#variables.New_ID#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="contact_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="first_name" value="#form.first_name#"/>
				<cfinvokeargument name="last_name" value="#form.last_name#"/>
				<cfinvokeargument name="email" value="#form.email#"/>
				<cfinvokeargument name="phone_1" value="#form.phone_1#"/>
				<cfinvokeargument name="comments" value="#form.comments#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="vehicle_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
				<cfinvokeargument name="interest" value="buy"/>
				<cfinvokeargument name="v_vin" value="#form.voi_vin#"/>
				<cfinvokeargument name="v_stock" value="#form.voi_stock#"/>
				<cfinvokeargument name="new_used" value="#form.voi_new_used#"/>
				<cfinvokeargument name="v_year" value="#form.voi_year#"/>
				<cfinvokeargument name="v_make" value="#form.voi_make#"/>
				<cfinvokeargument name="v_model" value="#form.voi_model#"/>
				<cfinvokeargument name="v_trim" value="#form.voi_trim#"/>
				<cfinvokeargument name="v_price" value="#form.voi_price#"/>
			</cfinvoke>

			<cfset variables.this_dealer_id=form.Delivery_Dealer_ID>
			
			<cfinvoke component="/cfcs/emails/adf_gen" method="vendor_adf" returnvariable="adf_email">
				<cfinvokeargument name="dealer_id" value="#variables.this_dealer_id#"/>
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="provider_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfinvoke component="/cfcs/emails/adf_gen" method="footer_adf" returnvariable="adf_email">
				<cfinvokeargument name="adf_email" value="#variables.adf_email#"/>
			</cfinvoke>

			<cfif #url.dealer_id# neq 25 and #url.dealer_id# neq 36 and #url.dealer_id# neq 37 and #url.dealer_id# neq 28  >
				<cfparam name="variables.Email_Subject" default="Quote Request from #lcase(cgi.Server_Name)#">
			
			<cfelseif #url.dealer_id# eq 25 or #url.dealer_id# eq 36 or #url.dealer_id# eq 37 or #url.dealer_id# eq 28 AND #cgi.Server_Name# eq "http://washingtonautomall.net/vehicles/qq_action.cfm?mode=ePrice" >						
				<cfparam name="variables.Email_Subject" default="e-price from #lcase(cgi.Server_Name)#">
			
			<cfelse>
				<cfparam name="variables.Email_Subject" default="Check Availability Request from #lcase(cgi.Server_Name)#">
			</cfif>
			
				<!---
				<cfif #cgi.Server_Name# eq "http://washingtonautomall.net/vehicles/qq_action.cfm?mode=ePrice" >
					 --------------------------------------------------------- e-Price- 
				</cfif>
				--->
			
			<cfparam name="variables.From_Email" default="leads@worlddealer.net">
			<cfparam name="variables.WD_BCC" default="wdpittsburgh@hotmail.com,wdsupport@worlddealer.net">

			<cfif Get_Lead_Addresses.Recordcount gt 0>
				<cfloop query="Get_Lead_Addresses">

					<!---Send Text Emails--->
					<cfif Get_Lead_Addresses.Email_Text eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
						<cfmailparam name="Reply-To" value="#form.email#">
						#variables.text_email#
						</cfmail>
						<!---<li>#Get_Lead_Addresses.Email# - Text</li>--->
					</cfif>

					<!---Send ADF Emails--->
					<cfif Get_Lead_Addresses.Email_ADF eq 1>
						<cfmail to="#Get_Lead_Addresses.Email#" from="#variables.From_Email#" subject="#variables.Email_Subject#" bcc="#variables.WD_BCC#">
						<cfmailparam name="Reply-To" value="#form.email#">
						#variables.adf_email#
						</cfmail>
						<!---<li>#Get_Lead_Addresses.Email# - ADF</li>--->					
					</cfif>

				</cfloop>
			</cfif>
			
		</cfif>

	</cffunction>

</cfcomponent>