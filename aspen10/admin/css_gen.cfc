<cfcomponent>

	<cffunction name="create_line" description="writes a line of CSS" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="DSN" default="Aspen10">
		<cfargument name="new_line" default="true">
		<cfargument name="element_id" default="true">
		<cfargument name="dealer_template_id" default="true">
		<cfargument name="Dealer_ID" default="true">
		<cfargument name="save_file" default="true">

		<cfquery datasource="#arguments.DSN#" name="Get_CSS">
			SELECT	Dealer_Template_CSS_ID, Dealer_ID, Dealer_Template_ID, Dealer_Template_Element_ID, Extend, Height, Width, 
					text_align, Bg_Color, Bg_Gradient_Top, Bg_Gradient_Bot,Bg_Gradient_left, Bg_Gradient_right, Bg_Image, Bg_Repeat, Bg_Position, Bg_Attach, 
					Padding_Top, Padding_Bot, Padding_Left, Padding_Right, Margin_Top, Margin_Bot, Margin_Left, Margin_Right, 
					Border_Color, Border_Top, Border_Bot, Border_Left, Border_Right,Border_Spec, Border_Radius,min_height,max_height,
					Font_Family, Font_Color, Font_Bg_Color, Font_Color_Rollover, Font_BG_Rollover, 
       				Font_Size, Font_Weight, Font_Style, Text_Decoration
			FROM	Dealer_Template_CSS
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Dealer_Template_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">
			AND			Dealer_Template_Element_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.element_id#" maxlength="6">
		</cfquery>

		<cfparam name="variables.tag_name" default="">
		<cfparam name="variables.id_name" default="">
		<cfparam name="variables.class_name" default="">

		<cfswitch expression="#arguments.element_id#">
			<cfcase value="1">
				<cfset variables.tag_name="body">
			</cfcase>
			<cfcase value="2">
				<cfset variables.class_name="section-hdr">
			</cfcase>
			<cfcase value="3">
				<cfset variables.class_name="section-nav">
			</cfcase>
			<cfcase value="4">
				<cfset variables.class_name="section-ftr">
			</cfcase>
			<cfcase value="5">
				<cfset variables.class_name="section-spl">
			</cfcase>
			<cfcase value="6">
				<cfset variables.class_name="btn-srp-cust">
			</cfcase>
			<cfcase value="7">
				<cfset variables.class_name="btn-vdp-cust">
			</cfcase>
			<cfcase value="8">
				<cfset variables.class_name="btn-vdp-return-cust">
			</cfcase>
			<cfcase value="9">
				<cfset variables.class_name="price-block-cust">
			</cfcase>
			<cfcase value="10">
				<cfset variables.class_name="calulator-btn-cust">
			</cfcase>
			<cfcase value="11">
				<cfset variables.class_name="section-carousel">
			</cfcase>
			<cfcase value="12">
				<cfset variables.class_name="section-links">
			</cfcase>
			<cfcase value="13">
				<cfset variables.class_name="body-style">
			</cfcase>
		</cfswitch>

		<cfset variables.css_element="">
		
		<cfif len(trim(variables.tag_name)) gt 0>
			<cfset variables.css_element=variables.css_element & variables.tag_name>
		</cfif>

		<cfif len(trim(variables.id_name)) gt 0>
			<cfset variables.css_element=variables.css_element & "##" & variables.id_name>
		</cfif>

		<cfif len(trim(variables.class_name)) gt 0>
			<cfset variables.css_element=variables.css_element & "." & variables.class_name>
		</cfif>
		
		<cffile action="append" file="#arguments.save_file#" output="#variables.css_element#{" addnewline="#arguments.new_line#">

		<cfswitch expression="#arguments.element_id#">
			<cfcase value="1">
				<!---background-color--->
				<cfif len(trim(Get_CSS.bg_color)) gt 0>
					<cffile action="append" file="#arguments.save_file#" output="background-color:###Get_CSS.bg_color#;" addnewline="#arguments.new_line#">
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<!---background-color--->
				<cfif len(trim(Get_CSS.bg_color)) gt 0>
					<cffile action="append" file="#arguments.save_file#" output="background-color:###Get_CSS.bg_color#;" addnewline="#arguments.new_line#">
				</cfif>
		
				<!---background gradient - no image--->
				<cfif len(trim(Get_CSS.bg_image)) eq 0 and len(trim(Get_CSS.Bg_Gradient_Top)) gt 0 and len(trim(Get_CSS.Bg_Gradient_Bot)) gt 0>
					<cffile action="append" file="#arguments.save_file#" output="background: -moz-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*FF3.6+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(###Get_CSS.Bg_Gradient_Top#), to(###Get_CSS.Bg_Gradient_Bot#));/*Chrome,Safari4+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -webkit-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*Chrome10+,Safari5.1+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -o-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*Opera 11.10+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -ms-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*IE10+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: linear-gradient(to bottom, ###Get_CSS.Bg_Gradient_Top# 0%,###Get_CSS.Bg_Gradient_Bot# 100%);/*W3C*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='###Get_CSS.Bg_Gradient_Top#', endColorstr='###Get_CSS.Bg_Gradient_Bot#',GradientType=0 );/*IE6-9*/" addnewline="#arguments.new_line#">
				</cfif>
				<!---background gradient - no image--->
				<cfif len(trim(Get_CSS.bg_image)) eq 0 and len(trim(Get_CSS.Bg_Gradient_left)) gt 0 and len(trim(Get_CSS.Bg_Gradient_right)) gt 0>
					<cffile action="append" file="#arguments.save_file#" output="background: -moz-linear-gradient(left, ###Get_CSS.Bg_Gradient_left#, ###Get_CSS.Bg_Gradient_right#);/*FF3.6+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(###Get_CSS.Bg_Gradient_left#), to(###Get_CSS.Bg_Gradient_right#));/*Chrome,Safari4+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -webkit-linear-gradient(left, ###Get_CSS.Bg_Gradient_left#, ###Get_CSS.Bg_Gradient_right#);/*Chrome10+,Safari5.1+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -o-linear-gradient(left, ###Get_CSS.Bg_Gradient_left#, ###Get_CSS.Bg_Gradient_right#);/*Opera 11.10+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: -ms-linear-gradient(left, ###Get_CSS.Bg_Gradient_left#, ###Get_CSS.Bg_Gradient_right#);/*IE10+*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: linear-gradient(to right, ###Get_CSS.Bg_Gradient_left# 0%,###Get_CSS.Bg_Gradient_right# 100%);/*W3C*/" addnewline="#arguments.new_line#">
					<cffile action="append" file="#arguments.save_file#" output="background: filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='###Get_CSS.Bg_Gradient_left#', endColorstr='###Get_CSS.Bg_Gradient_right#',GradientType=0 );/*IE6-9*/" addnewline="#arguments.new_line#">
				</cfif>
			</cfdefaultcase>
		</cfswitch>


		<!---font color--->
		<cfif len(trim(Get_CSS.font_color)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="color:###Get_CSS.font_color#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---font size--->
		<cfif len(trim(Get_CSS.font_size)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-size:#Get_CSS.font_size#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---font weight--->
		<cfif len(trim(Get_CSS.font_weight)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-weight:#Get_CSS.font_weight#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---font style--->
		<cfif len(trim(Get_CSS.font_style)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-style:#Get_CSS.font_style#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---text decoration--->
		<cfif len(trim(Get_CSS.text_decoration)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="text-decoration:#Get_CSS.text_decoration#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---padding top--->
		<cfif len(trim(Get_CSS.padding_top)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-top:#Get_CSS.padding_top#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---padding bottom--->
		<cfif len(trim(Get_CSS.padding_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-bottom:#Get_CSS.padding_bot#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---padding left--->
		<cfif len(trim(Get_CSS.padding_left)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-left:#Get_CSS.padding_left#px;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---padding right--->
		<cfif len(trim(Get_CSS.padding_right)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-right:#Get_CSS.padding_right#px;" addnewline="#arguments.new_line#">
		</cfif>
		
		
		<!---margin top--->
		<cfif len(trim(Get_CSS.margin_top)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-top:#Get_CSS.margin_top#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---margin bottom--->
		<cfif len(trim(Get_CSS.margin_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-bottom:#Get_CSS.margin_bot#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---margin left--->
		<cfif len(trim(Get_CSS.margin_left)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-left:#Get_CSS.margin_left#px;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---margin right--->
		<cfif len(trim(Get_CSS.margin_right)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-right:#Get_CSS.margin_right#px;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!--- Border color --->
		<cfif len(trim(Get_CSS.border_color)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="border:1px solid ###Get_CSS.border_color#;" addnewline="#arguments.new_line#">
		</cfif>
		<!--- Border Radius --->
		<cfif len(trim(Get_CSS.border_radius)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="border-radius:#Get_CSS.border_radius#px;" addnewline="#arguments.new_line#">
				<cffile action="append" file="#arguments.save_file#" output="-moz-border-radius: #Get_CSS.border_radius#px!important;" addnewline="#arguments.new_line#">			
				<cffile action="append" file="#arguments.save_file#" output="-webkit-border-radius: #Get_CSS.border_radius#px!important;" addnewline="#arguments.new_line#">			
		</cfif>
		<!--- alignment --->
		<cfif len(trim(Get_CSS.text_align)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="text-align:#Get_CSS.text_align#;" addnewline="#arguments.new_line#">
		</cfif>
		<!--- width --->
		<cfif len(trim(Get_CSS.width)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="width:#Get_CSS.width#;" addnewline="#arguments.new_line#">
		</cfif>
		<!--- minimum height --->
		<cfif #Get_CSS.min_height# gt 0>
			<cffile action="append" file="#arguments.save_file#" output="min-height:#Get_CSS.min_height#px;" addnewline="#arguments.new_line#">
		</cfif>
		<!--- maximum height --->
		<cfif #Get_CSS.max_height# gt 0>
			<cffile action="append" file="#arguments.save_file#" output="max-height:#Get_CSS.max_height#px;" addnewline="#arguments.new_line#">
		</cfif>
	
		<cffile action="append" file="#arguments.save_file#" output="}" addnewline="yes">

		<cfswitch expression="#arguments.element_id#">
			<cfcase value="1">
				<!---background-color--->
				<cfif len(trim(Get_CSS.bg_color)) gt 0>
					<cffile action="append" file="#arguments.save_file#" output=".body-style{" addnewline="#arguments.new_line#">					
					<cfif len(trim(Get_CSS.bg_image)) eq 0 and len(trim(Get_CSS.Bg_Gradient_Top)) gt 0 and len(trim(Get_CSS.Bg_Gradient_Bot)) gt 0>
						<cffile action="append" file="#arguments.save_file#" output="background-color:###Get_CSS.bg_color#;" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: -moz-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*FF3.6+*/" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(###Get_CSS.Bg_Gradient_Top#), to(###Get_CSS.Bg_Gradient_Bot#));/*Chrome,Safari4+*/" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: -webkit-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*Chrome10+,Safari5.1+*/" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: -o-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*Opera 11.10+*/" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: -ms-linear-gradient(top, ###Get_CSS.Bg_Gradient_Top#, ###Get_CSS.Bg_Gradient_Bot#);/*IE10+*/" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: linear-gradient(to bottom, ###Get_CSS.Bg_Gradient_Top# 0%,###Get_CSS.Bg_Gradient_Bot# 100%);/*W3C*/" addnewline="#arguments.new_line#">
						<cffile action="append" file="#arguments.save_file#" output="background: filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='###Get_CSS.Bg_Gradient_Top#', endColorstr='###Get_CSS.Bg_Gradient_Bot#',GradientType=0 );/*IE6-9*/" addnewline="#arguments.new_line#">
					</cfif>
					<cffile action="append" file="#arguments.save_file#" output="}" addnewline="yes">
				</cfif>
			</cfcase>
		</cfswitch>
		
	</cffunction>

	<cffunction name="create_line_x" description="writes a line of CSS" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="new_line" default="true">
		<cfargument name="save_file" required="true">
		<cfargument name="tag_name" required="true"> <!--- must be passed but CAN be left blank --->
		<cfargument name="id_name" required="true"> <!--- must be passed but CAN be left blank --->
		<cfargument name="class_name" required="true"> <!--- must be passed but CAN be left blank --->
		<cfargument name="bg_color" default="">
		<cfargument name="bg_image" default="">
		<cfargument name="bg_image_repeat" default="">
		<cfargument name="bg_image_position" default="">
		<cfargument name="bg_image_attach" default="">
		<cfargument name="bg_grade_top" default="">
		<cfargument name="bg_grade_bot" default="">
		<cfargument name="border_top" default="">
		<cfargument name="border_bot" default="">
		<cfargument name="border_left" default="">
		<cfargument name="border_right" default="">
		<cfargument name="height" default="">
		<cfargument name="width" default="100%">
		<cfargument name="text_align" default="left">
		<cfargument name="min_height" default="">
		<cfargument name="min_width" default="">
		<cfargument name="padding_top" default="">
		<cfargument name="padding_bot" default="">
		<cfargument name="padding_left" default="">
		<cfargument name="padding_right" default="">
		<cfargument name="margin_top" default="">
		<cfargument name="margin_bot" default="">
		<cfargument name="margin_left" default="">
		<cfargument name="margin_right" default="">
		<cfargument name="font_family" default="">
		<cfargument name="font_color" default="">
		<cfargument name="font_size" default="">
		<cfargument name="font_weight" default="">
		<cfargument name="font_style" default="">
		<cfargument name="text_decoration" default="">
		<cfargument name="display" default="">
		<cfargument name="clear" default="">
		
		<cfset variables.css_element="">
		
		<cfif len(trim(arguments.tag_name)) gt 0>
			<cfset variables.css_element=variables.css_element & arguments.tag_name>
		</cfif>

		<cfif len(trim(arguments.id_name)) gt 0>
			<cfset variables.css_element=variables.css_element & "##" & arguments.id_name>
		</cfif>

		<cfif len(trim(arguments.class_name)) gt 0>
			<cfset variables.css_element=variables.css_element & "." & arguments.class_name>
		</cfif>
		
		<cffile action="append" file="#arguments.save_file#" output="#variables.css_element#{" addnewline="#arguments.new_line#">

		<!---element display type--->
		<cfif len(trim(arguments.display)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="display:#arguments.display#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---element display type--->
		<cfif len(trim(arguments.clear)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="clear:#arguments.clear#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---element height--->
		<cfif len(trim(arguments.height)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="height:#arguments.height#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---element width--->
		<cfif len(trim(arguments.width)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="width:#arguments.width#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---element min height--->
		<cfif len(trim(arguments.min_height)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="min-height:#arguments.min_height#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---element min width--->
		<cfif len(trim(arguments.min_width)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="min-width:#arguments.min_width#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---background-color--->
		<cfif len(trim(arguments.bg_color)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="background-color:###arguments.bg_color#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---background image - no gradient--->
		<cfif len(trim(arguments.bg_image)) gt 0 and len(trim(arguments.bg_grade_top)) eq 0 and len(trim(arguments.bg_grade_bot)) eq 0>
			<cffile action="append" file="#arguments.save_file#" output="background-image:url('#arguments.bg_image#');" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background-repeat:#arguments.bg_image_repeat#;" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background-position:#arguments.bg_image_position#;" addnewline="#arguments.new_line#">
			<cfif len(trim(arguments.bg_image_attach)) gt 0>
				<cffile action="append" file="#arguments.save_file#" output="background-attachment:#arguments.bg_image_attach#;" addnewline="#arguments.new_line#">
			</cfif>
		</cfif>

		<!---background image + gradient--->
		<cfif len(trim(arguments.bg_image)) gt 0 and len(trim(arguments.bg_grade_top)) gt 0 and len(trim(arguments.bg_grade_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), -moz-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*FF3.6+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), -webkit-gradient(linear, 0% 0%, 0% 100%, from(###arguments.bg_grade_top#), to(###arguments.bg_grade_bot#));/*Chrome,Safari4+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), -webkit-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*Chrome10+,Safari5.1+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), -o-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*Opera 11.10+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), -ms-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*IE10+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), linear-gradient(to bottom, ###arguments.bg_grade_top# 0%,###arguments.bg_grade_bot# 100%);/*W3C*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: url('#arguments.bg_image#'), filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='###arguments.bg_grade_top#', endColorstr='###arguments.bg_grade_bot#',GradientType=0 );/*IE6-9*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background-repeat:#arguments.bg_image_repeat#;" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background-position:#arguments.bg_image_position#;" addnewline="#arguments.new_line#">
			<cfif len(trim(arguments.bg_image_attach)) gt 0>
				<cffile action="append" file="#arguments.save_file#" output="background-attachment:#arguments.bg_image_attach#;" addnewline="#arguments.new_line#">
			</cfif>
		</cfif>

		<!---background gradient - no image--->
		<cfif len(trim(arguments.bg_image)) eq 0 and len(trim(arguments.bg_grade_top)) gt 0 and len(trim(arguments.bg_grade_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="background: -moz-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*FF3.6+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(###arguments.bg_grade_top#), to(###arguments.bg_grade_bot#));/*Chrome,Safari4+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: -webkit-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*Chrome10+,Safari5.1+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: -o-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*Opera 11.10+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: -ms-linear-gradient(top, ###arguments.bg_grade_top#, ###arguments.bg_grade_bot#);/*IE10+*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: linear-gradient(to bottom, ###arguments.bg_grade_top# 0%,###arguments.bg_grade_bot# 100%);/*W3C*/" addnewline="#arguments.new_line#">
			<cffile action="append" file="#arguments.save_file#" output="background: filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='###arguments.bg_grade_top#', endColorstr='###arguments.bg_grade_bot#',GradientType=0 );/*IE6-9*/" addnewline="#arguments.new_line#">
		</cfif>

		<!---font family--->
		<cfif len(trim(arguments.font_family)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-family:#arguments.font_family#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---font color--->
		<cfif len(trim(arguments.font_color)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="color:###arguments.font_color#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---font size--->
		<cfif len(trim(arguments.font_size)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-size:#arguments.font_size#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---font weight--->
		<cfif len(trim(arguments.font_weight)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-weight:#arguments.font_weight#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---font style--->
		<cfif len(trim(arguments.font_style)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="font-style:#arguments.font_style#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---text decoration--->
		<cfif len(trim(arguments.text_decoration)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="text-decoration:#arguments.text_decoration#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---border top--->
		<cfif len(trim(arguments.border_top)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="border-top:#arguments.border_top#px solid ###arguments.border_color#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---border bottom--->
		<cfif len(trim(arguments.border_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="border-bottom:#arguments.border_bot#px solid ###arguments.border_color#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---border left--->
		<cfif len(trim(arguments.border_left)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="border-left:#arguments.border_left#px solid ###arguments.border_color#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---border right--->
		<cfif len(trim(arguments.border_right)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="border-right:#arguments.border_right#px solid ###arguments.border_color#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---margin top--->
		<cfif len(trim(arguments.margin_top)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-top:#arguments.margin_top#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---margin bottom--->
		<cfif len(trim(arguments.margin_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-bottom:#arguments.margin_bot#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---margin left--->
		<cfif len(trim(arguments.margin_left)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-left:#arguments.margin_left#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---margin right--->
		<cfif len(trim(arguments.margin_right)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="margin-right:#arguments.margin_right#;" addnewline="#arguments.new_line#">
		</cfif>

		<!---padding top--->
		<cfif len(trim(arguments.padding_top)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-top:#arguments.padding_top#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---padding bottom--->
		<cfif len(trim(arguments.padding_bot)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-bottom:#arguments.padding_bot#px;" addnewline="#arguments.new_line#">
		</cfif>

		<!---padding left--->
		<cfif len(trim(arguments.padding_left)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-left:#arguments.padding_left#px;" addnewline="#arguments.new_line#">
		</cfif>
		
		<!---padding right--->
		<cfif len(trim(arguments.padding_right)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="padding-right:#arguments.padding_right#px;" addnewline="#arguments.new_line#">
		</cfif>
		<!---width--->
		<cfif len(trim(arguments.width)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="width:#arguments.width#%;" addnewline="#arguments.new_line#">
		</cfif>
		<!--- text_align --->
		<cfif len(trim(arguments.text_align)) gt 0>
			<cffile action="append" file="#arguments.save_file#" output="text-align:#arguments.text_align#;" addnewline="#arguments.new_line#">
		</cfif>
		
		<cffile action="append" file="#arguments.save_file#" output="}" addnewline="yes">
	</cffunction>

</cfcomponent>