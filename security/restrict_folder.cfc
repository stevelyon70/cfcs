<cfcomponent>

	<cffunction name="restrict" description="resrtict folder access to certain ip addresses" output="Yes" access="public">
		<cfif 	left(REMOTE_ADDR,10) neq "192.168.5." and 
				left(REMOTE_ADDR,7) neq "10.0.0." and 
				left(REMOTE_ADDR,10) neq "172.16.25." and 
				left(REMOTE_ADDR,9) neq "70.192.13" and
				left(REMOTE_ADDR,10) neq "66.179.17."AND
				left(REMOTE_ADDR,12) neq "173.209.224."AND 			
				left(REMOTE_ADDR,13) neq "172.16.50.100"AND 		
				left(REMOTE_ADDR,13) neq "98.219.131.27"AND 		
				left(REMOTE_ADDR,13) neq "96.236.153.41"AND 		
				REMOTE_ADDR neq	"98.236.121.130" and
				remote_addr neq "70.198.197.249" and
				remote_addr neq "69.162.124.236"> 
				Access Denied
		
				<cfmail to="techsupport@worlddealer.net" from="security@worlddealer.net" subject="Unauthorized Accessx">
					An Unauthorized User attempted to access a protected file.
					IP Address: #CGI.REMOTE_ADDR#
					Template: #CGI.CF_TEMPLATE_PATH#
					Url: #CGI.SERVER_NAME#
				</cfmail>
				<cfabort>
		
		</cfif>
	</cffunction>

</cfcomponent>