<cfcomponent>

	<cffunction name="srp_pages" description="srp pagination" output="Yes" access="public">

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

		<div class="col-md-3 srp-page-pad">
			Page #variables.page# of #variables.totalPages#
		</div>
		<div class="col-md-9 no-pad">
			<ul class="pagination pagination-sm pull-right">
				<li><a href="#arguments.srp_action#?#variables.url_params#&page=1">first</a></li>
					<cfloop index="p" from="#variables.page_start#" to="#variables.page_end#">
						<cfif p gt 0>
							<li <cfif url.page eq p>class="active"</cfif>><a href="#arguments.srp_action#?#variables.url_params#&page=#p#">#p#</a></li>
						</cfif>
					</cfloop>
				<li><a href="#arguments.srp_action#?#variables.url_params#&page=#variables.totalPages#">last</a></li>
			</ul>
		</div>

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
		<!--- zip--->
		<cfif len(trim(url.zip)) gt 0>
			<cfset variables.url_params=variables.url_params & "&zip=#url.zip#">
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

		<div class="col-md-9 no-pad">
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