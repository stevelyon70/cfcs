<!--- var_manager_slideshow.cfm --->

<cfparam name="url.page_action" default="">
<cfparam name="url.Dealer_ID" default="0">
<cfparam name="url.Nav_Type_ID" default="3">
<cfset variables.Nav_Type_ID=url.Nav_Type_ID>
<cfset variables.Site_ID=url.Dealer_ID>
<cfset variables.DSN="Ultra10">
<cfset variables.Site_ID_Name="Dealer_ID">
<cfset variables.Table_Name="Navigation_Var">

<cfoutput>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<head>
<link href="css/admin-style.css" type="text/css" rel="stylesheet"/>
</head> 

<cfquery datasource="Ultra10" name="Get_Dealer">
	SELECT     	Dealer_Directory,city,state,display_name,Dealercode FROM Dealers WHERE Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#variables.Site_ID#" maxlength="6">
</cfquery>
<cfset G_DEALER_DIRECTORY = "#Get_Dealer.Dealer_Directory#" ><cfset G_DEALER_NAME = "#Get_Dealer.display_name#" >

 
<div class="sixty-width" align="center">

		<div class="page-title" align="center">
			#G_DEALER_NAME#
		</div>	
		<p></p>
		<div class="page-sub-title-blk" align="center">
			<cfif #variables.Nav_Type_ID# EQ 58 >
				<cfset page_nbr = 2 >
				Special Offers Page Slideshow Manager
			<cfelseif #variables.Nav_Type_ID# EQ 3 >
				<cfset page_nbr = 0 >
				Splash Page Slideshow Manager
			<cfelseif #variables.Nav_Type_ID# EQ 59 >
				<cfset page_nbr = 3 >
				Finance Page Slideshow Manager
			<cfelseif #variables.Nav_Type_ID# EQ 60 >
				<cfset page_nbr = 4 >
				Showroom Page Slideshow Manager 
			<cfelseif #variables.Nav_Type_ID# EQ 61 >
				<cfset page_nbr = 1 >
				Service Page Slideshow Manager 
			<cfelseif #variables.Nav_Type_ID# EQ 62 >
				<cfset page_nbr = 5 >
				Careers Page Slideshow Manager 
			<cfelseif #variables.Nav_Type_ID# EQ 63 >
				<cfset page_nbr = 6 >
				Community Page Slideshow Manager 
			<cfelseif #variables.Nav_Type_ID# EQ 64 >
				<cfset page_nbr = 7 >
				Community Page Slideshow Manager 
			<cfelseif #variables.Nav_Type_ID# EQ 65 >
				<cfset page_nbr = 8 >
				Collision Page Slideshow Manager 
			<cfelseif #variables.Nav_Type_ID# EQ 66 >
				<cfset page_nbr = 9 >
				Parts Page Slideshow Manager 
			</cfif>
		</div>	
		<div class="page-sub-title-blk" align="center">
			Note: Nav Name will be the Screen Title
		</div>
		<p></p>
		
		<p><input type="button" class="Tabbutton"  value="Exit" onClick="javascript:self.location='var_menu.cfm?dealer_id=#url.dealer_id#';"/></p>


<cfswitch expression="#url.page_action#">

	<cfdefaultcase>
		

		<!---Get Nav--->
		<cfstoredproc datasource="#variables.DSN#" procedure="Get_Var_Nav">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#variables.Site_ID_Name#" value="#variables.Site_ID#" maxlength="3">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@nav_type_id" value="#variables.Nav_Type_ID#" maxlength="3">
			<cfprocresult name="Get_Nav" resultset="1">
		</cfstoredproc>

		<cfstoredproc datasource="#variables.DSN#" procedure="Get_Dealer_Info">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="#variables.Site_ID_Name#" value="#variables.Site_ID#" maxlength="4">
			<cfprocresult name="Get_Dealer_Info" resultset="1">
		</cfstoredproc>
		
		<cfinvoke component="/cfcs/admin/var_nav_mng" method="cache_nav">
			<cfinvokeargument name="DSN" value="#variables.DSN#"/>
			<cfinvokeargument name="Site_ID" value="#variables.Site_ID#"/>
			<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="Dealer_Directory" value="#Get_Dealer_Info.Dealer_Directory#"/>
		</cfinvoke>		

		<cfinvoke component="/cfcs/admin/var_nav_mng" method="get_nav">
			<cfinvokeargument name="DSN" value="#variables.DSN#"/>
			<cfinvokeargument name="Site_ID_Name" value="#variables.Site_ID_Name#"/>
			<cfinvokeargument name="Site_ID" value="#variables.Site_ID#"/>
			<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="image_mode" value="on"/>
		</cfinvoke>
	
	</cfdefaultcase>

	<cfcase value="bulk_update">

		<cfparam name="form.Nav_ID" default="">
	
		<cfif len(trim(form.Nav_ID)) gt 0>
			<cfinvoke component="/cfcs/admin/var_nav_mng" method="bulk_update">
				<cfinvokeargument name="DSN" value="#variables.DSN#"/>
				<cfinvokeargument name="Table_Name" value="#variables.Table_Name#"/>
				<cfinvokeargument name="Site_ID" value="#variables.Site_ID#"/>
				<cfinvokeargument name="Site_ID_Name" value="#variables.Site_ID_Name#"/>
				<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			</cfinvoke>
		</cfif>

		<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?dealer_id=#form.site_id#&Nav_Type_ID=#url.Nav_Type_ID#">
	
	</cfcase>

	
	<cfcase value="edit_nav">

		<cfparam name="url.nav_id" default="0">
		
		
		<cfquery datasource="#variables.DSN#" name="Get_Nav">
			SELECT		Nav_ID,
						Dealer_ID,
						Nav_Type_ID,
						Nav_Behaviour_ID,
						Nav_Name,
						Nav_Alt,
						Nav_Link,
						Nav_Mobile_Link,
						Nav_Image,
						Nav_Rollover,
						Phone_ID,NAV_IMAGE_CODE ,align,var_page_nbr,
						Display_Mode,snippet,pull,text_color,FONT_WEIGHT ,FONT_SIZE ,MARGIN_TOP ,MARGIN_BOTTOM,MARGIN_LEFT ,MARGIN_right,PARENT_NAV_ID ,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		#variables.Table_Name#
			WHERE		Nav_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Nav_ID#" maxlength="10">
		</cfquery>

		<cfquery datasource="#variables.DSN#" name="Get_Dir">
			SELECT     	Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Get_Nav.Dealer_ID#" maxlength="10">
		</cfquery>
		<!--- <cfset url.dealer_id=#url.dealer_id# > --->
		<cfinvoke component="/cfcs/admin/var_nav_mng" method="edit_nav">
			<cfinvokeargument name="DSN" value="#variables.DSN#"/>
			<cfinvokeargument name="Site_ID" value="#Get_Nav.Dealer_ID#"/>
			<cfinvokeargument name="Site_ID_Name" value="#variables.Site_ID_Name#"/>
			<cfinvokeargument name="Template_ID" value="#Get_Dir.Dealer_Directory#"/>
			<cfinvokeargument name="Nav_Type_ID" value="#Get_Nav.Nav_Type_ID#"/>
			<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
			<cfinvokeargument name="image_mode" value="on"/>
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
		</cfinvoke>	
	
	</cfcase>
	
	<cfcase value="update_nav">

		<cfquery datasource="#variables.DSN#" name="Get_Dir">
			SELECT     	Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.Site_ID#" maxlength="10">
		</cfquery>

		<cfinvoke component="/cfcs/admin/var_nav_mng" method="update_nav">
			<cfinvokeargument name="DSN" value="#variables.DSN#"/>
			<cfinvokeargument name="Table_Name" value="#variables.Table_Name#"/>
			<cfinvokeargument name="Site_ID" value="#variables.Site_ID#"/>
			<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			<cfinvokeargument name="Save_Directory" value="E:\inetpub\wwwroot\Ultra10\dealer\#Get_Dir.Dealer_Directory#\images\slideshow"/>
			<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
		</cfinvoke>

		<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_nav&Nav_ID=#form.Nav_ID#">

	</cfcase>

	<cfcase value="delete_img">

		<cfquery datasource="#variables.DSN#" name="Get_Dir">
			SELECT     	Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Site_ID#" maxlength="10">
		</cfquery>

		<cfinvoke component="/cfcs/admin/var_nav_mng" method="delete_img">
			<cfinvokeargument name="DSN" value="#variables.DSN#"/>
			<cfinvokeargument name="Table_Name" value="#variables.Table_Name#"/>
			<cfinvokeargument name="Save_Directory" value="E:\inetpub\wwwroot\Ultra10\dealer\#Get_Dir.Dealer_Directory#\images\slideshow"/>
			<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
		</cfinvoke>

		<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_nav&Nav_ID=#url.Nav_ID#&Nav_Type_ID=#url.Nav_Type_ID#">

	</cfcase>

	<cfcase value="delete_roll">

		<cfquery datasource="#variables.DSN#" name="Get_Dir">
			SELECT     	Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Site_ID#" maxlength="10">
		</cfquery>

		<cfinvoke component="/cfcs/admin/var_nav_mng" method="delete_roll">
			<cfinvokeargument name="DSN" value="#variables.DSN#"/>
			<cfinvokeargument name="Table_Name" value="#variables.Table_Name#"/>
			<cfinvokeargument name="Save_Directory" value="E:\inetpub\wwwroot\Ultra10\dealer\#Get_Dir.Dealer_Directory#\images\slideshow"/>
			<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
		</cfinvoke>

		<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=edit_nav&Nav_ID=#url.Nav_ID#&Nav_Type_ID=#url.Nav_Type_ID#">

	</cfcase>

	
	<cfcase value="add_nav">

		<cfparam name="form.Nav_Name" default="">
	
		<cfif len(trim(form.Nav_Name)) gt 0>
			<cfinvoke component="/cfcs/admin/var_nav_mng" method="add_nav">
				<cfinvokeargument name="DSN" value="#variables.DSN#"/>
				<cfinvokeargument name="Table_Name" value="Navigation_Var"/>
				<cfinvokeargument name="Site_ID" value="#form.Site_ID#"/>
				<cfinvokeargument name="Site_ID_Name" value="#variables.Site_ID_Name#"/>
				<cfinvokeargument name="Nav_Type_ID" value="#variables.Nav_Type_ID#"/>
				<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
				<cfinvokeargument name="pg_nbr" value="#page_nbr#"/>
			</cfinvoke>
		</cfif>
		
		<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?dealer_id=#form.site_id#&Nav_Type_ID=#url.Nav_Type_ID#">
	
	</cfcase>

</cfswitch>
</div>
</cfoutput>