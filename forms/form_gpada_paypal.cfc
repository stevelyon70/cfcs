<cfcomponent>
	
	<cffunction name="show_default" description="display default PayPal form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<!--- <cfargument name="vin" required="true"> --->
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/paypal_deposit.cfm">

		<cfquery name="Chk_AppType" datasource="GPADA" >
			SELECT	a.ID, a.application_type, a.image_1, a.header_text, a.header_link, a.header_link_text, a.header_text_2, a.dues_line, a.disclaimer, a.created_ts, a.active, a.notifications,
			b.description, b.active
			FROM    Application_Layout a, Application_Types b
			WHERE  	a.application_type = #url.app_type# 
			AND		a.application_type = b.ID
			AND 	a.active = 1
		</cfquery>
		
		<cfquery name="Get_App_Info" datasource="GPADA" >
			SELECT	ID, app_type, company, address, city, state, zip, phone, fax, cell, email_address, member_type, authorized_name, recipient_name, describe_business, 
                    signature, submitted_dt, status, archive
			FROM	Applications
			WHERE	ID = #url.appl_id#
		</cfquery>
		
		<div class="container" >
		<div class="row no-pad">
			<div class="col-md-6 " style="font-weight:BOLD;font-size:18pt" >                     
				#Chk_AppType.description#
			</div>
			<div class="col-md-6" >                     
				<img src="http://dealers.wdautos.com/dealer/gpadaapplication/images/icons/#Chk_AppType.image_1#" border="1" class="img-responsive">
			</div>
		</div>
		
		<div class="row  pad-bottom-10 "><div class="col-md-12 " >&nbsp; </div></div>
		
		<div class="row row-centered pad-top-10  pad-bottom-10 ">
			<div class="col-md-12 col-centered" style="font-weight:bold;font-size:13pt;align:center" >                     
				<p style="align:center">#Chk_AppType.header_text#</p>
			</div>
		</div>
		<div class="row row-centered pad-top-10  pad-bottom-10 ">
			<div class="col-md-12 col-centered" style="font-weight:bold;font-size:13pt" >                     
				<a href="#Chk_AppType.header_link#" target="_blank">#Chk_AppType.header_link_text#</a>
			</div>
		</div>
		
		<div class="row pad-bottom-10 "><div class="col-md-12 ">&nbsp; </div></div>				
		
		<div class="row    pad-bottom-10 ">
			<div class="col-md-12 " style="font-weight:normal;font-size:10pt" >                     
				#Chk_AppType.header_text_2#
			</div>
		</div>
		

		<form id="paypal_form" name="paypal_form" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" name="on0" value="">  
				<input type="hidden" name="os0" value="">
				<input type="hidden" name="on1" value="">
				<input type="hidden" name="os1" value=""> 
				<input name="quantity" type="hidden" id="quantity" value="1" >
				<input name="shipping_amount" type="hidden" id="shipping_amount" value="0" >
				<input name="tax" type="hidden" id="tax" value="0">
		   		<input name="stock_number"  type="hidden" id="stock_number" value="0" size="40"> 
		   		<input name="item_name"  type="hidden" value="Annual Dues for <cfoutput>#Chk_AppType.description#</cfoutput>" id="item_name" size="40"> 
		   		<input name="item_number"  type="hidden" id="item_number" value="<cfoutput>#Get_App_Info.id#</cfoutput>" size="40">
				<input name="address2"   type="hidden" id="address2"  value="" size="40">
		   		<input name="amount"  type="hidden" id="amount" value="0" size="10">
		   		<input name="selling_price"  type="hidden" id="selling_price" value="0" size="10">
				<div class="row">
					<div class="col-md-2 " align="left"></div>
					<div class="col-md-8 " align="left">
						<span class="txt-red">*</span> = Required Entry
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2" for="firstname"><span class="txt-red">*</span> Customer 1 First Name</label>
					<div class="col-md-4">
						<input name="firstname" class="form-control input-md" id="firstname" type="text" maxlength="50" placeholder="Customer 1 First Name" required>
					</div>
					<label class="control-label col-md-2" for="Lastname"><span class="txt-red">*</span> Customer 1 Last Name</label>
					<div class="col-md-4">
						<input name="Lastname" class="form-control input-md" id="Lastname" type="text" maxlength="50" placeholder="Customer 1 Last Name" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2" for="firstname2"> Customer 2 First Name</label>
					<div class="col-md-4">
						<input name="firstname2" class="form-control input-md" id="firstname2" type="text" maxlength="50" placeholder="Customer 2 First Name" >
					</div>
					<label class="control-label col-md-2" for="Lastname2"> Customer 2 Last Name</label>
					<div class="col-md-4">
						<input name="Lastname2" class="form-control input-md" id="Lastname2" type="text" maxlength="50" placeholder="Customer 2 Last Name"  >
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2" for="phone1"><span class="txt-red">*</span>Phone</label>
					<div class="col-md-1">
						<input name="phone1" class="form-control input-md" id="phone1" type="text" maxlength="3" size="3"  required>
					</div>
					<div class="col-md-1">
						<input name="phone2" class="form-control input-md" id="phone2" type="text" maxlength="3" size="3"  required>
					</div>
					<div class="col-md-1">
						<input name="phone3" class="form-control input-md" id="phone3" type="text" maxlength="4" size="4"  required>
					</div>
					<label class="control-label col-md-3"  for="Email"><span class="txt-red">*</span> Email</label>
					<div class="col-md-4">
						<input name="Email" class="form-control input-md" id="Email" type="text" maxlength="50" placeholder="Email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2" for="address1"><span class="txt-red">*</span> Address</label>
					<div class="col-md-4">
						<input name="address1" class="form-control input-md" id="address1" type="text" maxlength="50" placeholder="Address" required>
					</div>
					<label class="control-label col-md-2" for="City"><span class="txt-red">*</span> City</label>
					<div class="col-md-4">
						<input name="City" class="form-control input-md" id="City" type="text" maxlength="50" placeholder="City" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2" for="state"><span class="txt-red">*</span> State</label>
					<div class="col-md-4">
						<input name="state" class="form-control input-md" id="state" type="text" maxlength="50" placeholder="State" required>
					</div>
					<label class="control-label col-md-2" for="zip"><span class="txt-red">*</span> Zip</label>
					<div class="col-md-4">
						<input name="zip" class="form-control input-md" id="zip" type="text" maxlength="50" placeholder="Zipcode" required>
					</div>
				</div>
			  
				<div class="form-group">
					<label class="control-label col-md-2" for="state"> Dealer Representative</label>
					<div class="col-md-4">
						<input name="SalesPerson" class="form-control input-md" id="SalesPerson" type="text" maxlength="50" placeholder="Dealer Representative" >
						<span class="help-block no-pad">If you are already working with someone.</span>
					</div>
					
					<div class="col-md-4">
					
					</div>
				</div>    
				 
				
				<div class="form-group">
					<label class="control-label col-md-7" for="Contact_Us"></label>
					<div class="col-md-5">
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="Reserve It">
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>
	
	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">
	
		<cfset build_phone = "#Form.phone1#-#Form.phone2#-#Form.phone3#" >
	
		 <cfquery NAME="InsPPCust" datasource="Ultra10">
		  INSERT into Dealer_PayPal_Customers ( dealer_id ,  
		  										Customer_1_Firstname ,  
												Customer_1_Lastname ,  
												Customer_2_Firstname ,  
												Customer_2_Lastname ,   
												SalesPerson ,  
												Phone ,  
												Email ,  
												Address ,  
												City ,  
												State ,  
												Zip ,  
												VIN ,  
												Stock ,  
												Permalink ,  
												Selling_Price ,  
												Deposit_Amount ,  
												Deposit_Date  )
		  							VALUES ( 	#Form.dealer_ID#,
												'#Form.firstname#',
												'#Form.lastname#',
												'#Form.firstname2#',
												'#Form.lastname2#',
												<cfif #Form.SalesPerson# NEQ "" >
													'#Form.SalesPerson#',
												<cfelse>
													null,
												</cfif>
												'#build_phone#',
												'#Form.email#',
												'#Form.address1#',
												'#Form.city#',
												'#Form.state#',
												'#Form.zip#',
												'#Form.item_number#',
												'#Form.stock_number#',
												'#Form.Permalink#',
												'#Form.Selling_Price#',
												#Form.amount#,
												#createODBCDateTime(now())# )
		</cfquery>
		<cfquery datasource="Ultra10" name="qryLast_id">SELECT A.ID FROM Dealer_PayPal_Customers A ORDER BY A.ID DESC</cfquery>
		<cfset Last_id = #qryLast_id.ID#>  
	
		<!---Generate Text Email--->
		<cfset recipient_list = "bob@worlddealer.net >
		
		<cfmail to="#recipient_list#" from="leads@worlddealer.net" bcc="bob@worlddealer.net" type="HTML" subject="#Chk_AppType.description#">  
			<table  align="left" >
				<tr><td colspan="2">This person has initiated a Reserve It request. It does not guarantee they have made payment through PayPal."</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>Customer 1 Name:</td><td align="left" >#form.firstname# #form.Lastname#</td></tr>
				<tr><td>Customer 2 Name:</td><td align="left" >#form.firstname2# #form.Lastname2#</td></tr>
				<tr><td>Phone:</td><td align="left" > #form.phone1# #form.phone2#-#form.phone3#</td></tr>
				<tr><td>Email:</td><td align="left" >#form.email#</td></tr>
				<tr><td>Address:</td><td align="left" >#form.address1#</td></tr>
				<tr><td>City/State/Zip:</td><td align="left" >#form.City# #form.State# #form.zip#</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>VIN:</td><td align="left" >#form.item_number#</td></tr>
				<tr><td>Stock ##:</td><td align="left" >#form.stock_number#</td></tr>
				<tr><td>Year Make Model:</td><td align="left" >#form.item_name#</td></tr>
				<tr><td>Selling Price:</td><td align="left" >#form.selling_price#</td></tr>
				<tr><td>Dealer Representative:</td><td align="left" ><cfif #form.SalesPerson# EQ "">No Selection<cfelse>#form.SalesPerson#</cfif></td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>Deposit Amount:</td><td align="left" >#form.amount#</td></tr>
				<tr><td>Submitted:</td><td align="left" >#timeformat(now(),"hh:mm tt")# on #dateformat(now(),"mm/dd/yyyy")#</td></tr>
			</table>
		</cfmail>

 
		<cfoutput>
			<body onLoad="document.paypal_form.submit();">
	
			<form method="post" name="paypal_form" action="https://www.paypal.com/cgi-bin/webscr" >
	 
				<!--- PayPal Configuration ---> 
				<input type="hidden" name="business" value="mattm@stuckeyforyou.com"> 
				<input type="hidden" name="cmd" value="_xclick"> 
				<input type="hidden" name="image_url" value="">
				<input type="hidden" name="cancel_url" value="/paypal/pp_toolkit/error.cfm">
				<input type="hidden" name="success_url" value="/paypal/pp_toolkit/success.cfm">
				<input type="hidden" name="return" value="2">
				<input type="hidden" name="cancel_return" value="http://www.stuckeyforyou.com">
				<input type="hidden" name="notify_url" value="/paypal/pp_toolkit/ipn/ipn.cfm">
				<input type="hidden" name="rm" value="2">
				<input type="hidden" name="currency_code" value="USD">
				<input type="hidden" name="lc" value="US">
				<input type="hidden" name="bn" value="toolkit-cfm">
				<input type="hidden" name="cbt" value="<Continue >>">
				  
				<!--- Payment Page Information ---> 
				<input type="hidden" name="no_shipping" value="">
				<input type="hidden" name="no_note" value="1">
				<input type="hidden" name="cn" value="Comments"> 
				<input type="hidden" name="cs" value="">
				 
				<!--- Product Information ---> 
				<input type="hidden" name="item_name" value="#Form.item_name#">
				<input type="hidden" name="amount" value="#Form.amount#">
				<input type="hidden" name="quantity" value="#Form.quantity#"> 
				<input type="hidden" name="item_number" value="#Form.item_number#">
				<input type="hidden" name="undefined_quantity" value="">
				<input type="hidden" name="on0" value="#Form.on0#">
				<input type="hidden" name="os0" value="#Form.os0#">
				<input type="hidden" name="on1" value="#Form.on1#">
				<input type="hidden" name="os1" value="#Form.os1#">
				
				<!--- Shipping and Misc Information ---> 
				<input type="hidden" name="shipping" value="#Form.shipping_amount#">
				<input type="hidden" name="shipping2" value="">
				<input type="hidden" name="handling" value="">
				<input type="hidden" name="tax" value="#Form.tax#">
				<input type="hidden" name="invoice" value="">
				
				<!--- Customer Information ---> 
				<input type="hidden" name="first_name" value="#Form.firstname#"> 
				<input type="hidden" name="last_name" value="#Form.lastname#"> 
				<input type="hidden" name="address1" value="#Form.address1#"> 
				<input type="hidden" name="address2" value="#Form.address2#"> 
				<input type="hidden" name="city" value="#Form.city#"> 
				<input type="hidden" name="state" value="#Form.state#"> 
				<input type="hidden" name="zip" value="#Form.zip#"> 
				<input type="hidden" name="email" value="#Form.email#"> 
				<input type="hidden" name="night_phone_a" value="#Form.phone1#"> 
				<input type="hidden" name="night_phone_b" value="#Form.phone2#"> 
				<input type="hidden" name="night_phone_c" value="#Form.phone3#"> 
				<input type="hidden" name="customer_ID" value="#Last_id#"> 
				<input type="hidden" name="custom" value="#Last_id#">
	  
		</form> 
	</cfoutput>

		
	<!--- <cfset url.error_message=#Last_id#>		 --->
		
	</cffunction>
</cfcomponent>