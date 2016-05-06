<cfoutput>
		

		<section class="section-oblong-btns">
			<div class="container pad-top-10 visible-md visible-lg visible-sm visible-xs">
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
				<div class="row">
					<div class="col-md-12  pad-top-10" style="align:left">
						<div class="row"></div>
							<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="query_var_btns">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="36"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
								<!--- <cfinvokeargument name="pass_make" value="#url.v_make#"/> --->
							</cfinvoke>
					</div>
				</div>
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
			</div>  
		</section>


</cfoutput>
