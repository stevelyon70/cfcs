<cfoutput>
		<section class="section-splash-spl">
		

				<div class="container ">	 
 													 
					<div class="row no-pad ">	
						
						<div class="col-md-12 no-pad" style="align:center">
						
<!--- Desktop Search --->		<div class="srch-tabs-block visible-md visible-lg">
									<div class="srch-tabs-title">Search Inventory</div>
									<div class="tab-pane active" id="srch">
										<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="btn_pull" value="pull-left"/>
										</cfinvoke>
									</div>
								</div>
								 
								<cfif #ss_trigger# eq 1>   			  
				                   <cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">	<!--- Toyota Slideshow --->
				                        <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				                        <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
				                        <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
				                    	<cfinvokeargument name="assets" value="#arguments.assets#"/>
				                    </cfinvoke>
				           	    <cfelse>
				                    <cfinvoke component="/cfcs/ultra10/variable_wow_slider_v1" method="wide">
				                        <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
				                        <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
				                        <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
				                        <cfinvokeargument name="assets" value="#arguments.assets#"/>
				                        <cfinvokeargument name="pg_nbr" value="#pg_nbr#"/>
										<cfif #pg_nbr# EQ 4 >
											<cfinvokeargument name="car_make" value="#url.v_make#"/>
										</cfif>
				                	</cfinvoke>
				               	</cfif>
								  
<!--- Mobile Search block --->	 <div class="srch-tabs-block-mbl visible-sm visible-xs">
									<div class="srch-tabs-title">Search Inventory</div>
									<div class="tab-pane active" id="srch">
										<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="btn_pull" value="pull-left"/>
										</cfinvoke>
									</div>
								</div>
								
						  </div>
					</div>
								 
				</div>  <!--- Container --->
		</section>

</cfoutput>		