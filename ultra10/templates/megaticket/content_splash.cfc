<cfcomponent>

	<cffunction name="modern" description="shows a standard contest pages 1 & 2" output="Yes" access="public">	
		
		<link href='http://fonts.googleapis.com/css?family=La+Belle+Aurore' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,800,300' rel='stylesheet' type='text/css'>
		
		<cfif NOT IsDefined("url.page")>
			<cfset url.page = "1" >
		</cfif>
		
		<cfquery datasource="Ultra10" name="dealer_detl">
			SELECT	ID, dealer_id, contest_name, form_header, your_info_title, question_title, trade_title, thankyou_page_text, confirmation_email, confirmation_email_subject, 
                      	confirmation_email_text,confirmation_email_from, questions_on, tradein_form, lead_email, rules_regs, lead_email_subject, lead_email_type, lead_email_from, 
						drawing_dt, start_dt, expires_dt, created_ts, active, image_page1, image_page2, image_email
				FROM    Contest_Control
			WHERE		Dealer_id = #url.dealer_ID#
			and active = 1
		</cfquery>
		
	<cfif #url.page# EQ 1 >
	
		
		<section class="section-splash-spl">
			<div class="container">		
		
	<!--- Body DESKTP & MOBILE Page 1  --->	
				<div class="row no-pad">	 
					<div class="col-md-7 body-text no-pad" align="left"> 
						 <img src="http://dealers.wdautos.com/dealer/baierlmegaticket/images/icons/#dealer_detl.image_page1#" alt="#dealer_detl.contest_name#"  class="img-responsive" border="0">
					</div>
					
					<div class="col-md-5 " align="left" >
						
						<div class="row">	
							<div class="col-md-12 pad-left 5" align="right">	
								<cfinvoke component="/cfcs/forms/form_trade" method="megaticket_default">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="VOI_Vin" value=""/>
									<cfinvokeargument name="VOI_New_Used" value=""/>
									<cfinvokeargument name="form_name" value="megaticket_default"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/megaticket_action.cfm"/>
								</cfinvoke>  
							</div>
						</div>
						
					</div>
				</div>

			</div>  <!--- container --->
		</section>
		
		<section class="section-ftr">
			<div class="container">		
	<!--- Footer DESKTOP Page 1 --->	
			<cfif #dealer_detl.rules_regs# NEQ "" >	
				<div class="row   pad-top-10">	
					<div class="col-md-6" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			  <a href="http://dealers.wdautos.com/dealer/baierlmegaticket/pdfs/#dealer_detl.rules_regs#" target="_blank" >Click here to view Official Rules and Regulations</a>
					</div>
					<div class="col-md-6" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="right">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  alt="WorldDealer Advertising, Inc." >  
					</div>
				</div>
			<cfelse>	
				<div class="row   pad-top-10">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  alt="WorldDealer Advertising, Inc." >  
					</div>
				</div>	
			</cfif>		
			</div>  <!--- container --->
		</section>
		
	<cfelseif #url.page# EQ 2>

	
		<cfquery datasource="Ultra10" name="Get_Thank_You_Page">
			SELECT	ID, dealer_id, contest_name, form_header, your_info_title, question_title, trade_title, thankyou_page_text, confirmation_email, confirmation_email_subject, 
                      	confirmation_email_text,confirmation_email_from, questions_on, tradein_form, lead_email, rules_regs, lead_email_subject, lead_email_type, lead_email_from, drawing_dt, 
					  	start_dt, expires_dt, created_ts, active
				FROM    Contest_Control
			WHERE		Dealer_id = #url.dealer_ID#
			and active = 1
		</cfquery>
		<cfset drw_dt = #dateformat(Get_Thank_You_Page.drawing_dt,"mm/dd/yyyy")# >
		
		<cfquery datasource="Ultra10" name="Get_Entry">
			SELECT  ID, dealer_id, contest_id, first_name, last_name, email, phone, question1, question2, question3, question4, question5, question6, question7, question8, 
		            question9, question10, submitted_ts
			FROM    Contest_Entries
			WHERE		ID = #url.entry_ID#
		</cfquery>
		
		
		<section class="section-splash-spl">
			<div class="container">		
		
	<!--- Body DESKTP & MOBILE Page 2  --->	
				<div class="row no-pad">	 
					<div class="col-md-7 body-text no-pad " align="left">
						 <img src="http://dealers.wdautos.com/dealer/baierlmegaticket/images/icons/#dealer_detl.image_page2#" alt="#dealer_detl.contest_name#"  class="img-responsive" border="0">
					</div>
					
					<div class="col-md-5 " align="left" >
						
						<div class="row">	
							<div class="col-md-12 pad-left 5" align="right" style="background-color:##EBEBEB">	
								<cfset Get_Thank_You_Page.thankyou_page_text=replace(Get_Thank_You_Page.thankyou_page_text,"$CUST1$","#Get_Entry.first_name#","All")>
								<cfset Get_Thank_You_Page.thankyou_page_text=replace(Get_Thank_You_Page.thankyou_page_text,"$CUST2$","#Get_Entry.last_name#","All")>
								<cfset Get_Thank_You_Page.thankyou_page_text=replace(Get_Thank_You_Page.thankyou_page_text,"$CEMAIL$","#Get_Entry.email#","All")>
								<cfset Get_Thank_You_Page.thankyou_page_text=replace(Get_Thank_You_Page.thankyou_page_text,"$WHERE$","#Get_Thank_You_Page.contest_name#","All")>
								<cfset Get_Thank_You_Page.thankyou_page_text=replace(Get_Thank_You_Page.thankyou_page_text,"$WHEN$","#drw_dt#","All")>
								#rtrim(Get_Thank_You_Page.thankyou_page_text)#
							</div>
						</div>
					</div>
				</div>
				
		
			</div>  <!--- container --->
			
			
		</section>

		<section class="section-ftr">
			<div class="container">		
	<!--- Footer DESKTOP Page 1 --->	
			<cfif #dealer_detl.rules_regs# NEQ "" >	
				<div class="row   pad-top-10">	
					<div class="col-md-6" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			  <a href="http://dealers.wdautos.com/dealer/baierlmegaticket/pdfs/#dealer_detl.rules_regs#" target="_blank" >Click here to view Official Rules and Regulations</a>
					</div>
					<div class="col-md-6" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="right">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  alt="WorldDealer Advertising, Inc." >  
					</div>
				</div>
			<cfelse>	
				<div class="row   pad-top-10">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  alt="WorldDealer Advertising, Inc." >  
					</div>
				</div>	
			</cfif>		
			</div>  <!--- container --->
		</section>
		
	<cfelseif #url.page# EQ 3>

	
		<cfquery datasource="Ultra10" name="Get_Error_Page">
			SELECT	ID, dealer_id, contest_name, form_header, your_info_title, question_title, trade_title, thankyou_page_text, confirmation_email, confirmation_email_subject, 
                      	confirmation_email_text,confirmation_email_from, questions_on, tradein_form, lead_email, rules_regs, lead_email_subject, lead_email_type, lead_email_from, drawing_dt, 
					  	start_dt, expires_dt, created_ts, active, error_page_text
				FROM    Contest_Control
			WHERE		Dealer_id = #url.dealer_ID#
			and active = 1
		</cfquery>
		<cfset drw_dt = #dateformat(Get_Error_Page.drawing_dt,"mm/dd/yyyy")# >
		
		<cfquery datasource="Ultra10" name="Get_Entry">
			SELECT  ID, dealer_id, contest_id, first_name, last_name, email, phone, question1, question2, question3, question4, question5, question6, question7, question8, 
		            question9, question10, submitted_ts
			FROM    Contest_Entries
			WHERE		ID = #url.entry_ID#
		</cfquery>
		<cfset reg_dt = #dateformat(Get_Entry.submitted_ts,"mm/dd/yyyy")# >
		
		
		<section class="section-splash-spl">
			<div class="container">		
		
	<!--- Body DESKTP & MOBILE Page 2  --->	
				<div class="row no-pad">	 
					<div class="col-md-7 body-text no-pad " align="left">
						 <img src="http://dealers.wdautos.com/dealer/baierlmegaticket/images/icons/#dealer_detl.image_page2#" alt="#dealer_detl.contest_name#"  class="img-responsive" border="0">
					</div>
					
					<div class="col-md-5 " align="left" >
						
						<div class="row">	
							<div class="col-md-12 pad-left 5" align="right" style="background-color:##EBEBEB">	
								<cfset Get_Error_Page.error_page_text=replace(Get_Error_Page.error_page_text,"$CUST1$","#Get_Entry.first_name#","All")>
								<cfset Get_Error_Page.error_page_text=replace(Get_Error_Page.error_page_text,"$CUST2$","#Get_Entry.last_name#","All")>
								<cfset Get_Error_Page.error_page_text=replace(Get_Error_Page.error_page_text,"$CEMAIL$","#Get_Entry.email#","All")>
								<cfset Get_Error_Page.error_page_text=replace(Get_Error_Page.error_page_text,"$WHERE$","#Get_Error_Page.contest_name#","All")>
								<cfset Get_Error_Page.error_page_text=replace(Get_Error_Page.error_page_text,"$WHEN$","#drw_dt#","All")>
								<cfset Get_Error_Page.error_page_text=replace(Get_Error_Page.error_page_text,"$PREREG$","#reg_dt#","All")>
								#rtrim(Get_Error_Page.error_page_text)#  
							</div>
						</div>
					</div>
				</div>
				
		
			</div>  <!--- container --->
			
			
		</section>

		<section class="section-ftr">
			<div class="container">		
	<!--- Footer DESKTOP Page 1 --->	
			<cfif #dealer_detl.rules_regs# NEQ "" >	
				<div class="row   pad-top-10">	
					<div class="col-md-6" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			  <a href="http://dealers.wdautos.com/dealer/baierlmegaticket/pdfs/#dealer_detl.rules_regs#" target="_blank" >Click here to view Official Rules and Regulations</a>
					</div>
					<div class="col-md-6" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="right">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  alt="WorldDealer Advertising, Inc." >  
					</div>
				</div>
			<cfelse>	
				<div class="row   pad-top-10">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  alt="WorldDealer Advertising, Inc." >  
					</div>
				</div>	
			</cfif>		
			</div>  <!--- container --->
		</section>


	</cfif>			
  

	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	</cffunction>

</cfcomponent>