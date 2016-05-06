<cfcomponent>

	<cffunction name="phone" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="title_class" default="">

		<cfquery datasource="Ultra10" name="Get_Phones">
			SELECT		Departments.Department,
						Dealer_Phones.Area_Code,
						Dealer_Phones.Prefix,
						Dealer_Phones.Line_Number,
						Dealer_Phones.Vanity_Number,
						Dealer_Phones.Phone_Label, 
						Dealer_Phones.Dealer_Dept_ID as phoner,
						Join_Dealer_Dept.Dealer_Dept_ID as dphone
			FROM		Dealer_Phones
			INNER JOIN	Join_Dealer_Dept
			ON			Dealer_Phones.Dealer_Dept_ID = Join_Dealer_Dept.Dealer_Dept_ID
			INNER JOIN	Departments
			ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
			WHERE		Dealer_Phones.Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			ORDER BY 	Dealer_Phones.Hierarchy
		</cfquery>

		<cfquery datasource="Ultra10" name="Get_Main_Hours">
			SELECT		Dealer_Dept_Hours.Line_Desc,
						Dealer_Dept_Hours.Line_Value
			FROM		Join_Dealer_Dept
			INNER JOIN	Dealer_Dept_Hours
			ON			Join_Dealer_Dept.Dealer_Dept_ID = Dealer_Dept_Hours.Dealer_Dept_ID
			WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			AND			Join_Dealer_Dept.Dept_ID = 45
			ORDER BY 	Dealer_Dept_Hours.Hierarchy
		</cfquery>

		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>
		
		<cfif #arguments.dealer_id# NEQ 256 > <!--- No COntact Address for Faulkner TBS --->
        <div itemscope itemtype="http://schema.org/AutoDealer">    
			<div class="#arguments.title_class#" title="#arguments.dealer_name#" itemprop="name">#arguments.dealer_name#</div>
        <div itemprop="address" itemscope itemtype="ttp://schema.org/PostalAddress">  
			<div class="content-dealer" title="#arguments.address_1#" itemprop="streetAddress">#arguments.address_1#</div>
			<div class="content-dealer" title="#arguments.address_2#">#arguments.address_2#</div>
			<div class="content-dealer" title="#arguments.city#, #arguments.state# #arguments.zip#">
            	<cfif #arguments.city# NEQ "" ><span itemprop="addressLocality">#arguments.city#</span>, <span itemprop="addressRegion">#arguments.state#</span> <span itemprop="postalCode">#arguments.zip#</span></cfif></div>
        </div>
        </div>
			<cfif Get_Form_Locations.recordcount eq 0>
				<a class="content-link" href="http://#cgi.server_name#/dealership/hours_and_directions.cfm" title="Get Directions">Get Directions</a>
			<cfelse>
			<cfif #arguments.dealer_id# NEQ 162 >
				<a class="content-link" href="http://#cgi.server_name#/dealership/locations.cfm" title="See Our Locations">See Our Locations</a>
			<cfelse>	
				<a class="content-link" href="http://#cgi.server_name#/dealer/baierlservice/new_locations.cfm" title="See Our Locations">See Our Locations</a>
			</cfif>	
				
			</cfif>
			<hr style="border-top: 1px solid black;"/>
        	<div itemscope itemtype="http://schema.org/AutoDealer">    
			<cfloop query="Get_Phones">
				<cfif len(trim(Get_Phones.Vanity_Number)) gt 0>
					<div class="content-phone" title="#Get_Phones.Vanity_Number#"  itemprop="telephone"><b>#Get_Phones.Phone_Label#:</b> #Get_Phones.Vanity_Number#</div>
				<cfelse>
				<cfif #arguments.dealer_id# NEQ 343 >
					<div class="content-phone" title="#Get_Phones.Phone_Label#: (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#" itemprop="telephone"><b>#Get_Phones.Phone_Label#:</b> (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</div>
				<cfelse>
					<div class="content-phone" title="#Get_Phones.Phone_Label#: (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#" itemprop="telephone"><b>#Get_Phones.Phone_Label#:</b> (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</div>
				</cfif>

				</cfif>
			</cfloop>
            </div>
			<hr style="border-top: 1px solid black;"/>
			<cfif Get_Form_Locations.recordcount eq 0>
				<div class="#arguments.title_class#" title="Store Hours">Store Hours</div>
				<a class="content-link" href="http://#cgi.server_name#/dealership/hours_and_directions.cfm" title="View All Department Hours">View All Department Hours</a>
			</cfif>
		<cfelse>
			<cfif #arguments.dealer_id# NEQ 162 >
				<a class="content-link" href="http://#cgi.server_name#/dealership/locations.cfm" title="See Our Locations">See Our Locations</a>
			<cfelse>	
				<a class="content-link" href="http://#cgi.server_name#/dealership/new_locations.cfm" title="See Our Locations">See Our Locations</a>
			</cfif>	
		</cfif>

	</cffunction>

	<cffunction name="phone_mobile" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="title_class" default="">
		
		
		<cfquery datasource="ultra10" name="Chk_Directions">
			SELECT		directions
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Dealer_ID#" maxlength="6">
		</cfquery>
		
		<cfset directions_on_off = #Chk_Directions.directions# >
		
		<cfif #arguments.dealer_id# eq 133 or #arguments.dealer_id# eq 196 or #arguments.dealer_id# eq 197 >
			
		<cfelse>
			<cfquery datasource="Ultra10" name="Get_Phones">
				SELECT		Departments.Department,
							Dealer_Phones.Area_Code,
							Dealer_Phones.Prefix,
							Dealer_Phones.Line_Number,
							Dealer_Phones.Vanity_Number,
							Dealer_Phones.Phone_Label
				FROM		Dealer_Phones
				INNER JOIN	Join_Dealer_Dept
				ON			Dealer_Phones.Dealer_Dept_ID = Join_Dealer_Dept.Dealer_Dept_ID
				INNER JOIN	Departments
				ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
				WHERE		Dealer_Phones.Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
				AND			Dealer_Phones.mobile = 1
				ORDER BY 	Dealer_Phones.Hierarchy
			</cfquery>
	
			<!--- <hr/> --->
			<cfif url.show_map eq 1 and #directions_on_off# EQ 1 >
				<cfset new_address = #replace(url.address_1,' ','%20','ALL')#>
					<cfif #url.dealer_id# NEQ 365  and  #url.dealer_id# NEQ 369>
						<a class="content-phone mobile-phone" title="Get Directions" href="http://maps.google.com/maps?q=#new_address#+#url.city#+#url.state#+#url.zip#" target="_blank" onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackEvents = 'event10';tmsomni.tl(true, 'o', 'mapDirections');"><img alt="Get Directions" src="http://#cgi.server_name#/images/inventory/icon_sm_clickformap.png"/> Get Directions</a>
					<cfelse>
						<a class="hdr-content-phone mobile-phone" title="Get Directions" href="http://maps.google.com/maps?q=#new_address#+#url.city#+#url.state#+#url.zip#" target="_blank" onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackEvents = 'event10';tmsomni.tl(true, 'o', 'mapDirections');"><img alt="Get Directions" src="http://#cgi.server_name#/images/inventory/icon_sm_clickformap.png"/> Get Directions</a>
					</cfif>	
			</cfif>
			<cfloop query="Get_Phones">
				<cfset variables.dial="#Get_Phones.Area_Code##Get_Phones.Prefix##Get_Phones.Line_Number#">
				<cfif len(trim(Get_Phones.Vanity_Number)) gt 0>
					<cfif #url.dealer_id# NEQ 365 and  #url.dealer_id# NEQ 369>
						<a class="content-phone mobile-phone" title="#Get_Phones.Vanity_Number#" href="tel:#variables.dial#" onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackEvents = 'event9';tmsomni.tl(true, 'o', 'clicktocall');"><img src="http://#cgi.server_name#/images/inventory/icon_SM_clicktocall.png"/> <b>#Get_Phones.Phone_Label#:</b> #Get_Phones.Vanity_Number#</a>
					<cfelse>
						<a class="hdr-content-phone mobile-phone" title="#Get_Phones.Vanity_Number#" href="tel:#variables.dial#" onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackEvents = 'event9';tmsomni.tl(true, 'o', 'clicktocall');"><img src="http://#cgi.server_name#/images/inventory/icon_SM_clicktocall.png"/> <b>#Get_Phones.Phone_Label#:</b> #Get_Phones.Vanity_Number#</a>
					</cfif>
					
				<cfelse>
					<cfif #url.dealer_id# NEQ 365 and  #url.dealer_id# NEQ 369>
						<a class="content-phone mobile-phone" title="Click to Call: (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#" href="tel:#variables.dial#" onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackEvents = 'event9';tmsomni.tl(true, 'o', 'clicktocall');"><img alt="(#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#"  src="http://#cgi.server_name#/images/inventory/icon_SM_clicktocall.png"/> <b>#Get_Phones.Phone_Label#:</b> (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</a>
				  	<cfelse>
						<a class="hdr-content-phone mobile-phone" title="Click to Call: (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#" href="tel:#variables.dial#" onClick = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackEvents = 'event9';tmsomni.tl(true, 'o', 'clicktocall');"><img alt="(#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#"  src="http://#cgi.server_name#/images/inventory/icon_SM_clicktocall.png"/> <b>#Get_Phones.Phone_Label#:</b> (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</a>
					</cfif>
				</cfif>
			</cfloop>
	
		</cfif>

	</cffunction>


	<cffunction name="phone_corp" description="shows a standard header" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="title_class" default="">

		<cfquery datasource="Ultra10" name="Get_Phones">
			SELECT		Departments.Department,
						Dealer_Phones.Area_Code,
						Dealer_Phones.Prefix,
						Dealer_Phones.Line_Number,
						Dealer_Phones.Vanity_Number,
						Dealer_Phones.Phone_Label, 
						Dealer_Phones.Dealer_Dept_ID as phoner,
						Join_Dealer_Dept.Dealer_Dept_ID as dphone
			FROM		Dealer_Phones
			INNER JOIN	Join_Dealer_Dept
			ON			Dealer_Phones.Dealer_Dept_ID = Join_Dealer_Dept.Dealer_Dept_ID
			INNER JOIN	Departments
			ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
			WHERE		Dealer_Phones.Dealer_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			ORDER BY 	Dealer_Phones.Hierarchy
		</cfquery>

		<cfquery datasource="Ultra10" name="Get_Main_Hours">
			SELECT		Dealer_Dept_Hours.Line_Desc,
						Dealer_Dept_Hours.Line_Value
			FROM		Join_Dealer_Dept
			INNER JOIN	Dealer_Dept_Hours
			ON			Join_Dealer_Dept.Dealer_Dept_ID = Dealer_Dept_Hours.Dealer_Dept_ID
			WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="6">
			AND			Join_Dealer_Dept.Dept_ID = 45
			ORDER BY 	Dealer_Dept_Hours.Hierarchy
		</cfquery>

		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>
		

        <div itemscope itemtype="http://schema.org/AutoDealer">    
			<div class="#arguments.title_class#" title="#arguments.dealer_name#" itemprop="name">#arguments.dealer_name#</div>
        <div itemprop="address" itemscope itemtype="ttp://schema.org/PostalAddress">  
			<div class="content-dealer" title="#arguments.address_1#" itemprop="streetAddress">#arguments.address_1#</div>
			<div class="content-dealer" title="#arguments.address_2#">#arguments.address_2#</div>
			<div class="content-dealer" title="#arguments.city#, #arguments.state# #arguments.zip#">
            	<cfif #arguments.city# NEQ "" ><span itemprop="addressLocality">#arguments.city#</span>, <span itemprop="addressRegion">#arguments.state#</span> <span itemprop="postalCode">#arguments.zip#</span></cfif></div>
        </div>
        </div>
			

	</cffunction>
	
	
	
</cfcomponent>

