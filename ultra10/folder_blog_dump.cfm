<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Blog Pages</title>
</head>

<body>
<cfoutput>
	<cfset where = ExpandPath("*.*") >
	<cfset thisDirectory = "E:\Inetpub\wwwroot/ultra10/blog">
	<cfset variables.look_at_Location="#thisDirectory#">
	<cfdirectory directory="#variables.look_at_Location#" name="file_used" sort="name ASC">
	
	<cfset clr="white">
	<table 	width="80%" align="center"  border="0"cellpadding="5"cellspacing="0">
		<tr>
			<td colspan="3" align="center" valign="TOP" >
				<h2>Blog Folder Pages</h2>
			</td>
		</tr>	
		<tr>
			<td width="33%" valign="TOP" >
				<table 	width="100%" align="center"  border="0"cellpadding="3"cellspacing="0">
					<tr>
						<td  colspan="2"  align="center">
							<div class="hdrline">BLOG</div>
						</tr>		
						<tr bgcolor="lightgrey" >
							<td align="left">Folder</td>
							<td align="left">Page Name</td>
						</tr>		
						<cfset clr=0 >
						<cfset trip_new=0 >
						<cfloop query="file_used">
							<cfif #file_used.type# EQ "Dir" >
								<cfquery name="get_n_page" datasource="Ultra10">
									SELECT   page_id ,  page_name,directory,file_name,script_name, active
									FROM   	global_page_registry
									WHERE	directory	like 'blog/#file_used.name#%'
								</cfquery>
								<cfset trip_new=#trip_new#+1 >
									<cfif clr EQ "##F8F8F8"><cfset clr="white"><cfelse><cfset clr="##F8F8F8"></cfif>
									<tr bgcolor="#clr#" >
										<td align="left">#file_used.name#</td>
										<td align="left"><cfif #get_n_page.recordcount# NEQ 0 >#get_n_page.page_name#<cfelse>&nbsp;</cfif></td>
									</tr>		
							</cfif>					
						</cfloop>	 
				</table>	
			</td>
		
			<td width="33%" valign="TOP" >&nbsp;
			</td>
			  
			<td width="33%" valign="TOP" >&nbsp;
				
			</td>  
			
		</tr>
	</table>
</cfoutput>

</body>
</html>

