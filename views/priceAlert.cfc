<cfcomponent>

	<cffunction name="siteModule" access="public" returntype="void" output="yes">
		<cfargument name="dsn" type="string" required="yes">
		<cfargument name="dealerId" type="numeric" required="yes">          
		<cfparam name="client.priceAlert_email" default="">  
        <!--- 		
			check to see if feature turned on for dealer 
		--->
        <cfif isFeatureOnPerDealer(arguments.dsn, arguments.dealerId)>
        	<style>
			.priceAlertSiteContainer {
				height:35px;
				padding-left:5px;
				overflow:hidden;
				border:outset ##E6E6E6;
			}
			.priceAlertPos {
				background: ##F1F1F3;
				position: fixed;
				left: 0;
				right: 0;
				top: 178px;
				width: 125px;
				opacity: 0.8;
				border-top-left-radius: 0px!important;
				border-top-right-radius: 10px!important;	
				border-bottom-left-radius: 0px!important;
				border-bottom-right-radius: 10px!important;
				-moz-border-top-right-radius: 10px!important;
				-moz-border-top-left-radius: 0px!important;
				-moz-border-bottom-left-radius: 0px!important;
				-moz-border-bottom-right-radius: 10px!important;
				-webkit-border-top-right-radius: 10px!important;	
				-webkit-border-top-left-radius: 0px!important;
				-webkit-border-bottom-left-radius: 0px!important;
				-webkit-border-bottom-right-radius: 10px!important;
			}			
			.priceAlertShrink {
				width:450px!important;	
				height:350px!important;
				overflow:auto;
			}
			</style>
            <cfscript>
				qAlerts = this.getAlertsPerUser('ultra10', arguments.dealerId, client.priceAlert_email);				
	            imgObj = new cfcs.vehicles.vehicle_photos();
			</cfscript>
        	<div id="priceAlertSiteModule" class="priceAlertSiteContainer priceAlertPos pad-top-10" onclick="$('##priceAlertSiteModule').toggleClass('priceAlertShrink');">
            	<div class="row">
                	<div class="col-md-9">Price Alert - #client.priceAlert_email#</div>
                </div>
                <div class="row">
                	<div class="col-md-2"></div>
					<div class="col-md-2">Price</div>
                    <div class="col-md-4">VIN</div>
                    <div class="col-md-1"></div>
                </div>                            
                <cfloop query="qAlerts">
                    <div class="row">
                        <div class="col-md-2">#imgObj.first_photo(vin, arguments.dealerId)#</div>
                        <div class="col-md-2">#dollarformat(alertprice)#</div>
                        <div class="col-md-4"><a href="/vehicles/vehicle_details.cfm?vin=#vin#">#vin#</a></div>
                        <div class="col-md-1">&times;</div>
                    </div>
                </cfloop>
            </div>        
        </cfif>        
	</cffunction>
    
    <cffunction name="vehicleModule" access="public" returntype="void" output="yes">
		<cfargument name="dsn" type="string" required="yes">
		<cfargument name="dealerId" type="numeric" required="yes">
        <cfargument name="vin" type="string" required="yes">  
        <cfargument name="v_make" type="string" required="yes">  
        <cfargument name="v_model" type="string" required="yes">  
        <cfargument name="voi_new_used" type="string" required="yes">  
        <cfargument name="voi_price" type="string" required="no" default="1">  
        <cfargument name="v_year" type="string" required="no" default=""> 
        <cfargument name="v_trim" type="string" required="no" default=""> 
        <cfargument name="sitePlacement" type="string" required="no" default="srp">  
        <cfargument name="stockNum" type="string" required="no" default="">  
        <cfset request.PAactive = false>            
        <!--- 		
			check to see if feature turned on for dealer 		
			priceAlert - #isAlertSetForVin(arguments.dsn, arguments.dealerId, arguments.vin)#
		 --->        
         <cfif arguments.sitePlacement is 'vdp'>         
	         <cfset request.btnStyle = 'btn btn-vdp-shopping'>
         </cfif>
         <cfif arguments.sitePlacement is 'srp'>         
	         <cfset request.btnStyle = 'btn srp-btn1'>
         </cfif>         
<!---<cfif cgi.remote_addr eq '172.16.25.102'> --->
        <cfif isFeatureOnPerDealer(arguments.dsn, arguments.dealerId)>
			<cfif isAlertSetForVin(arguments.dsn, arguments.dealerId, arguments.vin)>
                <cfif url.TEMPLATE_ID is 'New_World3x'> 
                    <a class="#request.btnStyle#"	href="##" id="clk_id_#arguments.vin#" cursor="hand" data-toggle="modal" data-target="###arguments.vin#ModalPriceAlert">REMOVE PRICE ALERT</a>
                    <script>
                        var resetbtn = '<a class="#request.btnStyle#"	href="##" cursor="hand" data-toggle="modal" data-target="###arguments.vin#ModalPriceAlert">GET PRICE ALERT</a>';					
                        $("##clk_id_#arguments.vin#").click(function(){
                            $.ajax({url: "http://#cgi.server_name#/vehicles/priceAlertAction.cfm?formtype=remove&voi_vin=#arguments.vin#&dealer_id=#arguments.dealerId#", success: function(result){
                                //alert
                                alert('Price Alert removed!');
                                $("##id_#arguments.vin#").html(resetbtn);
                            }});
                        });				
                    </script>     
                <cfelse>        
                    <cfif arguments.sitePlacement is 'srp'><div class="col-md-3 srp-btn visible-md visible-lg"></cfif>
                    <div id="id_#arguments.vin#">
                        <a class="btn btn-grey" id="clk_id_#arguments.vin#"><img  alt="Price Alert" class="btn-icon" src="/images/inventory/icon_RemovePriceAlert_off.png"  onmouseover="this.src='/images/inventory/icon_RemovePriceAlert_on.png'" onmouseout="this.src='/images/inventory/icon_RemovePriceAlert_off.png'" />Remove Price Alert</a>
                    </div>
                    <cfif arguments.sitePlacement is 'srp'></div></cfif>
                    <script>
                    var resetbtn = '<a class="btn btn-grey" data-toggle="modal" data-target="###arguments.vin#ModalPriceAlert"><img  alt="Price Alert" class="btn-icon" src="/images/inventory/icon_GetPriceAlert_on.png"  onmouseover="this.src="/images/inventory/icon_GetPriceAlert_off.png"" onmouseout="this.src="/images/inventory/icon_GetPriceAlert_on.png""/>Get Price Alert</a>';
                    $("##clk_id_#arguments.vin#").click(function(){
                        $.ajax({url: "http://#cgi.server_name#/vehicles/priceAlertAction.cfm?formtype=remove&voi_vin=#arguments.vin#&dealer_id=#arguments.dealerId#", success: function(result){
                            //alert
                            alert('Price Alert removed!');
                            $("##id_#arguments.vin#").html(resetbtn);
                        }});
                    });				
                    </script>            
                </cfif>
                    
            <cfelse>
            <!-- begin price alert button -->      
                <cfif url.TEMPLATE_ID is 'New_World3x'>            	
                        <a class="#request.btnStyle#"	href="##" cursor="hand" data-toggle="modal" data-target="###arguments.vin#ModalPriceAlert">GET PRICE ALERT</a>                
                <cfelse>
                    <cfif arguments.sitePlacement is 'srp' AND #cgi.server_name# NEQ "4ultra10.wddemos.com" ><div class="col-md-3 srp-btn visible-md visible-lg"></cfif>
                    	<cfif #arguments.dealerId# EQ 365 AND #cgi.server_name# EQ "4ultra10.wddemos.com">
					    	<a class="btn srp-btn3" data-toggle="modal" data-target="###arguments.vin#ModalPriceAlert">GET PRICE ALERT</a>
						<cfelse>           
					    	<a class="btn btn-grey" data-toggle="modal" data-target="###arguments.vin#ModalPriceAlert"><img  alt="Price Alert" class="btn-icon" src="/images/inventory/icon_GetPriceAlert_on.png" onmouseover="this.src='/images/inventory/icon_GetPriceAlert_off.png'" onmouseout="this.src='/images/inventory/icon_GetPriceAlert_on.png'" />Get Price Alert</a>           
						</cfif>	
                    <cfif arguments.sitePlacement is 'srp' AND #cgi.server_name# NEQ "4ultra10.wddemos.com"></div></cfif>
                 </cfif>
             </cfif>
                <!-- end price alert button -->
                <!-- begin popup form -->
                <cfinvoke component="/cfcs/ultra10/popups" method="priceAlert">
                    <cfinvokeargument name="voi_vin" value="#arguments.vin#"/>
                    <cfinvokeargument name="dealer_id" value="#arguments.dealerId#"/>
                    <cfinvokeargument name="modal_name" value="#arguments.Vin#ModalPriceAlert"/>
                    <cfinvokeargument name="voi_new_used" value="#arguments.voi_new_used#"/>
                    <cfinvokeargument name="formtype" value="add"/>
                    <cfinvokeargument name="voi_price" value="#arguments.voi_price#"/>
                    <cfinvokeargument name="returnUrl" value="#cgi.SERVER_NAME##cgi.SCRIPT_NAME#"/>
                    <cfinvokeargument name="v_make" value="#arguments.v_make#"/>
                    <cfinvokeargument name="v_year" value="#arguments.v_year#"/>
                    <cfinvokeargument name="v_model" value="#arguments.v_model#"/>
                    <cfinvokeargument name="v_trim" value="#arguments.v_trim#"/>  
                    <cfinvokeargument name="v_stock" value="#arguments.stockNum#"/>                
                </cfinvoke>
                <!-- end popup form -->
        </cfif>
<!---</cfif>  --->      
	</cffunction>
    
    <cffunction name="getAlertsPerUser" access="package" returntype="query">
		<cfargument name="dsn" type="string" required="yes">
    	<cfargument name="dealerId" type="numeric" required="yes">
        <cfargument name="userEmail" type="string" required="yes">
        
        <cfquery datasource="#arguments.dsn#" name="q1">
        	select vin, alertprice, id
            from priceAlert
            where dealer_id = #arguments.dealerId# 
                and email = '#arguments.userEmail#'
                and active = 1
        </cfquery>
        
    	<cfreturn q1>
    </cffunction>
    
    <cffunction name="isFeatureOnPerDealer" access="package" returntype="boolean">
		<cfargument name="dsn" type="string" required="yes">
    	<cfargument name="dealerId" type="numeric" required="yes">
        <cfquery datasource="#arguments.dsn#" name="dealerPA">
            select *
            from dealerPriceAlertXref
            where dealer_id = #arguments.dealerId# 
                and active = 1
         </cfquery>        
        <cfset bol = dealerPA.recordcount>        
        <cfreturn bol>        
    </cffunction>
    
    <cffunction name="isAlertSetForVin" access="package" returntype="boolean">
		<cfargument name="dsn" type="string" required="yes">
    	<cfargument name="dealerId" type="numeric" required="yes">
        <cfargument name="vin" type="string" required="yes">   
		<cfparam name="client.PRICEALERT_EMAIL" default="">    
        <cfquery datasource="#arguments.dsn#" name="dealerPA">
            select *
            from priceAlert
            where dealer_id = #arguments.dealerId# 
                and vin = '#arguments.vin#'
                and email = '#client.PRICEALERT_EMAIL#'
         </cfquery>     
        <cfset bol = dealerPA.recordcount>        
        <cfreturn bol>        
    </cffunction>
    
    <cffunction name="getDealerPAEmail" access="public" returntype="string">
		<cfargument name="dsn" type="string" required="yes">
    	<cfargument name="dealerId" type="numeric" required="yes">
        <cfquery datasource="#arguments.dsn#" name="dealerPA">
            select email
            from dealerPriceAlertXref
            where dealer_id = #arguments.dealerId# 
         </cfquery>        
    
    	<cfreturn dealerPA.email>
    </cffunction>
    
</cfcomponent>