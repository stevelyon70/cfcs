
<cfcomponent>


	<cffunction name="modern" description="WorldDealer Form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
		<section class="section-spl">
			<div class="container">
			 	<div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Header --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/autoviewlogo.png" border="0" class="img-responsive"> 
					</div>
				</div> 
				<div class="row"><div class="col-md-12">&nbsp;</div></div>
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container">
				<cfif NOT IsDefined("url.thanks") >
					<div class="row" >
						<cfset main_image = "ResponsiveExamples.png" >
						<cfset site_addr = "rwd.worlddealer.net" >
						<div class="col-md-12 no-pad" align="center">	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/#main_image#" border="0" class="img-responsive"> 
						</div>
					</div>
					<div class="row">
						<div class="row">
							<div class="col-md-12" align="center" style="color:##231f20 ;font-family: Helvetica, Arial, sans-serif;font-size:12pt" >	<!--- Body Text --->
							  		<h3><i><b>Are You Using Yesterday's Technology to Reach Today's Shopper?</b></i></h3>
									We can provide you with a Responsive Website in as little as 30 days. Learn how you can<br>
									increase your mobile traffic instantly; call us at 866.485.8800 and ask for Dan Ferguson, or<br>
									complete the contact form below.
							</div>
						</div>
					</div>
	
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					<div class="row" >
						<div class="col-md-4 no-pad"></div>
						<div class="col-md-4 no-pad">
							<div class="row">
								<div class="col-md-12 no-pad" align="center">	<!--- Info Request Form --->
									<div class="srch-tabs" align="center">
										Want to know more?
									</div>
									<cfinvoke component="/cfcs/forms/form_qq_micro" method="qq_micro_rwd">
										<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
										<cfinvokeargument name="VOI_Vin" value=""/>
										<cfinvokeargument name="VOI_New_Used" value=""/>
										<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
										<cfinvokeargument name="form_action" value="http://#cgi.server_name#/dealer/#variables.dlr_dir#/micro_rwd_action.cfm"/>
									</cfinvoke>  
								</div>
							</div>
						</div>
						<div class="col-md-4 no-pad"></div>
					</div>
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive"> --->
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
					 <div class="row">
						<div class="col-md-12 no-pad visible-md visible-lg" align="center">
							<a href="http://#CGI.server_name#/dealer/#variables.dlr_dir#/control/"  >Administrator</a>
						</div>
					</div>	  
			<cfelse>
					<div class="row">
						<div class="col-md-12 no-pad" align="center" >
						</div>
					</div>
					<div class="row" >
						<cfset main_image = "ResponsiveExamples.png" >
						<cfset site_addr = "rwd.worlddealer.net" >
						<div class="col-md-12 no-pad" align="center">	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/#main_image#" border="0" class="img-responsive"> 
						</div>
					</div>
					 <div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
					<div class="row">
						<div class="row">
							<div class="col-md-12" align="center" style="font-family: Helvetica, Arial, sans-serif;font-size:12pt" >	<!--- Body Text --->
								<span style="font-size:26pt;font-weight:bold" ><i>Thanks!</i></span>
								<br>
								<span style="font-size:20pt;font-weight:bold" >We'll be in touch soon.</span>
							</div>
						</div>
					</div>
	
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive"> --->
						</div>
					</div> 
					<cfloop index="x" from="1" to="8">
						 <div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
					</cfloop>
					 <div class="row">
						<div class="col-md-12 no-pad visible-md visible-lg" align="center">
							<a href="http://#CGI.server_name#/dealer/#variables.dlr_dir#/control/"  >Administrator</a>
						</div>
					</div>	  
	
				</cfif>	
			</div>  <!--- container --->
		</section>

	</cffunction>

	<cffunction name="modernregthankyou" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
		<section class="section-spl">
			<div class="container">
				
				 <div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Nav Bar --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_nav.png" border="0" class="img-responsive">
					</div>
				</div> 
				<div class="row">
					<div class="col-md-6 no-pad" align="center">					<!--- Screen Images --->								 
						<cfif #arguments.dealer_id# EQ 196 >
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tobykeithmain2.png" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 197 > 
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/PITT_StuckeyCruiseSweeps5-sm.png" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 199 >  
							<div class="row">
								<div class="col-md-12 no-pad">	&nbsp;	</div>
							</div>	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/contestgraphic_main.jpg" border="0" class="img-responsive"> 
						<cfelse>
							&nbsp;	   
						</cfif>
					</div> 
					<div class="col-md-6 no-pad">
						<div class="row">
							<div class="msg-thank-you" align="center">
								<h3>Thank You For Your Registration and Good Luck!</h3>
						</div>
						</div>
						<div class="row">
							<div class="col-md-12 no-pad" align="center">	
								<h3>Click a logo to visit one of our 3 stores for this month's great money saving offers!<h3>
							</div>
						</div>
						<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						<div class="row">
							<div class="col-md-4 no-pad" align="center">	
								<a href="http://fuccillotoyota.com" >
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_fuccillotoyota_location.png" alt="Fuccillo Toyota"  border="0" class="img-responsive"></a>
							</div>
							<div class="col-md-4 no-pad" align="center">	
								<a href="http://fuccillochevrolet.com" >
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_fuccillochevy_location.png" alt="Fuccillo Chevrolet" border="0" class="img-responsive"></a>
							</div>
							<div class="col-md-4 no-pad" align="center">	
								<a href="http://www.hyundaigrandisland.com" >
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_fuccillohyundai_location.png" alt="Fuccillo Hyundai"  border="0" class="img-responsive"></a>
							</div>
						</div>
					</div>
				</div>
				 <div class="row">
					<div class="col-md-12 no-pad">	&nbsp;
					</div>
				</div>	
				<cfif #url.dealer_id# EQ 199 >
					 <div class="row">
						<div class="col-md-3 no-pad"></div>
						<div class="col-md-6 no-pad" style="font-size:14pt;font-weight:bold">
							Enter for your chance to win a 60" LG® Plasma HDTV!
						</div>
						<div class="col-md-3 no-pad"></div>
					</div>	
					 <div class="row">
						<div class="col-md-2 no-pad"></div>
						<div class="col-md-8 no-pad">
							No purchase, payment or donation is necessary to enter and win. A purchase will not improve your chances of winning. Must be a legal U.S. resident, 18 years or older with a currently valid driver's license to enter and win. Only one registration form via online or in person, per family, per visit will be permitted.  The odds of winning are dependent on the number of entries.  One (1) winner will be randomly selected starting at approximately 7:00 PM on July 31, 2014 at Fuccillo Toyota of Grand Island, 1974 Alvin Road, Grand Island NY 14072 to receive a 60" LG®  Plasma HDTV.  You need not be present to win.  Contest runs July 24, 2014 through July 31, 2014.  See dealership for details and complete Contest Rules.  Void where prohibited.  Winner responsible for payment of all Federal, State and Local taxes applicable to winning the Grand Prize.
						</div>
						<div class="col-md-2 no-pad">&nbsp;</div>
					</div>	
 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
					<div class="row">
						<div class="col-md-12 no-pad" align="center">
							<a href="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/pdfs/FuccilloGrandIsland JulyTVContestRules.pdf" target="_blank" >Complete Contest Rules</a>
						</div>
					</div>	  
 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
				
				
				</cfif>
				
				
				 <div class="row">
					<div class="col-md-12 no-pad">								<!--- Footer --->
						<cfif #arguments.dealer_id# EQ 196 >
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/banner_SuperCoolSummerSale.jpg" border="0" class="img-responsive">
						<cfelse>
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive">
						</cfif>
					</div>
				</div> 
				 <div class="row">
					<div class="col-md-12 no-pad">	&nbsp;
					</div>
				</div>	 
				 <div class="row">
					<div class="col-md-12 no-pad" align="center">
						<a href="http://#CGI.server_name#/dealer/#variables.dlr_dir#/control/"  >Administrator</a>
						<!--- <a href="http://ultra10.wddemos.com/dealer/#variables.dlr_dir#/control/"  >Administrator</a> --->
					</div>
				</div>	  
				
			</div>
		</section>

	</cffunction>

	<cffunction name="modernbaierlregthankyou" description="shows a Baierl Thanks Page" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		
		<section class="section-spl">
			<div class="container">
				
				 <div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Nav Bar --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_nav.png" border="0" class="img-responsive">
					</div>
				</div> 
				<div class="row">
					<div class="col-md-6 no-pad" align="center">					<!--- Screen Images --->								 
						<cfif #arguments.dealer_id# EQ 196 >
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tobykeithmain2.png" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 197 > 
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/PITT_StuckeyCruiseSweeps5-sm.png" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 203 >  
							<div class="row">
								<div class="col-md-12 no-pad">	&nbsp;	</div>
							</div>	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/contestgraphic_main.jpg" border="0" class="img-responsive"> 
						<cfelseif #arguments.dealer_id# EQ 199 >  
							<div class="row">
								<div class="col-md-12 no-pad">	&nbsp;	</div>
							</div>	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/contestgraphic_main.jpg" border="0" class="img-responsive"> 
						<cfelse>
							&nbsp;	   
						</cfif>
					</div> 
					<div class="col-md-6 no-pad">
						<div class="row">
							<div class="msg-thank-you" align="center">
								<h3>Thank You For Your Registration and Good Luck!</h3><br>
								<h2>Watch Your Email for Valuable Coupons!</h2>
						</div>
					</div>
						<!--- <div class="row">
							<div class="col-md-12 no-pad" align="center">	
								<h3>Click a logo to visit one of our 3 stores for this month's great money saving offers!<h3>
							</div>
						</div>
						<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						<div class="row">
							<div class="col-md-4 no-pad" align="center">	
								<a href="http://fuccillotoyota.com" >
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_fuccillotoyota_location.png" alt="Fuccillo Toyota"  border="0" class="img-responsive"></a>
							</div>
							<div class="col-md-4 no-pad" align="center">	
								<a href="http://fuccillochevrolet.com" >
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_fuccillochevy_location.png" alt="Fuccillo Chevrolet" border="0" class="img-responsive"></a>
							</div>
							<div class="col-md-4 no-pad" align="center">	
								<a href="http://www.hyundaigrandisland.com" >
								<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/logo_fuccillohyundai_location.png" alt="Fuccillo Hyundai"  border="0" class="img-responsive"></a>
							</div>
						</div> --->
					</div>
				</div>
				 <div class="row">
					<div class="col-md-12 no-pad">	&nbsp;
					</div>
				</div>	
				<cfif #url.dealer_id# EQ 203 >
					 <div class="row">
						<div class="col-md-3 no-pad"></div>
						<div class="col-md-6 no-pad" style="font-size:14pt;font-weight:bold">
							Enter for your chance to win a Subaru Outback!
						</div>
						<div class="col-md-3 no-pad"></div>
					</div>	
					 <div class="row">
						<div class="col-md-2 no-pad"></div>
						<div class="col-md-8 no-pad">
							No purchase necessary to enter or win. A purchase will not improve your chances of winning. Must be a legal, Pennsylvania resident, 18 years or older with a current valid driver's license to enter and win.  Only one entry method, per person permitted. Odds of winning are dependent on the number of entries. See dealership for details and complete Contest Rules. Void where prohibited. Winner responsible for payment of all Federal, State and Local taxes applicable to winning the Grand Prize.
						</div>
						<div class="col-md-2 no-pad">&nbsp;</div>
					</div>	
 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
					<div class="row">
						<div class="col-md-12 no-pad" align="center">
							<a href="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/pdfs/CONTESTRULES.pdf" target="_blank" >Complete Contest Rules</a>
						</div>
					</div>	  
 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
				
				
				</cfif>
				
				
				 <div class="row">
					<div class="col-md-12 no-pad">							<!--- Footer --->
						<cfif #arguments.dealer_id# EQ 196 >
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/banner_SuperCoolSummerSale.jpg" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 203 >
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_nav.png" border="0" class="img-responsive">
						<cfelse>
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.jpg" border="0" class="img-responsive">
						</cfif>
					</div>
				</div> 
				 <div class="row">
					<div class="col-md-12 no-pad">	&nbsp;
					</div>
				</div>	 
				 <div class="row">
					<div class="col-md-12 no-pad" align="center">
						<a href="http://#CGI.server_name#/dealer/#variables.dlr_dir#/control/"  >Administrator</a>
						<!--- <a href="http://ultra10.wddemos.com/dealer/#variables.dlr_dir#/control/"  >Administrator</a> --->
					</div>
				</div>	  
				
			</div>
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<table style="width:100%" cellpadding="0" cellspacing="0">
					<cfif IsDefined("url.thanks") >
						<tr>
							<td  colspan="2" valign="top">
								<span style="font-size:20pt;font-weight:bold" ><i>Thanks!</i> We'll be in touch soon!</span>
							</td>
						</tr>	
					</cfif>
					<tr>
						<td colspan="2" valign="top">			<!--- Nav Bar --->
							<img src="http://dealers.wdautos.com/dealer/bobscars/images/icons/WDMicro_nav.png" border="0" class="img-responsive">
						</td>
					</tr>
					<tr>
						<td  width="55%"> 				<!--- Body Text --->
							<img src="http://dealers.wdautos.com/dealer/bobscars/images/icons/body_text.png" border="0" class="img-responsive">
						</td>
						<td  width="55%"> 			<!--- Screen Images --->
							<img src="http://dealers.wdautos.com/dealer/bobscars/images/icons/lower_left.png" border="0" class="img-responsive">
						</td>
					</tr>
				</table>
			</div>			
		</div>

	</cffunction>

</cfcomponent>