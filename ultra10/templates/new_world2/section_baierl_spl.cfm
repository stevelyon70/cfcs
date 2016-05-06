
<cfoutput>

<div class="container-fluid  ">	 
 
	
<section class="section-splash-spl">	
		
<!--- <div class="visible-md visible-lg visible-sm visible-xs" >
	<div class="row no-pad">	
		<cfset nbr_cols = 12 >
		<div class="col-md-#nbr_cols# no-pad   ">
	        	<cfinvoke component="/cfcs/ultra10/variable_wow_slider_v1" method="wide">
	                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
	                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
	                <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
	                <cfinvokeargument name="assets" value="#arguments.assets#"/>
	                <cfinvokeargument name="pg_nbr" value="#pg_nbr#"/>
	            </cfinvoke>
	 
		 
		</div>
	</div>
	
</div> --->
 
	<div class="row no-pad">	

		<!--- <div class="visible-sm visible-xs  ">
			<div class="col-md-12 no-pad   ">
    	    	<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="nav_type_id" value="34"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
				</cfinvoke>
			</div>
		</div> --->
		
		<div class="visible-md visible-lg visible-sm visible-xs ">
			<div class="col-md-12 no-pad   ">
	        	<cfinvoke component="/cfcs/ultra10/variable_wow_slider_v1" method="wide">
	                <cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
	                <cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
	                <cfinvokeargument name="nav_type_id" value="#ss_type#"/>
	                <cfinvokeargument name="assets" value="#arguments.assets#"/>
	                <cfinvokeargument name="pg_nbr" value="#pg_nbr#"/>
	            </cfinvoke>
			</div>
		</div>
	</div>
  
</section>
 
</div>  <!--- end of container-fluid --->

</cfoutput>		
