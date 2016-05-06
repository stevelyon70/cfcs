
<cfcomponent>
	
	<cffunction name="query_var" description="shows maps for page 4 of variable 1028 sorts alpha bby dealer name" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">
		<cfargument name="pass_make" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<!--- Get OEM ID --->
			<cfquery datasource="Ultra10" name="get_oem">
				SELECT    OEM_ID, OEM_Name, Active, Logo, description
				FROM      OEMs
				WHERE OEM_Name = '#pass_make#'
			</cfquery>
			
		<!--- Get dealer from join table --->
			<cfquery datasource="Ultra10" name="get_dlr_shares">
				SELECT 	Share_ID 
				FROM 	Dealer_Shares 
				WHERE 	dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4">
				AND		new_used = 'N'
				AND		Share_ID IN 
				(	SELECT 	Dealer_ID 
					FROM 	ultra10.dbo.Join_Dealer_OEM 
					WHERE 	OEM_ID = #get_oem.OEM_ID#)
			</cfquery>
		
			<cfset nbr_maps = #get_dlr_shares.recordcount# >
			
		<cfset dsp_cnt = 0 >
		
		<cfloop query="get_dlr_shares" >
		
			<cfquery name="chk_specific_map" datasource="Ultra10">
				SELECT   Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
	                     Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
    	                  Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
        	              Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
				FROM    Navigation
				WHERE	Dealer_ID	=	#get_dlr_shares.Share_ID#
				AND		nav_type_id = 68
			</cfquery>	
			
			<cfset use_image = "" >
			<cfif #chk_specific_map.recordcount# NEQ 0 >
				<cfset Get_Nav=chk_specific_map>
				<cfset arguments.nav_type_id = 68 >
			<cfelse>
				<cfquery name="chk_4_map" datasource="Ultra10">
					SELECT   Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
		                     Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
	    	                  Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
	        	              Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
					FROM    Navigation
					WHERE	Dealer_ID	=	#get_dlr_shares.Share_ID#
					AND		nav_type_id = 38
				</cfquery>	
				<cfset Get_Nav=chk_4_map>
			
			</cfif>
			
			<cfquery name="dealer_detail" datasource="Ultra10"> 
				SELECT	  a.Dealer_ID, a.Dealercode, a.Dealer_Name, a.Display_Name, a.Address_1, a.Address_2, a.City, a.State, a.Zip, a.Primary_URL, a.Primary_Phone,
						  b.Area_Code, b.Prefix, b.Line_Number 
				FROM   Dealers a, Dealer_Phones b
				WHERE	a.Dealer_ID	=	#get_dlr_shares.Share_ID#
				AND		b.Phone_ID = a.Primary_Phone
			</cfquery>	
								
		
			<cfloop query="Get_Nav">

			<cfset dsp_cnt = #dsp_cnt#+1 >
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id  AND get_nav.dealer_id eq #get_dlr_shares.Share_ID# >
		
				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
					<cfset variables.element_class="#arguments.element_class#-bold">
				<cfelse>
					<cfset variables.element_class="#arguments.element_class#">
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;border:1px solid ##A3A3A3">
				</cfif>
				<cfif len(trim(Get_Nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif Get_Nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset Get_Nav.pull="">
				</cfif>
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
						<cfif len(trim(arguments.colspan)) eq 0>
							<cfset arguments.colspan=4>
						</cfif>
						
						<cfset offset_cols_2 = "" >
						<cfset offset_cols = "" >
						<cfif #nbr_maps# eq 1 >
							<cfset offset_cols = "col-md-offset-4" >
						</cfif>
						<cfif #nbr_maps# eq 2 and #dsp_cnt# eq 2 >
							<cfset offset_cols = "" >	
							<cfset offset_cols_2 = "col-md-offset-4" >
						</cfif>
						
						<cfif len(trim(Get_Nav.Snippet)) gt 0>
							<div class="col-md-#arguments.colspan# #offset_cols# #offset_cols_2#" style="align:left">
								<div class="row">
									<cfif #dealer_detail.Primary_URL# NEQ "" >
										<div title="#dealer_detail.Display_Name#" class="pg4-title-txt" style="margin-left:12px"><a href="http://www.#dealer_detail.Primary_URL#" target="_blank"><span style="color:##000000">#dealer_detail.Display_Name#</span></a></div>
									<cfelse>
										<div title="#dealer_detail.Display_Name#" class="pg4-title-txt" style="margin-left:12px">#dealer_detail.Display_Name#</div>
									</cfif>	
								</div>
								<div id="nav_#Get_Nav.Nav_ID#" style="display:inline;" class="#arguments.colspan# nav_#Get_Nav.Nav_ID#" style="align:left" title="#dealer_detail.Display_Name#">
									 
										#Get_Nav.Snippet# 
									
								</div>
								<div class="row">
									<div title="#dealer_detail.Address_1#" style="margin-left:10px">#dealer_detail.Address_1#</div>
								</div>
								<div class="row">
									<div  title="#dealer_detail.city#" style="margin-left:10px">#dealer_detail.City#,#dealer_detail.State# #dealer_detail.Zip#</div>
								</div>	
								<div class="row">
									<div title="Phone" style="margin-left:10px">(#dealer_detail.Area_Code#) #dealer_detail.Prefix#-#dealer_detail.Line_Number#</div>
								</div>
								<cfif #dealer_detail.Primary_URL# NEQ "" >
									<div class="row">
										<div  class="pull-left" style="margin-left:10px;margin-right:30px;margin-bottom:20px"> <a href="http://www.#dealer_detail.Primary_URL#"  class="visit-btn" target="_blank">Visit Our Site</a> </div>
									</div>
								</cfif>
							</div>	
						
						</cfif>
			</cfif>
			</cfloop>
			
			</cfloop>
	</cffunction>
	
	<cffunction name="video_var" description="shows video for page 4 of variable 1028" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">
		<cfargument name="pass_make" default="">
		<cfargument name="pass_video" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
		<cfset vid_img_path = "../dealer/#url.assets#/images/icons/" >
		
					<cfset variables.element_class="#arguments.element_class#">
	<cfquery datasource="Ultra10" name="get_video">
		SELECT     ID, dealer_id, Vehicle_Make, Title, text_section, button_text, button_link, Video, Video_Image, Video_position, active
		FROM         Dealer_Internal_Video
		WHERE		ID = #arguments.pass_video#
	</cfquery>
	
	<!--- Need a dealer query to join dealer oems & dealer settings based on passed in make --->
		
			<cfif get_video.recordcount neq 0 >

				<cfset variables.nav_count=variables.nav_count+1>
					
						
							<div class="col-md-12" style="align:center">
								<!--- <div class="#variables.element_class#"> --->
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#"  title="Video" href="##" data-toggle="modal" data-target="##videoModal">
									<img class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#get_video.Video_Image#" />
								</a>
								
								
									<!--- <img alt="#get_video.Vehicle_Make#" class="img-responsive" src="#vid_img_path##get_video.Video_Image#"  > --->
								<!--- </div> --->
							</div>
						
			</cfif>
	</cffunction>
	
	
	<cffunction name="query_var_btns" description="shows oblong buttons for variable 1028" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">

		
		
		<cfquery datasource="ultra10" name="Get_Nav_Var">
		SELECT     Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
                      Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
                      Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
                      Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
		FROM         navigation_var
		WHERE		Dealer_ID = #url.dealer_id#
		AND			Nav_Type_ID = #arguments.Nav_Type_ID#
		<!--- <cfif IsDefined("arguments.pg_nbr")>
			AND	var_page_nbr = #arguments.pg_nbr#
		</cfif> --->
		ORDER BY 	Hierarchy
		</cfquery>
		
		
		
		
		<cfset Get_Nav=Get_Nav_Var>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
		<cfset dsp_cnt=0>
		
		<cfset tot_recs=Get_Nav.recordcount>
	<cfoutput> 	
		
		
		
		
		<cfloop query="Get_Nav">
		<cfset dsp_cnt=#dsp_cnt#+1>
			 
			<cfif Get_Nav.Nav_Type_ID eq #arguments.nav_type_id#  AND get_nav.dealer_id eq #url.dealer_id# >


				<cfset where_to = "" >
				<cfif Get_Nav.Nav_Behaviour_ID eq 1 >
					<cfset where_to = "" >
				</cfif>
				<cfif Get_Nav.Nav_Behaviour_ID eq 2 >
					<cfset where_to = "_blank" >
				</cfif>

		
				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
					<cfset variables.element_class="#arguments.element_class#-bold">
				<cfelse>
					<cfset variables.element_class="#arguments.element_class#">
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;">
				</cfif>
				<cfif len(trim(Get_Nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif Get_Nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset Get_Nav.pull="">
				</cfif>
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
						<cfif len(trim(arguments.colspan)) eq 0>
							<cfset arguments.colspan=4>
						</cfif>
						
						<cfset offset_cols_2 = "" >
						<cfset offset_cols = "" >
						<cfif #tot_recs# eq 1 >
							<cfset offset_cols = "col-md-offset-4" >
						</cfif>
						<cfif  #tot_recs# eq 2 and #dsp_cnt# eq 2 >
							<cfset offset_cols = "" >	
							<cfset offset_cols_2 = "col-md-offset-4" >
						</cfif>
						
						
							<div class="col-md-#arguments.colspan# #offset_cols# #offset_cols_2#" style="align:center">
								<div class="row">
									<div title="#get_nav.Nav_Name#" style="#variables.element_style#">
										<a class="oblong-btn" href="#get_nav.Nav_Link#" target="#where_to#">#get_nav.Nav_Name#</a>
									</div>
								</div>
								
							</div>	
						
						
			</cfif>
			</cfloop>
	</cfoutput>		
	</cffunction>
	
	
	<cffunction name="query_var_location" description="shows maps for page 4 of variable 1028 sorts by state & city" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">
		<cfargument name="pass_make" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<!--- Get OEM ID --->
			<!---<cfquery datasource="Ultra10" name="get_oem">
				SELECT    OEM_ID, OEM_Name, Active, Logo, description
				FROM      OEMs
				WHERE OEM_Name = '#pass_make#'
			</cfquery>--->
			
		<!--- Get dealer from join table --->
			<cfquery datasource="Ultra10" name="get_dlr_shares">
				SELECT 	Dealer_Shares.Share_ID , dealers.city, dealers.state, Navigation.Hierarchy
				FROM 	Dealer_Shares, dealers, Navigation 
				WHERE 	Dealer_Shares.dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4">
				AND		Dealer_Shares.Share_ID = dealers.dealer_id
				AND		Dealer_Shares.Share_ID = Navigation.dealer_id
					AND		nav_type_id = 68
				AND		Dealer_Shares.new_used = 'N'
				AND		Dealer_Shares.Share_ID IN 
				(	SELECT 	Dealer_ID 
					FROM 	ultra10.dbo.Join_Dealer_OEM  , OEMs
					WHERE 	Join_Dealer_OEM.OEM_ID = OEMs.OEM_ID 
                    	and OEMs.OEM_Name = '#pass_make#'
                   <!--- OEM_ID = #get_oem.OEM_ID#--->
                     )
				<cfif #url.dealer_id# eq 311 and ( #pass_make# EQ "Hyundai" or #pass_make# EQ "Ford") >
	                ORDER BY Navigation.Hierarchy
				<cfelse>	
				  ORDER BY 	 dealers.state DESC, dealers.city ASC  
				</cfif>	 
			</cfquery>
		
			<cfset nbr_maps = #get_dlr_shares.recordcount# >
			
		<cfset dsp_cnt = 0 >

		<cfloop query="get_dlr_shares" >
		
			<cfquery name="chk_specific_map" datasource="Ultra10">
				SELECT   Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
	                     Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
    	                  Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
        	              Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
				FROM    Navigation
				WHERE	Dealer_ID	=	#get_dlr_shares.Share_ID#
					AND		nav_type_id = 68
                ORDER BY Hierarchy
			</cfquery>	
			
			<cfif #chk_specific_map.recordcount# NEQ 0 >
				<cfset Get_Nav=chk_specific_map>
				<cfset arguments.nav_type_id = 68 >
			<cfelse>
				<cfquery name="chk_4_map" datasource="Ultra10">
					SELECT   Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
		                     Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
	    	                  Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
	        	              Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
					FROM    Navigation
					WHERE	Dealer_ID	=	#get_dlr_shares.Share_ID#
					AND		nav_type_id = 38
				</cfquery>	
				<cfset Get_Nav=chk_4_map>
			
			</cfif>
			
			<cfquery name="dealer_detail" datasource="Ultra10"> 
				SELECT	  a.Dealer_ID, a.Dealercode, a.Dealer_Name, a.Display_Name, a.Address_1, a.Address_2, a.City, a.State, a.Zip, a.Primary_URL, a.Primary_Phone,
						  b.Area_Code, b.Prefix, b.Line_Number 
				FROM   Dealers a, Dealer_Phones b
				WHERE	a.Dealer_ID	=	#get_dlr_shares.Share_ID#
				AND		b.Phone_ID = a.Primary_Phone
			</cfquery>	
								
			<cfloop query="Get_Nav">

			<cfset dsp_cnt = #dsp_cnt#+1 >
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id  AND get_nav.dealer_id eq #get_dlr_shares.Share_ID# >

		
				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
					<cfset variables.element_class="#arguments.element_class#-bold">
				<cfelse>
					<cfset variables.element_class="#arguments.element_class#">
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;border:1px solid ##A3A3A3">
				</cfif>
				<cfif len(trim(Get_Nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif Get_Nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset Get_Nav.pull="">
				</cfif>
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
						<cfif len(trim(arguments.colspan)) eq 0>
							<cfset arguments.colspan=4>
						</cfif>
						
						<cfset offset_cols_2 = "" >
						<cfset offset_cols = "" >
						<cfif #nbr_maps# eq 1 >
							<cfset offset_cols = "col-md-offset-4" >
						</cfif>
						<!---<cfif #nbr_maps# eq 2 and #dsp_cnt# eq 2 >
							<cfset offset_cols = "" >	
							<cfset offset_cols_2 = "col-md-offset-4" >
						</cfif>--->
						
						<cfif len(trim(Get_Nav.Snippet)) gt 0>
							<div class="col-md-#arguments.colspan# #offset_cols# #offset_cols_2#" style="align:left">
								<div class="row">
									<cfif #dealer_detail.Primary_URL# NEQ "" >
										<div title="#dealer_detail.Display_Name#" class="pg4-title-txt" style="margin-left:12px"><a href="http://www.#dealer_detail.Primary_URL#" target="_blank"><span style="color:##000000">#dealer_detail.Display_Name#</span></a></div>
									<cfelse>
										<div title="#dealer_detail.Display_Name#" class="pg4-title-txt" style="margin-left:12px">#dealer_detail.Display_Name#</div>
									</cfif>	
								</div>
                                
								<div id="nav_#Get_Nav.Nav_ID#" style="display:inline;" class="#arguments.colspan# nav_#Get_Nav.Nav_ID#" style="align:left" title="#dealer_detail.Display_Name#">
									 
										#Get_Nav.Snippet# 
										
								</div>
								<div class="row">
									<div title="#dealer_detail.Address_1#" style="margin-left:10px">#dealer_detail.Address_1#</div>
								</div>
								<div class="row">
									<div  title="#dealer_detail.city#" style="margin-left:10px">#dealer_detail.City#,#dealer_detail.State# #dealer_detail.Zip#</div>
								</div>	
								<div class="row">
									<div title="Phone" style="margin-left:10px">(#dealer_detail.Area_Code#) #dealer_detail.Prefix#-#dealer_detail.Line_Number#</div>
								</div>
								<cfif #dealer_detail.Primary_URL# NEQ "" >
									<div class="row">
										<div  class="pull-left" style="margin-left:10px;margin-right:30px;margin-bottom:20px"> <a href="http://www.#dealer_detail.Primary_URL#"  class="visit-btn" target="_blank">Visit Our Site</a> </div>
									</div>
								</cfif>
							</div>	
						
						</cfif>
			</cfif>
			</cfloop>
			
			</cfloop>
	</cffunction>
	
	
	<cffunction name="qry_var_location_logo" description="shows maps for page 4 of variable 1028 sorts by state & city with LOGO image" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">
		<cfargument name="pass_make" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<!--- Get OEM ID --->
			<cfquery datasource="Ultra10" name="get_oem">
				SELECT    OEM_ID, OEM_Name, Active, Logo, description
				FROM      OEMs
				WHERE OEM_Name = '#pass_make#'
			</cfquery>
			
			<cfset splitter = 0 >
			<cfif #pass_make# eq "Volkswagen" >
				<cfset splitter = 1 >
			</cfif>
			
		<!--- Get dealer from join table --->
			<cfquery datasource="Ultra10" name="get_dlr_shares">
				SELECT 	Dealer_Shares.Share_ID , dealers.city, dealers.state
				FROM 	Dealer_Shares, dealers
				WHERE 	Dealer_Shares.dealer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="4">
				AND		Dealer_Shares.Share_ID = dealers.dealer_id
				AND		Dealer_Shares.new_used = 'N'
				AND		Dealer_Shares.Share_ID IN 
				(	SELECT 	Dealer_ID 
					FROM 	ultra10.dbo.Join_Dealer_OEM 
					WHERE 	OEM_ID = #get_oem.OEM_ID#)
					ORDER BY 	 dealers.state DESC, dealers.city ASC
			</cfquery>
		
			<cfset nbr_maps = #get_dlr_shares.recordcount# >
			
		<cfset dsp_cnt = 0 >
		
		<cfloop query="get_dlr_shares" >
		
			<cfquery name="chk_specific_map" datasource="Ultra10">
				SELECT   Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
	                     Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
    	                  Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
        	              Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
				FROM    Navigation
				WHERE	Dealer_ID	=	#get_dlr_shares.Share_ID#
				AND		nav_type_id = 68
			</cfquery>	
			
			<cfif #chk_specific_map.recordcount# NEQ 0 >
				<cfset Get_Nav=chk_specific_map>
				<cfset arguments.nav_type_id = 68 >
			<cfelse>
				<cfquery name="chk_4_map" datasource="Ultra10">
					SELECT   Nav_ID, Dealer_ID, Nav_Type_ID, Parent_Nav_ID, Nav_Behaviour_ID, Nav_Name, Nav_Alt, Nav_Link, Nav_Mobile_Link, Snippet, Pull, Nav_Image, 
		                     Nav_Rollover, Nav_Image_Code, Phone_ID, Start_Date, End_Date, Align, Text_Color, Font_Family, Font_Weight, Font_Size, Margin_Left, Margin_Right, Margin_Top, 
	    	                  Margin_Bottom, Display_Mode, Hierarchy, Legacy_Nav_Custom_ID, Legacy_Nav_Main_ID, Legacy_Nav_Sub_ID, Width, Height, Robot_Food, Script_Name, 
	        	              Mega_Menu, Mega_Height, Mega_Columns, Mega_Glyph_Image, Mega_Right_Float, Mega_Glyph_Color, old_nav_id, var_page_nbr
					FROM    Navigation
					WHERE	Dealer_ID	=	#get_dlr_shares.Share_ID#
					AND		nav_type_id = 38
				</cfquery>	
				<cfset Get_Nav=chk_4_map>
			
			</cfif>
			
			<cfquery name="dealer_detail" datasource="Ultra10"> 
				SELECT	  a.Dealer_ID, a.Dealercode, a.Dealer_Name, a.Display_Name, a.Address_1, a.Address_2, a.City, a.State, a.Zip, a.Primary_URL, a.Primary_Phone,
						  b.Area_Code, b.Prefix, b.Line_Number 
				FROM   Dealers a, Dealer_Phones b
				WHERE	a.Dealer_ID	=	#get_dlr_shares.Share_ID#
				AND		b.Phone_ID = a.Primary_Phone
			</cfquery>	
			<cfif #get_dlr_shares.Share_ID# EQ 70 ><cfset dealer_detail.Area_Code = "702" ><cfset dealer_detail.Prefix = "566" ><cfset dealer_detail.Line_Number = "2000" ></cfif>				
		
			<cfloop query="Get_Nav">

			<cfset dsp_cnt = #dsp_cnt#+1 >
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id  AND get_nav.dealer_id eq #get_dlr_shares.Share_ID# >
			
			<cfquery name="sub_dealer_detail" datasource="Ultra10"> 
				SELECT	  a.Dealer_ID, a.Dealercode, a.Dealer_Directory
				FROM   Dealers a
				WHERE	a.Dealer_ID	=	#Get_Nav.Dealer_ID#
			</cfquery>	
		
				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
					<cfset variables.element_class="#arguments.element_class#-bold">
				<cfelse>
					<cfset variables.element_class="#arguments.element_class#">
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;border:1px solid ##A3A3A3">
				</cfif>
				<cfif len(trim(Get_Nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif Get_Nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset Get_Nav.pull="">
				</cfif>
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
						<cfif len(trim(arguments.colspan)) eq 0>
							<cfset arguments.colspan=4>
						</cfif>
						
						<cfset offset_cols_2 = "" >
						<cfset offset_cols = "" >
						<cfif #nbr_maps# eq 1 >
							<cfset offset_cols = "col-md-offset-4" >
						</cfif> 
						<cfif #nbr_maps# eq 2 and #dsp_cnt# eq 2 >
							<cfset offset_cols = "" >	
							<cfset offset_cols_2 = "" >
						</cfif>
						<cfif #nbr_maps# eq 3 and #dsp_cnt# eq 3 >
							<cfset offset_cols = "" >	
							<cfset offset_cols_2 = "" >
						</cfif>
						<cfif #nbr_maps# eq 4 and #dsp_cnt# eq 4 >
							<cfset offset_cols = "" >	
							<cfset offset_cols_2 = "" > 
						</cfif>
						
						<cfif len(trim(Get_Nav.Snippet)) gt 0>
							<div class="col-md-#arguments.colspan# #offset_cols# #offset_cols_2# " style="align:left">
								<div class="row row-centered pad-top-10 " style="min-height:140px">
									<cfif #Get_Nav.Nav_Image# NEQ "" >
										<div class="col-centered "  style="#variables.element_style#"><a href="http://www.#dealer_detail.Primary_URL#" target="_blank"><img src="http://#cgi.server_name#/dealer/#sub_dealer_detail.dealer_directory#/images/icons/#Get_Nav.Nav_Image#" border="0" class="img-responsive"> </a></div>
									</cfif>	
								</div>
								<div class="row pad-top-10">
								<div id="nav_#Get_Nav.Nav_ID#" style="display:inline;" class="#arguments.colspan# nav_#Get_Nav.Nav_ID#" style="align:left" title="#dealer_detail.Display_Name#">
									 
										#Get_Nav.Snippet# 
										
								</div>
								</div>
								<div class="row">
									<cfif #dealer_detail.Primary_URL# NEQ "" >
										<div title="#dealer_detail.Display_Name#" class="pg4-title-txt"><a href="http://www.#dealer_detail.Primary_URL#" target="_blank"><span style="color:##000000">#dealer_detail.Display_Name#</span></a></div>
									<cfelse>
										<div title="#dealer_detail.Display_Name#" class="pg4-title-txt" style="margin-left:10px">#dealer_detail.Display_Name#</div>
									</cfif>	
								</div>
								<div class="row">
									<div title="#dealer_detail.Address_1#">#dealer_detail.Address_1#</div>
								</div>
								<div class="row">
									<div  title="#dealer_detail.city#">#dealer_detail.City#,#dealer_detail.State# #dealer_detail.Zip#</div>
								</div>	
								<div class="row">
									<div title="Phone">(#dealer_detail.Area_Code#) #dealer_detail.Prefix#-#dealer_detail.Line_Number#</div>
								</div>
								<cfif #dealer_detail.Primary_URL# NEQ "" >
									<div class="row">
										<div  class="pull-left" style=margin-right:30px;margin-bottom:20px"> <a href="http://www.#dealer_detail.Primary_URL#"  class="visit-btn" target="_blank">Visit Our Site</a> </div>
									</div>
								</cfif>
							</div>	
							<cfif #dsp_cnt# eq 2 and #splitter# EQ 1 >
								<div class="clearfix"></div>
							<cfelseif #dsp_cnt# eq 3 and #splitter# EQ 0 >
								<div class="clearfix"></div>
							<cfelse>	
							</cfif>
						</cfif>
			</cfif>
			</cfloop>
			
			</cfloop>
	</cffunction>
	
	

	
	
</cfcomponent>
