<cfcomponent>
	
	
	<cffunction name="form_submit" description="default quick-quote layout" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="formData" required="true">		
		<cfargument name="dsn" default="worlddealer">
		
<cfif arguments.formData.imahuman eq 1>
		<!---Check Customer Activity - Suspend submissions if a bot is suspected--->
		<cfinvoke component="/cfcs/forms/form_save" method="check_submit"></cfinvoke>
		<!---Server Side Form Validation--->
		<cfset variables.error_message="">		
		
		<cfif listlen(variables.error_message) gt 0>					
			<cfset url.error_message=variables.error_message>
		<cfelse>
			<cfquery datasource="#arguments.dsn#">
            	INSERT INTO [Worlddealer].[dbo].[WD_SEO_Launch_Responses]
                       ([q1]
                       ,[q2]
                       ,[q3]
                       ,[q4]
                       ,[q5]
                       ,[q6]
                       ,[q7]
                       ,[q8]
                       ,[q9]
                       ,[q10]
                       ,[q11]
                       ,[q12]
                       ,[q13]
                       ,[weburl]
                       ,[name]
                       ,[email]
                       ,[phone])
                 VALUES
                       ('#arguments.formData.question1#',
                       '#arguments.formData.question2#',
                       '#arguments.formData.question3#',
                       '#arguments.formData.question4#',
                       '#arguments.formData.question5#',
                       '#arguments.formData.question6#',
                       '#arguments.formData.question7#',
                       '#arguments.formData.question8#',
                       '#arguments.formData.question9#',
                       '#arguments.formData.question10#',
                       '#arguments.formData.question11#',
                       '#arguments.formData.question12#',
                       '#arguments.formData.question13#',                       
                       '#arguments.formData.web_url#',                       
                       '#arguments.formData.name#',                       
                       '#arguments.formData.email#',                       
                       '#arguments.formData.phone#')
            </cfquery>	
            <cfset recips = 'seo@worlddealer.net;'>
            <!---<cfset recips = 'slyon@worlddealer.net'>--->
            <cfmail to="#recips#" from="seo@worlddealer.net" type="html" subject="Dealer #arguments.formData.name# has completed their Seo Launch Form" cc="tech@worlddealer.net">
            	Web Address : #arguments.formData.web_url#<br />
                Name : #arguments.formData.name#<br />
                Email : #arguments.formData.email#<br />
                Phone : #arguments.formData.phone#<br />
                <strong>Identify your primary market (PMA)</strong> : #arguments.formData.question1#<br />
                <strong>Identify up to 5 additional markets, areas, cities, or towns</strong> : #arguments.formData.question2#<br />
                <strong>Identify your 4 "core models" of vehicles that you sell</strong> : #arguments.formData.question3#<br />
                <strong>Identify the age range, gender, or other characteristics of your ideal customers</strong> : #arguments.formData.question4#<br />
                <strong>List the 10 most important keyword phrases you would like to rank for within your local market.</strong> : #arguments.formData.question5#<br />
                <strong>What local businesses, events, charities or organizations do you sponsor or conduct business with on a regular basis throughout the year?</strong> : #arguments.formData.question6#<br />
                <strong>Identify your top 3 competitors</strong> : #arguments.formData.question7#<br />
                <strong>Briefly explain any mission statement or value propositions that you may already be known for in these markets</strong>  : #arguments.formData.question8#<br />
                <strong>Identify local landmarks within a small radius of your dealership</strong> : #arguments.formData.question9#<br />
                <strong>Identify local highways or popular roads leading to or near your dealership</strong> : #arguments.formData.question10#<br />
                <strong>What do YOU believe to be the radius of your PMA?</strong>  : #arguments.formData.question11#<br />
                <strong>Identify any additional services or conveniences that your customers enjoy</strong> : #arguments.formData.question12#<br />
                <strong>List the zipcodes that account for 80% of your business</strong> : #arguments.formData.question13#<br />
            </cfmail>
            		
		</cfif>
<cfelse>
         <cfmail to="slyon@worlddealer.net" from="seo@worlddealer.net" type="html" subject="Seo Launch Form">
            	BOT ALERT<br /><cfdump var="#arguments#">                
         </cfmail>
</cfif>
	</cffunction>

</cfcomponent>