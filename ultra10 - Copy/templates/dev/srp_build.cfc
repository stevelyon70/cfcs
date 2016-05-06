<cfcomponent>

	<cffunction name="page_build" description="builds the srp page" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="data_directory" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="template_id" required="true">
		<cfargument name="dealer_name" required="true">
		<cfargument name="address_1" required="true">
		<cfargument name="address_2" required="true">
		<cfargument name="city" required="true">
		<cfargument name="state" required="true">
		<cfargument name="zip" required="true">
		<cfargument name="wordpress_cat" required="true">

		<cfargument name="Get_Meta_Info" required="true">
		<cfset Get_Meta_Info=arguments.Get_Meta_Info>

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<cfparam name="url.year" default="">
		<cfparam name="url.new_used" default="">
		<cfparam name="url.make" default="">
		<cfparam name="url.model" default="">
		<cfparam name="url.maxprice" default="11000000">
		<cfparam name="url.minprice" default="-1">
		<cfparam name="url.sortblock" default="1">
		<cfparam name="url.luxury" default="">
		<cfparam name="url.fleet" default="">
		<cfparam name="url.certified" default="">
		<cfparam name="url.body" default="">
		<cfparam name="url.drivetrain" default="">
		<cfparam name="url.transmission" default="">
		<cfparam name="url.color" default="">
		<cfparam name="url.zip" default="">
		<cfparam name="url.radius" default="">
		<cfparam name="form.srp_Vin" default="0">
		<cfparam name="url.form_action" default="0">	
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">

		
		<!--- sortblock kung fu ---> 
		<cfswitch expression="#url.sortblock#">
			<cfcase value="9">
				<cfset url.luxury=1>
			</cfcase>
			<cfcase value="10">
				<cfset url.fleet=1>
			</cfcase>
		</cfswitch>

		<!---maxprice kung fu--->
		<cfswitch expression="#url.maxprice#">
			<cfcase value="5000,10000,15000,20000,25000,30000,35000,40000,45000,50000,75000,100000">
				<cfset url.maxprice=url.maxprice>
			</cfcase>
			<cfdefaultcase>
				<cfset url.maxprice=11000000>
			</cfdefaultcase>
		</cfswitch>

		<!---minprice kung fu--->
		<cfswitch expression="#url.minprice#">
			<cfcase value="10000,20000,30000,50000,75000">
				<cfset url.minprice=url.minprice>
			</cfcase>
			<cfdefaultcase>
				<cfset url.minprice=-1>
			</cfdefaultcase>
		</cfswitch>

		<header class="section-hdr">
			<div class="container">
				<cfinvoke component="/cfcs/ultra10/build_header" method="dev">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</header>

		<cfinvoke component="/cfcs/ultra10/build_navigation" method="dev">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
			<cfinvokeargument name="nav_type_id" value="1"/>
		</cfinvoke>

		<cfif len(trim(Get_Meta_Info.page_banner)) gt 0>
			<section class="section-banner">
				<div class="container" align="center">
					<div class="row page-banner">
						<div class="col-md-12">
							#Get_Meta_Info.page_banner#
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<section class="section-title container">
			<div class="container">
				<div class="row">
					<h1 class="col-md-12 page-title" title="#Get_Meta_Info.page_title#">#Get_Meta_Info.page_title#</h1>
				</div>
			</div>
		</section>

		<cfinvoke component="/cfcs/ultra10/templates/#arguments.template_id#/content_srp" method="content">
			<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
		</cfinvoke>

		<cfif len(trim(Get_Meta_Info.page_footer)) gt 0>
			<section class="section-banner">
				<div class="container" align="center">
					<div class="row page-banner">
						<div class="col-md-12">
							#Get_Meta_Info.page_footer#
						</div>
					</div>
				</div>
			</section>
		</cfif>

		<footer>
			<div class="container">
				<cfinvoke component="/cfcs/ultra10/build_footer" method="nissan">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="dealer_name" value="#arguments.dealer_name#"/>
					<cfinvokeargument name="address_1" value="#arguments.address_1#"/>
					<cfinvokeargument name="address_2" value="#arguments.address_2#"/>
					<cfinvokeargument name="city" value="#arguments.city#"/>
					<cfinvokeargument name="state" value="#arguments.state#"/>
					<cfinvokeargument name="zip" value="#arguments.zip#"/>
				</cfinvoke>
			</div>
		</footer>
		
	</cffunction>

</cfcomponent>