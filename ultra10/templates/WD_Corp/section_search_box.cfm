<cfoutput>


<cfquery datasource="ultra10" name="get_dlr_name">SELECT  Display_Name FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	

<div class="container-fluid">

	<section class="section-search-box">
	
		<div class="container-search-box" align="center">
		
			<cfform action="../../search/index.cfm" method="post" name="news" style="margin:0px 0px 0px 0px" >
				<input type="hidden" name="res_style" value="1">
				<input class="site-srch-btn"	type="submit"  name="submit"  style="margin:0px 0px 0px 0px"  value="?">
				<input  class="site-srch-input"	 type="text" name="lookup" style="margin:0px 0px 0px 0px" value=""  placeholder="Search #get_dlr_name.display_name#" required >
			</cfform>
					
			
				<script language=JavaScript>
				
				//Typing Text (DHTML) v1 (Sunday, April 15th, 2001)
				//Programmed by: Haitham M. Al-Beik
				//Email: albeik26@hotmail.com
				//Visit http://javascriptkit.com for this script
				
				var newsText = new Array();
				newsText[0] = "New Nissan Altima";
				newsText[1] = "Apply for a loan";
				newsText[2] = "What's my car worth";
				newsText[3] = "What are your hours";
				newsText[4] = "New Nissan Offers";
				newsText[5] = "Where are you located"
				
				var ttloop = 1;    // Repeat forever? (1 = True; 0 = False)
				var tspeed = 60;   // Typing speed in milliseconds (larger number = slower)
				var tdelay = 12000; // Time delay between newsTexts in milliseconds
				
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
				      document.news.lookup.value = "";
				      eline = 0;
				      setTimeout("addChar()",tspeed)
				    }
				  }
				}
				function addChar() {
				  if (eline!=1) {
				    if (cchar != dwAText.length) {
				      nmttxt = ""; for (var k=0; k<=cchar;k++) nmttxt += dwAText.charAt(k);
				      document.news.lookup.value = nmttxt;
				      cchar += 1;
				      if (cchar != dwAText.length) document.news.lookup.value += "_";
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

					
					
					
					
			<!--- 				style="background-color:##ffffff;color:##666666;border:0px solid ##333333;border-top-left-radius:3px!important;-moz-border-radius:7px!important;-webkit-border-radius:7px!important;padding:2px 2px 2px 2px;"		
			style="font-size:18pt!important;height:50px;border:0px solid ##333333;border-top-left-radius:0px!important;-moz-border-radius:3px!important;-webkit-border-radius:3px!important;"	
			
           <cfinvoke component="/cfcs/views/simpleTextSearch" method="displaytextBox">
               <cfinvokeargument name="formWrap" value="yes" />
               <cfinvokeargument name="class" value="form-control input-lg" />
               <cfinvokeargument name="id" value="simpleSrh" />
               <cfinvokeargument name="width" value="300px" />
           </cfinvoke> --->
	
		</div>	
		
	</section>
	
</div>
</cfoutput>