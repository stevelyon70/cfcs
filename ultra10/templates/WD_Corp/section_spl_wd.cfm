<cfoutput>
<div class="container-fluid">		
	<section class="section-splash-spl  pad-bottom-10" >
		<div class="row-centered no-pad">	
			<div class="col-md-7 pad-top-10" style="align:center;margin-left:100px!important">
               	<cfinvoke component="/cfcs/ultra10/variable_wow_slider_v1" method="wide">
                   	<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
                       <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
                       <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
                       <cfinvokeargument name="assets" value="#arguments.assets#"/>
                       <cfinvokeargument name="pg_nbr" value="0"/>
				</cfinvoke>
            </div>
			<div class="col-md-4" >
				<div class="container-contact-us" >
					<div class="spl-search-name    pad-bottom-10" style="align:left">
						<span class="spl-search-name " style="color:##000000!important;font-weight:bold" ><h1>CONTACT US</h1></span>
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
			<div class="col-md-1"  >&nbsp;</div>
		  </div>  
	</section>
</div>
</cfoutput>		
