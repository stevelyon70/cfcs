<cfoutput>

<!--- Page Text --->  
	<cfif NOT IsDefined("pg_nbr") >
		<cfset pg_nbr = 0 >
	</cfif>
	<cfset nbr_col = "2" >
	
	<cfquery name="gt_text" datasource="Ultra10">
		SELECT  *
		FROM    Variable_Template_Dealer_Content
		WHERE	dealer_id = #url.dealer_id# AND page_type=#pg_nbr# AND hierarchy=1 AND active=1
	</cfquery>
	
	 <cfquery datasource="ultra10" name="dlr_info">SELECT Address_1,Address_2,City,State,Zip,Service_Phone,Inv_Phone_New FROM Dealers WHERE dealer_id = #url.dealer_id# </cfquery> 
		
	<cfquery datasource="ultra10" name="Get_Phn">
			SELECT Phone_ID,Phone_Label,Area_Code,Prefix,Line_Number FROM Dealer_Phones
			WHERE  Dealer_ID=#url.Dealer_ID# AND ( Phone_ID = #dlr_info.Inv_Phone_New# or Phone_ID = #dlr_info.Service_Phone#  ) ORDER BY 	Hierarchy
	</cfquery>
	
	<cfquery datasource="Ultra10" name="Get_Departments">
		SELECT		Join_Dealer_Dept.Dealer_Dept_ID,
					Departments.Department
		FROM		Join_Dealer_Dept
		INNER JOIN	Departments
		ON			Join_Dealer_Dept.Dept_ID = Departments.Dept_ID
		WHERE		Join_Dealer_Dept.Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.dealer_id#" maxlength="6">
		AND			Join_Dealer_Dept.Dealer_Dept_ID IN (SELECT Dealer_Dept_ID FROM Dealer_Dept_Hours)
		AND	Departments.Dept_ID = 45
		ORDER BY 	Join_Dealer_Dept.Hierarchy
	</cfquery>
		

<div class="container-fluid">
		<section class="section-links">
			<div class="container pad-top-10">
			<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="page-divider"></div></div></div>	
	<!-- mobile -->			
					<div class="row pad-top-10 visible-sm visible-xs">
						<div class="col-md-3 pad-top-10" align="center" >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="7"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
							</cfinvoke>
						</div>
						<div class="col-md-3 pad-top-10" align="center"  >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="8"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</div>
						<div class="col-md-3 pad-top-10"  align="center"  >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="9"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</div>
						 <div class="col-md-3 pad-top-10"  align="center"  >
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="10"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="info-link"/>
								<cfinvokeargument name="bold_top" value="true"/>
								<cfinvokeargument name="site_mode" value="#arguments.site_mode#"/>
							</cfinvoke>
						</div>  
						 <!---  <div class="col-md-3 visible-md visible-lg" align="center" >
							<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="dsn" value="#url.DSN#"/>
								<cfinvokeargument name="title_class" value="ftr-title"/>
								<cfinvokeargument name="input_class" value="ftr-input"/>
								<cfinvokeargument name="button_class" value="ftr-contact-input"/>
								<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
							</cfinvoke>
						</div>   --->
					</div>

	<!-- mobile end -->								
					
					
					<div class="row pad-top-10 visible-md visible-lg visible-sm visible-xs">
						<div class="col-md-7" align="left" >
							<section class="section-collapsable">
										
							  <cfif #gt_text.recordcount# NEQ 0 >
									<div class="row-centered">
										<div class="col-centered pad-top-10 visible-sm visible-xs visible-lg visible-md" style="align:left">
											<section class="ac-container">
												<div>
													<input id="ac-1" name="accordian-1" type="checkbox"   />
													<label for="ac-1">#gt_text.title#</label>
													<article class="ac-large"><p>#rtrim(gt_text.page_text)#</p></article>
												</div>
											</section>
										</div>
									</div>
								</cfif>  
							
							</section>
						</div>
						 <div class="col-md-2"  align="left"  >
							<div class="row">
								<div class="col-md-12 dlr-link-content">
									<cfif len(trim(dlr_info.Address_1)) gt 0><b>#dlr_info.Address_1#</b><br/></cfif>
									<cfif len(trim(dlr_info.Address_2)) gt 0><b>#dlr_info.Address_2#</b><br/></cfif>
									<cfif len(trim(dlr_info.City)) gt 0><b>#dlr_info.City#, #dlr_info.State# #dlr_info.Zip#</b><br/></cfif>
								</div>
							</div>		
							<div class="row">
								<div class="col-md-12">&nbsp;
								</div>
							</div>	
							<div class="row">
								<div class="col-md-12 dlr-link-content">
								<cfloop query="Get_Phn" >
								#Get_Phn.Phone_Label#: (#Get_Phn.Area_Code#) #Get_Phn.Prefix#-#Get_Phn.Line_Number# <br>
								</cfloop>
								</div>
							</div>		
							<div class="row">
								<div class="col-md-12">&nbsp;
								</div>
							</div>	
							<div class="row">
								<cfloop query="Get_Departments">
									<cfquery datasource="Ultra10" name="Get_Hours">SELECT Line_Desc,Line_Value FROM Dealer_Dept_Hours WHERE Dealer_Dept_ID=#Get_Departments.Dealer_Dept_ID# AND active=1 ORDER BY Hierarchy</cfquery>
									<div class="col-md-12 dlr-link-content">
										<cfloop query="Get_Hours">
											<b>#Get_Hours.Line_Desc#:</b> #Get_Hours.Line_Value#<br>
										</cfloop>
										<br/><br/>
									</div>
									<cfif Get_Departments.currentRow mod 3 eq 0>
										</div><div class="row">
									</cfif>
								</cfloop>
							</div>
						</div>  
						 <div class="col-md-2 visible-sm visible-xs visible-md visible-lg" align="left"  >
							<cfinvoke component="/cfcs/forms/form_contact" method="contact_footer">
								<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
								<cfinvokeargument name="dsn" value="#url.DSN#"/>
								<cfinvokeargument name="title_class" value="ftr-title"/>
								<cfinvokeargument name="input_class" value="ftr-input"/>
								<cfinvokeargument name="button_class" value="ftr-contact-input"/>
								<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/contact_action.cfm"/>
							</cfinvoke>
						</div>    
						 <div class="col-md-1 visible-md visible-lg pull-left" align="left"  >&nbsp;</div>
					</div>
					
				
				
			</div>		
			<div class="clearfix"></div>
		</section>
</div>  

</cfoutput>
