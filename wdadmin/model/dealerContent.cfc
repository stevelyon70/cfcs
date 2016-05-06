<cfcomponent>

	<cffunction name="getVehiclesByDealerID" access="public" returntype="query">
    	<cfargument name="dealerID" type="numeric" required="yes">
        <cfargument name="newUsed" type="string" default="N">
        <cfquery datasource="#application.dsn#" name="qVehicles">
            SELECT     	Vehicle_id, 
                        Stock, 
                        V_Year, 
                        V_Make, 
                        V_Model, 
                        V_Trim, 
                        Vin, 
                        Selling_Price, 
                        Exterior_Color, 
                        V_Style, 
                        Transmission, 
                        DriveTrain, 
                        Engine_Size, 
                        Cylinders, 
                        Img_urls, 
                        date_updated,
                        user_edit
            FROM		Vehicles 
            WHERE     	Dealer_id = #arguments.dealerID#    
            	<cfif len(arguments.newUsed) >AND		V_New_Used = '#ucase(arguments.newUsed)#'   </cfif>
            ORDER BY 	Stock
        </cfquery>        
        <cfreturn qVehicles>    
    </cffunction>
    
    <cffunction name="getVehiclesByVin" access="public" returntype="query">
    	<cfargument name="vin" type="string" required="yes">
        <cfquery datasource="#application.dsn#" name="qVehicles">
            SELECT     	*
            FROM		Vehicles 
            WHERE     	VIN = '#arguments.vin#'
        </cfquery>        
        <cfreturn qVehicles>    
    </cffunction>
    
    <cffunction name="getVehicleOptionsByVin" access="public" returntype="query">
    	<cfargument name="vin" type="string" required="yes">
        <cfquery datasource="#application.dsn#" name="qVehicles">
            SELECT     Vehicle_Option_ID, Vin, Exterior, Installed, Interior, Mechanical, Safety, Misc
			FROM       Vehicle_Options
            WHERE     	VIN = '#arguments.vin#'
        </cfquery>        
        <cfreturn qVehicles>    
    </cffunction>
    
    
        <cffunction name="getDealerAddrById" access="public" returntype="query">
    	<cfargument name="dealerId" type="numeric" required="yes">
	    <cfquery name="get_logo" datasource="Ultra10">
        	SELECT  Dealer_ID, Display_Name, primary_url, primary_phone, dealer_directory, Address_1, Address_2, City, State, Zip 
            FROM Dealers 
            WHERE Dealer_ID =  #arguments.dealerId#
        </cfquery> 
        <cfreturn get_logo>
        </cffunction>
    
    
	<cffunction name="getDealerSpecialsByDealerId" access="public" returntype="query">
		<cfargument name="dealerID" type="numeric" required="yes">
        <cfargument name="classID" type="numeric" required="yes">
        
        <cfquery datasource="#application.dsn#" name="Get_Specials">
            SELECT     	Vehicle_Special_ID,
                        Dealer_id, 
                        Special_Title, 
                        Vin, 
                        Vehicle_Image,
                        Vehicle_Year, 
                        Make, 
                        Model,
                        Was_Price, 
                        Is_Price,
                        Special_Desc,
                        Bullet_1, 
                        Bullet_2, 
                        Bullet_3, 
                        Bullet_4, 
                        Bullet_5,
                        Special_Footer,
                        Start_Date,
                        Expiration_Date,
                        Special_Type
            FROM		Vehicle_Specials
            WHERE     	Dealer_id = <cfqueryparam value="#arguments.dealerID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
                and Special_Class_ID = <cfqueryparam value="#arguments.classID#" cfsqltype="CF_SQL_INTEGER" maxlength="1">
            Order by 	Dealer_id,Hierarchy
        </cfquery>
		<cfreturn Get_Specials>
	</cffunction>
    
    
    <cffunction name="setSpecialsHierUp" access="public" returntype="void">
    	<cfargument name="specialID" type="numeric" required="yes">
        <cfargument name="dealerID" type="numeric" required="yes">
        <cfargument name="classID" type="numeric" required="yes">
        <cfquery datasource="#application.dsn#" name="Get_H">
                SELECT 	Hierarchy
                FROM	Vehicle_Specials
                WHERE	Vehicle_Special_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
            </cfquery>
            <cfset Old_H=Get_H.Hierarchy>
            <cfset New_H=Get_H.Hierarchy-1>
            <cfquery datasource="#application.dsn#" name="Update_Hierarchy">
                UPDATE	Vehicle_Specials
                SET		Hierarchy=<cfqueryparam value="#New_H#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
                WHERE	Vehicle_Special_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
            </cfquery>
            <cfquery datasource="#application.dsn#" name="Update_Hierarchy">
                UPDATE	Vehicle_Specials
                SET		Hierarchy=<cfqueryparam value="#Old_H#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
                WHERE	Vehicle_Special_ID<><cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
                AND		Hierarchy=<cfqueryparam value="#New_H#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
                AND		dealer_id=<cfqueryparam value="#arguments.dealerID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
                AND		Special_Class_ID=<cfqueryparam value="#arguments.classID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
            </cfquery>
    
    </cffunction>
    
     <cffunction name="setSpecialsHierDown" access="public" returntype="void">
    	<cfargument name="specialID" type="numeric" required="yes">
        <cfargument name="dealerID" type="numeric" required="yes">
        <cfargument name="classID" type="numeric" required="yes">
    	<cfquery datasource="#application.dsn#" name="Get_H">
			SELECT 	Hierarchy
			FROM	Vehicle_Specials
			WHERE	Vehicle_Special_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
		<cfset Old_H=Get_H.Hierarchy>
		<cfset New_H=Get_H.Hierarchy+1>
		<cfquery datasource="#application.dsn#" name="Update_Hierarchy">
			UPDATE	Vehicle_Specials
			SET		Hierarchy=<cfqueryparam value="#New_H#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
			WHERE	Vehicle_Special_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
		<cfquery datasource="#application.dsn#" name="Update_Hierarchy">
			UPDATE	Vehicle_Specials
			SET		Hierarchy=<cfqueryparam value="#Old_H#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
			WHERE	Vehicle_Special_ID<><cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
			AND		Hierarchy=<cfqueryparam value="#New_H#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
			AND		dealer_id=<cfqueryparam value="#arguments.dealerID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
			AND		Special_Class_ID=<cfqueryparam value="#arguments.classID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
       </cffunction>
       
       <cffunction name="setSpecialsExpireByID" access="public" returntype="void">
    	<cfargument name="specialID" type="numeric" required="yes">
       	
        <cfquery datasource="#application.dsn#" name="Expire_Special">
			UPDATE	Vehicle_Specials
			SET		Expiration_Date=<cfqueryparam value="#createODBCdate(dateadd("ww",-1,now()))#" cfsqltype="CF_SQL_DATE">
			WHERE	Vehicle_Special_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
        
       </cffunction>
       
       <cffunction name="delSpecialById" access="public" returntype="void">
    	<cfargument name="specialID" type="numeric" required="yes">
        <cfargument name="dealerID" type="numeric" required="yes">
        
       	<cfquery datasource="#application.dsn#" name="Expire_Special">
			DELETE	Vehicle_Specials
			WHERE	Vehicle_Special_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
		<cfquery datasource="#application.dsn#" name="Get_Remaining">
			SELECT		Vehicle_Special_ID
			FROM		Vehicle_Specials
			WHERE		dealer_id=<cfqueryparam value="#arguments.dealerID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
			AND			Special_Class_ID=<cfqueryparam value="#arguments.specialID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
			ORDER BY	Hierarchy
		</cfquery>
		<cfloop query="Get_Remaining">
			<cfquery datasource="#application.dsn#" name="Update_Hierarchy">
				UPDATE	Vehicle_Specials
				SET		Hierarchy=<cfqueryparam value="#Get_Remaining.Currentrow#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
				WHERE	Vehicle_Special_ID=<cfqueryparam value="#Get_Remaining.Vehicle_Special_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="10">
			</cfquery>
		</cfloop>
       </cffunction>
       
       <cffunction name="getDealerPagesByDealerId" access="public" returntype="query">
    	<cfargument name="dealerid" type="numeric" required="yes">
        <cfquery datasource="#application.dsn#" name="qData">
            SELECT     	*
            FROM		Dealer_Pages
			WHERE		Dealer_ID = #arguments.dealerid#
                AND			script_name not like '/blog/%'
                AND			script_name not like '/dealer/%'
                or			script_name like '/dealer/worlddealergeneric/%'
                AND			pg_type <> 1
            ORDER BY page_name
        </cfquery>        
        <cfreturn qData>    
    </cffunction>
    <cffunction name="getDealerPagesByDealerPageId" access="public" returntype="query">
    	<cfargument name="dealerPageId" type="numeric" required="yes">
        <cfquery datasource="#application.dsn#" name="qData">
            SELECT     	*
            FROM		Dealer_Pages
			WHERE		dealer_page_id = #arguments.dealerPageId#
                AND			script_name not like '/blog/%'
                AND			script_name not like '/dealer/%'
                or			script_name like '/dealer/worlddealergeneric/%'
                AND			pg_type <> 1
            ORDER BY page_name
        </cfquery>        
        <cfreturn qData>    
    </cffunction>
</cfcomponent>