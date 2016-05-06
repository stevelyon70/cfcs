<cfcomponent>

	<cffunction name="vdp_default" description="shows default vdp pricing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Selling_Price_Label" default="">
		<cfargument name="Selling_Price" default="">
		<cfargument name="MSRP_Label" default="">
		<cfargument name="MSRP_Price" default="">
		<cfargument name="Rebate_Label" default="">
		<cfargument name="Rebate_Price" default="">
		<cfargument name="Incentive_Label" default="">
		<cfargument name="Incentive_Price" default="">
		<cfargument name="Savings_Label" default="">
		<cfargument name="Savings_Price" default="">
		<cfargument name="AIS_Label" default="">
		<cfargument name="AIS_Price" default="">
		<cfargument name="AIS_APR" default="">
		<cfargument name="Adjusted_Baseline" default="">
		<cfargument name="VOI_Vin" default="">
		
	<!--- Check for Custom Pricing Color  --->
		<cfset variables.cust_btns = 0 >
		<cfset variables.price_display = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns, call_for_price_phone, price_display_variation  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		<cfset variables.price_display = #Chk_Srch.price_display_variation# >
		
		<cfset variables.dial = "" >
		<cfif #Chk_Srch.call_for_price_phone# NEQ "" >
			<cfquery datasource="Ultra10" name="Get_Phones">SELECT Area_Code,Prefix,Line_Number,Vanity_Number,Phone_Label FROM Dealer_Phones WHERE phone_id=#Chk_Srch.call_for_price_phone# AND dealer_id=#url.dealer_id#</cfquery>
			<cfset variables.dial="#Get_Phones.Area_Code##Get_Phones.Prefix##Get_Phones.Line_Number#">
		</cfif>	  
		
		<cfquery datasource="ultra10" name="Get_pb_color">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 4
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_pb_btns = #Get_pb_color.recordcount# >
	<!--- Check for Custom Pricing Color--->
	 <cfif #variables.cust_btns# EQ 1 AND #variables.nbr_pb_btns# GT 0 >
		
		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<div class="price-block-cust">
				<cfif #Get_pb_color.Btn_Link_Target# NEQ "modal" > 
					#Get_pb_color.Btn_Title#
				<cfelse>
					<a class="btn price-block-cust" data-toggle="modal" data-target="###arguments.VOI_Vin#Modal#RTrim(Get_pb_color.modal_type)#" >
						#Get_pb_color.Btn_Title#
					</a>
				</cfif>
			</div>
		<cfelse>
			<cfif arguments.MSRP_Price gt 0><div class="price-alt"><b>#ucase(arguments.MSRP_Label)#: <span class="pull-right">$#numberformat(arguments.MSRP_Price)#</span></b></div></cfif>
		
			<cfif arguments.Adjusted_Baseline gt 0 and  arguments.Adjusted_Baseline gt arguments.Selling_Price and (arguments.Adjusted_Baseline neq arguments.MSRP_Price) and (arguments.Adjusted_Baseline neq arguments.Selling_Price)>
				<div class="price-alt"><b>#ucase(arguments.Selling_Price_Label)#: <span class="pull-right">$#Numberformat(arguments.Adjusted_Baseline)#</span></b></div>
			</cfif>
			<cfif arguments.Rebate_Price gt 0><div class="price-alt"><b>#ucase(arguments.Rebate_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Rebate_Price)#</span></b></div></cfif>
			<cfif arguments.Incentive_Price gt 0><div class="price-alt"><b>#ucase(arguments.Incentive_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Incentive_Price)#</span></b></div></cfif>
			<cfif arguments.AIS_Price gt 0><div class="price-alt"><b>#ucase(arguments.AIS_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.AIS_Price)#</span></b></div></cfif>
			<cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
				<div class="price-break"></div>
			</cfif>
			<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
			<div class="price-sell-lab">#ucase(arguments.Selling_Price_Label)#:</div>
			<div class="price-block-cust"><cfif url.dealer_id eq 70 and url.new_used is 'N'><del></cfif>$#numberformat(arguments.Selling_Price)#<cfif url.dealer_id eq 70 and url.new_used is 'N'></del></cfif></div>
			<cfif arguments.Savings_Price gt 0>
                <cfif (url.dealer_id neq 70 and url.new_used is 'N') or (url.dealer_id eq 70 and url.new_used is 'U')>
            	<div class="price-save">
                	<b>#ucase(arguments.Savings_Label)#: <span class="pull-right">$#numberformat(arguments.Savings_Price)#</span></b>
                </div>
                </cfif>
            </cfif>
		</cfif>
		
	<cfelse>    
	
		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<cfif #url.dealer_id# NEQ 55 > 
				<cfif #url.dealer_id# eq 181 OR  #url.dealer_id# eq 303 >
					<cfset msg_txt = "Call For Price">
					<cfif #url.new_used# EQ "U">
						<cfset msg_txt = "KBB PRICES ON ALL PRE-OWNED">
						<div class="price-call-price-red" style="font-size:10pt;font-weight:bold">#msg_txt#</div>
					<cfelse>	
						<div class="price-call-price-red">#msg_txt#</div>
					</cfif>
				<cfelse> 
					<div class="price-call-price-red">Call For Price</div>
				</cfif> 
			<cfelse>
				<div class="price-call-price-red" align="center">You Are Approved</div>	<!--- Jim Butner 01/19/2015 bob --->
			</cfif>
		<cfelse>
			 <cfif variables.price_display EQ 0 > 
				<cfif arguments.MSRP_Price gt 0><div class="price-alt"><b>#ucase(arguments.MSRP_Label)#: <span class="pull-right">$#numberformat(arguments.MSRP_Price)#</span></b></div></cfif>
			 </cfif>  
<!--- 04-22-2016 bob  All Baierl Sites --->
 <cfif  ( 	#url.dealer_id# eq 1 OR #url.dealer_id# eq 132 OR #url.dealer_id# eq 195 OR #url.dealer_id# eq 16 OR 
				#url.dealer_id# eq 2 OR #url.dealer_id# eq 14 OR #url.dealer_id# eq 3 OR #url.dealer_id# eq 4 OR 
					#url.dealer_id# eq 6 OR #url.dealer_id# eq 148 OR #url.dealer_id# eq 7 OR #url.dealer_id# eq 8 OR 
						#url.dealer_id# eq 9 OR #url.dealer_id# eq 10 OR #url.dealer_id# eq 162 OR #url.dealer_id# eq 12 OR 
							#url.dealer_id# eq 15 ) AND #url.new_used# EQ "U" AND #arguments.Selling_Price# LTE 2500 >   
			<div class="price-call-price-red">Call For Price</div> 
<cfelse>  

 	<cfif variables.price_display EQ 0 >   
				<cfif arguments.Adjusted_Baseline gt 0 and  arguments.Adjusted_Baseline gt arguments.Selling_Price and (arguments.Adjusted_Baseline neq arguments.MSRP_Price) and (arguments.Adjusted_Baseline neq arguments.Selling_Price)>
					  <cfif #url.dealer_id# NEQ 257 >    <!--- Tri-Star Nissan Temporary label change  05/21/2015  --->
					<div class="price-alt"><b>#ucase(arguments.Selling_Price_Label)#: <span class="pull-right">$#Numberformat(arguments.Adjusted_Baseline)#</span></b></div>
					  <cfelse>
					<div class="price-alt"><b>SALE PRICE: <span class="pull-right">$#Numberformat(arguments.Adjusted_Baseline)#</span></b></div>
					</cfif>  
				</cfif>
				<cfif arguments.Rebate_Price gt 0><div class="price-alt"><b>#ucase(arguments.Rebate_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Rebate_Price)#</span></b></div></cfif>
				<cfif arguments.Incentive_Price gt 0><div class="price-alt"><b>#ucase(arguments.Incentive_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Incentive_Price)#</span></b></div></cfif>
				<cfif arguments.AIS_Price gt 0><div class="price-alt"><b>#ucase(arguments.AIS_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.AIS_Price)#</span></b></div></cfif>
				<cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
					<div class="price-break"></div>
				</cfif>
				
					<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
                    
					<div class="price-sell-lab">#ucase(arguments.Selling_Price_Label)#:</div>
					<div class="price-sell-price-red"><!--- <cfif url.dealer_id eq 70 and url.new_used is 'N'><del></cfif> --->$#numberformat(arguments.Selling_Price)#<!--- <cfif url.dealer_id eq 70 and url.new_used is 'N'></del></cfif> ---></div>
					<cfif arguments.Savings_Price gt 0>
                    	<cfif (url.dealer_id neq 70 and url.new_used is 'N') or (url.dealer_id eq 70 and url.new_used is 'U')>
	                    	<div class="price-save"><b>#ucase(arguments.Savings_Label)#: <span class="pull-right">$#numberformat(arguments.Savings_Price)#</span></b></div>
                        </cfif>
                    </cfif>
	  <cfelse>
				
					
				
				 <div class="price-sell-lab">#ucase(arguments.MSRP_Label)#:</div>
				<cfif #arguments.MSRP_Price# NEQ 0 AND #arguments.MSRP_Price# NEQ "" >
					<div class="price-sell-price-red">$#numberformat(arguments.MSRP_Price)#</div>	
				<cfelse>
					<div class="price-sell-price-red">$#numberformat(arguments.Adjusted_Baseline)#</div>		
				</cfif>  
	</cfif>		 
				<cfif #url.dealer_id# EQ 54 ><!---  Pgh East & West Hills Nissan 02/04/2015 --->
					<!--- <script type="text/javascript" src="http://automarksolutions.com/plugin/BRO/check/?did=2098&vin=#arguments.VOI_Vin#&im="></script> --->
				<cfelseif  #url.dealer_id# EQ 52>
					<!---<script type="text/javascript" src="http://automarksolutions.com/plugin/BRO/check/?did=2099&vin=#arguments.VOI_Vin#&im="></script>	--->
				</cfif>

		 	<cfif url.dealer_id eq 70 and url.new_used is 'N'>
            	<div align="center">
            		<img src="/dealer/findlaytoyota/images/library/btn_ePrice.jpg" data-toggle="modal" data-target="##<cfif cgi.SCRIPT_NAME contains '/new/'>#arguments.VOI_Vin#Modalrfq<cfelse>qqModal</cfif>">
                </div>               
            </cfif>
</cfif>	 	
		</cfif>
		
	   </cfif>	 
		<!---arguments.AIS_APR--->
	 
						<!--- <cfif (#url.dealer_id# eq 78  and  #url.New_Used# eq "N") AND IsDefined("url.frmscrn") >  <!--- Faulkner Nissan Harrisburg 04/07/2015 --->
							 
							<a data-toggle="modal" data-target="###arguments.VOI_Vin#Modaleprc2"><img  Alt="Faulkner" class="img-responsive" src="http://dealers.wdautos.com/dealer/faulknernissan/images/icons/btn_GetEprice.jpg"/></a>
							 
						</cfif>	     --->
				

	</cffunction>

	<cffunction name="vdp_default_new" description="shows default vdp pricing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Selling_Price_Label" default="">
		<cfargument name="Selling_Price" default="">
		<cfargument name="MSRP_Label" default="">
		<cfargument name="MSRP_Price" default="">
		<cfargument name="Rebate_Label" default="">
		<cfargument name="Rebate_Price" default="">
		<cfargument name="Incentive_Label" default="">
		<cfargument name="Incentive_Price" default="">
		<cfargument name="Savings_Label" default="">
		<cfargument name="Savings_Price" default="">
		<cfargument name="AIS_Label" default="">
		<cfargument name="AIS_Price" default="">
		<cfargument name="AIS_APR" default="">
		<cfargument name="Adjusted_Baseline" default="">
		<cfargument name="VOI_Vin" default="">

		
	<!--- Check for Custom Pricing Color  --->
		<cfset variables.cust_btns = 0 >
		<cfset variables.price_display = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns, call_for_price_phone,  price_display_variation  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		<cfset variables.price_display = #Chk_Srch.price_display_variation# >

 <cfif #url.dealer_id# EQ 365 AND #cgi.server_name# EQ "4ultra10.wddemos.com" ><cfset variables.price_display = "1" ></cfif>	
		
		<cfset variables.dial = "" >
		<cfif #Chk_Srch.call_for_price_phone# NEQ "" >
			<cfquery datasource="Ultra10" name="Get_Phones">SELECT Area_Code,Prefix,Line_Number,Vanity_Number,Phone_Label FROM Dealer_Phones WHERE phone_id=#Chk_Srch.call_for_price_phone# AND dealer_id=#url.dealer_id#</cfquery>
			<cfset variables.dial="#Get_Phones.Area_Code##Get_Phones.Prefix##Get_Phones.Line_Number#">
		</cfif>	  
		
		<cfquery datasource="ultra10" name="Get_pb_color">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 4
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_pb_btns = #Get_pb_color.recordcount# >
	<!--- Check for Custom Pricing Color--->
		
	 <cfif #variables.cust_btns# EQ 1 AND #variables.nbr_pb_btns# GT 0 >
		
		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<div class="price-block-cust">
				<cfif #Get_pb_color.Btn_Link_Target# NEQ "modal" > 
					#Get_pb_color.Btn_Title#
				<cfelse>
					<a class="btn price-block-cust" data-toggle="modal" data-target="###arguments.VOI_Vin#Modal#RTrim(Get_pb_color.modal_type)#" >
						#Get_pb_color.Btn_Title#
					</a>
				</cfif>
			</div>
		<cfelse>
			<cfif arguments.MSRP_Price gt 0><div class="price-alt"><b>#ucase(arguments.MSRP_Label)#: <span class="pull-right">$#numberformat(arguments.MSRP_Price)#</span></b></div></cfif>
			<cfif arguments.Adjusted_Baseline gt 0 and  arguments.Adjusted_Baseline gt arguments.Selling_Price and (arguments.Adjusted_Baseline neq arguments.MSRP_Price) and (arguments.Adjusted_Baseline neq arguments.Selling_Price)>
				<div class="price-alt"><b>#ucase(arguments.Selling_Price_Label)#: <span class="pull-right">$#Numberformat(arguments.Adjusted_Baseline)#</span></b></div>
			</cfif>
			<cfif arguments.Rebate_Price gt 0><div class="price-alt"><b>#ucase(arguments.Rebate_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Rebate_Price)#</span></b></div></cfif>
			<cfif arguments.Incentive_Price gt 0><div class="price-alt"><b>#ucase(arguments.Incentive_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Incentive_Price)#</span></b></div></cfif>
			<cfif arguments.AIS_Price gt 0><div class="price-alt"><b>#ucase(arguments.AIS_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.AIS_Price)#</span></b></div></cfif>
			<cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
				<div class="price-break"></div>
			</cfif>
			<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
			<div class="price-sell-lab">#ucase(arguments.Selling_Price_Label)#:</div>
			<div class="price-block-cust">$#numberformat(arguments.Selling_Price)#</div>
			<cfif arguments.Savings_Price gt 0><div class="price-save"><b>#ucase(arguments.Savings_Label)#: <span class="pull-right">$#numberformat(arguments.Savings_Price)#</span></b></div></cfif>
		</cfif>
		
	<cfelse> 	<!--- Custom Button test --->    
	
		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<cfif #url.dealer_id# NEQ 55 > 
				<cfif #url.dealer_id# eq 181 OR  #url.dealer_id# eq 303 >
					<cfset msg_txt = "Call For Price">
					<cfif #url.new_used# EQ "U">
						<cfset msg_txt = "KBB PRICES ON ALL PRE-OWNED">
						<div class="price-call-price-red" style="font-size:10pt;font-weight:bold">#msg_txt#</div>
					<cfelse>	
						<div class="price-call-price-red">#msg_txt#</div>
					</cfif>
				<cfelse> 
					<div class="price-call-price-red">Call For Price</div>
				</cfif> 
			<cfelse>
				<div class="price-call-price-red" align="center">You Are Approved</div>	<!--- Jim Butner 01/19/2015 bob --->
			</cfif>
		<cfelse>
			 <cfif variables.price_display EQ 0 > 
				<cfif arguments.MSRP_Price gt 0><div class="price-alt pull-left"><b>#ucase(arguments.MSRP_Label)#:  $#numberformat(arguments.MSRP_Price)# </b></div><br></cfif>
			 </cfif>  
 
<!--- 04-22-2016 bob  All Baierl Sites --->
 <cfif  ( 	#url.dealer_id# eq 1 OR #url.dealer_id# eq 132 OR #url.dealer_id# eq 195 OR #url.dealer_id# eq 16 OR 
				#url.dealer_id# eq 2 OR #url.dealer_id# eq 14 OR #url.dealer_id# eq 3 OR #url.dealer_id# eq 4 OR 
					#url.dealer_id# eq 6 OR #url.dealer_id# eq 148 OR #url.dealer_id# eq 7 OR #url.dealer_id# eq 8 OR 
						#url.dealer_id# eq 9 OR #url.dealer_id# eq 10 OR #url.dealer_id# eq 162 OR #url.dealer_id# eq 12 OR 
							#url.dealer_id# eq 15 ) AND #arguments.Selling_Price# LTE 2500 >   
			<div class="price-call-price-red">Call For Price</div> 
<cfelse>  			
	
 	<cfif variables.price_display EQ 0 > 		
			<cfif arguments.Adjusted_Baseline gt 0 and  arguments.Adjusted_Baseline gt arguments.Selling_Price and (arguments.Adjusted_Baseline neq arguments.MSRP_Price) and (arguments.Adjusted_Baseline neq arguments.Selling_Price)>
				  <cfif #url.dealer_id# NEQ 257 >    <!--- Tri-Star Nissan Temporary label change  05/21/2015  --->
						<div class="price-alt pull-left"><b>#ucase(arguments.Selling_Price_Label)#: $#Numberformat(arguments.Adjusted_Baseline)#</b></div><br>
				  <cfelse>
						<div class="price-alt pull-left"><b>SALE PRICE: $#Numberformat(arguments.Adjusted_Baseline)#</b></div><br>
				</cfif>  
			</cfif>
			<cfif arguments.Rebate_Price gt 0><div class="price-alt pull-left"><b>#ucase(arguments.Rebate_Label)#: <span class="  txt-red">-$#numberformat(arguments.Rebate_Price)#</span></b></div><br></cfif>
			<cfif arguments.Incentive_Price gt 0><div class="price-al pull-leftt"><b>#ucase(arguments.Incentive_Label)#: <span class=" txt-red">-$#numberformat(arguments.Incentive_Price)#</span></b></div><br></cfif>
			<cfif arguments.AIS_Price gt 0><div class="price-alt pull-left"><b>#ucase(arguments.AIS_Label)#: <span class=" txt-red">-$#numberformat(arguments.AIS_Price)#</span></b></div><br></cfif>
			<cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
				<div class="price-break"></div>
			</cfif>
			<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
			<!--- <div class="price-sell-lab">#ucase(arguments.Selling_Price_Label)#:</div> --->
			<div class="price-green"><b>Sale Price: $#numberformat(arguments.Selling_Price)#</b></div>
			<cfif arguments.Savings_Price gt 0><div class="price-save pull-left"><b>#ucase(arguments.Savings_Label)#: $#numberformat(arguments.Savings_Price)#</b></div></cfif>
<cfelse>
				
	
	  		<cfif #url.dealer_id# eq 365 ><cfset dlr_lookup = 18 ><cfelse><cfset dlr_lookup = #url.dealer_id# ></cfif>	<!--- Kelly Nissan Re-direct 05-06-2016 --->
	 		<cfquery datasource="ultra10" name="Chk_override" >
				SELECT  ID, dealer_id, Stock, VIN, MSRP, Discount, Factory, Sale, Savings, Override, start_ts, expire_ts
				FROM 	Vehicle_Pricing_Override
				WHERE   dealer_id = #dlr_lookup#
				AND		VIN = '#arguments.VOI_Vin#'
				AND		Override = 1
			</cfquery>
	  
	  		<cfif #Chk_override.recordcount# EQ 0 >
		  			<cfset incl_incentive = 0 >
		  			<cfif #arguments.MSRP_Price# NEQ 0 AND #arguments.MSRP_Price# NEQ "" >
						<cfset base_price = #arguments.MSRP_Price# >
					<cfelse>
						<cfset base_price = #arguments.Adjusted_Baseline# >
					</cfif>	
					<div class="price-sell-lab">#ucase(arguments.MSRP_Label)#:
						$#numberformat(base_price)#
					</div>
					<cfif arguments.AIS_Price gt 0>
						<div class="price-sell-lab pull-left">
							#ucase(arguments.AIS_Label)#: <span class=" txt-red">-$#numberformat(arguments.AIS_Price)#</span>
						</div><br>
						<cfset new_price = #base_price# - #arguments.AIS_Price# >
		  				<cfset incl_incentive = 1 >
					<cfelse>
						<cfset new_price = #base_price# >	
					</cfif>
				
					<div class="price-sell-lab-srp  ">#ucase(arguments.Selling_Price_Label)#:</div> 
					<cfif #incl_incentive# NEQ 0  >
						<div class="price-green-srp strikethrough">$#numberformat(new_price)#</div> 	
					<cfelse>
					 	<div class="price-green-srp">$#numberformat(new_price)#</div>		 
					</cfif>
					<cfif #incl_incentive# NEQ 0  >
						<a class="btn srp-btn2" title="CALL FOR PRICE!" href="tel:#variables.dial#" >CALL FOR PRICE!</a>
					</cfif>
			<cfelse>
		  			<cfif Chk_override.MSRP gt 0>
						<div class="price-alt-srp pull-left">#ucase(arguments.MSRP_Label)#:  $#numberformat(Chk_override.MSRP)# </div><br>
					</cfif>
	 		
					<cfif Chk_override.Discount gt 0 and  
							Chk_override.Discount gt Chk_override.Sale and 
								(Chk_override.Discount neq Chk_override.MSRP) and 
									(Chk_override.Discount neq Chk_override.Sale)>
						 <div class="price-alt-srp pull-left"  >#ucase(arguments.Selling_Price_Label)#: $#Numberformat(Chk_override.Discount)#</div><br>
					</cfif>
					<!--- <cfif arguments.Rebate_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.Rebate_Label)#: <span class="  txt-red">-$#numberformat(arguments.Rebate_Price)#</span></div><br></cfif>
					<cfif arguments.Incentive_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.Incentive_Label)#: <span class=" txt-red">-$#numberformat(arguments.Incentive_Price)#</span></div><br></cfif> --->
					
					<cfif Chk_override.Factory gt 0><div class="price-alt-srp pull-left">#ucase(arguments.AIS_Label)#: <span class=" txt-red">-$#numberformat(Chk_override.Factory)#</span></div><br></cfif>
					<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
					<div class="price-sell-lab-srp  ">#ucase(arguments.Selling_Price_Label)#:</div> 
					<div class=" price-strike-srp"><div class="price-green-srp"><b>$#numberformat(Chk_override.Sale)#</b></div></div>
					<cfif Chk_override.Savings gt 0><div class="price-save pull-left">#ucase(arguments.Savings_Label)#: $#numberformat(Chk_override.Savings)#</div><br></cfif>
					<br>
			
			</cfif>		<!--- Override end --->
				
				
						
				
				
				
				
				
				<!--- <div class="price-sell-lab">#ucase(arguments.MSRP_Label)#:</div>
				<cfif #arguments.MSRP_Price# NEQ 0 AND #arguments.MSRP_Price# NEQ "" >
					<div class="price-sell-price-red">$#numberformat(arguments.MSRP_Price)#</div>	
				<cfelse>
					<div class="price-sell-price-red">$#numberformat(arguments.Adjusted_Baseline)#</div>		
				</cfif> --->
	</cfif>		<!--- MSRP ONLY test ---> 		
	</cfif>		<!--- Baierl test ---> 					
		</cfif>	<!--- Selling price test ---> 
		
	   </cfif>	<!--- Custom Button test ---> 

	</cffunction>

	<cffunction name="srp_default_new" description="shows default vdp pricing" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="Selling_Price_Label" default="">
		<cfargument name="Selling_Price" default="">
		<cfargument name="MSRP_Label" default="">
		<cfargument name="MSRP_Price" default="">
		<cfargument name="Rebate_Label" default="">
		<cfargument name="Rebate_Price" default="">
		<cfargument name="Incentive_Label" default="">
		<cfargument name="Incentive_Price" default="">
		<cfargument name="Savings_Label" default="">
		<cfargument name="Savings_Price" default="">
		<cfargument name="AIS_Label" default="">
		<cfargument name="AIS_Price" default="">
		<cfargument name="AIS_APR" default="">
		<cfargument name="Adjusted_Baseline" default="">
		<cfargument name="VOI_Vin" default="">

		
	<!--- Check for Custom Pricing Color  --->
		<cfset variables.cust_btns = 0 >
		<cfset variables.price_display = 0 >
		<cfquery datasource="ultra10" name="Chk_Srch">SELECT Dealer_ID,	cust_btns, call_for_price_phone, price_display_variation  FROM	Dealers WHERE Dealer_ID = #url.dealer_id#</cfquery>	
		<cfset variables.cust_btns = #Chk_Srch.cust_btns# >
		<cfset variables.price_display = #Chk_Srch.price_display_variation# >
		
		
		<cfset variables.dial = "" >
		<cfif #Chk_Srch.call_for_price_phone# NEQ "" >
			<cfquery datasource="Ultra10" name="Get_Phones">SELECT Area_Code,Prefix,Line_Number,Vanity_Number,Phone_Label FROM Dealer_Phones WHERE phone_id=#Chk_Srch.call_for_price_phone# AND dealer_id=#url.dealer_id#</cfquery>
			<cfset variables.dial="#Get_Phones.Area_Code##Get_Phones.Prefix##Get_Phones.Line_Number#">
		</cfif>	  
		
<cfif #cgi.server_name# EQ "4ultra10.wddemos.com">
	<cfset variables.price_display = 1 >
</cfif>
		<cfquery datasource="ultra10" name="Get_pb_color">
			SELECT ID, dealer_id, Btn_Type, Btn_Title, Btn_Link, Btn_Link_Target, Btn_Image, modal_type, hierarchy  
			FROM	Dealer_Custom_Buttons 
			WHERE Dealer_ID = #url.dealer_id#
			AND	Btn_Type = 4
			AND	active = 1
			ORDER BY hierarchy ASC
		</cfquery>	
		<cfset variables.nbr_pb_btns = #Get_pb_color.recordcount# >
	<!--- Check for Custom Pricing Color--->
		
	 <cfif #variables.cust_btns# EQ 1 AND #variables.nbr_pb_btns# GT 0 >
		
		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<div class="price-block-cust">
				<cfif #Get_pb_color.Btn_Link_Target# NEQ "modal" > 
					#Get_pb_color.Btn_Title#
				<cfelse>
					<a class="btn price-block-cust" data-toggle="modal" data-target="###arguments.VOI_Vin#Modal#RTrim(Get_pb_color.modal_type)#" >
						#Get_pb_color.Btn_Title#
					</a>
				</cfif>
			</div>
		<cfelse>
			<cfif arguments.MSRP_Price gt 0><div class="price-alt"><b>#ucase(arguments.MSRP_Label)#: <span class="pull-right">$#numberformat(arguments.MSRP_Price)#</span></b></div></cfif><br>
			<cfif arguments.Adjusted_Baseline gt 0 and  arguments.Adjusted_Baseline gt arguments.Selling_Price and (arguments.Adjusted_Baseline neq arguments.MSRP_Price) and (arguments.Adjusted_Baseline neq arguments.Selling_Price)>
				<div class="price-alt"><b>#ucase(arguments.Selling_Price_Label)#: <span class="pull-right">$#Numberformat(arguments.Adjusted_Baseline)#</span></b></div>
			</cfif>
			<cfif arguments.Rebate_Price gt 0><div class="price-alt"><b>#ucase(arguments.Rebate_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Rebate_Price)#</span></b></div></cfif>
			<cfif arguments.Incentive_Price gt 0><div class="price-alt"><b>#ucase(arguments.Incentive_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.Incentive_Price)#</span></b></div></cfif>
			<cfif arguments.AIS_Price gt 0><div class="price-alt"><b>#ucase(arguments.AIS_Label)#: <span class="pull-right txt-red">-$#numberformat(arguments.AIS_Price)#</span></b></div></cfif>
			<!--- <cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
				<div class="price-break"></div>
			</cfif> --->
			<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
			<div class="price-sell-lab">#ucase(arguments.Selling_Price_Label)#:</div>
			<div class="price-block-cust">$#numberformat(arguments.Selling_Price)#</div>
			<cfif arguments.Savings_Price gt 0><div class="price-save"><b>#ucase(arguments.Savings_Label)#: <span class="pull-right">$#numberformat(arguments.Savings_Price)#</span></b></div></cfif>
		</cfif>
		
	<cfelse>    
	
		<cfif arguments.Selling_Price eq 0 or arguments.Selling_Price eq 10000000>
			<div class="price-call-price-red">Call For Price</div>
		<cfelse>
		
	 <cfif variables.price_display EQ 0 > 
			<cfif arguments.MSRP_Price gt 0>
				<div class="price-alt-srp pull-left">#ucase(arguments.MSRP_Label)#:  $#numberformat(arguments.MSRP_Price)# </div><br>
			</cfif>
	 		
			<cfif arguments.Adjusted_Baseline gt 0 and  
					arguments.Adjusted_Baseline gt arguments.Selling_Price and 
						(arguments.Adjusted_Baseline neq arguments.MSRP_Price) and 
							(arguments.Adjusted_Baseline neq arguments.Selling_Price)>
				 <div class="price-alt-srp pull-left"  >#ucase(arguments.Selling_Price_Label)#: $#Numberformat(arguments.Adjusted_Baseline)#</div><br>
			</cfif>
			<cfif arguments.Rebate_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.Rebate_Label)#: <span class="  txt-red">-$#numberformat(arguments.Rebate_Price)#</span></div><br></cfif>
			<cfif arguments.Incentive_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.Incentive_Label)#: <span class=" txt-red">-$#numberformat(arguments.Incentive_Price)#</span></div><br></cfif>
			<cfif arguments.AIS_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.AIS_Label)#: <span class=" txt-red">-$#numberformat(arguments.AIS_Price)#</span></div><br></cfif>
			<!--- <cfif arguments.MSRP_Price gt 0 or arguments.Rebate_Price gt 0 or arguments.Incentive_Price gt 0 or arguments.AIS_Price gt 0>
				<div class="price-break"></div>
			</cfif> --->
			<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
			<div class="price-sell-lab-srp  ">#ucase(arguments.Selling_Price_Label)#:</div> 
			<div class=" price-strike-srp"><div class="price-green-srp"><b>$#numberformat(arguments.Selling_Price)#</b></div></div>
			<cfif arguments.Savings_Price gt 0><div class="price-save pull-left">#ucase(arguments.Savings_Label)#: $#numberformat(arguments.Savings_Price)#</div><br></cfif>
				<br>
				
	  <cfelse>
	  		<cfif #url.dealer_id# eq 365 ><cfset dlr_lookup = 18 ><cfelse><cfset dlr_lookup = #url.dealer_id# ></cfif>	<!--- Kelly Nissan Re-direct 05-06-2016 --->
	 		<cfquery datasource="ultra10" name="Chk_override" >
				SELECT  ID, dealer_id, Stock, VIN, MSRP, Discount, Factory, Sale, Savings, Override, start_ts, expire_ts
				FROM 	Vehicle_Pricing_Override
				WHERE   dealer_id = #dlr_lookup#
				AND		VIN = '#arguments.VOI_Vin#'
				AND		Override = 1
			</cfquery>
	  
	  		<cfif #Chk_override.recordcount# EQ 0 >
		  			<cfset incl_incentive = 0 >
		  			<cfif #arguments.MSRP_Price# NEQ 0 AND #arguments.MSRP_Price# NEQ "" >
						<cfset base_price = #arguments.MSRP_Price# >
					<cfelse>
						<cfset base_price = #arguments.Adjusted_Baseline# >
					</cfif>	
					<div class="price-sell-lab">#ucase(arguments.MSRP_Label)#:
						$#numberformat(base_price)#
					</div>
					<cfif arguments.AIS_Price gt 0>
						<div class="price-sell-lab pull-left">
							#ucase(arguments.AIS_Label)#: <span class=" txt-red">-$#numberformat(arguments.AIS_Price)#</span>
						</div><br>
						<cfset new_price = #base_price# - #arguments.AIS_Price# >
		  				<cfset incl_incentive = 1 >
					<cfelse>
						<cfset new_price = #base_price# >	
					</cfif>
				
					<div class="price-sell-lab-srp  ">#ucase(arguments.Selling_Price_Label)#:</div> 
					<cfif #incl_incentive# NEQ 0  >
						<div class="price-green-srp strikethrough">$#numberformat(new_price)#</div> 	
					<cfelse>
					 	<div class="price-green-srp">$#numberformat(new_price)#</div>		 
					</cfif>
					<cfif #incl_incentive# NEQ 0  >
						<a class="btn srp-btn2" title="CALL FOR PRICE!" href="tel:#variables.dial#" >CALL FOR PRICE!</a>
					</cfif>
			<cfelse>
		  			<cfif Chk_override.MSRP gt 0>
						<div class="price-alt-srp pull-left">#ucase(arguments.MSRP_Label)#:  $#numberformat(Chk_override.MSRP)# </div><br>
					</cfif>
	 		
					<cfif Chk_override.Discount gt 0 and  
							Chk_override.Discount gt Chk_override.Sale and 
								(Chk_override.Discount neq Chk_override.MSRP) and 
									(Chk_override.Discount neq Chk_override.Sale)>
						 <div class="price-alt-srp pull-left"  >#ucase(arguments.Selling_Price_Label)#: $#Numberformat(Chk_override.Discount)#</div><br>
					</cfif>
					<!--- <cfif arguments.Rebate_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.Rebate_Label)#: <span class="  txt-red">-$#numberformat(arguments.Rebate_Price)#</span></div><br></cfif>
					<cfif arguments.Incentive_Price gt 0><div class="price-alt-srp pull-left">#ucase(arguments.Incentive_Label)#: <span class=" txt-red">-$#numberformat(arguments.Incentive_Price)#</span></div><br></cfif> --->
					
					<cfif Chk_override.Factory gt 0><div class="price-alt-srp pull-left">#ucase(arguments.AIS_Label)#: <span class=" txt-red">-$#numberformat(Chk_override.Factory)#</span></div><br></cfif>
					<cfif arguments.MSRP_Price eq 0 and len(trim(arguments.MSRP_Label)) gt 0><cfset arguments.Selling_Price_Label=arguments.MSRP_Label></cfif>
					<div class="price-sell-lab-srp  ">#ucase(arguments.Selling_Price_Label)#:</div> 
					<div class=" price-strike-srp"><div class="price-green-srp"><b>$#numberformat(Chk_override.Sale)#</b></div></div>
					<cfif Chk_override.Savings gt 0><div class="price-save pull-left">#ucase(arguments.Savings_Label)#: $#numberformat(Chk_override.Savings)#</div><br></cfif>
					<br>
			
			</cfif>		<!--- Override end --->
				
	</cfif>	 <!--- Selling Price DISPLAY 05-02-2016 --->		 
		</cfif>	 <!--- Selling Price test --->
		
	   </cfif>	 <!--- Custom Buttton test --->

	</cffunction>
	
	
	
</cfcomponent>