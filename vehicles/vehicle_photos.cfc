<cfcomponent>

	<cffunction name="wow_slider" description="multiple photos" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Img_Urls" required="true">
		<cfargument name="img_title" default="" >
		<cfargument name="img_class" default="">
		<cfargument name="Voi_Vin" default="">
		<cfargument name="Permalink" default="">
		<cfargument name="V_Make" default="">
		<cfargument name="V_Model" default="">
		<cfif url.dealer_id eq 62>
        <style>
			.wow-slider-vdp{border:none 0;max-width:none;padding:0; max-height:426px!important; max-width:640px!important;}							
		</style>
        </cfif>
		<div id="wowslider-container1">
			<div class="ws_images"><!-- vehicle_photos.cfc  -->
				<ul>
					<cfset variables.nav_count=0>
					<cfloop list="#arguments.Img_Urls#" index="img">
						<cfset variables.nav_count=variables.nav_count+1>
						<li>
                   		<cfif url.dealer_id eq 62>
                        
                            <cftry>
                            <cfimage                          
                                action = "writeToBrowser" 
                                source = "#variables.img#"
                                quality=".5" format="jpg" 
                                height="426" width="640"
                                border="0" class="img-responsive wow-slider-vdp" title="#arguments.img_title#" alt="#arguments.img_title#" id="wows1_#variables.nav_count-1#" >
                            <cfcatch>
                                <img class="img-responsive wow-slider-vdp" src="#variables.img#" alt="#arguments.img_title#" title="#arguments.img_title#" id="wows1_#variables.nav_count-1#"/>
                            </cfcatch>
                            </cftry>
                        <cfelse>
                            <img class="img-responsive wow-slider-vdp" src="#variables.img#" alt="#arguments.img_title#" title="#arguments.img_title#" id="wows1_#variables.nav_count-1#"/>
                        </cfif>						
                          
						</li>
					</cfloop>
				</ul>
			</div>
			<div class="ws_bullets">
				<div style="top:25px">
					<cfset variables.nav_count=0>
					<cfloop list="#arguments.Img_Urls#" index="img">
						<cfset variables.nav_count=variables.nav_count+1>
						<cfset variables.img_title_ext=right(#variables.img#,4)>
						<cfset variables.img_title=replace(variables.img,"#variables.img_title_ext#","","all" )>
						<a href="##" title="#variables.img_title#">#variables.nav_count#</a> 
					</cfloop>
				</div>
			</div>
			<div class="ws_shadow"></div>
		</div>
		<br/>
		<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/880/engine1/wowslider.js"></script>'>
		<cfset url.Non_Global_Footer_Scripts= url.Non_Global_Footer_Scripts & '<script type="text/javascript" src="http://#cgi.server_name#/wowslider/880/engine1/script.js"></script>'>
						<!--- changed from 785 09/21/2015 --->
	</cffunction>

	<cffunction name="single_photo" description="shows a single photo" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Img_Urls" required="true">
		<cfargument name="img_title" default="" >
		<cfargument name="img_class" default="">
		<cfargument name="Voi_Vin" default="">
		<cfargument name="Permalink" default="">
		<cfargument name="V_Make" default="">
		<cfargument name="V_Model" default="">
		<cfargument name="New_Used" default="N">
		<cfargument name="Certified" default="0">
	 
	 	<!--- Clicks Tracker --->
		<cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.dealer_id#</cfquery>
		<cfset click_tracker = #t_clik.track_clicks# >
		
		<!---Set Condition in Regular Speak--->
		<cfswitch expression="#arguments.New_Used#">
			<cfdefaultcase>
				<cfset variables.itype="Used">
			</cfdefaultcase>
			<cfcase value="N">
				<cfset variables.itype="New">
			</cfcase>
		</cfswitch>
		<cfif arguments.Certified eq 1>
			<cfset variables.itype="Certified">
		</cfif>

		<cfif len(trim(arguments.Img_Urls)) gt 0>
			<cfset variables.first_image=listgetat(arguments.Img_Urls,1)>
		<cfelse>
			<cfset variables.first_image="http://#cgi.server_name#/images/photo_coming_soon.jpg">
		</cfif>

		<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
			<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
		<cfelse>
			<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
		</cfif>
			
		<cfif len(trim(arguments.Voi_Vin))>
			<cfif #click_tracker# EQ 1 >		<!--- Set in Dealer Settings 02/2016 --->
				<a href="http://#cgi.server_name#/clicks/vauto_clicks.cfm?c_type=2&vin=#arguments.VOI_Vin#&v_link=#variables.v_link#&itype=#variables.itype#">
			<cfelse>
				<a href="http://#cgi.server_name#/vehicles/#variables.v_link#?itype=#variables.itype#">
			</cfif>
				
                <!---<cfif cgi.remote_addr eq '172.16.25.102x'>
    				<cftry>
                    <cfimage                          
                        action = "writeToBrowser" 
                        source = "#variables.first_image#"
                        quality=".5" format="jpg" 
                        border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" >
                    <cfcatch>
                    	<img border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
                    </cfcatch>
 					</cftry>
               <cfelse>--->
	                <img border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
                 <!---</cfif>--->
                
			</a>
		<cfelse>
	       <!--- <cfif cgi.remote_addr eq '172.16.25.102x'>
            <cftry>
            	<cfimage                          
                    action = "writeToBrowser" 
                    source = "#variables.first_image#"
                    quality=".5" format="jpg" 
                    border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" >
            <cfcatch>
            	<img border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
            </cfcatch>
            </cftry>
            
            <cfelse>--->
			<img border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="#variables.first_image#"/>
            <!---</cfif>--->
		</cfif>
			
	</cffunction>
    
    <cffunction name="first_photo" description="shows a single photo" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="Voi_Vin" default="">
		<cfargument name="dealer_id" default="0">		
			
        <cfquery datasource="ultra10" name="q1">                  
            select top 1 img_urls
            from vehicles
            where 0=0 and vin = '#arguments.voi_vin#'
        </cfquery>    
            <cfset img1 = listfirst(q1.img_urls)>
		<cfif len(trim(img1))>                
	    	<img border="0" class="img-responsive" title="VIN #arguments.voi_vin#" alt="#arguments.voi_vin#" src="#img1#"/>	
		<cfelse>
			<img border="0" class="img-responsive" title="Vehicle Image Coming Soon" alt="Coming Soon" src="/images/inventory/ph_coming_soon.jpg"/>
		</cfif>			
	</cffunction>

	<cffunction name="no_photo" description="shows a photo coming soon placeholder" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="img_title" default="" >
		<cfargument name="img_class" default="">
		<cfargument name="Voi_Vin" default="">
		<cfargument name="Permalink" default="">
		<cfargument name="V_Make" default="">
		<cfargument name="V_Model" default="">

		<cfif len(trim(arguments.Img_Urls)) gt 0>
			<cfset variables.first_image=listgetat(arguments.Img_Urls,1)>
		<cfelse>
			<cfset variables.first_image="http://#cgi.server_name#/images/photo_coming_soon.jpg">
		</cfif>

		<cfif len(trim(arguments.Permalink)) gt 0 and len(trim(arguments.V_Make)) gt 0 and len(trim(arguments.V_Model)) gt 0 >
			<cfset variables.v_link="#lcase(arguments.V_Make)#/#lcase(arguments.V_Model)#/#lcase(arguments.Permalink)#">
		<cfelse>
			<cfset variables.v_link="vehicle_details.cfm?vin=#arguments.VOI_Vin#">
		</cfif>

		<cfif len(trim(arguments.Voi_Vin))>
			<a href="http://#cgi.server_name#/vehicles/#variables.v_link#">
				<img border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="http://#cgi.server_name#/images/inventory/ph_coming_soon.jpg"/>
			</a>
		<cfelse>
			<img border="0" class="img-responsive #arguments.img_class#" title="#arguments.img_title#" alt="#arguments.img_title#" src="http://#cgi.server_name#/images/inventory/ph_coming_soon.jpg"/>
		</cfif>
	
	</cffunction>

</cfcomponent>