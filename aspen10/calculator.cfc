<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">

		<cfparam name="url.price" default="">
		<cfset variables.my_rate="6.9">
	
		<script type="text/javascript" src="http://static.wdautos.com/js/calculator_monthly.js"></script>
		<script type="text/javascript" src="http://static.wdautos.com/js/calculator_reverse.js"></script> 
	
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12 calc-title">
								Monthly Payment Calculator
							</div>
						</div>
						<form method="post" action="" name="calc">
							<div class="row">
								<div class="col-md-12 pad-bot-5" align="center">
									<b>Vehicle Price&nbsp;:&nbsp;</b>
									<input type="text" name="price" id="price" maxlength="10" value="#url.price#" onChange="validateInput(this,calc)"  <cfif len(trim(url.price)) neq 0>onfocus="validateInput(this,calc)"</cfif>>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5" align="center">
									<b><em>*</em> Interest Rate&nbsp;:&nbsp;</b>
									<input type="text" name="rate" maxlength="5" size="5" onChange="validateInput(this,calc)" value="#variables.my_rate#">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5" align="center">
									<b>Trade in Value or Cash Down&nbsp;:&nbsp;</b>
									<input type="text" name="down_payment" maxlength="10" size="10" value="0" onChange="validateInput(this,calc)">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5" align="center">
									<input class="btn btn-primary" type="Button" onclick="doCalculate()" value="Calculate Monthly Payment">
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 pad-bot-5">
									<b>36 Months&nbsp;:&nbsp;</b><input type="text" name="out_36" size="10" maxlength="10">
								</div>
								<div class="col-md-6 pad-bot-5">
									<b>48 Months&nbsp;:&nbsp;</b><input type="text" name="out_48" size="10" maxlength="10">
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 pad-bot-5">
									<b>60 Months&nbsp;:&nbsp;</b><input type="text" name="out_60" size="10" maxlength="10">
								</div>
								<div class="col-md-6 pad-bot-5">
									<b>72 Months&nbsp;:&nbsp;</b><input type="text" name="out_72" size="10" maxlength="10">
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 pad-bot-5 visible-md visible-lg">
									
								</div>
								<div class="col-md-6 pad-bot-5">
									<b>84 Months&nbsp;:&nbsp;</b><input type="text" name="out_84" size="10" maxlength="10">
								</div>
							</div>
						</form>
						<div class="row">
							<div class="col-md-12 calc-disclaimer">
								<span class="txt-red">*</span> These calculations and prices do not include applicable sales tax, license plate fees, registration fees, doc fees or notary fees.
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12 calc-title">
								How Much Are You Able to Finance?
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 pad-bot-5">
								To make calculating your monthly payment easy, we've developed a Payment Calculator that will do the math for you. Simply fill in the first four fields, then click "Calculate" to have the site run the calculation. You will need to complete all of the first four fields to receive the most accurate estimate.<br/><br/> 
								Default Interest and Sales Tax values may not apply to you or your area.<br/>
							</div>
						</div>
						<form name="calculatorform" mehtod="POST" action="JavaScript:paymentEvent()">
							<div class="row">
								<div class="col-md-6 pad-bot-5">
									<b>Desired Monthly Payment&nbsp;:&nbsp;</b>
								</div>
								<div class="col-md-6 pad-bot-5">
									$<INPUT TYPE="text" NAME="desired_monthly_payment" onChange="JavaScript:paymentEvent()">
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 pad-bot-5">
									<b>Interest Rate&nbsp;:&nbsp;</b>
								</div>
								<div class="col-md-6 pad-bot-5">
									&nbsp;&nbsp;<INPUT TYPE="text" NAME="loan_rate" value="0" onChange="JavaScript:paymentEvent()">&nbsp;%
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 pad-bot-5">
									<b>Sales Tax&nbsp;:&nbsp;</b>
								</div>
								<div class="col-md-6 pad-bot-5">
									&nbsp;&nbsp;<INPUT TYPE="text" NAME="sales_tax" value="0" onChange="JavaScript:paymentEvent()">&nbsp;%
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 pad-bot-5">
									<b>Desired Term Length&nbsp;:&nbsp;</b>
								</div>
								<div class="col-md-6 pad-bot-5">
									&nbsp;&nbsp;<INPUT TYPE="text" NAME="desired_term_length" value="48" onChange="JavaScript:paymentEvent()">&nbsp;months
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5" align="center">
									<input class="btn btn-primary" type="submit" value="Calculate">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5" align="center">
									<b>RESULTS</b>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5">
									With a $<INPUT TYPE="text" NAME="desired_monthly_payment_results"> per month payment
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5">
									For <INPUT TYPE="text" NAME="desired_term_length_results"> months,
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 pad-bot-5">
									you can finance $<INPUT TYPE="text" NAME="desired_finance_results">
								</div>
							</div>
						</form>
						<div class="row">
							<div class="col-md-12 calc-disclaimer">
								<span class="txt-red">*</span> These calculations and prices do not include applicable sales tax, license plate fees, registration fees, doc fees or notary fees.
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 calc-disclaimer">
				<span class="txt-red">*</span> Customer finance rates can vary by finance institution, credit score, collateral, and term.<br/>
				<span class="txt-red">*</span> Please note that these calculations are based solely on information provided by you. The dealer is not responsible for pricing and payments derived from these calculators. See dealer for specific pricing and payments.
			</div>
		</div>

		<script>
			var text_input = document.getElementById ('price');
			text_input.focus ();
			text_input.select ();
		</script>
	
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">
		
		<cfparam name="url.price" default="">
		<cfset variables.my_rate="6.9">

		<script type="text/javascript" src="http://static.wdautos.com/js/calculator_monthly.js"></script> 
		<table cellpadding="0" cellspacing="2">
			<form method="post" action="" name="calc">
				<tr>
					<td colspan="2" class="section-title" title="Monthly Payment Calculator">Monthly Payment Calculator</td>
				</tr>
				<tr>
					<td style="padding-top:5px;width:220px;" align="right">Vehicle Price&nbsp;:&nbsp;</td>
					<td style="padding-top:5px;width:220px;"><input class="form-input-calc" type="text" name="price" maxlength="10" value="<cfoutput>#url.price#</cfoutput>" onChange="validateInput(this,calc)"  <cfif len(trim(url.price)) neq 0>onfocus="validateInput(this,calc)"</cfif>></td>
				</tr>
				<tr>
					<td style="width:220px;" align="right"><em>*</em> Interest Rate&nbsp;:&nbsp;</td>
					<td style="width:220px;"><input class="form-input-calc" type="text" name="rate" maxlength="5" size="5" onChange="validateInput(this,calc)" value="<cfoutput>#variables.my_rate#</cfoutput>"></td>
				</tr>
				<tr> 
					<td style="width:220px;" align="right">Trade in Value or Cash Down&nbsp;:&nbsp;</td>
					<td style="width:220px;"><input class="form-input-calc" type="text" name="down_payment" maxlength="10" size="10" value="0" onChange="validateInput(this,calc)"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input class="form-btn-default" type="Button" onclick="doCalculate()" value="Calculate Monthly Payment"></td>
				</tr>
				<tr> 
					<td style="width:220px;" align="center">36 Months&nbsp;:&nbsp;<input class="form-input-calc" type="text" name="out_36" size="10" maxlength="10"></td>
					<td style="width:220px;" align="center">48 Months&nbsp;:&nbsp;<input class="form-input-calc" type="text" name="out_48" size="10" maxlength="10"></td>
				</tr>
				<tr> 
					<td style="width:220px;" align="center">60 Months&nbsp;:&nbsp;<input class="form-input-calc" type="text" name="out_60" size="10" maxlength="10"></td>
					<td style="width:220px;" align="center">72 Months&nbsp;:&nbsp;<input class="form-input-calc" type="text" name="out_72" size="10" maxlength="10"></td>
				</tr>
				<tr> 
					<td colspan="2" align="center">84 Months&nbsp;:&nbsp;<input class="form-input-calc" type="text" name="out_84" size="10" maxlength="10"></td>
				</tr>
			</form>
		</table>
		<div class="calc-disc"><em>*</em> These calculations and prices do not include applicable sales tax, license plate fees, registration fees, doc fees or notary fees.</div>
		<cfif len(trim(url.price)) neq 0><script>document.calc.price.focus()</script></cfif>

		<script type="text/javascript" src="http://static.wdautos.com/js/calculator_reverse.js"></script> 
		<table id="calculator_reverse" cellpadding="0" cellspacing="2">
			<form name="calculatorform" mehtod="POST" action="JavaScript:paymentEvent()">
				<tr>
					<td colspan="2" class="section-title" title="How Much Are You Able To Finance?">How Much Are You Able to Finance?</td>
				</tr>
				<tr>
					<td style="padding-top:5px" colspan="2">
						To make calculating your monthly payment easy, we've developed a Payment Calculator that will do the math for you.
						Simply fill in the first four fields, then click "Calculate" to have the site run the calculation.
						You will need to complete all of the first four fields to receive the most accurate estimate.			
						<br><br>
						Default Interest and Sales Tax values may not apply to you or your area.
						<br><br>
					</td>
				</tr>
				<tr>
					<td align="right">Desired Monthly Payment&nbsp;:&nbsp;</td>
					<td>$<INPUT CLASS="form-input-calc" TYPE="text" NAME="desired_monthly_payment" onChange="JavaScript:paymentEvent()"></td>
				</tr>
				<tr>
					<td align="right">Interest Rate&nbsp;:&nbsp;</td>
					<td>&nbsp;&nbsp;<INPUT CLASS="form-input-calc" TYPE="text" NAME="loan_rate" value="0" onChange="JavaScript:paymentEvent()">&nbsp;%</td>
				</tr>
				<tr>
					<td align="right">Sales Tax&nbsp;:&nbsp;</td>
					<td>&nbsp;&nbsp;<INPUT CLASS="form-input-calc" TYPE="text" NAME="sales_tax" value="0" onChange="JavaScript:paymentEvent()">&nbsp;%</td>
				</tr>
				<tr>
					<td align="right">Desired Term Length&nbsp;:&nbsp;</td>
					<td>&nbsp;&nbsp;<INPUT CLASS="form-input-calc" TYPE="text" NAME="desired_term_length" value="48" onChange="JavaScript:paymentEvent()">&nbsp;months</td>
				</tr>
				<tr>
					<td colspan="2"><INPUT CLASS="form-btn-default" TYPE="submit" value="Calculate"></td>
				</tr>
				<tr>
					<td colspan="2" style="padding:10px;" align="Center">RESULTS</td>
				</tr>
				<tr>
					<td align="right">With a</td>
					<td>&nbsp;$<INPUT CLASS="form-input-calc" TYPE="text" NAME="desired_monthly_payment_results">&nbsp;per month payment</td>
				</tr>
				<tr>
					<td align="right">For</td>
					<td>&nbsp;&nbsp;&nbsp;<INPUT CLASS="form-input-calc" TYPE="text" NAME="desired_term_length_results">&nbsp;months,</td>
				</tr>
				<tr>
					<td align="right">you can finance</td>
					<td>&nbsp;$<INPUT CLASS="form-input-calc" TYPE="text" NAME="desired_finance_results"></td>
				</tr>
			</form>
		</table>
		<div class="calc-disc"><em>*</em> These calculations and prices do not include applicable sales tax, license plate fees, registration fees, doc fees or notary fees.</div>
		
	</cffunction>

</cfcomponent>