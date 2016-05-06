
<cfparam name="attributes.autoplay" default="true">


		<cfset variables.vidSrc="http://#cgi.server_name#/dealer/#variables.dlr_dir#/videos/AutoProvalDec14.mp4">
	

<!--- <div id="myvideo">Javascript must be enabled and Flash 7 or above must be installed to view this content.</div> --->
<script type="text/javascript">
	var flashvars = {src : "<cfoutput>#variables.vidSrc#</cfoutput>", ap : <cfoutput>#attributes.autoplay#</cfoutput> };
	var params = {menu : "false",  wmode : "transparent"};
	swfobject.embedSWF("flash/scalableSingleFLV.swf", "myvideo", "650", "366", "8.0.0","expressInstall.swf", flashvars, params);
</script>