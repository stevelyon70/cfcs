
<cfcomponent>


	<style>
		
		.video-div{
			width:800px;
			height:600px;
			background-image:url('shaded.png');
			margin:0px auto 0px auto;
			border:3px solid #999;
			border-radius: 10px!important;
			-moz-border-radius: 10px!important;
			-webkit-border-radius: 10px!important;
			padding:10px;
		}
	</style>

	<cffunction name="modern" description="eblast landing page" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
	
		<cfquery datasource="Ultra10" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,proximity,address_2,emb_expiration,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset variables.dlr_dir = #Get_Dealer_Details.Dealer_Directory#>
		<cfset variables.youtube_link = "#Get_Dealer_Details.proximity#">
		<cfset variables.x_link = "#Get_Dealer_Details.address_2#">
		
		
		<cfquery datasource="VEmail10" name="Chk_Clicks">
			SELECT      ID, dealer_id, visits, first_visit_dt, last_visit_dt, click_thru, first_click_thru_dt, last_click_thru_dt, expire_ts
			FROM         Video_Email_Tracker
			WHERE		dealer_id=<cfqueryparam value="#url.dealer_id#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
			AND			active = 1
		</cfquery>
		
		<cfif #Chk_Clicks.recordcount# EQ 0 >
			<cfif #Chk_Clicks.expire_ts# EQ "" >
				<cfquery NAME="InsertUType" datasource="VEmail10">
				  INSERT into Video_Email_Tracker ( dealer_id, visits, first_visit_dt,last_visit_dt, click_thru  )
				  VALUES ( 	#url.dealer_id#,0,#CreateODBCDateTime(now())#,#CreateODBCDateTime(now())#,0   )
				</cfquery>
			</cfif>
		</cfif>

		<cfquery datasource="VEmail10" name="New_Visits">
			SELECT 	 ID, dealer_id, visits, first_visit_dt, last_visit_dt, click_thru, first_click_thru_dt, last_click_thru_dt
			FROM   	Video_Email_Tracker
			WHERE	dealer_id=<cfqueryparam value="#url.dealer_id#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
			AND		active = 1
		</cfquery>
		<cfif #New_Visits.visits# EQ "" >
			<cfset upd_visits =  1 >
		<cfelse>
			<cfset upd_visits = #New_Visits.visits# + 1 >
		</cfif>
			
		
		<cfset set_exp = "" >
		<cfif #Get_Dealer_Details.emb_expiration# NEQ "" >
			<cfset set_exp = #dateformat(Get_Dealer_Details.emb_expiration,"mm/dd/yyyy")# >
		</cfif>
				
		<cfquery datasource="VEmail10" name="Update_Visits">
			UPDATE	Video_Email_Tracker
			SET		visits=<cfqueryparam value="#upd_visits#" cfsqltype="CF_SQL_INTEGER">,
					<cfif #New_Visits.first_visit_dt# EQ "" >first_visit_dt=#CreateODBCDateTime(now())#,</cfif>
					<cfif #set_exp# NEQ "" >expire_ts=#CreateODBCDateTime(set_exp)#,<cfelse>expire_ts=NULL,</cfif>
					last_visit_dt=#CreateODBCDateTime(now())#
			WHERE	ID=<cfqueryparam value="#New_Visits.ID#" cfsqltype="CF_SQL_INTEGER" maxlength="6">
		</cfquery>			
		
		
		<section class="section-spl">
			<div class="container" >
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>			
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				<div class="row"></div>					 
				<div class="row"><div class="col-md-10  img-responsive" align="right" >
					<a href="eblast/click_thru.cfm?dealer_id=#url.dealer_id#&click_action=#variables.x_link#"><img alt="X" src="http://ultra10.wddemos.com/dealer/#variables.dlr_dir#/images/icons/xbtn.png" class="img-responsive" border="0"></a>
				</div></div>
				<div class="row">
					<div class="col-md-12  img-responsive" align="center" >	
						<div class="video-div img-responsive" >
							 <iframe 	width="674px" 
							 			height="390px" 
										src="#variables.youtube_link#" 
										frameborder="1" 
										allowfullscreen>
							</iframe>
						</div>
					</div>
				</div>
			</div>  <!--- container --->
		</section>
		
	</cffunction>


	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">


	</cffunction>

</cfcomponent>