<cfoutput>
		

		<section class="section-maps">
			<div class="container pad-top-10 visible-md visible-lg visible-sm visible-xs">
				<div class="row"><div class="col-md-12  visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
				<div class="row">
					<div class="col-md-12  " style="align:left">
					<cfif #url.dealer_id# NEQ 311 >
						 <div class="row pad-top-05">&nbsp;</div 
						<div class="row pad-bottom-05">
							<div class="pg-division-titles" title="#Get_Nav.Nav_Name#"><cfif #url.dealer_id# NEQ 311 >Faulkner<cfelse>#url.dealer_name#</cfif> #url.v_make# Locations</div>
						</div>
						 <!--- <div class="row pad-bottom-05">&nbsp;</div  --->
					</cfif>	
							<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="query_var_location"> <!--- sorts by state & city --->
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="38"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
								<cfinvokeargument name="pass_make" value="#url.v_make#"/>
							</cfinvoke>
					</div>
				</div>
			</div>  
		</section>


</cfoutput>
