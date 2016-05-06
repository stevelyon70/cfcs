<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<div class="visible-lg visible-md">
		<cfif #url.dealer_id# eq 333 or #url.dealer_id# eq 343  or #url.dealer_id# eq 369 >
		 
				 <div class="row">
					<div class="col-md-12  visible-lg visible-md">
						<div class="nav-stroke-top"></div>		
					</div>
				</div>	  
		</cfif>
	
			<nav class="navbar section-nav navbar-default navbar-dt" >
				<div class="container">
					<div  >
						<ul class="nav navbar-nav">
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Nav_Type_ID eq 1>
								<!--- Mega Menu determiniation STARTS Here --->
									<cfset variables.mega_menu=0>
									<cfset variables.Mega_Height=0>
									<cfset variables.Mega_Columns=0>
									<cfset variables.Mega_Glyph_Image=0>
									<cfset variables.Mega_Glyph_Color="">
									<cfset variables.Mega_Right_Float=0>
									<cfquery name="chk_4_mega" datasource="Ultra10">
										SELECT  Nav_ID, Mega_Menu, Mega_Height, Mega_Columns, 
												Mega_Glyph_Image, Mega_Glyph_Color, Mega_Right_Float
										FROM    Navigation
										WHERE	Nav_ID	=	#Get_Nav.Nav_ID#
									</cfquery>	
									<cfif #chk_4_mega.Mega_Menu# EQ 1>
										<cfset variables.mega_menu=1>
										<cfset variables.Mega_Height=#chk_4_mega.Mega_Height#>
										<cfset variables.Mega_Columns=#chk_4_mega.Mega_Columns#>
										<cfset variables.Mega_Glyph_Image=#chk_4_mega.Mega_Glyph_Image#>
										<cfset variables.Mega_Glyph_Color="#chk_4_mega.Mega_Glyph_Color#">
										<cfset variables.Mega_Right_Float=#chk_4_mega.Mega_Right_Float#>
									</cfif>
								
								<!--- Mega Menu determiniation ENDS Here --->
									<cfset variables.main_nav=Get_Nav.Nav_ID>
									<cfif Get_Nav.Nav_Link eq "index.cfm">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
									<cfelse>
										<cfif left(Get_Nav.Nav_Link,4) neq "http">
											<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
										</cfif>
									</cfif>
	
									<cfset variables.subcount=0>
									<cfloop query="Get_Nav">
										<cfif Get_Nav.Parent_Nav_ID eq variables.main_nav>
											<cfset variables.subcount=variables.subcount+1>
										</cfif>
									</cfloop>
									<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
										<cfcase value="1">
											<cfif variables.subcount eq 0>
												<li style="margin-right:10px!important"><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
											<cfelse>
											<!--- Mega Menu STARTS Here --->
											 
											<cfif #variables.mega_menu# eq 1  
													AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)"
														AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 8.0"> 
											
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt" style="height: #variables.Mega_Height#px; -webkit-column-count: #variables.Mega_Columns#; -moz-column-count: #variables.Mega_Columns#; column-count:#variables.Mega_Columns#;">
													
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		<li style="display: inline-block;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" >
																			<!--- <img src="http://dealers.wdautos.com//images/brand_logos/logo_ford_off.png" width="50px" height="50px" class="img-responsive" > #Get_Nav.Nav_Name# --->
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#
																			</a>
																		</li>
																		<!--- <div class="clear"></div> --->
																	</cfcase>
																	<cfcase value="2">
																		<li style="display: inline-block; padding-bottom:5px;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#   
																			</a>
																		</li>	
																		<!--- <div class="clear"></div> --->																		
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>														
													</ul>
												</li> 
												
												
											<cfelse>
											  
											<!--- Mega Menu STOPS Here --->
											
												<li class="dropdown dropdown-dt" style="margin-right:5px!important">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt">
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		 <!--- Omniture tagging code for washington Toyota --->
																		<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" 
																		    <cfif url.dealer_id EQ 37 AND  Trim(Get_Nav.Nav_Name) EQ Trim("Schedule Service Now")> 
																					onClick="tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event48';tmsomni.linkTrackEvents = 'event48';tmsomni.prop6 = 'service request';tmsomni.prop64 = 'service'; tmsomni.tl(this, 'o', 'servicerequest');"
																			</cfif>
																			 <cfif url.dealer_id EQ 37 AND  Trim(Get_Nav.Nav_Name) EQ Trim("Value Your Trade")> 
																					onClick="tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(this, 'o', 'vehrequest');"
																			</cfif>
																			>#Get_Nav.Nav_Name#</a></li>
																	</cfcase>
																	<cfcase value="2">
																		<li>
																			<a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" 
																		    <!--- Omniture tagging code for washington Toyota --->
																			<cfif url.dealer_id EQ 37 AND Trim(Get_Nav.Nav_Name) EQ #trim("Finance Application")#> 
																			  		onClick="tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event52';tmsomni.linkTrackEvents = 'event52';tmsomni.prop6 = 'finance request';tmsomni.prop64 = 'finance'; tmsomni.tl(this, 'e', 'financeapplication');"
																			</cfif> 
																			target="_blank">#Get_Nav.Nav_Name#</a>
																		</li>						
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>
													</ul>
												</li>
											</cfif>
											   </cfif>    <!--- for Mega Menu --->
										</cfcase>
										<cfcase value="2">
											<cfif variables.subcount eq 0>
												<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
											<cfelse>
											
											<!--- Mega Menu STARTS Here --->
											 
											<cfif #variables.mega_menu# eq 1  
											AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)"
											AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 8.0"> 
											
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank" >#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt" style="height: #variables.Mega_Height#px; -webkit-column-count: #variables.Mega_Columns#; -moz-column-count: #variables.Mega_Columns#; column-count:#variables.Mega_Columns#;">
													
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		<li style="display: inline-block;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
																			<!--- <img src="http://dealers.wdautos.com//images/brand_logos/logo_ford_off.png" width="50px" height="50px" class="img-responsive" > #Get_Nav.Nav_Name# --->
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#
																			</a>
																		</li>
																		<!--- <div class="clear"></div> --->
																	</cfcase>
																	<cfcase value="2">
																		<li style="display: inline-block; padding-bottom:5px;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#   
																			</a>
																		</li>	
																		<!--- <div class="clear"></div> --->																		
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>														
													</ul>
												</li> 
												
												
											<cfelse>
											  
											<!--- Mega Menu STOPS Here --->
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt">
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
																	</cfcase>
																	<cfcase value="2">
																		<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>
													</ul>
												</li>
											</cfif>
											</cfif>
										</cfcase>
										<cfcase value="3">
											<li class="navbar-link-dt">#Get_Nav.Nav_Name#</li>
										</cfcase>
									</cfswitch>
								</cfif>
							</cfloop>
							
							<!---Start 7-24-2014 added for chat nave for dealer 52--->
							<cfif #url.dealer_id# eq 52 >    
								<li>
		 							 <div class="visible-lg visible-md " style="margin-top: 0px; padding-left:0px; padding-right: -10%; right: 25%; position:static; z-index:10000;">
												<script type='text/javascript' src='http://chatserver3.clientconnexion.com:8080/include.js?domain=www.westhillsnissan.com'></script>
												<script type='text/javascript'>
													if (typeof sWOTrackPage == 'function') sWOTrackPage();
												</script>
									 </div> 
								</li>     
							</cfif>
							<!---Start 11-24-2014 added for chat nave for dealer 54--->
							<cfif #url.dealer_id# eq 54 >    
								<li>
		
							<div style="margin-top:0px; left: 50%; margin-left:90px; position: absolute; z-index: 10000;">   
								<script type='text/javascript' src='http://chatserver3.clientconnexion.com:8080/include.js?domain=www.pittsburgheastnissan.com'></script>
								<script type='text/javascript' >
								if(typeof sWOTrackPage=='function')sWOTrackPage();
								</script>
							</DIV>								
								</li>     
							</cfif>
							<!---Start 11-24-2014 added for chat nave for dealer 54--->		
							
							
																			
							
						</ul>
					</div>
				</div>
				
			</nav>
			
		<cfif #url.dealer_id# eq 333 >
		 
				 <div class="row">
					<div class="col-md-12  visible-lg visible-md">
						<div class="nav-stroke-bottom"></div>		
					</div>
				</div>	  
		</cfif>
		</div>
<cfif #url.dealer_id# NEQ 82 >
		<div class="visible-xs visible-sm">
		
			<nav class="navbar section-nav navbar-default navbar-dt" >
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##mobile_nav">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse no-pad" id="mobile_nav">
					<ul class="nav navbar-nav">
						<cfloop query="Get_Nav">
							<cfset variables.main_nav=Get_Nav.Nav_ID>
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfset variables.subcount=0>
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Parent_Nav_ID eq variables.main_nav>
									<cfset variables.subcount=variables.subcount+1>
								</cfif>
							</cfloop>
							<cfif Get_Nav.Nav_Type_ID eq 1>
								<cfif variables.subcount eq 0>
									<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
										<cfcase value="1">
											<li><a class="navbar-link-mbl" href="#Get_Nav.Nav_Link#">#Get_Nav.Nav_Name#</a></li>
										</cfcase>
										<cfcase value="2">
											<li><a class="navbar-link-mbl" href="#Get_Nav.Nav_Link#" target="_blank">#Get_Nav.Nav_Name#</a></li>
										</cfcase>
									</cfswitch>
								<cfelse>
									<li class="dropdown">
										<a class="navbar-link-mbl" href="##" class="dropdown-toggle" data-toggle="dropdown">#Get_Nav.Nav_Name# <b class="caret"></b></a>
										<ul class="dropdown-menu dropdown-menu-mbl ">
											<cfloop query="Get_Nav">
												<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav and Get_Nav.Robot_Food eq 0>
													<cfif Get_Nav.Nav_Link eq "index.cfm">
														<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
													<cfelse>
														<cfif left(Get_Nav.Nav_Link,4) neq "http">
															<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
														</cfif>
													</cfif>
													<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
														<cfset Get_Nav.Nav_Link=Get_Nav.Nav_Mobile_Link>
													</cfif>
													<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
														<cfcase value="1">
															<li><a class="navbar-link-mbl-sub" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
														</cfcase>
														<cfcase value="2">
															<li><a class="navbar-link-mbl-sub" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
														</cfcase>
													</cfswitch>
												</cfif>
											</cfloop>
										</ul>
									</li>
								</cfif>
							</cfif>
						</cfloop>
	
	 <!--- Start Mobile chat--->
                        <cfif #url.dealer_id# eq 52>
                        
                         <cfquery datasource="Ultra10" name="Get_Dealer_Directory">
                            SELECT     Dealer_Directory, Primary_URL
                            FROM		Dealers
                            WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
                        </cfquery>
                        
                        <!---#variables.server_name#--->
                        <li>
                        	<a href="http://chatserver3.clientconnexion.com/chat/chatstart.aspx?domain=www.#Get_Dealer_Directory.Primary_URL#&SID=1" target="_blank">
    							<span style="margin-left:10px;"><img alt="Chat Live Now!" src="http://dealers.wdautos.com/Dealer/#Get_Dealer_Directory.Dealer_Directory#/images/icons/stat.gif" title="Chat Live Now!" /></span>
							</a>                                 
                        </li>
                        </cfif>
						<!--- End Mobile chat--->
	
					</ul>
				</div>
			</nav>
		</div>
<cfelse>
		<div class="visible-xs visible-sm pull-left">
			<nav class="navbar-mbl section-nav-mbl navbar-default-mbl navbar-dt-mbl pull-left" >
				<div class="navbar-header " >
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##mobile_nav">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse no-pad pull-left" id="mobile_nav" >
					<ul class="nav navbar-nav-mbl pull-left" >
						<cfloop query="Get_Nav">
							<cfset variables.main_nav=Get_Nav.Nav_ID>
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfset variables.subcount=0>
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Parent_Nav_ID eq variables.main_nav>
									<cfset variables.subcount=variables.subcount+1>
								</cfif>
							</cfloop>
							<cfif Get_Nav.Nav_Type_ID eq 1>
								<cfif variables.subcount eq 0>
									<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
										<cfcase value="1">
											<li align="left"><a class="navbar-link-mbl" href="#Get_Nav.Nav_Link#">#Get_Nav.Nav_Name#</a></li>
										</cfcase>
										<cfcase value="2">
											<li align="left"><a class="navbar-link-mbl" href="#Get_Nav.Nav_Link#" target="_blank">#Get_Nav.Nav_Name#</a></li>
										</cfcase>
									</cfswitch>
								<cfelse>
									<li class="dropdown ">
										<a class="navbar-link-mbl" href="##" class="dropdown-toggle" data-toggle="dropdown">#Get_Nav.Nav_Name# <b class="caret"></b></a>
										<ul class="dropdown-menu ">
											<cfloop query="Get_Nav">
												<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav and Get_Nav.Robot_Food eq 0>
													<cfif Get_Nav.Nav_Link eq "index.cfm">
														<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
													<cfelse>
														<cfif left(Get_Nav.Nav_Link,4) neq "http">
															<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
														</cfif>
													</cfif>
													<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
														<cfset Get_Nav.Nav_Link=Get_Nav.Nav_Mobile_Link>
													</cfif>
													<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
														<cfcase value="1">
															<li><a class="navbar-link-mbl-sub" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
														</cfcase>
														<cfcase value="2">
															<li><a class="navbar-link-mbl-sub" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
														</cfcase>
													</cfswitch>
												</cfif>
											</cfloop>
										</ul>
									</li>
								</cfif>
							</cfif>
						</cfloop>
	
	 <!--- Start Mobile chat--->
                        <cfif #url.dealer_id# eq 52>
                        
                         <cfquery datasource="Ultra10" name="Get_Dealer_Directory">
                            SELECT     Dealer_Directory, Primary_URL
                            FROM		Dealers
                            WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
                        </cfquery>
                        
                        <!---#variables.server_name#--->
                        <li>
                        	<a href="http://chatserver3.clientconnexion.com/chat/chatstart.aspx?domain=www.#Get_Dealer_Directory.Primary_URL#&SID=1" target="_blank">
    							<span style="margin-left:10px;"><img alt="Chat Live Now!" src="http://dealers.wdautos.com/Dealer/#Get_Dealer_Directory.Dealer_Directory#/images/icons/stat.gif" title="Chat Live Now!" /></span>
							</a>                                 
                        </li>
                        </cfif>
						<!--- End Mobile chat--->
	
					</ul>
				</div>
			</nav>
		</div>


</cfif>				

		
		
		
		
	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">

		<div class="section-nav">
			<div class="container">
				<div class="superfish">
					<ul class="sf-menu">
						<cfloop query="Get_Nav">
							<cfif Get_Nav.Nav_Type_ID eq 1>
								<cfset variables.main_nav=Get_Nav.Nav_ID>
								<cfif Get_Nav.Nav_Link eq "index.cfm">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
									</cfif>
								</cfif>
		
								<cfset variables.subcount=0>
								<cfloop query="Get_Nav">
									<cfif Get_Nav.Parent_Nav_ID eq variables.main_nav>
										<cfset variables.subcount=variables.subcount+1>
									</cfif>
								</cfloop>
								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1">
										<cfif variables.subcount eq 0>
											<li><a class="navbar-link-legacy" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
										<cfelse>
											<li class="dropdown dropdown-dt">
												<a class="navbar-link-legacy" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
												<ul class="dropdown-menu dropdown-menu-dt">
													<cfloop query="Get_Nav">
														<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
															<cfif Get_Nav.Nav_Link eq "index.cfm">
																<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
															<cfelse>
																<cfif left(Get_Nav.Nav_Link,4) neq "http">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																</cfif>
															</cfif>
															<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																<cfcase value="1">
																	<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
																</cfcase>
																<cfcase value="2">
																	<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
																</cfcase>
															</cfswitch>
														</cfif>
													</cfloop>
												</ul>
											</li>
										</cfif>
									</cfcase>
									<cfcase value="2">
										<cfif variables.subcount eq 0>
											<li><a class="navbar-link-legacy" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
										<cfelse>
											<li class="dropdown dropdown-dt">
												<a class="navbar-link-legacy" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
												<ul class="dropdown-menu dropdown-menu-dt">
													<cfloop query="Get_Nav">
														<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
															<cfif Get_Nav.Nav_Link eq "index.cfm">
																<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
															<cfelse>
																<cfif left(Get_Nav.Nav_Link,4) neq "http">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																</cfif>
															</cfif>
															<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																<cfcase value="1">
																	<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
																</cfcase>
																<cfcase value="2">
																	<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
																</cfcase>
															</cfswitch>
														</cfif>
													</cfloop>
												</ul>
											</li>
										</cfif>
									</cfcase>
									<cfcase value="3">
										<li class="navbar-link-legacy">#Get_Nav.Nav_Name#</li>
									</cfcase>
								</cfswitch>
							</cfif>
						</cfloop>
					</ul>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		
		<!---<cfset url.Dom_Functions= url.Dom_Functions & '$("ul.sf-menu").superfish().find("ul").bgIframe({opacity:false});'>--->

	</cffunction>

	<cffunction name="dev" description="standard navbar" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Dealer_ID" default="true">
		<cfargument name="Nav_Type_ID" required="true">
	
		<!---Get Nav--->
		<cfstoredproc datasource="Ultra10" procedure="Get_All_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#arguments.Dealer_ID#" value="#arguments.dealer_id#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="#arguments.Nav_Type_ID#" maxlength="3">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>

		<div class="visible-lg visible-md">
			<nav class="navbar yamm navbar-default navbar-dt" >
				<div class="container sitenav">
					<div class="no-pad" id="dt_nav">
						<ul class="nav navbar-nav no-pad">
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Nav_Link eq "index.cfm">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
									</cfif>
								</cfif>
								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1">
										<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>								
									</cfcase>
									<cfcase value="2">
										<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
									</cfcase>
									<cfcase value="3">
										<li class="navbar-link-dt">#Get_Nav.Nav_Name#</li>
									</cfcase>
								</cfswitch>
							</cfloop>
							<!---<li class="dropdown dropdown-dt  yamm-fw">
								<a href="##" class="dropdown-toggle navbar-link-dt" data-toggle="dropdown">yamm <b class="caret"></b></a>
								<ul class="dropdown-menu dropdown-menu-dt">
									<li class="dropdown"><a href="##">Action</a></li>
								</ul>
							</li>--->
							<!---<li class="dropdown dropdown-dt">
								<a href="##" class="dropdown-toggle navbar-link-dt" data-toggle="dropdown">Pre-Owned <b class="caret"></b></a>
								<ul class="dropdown-menu dropdown-menu-dt">
									<li><a href="##">Action</a></li>
								</ul>
							</li>--->
						</ul>
					</div>
				</div>
			</nav>
		</div>
		<div class="visible-xs visible-sm">
			<nav class="navbar navbar-inverse" >
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##mobile_nav">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				</div>
				<div class="collapse navbar-collapse no-pad" id="mobile_nav">
					<ul class="nav navbar-nav">
						<cfloop query="Get_Nav">
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
								<cfcase value="1">
									<li><a class="navbar-link-mb" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>								
								</cfcase>
								<cfcase value="2">
									<li><a class="navbar-link-mb" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
								</cfcase>
								<cfcase value="3">
									<li class="navbar-link-mb">#Get_Nav.Nav_Name#</li>
								</cfcase>
							</cfswitch>
						</cfloop>
						<!---<li>
							<a href="http://#cgi.server_name#">Home</a>
						</li>
						<li class="dropdown">
							<a href="##" class="dropdown-toggle" data-toggle="dropdown">New Cars <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a class="navbar-link-mob" href="##">Action</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="##" class="dropdown-toggle" data-toggle="dropdown">Pre-Owned <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a class="navbar-link-mob" href="##">Action</a></li>
							</ul>
						</li>--->
					</ul>
				</div>
			</nav>
		</div>
	
	</cffunction>

	
	<cffunction name="pre_header" description="shows a standard header" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="pre_head_text" default="">
		<div class="visible-lg visible-md">
		
		<cfif #url.dealer_id# eq 333 >
		 
				 <div class="row">
					<div class="col-md-12  visible-lg visible-md">
						<div class="nav-stroke-top"></div>		
					</div>
				</div>	  
		</cfif>
			<nav class="navbar section-nav navbar-default navbar-dt" >
			
				<div class="container-fluid">
					<div>
						<ul class="nav navbar-nav">
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Nav_Type_ID eq 1>
								<!--- Mega Menu determiniation STARTS Here --->
									<cfset variables.mega_menu=0>
									<cfset variables.Mega_Height=0>
									<cfset variables.Mega_Columns=0>
									<cfset variables.Mega_Glyph_Image=0>
									<cfset variables.Mega_Glyph_Color="">
									<cfset variables.Mega_Right_Float=0>
									<cfquery name="chk_4_mega" datasource="Ultra10">
										SELECT  Nav_ID, Mega_Menu, Mega_Height, Mega_Columns, 
												Mega_Glyph_Image, Mega_Glyph_Color, Mega_Right_Float
										FROM    Navigation
										WHERE	Nav_ID	=	#Get_Nav.Nav_ID#
									</cfquery>	
									<cfif #chk_4_mega.Mega_Menu# EQ 1>
										<cfset variables.mega_menu=1>
										<cfset variables.Mega_Height=#chk_4_mega.Mega_Height#>
										<cfset variables.Mega_Columns=#chk_4_mega.Mega_Columns#>
										<cfset variables.Mega_Glyph_Image=#chk_4_mega.Mega_Glyph_Image#>
										<cfset variables.Mega_Glyph_Color="#chk_4_mega.Mega_Glyph_Color#">
										<cfset variables.Mega_Right_Float=#chk_4_mega.Mega_Right_Float#>
									</cfif>
								
								<!--- Mega Menu determiniation ENDS Here --->
									<cfset variables.main_nav=Get_Nav.Nav_ID>
									<cfif Get_Nav.Nav_Link eq "index.cfm">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
									<cfelse>
										<cfif left(Get_Nav.Nav_Link,4) neq "http">
											<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
										</cfif>
									</cfif>
	
									<cfset variables.subcount=0>
									<cfloop query="Get_Nav">
										<cfif Get_Nav.Parent_Nav_ID eq variables.main_nav>
											<cfset variables.subcount=variables.subcount+1>
										</cfif>
									</cfloop>
									<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
										<cfcase value="1">
											<cfif variables.subcount eq 0>
												<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
											<cfelse>
											<!--- Mega Menu STARTS Here --->
											 
											<cfif #variables.mega_menu# eq 1  
													AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)"
														AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 8.0"> 
											
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt" style="height: #variables.Mega_Height#px; -webkit-column-count: #variables.Mega_Columns#; -moz-column-count: #variables.Mega_Columns#; column-count:#variables.Mega_Columns#;">
													
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		<li style="display: inline-block;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" >
																			<!--- <img src="http://dealers.wdautos.com//images/brand_logos/logo_ford_off.png" width="50px" height="50px" class="img-responsive" > #Get_Nav.Nav_Name# --->
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#
																			</a>
																		</li>
																		<!--- <div class="clear"></div> --->
																	</cfcase>
																	<cfcase value="2">
																		<li style="display: inline-block; padding-bottom:5px;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#   
																			</a>
																		</li>	
																		<!--- <div class="clear"></div> --->																		
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>														
													</ul>
												</li> 
												
												
											<cfelse>
											  
											<!--- Mega Menu STOPS Here --->
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt">
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		 <!--- Omniture tagging code for washington Toyota --->
																		<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" 
																		    <cfif url.dealer_id EQ 37 AND  Trim(Get_Nav.Nav_Name) EQ Trim("Schedule Service Now")> 
																					onClick="tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event48';tmsomni.linkTrackEvents = 'event48';tmsomni.prop6 = 'service request';tmsomni.prop64 = 'service'; tmsomni.tl(this, 'o', 'servicerequest');"
																			</cfif>
																			 <cfif url.dealer_id EQ 37 AND  Trim(Get_Nav.Nav_Name) EQ Trim("Value Your Trade")> 
																					onClick="tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event54';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(this, 'o', 'vehrequest');"
																			</cfif>
																			>#Get_Nav.Nav_Name#</a></li>
																	</cfcase>
																	<cfcase value="2">
																		<li>
																			<a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" 
																		    <!--- Omniture tagging code for washington Toyota --->
																			<cfif url.dealer_id EQ 37 AND Trim(Get_Nav.Nav_Name) EQ #trim("Finance Application")#> 
																			  		onClick="tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.events='event52';tmsomni.linkTrackEvents = 'event52';tmsomni.prop6 = 'finance request';tmsomni.prop64 = 'finance'; tmsomni.tl(this, 'e', 'financeapplication');"
																			</cfif> 
																			target="_blank">#Get_Nav.Nav_Name#</a>
																		</li>						
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>
													</ul>
												</li>
											</cfif>
											   </cfif>    <!--- for Mega Menu --->
										</cfcase>
										<cfcase value="2">
											<cfif variables.subcount eq 0>
												<li><a class="navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
											<cfelse>
											
											<!--- Mega Menu STARTS Here --->
											 
											<cfif #variables.mega_menu# eq 1  
											AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)"
											AND #cgi.http_user_agent# DOES NOT CONTAIN "MSIE 8.0"> 
											
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank" >#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt" style="height: #variables.Mega_Height#px; -webkit-column-count: #variables.Mega_Columns#; -moz-column-count: #variables.Mega_Columns#; column-count:#variables.Mega_Columns#;">
													
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		<li style="display: inline-block;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
																			<!--- <img src="http://dealers.wdautos.com//images/brand_logos/logo_ford_off.png" width="50px" height="50px" class="img-responsive" > #Get_Nav.Nav_Name# --->
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#
																			</a>
																		</li>
																		<!--- <div class="clear"></div> --->
																	</cfcase>
																	<cfcase value="2">
																		<li style="display: inline-block; padding-bottom:5px;" >
																			<a class="dropdown dropdown-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
																				<cfif #variables.Mega_Glyph_Image# EQ 1><span class="glyphicon glyphicon-chevron-right" style="color:###variables.Mega_Glyph_color#" ></span></cfif> #Get_Nav.Nav_Name#   
																			</a>
																		</li>	
																		<!--- <div class="clear"></div> --->																		
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>														
													</ul>
												</li> 
												
												
											<cfelse>
											  
											<!--- Mega Menu STOPS Here --->
											
												<li class="dropdown dropdown-dt">
													<a class="dropdown-toggle navbar-link-dt" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a>
													<ul class="dropdown-menu dropdown-menu-dt">
														<cfloop query="Get_Nav">
															<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav>
																<cfif Get_Nav.Nav_Link eq "index.cfm">
																	<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
																<cfelse>
																	<cfif left(Get_Nav.Nav_Link,4) neq "http">
																		<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
																	</cfif>
																</cfif>
																<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
																	<cfcase value="1">
																		<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
																	</cfcase>
																	<cfcase value="2">
																		<li><a class="dropdown" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
																	</cfcase>
																</cfswitch>
															</cfif>
														</cfloop>
													</ul>
												</li>
											</cfif>
											</cfif>
										</cfcase>
										<cfcase value="3">
											<li class="navbar-link-dt">#Get_Nav.Nav_Name#</li>
										</cfcase>
									</cfswitch>
								</cfif>
							</cfloop>
							
							<!---Start 7-24-2014 added for chat nave for dealer 52--->
							<cfif #url.dealer_id# eq 52 >    
								<li>
		 							 <div class="visible-lg visible-md " style="margin-top: 0px; padding-left:10px; padding-right: -10%; right: 20%; position:static; z-index:10000;">
												<script type='text/javascript' src='http://chatserver3.clientconnexion.com:8080/include.js?domain=www.westhillsnissan.com'></script>
												<script type='text/javascript'>
													if (typeof sWOTrackPage == 'function') sWOTrackPage();
												</script>
									 </div> 
								</li>     
							</cfif>
							<!---Start 11-24-2014 added for chat nave for dealer 54--->
							<cfif #url.dealer_id# eq 54 >    
								<li>
		
							<div style="margin-top:0px; left: 50%; margin-left:90px; position: absolute; z-index: 10000;">   
								<script type='text/javascript' src='http://chatserver3.clientconnexion.com:8080/include.js?domain=www.pittsburgheastnissan.com'></script>
								<script type='text/javascript' >
								if(typeof sWOTrackPage=='function')sWOTrackPage();
								</script>
							</DIV>								
								</li>     
							</cfif>
							<!---Start 11-24-2014 added for chat nave for dealer 54--->		
							
							
																			
							
						</ul>
						<cfif #arguments.pre_head_text# NEQ "" AND #url.dealer_Id# NEQ 376  AND #url.dealer_Id# NEQ 374 >
							<div class="visible-lg visible-md pre-header-text pull-right" >#arguments.pre_head_text#</div>
							  
						</cfif>
					</div>
				</div>
				
			</nav>
			
		<cfif #url.dealer_id# eq 333 >
		 
				 <div class="row">
					<div class="col-md-12  visible-lg visible-md">
						<div class="nav-stroke-bottom"></div>		
					</div>
				</div>	  
		</cfif>
		</div>
		<div class="visible-xs visible-sm">
			<nav class="navbar section-nav navbar-default navbar-dt navbar-dt-mbl" >
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##mobile_nav">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse no-pad" id="mobile_nav">
					<ul class="nav navbar-nav">
						<cfloop query="Get_Nav">
							<cfset variables.main_nav=Get_Nav.Nav_ID>
							<cfif Get_Nav.Nav_Link eq "index.cfm">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
							<cfelse>
								<cfif left(Get_Nav.Nav_Link,4) neq "http">
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
								</cfif>
							</cfif>
							<cfset variables.subcount=0>
							<cfloop query="Get_Nav">
								<cfif Get_Nav.Parent_Nav_ID eq variables.main_nav>
									<cfset variables.subcount=variables.subcount+1>
								</cfif>
							</cfloop>
							<cfif Get_Nav.Nav_Type_ID eq 1>
								<cfif variables.subcount eq 0>
									<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
										<cfcase value="1">
											<li><a class="navbar-link-mbl" href="#Get_Nav.Nav_Link#">#Get_Nav.Nav_Name#</a></li>
										</cfcase>
										<cfcase value="2">
											<li><a class="navbar-link-mbl" href="#Get_Nav.Nav_Link#" target="_blank">#Get_Nav.Nav_Name#</a></li>
										</cfcase>
									</cfswitch>
								<cfelse>
									<li class="dropdown">
										<a class="navbar-link-mbl" href="##" class="dropdown-toggle" data-toggle="dropdown">#Get_Nav.Nav_Name# <b class="caret"></b></a>
										<ul class="dropdown-menu">
											<cfloop query="Get_Nav">
												<cfif Get_Nav.Nav_Type_ID eq 2 and Get_Nav.Parent_Nav_ID eq variables.main_nav and Get_Nav.Robot_Food eq 0>
													<cfif Get_Nav.Nav_Link eq "index.cfm">
														<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
													<cfelse>
														<cfif left(Get_Nav.Nav_Link,4) neq "http">
															<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#Get_Nav.Nav_Link#">
														</cfif>
													</cfif>
													<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
														<cfset Get_Nav.Nav_Link=Get_Nav.Nav_Mobile_Link>
													</cfif>
													<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
														<cfcase value="1">
															<li><a class="navbar-link-mbl-sub" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</a></li>
														</cfcase>
														<cfcase value="2">
															<li><a class="navbar-link-mbl-sub" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">#Get_Nav.Nav_Name#</a></li>						
														</cfcase>
													</cfswitch>
												</cfif>
											</cfloop>
										</ul>
									</li>
								</cfif>
							</cfif>
						</cfloop>
	
	 <!--- Start Mobile chat--->
                        <cfif #url.dealer_id# eq 52>
                        
                         <cfquery datasource="Ultra10" name="Get_Dealer_Directory">
                            SELECT     Dealer_Directory, Primary_URL
                            FROM		Dealers
                            WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
                        </cfquery>
                        
                        <!---#variables.server_name#--->
                        <li>
                        	<a href="http://chatserver3.clientconnexion.com/chat/chatstart.aspx?domain=www.#Get_Dealer_Directory.Primary_URL#&SID=1" target="_blank">
    							<span style="margin-left:10px;"><img alt="Chat Live Now!" src="http://dealers.wdautos.com/Dealer/#Get_Dealer_Directory.Dealer_Directory#/images/icons/stat.gif" title="Chat Live Now!" /></span>
							</a>                                 
                        </li>
                        </cfif>
						<!--- End Mobile chat--->
	
					</ul>
				</div>
			</nav>
		</div>

	</cffunction>

	
	
	
	
</cfcomponent>