<cfcomponent>

	<cffunction name="modern_dealerrater" description="shows standard dealerrater display" output="Yes" access="public">
	
		<cfquery datasource="Ultra8" name="Get_Reviews">
			SELECT		Dealers.Display_Name,
						DealerRater_Reviews.Review_ID,
						DealerRater_Reviews.Review_Date,
						DealerRater_Reviews.Positive,
						DealerRater_Reviews.Review_User,
						DealerRater_Reviews.Employees, 
			            DealerRater_Reviews.Department,
						DealerRater_Reviews.Review_Comments,
						DealerRater_Reviews.Perma_Link,
						DealerRater_Reviews.Rating_CustomerService,
						DealerRater_Reviews.Rating_Friendliness,
						DealerRater_Reviews.Rating_Overall,
						DealerRater_Reviews.Rating_Price,
						DealerRater_Reviews.Rating_Quality,
						DealerRater_Reviews.Rating_CustomerService+DealerRater_Reviews.Rating_Friendliness+DealerRater_Reviews.Rating_Overall+DealerRater_Reviews.Rating_Price+DealerRater_Reviews.Rating_Quality as Overall_Score
			FROM        DealerRater_Reviews
			INNER JOIN	Dealers
			ON			DealerRater_Reviews.Dealercode = Dealers.Dealercode
			<cfswitch expression="#url.Dealercode#">
				<cfdefaultcase>
					WHERE		DealerRater_Reviews.Dealercode IN (SELECT DISTINCT Shared_Dealercode FROM Inventory_Share WHERE Dealercode=<cfqueryparam value="#url.Dealercode#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">)
				</cfdefaultcase>
				<cfcase value="0014-0008-999-01-7249353718">
					WHERE		DealerRater_Reviews.Dealercode = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0014-0038-999-01-C7D035FA1C" maxlength="30">
				</cfcase>
			</cfswitch>
			AND			DealerRater_Reviews.Positive = 1
			AND			DealerRater_Reviews.Rating_Overall > 3
			ORDER BY	DealerRater_Reviews.Review_Date DESC
		</cfquery>

		<cfparam name="URL.page" default="1">
		<cfset variables.pageSize = 10>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(Get_Reviews.recordCount / variables.pageSize)>
		<cfif variables.endRow GT Get_Reviews.recordCount><cfset variables.endRow = Get_Reviews.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>

		<div class="row">
			<div class="col-md-12  visible-md visible-lg">
				<cfinvoke component="/cfcs/ultra10/reviews" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Reviews.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<cfloop query="Get_Reviews" startrow="#variables.startRow#" endrow="#variables.endRow#">
			<div class="row dr-review">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6">
							User: <b>#Get_Reviews.Review_User#</b><br />
							Date: <b>#dateformat(Get_Reviews.Review_Date,"mm/dd/yyyy")# #timeformat(Get_Reviews.Review_Date,"h:mm tt")#</b><br /><br />
							Reason For Visit: <b>#Get_Reviews.Department#</b><br />
							Employee(s) Dealt With: <b>#Get_Reviews.Employees#</b><br /><br />
						</div>
						<div class="col-md-6">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td>Customer Service:&nbsp;</td>
									<td><cfloop from="1" to="#Get_Reviews.Rating_CustomerService#" index="i"><img alt="#Get_Reviews.Rating_Friendliness# Star Review"  src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Rating_CustomerService# Star Review" /></cfloop></td>
									<td align="center"><b>#Get_Reviews.Rating_CustomerService#</b></td>
								</tr>
								<tr>
									<td>Quality of Work:&nbsp;</td>
									<td><cfloop from="1" to="#Get_Reviews.Rating_Quality#" index="i"><img alt="#Get_Reviews.Rating_Friendliness# Star Review"  src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Rating_Quality# Star Review" /></cfloop></td>
									<td align="center"><b>#Get_Reviews.Rating_Quality#</b></td>
								</tr>
								<tr>
									<td>Friendliness:&nbsp;</td>
									<td><cfloop from="1" to="#Get_Reviews.Rating_Friendliness#" index="i"><img alt="#Get_Reviews.Rating_Friendliness# Star Review"  src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Rating_Friendliness# Star Review" /></cfloop></td>
									<td align="center"><b>#Get_Reviews.Rating_Friendliness#</b></td>
								</tr>
								<tr>
									<td>Overall Experience:&nbsp;</td>
									<td><cfloop from="1" to="#Get_Reviews.Rating_Overall#" index="i"><img alt="#Get_Reviews.Rating_Price# Star Review"  src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Rating_Overall# Star Review" /></cfloop></td>
									<td align="center"><b>#Get_Reviews.Rating_Overall#</b></td>
								</tr>
								<tr>
									<td>Price:&nbsp;</td>
									<td><cfloop from="1" to="#Get_Reviews.Rating_Price#" index="i"><img alt="#Get_Reviews.Rating_Price# Star Review" src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Rating_Price# Star Review" /></cfloop></td>
									<td align="center"><b>#Get_Reviews.Rating_Price#</b></td>
								</tr>
								<tr style="border-top:2px solid black;">
									<td><b>Overall Score:</b>&nbsp;</td>
									<td><cfloop from="1" to="#round(Get_Reviews.Overall_Score/5)#" index="i"><img alt="#Get_Reviews.Overall_Score/5# Star Review"  src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Overall_Score/5# Star Review" /></cfloop></td>
									<td style="padding-top:5px;"><b class="dr-overall">#Get_Reviews.Overall_Score/5#</b></td>
								</tr>
							</table>
							<br />
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<b style="margin-bottom:5px;">My Review of #Get_Reviews.Display_Name#</b><br />
							#Get_Reviews.Review_Comments#							
						</div>
					</div>
				</div>
			</div>
		</cfloop>
		<div class="row">
			<div class="col-md-12  visible-md visible-lg">
				<cfinvoke component="/cfcs/ultra10/reviews" method="pagination">
					<cfinvokeargument name="Recordcount" value="#Get_Reviews.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 visible-xs visible-sm">
				<cfinvoke component="/cfcs/ultra10/reviews" method="pagination_next">
					<cfinvokeargument name="Recordcount" value="#Get_Reviews.Recordcount#"/>
				</cfinvoke>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<a href="http://www.dealerrater.com" target="_blank">
					<img class="img-responsive pull-right" alt="Reviews"  src="http://#cgi.server_name#/images/logos/reviews_by_dealerrater.png"  />
				</a>
			</div>
		</div>
	
	</cffunction>

	<cffunction name="legacy_dealerrater" description="shows legacy dealerrater display" output="Yes" access="public">

	</cffunction>

	<cffunction name="pagination" description="blog pagination" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="Recordcount" required="true" />

		<!---parameters--->
		<cfparam name="url.page" default="1">
		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 10>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(arguments.recordCount / variables.pageSize)>
		<cfif variables.endRow GT arguments.recordCount><cfset variables.endRow = arguments.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>

		<div class="col-md-3 srp-page-pad">
			Page #variables.page# of #variables.totalPages#
		</div>
		<div class="col-md-9 no-pad">
			<ul class="pagination pagination-sm pull-right">
				<li><a class="srp-page-link" href="http://#cgi.server_name##cgi.script_name#?&page=1">first</a></li>
					<cfloop index="p" from="#variables.page_start#" to="#variables.page_end#">
						<cfif p gt 0>
							<li><a <cfif url.page eq p>class="srp-page-link-active"<cfelse>class="srp-page-link"</cfif> href="http://#cgi.server_name##cgi.script_name#?&page=#p#">#p#</a></li>
						</cfif>
					</cfloop>
				<li><a class="srp-page-link" href="http://#cgi.server_name##cgi.script_name#?&page=#variables.totalPages#">last</a></li>
			</ul>
		</div>
	
	</cffunction>


	<cffunction name="pagination_next" description="blog pagination" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="Recordcount" required="true" />

		<!---parameters--->
		<cfparam name="url.page" default="1">
		<cfset URL.page=ReReplaceNoCase(URL.page,'[^0-9]','','ALL')>
		<cfset variables.pageSize = 5>
		<cfset variables.page = URL.page>
		<cfset variables.startRow = (variables.page - 1) * variables.pageSize + 1>
		<cfset variables.endRow = variables.startRow + variables.pageSize - 1>
		<cfset variables.totalPages = ceiling(arguments.recordCount / variables.pageSize)>
		<cfif variables.endRow GT arguments.recordCount><cfset variables.endRow = arguments.recordCount></cfif>
		<cfset variables.page_start=URL.page>
		<cfif variables.page_start+variables.pageSize lt variables.totalPages>
			<cfset variables.page_end=variables.page_start+variables.pageSize>
		<cfelse>
			<cfset variables.page_start=variables.totalPages-variables.pageSize>
			<cfset variables.page_end=variables.totalPages>
		</cfif>
		<cfif variables.totalPages lt variables.pageSize or variables.totalPages eq 5>
			<cfset variables.page_start=1>
			<cfset variables.page_end=variables.totalPages>
		</cfif>

		<div class="col-md-12" align="center">
			Page #variables.page# of #variables.totalPages#
		</div>
		<div class="col-md-12 no-pad">
			<ul class="pager">
				<cfif url.page gt 1>
					<li><a href="http://#cgi.server_name##cgi.script_name#?&page=#url.page-1#">Previous</a></li>
				<cfelse>
					<li class="disabled"><a>Previous</a></li>
				</cfif>
				<cfif url.page lt variables.totalPages>
					<li><a href="http://#cgi.server_name##cgi.script_name#?&page=#url.page+1#">Next</a></li>
				<cfelse>
					<li class="disabled"><a>Next</a></li>
				</cfif>
			</ul>
		</div>
	
	</cffunction>

</cfcomponent>