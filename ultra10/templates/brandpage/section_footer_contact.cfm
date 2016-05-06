<cfoutput>

		<section class="section-contact-us">
			<div class="container">
				<div class="row">
					<div class="col-md-8  pad-top-10  visible-sm visible-xs  visible-md visible-lg">	
						<div class="container-contact-us">
								<div class="spl-search-name    pad-bottom-10" style="align:left">
									<span class="spl-search-name " style="color:##ffffff;font-weight:bold;margin-left:15px" >CONTACT US</span>
								</div>
								<div class="row pad-top-10">
									<div class="col-md-12 visible-sm visible-xs visible-lg visible-md">	
										<cfinvoke component="/cfcs/forms/form_contact" method="contact_splash_v1">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="dsn" value="Ultra10"/>
										<cfinvokeargument name="button_text" value="Contact Us"/>
										<cfinvokeargument name="input_class" value="form-control input-sm"/>
										</cfinvoke>
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</section>

</cfoutput>
