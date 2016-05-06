<cfcomponent extends="dealer">
<cffunction name="getBlogsByDealerId" access="public" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
  <cfargument name="dealer_id" type="numeric" required="yes">
  		<cfquery datasource="#arguments.dsn#" name="q1" ><!---cachedwithin="#CreateTimeSpan(0,4,0,0)#"--->
        	select *
            from Dealer_Wordpress
            where dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" >
            order by dealer_wordpress_id desc
        </cfquery>
  <cfreturn q1>
</cffunction>
<cffunction name="getBlogById" access="public" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
  <cfargument name="blogId" type="numeric" required="yes">
  		<cfquery datasource="#arguments.dsn#" name="q1">
        	select top 1 *
            from Dealer_Wordpress
            where Dealer_Wordpress_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.blogId#" >
        </cfquery>
  <cfreturn q1>
</cffunction>
<cffunction name="getBlogPageByScript" access="public" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
  <cfargument name="script" type="string" required="yes">
  <cfargument name="dealer_id" type="numeric" required="yes">
  		<cfquery datasource="#arguments.dsn#" name="q1" result="r1">
        	select top 1 *
            from dealer_pages
            where script_name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.script#" >
            and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" >
        </cfquery>
  <cfreturn q1>
</cffunction>

<cffunction name="getAllCategories" access="public" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
  		<cfquery datasource="#arguments.dsn#" name="q1" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        	select *
            from  dealer_blog_category
            order by category
        </cfquery>
  <cfreturn q1>
</cffunction>
<cffunction name="getAllActiveCategories" access="public" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
  		<cfquery datasource="#arguments.dsn#" name="q1" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        	select *
            from  dealer_blog_category
            where active = 1
            order by category
        </cfquery>
  <cfreturn q1>
</cffunction>
<cffunction name="getTagsSearchByString" access="public" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
  <cfargument name="crit" type="string" required="yes">
  		<cfquery datasource="#arguments.dsn#" name="q1" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        	select <cfif len(trim(arguments.crit)) eq 0>top 50</cfif> *
            from  dealer_wordpress_tags
            where 0=0 and wp_tag like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.crit#%" >
            order by wp_tag
        </cfquery>
  <cfreturn q1>
</cffunction>
<cffunction name="updateBlogByID" access="public" returntype="void">
  <cfargument name="dsn" type="string" required="yes">
  <cfargument name="_form" type="struct" required="yes">
  <cfset VARIABLES.securityObj = new cfcs.wdadmin.model.security()>
  
  <cftry>
  		<cfquery datasource="#arguments.dsn#">
        	update Dealer_Wordpress
            set Post_Title = '#arguments._form.Post_Title#',
            post_content = '#arguments._form.post_content#',
            post_tags = '#arguments._form.post_tags#'          
            
	    <cfif VARIABLES.securityObj.isModAuth(moduleID=66)>
	       <!--- ,Date_Submitted = '#arguments._form.Date_Submitted#'
            ,Time_Submitted = '#arguments._form.Time_Submitted#'--->
            ,categoryid = #arguments._form.category#
            ,active = #arguments._form.active#
            ,status = '#arguments._form.status#'
         </cfif>
            where post_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments._form.postID#" >
        </cfquery>        
	    <cfif VARIABLES.securityObj.isModAuth(moduleID=66)>
  		<cfquery datasource="#arguments.dsn#">
        	update dealer_pages
            set meta_title = '#arguments._form.meta_title#',
            meta_description = '#arguments._form.meta_description#',
            meta_keywords = '#arguments._form.meta_keywords#',
            page_title = '#arguments._form.page_title#',
            page_name = '#arguments._form.page_title#',
            start_date = '#arguments._form.start_date#',
            end_date = '#arguments._form.end_date#'            
            where dealer_page_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments._form.pageId#" >
        </cfquery>
    	</cfif> 
   <cfcatch type="any">
   		<cfmail from="seo@worlddealer.net" to="slyon@worlddealer.net" subject="blog update error" type="html">			
            <cfdump var="#cfcatch#">
        </cfmail>
        <cflocation url="blog.cfm">
   </cfcatch>
   </cftry>   
        <!--- send note --->
        <cfmail from="seo@worlddealer.net" to="slyon@worlddealer.net" subject="blog update" type="html">
        	A blog entry has been updated.<br />
            #this.getDealerById(arguments._form.dealer_id).display_name#<br/>
            <a href="http://#cgi.HTTP_HOST#/wdadmin/modules/admin/blog.cfm?action=editForm&blogID=#arguments._form.blogID#">View</a><br />
        	<cfdump var="#arguments._form#">
        </cfmail>
        <!---<cfmail from="seo@worlddealer.net" to="seo@worlddealer.net" subject="blog update" type="html">
        	A blog entry has been updated.<br />
            
            <a href="http://#cgi.HTTP_HOST#/wdadmin/modules/admin/blog.cfm?action=editForm&blogID=#arguments._form.blogID#">View</a><br />
        </cfmail>--->
        
       
</cffunction>
<cffunction name="insertBlog" access="public" returntype="void">
  <cfargument name="dsn" type="string" required="yes">
  <cfargument name="_form" type="struct" required="yes">
  
  <cfparam name="arguments._form.active" default="0">
  <cfparam name="arguments._form.status" default="Writer">
  <cfparam name="arguments._form.meta_title" default="">
  <cfparam name="arguments._form.meta_description" default="">
  <cfparam name="arguments._form.meta_keywords" default="">
  <cfparam name="arguments._form.Post_Title" default="">
  <cfparam name="arguments._form.page_title" default="#arguments._form.Post_Title#">
  <cfparam name="arguments._form.start_date" default="#dateformat(now(), "yyyy-mm-dd")#">  
  <cfparam name="arguments._form.end_date" default="#dateformat(now(), "yyyy-mm-dd")#">   
  <cfparam name="arguments._form.date_submitted" default="#dateformat(now(), "mm/dd/yyyy")#">   
  <cfparam name="arguments._form.category" default="0">  
  
  <cfset post_id = '#dateformat(now(),"yyyy-mm-dd")#T#timeformat(now(),"hh:mm:ss")#Z'>  
  <cfset request.folder = replace(dateformat(arguments._form.date_submitted, "yyyy\mm"),"-","/", "all")>  
  <cfoutput>#this.createStructureAndScript(request.folder, arguments._form.post_title, post_id)#</cfoutput>  
  <cfset permaLink = this.permaLinkGen(arguments._form.post_title)>    
  <cftry>
    <cfquery datasource="#arguments.dsn#">
        insert into Dealer_Wordpress
        	(post_id, dealer_id, Date_Submitted,Time_Submitted,Post_Title,post_content,post_tags,active,status, archive_submitted, post_summary, perma_link, categoryId)
        values        ('#post_id#',#arguments._form.dealer_id#,'#arguments._form.Date_Submitted#','#arguments._form.Time_Submitted#','#arguments._form.Post_Title#','#arguments._form.post_content#','#arguments._form.post_tags#',#arguments._form.active#,'#arguments._form.status#', '#monthasstring(listlast(request.folder,'\'))# #listfirst(request.folder, '\')#', '#arguments._form.post_content#', '#permaLink#', #arguments._form.category#)
    </cfquery>    
    <cfquery datasource="#arguments.dsn#">
        insert into dealer_pages
        	(dealer_id, meta_title,meta_description,meta_keywords,page_title,page_name,start_date,end_date, script_name, directory)
        values        	(#arguments._form.dealer_id#,'#arguments._form.meta_title#','#arguments._form.meta_description#','#arguments._form.meta_keywords#','#arguments._form.page_title#','#arguments._form.page_title#','#arguments._form.start_date#','#arguments._form.end_date#', '/blog/#dateformat(arguments._form.date_submitted, "yyyy/mm")#/#permaLink#', 'blog')
    </cfquery>
   <cfcatch type="any">
   		<cfmail from="seo@worlddealer.net" to="slyon@worlddealer.net" subject="blog entry error" type="html">			
            <cfdump var="#cfcatch#">
        </cfmail>
        <cflocation url="blog.cfm">
   </cfcatch>
   </cftry>
  <!--- send note --->
        <cfmail from="seo@worlddealer.net" to="slyon@worlddealer.net" subject="blog entry" type="html">
        	A blog entry has been added.<br />
            Dealer : (#arguments._form.dealer_id#) #this.getDealerById(arguments._form.dealer_id).display_name#<br />
            
            <a href="http://#cgi.HTTP_HOST#/wdadmin/modules/admin/blog.cfm">View</a><br />
			<cfoutput>#post_id#</cfoutput>
            <cfdump var="#arguments._form#">
        </cfmail>
        <cfmail from="seo@worlddealer.net" to="michael@worlddealer.net,randi@worlddealer.net" subject="new blog entry" type="html">
        	A blog entry has been added.<br />
            Dealer : #arguments._form.dealer_id#<br />
            
            <a href="http://#cgi.HTTP_HOST#/wdadmin/modules/admin/blog.cfm">View</a><br />
        </cfmail>
</cffunction>


<cffunction name="removeBlog" access="public" returntype="void">
    <cfargument name="dsn" type="string" required="yes">
	<cfargument name="blogId" type="string" required="yes">   
    <cfargument name="pageId" type="string" required="yes">  
    <cfargument name="dealer_id" type="string" required="yes">
    
    <cfquery datasource="#arguments.dsn#">
        delete
        from Dealer_Wordpress
        where Dealer_Wordpress_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.blogId#" >
    </cfquery>
    
    <cfquery datasource="#arguments.dsn#" name="q1" result="r1">
        delete
        from dealer_pages
        where dealer_page_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageId#" >
        and dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" >
    </cfquery>
    
</cffunction>


<cffunction name="createStructureAndScript" access="package" returntype="void" output="yes">
	<cfargument name="folder" type="string" required="yes">
    <cfargument name="postTitle" type="string" required="yes">
    <cfargument name="postId" type="string" required="yes">
    <cfset siteDepthObj = new cfcs.automation.site_depth()>
    
	    <cfset _base = 'E:\inetpub\wwwroot\Ultra10\blog\'>    
	    <cfset _folder = _base & arguments.folder>
        <cfset permaLink = this.permaLinkGen(arguments.postTitle)> 
        <cftry>       
        <cfset DirectoryCreate(_folder)>
         <cfcatch type="any">
        	<!---<cfdump var="#cfcatch#">--->
        </cfcatch>
        </cftry>
        <cfset opInx = '<cfset url.archive_date="#monthasstring(listlast(arguments.folder,'\'))# #listfirst(arguments.folder, '\')#"><cfinvoke component="/cfcs/ultra10/templates/##url.template_id##/page_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="component_name" value="/cfcs/ultra10/blog"/><cfinvokeargument name="method_name" value="list_date"/><cfinvokeargument name="display_type" value="full"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>'>
        <cfset opScr = '<cfset url.Post_ID="#postId#"><cfset url.archive_date="#monthasstring(listlast(arguments.folder,'\'))# #listfirst(arguments.folder, '\')#"><cfinvoke component="/cfcs/ultra10/templates/##url.template_id##/page_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="component_name" value="/cfcs/ultra10/blog"/><cfinvokeargument name="method_name" value="single"/><cfinvokeargument name="display_type" value="full"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>'>
        <cftry>
        	<cfset tmp = siteDepthObj.create_file(server_location='#_folder#', file_name='index.cfm', file_output=opInx)>    
        <cfcatch type="any">
        	<!---<cfdump var="#cfcatch#">--->
        </cfcatch>
        </cftry>
        <cftry>
	        <cfset tmp = siteDepthObj.create_file(server_location='#_folder#', file_name=permaLink, file_output=opScr)>       
        <cfcatch type="any">
        	<!---<cfdump var="#cfcatch#">--->
        </cfcatch>
        </cftry> 
   
</cffunction>
<cffunction name="permaLinkGen" access="package" returntype="string">
	<cfargument name="pt" type="string" required="yes">
    
    <cfscript>
	_str = arguments.pt;		
	_str = replace(_str, " ", "-", "all");	
	//add more chars to remove ()
	_str = _str & '.cfm';
	return _str;	
	</cfscript>
    
</cffunction>


<cffunction name="getAllLaunchResponses" returntype="query">
  <cfargument name="dsn" type="string" required="yes">
	<cfquery name="q1" datasource="#arguments.dsn#">
    	select *
        from WD_SEO_Launch_Responses
        order by enteredOn desc
    </cfquery>
    
    
    <cfreturn q1>
</cffunction>


</cfcomponent>