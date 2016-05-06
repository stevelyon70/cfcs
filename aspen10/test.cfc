<cfcomponent>

	<cffunction name="modern_legacy" description="shows legacy specials page" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Specials">
			SELECT		Special_Title,
						Vehicle_Name,
						Vehicle_Year,
						Make,
						Model,
						Dealercode,
						Vehicle_Image,
						Was_Price,
						Is_Price,
						Special_Desc,
						Special_Footer,
						Vin,
						Special_Type,
						Link,
						Start_Date, 
		                Expiration_Date,
						Dealercode,
						Bullet_1,
						Bullet_2,
						Bullet_3,
						Bullet_4,
						Bullet_5
			FROM		Vehicle_Specials
			WHERE 		Dealercode IN (SELECT DISTINCT Shared_Dealercode FROM Inventory_Share WHERE Dealercode=<cfqueryparam value="#url.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30"> AND New_Used=<cfqueryparam value="#url.New_Used#" cfsqltype="CF_SQL_VARCHAR" maxlength="1">)
			AND 		Special_Class_ID=<cfqueryparam value="#url.Special_Class_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="2">
			AND 		Start_Date <= GETDATE()
			AND 		(Expiration_Date >= GETDATE() or Expiration_Date is NULL)
			ORDER BY Hierarchy
		</cfquery>

		<cfif Get_Specials.Recordcount gt 0>
			<cfset variables.img_url="http://#cgi.server_name#/images/inventory">
			<cfloop query="Get_Specials">

				<cfif len(trim(Get_Specials.Vehicle_Image)) eq 0>
					<cfset Get_Specials.Vehicle_Image="http://#cgi.server_name#/images/inventory/ph_coming_soon.jpg">
				</cfif>

				<div class="row legacy-spc-container" style="color:black;">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12">
								<h2 class="legacy-spc-desc" title="#Get_Specials.Special_Title#">#Get_Specials.Special_Title#</h2>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<img class="img-responsive" src="#Get_Specials.Vehicle_Image#"/>
							</div>
							<div class="col-md-8">
								<div class="row">
									<div class="col-md-12" align="center">
										<cfif len(trim(Get_Specials.Special_Desc)) gt 0><h3 class="legacy-spc-title">#REReplaceNoCase(Get_Specials.Special_Desc,"<[^>]*>","","ALL")#</h3></cfif>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<cfif isvalid("integer",Get_Specials.Was_Price) eq "Yes"><div class="legacy-spc-was">WAS : #dollarformat(Get_Specials.Was_Price)#</div></cfif>
									</div>
									<div class="col-md-6" align="right">
										<cfif isvalid("integer",Get_Specials.Is_Price) eq "Yes"><div class="legacy-spc-now">NOW : #dollarformat(Get_Specials.Is_Price)#</div></cfif> 
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<ul class="legacy-spc-bullets">
											<cfif len(trim(Get_Specials.Bullet_1)) gt 0><li>#Get_Specials.Bullet_1#</li></cfif>
											<cfif len(trim(Get_Specials.Bullet_2)) gt 0><li>#Get_Specials.Bullet_2#</li></cfif>
											<cfif len(trim(Get_Specials.Bullet_3)) gt 0><li>#Get_Specials.Bullet_3#</li></cfif>
											<cfif len(trim(Get_Specials.Bullet_4)) gt 0><li>#Get_Specials.Bullet_4#</li></cfif>
											<cfif len(trim(Get_Specials.Bullet_5)) gt 0><li>#Get_Specials.Bullet_5#</li></cfif>
											<cfif isvalid("date",Get_Specials.Expiration_Date) eq "Yes"><li>Offer Expires : #dateformat(dateadd("d","-1",Get_Specials.Expiration_Date),"mm/dd/yyyy")#</li></cfif>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<cfif Get_Specials.Special_Type eq "Specific">
								<div class="col-md-3 legacy-spc-btn">
									<a class="btn btn-grey" href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Specials.Vin#"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>VIEW DETAILS</a>
								</div>
							</cfif>
							<cfif Get_Specials.Special_Type eq "Search">
								<div class="col-md-3 legacy-spc-btn">
									<a class="btn btn-grey" href="http://#cgi.server_name#/vehicles/srp_action.cfm?year=#trim(Get_Specials.Vehicle_Year)#&make=#trim(Get_Specials.Make)#&model=#trim(Get_Specials.Model)#&new_used=<cfif url.Special_Class_ID eq 1>n<cfelse>u</cfif>"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="Search Inventory"/>Search inventory</a>
								</div>
							</cfif>
							<cfif Get_Specials.Special_Type eq "Generic">
								<div class="col-md-3 legacy-spc-btn">
									<cfif len(trim(replace(Get_Specials.Link,"http://",""))) gt 0>
										<a class="btn btn-grey" href="#Get_Specials.Link#"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>VIEW DETAILS</a>
									<cfelse>
										<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalrfq"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="VIEW DETAILS"/>VIEW DETAILS</a>
									</cfif>
								</div>
							</cfif>							
							<div class="col-md-3 legacy-spc-btn">
								<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalrfq"><img class="btn-icon" src="#variables.img_url#/icon_SM_Info_off.png" alt="REQUEST INFO"/>REQUEST INFO</a>
							</div>
							<div class="col-md-3 legacy-spc-btn">
								<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalqq"><img class="btn-icon" src="#variables.img_url#/icon_SM_GetQuote_off.png" alt="CONTACT DEALER"/>CONTACT DEALER</a>
							</div>
							<div class="col-md-3 legacy-spc-btn">
								<a class="btn btn-grey" href="http://#cgi.server_name#/finance/calculator.cfm?price=#Get_Specials.Is_Price#" title="CALCULATE MY PAYMENT" target="_blank"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" alt="CALCULATE MY PAYMENT"/>CALCULATE MY PAYMENT</a>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 legacy-spc-disclaimer">
								#Get_Specials.Special_Footer#
							</div>
						</div>
					</div>
				</div>
				<cfinvoke component="/cfcs/aspen10/popups" method="quick_quote">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="modal_name" value="#Get_Specials.Vin#Modalqq"/>
					<cfinvokeargument name="VOI_Vin" value="#Get_Specials.Vin#"/>
					<cfinvokeargument name="V_Year" value="#Get_Specials.Vehicle_Year#"/>
					<cfinvokeargument name="V_Make" value="#Get_Specials.Make#"/>
					<cfinvokeargument name="V_Model" value="#Get_Specials.Model#"/>
					<cfinvokeargument name="V_Trim" value=""/>
					<cfinvokeargument name="VOI_New_Used" value="#url.New_Used#"/>
					<cfinvokeargument name="Img_Urls" value="#Get_Specials.Vehicle_Image#"/>
				</cfinvoke>
				<cfinvoke component="/cfcs/aspen10/popups" method="rfq">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="modal_name" value="#Get_Specials.Vin#Modalrfq"/>
					<cfinvokeargument name="VOI_Vin" value="#Get_Specials.Vin#"/>
					<cfinvokeargument name="V_Year" value="#Get_Specials.Vehicle_Year#"/>
					<cfinvokeargument name="V_Make" value="#Get_Specials.Make#"/>
					<cfinvokeargument name="V_Model" value="#Get_Specials.Model#"/>
					<cfinvokeargument name="V_Trim" value=""/>
					<cfinvokeargument name="VOI_New_Used" value="#url.New_Used#"/>
					<cfinvokeargument name="Img_Urls" value="#Get_Specials.Vehicle_Image#"/>
				</cfinvoke>
			</cfloop>
		<cfelse>
			<div class="row">
				<div class="col-md-12" style="padding:100px 0px 100px 0px;" align="center">
					<h3>Please call or stop by for details on our current offers.</h3>
				</div>
			</div>
		</cfif>


	</cffunction>

	<cffunction name="legacy_legacy" description="shows legacy specials page" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Specials">
			SELECT		Special_Title,
						Vehicle_Name,
						Vehicle_Year,
						Make,
						Model,
						Dealercode,
						Vehicle_Image,
						Was_Price,
						Is_Price,
						Special_Desc,
						Special_Footer,
						Vin,
						Special_Type,
						Link,
						Start_Date, 
		                Expiration_Date,
						Dealercode,
						Bullet_1,
						Bullet_2,
						Bullet_3,
						Bullet_4,
						Bullet_5
			FROM		Vehicle_Specials
			WHERE 		Dealercode IN (SELECT DISTINCT Shared_Dealercode FROM Inventory_Share WHERE Dealercode=<cfqueryparam value="#url.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30"> AND New_Used=<cfqueryparam value="#url.New_Used#" cfsqltype="CF_SQL_VARCHAR" maxlength="1">)
			AND 		Special_Class_ID=<cfqueryparam value="#url.Special_Class_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="2">
			AND 		Start_Date <= GETDATE()
			AND 		(Expiration_Date >= GETDATE() or Expiration_Date is NULL)
			ORDER BY Hierarchy
		</cfquery>
		<cfset variables.img_url="http://#cgi.server_name#/images/inventory">
		<table style="width:100%;">
			<cfloop query="Get_Specials">

				<cfif len(trim(Get_Specials.Vehicle_Image)) eq 0>
					<cfset Get_Specials.Vehicle_Image="http://#cgi.server_name#/images/inventory/ph_coming_soon.jpg">
				</cfif>

				<tr>
					<td>
						<table style="width:100%;border:1px solid ##ccc;">
							<tr>
								<td colspan="2" align="center">
									<h2 class="legacy-spc-title" title="#Get_Specials.Special_Title#">#Get_Specials.Special_Title#</h2>
								</td>
							</tr>
							<tr>
								<td style="width:250px" valign="top">
									<img style="width:250px" src="#Get_Specials.Vehicle_Image#"/>
								</td>
								<td style="width:600px" valign="top">
									<table style="width:100%;">
										<tr>
											<td align="center" colspan="2">
												<h3 class="legacy-spc-desc">#REReplaceNoCase(Get_Specials.Special_Desc,"<[^>]*>","","ALL")#</h3>
											</td>
										</tr>
										<tr>
											<td align="center">
												<cfif isvalid("integer",Get_Specials.Was_Price) eq "Yes"><div class="legacy-spc-was">WAS : #dollarformat(Get_Specials.Was_Price)#</div></cfif>
											</td>
											<td align="center">
												<cfif isvalid("integer",Get_Specials.Is_Price) eq "Yes"><div class="legacy-spc-now">NOW : #dollarformat(Get_Specials.Is_Price)#</div></cfif>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<ul class="legacy-spc-bullets">
													<cfif len(trim(Get_Specials.Bullet_1)) gt 0><li>#Get_Specials.Bullet_1#</li></cfif>
													<cfif len(trim(Get_Specials.Bullet_2)) gt 0><li>#Get_Specials.Bullet_2#</li></cfif>
													<cfif len(trim(Get_Specials.Bullet_3)) gt 0><li>#Get_Specials.Bullet_3#</li></cfif>
													<cfif len(trim(Get_Specials.Bullet_4)) gt 0><li>#Get_Specials.Bullet_4#</li></cfif>
													<cfif len(trim(Get_Specials.Bullet_5)) gt 0><li>#Get_Specials.Bullet_5#</li></cfif>
													<cfif isvalid("date",Get_Specials.Expiration_Date) eq "Yes"><li>Offer Expires : #dateformat(dateadd("d","-1",Get_Specials.Expiration_Date),"mm/dd/yyyy")#</li></cfif>
												</ul>
											</td>
										</tr>											
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table style="width:100%;">
										<tr>
											<td style="width:33%;">
												<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/quote_pop.cfm?vin=#Get_Specials.Vin#&title=Request Info about','qqWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
													<img style="display:block;float:left" class="btn-icon" src="#variables.img_url#/icon_SM_Info_off.png" border="0"/>
													<span style="display:block;float:left;padding:9px 0px 0px 0px;">REQUEST INFO</span>
													<div style="clear:both"></div>
												</a>
											</td>
											<td style="width:33%;">
												<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/quote_pop.cfm?vin=#Get_Specials.Vin#&title=Contact Dealer about','qqWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
													<img style="display:block;float:left" class="btn-icon" src="#variables.img_url#/icon_SM_GetQuote_off.png" border="0"/>
													<span style="display:block;float:left;padding:9px 0px 0px 0px;">CONTACT DEALER</span>
													<div style="clear:both"></div>
												</a>
											</td>
											<td style="width:33%;">									
												<a style="display:block" class="btn btn-grey" href="http://#cgi.server_name#/finance/calculator.cfm?price=#Get_Specials.Is_Price#">
													<img style="display:block;float:left" class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" border="0"/>
													<span style="display:block;float:left;padding:9px 0px 0px 0px;">CALCULATE MY PAYMENT</span>
													<div style="clear:both"></div>
												</a>
											</td>
										</tr>											
									</table>
								</td>
							</tr>
							<cfif len(trim(Get_Specials.Special_Footer)) gt 0>
								<tr>
									<td class="legacy-spc-disclaimer" colspan="2">
										#Get_Specials.Special_Footer#			
									</td>
								</tr>
							</cfif>
						</table>
						<br/>
					</td>
				</tr>
			</cfloop>
		</table>

<!---								<div class="row">
						<div class="col-md-4 legacy-spc-btn">
							<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalrfq"><img class="btn-icon" src="#variables.img_url#/icon_SM_Info_off.png" title="REQUEST INFO"/>REQUEST INFO</a>
						</div>
						<div class="col-md-4 legacy-spc-btn">
							<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalqq"><img class="btn-icon" src="#variables.img_url#/icon_SM_GetQuote_off.png" title="CONTACT DEALER"/>CONTACT DEALER</a>
						</div>
						<div class="col-md-4 legacy-spc-btn">
							<a class="btn btn-grey" href="http://#cgi.server_name#/finance/calculator.cfm?price=#Get_Specials.Is_Price#" title="CALCULATE MY PAYMENT" target="_blank"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" title="CONTACT DEALER"/>CALCULATE MY PAYMENT</a>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 ">
							
						</div>
					</div>
				</div>
			</div>
		</cfloop>--->

	</cffunction>

</cfcomponent>