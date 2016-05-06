<cfcomponent>

	<cffunction name="vdp_standard" description="shows default standard vdp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_fin" default="no">
		<cfargument name="exclude_friend" default="no">
		<cfargument name="exclude_print" default="no">
		<cfargument name="exclude_autocheck" default="no">


	 	<!--- Clicks Tracker --->
		<cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery><cfset click_tracker = #t_clik.track_clicks# >
		<!--- Clicks Tracker --->
		
	<!--- Check for Custom Buttons--->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		
		<cfquery datasource="ultra10" name="Get_Btns">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 2
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_vdp_btns = #Get_Btns.recordcount# >
	<!--- Check for Custom Buttons--->

		<cfswitch expression="#url.dealer_id#">
			<cfcase value="17,18,32,33,34,35">
				<!---Paul request 5/22/2014--->
				<cfset arguments.exclude_qq="yes">
			</cfcase>
		</cfswitch>
		
	 <cfswitch expression="#url.dealer_id#">
			<cfcase value="24,60,61,72,75,78,79,82,174,175,176,177,256,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,291,292,293,294,295,296,297,298,299,300,301,309,310">
				<!---Faulkner request 08/26/2015--->
				<cfset arguments.exclude_print="yes">
			</cfcase>
			<cfcase value="84,311">
				<!--- FindlayAuto request 02/05/2016--->
				<cfset arguments.exclude_fin="yes">
			</cfcase>
		</cfswitch>  
 
		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
	
	<cfif #variables.cust_btns# EQ 1 AND #variables.nbr_vdp_btns# GT 0 >
		<cfloop query="Get_Btns">
			<cfswitch expression="#Get_Btns.Btn_Link_Target#">
				<cfdefaultcase>
					<a class="btn btn-vdp-cust" href="#Get_Btns.Btn_Link#" >
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img  alt="#Get_Btns.Btn_Title#"class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfdefaultcase>	
				<cfcase value="Modal">
					<a class="btn btn-vdp-cust" data-toggle="modal"   data-target="###Get_Btns.modal_type#Modal">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 
						</cfif>
						<span align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>	
				<cfcase value="print">
					<a class="btn btn-vdp-cust" href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" target="_blank">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span  align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>	
				<cfcase value="new">
					<a class="btn btn-vdp-cust" href="#Get_Btns.Btn_Link#" target="_blank">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#"  class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span  align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>
			</cfswitch>
		</cfloop>		
				
	<cfelse>
	 
		<cfif #url.dealer_id# EQ 30>
				 
					 <div class="page-div-lite"></div> 
		 
				
			<a class="btn btn-red-cust" href="http://ronhibbardtoyota.com/dealer/ronhibbard/ron_hibbard_finance_application.cfm" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off_white.png"/>Get Financed</a>
		</cfif>
			 
		<cfif arguments.exclude_td eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfcase value="36,37,28,25">	<!--- Washington Auto Mall & subs --->	
					<a class="btn btn-grey " data-toggle="modal"   data-target="##tdModal" <cfif url.dealer_id EQ 37> onClick = "var s=s_gi('tdds-prod');s.linkTrackVars = 'prop6,prop64';s.linkTrackEvents = 'event54';s.prop6 = 'vehicle request';s.prop64 = 'vehicle'; s.tl(this, 'o');" </cfif>><img alt="Test Drive"  class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive2_off.png"/ >Schedule A Test Drive</a>
				</cfcase>	
				<cfdefaultcase>
					<a class="btn btn-grey" data-toggle="modal" data-target="##tdModal"><img alt="Test Drive"  class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png"/>Schedule A Test Drive</a>
				</cfdefaultcase>	
			</cfswitch>
		</cfif>
		<cfif arguments.exclude_qq eq "no">
			<cfswitch expression="#url.dealer_id#">
				
				 <cfcase value="79">	<!--- Faulkner Nissan Jenkintown --->
					<a class="btn btn-grey-cust" data-toggle="modal" data-target="##qqModal"><img alt="Get Additional Savings"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get Additional Savings</a>						
				</cfcase> 
				
				 <cfcase value="30">	<!--- Ron Hibbard Toyota --->
					 
				</cfcase> 
				
				
				 <cfcase value="233">	<!--- Change to Ron Hibbard if approved  --->
					<cfif IsDefined("url.newused") and #url.newused# EQ "U">
					<a class="btn btn-grey-cust" data-toggle="modal" data-target="##maoModal"><img alt="Make an Offer"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Make an Offer</a>						
					<cfelse>			
					<a class="btn btn-grey" data-toggle="modal" data-target="##qqModal" <cfif url.dealer_id EQ 37> onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(this, 'o', 'getquote');" </cfif>><img alt="Get a Quote"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
					</cfif>
				</cfcase> 

				 <cfcase value="38">	<!--- Washington Scio --->
					<a class="btn btn-grey" href="http://#cgi.server_name#/forms/trade.cfm" ><img alt="Value Your Trade"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Value Your Trade</a>						
				</cfcase> 
				 <cfcase value="1">	<!--- Baierl. com --->
					<a class="btn btn-grey" href="http://#cgi.server_name#/dealer/baierl/value_your_trade.cfm" ><img alt="Value Your Trade"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Value Your Trade</a>						
				</cfcase> 
				 <cfcase value="179">	<!--- Fuccillo Scio --->
					<a class="btn btn-grey" href="http://#cgi.server_name#/forms/trade.cfm" ><img alt="Value Your Trade"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Value Your Trade</a>						
				</cfcase> 
				 <cfcase value="45">	<!--- Stoltz Scio --->
					<a class="btn btn-grey" href="http://#cgi.server_name#/forms/trade.cfm" ><img alt="Value Your Trade"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Value Your Trade</a>						
				</cfcase> 

				<cfcase value="78">	
					<cfif ( IsDefined("url.newused") AND #url.newused# EQ "N") >
						<a class="btn btn-grey" data-toggle="modal" data-target="##qqModal" ><img alt="Get a Quote"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
					<cfelse>
						<a class="btn btn-grey" data-toggle="modal" data-target="##qqModal" ><img alt="Get a Quote"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
					</cfif>
				</cfcase> 
				
				<cfdefaultcase>
					<a class="btn btn-grey" data-toggle="modal" data-target="##qqModal" <cfif url.dealer_id EQ 37> onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(this, 'o', 'getquote');" </cfif>><img alt="Get a Quote"  class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
				</cfdefaultcase>	
			</cfswitch>
		</cfif>
		<cfif arguments.exclude_fin eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=#url.dealercode#" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfdefaultcase>
				<cfcase value="14">	<!--- Baierl Budget Cars --->
					<a class="btn btn-grey" href="http://www.baierlkia.com/financing/application.htm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="369">	<!--- Front Range Auto --->
					<a class="btn btn-grey" href="http://#cgi.server_name#/finance/index.cfm" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="330"> <!--- Internet Auto Boise--->
					<a class="btn btn-grey" href="https://www.ecreditsecurity.com/companies/254/credit_apps/new" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="249"> <!--- Internet Auto Reno --->
					<a class="btn btn-grey" href="https://www.ecreditsecurity.com/companies/5027/credit_apps/new" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<!--- Fuccillo Group --->
				<cfcase value="167,85,86,87,168,88,181,171,76,303,89,73,179,373,375,169,180,172">	
					<a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=#url.dealercode#" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="30">  <!--- Ron Hibbard Toyota --->
					<!--- <a class="btn btn-grey" href="http://ronhibbardtoyota.com/dealer/ronhibbard/ron_hibbard_finance_application.cfm" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a> --->
				</cfcase>
				<cfcase value="62">
					<a class="btn btn-grey" href="http://www.dealertrack.com/consumerweb/default.asp?src_id=09081703385&dealerid=123452" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="83">  <!--- Pinegar Branson --->
					<a class="btn btn-grey" href="https://www.financeconnect.com/pinegar-branson/Embedded/App" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="68">  <!--- Henderson Mazda --->
					<a class="btn btn-grey" href="http://mazdahenderson.com/dealer/hendersonmazda/finance_application.cfm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="65">  <!--- Henderson Kia --->
					<a class="btn btn-grey" href="http://hendersonkia.com/dealer/hendersonkia/finance_application.cfm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="326">  <!--- Henderson Kia & Mazda --->
					<a class="btn btn-grey" href="http://hendersonkiamazda.com/dealer/hendersonauto/finance_application.cfm" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="80">  <!--- Pinegar Republic --->
					<a class="btn btn-grey" href="https://www.routeone.net/WAO/consumer.do?url=PinegarChevrolet&appType=Credit&partner=dealer" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="47">  <!--- Stoltz Coudersport --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0006-999-01-8142743224"  target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="42">  <!--- Stoltz Corporate --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0000-999-01-0000000000" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="43">  <!--- Stoltz Ford --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0002-999-01-814-781-10 " target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="46">  <!--- Stoltz Toyota --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0003-999-01-8143713333" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="45">  <!--- Stoltz Scion --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0004-999-01-8143713333 " target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="262">  <!--- Stoltz Used Value Center --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0007-999-01-C3685742F5" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="265">  <!--- Car Connection --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0082-0001-999-01-5138298022" target="_blank"><img alt="Finance Application"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Finance Application</a>
				</cfcase>
				<cfcase value="264">  <!--- Car Connection --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=0082-0002-999-01-430516841C" target="_blank"><img alt="Finance Application"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Finance Application</a>
				</cfcase>
				<cfcase value="1">  <!--- Baierl --->
					<a class="btn btn-grey" href="http://baierl.com/finance/index.cfm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="36,37,28,25">	<!--- Washington Auto Mall & subs --->	
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=#url.dealercode#"   target="_blank" <cfif url.dealer_id EQ 37> onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event52';tmsomni.linkTrackEvents = 'event52';tmsomni.prop6 = 'finance request';tmsomni.prop64 = 'finance'; tmsomni.tl(this, 'o', 'getpre');" </cfif> ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance2_off.png"/>Get Pre-Approved</a>
				</cfcase>	
				<cfcase value="252,259,200,258">	<!--- Murrays 03-21-2016 --->	
					<a class="btn btn-grey" href="/finance/privacy.cfm"  target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>	
			</cfswitch>
		</cfif>
		<cfif arguments.exclude_friend eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<a class="btn btn-grey" data-toggle="modal"   data-target="##friendModal" <cfif url.dealer_id EQ 37> onClick = "var s=s_gi('tdds-prod');s.linkTrackVars = 'prop6,prop66';tmsomni.events='event84';s.linkTrackEvents = 'event84';s.prop6 = 'Social Media';s.prop66 = 'email'; s.tl(true, 'o' ,'sendtofriend');" </cfif>><img alt="Send to a Friend"  class="btn-icon" src="#varibales.img_url#/icon_SM_SendtoFriend2_off.png"/>Send to a Friend</a>
				</cfcase>
				<cfdefaultcase>
					<a class="btn btn-grey" data-toggle="modal" data-target="##friendModal"><img alt="Send to a Friend"  class="btn-icon" src="#varibales.img_url#/icon_SM_SendtoFriend_off.png"/>Send to a Friend</a>
				</cfdefaultcase>	
			</cfswitch>
		</cfif>
		<cfif arguments.exclude_print eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings 02/2016 --->
						<a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=4&vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank">
					<cfelse>
						<a href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank">
					</cfif>
					<img alt="Print"  class="btn-icon" src="#varibales.img_url#/icon_SM_print_off.png"/>Print Vehicle</a>
				</cfdefaultcase>	
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings 02/2016 --->
						<a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=4&vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank">
					<cfelse>
							<a href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#"  class="btn  btn-grey" target="_blank">
					</cfif>		
					<img alt="Print"  class="btn-icon" src="#varibales.img_url#/icon_SM_print2_off.png"/>Print Vehicle</a>
				</cfcase>
			</cfswitch>
		</cfif>
	</cfif> <!--- end custom buttons test --->	
	</cffunction>

	<cffunction name="vdp_standard_new" description="shows default standard vdp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_fin" default="no">
		<cfargument name="exclude_friend" default="no">
		<cfargument name="exclude_print" default="no">
		<cfargument name="exclude_autocheck" default="no">


	 	<!--- Clicks Tracker --->
		<cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery><cfset click_tracker = #t_clik.track_clicks# >
		<!--- Clicks Tracker --->
		
	<!--- Check for Custom Buttons--->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		
		<cfquery datasource="ultra10" name="Get_Btns">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 2
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_vdp_btns = #Get_Btns.recordcount# >
	<!--- Check for Custom Buttons--->

		<cfswitch expression="#url.dealer_id#">
			<cfcase value="17,18,32,33,34,35">
				<!---Paul request 5/22/2014--->
				<cfset arguments.exclude_qq="yes">
			</cfcase>
		</cfswitch>
		
	 <cfswitch expression="#url.dealer_id#">
			<cfcase value="24,60,61,72,75,78,79,82,174,175,176,177,256,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,291,292,293,294,295,296,297,298,299,300,301,309,310">
				<!---Faulkner request 08/26/2015--->
				<cfset arguments.exclude_print="yes">
			</cfcase>
		</cfswitch>  

		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
	
	<cfif #variables.cust_btns# EQ 1 AND #variables.nbr_vdp_btns# GT 0 >
		<cfloop query="Get_Btns">
			<cfswitch expression="#Get_Btns.Btn_Link_Target#">
				<cfdefaultcase>
					<a class="btn btn-vdp-cust" href="#Get_Btns.Btn_Link#" >
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img  alt="#Get_Btns.Btn_Title#"class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfdefaultcase>	
				<cfcase value="Modal">
					<a class="btn btn-vdp-cust" data-toggle="modal"   data-target="###Get_Btns.modal_type#Modal">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 
						</cfif>
						<span align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>	
				<cfcase value="print">
					<a class="btn btn-vdp-cust" href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" target="_blank">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span  align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>	
				<cfcase value="new">
					<a class="btn btn-vdp-cust" href="#Get_Btns.Btn_Link#" target="_blank">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#"  class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span  align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>
			</cfswitch>
		</cfloop>		
				
	<cfelse>
	 
		<cfif #url.dealer_id# EQ 30>
			 <div class="page-div-lite"></div> 
			<a class="btn btn-red-cust" href="http://ronhibbardtoyota.com/dealer/ronhibbard/ron_hibbard_finance_application.cfm" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off_white.png"/>Get Financed</a>
		</cfif>

		<cfif arguments.exclude_fin eq "no">
			<cfswitch expression="#url.dealer_id#">
				
				<cfdefaultcase>
					<!--- <a class="btn btn-vdp-shopping-red" href="https://secure.worlddealer.net/finance.cfm?dealercode=#url.dealercode#" target="_blank">Get Pre-Approved</a> --->
					 <a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=#url.dealercode#" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>  
				</cfdefaultcase>
				
				
				<cfcase value="169"> <!--- Fuccillo Hyundai Grand Island--->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=0030-0004-999-01-7167737505" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="76"> <!--- Fuccillo Hyundai Greece (Rochester) 01-19-2015 --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=0018-0008-999-01-5857209000" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="30">  <!--- Ron Hibbard Toyota --->
					<!--- <a class="btn btn-grey" href="http://ronhibbardtoyota.com/dealer/ronhibbard/ron_hibbard_finance_application.cfm" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a> --->
				</cfcase>
				<cfcase value="62">
					<a class="btn btn-grey" href="http://www.dealertrack.com/consumerweb/default.asp?src_id=09081703385&dealerid=123452" target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="83">  <!--- Pinegar Branson --->
					<a class="btn btn-grey" href="https://www.financeconnect.com/pinegar-branson/Embedded/App" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="68">  <!--- Henderson Mazda --->
					<a class="btn btn-grey" href="http://mazdahenderson.com/dealer/hendersonmazda/finance_application.cfm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="65">  <!--- Henderson Kia --->
					<a class="btn btn-grey" href="http://hendersonkia.com/dealer/hendersonkia/finance_application.cfm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="326">  <!--- Henderson Kia & Mazda --->
					<a class="btn btn-grey" href="http://hendersonkiamazda.com/dealer/hendersonauto/finance_application.cfm" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="80">  <!--- Pinegar Republic --->
					<a class="btn btn-grey" href="https://www.routeone.net/WAO/consumer.do?url=PinegarChevrolet&appType=Credit&partner=dealer" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="180">  <!--- Fuccillo Kia Schenectady --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=0018-0034-999-01-5188470800" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
			<cfcase value="47">  <!--- Stoltz Coudersport --->
				<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0006-999-01-8142743224" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
			</cfcase>
			<cfcase value="42">  <!--- Stoltz Corporate --->
				<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0000-999-01-0000000000 " target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
			</cfcase>
			<cfcase value="43">  <!--- Stoltz Ford --->
				<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0002-999-01-814-781-10 " target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
			</cfcase>
			<cfcase value="45">  <!--- Stoltz Scion --->
				<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0004-999-01-8143713333" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
			</cfcase>
			<cfcase value="46">  <!--- Stoltz Toyota --->
				<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0058-0003-999-01-8143713333" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
			</cfcase>
			<cfcase value="262">  <!--- Stoltz Used Value Center --->
				<a class="btn btn-grey" href="http://#cgi.server_name#/finance/privacy.cfm " target="_blank"><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
			</cfcase>
				<cfcase value="265">  <!--- Car Connection --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0082-0001-999-01-5138298022" target="_blank"><img alt="Finance Application"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Finance Application</a>
				</cfcase>
				<cfcase value="264">  <!--- Car Connection --->
					<a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=0082-0002-999-01-430516841C" target="_blank"><img alt="Finance Application"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Finance Application</a>
				</cfcase>
				<cfcase value="1">  <!--- Baierl --->
					<a class="btn btn-grey" href="http://baierl.com/finance/index.cfm" target="_blank" ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png"/>Get Pre-Approved</a>
				</cfcase>
				<cfcase value="36,37,28,25">	<!--- Washington Auto Mall & subs --->	
					<a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=#url.dealercode#"   target="_blank" <cfif url.dealer_id EQ 37> onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event52';tmsomni.linkTrackEvents = 'event52';tmsomni.prop6 = 'finance request';tmsomni.prop64 = 'finance'; tmsomni.tl(this, 'o', 'getpre');" </cfif> ><img alt="Get Pre-Approved"  class="btn-icon" src="#varibales.img_url#/icon_SM_Finance2_off.png"/>Get Pre-Approved</a>
				</cfcase>	
			</cfswitch>
		</cfif>			 
		<cfif arguments.exclude_td eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfcase value="36,37,28,25">	<!--- Washington Auto Mall & subs --->	
					<a class="btn btn-grey " data-toggle="modal"   data-target="##tdModal" <cfif url.dealer_id EQ 37> onClick = "var s=s_gi('tdds-prod');s.linkTrackVars = 'prop6,prop64';s.linkTrackEvents = 'event54';s.prop6 = 'vehicle request';s.prop64 = 'vehicle'; s.tl(this, 'o');" </cfif>><img alt="Test Drive"  class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive2_off.png"/ >Schedule A Test Drive</a>
				</cfcase>	
				
				<cfdefaultcase>
					<!--- <a class="btn btn-vdp-shopping" data-toggle="modal" data-target="##tdModal">Schedule A Test Drive</a> --->
					  <a class="btn btn-grey" data-toggle="modal" data-target="##tdModal"><img alt="Test Drive"  class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png"/>Schedule A Test Drive</a> 
				</cfdefaultcase>	
				
			</cfswitch>
		</cfif>
		

		<cfif arguments.exclude_friend eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<a class="btn btn-grey" data-toggle="modal"   data-target="##friendModal" <cfif url.dealer_id EQ 37> onClick = "var s=s_gi('tdds-prod');s.linkTrackVars = 'prop6,prop66';tmsomni.events='event84';s.linkTrackEvents = 'event84';s.prop6 = 'Social Media';s.prop66 = 'email'; s.tl(true, 'o' ,'sendtofriend');" </cfif>><img alt="Send to a Friend"  class="btn-icon" src="#varibales.img_url#/icon_SM_SendtoFriend2_off.png"/>Send to a Friend</a>
				</cfcase>
				
				<cfdefaultcase>
					<!--- <a class="btn btn-vdp-shopping" data-toggle="modal" data-target="##friendModal">Send to a Friend</a> --->
					  <a class="btn btn-grey" data-toggle="modal" data-target="##friendModal"><img alt="Send to a Friend"  class="btn-icon" src="#varibales.img_url#/icon_SM_SendtoFriend_off.png"/>Send to a Friend</a>  
				</cfdefaultcase>	
				
			</cfswitch>
		</cfif>
		
		<cfif arguments.exclude_print eq "no">
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings 02/2016 --->
						<a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=4&vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank">
					<cfelse>
						<a href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank">
					</cfif>
					<img alt="Print"  class="btn-icon" src="#varibales.img_url#/icon_SM_print_off.png"/>Print Vehicle</a>
				</cfdefaultcase>	
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings 02/2016 --->
						<a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=4&vin=#arguments.VOI_Vin#" class="btn  btn-grey" target="_blank">
					<cfelse>
							<a href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#"  class="btn  btn-grey" target="_blank">
					</cfif>		
					<img alt="Print"  class="btn-icon" src="#varibales.img_url#/icon_SM_print2_off.png"/>Print Vehicle</a>
				</cfcase>
			</cfswitch>
		</cfif>
	</cfif> <!--- end custom buttons test --->	
	</cffunction>

	<cffunction name="srp_standard" description="shows default standard srp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->

		<cfargument name="VOI_Vin" required="true">
		<cfargument name="Permalink" default="">
		<cfargument name="V_Make" default="">
		<cfargument name="V_Model" default="">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_info" default="no">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_details" default="no">
		<cfargument name="New_Used" default="N">
		<cfargument name="Certified" default="0">

		
	<!--- Check for Custom Buttons--->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		<cfquery datasource="ultra10" name="Get_SRP_Btns">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 1
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_srp_btns = #Get_SRP_Btns.recordcount# >
	<!--- Check for Custom Buttons--->
		
	 	<!--- Clicks Tracker --->
		<cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfset click_tracker = #t_clik.track_clicks# >
		
		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#arguments.New_Used#">
			<cfdefaultcase>
				<cfset variables.itype="Used">
			</cfdefaultcase>
			<cfcase value="N">
				<cfset variables.itype="New">
			</cfcase>
		</cfswitch>
		<cfif arguments.Certified eq 1>
			<cfset variables.itype="Certified">
		</cfif>
		
		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
	
		
	<cfif #variables.cust_btns# EQ 1 AND #variables.nbr_srp_btns# GT 0 >
		
			<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
				<cfif #url.dealer_id# eq 78>
					<cfset arguments.Permalink = #REReplace(arguments.Permalink,"/","_","All")# >
				</cfif>   
				<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
			<cfelse>
				<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
			</cfif>
	 	 <cfloop query="Get_SRP_Btns">
		 
		 
		 	<cfif #Get_SRP_Btns.hierarchy# GTE #variables.nbr_srp_btns# >
				<cfset blnkcols = #Get_SRP_Btns.hierarchy# - #variables.nbr_srp_btns# >
				<cfloop index="b" from="1" to="#blnkcols#" >
					<div class="col-md-3 srp-btn visible-md visible-lg"></div>
				</cfloop>
			</cfif>
			<cfswitch expression="#Get_SRP_Btns.Btn_Link_Target#">
				<cfcase value="direct">
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-srp-cust" href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#" >
							<cfif #Get_SRP_Btns.Btn_Image# NEQ "" >
								<img alt="#Get_SRP_Btns.Btn_Title#"  class="btn-icon" src="#varibales.img_url#/#Get_SRP_Btns.Btn_Image#"/> 	
							</cfif>
							#Get_SRP_Btns.Btn_Title#
						</a>
					</div>
				</cfcase>	
				<cfcase value="modal">
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-srp-cust" data-toggle="modal" data-target="###arguments.VOI_Vin#Modal#RTrim(Get_SRP_Btns.modal_type)#" >
							<cfif #Get_SRP_Btns.Btn_Image# NEQ "" >
								<img alt="#Get_SRP_Btns.Btn_Title#"  class="btn-icon" src="#varibales.img_url#/#Get_SRP_Btns.Btn_Image#"/> 	
							</cfif>
							#Get_SRP_Btns.Btn_Title#
						</a>
					</div>
				</cfcase>	
				<cfcase value="new">
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-srp-cust" href="#Get_SRP_Btns.Btn_Link#" target="_blank">
							<cfif #Get_SRP_Btns.Btn_Image# NEQ "" >
								<img alt="#Get_SRP_Btns.Btn_Title#"  class="btn-icon" src="#varibales.img_url#/#Get_SRP_Btns.Btn_Image#"/> 	
							</cfif>
							#Get_SRP_Btns.Btn_Title#
						</a>
					</div>
				</cfcase>	
				<cfdefaultcase>
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-srp-cust" href="http://#cgi.server_name#/#Get_SRP_Btns.Btn_Link#">
							<cfif #Get_SRP_Btns.Btn_Image# NEQ "" >
								<img alt="#Get_SRP_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_SRP_Btns.Btn_Image#"/> 	
							</cfif>
							#Get_SRP_Btns.Btn_Title#
						</a>
					</div>
				</cfdefaultcase>	
			</cfswitch>	
		</cfloop>		
  			
	<cfelse>  
	

	
		
		<cfif arguments.exclude_qq eq "no">
			<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
				<cfif #url.dealer_id# eq 78>
					<cfset arguments.Permalink = #REReplace(arguments.Permalink,"/","_","All")# >
				</cfif>   
				<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
			<cfelse>
				<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
			</cfif>
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey" data-toggle="modal" data-target="###arguments.VOI_Vin#Modalqq"><img  alt="Get a Quote" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get a Quote</a>
					</div>
				</cfdefaultcase>
				<cfcase value="17,18,32,34,35">
					<!---Paul request 5/22/2014--->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey-cust" data-toggle="modal" data-target="###arguments.VOI_Vin#Modalqq"><img alt="Check for More Savings" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Check for More Savings</a>
					</div>
				</cfcase>
				<cfcase value="82">		<!--- Faulkner Mazda --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey" data-toggle="modal" data-target="###arguments.VOI_Vin#Modalqq"><img alt="Get Faulkner Price" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get Faulkner Price</a>
					</div>
				</cfcase>
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-yellow" data-toggle="modal"  data-target="###arguments.VOI_Vin#Modalqq"><img alt="Check Availability" class="btn-icon" src="#varibales.img_url#/icon_VDP_Placeholder.png"/>Check Availabilty</a>
					</div>
				</cfcase>	
				<cfcase value="30">		<!--- Ron Hibbard --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						&nbsp;
					</div>
				</cfcase>	
				 
				<cfcase value="33,236">	<!--- Kelly Ford Kelly CJDR  --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey" 
							 onClick="document.location='http://#cgi.server_name#/vehicles/#variables.v_link###section1_ID';" title="#arguments.V_Make# #arguments.V_Model#"><img alt="Get My Payment" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get My Payment</a>
					</div>
				</cfcase>	 
				
				<cfcase value="79">		<!--- Faulkner --->
					<div class="col-md-3 srp-btn  visible-md visible-lg">
						 <a class="btn btn-grey-cust" href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#" ><img alt="View Details" class="btn-icon" src="#varibales.img_url#/icon_SM_Details_off.png"/>View Details</a>
					</div>
				</cfcase>	
				
				<cfcase value="38">		<!--- Washington Scion --->
					<div class="col-md-3 srp-btn  visible-md visible-lg">
						 <a class="btn btn-grey"  href="http://#cgi.server_name#/forms/trade.cfm"  ><img alt="Value Your Trade" class="btn-icon" src="#varibales.img_url#/icon_SM_getquote_off.png"/>Value Your Trade</a>
					</div>
				</cfcase>	
				
				<cfcase value="179">		<!--- Fuccillo Scion --->
					<div class="col-md-3 srp-btn  visible-md visible-lg">
						 <a class="btn btn-grey"  href="http://#cgi.server_name#/forms/trade.cfm"  ><img alt="Value Your Trade" class="btn-icon" src="#varibales.img_url#/icon_SM_getquote_off.png"/>Value Your Trade</a>
					</div>
				</cfcase>	
				<cfcase value="45">		<!--- Stoltz Scion --->
					<div class="col-md-3 srp-btn  visible-md visible-lg">
						 <a class="btn btn-grey"  href="http://#cgi.server_name#/forms/trade.cfm"  ><img alt="Value Your Trade" class="btn-icon" src="#varibales.img_url#/icon_SM_getquote_off.png"/>Value Your Trade</a>
					</div>
				</cfcase>	
				

			</cfswitch>
		</cfif>
		<cfif arguments.exclude_info eq "no">
		
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey" data-toggle="modal" data-target="###arguments.VOI_Vin#Modalrfq"><img alt="Request Info" class="btn-icon" src="#varibales.img_url#/icon_SM_Info_off.png"/>Request Info</a>
					</div>
				</cfdefaultcase>
				<cfcase value="233,338,365"></cfcase>
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<div class="col-md-3 srp-btn visible-md visible-lg"   >
						<a class="btn btn-grey" data-toggle="modal"   data-target="###arguments.VOI_Vin#Modaltd"><img alt="Test Drive" class="btn-icon" src="#varibales.img_url#/icon_VDP_Placeholder.png"/>Schedule Test Drive</a>
					</div>
				</cfcase>	
				<cfcase value="79">		<!--- Faulkner Nissan --->
					<div class="col-md-3 srp-btn visible-md visible-lg"   >
						<a class="btn btn-grey-cust" data-toggle="modal"   data-target="###arguments.VOI_Vin#Modalrfq"><img alt="Request Info" class="btn-icon" src="#varibales.img_url#/icon_SM_Info_off.png"/>Request Info</a>
					</div>
				</cfcase>	
				<cfcase value="1">		<!--- Baierl --->
					<div class="col-md-3 srp-btn  visible-md visible-lg">
						 <a class="btn btn-grey"  href="http://#cgi.server_name#/dealer/baierl/value_your_trade.cfm"  ><img alt="Value Your Trade" class="btn-icon" src="#varibales.img_url#/icon_SM_getquote_off.png"/>Value Your Trade</a>
					</div>
				</cfcase>	
				
				<cfcase value="30">		<!--- Ron Hibbard --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						&nbsp;
					</div>
				</cfcase>	
			</cfswitch>
		</cfif>
		<cfif arguments.exclude_td eq "no">
		
			<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
				<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
			<cfelse>
				<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
			</cfif>
			
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey" data-toggle="modal" data-target="###arguments.VOI_Vin#Modaltd"><img alt="Test Drive" class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png"/>Test Drive</a>
					</div>
				</cfdefaultcase>
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<div class="col-md-3 srp-btn">
						<a class="btn btn-grey"  href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#"><img alt="Vehicle Details" class="btn-icon" src="#varibales.img_url#/icon_VDP_Placeholder.png"/>Vehicle Details</a>
					</div>
				</cfcase>	
				<cfcase value="79">		<!--- Faulkner Nissan Jenkintown --->
					<div class="col-md-3 srp-btn">
						<a class="btn btn-grey-cust"  href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#"><img alt="Test Drive" class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png"/>Test Drive</a>
					</div>
				</cfcase>	
				<cfcase value="30">		<!--- Ron Hibbard --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						&nbsp;
					</div>
				</cfcase>	
			</cfswitch>
					
		</cfif>
		<cfif arguments.exclude_details eq "no">
			<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
				<cfif #url.dealer_id# eq 78>
					<cfset arguments.Permalink = #REReplace(arguments.Permalink,"/","_","All")# >
				</cfif>   
				<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
			<cfelse>
				<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
			</cfif>
			<cfswitch expression="#url.dealer_id#">
				<cfdefaultcase>
					<div class="col-md-3 srp-btn">
			<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings --->
				<a class="btn btn-grey" href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=2&vin=#arguments.VOI_Vin#&v_link=#variables.v_link#&itype=#variables.itype#"><img alt="Vehicle Details" class="btn-icon" src="#varibales.img_url#/icon_SM_Details_off.png"/>Vehicle Details</a>
			<cfelse>
				<a class="btn btn-grey" href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#"><img alt="Vehicle Details" class="btn-icon" src="#varibales.img_url#/icon_SM_Details_off.png"/>Vehicle Details</a>
			</cfif>
					</div>
				</cfdefaultcase> 
				<cfcase value="30">		<!--- Ron Hibbard --->
					<div class="col-md-3 srp-btn  visible-md visible-lg">
						 <a class="btn btn-green-srp" href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#" >SEE VEHICLE DETAILS</a>
					</div>
				</cfcase>	
				<cfcase value="79">		<!--- Faulkner Nissan Jenkintown --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-grey-cust" data-toggle="modal" data-target="###arguments.VOI_Vin#Modaladddetl"><img alt="Additional Savings" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png"/>Get Additional Savings</a>						
					</div>
				</cfcase>	
				<cfcase value="36,37,28,25">		<!--- Washington Auto Mall & subs --->
					<div class="col-md-3 srp-btn visible-md visible-lg">
						<a class="btn btn-green-srp" data-toggle="modal" data-target="###arguments.VOI_Vin#Modaleprc2"><img  alt="Get e-Price" class="btn-icon"  src="#varibales.img_url#/icon_VDP_Placeholder.png"/>&nbsp;&nbsp;&nbsp;&nbsp;Get e-Price</a>						
					</div>
				</cfcase>	  
			</cfswitch>
		</cfif>
</cfif> <!--- End of Custom Buttons --->

	</cffunction>

	
	
	
	
	
	<cffunction name="srp_legacy" description="shows default standard srp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->

		<cfargument name="VOI_Vin" required="true">
		<cfargument name="Permalink" default="">
		<cfargument name="V_Make" default="">
		<cfargument name="V_Model" default="">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_info" default="no">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_details" default="no">
		<cfargument name="New_Used" default="N">
		<cfargument name="Certified" default="0">

		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#arguments.New_Used#">
			<cfdefaultcase>
				<cfset variables.itype="Used">
			</cfdefaultcase>
			<cfcase value="N">
				<cfset variables.itype="New">
			</cfcase>
		</cfswitch>
		<cfif arguments.Certified eq 1>
			<cfset variables.itype="Certified">
		</cfif>
		
		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
		
		<table style="width:100%">
			<tr>
				<cfif arguments.exclude_qq eq "no">
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/quote_pop.cfm?vin=#arguments.VOI_Vin#','qqWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
							<img alt="Get a Quote"  style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png" border="0"/>
							<cfswitch expression="#url.dealer_id#">
								<cfdefaultcase>
									<span style="display:block;float:left;padding:9px 0px 0px 0px;">Get a Quote</span>
								</cfdefaultcase>
								<cfcase value="17,18,32,33,34,35">
									<span style="display:block;float:left;padding:9px 0px 0px 0px;">Check for More Savings</span>
								</cfcase>
							</cfswitch>
							<div style="clear:both"></div>
						</a>
					</td>
				</cfif>
				<cfif arguments.exclude_info eq "no">
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/quote_pop.cfm?vin=#arguments.VOI_Vin#&title=Request Info about','qqWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
							<img  alt="Request Info" style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_Info_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Request Info</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</cfif>
				<cfif arguments.exclude_td eq "no">
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/td_pop.cfm?vin=#arguments.VOI_Vin#','tdWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
							<img  alt="Test Drive"  style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Schedule A Test Drive</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</cfif>
				<cfif arguments.exclude_details eq "no">
					<td style="width:25%" valign="top">
						<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
							<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
						<cfelse>
							<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
						</cfif>
						<a style="display:block" class="btn btn-grey" href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#">
							<img  alt="Vehicle Details" style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_Details_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Vehicle Details</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</cfif>
			</tr>
		</table>
	
	</cffunction>

	<cffunction name="vdp_legacy" description="shows default standard vdp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="exclude_td" default="no">
		<cfargument name="exclude_qq" default="no">
		<cfargument name="exclude_fin" default="no">
		<cfargument name="exclude_friend" default="no">
		<cfargument name="exclude_print" default="no">

		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">

		<cfswitch expression="#url.dealer_id#">
			<cfcase value="17,18,32,33,34,35">
				<!---Paul request 5/22/2014--->
				<cfset arguments.exclude_qq="yes">
			</cfcase>
		</cfswitch>
	
		<table style="width:100%">

			<cfif arguments.exclude_td eq "no">
				<tr>
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/td_pop.cfm?vin=#arguments.VOI_Vin#','tdWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
							<img alt="Test Drive"  style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_testdrive_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Schedule A Test Drive</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</tr>
			</cfif>

			<cfif arguments.exclude_qq eq "no">
				<tr>
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/quote_pop.cfm?vin=#arguments.VOI_Vin#','qqWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
							<img alt="Quote"  style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_GetQuote_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Get a Quote</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</tr>
			</cfif>

			<cfif arguments.exclude_fin eq "no">
				<cfswitch expression="#url.dealer_id#">
					<cfdefaultcase>
						<tr>
							<td style="width:25%" valign="top">
								<a style="display:block" href="https://secure.worlddealer.net/finance.cfm?dealercode=#url.dealercode#" target="_blank" class="btn btn-grey">
									<img alt="Finance"  style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png" border="0"/>
									<span style="display:block;float:left;padding:9px 0px 0px 0px;">Get Pre-Approved</span>
									<div style="clear:both"></div>
								</a>
							</td>
						</tr>
					</cfdefaultcase>
					<cfcase value="70">
						<tr>
							<td style="width:25%" valign="top">
								<a style="display:block" href="https://extranet.dealercentric.com/app-templates/LoanApplication/QuickApplication.aspx?AssociateID=1260&AssociateTypeID=4000&htm=1&vid=stop" target="_blank" class="btn btn-grey">
									<img alt="Finance" style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_Finance_off.png" border="0"/>
									<span style="display:block;float:left;padding:9px 0px 0px 0px;">Get Pre-Approved</span>
									<div style="clear:both"></div>
								</a>
							</td>
						</tr>
					</cfcase>
				</cfswitch>
			</cfif>

			<!---<cfif arguments.exclude_friend eq "no">
				<tr>
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey">
							<img style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_SendtoFriend_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Send to a Friend</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</tr>
			</cfif>--->

			<cfif arguments.exclude_print eq "no">
				<tr>
					<td style="width:25%" valign="top">
						<a style="display:block" class="btn btn-grey" href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" target="_blank">
							<img alt="Print" style="display:block;float:left" class="btn-icon" src="#varibales.img_url#/icon_SM_print_off.png" border="0"/>
							<span style="display:block;float:left;padding:9px 0px 0px 0px;">Print Vehicle</span>
							<div style="clear:both"></div>
						</a>
					</td>
				</tr>
			</cfif>

		</table>

	</cffunction>


	<cffunction name="srp_new" description="shows default standard srp buttons & functionality" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="VOI_Vin" required="true">
		<cfargument name="Dealer_ID" required="true">
		<cfargument name="exclude_td" default="yes">
		<cfargument name="exclude_qq" default="yes">
		<cfargument name="exclude_fin" default="yes">
		<cfargument name="exclude_friend" default="yes">
		<cfargument name="exclude_print" default="yes">
		<cfargument name="exclude_autocheck" default="yes">


	<!--- Check for Custom Buttons--->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		
		<cfquery datasource="ultra10" name="Get_Btns">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 2
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_vdp_btns = #Get_Btns.recordcount# >
	<!--- Check for Custom Buttons--->

		<cfset varibales.img_url="http://#cgi.server_name#/images/inventory">
	
	<cfif #variables.cust_btns# EQ 1 AND #variables.nbr_vdp_btns# GT 0 >
		<cfloop query="Get_Btns">
			<cfswitch expression="#Get_Btns.Btn_Link_Target#">
				<cfdefaultcase>
					<a class="btn btn-vdp-cust" href="#Get_Btns.Btn_Link#" >
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img  alt="#Get_Btns.Btn_Title#"class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfdefaultcase>	
				<cfcase value="Modal">
					<a class="btn btn-vdp-cust" data-toggle="modal"   data-target="###Get_Btns.modal_type#Modal">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 
						</cfif>
						<span align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>	
				<cfcase value="print">
					<a class="btn btn-vdp-cust" href="http://#cgi.server_name#/vehicles/print_vehicle.cfm?Vin=#arguments.VOI_Vin#" target="_blank">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#" class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span  align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>	
				<cfcase value="new">
					<a class="btn btn-vdp-cust" href="#Get_Btns.Btn_Link#" target="_blank">
						<cfif #Get_Btns.Btn_Image# NEQ "" >
							<img alt="#Get_Btns.Btn_Title#"  class="btn-icon" src="#varibales.img_url#/#Get_Btns.Btn_Image#"/> 	
						</cfif>
						<span  align="center">#Get_Btns.Btn_Title#</span>
					</a>
				</cfcase>
			</cfswitch>
		</cfloop>		
				
	<cfelse>
	

		<cfswitch expression="#url.dealer_id#">
			<cfdefaultcase>
				<a class="btn srp-btn2"	href="##" cursor="hand" data-toggle="modal" data-target="###arguments.VOI_Vin#Modalqq">GET E-PRICE</a>
			</cfdefaultcase>	
		</cfswitch>
        
		<cfswitch expression="#url.dealer_id#">
			<cfdefaultcase>
				<a class="btn srp-btn1" href="http://#cgi.server_name#/vehicles/#arguments.v_link#" title="View Details">VIEW DETAILS</a>
			</cfdefaultcase>	
		</cfswitch>
        

	</cfif> <!--- end custom buttons test --->	
</cffunction>

	
	
	
	
</cfcomponent>