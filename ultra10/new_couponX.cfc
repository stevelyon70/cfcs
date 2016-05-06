<cfcomponent>

	<cffunction name="modern_standard_legacy" description="shows coupons from legacy system" output="Yes" access="public">

    <cfparam name="url.Department" default="Show_All">
    <cfparam name="variables.Deparment_Name" default="">
	
    <cfargument name="dealer_id" required="true">
    <cfargument name="assets" required="true">
	
    <cfargument name="new_used" default="U">
    <cfargument name="certified" default="0">
    <cfargument name="price_ceiling" default="">
    <cfargument name="results" default="12">
    <cfargument name="carousel_class" default="specials-carousel">
    <cfargument name="minSlides" default="3">
    <cfargument name="maxSlides" default="20">
    <cfargument name="auto" default="true">
    <cfargument name="moveSlides" default="1">
    <cfargument name="slideWidth" default="200">
    <cfargument name="slideMargin" default="10">
    <cfargument name="addScript" default="true">

    <cfset var Get_Form_Locations="">
		
	<cfquery name="get_dlr" datasource="Ultra10">
		SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #url.dealer_id#
	</cfquery>
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
								Active,start,
								Hierarchy
					FROM		Coupons
					WHERE	Dealer_ID =	<cfqueryparam cfsqltype="CF_SQL_INT" value="#url.Dealer_ID#" maxlength="10">
			AND 		Active = 1			
		<cfif #url.Department# NEQ "Show_All">				
			<cfif #url.dealer_id# eq  70   or  #url.dealer_id# eq  51   >				AND 		Department = #url.Department#
			</cfif>
		</cfif>
		AND			(Start <=
	    <cfqueryparam value="#dateformat(now(), " mm mm// ")#" cfsqltype="CF_SQL_DATE">
)
			AND			(Expires is NULL or Expires >=
	    <cfqueryparam value="#dateformat(now(), " mm mm// ")#" cfsqltype="CF_SQL_DATE">
)			
		
ORDER BY Hierarchy
	</cfquery>
	<!---
	<ul class="#arguments.carousel_class#" align="center">	--->
		<cfloop query="Get_Coupon">
			<!--- Find the dealer that has the image in case the coupons is from a share --->
			<cfquery name="get_dlr" datasource="Ultra10">
				SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #Get_Coupon.dealer_id#
			</cfquery>
		    		    <cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >
		    <cfswitch expression="#Get_Coupon.Department#">
		    <cfcase value="5">
		    		    <cfset variables.Deparment_Name="New Car Sales"></cfcase>
		    <cfcase value="14">
		    		    <cfset variables.Deparment_Name="Used Car Sales"></cfcase>
		    <cfcase value="12">
		    		    <cfset variables.Deparment_Name="Service"></cfcase>
		    <cfcase value="7">
		    		    <cfset variables.Deparment_Name="Parts"></cfcase>
		    <cfcase value="3">
		    		    <cfset variables.Deparment_Name="Finance"></cfcase>
		    <cfcase value="24">
		    		    <cfset variables.Deparment_Name="Fleet"></cfcase>
		    <cfcase value="18">
		    		    <cfset variables.Deparment_Name="Rental"></cfcase>
		    <cfcase value="10">
		    		    <cfset variables.Deparment_Name="Collision Center"></cfcase>
		    <cfcase value="11">
		    		    <cfset variables.Deparment_Name="General Sales"></cfcase>
		    <cfcase value="46">
		    		    <cfset variables.Deparment_Name="Coupons"></cfcase></cfswitch><!---
			<li class="slide #arguments.carousel_class#_slide">--->				
			<cfif #Get_Coupon.inside_box# EQ 0>					
				<cfif #Get_Coupon.img_link_only# EQ 1 >
					<div class="row">
						<div class="col-md-12" align="center">								
							<cfif #RTrim(Get_Coupon.link_address)# NEQ "" ><a href="http://#cgi.server_name#/dealer/#variables.DEALER_DIRECTORY#/#RTrim(Get_Coupon.link_address)#">
<img class="img-responsive" border="none" alt="#Get_Coupon.Title#" src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#"/>
</a>
							<cfelse>
<img class="img-responsive" border="none" alt="#Get_Coupon.Title#" src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#"/>
							</cfif>
						</div>
					</div>
				</cfif>
			<cfelse>
				<div class="row legacy-coupon-box">
					<div class="row">
						<div class="col-md-12" align="center"><h3 class="legacy-coupon-title">#Get_Coupon.Title#</h3>
						</div>
					</div>						
					<cfif #Get_Coupon.Description_top# NEQ "" >
						<div class="row">
							<div class="col-md-12" align="center">	#Get_Coupon.Description_top#
							</div>
						</div>
					</cfif>
											<cfif #Get_Coupon.headerimage# NEQ "" >
						<div class="row">
							<div class="col-md-12" align="center"><img src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.headerimage#" class="img-responsive" alt="#variables.Display_Name#">
							</div>
						</div>
					</cfif>
											<cfif #Get_Coupon.Desription_bottom# NEQ "" >
						<div class="row">
							<div class="col-md-12" align="center">	#Get_Coupon.Desription_bottom#
							</div>
						</div>
					</cfif>
					<div class="row">
						<div class="col-md-6" align="left" valign="BOTTOM">	Department&nbsp;:&nbsp; #variables.Deparment_Name#<br>Expiration&nbsp;:&nbsp;								
							<cfif len(trim(Expires)) eq 0>								Does Not Expire
							<cfelse>
#dateformat(Get_Coupon.Expires, "mm/dd/yyyy")#
							</cfif>
						</div>
						<div class="col-md-6" align="center">								
							<cfif #Get_Coupon.use_prt_img# EQ "" ><a class="btn btn-primary" href="http://#cgi.server_name#/special_offers/print_coupon.cfm?CouponID=#Get_Coupon.ID#&new=1&dlrdir=#variables.DEALER_DIRECTORY#" target="_blank">
Print This Coupon
</a>
							<cfelse>
<a href="http://#cgi.server_name#/special_offers/print_coupon.cfm?CouponID=#Get_Coupon.ID#&new=1&dlrdir=#variables.DEALER_DIRECTORY#" target="_blank">
<img class="img-responsive" border="none" alt="Print this Coupon" src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/library/#Get_Coupon.use_prt_img#"/><br>Print This Coupon
</a>
							</cfif>
						</div>
					</div>
				</div>
			</cfif>
			<!---</li>--->
		</cfloop>
		<!---
	</ul>	--->		
	<cfif arguments.addScript eq "true">	    
	    <cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/bxslider/jquery.bxslider.min.js"></script>'>
	</cfif>
        <cfset url.Dom_Functions= url.Dom_Functions & "$('.#arguments.carousel_class#').bxSlider({slideWidth:#arguments.slideWidth#,minSlides:#arguments.minSlides#,maxSlides:#arguments.maxSlides#,slideMargin:#arguments.slideMargin#,pager:false,auto:#arguments.auto#,autoHover: true,moveSlides:#arguments.moveSlides#});">
</cffunction>

</cfcomponent>