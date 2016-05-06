<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<!--- SEARCH BAR 03/16/2016 --->
		<cfset variables.srch_err_phrase = "" >
		<cfif IsDefined("url.err_disp") >
			<cfset variables.srch_err_phrase = "Vehicles Found for"  >
			<cfset variables.srch_err_criteria = "#url.err_disp#" >
		</cfif>
		
<!--- Check SRP/VDP SEARCH BAR Style 03/16/2016 --->
		<cfset body_srchbar = 0 ><cfset srp_noresult = "USED" >
		<cfquery datasource="ultra10" name="chk_splash_srch">SELECT body_search_location,zero_result_dest FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfset body_srchbar = #chk_splash_srch.body_search_location# > 
		<cfif #chk_splash_srch.zero_result_dest# EQ 1><cfset srp_noresult = "NEW" ><cfelse><cfset srp_noresult = "USED" ></cfif>
		
		<section class="section-spl">
			<div class="container">
				<div class="row">
		<cfif #url.dealer_id# NEQ 233 >
					<div class="col-md-3 pad-top-10 visible-md visible-lg">
						<ul class="nav nav-tabs spl-tabs">
							<li class="active"><a href="##srch" data-toggle="tab">Search</a></li>
							<li><a href="##qq" data-toggle="tab">Quick Quote</a></li>
						</ul>
						<div class="tab-content srch-tabs">
							<div class="tab-pane active" id="srch">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
								</cfinvoke>
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="42"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="srch-links-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
							<div class="tab-pane" id="qq">
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_qq">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
									<cfinvokeargument name="srp_action" value="http://#cgi.server_name#/vehicles/splash_qq_action.cfm"/>
								</cfinvoke>
							</div>
						</div>
					</div>
			</cfif>
					
					<div class="col-md-9 pad-top-10">
						<div class="row  visible-sm visible-xs">
							<div class="col-md-12">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="13"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="spl-tools-btn"/>
									<cfinvokeargument name="glyph_right" value="true"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row">
						<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
							<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="3"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
						</cfinvoke>
						</div>
						<div class="row visible-sm visible-xs">
							<div class="col-md-12">
								<br/><br/>
								<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
									<cfinvokeargument name="form_id" value="carfinderFormMbl"/>
								</cfinvoke>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pad-top-10">
								<br/>
							</div>
						</div>
					</div>
					
					<cfif #url.dealer_id# eq 233>
						<div class="col-md-3 pad-top-10 visible-md visible-lg">
							<div class="spc-container" >
							<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="dsn" value="#url.DSN#"/>
								<cfinvokeargument name="title_class" value="spc-title"/>
								<cfinvokeargument name="input_class" value="spc-input"/>
								<cfinvokeargument name="button_class" value="spc-contact-input"/>
								<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
							</cfinvoke>
							</div>
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="42"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="srch-links-btn"/>
								<cfinvokeargument name="glyph_right" value="true"/>
							</cfinvoke>
						</div>
					</cfif>		
					
				</div>
			</div>
			
				<!--- Search Bar 03/16/2016 ---> 
				<cfif #body_srchbar# EQ 1 AND #url.dealer_id# eq 233  >	

					 <cfquery datasource="ultra10" name="chk_sugs">
					 	SELECT  suggestion FROM Dealer_Search_Suggestions WHERE dealer_id=#url.dealer_id# AND active = 1 ORDER BY hierarchy ASC </cfquery>
					<cfset a_newsText = ArrayNew(1)>
					<cfset a_label = ArrayNew(1)>
					<cfloop index="c" from="1" to="10"><cfset a_newsText[c]=""><cfset a_label[c]="Seach Suggestion:"></cfloop>
					<cfset x = 0 ><cfloop query="chk_sugs" ><cfset x = #x#+1 ><cfset a_newsText[x]="#chk_sugs.suggestion#"></cfloop>
					
					<div class="container visible-md visible-lg visible-sm visible-xs">		 
				 		<div class="container-search-box-bdy" align="center">
							<br>
							<cfform action="../../search/index.cfm" method="post" name="news"  >
								<input type="hidden" name="res_style" value="1">
								<input class="site-srch-btn-bdy"	type="submit"  name="submit"     value="?">
								<input  class="site-srch-input-bdy"	 type="text" name="lookup"  id="searchbar" size="50"  value=""  placeholder="Search #url.dealer_name#s Inventory" required >
								<cfif #chk_sugs.recordcount# NEQ 0 >
									<div class="site-srch-example-label-bdy" >
									<input  class="site-srch-example-bdy"	 type="text" name="exlookup"  id="realsearchbar" value=""    >
									</div>
								</cfif>
							<cfif #variables.srch_err_phrase# NEQ "" >
								 &nbsp;&nbsp;<span class="site-srch-count">0 </span><span class="site-srch-error">#variables.srch_err_phrase# "#variables.srch_err_criteria#".<br>Displaying All #srp_noresult# Vehicles in our inventory</span>
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
							
							<br>
							<div class="col-md-12 col-md-offset-1" align="center" >
								<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="horizontal_search_huge">
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
									<cfinvokeargument name="btn_pull" value="pull-right"/>
								</cfinvoke>	
							</div> <!--- end search columns --->
							<br>
						</div> 
					</div>
				</cfif>
			
			
		 <cfif #url.dealer_id# eq 33 OR  #url.dealer_id# eq 18  OR  #url.dealer_id# eq 32  OR  #url.dealer_id# eq 34  >
			<div class="container visible-md visible-lg visible-sm visible-xs">
				<div class="row pad-bottom-10">
					<div class="col-md-12  pad-top-10" align="center" style="margin-bottom:15px" >
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="31"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke> 
					</div>
				</div>
			</div>
		</cfif>		 
			
			
		</section>

		<section class="section-carousel">
			<div class="container pad-top-10 visible-md visible-lg">
				<div class="row" align="center">
					<div id="#arguments.assets#-carousel" class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
							<cfinvokeargument name="dsn" value="ultra10"/>
							<cfinvokeargument name="dealer_id" value="31"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="new_used" value="U"/>
							<cfinvokeargument name="minSlides" value="4"/>
                            <cfif url.dealer_id eq 32 
								or url.dealer_id eq 33
								or url.dealer_id eq 34
								or url.dealer_id eq 18
								>
							<cfinvokeargument name="maxSlides" value="4"/>
                            <cfinvokeargument name="sliderShow" value="false"/>
                            <cfelse>
                            <cfinvokeargument name="maxSlides" value="20"/>
                            </cfif>
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="nav_type_id" value="35"/>
							<cfinvokeargument name="carousel_class" value="specials-carousel"/>
							<cfinvokeargument name="element_class" value="specials-icon"/>
							<cfinvokeargument name="slideWidth" value="230"/>
							<cfinvokeargument name="slideMargin" value="15"/>
							<cfif #url.dealer_id# neq 33 AND  #url.dealer_id# neq 236 and #url.dealer_id# NEQ 257 and #url.dealer_id# NEQ 32 >
								<cfinvokeargument name="slideMargin" value="15"/>
							<cfelse>
								<cfinvokeargument name="slideMargin" value="30"/>	<!--- Increased Margin for KellyCarChrysler  09/09/2014 Should be controlled from Admin - Bob --->	
							</cfif>
							<cfif #url.dealer_id# eq 34 >
								<cfinvokeargument name="slideMargin" value="30"/>
							</cfif>	
						</cfinvoke>
					</div>
				</div>
				
		 <!--- <cfif #url.dealer_id# eq 33 OR  #url.dealer_id# eq 18  OR  #url.dealer_id# eq 32  OR  #url.dealer_id# eq 34  >
			<div class="container visible-md visible-lg">
				<div class="row">
					<div class="col-md-12  pad-top-10" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="31"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-icons"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke> 
					</div>
				</div>
			</div>
		</cfif>		  --->
				
				
			</div>
			<div class="container pad-top-10 visible-xs visible-sm">
				<div class="row">
					<div class="col-md-12" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="35"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="specials-icon-mbl"/>
							<cfinvokeargument name="glyph_left" value="true"/>
						</cfinvoke>
					</div>
				</div>
			</div>
		</section>

		<section class="section-carousel">
			<div class="container pad-top-10 visible-md visible-lg">
				<div class="row" align="center">
					<div id="#arguments.assets#-btn-carousel" class="col-md-12">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="36"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="btns-oblong"/>
							<cfinvokeargument name="pull" value="left"/>
						</cfinvoke>
						<div class="clearfix"></div>
						<div class="pad-top-10"></div>
					</div>
				</div>
			</div>
		</section>
		<cfquery name="chk_sec_spl" datasource="Ultra10">
			SELECT	ID, dealer_id, title, title_font_family, title_font_size, title_font_color, 
					title_font_weight, title_font_decoration, title_align, free_text, active
			FROM    Dealer_Splash_Section_Text
			where 	 dealer_id = #url.dealer_id#
		</cfquery>
		<section class="section-video">
			<div class="container">
			<cfif #chk_sec_spl.recordcount# EQ 1 >
				<cfset styler = "font-family:#chk_sec_spl.title_font_family#;color:###chk_sec_spl.title_font_color#;font-weight:#chk_sec_spl.title_font_weight#" >
				<div class="row">
					<div class="col-md-12 pad-10 visible-md visible-lg" align="#chk_sec_spl.title_align#">
					<cfif #chk_sec_spl.title_font_size# EQ 1 ><H1><span style="#styler#" >#chk_sec_spl.title#</span></H1></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 2 ><H2><span style="#styler#" >#chk_sec_spl.title#</span></H2></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 3 ><H3><span style="#styler#" >#chk_sec_spl.title#</span></H3></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 4 ><H4><span style="#styler#" >#chk_sec_spl.title#</span></H4></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 5 ><H5><span style="#styler#" >#chk_sec_spl.title#</span></H5></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 6 ><H6><span style="#styler#" >#chk_sec_spl.title#</span></H6></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 7 ><H7><span style="#styler#" >#chk_sec_spl.title#</span></H7></cfif>
					<cfif #chk_sec_spl.title_font_size# EQ 8 ><H8><span style="#styler#" >#chk_sec_spl.title#</span></H8></cfif>
					</div>
				</div>	
				<cfif #chk_sec_spl.free_text# NEQ "" >
					<div class="row">
						<div class="col-md-12 pad-10 visible-md visible-lg" align="left">
						#chk_sec_spl.free_text#
						</div>
					</div>	
				</cfif>
			</cfif>
				<div class="row">
					<div class="col-md-6 pad-10 visible-md visible-lg" align="center">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="30"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="video-link"/>
						</cfinvoke>
					</div>
					<div class="col-md-6 pad-10 visible-md visible-lg" align="center">				
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="38"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="splash-map"/>
						</cfinvoke>
					</div>
				</div>
				<!--- <cfif #url.dealer_id# EQ 18>
					<div class="row">
						<div class="col-md-12 pad-10 visible-md visible-lg" align="center">
							<a href="http://women-drivers.com/Kelly-Nissan-reviews" target="_blank"><img alt="Nissan" class="img-responsive" src="http://dealers.wdautos.com/dealer/kellynissan/images/icons/banner_NumberOneNissan_990.jpg" alt="Nissan" border="0" ></a>
						</div>
					</div>
				</cfif> --->
			</div>
		</section>

				<cfinclude template="section_about_us.cfm" >
				
		<section class="section-links">
			<div class="container pad-top-10">
				<cfswitch expression="#url.dealer_id#">
					<cfcase value="18,34,33,32,236,257">
						<div class="row">
							<div class="col-md-6">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="37"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="right"/>
								</cfinvoke>								
							</div>
						</div>
					</cfcase>
					<cfdefaultcase><!--- 10/22/2014 bob --->
						<!---  <div class="row  visible-sm visible-xs  ">
							<div class="col-md-12 ">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="28"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="sm-link"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
							</div>
						</div>     --->
					</cfdefaultcase>
				</cfswitch>
				<div class="row pad-top-10">
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="7"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="8"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="9"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="info-link"/>
							<cfinvokeargument name="bold_top" value="true"/>
							<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
						</cfinvoke>
					</div>
					<div class="col-md-3 visible-md visible-lg">
						<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
							<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
							<cfinvokeargument name="dsn" value="#url.DSN#"/>
							<cfinvokeargument name="title_class" value="ftr-title"/>
							<cfinvokeargument name="input_class" value="ftr-input"/>
							<cfinvokeargument name="button_class" value="ftr-contact-input"/>
							<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
						</cfinvoke>
					</div>
				</div>
				<!--- <cfinclude template="section_about_us.cfm" > --->
				<!--- Test for About Us here 
					<div class="row pad-top-10">
					</div> 
				--->
			</div>	<!--- end of container --->	
			
				
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:195px;padding:10px 10px 10px 0px;" valign="top">
							<div>
								<div style="padding-top:5px">
									<div class="spl-search-name">#arguments.dealer_name#</div>
									<div class="spl-search-title" title="CAR FINDER">CAR FINDER</div>
									<cfinvoke component="/cfcs/ultra10/tool_search_engine" method="vertical_search">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="btn_pull" value="pull-right"/>
									</cfinvoke>
									<div style="padding-right:10px;">
										<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
											<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
											<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
											<cfinvokeargument name="nav_type_id" value="42"/>
											<cfinvokeargument name="assets" value="#arguments.assets#"/>
											<cfinvokeargument name="element_class" value="srch-links-btn"/>
											<cfinvokeargument name="glyph_right" value="true"/>
										</cfinvoke>
									</div>
								</div>
							</div>
						</td>
						<td class="pad-top-10" style="width:785px" valign="top">
							<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="3"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
							</cfinvoke>
							<br/><br/>
						</td>
					</tr>
				</table>
			</div>			
		</div>

		<div class="section-carousel">
			<div class="container pad-top-10" align="center">
				<table style="width:990px;">
					<tr>
						<td>
							<cfinvoke component="/cfcs/ultra10/bxslider" method="carousel">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="31"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="4"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="nav_type_id" value="35"/>
								<cfinvokeargument name="carousel_class" value="specials-carousel-legacy"/>
								<cfinvokeargument name="element_class" value="specials-icon-legacy"/>
								<cfinvokeargument name="slideWidth" value="230"/>
								<cfinvokeargument name="slideMargin" value="17"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
			<div class="container pad-top-10" align="center">
				<table style="width:990px;">
					<tr>
						<td>
							<div id="#arguments.assets#-btn-carousel">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="36"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="btns-oblong-leg"/>
									<cfinvokeargument name="pull" value="left"/>
								</cfinvoke>
								<div class="clearfix"></div>
								<div class="pad-top-10"></div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-video">
			<div class="container">
				<table style="width:100%">
					<tr>
						<td style="width:50%" class="pad-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="30"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="video-link"/>
							</cfinvoke>
						</td>
						<td style="width:50%" class="pad-10" align="center">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="38"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="splash-map"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="section-links">
			<div class="container pad-top-10">

				<table style="width:100%;margin-bottom:10px;" cellpadding="0" cellspacing="0">
					<cfswitch expression="#url.dealer_id#">
						<cfcase value="18">
							<tr>
								<td style="width:50%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="28"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="left"/>
									</cfinvoke>
								</td>
								<td style="width:50%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="37"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="right"/>
									</cfinvoke>								
								</td>
							</tr>
						</cfcase>
						<cfdefaultcase>
							<tr>
								<td style="width:100%" valign="top">
									<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="28"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="sm-link"/>
										<cfinvokeargument name="pull" value="left"/>
									</cfinvoke>
								</td>
							</tr>
						</cfdefaultcase>
					</cfswitch>
				</table>
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="8"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="9"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:25%" valign="top">
							<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer_leg">
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="dsn" value="#url.DSN#"/>
								<cfinvokeargument name="title_class" value="ftr-title"/>
								<cfinvokeargument name="input_class" value="ftr-input"/>
								<cfinvokeargument name="button_class" value="ftr-contact-input"/>
								<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>