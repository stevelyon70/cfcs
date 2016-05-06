<cfcomponent>
	<cffunction name="getNavSub" access="public" returntype="query">
		<cfargument name="modID" type="string" required="yes">
		<cfquery name="get_classfications" datasource="Ultra10" dbtype="ODBC">
            SELECT AM.ID, AMC.ClassificationID, AMC.Description, AM.Module ,  
                AM.SecLevel ,  AM.URL_parameters ,  AM.Screen_Title ,  AM.Status ,  
                AM.hierarchy , AM.category , AM.dealer_id, AM.mouse_over, AM.active  ,AM.scrn_target  
             FROM [Ultra10].[dbo].[Admin_Modules] as AM, [Ultra10].dbo.Admin_ModulesClassification as AMC
             WHERE AM.active = 1 
                and AM.ClassificationID = AMC.ClassificationID 
                and AM.ClassificationID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.modid#">
              order by  AMC.Description, AM.hierarchy, AM.Screen_Title ASC
        </cfquery>
		<cfreturn get_classfications>
	</cffunction>
</cfcomponent>