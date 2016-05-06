<cfcomponent>

	<cffunction name="modern_standard_legacy" description="shows coupons from legacy system" output="Yes" access="public">

		<cfparam name="url.Department" default="Show_All">
		<cfparam name="variables.Deparment_Name" default="">

		<cfset var Get_Form_Locations="">
		
		<cfquery name="get_dlr" datasource="Ultra10">SELECT  Dealer_ID, Display_Name, dealer_directory FROM Dealers WHERE Dealer_ID =  #url.dealer_id#</cfquery> 
		<cfset variables.DEALER_DIRECTORY = #get_dlr.dealer_directory# >
		<cfset variables.Display_Name = #get_dlr.Display_Name# >
		
		<cfquery datasource="Ultra10" name="get_nav">
			SELECT		*
			FROM		navigation
			<cfswitch expression="#url.Dealer_ID#"> 
				<cfdefaultcase>WHERE	Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INT" value="#url.Dealer_ID#" maxlength="10"></cfdefaultcase>
<!--- 				<cfcase value="17,162,1,326">WHERE Dealer_ID in (SELECT DISTINCT Share_ID FROM Dealer_Shares WHERE Dealer_ID=<cfqueryparam value="#url.Dealer_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">)</cfcase> --->
			</cfswitch>
			AND			Nav_Type_id = 72
			<!--- AND			hotlist = 1 --->
			AND			(Start_date <= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
			AND			(End_Date is NULL or End_Date >= <cfqueryparam value="#dateformat(now(), "mm/dd/yyyy")#" cfsqltype="CF_SQL_DATE">)
			<cfif #url.dealer_id# eq 1 >
				ORDER BY dealer_id, Hierarchy
			<cfelse>
				ORDER BY Hierarchy
			</cfif>
		</cfquery>

				
			<cfset arguments.responsive = "true" >
			<cfset variables.element_class="">
				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(get_nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;">
				</cfif>
				<cfif len(trim(get_nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(get_nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#pt!important;">
				</cfif>
				<cfif len(trim(get_nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(get_nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(get_nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(get_nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(get_nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(get_nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif get_nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset get_nav.pull="">
				</cfif>
				
				<cfif len(trim(get_nav.pull)) neq 0>
					<cfset arguments.pull=get_nav.pull>
				</cfif>
				
				<cfif get_nav.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif get_nav.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>

		
		<cfloop query="get_nav">
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
					<cfif left(Get_Nav.Nav_Mobile_Link,4) neq "http">
						<cfset Get_Nav.Nav_Mobile_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Mobile_Link)#">
					</cfif>
				

			<div class="row">
				<div class="col-md-12" align="center">
				
		<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
				<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
					<img style="#variables.element_style#"  class="nav_#Get_Nav.Nav_ID# img-responsive " alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/slideshow/#Get_Nav.Nav_Image#" />
				</a>

				<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
				
				<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# " href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#"  target="_blank">
			 
				<span style="#variables.element_style#">#Get_Nav.Snippet#</span>
				</a>

				<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
		 				
				
					<!--- <img class="img-responsive" border="none" alt="#get_nav.Nav_Name#"  src="http://dealers.wdautos.com/dealer/#variables.DEALER_DIRECTORY#/images/slideshow/#get_nav.Nav_Image#" /> --->
				</div>
			</div>
			<div class="row"><div class="col-md-12" align="center">&nbsp;</div></div>	<div class="row"><div class="col-md-12" align="center">&nbsp;</div></div>	
			</div>
		</cfloop>

	</cffunction>

	
	
	<cffunction name="legacy_standard_legacy" description="shows coupons from legacy system" output="Yes" access="public">
	</cffunction>
	
	<cffunction name="legacy_print" description="prints_coupon" output="Yes" access="public">
	</cffunction>
	
	<cffunction name="full_container" description="shows coupons from legacy system" output="Yes" access="public">
	</cffunction>
	
	
	
	
</cfcomponent>