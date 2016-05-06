<cfcomponent>

	<cffunction name="test" description="gets makes" output="Yes" access="public">

		<!---<form id="myForm" name="myForm" action="select_ajax.cfm" method="post">
			<select name="voi_make" id="voi_make">
				<cfinvoke component="/cfcs/vehicles/build_options" method="get_all">
					<cfinvokeargument name="dealer_id" value="91"/>
					<cfinvokeargument name="dsn" value="ultra8"/>
					<cfinvokeargument name="data_field" value="Vehicle_Make"/>
					<cfinvokeargument name="data_table" value="Chrome_Reviews"/>
					<cfinvokeargument name="default_option" value="Choose a Make"/>
				</cfinvoke>
			</select>
			<select name="voi_model" id="voi_model">
			</select>
			<input type="submit" value="search"/>
		</form>--->



		<!---Get Dealers --->
		<cfstoredproc datasource="Ultra10" procedure="Get_Automall_Dealers">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="91" maxlength="3">
			<cfprocresult name="Get_All_Dealers" resultset="1">
		</cfstoredproc>

		<div class="row">
			<div class="col-md-12">
				<cfparam name="url.first_name" default="">
				<cfparam name="url.last_name" default="">
				<cfparam name="url.email" default="">
				<cfparam name="url.phone_1" default="">
				<cfparam name="url.voi_new_used" default="">
				<cfparam name="url.voi_year_min" default="">
				<cfparam name="url.voi_year_max" default="">
				<cfparam name="url.voi_make" default="">
				<cfparam name="url.voi_model" default="">
				<cfparam name="url.voi_odometer" default="">
				<cfparam name="url.voi_price" default="">
				<cfparam name="url.comments" default="">
				<cfparam name="url.timeframe" default="">
				<cfparam name="url.delivery_dealer_id" default="">

				<cfif dateformat(now(),"mm") lt 6>
					<cfif len(trim(url.voi_year_min)) eq 0><cfset url.voi_year_min=dateformat(now(),"yyyy")-1></cfif>
					<cfif len(trim(url.voi_year_max)) eq 0><cfset url.voi_year_max=dateformat(now(),"yyyy")></cfif>
				<cfelse>
					<cfif len(trim(url.voi_year_min)) eq 0><cfset url.voi_year_min=dateformat(now(),"yyyy")></cfif>
					<cfif len(trim(url.voi_year_max)) eq 0><cfset url.voi_year_max=dateformat(now(),"yyyy")+1></cfif>					
				</cfif>

				<form class="form-horizontal" action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="post">
					<fieldset>
						<input type="hidden" name="Automall_ID" value="#arguments.Automall_ID#"/>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<div class="col-md-5"></div>
									<div class="col-md-7" align="center">
										<b>Tell Us About Yourself</b>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="first_name"><em>*</em> First Name</label>
									<div class="col-md-7">
										<input name="first_name" class="form-control input-md" id="first_name" type="text" placeholder="First Name" maxlength="50" value="#url.first_name#" required/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="last_name"><em>*</em> Last Name</label>  
									<div class="col-md-7">
										<input name="last_name" class="form-control input-md" id="last_name" type="text" placeholder="Last Name" maxlength="50" value="#url.last_name#" required/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="email"><em>*</em> Email</label>  
									<div class="col-md-7">
										<input name="email" class="form-control input-md" id="email" type="email" placeholder="Email" maxlength="100" value="#url.email#" required/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="phone"> Phone</label>  
									<div class="col-md-7">
										<input name="phone_1" class="form-control input-md" id="phone_1" type="text" placeholder="Phone" maxlength="10" value="#url.phone_1#" />
										<span class="help-block">Numbers Only - no hypens or parentheses</span>  
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-5"></div>
									<div class="col-md-7" align="center">
										<b>Search Parameters</b>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="timeframe"><em>*</em> Search Timeframe</label>
									<div class="col-md-7">
										<select id="timeframe" name="timeframe" class="form-control input-md" required>
											<option value="">Search Timeframe</option>
											<option value="7" <cfif url.timeframe eq 7>selected</cfif>>1 Week</option>
											<option value="14" <cfif url.timeframe eq 14>selected</cfif>>2 Weeks</option>
											<option value="28" <cfif url.timeframe eq 28>selected</cfif>>4 Weeks</option>
											<option value="56" <cfif url.timeframe eq 56>selected</cfif>>8 Weeks</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-5 control-label visible-md visible-lg" for="delivery_dealer_id"><em>*</em> Select A Dealer</label>
									<div class="col-md-7">
										<select id="delivery_dealer_id" name="delivery_dealer_id" class="form-control input-md" required>
											<option value="">Select A Dealer</option>
											<cfloop query="Get_All_Dealers">
												<option value="#Get_All_Dealers.Dealer_ID#" <cfif Get_All_Dealers.Dealer_ID eq url.delivery_dealer_id>selected</cfif>>#Get_All_Dealers.Display_Name#</option>
											</cfloop>
										</select>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<div class="col-md-3"></div>
									<div class="col-md-7" align="center">
										<b>Tell Us About Your Vehicle of Interest</b>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="voi_year"><em>*</em> Condition</label>
									<div class="col-md-7">
										<select id="voi_new_used" name="voi_new_used" class="form-control input-md" required>
											<option value="N" <cfif url.voi_new_used eq "N">selected</cfif>>New</option>
											<option value="U" <cfif url.voi_new_used eq "U">selected</cfif>>Pre-Owned</option>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_year_min"><em>*</em> Year Range</label>
									<div class="col-md-3">
										<select id="voi_year_min" name="voi_year_min" class="form-control input-md" required>
											<option value="">Oldest</option>
											<cfloop from="#dateformat(now(),'yyyy')#" to="#dateformat(now(),'yyyy')-20#" step="-1" index="min_year">
												<option value="#variables.min_year#" <cfif url.voi_year_min eq variables.min_year>selected</cfif>>#variables.min_year#</option>
											</cfloop>
										</select>
										<div class="form-pad visible-sm visible-xs"></div>
									</div>
									<div class="col-md-1 visible-md visible-lg" align="center">
										<label class="control-label">to</label>
									</div>
									<div class="col-md-3">
										<select id="voi_year_max" name="voi_year_max" class="form-control input-md" required>
											<option value="">Newest</option>
											<cfloop from="#dateformat(now(),'yyyy')+1#" to="#dateformat(now(),'yyyy')-20#" step="-1" index="max_year">
												<option value="#variables.max_year#" <cfif url.voi_year_max eq variables.max_year>selected</cfif>>#variables.max_year#</option>
											</cfloop>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_make"><em>*</em> Make</label>
									<div class="col-md-7">
										<select name="voi_make" id="voi_make" class="form-control input-md">
											<cfinvoke component="/cfcs/vehicles/build_options" method="get_all">
												<cfinvokeargument name="dealer_id" value="91"/>
												<cfinvokeargument name="dsn" value="ultra8"/>
												<cfinvokeargument name="data_field" value="Vehicle_Make"/>
												<cfinvokeargument name="data_table" value="Chrome_Reviews"/>
												<cfinvokeargument name="default_option" value="Choose a Make"/>
											</cfinvoke>
										</select>
										<!---<input name="voi_make" class="form-control input-md" id="voi_make" type="text" placeholder="Make" maxlength="50" value="#url.voi_make#" required/>--->
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_model"><em>*</em> Model</label>
									<div class="col-md-7">
										<select name="voi_model" id="voi_model" class="form-control input-md">
										</select>
										<!---<input name="voi_model" class="form-control input-md" id="voi_model" type="text" placeholder="Model" maxlength="50" value="#url.voi_model#" required/>--->
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_odometer"> Mileage</label>
									<div class="col-md-7">
										<select id="voi_odometer" name="voi_odometer" class="form-control input-md">
											<option value="">Mileage</option>
											<option value="1" <cfif url.voi_odometer eq "1">selected</cfif>>Under 10,000</option>
											<option value="2" <cfif url.voi_odometer eq "2">selected</cfif>>10,000 - 20,000</option>
											<option value="3" <cfif url.voi_odometer eq "3">selected</cfif>>20,000 - 30,000</option>
											<option value="4" <cfif url.voi_odometer eq "4">selected</cfif>>30,000 - 50,000</option>
											<option value="5" <cfif url.voi_odometer eq "5">selected</cfif>>Over 50,000</option>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="voi_price"> Price Range</label>
									<div class="col-md-7">
										<select id="voi_price" name="voi_price" class="form-control input-md">
											<option value="">Price Range</option>
											<option value="1" <cfif url.voi_price eq "1">selected</cfif>>Under $10,000</option>
											<option value="2" <cfif url.voi_price eq "2">selected</cfif>>$10,000 - $20,000</option>
											<option value="3" <cfif url.voi_price eq "3">selected</cfif>>$20,000 - $30,000</option>
											<option value="4" <cfif url.voi_price eq "4">selected</cfif>>$30,000 - $50,000</option>
											<option value="4" <cfif url.voi_price eq "5">selected</cfif>>$50,000 - $75,000</option>
											<option value="5" <cfif url.voi_price eq "6">selected</cfif>>Over $75,000</option>
										</select>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label visible-md visible-lg" for="comments">Comments</label>
									<div class="col-md-7">                     
										<textarea name="comments" class="form-control" id="comments" maxlength="1000" placeholder="Comments">#url.comments#</textarea>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>
								<div class="control-group">
									<label class="col-md-3 control-label" for="reset"></label>
									<div class="col-md-7" align="center">
										<input type="reset" class="btn btn-default" id="reset" value="Reset"/>
										<input type="submit" class="btn btn-primary" id="submit" value="Find My Car"/>
									</div>
									<div class="col-md-2 visible-md visible-lg"></div>
								</div>								
							</div>
						</div>

					</fieldset>
				</form>
			</div>
		</div>




<script>
$(function() {

	var $voi_make = $('##voi_make')
	var $voi_model = $('##voi_model')

	$voi_model.load('../sandbox/models_new.cfm?make=');
	
	$voi_make.change(function(){

		var makeName = $voi_make.val();

		$voi_model.load('../sandbox/models_new.cfm?make=' + makeName);
		
	});

});
</script>

	</cffunction>

</cfcomponent>