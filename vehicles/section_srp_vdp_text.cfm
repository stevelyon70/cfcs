<cfoutput>
<!--- Page Text --->  
	<cfif NOT IsDefined("n_u_flag") >
		<cfset n_u_flag = "U" >
	</cfif> 
	<cfif NOT IsDefined("pg_nbr") >
		<cfset pg_nbr = 91 >
	</cfif>
	<cfset nbr_col = "2" >
	<cfquery name="gt_text" datasource="Ultra10">
		SELECT	   id, dealer_id, page_type, usage, make, title, page_text 
		FROM         Variable_Template_Dealer_Content
		WHERE	dealer_id = #url.dealer_id#
		AND		page_type = #pg_nbr#
		AND		active = 1
	</cfquery>

	<!---Set Condition in Regular Speak--->
	<cfswitch expression="#n_u_flag#">
		<cfdefaultcase>
			<cfset variables.N_U="Used">
		</cfdefaultcase>
		<cfcase value="N">
			<cfset variables.N_U="New">
		</cfcase>
		<cfcase value="U">
			<cfset variables.N_U="Used">
		</cfcase>
		<cfcase value="C">
			<cfset variables.N_U="Certified">
		</cfcase>
	</cfswitch>
		
<div class="container-fluid">	
	<section class="section-collapsable">
		<cfif #gt_text.recordcount# NEQ 0 >
 			<cfif 	#came_from# EQ 1 >	<!--- Replace ONLY on VDP Page --->
				<cfset gt_text.title = #replace(gt_text.title,"$NU$", "#variables.N_U#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$COLOR$", "#arguments.Exterior_Color#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$MAKE$", "#arguments.V_Make#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$MODEL$", "#arguments.V_Model#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$YEAR$", "#arguments.V_Year#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$WHERE$", "#arguments.Dealer_Display_Name#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$CITY$", "#arguments.Dealer_City#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$STATE$", "#arguments.Dealer_State#", "ALL")# >
				
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$NU$", "#variables.N_U#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$COLOR$", "#arguments.Exterior_Color#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$MAKE$", "#arguments.V_Make#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$MODEL$", "#arguments.V_Model#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$YEAR$", "#arguments.V_Year#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$WHERE$", "#arguments.Dealer_Display_Name#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$CITY$", "#arguments.Dealer_City#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$STATE$", "#arguments.Dealer_State#", "ALL")# >  
			<cfelse>	
				<cfquery datasource="ultra10" name="get_Dname">SELECT Dealer_ID,	Display_Name,City, State  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		
				<cfset gt_text.title = #replace(gt_text.title,"$WHERE$", "#get_Dname.Display_Name#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$CITY$", "#get_Dname.City#", "ALL")# >
				<cfset gt_text.title = #replace(gt_text.title,"$STATE$", "#get_Dname.State#", "ALL")# >
				<cfif IsDefined("url.make") and #url.make# NEQ "" >
					<cfset gt_text.title = #replace(gt_text.title,"$NU$", "for a #UCase(variables.N_U)# ", "ALL")# >
					<cfset gt_text.title = #replace(gt_text.title,"$MAKE$", "#UCase(url.make)#", "ALL")# >
				<cfelse>
					<cfset gt_text.title = #replace(gt_text.title,"$NU$", "", "ALL")# >
					<cfset gt_text.title = #replace(gt_text.title,"$MAKE$", "", "ALL")# >	
				</cfif>
				<cfif IsDefined("url.model") and #url.model# NEQ "" >
					<cfset gt_text.title = #replace(gt_text.title,"$MODEL$", "#UCase(url.model)#", "ALL")# >
				<cfelse>
					<cfset gt_text.title = #replace(gt_text.title,"$MODEL$", "", "ALL")# >	
				</cfif>
				
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$WHERE$", "#get_Dname.Display_Name#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$CITY$", "#get_Dname.City#", "ALL")# >
				<cfset gt_text.page_text = #replace(gt_text.page_text,"$STATE$", "#get_Dname.State#", "ALL")# >  
				<cfif IsDefined("url.make") and #url.make# NEQ "" >
					<cfset gt_text.page_text = #replace(gt_text.page_text,"$MAKE$", "for a #UCase(url.make)#", "ALL")# >
				<cfelse>
					<cfset gt_text.page_text = #replace(gt_text.page_text,"$MAKE$", "", "ALL")# >	
				</cfif>
				<cfif IsDefined("url.model") and #url.model# NEQ "" >
					<cfset gt_text.page_text = #replace(gt_text.page_text,"$MODEL$", "#UCase(url.model)#", "ALL")# >
				<cfelse>
					<cfset gt_text.page_text = #replace(gt_text.page_text,"$MODEL$", "", "ALL")# >	
				</cfif>
			</cfif>
				
			<div class="row-centered">
				<div class="col-centered pad-top-10 visible-sm visible-xs visible-lg visible-md" style="align:left">
					<section class="srp-d-container">
						<div>
							<input id="srp-1" name="accordian-1" type="checkbox"   />
							<label for="srp-1">#gt_text.title#</label>
							<article class="srp-large"><p>#rtrim(gt_text.page_text)#</p></article>
						</div>
					</section>
				</div>
			</div>
		</cfif>  
	</section>
</div>
	
</cfoutput>
