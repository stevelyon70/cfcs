<cfcomponent>

	<cfparam name="url.page_action" default="">

	<cffunction name="standard" description="coming soon message" output="Yes" access="public">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-title" title="#Get_Page_Content.page_title#">#Get_Page_Content.page_title#</h1>
			</div>
		</div>
		<cfif len(trim(Get_Page_Content.page_banner)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_banner#
				</div>
			</div>
		</cfif>
		<div class="row">
			<cfswitch expression="#url.page_action#" >
				<cfdefaultcase>
					<cfinvoke component="/cfcs/automall/findmycar_form" method="contact_form">
						<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
						<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
						<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
					</cfinvoke>
				</cfdefaultcase>
				<cfcase value="submit_form">
					<cfinvoke component="/cfcs/automall/findmycar_form" method="submit_form">
						<cfinvokeargument name="automall_id" value="#arguments.automall_id#"/>
						<cfinvokeargument name="automall_name" value="#arguments.automall_name#"/>
						<cfinvokeargument name="template_id" value="#arguments.template_id#"/>
					</cfinvoke>
				</cfcase> 
			</cfswitch>
		</div>
		<cfif len(trim(Get_Page_Content.page_footer)) gt 0>
			<div class="row">
				<div class="col-md-12">
					#Get_Page_Content.page_footer#
				</div>
			</div>
		</cfif>
	</cffunction>

</cfcomponent>