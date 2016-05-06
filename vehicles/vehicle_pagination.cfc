<cfcomponent>

	<cffunction name="srp_pages" description="srp pagination" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>

		<!---parameters--->
		<cfparam name="url.page" default="1">

		<cfset Get_Vehicles.Recordcount=arguments.Recordcount>

		<cfset variables.url_params="">
		
		<!--- Collection Search --->
		<cfif IsDefined("url.lookup_vins") >
			<cfset variables.url_params=variables.url_params & "&lookup_vins=#url.lookup_vins#">
		</cfif>
		
		<!--- inventory type --->
		<cfif len(trim(url.new_used)) gt 0>
			<cfset variables.url_params=variables.url_params & "&new_used=#url.new_used#">
		</cfif>
		<!---add dealer--->
		<cfif len(trim(url.dealer_id)) gt 0>
			<cfset variables.url_params=variables.url_params & "&dealer_id=#url.dealer_id#">
		</cfif>
		<!---add body--->
		<cfif len(trim(body)) gt 0>
			<cfset variables.url_params=variables.url_params & "&body=#body#">
		</cfif>
		<!---add drivetrain--->
		<cfif len(trim(drivetrain)) gt 0>
			<cfset variables.url_params=variables.url_params & "&drivetrain=#drivetrain#">
		</cfif>
		<!---add style--->
		<cfif len(trim(style)) gt 0>
	        <cfset variables.url_params=variables.url_params & "&style=#style#">
        </cfif>
		<!---add transmission--->
		<cfif len(trim(transmission)) gt 0>
			<cfset variables.url_params=variables.url_params & "&transmission=#transmission#">
		</cfif>
		<!---add color--->
		<cfif len(trim(color)) gt 0>
			<cfset variables.url_params=variables.url_params & "&color=#color#">
		</cfif>
		<!---add year--->
		<cfif len(trim(url.year)) gt 0>
			<cfset variables.url_params=variables.url_params & "&year=#url.year#">
		</cfif>
		<!---add make--->
		<cfif len(trim(url.make)) gt 0>
			<cfset variables.url_params=variables.url_params & "&make=#url.make#">
		</cfif>
		<!---add model--->
		<cfif len(trim(url.model)) gt 0>
			<cfset variables.url_params=variables.url_params & "&model=#url.model#">
		</cfif>
		<!---add zip--->
		<cfif len(trim(url.zip)) gt 0>
			<cfset variables.url_params=variables.url_params & "&zip=#url.zip#">
		</cfif>
		<!---add radius--->
		<cfif len(trim(url.radius)) gt 0>
			<cfset variables.url_params=variables.url_params & "&radius=#url.radius#">
		</cfif>
		<!---add minprice--->
		<cfif minprice neq -1>
			<cfset variables.url_params=variables.url_params & "&minprice=#minprice#">
		</cfif>
		<!---add maxprice--->
		<cfif maxprice neq 11000000 and maxprice neq "" >
			<cfset variables.url_params=variables.url_params & "&maxprice=#maxprice#">
		</cfif>
		<!---sort classic --->
		<cfif len(trim(url.classic)) gt 0 or isdefined("url.now") >
			<cfset variables.url_params=variables.url_params & "&classic=#url.classic#">
		</cfif>
		<!---add geo --->
		
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "") >
			<cfset variables.url_params=variables.url_params & "&geo=#url.geo#">
		</cfif>	
 
		
		<!--- <cfif len(trim(url.geo)) gt 0>
			<cfset variables.url_params=variables.url_params & "&geo=#url.geo#">
		<cfelse>	
			<cfset variables.url_params=variables.url_params & "&geo=0">
		</cfif> --->
		<!---sort inventory--->
		<cfif len(trim(url.sortblock)) eq 0>
			<cfset url.sortblock=1>
		</cfif>
		<!---sort inventory--->
		<cfif url.result_set neq 10>
			<cfset variables.url_params=variables.url_params & "&result_set=#url.result_set#">
		</cfif>
		<cfset variables.url_params=variables.url_params & "&sortblock=#url.sortblock#">

		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<!--- Setup paging --->
		<cfset variables.pageSize = url.result_set><!--- cars per page --->
		<!---<cfset variables.pageSize = 10>--->
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Vehicles.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Vehicles.recordCount><cfset variables.endRow = Get_Vehicles.recordCount></cfif>
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
				
					<cfif #variables.totalPages# GT 1 AND #url.page# GT 1 >
						<li><a class="srp-page-link" href="#arguments.srp_action#?#variables.url_params#&page=1">First</a></li>
						<cfset gobk = #url.page# - 1 >
						<li><a class="srp-page-link" href="#arguments.srp_action#?#variables.url_params#&page=#gobk#">Prev</a></li>
					</cfif>
					<cfloop index="p" from="#variables.page_start#" to="#variables.page_end#">
						<cfif p gt 0>
							<li><a <cfif url.page eq p>class="srp-page-link-active"<cfelse>class="srp-page-link"</cfif> href="#arguments.srp_action#?#variables.url_params#&page=#p#">#p#</a></li>
						</cfif>
					</cfloop>
					<cfif #variables.totalPages# GT 1 AND #url.page# LT #variables.totalPages# >
						<cfset gobk = #url.page# + 1 >
						<li><a class="srp-page-link" href="#arguments.srp_action#?#variables.url_params#&page=#gobk#">Next</a></li>
					</cfif>
					
				<li><a class="srp-page-link" href="#arguments.srp_action#?#variables.url_params#&page=#variables.totalPages#">Last</a></li>
			</ul>
		</div>

	</cffunction>
	
	<cffunction name="srp_pages_legacy" description="srp pagination" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>

		<!---parameters--->
		<cfparam name="url.page" default="1">

		<cfset Get_Vehicles.Recordcount=arguments.Recordcount>

		<cfset variables.url_params="">
		<!--- inventory type --->
		<cfif len(trim(url.new_used)) gt 0>
			<cfset variables.url_params=variables.url_params & "&new_used=#url.new_used#">
		</cfif>
		<!---add dealer--->
		<cfif len(trim(url.dealer_id)) gt 0>
			<cfset variables.url_params=variables.url_params & "&dealer_id=#url.dealer_id#">
		</cfif>
		<!---add body--->
		<cfif len(trim(body)) gt 0>
			<cfset variables.url_params=variables.url_params & "&body=#body#">
		</cfif>
		<!---add drivetrain--->
		<cfif len(trim(drivetrain)) gt 0>
			<cfset variables.url_params=variables.url_params & "&drivetrain=#drivetrain#">
		</cfif>
		<!---add transmission--->
		<cfif len(trim(transmission)) gt 0>
			<cfset variables.url_params=variables.url_params & "&transmission=#transmission#">
		</cfif>
		<!---add color--->
		<cfif len(trim(color)) gt 0>
			<cfset variables.url_params=variables.url_params & "&color=#color#">
		</cfif>
		<!---add year--->
		<cfif len(trim(url.year)) gt 0>
			<cfset variables.url_params=variables.url_params & "&year=#url.year#">
		</cfif>
		<!---add make--->
		<cfif len(trim(url.make)) gt 0>
			<cfset variables.url_params=variables.url_params & "&make=#url.make#">
		</cfif>
		<!---add model--->
		<cfif len(trim(url.model)) gt 0>
			<cfset variables.url_params=variables.url_params & "&model=#url.model#">
		</cfif>
		<!---add zip--->
		<cfif len(trim(url.zip)) gt 0>
			<cfset variables.url_params=variables.url_params & "&zip=#url.zip#">
		</cfif>
		<!---add radius--->
		<cfif len(trim(url.radius)) gt 0>
			<cfset variables.url_params=variables.url_params & "&radius=#url.radius#">
		</cfif>
		<!---add maxprice--->
		<cfif maxprice neq 11000000>
			<cfset variables.url_params=variables.url_params & "&maxprice=#maxprice#">
		</cfif>
		<!---add minprice--->
		<cfif minprice neq -1>
			<cfset variables.url_params=variables.url_params & "&minprice=#minprice#">
		</cfif>
		<!---sort classic --->
		<cfif len(trim(url.classic)) gt 0>
			<cfset variables.url_params=variables.url_params & "&classic=#url.classic#">
		</cfif>
		<!---add geo --->
		
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "") >
			<cfset variables.url_params=variables.url_params & "&geo=#url.geo#">
		<cfelse>	
			<cfset variables.url_params=variables.url_params & "&geo=0">
		</cfif>	
		
		<!--- <cfif len(trim(url.geo)) gt 0>
			<cfset variables.url_params=variables.url_params & "&geo=#url.geo#">
		</cfif> --->
		<!---sort inventory--->
		<cfif len(trim(url.sortblock)) eq 0>
			<cfset url.sortblock=1>
		</cfif>
		<cfset variables.url_params=variables.url_params & "&sortblock=#url.sortblock#">

		<!---sort inventory--->
		<cfif url.result_set neq 10>
			<cfset variables.url_params=variables.url_params & "&result_set=#url.result_set#">
		</cfif>
		<cfset variables.url_params=variables.url_params & "&sortblock=#url.sortblock#">

		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<!--- Setup paging --->
		<cfset variables.pageSize = url.result_set><!--- cars per page --->
		<!---<cfset variables.pageSize = 10>--->
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Vehicles.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Vehicles.recordCount><cfset variables.endRow = Get_Vehicles.recordCount></cfif>
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

		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100px">
					Page #variables.page# of #variables.totalPages#
				</td>
				<td align="right">
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td style="padding:0px 10px 0px 10px;"><a class="srp-page-link" href="#arguments.srp_action#?#variables.url_params#&page=1">first</a></td>
							<cfloop index="p" from="#variables.page_start#" to="#variables.page_end#">
								<td style="padding:0px 5px 0px 5px;"><a <cfif url.page eq p>class="srp-page-link-active"<cfelse>class="srp-page-link"</cfif> href="#arguments.srp_action#?#variables.url_params#&page=#p#">#p#</a></td>
							</cfloop>
							<td style="padding:0px 10px 0px 10px;"><a class="srp-page-link" href="#arguments.srp_action#?#variables.url_params#&page=#variables.totalPages#">last</a></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	
	</cffunction>

	<cffunction name="srp_next" description="srp next & prev" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Recordcount" required="true" />
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>

		<!---parameters--->
		<cfparam name="url.page" default="1">

		<cfset Get_Vehicles.Recordcount=arguments.Recordcount>

		<cfset variables.url_params="">
		<!--- inventory type --->
		<cfif len(trim(url.new_used)) gt 0>
			<cfset variables.url_params=variables.url_params & "&new_used=#url.new_used#">
		</cfif>
		<!---add dealer--->
		<cfif len(trim(url.dealer_id)) gt 0>
			<cfset variables.url_params=variables.url_params & "&dealer_id=#url.dealer_id#">
		</cfif>
		<!---add year--->
		<cfif len(trim(url.year)) gt 0>
			<cfset variables.url_params=variables.url_params & "&year=#url.year#">
		</cfif>
		<!---add make--->
		<cfif len(trim(url.make)) gt 0>
			<cfset variables.url_params=variables.url_params & "&make=#url.make#">
		</cfif>
		<!---add model--->
		<cfif len(trim(url.model)) gt 0>
			<cfset variables.url_params=variables.url_params & "&model=#url.model#">
		</cfif>
		<!---add maxprice--->
		<cfif maxprice neq 11000000>
			<cfset variables.url_params=variables.url_params & "&maxprice=#maxprice#">
		</cfif>
		<!---add minprice--->
		<cfif minprice neq -1>
			<cfset variables.url_params=variables.url_params & "&minprice=#minprice#">
		</cfif>
		<!---add geo --->
		
		<cfif IsDefined("url.geo") AND (url.geo neq "0" AND url.geo neq "") >
			<cfset variables.url_params=variables.url_params & "&geo=#url.geo#">
		<cfelse>	
			<cfset variables.url_params=variables.url_params & "&geo=0">
		</cfif>	
		<!--- <cfif len(trim(url.geo)) gt 0>
			<cfset variables.url_params=variables.url_params & "&geo=#url.geo#">
		</cfif> --->
		<!---sort inventory--->
		<cfif len(trim(url.sortblock)) eq 0>
			<cfset url.sortblock=1>
		</cfif>
		<cfset variables.url_params=variables.url_params & "&sortblock=#url.sortblock#">

		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 10>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Vehicles.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Vehicles.recordCount><cfset variables.endRow = Get_Vehicles.recordCount></cfif>
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
					<li><a href="#arguments.srp_action#?#variables.url_params#&page=#url.page-1#">Previous</a></li>
				<cfelse>
					<li class="disabled"><a>Previous</a></li>
				</cfif>
				<cfif url.page lt variables.totalPages>
					<li><a href="#arguments.srp_action#?#variables.url_params#&page=#url.page+1#">Next</a></li>
				<cfelse>
					<li class="disabled"><a>Next</a></li>
				</cfif>
			</ul>
		</div>

	</cffunction>
	
</cfcomponent>