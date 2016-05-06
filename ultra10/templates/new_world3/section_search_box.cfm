<cfoutput>


<!--- SEARCH BAR 03/16/2016 --->
	<cfset variables.srch_err_phrase = "" >
	<cfif IsDefined("url.err_disp") ><cfset variables.srch_err_phrase = "Vehicles Found for"><cfset variables.srch_err_criteria = "#url.err_disp#" ></cfif>
		
<!--- Check SRP/VDP SEARCH BAR Style 03/16/2016 --->
	<cfset body_srchbar = 0 ><cfset srp_noresult = "USED" >
	<cfquery datasource="ultra10" name="chk_splash_srch">SELECT body_search_location,zero_result_dest FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
	<cfset body_srchbar = #chk_splash_srch.body_search_location# > 
	<cfif #chk_splash_srch.zero_result_dest# EQ 1><cfset srp_noresult = "NEW" ><cfelse><cfset srp_noresult = "USED" ></cfif>
	<cfquery datasource="ultra10" name="chk_sugs" maxrows="10">SELECT  suggestion FROM Dealer_Search_Suggestions WHERE dealer_id=#url.dealer_id# AND active = 1 ORDER BY hierarchy ASC </cfquery>
	<cfset a_newsText = ArrayNew(1)><cfset a_label = ArrayNew(1)>
	<cfloop index="c" from="1" to="10"><cfset a_newsText[c]=""><cfset a_label[c]="Seach Suggestion:"></cfloop>
	<cfset x = 0 ><cfloop query="chk_sugs" ><cfset x = #x#+1 ><cfset a_newsText[x]="#chk_sugs.suggestion#"></cfloop>
					
<div class="container-fluid">

	<section class="section-search-box">
	
		<div class="container-search-box" align="center">
		
			<cfform action="../../search/index.cfm" method="post" name="news" style="margin:0px 0px 0px 0px" >
				<input type="hidden" name="res_style" value="1">
				<input class="site-srch-btn"	type="submit"  name="submit"  style="margin:0px 0px 0px 0px"  value="?">
				<input  class="site-srch-input"	 type="text" name="lookup" style="margin:0px 0px 0px 0px" value=""  placeholder="Search #url.dealer_name#" required >
				<cfif #chk_sugs.recordcount# NEQ 0 >
					<div class="site-srch-example-label-bdy visible-md visible-lg" >
						<input  class="site-srch-example-bdy"	 type="text" name="exlookup"  id="realsearchbar" value=""    >
					</div>
				</cfif>
			</cfform>

			<script language=JavaScript>
				var newsText = new Array();

					newsText[0] = "<cfoutput>Welcome to #url.dealer_name#!</cfoutput>"; 
					newsText[1] = "<cfoutput>#a_label[1]# #a_newsText[1]#</cfoutput>";
					newsText[2] = "<cfoutput>#a_label[2]# #a_newsText[2]#</cfoutput>";
					<cfif #x# GTE 3 >newsText[3] = "<cfoutput>#a_label[3]# #a_newsText[3]#</cfoutput>";</cfif>
					<cfif #x# GTE 4 >newsText[4] = "<cfoutput>#a_label[4]# #a_newsText[4]#</cfoutput>";</cfif>
					<cfif #x# GTE 5 >newsText[5] = "<cfoutput>#a_label[5]# #a_newsText[5]#</cfoutput>";</cfif>
					<cfif #x# GTE 6 >newsText[6] = "<cfoutput>#a_label[6]# #a_newsText[6]#</cfoutput>";</cfif>
					<cfif #x# GTE 7 >newsText[7] = "<cfoutput>#a_label[7]# #a_newsText[7]#</cfoutput>";</cfif>
					<cfif #x# GTE 8 >newsText[8] = "<cfoutput>#a_label[8]# #a_newsText[8]#</cfoutput>";</cfif>
					<cfif #x# GTE 9 >newsText[9] = "<cfoutput>#a_label[9]# #a_newsText[9]#</cfoutput>";</cfif>
					<cfif #x# GTE 10 >newsText[10] = "<cfoutput>#a_label[10]# #a_newsText[10]#</cfoutput>";</cfif>
						
					var ttloop = 1;    // Repeat forever? (1 = True; 0 = False)
					var tspeed = 60;   // Typing speed in milliseconds (larger number = slower)
					var tdelay = 3000; // Time delay between newsTexts in milliseconds
							
					// ------------- NO EDITING AFTER THIS LINE ------------- \\
					var dwAText, cnews=0, eline=0, cchar=0, mxText;
						
					function doNews() {
						  mxText = newsText.length - 1;
						  dwAText = newsText[cnews];
						  setTimeout("addChar()",1000)
						}
					function addNews() {
						  cnews += 1;
						  if (cnews <= mxText) {
						    dwAText = newsText[cnews];
						    if (dwAText.length != 0) {
						      document.news.exlookup.value = "";
						      eline = 0;
						      setTimeout("addChar()",tspeed)
						    }
						  }
						}
					function addChar() {
						  if (eline!=1) {
						    if (cchar != dwAText.length) {
						      nmttxt = ""; for (var k=0; k<=cchar;k++) nmttxt += dwAText.charAt(k);
						      document.news.exlookup.value = nmttxt;
						      cchar += 1;
						      if (cchar != dwAText.length) document.news.exlookup.value += "_";
						    } else {
						      cchar = 0;
						      eline = 1;
						    }
						    if (mxText==cnews && eline!=0 && ttloop!=0) {
						      cnews = 0; setTimeout("addNews()",tdelay);
						    } else setTimeout("addChar()",tspeed);
						  } else {
						    setTimeout("addNews()",tdelay)
						  }
						}
						
					doNews()
				</script>					

		</div>	
		
	</section>
	
</div>
</cfoutput>