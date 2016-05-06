<cfcomponent>

	<cffunction name="modern_index" description="modern car index for Variable Showroom Page 4" output="Yes" access="public">

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
					<cfif #url.dealer_id# eq 84 >
					<a class="chrome-brand-model" href="../../showroom/#Get_Models.Vehicle_Make#/#lcase(variables.file_name)#?chrome_model_id=#Get_Models.Chrome_Model_ID#" title="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#">
					<cfelse>	
					<a class="chrome-brand-model" href="../showroom/#Get_Models.Vehicle_Make#/#lcase(variables.file_name)#?chrome_model_id=#Get_Models.Chrome_Model_ID#" title="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#">
					</cfif>
						<span class="chrome-gallery-title">#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#</span><br/>
						<img alt="#Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#"  class="img-responsive" alt="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#Get_Models.Chrome_Model_ID#/tn/#Get_Models.Image#"/><br/><br/>
					</a>
				</div>
				<cfif Get_Models.currentrow mod 4 eq 0>
					</div><div class="row">
				</cfif>
			</cfloop>
		</div>		<!---<div class="row">
			<div class="col-md-12 chrome-divider">
				<a href="http://www.chromedata.com" target="_blank"><img class="pull-right" alt="showroom data provided by Chrome" src="http://#cgi.server_name#/images/logos/logo_chromedata.png" border="0"/></a>
				<div class="clearfix"></div>
			</div>
		</div>--->
	
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
								<img  alt="#Get_Models.Vehicle_Year# #Get_Models.Vehicle_Make# #Get_Models.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#Get_Models.Chrome_Model_ID#/tn/#Get_Models.Image#"/><br/><br/>
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
			</div>
			<div class="col-md-8" align="center">
				<cfif len(trim(Get_Photo.Image)) neq 0><img class="img-responsive" alt="#Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#" src="http://showroom.worlddealer.net/autobrief/#url.Chrome_Model_ID#/#Get_Photo.Image#"/></cfif>
				<cfif len(trim(Get_Photo.Caption)) gt 0><br/>#Get_Photo.Caption#</cfif>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Overview of the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Overview</h2>
				<h3 class="chrome-data">#Get_Model_Details.Model_Overview#</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Model Strengths for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Strengths</h2>
				<h3 class="chrome-data">#Get_Model_Details.Model_Strengths#</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Model Changes for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Changes</h2>
				<h3 class="chrome-data">#Get_Model_Details.Model_Changes#</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2 class="chrome-divider" title="Model Value for the #Get_Model_Details.Vehicle_Year# #Get_Model_Details.Vehicle_Make# #Get_Model_Details.Vehicle_Model#">Model Value</h2>
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

</cfcomponent>
