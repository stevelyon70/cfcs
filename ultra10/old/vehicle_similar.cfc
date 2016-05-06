<cfcomponent>

	<cffunction name="vdp_similar" description="Gets simlar vehicles for VDP" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Get_Similar" required="true">

		<cfset Get_Similar=arguments.Get_Similar>
		
		<cfloop query="Get_Similar">
			<a class="vpd-similar" href="">
				<cfif listlen(Get_Similar.Img_Urls) gt 0>
					<img class="vdp-img" src="#listgetat(Get_Similar.Img_Urls,1)#"/>
				</cfif>
				#Get_Similar.V_Year# #Get_Similar.V_Make# #Get_Similar.V_Model# #Get_Similar.V_Trim#<br/>
				<div class="txt-red"><b>$#numberformat(Get_Similar.Selling_Price)#</b></div><br/>
			</a>
		</cfloop> 

	</cffunction>

</cfcomponent>