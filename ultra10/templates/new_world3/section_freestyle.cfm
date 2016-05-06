<cfoutput>

<cfquery name="get_content" datasource="Ultra10">
	SELECT 	ID, dealer_id, page_title, page_css, page_content, hierarchy, active,last_upd,create_dt
	FROM   	Variable_Freestyle_Pages
	WHERE 	dealer_id=#url.dealer_id# 
	AND 	active=1
	ORDER BY hierarchy ASC
</cfquery>

<!--- Free-Style Page --->  
	
		<section class="section-page-freestyle">
			<div class="container pad-top-10">
				<cfloop query="get_content" >
					#get_content.page_css#
					#get_content.page_content#
				</cfloop>
			</div>	
			<div class="clearfix"></div>
		</section>


</cfoutput>