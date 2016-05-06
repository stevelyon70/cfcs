<cfcomponent>
	<cffunction name="getHumanFileSize" access="public" returntype="string">
		<cfargument name="rawFileSize" type="string" required="yes">
        <!--- 
		loop thru dividing by 1024
		
		if lt 1k return with bytes
		divide again
		if lt 1k return MB
		divide again
		if lt 1k return GB
		
		--->
        <cfif arguments.rawFileSize lt 1024>
        	<cfset fileSizeRtn = numberformat(arguments.RawFileSize, "99.00") & ' Bytes'>
        <cfelseif arguments.rawFilesize/1024 lt 1024>
			<cfset fileSizeRtn = numberformat(arguments.RawFileSize/1024, "99.00") & ' KB'>
        <cfelseif arguments.rawFilesize/1024/1024 lt 1024>            
        	<cfset fileSizeRtn = numberformat(arguments.RawFileSize/1024/1024, "99.00") & ' MB'>
		<cfelseif arguments.rawFilesize/1024/1024/1024 lt 1024>            
        	<cfset fileSizeRtn = numberformat(arguments.RawFileSize/1024/1024/1024, "99.00") & ' GB'>
		</cfif>        
		<cfreturn fileSizeRtn>
	</cffunction>
    
    <cffunction name="getHumanModDate" access="public" returntype="string">
		<cfargument name="date" type="string" required="yes">
        
        <!--- get the date of modification
		validate it is a date
		loop thru based on date diff
		
		if 0 then return today
			if 0 then get humantime
		if 1 return yesterday
		if 2-7 return this week
		if 8-30 return this month
		if 31-60 return last month
		if 60-365 return in last year
		if 365+ return a while ago
		--->
        <cfset daysOld = datediff('d', arguments.date, now())>
        <cfif daysOld eq 1>
        	<cfset humanDaysOld = 'yesterday'>
         <cfelseif daysOld gte 2 and daysOld lte 7>
         	<cfset humanDaysOld = 'within a week'>
         <cfelseif daysOld gte 8 and daysOld lte 30>
         	<cfset humanDaysOld = 'within a month'>
         <cfelseif daysOld gte 31 and daysOld lte 60>
         	<cfset humanDaysOld = 'month ago'>
         <cfelseif daysOld gte 60 and daysOld lte 365>
         	<cfset humanDaysOld = 'within a year'>
         <cfelseif daysOld gt 365>
         	<cfset humanDaysOld = 'while ago'>
         <cfelseif daysOld eq 0>
         	<cfset humanDaysOld = 'today'>
         </cfif>
		
		<cfreturn humanDaysOld>
	</cffunction>
</cfcomponent>