<cfcomponent>

	<cffunction name="pitt" description="trade in tool for pitt" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="Get_Page_Content" required="true"/>
		<cfargument name="form_id" default="zipForm">
		<cfargument name="form_class" default="spl-form">
		<cfargument name="form_method" default="post">
		<cfset Get_Page_Content=arguments.Get_Page_Content>


		<!---default parameters--->
		<cfparam name="zip" default="">
		<cfparam name="radius" default="25">
		<cfparam name="dealer_id" default="">
		<cfparam name="new_used" default="B">
		<cfparam name="page" default="">
		<cfparam name="year" default="">
		<cfparam name="make" default="">
		<cfparam name="model" default="">
		<cfparam name="body" default="">
		<cfparam name="drivetrain" default="">
		<cfparam name="transmission" default="">
		<cfparam name="style" default="">
		<cfparam name="color" default="">
		<cfparam name="maxprice" default="11000000">
		<cfparam name="minprice" default="-1">
		<cfparam name="sortblock" default="1">

		<!---former settings--->
		<cfparam name="old_dealer_id" default="">
		<cfparam name="old_year" default="">
		<cfparam name="old_make" default="">

		<cfset variables.inv_url="http://#lcase(cgi.server_name)#/vehicles/srp_action.cfm?">

		<!---add maxprice--->
		<cfif maxprice neq 11000000>
			<cfset variables.inv_url=variables.inv_url & "&maxprice=#maxprice#">
		</cfif>
		
		<!---add minprice--->
		<cfif minprice neq -1>
			<cfset variables.inv_url=variables.inv_url & "&minprice=#minprice#">
		</cfif>
		
		<!---add body--->
		<cfif len(trim(body)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&body=#body#">
		</cfif>
		
		<!---add drivetrain--->
		<cfif len(trim(drivetrain)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&drivetrain=#drivetrain#">
		</cfif>
		
		<!---add transmission--->
		<cfif len(trim(transmission)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&transmission=#transmission#">
		</cfif>
		
		<!---add color--->
		<cfif len(trim(color)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&color=#color#">
		</cfif>
		
		<!---add dealer id--->
		<cfif len(trim(dealer_id)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&dealer_id=#dealer_id#">
		</cfif>
		
		<!---check old make--->
		<cfif len(trim(old_dealer_id)) gt 0>
			<cfif old_dealer_id neq dealer_id>
				<cfset dealer_id="">
			</cfif>
		</cfif>
		
		<!---add year--->
		<cfif len(trim(year)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&year=#year#">
		</cfif>
		
		<!---add make--->
		<cfif len(trim(make)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&make=#make#">
		</cfif>
		
		<!---check old make--->
		<cfif len(trim(old_make)) gt 0>
			<cfif old_make neq make>
				<cfset model="">
			</cfif>
		</cfif>
		
		<!---add model--->
		<cfif len(trim(model)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&model=#model#">
		</cfif>
		
		<!---add zip--->
		<cfif len(trim(zip)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&zip=#zip#">
		</cfif>
		
		<!---add radius--->
		<cfif len(trim(radius)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&radius=#radius#">
		</cfif>
		
		<!---sort inventory--->
		<cfif len(trim(sortblock)) eq 0>
			<cfset sortblock=1>
		</cfif>
		<cfset variables.inv_url=variables.inv_url & "&sortblock=#sortblock#">
		
		<!---add page--->
		<cfif len(trim(page)) gt 0>
			<cfset variables.inv_url=variables.inv_url & "&page=#page#">
		</cfif>

		<div class="row">
			<div class="col-md-12">
				<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_banner#
				</div>
			</div>
		</cfif>
		<div class="row">
			<div class="col-md-4">
				<form id="#arguments.form_id#" class="#arguments.form_class#" method="post" action="#variables.inv_url#">
					<select class="spl-search-input" name="new_used" id="search_new_used_#arguments.form_id#">
						<option value="N" <cfif new_used eq "N">selected="selected"</cfif>>New</option>
						<option value="U" <cfif new_used eq "U">selected="selected"</cfif>>Used</option>
						<option value="C" <cfif new_used eq "C">selected="selected"</cfif>>Certified</option>
					</select>
					<input class="spl-search-input" type="text" name="zip" id="search_zip_#arguments.form_id#" value="" maxlength="5" placeholder="Your Zip Code">
					<select class="spl-search-input" name="radius" id="search_radius_#arguments.form_id#">
						<option value="5" <cfif radius eq "5">selected="selected"</cfif>>5 Miles</option>
						<option value="10" <cfif radius eq "10">selected="selected"</cfif>>10 Miles</option>
						<option value="25" <cfif radius eq "25">selected="selected"</cfif>>25 Miles</option>
						<option value="50" <cfif radius eq "50">selected="selected"</cfif>>50 Miles</option>
					</select>
					<input type="submit" class="btn btn-spl-search" id="spl-search-submit" value="Search Now!">				
				</form>
			</div>
			<div class="col-md-8"></div>
		</div>
		<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_footer#
				</div>
			</div>
		</cfif>
	</cffunction>

</cfcomponent>