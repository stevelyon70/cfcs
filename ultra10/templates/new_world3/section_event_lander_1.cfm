<!--- section_event_lander_3.cfm
				
 --->
 
		<!--- arguments --->
						
		<cfset err_style = "" >
		<cfif IsDefined("url.err_msg") and #len(url.err_msg)# GT 0 >
			<cfset err_style = "background-color:yellow" >
		</cfif>
 
<style type="text/css">
 
.container{
	margin-left:auto!important;
	margin-right:auto!important;
	max-width:100%!important;
	max-height:100%!important; 
}
.container-mbl{
	margin-left:5px!important;
	margin-right:auto!important;
	max-width:100%!important;
	max-height:auto!important;  
	align:center!important;  
}

</style>
	

<cfoutput>
	
	<section class="section-spl" >		
		
		<div class="container-mbl visible-sm visible-xs" style="margin-bottom:10px!important">
			<div class="row" style="margin-top:10px!important">					 
				<div class="col-md-12 visible-sm visible-xs ">
					<img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/form_testdrivegraphic.jpg" class="img-responsive" alt="March Mania Sales Event"/>
				</div>
			</div>	
			<div class="row" style="margin-top:5px!important">					 
				<div class="col-md-12 visible-sm visible-xs "   >	
					<div class="register_title" >Complete this form to claim your gift card worth up to $100 with a test drive!<br>Hurry Offer Ends 3/31/2016.</div>	
					<form action="http://#cgi.server_name#/forms/email_event_action.cfm" method="post">
						<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#url.dealer_id#">
						<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#url.dealer_id#">
						<input class="form-control input-md" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First Name" required>
 						<input class="form-control input-md" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* Last Name" required> 
						<input class="form-control input-md" name="Email" id="Email" type="email" style="margin-bottom:10px" size="40"  maxlength="100" placeholder="* Email" required>
						<input class="form-control input-md" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:10px" size="40"  maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
						<br><input class="register-go-btn "   name="Submit" id="Submit"   type="submit" value="Get My Visa Reward Card">
					</form>
				
					<div class="register_big_button_container" style="align:center;margin-top:5px!important;" >
						<div class="register_big_button_text"><a href="http://kellynissanofroute33.com/new/offers.cfm" ><img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/btn_MarchMania_ViewSpecials.jpg" width="100%" alt="March Mania Sales Event"/></a></div>
					</div>	
				</div>			
	        </div>  <!--- End ROW --->
		</div>  
	 	
		<div class="container   visible-lg visible-md" style="margin-bottom:5px!important">
			<div class="row" style="margin-top:5px!important">					 
				<div class="col-md-12 pull-left visible-lg visible-md" style="align:left!important;margin-left:3px!important">
				    <div class="row">
						<div class="col-md-7  visible-sm visible-xs  visible-lg visible-md" >	
							<img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/form_testdrivegraphic.jpg" class="img-responsive" alt="March Mania Sales Event"/>
						</div>
						<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md"   >	
							<div class="register_title" >Complete this form to claim your gift card worth up to $100 with a test drive!<br>Hurry Offer Ends 3/31/2016.</div>	
							<form action="http://#cgi.server_name#/forms/email_event_action.cfm" method="post">
								<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#url.dealer_id#">
								<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#url.dealer_id#">
								<input class="form-control input-md" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First Name" required>
 								<input class="form-control input-md" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* Last Name" required> 
								<input class="form-control input-md" name="Email" id="Email" type="email" style="margin-bottom:10px" maxlength="100" placeholder="* Email" required>
								<input class="form-control input-md" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:10px" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
								<br><input class="register-go-btn "   name="Submit" id="Submit"   type="submit" value="Get My Visa Reward Card">
							</form>
						
							<div class="register_big_button_container" style="align:center;margin-top:10px!important;" >
								<div class="register_big_button_text"><a href="http://kellynissanofroute33.com/new/offers.cfm" ><img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/btn_MarchMania_ViewSpecials.jpg" width="100%" alt="March Mania Sales Event"/></a></div>
							</div>	
						</div>			
			       	</div>
				</div>  
			</div>		 
		</div>	
		
	</section>
    
</cfoutput>

