
<cfcomponent>


	<cffunction name="modern" description="WorldDealer Form" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
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
				<cfif IsDefined("url.thanks") >
					<div class="row">
						<div class="col-md-12 no-pad" align="center" >
							<span style="font-size:20pt;font-weight:bold" ><i>Thanks!</i> We'll be in touch soon!</span>
						</div>
					</div>
				</cfif>
				<div class="row"><div class="col-md-12">&nbsp;</div></div>
				 <div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Nav Bar --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_nav.png" border="0" class="img-responsive">
					</div>
				</div> 
				<div class="row" >
					<cfif #url.dealer_id# eq 198 > 
						<cfset main_image = "platforms.png" >
						<cfset site_addr = "rwd.worlddealer.net" >
					<cfelse>
						<cfset main_image = "platforms.jpg" >
						<cfset site_addr = "toyota.worlddealer.net" >
					</cfif>
							
					<div class="col-md-8 padding-left 5px" align="center">	
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/#main_image#" border="0" class="img-responsive"> 
							
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-md-11" align="left" style="font-family: Helvetica, Arial, sans-serif;font-size:12pt" >	<!--- Body Text --->
									<p>From top 100 dealer groups to small independent dealers, <strong>WorldDealer</strong> search engine friendly and OEM compliant websites are the most <strong>flexible and cost effective</strong> websites in the industry and are fully supported by world class service.</p>
	
							  		<p>Internet traffic originating from mobile devices is rising exponentially each day. As more and more people get used to browsing the web through their smartphones and tablets, it's important to provide a <strong>seamless user experience. </strong></p>
							  		<p>Our <strong><span style="color: ##4161ae;">Responsive Web Design (RWD) platform</span></strong> allows us to craft sites which provide an optimal viewing experience - easy reading and navigation with a minimum of resizing, panning, and scrolling - across a wide range of devices (from mobile phones to desktop computer monitors). </p>
	  
							  		<h3>Benefits of Responsive Design</h3>
								  		<ul>
									  		<cfif #url.dealer_id# eq 133 ><li>Toyota Digital Dealer Solutions (TDDS) Preferred Provider with fully Toyota compliant designs</li></cfif>
											<li>Seamless user experience across multiple devices</li>
									  		<li>A site that is designed to convert on the ever-growing mobile demographic</li>
									  		<li>Easier site management - one site, one URL, all platforms</li>
									  		<li>Unified Search Engine Optimization strategy preferred by Google</li>
								  		</ul>
							</div>
						</div>
					</div>
					<div class="col-md-4 no-pad">
						<div class="row">
							<div class="vdp-form-mobile" align="center">	<!--- Info Request Form --->
								<div class="vdp-form-title" align="center" style="background-color:##4161ae; color: ##ffffff; padding:5px 5px 5px 5px">
									<h3 style="font-family: Helvetica, Arial, sans-serif" align="center">Want to know more?</h3><br>Fill out this form for more information on a responsive website strategy with WorldDealer.
								</div>
								<cfinvoke component="/cfcs/forms/form_qq_micro" method="qq_micro">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/dealer/#variables.dlr_dir#/micro_qq_action.cfm"/>
								</cfinvoke>  
							</div>
						</div>
					</div>
				</div>
				<div class="row"><div class="col-md-12">&nbsp;</div></div>
				<cfif #url.dealer_id# eq 198 >
					<div class="row">
						<div class="col-md-12 no-pad " align="left">		
							<h3>Examples</h3>
						</div>
					</div> 
					<div class="row">
						<div class="col-md-2 no-pad" align="center">		
							<a href="##openModal" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tn_PittsburghAutoSuperstore.jpg"   ></a>
							<div id="openModal" class="modalDialog img-responsive">
								<div class="img-responsive">
									<a href="##close" title="Close" class="close">X</a>
									<img class="img-responsive"  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/full_PittsburghAutoSuperstore.jpg"   >
								</div>
							</div>
						</div>
						<div class="col-md-2 no-pad" align="center">		
							<a href="##openModala" ><img  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tn_StuckeyForYou.jpg"   ></a>
							<div id="openModala" class="modalDialog img-responsive">
								<div class="img-responsive">
									<a href="##close" title="Close" class="close">X</a>
									<img class="img-responsive"  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/full_StuckeyForYou.jpg"   >
								</div>
							</div>
						</div>
						<div class="col-md-2 no-pad" align="center">		
							<a href="##openModalb" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tn_KAGCorp.jpg"   ></a>
							<div id="openModalb" class="modalDialog img-responsive">
								<div class="img-responsive">
									<a href="##close" title="Close" class="close">X</a>
									<img class="img-responsive"   src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/full_KAGCorp.jpg"   >
								</div>
							</div>	
						</div>
						<div class="col-md-2 no-pad" align="center">		
							<a href="##openModalc" ><img  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tn_KAGNissan.jpg"   ></a>
							<div id="openModalc" class="modalDialog img-responsive">
								<div class="img-responsive">
									<a href="##close" title="Close" class="close">X</a>
									<img class="img-responsive"  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/full_KAGNissan.jpg"   >
								</div>
							</div>		
						</div>
						<div class="col-md-2 no-pad" align="center">		
							<a href="##openModald" ><img  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tn_FindlayToyota.jpg"   ></a>
							<div id="openModald" class="modalDialog img-responsive">
								<div class="img-responsive">
									<a href="##close" title="Close" class="close">X</a>
									<img class="img-responsive"  src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/full_FindlayToyota.jpg"   >
								</div>
							</div>	
						</div>
					</div> 
					<div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div> 
				</cfif>
				
				<cfif #url.dealer_id# eq 133 >
					<div class="row">
						<div class="col-md-12 no-pad " align="left">		
							<h3>Example</h3>
						</div>
					</div> 
					 <div class="row">
						<div class="col-md-2 no-pad " align="center">		
							<a href="##openModald" ><img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tn_FindlayToyota.jpg"   ></a>
							<div id="openModald" class="modalDialog img-responsive">
								<div class="img-responsive">
									<a href="##close" title="Close" class="close">X</a>
									<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/full_FindlayToyota.jpg"   >
								</div>
							</div>	
						</div>
					</div>  
					<div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div> 
				</cfif>
				
				 <div class="row">
					<div class="col-md-12 no-pad">								<!--- Footer --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_ftr.png" border="0" class="img-responsive">
					</div>
				</div> 
				
				 <div class="row">
					<div class="col-md-12 no-pad">	&nbsp;
					</div>
				</div>	 
				 <div class="row">
					<div class="col-md-12 no-pad" align="center">
						<a href="http://#CGI.server_name#/dealer/#variables.dlr_dir#/control/"  >Administrator</a>
					</div>
				</div>	  
			</div>  <!--- container --->
		</section>

	</cffunction>

	<cffunction name="modernreg" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
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
				<cfif IsDefined("url.thanks")  >
					<cfif #url.thanks# EQ "yes"  >
						<cfif IsDefined("url.wch") ><div class="row">
							<div class="col-md-12 no-pad" align="center" >
								<span style="font-size:20pt;font-weight:bold" ><i>Thank You Page</i></span>
								</div>
							</div>
						</cfif>
						<div class="row">
							<div class="col-md-12 no-pad" align="center" >
								<span style="font-size:20pt;font-weight:bold" ><i>Registration Complete</i></span>
							</div>
						</div>
					<cfelse>				
						<div class="row">
							<div class="col-md-12 no-pad" align="center" >
								<span style="font-size:20pt;font-weight:bold;color:red" ><i>Invalid Authorization</i></span>
							</div>
						</div>
					</cfif>	
				</cfif>
				 <div class="row">
					<div class="col-md-12 no-pad" align="center" >				<!--- Nav Bar --->
						<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/blank_Micro_nav.png" border="0" class="img-responsive">
					</div>
				</div> 
				<div class="row">
					<div class="col-md-8 no-pad" align="center">					<!--- Screen Images --->								 
						<cfif #arguments.dealer_id# EQ 196 >
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/tobykeithposter2.png" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 197 > 
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/PITT_StuckeyCruiseSweeps5-sm.png" border="0" class="img-responsive">
						<cfelseif #arguments.dealer_id# EQ 199 >  
							<div class="row">
								<div class="col-md-12 no-pad">	&nbsp;	</div>
							</div>	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/contestgraphic_main.jpg" border="0" class="img-responsive"> 
						<cfelseif #arguments.dealer_id# EQ 203 >  
							<div class="row">
								<div class="col-md-12 no-pad">	&nbsp;	</div>
							</div>	
							<img src="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/images/icons/contestgraphic_main.jpg" border="0" class="img-responsive"> 
						<cfelse>
							&nbsp;	   
						</cfif>
					</div> 
					<div class="col-md-4 no-pad">
						<cfif #arguments.dealer_id# EQ 199 or #arguments.dealer_id# EQ 203 >  
							<div class="row"><div class="col-md-12 no-pad">	&nbsp;	</div></div>	
						</cfif>	
						<div class="row">
						<cfif #arguments.dealer_id# EQ 199>
							<div class="vdp-form-mobile" align="left">	<!--- Info Request Form --->
								<div class="vdp-form-title" align="center"><span style="font-size:20pt;font-weight:bold" >REGISTRATION</span></div>
									 <div class="row">
										<div class="col-md-12 no-pad" align="center"><span style="font-size:12pt;font-weight:bold" >*</span><span style="font-size:10pt;font-weight:bold" > = Required Entry</span>
										</div>
								</div>	 <div class="row"><div class="vdp-form-mobile" align="left">
								  <cfinvoke component="/cfcs/forms/form_qq_micro" method="register_micro">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/dealer/#variables.dlr_dir#/micro_qq_action.cfm"/>
								</cfinvoke>  
								</div> 
				
								</div>
							</div>
						</cfif>	
						<cfif #arguments.dealer_id# EQ 203>
							<div class="vdp-form-mobile" align="left">	<!--- Info Request Form --->
								<div class="vdp-form-title" align="center"><span style="font-size:20pt;font-weight:bold" >REGISTRATION</span></div>
									 <div class="row">
										<div class="col-md-12 no-pad" align="center"><span style="font-size:12pt;font-weight:bold" >*</span><span style="font-size:10pt;font-weight:bold" > Required Entry</span><br>
										<span style="font-size:10pt;color:red;font-weight:bold" >Only One Entry Per Person</span><br>
										<span style="font-size:8pt;color:black;font-weight:bold" >Duplicate Entries will be considered ineligible</span>
										</div>
								</div>	 <div class="row"><div class="vdp-form-mobile" align="left">
								  <cfinvoke component="/cfcs/forms/form_qq_micro" method="register_micro_short">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/dealer/#variables.dlr_dir#/micro_qq_action.cfm"/>
								</cfinvoke>  
								</div> 
				
								</div>
							</div>
						</cfif>	
							<cfif #arguments.dealer_id# EQ 196 >  
			 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
									<div class="row">
										<div class="col-md-12 no-pad" align="center">
											<a href="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/pdfs/BaierlFord_TobyKeith_Rules.pdf" target="_blank" >Complete Contest Rules</a>
										</div>
									</div>	  
				 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	
							</cfif>
						</div>
					</div>
				</div>
							<cfif #arguments.dealer_id# EQ 197 >  
			 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
									<div class="row">
										<div class="col-md-12 no-pad" align="center">
											<a href="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/pdfs/Stuckey Cruise Sweeps Rules.pdf" target="_blank" >Complete Contest Rules</a>
										</div>
									</div>	  
				 					<!--- <div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 --->
							</cfif>
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
							No purchase, payment or donation is necessary to enter and win. A purchase will not improve your chances of winning. Must be a legal U.S. resident, 18 years or older with a currently valid driver's license to enter and win. Only one registration form via online or in person, per family, per visit will be permitted. The odds of winning are dependent on the number of entries. One (1) winner will be randomly selected starting at approximately 4:00 PM on August 31, 2014 at Fuccillo Toyota of Grand Island, 1974 Alvin Road, Grand Island NY 14072 to receive a 60" LG® Plasma HDTV. You need not be present to win. Contest runs August 1, 2014 through August 31, 2014. See dealership for details and complete Contest Rules. Void where prohibited. Winner responsible for payment of all Federal, State and Local taxes applicable to winning the Grand Prize.
						</div>
						<div class="col-md-2 no-pad">&nbsp;</div>
					</div>	
 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
					<div class="row">
						<div class="col-md-12 no-pad" align="center">
							<a href="http://dealers.wdautos.com/dealer/#variables.dlr_dir#/pdfs/FuccilloGrandIsland_AugustRules.pdf" target="_blank" >Complete Contest Rules</a>
						</div>
					</div>	  
 					<div class="row"><div class="col-md-12 no-pad">&nbsp;</div></div>	 
				
				
				</cfif>
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
						<!--- <a href="http://Aspen10.wddemos.com/dealer/#variables.dlr_dir#/control/"  >Administrator</a> --->
					</div>
				</div>	  
				
			</div>
		</section>

	</cffunction>

	<cffunction name="modernregthankyou" description="shows a standard header" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
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
						<!--- <a href="http://Aspen10.wddemos.com/dealer/#variables.dlr_dir#/control/"  >Administrator</a> --->
					</div>
				</div>	  
				
			</div>
		</section>

	</cffunction>

	<cffunction name="modernbaierlregthankyou" description="shows a Baierl Thanks Page" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Aspen10" name="Get_Dealer_Details">
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
						<!--- <a href="http://Aspen10.wddemos.com/dealer/#variables.dlr_dir#/control/"  >Administrator</a> --->
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