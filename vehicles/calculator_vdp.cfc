<cfcomponent>

	<cffunction name="vdp_new" description="payment calculator within a NEW vdp" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="Calc_Price" default="">
		
		
	<!--- Check for Custom Pricing Color  --->
		<cfset variables.cust_btns = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns,dflt_rate  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		
		
		<cfquery datasource="ultra10" name="Get_color">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 5
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_btns = #Get_color.recordcount# >
	<!--- Check for Custom Pricing Color--->
		
		
		<cfif arguments.Calc_Price eq "10000000">
			<cfset arguments.Calc_Price=0>
		</cfif>

		
		
		
		<cfswitch expression="#arguments.dealer_id#">
			<cfdefaultcase><cfset variables.my_rate="6.9"></cfdefaultcase>
		</cfswitch>
		
		
		<cfif #url.dealer_id# NEQ 257>
			<cfset variables.my_rate="6.9">
		<cfelse>
			<cfset variables.my_rate="3.99">	
		</cfif>
	
		<cfif #url.dealer_id# EQ 12 >
			<cfset variables.my_rate="3.72">	
		</cfif>	
		<cfif #Chk_Srch.dflt_rate# NEQ 0  AND #Chk_Srch.dflt_rate# NEQ ""  >
			<cfset variables.my_rate="#Chk_Srch.dflt_rate#">	
		</cfif>	
		
		<div class="row">
			<div class="col-md-5 vdp-pad-5">
				<b>Vehicle Price:</b>
			</div>
			<div class="col-md-7 vdp-pad-10">
				<input class="vdp-calc-input" name="price" id="price" type="text" value="#arguments.Calc_Price#" maxlength="6" onblur="$('##calcBtn').click();" />
			</div>
		</div>
		<div class="row">
			<div class="col-md-5 vdp-pad-5">
				<b>Interest Rate:</b>
			</div>
			<div class="col-md-7 vdp-pad-10">
				<input class="vdp-calc-input" name="int_rate" id="int_rate" type="text" value="#variables.my_rate#" size="6" maxlength="3" onblur="$('##calcBtn').click();" />%
			</div>
		</div>
		<div class="row">
			<div class="col-md-5 vdp-pad-10">
				<b>Cash or Trade:</b>
			</div>
			<div class="col-md-7 vdp-pad-10">
				<input class="vdp-calc-input" name="down_payment" id="down_payment" type="text" value="" maxlength="5" onblur="$('##calcBtn').click();" />
			</div>
		</div>
		<div class="row">
			<div class="col-md-5 vdp-pad-10">
				<b>Monthly Term:</b>
			</div>
			<div class="col-md-7 vdp-pad-10">
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
			<div class="col-md-12 vdp-pad-10" align="center">
				<cfif #variables.nbr_btns# GT 0 >
					<button type="button" id="calcBtn" name="calcBtn" class="btn calulator-btn-cust">#Get_color.Btn_Title#</button>
				<cfelse>
					<button type="button" id="calcBtn" name="calcBtn" class="btn btn-calculator">Calculate Payment</button>
				</cfif>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 vdp-pad-10" align="right">
				<div class="youpay">You'd Pay:</div>
			</div>
			<div class="col-md-6 vdp-pad-10" align="left">
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