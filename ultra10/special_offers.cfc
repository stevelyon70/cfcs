<cfcomponent>

	<cffunction name="modern_legacy" description="shows legacy specials page" output="Yes" access="public">

		<cfset variables.n_u = 1 >
		<cfif #url.New_Used# eq "N" >
			<cfset variables.n_u = 1 >
		</cfif>
		<cfif #url.New_Used# eq "U" >
			<cfset variables.n_u = 2 >
		</cfif>
		
		<!--- 	0000-0402-999-01-EF7A0D3FB6  northpointe GM
				0000-0244-999-01-8146767000  northpointe CDJR
		 --->
		

<!--  special_offers -->
    <cfquery datasource="Ultra10" name="Get_Specials" result="r1">
    	select * from (
    
			SELECT		Special_Title,
						Vehicle_Name,
						Vehicle_Year,
						Make,
						Model,
						Vehicle_Specials.Dealer_id,
                        <!---<cfif cgi.remote_addr eq '172.16.25.102'>--->
                        <!--- vehicles.Img_Urls as  --->Vehicle_Image,	 <!--- 03-02-2016 bob --->	
                        <!---<cfelse>
						Vehicle_Image,
                        </cfif>--->
						Was_Price,
						Is_Price,
						Special_Desc,
						Special_Footer,
						Vehicle_Specials.Vin, Vehicle_Special_ID,
						Special_Type,
						Link,
						Start_Date, 
		                Expiration_Date,
						Bullet_1,
						Bullet_2,
						Bullet_3,
						Bullet_4,
						Bullet_5,
						Hierarchy
			FROM		Vehicle_Specials inner join vehicles on Vehicle_Specials.vin = vehicles.vin
			<cfif url.dealer_id EQ 43 
				or url.dealer_id EQ 78 
				or url.dealer_id EQ 79
				 or url.dealer_id EQ 82
				  or url.dealer_id EQ 24> <!--- Faulkner Nissan Harrisburg & Jenkintown Seperate Special Offers --->
				WHERE 		Vehicle_Specials.dealer_ID = <cfqueryparam value="#url.dealer_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">  
                	 AND Special_class_id= '#variables.n_u#'  
			<cfelse>
            WHERE		Vehicle_Specials.Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4">
						<cfif len(trim(url.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.new_used#" maxlength="1">
						</cfif>
					)
            
				<!---WHERE 		dealer_ID IN (SELECT DISTINCT Shared_Dealercode FROM Inventory_Share WHERE dealer_ID=<cfqueryparam value="#url.dealer_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30"> AND New_Used=<cfqueryparam value="#url.New_Used#" cfsqltype="CF_SQL_VARCHAR" maxlength="1">)--->
			</cfif>
			AND 		Special_Class_ID=<cfqueryparam value="#url.Special_Class_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="2">
			AND 		Start_Date <= GETDATE()
			AND 		(Expiration_Date >= GETDATE() or Expiration_Date is NULL)
			AND Special_Type = 'Specific'  
			<cfif #url.dealer_id# EQ 375 AND #url.new_used# EQ "N">		<!--- Fuccillo Mazda  --->
            AND 		Make = 'Mazda'
			</cfif>
            UNION 
            
            SELECT		Special_Title,
						Vehicle_Name,
						Vehicle_Year,
						Make,
						Model,
						Vehicle_Specials.Dealer_id,
						Vehicle_Image,
						Was_Price,
						Is_Price,
						Special_Desc,
						Special_Footer,
						Vehicle_Specials.Vin, Vehicle_Special_ID,
						Special_Type,
						Link,
						Start_Date, 
		                Expiration_Date,
						Bullet_1,
						Bullet_2,
						Bullet_3,
						Bullet_4,
						Bullet_5,
						Hierarchy
			FROM		Vehicle_Specials
			<cfif url.dealer_id EQ 43 
				or url.dealer_id EQ 78 
				or url.dealer_id EQ 79				
				 or url.dealer_id EQ 82
				  or url.dealer_id EQ 24> <!--- Faulkner Nissan Harrisburg & Jenkintown Seperate Special Offers --->
				WHERE 		Vehicle_Specials.dealer_ID = <cfqueryparam value="#url.dealer_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">  
                	 AND Special_class_id= '#variables.n_u#'  
			<cfelse>
            WHERE		Vehicle_Specials.Dealer_ID IN 
					(	SELECT 	Distinct Share_ID 
						FROM 	dbo.Dealer_Shares 
						WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4">
						<cfif len(trim(url.new_used)) gt 0>
							AND		New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.new_used#" maxlength="1">
						</cfif>
					)
            
				<!---WHERE 		dealer_ID IN (SELECT DISTINCT Shared_Dealercode FROM Inventory_Share WHERE dealer_ID=<cfqueryparam value="#url.dealer_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30"> AND New_Used=<cfqueryparam value="#url.New_Used#" cfsqltype="CF_SQL_VARCHAR" maxlength="1">)--->
			</cfif>
			AND 		Special_Class_ID=<cfqueryparam value="#url.Special_Class_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="2">
			AND 		Start_Date <= GETDATE()
			AND 		(Expiration_Date >= GETDATE() or Expiration_Date is NULL)
			AND (Special_Type = 'Search'	or Special_Type = 'Generic')
             
			<cfif #url.dealer_id# EQ 375 AND #url.new_used# EQ "N">		<!--- Fuccillo Mazda  --->
            AND 		Make = 'Mazda'
			</cfif>
            
            
            ) as tbl
            
            
            
			<cfif #url.dealer_id# NEQ 35 >
				ORDER BY Hierarchy
			<cfelse>	
				ORDER BY dealer_id desc, Hierarchy asc
			</cfif>
		</cfquery>
        
		<cfif Get_Specials.Recordcount gt 0>
        
        
			<cfset variables.img_url="http://#cgi.server_name#/images/inventory">
			<cfloop query="Get_Specials">
	<!--- *********************
	
	get first img from vehicle table if type is specific 
	
	****************************  --->
				
                <!---<cfif cgi.remote_addr eq '172.16.25.102'>--->
				<cfif Get_Specials.Special_Type is 'specific'>
                <cftry>
                	<cfset Get_Specials.Vehicle_Image = listgetat(Get_Specials.Vehicle_Image,1)>
                   	<cfcatch><cfset Get_Specials.Vehicle_Image = ""></cfcatch>
                </cftry>
                </cfif>
                <!---</cfif>--->
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
						<!--- vehicle special image. pulled from ultra8--->
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
									<div class="col-md-12" align="right">
										<cfif isvalid("integer",Get_Specials.Was_Price) eq "Yes"><cfif Get_Specials.Was_Price gt 0><div class="legacy-spc-was"><b><cfif url.dealer_id is 65 or url.dealer_id is 68 or dealer_id is 326>KBB RETAIL<cfelse>WAS</cfif> : #dollarformat(Get_Specials.Was_Price)#</b></div></cfif></cfif>
									</div>
									<!--- <div class="col-md-6" align="right">
										<cfif isvalid("integer",Get_Specials.Is_Price) eq "Yes"><cfif Get_Specials.Is_Price gt 0><div class="legacy-spc-now">NOW : #dollarformat(Get_Specials.Is_Price)#</div></cfif> </cfif>
									</div> --->
								</div>
								<div class="row">
									<!--- <div class="col-md-6">
										<cfif isvalid("integer",Get_Specials.Was_Price) eq "Yes"><cfif Get_Specials.Was_Price gt 0><div class="legacy-spc-was">WAS : #dollarformat(Get_Specials.Was_Price)#</div></cfif></cfif>
									</div> --->
									<div class="col-md-12" align="right">
										<cfif #url.dealer_id# eq 200>
										<cfif isvalid("integer",Get_Specials.Is_Price) eq "Yes"><cfif Get_Specials.Is_Price gt 0><div class="legacy-spc-now">SALE PRICE : #dollarformat(Get_Specials.Is_Price)#</div></cfif> </cfif>
										<cfelse>
										<cfif isvalid("integer",Get_Specials.Is_Price) eq "Yes"><cfif Get_Specials.Is_Price gt 0><div class="legacy-spc-now"><cfif url.dealer_id is 65 or url.dealer_id is 68 or dealer_id is 326>OUR PRICE<cfelse>NOW</cfif> : #dollarformat(Get_Specials.Is_Price)#</div></cfif> </cfif>
										</cfif>
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
									<a class="btn btn-grey" href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Specials.Vin#"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>View Details</a>
								</div>
							</cfif>
							<cfif Get_Specials.Special_Type eq "Search">
								<div class="col-md-3 legacy-spc-btn">
									<a class="btn btn-grey" href="http://#cgi.server_name#/vehicles/srp_action.cfm?year=#trim(Get_Specials.Vehicle_Year)#&make=#trim(Get_Specials.Make)#&model=#trim(Get_Specials.Model)#&new_used=<cfif url.Special_Class_ID eq 1>n<cfelse>u</cfif>"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="Search Inventory"/>Search Inventory</a>
								</div>
							</cfif>
							<cfif Get_Specials.Special_Type eq "Generic">
								<div class="col-md-3 legacy-spc-btn">
									<cfif len(trim(replace(Get_Specials.Link,"http://",""))) gt 0>
										<a class="btn btn-grey" href="#Get_Specials.Link#"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>View Details</a>
									<cfelse>
										<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalrfq"><img class="btn-icon" src="#variables.img_url#/icon_SM_Details_off.png" alt="View Details"/>View Details</a>
									</cfif>
								</div>
							</cfif>							
							<div class="col-md-3 legacy-spc-btn">
								<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalrfq"><img class="btn-icon" src="#variables.img_url#/icon_SM_Info_off.png" alt="Request Info"/>Request Info</a>
							</div>
							<div class="col-md-3 legacy-spc-btn">
								<a class="btn btn-grey" data-toggle="modal" data-target="###Get_Specials.Vin#Modalqq"><img class="btn-icon" src="#variables.img_url#/icon_SM_GetQuote_off.png" alt="Contact Dealer"/>Contact Dealer</a>
							</div>
							<div class="col-md-3 legacy-spc-btn">								
                                <cfif arguments.dealer_id eq 264>
                                <a class="btn btn-grey" href="https://secure.worlddealer.net/fiveliner.cfm?dealercode=0082-0002-999-01-430516841C" title="Calculate Payment" target="_blank"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" alt="Calculate Payment"/>
                                Finance Application
                                </a>
                                <cfelseif arguments.dealer_id eq 265>
                                <a class="btn btn-grey" href="https://secure.worlddealer.net/finance.cfm?dealercode=0082-0001-999-01-5138298022" title="Calculate Payment" target="_blank"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" alt="Calculate Payment"/>                                Finance Application
                                </a>
                                <cfelse>
                                <a class="btn btn-grey" href="http://#cgi.server_name#/finance/calculator.cfm?price=#Get_Specials.Is_Price#" title="Calculate Payment" target="_blank"><img class="btn-icon" src="#variables.img_url#/icon_SM_Finance_off.png" alt="Calculate Payment"/>
                                Calculate Payment
                                </a>
                                </cfif>                                
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 legacy-spc-disclaimer">
								#Get_Specials.Special_Footer#
							</div>
						</div>
					</div>
				</div>
				<cfinvoke component="/cfcs/ultra10/popups" method="quick_quote">
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
				<cfinvoke component="/cfcs/ultra10/popups" method="rfq">
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
				<div class="col-md-12">
					<h1 class="legacy-spc-desc" title="Special Offers">Specials at #url.dealer_name#</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12" style="padding:100px 0px 100px 0px;" align="center">
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<h3>Please call or stop by for details on our current offers.</h3>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
				</div>
			</div>
		</cfif>


	</cffunction>

	<cffunction name="legacy_legacy" description="shows legacy specials page" output="Yes" access="public">

		<cfset variables.n_u = 1 >
		<cfif #url.New_Used# eq "N" >
			<cfset variables.n_u = 1 >
		</cfif>
		<cfif #url.New_Used# eq "U" >
			<cfset variables.n_u = 2 >
		</cfif>
		
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
			
			<cfif #url.Dealercode# EQ "0046-0018-999-01-5C86C17B1C" or #url.Dealercode# EQ "0046-0004-999-01-2158878870" > <!--- Faulkner Nissan Harrisburg & Jenkintown Seperate Special Offers --->
				WHERE 		Dealercode = <cfqueryparam value="#url.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">   AND Special_class_id= '#variables.n_u#'  
			<cfelse>
				WHERE 		Dealercode IN (SELECT DISTINCT Shared_Dealercode FROM Inventory_Share WHERE Dealercode=<cfqueryparam value="#url.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30"> AND New_Used=<cfqueryparam value="#url.New_Used#" cfsqltype="CF_SQL_VARCHAR" maxlength="1">)
			</cfif>
			AND 		Special_Class_ID=<cfqueryparam value="#url.Special_Class_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="2">
			AND 		Start_Date <= GETDATE()
			AND 		(Expiration_Date >= GETDATE() or Expiration_Date is NULL)
			ORDER BY Hierarchy
		</cfquery>
		
		<cfset variables.img_url="http://#cgi.server_name#/images/inventory">
		<table style="width:100%;">
		
		<cfif Get_Specials.Recordcount gt 0>
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
									<img style="width:250px" alt="#Get_Specials.Special_Title#"  src="#Get_Specials.Vehicle_Image#"/>
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
													<img style="display:block;float:left" alt="Request Info"  class="btn-icon" src="#variables.img_url#/icon_SM_Info_off.png" />
													<span style="display:block;float:left;padding:9px 0px 0px 0px;">Request Info</span>
													<div style="clear:both"></div>
												</a>
											</td>
											<td style="width:33%;">
												<a style="display:block" class="btn btn-grey" href="javascript:void(null)" onclick="window.open('http://#cgi.server_name#/vehicles/quote_pop.cfm?vin=#Get_Specials.Vin#&title=Contact Dealer about','qqWindow','width=300,height=300,toolbar=no,scrollbars=no,resizable=no')">
													<img style="display:block;float:left" alt="Contact Dealer" class="btn-icon" src="#variables.img_url#/icon_SM_GetQuote_off.png" />
													<span style="display:block;float:left;padding:9px 0px 0px 0px;">Contact Dealer</span>
													<div style="clear:both"></div>
												</a>
											</td>
											<td style="width:33%;">									
												<a style="display:block" class="btn btn-grey" href="http://#cgi.server_name#/finance/calculator.cfm?price=#Get_Specials.Is_Price#">
													<img style="display:block;float:left" class="btn-icon" alt="Calculate Payment" src="#variables.img_url#/icon_SM_Finance_off.png" />
													<span style="display:block;float:left;padding:9px 0px 0px 0px;">Calculate Payment</span>
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

		<cfelse>
			<tr>
				<td>
					<table style="width:100%">
						<tr>
							<td colspan="2" align="center">
								<h2 class="legacy-spc-title" title="#Get_Specials.Special_Title#">#Get_Specials.Special_Title#</h2>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<h3>Please call or stop by for details on our current offers.</h3>
							</td>
						</tr>
					</table>	
		</cfif>			
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