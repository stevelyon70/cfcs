<cfoutput>
		
<!--- Splash Marketing Banners --->

	<cfquery name="Chk_Splash" datasource="Ultra10" >
		SELECT  Nav_ID, Dealer_ID, Nav_Type_ID,Start_Date, End_Date
		FROM    Navigation
		WHERE  	Dealer_ID = #url.dealer_id# 
		AND 	Nav_Type_ID = 70  
		AND GETDATE() between Start_Date AND End_Date 	
	</cfquery>
	<cfif #Chk_Splash.recordcount# NEQ 0 >
		<section class="section-banners">
			<div class="container visible-md visible-lg visible-sm visible-xs">
				<div class="row-centered">
					<div class="col-centered no-pad" style="align:center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="70"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke>
					</div>
				</div>
			</div>  
		</section>
	</cfif>

</cfoutput>
