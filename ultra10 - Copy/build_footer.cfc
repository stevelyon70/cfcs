<cfcomponent>

	<cffunction name="standard" description="shows a standard footer" output="Yes" access="public">
		footer
	</cffunction>

	<cffunction name="nissan" description="shows a nissan compliant footer" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" required="true">
		<cfargument name="address_1" required="true">
		<cfargument name="address_2" required="true">
		<cfargument name="city" required="true">
		<cfargument name="state" required="true">
		<cfargument name="zip" required="true">

		<cfparam name="url.first_name" default="">
		<cfparam name="url.last_name" default="">
		<cfparam name="url.email" default="">
		<cfparam name="url.phone" default="">
		<cfparam name="url.comments" default="">
	
		<div class="row nissan-ftr">
			<div class="col-md-6">
				#arguments.address_1#
				#arguments.address_2#
				#arguments.city#
				#arguments.state#
				#arguments.zip#
			</div>
			<div class="col-md-6">
				<div class="row pull-right">
					|<a data-toggle="modal" data-target="##copyModal">Copyright</a>
					|<a data-toggle="modal" data-target="##contactModal" href="">Contact Us</a>
					|<a href="">Privacy Statement</a>
					<a class="nissan-ftr-logo" href="http://www.nissanusa.com/" target="_blank"><img src="http://#cgi.server_name#/images/oem/nissan/nissan_footer.png"/></a>
				</div>
			</div>
		</div>
		<!--- Copyright Modal Window --->
		<div class="modal fade" id="copyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<b>&copy; Copyright</b>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-12">
									The Nissan names, logos, product names, feature names, and slogans are trademarks owned by or licensed to Nissan Motor Co. Ltd. and/or Nissan North America, Inc. 2002-#dateformat(now(),"yyyy")# Nissan North America, Inc. All rights reserved. Materials contained on this Web site may not be used or reproduced without written permission from Nissan North America, Inc.
								</div>									
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--- Contact Modal Window --->
		<div class="modal fade" id="contactModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Contact #arguments.dealer_name#</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-12">
									<div class="pop-form-box">
										<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="post">
											<div class="row">
												<div class="col-md-12 ftr-form-pad link-info-title" align="center">
													CONTACT US
												</div>
											</div>
											<div class="row">
												<div class="col-md-6 ftr-form-pad">
													<input name="first_name" class="form-control input-md" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
												</div>
												<div class="col-md-6 ftr-form-pad">
													<input name="last_name" class="form-control input-md" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6 ftr-form-pad">
													<input name="email" class="form-control input-md" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
												</div>
												<div class="col-md-6 ftr-form-pad">
													<input name="phone" class="form-control input-md" id="phone" type="text" placeholder="Phone" maxlength="10" value="#url.phone#"/>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12 ftr-form-pad">
													<textarea name="comments" class="form-control" id="comments" maxlength="1000" placeholder="Comments" required>#url.comments#</textarea>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12 ftr-form-pad" align="center">
													<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
													<input type="submit" class="btn btn-primary" id="submit" value="Contact Us"/>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</cffunction>

</cfcomponent>