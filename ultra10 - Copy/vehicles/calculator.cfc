<cfcomponent>

	<cffunction name="modal" description="payment calculator within a modal popup" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="price" default="">

		<cfswitch expression="#arguments.automall_id#">
			<cfdefaultcase><cfset variables.my_rate="6.9"></cfdefaultcase>
		</cfswitch>

		<script src="http://#cgi.server_name#/js/calculator_monthly.js"></script>
		
		<div class="modal fade" id="calcModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Payment Calculator</h4>
						</div>
						<div class="modal-body">
							<form method="post" action="" name="calc">
								<div class="row">
									<div class="col-md-6 calc-pad visible-md visible-lg" align="right">
										Vehicle Price&nbsp;:&nbsp;
									</div>
									<div class="col-md-6 calc-pad">
										<span class="visible-sm visible-xs">Vehicle Price&nbsp;:&nbsp;</span>
										<input type="text" class="calc-input" name="price" maxlength="10" value="#arguments.price#" onChange="validateInput(this,calc)"  <cfif len(trim(arguments.price)) neq 0>onfocus="validateInput(this,calc)"</cfif>/>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 calc-pad visible-md visible-lg" align="right">
										Interest Rate&nbsp;:&nbsp;
									</div>
									<div class="col-md-6 calc-pad">
										<span class="visible-sm visible-xs">Interest Rate&nbsp;:&nbsp;</span>
										<input type="text" class="calc-input" name="rate" maxlength="5" size="5" onChange="validateInput(this,calc)" value="#variables.my_rate#"/>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 calc-pad visible-md visible-lg" align="right">
										Trade in Value or Cash Down&nbsp;:&nbsp;
									</div>
									<div class="col-md-6 calc-pad">										
										<span class="visible-sm visible-xs">Trade in Value or Cash Down&nbsp;:&nbsp;</span>
										<input type="text" class="calc-input" name="down_payment" maxlength="10" size="10" value="0" onChange="validateInput(this,calc)"/>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 calc-pad" align="center">
										<button type="button" class="calc-input" class="btn btn-primary btn-lg" onclick="doCalculate()">Calculate Monthly Payment</button>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 calc-pad" align="center">
										36 Months : <input class="calc-input" type="text" name="out_36" size="10" maxlength="10"/>
									</div>
									<div class="col-md-6 calc-pad" align="center">
										48 Months : <input class="calc-input" type="text" name="out_48" size="10" maxlength="10"/>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 calc-pad" align="center">
										60 Months : <input class="calc-input" type="text" name="out_60" size="10" maxlength="10"/>
									</div>
									<div class="col-md-6 calc-pad" align="center">
										72 Months : <input class="calc-input" type="text" name="out_72" size="10" maxlength="10"/>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 calc-pad" align="center">
										<em>*</em> These calculations and prices do not include applicable sales tax, license plate fees, registration fees, doc fees or notary fees.
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</cffunction>

	<cffunction name="vdp" description="payment calculator within a vdp" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="Calc_Price" default="">
		
		<cfif arguments.Calc_Price eq "10000000">
			<cfset arguments.Calc_Price=0>
		</cfif>

		<cfswitch expression="#arguments.dealer_id#">
			<cfdefaultcase><cfset variables.my_rate="6.9"></cfdefaultcase>
		</cfswitch>
	
		<div class="row">
			<div class="col-md-2 vdp-pad-10">
				<b>Vehicle Price&nbsp;:&nbsp;</b>
			</div>
			<div class="col-md-4 vdp-pad-10">
				<input class="vdp-calc-input" name="price" id="price" type="text" value="#arguments.Calc_Price#" maxlength="6" onblur="$('##calcBtn').click();" />
			</div>
			<div class="col-md-2 vdp-pad-10">
				<b>Cash or Trade&nbsp;:&nbsp;</b>
			</div>
			<div class="col-md-4 vdp-pad-10">
				<input class="vdp-calc-input" name="down_payment" id="down_payment" type="text" value="0" maxlength="5" onblur="$('##calcBtn').click();" />
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 vdp-pad-10">
				<b>Interest Rate&nbsp;:&nbsp;</b>
			</div>
			<div class="col-md-4 vdp-pad-10">
				<input class="vdp-calc-input" name="int_rate" id="int_rate" type="text" value="#variables.my_rate#" maxlength="3" onblur="$('##calcBtn').click();" />%
			</div>
			<div class="col-md-2 vdp-pad-10">
				<b>Monthly Term&nbsp;:&nbsp;</b>
			</div>
			<div class="col-md-4 vdp-pad-10">
				<select class="vdp-calc-input" name="term" id="term" onchange="$('##calcBtn').click();">
					<option value="">Select</option>
					<option value="36">36 Months</option>
					<option value="48">48 Months</option>
					<option value="60">60 Months</option>
					<option value="72" selected>72 Months</option>
					<option value="84">84 Months</option>
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 vdp-pad-10" align="center">
				<button type="button" id="calcBtn" name="calcBtn" class="btn btn-primary">CALCULATE PAYMENT</button>
			</div>
			<div class="col-md-6 vdp-pad-10" align="center">
				<div class="vdp-payment-cell"><div class="vdp-calc-payment" id="monthly_amt">&nbsp;</div>per month<em>*</em></div>
			</div>
		</div>

		<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script src="http://#cgi.server_name#/js/jquery.numeric.js"></script>'>
		<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/js/calculator_front.js?<cfoutput>#now()#</cfoutput>"></script>'>
		<cfif arguments.Calc_Price gt 0>
			<cfset url.Dom_Functions= url.Dom_Functions & "$('##calcBtn').click();">
		</cfif>
		
	</cffunction>
	
</cfcomponent>