<cfoutput>
		
<div container-fluid >
		<section class="section-maps">
			<div class="no-pad visible-md visible-lg ">
				<!--- <div class="row"><div class="col-md-12   visible-lg visible-md"><div class="gradient"></div></div></div>	 --->
				<div class="row">
					<div class="col-md-12  " style="align:left">
					<cfif #url.dealer_id# NEQ 311 AND  #url.dealer_id# NEQ 17  AND  #url.dealer_id# NEQ 365  AND  #url.dealer_id# NEQ 233 AND  #url.dealer_id# NEQ 82 AND  #url.dealer_id# NEQ 369>
						 <div class="row pad-top-05">&nbsp;</div 
						<div class="row pad-bottom-05">
							<div class="pg-division-titles" title="#Get_Nav.Nav_Name#"><cfif #url.dealer_id# NEQ 311 >Faulkner<cfelse>#url.dealer_name#</cfif> Locations</div>
						</div>
						 <!--- <div class="row pad-bottom-05">&nbsp;</div  --->
					</cfif>	
							<cfif #url.dealer_id# NEQ 17 AND  #url.dealer_id# NEQ 365  AND  #url.dealer_id# NEQ 233 AND  #url.dealer_id# NEQ 24 AND  #url.dealer_id# NEQ 82 AND  #url.dealer_id# NEQ 369>
								<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="query_var_location"> <!--- sorts by state & city --->
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="38"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="splash-map"/>
										<cfinvokeargument name="pass_make" value=""/>
								</cfinvoke>
							<cfelse>
							 <cfif  #url.dealer_id# EQ 233 or  #url.dealer_id# EQ 365>
								<div class="col-centered visible-md visible-lg">
									<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d3023.8649368410497!2d-75.29327308418703!3d40.72098967933087!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sus!4v1451938562038" 
									width="1900" height="400" frameborder="0" style="border:0" allowfullscreen></iframe>
									 <!--- <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3044.7337674902874!2d-76.78302800000001!3d40.25944769999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c8bf21d3dda745%3A0x6acca859402e174a!2s5945+Grayson+Rd%2C+Harrisburg%2C+PA+17111!5e0!3m2!1sen!2sus!4v1442588031670" 
									 width="1900" height="400" frameborder="0" style="border:0" allowfullscreen></iframe>  --->
								</div>	
							</cfif>
							 <cfif  #url.dealer_id# EQ 24>
								<div class="col-centered visible-md visible-lg">
									 <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3044.7337674902874!2d-76.78302800000001!3d40.25944769999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c8bf21d3dda745%3A0x6acca859402e174a!2s5945+Grayson+Rd%2C+Harrisburg%2C+PA+17111!5e0!3m2!1sen!2sus!4v1442588031670" 
									 width="1800" height="400" frameborder="0" style="border:0" allowfullscreen></iframe> 
								</div>	
							</cfif>
							 <cfif  #url.dealer_id# EQ 82>
								<div class="visible-md visible-lg">
									<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3050.3441213932733!2d-74.98000218420127!3d40.134617779398965!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c6b2a83ded7185%3A0x978248915da47869!2s4437+Street+Rd%2C+Feasterville-Trevose%2C+PA+19053!5e0!3m2!1sen!2sus!4v1446046412321" 
									width="100%" height="400" frameborder="0" style="border:0" allowfullscreen></iframe>
								</div>	
							</cfif>
							<cfif #url.dealer_id# EQ 17>
								<div class=" visible-md visible-lg">
									<iframe src="https://www.google.com/maps/d/embed?mid=zygDwS8FiESQ.kATDgtvIcuaA&z=15&ll=40.548215,-75.490427" width="100%" height="400"></iframe>
								</div>	
							</cfif>
							<cfif #url.dealer_id# EQ 369>
								<div class=" visible-md visible-lg">
									<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3056.8001178571044!2d-104.82445728420481!3d39.99057197941706!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x876c6d47f78469fd%3A0xfbb21d76d20cb816!2sFront+Range+Auto+Sales!5e0!3m2!1sen!2sus!4v1454338416683" 
									width="1130" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>

								</div>	
							</cfif>
							</cfif>		
					</div>
				</div>
			</div>  
		</section>
</div>

</cfoutput>
