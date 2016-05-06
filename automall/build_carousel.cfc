<cfcomponent>

	<cffunction name="featured" description="shows a standard header" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">

		<!---Get Nav--->
		<cfstoredproc datasource="Automall" procedure="Get_Vehicles_Random">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@new_used" value="u" maxlength="1">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="0" maxlength="10">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@maxprice" value="15000" maxlength="10">
			<cfprocresult name="Get_Vehicles_Random" resultset="1">
		</cfstoredproc>

		<div class="row">
			<div class="col-md-12 fv-head">
				Featured Vehicles
			</div>
		</div>

		<div class="row visible-md visible-lg">
			<cfif Get_Vehicles_Random.recordcount lt 5>
				<cfloop query="Get_Vehicles_Random" endrow="4">
					<div class="col-md-3">
						<a href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_Random.Vin#" class="fv-link-no-car img-responsive">
							<span class="fv-title">#Get_Vehicles_Random.V_Year# #Get_Vehicles_Random.V_Make# #Get_Vehicles_Random.V_Model# #Get_Vehicles_Random.V_Trim#</span>
							<img class="img-responsive" src="#listgetat(Img_Urls,1)#" title="#Get_Vehicles_Random.V_Year# #Get_Vehicles_Random.V_Make# #Get_Vehicles_Random.V_Model# #Get_Vehicles_Random.V_Trim#"/>
							<span class="fv-more">More Information <span class="glyphicon glyphicon-chevron-right pull-right"></span></span>
							<span class="fv-price">$#numberformat(Get_Vehicles_Random.Selling_Price)#</span>
						</a>
					</div>
				</cfloop>
			<cfelse>
				<div class="col-md-12">
					<ul class="desk_fv_carousel">
						<cfloop query="Get_Vehicles_Random" endrow="12">
							<li class="slide">
								<a href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_Random.Vin#" class="fv-link-no-car img-responsive">
									<span class="fv-title">#Get_Vehicles_Random.V_Year# #Get_Vehicles_Random.V_Make# #Get_Vehicles_Random.V_Model# #Get_Vehicles_Random.V_Trim#</span>
									<img class="img-responsive" src="#listgetat(Img_Urls,1)#" title="#Get_Vehicles_Random.V_Year# #Get_Vehicles_Random.V_Make# #Get_Vehicles_Random.V_Model# #Get_Vehicles_Random.V_Trim#"/>
									<span class="fv-more">More Information <span class="glyphicon glyphicon-chevron-right pull-right"></span></span>
									<span class="fv-price">$#numberformat(Get_Vehicles_Random.Selling_Price)#</span>
								</a>
							</li>
						</cfloop>
					</ul>
				</div>
				<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
				<cfset url.Dom_Functions= url.Dom_Functions & "$('.desk_fv_carousel').bxSlider({slideWidth: 275,minSlides: 4,maxSlides: 12,slideMargin: 10,pager: false,auto: true,autoHover: true});">
			</cfif>
		</div>

		<div class="row visible-xs visible-sm">
			<div class="col-md-12">
				<cfloop query="Get_Vehicles_Random" endrow="6">
					<div class="row">
						<div class="col-md-12">
							<a href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Vehicles_Random.Vin#" class="fv-link-no-car img-responsive">
								<span class="fv-title">#Get_Vehicles_Random.V_Year# #Get_Vehicles_Random.V_Make# #Get_Vehicles_Random.V_Model# #Get_Vehicles_Random.V_Trim#</span>
								<img class="img-responsive" src="#listgetat(Img_Urls,1)#" title="#Get_Vehicles_Random.V_Year# #Get_Vehicles_Random.V_Make# #Get_Vehicles_Random.V_Model# #Get_Vehicles_Random.V_Trim#"/><br/>
								<span class="fv-more">More Information <span class="glyphicon glyphicon-chevron-right pull-right"></span></span>
								<span class="fv-price">$#numberformat(Get_Vehicles_Random.Selling_Price)#</span>
							</a>
						</div>
					</div>
				</cfloop>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12 fv-bottom">
			</div>
		</div>
	</cffunction>

</cfcomponent>