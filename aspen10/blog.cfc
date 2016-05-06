<cfcomponent>

	<cffunction name="list" description="shows default blog page" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true" >
		<cfargument name="dealer_name" required="true" >

		<!---Get Blogs--->
		<cfstoredproc datasource="Aspen10" procedure="Get_Blogs">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
			<cfprocresult name="Get_Blogs" resultset="1">
			<cfprocresult name="Get_Archives" resultset="2">
			<cfprocresult name="Get_Tags" resultset="3">
			<cfprocresult name="Get_Recent" resultset="4">
		</cfstoredproc>

		<cfparam name="url.page" default="1">
		<cfset url.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 5>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Blogs.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Blogs.recordCount><cfset variables.endRow = Get_Blogs.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		
		<div class="row">
			<div class="col-md-12  visible-md visible-lg">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9">
				<cfloop query="Get_Blogs" startrow="#variables.startRow#" endrow="#variables.endRow#">
					<div class="row blog-content">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<a class="blog-title" href="http://#cgi.server_name#/blog/#dateformat(Get_Blogs.Date_Submitted,'yyyy')#/#dateformat(Get_Blogs.Date_Submitted,'mm')#/#Get_Blogs.Perma_Link#">
										#Get_Blogs.Post_Title#
									</a>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									#Get_Blogs.Post_Content#<br/>
									This entry was posted in #arguments.dealer_name# and tagged
									<cfset variables.tag_count=0>
									<cfloop list="#Get_Blogs.Post_Tags#" index="x_tag">
										<cfset variables.tag_count=variables.tag_count+1>
										<cfset variables.tag_link=replace(variables.x_tag," ","ppp","all")>
										<cfset variables.tag_link=rereplace(variables.tag_link, "[^\w]", "", "all")>
										<cfset variables.tag_link=replace(variables.tag_link,"ppp","-","all")>
										<a href="http://#cgi.server_name#/blog/tag/#lcase(variables.tag_link)#">#variables.x_tag#</a><cfif variables.tag_count lt listlen(Get_Blogs.Post_Tags)>, </cfif>
									</cfloop>						
									on #Get_Blogs.Date_Submitted# at #Get_Blogs.Time_Submitted#
								</div>
							</div>
						</div>
					</div>
					<br/>
				</cfloop>
			</div>
			<div class="col-md-3 visible-md visible-lg">
				<div class="row blog-col-rt">
					<div class="12">
						RECENT POSTS
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Recent">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#dateformat(Get_Recent.Date_Submitted,'yyyy')#/#dateformat(Get_Recent.Date_Submitted,'mm')#/#Get_Recent.Perma_Link#" title="#Get_Recent.Post_Title#">#Get_Recent.Post_Title#</a>
						</cfloop>
					</div>
				</div>
				<div class="row blog-col-rt">
					<div class="12">
						ARCHIVES
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Archives">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#Get_Archives.Arc_Year#/#Get_Archives.Arc_Month#" title="#Get_Archives.Archive_Submitted#">#Get_Archives.Archive_Submitted#</a>
						</cfloop>
					</div>
				</div>
				<!---<div class="row blog-col-rt">
					<div class="12">
						TAGS
					</div>
				</div>
				<cfset variables.tag_list="">
				<div class="row">
					<div class="12">
						<cfloop query="Get_Tags">
							<a class="tools-tag-link" href="http://#cgi.server_name#/blog/tag/#lcase(Get_Tags.WP_Link)#" title="#Get_Tags.WP_Tag#">#Get_Tags.WP_Tag#</a><cfif Get_Tags.currentrow lt Get_Tags.recordcount>, </cfif>							
						</cfloop>
					</div>
				</div>--->
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-md visible-lg">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-xs visible-sm">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination_next">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>

	
	</cffunction>

	<cffunction name="single" description="shows a single blog page" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" required="true">

		<!---Get Blogs--->
		<cfstoredproc datasource="Aspen10" procedure="Get_Blog_Post">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@post_id" value="#url.Post_ID#" maxlength="50">
			<cfprocresult name="Get_Blogs" resultset="1">
			<cfprocresult name="Get_Archives" resultset="2">
			<cfprocresult name="Get_Tags" resultset="3">
			<cfprocresult name="Get_Recent" resultset="4">
		</cfstoredproc>
		
		<div class="row">
			<div class="col-md-9">
				<cfloop query="Get_Blogs">
					<div class="row blog-content">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									#Get_Blogs.Post_Content#<br/>
									This entry was posted in #arguments.dealer_name# and tagged
									<cfset variables.tag_count=0>
									<cfloop list="#Get_Blogs.Post_Tags#" index="x_tag">
										<cfset variables.tag_count=variables.tag_count+1>
										<cfset variables.tag_link=replace(variables.x_tag," ","ppp","all")>
										<cfset variables.tag_link=rereplace(variables.tag_link, "[^\w]", "", "all")>
										<cfset variables.tag_link=replace(variables.tag_link,"ppp","-","all")>
										<a href="http://#cgi.server_name#/blog/tag/#lcase(variables.tag_link)#">#variables.x_tag#</a><cfif variables.tag_count lt listlen(Get_Blogs.Post_Tags)>, </cfif>
									</cfloop>						
									on #Get_Blogs.Date_Submitted# at #Get_Blogs.Time_Submitted#
								</div>
							</div>
						</div>
					</div>
					<br/>
				</cfloop>
			</div>
			<div class="col-md-3 visible-md visible-lg">
				<div class="row blog-col-rt">
					<div class="12">
						RECENT POSTS
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Recent">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#dateformat(Get_Recent.Date_Submitted,'yyyy')#/#dateformat(Get_Recent.Date_Submitted,'mm')#/#Get_Recent.Perma_Link#" title="#Get_Recent.Post_Title#">#Get_Recent.Post_Title#</a>
						</cfloop>
					</div>
				</div>
				<div class="row blog-col-rt">
					<div class="12">
						ARCHIVES
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Archives">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#Get_Archives.Arc_Year#/#Get_Archives.Arc_Month#" title="#Get_Archives.Archive_Submitted#">#Get_Archives.Archive_Submitted#</a>
						</cfloop>
					</div>
				</div>
				<!---<div class="row blog-col-rt">
					<div class="12">
						TAGS
					</div>
				</div>
				<cfset variables.tag_list="">
				<div class="row">
					<div class="12">
						<cfloop query="Get_Tags">
							<a class="tools-tag-link" href="http://#cgi.server_name#/blog/tag/#lcase(Get_Tags.WP_Link)#" title="#Get_Tags.WP_Tag#">#Get_Tags.WP_Tag#</a><cfif Get_Tags.currentrow lt Get_Tags.recordcount>, </cfif>							
						</cfloop>
					</div>
				</div>--->
			</div>
		</div>
	
	</cffunction>

	<cffunction name="list_date" description="shows default blog page" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" required="true">

		<!---Get Blogs--->
		<cfstoredproc datasource="Aspen10" procedure="Get_Blogs_By_Date">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@archive_date" value="#url.archive_date#" maxlength="50">
			<cfprocresult name="Get_Blogs" resultset="1">
			<cfprocresult name="Get_Archives" resultset="2">
			<cfprocresult name="Get_Tags" resultset="3">
			<cfprocresult name="Get_Recent" resultset="4">
		</cfstoredproc>

		<cfparam name="url.page" default="1">
		<cfset url.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 5>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Blogs.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Blogs.recordCount><cfset variables.endRow = Get_Blogs.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		
		<div class="row">
			<div class="col-md-12">
				<h1 class="site-h1" title="MONTHLY ARCHIVES: #url.archive_date#">MONTHLY ARCHIVES: #ucase(url.archive_date)#</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12  visible-md visible-lg">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9">
				<cfloop query="Get_Blogs" startrow="#variables.startRow#" endrow="#variables.endRow#">
					<div class="row blog-content">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<a class="blog-title" href="http://#cgi.server_name#/blog/#dateformat(Get_Blogs.Date_Submitted,'yyyy')#/#dateformat(Get_Blogs.Date_Submitted,'mm')#/#Get_Blogs.Perma_Link#">
										#Get_Blogs.Post_Title#
									</a>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									#Get_Blogs.Post_Content#<br/>
									This entry was posted in #arguments.dealer_name# and tagged
									<cfset variables.tag_count=0>
									<cfloop list="#Get_Blogs.Post_Tags#" index="x_tag">
										<cfset variables.tag_count=variables.tag_count+1>
										<cfset variables.tag_link=replace(variables.x_tag," ","ppp","all")>
										<cfset variables.tag_link=rereplace(variables.tag_link, "[^\w]", "", "all")>
										<cfset variables.tag_link=replace(variables.tag_link,"ppp","-","all")>
										<a href="http://#cgi.server_name#/blog/tag/#lcase(variables.tag_link)#">#variables.x_tag#</a><cfif variables.tag_count lt listlen(Get_Blogs.Post_Tags)>, </cfif>
									</cfloop>						
									on #Get_Blogs.Date_Submitted# at #Get_Blogs.Time_Submitted#
								</div>
							</div>
						</div>
					</div>
					<br/>
				</cfloop>
			</div>
			<div class="col-md-3 visible-md visible-lg">
				<div class="row blog-col-rt">
					<div class="12">
						RECENT POSTS
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Recent">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#dateformat(Get_Recent.Date_Submitted,'yyyy')#/#dateformat(Get_Recent.Date_Submitted,'mm')#/#Get_Recent.Perma_Link#" title="#Get_Recent.Post_Title#">#Get_Recent.Post_Title#</a>
						</cfloop>
					</div>
				</div>
				<div class="row blog-col-rt">
					<div class="12">
						ARCHIVES
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Archives">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#Get_Archives.Arc_Year#/#Get_Archives.Arc_Month#" title="#Get_Archives.Archive_Submitted#">#Get_Archives.Archive_Submitted#</a>
						</cfloop>
					</div>
				</div>
				<!---<div class="row blog-col-rt">
					<div class="12">
						TAGS
					</div>
				</div>
				<cfset variables.tag_list="">
				<div class="row">
					<div class="12">
						<cfloop query="Get_Tags">
							<a class="tools-tag-link" href="http://#cgi.server_name#/blog/tag/#lcase(Get_Tags.WP_Link)#" title="#Get_Tags.WP_Tag#">#Get_Tags.WP_Tag#</a><cfif Get_Tags.currentrow lt Get_Tags.recordcount>, </cfif>							
						</cfloop>
					</div>
				</div>--->
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-md visible-lg">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-xs visible-sm">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination_next">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
	
	</cffunction>
	
	<cffunction name="list_tag" description="shows default blog page" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" required="true">

		 <cfquery datasource="Aspen10" name="Get_Blogs">
			SELECT		Dealer_Wordpress_ID,
						Dealer_ID,
						Post_ID,
						Date_Submitted,
						Archive_Submitted,
						Time_Submitted,
						Post_Title,
						Post_Content,
						Post_Summary,
						Post_Tags, 
			            Perma_Link
			FROM		Dealer_Wordpress
			WHERE		(Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="10">)
			AND			(Post_Tags like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#url.tag#%" maxlength="200">)
			ORDER BY	Date_Submitted DESC,
						Time_Submitted DESC
		</cfquery>
			
		<cfstoredproc datasource="Aspen10" procedure="Get_Blogs">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="10">
			<cfprocresult name="Get_Blogs_All" resultset="1">
			<cfprocresult name="Get_Archives" resultset="2">
			<cfprocresult name="Get_Tags" resultset="3">
			<cfprocresult name="Get_Recent" resultset="4">
		</cfstoredproc>

		<cfparam name="url.page" default="1">
		<cfset url.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 5>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Blogs.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Blogs.recordCount><cfset variables.endRow = Get_Blogs.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		
		<div class="row">
			<div class="col-md-12">
				<h1 class="site-h1" title="TAG ARCHIVES: #url.tag#">TAG ARCHIVES: #ucase(url.tag)#</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12  visible-md visible-lg">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9">
				<cfloop query="Get_Blogs" startrow="#variables.startRow#" endrow="#variables.endRow#">
					<div class="row blog-content">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<a class="blog-title" href="http://#cgi.server_name#/blog/#dateformat(Get_Blogs.Date_Submitted,'yyyy')#/#dateformat(Get_Blogs.Date_Submitted,'mm')#/#Get_Blogs.Perma_Link#">
										#Get_Blogs.Post_Title#
									</a>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									#Get_Blogs.Post_Content#<br/>
									This entry was posted in #arguments.dealer_name# and tagged
									<cfset variables.tag_count=0>
									<cfloop list="#Get_Blogs.Post_Tags#" index="x_tag">
										<cfset variables.tag_count=variables.tag_count+1>
										<cfset variables.tag_link=replace(variables.x_tag," ","ppp","all")>
										<cfset variables.tag_link=rereplace(variables.tag_link, "[^\w]", "", "all")>
										<cfset variables.tag_link=replace(variables.tag_link,"ppp","-","all")>
										<a href="http://#cgi.server_name#/blog/tag/#lcase(variables.tag_link)#">#variables.x_tag#</a><cfif variables.tag_count lt listlen(Get_Blogs.Post_Tags)>, </cfif>
									</cfloop>						
									on #Get_Blogs.Date_Submitted# at #Get_Blogs.Time_Submitted#
								</div>
							</div>
						</div>
					</div>
					<br/>
				</cfloop>
			</div>
			<div class="col-md-3 visible-md visible-lg">
				<div class="row blog-col-rt">
					<div class="12">
						RECENT POSTS
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Recent">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#dateformat(Get_Recent.Date_Submitted,'yyyy')#/#dateformat(Get_Recent.Date_Submitted,'mm')#/#Get_Recent.Perma_Link#" title="#Get_Recent.Post_Title#">#Get_Recent.Post_Title#</a>
						</cfloop>
					</div>
				</div>
				<div class="row blog-col-rt">
					<div class="12">
						ARCHIVES
					</div>
				</div>
				<div class="row">
					<div class="12">
						<cfloop query="Get_Archives">
							<a class="recent-link" href="http://#cgi.Server_Name#/blog/#Get_Archives.Arc_Year#/#Get_Archives.Arc_Month#" title="#Get_Archives.Archive_Submitted#">#Get_Archives.Archive_Submitted#</a>
						</cfloop>
					</div>
				</div>
				<!---<div class="row blog-col-rt">
					<div class="12">
						TAGS
					</div>
				</div>
				<cfset variables.tag_list="">
				<div class="row">
					<div class="12">
						<cfloop query="Get_Tags">
							<a class="tools-tag-link" href="http://#cgi.server_name#/blog/tag/#lcase(Get_Tags.WP_Link)#" title="#Get_Tags.WP_Tag#">#Get_Tags.WP_Tag#</a><cfif Get_Tags.currentrow lt Get_Tags.recordcount>, </cfif>							
						</cfloop>
					</div>
				</div>--->
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-md visible-lg">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-xs visible-sm">
				<cfinvoke component="/cfcs/aspen10/blog" method="pagination_next">
					<cfinvokeargument name="Recordcount" value="#Get_Blogs.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>

	</cffunction>
	
	<cffunction name="pagination" description="blog pagination" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="Recordcount" required="true" />

		<!---parameters--->
		<cfparam name="url.page" default="1">
		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 5>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(arguments.recordCount / variables.pageSize)>
		<cfif variables.endRow GT arguments.recordCount><cfset variables.endRow = arguments.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>

		<div class="col-md-3 srp-page-pad">
			Page #variables.page# of #variables.totalPages#
		</div>
		<div class="col-md-9 no-pad">
			<ul class="pagination pagination-sm pull-right">
				<li><a class="srp-page-link" href="http://#cgi.server_name##cgi.script_name#?&page=1">first</a></li>
					<cfloop index="p" from="#variables.page_start#" to="#variables.page_end#">
						<cfif p gt 0>
							<li><a <cfif url.page eq p>class="srp-page-link-active"<cfelse>class="srp-page-link"</cfif> href="http://#cgi.server_name##cgi.script_name#?&page=#p#">#p#</a></li>
						</cfif>
					</cfloop>
				<li><a class="srp-page-link" href="http://#cgi.server_name##cgi.script_name#?&page=#variables.totalPages#">last</a></li>
			</ul>
		</div>
	
	</cffunction>


	<cffunction name="pagination_next" description="blog pagination" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="Recordcount" required="true" />

		<!---parameters--->
		<cfparam name="url.page" default="1">
		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 5>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(arguments.recordCount / variables.pageSize)>
		<cfif variables.endRow GT arguments.recordCount><cfset variables.endRow = arguments.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>

		<div class="col-md-12" align="center">
			Page #variables.page# of #variables.totalPages#
		</div>
		<div class="col-md-12 no-pad">
			<ul class="pager">
				<cfif url.page gt 1>
					<li><a href="http://#cgi.server_name##cgi.script_name#?&page=#url.page-1#">Previous</a></li>
				<cfelse>
					<li class="disabled"><a>Previous</a></li>
				</cfif>
				<cfif url.page lt variables.totalPages>
					<li><a href="http://#cgi.server_name##cgi.script_name#?&page=#url.page+1#">Next</a></li>
				<cfelse>
					<li class="disabled"><a>Next</a></li>
				</cfif>
			</ul>
		</div>
	
	</cffunction>
	
	
</cfcomponent>