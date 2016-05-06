<cfcomponent>

	<cffunction name="print_me" description="prints_graphic" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Nav_ID" required="true">

		<cfquery datasource="Aspen10" name="Get_Nav">
			SELECT     	Nav_Image,
						Nav_Alt
			FROM		Navigation
			WHERE		Nav_ID = <cfqueryparam value="#arguments.Nav_ID#" cfsqltype="CF_SQL_INTEGER" maxlength="5">
		</cfquery>
		
		<div style="background-color:##fff;padding:10px;">
			<img src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" class="img-responsive" alt="#Get_Nav.Nav_Alt#"/>
			<br/>
			<a href="javascript:window.print();">Click Here to Print</a>
			<script>
				window.print();
			</script>
		</div>
	
	
	</cffunction>

</cfcomponent>