<!---
	Element Types:
		1 - Body
		2 - Header
		3 - Navigation Bar
		4 - Footer
 --->

<cfcomponent>

	<cffunction name="save_css" description="save css to database" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" required="true">
		<cfargument name="db_table" required="true">
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_template_id" required="true">
		<cfargument name="dealer_template_element_id" required="true">

		<cfargument name="extend" default="">
		<cfargument name="width" default="100%">
		<cfargument name="text_align" default="left">
		<cfargument name="height" default="">
		<cfargument name="min_height" default="">
		<cfargument name="max_height" default="">

		<cfargument name="bg_color" default="">
		<cfargument name="bg_grade_top" default="">
		<cfargument name="bg_grade_bot" default="">
		<cfargument name="bg_grade_left" default="">
		<cfargument name="bg_grade_right" default="">
		

		<cfargument name="bg_image" default="">
		<cfargument name="bg_image_repeat" default="">
		<cfargument name="bg_image_position" default="">
		<cfargument name="bg_image_attach" default="">

		<cfargument name="padding_top" default="">
		<cfargument name="padding_bot" default="">
		<cfargument name="padding_left" default="">
		<cfargument name="padding_right" default="">
		
		<cfargument name="margin_top" default="">
		<cfargument name="margin_bot" default="">
		<cfargument name="margin_left" default="">
		<cfargument name="margin_right" default="">
		
		<cfargument name="border_color" default="">
		<cfargument name="border_top" default="">
		<cfargument name="border_bot" default="">
		<cfargument name="border_left" default="">
		<cfargument name="border_right" default="">
		<cfargument name="border_spec" default="">
		<cfargument name="border_radius" default="">

		<cfargument name="font_family" default="">
		<cfargument name="font_color" default="">
		<cfargument name="font_color_rollover" default="">
		<cfargument name="font_bg_color" default="">
		<cfargument name="font_bg_rollover" default="">
		
		<cfargument name="font_size" default="">
		<cfargument name="font_weight" default="">
		<cfargument name="font_style" default="">
		
		<cfquery datasource="#arguments.dsn#" name="Get_Image">
			SELECT		Bg_Image
			FROM 		#arguments.db_table#
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Dealer_Template_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">
			AND			Dealer_Template_Element_ID  = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_element_id#" maxlength="6">
		</cfquery>

		<cfif len(trim(Get_Image.Bg_Image)) gt 0 and len(trim(arguments.bg_image)) eq 0>
			<cfset arguments.bg_image=Get_Image.Bg_Image>
		</cfif>
		
		<cfquery datasource="#arguments.dsn#" name="Delete_CSS">
			DELETE FROM #arguments.db_table#
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Dealer_Template_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">
			AND			Dealer_Template_Element_ID  = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_element_id#" maxlength="6">
		</cfquery>

		#arguments.extend#
		
		<cfquery datasource="#arguments.dsn#" name="Insert_CSS">
			INSERT INTO	#arguments.db_table#
				(	Dealer_ID,
					Dealer_Template_ID,
					Dealer_Template_Element_ID,

					Extend,
					Width,
					text_align,
					Height,
					min_Height,
					max_Height,

					Bg_Color,
					Bg_Gradient_Top,
					Bg_Gradient_Bot, 
					Bg_Gradient_left,
					Bg_Gradient_right, 
					
                	<cfif len(trim(arguments.bg_image)) gt 0>
						Bg_Image,
					</cfif>
                	
					Bg_Repeat,
					Bg_Position,
					Bg_Attach,
					
					Padding_Top,
					Padding_Bot,
					Padding_Left,
					Padding_Right,
					
					Margin_Top,
					Margin_Bot,
					Margin_Left,
					Margin_Right, 
                    
					Border_Color,
					Border_Top,
					Border_Bot,
					Border_Left,
					Border_Right,
					Border_Spec,
					Border_Radius,
					
					Font_Family,
					Font_Color,
					Font_Bg_Color,
					Font_Color_Rollover,
					Font_BG_Rollover,
					Font_Size,
					Font_Weight,
					Font_Style
					)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_element_id#" maxlength="6">,

				<cfif len(trim(arguments.extend)) gt 0><cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.extend#" maxlength="1"><cfelse>1</cfif>,
				<cfif len(trim(arguments.width)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.width#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.text_align)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.text_align#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.height)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.height#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.min_height)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.min_height#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.max_height)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.max_height#" maxlength="6"><cfelse>NULL</cfif>,
				
				<cfif len(trim(arguments.bg_color)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_color#" maxlength="15"><cfelse>'ffffff'</cfif>,
				<cfif len(trim(arguments.bg_grade_top)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_grade_top#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.bg_grade_bot)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_grade_bot#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.bg_grade_left)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_grade_left#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.bg_grade_right)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_grade_right#" maxlength="15"><cfelse>NULL</cfif>,

				
				<cfif len(trim(arguments.bg_image)) gt 0>
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_image#" maxlength="100">,
				</cfif>
				

				<cfif len(trim(arguments.bg_image_repeat)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_image_repeat#" maxlength="15"><cfelse>'repeat'</cfif>,
				<cfif len(trim(arguments.bg_image_position)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_image_position#" maxlength="15"><cfelse>'left top'</cfif>,
				<cfif len(trim(arguments.bg_image_attach)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.bg_image_attach#" maxlength="15"><cfelse>'scroll'</cfif>,
				
				<cfif len(trim(arguments.padding_top)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.padding_top#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.padding_bot)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.padding_bot#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.padding_left)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.padding_left#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.padding_right)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.padding_right#" maxlength="6"><cfelse>NULL</cfif>,

				<cfif #trim(arguments.margin_top)# gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.margin_top#" maxlength="6"><cfelse>0</cfif>,
				<cfif #trim(arguments.margin_bot)# gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.margin_bot#" maxlength="6"><cfelse>0</cfif>,
				<cfif #trim(arguments.margin_left)# gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.margin_left#" maxlength="6"><cfelse>0</cfif>,
				<cfif #trim(arguments.margin_right)# gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.margin_right#" maxlength="6"><cfelse>0</cfif>,

				<cfif len(trim(arguments.border_color)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.border_color#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.border_top)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.border_top#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.border_bot)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.border_bot#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.border_left)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.border_left#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.border_right)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.border_right#" maxlength="6"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.border_spec)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.border_spec#" maxlength="30"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.border_radius)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.border_radius#" maxlength="30"><cfelse>NULL</cfif>,

				<cfif len(trim(arguments.font_family)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_family#" maxlength="50"><cfelse>'arial, serif'</cfif>,
				<cfif len(trim(arguments.font_color)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_color#" maxlength="15"><cfelse>'000000'</cfif>,
				<cfif len(trim(arguments.font_bg_color)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_bg_color#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.font_color_rollover)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_color_rollover#" maxlength="15"><cfelse>NULL</cfif>,
				<cfif len(trim(arguments.font_bg_rollover)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_bg_rollover#" maxlength="15"><cfelse>NULL</cfif>,
				
				<cfif len(trim(arguments.font_size)) gt 0><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.font_size#" maxlength="6"><cfelse>12</cfif>,
				<cfif len(trim(arguments.font_weight)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_weight#" maxlength="10"><cfelse>'normal'</cfif>,
				<cfif len(trim(arguments.font_style)) gt 0><cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.font_style#" maxlength="10"><cfelse>'normal'</cfif>
				)
		</cfquery>
		
	</cffunction>
	
	<cffunction name="delete_img" description="delete image" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dsn" default="true">
		<cfargument name="db_table" default="true">
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_template_id" required="true">
		<cfargument name="dealer_template_element_id" required="true">
			
		<cfquery datasource="#arguments.dsn#" name="Get_Image">
			SELECT		Bg_Image
			FROM 		#arguments.db_table#
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Dealer_Template_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">
			AND			Dealer_Template_Element_ID  = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_element_id#" maxlength="6">
		</cfquery>

		<cftry>
			<cffile action="delete" file="#arguments.save_directory#\#arguments.Dealer_Template_ID#\#Get_Image.Bg_Image#">
			<cfcatch></cfcatch>
		</cftry>

		<cfquery datasource="#arguments.dsn#" name="Delete_Image">
			UPDATE		#arguments.db_table#
			SET			Bg_Image = NULL
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Dealer_Template_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">
			AND			Dealer_Template_Element_ID  = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_element_id#" maxlength="6">
		</cfquery>
		
	</cffunction>

</cfcomponent>