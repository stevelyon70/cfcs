<cfcomponent>

	<cffunction name="legacy" description="warns user that their browser is outdated" output="Yes" access="public">
		<div class="browser-warning">
			<table  align="center"  border="0" class="browser-download">
				<tr>
					<td align="center" valign="MIDDLE"  width="40%" rowspan="2"><span style="color:red;font-size:16pt">PLEASE NOTE</span><br>This site is optimized for modern web browsers.&nbsp;&nbsp;All site functionality may not be available to you.<br>Please consider upgrading your browser by using any of these links:
				</td>
				</tr>	
				<tr>
					<td align="center" width="10%"><a href="https://www.google.com/intl/en/chrome/browser/" target="_blank"><img alt="Download Chrome" src="http://#cgi.server_name#/images/browsers/logo_chrome_sm.png" border="0"/><br/>Chrome</a></td>
					<td align="center" width="10%"><a href="http://www.mozilla.org/en-US/firefox/new/" target="_blank"><img alt="Download Firefox" src="http://#cgi.server_name#/images/browsers/logo_firefox_sm.png" border="0"/><br/>Firefox</a></td>
					<td align="center" width="10%"><a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie" target="_blank"><img alt="Download IE" src="http://#cgi.server_name#/images/browsers/logo_ie_sm.png" border="0"/><br/>Internet Explorer</a></td>
					<td align="center" width="10%"><a href="https://www.apple.com/safari/" target="_blank"><img alt="Download Safari" src="http://#cgi.server_name#/images/browsers/logo_safari_sm.png" border="0"/><br/>Safari</a></td>
					<td align="center" width="10%"><a href="http://www.opera.com/" target="_blank"><img alt="Download Opera" src="http://#cgi.server_name#/images/browsers/logo_opera_sm.png" border="0"/><br/>Opera</a></td>
				</tr>
			</table>
		</div>			
	</cffunction>

</cfcomponent>