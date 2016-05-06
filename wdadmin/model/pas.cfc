<cfcomponent>
	<cffunction name="getPageContent" access="public" returntype="query">    
		<cfargument name="table" type="string" required="yes"> 
        <cfargument name="sortBy" type="string" required="no" default=""> 
        <cfargument name="criteria" type="string" required="no" default=""> 
        <cfquery datasource="#application.dsn#" name="c1">
        	select *
            from PghAutoShow.dbo.#arguments.table#
           <cfif len(arguments.criteria)>
            WHERE 0=0 #preservesinglequotes(arguments.criteria)#
           </cfif>
           <cfif #arguments.table# EQ "events">			<!--- Added 12/28 bob --->
            ORDER BY rank asc, hierarchy asc
			<cfelse>	
	           <cfif len(arguments.sortBy)>
	            ORDER BY #arguments.sortBy#
          	 </cfif>
           </cfif>
        </cfquery>		
		<cfreturn c1>
	</cffunction>
    <cffunction name="getPageBgImg" access="public" returntype="string">    
		<cfargument name="page" type="string" required="yes"> 
        <cfquery datasource="#application.dsn#" name="c1">
        	select bgImgUrl
            from PghAutoShow.dbo.pageSingleContent
            WHERE pageName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.page#">
        </cfquery>		
		<cfreturn c1.bgImgUrl>
	</cffunction>
    <cffunction name="getPageText" access="public" returntype="string">    
		<cfargument name="page" type="string" required="yes"> 
        <cfquery datasource="#application.dsn#" name="c1">
        	select textAreaMain
            from PghAutoShow.dbo.pageSingleContent
            WHERE pageName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.page#">
        </cfquery>		
		<cfreturn c1.textAreaMain>
	</cffunction>
    <cffunction name="updateAboutPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.about
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            textAreaSide = '#arguments.formFields.textAreaSide#',
            textAreaSub = '#arguments.formFields.textAreaSub#',
            lastUpdatedOn = #createodbcdatetime(now())#   ,
            lastUpdatedBy = '#GetAuthUser()#'         
        </cfquery>        
    </cffunction>   
   
    <cffunction name="updateSponsorPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.sponsors
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            textAreaSide = '#arguments.formFields.textAreaSide#',
            lastUpdatedOn = #createodbcdatetime(now())#     ,
            lastUpdatedBy = '#GetAuthUser()#'                
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateDirectionPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.directions
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            textAreaSide = '#arguments.formFields.textAreaSide#',
            lastUpdatedOn = #createodbcdatetime(now())#,
            lastUpdatedBy = '#GetAuthUser()#'                     
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateTicketsPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.tickets
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            textAreaSide = '#arguments.formFields.textAreaSide#',
            lastUpdatedOn = #createodbcdatetime(now())#   ,
            lastUpdatedBy = '#GetAuthUser()#'                  
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateMediaPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.media
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            lastUpdatedOn = #createodbcdatetime(now())# ,
            lastUpdatedBy = '#GetAuthUser()#'                    
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateFaqsPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.faqs
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            lastUpdatedOn = #createodbcdatetime(now())# ,
            lastUpdatedBy = '#GetAuthUser()#'                    
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateContactPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.contact
            set <!---textAreaMain = '#arguments.formFields.textAreaMain#',--->
            textAreaSide = '#arguments.formFields.textAreaSide#',
            recipientList = '#arguments.formFields.recipientList#',
            thankyouText = '#arguments.formFields.thankyouText#',
            lastUpdatedOn = #createodbcdatetime(now())#,
            lastUpdatedBy = '#GetAuthUser()#'                     
        </cfquery>        
    </cffunction>
    <cffunction name="updateGalleryPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.pageSingleContent
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            lastUpdatedOn = #createodbcdatetime(now())#   ,
            lastUpdatedBy = '#GetAuthUser()#'           
            where pageName = 'gallery'       
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateEventPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>              
          
        <cfquery datasource="#application.dsn#">
        	<cfif arguments.formFields.id eq 0>
            insert into PghAutoShow.dbo.events
            (dayText, timeText, headline, textAreaMain,lastUpdatedOn, lastUpdatedBy)
            values
            ('#left(arguments.formFields.dayText,50)#','#left(arguments.formFields.timeText,50)#','#left(arguments.formFields.headline,100)#','#arguments.formFields.textAreaMain#',#createodbcdatetime(now())#,'#left(GetAuthUser(),50)#')
            <cfelse>
            update PghAutoShow.dbo.events
            set textAreaMain = '#arguments.formFields.textAreaMain#',
                dayText = '#left(arguments.formFields.dayText,50)#',
                timeText = '#left(arguments.formFields.timeText,50)#',
                headline = '#left(arguments.formFields.headline,100)#',
                rank = '#arguments.formFields.rank#',
                hierarchy = '#arguments.formFields.hierarchy#',
                lastUpdatedOn = #createodbcdatetime(now())#,
            	lastUpdatedBy = '#left(GetAuthUser(),50)#'           
            where id = #arguments.formFields.id# 
            </cfif>
        	          
        </cfquery>        
    </cffunction>
    <cffunction name="delEvent" access="public" returntype="void">    	
    	<cfargument name="id" type="numeric" required="yes"/>          
        <cfquery datasource="#application.dsn#">        	
            delete 
            from PghAutoShow.dbo.events            
            where id = #arguments.id#        	          
        </cfquery>        
    </cffunction>
    
    <cffunction name="updateExhibitorPage" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>                      
        <cfquery datasource="#application.dsn#">        	
           update PghAutoShow.dbo.pageSingleContent
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            lastUpdatedOn = #createodbcdatetime(now())#,
            lastUpdatedBy = '#GetAuthUser()#'              
            where pageName = 'exhibitor'         	          
        </cfquery>        
    </cffunction>
    
    <cffunction name="updatePageContent" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/>        
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.pageSingleContent
            set textAreaMain = '#arguments.formFields.textAreaMain#',
            lastUpdatedOn = #createodbcdatetime(now())#,
            lastUpdatedBy = '#GetAuthUser()#'                
            where id =      #arguments.formFields.id#
        </cfquery>        
    </cffunction>
     <cffunction name="delVehicle" access="public" returntype="void">    	
    	<cfargument name="id" type="numeric" required="yes"/>          
        <cfquery datasource="#application.dsn#">        	
            delete 
            from PghAutoShow.dbo.vehicles            
            where id = #arguments.id#        	          
        </cfquery>        
    </cffunction>
    <cffunction name="updateVehicle" access="public" returntype="void">    	
    	<cfargument name="formFields" type="struct" required="yes"/> 
        <cfparam name="arguments.formFields.featured" default="0">
        <cfparam name="arguments.formFields.active" default="0">
        <cfif arguments.formFields.id eq 0>
         <cfquery datasource="#application.dsn#">
        	insert into PghAutoShow.dbo.vehicles
            (vMake,vModel,vYear,lastUpdatedOn, featured, rank, active)
            values
            ('#arguments.formFields.vMake#','#arguments.formFields.vModel#','#arguments.formFields.vYear#',#createodbcdatetime(now())# , #arguments.formFields.featured#, 1, #arguments.formFields.active#)
        </cfquery>
        <cfelse>
        <cfquery datasource="#application.dsn#">
        	update PghAutoShow.dbo.vehicles
            set vMake = '#arguments.formFields.vMake#',
            vModel = '#arguments.formFields.vModel#',
            vYear = '#arguments.formFields.vYear#',
            featured =#arguments.formFields.featured# ,
            active = #arguments.formFields.active#,
            lastUpdatedOn = #createodbcdatetime(now())#,
            lastUpdatedBy = '#GetAuthUser()#'                
            where id =      #arguments.formFields.id#
        </cfquery> 
        </cfif>                      
    </cffunction>
    
</cfcomponent>