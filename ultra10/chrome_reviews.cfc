<cfcomponent>

	<cffunction name="modern_index" description="modern car index" output="Yes" access="public">

		<cfquery datasource="Ultra8" name="Get_Models">
			SELECT		Chrome_Reviews.Vehicle_Year,
						Chrome_Reviews.Vehicle_Make,
						Chrome_Reviews.Vehicle_Model,
						Chrome_Reviews_Gallery.Image, 
		                Chrome_Reviews_Gallery.Caption,
						Chrome_Reviews_Gallery.Hierarchy,
						Chrome_Reviews.Chrome_Model_ID
			FROM		Chrome_Reviews
			INNER JOIN	Chrome_Reviews_Gallery
			ON 			Chrome_Reviews.Chrome_Model_ID=Chrome_Reviews_Gallery.Chrome_Model_ID
			WHERE		Chrome_Reviews.Vehicle_Make=<cfqueryparam value="#url.v_make#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			AND			Chrome_Reviews.Showroom_Active=1
			AND			Chrome_Reviews_Gallery.Hierarchy=1
			ORDER BY	Chrome_Reviews.Vehicle_Model, Chrome_Reviews.Vehicle_Year
		</cfquery>

		<cfset url.year=Get_Models.Vehicle_Year>
		<cfset url.make=Get_Models.Vehicle_Make>
		<cfset url.model=Get_Models.Vehicle_Model>
		<cfset url.new_used="N">
	
		<div class="row">
			<cfloop query="Get_Models">
				<cfset variables.file_name="#Get_Models.Vehicle_Make#_#Get_Models.Vehicle_Model#_#Get_Models.Vehicle_Year#.cfm">
				<cfset variables.file_name=replace(variables.file_name," ","_","All")>
				<cfset Get_Models.Vehicle_Model=replace(Get_Models.Vehicle_Model,"Cpe","Coupe","All")>
				<cfset Get_Models.Vehicle_Model=replace(Get_Models.Vehicle_Model,"Sdn","Sedan","All")>
				<div class="col-md-3" align="center">
					<a class="chrome-brand-model" href="#lcase(variables.file_name)#?chrome_model_id=#Get_Models.Chrome_Model_ID#" title="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#">
						<span class="chrome-gallery-title">#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#</span><br/>
						<img class="img-responsive" alt="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#Get_Models.Chrome_Model_ID#/tn/#Get_Models.Image#"/><br/><br/>
					</a>
				</div>
				<cfif Get_Models.currentrow mod 4 eq 0>
					</div><div class="row">
				</cfif>
			</cfloop>
		</div>
		<cfquery name="chk_for_text" datasource="Ultra10">
			SELECT	  id, dealer_id, page_type, title, title_font_family, title_font_size, title_font_color, title_font_weight, title_font_decoration, page_text, page_font_family, 
                      page_font_size, page_font_color, page_font_weight, page_font_decoration, trailer, trailer_font_family, trailer_font_size, trailer_font_color, trailer_font_weight, 
                      trailer_font_decoration, link1, link_target1, link_txt1, link2, link_target2, link_txt2, link3, link_target3, link_txt3, link4, link_target4, link_txt4, link5, link_target5, link_txt5, 
                      link6, link_target6, link_txt6, link_font_color, link_font_family, link_font_size, link_font_weight, link_decoration, active, hierarchy,make
			FROM      Dealer_Showroom_Text
			WHERE	dealer_id	=	#URL.dealer_id#
			AND		make like '#Get_Models.Vehicle_Make#%'
			AND		active = 1
		</cfquery>
		<cfset gt_text=chk_for_text>
		<cfif #chk_for_text.recordcount# NEQ 0 >
		<div class="row">
			<div gt_text="container pad-top-10">
				<cfloop query="gt_text" >
					<cfif #gt_text.title# NEQ "" >
						<cfset f_color = "###gt_text.title_font_color#" >
						<cfset f_size = "#gt_text.title_font_size#" >
						<cfset f_weight = "#gt_text.title_font_weight#" >
						<cfset f_familiy = "#gt_text.title_font_family#" >
						<cfset f_decor = "#gt_text.title_font_decoration#" >
						<div class="row">
							<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
								<span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.title#</span>
							</div>	
						</div>
					</cfif>
					<div class="row">
						<cfset f_color = "###gt_text.page_font_color#" >
						<cfset f_size = "#gt_text.page_font_size#" >
						<cfset f_weight = "#gt_text.page_font_weight#" >
						<cfset f_familiy = "#gt_text.page_font_family#" >
						<cfset f_decor = "#gt_text.page_font_decoration#" >
						<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
							<span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.page_text#</span>
						</div>	
					</div>
					<cfif #gt_text.trailer# NEQ "" >
						<cfset f_color = "###gt_text.trailer_font_color#" >
						<cfset f_size = "#gt_text.trailer_font_size#" >
						<cfset f_weight = "#gt_text.trailer_font_weight#" >
						<cfset f_familiy = "#gt_text.trailer_font_family#" >
						<cfset f_decor = "#gt_text.trailer_font_decoration#" >
						<div class="row">
							<div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
								<span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.trailer#</span>
							</div>	
						</div>
					</cfif>
					<cfif #gt_text.link1# NEQ "" >
						<cfset f_color = "###gt_text.link_font_color#" >
						<cfset f_size = "#gt_text.link_font_size#" >
						<cfset f_weight = "#gt_text.link_font_weight#" >
						<cfset f_familiy = "#gt_text.link_font_family#" >
						<cfset f_decor = "#gt_text.link_decoration#" >
						<div class="row">
							<cfif #gt_text.link1# NEQ "" >
								<cfif #gt_text.link_target1# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link1#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link1#"></cfif>
								<div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
									<a href="#destination#" target="#f_target#" ><span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt1#</span></a>
								</div>	
							</cfif>	
							<cfif #gt_text.link2# NEQ "" >
								<cfif #gt_text.link_target2# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link2#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link2#"></cfif>
								<div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
									<a href="#destination#" target="#f_target#" ><span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt2#</span></a>
								</div>	
							</cfif>	
							<cfif #gt_text.link3# NEQ "" >
								<cfif #gt_text.link_target3# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link3#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link3#"></cfif>
								<div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
									<a href="#destination#" target="#f_target#" ><span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt3#</span></a>
								</div>	
							</cfif>	
							<cfif #gt_text.link4# NEQ "" >
								<cfif #gt_text.link_target4# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link4#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link4#"></cfif>
								<div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
									<a href="#destination#" target="#f_target#" ><span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt4#</span></a>
								</div>	
							</cfif>	
							<cfif #gt_text.link5# NEQ "" >
								<cfif #gt_text.link_target5# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link5#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link5#"></cfif>
								<div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
									<a href="#destination#" target="#f_target#" ><span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt5#</span></a>
								</div>	
							</cfif>	
							<cfif #gt_text.link6# NEQ "" >
								<cfif #gt_text.link_target6# EQ 0 ><cfset f_target=""><cfset destination="../#gt_text.link6#"><cfelse><cfset f_target="_blank"><cfset destination="#gt_text.link6#"></cfif>
								<div class="col-md-2 pad-top-10 visible-sm visible-xs visible-lg visible-md" align="left">
									<a href="#destination#" target="#f_target#" ><span style="font-family:#f_familiy#;font-size:#f_size#;color:#f_color#;font-weight:#f_weight#;font-style:#f_decor#">#gt_text.link_txt6#</span></a>
								</div>	
							</cfif>	
						</div>
					</cfif>
					<div class="row">
						<div class="col-md-12 pad-top-10 pad-bottom-10 visible-sm visible-xs visible-lg visible-md">
							<div class="gradient"></div>
						</div>
					</div>	
				</cfloop>
			</div>	
			<div class="clearfix"></div>
			</div>
		</cfif>

	
	</cffunction>

	<cffunction name="legacy_index" description="legacy car index" output="Yes" access="public">

			<cfquery datasource="Ultra8" name="Get_Models">
			SELECT		Chrome_Reviews.Vehicle_Year,
						Chrome_Reviews.Vehicle_Make,
						Chrome_Reviews.Vehicle_Model,
						Chrome_Reviews_Gallery.Image, 
		                Chrome_Reviews_Gallery.Caption,
						Chrome_Reviews_Gallery.Hierarchy,
						Chrome_Reviews.Chrome_Model_ID
			FROM		Chrome_Reviews
			INNER JOIN	Chrome_Reviews_Gallery
			ON 			Chrome_Reviews.Chrome_Model_ID=Chrome_Reviews_Gallery.Chrome_Model_ID
			WHERE		Chrome_Reviews.Vehicle_Make=<cfqueryparam value="#url.v_make#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			AND			Chrome_Reviews.Showroom_Active=1
			AND			Chrome_Reviews_Gallery.Hierarchy=1
			ORDER BY	Chrome_Reviews.Vehicle_Model, Chrome_Reviews.Vehicle_Year
		</cfquery>

		<cfset url.year=Get_Models.Vehicle_Year>
		<cfset url.make=Get_Models.Vehicle_Make>
		<cfset url.model=Get_Models.Vehicle_Model>
		<cfset url.new_used="N">

		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<cfloop query="Get_Models">
					<td>
						<cfset variables.file_name="#Get_Models.Vehicle_Make#_#Get_Models.Vehicle_Model#_#Get_Models.Vehicle_Year#.cfm">
						<cfset variables.file_name=replace(variables.file_name," ","_","All")>
						<cfset Get_Models.Vehicle_Model=replace(Get_Models.Vehicle_Model,"Cpe","Coupe","All")>
						<cfset Get_Models.Vehicle_Model=replace(Get_Models.Vehicle_Model,"Sdn","Sedan","All")>
						<div class="col-md-3" align="center">
							<a class="chrome-brand-model" href="#lcase(variables.file_name)#?chrome_model_id=#Get_Models.Chrome_Model_ID#" title="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#">
								<span class="chrome-gallery-title">#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#</span><br/>
								<img border="0" alt="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#Get_Models.Chrome_Model_ID#/tn/#Get_Models.Image#"/><br/><br/>
							</a>
						</div>
					</td>
					<cfif Get_Models.currentrow mod 4 eq 0>
						</tr><tr>
					</cfif>
				</cfloop>
			</tr>
			<!---<tr>
				<td colspan="4" align="right">
					<a href="http://www.chromedata.com" target="_blank"><img class="pull-right" alt="showroom data provided by Chrome" src="http://#cgi.server_name#/images/logos/logo_chromedata.png" border="0"/></a><br/><br/>
				</td>
			</tr>--->
		</table>
	
	</cffunction>

	<cffunction name="modern_review" description="modern car index" output="Yes" access="public">
		
		<cfparam name="#url.chrome_model_id#" default="0">

		<cfquery datasource="Ultra8" name="Get_Model_Details">
			SELECT		Vehicle_Year,
						Vehicle_Make,
						Vehicle_Model,
						Chrome_Model_ID,
						Model_Overview,
						Model_Changes,
						Model_Strengths,
						Model_Value
			FROM		Chrome_Reviews
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
		</cfquery>
		<cfquery datasource="Ultra8" name="Get_Photo">
			SELECT		Image,
						Caption,
						Hierarchy
			FROM		Chrome_Reviews_Gallery
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			AND			Hierarchy=<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
		<cfquery datasource="Ultra8" name="Get_Notes">
			SELECT		Notes
			FROM        Chrome_Reviews_Notes
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			ORDER BY	Hierarchy
		</cfquery>

		<cfset url.year=Get_Model_Details.Vehicle_Year>
		<cfset url.make=Get_Model_Details.Vehicle_Make>
		<cfset url.model=Get_Model_Details.Vehicle_Model>
		<cfset url.new_used="N">

		<cfset Get_Model_Details.Vehicle_Model=replace(Get_Model_Details.Vehicle_Model,"Cpe","Coupe","All")>
		<cfset Get_Model_Details.Vehicle_Model=replace(Get_Model_Details.Vehicle_Model,"Sdn","Sedan","All")>
		
		<cfif Get_Model_Details.Vehicle_Model contains "Series">
			<cfset variables.My_Model=Get_Model_Details.Vehicle_Model>
		<cfelse>
			<cfset variables.My_Model=replace(Get_Model_Details.Vehicle_Model," ","","All")>
		</cfif>
		<cfif Get_Model_Details.Vehicle_Model eq "Genesis_Coupe">
			<cfset variables.My_Model=replace(variables.My_Model,"Coupe","","All")>
		<cfelse>
			<cfset variables.My_Model=Get_Model_Details.Vehicle_Model>
		</cfif>
		
		<cfif right(cgi.script_name,10) eq "review.cfm">
			<div class="row">
				<div class="col-md-12">
					<h1 class="site-h1" title="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#</h1>
				</div>
			</div>
		</cfif>
		<div class="row">
			<div class="col-md-4">
				<cfif #url.dealer_id# eq 343 >
				<div class="side-title" title="Request More Info" ><span style="color:##ffffff!important">Request More Info</span></div>
				<cfelse>
				<div class="side-title" title="Request More Info">Request More Info</div>
				</cfif>
				<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_chrome">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="voi_new_used" value="N"/>
					<cfinvokeargument name="voi_year" value="#Get_Model_Details.Vehicle_Year#"/>
					<cfinvokeargument name="voi_make" value="#Get_Model_Details.Vehicle_Make#"/>
					<cfinvokeargument name="voi_model" value="#Get_Model_Details.Vehicle_Model#"/>
					<cfinvokeargument name="title_class" value="side-title"/>
					<cfinvokeargument name="input_class" value="side-input"/>
					<cfinvokeargument name="button_class" value="button-input"/>
					<cfinvokeargument name="button_label" value="Request Info"/>
					<cfinvokeargument name="form_action" value="http://#cgi.server_name#/showroom/form_action.cfm"/>
				</cfinvoke>
			</div>
			<div class="col-md-8" align="center">
				<cfif len(trim(Get_Photo.Image)) neq 0><img class="img-responsive" alt="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#url.Chrome_Model_ID#/#Get_Photo.Image#"/></cfif>
				<cfif len(trim(Get_Photo.Caption)) gt 0><br/>#Get_Photo.Caption#</cfif>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Overview of the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Overview</h2>
				
				<cfset Get_Model_Details.Model_Overview=#replacenocase(Get_Model_Details.Model_Overview,"SKYACTIV ","SKYACTIV<sup>&reg;</sup> ","All")#> 
				<cfset Get_Model_Details.Model_Overview=#replacenocase(Get_Model_Details.Model_Overview,"SKYACTIV-","SKYACTIV<sup>&reg;</sup>-","All")#> 
				<h3 class="chrome-data">#Get_Model_Details.Model_Overview#</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Model Strengths for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Strengths</h2>
				<cfset Get_Model_Details.Model_Strengths=#replacenocase(Get_Model_Details.Model_Strengths,"SKYACTIV ","SKYACTIV<sup>&reg;</sup> ","All")#> 
				<cfset Get_Model_Details.Model_Strengths=#replacenocase(Get_Model_Details.Model_Strengths,"SKYACTIV-","SKYACTIV<sup>&reg;</sup>-","All")#> 
				<h3 class="chrome-data">#Get_Model_Details.Model_Strengths#</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Model Changes for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Changes</h2>
				<cfset Get_Model_Details.Model_Changes=#replacenocase(Get_Model_Details.Model_Changes,"SKYACTIV ","SKYACTIV<sup>&reg;</sup> ","All")#> 
				<cfset Get_Model_Details.Model_Changes=#replacenocase(Get_Model_Details.Model_Changes,"SKYACTIV-","SKYACTIV<sup>&reg;</sup>-","All")#> 
				<h3 class="chrome-data">#Get_Model_Details.Model_Changes#</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Model Value for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Value</h2>
				<cfset Get_Model_Details.Model_Value=#replacenocase(Get_Model_Details.Model_Value,"SKYACTIV ","SKYACTIV<sup>&reg;</sup> ","All")#> 
				<cfset Get_Model_Details.Model_Value=#replacenocase(Get_Model_Details.Model_Value,"SKYACTIV-","SKYACTIV<sup>&reg;</sup>-","All")#> 
				<h3 class="chrome-data">#Get_Model_Details.Model_Value#</h3>
			</div>
		</div>
		<!---<div class="row">
			<div class="col-md-12 chrome-divider">
				<a href="http://www.chromedata.com" target="_blank"><img class="pull-right" alt="showroom data provided by Chrome" src="http://#cgi.server_name#/images/logos/logo_chromedata.png" border="0"/></a>
				<div class="clearfix"></div>
			</div>
		</div>--->
	</cffunction>

	<cffunction name="legacy_review" description="legacy car index" output="Yes" access="public">

		<cfparam name="#url.chrome_model_id#" default="0">

		<cfquery datasource="Ultra8" name="Get_Model_Details">
			SELECT		Vehicle_Year,
						Vehicle_Make,
						Vehicle_Model,
						Chrome_Model_ID,
						Model_Overview,
						Model_Changes,
						Model_Strengths,
						Model_Value
			FROM		Chrome_Reviews
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
		</cfquery>
		<cfquery datasource="Ultra8" name="Get_Photo">
			SELECT		Image,
						Caption,
						Hierarchy
			FROM		Chrome_Reviews_Gallery
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			AND			Hierarchy=<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
		<cfquery datasource="Ultra8" name="Get_Notes">
			SELECT		Notes
			FROM        Chrome_Reviews_Notes
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			ORDER BY	Hierarchy
		</cfquery>

		<cfset url.year=Get_Model_Details.Vehicle_Year>
		<cfset url.make=Get_Model_Details.Vehicle_Make>
		<cfset url.model=Get_Model_Details.Vehicle_Model>
		<cfset url.new_used="N">

		<cfset Get_Model_Details.Vehicle_Model=replace(Get_Model_Details.Vehicle_Model,"Cpe","Coupe","All")>
		<cfset Get_Model_Details.Vehicle_Model=replace(Get_Model_Details.Vehicle_Model,"Sdn","Sedan","All")>
		
		<cfif Get_Model_Details.Vehicle_Model contains "Series">
			<cfset variables.My_Model=Get_Model_Details.Vehicle_Model>
		<cfelse>
			<cfset variables.My_Model=replace(Get_Model_Details.Vehicle_Model," ","","All")>
		</cfif>
		<cfif Get_Model_Details.Vehicle_Model eq "Genesis_Coupe">
			<cfset variables.My_Model=replace(variables.My_Model,"Coupe","","All")>
		<cfelse>
			<cfset variables.My_Model=Get_Model_Details.Vehicle_Model>
		</cfif>
	
		<table width="100%" cellpadding="0" cellspacing="0">
			<cfif right(cgi.script_name,10) eq "review.cfm">
				<tr>
					<td colspan="2">
						<h1 class="site-h1" title="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#</h1>
					</td>
				</tr>
			</cfif>
			<tr>
				<td valign="top" style="width:50%">
					<div class="side-title" title="Request More Info">Request More Info</div>
					<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_chrome">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="voi_new_used" value="N"/>
						<cfinvokeargument name="voi_year" value="#Get_Model_Details.Vehicle_Year#"/>
						<cfinvokeargument name="voi_make" value="#Get_Model_Details.Vehicle_Make#"/>
						<cfinvokeargument name="voi_model" value="#Get_Model_Details.Vehicle_Model#"/>
						<cfinvokeargument name="title_class" value="side-title"/>
						<cfinvokeargument name="input_class" value="side-input"/>
						<cfinvokeargument name="button_class" value="button-input"/>
						<cfinvokeargument name="button_label" value="Request Info"/>
						<cfinvokeargument name="form_action" value="http://#cgi.server_name#/showroom/form_action.cfm"/>
					</cfinvoke>					
				</td>
				<td valign="top" style="width:50%;" align="center">
					<cfif len(trim(Get_Photo.Image)) neq 0><img class="img-responsive" alt="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#url.Chrome_Model_ID#/#Get_Photo.Image#"/></cfif>
					<cfif len(trim(Get_Photo.Caption)) gt 0><br/>#Get_Photo.Caption#</cfif>					
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<h2 class="chrome-divider" title="Overview of the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Overview</h2>
					<h3 class="chrome-data">#Get_Model_Details.Model_Overview#</h3>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<h2 class="chrome-divider" title="Model Strengths for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Strengths</h2>
					<h3 class="chrome-data">#Get_Model_Details.Model_Strengths#</h3>					
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<h2 class="chrome-divider" title="Model Changes for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Changes</h2>
					<h3 class="chrome-data">#Get_Model_Details.Model_Changes#</h3>					
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<h2 class="chrome-divider" title="Model Value for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Value</h2>
					<h3 class="chrome-data">#Get_Model_Details.Model_Value#</h3>					
				</td>
			</tr>
			<!---<tr>
				<td colspan="2" align="right">
					<a href="http://www.chromedata.com" target="_blank"><img class="pull-right" alt="showroom data provided by Chrome" src="http://#cgi.server_name#/images/logos/logo_chromedata.png" border="0"/></a><br/><br/>
				</td>
			</tr>--->
		</table>
	</cffunction>


	<cffunction name="model_review" description="modern car index" output="Yes" access="public">
	<cfoutput>
		<cfparam name="url.chrome_model_id" default="0">
		
		<cfquery datasource="Ultra10" name="Get_Dealer_Dir">
			SELECT     	Dealer_Directory,display_name, city,state, proximity,dsp_name_in_title,	Dealercode
			FROM		Dealers
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
		</cfquery>
		
		<cfset url.dealer_directory = "#Get_Dealer_Dir.Dealer_Directory#" >
		<cfset url.dealer_city = "#Get_Dealer_Dir.city#" >
		<cfset url.dealer_state = "#Get_Dealer_Dir.state#" >
		<cfset url.proximity = "#Get_Dealer_Dir.proximity#" >
		<cfset dsp_name_in_title = #Get_Dealer_Dir.dsp_name_in_title# >
		<cfset name_in_title = "#Get_Dealer_Dir.display_name#" >

<cfif IsDefined("url.adhoc") >
 				
	<!--- Check for REPLACEMENT IMAGE --->	
		<cfquery datasource="Ultra10" name="Get_D_Page">
			SELECT	Dealer_Page_ID, Dealer_ID, directory, page_name, script_name, meta_title, meta_description, meta_keywords, page_title, page_banner, page_content, 
                    page_footer, legacy_meta, legacy_page_text, scripts_head, scripts_above_body, scripts_body_top, scripts_body_bottom, scripts_after_body, display_type, iframe, 
                    iframe_width, iframe_height, iframe_scroll, Start_Date, End_Date, Dealer_Wordpress_ID, Chrome_Model_ID, save_as_source, save_as_source_banner, 
                    save_as_source_footer, save_as_source_legacy, incl_position_1, incl_dept_1, incl_position_2, incl_dept_2, pg_type, showroom_inc, showroom_make, 
                    replacement_img, adhoc, adhoc_year, adhoc_make, adhoc_model
			FROM	Dealer_Pages
			WHERE 	Dealer_Page_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.model_script#" maxlength="6">
		</cfquery>

		
		
		<cfset url.year=Get_D_Page.adhoc_year>
		<cfset url.make=Get_D_Page.adhoc_make>
		<cfset url.model=Get_D_Page.adhoc_model>
		<cfset url.new_used="N">

		 
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-4">
				<div class="side-title side-title-model" title="Request More Info">Request More Info</div>
				<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_chrome">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="voi_new_used" value="N"/>
					<cfinvokeargument name="voi_year" value="#Get_D_Page.adhoc_year#"/>
					<cfinvokeargument name="voi_make" value="#Get_D_Page.adhoc_make#"/>
					<cfinvokeargument name="voi_model" value="#Get_D_Page.adhoc_model#"/>
					<cfinvokeargument name="title_class" value="side-title"/>
					<cfinvokeargument name="input_class" value="side-input"/>
					<cfinvokeargument name="button_class" value="button-input"/>
					<cfinvokeargument name="button_label" value="Request Info"/>
					<cfinvokeargument name="form_action" value="http://#cgi.server_name#/showroom/form_action.cfm"/>
				</cfinvoke>
			</div>
			<div class="col-md-8" align="center">
		
				<cfif #Get_D_Page.recordcount# NEQ 0 >
					<img class="img-responsive" alt="#Get_D_Page.adhoc_year# #Get_D_Page.adhoc_make# #Get_D_Page.adhoc_model#" src="http://dealers.wdautos.com/dealer/#url.dealer_directory#/images/library/#Get_D_Page.replacement_img#"/>
				<cfelse>
					<!--- <cfif len(trim(Get_Photo.Image)) neq 0><img class="img-responsive" alt="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#url.Chrome_Model_ID#/#Get_Photo.Image#"/></cfif> --->
				</cfif>
				
				 <br/>#Get_D_Page.adhoc_year# #Get_D_Page.adhoc_make# #Get_D_Page.adhoc_model#
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
 	
<cfelse>
		
		
		
	<!--- Check for REPLACEMENT IMAGE --->	
		<cfquery datasource="Ultra10" name="Get_D_Page">
			SELECT		Dealer_Page_ID,	Dealer_ID,directory,page_name,meta_description,
						script_name,meta_title,meta_description,meta_keywords,
						page_title,	page_content,  replacement_img,
						showroom_inc,
						showroom_make
			FROM		Dealer_Pages
			WHERE 		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			AND			Chrome_Model_id = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			AND replacement_img is not null
			ORDER BY replacement_img DESC
		</cfquery>

		<cfquery datasource="Ultra8" name="Get_Model_Details">
			SELECT		Vehicle_Year,
						Vehicle_Make,
						Vehicle_Model,
						Chrome_Model_ID,
						Model_Overview,
						Model_Changes,
						Model_Strengths,
						Model_Value
			FROM		Chrome_Reviews
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
		</cfquery>
		<cfquery datasource="Ultra8" name="Get_Photo">
			SELECT		Image,
						Caption,
						Hierarchy
			FROM		Chrome_Reviews_Gallery
			WHERE		Chrome_Model_ID = <cfqueryparam value="#url.Chrome_Model_ID#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
			AND			Hierarchy=<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER" maxlength="10">
		</cfquery>
		
		<cfset url.year=Get_Model_Details.Vehicle_Year>
		<cfset url.make=Get_Model_Details.Vehicle_Make>
		<cfset url.model=Get_Model_Details.Vehicle_Model>
		<cfset url.new_used="N">

		<cfset Get_Model_Details.Vehicle_Model=replace(Get_Model_Details.Vehicle_Model,"Cpe","Coupe","All")>
		<cfset Get_Model_Details.Vehicle_Model=replace(Get_Model_Details.Vehicle_Model,"Sdn","Sedan","All")>
		
		<cfif Get_Model_Details.Vehicle_Model contains "Series">
			<cfset variables.My_Model=Get_Model_Details.Vehicle_Model>
		<cfelse>
			<cfset variables.My_Model=replace(Get_Model_Details.Vehicle_Model," ","","All")>
		</cfif>
		<cfif Get_Model_Details.Vehicle_Model eq "Genesis_Coupe">
			<cfset variables.My_Model=replace(variables.My_Model,"Coupe","","All")>
		<cfelse>
			<cfset variables.My_Model=Get_Model_Details.Vehicle_Model>
		</cfif>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-4">
				<div class="side-title side-title-model" title="Request More Info">Request More Info</div>
				<cfinvoke component="/cfcs/forms/form_quick_quote" method="qq_chrome">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="voi_new_used" value="N"/>
					<cfinvokeargument name="voi_year" value="#Get_Model_Details.Vehicle_Year#"/>
					<cfinvokeargument name="voi_make" value="#Get_Model_Details.Vehicle_Make#"/>
					<cfinvokeargument name="voi_model" value="#Get_Model_Details.Vehicle_Model#"/>
					<cfinvokeargument name="title_class" value="side-title"/>
					<cfinvokeargument name="input_class" value="side-input"/>
					<cfinvokeargument name="button_class" value="button-input"/>
					<cfinvokeargument name="button_label" value="Request Info"/>
					<cfinvokeargument name="form_action" value="http://#cgi.server_name#/showroom/form_action.cfm"/>
				</cfinvoke>
			</div>
			<div class="col-md-8" align="center">
		
				<cfif #Get_D_Page.recordcount# NEQ 0 >
					<img class="img-responsive" alt="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#" src="http://dealers.wdautos.com/dealer/#url.dealer_directory#/images/library/#Get_D_Page.replacement_img#"/>
				<cfelse>
					<cfif len(trim(Get_Photo.Image)) neq 0><img class="img-responsive" alt="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#url.Chrome_Model_ID#/#Get_Photo.Image#"/></cfif>
				</cfif>
				
				<cfif len(trim(Get_Photo.Caption)) gt 0><br/>#Get_Photo.Caption#</cfif>
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>

</cfif>		
	</cfoutput>		
	</cffunction>
	
	
	
	
	
</cfcomponent>