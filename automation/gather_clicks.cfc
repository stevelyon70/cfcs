<cfcomponent>

	<cffunction name="page_clicks" description="gathers page clicks from a click directory" output="no" access="public">

		<!---arguments --->
		<cfargument name="site_id" required="true">
		<cfargument name="top_directory" required="true">
		<cfargument name="click_directory" required="true">
		<cfargument name="conversion_type" required="true">
	
		<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#" name="Get_Dealers" type="dir">

		<ul>

			<cfloop query="Get_Dealers">
	
				<li>#Get_Dealers.Name#</li>

				<cfset variables.Dealer_ID=Get_Dealers.Name>

				<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#\#Get_Dealers.name#" name="Get_Activity" type="file">
				
				<ul>

					<cfloop query="Get_Activity">
	
						<li>#Get_Activity.name#</li>
	
							<cffile action="read" file="#arguments.top_directory#\#arguments.click_directory#\#Get_Dealers.name#\#Get_Activity.name#" variable="myfile" >

							<ul>
	
								<cfset variables.file_date=replace(Get_Activity.name,".txt","")>
								<cfset variables.file_date="#mid(variables.file_date,5,2)#/#right(variables.file_date,2)#/#left(variables.file_date,4)#">
							
								<cfif variables.file_date lt dateformat(now(),"mm/dd/yyyy")>

									<cfquery datasource="Leads" name="insert_conversion">
										INSERT INTO	Conversions
											(Site_ID,
											Dealer_ID,
											Conversion_Type_ID,
											Conversion_Date,
											Clicks)
										VALUES
											(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#" maxlength="4">,
											<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.Dealer_ID#" maxlength="4">,
											<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.conversion_type#" maxlength="4">,
											<cfqueryparam cfsqltype="cf_sql_date" value="#variables.file_date#" maxlength="10">,
											<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.myfile#" maxlength="4">)
									</cfquery>
								
									<li>#arguments.conversion_type# - #arguments.site_id# - #variables.Dealer_ID# - #variables.file_date# - #variables.myfile#</li>

									<cftry>
										<cffile action="delete" file="#arguments.top_directory#\#arguments.click_directory#\#Get_Dealers.name#\#Get_Activity.name#">
										<cfcatch></cfcatch>
									</cftry>
									
								</cfif>
								
							</ul>
					
					</cfloop>

				</ul>
		
			</cfloop>

		</ul>

	</cffunction>

	<cffunction name="v_clicks" description="gathers vehicles clicks from a click directory" output="no" access="public">

		<!---arguments --->
		<cfargument name="site_id" required="true">
		<cfargument name="top_directory" required="true">
		<cfargument name="click_directory" required="true">
		<cfargument name="conversion_type" required="true">

		<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#" name="Get_Dealers" type="dir">

		<ul>

			<cfloop query="Get_Dealers">

				<cfset variables.Dealer_ID=Get_Dealers.Name>
				
				<li>#variables.Dealer_ID#</li>
				
				<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#\#variables.Dealer_ID#" name="Get_Vins" type="dir">
				
				<ul>
					
					<cfloop query="Get_Vins">
						
						<cfset variables.Vin=Get_Vins.Name>

						<li>#variables.Vin#</li>

						<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#\#variables.Dealer_ID#\#variables.Vin#" name="Get_Activity" type="file">
						
						<cffile action="read" file="#arguments.top_directory#\#arguments.click_directory#\#variables.Dealer_ID#\#variables.Vin#\desc.txt" variable="mydesc">
						
						<ul>
							
							<cfloop query="Get_Activity">

								<cfset variables.file_date=replace(Get_Activity.name,".txt","")>
								<cfset variables.file_date="#mid(variables.file_date,5,2)#/#right(variables.file_date,2)#/#left(variables.file_date,4)#">
								
								<cfif Get_Activity.name neq "desc.txt">
									<cfif variables.file_date lt dateformat(now(),"mm/dd/yyyy")>
										<cffile action="read" file="#arguments.top_directory#\#arguments.click_directory#\#variables.Dealer_ID#\#variables.Vin#\#Get_Activity.name#" variable="myfile">
										<li>#arguments.conversion_type# - #arguments.site_id# - #variables.Dealer_ID# - #variables.file_date# - #variables.Vin# - #variables.myfile# - #variables.mydesc#</li>
										<cfquery datasource="Leads" name="insert_conversion">
											INSERT INTO	Conversions
												(Site_ID,
												Dealer_ID,
												Description,
												Conversion_Type_ID,
												Conversion_Date,
												Clicks,
												Vin)
											VALUES
												(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#" maxlength="4">,
												<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.Dealer_ID#" maxlength="4">,
												<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.mydesc#" maxlength="200">,
												<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.conversion_type#" maxlength="4">,
												<cfqueryparam cfsqltype="cf_sql_date" value="#variables.file_date#" maxlength="10">,
												<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.myfile#" maxlength="4">,
												<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.vin#" maxlength="21">)
										</cfquery>
										<cftry>
											<cffile action="delete" file="#arguments.top_directory#\#arguments.click_directory#\#variables.Dealer_ID#\#variables.Vin#\#Get_Activity.name#">
											<cfcatch></cfcatch>
										</cftry>
									</cfif>
								</cfif>
					
							</cfloop>
							
						</ul>
						
					</cfloop>
					
				</ul>

			</cfloop>
			
		</ul>
	
		
	
	</cffunction>
	
	<cffunction name="v_clicks_old" description="gathers vehicles clicks from a click directory" output="No" access="public">

		<!---arguments --->
		<!---<cfargument name="site_id" required="true">
		<cfargument name="top_directory" required="true">
		<cfargument name="click_directory" required="true">
		<cfargument name="conversion_type" required="true">
	
		<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#" name="Get_Vins" type="dir">

		<ul>

			<cfloop query="Get_Vins">
	
				<li>#Get_Vins.Name#</li>

				<cfset variables.Vin=Get_Vins.Name>

				<cfdirectory action="list" directory="#arguments.top_directory#\#arguments.click_directory#\#variables.Vin#" name="Get_Activity" type="file">
				
				<ul>

					<cfloop query="Get_Activity">

						<cfset variables.file_date=replace(Get_Activity.name,".txt","")>
						<cfset variables.file_date="#mid(variables.file_date,5,2)#/#right(variables.file_date,2)#/#left(variables.file_date,4)#">
					
						<cffile action="read" file="#arguments.top_directory#\#arguments.click_directory#\#variables.Vin#\#Get_Activity.name#" variable="myfile" >
						
						<cfquery datasource="automall" name="Get_Dealer">
							SELECT 	Dealer_ID,
									V_New_Used,
									Stock,
									V_Year,
									V_Make,
									V_Model,
									V_Trim
							FROM	Vehicles
							WHERE	Vin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.Vin#" maxlength="21">
						</cfquery>

						<cfif len(trim(Get_Dealer.Dealer_ID)) gt 0>
							<cfquery datasource="Leads" name="insert_conversion">
								INSERT INTO	Conversions
									(Site_ID,
									Dealer_ID,
									Description,
									Conversion_Type_ID,
									Conversion_Date,
									Clicks,
									Vin)
								VALUES
									(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#" maxlength="4">,
									<cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Dealer.Dealer_ID#" maxlength="4">,
									<cfqueryparam cfsqltype="cf_sql_varchar" value="#Get_Dealer.V_New_Used# - #Get_Dealer.Stock# - #Get_Dealer.V_Year# #Get_Dealer.V_Make# #Get_Dealer.V_Model# #Get_Dealer.V_Trim#" maxlength="200">,
									<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.conversion_type#" maxlength="4">,
									<cfqueryparam cfsqltype="cf_sql_date" value="#variables.file_date#" maxlength="10">,
									<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.myfile#" maxlength="4">,
									<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.vin#" maxlength="21">)
							</cfquery>
						</cfif>
						
						<li>#arguments.conversion_type# - #arguments.site_id# - #Get_Dealer.Dealer_ID# - #variables.file_date# - #variables.Vin# - #variables.myfile#</li>
					
					</cfloop>

				</ul>
		
			</cfloop>

		</ul>--->

	</cffunction>

</cfcomponent>