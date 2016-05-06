<cfcomponent>

<cffunction name="simple_title" description="sets title tag" output="Yes" access="public">

<!--- arguments --->
<cfargument name="title" default="untilted">
<cfargument name="description" default="">
<cfargument name="keywords" default="">
<cfargument name="scripts_head" default="">
<cfargument name="ga_codes" default="">
<cfargument name="google_validation" default="">
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
<!---<cfif len(trim(arguments.ga_codes)) gt 0>
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount', '#arguments.ga_codes#']);
_gaq.push(['_setDomainName', 'none']);
_gaq.push(['_setAllowLinker', true]);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
<script type="text/javascript">
setTimeout(function(){var a=document.createElement("script");
var b=document.getElementsByTagName("script")[0];
a.src=document.location.protocol+"//dnn506yrbagrg.cloudfront.net/pages/scripts/0013/7912.js?"+Math.floor(new Date().getTime()/3600000);
a.async=true;a.type="text/javascript";b.parentNode.insertBefore(a,b)}, 1);
</script>
</cfif>--->
<cfif len(trim(arguments.scripts_head)) gt 0>
#arguments.scripts_head#
</cfif>
</cffunction>

</cfcomponent>