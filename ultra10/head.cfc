<cfcomponent>

<cffunction name="simple_title" description="sets title tag" output="Yes" access="public">

<!--- arguments --->
<cfargument name="title" default="untilted">
<cfargument name="description" default="">
<cfargument name="keywords" default="">
<cfargument name="scripts_head" default="">
<cfargument name="global_scripts_head" default="">
<cfargument name="ga_codes" default="">
<cfargument name="google_validation" default="">
<cfargument name="bing_validation" default="">

<meta charset="utf-8">


<title>#arguments.title#</title> 

<cfif len(trim(arguments.description)) gt 0><meta name="description" content="#arguments.description#"/></cfif>
<cfif len(trim(arguments.keywords)) gt 0><meta name="keywords" content="#arguments.keywords#"/></cfif>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="distribution" content="Global"/>
<meta name="robots" content="INDEX,FOLLOW"/>
<meta name="author" content="http://www.worlddealer.net"/>
<meta name="copyright" content="Copyright #dateformat(now(),"yyyy")-1#-#dateformat(now(),"yyyy")#"/>

<cfif len(trim(arguments.google_validation)) gt 0><meta name="google-site-verification" content="#arguments.google_validation#" /></cfif>
<cfif len(trim(arguments.bing_validation)) gt 0><meta name="msvalidate.01" content="#arguments.bing_validation#" /></cfif>
<cfif len(trim(arguments.ga_codes)) gt 0>
	<script type="text/javascript">
		var _gaq = _gaq || [];
		<cfif listlen(arguments.ga_codes) eq 1>
			_gaq.push(['_setAccount', '#arguments.ga_codes#']);
			_gaq.push(['_setDomainName', '#cgi.server_name#']);
			_gaq.push(['_setAllowLinker', true]);
			_gaq.push(['_trackPageview']);
		<cfelse>
			<cfset variables.code_count=0>
			<cfloop list="#arguments.ga_codes#" index="gacode">
				<cfset variables.code_count=variables.code_count+1>
				<cfif variables.code_count eq 1>
					_gaq.push(['_setAccount', '#variables.gacode#']);
					_gaq.push(['_setDomainName', '#cgi.server_name#']);
					_gaq.push(['_setAllowLinker', true]);
					_gaq.push(['_trackPageview']);
				</cfif>
				<cfif variables.code_count eq 2>
					_gaq.push(['b._setAccount', '#variables.gacode#']);
					_gaq.push(['b._setDomainName', '#cgi.server_name#']);
					_gaq.push(['b._setAllowLinker', true]);
					_gaq.push(['b._trackPageview']);
				</cfif>
				<cfif variables.code_count eq 3>
					_gaq.push(['c._setAccount', '#variables.gacode#']);
					_gaq.push(['c._setDomainName', '#cgi.server_name#']);
					_gaq.push(['c._setAllowLinker', true]);
					_gaq.push(['c._trackPageview']);
				</cfif>
				<cfif variables.code_count eq 4>
					_gaq.push(['d._setAccount', '#variables.gacode#']);
					_gaq.push(['d._setDomainName', '#cgi.server_name#']);
					_gaq.push(['d._setAllowLinker', true]);
					_gaq.push(['d._trackPageview']);
				</cfif>
				<cfif variables.code_count eq 5>
					_gaq.push(['e._setAccount', '#variables.gacode#']);
					_gaq.push(['e._setDomainName', '#cgi.server_name#']);
					_gaq.push(['e._setAllowLinker', true]);
					_gaq.push(['e._trackPageview']);
				</cfif>
			</cfloop>
		</cfif>
		(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
	</script>
</cfif>


<cfif len(trim(arguments.global_scripts_head)) gt 0>
#arguments.global_scripts_head#
</cfif>
<cfif len(trim(arguments.scripts_head)) gt 0>
#arguments.scripts_head#
</cfif>

</cffunction>

</cfcomponent>