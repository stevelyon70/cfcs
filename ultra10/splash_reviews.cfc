<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Reviews">
			SELECT		Top 1
						Dealers.Display_Name,
						Dealers.DealeRater_Link,
						DealerRater_Reviews.Review_Date,
						DealerRater_Reviews.Positive,
						DealerRater_Reviews.Review_User,
						DealerRater_Reviews.Employees, 
			            DealerRater_Reviews.Department,
						DealerRater_Reviews.Review_Comments,
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
				<cfcase value="0098-0004-999-01-7FB738A51C">
					WHERE		DealerRater_Reviews.Dealercode = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0098-0004-999-01-7FB738A51C" maxlength="30">
				</cfcase>
			</cfswitch>
			AND			DealerRater_Reviews.Positive = 1
			AND			DealerRater_Reviews.Rating_Overall > 3
			ORDER BY 	NEWID() <!---Gets Random item from query --->
		</cfquery>

		<cfif Get_Reviews.Recordcount gt 0>
			<div class="row dr-review">
				<div class="col-md-2">
					<a class="spl-review-read" href="http://#cgi.server_name#/reviews" title="Read Our Reviews">Read Our Reviews</a>
				</div>
				<div class="col-md-2" align="center">
					<cfloop from="1" to="#round(Get_Reviews.Overall_Score/5)#" index="i"><img alt="#Get_Reviews.Overall_Score/5# Star Review" src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Overall_Score/5# Star Review" />&nbsp;</cfloop><br/>
					<div style="padding-top:10px;"><b class="dr-overall">#Get_Reviews.Overall_Score/5#</b></div>
				</div>
				<div class="col-md-6">
					<b>#left(Get_Reviews.Review_Comments,50)# ...</b>
					<div class="spl-review-comments">#left(Get_Reviews.Review_Comments,200)#<br/><a class="pull-right" href="http://#cgi.server_name#/reviews">read more</a></div>
				</div>
				<div class="col-md-2" align="center">
					<a class="spl-dr-write" href="#Get_Reviews.DealeRater_Link#" target="_blank">Write a Review</a>
				</div>
			</div>
		</cfif>

	
	</cffunction>

	<cffunction name="modern_standard_new" description="shows standard dealer hours" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Reviews">
			SELECT		Top 1
						DealerRater_Reviews.Review_Date,
						DealerRater_Reviews.Positive,
						DealerRater_Reviews.Review_User,
						DealerRater_Reviews.Employees, 
			            DealerRater_Reviews.Department,
						DealerRater_Reviews.Review_Comments,
						DealerRater_Reviews.Rating_CustomerService+DealerRater_Reviews.Rating_Friendliness+DealerRater_Reviews.Rating_Overall+DealerRater_Reviews.Rating_Price+DealerRater_Reviews.Rating_Quality as Overall_Score
			FROM        DealerRater_Reviews
			WHERE		DealerRater_Reviews.Dealercode = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0098-0004-999-01-7FB738A51C" maxlength="30">
			AND			DealerRater_Reviews.Positive = 1
			AND			DealerRater_Reviews.Rating_Overall > 3
			ORDER BY 	NEWID() <!---Gets Random item from query --->
		</cfquery>

		<cfif Get_Reviews.Recordcount gt 0>
			<div class="row dr-review">
				
				<div class="col-md-8 col-md-offset-1"  align="left">
					<b>#Get_Reviews.Review_User#</b>
					<cfloop from="1" to="#round(Get_Reviews.Overall_Score/5)#" index="i"><img alt="#Get_Reviews.Overall_Score/5# Star Review" src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Overall_Score/5# Star Review" />&nbsp;</cfloop><br/>
					
					<div class="spl-review-comments">#Get_Reviews.Review_Comments#<!--- <br/><a class="pull-right" href="http://#cgi.server_name#/reviews">read more</a> ---></div>
				</div>
				<div class="col-md-2" align="center">
					<cfif #url.dealer_id# NEQ 365 >
					<a class="spl-review-read" href="http://#cgi.server_name#/reviews" title="Read Our Reviews">READ ALL REVIEWS</a>
					<cfelse>
					<a class="spl-review-read" href="http://#cgi.server_name#/dealer/kellynissan_bld/customer_reviews.cfm " title="Read All Reviews">READ ALL REVIEWS</a>
					</cfif>
				</div>
			</div>
		</cfif>

	
	</cffunction>

	<cffunction name="modern_standard_stacked" description="shows reviews stacked" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Reviews">
			SELECT		Top 1
						Dealers.Display_Name,
						Dealers.DealeRater_Link,
						DealerRater_Reviews.Review_Date,
						DealerRater_Reviews.Positive,
						DealerRater_Reviews.Review_User,
						DealerRater_Reviews.Employees, 
			            DealerRater_Reviews.Department,
						DealerRater_Reviews.Review_Comments,
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
			ORDER BY 	NEWID() <!---Gets Random item from query --->
		</cfquery>

		<cfif Get_Reviews.Recordcount gt 0>
			<div class="row dr-review">
				<div class="col-md-12" align="left">
					<cfloop from="1" to="#round(Get_Reviews.Overall_Score/5)#" index="i"><img alt="#Get_Reviews.Overall_Score/5# Star Review" src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Overall_Score/5# Star Review" />&nbsp;</cfloop><br/>
					<!--- <div style="padding-top:10px;"><b class="dr-overall">#Get_Reviews.Overall_Score/5#</b></div> --->
				</div>
			</div>	
			<div class="row dr-review">
				<div class="col-md-12"><br>
					<!--- <b>#left(Get_Reviews.Review_Comments,50)# ...</b> --->
					<div class="spl-review-comments">#left(Get_Reviews.Review_Comments,200)#<br/></div>
				</div>
			</div>	
			<div class="row dr-review">
				<div class="col-md-12" align="center">
					<!--- <input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://#cgi.server_name#/dealer/#url.assets#/testimonials.cfm';"> --->
					<cfif #url.dealer_id# eq 30>
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://ronhibbardtoyota.com/dealer/ronhibbard/dealerrater_reviews.cfm';">
					<cfelseif #url.dealer_id# eq 3 >
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://baierlcadillac.com/dealer/baierlcadillac/dealerrater_reviews.cfm';">
					<cfelseif #url.dealer_id# eq 4 >
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://baierlchevrolet.com/dealer/baierlchevrolet/dealerrater_reviews.cfm';">
					<cfelseif #url.dealer_id# eq 6 >
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://baierlford.com/dealer/baierlford/dealerrater_reviews.cfm';">
					<cfelseif #url.dealer_id# eq 7 >
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://baierlhonda.com/dealer/baierlhonda/dealerrater_reviews.cfm';">
					<cfelseif #url.dealer_id# eq 8 >
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://baierlkia.com/dealer/baierlkia/dealerrater_reviews.cfm';">
					<cfelseif #url.dealer_id# eq 12 >
						<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://baierltoyota.com/dealer/baierltoyota/dealerrater_reviews.cfm';">
					<cfelse>
					<input class="blk2-btn" name="Button_Go" type="submit" value="Read More" onClick="javascript:self.location='http://#cgi.server_name#/reviews';">
					</cfif>
					<!--- <a class="pull-right" href="http://#cgi.server_name#/reviews">read more</a> --->
				</div>
			</div>	
			<div class="row dr-review">
				<div class="col-md-12" align="center">
					<cfif #url.dealer_id# eq 1 >
					 <form  action="dealer/baierl/write_a_review.cfm"> <input class="blk2-btn" name="Button_Go" type="submit" value="Write a Review" > </form> 
					<cfelseif #url.dealer_id# eq 14 >
					 <form  action="dealer/baierlbudgetcars/write_a_review.cfm"> <input class="blk2-btn" name="Button_Go" type="submit" value="Write a Review" > </form> 
					<cfelse>
					 <form target="_blank" action="#Get_Reviews.DealeRater_Link#"> <input class="blk2-btn" name="Button_Go" type="submit" value="Write a Review" > </form> 
					</cfif>
					 <!---  <a type="button" class="blk2-btn" href="#Get_Reviews.DealeRater_Link#" value="Write a Review"  target="_blank"></a> --->  
					 
				</div>
			</div>
		</cfif>

	
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Reviews">
			SELECT		Top 1
						Dealers.Display_Name,
						Dealers.DealeRater_Link,
						DealerRater_Reviews.Review_Date,
						DealerRater_Reviews.Positive,
						DealerRater_Reviews.Review_User,
						DealerRater_Reviews.Employees, 
			            DealerRater_Reviews.Department,
						DealerRater_Reviews.Review_Comments,
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
			ORDER BY 	NEWID() <!---Gets Random item from query --->
		</cfquery>	

		<cfif Get_Reviews.Recordcount gt 0>
			<table style="width:100%;" cellpadding="0" cellspacing="0" class="dr-review">
				<tr>
					<td style="padding:10px" align="center">
						<a class="spl-review-read" href="http://#cgi.server_name#/reviews" title="Read Our Reviews">Read Our Reviews</a>						
					</td>
					<td style="width:150px" align="center">
						<cfloop from="1" to="#round(Get_Reviews.Overall_Score/5)#" index="i"><img alt="#Get_Reviews.Overall_Score/5# Star Review" src="http://#cgi.server_name#/images/logos/review-star-sm.png" title="#Get_Reviews.Overall_Score/5# Star Review" />&nbsp;</cfloop><br/>
						<div style="padding-top:10px;"><b class="dr-overall">#Get_Reviews.Overall_Score/5#</b></div>												
					</td>
					<td>
						<b>#left(Get_Reviews.Review_Comments,50)# ...</b>
						<div class="spl-review-comments">#left(Get_Reviews.Review_Comments,200)#<br/><a class="pull-right" href="http://#cgi.server_name#/reviews">read more</a></div>												
					</td>
					<td style="padding:10px" align="center">
						<a class="spl-dr-write" href="#Get_Reviews.DealeRater_Link#" target="_blank">Write a Review</a>			
					</td>
				</tr>
			</table>
		</cfif>
	
	</cffunction>

</cfcomponent>
