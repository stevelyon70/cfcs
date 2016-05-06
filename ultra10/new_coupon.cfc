<cfcomponent>

	<cffunction name="modern_standard_slider" description="shows coupons from legacy system" output="Yes" access="public">
 
	    <cfargument name="new_used" default="U">
	    <cfargument name="certified" default="0">
	    <cfargument name="price_ceiling" default="">
	    <cfargument name="results" default="12">
	    <cfargument name="carousel_class" default="carousel_v_rand">
	    <cfargument name="minSlides" default="2">
	    <cfargument name="maxSlides" default="20">
	    <cfargument name="auto" default="true">
	    <cfargument name="moveSlides" default="1">
	    <cfargument name="slideWidth" default="200">
	    <cfargument name="slideMargin" default="10">
	    <cfargument name="addScript" default="true"> 
	
		<cfparam name="url.Department" default="Show_All">
		<cfparam name="variables.Deparment_Name" default="">
		
		<cfset variables.nav_count=0>
		<!--- <cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfset variables.dealer_list="">
		<cfloop query="Get_Form_Locations">
			<cfset variables.dealer_list=listappend(variables.dealer_list,"'#Get_Form_Locations.Dealercode#'")>
		</cfloop> --->
		
		<cfquery name="get_dlr" datasource="Ultra10">SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #url.dealer_id#</cfquery> 
		<cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >
		<cfset variables.Display_Name = #get_dlr.Display_Name# >



<ul class="#arguments.carousel_class#" align="center">
		<cfloop query="Get_Nav">

			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				 <li class="slide #arguments.carousel_class#_slide">
					<div class="row">
						<div class="col-md-12" align="center">
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								 <a id="nav_#Get_Nav.nav_id#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img  class="nav_#Get_Nav.Nav_ID#  img-responsive " alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>	
							</cfif>
						</div>
					</div>
			 
				</li>
			</cfif>
		</cfloop>
</ul>






<!---  --->		
<!--- 		<cfquery datasource="Ultra10" name="Get_Coupon">
			SELECT		ID,
						Dealer_ID,
						HeaderImage,
						Title,
						Description_top,
						Desription_bottom,
						use_prt_img, 
						img_link_only ,
						link_address ,  
						inside_box , 
						Expires,
						Department,
						Active,start,
						Hierarchy
			FROM		Coupons
			<cfswitch expression="#url.Dealer_ID#">   <!--- 0014-0000-999-01-0000000000 --->
				<cfdefaultcase>WHERE	Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INT" value="#url.Dealer_ID#" maxlength="10"></cfdefaultcase>
				<cfcase value="17,162,1">WHERE Dealer_ID in (SELECT DISTINCT Share_ID FROM Dealer_Shares WHERE Dealer_ID=<cfqueryparam value="#url.Dealer_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">)</cfcase>
			</cfswitch>
			AND 		Active = 1
			<cfif #url.Department# NEQ "Show_All">
				<cfif #url.dealer_id# eq  70   or  #url.dealer_id# eq  51   > 
					AND 		Department = #url.Department# 
				</cfif>
			</cfif>
			AND			(Start <= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
			AND			(Expires is NULL or Expires >= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
			<cfif #url.dealer_id# eq 1 >
				ORDER BY dealer_id, Hierarchy
			<cfelse>
				ORDER BY Hierarchy
			</cfif>
		</cfquery>
<ul class="#arguments.carousel_class#" align="center">
		<cfloop query="Get_Coupon">

			<!--- Find the dealer that has the image in case the coupons is from a share --->
				
			<cfquery name="get_dlr" datasource="Ultra10">SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #Get_Coupon.dealer_id#</cfquery> 
			<cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >

			<cfswitch expression="#Get_Coupon.Department#">
				<cfcase value="5"><cfset variables.Deparment_Name="New Car Sales"></cfcase>
				<cfcase value="14"><cfset variables.Deparment_Name="Used Car Sales"></cfcase>
				<cfcase value="12"><cfset variables.Deparment_Name="Service"></cfcase>
				<cfcase value="7"><cfset variables.Deparment_Name="Parts"></cfcase>
				<cfcase value="3"><cfset variables.Deparment_Name="Finance"></cfcase>
				<cfcase value="24"><cfset variables.Deparment_Name="Fleet"></cfcase>
				<cfcase value="18"><cfset variables.Deparment_Name="Rental"></cfcase>
				<cfcase value="10"><cfset variables.Deparment_Name="Collision Center"></cfcase>
				<cfcase value="11"><cfset variables.Deparment_Name="General Sales"></cfcase>
				<cfcase value="46"><cfset variables.Deparment_Name="Coupons"></cfcase>
			</cfswitch>
			
	<li class="slide #arguments.carousel_class#_slide">
				<cfif #Get_Coupon.img_link_only# EQ 1 >
					<div class="row">
						<div class="col-md-12" align="center">
							zzzz
							<!--- <cfif #RTrim(Get_Coupon.link_address)# NEQ "" >
								<a  href="http://#cgi.server_name#/dealer/#variables.DEALER_DIRECTORY#/#RTrim(Get_Coupon.link_address)#"  >xxx
								<img class="img-responsive" border="none" alt="#Get_Coupon.Title#"  src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#" /></a>
							<cfelse>zzz
								<img class="img-responsive" border="none" alt="#Get_Coupon.Title#"  src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#" />
							</cfif> --->
						</div>
					</div>
				</cfif>

			<div class="row">
						<div class="col-md-12" align="center">&nbsp;</div></div>	
	</li>			
		</cfloop>
</ul>		 --->
	<cfif arguments.addScript eq "true">	    
	    <cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
	</cfif>
        <cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">

	</cffunction>

	<cffunction name="legacy_standard_legacy" description="shows coupons from legacy system" output="Yes" access="public">

		<cfparam name="url.Department" default="Show_All">
		<cfparam name="variables.Deparment_Name" default="">

		<cfset var Get_Form_Locations="">
		
		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>

		<cfset variables.dealer_list="">
		<cfloop query="Get_Form_Locations">
			<cfset variables.dealer_list=listappend(variables.dealer_list,"'#Get_Form_Locations.Dealercode#'")>
		</cfloop>
		
		<!--- <cfif url.dealer_id eq "xxx"> --->
 		 
		
			<cfquery name="get_dlr" datasource="Ultra10">SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #url.dealer_id#</cfquery> 
			<cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >
			<cfset variables.Display_Name = #get_dlr.Display_Name# >
			
		 	<cfif #url.dealer_id# eq  31 OR  
					#url.dealer_id# eq  66  OR  
						#url.dealer_id# eq  18  OR  
							#url.dealer_id# eq  70  OR  
								#url.dealer_id# eq  32 OR  
									#url.dealer_id# eq  28 OR  
										#url.dealer_id# eq  25 OR  
											#url.dealer_id# eq  51 OR  
											#url.dealer_id# eq  78  OR  
												#url.dealer_id# eq  79 OR  
												#url.dealer_id# eq  82 > 
	 
		
			<cfquery name="get_dlr" datasource="Ultra10">SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #url.dealer_id#</cfquery> 
			<cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >
			<cfset variables.Display_Name = #get_dlr.Display_Name# >
			
			<cfquery datasource="Ultra10" name="Get_Coupon">
				SELECT		ID,
							Dealer_ID,
							HeaderImage,
							Title,
							Description_top,
							Desription_bottom,
							use_prt_img, 
							img_link_only ,
							link_address ,  
							inside_box , 
							Expires,
							Department,
							Active,
							Hierarchy
				FROM		Coupons
				WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INT" value="#url.Dealer_ID#" maxlength="10">
				AND 		Active = 1
				<cfif #url.Department# NEQ "Show_All">
					<cfif #url.dealer_id# eq  70   or  #url.dealer_id# eq  51   > 
						AND 		Department = #url.Department# 
					</cfif>
				</cfif>
				AND			(Expires is NULL or Expires >= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
				ORDER BY Hierarchy
			</cfquery>
	
				<cfif url.dealer_id eq 70 >
					<cfif url.Department eq 12>
						<img alt="Service Coupons"  class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/library/header_service.jpg" /><br>
						
					</cfif>
				</cfif>
			<cfloop query="Get_Coupon">
	
				<cfswitch expression="#Get_Coupon.Department#">
					<cfcase value="5"><cfset variables.Deparment_Name="New Car Sales"></cfcase>
					<cfcase value="14"><cfset variables.Deparment_Name="Used Car Sales"></cfcase>
					<cfcase value="12"><cfset variables.Deparment_Name="Service"></cfcase>
					<cfcase value="7"><cfset variables.Deparment_Name="Parts"></cfcase>
					<cfcase value="3"><cfset variables.Deparment_Name="Finance"></cfcase>
					<cfcase value="24"><cfset variables.Deparment_Name="Fleet"></cfcase>
					<cfcase value="18"><cfset variables.Deparment_Name="Rental"></cfcase>
					<cfcase value="10"><cfset variables.Deparment_Name="Collision Center"></cfcase>
					<cfcase value="11"><cfset variables.Deparment_Name="General Sales"></cfcase>
					<cfcase value="46"><cfset variables.Deparment_Name="Coupons"></cfcase>
				</cfswitch>
				
				
				<cfif #Get_Coupon.inside_box# EQ 0>
					<cfif #Get_Coupon.img_link_only# EQ 1 >
						<div class="row">
							<div class="col-md-12" align="center">
								<cfif #RTrim(Get_Coupon.link_address)# NEQ "" >
									<a  href="http://#cgi.server_name#/dealer/#variables.DEALER_DIRECTORY#/#RTrim(Get_Coupon.link_address)#"  >
									<img class="img-responsive" border="none" alt="#Get_Coupon.Title#"  src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#" /></a>
								<cfelse>
									<img class="img-responsive" border="none" alt="#Get_Coupon.Title#"  src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#" />
								</cfif>
							</div>
						</div>
					</cfif>
				<cfelse>
				<div class="row legacy-coupon-box">
					<div class="row">
						<div class="col-md-12" align="center">
							<h3 class="legacy-coupon-title">#Get_Coupon.Title#</h3>
						</div>
					</div>
					<cfif #Get_Coupon.Description_top# NEQ "" >
						<div class="row">
							<div class="col-md-12" align="center">
								#Get_Coupon.Description_top#
							</div>
						</div>
					</cfif>
					<cfif #Get_Coupon.headerimage# NEQ "" >
						<div class="row">
							<div class="col-md-12" align="center">
								<img src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#" class="img-responsive" alt="#variables.Display_Name#"  >
							</div>
						</div>
					</cfif>	
					<cfif #Get_Coupon.Desription_bottom# NEQ "" >
						<div class="row">
							<div class="col-md-12" align="center">
								#Get_Coupon.Desription_bottom#
							</div>
						</div>
					</cfif>
					<div class="row">
						<div class="col-md-6" align="left" valign="BOTTOM">
							Department&nbsp;:&nbsp; #variables.Deparment_Name#<br>
							Expiration&nbsp;:&nbsp;
							<cfif len(trim(Expires)) eq 0>
								Does Not Expire
							<cfelse>
								#dateformat(Get_Coupon.Expires, "mm/dd/yyyy")#
							</cfif>
						</div>
						<div class="col-md-6" align="center">
							<cfif #Get_Coupon.use_prt_img# EQ "" >
								<a class="btn btn-primary" href="http://#cgi.server_name#/special_offers/print_coupon.cfm?CouponID=#Get_Coupon.ID#&new=1&dlrdir=#variables.DEALER_DIRECTORY#" target="_blank">Print This Coupon</a>
							<cfelse>	
								<a  href="http://#cgi.server_name#/special_offers/print_coupon.cfm?CouponID=#Get_Coupon.ID#&new=1&dlrdir=#variables.DEALER_DIRECTORY#" target="_blank"><img class="img-responsive" border="none" alt="Print this Coupon"  src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.use_prt_img#" /><br>Print This Coupon</a>
							</cfif>
						</div>
					</div>
				</div>
				
				</cfif>		
				<div class="row">
							<div class="col-md-12" align="center">&nbsp;</div></div>	
			</cfloop>
		<cfelse>      
			<cfquery datasource="Ultra8" name="Get_Coupon">
				SELECT		CouponID,
							DealerCode,
							HeaderImage,
							Title,
							Description,
							Expires,
							Department,
							Active,
							Hierarchy
				FROM		CouponBonanza
				<cfif Get_Form_Locations.Recordcount lt 2>
					WHERE 		DealerCode = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.DealerCode#" maxlength="30">
				<cfelse>
					WHERE		Dealercode in (#Preservesinglequotes(variables.dealer_list)#)
				</cfif>
				AND 		Active = 'Y'
				AND			(Expires is NULL or Expires >= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
				<cfif url.Department neq "Show_All" and url.Department neq 0>
					AND		(Department=<cfqueryparam value="#url.Department#" cfsqltype="CF_SQL_INTEGER" maxlength="2"> OR CouponBonanza.Department=11)
				</cfif>
				ORDER BY DealerCode, Hierarchy
			</cfquery>
	
			<cfloop query="Get_Coupon">
	
				<cfswitch expression="#Get_Coupon.Department#">
					<cfcase value="2"><cfset variables.Deparment_Name="New Car Sales"></cfcase>
					<cfcase value="3"><cfset variables.Deparment_Name="Used Car Sales"></cfcase>
					<cfcase value="4"><cfset variables.Deparment_Name="Service"></cfcase>
					<cfcase value="5"><cfset variables.Deparment_Name="Parts"></cfcase>
					<cfcase value="6"><cfset variables.Deparment_Name="Finance"></cfcase>
					<cfcase value="8"><cfset variables.Deparment_Name="Fleet"></cfcase>
					<cfcase value="9"><cfset variables.Deparment_Name="Rental"></cfcase>
					<cfcase value="10"><cfset variables.Deparment_Name="Collision Center"></cfcase>
					<cfcase value="11"><cfset variables.Deparment_Name="Coupons"></cfcase>
				</cfswitch>
			
				<div class="row legacy-coupon-box">
					<div class="row">
						<div class="col-md-12" align="center">
							<h3 class="legacy-coupon-title">#Get_Coupon.Title#</h3>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12" align="center">
							#Get_Coupon.Description#
						</div>
					</div>
					<div class="row">
						<div class="col-md-6" align="center">
							Department&nbsp;:&nbsp; #variables.Deparment_Name#<br>
							Expiration&nbsp;:&nbsp;
							<cfif len(trim(Expires)) eq 0>
								Does Not Expire
							<cfelse>
								#dateformat(Get_Coupon.Expires, "mm/dd/yyyy")#
							</cfif>
						</div>
						<div class="col-md-6" align="center">
							<a class="btn btn-primary" href="http://#cgi.server_name#/special_offers/print_coupon.cfm?CouponID=#Get_Coupon.CouponID#&dlrdir=#variables.DEALER_DIRECTORY#" target="_blank">Print This Coupon</a>
						</div>
					</div>
				</div>
			</cfloop>
	   </cfif>
		
	</cffunction>
	
	<cffunction name="legacy_print" description="prints_coupon" output="Yes" access="public">

		<cfparam name="url.Department" default="Show_All">
		<cfparam name="url.CouponID" default="0">
		<cfparam name="variables.Deparment_Name" default="">
			
		<cfif IsDefined("url.new")>
			<cfquery datasource="Ultra10" name="Get_Coupon">
				SELECT		ID,
							Dealer_ID,
							HeaderImage,
							Title,
							Description_top,
							Desription_bottom,
							Expires,
							Department,
							Active,
							Hierarchy
				FROM		Coupons
				WHERE 		Active = 1
				AND			(Expires is NULL or Expires >= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
				AND			ID = <cfqueryparam value="#url.CouponID#" cfsqltype="CF_SQL_INTEGER" maxlength="5">
				ORDER BY Hierarchy
			</cfquery>
	
			<cfquery name="get_dlr" datasource="Ultra10">SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #url.dealer_id#</cfquery> 
			<cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >
			<cfset variables.Display_Name = #get_dlr.Display_Name# >
			
				<cfswitch expression="#Get_Coupon.Department#">
					<cfcase value="5"><cfset variables.Deparment_Name="New Car Sales"></cfcase>
					<cfcase value="14"><cfset variables.Deparment_Name="Used Car Sales"></cfcase>
					<cfcase value="12"><cfset variables.Deparment_Name="Service"></cfcase>
					<cfcase value="7"><cfset variables.Deparment_Name="Parts"></cfcase>
					<cfcase value="3"><cfset variables.Deparment_Name="Finance"></cfcase>
					<cfcase value="24"><cfset variables.Deparment_Name="Fleet"></cfcase>
					<cfcase value="18"><cfset variables.Deparment_Name="Rental"></cfcase>
					<cfcase value="10"><cfset variables.Deparment_Name="Collision Center"></cfcase>
					<cfcase value="11"><cfset variables.Deparment_Name="General Sales"></cfcase>
					<cfcase value="46"><cfset variables.Deparment_Name="Coupons"></cfcase>
				</cfswitch>
	
				<style>
					.Coupon_Table{	color:##000000;
									background-color:##ffffff;
									border:5px dashed ##000000;
									width:550px;
									height:250px;
					}
					.Coupon_Title{	font: bold 20px arial;
									height:25px;
									padding:2px;
									text-align:center;
					}
					.Coupon_Desc{	font: bold 12px arial;
									text-align:center;
					}
					.Coupon_Note{	font: bold 12px arial;
									width:50%;
									height:30px;
									padding-left:10px;
									padding-top:5px;
									padding-bottom:5px;
					}
				</style>
	
				<div style="background-color:##fff" align="center">
					<br/>
					<div align="center"><a href="javascript:window.print();">Click Here to Print</a></div>
					<br/>
					<table class="Coupon_Table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="Coupon_Title" colspan="2">
								#Get_Coupon.Title#
							</td>
						</tr>
						<cfif #Get_Coupon.Description_top# NEQ "" >
							<tr>
								<td class="Coupon_Desc" colspan="2">
									#Get_Coupon.Description_top#
								</td>
							</tr>
						</cfif>	
						<cfif #Get_Coupon.headerimage# NEQ "" >
							<tr>
								<td class="Coupon_Desc" align="center" colspan="2">&nbsp;&nbsp;
								<img src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#"  alt="#variables.Display_Name#"  >
								</td>
							</tr>
						</cfif>	
						<cfif #Get_Coupon.Desription_bottom# NEQ "" >
							<tr>
								<td class="Coupon_Desc" colspan="2">
									#Get_Coupon.Desription_bottom#
								</td>
							</tr>
						</cfif>	
						<tr>
							<td class="Coupon_Note" align="center">
								Department&nbsp;:&nbsp; #variables.Deparment_Name#<br>
							</td>
							<td class="Coupon_Note" align="center">
								Expiration&nbsp;:&nbsp;
								<cfif len(trim(Get_Coupon.Expires)) eq 0>
									Does Not Expire
								<cfelse>
									#dateformat(Get_Coupon.Expires, "mm/dd/yyyy")#
								</cfif>
							</td>
						</tr>
					</table>
					<br/>
					<div align="center"><a href="javascript:window.print();">Click Here to Print</a></div>
					<br/>
				</div>
				
				<script>
					window.print();
				</script>
			
			<cfelse>   
				<cfquery datasource="Ultra8" name="Get_Coupon">
					SELECT		CouponID,
								DealerCode,
								HeaderImage,
								Title,
								Description,
								Expires,
								Department,
								Active,
								Hierarchy
					FROM		CouponBonanza
					WHERE		Active = 'Y'
					AND			(Expires is NULL or Expires >= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
					AND			CouponID = <cfqueryparam value="#url.CouponID#" cfsqltype="CF_SQL_INTEGER" maxlength="5">
				</cfquery>
				
				<cfswitch expression="#Get_Coupon.Department#">
					<cfdefaultcase><cfset variables.Deparment_Name="Coupons"></cfdefaultcase>
					<cfcase value="2"><cfset variables.Deparment_Name="New Car Sales"></cfcase>
					<cfcase value="3"><cfset variables.Deparment_Name="Used Car Sales"></cfcase>
					<cfcase value="4"><cfset variables.Deparment_Name="Service"></cfcase>
					<cfcase value="5"><cfset variables.Deparment_Name="Parts"></cfcase>
					<cfcase value="6"><cfset variables.Deparment_Name="Finance"></cfcase>
					<cfcase value="8"><cfset variables.Deparment_Name="Fleet"></cfcase>
					<cfcase value="9"><cfset variables.Deparment_Name="Rental"></cfcase>
					<cfcase value="10"><cfset variables.Deparment_Name="Collision Center"></cfcase>
					<cfcase value="11"><cfset variables.Deparment_Name="Coupons"></cfcase>
				</cfswitch>
	
				<style>
					.Coupon_Table{	color:##000000;
									background-color:##ffffff;
									border:5px dashed ##000000;
									width:550px;
									height:250px;
					}
					.Coupon_Title{	font: bold 20px arial;
									height:25px;
									padding:2px;
									text-align:center;
					}
					.Coupon_Desc{	font: bold 12px arial;
									text-align:center;
					}
					.Coupon_Note{	font: bold 12px arial;
									width:50%;
									height:30px;
									padding-left:10px;
									padding-top:5px;
									padding-bottom:5px;
					}
				</style>
	
				<div style="background-color:##fff" align="center">
					<br/>
					<div align="center"><a href="javascript:window.print();">Click Here to Print</a></div>
					<br/>
					<table class="Coupon_Table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="Coupon_Title" colspan="2">
								#Get_Coupon.Title#
							</td>
						</tr>
						<tr>
							<td class="Coupon_Desc" colspan="2">
								#Get_Coupon.Description#
							</td>
						</tr>
						<tr>
							<td class="Coupon_Note" align="center">
								Department&nbsp;:&nbsp; #variables.Deparment_Name#<br>
							</td>
							<td class="Coupon_Note" align="center">
								Expiration&nbsp;:&nbsp;
								<cfif len(trim(Get_Coupon.Expires)) eq 0>
									Does Not Expire
								<cfelse>
									#dateformat(Get_Coupon.Expires, "mm/dd/yyyy")#
								</cfif>
							</td>
						</tr>
					</table>
					<br/>
					<div align="center"><a href="javascript:window.print();">Click Here to Print</a></div>
					<br/>
				</div>
				
				<script>
					window.print();
				</script>
	  </cfif>    
	</cffunction>

	
	
	
	
</cfcomponent>
