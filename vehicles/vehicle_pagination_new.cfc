<cfcomponent>

	<cffunction name="srp_pages" description="srp pagination for Alt1 SRP Layout" output="Yes" access="public">

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
		<cfif len(trim(interiorcolor)) gt 0>
			<cfset variables.url_params=variables.url_params & "&interiorcolor=#interiorcolor#">
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
			<cfset variables.url_params=variables.url_params & "&model=#urlencodedformat(url.model)#">
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
		<!---  <cfset variables.pageSize = 10>  --->
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

 		   
		
		 <div class="col-md-3 no-pad" align="left" style="margin-top:10px!important"  > 
		
		<cfif NOT IsDefined("url.new_used") >
			<cfset fldr = "new" >
		<cfelseif #url.new_used# EQ "N" >	
			<cfset fldr = "new" >
		<cfelseif #url.new_used# EQ "U" >	
			<cfset fldr = "used" >
		<cfelseif #url.new_used# EQ "C" >	
			<cfset fldr = "certified" >
		</cfif>
					
		<form id="srp_new_form" name="srp_new_form" action="http://#cgi.server_name#/vehicles/new_shrt_srch.cfm" method="post">
				<!--- <div class="col-md-12 visible-md visible-lg no-pad" align="left" > --->
					
					<select name="sortblock" class="srp-input-new" onchange="this.form.submit()">
						<option value="" >Sort By</option>
						<option value="1" <cfif url.sortblock eq "1">selected</cfif>>Sort By Make,Model</option>
						<option value="2" <cfif url.sortblock eq "2">selected</cfif>>Sort By Price (low to high)</option>
						<option value="3" <cfif url.sortblock eq "3">selected</cfif>>Sort By Price (high to low)</option>
						<cfif url.new_used neq "N" and url.new_used neq "A"><option value="4" <cfif url.sortblock eq "4">selected</cfif>>Sort By Mileage (low to high)</option></cfif>
						<cfif url.new_used neq "N" and url.new_used neq "A"><option value="5" <cfif url.sortblock eq "5">selected</cfif>>Sort By Mileage (high to low)</option></cfif>
						<option value="6" <cfif url.sortblock eq "6">selected</cfif>>Sort By Year (low to high)</option>
						<option value="7" <cfif url.sortblock eq "7">selected</cfif>>Sort By Year (high to low)</option>
						<cfif len(trim(url.dealer_id)) gt 0><option value="8" <cfif url.sortblock eq "8">selected</cfif>>Sort By Stock Number</option></cfif>
						<cfif #url.dealer_id# eq 14>
						 <option value="9" <cfif url.sortblock eq "9">selected</cfif>>Show Luxury</option>
						 </cfif>
					</select>
				<!--- </div> --->
			<input type="hidden" name="script_content" value="#variables.url_params#"/>
			<input type="hidden" name="make" value="#url.make#"/>
			<input type="hidden" name="new_used" value="#url.new_used#"/>
			<input type="hidden" name="model" value="#url.model#"/>
			<input type="hidden" name="year" value="#url.year#"/>
			<input type="hidden" name="body" value="#url.body#"/>
			<input type="hidden" name="color" value="#url.color#"/>
			<input type="hidden" name="interiorcolor" value="#url.interiorcolor#"/>
			<input type="hidden" name="zip" value="#url.zip#"/>
			<input type="hidden" name="radius" value="#url.radius#"/>
			<input type="hidden" name="maxprice" value="#url.maxprice#"/>
			<input type="hidden" name="minprice" value="#url.minprice#"/>
			<input type="hidden" name="old_year" value="#url.year#"/>
			<input type="hidden" name="old_make" value="#url.make#"/>
			<input type="hidden" name="classic" value="#url.classic#"/>
			<input type="hidden" name="geo" value="#url.geo#"/>

		</form>
			
			<!--- 
			<cfinvoke component="/cfcs/vehicles/srp_engine" method="srp_new">
				<cfinvokeargument name="srp_action" value="http://#cgi.server_name##cgi.script_name#"/>
				<cfinvokeargument name="pass_params" value="#variables.url_params#"/>
			</cfinvoke> --->
		</div>    
		
			 <!---  <div class="col-md-3 srp-page-pad" align="left" >
				Page #variables.page# of #variables.totalPages#	
			</div>     --->
		
		<div class="col-md-9 no-pad pull-left">
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
