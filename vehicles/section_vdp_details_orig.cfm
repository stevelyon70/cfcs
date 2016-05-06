<cfoutput>
		
<cfset price_alert = 1>

<cfset active_class = ArrayNew(1) >
<cfset content_active_class = ArrayNew(1) >
<cfloop index="x" from="1" to="6" ><cfset active_class[x] = "" ><cfset content_active_class[x] = "" ></cfloop>
	
<div class="container-fluid">
	<section class="section-internal-video">
		<div class="container">
			<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md price-sell-lab"><!--- VEHICLE DETAILS ---></div></div>	
				<div class="row">  
					<div class="col-md-12 pull-right  pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
						<ul class="nav nav-tabs" > 
								<cfif #arguments.Dealer_Comments# NEQ "" >
							  		<li> <a class="#active_class[1]##ln# nav-tabs nav-tab1" data-toggle="tab" href="##tab1#ln#">DEALER COMMENTS</a></li>
								</cfif>
								<li><a class="#active_class[2]# nav-tabs nav-tab2" data-toggle="tab" href="##tab2#ln#">VEHICLE DETAILS</a></li>
								<li><a class="#active_class[3]# nav-tabs nav-tab3" data-toggle="tab" href="##tab3#ln#">PAYMENT CALCULATOR</a></li>
								<cfif #price_alert# EQ 1 >
									<li><a class="#active_class[4]# nav-tabs nav-tab4" data-toggle="tab" href="##tab4#ln#">ADD TO MY WISH LIST</a></li>
								</cfif>
						</ul>
						<div class="tab-content">
							<div id="tab1" class="tab-pane fade #content_active_class[1]#">
								<p>#arguments.Dealer_Comments#	
								<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important;">Close</span></a></div></p>
							</div>
							
						<div id="tab2" class="tab-pane fade  #content_active_class[2]#">
							<p><cfinvoke component="/cfcs/vehicles/vehicle_options" method="vdp_default">
									<cfinvokeargument name="Installed" value="#Get_Vehicle_Options.Installed#"/>
									<cfinvokeargument name="Safety" value="#Get_Vehicle_Options.Safety#"/>
									<cfinvokeargument name="Interior" value="#Get_Vehicle_Options.Interior#"/>
									<cfinvokeargument name="Exterior" value="#Get_Vehicle_Options.Exterior#"/>
									<cfinvokeargument name="Mechanical" value="#Get_Vehicle_Options.Mechanical#"/>
									<cfinvokeargument name="Misc" value="#Get_Vehicle_Options.Misc#"/>
								</cfinvoke>
							<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
						</div>
						<div id="tab3" class="tab-pane fade  #content_active_class[3]#">
						    <p><cfinvoke component="/cfcs/vehicles/calculator" method="vdp">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="Calc_Price" value="#arguments.Selling_Price#"/>
								</cfinvoke>
							<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="font-weight:bold;color:red!important">Close</span></a></div></p>
						</div>
						<div id="tab4" class="tab-pane fade #content_active_class[4]#">
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
						</div>
						<!--- Content Close --->
					 <div id="tabclear" class="tab-pane fade" ></div> 
					</div>
							
				</div>
			</div> 
	   </div>
	</section>
</div>	
</cfoutput>




							<!--- <cfelse>	
								<cfif #Get_Vehicle_Options.Installed# NEQ "" >
							  		<li> <a class="#active_class[1]##ln# nav-tabs nav-tab1" data-toggle="tab2" href="###tab1#_2">Installed </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Safety# NEQ "" >
							  		<li> <a class="#active_class[2]##ln# nav-tabs nav-tab2" data-toggle="tab2" href="##tab1#ln#">Safety </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Interior# NEQ "" >
							  		<li> <a class="#active_class[3]##ln# nav-tabs nav-tab3" data-toggle="tab2" href="##tab1#ln#">Interior </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Exterior# NEQ "" >
							  		<li> <a class="#active_class[4]##ln# nav-tabs nav-tab4" data-toggle="tab2" href="##tab1#ln#">Exterior </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Mechanical# NEQ "" >
							  		<li> <a class="#active_class[5]##ln# nav-tabs nav-tab1" data-toggle="tab2" href="##tab1#ln#">Mechanical </a></li>
								</cfif>
								<cfif #Get_Vehicle_Options.Misc# NEQ "" >
							  		<li> <a class="#active_class[6]##ln# nav-tabs nav-tab2" data-toggle="tab2" href="##tab1#ln#">Miscellaneous </a></li>
								</cfif>
							</cfif> --->