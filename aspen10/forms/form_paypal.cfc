<cfcomponent>
	
	<cffunction name="show_default" description="display default PayPal form" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<!--- <cfargument name="vin" required="true"> --->
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/paypal_deposit.cfm">

		<cfquery name="get_ctrl" datasource="Aspen10">
			SELECT  ID ,  dealer_ID ,  paypal_url ,  paypal_primary_email ,  sandbox_paypal_url ,  sandbox_paypal_primary_email ,  set_mode ,  paypal_command ,  paypal_site_url ,  
					paypal_img_url ,  success_url ,  cancel_url ,  paypal_notify_url ,  paypal_return_method ,  paypal_curreny_code ,  paypal_display_comment ,  paypal_comment_header ,  
					paypal_background_color ,  paypal_item_number ,  paypal_deposit_amount ,  created_ts ,  updated_ts ,  active ,sandbox_site_url ,upper_text,bottom_text ,thankyou_text,cancel_text
			FROM   PayPal_Control  
			WHERE	dealer_ID	=	#arguments.dealer_id#
		</cfquery>		

		<cfset variables.vin="#url.vin#">  
	
		<cfquery name="get_staff" datasource="Aspen10">
			SELECT  Person_ID, Dealer_ID, Dealer_Dept_ID, First_Name, Last_Name, Email, Phone, Cell_Phone, Staff_Image, Staff_Link, Bio, Note, Staff_Position, 
                    Staff_Position_ID, Team, Team_ID, Hierarchy, Active, Old_Staff_ID, Permalink
			FROM    People
			WHERE	dealer_ID	=	#arguments.dealer_id#
			AND 	Dealer_Dept_ID = 4
			ORDER BY Last_Name ASC
		</cfquery>		
	
		<cfquery name="get_inv" datasource="Aspen10">
			SELECT     Vehicle_ID, Dealer_ID, Vin, Stock, Permalink, Img_Urls, Video_Link, V_New_Used, V_Year, V_Make, V_Model, V_Trim, V_Odometer, V_Model_Number, 
	           V_Type, V_Style, Interior_Color, Exterior_Color, Transmission, Engine_Size, Cylinders, Doors, Drivetrain, Passengers, Dealer_Comments, Fuel_Type, EPA_City, 
	           EPA_HWY, Selling_Price_Label, Selling_Price, MSRP_Label, MSRP_Price, Rebate_Label, Rebate_Price, Incentive_Label, Incentive_Price, Savings_Label, 
	           Savings_Price, AIS_Label, AIS_Price, AIS_APR, Certified, Fleet, Luxury, Carfax_One_Owner, Dealer_Display_Name, Dealer_Address_1, Dealer_Address_2, 
	           Dealer_City, Dealer_State, Dealer_Zip, Dealer_Phone, Dealer_Url, Link_Finance, Link_Service, Link_Sales, Link_Parts, Link_Directions
			FROM    Vehicles
			where	vin = '#variables.vin#'
		</cfquery>	
		<cfset year_make_model = "#get_inv.V_Year# #RTrim(get_inv.V_Make)# #RTrim(get_inv.V_Model)#" >
		<cfset selling_price = "#get_inv.Selling_Price#" >
		<cfset Permalink = "#get_inv.Permalink#" >
		<cfset stock_nbr = "#get_inv.Stock#" >
		<cfset pass_vin = "#get_inv.Vin#" >
		
		<div class="row">
			<div class="form-group">
				<div class="col-md-12" align="center">
						<div class="row">
							<div class="col-md-3 " align="left">
							<img src="http://dealers.wdautos.com/dealer/stuckeyforyou/images/library/logo_reserveit_2.png" class="img-responsive"  alt="Reserve It"> 
							</div>
							<div class="col-md-5" align="center">
									<div class="row">
										<div class="col-md-6" align="left"><font style="FONT-SIZE: 18pt;  FONT-WEIGHT: bold;  COLOR: black; FONT-FAMILY: Arial, sans-serif">
										#get_inv.V_Year# #RTrim(get_inv.V_Make)# #RTrim(get_inv.V_Model)#</font> </div>
									</div>	
								<cfif #get_inv.Engine_Size# NEQ "" >
									<div class="row">
										<div class="col-md-3" align="right">Engine: </div>
										<div class="col-md-4" align="left"><strong>#get_inv.Engine_Size#&nbsp;<cfif #get_inv.Cylinders# NEQ "" >#get_inv.Cylinders# Cylinders</cfif></strong></div>
									</div>
								</cfif>		
								<cfif #get_inv.Exterior_color# NEQ "" >
									<div class="row">
										<div class="col-md-3" align="right">Exterior Color :</div>
										<div class="col-md-4" align="left"><strong>#get_inv.Exterior_color#</strong></div>
									</div>
								</cfif>
								<cfif #get_inv.Vin# NEQ "" >
									<div class="row">
										<div class="col-md-3" align="right"">VIN :</div>
										<div class="col-md-4" align="left"><strong>#get_inv.Vin#</strong></div>
									</div>
								</cfif>	
								<cfif #get_inv.Stock# NEQ "" >
									<div class="row">
										<div class="col-md-3" align="right">Stock ## :</div>
										<div class="col-md-4" align="left"><strong>#get_inv.Stock#</strong></div>
									</div>
								</cfif>	
								<cfif #get_inv.V_Model_Number# NEQ "" >
									<div class="row">
										<div class="col-md-3" align="right">Model ## :</div>
										<div class="col-md-4" align="left"><strong>#get_inv.V_Model_Number#</strong></div>
									</div>
								</cfif>
								<cfif #get_inv.Transmission# NEQ "" >
									<div class="row">
										<div class="col-md-3" align="right">Transmission :</div>
										<div class="col-md-4" align="left"><strong>#get_inv.Transmission#</strong></div>
									</div>
								</cfif>	
							</div>
							<div class="col-md-3 " align="left">
								<cfset lst_len = #ListLen(get_inv.Img_Urls)# >
								<cfif #get_inv.Img_Urls# NEQ "" >
									<img class="img-responsive" width="270px" height="202px" border="1" src="#ListFirst(get_inv.Img_Urls)#"/>
								<cfelse>
									<img  class="img-responsive" width="270px" height="202px" border="1" src="http://automall.wddemos.com/images/photo_coming_soon.jpg"/>
								</cfif>
							</div>
							<div class="col-md-4 " align="left"></div>
							</div>
						</div>		
					<div class="row">&nbsp;</div>
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-8 " align="left">
								#get_ctrl.upper_text#
							</div>
							<div class="col-md-2"></div>
						</div>
					</div>
				</div>
			</div>
		</div>		
		<form id="paypal_form" name="paypal_form" class="form-horizontal" action="#arguments.form_action#" method="post">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				<input type="hidden" id="voi_new_used" name="voi_new_used" value="N">
				<input type="hidden" name="on0" value="">  
				<input type="hidden" name="os0" value="">
				<input type="hidden" name="on1" value="">
				<input type="hidden" name="os1" value=""> 
				<input name="quantity" type="hidden" id="quantity" value="1" >
				<input name="shipping_amount" type="hidden" id="shipping_amount" value="0" >
				<input name="tax" type="hidden" id="tax" value="0">
		   		<input name="stock_number"  type="hidden" id="stock_number" value="<cfoutput>#stock_nbr#</cfoutput>" size="40"> 
		   		<input name="item_name"  type="hidden" value="Deposit on <cfoutput>#year_make_model#</cfoutput>" id="item_name" size="40"> 
		   		<input name="item_number"  type="hidden" id="item_number" value="<cfoutput>#pass_vin#</cfoutput>" size="40">
				<input name="address2"   type="hidden" id="address2"  value="" size="40">
		   		<input name="amount"  type="hidden" id="amount" value="<cfoutput>#get_ctrl.paypal_deposit_amount#</cfoutput>" size="10">
		   		<input name="selling_price"  type="hidden" id="selling_price" value="<cfoutput>#selling_price#</cfoutput>" size="10">
		   		<input name="Permalink"  type="hidden" id="Permalink" value="<cfoutput>#Permalink#</cfoutput>" size="10">
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
	
		 <cfquery NAME="InsPPCust" datasource="Aspen10">
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
		<cfquery datasource="Aspen10" name="qryLast_id">SELECT A.ID FROM Dealer_PayPal_Customers A ORDER BY A.ID DESC</cfquery>
		<cfset Last_id = #qryLast_id.ID#>  
	
		<!---Generate Text Email--->
		<cfset recipient_list = "mattm@stuckeyforyou.com;Michael@stuckeyforyou.com;chuck@stuckeyforyou.com;nate@stuckeyforyou.com;bryan@stuckeyforyou.com;sean@stuckeyforyou.com;matt@stuckeyforyou.com;shawn@stuckeyforyou.com;ken@stuckeyforyou.com" >
		
		<cfmail to="#recipient_list#" from="leads@worlddealer.net" bcc="bob@worlddealer.net" type="HTML" subject="Reserve It Deposit">  
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