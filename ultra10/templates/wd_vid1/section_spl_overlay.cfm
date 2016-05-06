<cfoutput>
	<div container-fluid >
		<section class="section-splash-spl  no-pad">
			<div class="row-centered no-pad ">	
				<div class="col-md-12 no-pad" style="align:center">
					<div class="srch-tabs-block visible-md visible-lg">								<!--- Desktop Search --->	
						 <div class="srch-tabs-title">YOUR NEW VEHICLE IS HERE!</div>  
							<div class="tab-pane active" id="srch">
								<!--- <cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-left"/>
								</cfinvoke> --->
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="42"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="srch-links-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
						</div>
								 
						<cfif #ss_trigger# eq 1>   			  
				        	<cfinvoke component="/cfcs/ultra10/wow_slider_Toy" method="wide">		<!--- Toyota Slideshow --->
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
								  
					 	<div class="srch-tabs-block-mbl visible-sm visible-xs">						<!--- Mobile Search block --->
							<!--- <div class="srch-tabs-title">Search Inventory</div> --->
								<div class="tab-pane active" id="srch">
									<!--- <cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-left"/>
									</cfinvoke> --->
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="42"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="srch-links-btn"/>
										<cfinvokeargument name="glyph_right" value="true"/>
									</cfinvoke>
								</div>
							</div>
					  </div>
				</div>
		</section>
</div>
</cfoutput>		