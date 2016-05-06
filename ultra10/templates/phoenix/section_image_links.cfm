<cfoutput>



<cfquery name="Get_Img_Links" datasource="Ultra10" >
	SELECT     id, dealer_id, column_number, hierarchy, image_name, link_title, link_text, link_destination, link_btn_text, active
	FROM       Variable_Image_Links
	WHERE dealer_id = #url.dealer_id#
	AND			active = 1
	ORDER BY	column_number ASC, hierarchy ASC
</cfquery>

<cfset a_image_name = ArrayNew(2) >
<cfset a_link_title = ArrayNew(2) >
<cfset a_link_text = ArrayNew(2) >
<cfset a_link_destination = ArrayNew(2) >
<cfset a_link_btn_text = ArrayNew(2) >
<cfset x = 0 >
<cfloop query="Get_Img_Links" >
	<cfset x = #Get_Img_Links.column_number# >
	<cfset y = #Get_Img_Links.hierarchy#
	<cfset a_image_name[x][y] = #Get_Img_Links.image_name# >
	<cfset a_link_title[x][y] = #Get_Img_Links.link_title# >
	<cfset a_link_text[x][y] = #Get_Img_Links.link_text# >
	<cfset a_link_destination[x][y] = #Get_Img_Links.link_destination# >
	<cfset a_link_btn_text[x][y] = #Get_Img_Links.link_btn_text# >
</cfloop>

  
<section class="section-img-links">
	<div class="container pad-top-10">
		<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="page-divider"></div></div></div>	
		<div class="row pad-top-10">
			<cfloop index="x" from="1" to="3" >
			<div class="col-md-4" style="align:center" >
				<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
					<cfinvokeargument name="nav_type_id" value="7"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="element_class" value="info-link"/>
					<cfinvokeargument name="bold_top" value="true"/>
				</cfinvoke>
			</div>
			</cfloop>
		</div>    
	</div>
	<div class="clearfix"></div>
</section>

</cfoutput>		
