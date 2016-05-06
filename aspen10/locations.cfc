<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="store_class" default="">
		<cfargument name="address_class" default="">
		<cfargument name="phone_class" default="">
		<cfargument name="show_primary" default="no">
		<cfargument name="show_nv" default="no">
		<cfargument name="show_uv" default="no">
		<cfargument name="show_service" default="no">
		<cfargument name="show_parts" default="no">
		<cfargument name="label_primary" default="Store">
		<cfargument name="label_nv" default="New Vehicle Sales">
		<cfargument name="label_uv" default="Used Vehicle Sales">
		<cfargument name="label_service" default="Service">
		<cfargument name="label_parts" default="Parts">
		<cfargument name="show_primary_btn" default="no">
		<cfargument name="primary_label" default="Visit Website">
		<cfargument name="show_service_btn" default="no">
		<cfargument name="show_parts_btn" default="no">
		<cfargument name="service_label" default="Schedule Service Now">
		<cfargument name="service_btn_class" default="">
		
		
		<cfquery datasource="Aspen10" name="Get_Locations">
			SELECT		Dealer_Locations.Dealer_ID,
						Dealers.Display_Name,
						Dealers.Address_1,
						Dealers.Address_2,
						Dealers.City,
						Dealers.State,
						Dealers.Zip,
						Dealers.Primary_URL,
						Dealers.Link_Finance,
						Dealers.Link_Service,
						Dealers.Link_Sales,
						Dealers.Link_Parts,
						Dealers.Link_Directions,
			
						Dealer_Phones.Area_Code, 
						Dealer_Phones.Prefix,
						Dealer_Phones.Line_Number,
						Dealer_Phones.Vanity_Number,
			
						Dealer_Phones_1.Area_Code AS nv_area_code,
						Dealer_Phones_1.Prefix AS nv_prefix, 
						Dealer_Phones_1.Line_Number AS nv_line_number,
						Dealer_Phones_1.Vanity_Number AS nv_vanity_number,
			
						Dealer_Phones_2.Area_Code AS uv_area_code,
						Dealer_Phones_2.Prefix AS uv_prefix, 
						Dealer_Phones_2.Line_Number AS uv_line_number,
						Dealer_Phones_2.Vanity_Number AS uv_vanity,
			
						Dealer_Phones_3.Area_Code AS service_area_code,
						Dealer_Phones_3.Prefix AS service_prefix, 
						Dealer_Phones_3.Line_Number AS service_line_number,
						Dealer_Phones_3.Vanity_Number AS service_vanity_number,
			
						Dealer_Phones_4.Area_Code AS parts_area_code, 
						Dealer_Phones_4.Prefix AS parts_prefix,
						Dealer_Phones_4.Line_Number AS parts_line_number,
						Dealer_Phones_4.Vanity_Number AS parts_vanity_number
			
			FROM		Dealer_Locations
			
			INNER JOIN	Dealers ON Dealer_Locations.Location_ID = Dealers.Dealer_ID
			INNER JOIN	Dealer_Phones ON Dealers.Primary_Phone = Dealer_Phones.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_1 ON Dealers.Inv_Phone_New = Dealer_Phones_1.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_2 ON Dealers.Inv_Phone_Used = Dealer_Phones_2.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_3 ON Dealers.Service_Phone = Dealer_Phones_3.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_4 ON Dealers.Parts_Phone = Dealer_Phones_4.Phone_ID
			
			WHERE		Dealer_Locations.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Locations.Hierarchy
		</cfquery>
		
		<div class="row">
			<cfloop query="Get_Locations">
				<div class="col-md-3">
					<div class="#arguments.store_class#" title="#Get_Locations.Display_Name#">#Get_Locations.Display_Name#</div>
					<div class="#arguments.address_class#" title="#Get_Locations.Address_1# #Get_Locations.Address_2# #Get_Locations.City# #Get_Locations.State# #Get_Locations.Zip#">
						#Get_Locations.Address_1#<br/>
						<cfif len(trim(Get_Locations.Address_2)) gt 0>#Get_Locations.Address_2#<br/></cfif>
						#Get_Locations.City#, #Get_Locations.State# #Get_Locations.Zip#<br/>
					</div>
					<div class="#arguments.phone_class#">
						<cfswitch expression="#Get_Locations.Dealer_ID#">
							<cfdefaultcase>
								<cfif arguments.show_primary eq "yes">
									<cfif len(trim(Vanity_Number)) gt 0>
										<cfif len(trim(label_primary)) gt 0>#arguments.label_primary#: </cfif>#Get_Locations.Vanity_Number#
									<cfelse>
										<cfif len(trim(area_code)) gt 0>
											<cfif len(trim(label_primary)) gt 0>#arguments.label_primary#: </cfif>(#Get_Locations.area_code#) #Get_Locations.prefix#-#Get_Locations.line_number#<br/>
										</cfif>
									</cfif>
								</cfif>
								<cfif arguments.show_nv eq "yes">
									<cfif len(trim(nv_vanity_number)) gt 0>
										<cfif len(trim(label_nv)) gt 0>#arguments.label_nv#: </cfif>#Get_Locations.nv_vanity_number#
									<cfelse>
										<cfif len(trim(nv_area_code)) gt 0>
											<cfif len(trim(label_nv)) gt 0>#arguments.label_nv#: </cfif>(#Get_Locations.nv_area_code#) #Get_Locations.nv_prefix#-#Get_Locations.nv_line_number#<br/>
										</cfif>
									</cfif>
								</cfif>
								<cfif arguments.show_uv eq "yes">
									<cfif len(trim(uv_vanity_number)) gt 0>
										<cfif len(trim(label_uv)) gt 0>#arguments.label_uv#: </cfif>#Get_Locations.uv_vanity_number#
									<cfelse>
										<cfif len(trim(uv_area_code)) gt 0>
											<cfif len(trim(label_uv)) gt 0>#arguments.label_uv#: </cfif>(#Get_Locations.uv_area_code#) #Get_Locations.uv_prefix#-#Get_Locations.uv_line_number#<br/>
										</cfif>
									</cfif>
								</cfif>
								<cfif arguments.show_service eq "yes">
									<cfif len(trim(service_vanity_number)) gt 0>
										<cfif len(trim(label_service)) gt 0>#arguments.label_service#: </cfif>#Get_Locations.service_vanity_number#
									<cfelse>
										<cfif len(trim(service_area_code)) gt 0>
											<cfif len(trim(label_service)) gt 0>#arguments.label_service#: </cfif>(#Get_Locations.service_area_code#) #Get_Locations.service_prefix#-#Get_Locations.service_line_number#<br/>
										</cfif>
									</cfif>
								</cfif>
								<cfif arguments.show_parts eq "yes">
									<cfif len(trim(parts_vanity_number)) gt 0>
										<cfif len(trim(label_parts)) gt 0>#arguments.label_parts#: </cfif>#Get_Locations.parts_vanity_number#
									<cfelse>
										<cfif len(trim(parts_area_code)) gt 0>
											<cfif len(trim(label_parts)) gt 0>#arguments.label_parts#: </cfif>(#Get_Locations.parts_area_code#) #Get_Locations.parts_prefix#-#Get_Locations.parts_line_number#<br/>
										</cfif>
									</cfif>
								</cfif>
							</cfdefaultcase>
							<cfcase value="35"> 
								Easton: (888) 473-1683<br/>
								Emmaus: (888) 431-1294<br/>
							</cfcase>
						</cfswitch>
					</div>
					<cfif arguments.show_primary_btn eq "yes">
						<a class="#arguments.service_btn_class#" href="http://#Get_Locations.Primary_URL#" target="_blank" title="Visit #Get_Locations.Primary_URL#">#arguments.primary_label#</a>
					</cfif>
					<cfif arguments.show_service_btn eq "yes" and len(trim(Get_Locations.Link_Service)) gt 0>
						<a class="#arguments.service_btn_class#" href="#Get_Locations.Link_Service#" target="_blank" title="Schedule Service at #Get_Locations.Display_Name#">#arguments.service_label#</a>
					</cfif>
					<cfif arguments.show_parts_btn eq "yes" and len(trim(Get_Locations.Link_Parts)) gt 0>
						<a class="#arguments.service_btn_class#" href="#Get_Locations.Link_Parts#" target="_blank" title="Visit #Get_Locations.Link_Parts#">#arguments.parts_label#</a>
					</cfif>
				</div>
				<cfif arguments.Dealer_ID eq "162">
					<cfif Get_Locations.currentRow eq Get_Locations.recordcount>
						<div class="col-md-9 no-pad" align="center">
							<cfinvoke component="/cfcs/aspen10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="33"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="loc-splash-map"/>
								<cfinvokeargument name="glyph_left" value="true"/>
							</cfinvoke>
						</div>
					</cfif>
				</cfif>
				<cfif Get_Locations.currentRow mod 4 eq 0>
					</div><div class="row">
				</cfif>
			</cfloop>
		</div>
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="store_class" default="">
		<cfargument name="address_class" default="">
		<cfargument name="phone_class" default="">
		<cfargument name="show_primary" default="no">
		<cfargument name="show_nv" default="no">
		<cfargument name="show_uv" default="no">
		<cfargument name="show_service" default="no">
		<cfargument name="show_parts" default="no">
		<cfargument name="label_primary" default="Store">
		<cfargument name="label_nv" default="New Vehicle Sales">
		<cfargument name="label_uv" default="Used Vehicle Sales">
		<cfargument name="label_service" default="Service">
		<cfargument name="label_parts" default="Parts">
		<cfargument name="show_primary_btn" default="no">
		<cfargument name="primary_label" default="Visit Website">
		<cfargument name="show_service_btn" default="no">
		<cfargument name="show_parts_btn" default="no">
		<cfargument name="service_label" default="Schedule Service Now">
		<cfargument name="service_btn_class" default="">
		
		
		<cfquery datasource="Aspen10" name="Get_Locations">
			SELECT		Dealer_Locations.Dealer_ID,
						Dealers.Display_Name,
						Dealers.Address_1,
						Dealers.Address_2,
						Dealers.City,
						Dealers.State,
						Dealers.Zip,
						Dealers.Primary_URL,
						Dealers.Link_Finance,
						Dealers.Link_Service,
						Dealers.Link_Sales,
						Dealers.Link_Parts,
						Dealers.Link_Directions,
			
						Dealer_Phones.Area_Code, 
						Dealer_Phones.Prefix,
						Dealer_Phones.Line_Number,
						Dealer_Phones.Vanity_Number,
			
						Dealer_Phones_1.Area_Code AS nv_area_code,
						Dealer_Phones_1.Prefix AS nv_prefix, 
						Dealer_Phones_1.Line_Number AS nv_line_number,
						Dealer_Phones_1.Vanity_Number AS nv_vanity_number,
			
						Dealer_Phones_2.Area_Code AS uv_area_code,
						Dealer_Phones_2.Prefix AS uv_prefix, 
						Dealer_Phones_2.Line_Number AS uv_line_number,
						Dealer_Phones_2.Vanity_Number AS uv_vanity,
			
						Dealer_Phones_3.Area_Code AS service_area_code,
						Dealer_Phones_3.Prefix AS service_prefix, 
						Dealer_Phones_3.Line_Number AS service_line_number,
						Dealer_Phones_3.Vanity_Number AS service_vanity_number,
			
						Dealer_Phones_4.Area_Code AS parts_area_code, 
						Dealer_Phones_4.Prefix AS parts_prefix,
						Dealer_Phones_4.Line_Number AS parts_line_number,
						Dealer_Phones_4.Vanity_Number AS parts_vanity_number
			
			FROM		Dealer_Locations
			
			INNER JOIN	Dealers ON Dealer_Locations.Location_ID = Dealers.Dealer_ID
			INNER JOIN	Dealer_Phones ON Dealers.Primary_Phone = Dealer_Phones.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_1 ON Dealers.Inv_Phone_New = Dealer_Phones_1.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_2 ON Dealers.Inv_Phone_Used = Dealer_Phones_2.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_3 ON Dealers.Service_Phone = Dealer_Phones_3.Phone_ID
			INNER JOIN	Dealer_Phones AS Dealer_Phones_4 ON Dealers.Parts_Phone = Dealer_Phones_4.Phone_ID
			
			WHERE		Dealer_Locations.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Locations.Hierarchy
		</cfquery>
		
		<table style="width:100%">
			<tr>
				<cfloop query="Get_Locations">
					<td class="col-md-3">
						<div class="#arguments.store_class#" title="#Get_Locations.Display_Name#">#Get_Locations.Display_Name#</div>
						<div class="#arguments.address_class#" title="#Get_Locations.Address_1# #Get_Locations.Address_2# #Get_Locations.City# #Get_Locations.State# #Get_Locations.Zip#">
							#Get_Locations.Address_1#<br/>
							<cfif len(trim(Get_Locations.Address_2)) gt 0>#Get_Locations.Address_2#<br/></cfif>
							#Get_Locations.City#, #Get_Locations.State# #Get_Locations.Zip#<br/>
						</div>
						<div class="#arguments.phone_class#">
							<cfswitch expression="#Get_Locations.Dealer_ID#">
								<cfdefaultcase>
									<cfif arguments.show_primary eq "yes">
										<cfif len(trim(Vanity_Number)) gt 0>
											<cfif len(trim(label_primary)) gt 0>#arguments.label_primary#: </cfif>#Get_Locations.Vanity_Number#
										<cfelse>
											<cfif len(trim(area_code)) gt 0>
												<cfif len(trim(label_primary)) gt 0>#arguments.label_primary#: </cfif>(#Get_Locations.area_code#) #Get_Locations.prefix#-#Get_Locations.line_number#<br/>
											</cfif>
										</cfif>
									</cfif>
									<cfif arguments.show_nv eq "yes">
										<cfif len(trim(nv_vanity_number)) gt 0>
											<cfif len(trim(label_nv)) gt 0>#arguments.label_nv#: </cfif>#Get_Locations.nv_vanity_number#
										<cfelse>
											<cfif len(trim(nv_area_code)) gt 0>
												<cfif len(trim(label_nv)) gt 0>#arguments.label_nv#: </cfif>(#Get_Locations.nv_area_code#) #Get_Locations.nv_prefix#-#Get_Locations.nv_line_number#<br/>
											</cfif>
										</cfif>
									</cfif>
									<cfif arguments.show_uv eq "yes">
										<cfif len(trim(uv_vanity_number)) gt 0>
											<cfif len(trim(label_uv)) gt 0>#arguments.label_uv#: </cfif>#Get_Locations.uv_vanity_number#
										<cfelse>
											<cfif len(trim(uv_area_code)) gt 0>
												<cfif len(trim(label_uv)) gt 0>#arguments.label_uv#: </cfif>(#Get_Locations.uv_area_code#) #Get_Locations.uv_prefix#-#Get_Locations.uv_line_number#<br/>
											</cfif>
										</cfif>
									</cfif>
									<cfif arguments.show_service eq "yes">
										<cfif len(trim(service_vanity_number)) gt 0>
											<cfif len(trim(label_service)) gt 0>#arguments.label_service#: </cfif>#Get_Locations.service_vanity_number#
										<cfelse>
											<cfif len(trim(service_area_code)) gt 0>
												<cfif len(trim(label_service)) gt 0>#arguments.label_service#: </cfif>(#Get_Locations.service_area_code#) #Get_Locations.service_prefix#-#Get_Locations.service_line_number#<br/>
											</cfif>
										</cfif>
									</cfif>
									<cfif arguments.show_parts eq "yes">
										<cfif len(trim(parts_vanity_number)) gt 0>
											<cfif len(trim(label_parts)) gt 0>#arguments.label_parts#: </cfif>#Get_Locations.parts_vanity_number#
										<cfelse>
											<cfif len(trim(parts_area_code)) gt 0>
												<cfif len(trim(label_parts)) gt 0>#arguments.label_parts#: </cfif>(#Get_Locations.parts_area_code#) #Get_Locations.parts_prefix#-#Get_Locations.parts_line_number#<br/>
											</cfif>
										</cfif>
									</cfif>
								</cfdefaultcase>
								<cfcase value="35"> 
									Easton: (888) 473-1683<br/>
									Emmaus: (888) 431-1294<br/>
								</cfcase>
							</cfswitch>
						</div>
						<cfif arguments.show_primary_btn eq "yes">
							<a class="#arguments.service_btn_class#" href="http://#Get_Locations.Primary_URL#" target="_blank" title="Visit #Get_Locations.Primary_URL#">#arguments.primary_label#</a>
						</cfif>
						<cfif arguments.show_service_btn eq "yes" and len(trim(Get_Locations.Link_Service)) gt 0>
							<a class="#arguments.service_btn_class#" href="#Get_Locations.Link_Service#" target="_blank" title="Schedule Service at #Get_Locations.Display_Name#">#arguments.service_label#</a>
						</cfif>
						<cfif arguments.show_parts_btn eq "yes" and len(trim(Get_Locations.Link_Parts)) gt 0>
							<a class="#arguments.service_btn_class#" href="#Get_Locations.Link_Parts#" target="_blank" title="Visit #Get_Locations.Link_Parts#">#arguments.parts_label#</a>
						</cfif>
					</td>
					<cfif arguments.Dealer_ID eq "162">
						<cfif Get_Locations.currentRow eq Get_Locations.recordcount>
							<td colspan="3" align="center">
								<cfinvoke component="/cfcs/aspen10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="33"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="loc-splash-map"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke>
							</td>
						</cfif>
					</cfif>
					<cfif Get_Locations.currentRow mod 4 eq 0>
						</tr><tr>
					</cfif>
				</cfloop>
			</tr>
		</table>
	
			
	
	
	
	</cffunction>

</cfcomponent>