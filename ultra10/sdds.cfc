<cfcomponent persistent="true" accessors="true">
	<cfproperty name="dealer_id" default="0" />
    <cfproperty name="dsn" default="Ultra10" />
	<cffunction name="track" description="add scion tracking scripts" output="Yes" access="public">		
	<!---arguments--->
		<cfargument name="dealer_id" required="true">
        <cfargument name="sdds" required="true" default="0">
	<!--- default url values - do not exists for all pages --->
		<cfparam name="url.new_used" default="">
		<cfparam name="url.year" default="">
		<cfparam name="url.make" default="">
		<cfparam name="url.model" default="">
		<cfparam name="url.page_action" default="">
		<cfparam name="url.tdds_contact" default="no">    
        <cfif arguments.sdds>
        <cfset setDealer_id(arguments.dealer_id)>
        <cfset Get_SDDS = getDealerDB()>
        <cfset Get_Urls = getDealerUrlsDB()>
		<cfoutput>
        <cfset variables.url_list="#valuelist(Get_Urls.Dealer_URL)#,worlddealer.net,wdautos.com,google-analytics.com">
			<!--- function to get url variables in Javascript --->
			<script language="JavaScript" type="text/JavaScript" >
					function getQueryVariable(variable)
						{
						   var query = window.location.search.substring(1);
						   var vars = query.split("&");
						   for (var i=0;i<vars.length;i++) {
								   var pair = vars[i].split("=");
								   if(pair[0] == variable){return pair[1];}
						   }
						   return(false);
						}
           </script>
    <!--- All variables should be passed in lower case. - TDDS:TIG pg 7 --->
			<script language="JavaScript" type="text/JavaScript" >
				var tms_account = "#lcase(getEnvironment())#";
				var tms_linkInternalFilters = "#variables.url_list#";
				var tms_siteID = "#lcase(replace(cgi.server_name,'www.','','all'))#";
				var tms_dealerCode = "#Get_SDDS.OEM_Key#";
				var tms_region = "#lcase(Get_SDDS.SDDS_region)#";
				var tms_tda = "#lcase(Get_SDDS.SDDS_tda)#";
				var tms_district = "#lcase(Get_SDDS.SDDS_district)#";
				<cfif len(trim(Get_SDDS.SDDS_autogroup)) gt 0>
					var tms_autogroup= "#lcase(Get_SDDS.SDDS_autogroup)#";
				</cfif>

				var tms_provider= "worlddealer";				
			</script> 
            <!--- SiteCatalyst code version: H.26.X. Copyright 1996-2011 Adobe, Inc. All Rights Reserved 
            More info available at http://www.omniture.com ---> 
            <script language="JavaScript" type="text/JavaScript" src="http://www.scion.com/js/omni/SDDS_dealers_s_code.js"></script>             
            <!-- scion  #arguments.sdds#-->		            
            <script language="JavaScript" type="text/JavaScript">			<!-- 
			/************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/ 
			var s_code=tmsomni.t();if(s_code)document.write(s_code)//-->
            </script> 
			<!--- End SiteCatalyst code version: H.24.X. ---> 
            
            
			
			
			
			<!--- New Vehicle Inventory --->
			<cfif left(lcase(cgi.script_name),5) eq "/new/">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop10 = "new";
					tmsomni.prop2 = <cfif len(trim(url.year)) gt 0>"#url.year#"<cfelse>"all"</cfif>;
					tmsomni.prop9  = <cfif len(trim(url.model)) gt 0>"#url.model#"<cfelse>"all"</cfif>;
					<cfif lcase(cgi.script_name) contains "make" or lcase(cgi.script_name) contains "index.cfm" or lcase(cgi.script_name) contains "new_cars.cfm">tmsomni.events = "event64";</cfif>
				</script>
			</cfif>
			
			<!--- Used Vehicle Inventory --->
			<cfif left(lcase(cgi.script_name),6) eq "/used/">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop10 = "used";
					tmsomni.prop2 = <cfif len(trim(url.year)) gt 0>"#url.year#"<cfelse>"all"</cfif>;
					tmsomni.prop9  = <cfif len(trim(url.model)) gt 0>"#url.model#"<cfelse>"all"</cfif>;
					<cfif lcase(cgi.script_name) contains "make" or lcase(cgi.script_name) contains "index.cfm" or lcase(cgi.script_name) contains "used_cars.cfm">tmsomni.events = "event64";</cfif>
				</script>
			</cfif>
			
			<!--- Certified Inventory --->
			<cfif left(lcase(cgi.script_name),11) eq "/certified/">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop10 = "certified";
					tmsomni.prop2 = <cfif len(trim(url.year)) gt 0>"#url.year#"<cfelse>"all"</cfif>;
					tmsomni.prop9  = <cfif len(trim(url.model)) gt 0>"#url.model#"<cfelse>"all"</cfif>;
					<cfif lcase(cgi.script_name) contains "make" or lcase(cgi.script_name) contains "index.cfm" or lcase(cgi.script_name) contains "certified.cfm">tmsomni.events = "event64";</cfif>
				</script>
			</cfif>
			
			
			
			
			
			<!--- Contact Us Start --->
			<cfif lcase(cgi.script_name) eq "/forms/contact.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "contact";
					tmsomni.prop64 = "other";
					tmsomni.events = "event94";
				</script>
			</cfif>

			<!--- Contact Us Save --->
			<cfif lcase(cgi.script_name) eq "/forms/contact_action.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.eVar6 = "contact";
					tmsomni.eVar64 = "other";
					tmsomni.events = "event95";
				</script>
			</cfif>
			
			<!--- Contact Us End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_contact.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "contact";
					tmsomni.prop64 = "contact";
					tmsomni.events = "event95";
				</script>
			</cfif>

			<!--- Send to Friend End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_friend.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "friend";
					tmsomni.prop64 = "friend";
					tmsomni.events = "event68";
				</script>
			</cfif>
			
			<!--- Ask A Tech Start and Save --->
			<cfif lcase(cgi.script_name) eq "/forms/ask_a_tech.cfm">
				<cfswitch expression="#url.page_action#">
					<cfdefaultcase>
						<script language="JavaScript" type="text/JavaScript" > 
							//Set Custom Page Load Variables
							tmsomni.prop6 = "ask a tech";
							tmsomni.prop64 = "ask a tech";
							tmsomni.events = "event67";
						</script>
					</cfdefaultcase>
					<cfcase value="submit_form">
						<script language="JavaScript" type="text/JavaScript" > 
							//Set Custom Page Load Variables
							tmsomni.eVar6 = "ask a tech";
							tmsomni.eVar64 = "ask a tech";
						</script>						
					</cfcase>
				</cfswitch>
			</cfif>
			
			<!--- Ask A Tech End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_tech.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "ask a tech";
					tmsomni.prop64 = "ask a tech";
					tmsomni.events = "event68";
				</script>
			</cfif>
			
			<!--- Test Drive Start --->
			<cfif lcase(cgi.script_name) eq "/forms/test_drive.cfm" or isdefined("tdFormV")>
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					<cfif len(trim(url.new_used)) gt 0 and len(trim(url.year)) gt 0 and len(trim(url.model)) gt 0>
						tmsomni.prop6 = "vehicle request";
						tmsomni.prop64 = "vehicle";
						tmsomni.events = "event54";
						<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
						<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
						<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
					<cfelse>
						tmsomni.prop6 = "test drive";
						tmsomni.prop64 = "vehicle";
						tmsomni.events = "event67";
					</cfif>
				</script>
			</cfif>

			<!--- Test Drive Save --->
			<cfif lcase(cgi.script_name) eq "/forms/test_drive_action.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.eVar6 = "test drive";
					tmsomni.eVar64 = "vehicle";
					tmsomni.events = "event55";
					<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
					<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
					<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
				</script>
			</cfif>
			
			<!--- Test Drive End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_test_drive.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					<cfif len(trim(url.new_used)) gt 0 and len(trim(url.year)) gt 0 and len(trim(url.model)) gt 0>
						tmsomni.prop6 = "vehicle request";
						tmsomni.prop64 = "vehicle";
						tmsomni.events = "event55";
						<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
						<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
						<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
					<cfelse>
						tmsomni.prop6 = "test drive";
						tmsomni.prop64 = "vehicle";
						tmsomni.events = "event68";
					</cfif>
				</script>
			</cfif>
			
			<!--- Trade Appraisal Start --->
			<cfif lcase(cgi.script_name) eq "/forms/trade.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "trade appraiser";
					tmsomni.prop64 = "trade appraiser";
					tmsomni.events = "event54";
					<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
					<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
					<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
				</script>
			</cfif>

			<!--- Trade Appraisal Save --->
			<cfif lcase(cgi.script_name) eq "/forms/trade_action.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.eVar6 = "trade appraiser";
					tmsomni.eVar64 = "trade appraiser";
					tmsomni.events = "event55";
				</script>
			</cfif>
			
			<!--- Trade Appraisal End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_trade.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "trade appraiser";
					tmsomni.prop64 = "trade appraiser";
					tmsomni.events = "event68";
				</script>
			</cfif>
			
			<!--- Service Request Start --->
			<cfif lcase(cgi.script_name) eq "/forms/service.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "request service appointment";
					tmsomni.prop64 = "service";
					tmsomni.events = "event48";
				</script>
			</cfif>
			
			<!--- Service Request End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_service.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "request service appointment";
					tmsomni.prop64 = "service";
					tmsomni.events = "event49";
				</script>
			</cfif>
			
			<!--- Parts Start --->
			<cfif lcase(cgi.script_name) eq "/forms/parts.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "parts request";
					tmsomni.prop64 = "parts";
					tmsomni.events = "event50";
				</script>
			</cfif>

			<!--- Parts Save --->
			<cfif lcase(cgi.script_name) eq "/forms/parts_action.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.eVar6 = "parts request";
					tmsomni.eVar64 = "parts";
					tmsomni.events = "event51";
				</script>
			</cfif>
			
			<!--- Parts Request End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_parts.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "parts request";
					tmsomni.prop64 = "parts";
					tmsomni.events = "event51";
				</script>
			</cfif>
			
			<!--- Vehicle Request Start --->
			<cfif lcase(cgi.script_name) eq "/forms/find_my_car.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "vehicle request";
					tmsomni.prop64 = "vehicle";
					tmsomni.events = "event54";
					<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
					<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
					<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
				</script>
			</cfif>

			<!--- Vehicle Request Save --->
			<cfif lcase(cgi.script_name) eq "/forms/fmc_action.cfm" or lcase(cgi.script_name) eq "/vehicles/qq_action.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.eVar6 = "vehicle request";
					tmsomni.eVar64 = "vehicle";
				</script>
			</cfif>
			
			<cfif lcase(left(cgi.script_name,10)) eq "/showroom/">
				<script language="JavaScript" type="text/JavaScript" >
					var doOnceSR = false;
					function OnFocusTrackSR () {
						if (doOnceSR){return false;}{
							tmsomni.trackExternalLinks=false;
							tmsomni.linkTrackVars='prop2,prop6,prop9,prop10,prop64,eVar6,eVar64,events';
							tmsomni.linkTrackEvents=tmsomni.events='event54';
							tmsomni.tl(this, 'o',"#lcase(GetFileFromPath(cgi.CF_TEMPLATE_PATH))# - Form Start");
							doOnceSR = true;
						}
					}
					tmsomni.prop10 = "new";
					<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
					<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
				</script>
			</cfif>
			
			<!--- Vehicle Request End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_quote.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "vehicle request";
					tmsomni.prop64 = "vehicle";
					tmsomni.events = "event55";
					<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
					<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
					<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
				</script>
			</cfif>
			
			<!--- Vehicle Details End --->
			<cfif lcase(cgi.script_name) contains "wdi.cfm" or lcase(cgi.script_name) contains "vehicle_details.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.events = "event81";
					<cfif cgi.script_name contains "/Certified/">
						tmsomni.prop10 = certified;
					<cfelse>
						<cfif len(trim(url.new_used)) gt 0>tmsomni.prop10 = <cfif url.new_used eq "n">"new"<cfelseif url.new_used eq "c">"certified"<cfelse>"used"</cfif>;</cfif>
					</cfif>
					<cfif len(trim(url.year)) gt 0>tmsomni.prop2 = "#url.year#";</cfif>
					<cfif len(trim(url.model)) gt 0>tmsomni.prop9  = "#url.model#";</cfif>
					tmsomni.events = "event81";
				</script>
			</cfif>
            
            	
		</cfoutput>        
        </cfif>		
	</cffunction>
    
    <cffunction access="private" returntype="string"  name="getEnvironment" output="no">
    	<cfreturn "sdds-dev">
		<!--- development = sdds-dev --->
		<!--- production = sdds-prod --->        
    </cffunction>
    
    <cffunction access="private" returntype="query"  name="getDealerDB" output="no">
    	<cfquery datasource="#getDsn()#" name="Get_SDDS">
			SELECT		Dealer_ID,
						Dealercode,
						OEM_Key,
						SDDS,
						SDDS_region,
						SDDS_tda,
						SDDS_district,
						SDDS_autogroup
			FROM		[Dealer_Tags]
			WHERE		SDDS = <cfqueryparam cfsqltype="cf_sql_integer" value="1" maxlength="1">
			<cfif len(trim(getDealer_id())) gt 0 and getDealer_id() neq 0>
				AND		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getDealer_id()#" maxlength="30">
			</cfif>
			AND			Active = <cfqueryparam cfsqltype="cf_sql_integer" value="1" maxlength="1">
		</cfquery>
        <cfreturn Get_SDDS>      
    </cffunction>
    
    <cffunction access="private" returntype="query"  name="getDealerUrlsDB" output="no">
    	<cfquery datasource="#getDsn()#" name="Get_Urls">
				SELECT		lower(Dealer_URL) as Dealer_URL
				FROM    	Dealer_URLs
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getDealer_id()#" maxlength="30">
				ORDER BY 	URL_Type
			</cfquery>
        <cfreturn Get_Urls>      
    </cffunction>
	
    <cffunction access="private" returntype="numeric"  name="isScionDealer" output="no">
    	<cfargument name="dealerID" required="yes" type="numeric" />
        
        
    </cffunction>
</cfcomponent>
