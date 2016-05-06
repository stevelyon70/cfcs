<cfcomponent>

	<cffunction name="standard" description="shows a standard header" output="Yes" access="public">

		<cfargument name="automall_id" required="true">
		<cfargument name="automall_name" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="site_mode" default="modern">

		<cfif cgi.http_user_agent contains "MSIE 8.0" or cgi.http_user_agent contains "MSIE 7.0" or cgi.http_user_agent contains "MSIE 6.0">
			<cfset arguments.site_mode="legacyx">
		</cfif>

		<cfswitch expression="#arguments.site_mode#">
			<cfdefaultcase>
				<header class="section-hdr">
					<div class="container hdr">
						<div class="row">
							<div class="col-md-4" align="center">
								<!--- <a href="http://advertisers.triblive.com/emag/autoShow2014_2.27.14/##/1/" target="_blank"><img style="margin:20px" src="http://#cgi.server_name#/images/img_AutoShowBurst.png"/></a> --->
							</div>
							<div class="col-md-4" align="center">
								<a href="http://#lcase(cgi.server_name)#"><img class="img-responsive" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/logo.png"/></a>
							</div>
							<div class="col-md-4">				
								<a sty class="pull-right" href="https://twitter.com/PghAutoStore" title="twitter" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_twitter.png"/></a>
								<a class="pull-right" href="https://www.facebook.com/PittsburghAutoSuperstore" title="facebook" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_facebook.png"/></a>
							</div>
						</div>
					</div>
				</header>
			</cfdefaultcase>
			<cfcase value="legacy">
				<table style="width:100%">
					<tr>
						<td align="center">
							<table style="width:990px">
								<tr>
									<td style="width:730px;">
										This site is optimized for modern browsers. Please consider upgrading your brower using any of the following links:
									</td>
									<td style="width:260px">
										<table style="width:100%">
											<tr>
												<td align="center"><a href="https://www.google.com/intl/en/chrome/browser/" target="_blank" title="Download Chrome"><img alt="Download Chrome" src="http://#cgi.server_name#/images/browsers/logo_chrome.png" border="0"/></a></td>
												<td align="center"><a href="http://www.mozilla.org/en-US/firefox/new/" target="_blank" title="Download Firefox"><img alt="Download Firefox" src="http://#cgi.server_name#/images/browsers/logo_firefox.png" border="0"/></a></td>
												<td align="center"><a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie" target="_blank" title="Download IE"><img alt="Download IE" src="http://#cgi.server_name#/images/browsers/logo_ie.png" border="0"/></a></td>
												<td align="center"><a href="https://www.apple.com/safari/" target="_blank" title=""><img alt="Download Safari" src="http://#cgi.server_name#/images/browsers/logo_safari.png" border="0"/></a></td>
												<td align="center"><a href="http://www.opera.com/" target="_blank" title="Download Opera"><img alt="Download Opera" src="http://#cgi.server_name#/images/browsers/logo_opera.png" border="0"/></a></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<table style="width:990px">
								<tr class="hdr">
									<td style="width:455px" align="center">
										<a href="http://advertisers.triblive.com/emag/autoShow2014_2.27.14/##/1/" target="_blank"><img style="margin:20px" src="http://#cgi.server_name#/images/img_AutoShowBurst.png"/></a>
									</td>
									<td style="width:455px" align="center">
										<a href="http://#lcase(cgi.server_name)#"><img class="img-responsive" src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/logo.png"/></a>
									</td>
									<td style="width:40px" valign="top">
										<a href="https://www.facebook.com/PittsburghAutoSuperstore" title="facebook" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_facebook.png"/></a>
									</td>
									<td style="width:40px" valign="top">
										<a href="https://twitter.com/PghAutoStore" title="twitter" target="_blank"><img src="http://#cgi.server_name#/sites/#arguments.automall_name#/images/icon_twitter.png"/></a>
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