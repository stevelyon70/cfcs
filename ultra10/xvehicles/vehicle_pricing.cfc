<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp pricing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Selling_Price_Label" default="">
		<cfargument name="Selling_Price" default="">
		<cfargument name="MSRP_Label" default="">
		<cfargument name="MSRP_Price" default="">
		<cfargument name="Rebate_Label" default="">
		<cfargument name="Rebate_Price" default="">
		<cfargument name="Incentive_Label" default="">
		<cfargument name="Incentive_Price" default="">
		<cfargument name="Savings_Label" default="">
		<cfargument name="Savings_Price" default="">
		<cfargument name="AIS_Label" default="">
		<cfargument name="AIS_Price" default="">
		<cfargument name="AIS_APR" default="">

		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<div class="price-call-price-red">Call For Price</div>
		<cfelse>
			<cfif arguments.MSRP_Price gt 0><div class="price-alt"><b>#ucase(arguments.MSRP_Label)#: <span class="pull-right">$#numberformat(arguments.MSRP_Price)#</span></b></div></cfif>
			<cfif arguments.Rebate_Price gt 0><div class="price-alt"><b>#ucase(arguments.Rebate_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Rebate_Price)#</span></b></div></cfif>
			<cfif arguments.Incentive_Price gt 0><div class="price-alt"><b>#ucase(arguments.Incentive_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Incentive_Price)#</span></b></div></cfif>
			<cfif arguments.AIS_Price gt 0><div class="price-alt"><b>#ucase(arguments.AIS_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.AIS_Price)#</span></b></div></cfif>
			<cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
				<div class="price-break"></div>
			</cfif>
			<div class="price-sell-lab">#ucase(arguments.Selling_Price_Label)#:</div>
			<div class="price-sell-price-red">$#numberformat(arguments.Selling_Price)#</div>
			<cfif arguments.Savings_Price gt 0><div class="price-save"><b>#ucase(arguments.Savings_Label)#: <span class="pull-right">$#numberformat(arguments.Savings_Price)#</span></b></div></cfif>
		</cfif>
		<!---arguments.AIS_APR--->

	</cffunction>

</cfcomponent>