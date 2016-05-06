<cfcomponent>

<!--- Data Collection --->
		<cfset variables.dsn = "Ultra10">
		
		<cfset d_dept_name = ArrayNew(1) >
		<cfset d_dept_id = ArrayNew(1) >
		<cfset a_person_id = ArrayNew(2) >
		<cfset a_Dealer_Dept_ID = ArrayNew(2) >
		<cfset a_First_Name = ArrayNew(2) >
		<cfset a_Last_Name = ArrayNew(2) >
		<cfset a_Email = ArrayNew(2) >
		<cfset a_Phone = ArrayNew(2) >
		<cfset a_Cell_Phone = ArrayNew(2) >
		<cfset a_Staff_Image = ArrayNew(2) >
		<cfset a_Staff_Link = ArrayNew(2) >
		<cfset a_Bio = ArrayNew(2) >
		<cfset a_Note = ArrayNew(2) >
		<cfset a_Staff_Position = ArrayNew(2) >
		<cfset a_Team = ArrayNew(2) >
		<cfset a_Last = ArrayNew(1) >
		
		
		<cfquery datasource="#variables.DSN#" name="Get_Assigned_Depts">
			SELECT		Join_Dealer_Dept_Staff.Dealer_Dept_ID,
						Join_Dealer_Dept_Staff.Dept_ID,
						Departments.Department,
						Join_Dealer_Dept_Staff.Hierarchy
			FROM		Join_Dealer_Dept_Staff
			INNER JOIN	Departments
			ON			Join_Dealer_Dept_Staff.Dept_ID = Departments.Dept_ID
			WHERE		Join_Dealer_Dept_Staff.Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			and			Join_Dealer_Dept_Staff.Dept_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.department#" maxlength="6">
			ORDER BY 	Join_Dealer_Dept_Staff.Hierarchy
		</cfquery>
		
		
		<cfset d = 0 >
		<cfloop query="Get_Assigned_Depts">
			<cfquery datasource="#variables.dsn#" name="Get_Staff">
			SELECT  a.Person_ID,a.Dealer_ID,a.Dealer_Dept_ID,a.First_Name,a.Last_Name,a.Email,a.Phone,a.Cell_Phone,a.Staff_Image,a.Staff_Link,a.Bio,a.Note,
			a.Staff_Position,a.Team
			FROM   People a 
			where	a.dealer_id = #url.dealer_id#
			AND		a.Dealer_Dept_ID = #Get_Assigned_Depts.Dealer_Dept_ID#
			ORDER BY a.Dealer_Dept_ID ASC, a.Hierarchy ASC
		</cfquery> 
		
		<cfset x = 0 >
		<cfif #Get_Staff.recordcount# NEQ 0 >
			<cfset d = #d#+1 >
			<cfset d_dept_name[d] = #Get_Assigned_Depts.Department# >
			<cfset d_dept_id[d] = #Get_Assigned_Depts.Dept_ID# >
			<cfloop query="Get_Staff">
				<cfset x = #x#+1 >
				<cfset a_person_id[d][x] = "#Get_Staff.Person_ID#" >
				<cfset a_Dealer_Dept_ID[d][x] = "#Get_Staff.Dealer_Dept_ID#" >
				<cfset a_First_Name[d][x] = "#Get_Staff.First_Name#" >
				<cfset a_Last_Name[d][x] = "#Get_Staff.Last_Name#" >
				<cfset a_Email[d][x] = "#Get_Staff.Email#" >
				<cfset a_Phone[d][x] ="#Get_Staff.Phone#" >
				<cfset a_Cell_Phone[d][x] = "#Get_Staff.Cell_Phone#" >
				<cfif #Get_Staff.Staff_Image# NEQ "" >
					<cfset a_Staff_Image[d][x] = "#Get_Staff.Staff_Image#" >
				<cfelse>		
					<cfset a_Staff_Image[d][x] = "staff.jpg" >
				</cfif>
				<cfset a_Staff_Link[d][x] = "#Get_Staff.Staff_Link#" >
				<cfset a_Bio[d][x] = "#Get_Staff.Bio#" >
				<cfset a_Note[d][x] = "#Get_Staff.Note#" >
				<cfset a_Staff_Position[d][x] = "#Get_Staff.Staff_Position#" >
				<cfset a_Team[d][x] = "#Get_Staff.Team#" >
			</cfloop>
			<cfset a_Last[d] = #x# >
		</cfif>
		</cfloop>
		<cfset last_dept = #d# >
		
		<cfquery datasource="#variables.DSN#" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset variables.imgfldr = "images\staff">
		<cfset variables.fullpath = "http://#cgi.server_name#/dealer/#Get_Dealer_Details.Dealer_Directory#/#variables.imgfldr#/">

	<cffunction name="modern_standard" description="create standard staff page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">
		
				<cfset hld_dept = 0 >
				<cfloop index="d" from="1" to="#last_dept#" >
					<cfif #a_Last[d]# LT 5 >
						<cfset stepper = #a_Last[d]#  >
					<cfelse>	
						<cfset stepper =   5  >
					</cfif>
				<cfloop index="x" from="1" to="#a_Last[d]#" step="#stepper#" >
					<cfset nxt = 0 >
					<cfif #hld_dept# NEQ #d_dept_id[d]# >
						<cfif #url.dealer_id# NEQ 18 >
						<div class="row">
							<div class="col-md-12">
							 <h2>#Get_Dealer_Details.Display_Name# #d_dept_name[d]# Staff</h2>
							</div>
						</div>
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-md-12">
							 We also speak: Hebrew, Albanian, Vietnamese, Arabic, Spanish, Thai, Tagalog, Kapampangan, Swahili, Farsi, Ilokano, Danish
							</div></div>
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-md-12">
							<a href="service.cfm" >Service Department >></a>
							</div></div>
						</cfif>	
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<cfset hld_dept = #d_dept_id[d]# >
					</cfif>
					<div class="row">
						<div class="col-md-2">
							 <cfif #a_Staff_Image[d][x]# NEQ "">  
								<img src="#variables.fullpath##a_Staff_Image[d][x]#" class="img-responsive" alt="#a_First_Name[d][x]# #a_Last_Name[d][x]#"  border="0" >
							  </cfif>  
							<p></p>
							<p>#a_First_Name[d][x]# #a_Last_Name[d][x]#
							<cfif #a_Staff_Position[d][x]# NEQ ""><br>#a_Staff_Position[d][x]#</cfif>
							<cfif #a_Phone[d][x]# NEQ ""><br>Phone : #a_Phone[d][x]#</cfif>
							<cfif #a_Cell_Phone[d][x]# NEQ ""><br>Mobile : #a_Cell_Phone[d][x]#</cfif>
							<cfif #a_Email[d][x]# NEQ "" AND #a_Email[d][x]# NEQ "N/A"><br><a href="mailto:#a_Email[d][x]#">#a_Email[d][x]#</a></cfif>
							<cfif #a_bio[d][x]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][x]#_Modal">About Me</a></cfif>
							<cfif #a_Note[d][x]# NEQ ""><br>#a_Note[d][x]#</cfif></p>
						</div>
						<cfif #a_bio[d][x]# NEQ "">
							<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
								<cfinvokeargument name="Person_ID" value="#a_person_id[d][x]#"/>
								<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][x]#"/>
								<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][x]#"/>
								<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][x]#"/>
								<cfinvokeargument name="Staff_Email" value="#a_Email[d][x]#">
								<cfinvokeargument name="Staff_Bio" value="#a_bio[d][x]#">
							</cfinvoke>
						</cfif>
						<cfset nxt = #x#+1 >
						<cfif #nxt# LTE #a_Last[d]# AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-2">
							 <cfif #a_Staff_Image[d][nxt]# NEQ ""> 
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
							 </cfif>  
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-2">
								 <cfif #a_Staff_Image[d][nxt]# NEQ ""> 
									<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
								 </cfif> 
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-2">
								<cfif #a_Staff_Image[d][nxt]# NEQ "">
									<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
								</cfif>
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-2">
								<cfif #a_Staff_Image[d][nxt]# NEQ "">
									<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
								</cfif>
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
					</div>
					</cfloop>
				</cfloop>
		
	</cffunction>


	<cffunction name="modern_standardSC" description="create standard staff page for Service Center" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">
		
				<cfset hld_dept = 0 >
				<cfloop index="d" from="1" to="#last_dept#" >
					<cfif #a_Last[d]# LT 4 >
						<cfset stepper = #a_Last[d]#  >
					<cfelse>	
						<cfset stepper =   4  >
					</cfif>
				<cfloop index="x" from="1" to="#a_Last[d]#" step="#stepper#" >
					<cfset nxt = 0 >
					 <cfif #hld_dept# NEQ #d_dept_id[d]# >
						<cfif #url.dealer_id# NEQ 18 >
						<div class="row">
							<div class="col-md-12">
							 <h2>#Get_Dealer_Details.Display_Name# #d_dept_name[d]# Staff</h2>
							</div>
						</div>
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-md-12">
							 We also speak: Hebrew, Albanian, Vietnamese, Arabic, Spanish, Thai, Tagalog, Kapampangan, Swahili, Farsi, Ilokano, Danish
							</div></div>
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<div class="row">
							<div class="col-md-12">
							<a href="service.cfm" >Service Department >></a>
							</div></div>
						</cfif>	
						<div class="row"><div class="col-md-12">&nbsp;</div></div>
						<cfset hld_dept = #d_dept_id[d]# >
					</cfif> 
					<div class="row">
						<div class="col-md-3">
							 <cfif #a_Staff_Image[d][x]# NEQ "">  
								<img src="#variables.fullpath##a_Staff_Image[d][x]#" class="img-responsive" alt="#a_First_Name[d][x]# #a_Last_Name[d][x]#"  border="0" >
							  </cfif>  
							<p></p>
							<p>#a_First_Name[d][x]# #a_Last_Name[d][x]#
							<cfif #a_Staff_Position[d][x]# NEQ ""><br>#a_Staff_Position[d][x]#</cfif>
							<cfif #a_Phone[d][x]# NEQ ""><br>Phone : #a_Phone[d][x]#</cfif>
							<cfif #a_Cell_Phone[d][x]# NEQ ""><br>Mobile : #a_Cell_Phone[d][x]#</cfif>
							<cfif #a_Email[d][x]# NEQ "" AND #a_Email[d][x]# NEQ "N/A"><br><a href="mailto:#a_Email[d][x]#">#a_Email[d][x]#</a></cfif>
							<cfif #a_bio[d][x]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][x]#_Modal">About Me</a></cfif>
							<cfif #a_Note[d][x]# NEQ ""><br>#a_Note[d][x]#</cfif></p>
						</div>
						<cfif #a_bio[d][x]# NEQ "">
							<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
								<cfinvokeargument name="Person_ID" value="#a_person_id[d][x]#"/>
								<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][x]#"/>
								<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][x]#"/>
								<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][x]#"/>
								<cfinvokeargument name="Staff_Email" value="#a_Email[d][x]#">
								<cfinvokeargument name="Staff_Bio" value="#a_bio[d][x]#">
							</cfinvoke>
						</cfif>
						<cfset nxt = #x#+1 >
						<cfif #nxt# LTE #a_Last[d]# AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-3">
							 <cfif #a_Staff_Image[d][nxt]# NEQ ""> 
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
							 </cfif>  
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-3">
								 <cfif #a_Staff_Image[d][nxt]# NEQ ""> 
									<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
								 </cfif> 
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<div class="col-md-3">
								<cfif #a_Staff_Image[d][nxt]# NEQ "">
									<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" >
								</cfif>
								<p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Phone[d][nxt]# NEQ ""><br>Phone : #a_Phone[d][nxt]#</cfif>
								<cfif #a_Cell_Phone[d][nxt]# NEQ ""><br>Mobile : #a_Cell_Phone[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ "" AND #a_Email[d][nxt]# NEQ "N/A"><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a href="##" data-toggle="modal" data-target="##bio#a_person_id[d][nxt]#_Modal">About Me</a></cfif> 
								<cfif #a_Note[d][nxt]# NEQ ""><br>#a_Note[d][nxt]#</cfif></p>
							</div>
							<cfif #a_bio[d][nxt]# NEQ "">
								<cfinvoke component="/cfcs/ultra10/popups" method="staff_bio">
									<cfinvokeargument name="Person_ID" value="#a_person_id[d][nxt]#"/>
									<cfinvokeargument name="Staff_Photo" value="#variables.fullpath##a_Staff_Image[d][nxt]#"/>
									<cfinvokeargument name="Staff_Name" value="#a_First_Name[d][x]# #a_Last_Name[d][nxt]#"/>
									<cfinvokeargument name="Staff_Position" value="#a_Staff_Position[d][nxt]#"/>
									<cfinvokeargument name="Staff_Email" value="#a_Email[d][nxt]#">
									<cfinvokeargument name="Staff_Bio" value="#a_bio[d][nxt]#">
								</cfinvoke>
							</cfif>
						</cfif>
					</div>
					</cfloop>
				</cfloop>
		
	</cffunction>
	
	
	
	
	<cffunction name="standard_legacy" description="create standard staff page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		
		<table>
			<cfset hld_dept = 0 >
			<cfloop index="d" from="1" to="#last_dept#" >
				<cfif #a_Last[d]# EQ 1 >
					<cfset stepper = 1 >
				<cfelseif #a_Last[d]# EQ 2>	
					<cfset stepper = 2 >
				<cfelseif #a_Last[d]# EQ 3>	
					<cfset stepper =  3  >
				<cfelseif #a_Last[d]# GTE 4>	
					<cfset stepper =   4  >
				<cfelseif #a_Last[d]# GTE 5>	
					<cfset stepper =   5  >
				</cfif>
				<cfloop index="x" from="1" to="#a_Last[d]#" step="#stepper#" >
					<cfset nxt = 0 >
					<cfif #hld_dept# NEQ #d_dept_id[d]# >
						<tr><td>&nbsp;</td></tr>
						<tr >
							<td>
							 <h2>#Get_Dealer_Details.Display_Name# #d_dept_name[d]# Staff</h2>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>
						<tr >
							<td>
							  We also speak: Hebrew, Albanian, Vietnamese, Arabic, Spanish, Thai, Tagalog, Kapampangan, Swahili, Farsi, Ilokano, Danish
							  <br>
							<a href="service.cfm" >Service Department >></a>
							</td>
						</tr>
						<cfset hld_dept = #d_dept_id[d]# >
					</cfif>
					<tr>
						<td width="25%">
							<img src="#variables.fullpath##a_Staff_Image[d][x]#" class="img-responsive" alt="#a_First_Name[d][x]# #a_Last_Name[d][x]#"  border="0" >
							<p></p>
							<p>#a_First_Name[d][x]# #a_Last_Name[d][x]#
							<cfif #a_Staff_Position[d][x]# NEQ ""><br>#a_Staff_Position[d][x]#</cfif>
							<cfif #a_Email[d][x]# NEQ ""><br><a href="mailto:#a_Email[d][x]#">#a_Email[d][x]#</a></cfif>
							<cfif #a_bio[d][x]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
						</td>
						<cfset nxt = #x#+1 >
						<cfif #nxt# LTE #a_Last[d]# AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
					</tr>
					<tr><td>&nbsp;</td></tr>	
					</cfloop>
				</cfloop>
		</table>
		
	</cffunction>

	<cffunction name="legacy_standard" description="create standard staff page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		
		<table>
			<cfset hld_dept = 0 >
			<cfloop index="d" from="1" to="#last_dept#" >
				<cfif #a_Last[d]# EQ 1 >
					<cfset stepper = 1 >
				<cfelseif #a_Last[d]# EQ 2>	
					<cfset stepper = 2 >
				<cfelseif #a_Last[d]# EQ 3>	
					<cfset stepper =  3  >
				<cfelseif #a_Last[d]# GTE 4>	
					<cfset stepper =   4  >
				<cfelseif #a_Last[d]# GTE 5>	
					<cfset stepper =   5  >
				</cfif>
				<cfloop index="x" from="1" to="#a_Last[d]#" step="#stepper#" >
					<cfset nxt = 0 >
					<cfif #hld_dept# NEQ #d_dept_id[d]# >
						<tr><td>&nbsp;</td></tr>
						<tr >
							<td>
							 <h2>#Get_Dealer_Details.Display_Name# #d_dept_name[d]# Staff</h2>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>
						<tr >
							<td>
							  We also speak: Hebrew, Albanian, Vietnamese, Arabic, Spanish, Thai, Tagalog, Kapampangan, Swahili, Farsi, Ilokano, Danish
							  <br>
							<a href="service.cfm" >Service Department >></a>
							</td>
						</tr>
						<cfset hld_dept = #d_dept_id[d]# >
					</cfif>
					<tr>
						<td width="25%">
							<img src="#variables.fullpath##a_Staff_Image[d][x]#" class="img-responsive" alt="#a_First_Name[d][x]# #a_Last_Name[d][x]#"  border="0" >
							<p></p>
							<p>#a_First_Name[d][x]# #a_Last_Name[d][x]#
							<cfif #a_Staff_Position[d][x]# NEQ ""><br>#a_Staff_Position[d][x]#</cfif>
							<cfif #a_Email[d][x]# NEQ ""><br><a href="mailto:#a_Email[d][x]#">#a_Email[d][x]#</a></cfif>
							<cfif #a_bio[d][x]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
						</td>
						<cfset nxt = #x#+1 >
						<cfif #nxt# LTE #a_Last[d]# AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
						<cfset nxt = #nxt#+1 >
						<cfif #nxt# LTE #a_Last[d]#  AND #d_dept_id[d]# EQ #hld_dept# >
							<td width="25%">
								<img src="#variables.fullpath##a_Staff_Image[d][nxt]#" class="img-responsive" alt="#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#"  border="0" ><p></p>
								<p>#a_First_Name[d][nxt]# #a_Last_Name[d][nxt]#
								<cfif #a_Staff_Position[d][nxt]# NEQ ""><br>#a_Staff_Position[d][nxt]#</cfif>
								<cfif #a_Email[d][nxt]# NEQ ""><br><a href="mailto:#a_Email[d][nxt]#">#a_Email[d][nxt]#</a></cfif>
								<cfif #a_bio[d][nxt]# NEQ ""><br><a style="font-size:12pt;color:red" href="##">About Me</a></cfif></p>
							</td>
						</cfif>
					</tr>
					<tr><td>&nbsp;</td></tr>	
					</cfloop>
				</cfloop>
		</table>
		
	</cffunction>

</cfcomponent>