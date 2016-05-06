<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="site_mode" required="true">
		<cfargument name="Get_Meta_Info" required="true">
		<cfargument name="component_name" required="true">
		<cfargument name="method_name" required="true">
		<cfargument name="display_type" default="">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
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
					<div class="col-md-12 no-pad" align="center" >				<!--- Header --->
						<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/webheader.jpg" border="0" class="img-responsive"> 
					</div>
				</div> 
			</div>
		</section>
		
		<section class="section-spl">
			<div class="container">
					<div class="row">
						<div class="col-md-8 pad-right 5px" align="right" >	
							<img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_640x360_V1.jpg" border="0" class="img-responsive"> 
						</div>
						<div class="col-md-4 pad-left 5px  pad-top-10" style="background-color:##333" align="left" >	
							<span style="font-size:10pt;color:##ffffff;font-weight:bold">TRADE IN APPRAISAL</span><br><br>
							<span style="font-size:9pt;color:##ffffff;font-weight:bold">We are pleased to invite you to a very unique vehicle sales event. Due to the shortage of quality pre-owned vehicles available at our dealership, we are prepared to buy back your vehicle with incredible incentives to you.</span> 
						</div>
						<div class="col-md-4 pad-left 5px " style="background-color:##333"  align="left" ><br>	
							<span style="font-size:10pt;color:##ffffff;font-weight:bold">Trade-In Assistance Program :</span><br><br>
							<span style="font-size:9pt;color:##ffffff;font-weight:bold">When you upgrade to a New Vehicle, we will buy back your current vehicle at never before offered terms, giving you <span style="font-size:9pt;color:yellow;font-weight:bold">TOP DOLLAR FOR YOUR TRADE*</span> We have made trading in your vehicle easier than ever.</span> 
							<br><br><span style="font-size:10pt;color:##ffffff;font-weight:bold">No hassles. No gimmicks.</span><br><br>
						</div>
					<div class="row">
						<div class="col-md-8 pad-right 5px" align="right" >	
							
						</div>
						<div class="col-md-4 pad-left 5px" style="background-color:##fff"  align="left" > 	
							<div class="col-md-12 pad-left 5px " style="background-color:##fff"  align="center" >
								<div class="col-md-5 pad-left 5px " style="background-color:##333"  align="left" >
									<span style="font-size:9pt;color:##ffffff;font-weight:normal">SEARCH OUR</span><br><span style="font-size:10pt;color:##ffffff;font-weight:bold">INVENTORY</span>
								</div>
								<div class="col-md-2 pad-left 5px " style="background-color:##fff"  align="center" ></div>
								<div class="col-md-5 pad-left 5px " style="background-color:##333"  align="left" >
									<span style="font-size:9pt;color:##ffffff;font-weight:normal">VISIT OUR</span><br><span style="font-size:10pt;color:##ffffff;font-weight:bold">WEBSITE</span>
								</div>
							</div>
						</div>
					</div>
					</div>
	
	
	
	
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row"> 
							<div class="col-md-6 pull left" align="left" >	
<!--- <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Toy_TradeBooster_640x360_V1.jpg" border="0" class="img-responsive">  --->
							</div>		
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
					 <div class="row">
						<div class="col-md-12 no-pad visible-md visible-lg" align="center">
							
						</div>
					</div>	  
					<div class="row"><div class="col-md-12">&nbsp;</div></div>
					 <div class="row">
						<div class="col-md-12 no-pad">								<!--- Footer --->
							<!--- <img src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/Toy_TradeIn_Booster_640x244_footer.jpg" border="0" class="img-responsive">  --->
						</div>
					</div> 
					
					 <div class="row">
						<div class="col-md-12 no-pad">	&nbsp;
						</div>
					</div>	 
			</div>  <!--- container --->
		</section>

	</cffunction>

	<cffunction name="legacy" description="shows a standard header" output="Yes" access="public">

		<div class="section-spl">
			<div class="container">
				<cfswitch expression="#arguments.display_type#">
					<cfdefaultcase>
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding:10px 0px 10px 0px;" valign="top">
									<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
										<div class="row">
											<div class="col-md-12">
												<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
											</div>
										</div>
									</cfif>
									<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_banner#
											</div>
										</div>
									</cfif>
									<div class="row">
										<div class="col-md-12 pad-top-10">
											<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
												<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
												<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
												<cfinvokeargument name="city" value="#arguments.city#"/>
												<cfinvokeargument name="state" value="#arguments.state#"/>
												<cfinvokeargument name="zip" value="#arguments.zip#"/>
												<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
											</cfinvoke>
										</div>
									</div>
									<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_footer#
											</div>
										</div>
									</cfif>
								</td>
							</tr>
						</table>
					</cfdefaultcase>
					<cfcase value="col_right">
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td style="width:790px;padding:0px 10px 0px 0px;" valign="top">
									<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
										<div class="row">
											<div class="col-md-12">
												<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
											</div>
										</div>
									</cfif>
									<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_banner#
											</div>
										</div>
									</cfif>
									<div class="row">
										<div class="col-md-12 pad-top-10">
											<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
												<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
												<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
												<cfinvokeargument name="city" value="#arguments.city#"/>
												<cfinvokeargument name="state" value="#arguments.state#"/>
												<cfinvokeargument name="zip" value="#arguments.zip#"/>
												<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
											</cfinvoke>
										</div>
									</div>
									<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_footer#
											</div>
										</div>
									</cfif>
								</td>
								<td  style="width:200px" valign="top">
									<div class="content-contact">
										<cfif cgi.script_name neq "/forms/contact.cfm">
											<cfinvoke component="/cfcs/forms/form_contact" method="sidebar_modern">
												<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
												<cfinvokeargument name="dsn" value="#url.DSN#"/>
												<cfinvokeargument name="title_class" value="side-title"/>
												<cfinvokeargument name="input_class" value="side-input"/>
												<cfinvokeargument name="button_class" value="button-input"/>
												<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
											</cfinvoke>
											<hr>
										</cfif>
										<cfinvoke component="/cfcs/ultra10/contact" method="phone">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
											<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
											<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
											<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
											<cfinvokeargument name="city" value="#arguments.city#"/>
											<cfinvokeargument name="state" value="#arguments.state#"/>
											<cfinvokeargument name="zip" value="#arguments.zip#"/>
											<cfinvokeargument name="title_class" value="side-title"/>
										</cfinvoke>
									</div>
								</td>
							</tr>
						</table>
					</cfcase>
					<cfcase value="col_left">
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td  style="width:200px" valign="top">
									<div class="content-contact">
										<cfif cgi.script_name neq "/forms/contact.cfm">
											<cfinvoke component="/cfcs/forms/form_contact" method="sidebar_modern">
												<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
												<cfinvokeargument name="dsn" value="#url.DSN#"/>
												<cfinvokeargument name="title_class" value="side-title"/>
												<cfinvokeargument name="input_class" value="side-input"/>
												<cfinvokeargument name="button_class" value="button-input"/>
												<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
											</cfinvoke>
											<hr>
										</cfif>
										<cfinvoke component="/cfcs/ultra10/contact" method="phone">
											<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
											<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
											<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
											<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
											<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
											<cfinvokeargument name="city" value="#arguments.city#"/>
											<cfinvokeargument name="state" value="#arguments.state#"/>
											<cfinvokeargument name="zip" value="#arguments.zip#"/>
											<cfinvokeargument name="title_class" value="side-title"/>
										</cfinvoke>
									</div>									
								</td>
								<td style="width:790px" valign="top">
									<cfif len(trim(Get_Meta_Info.page_title)) gt 0>
										<div class="row">
											<div class="col-md-12">
												<h1 class="site-h1" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
											</div>
										</div>
									</cfif>
									<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_banner#
											</div>
										</div>
									</cfif>
									<div class="row">
										<div class="col-md-12 pad-top-10">
											<cfinvoke component="#arguments.component_name#" method="#arguments.method_name#">
												<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
												<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
												<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
												<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
												<cfinvokeargument name="city" value="#arguments.city#"/>
												<cfinvokeargument name="state" value="#arguments.state#"/>
												<cfinvokeargument name="zip" value="#arguments.zip#"/>
												<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
											</cfinvoke>
										</div>
									</div>
									<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
										<div class="row">
											<div class="col-md-12">
												#Get_Meta_Info.page_footer#
											</div>
										</div>
									</cfif>
								</td>
							</tr>
						</table>
					</cfcase>
				</cfswitch>
			</div>			
		</div>
			
		<div class="section-links">
			<div class="container pad-top-10">
				<table style="width:100%;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="8"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="9"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="10"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
						<td style="width:20%" valign="top">
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="11"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</td>
					</tr>
				</table>
			</div>			
		</div>
	
	</cffunction>

</cfcomponent>