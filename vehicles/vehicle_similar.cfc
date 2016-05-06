<cfcomponent>

	<cffunction name="vdp_similar" description="Gets simlar vehicles for VDP" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Get_Similar" required="true">

		<cfset Get_Similar=arguments.Get_Similar>
		
		<cfloop query="Get_Similar">
			<a class="vpd-similar" href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Similar.Vin#"">
				<cfif listlen(Get_Similar.Img_Urls) gt 0>
					<img  alt="#Get_Similar.V_Make#" class="img-responsive" src="#listgetat(Get_Similar.Img_Urls,1)#"/>
				</cfif>
				#Get_Similar.V_Year# #Get_Similar.V_Make# #Get_Similar.V_Model# #Get_Similar.V_Trim#<br/>
				<cfif #url.dealer_id# EQ 78 AND #url.new_used# EQ "N" >
					<div class="txt-red"><b>Call For Price</b></div><br/>
				<cfelse>
					<cfif Get_Similar.Selling_Price neq 0 and Get_Similar.Selling_Price neq 10000000>
						<div class="txt-red"><b>$#numberformat(Get_Similar.Selling_Price)#</b></div><br/>
					<cfelse>
						<div class="txt-red"><b>Call For Price</b></div><br/>
					</cfif>
				</cfif>	
			</a>
		</cfloop> 

	</cffunction>


<!--- NEW VDP 12/21/2015  --->
	<cffunction name="vdp_similar_new" description="Gets simlar vehicles for VDP" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Get_Similar" required="true">

		<cfset Get_Similar=arguments.Get_Similar>
		                     
                      
		<cfloop query="Get_Similar">
 		<div class="col-md-3">
			<a class="vpd-similar" href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Similar.Vin#" >
				<cfif listlen(Get_Similar.Img_Urls) gt 0>
					<img  alt="#Get_Similar.V_Make#" class="img-responsive" src="#listgetat(Get_Similar.Img_Urls,1)#"/>
				</cfif>
				<p align="center" class="txt-vdp-similar">#Get_Similar.V_Year# #Get_Similar.V_Make# #Get_Similar.V_Model# #Get_Similar.V_Trim#<br/></p>
				<cfif Get_Similar.Selling_Price neq 0 and Get_Similar.Selling_Price neq 10000000>
					<p align="center" class="txt-vdp-similar-red"> <b>$#numberformat(Get_Similar.Selling_Price)#</b></p><br/>
				<cfelse>
					<p align="center" class="txt-vdp-similar-red"><b>Call For Price</b><br/></p>
				</cfif>
				<p align="center"><input class="btn-vdp-similar" name="Button_Go" type="submit" value="View Vehicle" onClick="javascript:self.location='http://#lcase(cgi.server_name)#/vehicles/#lcase(Get_Similar.V_Make)#/#lcase(Get_Similar.V_Model)#/#lcase(Get_Similar.Permalink)#';"></p><br/>
			</a>	
		</div>	
		</cfloop> 

	</cffunction>

	<cffunction name="vdp_similar_legacy" description="Gets simlar vehicles for VDP" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Get_Similar" required="true">

		<cfset Get_Similar=arguments.Get_Similar>
		
		<cfloop query="Get_Similar">
			<a class="vpd-similar" href="http://#cgi.server_name#/vehicles/vehicle_details.cfm?vin=#Get_Similar.Vin#"">
				<cfif listlen(Get_Similar.Img_Urls) gt 0>
					<img alt="#Get_Similar.V_Make#" style="width:240px;" src="#listgetat(Get_Similar.Img_Urls,1)#"/>
				</cfif>
				#Get_Similar.V_Year# #Get_Similar.V_Make# #Get_Similar.V_Model# #Get_Similar.V_Trim#<br/>
				
				<cfif #url.dealer_id# EQ 78 AND #url.new_used# EQ "N" >
						<div class="txt-red"><b>Call For Price</b></div><br/>
				<cfelse>
					<cfif Get_Similar.Selling_Price neq 0 and Get_Similar.Selling_Price neq 10000000>
						<div class="txt-red"><b>$#numberformat(Get_Similar.Selling_Price)#</b></div><br/>
					<cfelse>
						<div class="txt-red"><b>Call For Price</b></div><br/>
					</cfif>
				</cfif>	
			</a>
		</cfloop> 

	</cffunction>

</cfcomponent>