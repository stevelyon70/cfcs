<cfcomponent>
	
	<cffunction name="show_default" description="display default contact us form" output="Yes" access="public">
		
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="input_size" default="input-xlarge">
		<cfargument name="form_legend" default="Contact Us">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/job_action.cfm">

		<cfset var Get_Form_Locations="">
		 

 
    <!--- <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" media="screen" href="http://tarruda.github.com/bootstrap-datetimepicker/assets/css/bootstrap-datetimepicker.min.css">
  --->
		
		<form class="form-horizontal" action="#arguments.form_action#" method="post" enctype="multipart/form-data">
			<fieldset>
				<input type="hidden" id="Dealer_ID" name="Dealer_ID" value="#arguments.dealer_id#">
				
				<div class="form-group">
					<div class="col-md-4" align="center"></div>
					<div class="col-md-4" align="right">
						<span style="font-family:Helvetica, Condensed, sans-serif;font-style:italic;font-size:12pt;color:##000000;font-weight:bold">Appointment Date:</span> 
					</div>
					<div class="col-md-4" align="left">
						
						
					 <div id="datetimepicker2" class="input-append date">
						<div class="input-group date">
  <input type="text" name="Appointment_date" data-format="MM/dd/yyyy"  class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
</div>
						
						
						
					<!---  <cfif #arguments.dealer_id# eq 495 > --->
     
					<!--- <input name="Appointment_date"  class="form-control input-sm " data-format="MM/dd/yyyy"  style="border:1px solid ##000000;min-height:25px"  id="datetimepicker" type="text" size="30"  maxlength="10" > </input>
				      <span class="add-on">
				        <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
				      </span> --->
					</div>
<!--- 					<cfelse>
						<input name="Appointment_date"  class="form-control input-sm"  style="border:1px solid ##ffffff"  id="Appointment_date" type="text" size="30"  maxlength="10" >
											
						</cfif>  --->
					</div>
					
				</div>
								<div class="form-group">
					<!--- <div class="col-md-3" align="left"><a href="../employment" style="font-size:10pt;font-weight:bold" >Return to Opportunities</a></div> --->
					<label class="control-label col-md-3" for="Contact_Us"></label>
					<div class="col-md-6" align="right" >
						<input type="submit" class="btn btn-primary" id="Contact_Us" value="SUBMIT APPLICATION">
						<br>
						<a href="../employment" style="font-size:10pt;font-weight:bold" >Return to Opportunities</a>
					</div>
				</div>
			</fieldset>
		</form>

	</cffunction>

	<cffunction name="form_submit" description="action page for form" output="Yes" access="public">

	</cffunction>

</cfcomponent>
