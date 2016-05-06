<cfcomponent>

	<cffunction name="track" description="shows standard dealer hours" output="Yes" access="public">
		
		<!---arguments--->
		<cfargument name="dealer_id" required="true">

		<!--- default url values - do not exists for all pages --->
		<cfparam name="url.new_used" default="">
		<cfparam name="url.year" default="">
		<cfparam name="url.make" default="">
		<cfparam name="url.model" default="">
		<cfparam name="url.page_action" default="">
		<cfparam name="url.tdds_contact" default="no">

		<!--- set tdds account mode --->
		<cfset variables.tms_account="tdds-prod">
		<!--- development = tdds-dev --->
		<!--- production = tdds-prod --->
		
		<cfquery datasource="Ultra10" name="Get_TDDS">
			SELECT		Dealer_ID,
						Dealercode,
						OEM_Key,
						TDDS,
						TDDS_region,
						TDDS_tda,
						TDDS_district,
						TDDS_autogroup
			FROM		Dealers
			WHERE		TDDS = 1
			<cfif len(trim(arguments.dealer_id)) gt 0 and arguments.dealer_id neq 0>
				AND		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="30">
			</cfif>
			AND			Active = 1
		</cfquery>

		<cfif Get_TDDS.recordcount eq 1>

			<cfquery datasource="Ultra10" name="Get_Urls">
				SELECT		lower(Dealer_URL) as Dealer_URL
				FROM    	Dealer_URLs
				WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="30">
				ORDER BY 	URL_Type
			</cfquery>
		
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
				var tms_account = "#variables.tms_account#";
				var tms_linkInternalFilters = "#variables.url_list#";
				var tms_siteID = "#lcase(replace(cgi.server_name,'www.','','all'))#";
				var tms_dealerCode = "#Get_TDDS.OEM_Key#";
				var tms_region = "#lcase(Get_TDDS.TDDS_region)#";
				var tms_tda = "#lcase(Get_TDDS.TDDS_tda)#";
				var tms_district = "#lcase(Get_TDDS.TDDS_district)#";
				<cfif len(trim(Get_TDDS.TDDS_autogroup)) gt 0>var tms_autogroup= "#lcase(Get_TDDS.TDDS_autogroup)#";</cfif>
				var tms_provider= "worlddealer";
			</script>

			<!-- SiteCatalyst code version: H.24.1. Copyright 1996-2011 Adobe, Inc. All Rights Reserved More info available at http://www.omniture.com --> 
			<script language="JavaScript" type="text/JavaScript" src="http://www.toyota.com/js/omni/TDDS_dealers_s_code.js"></script>
			
			<!--- New Vehicle Inventory --->
			<cfif left(lcase(cgi.script_name),5) eq "/new/">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop10 = "new";
					tmsomni.prop2 = <cfif len(trim(url.year)) gt 0>"#url.year#"<cfelse>"no value"</cfif>;
					tmsomni.prop9  = <cfif len(trim(url.model)) gt 0>"#url.model#"<cfelse>"no value"</cfif>;
					<cfif lcase(cgi.script_name) contains "make" or lcase(cgi.script_name) contains "index.cfm" or lcase(cgi.script_name) contains "new_cars.cfm">tmsomni.events = "event64";</cfif>
				</script>
			</cfif>
			
			<!--- Used Vehicle Inventory --->
			<cfif left(lcase(cgi.script_name),6) eq "/used/">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop10 = "used";
					tmsomni.prop2 = <cfif len(trim(url.year)) gt 0>"#url.year#"<cfelse>"no value"</cfif>;
					tmsomni.prop9  = <cfif len(trim(url.model)) gt 0>"#url.model#"<cfelse>"no value"</cfif>;
					<cfif lcase(cgi.script_name) contains "make" or lcase(cgi.script_name) contains "index.cfm" or lcase(cgi.script_name) contains "used_cars.cfm">tmsomni.events = "event64";</cfif>
				</script>
			</cfif>
			
			<!--- Certified Inventory --->
			<cfif left(lcase(cgi.script_name),11) eq "/certified/">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop10 = "certified";
					tmsomni.prop2 = <cfif len(trim(url.year)) gt 0>"#url.year#"<cfelse>"no value"</cfif>;
					tmsomni.prop9  = <cfif len(trim(url.model)) gt 0>"#url.model#"<cfelse>"no value"</cfif>;
					<cfif lcase(cgi.script_name) contains "make" or lcase(cgi.script_name) contains "index.cfm" or lcase(cgi.script_name) contains "certified.cfm">tmsomni.events = "event64";</cfif>
				</script>
			</cfif>
			
			<cfif url.tdds_contact eq "yes">
				<script language="JavaScript" type="text/JavaScript" >
					var doOnce = false;
					function OnFocusTrack () {
						if (doOnce){return false;}{
							tmsomni.trackExternalLinks=false;
							tmsomni.linkTrackVars='prop6,prop64,eVar6,eVar64,events';
							tmsomni.linkTrackEvents=tmsomni.events='event67';
							tmsomni.tl(this, 'o',"#lcase(GetFileFromPath(cgi.CF_TEMPLATE_PATH))# - Form Start");
							doOnce = true;
						}
					}
				</script>
			</cfif>
			
			<cfif url.tdds_contact eq "yes">
				<script language="JavaScript" type="text/JavaScript" >
					var doOnceTweet = false;
					function TweetTrack () {
						if (doOnceTweet){return false;}{
							tmsomni.trackExternalLinks=false;
							tmsomni.linkTrackEvents=tmsomni.events='event46';
							tmsomni.tl(this, 'o',"#lcase(GetFileFromPath(cgi.CF_TEMPLATE_PATH))# - Tweet");
							doOnceTweet = true;
						}
					}
				</script>
			</cfif>
			
			<!--- Contact Us Start --->
			<cfif lcase(cgi.script_name) eq "/forms/contact.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "contact";
					tmsomni.prop64 = "other";
					tmsomni.events = "event67";
				</script>
			</cfif>

			<!--- Contact Us Save --->
			<cfif lcase(cgi.script_name) eq "/forms/contact_action.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.eVar6 = "contact";
					tmsomni.eVar64 = "other";
				</script>
			</cfif>
			
			<!--- Contact Us End --->
			<cfif lcase(cgi.script_name) eq "/forms/thank_you_contact.cfm">
				<script language="JavaScript" type="text/JavaScript" > 
					//Set Custom Page Load Variables
					tmsomni.prop6 = "contact";
					tmsomni.prop64 = "contact";
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
			<cfif lcase(cgi.script_name) eq "/forms/test_drive.cfm">
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
					tmsomni.events = "event67";
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
			<cfif lcase(cgi.script_name) eq "/forms/schedule_service.cfm">
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
			
			<script language="JavaScript" type="text/JavaScript"><!-- 
			/************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/ 
			var s_code=tmsomni.t();if(s_code)document.write(s_code)//--></script> 
			<!-- End SiteCatalyst code version: H.24.X. --> 
	
		</cfif>

	</cffunction>

</cfcomponent>