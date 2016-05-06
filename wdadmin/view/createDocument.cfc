<cfcomponent>
	<cffunction name="createPdf" access="public" returntype="string">
		<cfargument name="filepath" type="string" required="yes">
		<cfargument name="content" type="any" required="yes">            
        
        <cfhttp url="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" result="s1" /> 
		<cfhttp url="http://ultra10.wddemos.com/wdadmin/style/style.css" result="s2" />                
        <cfdocument format="PDF" overwrite="yes" name="p1" filename="#arguments.filePath#/pdfReport.pdf">        
			<cfoutput>
            <style>		
            #s1.fileContent#
            #s2.fileContent#
            </style> 
            #arguments.content#
            </cfoutput>
        </cfdocument>  
              
        <cfset fileUrl = 'pdfReport.pdf'>		
		<cfreturn fileUrl>
	</cffunction>
</cfcomponent>