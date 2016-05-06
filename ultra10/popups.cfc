<cfcomponent>

	<cffunction name="test_drive" description="loads test drive form" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="tdModal">
		
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<h3>Schedule a Test Drive on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6"> 
								<cfinvoke component="/cfcs/forms/form_test_drive" method="form_popup">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="findlay_td" description="loads test drive form for findlay" output="yes" access="public">
	<!--- 	
		<!--- arguments --->
		<cfargument name="scrolling" default="no">
		<cfargument name="width" default="100%">
		<cfargument name="height" default="550">
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="FindlaytdModal">
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center">
							<iframe id="iframe_findlay_td" src="http://#cgi.server_name#/dealer/findlaytoyota/inventory_popup.cfm?voi_vin=#arguments.voi_vin#" frameborder="0" scrolling="#arguments.scrolling#" width="#arguments.width#" height="#arguments.height#"></iframe>
						</div>						
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	 --->

	</cffunction>

	<cffunction name="quick_quote" description="loads quick quote" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="qqModal">
		
		
	 	<!--- Clicks Tracker --->
		<!--- <cfoutput> <cfquery datasource="ultra10" name="t_clik">SELECT track_clicks FROM Dealers WHERE dealer_id=#url.Dealer_ID#</cfquery>
		<cfif #t_clik.track_clicks# EQ 1 >
			<cfquery datasource="Ultra10" name="g_Clk">SELECT ID,quote_srp_click FROM Vehicle_Click_Stats WHERE VIN='#arguments.VOI_Vin#' </cfquery>
		 	<cfset g_Clk.quote_srp_click = #g_Clk.quote_srp_click# + 1 > 
			<cfquery datasource="Ultra10" name="Upd_Clk">UPDATE Vehicle_Click_Stats SET quote_srp_click=#g_Clk.quote_srp_click#,last_Upd=#CreateODBCDateTime(now())#WHERE VIN='#arguments.VOI_Vin#'</cfquery>  
		</cfif> </cfoutput>    --->
		<!--- Clicks Tracker --->
		
		
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<cfif #url.dealer_id# neq 25 and #url.dealer_id# neq 36 and #url.dealer_id# neq 37 and #url.dealer_id# neq 28 >
									<h3>Request a Quote on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
									<cfelse>
									<h3>Check Availability on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
									</cfif>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="form_popup">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
    
    <cffunction name="priceAlert" description="loads price alert" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="priceAlert">
		<cfargument name="formtype" default="add" >
		<cfargument name="voi_price" default="0" >
		<cfargument name="returnUrl" default="#cgi.SERVER_NAME#">
		<cfargument name="dealer_id" default="0">
		<cfargument name="V_Year" default="0" >
		<cfargument name="V_Make" default="0" >
		<cfargument name="V_Model" default="0" >
		<cfargument name="V_Trim" default="0" >
		<cfargument name="v_stock" default="" required="no" >
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">									
									<h3>Alert me when the price changes on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_price_alert" method="form_popup">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
									<cfinvokeargument name="formtype" value="#arguments.formtype#"/>
									<cfinvokeargument name="voi_price" value="#arguments.voi_price#"/>
									<cfinvokeargument name="returnUrl" value="#arguments.returnUrl#"/>
									<cfinvokeargument name="v_stock" value="#arguments.v_stock#"/>
							
								</cfinvoke>
							</div>
                            
            <cfscript>								
	            imgObj = new cfcs.vehicles.vehicle_photos();
			</cfscript>
							<div class="col-md-6">#imgObj.first_photo(arguments.voi_vin, arguments.dealer_Id)#
								<!---<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>--->
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="make_an_offer" description="loads a make an offer form" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="maoModal">
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<h3>Make an offer on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="form_mao_popup">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="chk_available" description="Same as Quick Quote with AVAILABILITY labels" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="qqModal">
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<h3>Check Availability on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="form_popup_available">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="rfq" description="loads rfq" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="qqModal">
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<h3>Request More Information on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="form_popup">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	<cffunction name="adddetl" description="loads Additional Details" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="false">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="qqModal">
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<h3>Fill out this form to get additional savings on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="form_addsave">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="eprc2" description="loads eprice" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		<cfargument name="form_mode" default="standard">
		<cfargument name="modal_name" default="qqModal">
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="#arguments.modal_name#Label" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="row">
								<div class="col-md-12" align="center">
									<h3>Receive an e-Price on this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#</h3>
								</div>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_quick_quote" method="form_ePrice">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	
	
	
	
	
	<cffunction name="send_friend" description="loads send friend form" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="voi_vin" required="true">
		
		<div id="friendModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="friendModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="col-md-12" align="center">
								<h3>Send this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim# to a friend</h3>
							</div>
						</div>
						<cfset url.v_comments="Check out this #arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim# at #url.Dealer_Name#">
						<div class="row">
							<div class="col-md-6">
								<cfinvoke component="/cfcs/forms/form_friend" method="form_popup">
									<cfinvokeargument name="Dealer_ID" value="#arguments.Dealer_ID#"/>
									<cfinvokeargument name="VOI_Vin" value="#arguments.VOI_Vin#"/>
									<cfinvokeargument name="VOI_New_Used" value="#arguments.VOI_New_Used#"/>
								</cfinvoke>
							</div>
							<div class="col-md-6">
								<cfinvoke component="/cfcs/vehicles/vehicle_photos" method="single_photo">
									<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
									<cfinvokeargument name="Img_Urls" value="#arguments.Img_Urls#"/>
									<cfinvokeargument name="img_title" value="#arguments.V_Year# #arguments.V_Make# #arguments.V_Model# #arguments.V_Trim#"/>
									<cfinvokeargument name="img_class" value="vdp-img"/>
								</cfinvoke>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="staff_bio" description="loads staff bio" output="yes" access="public">
		
		<!--- arguments --->
		<cfargument name="person_id" required="true">
		<cfargument name="Staff_Photo" required="true">
		<cfargument name="Staff_Name" required="true">
		<cfargument name="Staff_Position" required="true">
		<cfargument name="Staff_Email" required="true">
		<cfargument name="Staff_Bio" required="true">
		
		<div id="bio#arguments.person_id#_Modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="bio#arguments.person_id#_ModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="row">
							<div class="col-md-2"></div>							
							<div class="col-md-2">
								<img class="img-responsive alt="Staff Bio"" src="#arguments.Staff_Photo#"/>
							</div>
							<div class="col-md-8">
								<div class="row">
									<div class="col-md-12">
										<h3>#arguments.Staff_Name#, #arguments.Staff_Position#</h3>
										<a href="mailto:#arguments.Staff_Email#">#arguments.Staff_Email#</a>										
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										#arguments.Staff_Bio#
									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="iframe" description="loads iframe in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="iframe_src" required="true">
		<cfargument name="pop_name" required="true">
		<cfargument name="scrolling" default="no">
		<cfargument name="width" default="100%">
		<cfargument name="height" default="400">
		<cfargument name="close_function" default="">
		
	
		<div id="#arguments.pop_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="pgtxtModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button <cfif len(trim(arguments.close_function)) gt 0>onclick="#arguments.close_function#"</cfif> type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center">
							<iframe id="iframe_#arguments.pop_name#" src="http://#cgi.server_name#/blank.html" frameborder="0" scrolling="#arguments.scrolling#" width="#arguments.width#" height="#arguments.height#"></iframe>
						</div>
						<br/>
						<div class="clearfix"></div>
						<button <cfif len(trim(arguments.close_function)) gt 0>onclick="#arguments.close_function#"</cfif> type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="page_text" description="loads page text in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="page_text" required="true">
	
		<div id="pgtxtModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="pgtxtModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						#arguments.page_text#
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="homepage_pop" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="img" required="true">
		<cfargument name="link" default="">
		<cfargument name="BG_Color" default="ffffff">
		
	 
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel"  aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt" style="background-color:###arguments.BG_Color#;">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix" style="background-color:###arguments.BG_Color#;"></span>
						<div align="center" style="background-color:###arguments.BG_Color#;">
							<cfif len(trim(arguments.link)) gt 0>
								<a href="#arguments.link#"><img class="img-responsive" src="#arguments.img#"/></a>
							<cfelse>
								<img class="img-responsive" alt="Homepage" src="#arguments.img#"/>
							</cfif>
						</div>
						<div class="clearfix" style="background-color:###arguments.BG_Color#;"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix" style="background-color:###arguments.BG_Color#;"></div>
					</div>
					
				</div>
			</div>
		</div>	

	</cffunction>
	
	<cffunction name="srp_vdp_pop" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="img" required="true">
		<cfargument name="link" default="">
		<cfargument name="BG_Color" default="ffffff">
		<cfargument name="form_name" default="price_search">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/email_event_action.cfm">
		<cfargument name="voi_new_used" default="">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="register-btn">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
		
		<cfset err_style = "" >
		<cfif IsDefined("url.err_msg") and #len(url.err_msg)# GT 0 >
			<cfset err_style = "background-color:yellow" >
		</cfif>
		
		<cfset t_voi_vin = ""><cfset t_voi_new_used = ""><cfset t_voi_year = "">
		<cfset t_voi_make = "">	<cfset t_voi_model = ""><cfset t_voi_stock = "">
		<!--- <cfif left(cgi.remote_addr,13) eq "172.16.25.112" and IsDefined("voi_vin") > --->
		<cfif #url.dealer_id# EQ 365 and IsDefined("url.vin") >
			<cfquery datasource="ultra10" name="get_car">SELECT vin, stock,v_new_used, v_make,v_model,v_year FROM vehicles WHERE dealer_id = 365 AND vin='#url.vin#' </cfquery>
			<cfif #get_car.recordcount# NEQ 0 >
				<cfset t_voi_vin = "#get_car.vin#"><cfset t_voi_new_used = "#get_car.v_new_used#"><cfset t_voi_year = "#get_car.v_year#">
				<cfset t_voi_make = "#get_car.v_make#"><cfset t_voi_model = "#get_car.v_model#"><cfset t_voi_stock = "#get_car.stock#">
			</cfif>
		</cfif>

	 
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel"  aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt" style="background-color:###arguments.BG_Color#;">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix" style="background-color:###arguments.BG_Color#;"></span>
						<div align="center" style="background-color:###arguments.BG_Color#;">
							
	    <div class="row">

			<div class="col-md-7  visible-sm visible-xs  visible-lg visible-md" >	
			<cfif #arguments.dealer_id# NEQ 365 >
		    	<img src="http://dealers.wdautos.com/dealer/baierl/images/library/2016MalibuEvent_FormGraphic.jpg" width="100%" alt="Chevrolet Malibu Launch Event on March 10th"/>
			<cfelse>
				 <cfif left(cgi.remote_addr,13) eq "172.16.25.112" >#t_voi_vin# - #t_voi_new_used# - #t_voi_year# - #t_voi_make# - #t_voi_model#  </cfif>   
		    	<img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/form_testdrivegraphic.jpg" width="100%" alt="March Mania Sales Event"/>
			</cfif>
			</div>
				
			<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md"   >	
			<cfif #arguments.dealer_id# NEQ 365 >
				<div class="register_title" >2016 Chevy Malibu Reveal - RSVP here</div>
			<cfelse>
				<div class="register_title" >Complete this form to claim your gift card worth up to $100 with a test drive!<br>Hurry Offer Ends 3/31/2016.</div>	
				
			</cfif>	
				<!--- <span class="register_text" >Fill out the form below</span> --->
				<form action="#arguments.form_action#" method="post">
					<input type="hidden" name="Delivery_Dealer_ID" id="Delivery_Dealer_ID" value="#arguments.dealer_id#">
					<input type="hidden" name="Dealer_ID" id="Dealer_ID" value="#arguments.dealer_id#">
					<input type="hidden" name="voi_vin" id="voi_vin" value="#t_voi_vin#">
					<input type="hidden" name="voi_new_used" id="voi_new_used" value="#t_voi_new_used#">
					<input type="hidden" name="voi_year" id="voi_year" value="#t_voi_year#">
					<input type="hidden" name="voi_make" id="voi_make" value="#t_voi_make#">
					<input type="hidden" name="voi_model" id="voi_model" value="#t_voi_model#">
					<input type="hidden" name="voi_stock" id="voi_stock" value="#t_voi_stock#">
			<cfif #arguments.dealer_id# NEQ 365 AND  #arguments.dealer_id# NEQ 358 >
					<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First & Last Name" required>
			<cfelse>
					<input class="#arguments.input_class#" name="First_Name" id="First_Name" style="margin-bottom:10px" type="text" maxlength="50" placeholder="* First Name" required>
 					<input class="#arguments.input_class#" name="Last_Name" id="Last_Name" style="margin-bottom:5px" type="text" maxlength="50" placeholder="* Last Name" required> 
			</cfif>
					<input class="#arguments.input_class#" name="Email" id="Email" type="email" style="margin-bottom:10px" maxlength="100" placeholder="* Email" required>
					<input class="#arguments.input_class#" name="Phone_1" id="Phone_1" type="text"  style="margin-bottom:10px" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
			<cfif #arguments.dealer_id# NEQ 365 >
					<input class="#arguments.input_class#" name="Guests" id="Guests" type="text" style="margin-bottom:10px" maxlength="50" placeholder="## of Guests (including yourself)" required>
			</cfif>		
					<cfif #arguments.dealer_id# NEQ 365 AND  #arguments.dealer_id# NEQ 358 >
					<br><input class="register-go-btn pull-right"   name="Submit" id="Submit"   type="submit" value="Register Now">
					<cfelse>
					<div style="align:center!important"><input class="register-go-btn"   name="Submit" id="Submit"   type="submit" value="Get My Visa Reward Card"></div>
					</cfif>
				</form>
				
				<cfif #arguments.dealer_id# EQ 365 >
				 
					<div class="register_big_button_container" style="align:center;margin-top:10px!important" >
						<div class="register_big_button_text"><a href="http://kellynissanofroute33.com/new/offers.cfm" ><img src="http://dealers.wdautos.com/dealer/kellynissanevent/images/library/btn_MarchMania_ViewSpecials.jpg" width="100%" alt="March Mania Sales Event"/></a></div>
					</div>		
				</cfif>			
			</div>		
				

        </div>  <!--- End ROW --->

						</div>
						<div class="clearfix" style="background-color:###arguments.BG_Color#;"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix" style="background-color:###arguments.BG_Color#;"></div>
					</div>
					
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="trade_in_pop" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="BG_Color" default="ffffff">
		
	
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="trade-modal" style="background-color:###arguments.BG_Color#;" >
						<cfif #arguments.dealer_id# NEQ 79 >
							<cfinvoke component="/cfcs/forms/form_trade" method="show_offer">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="form_mode" value="popup"/>
							</cfinvoke>
						<cfelse>
							<cfinvoke component="/cfcs/forms/form_trade" method="show_offer_v1">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="form_mode" value="popup"/>
							</cfinvoke>	
						</cfif>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	

	<cffunction name="we_buy_cars_pop" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="BG_Color" default="ffffff">
		
	
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="trade-modal" style="background-color:###arguments.BG_Color#;" >
						 
							<cfinvoke component="/cfcs/forms/form_trade" method="used_car_buy">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="form_mode" value="popup"/>
							</cfinvoke>	 
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	

	<cffunction name="coupon_td_pop" description="loads Coupon popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="BG_Color" default="ffffff">
		
	
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="trade-modal" style="background-color:###arguments.BG_Color#;" >
							<cfinvoke component="/cfcs/forms/form_trade" method="show_contact">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="form_mode" value="popup"/>
							</cfinvoke>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	<cffunction name="contact_us_pop" description="loads popup in modal" output="yes" access="public">  <!--- New 12/26/2014 --->

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="BG_Color" default="ffffff">
		
	
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="trade-modal" style="background-color:###arguments.BG_Color#;" >
							<cfinvoke component="/cfcs/forms/form_trade" method="show_contact">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="form_mode" value="popup"/>
							</cfinvoke>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	<cffunction name="promotion_pop" description="loads popup in modal" output="yes" access="public">  <!--- New 12/26/2014 --->

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="BG_Color" default="ffffff">
		
	
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="trade-modal" style="background-color:###arguments.BG_Color#;" >
							<cfinvoke component="/cfcs/forms/form_promotion" method="show_offer_v1">
								<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
								<cfinvokeargument name="form_mode" value="popup"/>
							</cfinvoke>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="nissan_copyright" description="loads popup in modal" output="yes" access="public">

		<div id="copyModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-nissan-copy">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div>The Nissan names, logos, product names, feature names, and slogans are trademarks owned by or licensed to Nissan Motor Co. Ltd. and/or Nissan North America, Inc. 2002-#dateformat(now(),"yyyy")# Nissan North America, Inc. All rights reserved. Materials contained on this Web site may not be used or reproduced without written permission from Nissan North America, Inc.</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>

	<cffunction name="v_disclaimer" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="modal_name" default="discModal">
		<cfargument name="Disclaimer" default="">
	
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-disclaimer-copy">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div style="padding:50px 0px 50px 0px;">#arguments.Disclaimer#</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	<cffunction name="courtesy_certified" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="modal_name" default="certModal">
		<cfargument name="Disclaimer" default="">
	
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center"  >
								<img class="img-responsive" alt="Certified" src="http://dealers.wdautos.com/dealer/autobuysmart/images/library/standardcoveragewarranty.jpg"/></div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	<cffunction name="baierl_certified" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="modal_name" default="baierlModal">
		<cfargument name="Disclaimer" default="">
	
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center"  >
								<img class="img-responsive" alt="Certified" src="http://dealers.wdautos.com/dealer/baierl/images/library/supercertified.jpg"/></div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	<cffunction name="turkeypop" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="modal_name" default="turkeypop">
		<cfargument name="Disclaimer" default="">
		<cfargument name="image_src" default="0">
		<cfif #arguments.image_src# EQ 0 >
			<cfset variables.imagesrc = "big_mailer.jpg">
		<cfelse>
			<cfset variables.imagesrc = "big_card.jpg">
		</cfif>
	
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center"  >
								<img class="img-responsive" alt="Visa Card" src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/#variables.imagesrc#"/></div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	
	<cffunction name="youtubepop" description="loads popup in modal" output="yes" access="public">
			<!--- arguments --->
		<cfargument name="modal_name" default="youtubepop">
		<cfargument name="Disclaimer" default="">
		<cfargument name="bg_color" default="">
		<cfargument name="image_src" default="0">
		<cfargument name="video" default="">
		
		<cfset bgstyle = "" >
		<cfif #arguments.bg_color# NEQ "" ><cfset bgstyle = "background-color:###arguments.bg_color#!important" ><cfelse><cfset bgstyle = "background-color:transparent!important" ></cfif>
		
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" style="#bgstyle#">
				<div class="container" style="#bgstyle#" align="center">
					<div class="modal-content modal-pgtxt" style="#bgstyle#">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="trade-modal" style="#bgstyle#" >
							 <iframe 	width="800px" 
								 			height="600px" 
											src="#arguments.video#" 
											frameBorder="0"  
											hspace="0" 
											vspace="0" 
											marginheight="0"
											allowfullscreen>
								</iframe> 
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	
 
	</cffunction>
	
	
	<cffunction name="toyotacare" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="modal_name" default="toyotacare">
		<cfargument name="Disclaimer" default="">
		<cfargument name="image_src" default="0">
		
	
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div class="col-md-12" align="center"  >
<!---  --->						
    <div>
      <p style="font-size: 16px;margin-bottom:2px!important" align="left"><b>Peace of Mind Comes Standard</b></p>
	  <!--- <h3 align="left">Peace of Mind Comes Standard</h3> --->
	  <p style="font-size: 12px;" align="left"><em>(Included with every new Toyota purchase)</em></p>
      <p align="left">As part of the Toyota family, your exceptional ownership experience starts with ToyotaCare*, a no cost maintenance plan with 24-hour roadside assistance. The ToyotaCare plan covers normal factory scheduled maintenance for 2 years or 25,000 miles, whichever comes first. 24-hour roadside assistance is also included for 2 years and unlimited miles.</p>
     
      <p style="font-size: 12px;" align="left"><em>*ToyotaCare covers normal factory scheduled service for 2 years or 25,000 miles, whichever comes first.  See Toyota dealer for details and exclusions. Valid only in the continental U.S. and Alaska.</em></p>
      <table style="width: 100%;">
        <tr>
         <td colspan="2" align="left" style="padding:5px 0;"><strong>ToyotaCare Includes:</strong></td>
          </tr>
        <tr>
          <td style="padding:15px; width:50%x;" valign="top">
          <div><img src="http://dealers.wdautos.com/dealer/toyotaservice/images/library/img_ToyotaCare_Wrench.png" height="89" width="88" alt="toyotacare wrench"></div>
          
            <p><strong>Maintenance</strong><br>
              Toyota-trained technicians will help you fulfill maintenance obligations and help improve your Toyota's overall performance while keeping a complete history of maintenance visits. Toyota will also deliver timely reminders before your scheduled maintenance.</p>
 <p><strong>ToyotaCare Recommended Services Include:</strong>
            
            <ul>
              <li>Replace engine oil and oil filter</li>
              <li>Rotate tires</li>
              <li>Multi-point vehicle inspection</li>
              <li>Inspect and adjust all fluid levels</li>
            </ul>
            </p></td>
           <td style="padding:15px; width:50%;" valign="top">
          <div><img src="http://dealers.wdautos.com/dealer/toyotaservice/images/library/img_ToyotaCare_Road.png" height="89" width="88" alt="toyotacare road"></div>
          
<p><strong>24-Hour Roadside Assistance**</strong><br>

ToyotaCare features 24-hour roadside assistance available at no cost for 2 years from the effective date, and unlimited miles.</p>

<p><strong>24-hour Roadside Assistance Covers:</strong>
            
            <ul>
              <li>Battery Jump Start</li>
              <li>Lockout Protection</li>
              <li>Emergency Fuel Delivery</li>
              <li>Tire Service</li>
              <li>Towing</li>
              <li>Winching</li>
            </ul>
            </p>
            <p style="font-size:10px;">**Does not include parts and fluids, except emergency fuel delivery.  Valid only in the continental U.S. and Alaska.</p></td>
     
        </tr>
        <tr>
          
          <td colspan="2" style="padding:10px 0;"><p style="font-size:10px;">Call 24/7 for Roadside Assistance. Valid only in the continental U.S. and Alaska. 1-800-444-4195<br>
              </p></td>
          <td></td>
        </tr>
      </table>
    
  </div>
						
						
<!---  --->				</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	
	
	
	<cffunction name="makemydeal" description="loads popup in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="modal_name" default="certModal">
		<cfargument name="Disclaimer" default="">
	
		<div id="#arguments.modal_name#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container" align="center">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center"  >				
					<div class="row">
					<div id="mmd-widget"></div>
						<!--- <cfif #arguments.New_Used# EQ "N">
							<script>
							    mmd.loadWidget({
						        listedPrice: #arguments.Selling_Price#,
						        vehicleStatus: 1,
						        vin: "#arguments.Vin#",
						        year: #arguments.V_Year#,
						        make: "#arguments.V_Make#",
						        model: "#arguments.V_Model#",
						        trim: "#arguments.V_Trim#",
						        img: "#variables.pass_img#",
						        stock: "#arguments.Stock#",
						        mileage: #arguments.Odometer#,
						        url: document.URL,
						        widgetType: "compact",
						        onLoadedFunction: function() { 
						        console.log('widget loaded'); 
						        },
						        onHidingFunction: function() { 
						        console.log('widget not showing');
						       }
							   	});
							</script>
						<cfelse>
							<script>
							    mmd.loadWidget({
						        listedPrice: #arguments.Selling_Price#,
						        vehicleStatus: 0,
						        vin: "#arguments.Vin#",
						        year: #arguments.V_Year#,
						        make: "#arguments.V_Make#",
						        model: "#arguments.V_Model#",
						        trim: "#arguments.V_Trim#",
						        img: "#variables.pass_img#",
						        stock: "#arguments.Stock#",
						        mileage: #arguments.Odometer#,
						        url: document.URL,
						        widgetType: "compact",
						        onLoadedFunction: function() { 
						        console.log('widget loaded'); 
						        },
						        onHidingFunction: function() { 
						        console.log('widget not showing');
						       }
							   	});
							</script>
						</cfif> --->
					</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>	

	</cffunction>
	
	<cffunction name="video_player" description="loads video player in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">

		<cfquery datasource="ultra10" name="Get_Videos">
			SELECT		Dealer_Video_ID,
						Dealer_ID,
						Video_Name,
						Thumbnail,
						FLV_URL,
						HTML5_URL,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		Dealer_Videos
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			FLV_URL is not null
			ORDER BY 	Hierarchy
		</cfquery>

		<script src="#url.boostrap_url#/flowplayer/flowplayer-3.2.13.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="http://cdn.jquerytools.org/1.2.6/tiny/jquery.tools.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="#url.boostrap_url#/flowplayer/flowplayer.playlist-3.2.11.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="#url.boostrap_url#/flowplayer/flowplayer.ipad-3.2.13.min.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="#url.boostrap_url#/flowplayer/playlist-horizontal.css"/>
			
		<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="video-modal"><!--- modal-dialog --->
				<div class="container">
					<div class="modal-content video-content">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center">
							<a id="player" class="player"></a>
							<div class="playlist_wrap">
								<a class="prev"></a>
									<div id="pl">
										<div class="entries">
											<div class="page">
												<cfloop query="Get_Videos">
													<a video href="#Get_Videos.FLV_URL#" title="#Get_Videos.Video_Name#">
														<img alt="#Get_Videos.Video_Name#" src="http://#cgi.server_name#/dealer/#arguments.assets#/videos/#Get_Videos.Thumbnail#">
													</a>
													<cfif Get_Videos.currentrow mod 4 eq 0>
														</div><div class="page">
													</cfif>
												</cfloop>
											</div>
										</div>
									</div>
								<a class="next"></a>
							</div>
						</div>
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary modal-close pull-right" data-dismiss="modal">Close</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
		
		
		<script>
		$(function() {
			// set up the player
			$f("player", "#url.boostrap_url#/flowplayer/flowplayer-3.2.18.swf", {
				clip: {
					autoPlay: false,
					autoBuffering: true
				}
			// the iPad plugin and the playlist plugin
			}).ipad().playlist("div.entries");
			// set up scrolling for the playlist elements
			$("##pl").scrollable();
		});
		</script>

	</cffunction>

</cfcomponent>