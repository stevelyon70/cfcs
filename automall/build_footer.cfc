<cfcomponent>

	<cffunction name="standard" description="shows a standard footer" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" default="modern">

		<cfif cgi.http_user_agent contains "MSIE 8.0" or cgi.http_user_agent contains "MSIE 7.0" or cgi.http_user_agent contains "MSIE 6.0">
			<cfset arguments.site_mode="legacyx">
		</cfif>

		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				<footer class="ftr-footer">
					<div class="container ftr">
						<div class="row">
							<div class="col-md-5">
								<cfinvoke component="/cfcs/automall/icons" method="default">
									<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
									<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
									<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
									<cfinvokeargument name="nav_type_id" value="6"/>
									<cfinvokeargument name="txt_class" value="pull-left ftr-link"/>
								</cfinvoke>
							</div>
							<div class="col-md-2">
								<a class="pull-right" href="https://twitter.com/PghAutoStore" title="twitter" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_twitter.png"/></a>
								<a class="pull-right" href="https://www.facebook.com/PittsburghAutoSuperstore" title="facebook" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_facebook.png"/></a>
							</div>
							<div class="col-md-3">
								<a class="pull-right ftr-link-none" href="http://gpada.com" target="_blank"><img src="http://automall.wddemos.com/sites/#arguments.automall_name#/images/gpada_logo_sm.png"/></a>
							</div>
							<div class="col-md-2">
								<a class="pull-right ftr-link-none" href="http://triblive.com" target="_blank">powered by&nbsp;&nbsp;<img src="http://automall.wddemos.com/sites/#arguments.automall_name#/images/trib-logo.png"/></a>
							</div>
						</div>
					</div>
				</footer>
			</cfdefaultcase>
			<cfcase value="legacy">
				<table style="width:100%">
					<tr>
						<td align="center">
							<table style="width:990px">
								<tr>
									<td style="width:50%">
										<cfinvoke component="/cfcs/automall/icons" method="default">
											<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
											<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
											<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
											<cfinvokeargument name="nav_type_id" value="6"/>
											<cfinvokeargument name="txt_class" value="pull-left ftr-link"/>
										</cfinvoke>
									</td>
									<td>
										<a href="https://www.facebook.com/PittsburghAutoSuperstore" title="facebook" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_facebook.png"/></a>											
									</td>
									<td>
										<a href="https://twitter.com/PghAutoStore" title="twitter" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_twitter.png"/></a>
									</td>
									<td>
										<a class="pull-right ftr-link-none" href="http://gpada.com" target="_blank"><img src="http://automall.wddemos.com/sites/#arguments.automall_name#/images/gpada_logo_sm.png"/></a>
									</td>
									<td>
										<a class="pull-right ftr-link-none" href="http://triblive.com" target="_blank">powered by<br/><img src="http://automall.wddemos.com/sites/#arguments.automall_name#/images/trib-logo.png"/></a>
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