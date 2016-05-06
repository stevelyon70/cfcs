<cfcomponent>

	<cffunction name="pitt" description="header script tags" output="Yes" access="public">
		
		<cfswitch expression="#cgi.script_name#">
			<cfcase value="/index.cfm">
				<script type='text/javascript'>
					(function() {
					var useSSL = 'https:' == document.location.protocol;
					var src = (useSSL ? 'https:' : 'http:') +
					'//www.googletagservices.com/tag/js/gpt.js';
					document.write('<scr' + 'ipt src="' + src + '"></scr' + 'ipt>');
					})();
				</script>
				<script type='text/javascript'>
					var Leaderboard_BTFactive;
					var Skyscraper_BTFactive;
					var richmediaactive;
					var Pencil_Leavebehind_ATFactive;
					var BigBox_ATFactive;
					var Top_Companion_ATFactive;
					
					googletag.cmd.push(function() {
					var width = "";if (document.documentElement && document.documentElement.clientWidth) {width = document.documentElement.clientWidth;} else {width = 1024;}
					
					var Leaderboard_BTFsize;
					
					/*Leaderboard_BTFsize = [[728,90],[468,60],[300,50]]*/
					
					if (width >=0 && width < 768) { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [300,50]; } 
					else if (width >=768 && width < 992) { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [468,60]; }
					else if (width > 992) { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [728,90]; }
					else { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [728,90]; }
					if (Leaderboard_BTFactive > 0){ googletag.defineSlot('/207845991/Leaderboard_BTF', Leaderboard_BTFsize, 'div-gpt-ad-1380843670843-1').addService(googletag.pubads());}
					
					
					var BigBox_STFsize;
					if (width >=0 && width < 768) { BigBox_STFactive = 1; BigBox_STFsize = [300,50]; } 
					else if (width >=768 && width < 992) { BigBox_STFactive = 1; BigBox_STFsize = [[300,250],[300,100],[300,50]]; }
					else if (width > 992) { BigBox_STFactive = 1; BigBox_STFsize = [300,250]; }
					else { BigBox_STFactive = 1; BigBox_STFsize = [[300,250],[300,100],[300,50]]; }
					if (BigBox_STFactive > 0){ googletag.defineSlot('/207845991/BigBox_STF', BigBox_STFsize, 'div-gpt-ad-1380843670843-2').addService(googletag.pubads());}
					
					
					var BigBox_BTFsize;
					if (width >=0 && width < 768) {BigBox_BTFactive = 1; BigBox_BTFsize= [300,50]; } 
					else if (width >=768 && width < 992) {BigBox_BTFactive = 1; BigBox_BTFsize= [[300,250],[300,100],[300,50]]; }
					else if (width > 992) {BigBox_BTFactive = 1; BigBox_BTFsize= [300,250]; }
					else {BigBox_BTFactive = 1; BigBox_BTFsize= [[300,250],[300,100],[300,50]]; }
					if (BigBox_BTFactive > 0){ googletag.defineSlot('/207845991/BigBox_BTF', BigBox_BTFsize, 'div-gpt-ad-1380843670843-3').addService(googletag.pubads());}
					
					
					googletag.pubads().setTargeting("site","pittsburghautosuperstore.com");
					googletag.pubads().setTargeting("cstmSctn","Homepage");
					googletag.pubads().setTargeting("conType","page");
					googletag.pubads().setTargeting("content",["ROS"]);
					googletag.pubads().setTargeting("autocontent", ["{http://#cgi.server_name#}"]);
					googletag.pubads().enableSyncRendering();
					googletag.pubads().enableSingleRequest();
					googletag.enableServices();
					});
				</script>
			</cfcase> 
			<cfdefaultcase>
				<script type='text/javascript'>
					(function() {
					var useSSL = 'https:' == document.location.protocol;
					var src = (useSSL ? 'https:' : 'http:') +
					'//www.googletagservices.com/tag/js/gpt.js';
					document.write('<scr' + 'ipt src="' + src + '"></scr' + 'ipt>');
					})();
				</script>
				<script type='text/javascript'>
					var Leaderboard_ATFactive;
					var Leaderboard_BTFactive;
					
					googletag.cmd.push(function() {
					var width = "";if (document.documentElement && document.documentElement.clientWidth) {width = document.documentElement.clientWidth;} else {width = 1024;}
					
					var Leaderboard_ATFsize;
					/*Leaderboard_ATFsize = [[728,90],[468,60],[300,50]]*/
					
					if (width >=0 && width < 768) { Leaderboard_ATFactive = 1; Leaderboard_ATFsize = [300,50]; } 
					else if (width >=768 && width < 992) { Leaderboard_ATFactive = 1; Leaderboard_ATFsize = [468,60]; }
					else if (width > 992) { Leaderboard_ATFactive = 1; Leaderboard_ATFsize = [728,90]; }
					else { Leaderboard_ATFactive = 1; Leaderboard_ATFsize = [728,90]; }
					if (Leaderboard_ATFactive > 0){ googletag.defineSlot('/207845991/Leaderboard_ATF', Leaderboard_ATFsize, 'div-gpt-ad-1380843670843-1').addService(googletag.pubads());}
					
					var Leaderboard_BTFsize;
					/*Leaderboard_BTFsize = [[728,90],[468,60],[300,50]]*/
					
					if (width >=0 && width < 768) { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [300,50]; } 
					else if (width >=768 && width < 992) { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [468,60]; }
					else if (width > 992) { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [728,90]; }
					else { Leaderboard_BTFactive = 1; Leaderboard_BTFsize = [728,90]; }
					if (Leaderboard_BTFactive > 0){ googletag.defineSlot('/207845991/Leaderboard_BTF', Leaderboard_BTFsize, 'div-gpt-ad-1380843670843-2').addService(googletag.pubads());}
					
					
					googletag.pubads().setTargeting("site","pittsburghautosuperstore.com");googletag.pubads().setTargeting("conType","page");googletag.pubads().setTargeting("content",["auto-{http://#cgi.server_name##cgi.script_name#}","ROS"]);
					googletag.pubads().enableSyncRendering();
					googletag.pubads().enableSingleRequest();
					googletag.enableServices();
					});
				</script>
			</cfdefaultcase>
		</cfswitch>
		
	</cffunction>

</cfcomponent>