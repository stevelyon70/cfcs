 <!--- <cfif 	url.site_mode eq "legacy" and 
			cgi.script_name neq "/vehicles/quote_pop.cfm" and 
			cgi.script_name neq "/vehicles/td_pop.cfm">
		<cfinvoke component="/cfcs/setup/browser" method="legacy"></cfinvoke>
	</cfif>  --->

	<!--- PURLs Only  ---> 
	
	
	<cfif #url.dealer_id# eq 261 or  #url.dealer_id# eq 196 or  #url.dealer_id# eq 289 or  #url.dealer_id# eq 306  >	
		<!--- <cfset clean_step_1 = "#cgi.QUERY_STRING#" >
		<cfset clean_step_2 = #ReReplace(cgi.QUERY_STRING, "[[:space:]] ", "Q", "ALL")#/ >  --->
		
		<!--- set up a test variable --->
		<cfset mySpaceFilledString = "#cgi.QUERY_STRING#" />
		<!--- remove ALL spaces from the string --->
		<cfset mySpaceFreeVariable = #ReReplaceNoCase(mySpaceFilledString,"[^[:alnum:]]","","ALL")# >


		<!--- check it works --->

		
		
		<cfoutput><cfset purl_is = "#mySpaceFreeVariable#" ></cfoutput>
	</cfif>
	

<cfinvoke component="/cfcs/ultra10/templates/#url.template_id#/splash_build" method="page_build">
	<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
	<cfinvokeargument name="dealer_name" value="#url.dealer_name#"/>
	<cfinvokeargument name="address_1" value="#url.address_1#"/>
	<cfinvokeargument name="address_2" value="#url.address_2#"/>
	<cfinvokeargument name="city" value="#url.city#"/>
	<cfinvokeargument name="state" value="#url.state#"/>
	<cfinvokeargument name="zip" value="#url.zip#"/>
	<cfinvokeargument name="assets" value="#url.assets#"/>
	<cfinvokeargument name="template_id" value="#url.template_id#"/>
	<cfinvokeargument name="dealer_template_id" value="#url.dealer_template_id#"/>
	<cfinvokeargument name="site_mode" value="#url.site_mode#"/>
	<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
	<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
	<cfinvokeargument name="Get_Meta_Info" value="#Get_Meta_Info#"/>
	<!--- PURLs Only  --->
	<cfif #url.dealer_id# eq 261 or #url.dealer_id# eq 196 or #url.dealer_id# eq 289 or #url.dealer_id# eq 306  >	
		<cfinvokeargument name="get_purl" value="#purl_is#"/>
		<cfif IsDefined("url.multi_purls")>
			<cfinvokeargument name="multi_purls" value="1"/>
		</cfif>
	</cfif>
</cfinvoke>

	
	

<!---index page popups--->
<!---<cfcookie name="popupcookie" value="0">--->
<cfparam name="cookie.popupcookie" default="0">
<cfif cookie.popupcookie eq 0 and url.site_mode eq "modern">
	<cfquery datasource="Ultra10" name="Get_Pop" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
		SELECT		Top 1
					Nav_Image,
					Nav_Link,
					Nav_Behaviour_ID,
					Start_Date,
					End_Date,
					BG_Color
		FROM		Dealer_Popups
		WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
		AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
		AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
		ORDER BY	Dealer_Popup_ID
	</cfquery>
	
	
		<cfif #url.dealer_id# eq 178  OR  #url.dealer_id# eq 311  >	<!--- Fuccillo Walkon  --->
		<!--- <script type="text/javascript" src="http://www.walkonsite.com/player/vid/554b77bdb38dc66b04c5a48c/"></script>  --->
 					<cfinclude template="fucilloWalkon.htm"/> 
		</cfif>
		
		
	
	<cfif Get_Pop.Recordcount eq 1>
		<cfswitch expression="#Get_Pop.Nav_Behaviour_ID#">
			<cfcase value="1">
				<cfinvoke component="/cfcs/ultra10/popups" method="homepage_pop">
					<cfinvokeargument name="img" value="http://dealers.wdautos.com/dealer/#url.assets#/images/popups/#Get_Pop.Nav_Image#"/>
					<cfinvokeargument name="link" value="#Get_Pop.Nav_Link#"/>
					<cfinvokeargument name="BG_Color" value="#Get_Pop.BG_Color#"/>
				</cfinvoke>
				<script type="text/javascript">
				    $(window).load(function(){
				        $('#popModal').modal('show');
				    });
				</script>				
			</cfcase>
			<cfcase value="2">
				<cfinvoke component="/cfcs/ultra10/popups" method="trade_in_pop">
					<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
					<cfinvokeargument name="BG_Color" value="#Get_Pop.BG_Color#"/>
				</cfinvoke>
				<script type="text/javascript">
				    $(window).load(function(){
				        $('#popModal').modal('show');
				    });
				</script>
			</cfcase>
			  <cfcase value="3">  <!--- Added for Faulkner Nissan Jenkintown 12/26/2014 --->
				<cfinvoke component="/cfcs/ultra10/popups" method="contact_us_pop">
					<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
					<cfinvokeargument name="BG_Color" value="#Get_Pop.BG_Color#"/>
				</cfinvoke>
				<script type="text/javascript">
				    $(window).load(function(){
				        $('#popModal').modal('show');
				    });
				</script>
			</cfcase> 
			  <cfcase value="4">  <!--- Added for Baierl Kia 05/14/2015 --->
				<cfinvoke component="/cfcs/ultra10/popups" method="coupon_td_pop">
					<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
					<cfinvokeargument name="BG_Color" value="#Get_Pop.BG_Color#"/>
				</cfinvoke>
				<script type="text/javascript">
				    $(window).load(function(){
				        $('#popModal').modal('show');
				    });
				</script>
			</cfcase>  
		</cfswitch>
		<cfcookie name="popupcookie" value="1">
		<!---<cfcookie name="popupcookie" value="1" expires="#CreateTimeSpan(0,2,0,0)#">--->
	</cfif>
</cfif>




