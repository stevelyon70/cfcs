<cfcomponent>

	<cffunction name="import_options" description="Imports the tcuv options & incentive xml data from local file" output="yes" access="public">	

		<!--- arguments --->
		<cfargument name="dsn" required="true">

		<cfquery datasource="Imports" name="Get_Vins">
			SELECT		OEM_Key,
						Dealer_ID,
						Dealercode,
						Vin
			FROM		Import_TCUV
			WHERE		Options_Imported = 0
			ORDER BY 	OEM_Key, Vin
		</cfquery>
		
		<cfloop query="Get_Vins">

			<cfset variables.incentive_apr="">
			<cfset variables.disclaimer="">
			<cfset variables.incentive_id="">
			<cfset variables.installed_list="">
			<cfset variables.safety_list="">
			<cfset variables.exterior_list="">
			<cfset variables.interior_list="">
			<cfset variables.mechanical_list="">

			<li>Importing #Get_Vins.Vin#</li>
			
			<cffile action="read" file="E:\tcuv\vins\#Get_Vins.Vin#.xml" variable="myXML">
			
			<cfif variables.myXML contains "Connection Failure">

				<li>Connection Failure</li>

			<cfelseif variables.myXML contains "Connection Timeout">

				<li>Connection Timeout</li>


			<cfelse>
		
				<cfset variables.myXML = xmlParse(variables.myXML)>
				
				<!---<cfdump var="#variables.myXML#" >--->
	
				<cftry><cfset variables.incentive_id=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Incentive.IncentiveID.XmlText><cfcatch></cfcatch></cftry>
	
				<!---Incentives--->
				<cfif len(trim(variables.incentive_id)) gt 0>
					<cfset variables.incentives_error=0>
					<cftry>
						<cfset variables.incentives_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem)>	
						<cfcatch>
							<cfset variables.incentives_error=1>
						</cfcatch>
					</cftry>
					<cfif variables.incentives_error eq 0>
						<cfloop from="1" to="#variables.incentives_array_len#" index="inc_id">
							<cfset variables.this_incentive_id=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Incentive.IncentiveID.XmlText>
							<cfif variables.this_incentive_id eq variables.incentive_id>
								<cfset variables.this_inc_active=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Incentive.ActiveIndicator.XmlText>
								<cfif variables.this_inc_active eq "true">
									<cfset variables.this_apr=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Financing.AnnualPercentageRate.XmlText>
									<cfset variables.this_term=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Financing.TermMeasure.XmlText>
									<cfset variables.incentive_apr="APR as low as #variables.this_apr#% for #variables.this_term# months">
									<cfset variables.disclaimer_error=0>
									<cftry>
										<cfset variables.disclaimer_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Financing.FinancingComments)>	
										<cfcatch>
											<cfset variables.disclaimer_error=1>
										</cfcatch>
									</cftry>
									<cfif variables.incentives_error eq 0>
										<cfloop from="1" to="#variables.disclaimer_array_len#" index="disc">
											<cfset variables.this_disc=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Financing.FinancingComments[#disc#].XmlAttributes.languageID>
											<cfif variables.this_disc eq "En">
												<cfset variables.disclaimer=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingIncentiveLineItem[#inc_id#].Financing.FinancingComments[#disc#].XmlText>
											</cfif>
										</cfloop>
									</cfif>
								</cfif>
								<cfbreak>
							</cfif>
						</cfloop>
					</cfif>
				</cfif>
	
				<!---Options Processing--->
				<cfset variables.option_error=0>
				<cftry>
					<cfset variables.options_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup)>	
					<cfcatch>
						<cfset variables.option_error=1>
					</cfcatch>
				</cftry>
				<cfif variables.option_error eq 0>
					<cfloop from="1" to="#variables.options_array_len#" index="cat">
						
						<cfset variables.this_cat = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeatureGroupName.XmlText>
	
						<!---Safety Options--->
						<cfif variables.this_cat contains "SAFETY">
							<cfset variables.this_option_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature)>
							<cfloop from="1" to="#variables.this_option_len#" index="option">
								<cfset variables.this_option = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature[#option#].OptionShortDescription.XmlText>
								<cfset variables.this_option=replace(variables.this_option,",","&##44;","all")>				
								<cfset variables.safety_list=listappend(variables.safety_list,variables.this_option)>
							</cfloop>
						</cfif>
	
						<!---Exterior Options--->
						<cfif variables.this_cat contains "EXTERIOR">
							<cfset variables.this_option_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature)>
							<cfloop from="1" to="#variables.this_option_len#" index="option">
								<cfset variables.this_option = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature[#option#].OptionShortDescription.XmlText>
								<cfset variables.this_option=replace(variables.this_option,",","&##44;","all")>
								<cfset variables.exterior_list=listappend(variables.exterior_list,variables.this_option)>
							</cfloop>
						</cfif>
	
						<!---Interior Options--->
						<cfif variables.this_cat contains "INTERIOR">
							<cfset variables.this_option_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature)>
							<cfloop from="1" to="#variables.this_option_len#" index="option">
								<cfset variables.this_option = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature[#option#].OptionShortDescription.XmlText>
								<cfset variables.this_option=replace(variables.this_option,",","&##44;","all")>
								<cfset variables.interior_list=listappend(variables.interior_list,variables.this_option)>
							</cfloop>
						</cfif>
	
						<!---Comfort Options--->
						<cfif variables.this_cat contains "COMFORT">
							<cfset variables.this_option_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature)>
							<cfloop from="1" to="#variables.this_option_len#" index="option">
								<cfset variables.this_option = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature[#option#].OptionShortDescription.XmlText>
								<cfset variables.this_option=replace(variables.this_option,",","&##44;","all")>
								<cfset variables.interior_list=listappend(variables.interior_list,variables.this_option)>
							</cfloop>
						</cfif>
	
						<!---Mechanical Options--->
						<cfif variables.this_cat contains "MECHANICAL">
							<cfset variables.this_option_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature)>
							<cfloop from="1" to="#variables.this_option_len#" index="option">
								<cfset variables.this_option = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.Vehicle.StandardEquipment.StandardFeatureGroup[#cat#].StandardFeature[#option#].OptionShortDescription.XmlText>
								<cfset variables.this_option=replace(variables.this_option,",","&##44;","all")>
								<cfset variables.mechanical_list=listappend(variables.mechanical_list,variables.this_option)>
							</cfloop>
						</cfif>
	
					</cfloop>
					
				</cfif>
	
				<!---Installed Options Processing--->
				<cfset variables.installed_error=0>
				<cftry>
					<cfset variables.installed_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.RemarketingOption)>	
					<cfcatch>
						<cfset variables.installed_error=1>
					</cfcatch>
				</cftry>
				
				<cfif variables.installed_error eq 0>
					<cfloop from="1" to="#variables.installed_array_len#" index="installed">
						<cfset variables.this_installed = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.RemarketingOption[#installed#].OptionShortDescription.XmlText>
						<cfset variables.installed_notes_error=0>
						<cfset variables.installed_notes="">
						<cftry>
							<cfset variables.notes_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.RemarketingOption[#installed#].OptionNotes)>			
							<cfcatch>
								<cfset variables.installed_notes_error=1>
							</cfcatch>
						</cftry>
						<cfif variables.installed_notes_error eq 0>
							<cfloop from="1" to="#variables.notes_array_len#" index="note">
								<cfset variables.this_note=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.RemarketingOption[#installed#].OptionNotes[#note#].XmlText>
								<cfset variables.this_note=replace(variables.this_note,",","&##44;","all")>
								<cfif len(trim(variables.installed_notes)) eq 0>
									<cfset variables.installed_notes=variables.this_note>
								<cfelse>
									<cfset variables.installed_notes=variables.installed_notes & " " & variables.this_note>
								</cfif>
							</cfloop>
						</cfif>
						<cfset variables.this_installed = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem.RemarketingOption[#installed#].OptionShortDescription.XmlText>
						<cfif len(trim(variables.installed_notes)) gt 0>
							<cfset variables.this_installed=variables.this_installed & " " & variables.installed_notes>
						</cfif>
						<cfset variables.installed_list=listappend(variables.installed_list,variables.this_installed)>
					</cfloop>
				</cfif>
			
				<!---<li>#Get_Vins.Vin# #Get_Vins.Dealer_ID#</li>
				<ul>
					<li>#variables.incentive_id#</li>
					<li>#variables.incentive_apr#</li>
					<li>#variables.disclaimer#</li>
					<li>#variables.installed_list#</li>
					<li>#variables.safety_list#</li>
					<li>#variables.exterior_list#</li>
					<li>#variables.interior_list#</li>
					<li>#variables.mechanical_list#</li>
				</ul>--->
	
				<cfif len(trim(variables.incentive_apr)) gt 0>
					<cfquery datasource="Imports" name="Update_Incentives">
						UPDATE		Import_TCUV
						SET			Incentive_APR = <cfif len(trim(variables.incentive_apr)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.incentive_apr#" maxlength="100"><cfelse>NULL</cfif>,
									Incentive_APR_Disclaimer = <cfif len(trim(variables.disclaimer)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.disclaimer#"><cfelse>NULL</cfif>
						WHERE		Vin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Vin#" maxlength="21">
						AND			Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Dealer_ID#" maxlength="4">
					</cfquery>
				</cfif>
	
				<cfif len(trim(variables.installed_list)) gt 0 or len(trim(variables.safety_list)) gt 0 or len(trim(variables.exterior_list)) gt 0 or len(trim(variables.interior_list)) gt 0 or len(trim(variables.mechanical_list)) gt 0>
					<cfquery datasource="Imports" name="Update_Options">
						UPDATE		Import_TCUV
						SET			Installed = <cfif len(trim(variables.installed_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.installed_list#"><cfelse>NULL</cfif>,
	                      			Safety = <cfif len(trim(variables.safety_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.safety_list#"><cfelse>NULL</cfif>,
	                      			Exterior = <cfif len(trim(variables.exterior_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.exterior_list#"><cfelse>NULL</cfif>,
	                      			Interior = <cfif len(trim(variables.interior_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.interior_list#"><cfelse>NULL</cfif>,
	                      			Mechanical = <cfif len(trim(variables.mechanical_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.mechanical_list#"><cfelse>NULL</cfif>,
									Options_Imported = 1
						WHERE		Vin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Vin#" maxlength="21">
						AND			Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Dealer_ID#" maxlength="4">
					</cfquery>
				</cfif>
		
			</cfif>
		
		</cfloop>
	
	</cffunction>
	
	<cffunction name="fetch_options" description="fetches the tcuv options xml data" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" required="true">

		<cfset var tzInfo = getTimeZoneInfo().utcHourOffset>
		<cfset var gmtDate = dateFormat(now(), "yyyy-mm-dd")>
		<cfset var gmtTime = "T" & timeFormat(now(), "HH:MM:SS") & "-0" & tzinfo & ":00">
		<cfset var gmt = gmtDate & gmtTime>
		<cfset var uuidLibObj = createObject("java", "java.util.UUID")>
		<cfset var guidStr = uuidLibObj.randomUUID().tostring()>
	
		<cfquery datasource="Imports" name="Get_Vins">
			SELECT		OEM_Key,
						Dealer_ID,
						Dealercode,
						Vin
			FROM		Import_TCUV
			WHERE		Options_Imported = 0
			ORDER BY 	OEM_Key
		</cfquery>
	
		<cfloop query="Get_Vins">

			<!--- Start Timer --->
			<cfset request.execTime = getTickCount()>
			<li>Fetching #Get_Vins.Vin#</li>

				<!---Create Search Request--->
				<cfsavecontent variable="tcuvXML">
					<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<p:GetVehicleRemarketing releaseID="5.4.4" xmlns:udt="http://www.openapplications.org/oagis/9/unqualifieddatatypes/1.1" 
						xmlns:p4="http://www.openapplications.org/oagis/9" 
						xmlns:p3="http://www.starstandard.org/STAR/5/qualifieddatatypes/1.0" 
						xmlns:p2="http://www.starstandard.org/STAR/5/codelists" 
						xmlns:p1="http://www.openapplications.org/oagis/9/codelists" 
						xmlns:clm54217="http://www.openapplications.org/oagis/9/currencycode/54217:2001" 
						xmlns:nmmacl="http://www.nmma.org/CodeLists" 
						xmlns:clm5639="http://www.openapplications.org/oagis/9/languagecode/5639:1988" 
						xmlns:clmIANAMIMEMediaTypes="http://www.openapplications.org/oagis/9/IANAMIMEMediaTypes:2003" 
						xmlns:p="http://www.starstandard.org/STAR/5" 
						xmlns:xfUOMcl="http://www.xfront.com/UnitsOfMeasure" 
						xmlns:clm66411="http://www.openapplications.org/oagis/9/unitcode/66411:2001" 
						xmlns:qdt="http://www.openapplications.org/oagis/9/qualifieddatatypes/1.1" 
						xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
						<p:ApplicationArea>
							<p:Sender>
								<p:CreatorNameCode>#Get_Vins.OEM_Key#</p:CreatorNameCode>
								<p:SenderNameCode>#arguments.provider_code#</p:SenderNameCode>
								<p:PartyID>#arguments.provider_code#</p:PartyID>
							</p:Sender>
							<p:CreationDateTime>#gmt#</p:CreationDateTime>
							<p:BODID>#guidStr#</p:BODID>
							<p:Destination xsi:type="xs:string" xmlns:xs="http://www.w3.org/2001/XMLSchema">DWPTCUV</p:Destination>
						</p:ApplicationArea>
						<p:GetVehicleRemarketingDataArea>
							<p:Get maxItems="100"/>
							<p:VehicleRemarketing>
								<p:VehicleRemarketingHeader>
									<p:DocumentIdentificationGroup>
										<p:DocumentIdentification>
											<p:DocumentID>1</p:DocumentID>
										</p:DocumentIdentification>
									</p:DocumentIdentificationGroup>
									<p:VehicleSearchCriteria>									
										<p:GenericSearchCriteria>
											<p:GenericSearchCriteriaCode>IncentiveIndicator</p:GenericSearchCriteriaCode>
											<p:GenericSearchCriteriaValue>Y</p:GenericSearchCriteriaValue>
										</p:GenericSearchCriteria>									
									</p:VehicleSearchCriteria>
									<p:VehicleSearchCriteria>
										<p:ListSearchCriteria>
											<p:ListSearchCriteriaCode>VIN</p:ListSearchCriteriaCode>
											<p:ListSearchCriteriaValue>#Get_Vins.Vin#</p:ListSearchCriteriaValue>																					
										</p:ListSearchCriteria>
									</p:VehicleSearchCriteria>														
								</p:VehicleRemarketingHeader>
							</p:VehicleRemarketing>
						</p:GetVehicleRemarketingDataArea>
					</p:GetVehicleRemarketing>
				</cfsavecontent>
				
				<cffile action="WRITE" file="E:\tcuv\vins\#Get_Vins.Vin#_send.xml" output="#trim(tcuvXML)#">
				
				<cfhttp method="post" url="#arguments.tcuv_url#" result="httpResponse" timeout="60">
					<cfhttpparam type="header" name="accept-encoding" value="no-compression"/>
					<cfhttpparam type="xml" value="#trim(tcuvXML)#"/>
				</cfhttp>
			
				<!--- Write xml to file for debugging purposes --->
				<cffile action="WRITE" file="E:\tcuv\vins\#Get_Vins.Vin#.xml" output="#httpResponse.fileContent#" addnewline="Yes">
				
			<!--- Stop Timer --->
			<cfset request.execTime = gettickCount() - request.execTime> 
			<cfset request.execTime = request.execTime/1000>
			<li>#Get_Vins.Vin# Fetched - #request.execTime# seconds</li>
			
		</cfloop>
	
	</cffunction>

	<cffunction name="import_vehicle" description="imports the tcuv vehicle xml data from local file" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dsn" required="true">
		<cfargument name="oem_key" required="true">
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealercode" required="true">

		<cffile action="read" file="E:\tcuv\00-#arguments.OEM_Key#_vehicles.xml" variable="myXML">
		
		<cfif variables.myXML contains "Connection Failure">

			<li>Connection Failure</li>

		<cfelseif variables.myXML contains "Connection Timeout">

			<li>Connection Timeout</li>

		<cfelse>

			<cfset variables.myXML = xmlParse(variables.myXML)>
	
			<cfset variables.vehicle_count=0>
	
			<cftry>
				<cfset variables.vehicle_count=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.Show.xmlAttributes.recordSetTotal>
				<cfcatch>
					<cfset variables.vehicle_count=0>
				</cfcatch>
			</cftry>
			
			<cfif variables.vehicle_count gt 0>
	
				<!---<cfdump var="#variables.myXML#" >--->
	
				<cfset variables.v_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem)>
				
				<cfloop from="1" to="#variables.v_array_len#" index="vid">
			
					<!---Default Variables--->
					<cfset variables.vin="">
					<cfset variables.stock="">
					<cfset variables.year="">
					<cfset variables.make="">
					<cfset variables.model="">
					<cfset variables.trim="">
					<cfset variables.bodystyle="">
					<cfset variables.doors="">
					<cfset variables.transmission="">
					<cfset variables.drivetrain="">
					<cfset variables.engine="">
					<cfset variables.cylinders="">
					<cfset variables.price="">
					<cfset variables.odometer="">
					<cfset variables.ext_color="">
					<cfset variables.int_color="">
					<cfset variables.img_full_list="">
					<cfset variables.img_mobile_list="">
			
					<!---Set Variables--->
					<cftry><cfset variables.vin=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.VehicleID.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.stock=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.VehicleStockString.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.year=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.ModelYear.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.make=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.MakeString.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.model=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.SeriesName.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.vtrim=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.TrimCode.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.model_code=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.Model.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.model_desc=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.ModelDescription.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.doors=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.DoorsQuantityNumeric.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.bodystyle=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.BodyStyle.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.fuel=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.FuelTypeCode.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.drivetrain=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.DriveTrain.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.transmission=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.TransmissionGroup.TransmissionTypeName.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.passengers=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.VehiclePassengersNumeric.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.engine=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.Engine.Model.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.cylinders=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.Engine.NumberOfEngineCylindersNumeric.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.price=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].PricingABIE.Price.ChargeAmount.XmlText><cfcatch></cfcatch></cftry>
					<cftry><cfset variables.odometer=myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].OdometerStatus.XmlText><cfcatch></cfcatch></cftry>
			
					<!---Colors--->
					<cfset variables.color_error=0>
					<cftry>
						<cfset variables.color_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.ColorGroup)>	
						<cfcatch>
							<cfset variables.color_error=1>
						</cfcatch>
					</cftry>
					<cfif variables.color_error eq 0>
						<cfloop from="1" to="#variables.color_array_len#" index="color">
							<cfset variables.this_color = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.ColorGroup[#color#].ColorName.XmlText>
							<cfset variables.this_color_type = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].Vehicle.ColorGroup[#color#].ColorItemCode.XmlText>
							<cfif variables.this_color_type eq "Interior">
								<cfset variables.int_color=variables.this_color>
							</cfif>
							<cfif variables.this_color_type eq "Exterior">
								<cfset variables.ext_color=variables.this_color>
							</cfif>
						</cfloop>
					</cfif>
			
					<!---Image Processes--->	
					<cfset variables.img_error=0>
					<cftry>
						<cfset variables.images_array_len = arraylen(myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].AdditionalMedia)>	
						<cfcatch>
							<cfset variables.img_error=1>
						</cfcatch>
					</cftry>
					<cfif variables.img_error eq 0>
						<cfloop from="1" to="#variables.images_array_len#" index="img">
							<cfset variables.this_img = myXML.ShowVehicleRemarketing.ShowVehicleRemarketingDataArea.VehicleRemarketing.VehicleRemarketingVehicleLineItem[#vid#].AdditionalMedia[#img#].MediaSourceURI.XmlText>
							<cfif variables.this_img does not contain "mobile">
								<cfset variables.img_full_list=listappend(variables.img_full_list,variables.this_img)>
							<cfelse>
								<cfset variables.img_mobile_list=listappend(variables.img_mobile_list,variables.this_img)>
							</cfif>
						</cfloop>
					</cfif>
			
					<!---<ul>
						<li>Vin: #variables.vin#</li>
						<li>Stock: #variables.stock#</li>
						<li>Year: #variables.year#</li>
						<li>Make: #variables.make#</li>
						<li>Model: #variables.model#</li>
						<li>Trim: #variables.vtrim#</li>
						<li>Model Code: #variables.model_code#</li>
						<li>Model Desc: #variables.model_desc#</li>
						<li>Doors: #variables.doors#</li>
						<li>Body: #variables.bodystyle#</li>
						<li>Fuel: #variables.fuel#</li>
						<li>Drivetrain: #variables.drivetrain#</li>
						<li>Transmission: #variables.transmission#</li>
						<li>Passengers: #variables.passengers#</li>
						<li>Interior Color: #variables.int_color#</li>
						<li>Exterior Color: #variables.ext_color#</li>
						<li>Engine: #variables.engine#</li>
						<li>Cylinders: #variables.cylinders#</li>
						<li>Price: #variables.price#</li>
						<li>Odometer: #variables.odometer#</li>
						<li>Images: #variables.img_full_list#</li>
					</ul>--->
			
					<cfquery datasource="Imports" name="Insert_tcuv">
						INSERT INTO		Import_TCUV
							(Dealer_ID,
							Dealercode,
							OEM_Key,
							Vin,
							Stock,
							Year,
							Make,
							Model,
							Trim,
							Model_Code,
							Body,
							Doors,
							Transmission,
							Drivetrain,
							Engine,
							Cylinders,
							Price,
							Odometer,
							Fuel,
							Exterior_Color,
							Interior_Color, 
			      			Vehicle_Images,
			      			Mobile_Images)
						VALUES
							(	<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="10">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dealercode#" maxlength="30">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.oem_key#" maxlength="20">,
								<cfif len(trim(variables.vin)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.vin#" maxlength="21"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.stock)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.stock#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.year)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#variables.year#" maxlength="4"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.make)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.make#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.model)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.model#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.vtrim)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.vtrim#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.model_code)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.model_code#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.model_desc)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.model_desc#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.doors)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#variables.doors#" maxlength="1"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.transmission)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.transmission#" maxlength="100"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.drivetrain)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.drivetrain#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.engine)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.engine#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.cylinders)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#variables.cylinders#" maxlength="2"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.price)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#variables.price#" maxlength="10"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.odometer)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#variables.odometer#" maxlength="10"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.fuel)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.fuel#" maxlength="50"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.ext_color)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.ext_color#" maxlength="100"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.int_color)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.int_color#" maxlength="100"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.img_full_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.img_full_list#"><cfelse>NULL</cfif>,
								<cfif len(trim(variables.img_mobile_list)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.img_mobile_list#"><cfelse>NULL</cfif>
							)
					</cfquery>
			
				</cfloop>
	
			<cfelse>
				
				0 Vehicles Found
			
			</cfif>
			
		</cfif>
		
	</cffunction>

	<cffunction name="fetch" description="gets the tcuv xml data" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dsn" required="true">
		<cfargument name="oem_key" required="true">
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealercode" required="true">
		<cfargument name="provider_code" required="true">
		<cfargument name="tcuv_url" required="true">

		<cfset var Insert_tcuv="">
		<cfset var tzInfo = getTimeZoneInfo().utcHourOffset>
		<cfset var gmtDate = dateFormat(now(), "yyyy-mm-dd")>
		<cfset var gmtTime = "T" & timeFormat(now(), "HH:MM:SS") & "-0" & tzinfo & ":00">
		<cfset var gmt = gmtDate & gmtTime>
		<cfset var uuidLibObj = createObject("java", "java.util.UUID")>
		<cfset var guidStr = uuidLibObj.randomUUID().tostring()>

		<cfsavecontent variable="tcuvXML">
			<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
			<p:GetVehicleRemarketing releaseID="5.4.4" xmlns:udt="http://www.openapplications.org/oagis/9/unqualifieddatatypes/1.1" 
				xmlns:p4="http://www.openapplications.org/oagis/9" 
				xmlns:p3="http://www.starstandard.org/STAR/5/qualifieddatatypes/1.0" 
				xmlns:p2="http://www.starstandard.org/STAR/5/codelists" 
				xmlns:p1="http://www.openapplications.org/oagis/9/codelists" 
				xmlns:clm54217="http://www.openapplications.org/oagis/9/currencycode/54217:2001" 
				xmlns:nmmacl="http://www.nmma.org/CodeLists" 
				xmlns:clm5639="http://www.openapplications.org/oagis/9/languagecode/5639:1988" 
				xmlns:clmIANAMIMEMediaTypes="http://www.openapplications.org/oagis/9/IANAMIMEMediaTypes:2003" 
				xmlns:p="http://www.starstandard.org/STAR/5" 
				xmlns:xfUOMcl="http://www.xfront.com/UnitsOfMeasure" 
				xmlns:clm66411="http://www.openapplications.org/oagis/9/unitcode/66411:2001" 
				xmlns:qdt="http://www.openapplications.org/oagis/9/qualifieddatatypes/1.1" 
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
				<p:ApplicationArea>
					<p:Sender>
						<p:CreatorNameCode>#arguments.OEM_Key#</p:CreatorNameCode>
						<p:SenderNameCode>#arguments.provider_code#</p:SenderNameCode>
						<p:PartyID>#arguments.provider_code#</p:PartyID>
					</p:Sender>
					<p:CreationDateTime>#gmt#</p:CreationDateTime>
					<p:BODID>#guidStr#</p:BODID>
					<p:Destination xsi:type="xs:string" xmlns:xs="http://www.w3.org/2001/XMLSchema">DWPTCUV</p:Destination>
				</p:ApplicationArea>
				<p:GetVehicleRemarketingDataArea>
					<p:Get maxItems="9999"/>
					<p:VehicleRemarketing>
						<p:VehicleRemarketingHeader>
							<p:DocumentIdentificationGroup>
								<p:DocumentIdentification>
									<p:DocumentID>1</p:DocumentID>
								</p:DocumentIdentification>
							</p:DocumentIdentificationGroup>
						</p:VehicleRemarketingHeader>
					</p:VehicleRemarketing>
				</p:GetVehicleRemarketingDataArea>
			</p:GetVehicleRemarketing>
		</cfsavecontent>

		<cffile action="WRITE" file="E:\tcuv\#arguments.OEM_Key#_send.xml" output="#trim(tcuvXML)#">

		<cfhttp method="post" url="#arguments.tcuv_url#" result="httpResponse" timeout="60">
			<cfhttpparam type="header" name="accept-encoding" value="no-compression"/>
			<cfhttpparam type="xml" value="#trim(tcuvXML)#"/>
		</cfhttp>
		
		<cffile action="WRITE" file="E:\tcuv\00-#arguments.OEM_Key#_vehicles.xml" output="#httpResponse.fileContent#">
		
	</cffunction>

	<cffunction name="get_tdds" description="Gets TDDS Dealers" output="yes" access="public">
		<!--- arguments --->
		<cfargument name="dsn" required="true">
		<cfset var Get_TDDS="">

		<cfquery datasource="#arguments.dsn#" name="Get_TDDS">
			SELECT     	Dealer_ID,
						Dealercode,
						Display_Name,
						OEM_Key
			FROM		Dealers
			WHERE		TDDS = 1
			AND			Active = 1
			<!---AND			Dealer_ID <> 70--->
			AND			Dealer_ID = 56
			ORDER BY 	Display_Name
		</cfquery>
		
		<cfreturn Get_TDDS>
		
	</cffunction>

	<cffunction name="truncate_tcuv" description="Truncates the TCUV Table" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" required="true">
		<cfset var Truncate_TCUV="">
		
		<cfquery datasource="#arguments.dsn#" name="Truncate_TCUV">
			TRUNCATE TABLE	Import_TCUV
		</cfquery>
		
	</cffunction>

	<cffunction name="update_legacy" description="updates inventory on Ultra9 and below" output="yes" access="public">	

		<!--- arguments --->
		<cfargument name="dsn" required="true">
		<cfargument name="dealer_id" required="true">
		<cfargument name="Dealercode" required="true">

		<cfquery datasource="Imports" name="Get_Vins">
			SELECT		Dealer_ID,
						Dealercode,
						OEM_Key,
						Vin,
						Stock,
						Year,
						Make,
						Model,
						Trim,
						Model_Code,
						Body,
						Doors,
						Transmission,
						Drivetrain,
						Engine,
						Cylinders,
						Price,
						Odometer,
						Fuel,
						Exterior_Color,
						Interior_Color, 
		      			Vehicle_Images,
		      			Mobile_Images,
						Incentive_APR, 
                      	Incentive_APR_Disclaimer,
                      	Installed,
                      	Safety,
                      	Exterior,
                      	Interior,
                      	Mechanical 
			FROM		Import_TCUV
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
			ORDER BY 	Vin
		</cfquery>

		<cfquery datasource="Ultra8" name="Get_Dealer_Info">
			SELECT		Top 1
						Dealership_Name,
						Dealership_Address,
						Dealership_City,
						Dealership_State,
						Dealership_Zip,
						Dealership_Phone,
						PM_Selling_Name
			FROM		Inventory
			WHERE		Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Dealercode#" maxlength="30">
			AND			New_Used = 'U'
			AND			Certified = 0
		</cfquery>

		<cfquery datasource="Ultra8" name="Update_Ultra8_Certified">
			UPDATE		Inventory
			SET			Certified=0
			WHERE		Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Dealercode#" maxlength="30">
			AND			New_Used = 'U'
			AND			Make = 'Toyota'
		</cfquery>

		<cfquery datasource="Ultra8" name="Update_Ultra8_Options">
			DELETE FROM	Inventory
			WHERE		Dealercode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Dealercode#" maxlength="30">
			AND			Vin in (SELECT Vin FROM Imports.dbo.Import_TCUV WHERE Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
		</cfquery>

		<cfquery datasource="Ultra8" name="Delete_Ultra8_Options">
			DELETE		Inventory_Options_Inline
			WHERE		Vin in (SELECT Vin FROM Imports.dbo.Import_TCUV WHERE Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
		</cfquery>
		
		<ul>
			<cfloop query="Get_Vins">
				<cfquery datasource="Ultra8" name="Insert_tcuv">
					INSERT INTO	Inventory
						(Dealercode,
						New_Used,
						Certified,
						Vin,
						Stock,
						Vehicle_Year,
						Make,
						Model,
						Vehicle_Trim,
						Model_Number,
						Vehicle_Style,
						Vehicle_Type,
						Doors,
						Transmission, 
                      	Drive_Train,
                      	Engine_Size,
                      	Cylinders,
                      	PM_Selling_Name,
                      	Selling_Price,
                      	PM_Selling_Price,
                      	Mileage,
                      	Exterior_Color,
                      	Interior_Color,
                      	PM_Photo_Urls,
                      	Image_URLs,
                      	Alt_Price_1,
                      	Alt_Price_2,
                      	Special_Price,
                      	TCUV_Incentive,
                      	TCUV_Disclaimer,
						Dealership_Name,
						Dealership_Address,
						Dealership_City,
						Dealership_State,
						Dealership_Zip,
						Dealership_Phone
                      	)
					VALUES
						(	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dealercode#" maxlength="30">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="U" maxlength="1">,
							<cfqueryparam cfsqltype="cf_sql_bit" value="1" maxlength="1">,
							<cfif len(trim(Get_Vins.Vin)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Vin#" maxlength="21"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Stock)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Stock#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Year)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Year#" maxlength="4"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Make)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Make#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Model)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Model#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Trim)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Trim#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Model_Code)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Model_Code#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Body)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Body#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Body)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Body#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Doors)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Doors#" maxlength="1"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Transmission)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Transmission#" maxlength="100"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Drivetrain)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Drivetrain#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Engine)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Engine#" maxlength="50"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Cylinders)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Cylinders#" maxlength="2"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Dealer_Info.PM_Selling_Name)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.PM_Selling_Name#" maxlength="50"><cfelse>'Selling Price'</cfif>,
							<cfif len(trim(Get_Vins.Price)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Price#" maxlength="10"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Price)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Price#" maxlength="10"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Odometer)) gt 0><cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Vins.Odometer#" maxlength="10"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Exterior_Color)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Exterior_Color#" maxlength="100"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Interior_Color)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Interior_Color#" maxlength="100"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Vehicle_Images)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Vehicle_Images#"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Vehicle_Images)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Vehicle_Images#"><cfelse>NULL</cfif>,
							0,
							0,
							0,
							<cfif len(trim(Get_Vins.Incentive_APR)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Incentive_APR#"><cfelse>NULL</cfif>,
							<cfif len(trim(Get_Vins.Incentive_APR_Disclaimer)) gt 0><cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Incentive_APR_Disclaimer#"><cfelse>NULL</cfif>,	
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.Dealership_Name#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.Dealership_Address#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.Dealership_City#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.Dealership_State#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.Dealership_Zip#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer_Info.Dealership_Phone#">
						)
				</cfquery>

				<cfif 	len(trim(Get_Vins.Safety)) gt 0 or 
						len(trim(Get_Vins.Interior)) gt 0 or 
						len(trim(Get_Vins.Exterior)) gt 0 or
						len(trim(Get_Vins.Mechanical)) gt 0 or
						len(trim(Get_Vins.Installed)) gt 0>

					<cftransaction>
						<cfquery datasource="Ultra8" name="Insert_Ultra8_Options">
							INSERT INTO	Inventory_Options_Inline
								(Vin,
								Exterior,
								Installed,
								Interior,
								Mechanical,
								Safety)
							VALUES
								(<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Vins.Vin#" maxlength="21">,
								<cfif len(trim(Get_Vins.Exterior)) gt 0>'#Get_Vins.Exterior#'<cfelse>NULL</cfif>,
								<cfif len(trim(Get_Vins.Installed)) gt 0>'#Get_Vins.Installed#'<cfelse>NULL</cfif>,
								<cfif len(trim(Get_Vins.Interior)) gt 0>'#Get_Vins.Interior#'<cfelse>NULL</cfif>,
								<cfif len(trim(Get_Vins.Mechanical)) gt 0>'#Get_Vins.Mechanical#'<cfelse>NULL</cfif>,
								<cfif len(trim(Get_Vins.Safety)) gt 0>'#Get_Vins.Safety#'<cfelse>NULL</cfif>)
						</cfquery>
					</cftransaction>

				</cfif>

				<li>#Get_Vins.Vin#</li>
			</cfloop>
		</ul>

	</cffunction>

</cfcomponent>