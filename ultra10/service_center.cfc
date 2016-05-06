<cfcomponent>

	<cffunction name="modern_standard" description="shows standard dealer hours" output="Yes" access="public">
		<style>
			##wowslider-container1 .ws_bullets a {
				background: url(http://dealers.wdautos.com/wowslider/880/engine1/bullet.png) left top;
			}
		</style>
		
		
		<cfif NOT IsDefined("Get_Nav")>
			<cflocation url="#cgi.server_name#" >
		</cfif>
		
		<div align="center">
			<div class="row service-center-stage-top" style="max-width:967px">
				<div class="col-md-2 visible-md visible-lg" align="left">
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="nav_type_id" value="47"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="element_class" value="svc-btn-rt"/>
						<cfinvokeargument name="responsive" value="true"/>
					</cfinvoke>
					&nbsp;<!---You need something here for the colum to appear on the site - otherwise the slideshow will float all the way to the left--->
				</div>
				<div class="col-md-7 pad-top-10"> 
					<cfinvoke component="/cfcs/ultra10/wow_slider" method="wide">
						<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
						<cfinvokeargument name="Get_Nav" value="#arguments.Get_Nav#"/>
						<cfinvokeargument name="nav_type_id" value="46"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
					</cfinvoke>
				</div>
				<div class="col-md-3 no-pad visible-md visible-lg" align="right">
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="nav_type_id" value="48"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="element_class" value="svc-btn-lt"/>
						<cfinvokeargument name="responsive" value="true"/>
					</cfinvoke>
				</div>
				<div class="row">
					<div class="col-md-12">
						<br/>
					</div>
				</div>
				<div class="row visible-md visible-lg">
					<div class="col-md-12 pad-top-10">
						<img class="img-responsive" alt="Break"  src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/service/break_a.png"/>
					</div>
				</div>
			</div>
		</div>
		<div align="center" class="visible-sm visible-xs">
			<div class="row">
				<div class="col-md-12 no-pad">
					<!--- <table width="100%" cellpadding="0" cellspacing="0">    07/23/2014
						<tr> --->
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="table">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="48"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="svc-btn-mbl"/>
							</cfinvoke>
						<!--- </tr>
					</table> --->
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 no-pad ">
					<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/service/break_a.png"/><!--- SERVICE SPECIALS --->
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 no-pad"> 
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="table">
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="nav_type_id" value="49"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="element_class" value="svc-coupons"/>
					</cfinvoke> 
				 
				</div>
			</div>
			

			<div class="row">
				<div class="col-md-12 no-pad ">
					<img class="img-responsive" src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/service/break_b.png"/><!--- SERVICE COUPONS --->
				</div>
			</div>
		</div>
		<div align="center" class="visible-md visible-lg">
			<div class="row service-center-stage-bot" style="max-width:967px">
				<div class="col-md-9 no-pad">
					<div style="background-color:##fff;margin:5px;">
						<cfif #arguments.dealer_id# NEQ 18 AND  #arguments.dealer_id# NEQ 365 >  
							<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="49"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="element_class" value="svc-coupons"/>
								<cfinvokeargument name="pull" value="left"/>
							</cfinvoke>
						<cfelse>
							<cfinvoke component="/cfcs/ultra10/new_coupon" method="modern_standard_slider">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="new_used" value="U"/>
								<cfinvokeargument name="minSlides" value="3"/>
								<cfinvokeargument name="maxSlides" value="20"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
								<cfinvokeargument name="nav_type_id" value="49"/>
								<cfinvokeargument name="element_class" value="svc-coupons"/>
								<cfinvokeargument name="carousel_class" value="carousel_v_rand"/>
								<cfinvokeargument name="slideWidth" value="234"/>
								<cfinvokeargument name="slideMargin" value="5"/>
							</cfinvoke>  
					</cfif>   
					<div style="clear:both;"></div>
					</div>
				</div>
				<div class="col-md-3 no-pad">
					<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
						<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
						<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
						<cfinvokeargument name="nav_type_id" value="50"/>
						<cfinvokeargument name="assets" value="#arguments.assets#"/>
						<cfinvokeargument name="element_class" value="svc-helpful-link"/>
						<cfinvokeargument name="responsive" value="false"/>
					</cfinvoke>					
				</div>
			</div>
		</div>
<cfif #url.dealer_id# NEQ 78 and #url.dealer_id# NEQ 79 and #url.dealer_id# NEQ 18  and #url.dealer_id# NEQ 365 >		
		<div class="row no-pad visible-md visible-lg">
			<div class="col-md-12 no-pad" align="center">
				<img class="img-responsive" alt="Break" src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/service/break_b.png"/> <!--- Service videos --->
			</div>
		</div>
		<div align="center">
			<div class="row service-center-stage-bot" style="max-width:967px">
				<div style="background-color:##fff;margin:5px;padding:5px;">
					<div class="row">
						<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
							<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
							<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							<cfinvokeargument name="nav_type_id" value="51"/>
							<cfinvokeargument name="assets" value="#arguments.assets#"/>
							<cfinvokeargument name="element_class" value="svc-video-container"/>
							<cfinvokeargument name="colspan" value="6"/>
						</cfinvoke>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
		</div>
</cfif>					
		
<cfif #arguments.dealer_id# EQ 18 OR  #arguments.dealer_id# EQ 365 > 
		<div class="row no-pad visible-md visible-lg">
			<div class="col-md-12 no-pad" align="center">
				<img class="img-responsive" alt="Break" src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/service/break_staff.jpg"/> <!--- Service Staff Faulkner Nissan --->
			</div>
		</div>
		<div align="center">
			<div class="row service-center-stage-bot" style="max-width:967px">
				<div style="background-color:##fff;margin:5px;padding:5px;">
					<div class="row">
						<div class="col-md-11" style="margin:45px;padding:5px;align:center"  >
							<cfset url.Department="12">
							<cfinvoke component="/cfcs/ultra10/service_staff" method="modern_standardSC">
								<cfinvokeargument name="dsn" value="ultra10"/>
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="assets" value="#arguments.assets#"/>
								<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
								<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
							</cfinvoke>  
						</div>	
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
		</div>
</cfif>
		
		
	</cffunction>

	<cffunction name="legacy_standard" description="shows legacy dealer hours" output="Yes" access="public">

		Service Center
		
	</cffunction>

</cfcomponent>