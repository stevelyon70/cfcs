<cfcomponent>

	<cffunction name="pitt_splash" description="buttons for pittsburgh" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" default="modern">

		<cfif cgi.http_user_agent contains "MSIE 8.0" or cgi.http_user_agent contains "MSIE 7.0" or cgi.http_user_agent contains "MSIE 6.0">
			<cfset arguments.site_mode="legacyx">
		</cfif>

		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				<section class="section-splash-btn">
					<div class="container splash-btn">
						<div class="row">
							<!--- <div class="col-md-6 no-pad" align="center">
								<a href="##" target="_blank"><img class="img-responsive btn-mbl-spl" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_mbl_auto_auction.png"/></a>
							</div>
							<div class="col-md-6 no-pad" align="center">
								<a data-toggle="modal" href="##" data-target="##calcModal"><img class="img-responsive btn-mbl-spl" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_mbl_payment_calculator.png"/></a>
							</div> --->
							<div class="col-md-12 no-pad" align="center">
								<a data-toggle="modal" href="##" data-target="##calcModal"><img class="img-responsive btn-mbl-spl" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_mbl_payment_calculator.png"/></a>
							</div>
						</div>
					</div>
				</section>
			</cfdefaultcase>
			<cfcase value="legacy">
				<table style="width:100%">
					<tr>
						<td align="center">
							<table style="width:990px">
								<tr>
									<!--- <td style="width:50px;" align="center">
										<a href="##" target="_blank"><img class="img-responsive btn-mbl-spl" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_mbl_auto_auction.png"/></a>
									</td>
									<td style="width:50px;" align="center">
										<a data-toggle="modal" href="##" data-target="##calcModal"><img class="img-responsive btn-mbl-spl" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_mbl_payment_calculator.png"/></a>
									</td> --->
									<td style="width:50px;" align="center">
										<a data-toggle="modal" href="##" data-target="##calcModal"><img class="img-responsive btn-mbl-spl" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/btn_mbl_payment_calculator.png"/></a>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</cfcase>
		</cfswitch>

	</cffunction>

</cfcomponent>