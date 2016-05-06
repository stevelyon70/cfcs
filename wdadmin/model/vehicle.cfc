<cfcomponent>
	<cffunction name="getAllVehiclesCount" access="public" returntype="numeric">
		<cfquery name="vehicles" datasource="#application.dsn#">
            SELECT  count(vin) as cnt
            FROM    vehicles
        </cfquery> 
		<cfreturn vehicles.cnt>
	</cffunction>
    
    <cffunction name="getAllVehiclesCountByDealerId" access="public" returntype="numeric">
    <cfargument name="dealerID" default="0">
		<cfquery name="vehicles" datasource="#application.dsn#">
            SELECT  count(vin) as cnt
            FROM    vehicles
            WHERE dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
        </cfquery> 
		<cfreturn vehicles.cnt>
	</cffunction>
    
    <cffunction name="getAllVehiclesByDealerId" access="public" returntype="query">
    <cfargument name="dealerID" default="0">
		<cfquery name="vehicles" datasource="#application.dsn#">
            SELECT dealer_id, V_Make, v_model, Vin, V_Trim, V_Year, V_Style, V_Odometer, Exterior_Color, Transmission, Cylinders, Doors, permalink, v_new_used, interior_color, img_urls
            FROM    vehicles
            WHERE 0=0  
            <cfif arguments.dealerID>
            	and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealerID#">
            </cfif>
            ORDER BY v_make 
        </cfquery> 
		<cfreturn vehicles>
	</cffunction>
    
    
    <cffunction name="getAllVehiclesMakes" access="public" returntype="query">
		<cfquery name="makes" datasource="#application.dsn#">
            SELECT  distinct v_make
            FROM    vehicles
            order by v_make
        </cfquery> 
		<cfreturn makes>
	</cffunction>
    
    <cffunction name="getAllVehiclesModels" access="public" returntype="query">
		<cfquery name="models" datasource="#application.dsn#">
            SELECT  distinct v_model, v_make
            FROM    vehicles
            order by v_make, v_model
        </cfquery> 
		<cfreturn models>
	</cffunction>
    
    <cffunction name="getAllVehiclesTrims" access="public" returntype="query">
		<cfquery name="trims" datasource="#application.dsn#">
            SELECT  distinct v_model, v_make, v_trim
            FROM    vehicles
            order by v_make, v_model, v_trim
        </cfquery> 
		<cfreturn trims>
	</cffunction>
    
    <cffunction name="getAllVehiclesYears" access="public" returntype="query">
		<cfquery name="years" datasource="#application.dsn#">
            SELECT  distinct v_year
            FROM    vehicles
            order by v_year desc
        </cfquery> 
		<cfreturn years>
	</cffunction>
    
    <cffunction name="updateDealerVehicleByVin" access="public" returntype="string">
		<cfargument name="formFields" type="struct" required="yes">
        <cfparam name="myResult " default="Success">
		<cfif arguments.formFields.hold_Vehicle_ID eq 0>
			<cfif this.doesVinExist(arguments.formFields.vin)>
                <cfset myResult = 'We already have a vehicle with this VIN in our system. VINS are unique to each vehicle. Please check your VIN and make sure it is correct.'>
                <cfreturn myResult>
            </cfif>
        </cfif>  
        <cftransaction>	
        <cfset this.delVehicleOverrideByVin(arguments.formFields.vin)>  
        <cfset lastID = this.insertVehicleOverride(arguments.formFields)>      
        
        <cfquery datasource="#application.dsn#">
			INSERT INTO Vehicle_Override_Options 
            (Vin)
			Values     
            ('#arguments.formFields.vin#')
		</cfquery>   
        
        <!--- Delete from Vehicles if NOT a NEW ADDITION --->
		<cfif arguments.formFields.hold_Vehicle_ID neq 0>
		<cfquery datasource="#application.dsn#">
			DELETE 
            FROM Vehicles
			WHERE Vehicle_ID=<cfqueryparam value="#form.hold_Vehicle_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>        
		</cfif>
 
		 <cfif #form.hold_permalink# EQ "" >
			<cfset variables.Dealer_City=lcase(rereplace(arguments.formFields.hold_Dealer_City, " ", "_", "all"))> 	
		 	<cfset arguments.formFields.hold_permalink = "#arguments.formFields.V_Year#_#arguments.formFields.V_Make#_#arguments.formFields.V_Model#_#variables.dealer_city#_#arguments.formFields.hold_Dealer_State#_#form.vin#_wdi.cfm" >
		 </cfif>        
         
         <!--- insert into vehicles --->
        <cfset this.insertVehicle(arguments.formFields)>
        </cftransaction>        
		<cfreturn myResult>
	</cffunction>
    <cffunction name="insertVehicle" access="public" returntype="void">    
	<cfargument name="formFields" type="struct" required="yes">
    
    <cfquery datasource="#application.dsn#">
			INSERT INTO	Vehicles
						(	dealer_id,
							Vin,
							Stock,
							Permalink,
							V_New_Used, 
							V_Year,
							V_Make,
							V_Model,
							v_trim,
							V_style,
							v_model_number,
							doors,
							exterior_color,
							interior_color,
							engine_size,
							cylinders,
							transmission,
							drivetrain,
							v_odometer,
							certified,
							dealer_comments,
							img_urls,
							Selling_Price_Label,
							Selling_Price,
							MSRP_Label,  		
							MSRP_Price, 
							Rebate_Label,  		
							Rebate_Price, 	
							Incentive_Label,
							Incentive_Price,
							Savings_Label,
							Savings_Price,
							AIS_Label,
							AIS_Price,
							Video_Link, 
							V_Type,
							Passengers,
							Fuel_Type,
							EPA_City,
							EPA_HWY,
							Adjusted_Baseline,
							AIS_APR,
							Fleet,
							Luxury, 
							Commercial,
							Carfax_One_Owner,
							Autocheck,
							Dealer_Display_Name,
							Dealer_Address_1,
							Dealer_Address_2,
							Dealer_City,
							Dealer_State, 
							Dealer_Zip,
							Dealer_Phone, 
							Dealer_Url,
							Link_Finance, 
							Link_Service,
							Link_Sales,
							Link_Parts,
							Link_Directions,
							Disclaimer,
							AIS_wID,
							half_year,
							User_Edit , 
							V_Half_Year )
					VALUES 
						( 	#arguments.formFields.dealer_id#,
						  	<cfif #arguments.formFields.Vin# NEQ "">'#arguments.formFields.Vin#',<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.Stock# NEQ "">'#arguments.formFields.Stock#',<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.hold_permalink# NEQ "">	'#arguments.formFields.hold_permalink#' ,<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.V_New_Used# NEQ "">'#arguments.formFields.V_New_Used#',<cfelse>null,</cfif>
						  	#arguments.formFields.V_Year#, 
						  	<cfif #arguments.formFields.V_Make# NEQ "">'#arguments.formFields.V_Make#', <cfelse>null,</cfif>
							<cfif #arguments.formFields.V_Model# NEQ "">'#arguments.formFields.V_Model#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.v_trim# NEQ "">'#arguments.formFields.v_trim#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.V_style# NEQ "">'#arguments.formFields.V_style#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.v_model_number# NEQ "">'#arguments.formFields.v_model_number#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.doors# NEQ "">'#arguments.formFields.doors#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.exterior_color# NEQ "">'#arguments.formFields.exterior_color#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.interior_color# NEQ "">'#arguments.formFields.interior_color#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.engine_size# NEQ "">'#arguments.formFields.engine_size#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.cylinders# NEQ "">'#arguments.formFields.cylinders#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.transmission# NEQ "">'#arguments.formFields.transmission#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.drivetrain# NEQ "">'#arguments.formFields.drivetrain#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.v_odometer# NEQ "">#arguments.formFields.v_odometer#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.certified# NEQ "">#arguments.formFields.certified#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.dealer_comments# NEQ "">'#arguments.formFields.dealer_comments#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.img_urls# NEQ "">'#arguments.formFields.img_urls#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.Selling_Price_Label# NEQ "">'#arguments.formFields.Selling_Price_Label#', <cfelse>null,</cfif>
						  	<cfif #arguments.formFields.Selling_Price# NEQ "">#arguments.formFields.Selling_Price#,<cfelse>0,</cfif>
						  	<cfif #arguments.formFields.MSRP_Label# NEQ "">	'#arguments.formFields.MSRP_Label#',<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.MSRP_Price# NEQ "">#arguments.formFields.MSRP_Price#,<cfelse>0,</cfif>
						  	<cfif #arguments.formFields.Rebate_Label# NEQ "">	'#arguments.formFields.Rebate_Label#',<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.Rebate_Price# NEQ "">#arguments.formFields.Rebate_Price#,<cfelse>0,</cfif>
						  	<cfif #arguments.formFields.Incentive_Label# NEQ "">	'#arguments.formFields.Incentive_Label#',<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.Incentive_Price# NEQ "">#arguments.formFields.Incentive_Price#,<cfelse>0,</cfif>
						  	<cfif #arguments.formFields.Savings_Label# NEQ "">	'#arguments.formFields.Savings_Label#',<cfelse>null,</cfif>
						  	<cfif #arguments.formFields.Incentive_Price# NEQ "">#arguments.formFields.Savings_Price# ,<cfelse>0,</cfif>
						  	<cfif #arguments.formFields.AIS_Label# NEQ "">	'#arguments.formFields.AIS_Label#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.AIS_Price# NEQ "">	#arguments.formFields.AIS_Price#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Video_Link# NEQ "">'#arguments.formFields.hold_Video_Link#', <cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_V_Type# NEQ "">'#arguments.formFields.hold_V_Type#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Passengers# NEQ "">#arguments.formFields.hold_Passengers#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Fuel_Type# NEQ "">'#arguments.formFields.hold_Fuel_Type#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_EPA_City# NEQ "">#arguments.formFields.hold_EPA_City#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_EPA_HWY# NEQ "">#arguments.formFields.hold_EPA_HWY#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Adjusted_Baseline# NEQ "">#arguments.formFields.hold_Adjusted_Baseline#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_AIS_APR# NEQ "">'#arguments.formFields.hold_AIS_APR#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Fleet# NEQ "">#arguments.formFields.hold_Fleet#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Luxury# NEQ "">#arguments.formFields.hold_Luxury#, <cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Commercial# NEQ "">#arguments.formFields.hold_Commercial#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Carfax_One_Owner# NEQ "">#arguments.formFields.hold_Carfax_One_Owner#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Autocheck# NEQ "">#arguments.formFields.hold_Autocheck#,<cfelse>0,</cfif>
							<cfif #arguments.formFields.hold_Dealer_Display_Name# NEQ "">'#arguments.formFields.hold_Dealer_Display_Name#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_Address_1# NEQ "">'#arguments.formFields.hold_Dealer_Address_1#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_Address_2# NEQ "">'#arguments.formFields.hold_Dealer_Address_2#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_City# NEQ "">'#arguments.formFields.hold_Dealer_City#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_State# NEQ "">'#arguments.formFields.hold_Dealer_State#', <cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_Zip# NEQ "">'#arguments.formFields.hold_Dealer_Zip#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_Phone# NEQ "">'#arguments.formFields.hold_Dealer_Phone#', <cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Dealer_Url# NEQ "">'#arguments.formFields.hold_Dealer_Url#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Link_Finance# NEQ "">'#arguments.formFields.hold_Link_Finance#', <cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Link_Service# NEQ "">'#arguments.formFields.hold_Link_Service#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Link_Sales# NEQ "">'#arguments.formFields.hold_Link_Sales#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Link_Parts# NEQ "">'#arguments.formFields.hold_Link_Parts#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Link_Directions# NEQ "">'#arguments.formFields.hold_Link_Directions#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_Disclaimer# NEQ "">'#arguments.formFields.hold_Disclaimer#',<cfelse>null,</cfif>
							<cfif #arguments.formFields.hold_AIS_wID# NEQ "">'#arguments.formFields.hold_AIS_wID#',<cfelse>null,</cfif> 
							<cfif #arguments.formFields.hold_half_year# NEQ "">#arguments.formFields.hold_half_year#,<cfelse>0,</cfif>
							1,	
							<cfif #arguments.formFields.hold_V_Half_Year# NEQ "">#arguments.formFields.hold_V_Half_Year#<cfelse>0</cfif>  )
				</cfquery>
    
    </cffunction>
    <cffunction name="insertVehicleOverride" access="public" returntype="numeric">    
		<cfargument name="formFields" type="struct" required="yes">
        
        <cfquery datasource="#application.dsn#" name="Insert_Override_Details">
			INSERT INTO	Vehicle_Override
						(	dealer_id,
							Vin,
							Stock,
							Permalink,
							V_New_Used, 
							V_Year,
							V_Make,
							V_Model,
							v_trim,
							V_style,
							v_model_number,
							doors,
							exterior_color,
							interior_color,
							engine_size,
							cylinders,
							transmission,
							drivetrain,
							v_odometer,
							certified,
							dealer_comments,
							img_urls,
							Selling_Price_Label,
							Selling_Price,
							MSRP_Label,  		
							MSRP_Price, 
							Rebate_Label,  		
							Rebate_Price, 	
							Incentive_Label,
							Incentive_Price,
							Savings_Label,
							Savings_Price,
							AIS_Label,
							AIS_Price  )
					VALUES 
						( 	#arguments.formFields.dealer_id#,
						  	'#arguments.formFields.Vin#',
						  	'#arguments.formFields.Stock#',
						  	'#arguments.formFields.hold_permalink#' ,
						  	'#arguments.formFields.V_New_Used#',
						  	#arguments.formFields.V_Year#, 
						  	'#arguments.formFields.V_Make#', 
							'#arguments.formFields.V_Model#',
							'#arguments.formFields.v_trim#',
							'#arguments.formFields.V_style#',
							'#arguments.formFields.v_model_number#',
							'#arguments.formFields.doors#',
							'#arguments.formFields.exterior_color#',
							'#arguments.formFields.interior_color#',
							'#arguments.formFields.engine_size#',
							'#arguments.formFields.cylinders#',
							'#arguments.formFields.transmission#',
							'#arguments.formFields.drivetrain#',
							#arguments.formFields.v_odometer#,
							#numberformat(arguments.formFields.certified)#,
							'#arguments.formFields.dealer_comments#',
							'#arguments.formFields.img_urls#',
							<cfif #arguments.formFields.Selling_Price_Label# NEQ "">'#arguments.formFields.Selling_Price_Label#'<cfelse>null</cfif>, 
						  	<cfif #arguments.formFields.Selling_Price# NEQ "">#arguments.formFields.Selling_Price#<cfelse>0</cfif>,
						  	<cfif #arguments.formFields.MSRP_Label# NEQ "">'#arguments.formFields.MSRP_Label#'<cfelse>null</cfif>,
						  	<cfif #arguments.formFields.MSRP_Price# NEQ "">#arguments.formFields.MSRP_Price#<cfelse>0</cfif>,
						  	<cfif #arguments.formFields.Rebate_Label# NEQ "">'#arguments.formFields.Rebate_Label#'<cfelse>null</cfif>,
						  	<cfif #arguments.formFields.Rebate_Price# NEQ "">#arguments.formFields.Rebate_Price#<cfelse>0</cfif>,
						  	<cfif #arguments.formFields.Incentive_Label# NEQ "">'#arguments.formFields.Incentive_Label#'<cfelse>null</cfif>,
						  	<cfif #arguments.formFields.Incentive_Price# NEQ "">#arguments.formFields.Incentive_Price#<cfelse>0</cfif>,
						  	<cfif #arguments.formFields.Savings_Label# NEQ "">'#arguments.formFields.Savings_Label#'<cfelse>null</cfif>,
						  	<cfif #arguments.formFields.Savings_Price# NEQ "">#arguments.formFields.Savings_Price#<cfelse>0</cfif> ,
						  	<cfif #arguments.formFields.AIS_Label# NEQ "">'#arguments.formFields.AIS_Label#'<cfelse>null</cfif>,
						  	<cfif #arguments.formFields.AIS_Price# NEQ "">'#arguments.formFields.AIS_Price#'<cfelse>0</cfif> )
                            
              SELECT IDENT_CURRENT('Vehicle_Override') AS ID;
		</cfquery>
        
        <cfreturn Insert_Override_Details.ID>
    </cffunction>
    
    <cffunction name="delDealerVehicleOverrideByVin" access="public" returntype="void">
	    <cfargument name="vin" type="string" required="yes">    
        
        <cfquery name="DeleteEvent" datasource="#application.dsn#">
            Delete  
            From	
            Vehicle_Override 
            Where vin = '#arguments.vin#'
        </cfquery>    
    </cffunction>
    
    <cffunction name="delVehicleUserEditByVin" access="public" returntype="void">
	    <cfargument name="vin" type="string" required="yes">    
        
        <cfquery datasource="#application.dsn#" name="Clear_Vehicle_Status">
			UPDATE		Vehicles
			SET			Date_Updated=<cfqueryparam value="#DateFormat(now(),'mm/dd/yyyy')#" cfsqltype="CF_SQL_DATE">,
						User_Edit=0
			WHERE		Vin='#arguments.vin#'
		</cfquery>
		<cfset this.delVehicleOverrideByVin(arguments.vin)>
    </cffunction>    
    
    <cffunction name="doesVinExist" access="public" returntype="numeric">
		<cfargument name="vin" type="string" required="yes">        
        <cfquery datasource="#application.dsn#" name="Check_Vin">
			SELECT 	Vehicle_ID
			FROM	Vehicles
			WHERE	Vin=<cfqueryparam value="#left(arguments.Vin,21)#" cfsqltype="CF_SQL_VARCHAR" maxlength="21">
		</cfquery>        
		<cfreturn Check_Vin.recordcount>
	</cffunction>
    
    <cffunction name="delVehicleOverrideByVin" access="public" returntype="void">
		<cfargument name="vin" type="string" required="yes">    
	    <cfquery datasource="#application.dsn#" name="Delete_Vehicle_Override">
			DELETE 
            FROM	Vehicle_Override
			WHERE		Vin='#arguments.vin#'
		</cfquery>  
    </cffunction>
    
</cfcomponent>