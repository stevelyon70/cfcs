<cfcomponent>
	<cfapplication name="solDemo" applicationtimeout="#CreateTimeSpan(10, 0, 0, 0)#" sessionmanagement="yes">
	<cffunction name="page_build" description="builds the splash page" output="Yes" access="public">
	<cfoutput>
    <section id="header"></section>
    <section class="section-subhdr visible-md visible-lg" id="topNav"></section>
    <section id="content1"></section>
    <section id="content2"></section>
    <section id="content3"></section> 
	<cfset session.arguments = arguments>
    <cfset session.get_nav = get_nav>
	<cfset session.Get_Phones = Get_Phones>    
    <cfset session.Get_Meta_Info=Get_Meta_Info>    
    <cfset urlArr = StructKeyArray(url)>    
    <cfset _url = ''>
    <!---  loop over url scope and set vars --->
    <cfloop from="1" to="#arraylen(urlArr)#" index="s">
	    <cfset _url = _url & '&' & urlArr[s] & '=' & URLEncodedFormat(url[urlArr[s]])>
    </cfloop>    
    <cfsavecontent variable="c1">
			var $header = $('##header')
			var $topNav = $('##topNav')
			var $content1 = $('##content1')
			var $content2 = $('##content2')
			var $content3 = $('##content3')
			//add url vars to url string
			$header.load('/global/loadtest.cfm?id=1500&cfcId=head#_url#');
			$topNav.load('/global/loadtest.cfm?id=1500&cfcId=nav#_url#');
			$content1.load('/global/loadtest.cfm?id=1500&cfcId=content1#_url#');
			$content2.load('/global/loadtest.cfm?id=1500&cfcId=content2#_url#');
			$content3.load('/global/loadtest.cfm?id=1500&cfcId=content3#_url#');
	</cfsavecontent>		
	<cfset url.Dom_Functions = url.Dom_Functions & c1>    
	<!---});
	/*chkUsernameUnique = function(theUsername){
		$.getJSON("/cfcs/ultra10/build_footer.cfc", {
		 method: 'modern_portal',
		 Username: theUsername,
		 returnformat: 'json'
		 }, function(isUsernameUnique){
		 
		 if (isUsernameUnique == true) {
		 $("#theErrorDivID").html('Username is unique');
		 }
		 else {
		 $("#theErrorDivID").html('Please select a new username');
		 }
		 });
	};*/
	</script>--->
	</cfoutput>	
	</cffunction>
</cfcomponent>