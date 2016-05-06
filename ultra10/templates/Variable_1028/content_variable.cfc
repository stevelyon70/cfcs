<cfcomponent>

	<cffunction name="modern" description="shows a standard header" output="Yes" access="public">	
		
	<!--- arguments --->
	<cfargument name="Get_Nav" required="true">
	<cfargument name="Get_Phones" required="true">

	<!--- Check for Toyota Dealer  --->
	<cfset ss_trigger = 0 >
	<cfquery datasource="ultra10" name="Chk_tdds">SELECT Dealer_ID,	OEM_Key, TDDS, TDDS_region,	TDDS_tda,TDDS_district,	TDDS_autogroup FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
	<cfif #Chk_tdds.TDDS# EQ 1><cfset ss_trigger = 1 ></cfif>
	<!--- Check for Toyota Dealer  --->
	
	<!--- Check for Quick Quote / Search Links  / Video --->
	<cfset variables.srch_meth = 0 >
	<cfset variables.price_srch_meth = 0 >  
	<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	srch_method,bxs_new_used, price_srch_method  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
	<cfset variables.srch_meth = #Chk_Srch.srch_method# >

	<cfset tmp_bx_type = "0" >   <!--- Default for Carousel --->
		
	<cfset variables.price_srch_meth = #Chk_Srch.price_srch_method# >

	<cfset sub_section_1_active = 0 >
	<cfset sub_section_2_active = 0 >
	<cfset sub_sec_v1_active = 0 >
	<cfset sub_sec_v2_active = 0 >
	<cfset sub_sec_helpful_1_active = 0 >
	<cfset sub_sec_helpful_2_active = 0 >
	<cfset sub_section_spl_type = 0 >
	<cfset contain_nav = 0 >		<!--- Primary Navigation 0 = No 1 = Yes--->
	<cfset position_nav = 0 >		<!--- Position Navigation 0 = Standard 1 = Variable --->
	<cfset section_seq = ArrayNew(1) >
	<cfset section_seq_active = ArrayNew(1) >
	<cfset scrn_title = 0>	 <!--- variable to include Screen Title  --->
	
	<cfquery datasource="Ultra10" name="Get_Layout">
		SELECT  ID, dealer_id, page_type, module_id, module_name, has_subs, variable_spl1, variable_spl2, variable_nav_type, hierarchy, active
		FROM    Variable_template_dealer_layout
		WHERE	dealer_id = #url.dealer_id#
		AND		page_type = #url.page_type#
		AND		active = 1
		ORDER BY  hierarchy ASC
	</cfquery>

	<cfset b = 0 >
	<cfloop  query="Get_Layout" >
		<cfset b = #b# +1 >
		<cfset section_seq[b] = "#Get_Layout.module_name#" >
			<cfif #Get_Layout.hierarchy# EQ 0 AND  #Get_Layout.active# EQ 1 ><cfset scrn_title = 1></cfif>
			
			<cfif #Get_Layout.has_subs# EQ 1 and #Get_Layout.module_ID# EQ 1 OR #Get_Layout.module_ID# EQ 49  >
				<cfset sub_section_1_active = #Get_Layout.variable_spl1# >		<!--- Search Position 0 = None 1=left 2=right --->
				<cfset sub_section_2_active = #Get_Layout.variable_spl2# >		<!--- Slideshow/Carousel 0 = None 1=Slideshow 2=Carousel--->
				<cfset sub_section_spl_type = #Get_Layout.variable_nav_type# >	<!--- Nav_Type_ID for Slideshow ---> 
			</cfif>
			
			<cfif #Get_Layout.module_ID# EQ 14 >
				<cfset tmp_bx_type = #Get_Layout.variable_spl1# >		<!--- New or Used for Carousel --->
			</cfif>	
			
			<cfif #Get_Layout.module_ID# EQ 19 >
				<cfset contain_nav = #Get_Layout.variable_spl1# >		<!--- Primary Navigation 0 = No 1 = Yes--->
				<cfset position_nav = #Get_Layout.variable_spl2# >		<!--- Primary Navigation 0 = Standard 1 = Variable --->
			</cfif>	
			
			<cfif #Get_Layout.module_ID# EQ 23 >
				<cfset sub_sec_v1_active = #Get_Layout.variable_spl1# >		<!--- Video Position 0=Non 1=left 2=right --->
				<cfset sub_sec_v2_active = #Get_Layout.variable_spl2# >		<!--- Form Style 0=Contact Us 1=Test Drive 2=Quote --->
			</cfif>	
			<cfif #Get_Layout.module_ID# EQ 24 >
				<cfset sub_sec_helpful_1_active = #Get_Layout.variable_spl1# >		<!--- Carousel Position 0=Non 1=left 2=right --->
				<cfset sub_sec_helpful_2_active = #Get_Layout.variable_spl2# >		<!--- Search / Link Style 0=Helpful Links 1=Search --->
			</cfif>	
			
		<cfset pg_nbr = #Get_Layout.page_type# >
	</cfloop>
	<cfset num_sections = #b# >
	
	<cfset spl1 	= #sub_section_1_active# >
	<cfset spl2 	= #sub_section_2_active# >
	<cfset ss_type 	= #sub_section_spl_type# >
	<cfif #tmp_bx_type# EQ 0 >
		<cfset variables.bx_type 	= "U" >
	<cfelse>
		<cfset variables.bx_type 	= "N" >
	</cfif>
		
	<cfinclude template="section_utility_1.cfm">
	<cfloop index="x" from="1" to="#num_sections#" >
		
			<cfinclude template="#section_seq[x]#">

	</cfloop>
	

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	</cffunction>

</cfcomponent>