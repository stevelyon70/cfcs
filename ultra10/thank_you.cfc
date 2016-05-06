<cfcomponent>

	<cffunction name="generic" description="shows generic thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You For Your Request.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
        
	</cffunction>
	
	<cffunction name="hotlist" description="shows hot list thank you message" output="Yes" access="public">
	
		<cfquery datasource="ultra10" name="Get_OEM">
			SELECT			OEMs.OEM_Name,Join_Dealer_OEM.OEM_ID AS OID,
							Join_Dealer_OEM.Dealer_OEM_ID
			FROM			OEMs
			INNER JOIN		Join_Dealer_OEM
			ON				OEMs.OEM_ID = Join_Dealer_OEM.OEM_ID
			WHERE     		Join_Dealer_OEM.Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.dlr#" maxlength="5">
			ORDER BY		OEMs.OEM_Name
		</cfquery>
	
		<!--- <cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
			#Get_Meta_Info.page_banner#
		</cfif>	 --->
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You For Your #Get_OEM.OEM_Name# Hot List Inquiry.</h3>
				<h4>A Baierl Automotive Team Member Will Contact You Shortly.</h4>
			</div>
			<br><br><br><br>
			<br><br><br><br>
		</cfif>
	</cffunction>

	<cffunction name="service" description="shows generic thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You For Your Request.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="offlease" description="shows off lease thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="maillist" description="shows mailing list registration thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
			
			<div class="msg-thank-you" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="events" description="shows consumer event registration thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
			
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		<cfelse>
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="malibu_event" description="shows email event registration thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
			
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		<cfelse>
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>
	
	<cffunction name="kelly_event" description="shows email event registration thank you message" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
			
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
			</div>
		<cfelse>
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:70px" align="center">
				<h3>Thank You.</h3>
				<h4>A #url.Dealer_Name#<br/>
				Associate will Contact You Shortly.</h4>
				<br><br>
				<div class="col-md-4" align="center">&nbsp;</div>
				<div class="col-md-4" align="center">
				<a href="http://kellynissanofroute33.com/new/offers.cfm" ><img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/btn_MarchMania_ViewSpecials.jpg" width="100%" alt="March Mania Sales Event"/></a>
				</div>
				<div class="col-md-4" align="center">&nbsp;</div>
			</div>
		</cfif>
		<cfif #url.dealer_id# EQ 358 >
			 
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				<a href="kellynissanof route33.com" class="register-go-btn" >Visit Our Site</a>
			</div>
		<cfelse>
			<div class="msg-thank-you pad-bottom-10" style="margin-bottom:90px" align="center">
				&nbsp;
			</div>	
		</cfif>
	</cffunction>
	
	<cffunction name="application_gpada" description="GPADA PayPal Integration" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You for your Application.</h3>
				<h4>A GPADA Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>

	<cffunction name="turkey_shoot" description="GPADA PayPal Integration" output="Yes" access="public">
		<cfif len(trim(Get_Meta_Info.page_content)) gt 0>
			#Get_Meta_Info.page_content#
		<cfelse>
			<div class="msg-thank-you" align="center">
				<h3>Thank You for your Application.</h3>
				<h4>A GPADA Associate will Contact You Shortly.</h4>
			</div>
		</cfif>
	</cffunction>


</cfcomponent>