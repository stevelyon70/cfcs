<cfcomponent>
	
	<cffunction name="css_settings" description="shows the settings for current template" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="DSN" required="yes">
		<cfargument name="dealer_id" required="yes">
		<cfargument name="dealer_template_id" required="yes">
		<cfargument name="element_id" required="yes">
		<cfargument name="prefix" required="yes">

		<cfquery datasource="#arguments.DSN#" name="Get_CSS">
			SELECT	Dealer_Template_CSS_ID, Dealer_ID, Dealer_Template_ID, Dealer_Template_Element_ID, Extend, Height, Width, 
					text_align, Bg_Color, Bg_Gradient_Top, Bg_Gradient_Bot,Bg_Gradient_left, Bg_Gradient_right, Bg_Image, Bg_Repeat, Bg_Position, Bg_Attach, 
					Padding_Top, Padding_Bot, Padding_Left, Padding_Right, Margin_Top, Margin_Bot, Margin_Left, Margin_Right, 
					Border_Color, Border_Top, Border_Bot, Border_Left, Border_Right, Border_Spec,Border_Radius,min_height,max_height,
					Font_Family, Font_Color, Font_Bg_Color, Font_Color_Rollover, Font_BG_Rollover, 
       				Font_Size, Font_Weight, Font_Style, Text_Decoration
			FROM	Dealer_Template_CSS
			WHERE	Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND		Dealer_Template_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_template_id#" maxlength="6">
			AND		Dealer_Template_Element_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.element_id#" maxlength="6">
		</cfquery>
		
		<table cellpadding="2" width="100%" cellspacing="3">
			<tr>
				<td align="right" valign="MIDDLE" >
					Background Color:
				</td>
				<td>
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Bg_Color"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Bg_Color#"/>
						<cfinvokeargument name="hide_none" value="1"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					BG-Grade Top:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Bg_Gradient_Top"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Bg_Gradient_Top#"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>								
				<td align="right" valign="MIDDLE" >
					BG-Grade Bottom:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Bg_Gradient_Bot"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Bg_Gradient_Bot#"/>
					</cfinvoke>
				</td>
			</tr>
		<cfif #arguments.element_id# NEQ 1 AND #arguments.element_id# NEQ 2 AND #arguments.element_id# NEQ 3 AND #arguments.element_id# NEQ 4 AND #arguments.element_id# NEQ 5  AND #arguments.element_id# NEQ 11  >
			<tr>								
				<td align="right" valign="MIDDLE" >
					BG-Grade Left:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Bg_Gradient_left"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Bg_Gradient_left#"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>								
				<td align="right" valign="MIDDLE" >
					BG-Grade Right:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Bg_Gradient_right"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Bg_Gradient_right#"/>
					</cfinvoke>
				</td>
			</tr>
		</cfif>	
			<tr>
				<td align="right" valign="MIDDLE" >
					Font Color:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Font_Color"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Font_Color#"/>
						<cfinvokeargument name="hide_none" value="1"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Font Family:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_fonts">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Font_Family"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Font_Family#"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>								
				<td align="right" valign="MIDDLE" >
					Font Size:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Font_Size"/>
						<cfif Get_CSS.recordcount eq 0>
							<cfinvokeargument name="select_value" value="12"/>
						<cfelse>
							<cfinvokeargument name="select_value" value="#Get_CSS.Font_Size#"/>
						</cfif>
						<cfinvokeargument name="loop_end" value="100"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Font Weight:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_weights">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Font_Weight"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Font_Weight#"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Font Style:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_styles">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Font_Style"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Font_Style#"/>
					</cfinvoke>
				</td>
			</tr>
		<cfif #arguments.element_id# NEQ 1 AND #arguments.element_id# NEQ 2 AND #arguments.element_id# NEQ 3 AND #arguments.element_id# NEQ 4 AND #arguments.element_id# NEQ 5  AND #arguments.element_id# NEQ 11   AND #arguments.element_id# NEQ 12  >
			<tr>
				<td align="right" valign="MIDDLE" >
					Border Color:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_colors">
						<cfinvokeargument name="dsn" value="#arguments.DSN#"/>
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Border_Color"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.border_Color#"/>
						<cfinvokeargument name="hide_none" value="1"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Border Radius:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Border_radius"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Border_radius#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="10"/>
					</cfinvoke>
				</td>
			</tr>
			</cfif>
			<cfif #arguments.element_id# NEQ 1 AND #arguments.element_id# NEQ 2  AND #arguments.element_id# NEQ 4 AND #arguments.element_id# NEQ 5  AND #arguments.element_id# NEQ 12 >
			<tr>
				<td align="right" valign="MIDDLE" >
					Minimum Height:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_min_height"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.min_height#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="100"/>
						<cfinvokeargument name="hide_none" value="1"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Maximum Height:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_max_height"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.max_height#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="100"/>
						<cfinvokeargument name="hide_none" value="1"/>
					</cfinvoke>
				</td>
			</tr>
			</cfif>
			<tr>
				<td align="right" valign="MIDDLE" >
					Padding Top:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Padding_Top"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Padding_Top#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Padding Bottom:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Padding_Bot"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Padding_Bot#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Padding Left:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Padding_Left"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Padding_Left#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Padding Right:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Padding_Right"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Padding_Right#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<cfif #arguments.element_id# NEQ 1 AND #arguments.element_id# NEQ 2  AND #arguments.element_id# NEQ 4 AND #arguments.element_id# NEQ 5  AND #arguments.element_id# NEQ 11  AND #arguments.element_id# NEQ 12 >
			<tr>
				<td align="right" valign="MIDDLE" >
					Margin Top:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Margin_Top"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Margin_Top#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Margin Bottom:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Margin_Bot"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Margin_Bot#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Margin Left:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Margin_Left"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Margin_Left#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Margin Right:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_numbers">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_Margin_Right"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.Margin_Right#"/>
						<cfinvokeargument name="loop_start" value="0"/>
						<cfinvokeargument name="loop_end" value="20"/>
					</cfinvoke>
				</td>
			</tr>
			</cfif>
			<cfif #arguments.element_id# NEQ 1 AND #arguments.element_id# NEQ 2  AND #arguments.element_id# NEQ 4 AND #arguments.element_id# NEQ 5  AND #arguments.element_id# NEQ 11  AND #arguments.element_id# NEQ 12 >
			<tr>
				<td align="right" valign="MIDDLE" >
					Width:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_percent">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_width"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.width#"/>
					</cfinvoke>
				</td>
			</tr>
			<tr>
				<td align="right" valign="MIDDLE" >
					Text Alignment:
				</td>
				<td align="left">
					<cfinvoke component="/cfcs/admin/css_picker" method="get_alignment">
						<cfinvokeargument name="select_name" value="#arguments.prefix#_text_align"/>
						<cfinvokeargument name="select_value" value="#Get_CSS.text_align#"/>
					</cfinvoke>
				</td>
			</tr>
		</cfif>	
		</table>
		  

	</cffunction>

</cfcomponent>