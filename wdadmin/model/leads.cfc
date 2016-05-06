<cfcomponent extends="dealer">
	<cffunction name="getAllLeads" access="public" returntype="query">
    	<cfargument name="sortBy" default="Lead_Type_ID ASC" />
    
		<cfquery name="get_lead_types" datasource="Leads" dbtype="ODBC">
            SELECT  Lead_Type_ID, Lead_Type, Ultra10
            FROM    Lead_Types
            WHERE active = 1
            <cfif len(arguments.sortBy)>
            ORDER BY #arguments.sortBy#
            </cfif>
        </cfquery> 
		<cfreturn get_lead_types>
	</cffunction>
    
    <cffunction name="getLeadsByDateDealer" access="public" returntype="query">
    	<cfargument name="fromDate" default="" required="no">
        <cfargument name="endDate" default="" required="no">
        <cfargument name="dealerID" default="0" required="no">
        
        <cfquery name="get_lead_types" datasource="Leads" dbtype="ODBC">
            SELECT Lead_Type, 
            Lead_Type_ID, 
            (SELECT (ISNULL(COUNT(Lead_Type_ID),0)) as cnt 
             FROM Leads 
             WHERE 0=0
             	<cfif len(arguments.fromDate)>AND Date_Submitted >= #CreateODBCDate(arguments.fromDate)#</cfif>
                <cfif len(arguments.endDate)>AND Date_Submitted <= #CreateODBCDate(arguments.endDate)#</cfif>
                AND Delivery_Dealer_ID = #arguments.dealerId#
                AND Lead_Type_ID = lt.Lead_Type_ID) as cnts
            FROM Lead_Types	as lt
            WHERE lt.active = 1 and not Lead_Type_ID = 3
        </cfquery>        
        <cfset u8leads = this.getLeadsByDateDealerUltra8(arguments.fromDate, arguments.endDate, arguments.dealerId)>
        <cfloop query="u8leads">        
        	<cfset tmp = queryAddRow(get_lead_types, {Lead_Type = "#u8leads.Lead_Type#", Lead_Type_ID = "#u8leads.Lead_Type_ID#", cnts = "#u8leads.cnts#"})>        
        </cfloop>
        
		<cfreturn get_lead_types>
    </cffunction>
    
     <cffunction name="getLeadsByDateDealerUltra8" access="public" returntype="query">
    	<cfargument name="fromDate" default="" required="no">
        <cfargument name="endDate" default="" required="no">
        <cfargument name="dealerID" default="0" required="no">
        
        <cfquery name="get_old_lead_types" datasource="Leads" dbtype="ODBC">
        	SELECT Lead_Type, 
            Lead_Type_ID, 
        	(SELECT (ISNULL(COUNT(LeadType_ID),0)) as cnt
             FROM ultra8.dbo.Leads u8l
             WHERE 0=0
             	<cfif len(arguments.fromDate)>AND Date_Submitted >= '#dateformat(arguments.fromDate, 'yyyy-mm-dd')# 00:00:00'</cfif>
                <cfif len(arguments.endDate)>AND Date_Submitted <= '#dateformat(arguments.endDate, 'yyyy-mm-dd')# 23:59:59'</cfif>
            	and u8l.LeadType_ID = 3
                and u8l.dealercode = '0123-0002-999-01-379B0PINTO'
            ) as cnts
                FROM  leads.dbo.Lead_Types	as lt
                WHERE lt.active = 1 
                	and lt.Lead_Type_ID = 3           
        </cfquery>
		<cfreturn get_old_lead_types>
    </cffunction>

	<cffunction name="getLeadsByDateDealerType" access="public" returntype="query">
    	<cfargument name="fromDate" default="" required="no">
        <cfargument name="endDate" default="" required="no">
        <cfargument name="dealerID" default="0" required="no">
        <cfargument name="leadTypeId" default="0" required="no">
        
        <cfset _dealercode = trim(getDealerCodeById(arguments.dealerid))>
        <!--- get leads for dealer by lead type --->
        <cfquery name="get_lead_types" datasource="Leads" dbtype="ODBC">
            SELECT LT.Lead_Type, L.Lead_Type_ID, L.Lead_ID, L.Date_Submitted, C.First_Name, C.Last_Name, C.Email, C.Phone_1--, V.V_Year, V.V_Make, V.V_Model
             FROM Leads L, Contacts C, Lead_Types LT--, Vehicles V
             WHERE 0=0
             	and LT.active = 1
             	and L.Lead_type_id = LT.lead_type_id
             	and L.lead_id = C.lead_id
                --and L.lead_id = V.lead_id
             	<cfif len(arguments.fromDate)>AND Date_Submitted >= '#dateformat(arguments.fromDate, 'yyyy-mm-dd')# 00:00:00'</cfif>
                <cfif len(arguments.endDate)>AND Date_Submitted <= '#dateformat(arguments.endDate, 'yyyy-mm-dd')# 23:59:59'</cfif>
                AND Delivery_Dealer_ID = #arguments.dealerId#
                AND L.Lead_Type_ID = #arguments.leadTypeId#
                
            union 
            
            select lt.Lead_Type, l.LeadType_ID, l.LeadID, l.Date_Submitted, l.Applicant1_FirstName, l.Applicant1_LastName, l.Applicant1_Email, l.Applicant1_Phone_1             from leads.dbo.Lead_Types lt, ultra8.dbo.Leads l
            where lt.Lead_Type_ID = l.LeadType_ID
                and l.Dealercode = '#_dealercode#'
                and lt.Lead_Type_ID=#arguments.leadTypeId#
                <cfif len(arguments.fromDate)>AND Date_Submitted >= '#dateformat(arguments.fromDate, 'yyyy-mm-dd')# 00:00:00'</cfif>
                <cfif len(arguments.endDate)>AND Date_Submitted <= '#dateformat(arguments.endDate, 'yyyy-mm-dd')# 23:59:59'</cfif>
            order by Date_Submitted desc
         </cfquery>
		<cfreturn get_lead_types>
    </cffunction>
    
    <cffunction name="getLeadByLeadId" access="public" returntype="query">
        <cfargument name="leadId" default="0" required="no">
        <!--- get leads for dealer by lead type --->
        <cfquery name="get_lead_types" datasource="Leads" dbtype="ODBC">
            SELECT L.*, LT.lead_type
             FROM Leads L, Lead_Types LT
             WHERE 0=0
             	and L.Lead_type_id = LT.lead_type_id  
                AND L.lead_id = #arguments.leadId#
        </cfquery>
		<cfreturn get_lead_types>
    </cffunction>
    
    
    <cffunction name="getLeadVehicleByLeadID" access="public" returntype="query">
        <cfargument name="leadID" default="0" required="no">
        <!--- get leads for dealer by lead type --->
        <cfquery name="get_lead_types" datasource="Leads" dbtype="ODBC">
            SELECT  v_year,v_make,v_model,vin, vehicle_type, stock, V_NewUsed, FMC_Start_Date, FMC_End_Date, Mileage_Min, Mileage_Max,Year_Min,Year_Max,Price_Min,Price_Max,V_Trim,V_Selling_Price,V_Offer,V_Body,V_Exterior_Color,V_Exterior_Color_2,V_Interior_Color,V_Interior_Color_2,V_Transmission,V_Engine,V_Options,V_Seating,V_License_Plate,V_Mileage,V_Cash_Down,V_Monthly_Payment,V_Balance,V_Estimated_Value,V_Condition,Purchase_Timeframe,Payment_Plan,Parts_Comments,Rental_Start,Rental_End,Comments
             FROM Vehicles V, Vehicle_Types f
             WHERE  V.lead_id = #arguments.leadID#
             and v.vehicle_type_id = f.vehicle_type_id
             
             union 
             
             select voi_year as v_year, voi_make as v_make, voi_model as v_model, '' as vehicle_type, '' as vin, '' as stock, '' as V_NewUsed, '' as FMC_Start_Date, '' as FMC_End_Date, '' as Mileage_Min,  '' as Mileage_Max, '' as Year_Min, '' as Year_Max, '' as Price_Min, '' as Price_Max, '' as V_Trim, '' as V_Selling_Price, '' as V_Offer, '' as V_Body, '' as V_Exterior_Color, '' as V_Exterior_Color_2, '' as V_Interior_Color, '' as V_Interior_Color_2, '' as V_Transmission, '' as V_Engine, '' as V_Options, '' as V_Seating, '' as V_License_Plate, '' as V_Mileage, '' as V_Cash_Down, '' as V_Monthly_Payment, '' as V_Balance, '' as V_Estimated_Value, '' as V_Condition, '' as Purchase_Timeframe, '' as Payment_Plan, '' as Parts_Comments, '' as Rental_Start, '' as Rental_End, '' as Comments
             from ultra8.dbo.leads 
             where leadid = #arguments.leadID#
        </cfquery>
		<cfreturn get_lead_types>
    </cffunction>
    
    <cffunction name="getLeadContactByLeadID" access="public" returntype="query">
        <cfargument name="leadID" default="0" required="no">
        <!--- get leads for dealer by lead type --->
        <cfquery name="get_lead_types" datasource="Leads" dbtype="ODBC">
            SELECT     	c.Contact_ID, c.Lead_ID, c.Contact_Type_ID, c.PIN, c.SSN, c.DOB, c.Prefix, c.First_Name, c.Middle_Name, c.Last_Name, c.Suffix, 
				c.Email, c.Phone_1, c.Phone_2, c.Fax, c.Address_1, c.Address_2, c.City, c.State, c.Zip, c.Relationship, c.License, c.Comments, 
				c.Business_Name, c.Tax_ID, c.Sales_Rep, c.Best_Time, c.Best_Method,
				e.Contact_Type_ID, e.Contact_Type
            FROM        Contacts c, Contact_Types e
            WHERE		c.Lead_ID = #arguments.leadID#
           	 AND			c.Contact_Type_ID = e.Contact_Type_ID
        </cfquery>
		<cfreturn get_lead_types>
    </cffunction>
    
    
</cfcomponent>