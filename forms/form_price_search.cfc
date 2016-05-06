<cfcomponent>

	
	<cffunction name="price_srch" description="Price Search open form" output="yes" access="public">

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
										<cfif #arguments.dealer_id# eq 84>
											<select  class="spl-search-input" name="voi_new_used" id="voi_new_used">
												<option value="N" <cfif arguments.voi_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
												<option value="U" <cfif arguments.voi_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
												<option value="C" <cfif arguments.voi_new_used eq "c">selected="selected"</cfif>>Certified Vehicles</option>
											</select><br/>
										<cfelse>									
											<input name="voi_new_used"   id="voi_new_used" type="radio" checked="checked" value="N">
											<span style="font-size:11pt">New</span>
											&nbsp;&nbsp;
											<input name="voi_new_used"   id="voi_new_used1" type="radio" value="U">
											<span style="font-size:11pt">Used</span>
											&nbsp;&nbsp;
											<input name="voi_new_used"   id="voi_new_used2" type="radio" value="C">
											<span style="font-size:11pt">Certified</span>
										</cfif>
									</div>	
								</div>	
							</div>
						</div>
					</cfif>
					<div class="form-group  qq-input">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-6">
									<input  class="form-control" id="Min_Price" name="Min_Price" type="text" <!--- placeholder="Minimum Price*" ---> size="10" maxlength="10" required >
									<p class="help-block">&nbsp;&nbsp;Minimum Price*</p>
								</div>	
								<div class="col-md-6">
									<input  class="form-control" id="Max_Price" name="Max_Price" type="text" <!--- placeholder="Maximum Price*" ---> size="10" maxlength="10" required >
									<p class="help-block">&nbsp;&nbsp;Maximum Price*</p>
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