
<!--- Contains all ADD-ONS for the VDP Screen 12/16/2015 --->


<cfoutput>

	<!--- Anchor for Make My Deal Kelly Ford & CDJR --->
	<div id="section1_ID"></div>	
	
	<div class="vdp-text">
		<cfif arguments.Certified eq 1 and arguments.New_Used eq "U">
			<div class="pad-10">
				<cfif #url.dealer_id# neq 82 and  #url.dealer_id# neq 249 and  #url.dealer_id# neq 330 and  #url.dealer_id# neq 79 >	
					<img alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
				<cfelse>								
					<cfif #url.dealer_id# eq 82 and #arguments.V_Make# NEQ "Hyundai"> <!--- 02/02/2015 removed Hyundai Certified from Faulkner Mazda --->
						<img alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/#arguments.V_Make#.jpg"/>
					</cfif>							
					<cfif #url.dealer_id# eq 249 OR  #url.dealer_id# eq 330 > <!--- Internetautoreno --->
						<img Alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/images/cpo/logo_DealerCertified.png"/>
					</cfif>				
					<cfif #url.dealer_id# eq 79 > <!--- Faulkner Nissan Jenkintown --->
						<a href="http://faulknernissanjenkintown.com/dealer/faulknernissanjenkintown/nissan_certified_preowned.cfm" target="_blank" >
						<img Alt="#arguments.V_Make#"  class="img-responsive" src="http://dealers.wdautos.com/dealer/faulknernissanjenkintown/images/library/btn_NissanCPO.png"/></a>
					</cfif>
				</cfif>
			</div>
		</cfif>
		
		<!--- KellyNissan 07/02/2015 --->					
		<cfif ( #url.dealer_id# EQ 18 OR #url.dealer_id# EQ 365) and len(arguments.Video_Link) GT 0 ><a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"   src="http://dealers.wdautos.com/images/inventory/btn_LotVantage_Videos.png"/></a></cfif>
		
		<!--- Preston Auto Superstore --->
		<cfif #url.dealer_id# EQ 62 ><br><div align="center"><div class="fatwin-div"><img src="http://dealers.wdautos.com/dealer/prestonsuperstore/images/library/btn_ValueYourTrade.png" Alt="Trade-In Value"></div></div></cfif>
					
		<!--- Kia East Syracuse --->			
		<cfif url.dealer_id eq 343><br/><a href="/forms/trade.cfm" ><img src="http://dealers.wdautos.com/dealer/kiaeastsyracuse/images/icons/btn_KelleyBlueBook.jpg"></a><br/></cfif>
		
		<!--- Stoltz Scion --->	
		<cfif #url.dealer_id# EQ 45 and arguments.New_Used eq "U" and arguments.certified eq "1"  and arguments.V_Make eq "Scion" ><br/><img src="http://dealers.wdautos.com/dealer/stoltzscion/images/library/logo_ScionCPO.png"><br/></cfif>
		
		<!--- Stoltz Scion --->	
		<cfif #url.dealer_id# EQ 45 ><br/><a href="http://#cgi.server_name#/forms/trade.cfm"><img src="http://dealers.wdautos.com/dealer/stoltzscion/images/library/btn_ValueYourTrade_Scion.png"></a><br/></cfif>

		<!--- CarFax EXCEPT for WAM dealers --->	
		<cfif url.Carfax eq 1 and arguments.New_Used eq "U" and ( #url.year# GT 1990 ) AND ( #url.dealer_id# NEQ 36 AND #url.dealer_id# NEQ 28 AND #url.dealer_id# NEQ 37 )>
			<div align="center">
				<cfif arguments.Carfax_One_Owner eq 1>
					<!---one owner--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
				<cfelse>
					<!---carfax--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
				</cfif><br>
			</div>
		</cfif>
		
		<!--- CarFax only on Toyota Certified for WAM --->					
		<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 36 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
			<div align="center">
				<cfif arguments.Carfax_One_Owner eq 1>
					<!---one owner--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
				<cfelse>
					<!---carfax--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
				</cfif>
			</div>
		</cfif>	
		
		<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 37 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
			<div align="center">
				<cfif arguments.Carfax_One_Owner eq 1>
					<!---one owner--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
				<cfelse>
					<!---carfax--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
				</cfif>
			</div>
		</cfif>
		<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 38 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
			<div align="center">
				<cfif arguments.Carfax_One_Owner eq 1>
					<!---one owner--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
				<cfelse>
					<!---carfax--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
				</cfif>
			</div>
		</cfif>
				
		<cfif url.Carfax eq 1 and arguments.New_Used eq "U"   and arguments.certified eq "1" AND #url.dealer_id# EQ 28 AND (arguments.V_Make eq "Toyota" OR arguments.V_Make eq "Hyundai") >  <!--- CarFax only on Toyota Certified for WAM --->
			<div align="center">
				<cfif arguments.Carfax_One_Owner eq 1>
					<!---one owner--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax One Owner"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo_one.png"/></a>
				<cfelse>
					<!---carfax--->
					<a href="http://www.carfax.com/cfm/ccc_DisplayHistoryRpt.cfm?partner=DVW_1&vin=#arguments.Vin#" target="_blank"><img Alt="Carfax"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/cfx_logo.png"/></a>
				</cfif>
			</div>
		</cfif>
							
		<!--- Courtesy Certified  --->							
		<cfif (arguments.Dealer_id eq 288 OR  arguments.Dealer_id eq 67) and arguments.New_Used eq "U" and #arguments.V_Year# GT 1991 >
			<div align="center" >
				<a data-toggle="modal" style="cursor:pointer" data-target="##certModal"><img src="http://dealers.wdautos.com/dealer/courtesylotus/images/icons/logo_CertifiedWarranty.jpg" alt="Certified" /></a> 
			</div>
		</cfif>
				
		<!--- Baierl Certified 04/20/2015  --->
	    <cfif 	( 	#url.dealer_id# eq 1 OR #url.dealer_id# eq 132 OR #url.dealer_id# eq 195 OR #url.dealer_id# eq 16 OR #url.dealer_id# eq 2 OR 
						#url.dealer_id# eq 14 OR #url.dealer_id# eq 3 OR #url.dealer_id# eq 4 OR #url.dealer_id# eq 6 OR #url.dealer_id# eq 148 OR 
							#url.dealer_id# eq 7 OR #url.dealer_id# eq 8 OR #url.dealer_id# eq 9 OR #url.dealer_id# eq 10 OR #url.dealer_id# eq 162 OR 
								#url.dealer_id# eq 12 OR #url.dealer_id# eq 15 ) and #arguments.V_Make# NEQ "FIAT" and #arguments.New_Used# EQ "U" AND #arguments.Certified# eq 0 AND #arguments.Dealer_Display_Name# NEQ "Baierl Fiat"> 
								<!---<div align="center">
									<a data-toggle="modal" style="cursor:pointer" data-target="##baierlModal"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/baierl/pdfs/SUperCarMobile.jpg" alt="Baierl Certified" /></a>
									
								</div>--->
		</cfif>   
		<!--- Baierl Certified --->
						
		<!--- LotVanage Videos 06/26/2015 --->		
		<cfquery name="LV_Video" datasource="ultra10" >
				SELECT    a.LotVantage_video, b.lv_on
				FROM      Vehicles a, dealers b
				WHERE	a.vin='#arguments.Vin#'
				AND		a.dealer_id = b.dealer_id
				and		b.lv_on = 1
		</cfquery>
		<cfif #LV_Video.LotVantage_video# NEQ "" >
			<br>
			<a onclick="javascript:window.open('#LV_Video.LotVantage_video#','vehicletest','width=650px,height=500')" style="display:block;cursor:pointer;" >
			 <img Alt="Internet Special"  class="img-responsive" src="http://dealers.wdautos.com/images/inventory/btn_LotVantage_Videos.png"/></a> 
		</cfif>
		<!--- LotVanage Videos 06/26/2015 --->			
		
		<!--- 04/08/2015 Fayette Honda --->				
		<cfif #url.dealer_id# eq 25 and arguments.New_Used eq "U" >    
			<cfquery name="IS_Fayette" datasource="ultra10" >SELECT Util_fld FROM Vehicles WHERE vin='#arguments.Vin#'</cfquery>
			<cfif #IS_Fayette.util_fld# EQ 1 ><img Alt="Internet Special"  class="img-responsive" src="http://dealers.wdautos.com/dealer/fayettehonda/images/library/icon_Fayette_InternetSpecial.png"/></cfif>
		</cfif>
		
		<!--- EXCLUDE Fayette Honda -25 and WAM -36 --->				
		<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U" and arguments.Dealer_id neq 36 and arguments.Dealer_id neq 25>
			<div class="pad-10">
				<a class="btn btn-navy" href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
					VEHICLE HISTORY REPORT
				</a>
			</div>
		</cfif>
		
		<!--- Washington AutoMall --->			
		<cfif arguments.Autocheck eq 1 and arguments.New_Used eq "U" and ( arguments.Dealer_id eq 36  or arguments.Dealer_id eq 25 ) >  
			<cfif (arguments.V_Make NEQ "Toyota" AND  arguments.V_Make NEQ "Hyundai") and arguments.Certified EQ 0 >
				<div>
					<a   href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
						<img class="img-responsive" src="http://dealers.wdautos.com/dealer/washingtonautomall/images/icons/btn_AutoCheck.png" alt="Vehicle History Report" />
					</a>
				</div>
			</cfif>
			<cfif arguments.V_Make NEQ "Honda" and arguments.Certified EQ 1 >
				<div>
					<a   href="http://#cgi.server_name#/vehicles/autocheck.cfm?Vehicle_ID=#arguments.Vehicle_ID#" target="_blank">
						<img class="img-responsive" src="http://dealers.wdautos.com/dealer/washingtonautomall/images/icons/btn_AutoCheck.png" alt="Vehicle History Report" />
					</a>
				</div>
			</cfif>
		</cfif>
		
		<!--- Kelly Ford --->					
	   	<cfif url.dealer_id eq 236 and #arguments.New_Used# EQ "N" >
			<div class="pad-10">
				<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
			</div>
		</cfif>   
		
		<!--- Washington AutoMall --->
		<cfif url.dealer_id eq 36 and #len(arguments.Video_Link)# GT 0 >
			<div align="center"><a href="javascript:void(null);" onclick="javascript:getVid('#arguments.Video_Link#');"><img Alt="Play Video"  src="http://#cgi.server_name#/images/inventory/icon_playvideo_off_white.png"></a></div>
		</cfif>		

		<!--- Murrays Ford Window Sticker --->					
	   	<cfif (url.dealer_id eq 259 or url.dealer_id eq 252) and #arguments.New_Used# EQ "N" >  
			<div class="pad-10">
				<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
			</div>
		</cfif>   
		
		<!--- Baierl Ford Window Sticker--->
	   	<cfif url.dealer_id eq 6 and #arguments.New_Used# EQ "N" > 
			<div class="pad-10">
				<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/kellyford/images/icons/ford_sticker.png"/></a>
			</div>
		</cfif>   
		
		<!--- Stoltz Ford Window Sticker- --->
	   	<cfif url.dealer_id eq 43 and #arguments.New_Used# EQ "N" > 
			<div class="pad-10">
				<a href="http://fordlabels.webview.biz/webviewhybrid/WindowSticker.aspx?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/stoltzofstmarys/images/icons/ford_sticker.png"/></a>
			</div>
		</cfif>   
	   	<cfif url.dealer_id eq 43 and ( #arguments.New_Used# EQ "N" OR #arguments.New_Used# EQ "U")> 
			<div class="pad-10">
				<script type='text/javascript'>var o={color:'##075CAF',align:'right',headerText:'Send to My Phone',bodyText:'Send this listing to my phone.',logo:'',logoLink:'',startOpen:!0},gid=2714,c=document.createElement('link');c.type='text/css',c.href='https://apps.slicktext.com/IMG/widget/styles/build.css',c.media='all',c.rel='stylesheet',document.body.appendChild(c);var
j=document.createElement('script');j.type='text/javascript',j.src='https://apps.slicktext.com/IMG/widget/scripts/build.js',document.body.appendChild(j);/*
NEED SUPPORT? Email: support@TextUps.com
or call 1.800.278.4670 */</script>

			</div>
		</cfif>   
							 
		<!---   Northepoint CDJR --->					 
	   	<cfif url.dealer_id eq 132 and #arguments.New_Used# EQ "N" >  
			<div class="pad-10">
				<a href="http://www.chrysler.com/hostd/windowsticker/getWindowStickerPdf.do?vin=#arguments.Vin#" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/northpointeauto/images/icons/logo_sticker.jpg"/></a>
			</div>
		</cfif> 
		<!---   Northepoint GM --->   
	   	<cfif url.dealer_id eq 195 and #arguments.New_Used# EQ "N" > 
			<div class="pad-10">
				<a href="http://www.northpointecars.com/f_WindowSticker?VIN=#arguments.Vin#&businessAssociate=221869" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/northpointeautogm/images/icons/logo_sticker.jpg"/></a>
			</div>
		</cfif>   
		
		<!---   Northepoint GM --->
        <cfif url.dealer_id eq 195 > 
			<div class="pad-10">
				<a href="https://dealeronlineretailing.com/GMOR/init.action?vin=#arguments.Vin#&refer=http://www.northpointecars.com/&grti=G1B4133485ST" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/northpointeautogm/images/icons/btn_ShopClickDrive.png"/></a>
			</div>
		</cfif> 
		
		<!---   Pinegar Branson --->
	   	<cfif url.dealer_id eq 83 and #arguments.New_Used# EQ "N" >
			<div class="pad-10">
				<a href="http://www.pinegarchevy.net/f_WindowSticker?VIN=#arguments.Vin#&businessAssociate=118920" target="_blank" ><img alt="Window Sticker"  class="img-responsive" border="0" src="http://dealers.wdautos.com/dealer/pinegarchevy/images/icons/logo_sticker.jpg"/></a>
			</div>
		</cfif> 
		
		<cfif ( #url.dealer_id# eq 24 OR <!--- Faulkner Mazda Harrisburg --->
				 #url.dealer_id# eq 82  OR <!--- Faulkner Mazda Harrisburg --->
				 	#url.dealer_id# eq 78  OR <!--- Faulkner Nissan Harrisburg --->
				 		#url.dealer_id# eq 79 ) and  <!--- Faulkner Nissan Jenkintown --->
				 			arguments.New_Used eq "U">  
			<div align="center">
				<a name="MaxSeLinkPlaceholder" data-vin="#arguments.Vin#"><img alt="Faulkner"  class="img-responsive" src="http://dealers.wdautos.com/dealer/faulknermazdharrisburg/images/icons/image012.png"/></a>
			</div>
		</cfif>	
							
		<!--- Kelly Buick  --->							
		<cfif arguments.Dealer_id eq 32 >
			<div align="center" >
				<!---<a href="http://kellycarbuickgmc.com/dealer/kellybuickgmc/vehicle_range_finder.cfm"><img class="img-responsive" alt="AutoTrader Vehicle Range Finder" src="http://dealers.wdautos.com/dealer/kellybuickgmc/images/library/AutoTrader_Vehicle_Range_Finder.jpg"/></a> --->
                               <a href="http://kellycarbuickgmc.com/forms/trade.cfm"><img class="img-responsive" alt="AutoTrader Vehicle Range Finder" src="http://dealers.wdautos.com/dealer/kellybuickgmc/images/library/icon_KelleyTradeIn.png"/></a> 
			</div>
		</cfif>
							
		<!--- spin car swipetospin script --->
		<cfif 	url.dealer_id EQ 17 or url.dealer_id eq 18 or url.dealer_id eq 365 or url.dealer_id eq 32 or url.dealer_id eq 33 or url.dealer_id eq 34 or url.dealer_id eq 54 or url.dealer_id eq 73 or
					url.dealer_id EQ 76 or url.dealer_id eq 85 or url.dealer_id eq 86 or url.dealer_id EQ 87 or  url.dealer_id EQ 88 or url.dealer_id EQ 89 or url.dealer_id EQ 167 or
	                   url.dealer_id eq 169 or url.dealer_id EQ 170 or url.dealer_id eq 171 or url.dealer_id eq 172 or url.dealer_id EQ 179 or url.dealer_id eq 303 >
                 <script src="http://integrator.swipetospin.com"></script>
        </cfif>  
		
		<!--- Fuccillo KIA of Clay --->					
		<cfif #url.dealer_id# eq 171 >
			<cfif #arguments.V_Model# EQ "K900" >
				<script type="text/javascript">
					var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
					var hl_script = document.createElement("script");
					hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=K900';
					hl_script.type = 'text/javascript';
					hl_script.id = "HL_ScriptCall";
					document.getElementsByTagName('head')[0].appendChild(hl_script);
				</script>
			<cfelseif #arguments.V_Model# EQ "Optima" >
				<script type="text/javascript">
					var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
					var hl_script = document.createElement("script");
					hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=Optima';
					hl_script.type = 'text/javascript';
					hl_script.id = "HL_ScriptCall";
					document.getElementsByTagName('head')[0].appendChild(hl_script);
				</script>
			<cfelseif #arguments.V_Model# EQ "Cadenza" >
				<script type="text/javascript">
					var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
					var hl_script = document.createElement("script");
					hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=Cadenza';
					hl_script.type = 'text/javascript';
					hl_script.id = "HL_ScriptCall";
					document.getElementsByTagName('head')[0].appendChild(hl_script);
				</script>
			<cfelseif #arguments.V_Model# EQ "Sorento" >
				<script type="text/javascript">
					var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
					var hl_script = document.createElement("script");
					hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFCLAY/Delivery.aspx?SiteID=3291&PgID=new_vehicle_details&vin=#arguments.Vin#&stockNumber=#arguments.Stock#&year=#arguments.V_Year#&make=KIA&model=Sorento';
					hl_script.type = 'text/javascript';
					hl_script.id = "HL_ScriptCall";
					document.getElementsByTagName('head')[0].appendChild(hl_script);
				</script>
			</cfif>		
		</cfif>			
					
		<!--- Fuccillo KIA Schenectady --->		
		<cfif #url.dealer_id# eq 180 >
			<cfif #arguments.V_Model# EQ "K900" >
				<script type="text/javascript"> 
				 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
				 var hl_script = document.createElement("script"); 
				 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=K900';
				 hl_script.type = 'text/javascript'; 
				 hl_script.id = "HL_ScriptCall"; 
				 document.getElementsByTagName('head')[0].appendChild(hl_script);
				 </script>
			<cfelseif #arguments.V_Model# EQ "Optima" >
				<script type="text/javascript"> 
				 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
				 var hl_script = document.createElement("script"); 
				 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=Optima';
				 hl_script.type = 'text/javascript'; 
				 hl_script.id = "HL_ScriptCall"; 
				 document.getElementsByTagName('head')[0].appendChild(hl_script);
				 </script>
			<cfelseif #arguments.V_Model# EQ "Cadenza" >
				<script type="text/javascript"> 
				 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
				 var hl_script = document.createElement("script"); 
				 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=Cadenza';
				 hl_script.type = 'text/javascript'; 
				 hl_script.id = "HL_ScriptCall"; 
				 document.getElementsByTagName('head')[0].appendChild(hl_script);
				 </script>
			<cfelseif #arguments.V_Model# EQ "Sorento" >
				<script type="text/javascript"> 
				 var hl_protocol = (("https:" == document.location.protocol) ? "https://" : "http://");
				 var hl_script = document.createElement("script"); 
				 hl_script.src = hl_protocol + 'www.incentivesnetwork.net/Delivery/ClientPaths/FUCCILLOKIAOFSCHENECTADY/Delivery.aspx?SiteID=3145&PgID=new_vehicle_details&vin=1C3CCCCG0FN519483&stockNumber=152C04&year=2015&make=KIA&model=Sorento';
				 hl_script.type = 'text/javascript'; 
				 hl_script.id = "HL_ScriptCall"; 
				 document.getElementsByTagName('head')[0].appendChild(hl_script);
				 </script>

			</cfif>
		</cfif>
 						
	</div>
</cfoutput>						