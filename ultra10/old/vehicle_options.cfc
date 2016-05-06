<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp options" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Installed" default="">
		<cfargument name="Safety" default="">
		<cfargument name="Interior" default="">
		<cfargument name="Exterior" default="">
		<cfargument name="Mechanical" default="">
		<cfargument name="Misc" default="">


		<cfif len(trim(arguments.Installed)) gt 0>
			<div class="row vdp-option-cat"><b>Installed</b></div>
			<div class="row">
				<div class="col-md-4">
					<cfset variables.rowsplit=ceiling(listlen(arguments.Installed)/3)>
					<cfset variables.row_count=0>
					<cfloop list="#arguments.Installed#" index="o">
						<cfset variables.row_count=variables.row_count+1>
						<li class="vdp-option-li">#variables.o#</li>
						<cfif variables.row_count mod variables.rowsplit eq 0>
							</div>
							<div class="col-md-4">
						</cfif>
					</cfloop>
				</div>
			</div>
		</cfif>

		<cfif len(trim(arguments.Safety)) gt 0>
			<div class="row vdp-option-cat"><b>Safety</b></div>
			<div class="row">
				<div class="col-md-4">
					<cfset variables.rowsplit=ceiling(listlen(arguments.Safety)/3)>
					<cfset variables.row_count=0>
					<cfloop list="#arguments.Safety#" index="o">
						<cfset variables.row_count=variables.row_count+1>
						<li class="vdp-option-li">#variables.o#</li>
						<cfif variables.row_count mod variables.rowsplit eq 0>
							</div>
							<div class="col-md-4">
						</cfif>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Exterior)) gt 0>
			<div class="row vdp-option-cat"><b>Exterior</b></div>
			<div class="row">
				<div class="col-md-4">
					<cfset variables.rowsplit=ceiling(listlen(arguments.Exterior)/3)>
					<cfset variables.row_count=0>
					<cfloop list="#arguments.Exterior#" index="o">
						<cfset variables.row_count=variables.row_count+1>
						<li class="vdp-option-li">#variables.o#</li>
						<cfif variables.row_count mod variables.rowsplit eq 0>
							</div>
							<div class="col-md-4">
						</cfif>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Interior)) gt 0>
			<div class="row vdp-option-cat"><b>Interior</b></div>
			<div class="row">
				<div class="col-md-4">
					<cfset variables.rowsplit=ceiling(listlen(arguments.Interior)/3)>
					<cfset variables.row_count=0>
					<cfloop list="#arguments.Interior#" index="o">
						<cfset variables.row_count=variables.row_count+1>
						<li class="vdp-option-li">#variables.o#</li>
						<cfif variables.row_count mod variables.rowsplit eq 0>
							</div>
							<div class="col-md-4">
						</cfif>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Mechanical)) gt 0>
			<div class="row vdp-option-cat"><b>Mechanical</b></div>
			<div class="row">
				<div class="col-md-4">
					<cfset variables.rowsplit=ceiling(listlen(arguments.Mechanical)/3)>
					<cfset variables.row_count=0>
					<cfloop list="#arguments.Mechanical#" index="o">
						<cfset variables.row_count=variables.row_count+1>
						<li class="vdp-option-li">#variables.o#</li>
						<cfif variables.row_count mod variables.rowsplit eq 0>
							</div>
							<div class="col-md-4">
						</cfif>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Misc)) gt 0>
			<div class="row vdp-option-cat"><b>Miscellaneous</b></div>
			<div class="row">
				<div class="col-md-4">
					<cfset variables.rowsplit=ceiling(listlen(arguments.Misc)/3)>
					<cfset variables.row_count=0>
					<cfloop list="#arguments.Misc#" index="o">
						<cfset variables.row_count=variables.row_count+1>
						<li class="vdp-option-li">#variables.o#</li>
						<cfif variables.row_count mod variables.rowsplit eq 0>
							</div>
							<div class="col-md-4">
						</cfif>
					</cfloop>
				</div>
			</div>
		</cfif>

	</cffunction>

	<cffunction name="vdp_mobile" description="shows mobile vdp options" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Installed" default="">
		<cfargument name="Safety" default="">
		<cfargument name="Interior" default="">
		<cfargument name="Exterior" default="">
		<cfargument name="Mechanical" default="">
		<cfargument name="Misc" default="">


		<cfif len(trim(arguments.Installed)) gt 0>
			<div class="row vdp-option-cat"><b>Installed</b></div>
			<div class="row">
				<div class="col-md-12">
					<cfloop list="#arguments.Installed#" index="o">
						<li class="vdp-option-li">#variables.o#</li>
					</cfloop>
				</div>
			</div>
		</cfif>

		<cfif len(trim(arguments.Safety)) gt 0>
			<div class="row vdp-option-cat"><b>Safety</b></div>
			<div class="row">
				<div class="col-md-12">
					<cfloop list="#arguments.Safety#" index="o">
						<li class="vdp-option-li">#variables.o#</li>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Exterior)) gt 0>
			<div class="row vdp-option-cat"><b>Exterior</b></div>
			<div class="row">
				<div class="col-md-12">
					<cfloop list="#arguments.Exterior#" index="o">
						<li class="vdp-option-li">#variables.o#</li>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Interior)) gt 0>
			<div class="row vdp-option-cat"><b>Interior</b></div>
			<div class="row">
				<div class="col-md-12">
					<cfloop list="#arguments.Interior#" index="o">
						<li class="vdp-option-li">#variables.o#</li>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Mechanical)) gt 0>
			<div class="row vdp-option-cat"><b>Mechanical</b></div>
			<div class="row">
				<div class="col-md-12">
					<cfloop list="#arguments.Mechanical#" index="o">
						<li class="vdp-option-li">#variables.o#</li>
					</cfloop>
				</div>
			</div>
		</cfif>
		<cfif len(trim(arguments.Misc)) gt 0>
			<div class="row vdp-option-cat"><b>Miscellaneous</b></div>
			<div class="row">
				<div class="col-md-12">
					<cfloop list="#arguments.Misc#" index="o">
						<li class="vdp-option-li">#variables.o#</li>
					</cfloop>
				</div>
			</div>
		</cfif>

	</cffunction>

</cfcomponent>