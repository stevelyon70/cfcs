<cfoutput>
<!--- OEM Models --->  
		<cfquery name="Get_Assigned_OEMs" datasource="Ultra10" >
			SELECT  a.ID, a.dealer_id, a.dealer_oem_id, a.link_to, a.link_to_target, a.active, a.hierarchy,
					b.OEM_ID, b.Logo,b.OEM_Name, b.OEM_make
			FROM    Vulcan_Brand_Models a, OEM_Models b, OEMs c
			where 	a.dealer_id = #url.dealer_id#
			and		a.dealer_oem_id = b.OEM_ID
			and		b.OEM_Make = c.oem_id
			and a.active = 1
			order by a.hierarchy ASC
		</cfquery>

		<cfset nbr_col = "2" >

		<cfif  #Get_Assigned_OEMs.recordcount# GT 0 >
			
			<section class="section-oem-models">
				 <div class="container pad-top-10">
					
					<div class="row-centered">
						 <div class="col-centered col-md-offset-1" > 
							<cfloop query="Get_Assigned_OEMs" >
								<div class="col-md-#nbr_col# oem-model-name" >
									 <cfif  #len(Get_Assigned_OEMs.Logo)# gt 0 >
									 	<a href="#Get_Assigned_OEMs.link_to#" <cfif  #Get_Assigned_OEMs.link_to_target# NEQ 0 >target="_blank"</cfif> ><img alt="#Get_Assigned_OEMs.OEM_Name#" src="http://dealers.wdautos.com/images/brand_models/#Get_Assigned_OEMs.Logo#" class="img-responsive" ></a>
									 	#Get_Assigned_OEMs.OEM_Name#
									 <cfelse>
									 	#Get_Assigned_OEMs.OEM_Name#
									 </cfif> 
								</div>
							</cfloop>
					  	</div>  
					</div>

				<div class="clearfix"></div>
				</div>	 <!--- container --->
			</section>
		</cfif>
</cfoutput>