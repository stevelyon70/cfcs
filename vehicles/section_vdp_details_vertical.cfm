<cfoutput>
		
<cfset price_alert = 1>

<cfset active_class = ArrayNew(1) >
<cfset content_active_class = ArrayNew(1) >
<cfloop index="x" from="1" to="9" ><cfset active_class[x] = "" ><cfset content_active_class[x] = "" ></cfloop>

<cfif #len(rtrim(arguments.Dealer_Comments))# GT 1 ><cfset active_class[1] = "active" ><cfset content_active_class[1] = " active" >
<cfelseif #Get_Vehicle_Options.Installed# NEQ "" ><cfset active_class[2] = "active" ><cfset content_active_class[2] = "active" >
<cfelseif #Get_Vehicle_Options.Safety# NEQ "" ><cfset active_class[3] = "active" ><cfset content_active_class[3] = "active" > 
<cfelseif #Get_Vehicle_Options.Interior# NEQ "" ><cfset active_class[4] = "active" ><cfset content_active_class[4] = "active" >
<cfelseif #Get_Vehicle_Options.Exterior# NEQ "" ><cfset active_class[5] = "active" ><cfset content_active_class[5] = "active" > 
<cfelseif #Get_Vehicle_Options.Mechanical# NEQ "" ><cfset active_class[6] = "active" ><cfset content_active_class[6] = "active" >
<cfelseif #Get_Vehicle_Options.Misc# NEQ "" ><cfset active_class[7] = "active" ><cfset content_active_class[7] = "active" ></cfif> 

<cfset tab_spc = "30px" >	
<div class="container-fluid">
	<section class="section-internal-video">
		<div class="container" >
				<div class="row">  
					<div class="col-md-9 pull-left  pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
					<div class="row"><div class="col-md-4 pad-top-10 visible-sm visible-xs visible-lg visible-md vdp-form-title">VEHICLE DETAILS</div></div>
					
						<div class="panel panel-default">
							<div class="col-md-2 panel-heading">
								<a class="srp-filter-block" data-toggle="collapse" data-parent="##accordion" href="##collapseComment">
									Miscellaneous
									<span class="glyphicon glyphicon-chevron-down pull-right"></span>
								</a>
							</div>
							<div class="row" >
							<div id="collapseComment" class="col-md-12 panel-collapse collapse">
								<div class="panel-body">
									<br><br>
									<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
									</cfinvoke>
								</div>
							</div>
							</div>
						</div>
					
					
					
					
						<ul class="col-md-3 nav nav-tabs  nav-stacked" > 
								<cfif  #len(rtrim(arguments.Dealer_Comments))# GT 1  >
							  		<li style="margin-bottom:#tab_spc#;margin-top:15px" > <a class="#active_class[1]# nav-tabs nav-tab1" data-toggle="tab" href="##tab1"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Dealer Comments</a></li>
								</cfif>		
								<cfif #Get_Vehicle_Options.Installed# NEQ "" >
							  		<li style="margin-bottom:#tab_spc#" > <a class="#active_class[2]# nav-tabs nav-tab1" data-toggle="tab" href="##tab2"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Installed </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Safety# NEQ "" >
							  		<li style="margin-bottom:#tab_spc#" > <a class="#active_class[3]# nav-tabs nav-tab1" data-toggle="tab" href="##tab3"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Safety </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Interior# NEQ "" >
							  		<li style="margin-bottom:#tab_spc#" > <a class="#active_class[4]# nav-tabs nav-tab1" data-toggle="tab" href="##tab4"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Interior </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Exterior# NEQ "" >
							  		<li style="margin-bottom:#tab_spc#" > <a class="#active_class[5]# nav-tabs nav-tab1" data-toggle="tab" href="##tab5"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Exterior </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Mechanical# NEQ "" >
							  		<li style="margin-bottom:#tab_spc#" > <a class="#active_class[6]# nav-tabs nav-tab1" data-toggle="tab" href="##tab6"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Mechanical </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Misc# NEQ "" >
							  		<li style="margin-bottom:#tab_spc#" > <a class="#active_class[7]# nav-tabs nav-tab1" data-toggle="tab" href="##tab7"><i class="glyphicon glyphicon-chevron-down"></i>&nbsp;Miscellaneous </a></li>
								</cfif>
								<!--- <li style="margin-bottom:#tab_spc#" ><a class="#active_class[8]# nav-tabs nav-tab1" data-toggle="tab" href="##tab8"><i class="glyphicon glyphicon-arrow-right"></i>&nbsp;Price Alert</a></li> --->
						</ul>
						<div class="tab-content col-md-9">
							<div id="tab1" class="tab-pane fade #content_active_class[1]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="align:center;font-weight:bold;color:red!important">Close</span></a></div> 
								<b>Dealer Comments</b>
								<p>#arguments.Dealer_Comments#	
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important;">Close</span></a></div></p> --->
							</div>
							<div id="tab2" class="tab-pane fade   #content_active_class[2]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
								 	<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
									</cfinvoke>
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div>  --->
							</div>	
							<div id="tab3" class="tab-pane fade    #content_active_class[3]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
									<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
									</cfinvoke>
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div>  --->
							</div>
							<div id="tab4" class="tab-pane fade  #content_active_class[4]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
									<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
									</cfinvoke>
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p> --->
							</div>
							<div id="tab5" class="tab-pane fade  #content_active_class[5]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
									<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
									</cfinvoke>
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p> --->
							</div>
							<div id="tab6" class="tab-pane fade  #content_active_class[6]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
									<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
									</cfinvoke>
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p> --->
							</div>
							<div id="tab7" class="tab-pane fade  #content_active_class[7]#">
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a>&nbsp;&nbsp;</div></p>
									<cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_new">
										<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
									</cfinvoke>
								<!--- <div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p> --->
							</div>
							<!--- <div id="tab8" class="tab-pane fade #content_active_class[8]#">
								<p>
								<cfinvoke component="/cfcs/forms/form_contact" method="wish_list">
									<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/> 
									<cfinvokeargument name="V_Year" value="#arguments.V_Year#"/>
									<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
									<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
									<cfinvokeargument name="V_Trim" value="#arguments.V_Trim#"/>
									<cfinvokeargument name="V_Stock" value="#arguments.stock#"/>
									<cfinvokeargument name="dsn" value="ultra10"/>
									<cfinvokeargument name="form_action" value="http://#cgi.server_name#/forms/maillist_action.cfm"/>
								</cfinvoke> 
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important;">Close</span></a></div></p>
							</div> --->
						<!--- Content Close --->
					 <div id="tabclear" class="tab-pane fade" ></div> 
					</div>
							
				</div>  <!--- end 9 columns --->
				
				<div class="col-md-3" >
					<div class="row"><div class="col-md-12 visible-sm visible-xs visible-lg visible-md vdp-form-title">PAYMENT CALCULATOR</div></div>	
					<div class="row ">
						<div class="col-md-12 vdp-pad-10">
							<cfinvoke component="/cfcs/vehicles/calculator_vdp" method="vdp_new">
								<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
								<cfinvokeargument name="Calc_Price" value="#arguments.Selling_Price#"/>
							</cfinvoke>
						</div>
						<div class="col-md-12 vdp-form-title">
							<b>SHOPPING TOOLS</b>
						</div>
						<div class="col-md-12  vdp-pad-10 pull-left">
							<cfinvoke component="/cfcs/vehicles/vehicle_btns" method="vdp_standard_new">
								<cfinvokeargument name="Voi_Vin" value="#arguments.Vin#"/>
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="V_Make" value="#arguments.V_Make#"/>
								<cfinvokeargument name="V_Model" value="#arguments.V_Model#"/>
								<cfinvokeargument name="New_Used" value="#arguments.New_Used#"/>
								<cfinvokeargument name="Certified" value="#arguments.Certified#"/>
							</cfinvoke>
                            <cfscript>
                                priceAlertObj =  new cfcs.views.priceAlert();
                                    writeoutput(priceAlertObj.vehicleModule('ultra10', url.dealer_id, arguments.vin, arguments.v_make, arguments.v_model, arguments.V_New_Used, arguments.Selling_Price, arguments.v_year, arguments.v_trim, 'vdp', arguments.Stock));
                            </cfscript>		
						</div>  
					</div>
				</div>	
				
			</div>  <!--- end row --->
	   </div>
	</section>
</div>	
</cfoutput>

