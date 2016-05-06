<cfoutput>

		<cfquery name="gt_new" datasource="Ultra10">
			SELECT 	Vehicle_ID, Dealer_ID, V_New_Used
			FROM   	Vehicles
			WHERE	Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4"> 
					 )
			AND	v_new_used = 'N'				 
		</cfquery>
		<cfquery name="gt_used" datasource="Ultra10">
			SELECT     Vehicle_ID, Dealer_ID, V_New_Used
			FROM         Vehicles
			WHERE	Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4"> 
					 )
			AND	V_New_Used = 'U' or V_New_Used = 'C'
		</cfquery>
		<cfquery name="gt_total" datasource="Ultra10">
			SELECT     Vehicle_ID, Dealer_ID, V_New_Used
			FROM         Vehicles
			WHERE	Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	ultra10.dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4"> 
					 )
		</cfquery>

<div class="container-fluid" >
		<section class="section-vehicle-count">
			<div class="container-vehicle-count pad-top-10 visible-md visible-lg visible-sm visible-xs">
				<div class="row row-centered">
					<div class="col-md-4 pad-top-10 vehicle-count-titles">
						#numberformat(gt_new.recordcount)# New Vehicles
					</div>
					<div class="col-md-4 pad-top-10 vehicle-count-titles">
						#numberformat(gt_total.recordcount)# Total Vehicles
					</div>
					<div class="col-md-4 pad-top-10 vehicle-count-titles" >
						#numberformat(gt_used.recordcount)# Used Vehicles
					</div>
				</div>
			</div>  
		</section>
</div>	
</cfoutput>		
