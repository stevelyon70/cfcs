<cfcomponent>
	
	<cffunction name="get_colors" description="get colors" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="ffffff">
		<cfargument name="hide_none" default="0">

		<cfquery datasource="#arguments.DSN#" name="Get_Colors">
			SELECT     	CSS_Color_ID,
						Color_Name,
						Hex_Code,
						Short_Hand
			FROM		CSS_Colors
			ORDER BY	Color_Name	
		</cfquery>

		<!--- <select name="#arguments.select_name#">
			<cfif arguments.hide_none eq 0>
				<option value="" <cfif arguments.select_value eq "">selected</cfif>>none</option>
			</cfif>
			<option value="transparent" <cfif arguments.select_value eq "transparent">selected</cfif>>transparent</option>
			<cfloop query="Get_Colors">
				<option value="#Get_Colors.Hex_Code#" <cfif Get_Colors.Hex_Code eq arguments.select_value>selected</cfif>>#Get_Colors.Color_Name#</option>
			</cfloop>
		</select>
			or --->
		<input name="#arguments.select_name#" value="#arguments.select_value#" type="text" size="12" maxlength="12"> <span style="color:blue;font-size:8pt">6 digits, or leave blank</span>	

	</cffunction>
	<!--- <cffunction name="get_text" description="get text" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="ffffff">
		<cfargument name="hide_none" default="0">

		
		<input name="#arguments.select_name#" value="#arguments.select_value#" type="text" size="100"  >  	

	</cffunction>
	 --->
	<cffunction name="get_fonts" description="get fonts" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="arial, sans-serif">

		<select name="#arguments.select_name#">
			<option value="arial, sans-serif" <cfif arguments.select_value eq "arial, sans-serif">selected</cfif>>Arial</option>
			<option value="verdana, sans-serif" <cfif arguments.select_value eq "verdana, sans-serif">selected</cfif>>Verdana</option>
			<option value="times new roman, times, serif" <cfif arguments.select_value eq "times new roman, times, serif">selected</cfif>>Times New Toman</option>
			<option value="impact, charcoal, sans-serif" <cfif arguments.select_value eq "impact, charcoal, sans-serif">selected</cfif>>Impact</option>
			<option value="georgia, serif" <cfif arguments.select_value eq "georgia, serif">selected</cfif>>Georgia</option>
		</select>

	</cffunction>

	<cffunction name="get_numbers" description="get numbers" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="12">
		<cfargument name="loop_start" default="1">
		<cfargument name="loop_end" default="10">
		<cfargument name="prefix" default="">
		<cfargument name="suffix" default="px">

		<select name="#arguments.select_name#">
			<cfloop from="#arguments.loop_start#" to="#arguments.loop_end#" index="number">
				<option value="#variables.number#" <cfif arguments.select_value eq variables.number>selected</cfif>>#arguments.prefix##variables.number##arguments.suffix#</option>
			</cfloop>
		</select>

	</cffunction>

	<cffunction name="get_weights" description="get weight" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="normal">
	
		<select name="#arguments.select_name#">
			<option value="normal" <cfif arguments.select_value eq "normal">selected</cfif>>Normal</option>
			<option value="bold" <cfif arguments.select_value eq "bold">selected</cfif>>Bold</option>
		</select>

	</cffunction>

	<cffunction name="get_styles" description="get styles" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="normal">
	
		<select name="#arguments.select_name#">
			<option value="normal" <cfif arguments.select_value eq "normal">selected</cfif>>Normal</option>
			<option value="italic" <cfif arguments.select_value eq "italic">selected</cfif>>Italic</option>
		</select>
	
	</cffunction>
	<cffunction name="get_alignment" description="get alignment" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="normal">
	
		<select name="#arguments.select_name#">
			<option value="left" <cfif arguments.select_value eq "left">selected</cfif>>Left</option>
			<option value="right" <cfif arguments.select_value eq "right">selected</cfif>>Right</option>
			<option value="center" <cfif arguments.select_value eq "center">selected</cfif>>Center</option>
		</select>
	
	</cffunction>
	<cffunction name="get_percent" description="get percent" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="select_name" required="yes">
		<cfargument name="select_value" default="100">
	
		<select name="#arguments.select_name#">
			<cfloop index="x" from="10" to="100" step="5">
				<option value="#x#%" <cfif arguments.select_value eq "#x#%">selected</cfif>>#x#%</option>
			</cfloop>
		</select>
	
	</cffunction>

</cfcomponent>