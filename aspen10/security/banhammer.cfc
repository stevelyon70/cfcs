<cfcomponent>

	<cffunction name="bad_agents" description="block bad robots" output="Yes" access="public">
	
		<cfif 	left(cgi.HTTP_USER_AGENT,5) eq "Java/"
				OR cgi.HTTP_USER_AGENT contains "AhrefsBot"
				OR cgi.HTTP_USER_AGENT contains "RealSpider"
				OR cgi.HTTP_USER_AGENT contains "libwww-perl"
				OR cgi.HTTP_USER_AGENT contains "findfiles.net/0.97 (Robot;test_robot@gmx-topmail.de)"
				OR cgi.HTTP_USER_AGENT contains "http://www.80legs.com/webcrawler.html"
				OR cgi.HTTP_USER_AGENT contains "http://www.dotnetdotcom.org"
				OR cgi.HTTP_USER_AGENT contains "www.omni-explorer.com"
				OR cgi.HTTP_USER_AGENT contains "sitebot"
				OR cgi.HTTP_USER_AGENT contains "NerdByNature.Bot"
				OR cgi.HTTP_USER_AGENT contains "Baiduspider"
				OR cgi.HTTP_USER_AGENT contains "Ezooms/1.0"
				OR cgi.HTTP_USER_AGENT contains "YandexBot"
				OR cgi.HTTP_USER_AGENT contains "discoverybot"
				OR cgi.HTTP_USER_AGENT contains "TurnitinBot"
				or left(cgi.remote_addr,7) eq "173.212"
				or left(cgi.remote_addr,6) eq "202.46">
				<cfabort>
		</cfif>
	
	</cffunction>

	<cffunction name="banned_ip" description="block already banned ips" output="Yes" access="public">

		<cfset variables.dsn="banhammer">
		<cfset variables.ban_msg_eng="We're Sorry. Your IP Address <strong style='background-color:##F00;color:##ff0'>(#cgi.Remote_Addr#)</strong> has been identified as originating from a malicious host. You will not be premitted to utilize this website in any way.<br/>If you believe you received this message in error, you may call customer support at 866-485-8800.">
		<cfset variables.ban_msg_esp="Disculpe las molestias. Tu direcci�n IP <strong style='background-color:##f00;color:##ff0'>(#cgi.Remote_Addr#)</strong> ha sido identificado como procedente de un host malicioso. No se le premitted para utilizar este sitio web de ninguna manera.<br/>Si usted cree que ha recibido este mensaje por error, puede llamar a atenci�n al cliente al 866-485-8800.">
		<cfset variables.ban_msg_fr="Nous sommes d�sol�s. Votre adresse IP <strong style='background-color:##f00;color:##ff0'>(#cgi.Remote_Addr#)</strong> a �t� identifi� comme provenant d'un h�te malveillant. Vous ne serez pas premitted � utiliser ce site de quelque fa�on.<br/>Si vous croyez que vous avez re�u ce message par erreur, vous pouvez appeler le support � la client�le au 866-485-8800.">
		<cfset variables.ban_msg_ger="Es tut uns leid. Ihre IP <strong style='background-color:##F00;color:##ff0'>(#cgi.Remote_Addr#)</strong> Adresse hat, als von einem b�sartigen Host identifiziert worden. Sie werden nicht premitted, diese Website in irgendeiner Weise nutzen werden.<br/>Wenn Sie glauben, Sie haben diese Nachricht erhalten haben, k�nnen Sie den Kundendienst unter 866-485-8800 anrufen.">
		
		<!--- Ad-Hoc QUERY commented out in favor of Stored Proceedure
		<cfquery datasource="#variables.dsn#" name="check_ip">
			SELECT		BAN_ID,
						REMOTE_ADDR,
						REMOTE_HOST,
						CF_TEMPLATE_PATH,
						HTTP_USER_AGENT,
						BAN_DATE,
						VISIT_COUNT
			FROM		BANNED
			WHERE		REMOTE_ADDR=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.REMOTE_ADDR#" maxlength="20">
		</cfquery>
		--->
	
		<cfstoredproc datasource="#variables.dsn#" procedure="Check_Ip">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@REMOTE_ADDR" value="#cgi.REMOTE_ADDR#" maxlength="50">
			<cfprocresult name = "check_ip" resultset="1">
		</cfstoredproc>
		
		<cfif check_ip.recordcount gt 0>
			<!--- Ad-Hoc QUERY commented out in favor of Stored Proceedure
			<cfquery datasource="#variables.dsn#" name="Update_Visit">
				UPDATE		BANNED
				SET			VISIT_COUNT=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#check_ip.VISIT_COUNT+1#" maxlength="10">,
							LAST_VISIT=GetDate()
				WHERE		BAN_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#check_ip.BAN_ID#" maxlength="10">
			</cfquery>
			--->
			<cfstoredproc datasource="#variables.dsn#" procedure="Update_Visit">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@BAN_ID" value="#check_ip.BAN_ID#" maxlength="10">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@VISIT_COUNT" value="#check_ip.VISIT_COUNT+1#" maxlength="10">
			</cfstoredproc>
			<cfoutput>
				<div align="center">
					#variables.ban_msg_eng#<br/><hr/>
					#variables.ban_msg_esp#<br/><hr/>
					#variables.ban_msg_fr#<br/><hr/>
					#variables.ban_msg_ger#<br/>
				</div>
			</cfoutput>
			<cfabort>
		</cfif>
	
	</cffunction>

	<cffunction name="inject_protect" description="searches for various attacks and bans the originating ips if detected" output="Yes" access="public">
		<cfset variables.dsn="banhammer">
		<cfif 	REMOTE_ADDR neq "209.83.188.140" and
				REMOTE_ADDR neq "209.83.188.141" and
				REMOTE_ADDR neq "209.83.188.142" and
				REMOTE_ADDR neq "209.83.188.143" and
				REMOTE_ADDR neq "209.83.188.144" and
				REMOTE_ADDR neq "209.83.188.145" and
				REMOTE_ADDR neq "24.3.93.113" and 
				REMOTE_ADDR neq "50.73.170.140" and
				REMOTE_ADDR neq "69.89.78.176" and
				REMOTE_ADDR neq "69.89.78.177" and
				REMOTE_ADDR neq "69.89.78.178" and
				REMOTE_ADDR neq "69.89.78.180" and				
				left(REMOTE_ADDR,9) neq "8.14.169.">
	
			<cfif 	cgi.SCRIPT_NAME contains "EXEC("
					OR cgi.QUERY_STRING contains "EXEC("
					OR cgi.QUERY_STRING contains "@@version"
					OR cgi.QUERY_STRING contains "%40%40version"
					OR cgi.QUERY_STRING contains "declare%20@"
					OR cgi.QUERY_STRING contains "exec("
					OR cgi.QUERY_STRING contains "cast("
					OR cgi.QUERY_STRING contains "drop table"
					OR cgi.QUERY_STRING contains "drop%20table"
					OR cgi.QUERY_STRING contains "insert into"
					OR cgi.QUERY_STRING contains "insert%20into"
					OR cgi.QUERY_STRING contains "convert%28"
					OR cgi.QUERY_STRING contains "convert("
					OR cgi.QUERY_STRING contains "%20union%20all%20"
					OR cgi.QUERY_STRING contains "999999.9%20union%20all%20select"
					OR cgi.QUERY_STRING contains "information_schema.tables"
					OR cgi.QUERY_STRING contains "proc/self/environ"
	
					<!--- Japan hacker guy block --->
					OR left(cgi.REMOTE_ADDR,7) eq "150.70."
	
					OR cgi.PATH_INFO contains "EXEC("
					OR cgi.PATH_INFO contains "@@version"
					OR cgi.PATH_INFO contains "%40%40version"
					OR cgi.PATH_INFO contains "declare%20@"
					OR cgi.PATH_INFO contains "exec("
					OR cgi.PATH_INFO contains "cast("
					OR cgi.PATH_INFO contains "drop table"
					OR cgi.PATH_INFO contains "drop%20table"
					OR cgi.PATH_INFO contains "insert into"
					OR cgi.PATH_INFO contains "insert%20into"
					OR cgi.PATH_INFO contains "information_schema.tables"
					OR cgi.PATH_INFO contains "proc/self/environ"
	
					OR cgi.CF_TEMPLATE_PATH contains "E:\Inetpub\wwwroot\Ultra9\https:\secure.worlddealer.net\finance.cfm">
	
				<!--- Ad-Hoc QUERY commented out in favor of Stored Proceedure
				<cfquery datasource="#variables.dsn#" name="Insert_Ban">
					INSERT INTO		Banned
						(REMOTE_ADDR,
						REMOTE_HOST,
						CF_TEMPLATE_PATH,
						HTTP_USER_AGENT,
						SERVER_NAME,
						HTTP_REFERER)
					VALUES
						(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.REMOTE_ADDR#" maxlength="20">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.REMOTE_HOST#" maxlength="20">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.CF_TEMPLATE_PATH#" maxlength="200">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.HTTP_USER_AGENT#" maxlength="2000">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.SERVER_NAME#" maxlength="2000">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.HTTP_REFERER#" maxlength="2000">)
				</cfquery>
				--->
				
				<cfstoredproc datasource="#variables.dsn#" procedure="Insert_Ban">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@REMOTE_ADDR" value="#cgi.REMOTE_ADDR#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@REMOTE_HOST" value="#cgi.REMOTE_HOST#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CF_TEMPLATE_PATH" value="#cgi.CF_TEMPLATE_PATH#" maxlength="200">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@HTTP_USER_AGENT" value="#cgi.HTTP_USER_AGENT#" maxlength="2000">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@SERVER_NAME" value="#cgi.SERVER_NAME#" maxlength="2000">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@HTTP_REFERER" value="#cgi.HTTP_REFERER#" maxlength="2000">
				</cfstoredproc>
				
				<cfinvoke component="/cfcs/security/banhammer" method="banned_ip"></cfinvoke>
			
			</cfif>
		
		<cfelse>

			<cfif 	cgi.SCRIPT_NAME contains "EXEC("
				OR cgi.QUERY_STRING contains "EXEC("
				OR cgi.QUERY_STRING contains "@@version"
				OR cgi.QUERY_STRING contains "%40%40version"
				OR cgi.QUERY_STRING contains "declare%20@"
				OR cgi.QUERY_STRING contains "exec("
				OR cgi.QUERY_STRING contains "cast("
				OR cgi.QUERY_STRING contains "drop table"
				OR cgi.QUERY_STRING contains "drop%20table"
				OR cgi.QUERY_STRING contains "insert into"
				OR cgi.QUERY_STRING contains "insert%20into"
				OR cgi.QUERY_STRING contains "convert%28"
				OR cgi.QUERY_STRING contains "convert("
				OR cgi.QUERY_STRING contains "%20union%20all%20"
				OR cgi.QUERY_STRING contains "999999.9%20union%20all%20select"
				OR cgi.QUERY_STRING contains "information_schema.tables"
				OR cgi.QUERY_STRING contains "proc/self/environ"

				<!--- Japan hacker guy block --->
				OR left(cgi.REMOTE_ADDR,7) eq "150.70."

				OR cgi.PATH_INFO contains "EXEC("
				OR cgi.PATH_INFO contains "@@version"
				OR cgi.PATH_INFO contains "%40%40version"
				OR cgi.PATH_INFO contains "declare%20@"
				OR cgi.PATH_INFO contains "exec("
				OR cgi.PATH_INFO contains "cast("
				OR cgi.PATH_INFO contains "drop table"
				OR cgi.PATH_INFO contains "drop%20table"
				OR cgi.PATH_INFO contains "insert into"
				OR cgi.PATH_INFO contains "insert%20into"
				OR cgi.PATH_INFO contains "information_schema.tables"
				OR cgi.PATH_INFO contains "proc/self/environ"

				OR cgi.CF_TEMPLATE_PATH contains "E:\Inetpub\wwwroot\Ultra9\https:\secure.worlddealer.net\finance.cfm">
				<cfabort>
			</cfif>
			
		</cfif>
	</cffunction>
</cfcomponent>