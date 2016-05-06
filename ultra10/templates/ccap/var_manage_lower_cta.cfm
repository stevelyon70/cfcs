<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--- Module Identification & Modification History
  ***************************************************************************
  ***************************************************************************
  ***
  ***   Module          :   var_manage_lower_cta.cfm
  ***   Author 			:   Bob Anderson
  ***   Date            :   August 2014
  ***
  ***************************************************************************
  ***   Function 
  ***
  ***
  SELECT     TOP (200) ID, dealer_id, name, image, link, active, create_ts, hierarchy
FROM         Nav_Block_4
  
  ***   Modification History
  ***	
  *************************************************************************** --->
 
<html>

<link href="css/admin-style.css" type="text/css" rel="stylesheet"/>

<cfoutput>

<cfif NOT IsDefined("url.dealer_id")>
	<cfset url.dealer_id = 233 >
</cfif>
<cfif NOT IsDefined("url.scrn")>
	<cfset url.scrn = 0 >
</cfif>

<cfif #url.page_type# EQ 2 >
	<cfset page_nbr = 2 >
	<cfset page_title="Special Offers Lower CTA">
<cfelseif #url.page_type# EQ 0 >
	<cfset page_nbr = 0 >
	<cfset page_title="Splash Page Lower CTA">
<cfelseif #url.page_type# EQ 3 >
	<cfset page_nbr = 3 >
	<cfset page_title="Finance Page Lower CTA">
<cfelseif #url.page_type# EQ 4 >
	<cfset page_nbr = 4 >
	<cfset page_title="Showroom Page Lower CTA">
<cfelseif #url.page_type# EQ 1 >
	<cfset page_nbr = 1 >
	<cfset page_title="Service Page Lower CTA"> 
<cfelseif #url.page_type# EQ 5 >
	<cfset page_nbr = 5 >
	<cfset page_title="Careers Page Lower CTA">
<cfelseif #url.page_type# EQ 6 >
	<cfset page_nbr = 6 >
	<cfset page_title="Community Page Lower CTA">
<cfelseif #url.page_type# EQ 7 >
	<cfset page_nbr = 7 >
	<cfset page_title="Discover Page Lower CTA">
<cfelseif #url.page_type# EQ 8 >
	<cfset page_nbr = 8 >
	<cfset page_title="Collision Page Lower CTA">
<cfelseif #url.page_type# EQ 9 >
	<cfset page_nbr = 9 >
	<cfset page_title="Parts Page Lower CTA">
</cfif>


<cfquery datasource="Ultra10" name="Get_Dealer">
	SELECT     	Dealer_Directory,city,state,display_name,Dealercode FROM Dealers WHERE Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
</cfquery>
<cfset G_DEALER_DIRECTORY = "#Get_Dealer.Dealer_Directory#" ><cfset G_DEALER_NAME = "#Get_Dealer.display_name#" >


<script language="javascript">
function confirmThis(myID) {
	var result;
	result = confirm('Are you sure to delete this record?');
	if (result==true){
		document.form_name.del_id.value=myID;
		document.form_name.Delete.value= "Yes";
		document.form_name.submit();		
	}
}
</script>


				<cfset variables.imgfldr="images\icons">
				<cfset variables.fullpath="E:\inetpub\wwwroot\Ultra10\dealer\#G_DEALER_DIRECTORY#\#variables.imgfldr#\">
				<cfset variables.previewpath="http://#G_IMAGE_DIRECTORY#.com/dealer/#G_DEALER_DIRECTORY#/images/icons">
				<cfdirectory directory="#variables.fullpath#" name="file_db" sort="name ASC">



<cfif IsDefined("form.Delete") AND #form.Delete# Is "Yes">
	<cfquery name="DeleteEvent" datasource="Ultra10">
		Delete From	Nav_Block_4 Where ID = #form.del_id#
	</cfquery>
	<cflocation url="var_manage_lower_cta.cfm?scrn=0">
</cfif>	  

</head>

<cfif #url.scrn# EQ 1 >
	<!--- ADD / EDIT SECTION --->
	<cfif IsDefined("form.Submit")>
		<cfif #form.newrec# EQ -1 >
			<cfquery NAME="InsertUType" datasource="Ultra10">
			  INSERT into Nav_Block_4 ( 	Dealer_ID,  name,image, link,target,  hierarchy,page_type,make )
			  VALUES ( 	#Form.Dealer_ID#,'#Form.name#','#Form.image#','#Form.link#','#Form.target#',#Form.hierarchy#,#Form.page_type# ,'#Form.make#' )
			</cfquery>
			<cfquery datasource="Ultra10" name="qryLast_id">SELECT A.ID FROM	Nav_Block_4 A ORDER BY A.ID DESC</cfquery>
			<cfset Last_id = #qryLast_id.ID#>
			<cflocation url="var_manage_lower_cta.cfm?dealer_id=#form.dealer_id#&scrn=1&code=#last_id#&svd=1&page_type=#form.page_type#">
		<cfelse>			
			<cfquery NAME="UpdateUTyp" datasource="Ultra10">
				UPDATE Nav_Block_4
				SET 	Dealer_ID=#Form.Dealer_ID#,
						name='#Form.name#',
				 		image='#Form.image#',
						link='#Form.link#',
						target='#Form.target#',
						make='#Form.make#',
						page_type='#Form.page_type#',
				 		hierarchy=#Form.hierarchy#
				WHERE 	ID	=	#form.code#
			</cfquery>
			<cflocation url="var_manage_lower_cta.cfm?dealer_id=#form.dealer_id#&scrn=1&chg=1&code=#form.Code#&page_type=#form.page_type#">
		</cfif>
		
	</cfif>
	
	<cfset newrec = -1 >	
	<cfset variables.ID="">
	<cfset variables.Dealer_ID="#url.dealer_id#">
	<cfset variables.name="">
	<cfset variables.page_type="#url.page_type#">
	<cfset variables.Make="">
	<cfset variables.image="">
	<cfset variables.link="">
	<cfset variables.target="">
	<cfset variables.hierarchy="">
	<cfset variables.active="1">
	
	<cfquery datasource="Ultra10" name="qryLast_seq">SELECT A.hierarchy FROM	Nav_Block_4 A where dealer_id = #url.dealer_id# and page_type = #url.page_type# ORDER BY A.hierarchy DESC</cfquery>
	<cfif #qryLast_seq.hierarchy# EQ "">
		<cfset variables.hierarchy= +1>
	<cfelse>	
		<cfset variables.hierarchy= #qryLast_seq.hierarchy#+1>
	</cfif>

	<cfif IsDefined("URL.code") >	
		<cfquery name="get_code" datasource="Ultra10" dbtype="ODBC">
			SELECT       ID, dealer_id, name, image, link, active, create_ts, target, hierarchy,page_type,make
			FROM         Nav_Block_4
			WHERE	ID	=	#URL.code#
		</cfquery>
		<cfset newrec = 0 >	
		<cfset variables.ID="#get_code.ID#">
		<cfset variables.Dealer_ID="#get_code.dealer_id#">
		<cfset variables.name="#get_code.name#">
		<cfset variables.page_type="#get_code.page_type#">
		<cfset variables.Make="#get_code.Make#">
		<cfset variables.image="#get_code.image#">
		<cfset variables.link="#get_code.link#">
		<cfset variables.target="#get_code.target#">
		<cfset variables.hierarchy="#get_code.hierarchy#">
		<cfset variables.active="#get_code.active#">
	</cfif>	
	<body>
	<div class="sixty-width" align="center">
		
		<div class="page-title" align="center">
			#G_DEALER_NAME#
		</div>	
		<p></p>
		<div class="page-sub-title-blk" align="center">
			#page_title#
		</div>	
		<p><input 	type="button" class="TabButton" value="Exit" onClick="javascript:self.location='var_menu.cfm?dealer_id=#url.dealer_id#';"></p>
		<div class="half-width" align="center">	
			<div class="div-col-big" align="center">
		  		<input 	type="button" class="TabButton" value="Add Another" onClick="javascript:self.location='var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=1&page_type=#url.page_type#';">	&nbsp;&nbsp;
				<input 	type="button" class="TabButton" value="List" onClick="javascript:self.location='var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=0&page_type=#url.page_type#';">
			</div>
		</div>
	
		<p>
		<table 	width="60%" align="center" border="0" cellpadding="4" cellspacing="0">
			<tr> 
		    	<td align="center" valign="TOP">
					<table 	border="0" width="100%" align="left" cellpadding="3" cellspacing="0">
					<CFFORM action="var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=1&page_type=#url.page_type#" method="post" name="form_name" >
						
						<tr><td align="left" >
								<input 	type="submit" name="Submit" class="TabButton" value="Save">
							</td>
							<td align="right" >
								<cfif IsDefined("url.chg") ><font style="font-size: 8pt ; font-weight: bold ; color:red">Changes Saved<cfelseif IsDefined("url.svd") ><font style="font-size: 8pt ; font-weight: bold ; color:red">Record Added<cfelse>&nbsp;</cfif>	
							</td>
						</tr><cfif #newrec# EQ -1 >
							<input type="hidden" name="code" value="">
						<cfelse>
							<input type="hidden" name="code" value="#variables.ID#">	
						</cfif>
						<input type="hidden" name="Dealer_ID" value="#variables.Dealer_ID#">
						<input type="hidden" name="Delete" value="">
						<input type="hidden" name="del_id" value="">
						<input type="hidden" name="active" value="#variables.active#">
						<input type="hidden" name="newrec" value="#newrec#">
						<input type="hidden" name="page_type" value="#url.page_type#">
						<tr><td height="14"></td></tr>
						<tr>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								Icon
							</td>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								<select tabindex="1" name="image" >
									<option value=""></option>
									<cfloop query="file_db">
										<option value="#file_db.name#" <cfif #file_db.name# EQ #variables.image# >selected</cfif>>#file_db.name#&nbsp;&nbsp;</option>
									</cfloop>
								</select>
								<cfif #variables.image# NEQ "" >
									&nbsp;&nbsp;&nbsp;<input type="button" class="ButtonMicroMini"value="Preview" onClick="window.open('staff_img_preview.cfm?scrn_name=#variables.previewpath#/#variables.image#','','location=no,toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width=800,height=600');return false;">
								</cfif>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>	
						<tr>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								Name
							</td>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								<input  tabindex="2" 	TYPE="Text" NAME="name" value="#variables.name#" Size="60" Maxlength="100" required >
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>	
						<tr>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								Link
							</td>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								<textarea  tabindex="3" name="link" cols="60" rows="4">#variables.link#</textarea>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>	
						<tr>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								Target
							</td>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								<input 	TYPE="Text" NAME="target" value="#variables.target#" Size="15" Maxlength="15" >
								<br><span style="font-size:8pt;color:red">Leave blank for direct link, type NEW for new window</span>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>	
						<tr>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								Make
							</td>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								<input  tabindex="7" 	TYPE="Text" NAME="Make" value="#variables.make#" placeholder="Optional" Size="30" Maxlength="50"  >
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>	
						<tr>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								Hierarchy
							</td>
							<td align="left" style="font-size: 10pt ; font-weight: bold ; color:black">
								<input 	TYPE="Text" NAME="Hierarchy" value="#variables.Hierarchy#" Size="5" Maxlength="5" >
							</td>
						</tr>
						
						<tr>
							<td align="left">
								<cfif #newrec# EQ -1 >
									&nbsp;
								<cfelse>
									<input 	type="submit"  name="delete"  tabindex="9" class="TabButton" value="Delete" onClick="confirmThis(#ID#);">
								</cfif>
							</td>
							<cfif #newrec# EQ -1 >
								<td align="center">
									<input 	type="submit" name="Submit" class="TabButton" value="Save">
							<cfelse>
								<td align="right">
									<table 	border="0" width="30%" bordercolor="black" align="left" cellpadding="0" cellspacing="0">	
										<tr>
											<td align="right" valign="TOP">
												<input 	type="submit" name="Submit" class="TabButton" value="Save">
											</td>
										</tr>
									</table>	
								</cfif>	
								</td>
						</tr>
					</cfform>
					<tr><td height="30"></td></tr>
				</table>
				</td>
			</tr>
		</table>		
	</p>	

	</div>
</cfif>
<!--- END ADD / EDIT SECTION --->

<cfif #url.scrn# EQ 0 >

	<cfif IsDefined("url.Delete") >
		<cfquery name="DeleteEvent" datasource="Ultra10">
			Delete From	Nav_Block_4 Where ID = #url.delete#
		</cfquery>
	</cfif>	  

	<!--- LIST SECTION --->
	<cfif IsDefined("form.SubmitSC") >
		<cfloop index="twist" from="1" to="#form.count#">
			<cfquery name="" datasource="Ultra10">
				Update 		Nav_Block_4
				SET			ACTIVE 		= #TRIM(EVALUATE("prod_id_off_#twist#"))#,
							hierarchy = #TRIM(EVALUATE("hierarchy_#twist#"))#
				WHERE		ID 	= #TRIM(EVALUATE("form.id_#twist#"))#
			</cfquery>
		</cfloop>
	</cfif>
	
	<cfquery name="code_type" datasource="Ultra10" dbtype="ODBC">
		SELECT       ID, dealer_id, name, image, link, active, create_ts, target, hierarchy, page_type,make
		FROM         Nav_Block_4
		where dealer_id = #url.dealer_id#
		AND		page_type = #url.page_type#
		order by hierarchy ASC
	</cfquery>
	
	
	<div class="sixty-width" align="center">
		
		<div class="page-title" align="center">
			#G_DEALER_NAME#
		</div>	
		<p></p>
		<div class="page-sub-title-blk" align="center">
			#page_title#
		</div>	
		<p><input 	type="button" class="TabButton" value="Exit" onClick="javascript:self.location='var_menu.cfm?dealer_id=#url.dealer_id#';"></p>
		<div class="half-width" align="center">	
			<div class="div-col-big" align="left">
		  		<input 	type="button" class="TabButton" value="Create" onClick="javascript:self.location='var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=1&page_type=#url.page_type#';">	
				&nbsp;&nbsp;<input 	type="submit" name="Submit" value="Upload Icons" class="TabButton" onClick="javascript:self.location='pcs_ff_img-2.cfm?dir=Icons4&dealer_id=#url.dealer_id#&page_type=#url.page_type#';" > 
			</div>
		</div>
		<p>
			<table 	width="100%" border="1" bordercolor="black"cellpadding="3" cellspacing="0"  align="center">
				<tr bgcolor="lightgrey">
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">&nbsp;</td>
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">Name</td>
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">Image</td>
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">Link</td>
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">Target</td>
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">Hierarchy</td>
					<td align="center" width="10%"  valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">Status</td>
					<td align="center" valign="BOTTOM" style="font-size: 10pt  ; font-weight: bold ; color:black ">&nbsp;</td>
				</tr>
				<form name="dt_user_type" method="post" action="var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=0&page_type=#url.page_type#">
					<input type="Hidden" name="count" value="#code_type.RecordCount#">
					<input type="Hidden" name="domain_table" value="Vulcan_Brand_Links">
					<tr>
						<td align="right" colspan="13"><input type="submit" class="TabButton" name="submitSC" value="Change Status"></td>
					</tr>
					<cfloop query="code_type">	
						<tr>	
							<td align="center" valign="TOP"  width="5%"  style="font-size: 9pt  ; font-weight: bold ; color:blue ">
								<A 	onMouseOver="self.status='Edit';return true;" onMouseOut="self.status='';return true;"href="var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=1&code=#ID#&page_type=#url.page_type#">Edit</a>
								<input 	type="Hidden" name="id_#code_type.currentRow#" value="#ID#">
							</td>	
							<td align="center" valign="TOP" style="font-size: 10pt  ; font-weight: bold ; color:black " >#name#&nbsp;</td>	
							<td align="left" valign="TOP"  style="font-size: 10pt  ; font-weight: bold ; color:black " >#Image#&nbsp;</td>
							<td align="left" valign="TOP"  style="font-size: 10pt  ; font-weight: bold ; color:black " >#link#&nbsp;</td>
							<td align="center" valign="TOP"  style="font-size: 10pt  ; font-weight: bold ; color:black " ><cfif #target# eq "">Direct Link<cfelse>New Window</cfif>&nbsp;</td>
							<td align="center" valign="TOP"  style="font-size: 10pt  ; font-weight: bold ; color:black " >
								<input type="text" name="hierarchy_#code_type.currentRow#" size="3" maxlength="3" value="#hierarchy#">&nbsp;</td>
							<td align="center" valign="TOP" >
								<cfif Active EQ 0>
								 	<cfset active_bgcolor="white">
									<cfset inactive_bgcolor="pink">
								<cfelse>
									<cfset active_bgcolor="lime">
									<cfset inactive_bgcolor="white">
								</cfif>
								<table 	width="100%" border="1" bordercolor="black" cellpadding="3" cellspacing="0" height="10">
									<tr>
										<td><input type="Radio" class="radinput"  name="prod_id_off_#code_type.currentRow#" value="0" <cfif #code_type.Active# EQ 0>checked</cfif>></td>
										<td  bgcolor="#inactive_bgcolor#"><font style="font-size: 7pt  ; font-weight: bold ; color:black " >Inactive</td>
										<td><input type="Radio" class="radinput"  name="prod_id_off_#code_type.currentRow#" value="1" <cfif #code_type.Active# EQ 1>checked</cfif>></td>
										<td  bgcolor="#active_bgcolor#"><font style="font-size: 7pt  ; font-weight: bold ; color:black " >Active</td>
									</tr>
								</table>
							</td>	
							<td align="center" valign="MIDDLE" width="5%"  style="font-size: 9pt  ; font-weight: bold ; color:blue ">
								<A 	onMouseOver="self.status='Delete';return true;" onMouseOut="self.status='';return true;"href="var_manage_lower_cta.cfm?dealer_id=#url.dealer_id#&scrn=0&delete=#ID#&page_type=#url.page_type#">Delete</a>
							</td>	
						</tr>
					</cfloop>
					<tr><td align="right" colspan="13"><input type="submit" class="TabButton" name="SubmitSC" value="Change Status"></td></tr>
				</FORM>
			</table>
		</p>
	
	</div>
	<!--- End of List Screen --->
</cfif>



</cfoutput>

</body>
</html>

