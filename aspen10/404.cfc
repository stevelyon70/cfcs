<cfcomponent>

	<cffunction name="fnf" description="Ultra 10 404 handeler" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="my_page_type" default=""/>
		
		<!---get page type--->
		<cfif right(cgi.script_name,8) eq "_wdi.cfm">
			<cfset arguments.my_page_type = "v_details">
		</cfif>
		<cfif left(cgi.script_name,6) eq "/blog/">
			<cfset arguments.my_page_type = "blog">
		</cfif>
		<cfif left(cgi.script_name,10) eq "/showroom/">
			<cfset arguments.my_page_type = "showroom">
		</cfif>

		<cfswitch expression="#arguments.my_page_type#">

			<cfdefaultcase>
				<cflocation url="http://#cgi.server_name#/file_not_found.cfm">
			</cfdefaultcase>

			<cfcase value="showroom">
				
				<cfparam name="url.chrome_model_id" default="0" >

				<cfquery datasource="Ultra8" name="Get_Model_Details">
					SELECT		Chrome_Model_ID,
								Vehicle_Make
					FROM		Chrome_Reviews
					WHERE		Chrome_Model_ID = <cfqueryparam value="#url.chrome_model_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
				</cfquery>

				<cfif Get_Model_Details.Recordcount gt 0 and len(trim(Get_Model_Details.Vehicle_Make)) gt 0>

					<cfset variables.server_location="E:\inetpub\wwwroot\Aspen10\showroom">
					
					<cfinvoke component="/cfcs/automation/site_depth" method="create_folder">
						<cfinvokeargument name="server_location" value="#variables.server_location#"/>
						<cfinvokeargument name="folder_name" value="#lcase(Get_Model_Details.Vehicle_Make)#"/>
					</cfinvoke>

					<cfinvoke component="/cfcs/automation/site_depth" method="create_file">
						<cfinvokeargument name="server_location" value="#variables.server_location#\#lcase(Get_Model_Details.Vehicle_Make)#"/>
						<cfinvokeargument name="file_name" value="index.cfm"/>
						<cfinvokeargument name="file_output" value='<cfset url.v_make="#Get_Model_Details.Vehicle_Make#"><cfinvoke component="/cfcs/aspen10/templates/##url.template_id##/page_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="component_name" value="/cfcs/aspen10/chrome_reviews"/><cfinvokeargument name="method_name" value="##url.site_mode##_index"/><cfinvokeargument name="display_type" value="col_right"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>'/>
					</cfinvoke>

					<cfinvoke component="/cfcs/automation/site_depth" method="create_file">
						<cfinvokeargument name="server_location" value="#variables.server_location#\#lcase(Get_Model_Details.Vehicle_Make)#"/>
						<cfinvokeargument name="file_name" value="#lcase(GetFileFromPath(cgi.CF_TEMPLATE_PATH))#"/>
						<cfinvokeargument name="file_output" value='<cfset url.chrome_model_id="#url.chrome_model_id#"><cfinvoke component="/cfcs/aspen10/templates/##url.template_id##/page_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="component_name" value="/cfcs/aspen10/chrome_reviews"/><cfinvokeargument name="method_name" value="##url.site_mode##_review"/><cfinvokeargument name="display_type" value="col_right"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>'/>
					</cfinvoke>

				</cfif>

				<cfif len(trim(Get_Model_Details.Vehicle_Make)) gt 0>
					<cflocation url="http://#cgi.server_name#/showroom/#lcase(Get_Model_Details.Vehicle_Make)#/review.cfm?chrome_model_id=#url.Chrome_Model_ID#">
				<cfelse>
					<cflocation url="http://#cgi.server_name#/file_not_found.cfm">
				</cfif>
			
			</cfcase>
			
			<cfcase value="v_details">
				<!---Get Vehicle Details--->
				<cfstoredproc datasource="Aspen10" procedure="Get_Vehicle_Details_Permalink">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@permalink" value="#left(GetFileFromPath(cgi.CF_TEMPLATE_PATH),200)#" maxlength="200">
					<cfprocresult name="Get_Vehicle_Details" resultset="1">
				</cfstoredproc>

				<cfif 	len(trim(Get_Vehicle_Details.V_Make)) gt 0
						and len(trim(Get_Vehicle_Details.V_Model)) gt 0
						and len(trim(Get_Vehicle_Details.Permalink)) gt 0
						and len(trim(Get_Vehicle_Details.Vin)) gt 0>
					<cfset variables.server_location="E:\inetpub\wwwroot\Aspen10\vehicles">

					<!---check make directory--->
					<cfdirectory action="list"
								 directory="#variables.server_location#\#Get_Vehicle_Details.V_Make#"
								 name="check_dir">
					<cfif check_dir.recordcount eq 0>
						<!--- If no directory, Create directory. --->
						<cftry>
							<cfdirectory action="CREATE"
										 directory="#variables.server_location#\#lcase(Get_Vehicle_Details.V_Make)#">
							<cfcatch></cfcatch>
						</cftry>
						<!--- If no directory, Create ph.txt (placeholder) file. --->
						<cftry>
							<cffile action="WRITE"
									file="#variables.server_location#\#Get_Vehicle_Details.V_Make#\ph.txt"
									addnewline="No"
									output="#dateformat(now(),'mm/dd/yyyy')# #timeformat(now(),'hh:mm tt')#"
									nameconflict="OVERWRITE">
							<cfcatch></cfcatch>
						</cftry>
					</cfif>

					<!---check model directory--->
					<cfdirectory action="list"
								 directory="#variables.server_location#\#lcase(Get_Vehicle_Details.V_Make)#\#Get_Vehicle_Details.V_Model#"
								 name="check_dir">
					<cfif check_dir.recordcount eq 0>
						<!--- If no directory, Create directory. --->
						<cftry>
							<cfdirectory action="CREATE"
										 directory="#variables.server_location#\#Get_Vehicle_Details.V_Make#\#lcase(Get_Vehicle_Details.V_Model)#">
							<cfcatch></cfcatch>
						</cftry>
						<!--- If no directory, Create ph.txt (placeholder) file. --->
						<cftry>
							<cffile action="WRITE"
									file="#variables.server_location#\#Get_Vehicle_Details.V_Make#\#Get_Vehicle_Details.V_Model#\ph.txt"
									addnewline="No"
									output="#dateformat(now(),'mm/dd/yyyy')# #timeformat(now(),'hh:mm tt')#"
									nameconflict="OVERWRITE">
							<cfcatch></cfcatch>
						</cftry>
					</cfif>
					<cftry>
						<!---  <cfset variables.new_perm = #lcase(Get_Vehicle_Details.Permalink)# >
						<cfif #url.dealer_id# eq 78>
							<cfset arguments.Permalink = #REReplace(variables.new_perm,"/","_","All")# >
						</cfif>  
						 --->
					
						<cffile action="WRITE"
								file="#variables.server_location#\#Get_Vehicle_Details.V_Make#\#Get_Vehicle_Details.V_Model#\#lcase(Get_Vehicle_Details.Permalink)#"
								addnewline="No" 
								output='<cfset url.vin="#Get_Vehicle_Details.Vin#"><cfinvoke component="/cfcs/aspen10/templates/##url.template_id##/vdp_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="Get_Vehicle_Details" value="##Get_Vehicle_Details##"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>' 
								nameconflict="OVERWRITE">
						<cfcatch></cfcatch>
					</cftry>
				</cfif>
				
				<cfset variables.permalink="yes">
				<cftry>
					<cffile	action="read"
							file="#variables.server_location#\#Get_Vehicle_Details.V_Make#\#Get_Vehicle_Details.V_Model#\#lcase(Get_Vehicle_Details.Permalink)#"
							variable="moo">
					<cfcatch>
						<cfset variables.permalink="no">
					</cfcatch>
				</cftry>
				
				<cfif len(trim(Get_Vehicle_Details.Vin)) gt 0>
					<cflocation url="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vehicle_Details.Vin#">
				<cfelse>
					<cflocation url="http://#cgi.server_name#/file_not_found.cfm">
				</cfif>

			</cfcase> 

			<cfcase value="blog">
				
				<cfset variables.server_location="E:\inetpub\wwwroot\Aspen10\blog">
				
				<cfquery datasource="Aspen10" name="Get_Blog">
					SELECT		Date_Submitted,
								Perma_Link,
								Post_ID
					FROM		Dealer_Wordpress
					WHERE		Perma_Link = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#left(GetFileFromPath(cgi.CF_TEMPLATE_PATH),500)#" maxlength="500">
				</cfquery>
				
				<cfset variables.redirect="no">

				<cfif Get_Blog.Recordcount gt 0>
					<cfdirectory action="list"
								 directory="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#"
								 name="check_dir">
					<!---check year directory--->
					<cfif check_dir.recordcount eq 0>
						<!--- If no directory, Create directory. --->
						<cftry>
							<cfdirectory action="CREATE"
										 directory="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#">
							<cfcatch></cfcatch>
						</cftry>
						<!--- If no directory, Create ph.txt (placeholder) file. --->
						<cftry>
							<cffile action="WRITE"
									file="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\ph.txt"
									addnewline="No"
									output="#dateformat(now(),'mm/dd/yyyy')# #timeformat(now(),'hh:mm tt')#"
									nameconflict="OVERWRITE">
							<cfcatch></cfcatch>
						</cftry>
					</cfif>
					<cfdirectory action="list"
								 directory="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\#dateformat(Get_Blog.Date_Submitted,"mm")#"
								 name="check_dir">
					<!---check month directory--->
					<cfif check_dir.recordcount eq 0>
						<!--- If no directory, Create directory. --->
						<cftry>
							<cfdirectory action="CREATE"
										 directory="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\#dateformat(Get_Blog.Date_Submitted,"mm")#">
							<cfcatch></cfcatch>
						</cftry>
						<!--- If no directory, Create ph.txt (placeholder) file. --->
						<cftry>
							<cffile action="WRITE"
									file="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\#dateformat(Get_Blog.Date_Submitted,"mm")#\ph.txt"
									addnewline="No" 
									output="#dateformat(now(),'mm/dd/yyyy')# #timeformat(now(),'hh:mm tt')#" 
									nameconflict="OVERWRITE">
							<cffile action="WRITE" 
									file="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\#dateformat(Get_Blog.Date_Submitted,"mm")#\index.cfm"
									output='<cfset url.archive_date="#dateformat(Get_Blog.Date_Submitted,"mmmm")# #dateformat(Get_Blog.Date_Submitted,"yyyy")#"><cfinvoke component="/cfcs/aspen10/templates/##url.template_id##/page_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="component_name" value="/cfcs/aspen10/blog"/><cfinvokeargument name="method_name" value="list_date"/><cfinvokeargument name="display_type" value="full"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>'
									nameconflict="OVERWRITE"
									addnewline="No">
							<cfcatch></cfcatch>
						</cftry>
					</cfif>
					<!---write blog file--->
					<cftry>
						<cffile action="WRITE"
								file="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\#dateformat(Get_Blog.Date_Submitted,"mm")#\#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#"
								output='<cfset url.Post_ID="#Get_Blog.Post_ID#"><cfset url.archive_date="#dateformat(Get_Blog.Date_Submitted,"mmmm")# #dateformat(Get_Blog.Date_Submitted,"yyyy")#"><cfinvoke component="/cfcs/aspen10/templates/##url.template_id##/page_build" method="page_build"><cfinvokeargument name="dealer_id" value="##url.dealer_id##"/><cfinvokeargument name="dealer_name" value="##url.dealer_name##"/><cfinvokeargument name="address_1" value="##url.address_1##"/><cfinvokeargument name="address_2" value="##url.address_2##"/><cfinvokeargument name="city" value="##url.city##"/><cfinvokeargument name="state" value="##url.state##"/><cfinvokeargument name="zip" value="##url.zip##"/><cfinvokeargument name="assets" value="##url.assets##"/><cfinvokeargument name="template_id" value="##url.template_id##"/><cfinvokeargument name="dealer_template_id" value="##url.dealer_template_id##"/><cfinvokeargument name="site_mode" value="##url.site_mode##"/><cfinvokeargument name="Get_Nav" value="##Get_Nav##"/><cfinvokeargument name="Get_Phones" value="##Get_Phones##"/><cfinvokeargument name="component_name" value="/cfcs/aspen10/blog"/><cfinvokeargument name="method_name" value="single"/><cfinvokeargument name="display_type" value="full"/><cfinvokeargument name="Get_Meta_Info" value="##Get_Meta_Info##"/></cfinvoke>'
								nameconflict="OVERWRITE"
								addnewline="No">
						<cfcatch></cfcatch>
					</cftry>
					
					<cfset variables.redirect="yes">
					<cftry>
						<cffile	action="read"
								file="#variables.server_location#\#dateformat(Get_Blog.Date_Submitted,"yyyy")#\#dateformat(Get_Blog.Date_Submitted,"mm")#\#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#"
								variable="moo">
						<cfcatch>
							<cfset variables.redirect="no">
						</cfcatch>
					</cftry>
				</cfif>
				
				<cfif variables.redirect eq "yes">
					<cflocation url="http://#cgi.server_name##cgi.script_name#">
				<cfelse>
					<cflocation url="http://#cgi.server_name#/file_not_found.cfm">
				</cfif>
			
			</cfcase>
		</cfswitch> 

	</cffunction>
	
	<cffunction name="generic" description="Ultra 10 404 generic message" output="Yes" access="public">
		<div class="row">
			<div class="col-md-12">
				<h1 class="site-h1" title="Sorry. We Couldn't Find the Page You're Looking For.">Sorry. We Couldn't Find the Page You're Looking For.</h1>
			</div>
			<div class="col-md-12">
				<h3 title="Other Things to Try :">Other Things to Try :</h3>
				<ul>
					<li><a href="http://#cgi.server_name#/sitemap.cfm">Visit Our Sitemap</a></li>
				</ul>
			</div>
		</div>
	</cffunction>	
	
</cfcomponent>