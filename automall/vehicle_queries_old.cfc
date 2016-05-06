		<!---<cfswitch expression="#url.sortblock#">
			<cfdefaultcase>
				<!---Get Vehicles - sort Make,Model,Price Desc--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfdefaultcase>
			<cfcase value="2">
				<!---Get Vehicles - sort Price Low to High--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Price_Asc">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
			<cfcase value="3">
				<!---Get Vehicles - sort Price High to Low--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Price_Desc">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
			<cfcase value="4">
				<!---Get Vehicles - sort Odometer Asc--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Odometer_Asc">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
			<cfcase value="5">
				<!---Get Vehicles - sort Odometer Desc--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Odometer_Desc">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
			<cfcase value="6">
				<!---Get Vehicles - sort Year Asc--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Year_Asc">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
			<cfcase value="7">
				<!---Get Vehicles - sort Year Desc--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Year_Desc">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
			<cfcase value="8">
				<!---Get Vehicles - sort Stock Number--->
				<cfstoredproc datasource="Automall" procedure="Get_All_Vehicles_Stock">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@automall_id" value="#arguments.automall_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ew_used" value="#arguments.new_used#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_year" value="#url.year#" maxlength="6">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ake" value="#url.make#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@odel" value="#url.model#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@_type" value="#url.body#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@axprice" value="#url.maxprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@minprice" value="#url.minprice#" maxlength="10">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@uxury" value="#url.luxury#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@leet" value="#url.fleet#" maxlength="1">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@dealer_id" value="#url.dealer_id#" maxlength="3">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@rivetrain" value="#url.drivetrain#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ransmission" value="#url.transmission#" maxlength="50">
					<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@olor" value="#url.color#" maxlength="100">
					<cfprocresult name="Get_Vehicles" resultset="1">
				</cfstoredproc>
			</cfcase>
		</cfswitch>--->