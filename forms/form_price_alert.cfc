<cfcomponent>
	<cffunction name="form_popup" description="quick quote open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="btn_label" default="Update Price Alert">
		<cfargument name="form_action" default="http://#cgi.server_name#/vehicles/priceAlertAction.cfm?formtype=add">
		<cfargument name="form_name" default="price_alert">
		<cfargument name="formtype" default="add">
		<cfargument name="voi_price" default="0">
		<cfargument name="returnUrl" default="">
		<cfargument name="v_stock" default="">
        
		<cfparam name="cookie.priceAlert_full_name" default="">
		<cfparam name="cookie.priceAlert_email" default="">
		<cfparam name="cookie.priceAlert_phone_1" default="">
		<cfparam name="cookie.priceAlert_zip_code" default="">
        
		<form id="price_alert_pop" class="form-horizontal" action="#arguments.form_action#" method="post">
			<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
			<input name="voi_vin" id="voi_vin" type="hidden"  value="#left(arguments.voi_vin,17)#"/>
			<input name="voi_new_used" id="voi_new_used" type="hidden"  value="#arguments.voi_new_used#"/>
            <input name="voi_price" id="voi_price" type="hidden"  value="#arguments.voi_price#"/>
            <input name="returnUrl" id="voi_price" type="hidden"  value="#arguments.returnUrl#"/>  
            <input name="v_stock" id="v_stock" type="hidden"  value="#arguments.v_stock#"/>            
            
			<fieldset>
            <cfif arguments.formtype is 'add'>
	            <div class="form-group">
					<label class="control-label col-md-3" for="Price">Current Price</label>
					<div class="col-md-6">
						#dollarformat(arguments.voi_price)#						
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Full_Name"><span class="txt-red">*</span>Name</label>
					<div class="col-md-6">
						<input name="Full_Name" class="form-control input-md" id="Full_Name" type="text" maxlength="50" placeholder="Name" required value="#cookie.priceAlert_full_name#">						
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Phone_1">Phone</label>
					<div class="col-md-6">
						<input name="Phone_1" class="form-control input-md" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" value="#cookie.priceAlert_phone_1#">
						<p class="help-block">Numbers Only - no hyphens or parentheses</p>   <!---  Fayette Honda 10-07 Bob  --->
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-6">
						<input name="Email" class="form-control input-md" id="Email" type="email" maxlength="100" placeholder="Email" required value="#cookie.priceAlert_email#">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3" for="zip_code">Zip/Postal Code</label>
					<div class="col-md-6">
						<input name="zip_code" class="form-control input-md" id="zip_code" type="text" maxlength="100" placeholder="Zip code" value="#cookie.priceAlert_zip_code#">
					</div>
				</div>
                </cfif>
				<div class="form-group">
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6">							
						<input type="submit" class="btn btn-primary" id="form_submit" value="#ucase(arguments.formtype)# PRICE ALERT">
					</div>
				</div>
			</fieldset>
		</form>
	
	</cffunction>
</cfcomponent>