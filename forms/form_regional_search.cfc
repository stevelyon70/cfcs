<cfcomponent>

	
	<cffunction name="regional_srch" description="Rgional open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="price_search">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?form_action=form_submit">
		<cfargument name="voi_new_used" default="">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
			
			
		<form class="form-horizontal no-pad" action="#arguments.form_action#" id="#arguments.form_name#" name="#arguments.form_name#" method="post">
				<fieldset>
					<input name="dealer_id" id="dealer_id" type="hidden"  value="#arguments.dealer_id#"/>
					<cfif #arguments.voi_new_used# EQ 2 >
						<input name="voi_new_used" id="voi_new_used" type="hidden"  value="N"/>
					<cfelseif #arguments.voi_new_used# EQ 3 >
						<input name="voi_new_used" id="voi_new_used" type="hidden"  value="U"/>	
					<cfelse>	
						<div class="form-group  qq-input">
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-12 " align="center">
										<input name="voi_new_used"   id="voi_new_used" type="radio" checked="checked" value="N">
										<span style="font-size:10pt">New</span>
										&nbsp;&nbsp;&nbsp;
										<input name="voi_new_used"   id="voi_new_used1" type="radio" value="U">
										<span style="font-size:10pt">Used</span>
									</div>	
								</div>	
							</div>
						</div>
					</cfif>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<cfquery datasource="Ultra10" name="Get_Region">
										SELECT	ID, Dealer_ID, Region_text, active
										FROM    Dealer_Regions
										WHERE	Dealer_ID = #url.Dealer_ID#
										AND		active = 1
									</cfquery>
									<select class="spl-search-input" name="search_region" id="search_region">
										<option value="">Choose a Reqion</option>	
									<cfloop query="Get_Region">
										<option value="#Get_Region.ID#">#RTrim(Get_Region.Region_text)#</option>	
									</cfloop>
								</div>	
							</div>	
						</div>
					</div>
					<div class="form-group  qq-input">
						<div class="col-md-1" align="center">
							&nbsp;
						</div>
						<div class="col-md-10" align="center" >
							<input   type="submit"  class="spl-search-btn"  value=" Search Now ">
						</div>
					</div>
				</fieldset>
			</form>
			
	</cffunction>

	
	<cffunction name="form_submit" description="default contact layout" output="yes" access="public">
  	
	</cffunction>

	</cfcomponent>