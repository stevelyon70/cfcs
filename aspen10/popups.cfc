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
								<img class="img-responsive" src="#arguments.Staff_Photo#"/>
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
		
	
		<div id="popModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="container">
					<div class="modal-content modal-pgtxt">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<span class="clearfix"></span>
						<div align="center">
							<cfif len(trim(arguments.link)) gt 0>
								<a href="#arguments.link#"><img class="img-responsive" src="#arguments.img#"/></a>
							<cfelse>
								<img class="img-responsive" src="#arguments.img#"/>
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
							<cfinvoke component="/cfcs/forms/form_trade" method="show_offer">
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
	
	<cffunction name="video_player" description="loads video player in modal" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="assets" required="true">

		<cfquery datasource="Aspen10" name="Get_Videos">
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
														<img src="http://#cgi.server_name#/dealer/#arguments.assets#/videos/#Get_Videos.Thumbnail#">
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