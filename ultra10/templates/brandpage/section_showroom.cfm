<cfoutput>
	<cfset v_make = ArrayNew(1)>
	<cfif #url.v_make# EQ "CDJR">
		<cfset v_make[1] = "Chrysler">
		<cfset v_make[2] = "Dodge">
		<cfset v_make[3] = "Jeep">
		<cfset v_make[4] = "RAM">
		<cfset lst_make = 4>
	<cfelse>	
		<cfset v_make[1] = "#url.v_make#">
		<cfset lst_make = 1>
	</cfif>	
<cfloop index="x" from="1" to="#lst_make#" >
	<cfquery datasource="Ultra8" name="Chk_Chrome">
		SELECT		Chrome_Reviews.Vehicle_Year
		FROM		Chrome_Reviews
		INNER JOIN	Chrome_Reviews_Gallery
		ON 			Chrome_Reviews.Chrome_Model_ID=Chrome_Reviews_Gallery.Chrome_Model_ID
		WHERE		Chrome_Reviews.Vehicle_Make=<cfqueryparam value="#v_make[x]#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">
		AND			Chrome_Reviews.Showroom_Active=1
		AND			Chrome_Reviews_Gallery.Hierarchy=1
		ORDER BY	Chrome_Reviews.Vehicle_Model, Chrome_Reviews.Vehicle_Year
	</cfquery>

	<cfif #Chk_Chrome.recordcount# NEQ 0 >
		<section class="section-showroom">
			<div class="container pad-top-10 visible-md visible-lg visible-sm visible-xs">
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
				<div class="row">
					<div class="col-md-12  no-pad" style="align:center">
					<div class="row"><div class="pg-division-titles" title="#Get_Nav.Nav_Name#" style="align:left">#v_make[x]# Showroom</div></div><div class="row">&nbsp;</div>
						<cfset url.v_make = #v_make[x]# >
						<cfinvoke component="/cfcs/ultra10/var_chrome_reviews" method="modern_index">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="section-showroom"/>
							<cfinvokeargument name="pull" value="none"/>
						</cfinvoke>
					</div>
				</div>
			</div>  
		</section>
	</cfif>
</cfloop>	
</cfoutput>
