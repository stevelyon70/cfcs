<cfoutput>
<div class="container-fluid">		
	<section class="section-splash-spl  no-pad">
		<div class="row-centered no-pad">	
			<cfset nbr_cols = 12 >
			<div class="col-md-#nbr_cols# no-pad" style="align:center">
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
	  		</div>
		</div>
	</section>
</div>
</cfoutput>		