<cfoutput>

		<cfquery datasource="Ultra10" name="scrn_title">
			SELECT		Dealer_ID,
						Nav_Type_ID,
						Nav_Name
			FROM		navigation_var
			WHERE		dealer_id = #url.dealer_id#
			AND			nav_type_id = #ss_type#
			AND			var_page_nbr = #pg_nbr#
			<cfif #pg_nbr# eq 4 >
				AND	Nav_Name like '%#url.v_make#'
			</cfif>
		</cfquery>
	<cfif #scrn_title.recordcount# NEQ 0 >
		<section class="section-scrn-title">
			<div class="container">
				<div class="row no-pad">
					<div class="col-md-12 visible-sm visible-xs visible-lg visible-md">
						<div class="scr-title"><h1 class="site-h1"  >#scrn_title.Nav_Name#</h1></div>
					</div>
				</div>	
			</div>	
		</section>		
	</cfif>


</cfoutput>