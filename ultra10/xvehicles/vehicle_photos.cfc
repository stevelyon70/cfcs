<cfcomponent>

	<cffunction name="bx_slider" description="shows default vdp photo" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Img_Urls" required="true">
		<cfargument name="img_title" default="" >
		<cfargument name="img_class" default="">

		<cfif len(trim(arguments.Img_Urls)) gt 0>
			<cfif listlen(arguments.Img_Urls) eq 1>
				<a href="javascript:bigImage('#arguments.Img_Urls#');" title="#arguments.img_title#">
					<img class="img-responsive" title="#arguments.img_title#" alt="#arguments.img_title#" src="#arguments.Img_Urls#"/>
				</a>
			<cfelse>

				<div id="wowslider-container1">
					<div class="ws_images">
						<ul>
							<cfset variables.img_row=0>
							<cfloop list="#arguments.Img_Urls#" index="vdp_img">
								<cfset variables.img_row=variables.img_row+1>
								<li>
									<a href="javascript:bigImage('#variables.vdp_img#');" title="#arguments.img_title#">
										<img class="img-responsive" src="#variables.vdp_img#" alt="vdp_#variables.img_row#" title="vdp_#variables.img_row#" id="wows1_#variables.img_row-1#"/>
									</a>
								</li>
							</cfloop>
						</ul>
					</div>
					<div class="ws_bullets">
						<div>
							<cfset variables.nav_row=0>
							<cfloop list="#arguments.Img_Urls#" index="vdp_tn">
								<cfset variables.nav_row=variables.nav_row+1>
								<a href="##" title="vdp_#variables.nav_row#">#variables.nav_row#</a>
							</cfloop>
						</div>
					</div>
					<div class="ws_shadow"></div>
				</div>
				<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/#arguments.template_id#/engine1/wowslider.js"></script>'>
				<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/#arguments.template_id#/engine1/script.js"></script>'>	
				
			</cfif>

			<!-- Large Photo Modal -->
			<div class="modal fade container" id="lgPhotoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">#arguments.img_title#</h4>
						</div>
						<div class="modal-body" align="center">
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-8">
									<cfset variables.first_image=listgetat(arguments.Img_Urls,1)>
									<img id="lgPhoto" class="max-width" src="#variables.first_image#"/>
								</div>
								<div class="col-md-2"></div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div><!-- /.modal -->

		<cfelse>
			
			<img class="img-responsive" title="#arguments.img_title#" alt="#arguments.img_title#" src="http://#cgi.server_name#/images/photo_coming_soon.jpg"/>

		</cfif>

	</cffunction>
	
	<cffunction name="single_photo" description="shows a single photo" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Img_Urls" required="true">
		<cfargument name="img_title" default="" >
		<cfargument name="img_class" default="img-responsive">
		<cfargument name="Voi_Vin" default="">

		<cfif len(trim(arguments.Img_Urls)) gt 0>
			<cfset variables.first_image=listgetat(arguments.Img_Urls,1)>
		<cfelse>
			<cfset variables.first_image="http://#cgi.server_name#/images/photo_coming_soon.jpg">
		</cfif>
	
		<cfif len(trim(arguments.Voi_Vin))>
			<a href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#arguments.VOI_Vin#">
				<img class="#arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
			</a>
		<cfelse>
			<img class="#arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
		</cfif>
			
	</cffunction>

</cfcomponent>