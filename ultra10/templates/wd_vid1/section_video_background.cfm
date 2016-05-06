<cfoutput>
 
<cfset mp4_vid = "http://www.eclarify.com/videos/background.mp4" >
<cfset webm_vid = "http://www.eclarify.com/videos/background.webm" >
<cfset ogg_vid = "http://www.eclarify.com/videos/background.ogg" >
<cfset spkr = "muted" >  

<!--- 
<cfset mp4_vid = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" >
<cfset webm_vid = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.webm" >
<cfset ogg_vid = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.ogv" >
<cfset spkr = "" > --->

<div class="container-fluid no-pad">				
	<div class="clouds no-pad">	
	 
        <video loop #spkr# autoplay width="1900"  >
            <source id="mp4" src="#mp4_vid#" type="video/mp4"/>
            <source id="webm" src="#webm_vid#"  type="video/webm"/>
            <source id="ogv" src="#ogg_vid#" type="video/ogg"/>
           <!---  <source id="mp4" src="http://www.eclarify.com/videos/background.mp4" type="video/mp4"/>
            <source id="webm" src="http://www.eclarify.com/videos/background.webm"  type="video/webm"/>
            <source id="ogv" src="http://www.eclarify.com/videos/background.ogg" type="http://leongaban.com/video/ogg"/> --->
			<!--- <object data="http://www.eclarify.com/videos/background.mp4" width="1920" height="1080">
                <param name="wmode" value="transparent">
                <param name="autoplay" value="true" >
                <param name="loop" value="true" >
                <embed src="http://www.eclarify.com/videos/background.swf" width="1920" height="1080" wmode="transparent" >
            </object> --->
        </video>
 		
 		<div class="video-float-block" >
			 <div class="video-float-title">
			 	<img img-responsive alt="Sample Banner" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/search_placeholder.jpg" />
			 </div> 
			<!---  <div class="video-float-text"  align="center" ></div>  --->
		</div>
		
		
    </div>
	
	
</div>
	

</cfoutput>		