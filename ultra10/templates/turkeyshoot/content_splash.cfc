<cfcomponent>

	<cffunction name="modern" description="shows a standard contest pages 1 & 2" output="Yes" access="public">	
		
		<link href='http://fonts.googleapis.com/css?family=La+Belle+Aurore' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,800,300' rel='stylesheet' type='text/css'>
		
		<cfif NOT IsDefined("url.page")>
			<cfset url.page = "1" >
		</cfif>
		
		<cfquery datasource="Ultra10" name="dealer_detl">
			SELECT    Dealer_ID, Dealercode, Dealer_Name, Display_Name, Address_1, Address_2, City, State, Zip, Primary_URL, Dealer_Directory, Longitude, Latitude, 
                      AIS_Dealer_ID, AIS_WID, AIS_BriefInline, New_Inv_Type_ID, Inv_Code_New, Used_Inv_Type_ID, Inv_Code_Used, Fleet_Inv_New_Type_ID, Inv_Code_Fleet_New, 
                      Fleet_Inv_Used_Type_ID, Inv_Code_Fleet_Used, Commercial_New_Inv_Type_ID, Inv_Code_Commercial_New, Commercial_Used_Inv_Type_ID, 
                      Inv_Code_Commercial_Used, Store_Contact, Store_Contact_Email, Primary_Phone, Inv_Phone_New, Inv_Phone_Used, Service_Phone, Parts_Phone, 
                      Automall_Phone, Inv_Phone_New_Automall, Inv_Phone_Used_Automall, OEM_Key, TDDS, TDDS_region, TDDS_tda, TDDS_district, TDDS_autogroup, 
                      Google_Site_Verification, Carfax, Autocheck_CID, Autocheck_SID, Autocheck_PWD, Wordpress_Cat, Link_Finance, Link_Service, Link_Sales, Link_Parts, 
                      Link_Directions, Link_Charity, Link_New_Specials, Link_Used_Specials, scripts_head, scripts_above_body, scripts_body_top, scripts_body_bottom, 
                      scripts_after_body, vehicle_css, v_disclaimer, youtube, Active, exclude_inv, directions, scripts_nav_chat, cobalt_url, wd_logo_img, srch_method, price_srch_method, 
                      cust_btns, region_id, regional_parent_id, bxs_new_used, proximity, dsp_name_in_title, site_search_client, site_search_result, site_search_collection, lv_on, 
                      dflt_rate
			FROM         Dealers
			WHERE		Dealer_id = 342
		</cfquery>
		
	<cfif #url.page# EQ 1 or  #url.page# EQ 2 >
	
		
<div class="container-fluid">	
		<section class="section-spl">	 
			<div class="row no-pad">	
				<div class="container" >	 
					<div class="col-md-12 body-text no-pad" align="left"> 
						 <img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/header.png" alt=" "  class="img-responsive" border="0">
					</div>
				</div>	
				<div class="row no-pad">	
					<div class="container" >	
						<div class="col-md-12 body-text no-pad" align="left">  
							<div style="color:##000000;font:bold 14px arial;padding:10px 20px 20px 20px;margin-right:30px;margin-left:25px;">
								<p>Epsilon Aspen Automotive, The largest and most experienced automotive direct marketing company in the country, has developed this program to turn an ordinary month into one of your best months this year. This has always been our most successful direct marketing event for our clients. Why? Because it works. It's direct marketing at its best. And we are pleased to be celebrating the 27th Anniversary of the Turkey Shoot Mailer!</p>
							</div>
						</div>	
					</div>
				</div>	
				<div class="row no-pad">	 
					<div class="container">	 
						<div class="col-md-12 body-text no-pad" align="left"> 
							<div style="background-color:##1C1004;border:3px solid white;padding:10px;margin:5px 5px 0px 5px;-moz-border-radius: 10px;border-radius: 10px;margin-right:30px">
						
								<cfif #url.page# eq 1 >
									<form id="wd-form" name="wd-form" action="http://#cgi.server_name#/turkey_contact_action.cfm?page_action=submit_form" method="post" enctype="multipart/form-data">
									<input  id="dealer_id" name="dealer_id"  value="#url.dealer_id#"  type="hidden"/>
									<input  id="assets" name="assets"  value="#url.assets#"  type="hidden"/>
									<input  id="site_mode" name="site_mode"  value="#url.site_mode#"  type="hidden"/>
									<input  id="dealer_name" name="dealer_name"  value="#url.dealer_name#"  type="hidden"/>
									<input  id="template_id" name="template_id"  value="#url.template_id#"  type="hidden"/>
									<input  id="dealer_template_id" name="dealer_template_id"  value="#url.dealer_template_id#"  type="hidden"/>
									<div class="row no-pad">	
										<div class="col-md-4 body-text no-pad" align="center" style="font:bold 20px arial;color:##ffffff"> 
											CALL US AT<br/>
											800.736.0602<br/>
											<span style="display:block;font:normal 11px arial;padding:10px 0px 10px 0px">OR</span>
											FILL OUT THIS FORM<br/>
											<span style="font:normal 11px arial;">FOR MORE INFORMATION</span>
										</div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right"> First Name :</div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input  tabindex="1" id="first_name" name="first_name"  value="" maxlength="50" type="text"/ ></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="1" id="first_name" name="first_name" placeholder="First Name" value="" maxlength="50" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="2" id="last_name" name="last_name" placeholder="Last Name"  value="" maxlength="50"  type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">Address :</div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input   tabindex="6" id="address" name="address"   value="" maxlength="50" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="3" id="address" name="address" placeholder="Address" value="" maxlength="50" type="text"/></div>
									<div class="row no-pad">	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">Last Name :</div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="2" id="last_name" name="last_name"   value="" maxlength="50" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">City :</div>
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="7" id="city" name="city"  value="" maxlength="50" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="4" id="city" name="city" placeholder="City"  value="" maxlength="50" type="text"/></div>
									<div class="row no-pad">		
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="5" id="state" name="state"  placeholder="State" value="" maxlength="50" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="6" id="zip" name="zip"  placeholder="Zip" value="" maxlength="5" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="7" id="dealer" name="dealer" placeholder="Dealership Name"  value="" maxlength="50" type="text"/></div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">Dealership Name :</div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="3" id="dealer" name="dealer"    value="" maxlength="50" type="text"/></div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">State :</div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="8" id="state" name="state"  value="" maxlength="50" type="text"/></div>
									<div class="row no-pad">		
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">Phone :</div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="4" id="phone" name="phone"   value="" maxlength="12" type="text"/></div>	
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="8" id="phone" name="phone"  placeholder="Phone" value="" maxlength="12" type="text"/></div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="right">Zip :</div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="9" id="zip" name="zip"  value="" maxlength="5" type="text"/></div>
									<div class="row no-pad">		
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px" align="right">Email :</div>	
										<div class="col-md-2 body-text no-pad visible-lg visible-md" style="margin-top:5px"  align="left"><input tabindex="5" id="email" name="email"  value="" maxlength="100" type="text"/></div>
										<div class="col-md-2 body-text no-pad visible-sm visible-xs" align="left"><input tabindex="9" id="email" name="email"  placeholder="Email" value="" maxlength="100" type="text"/></div>	
										<div class="col-md-4 body-text pad-top-10" align="right"><input style="background-color:##1C1004;border:0px;color:##fff;font:normal 20px arial;" type="submit" value="SUBMIT"/></div>
									 </div>
								</form>
							<cfelse>
								<div class="row no-pad">	
									<div class="col-md-12 body-text no-pad" align="center" style="font:bold 32px arial;color:##ffffff;margin-top:30px;margin-bottom:30px"> 
										<i>Thank You!</i><br><span style="font:bold 22px arial;color:##ffffff">An Aspen IA Marketing Representative will be in touch with you shortly.</span>
									</div>
							</cfif>		
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>  <!--- container --->
	<div class="container">		
		<div class="row   no-pad">	
			<div class="col-md-5"   align="center">
	 			 <a data-toggle="modal" data-target="##turkeypop"><img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/directmail.png"  class="img-responsive"  alt="Direct Mail Piece" ></a>  
			</div>
			<div class="col-md-6"   align="left">
				<h3  style="color:##000000!important;font-weight:bold;font-family:"Times New Roman", sans-Serif;">DIRECT MAIL PIECE</h3>
				<div style="color:##000000!important;font:bold 14px arial;padding:0px 0px 0px 0px">
					Here's how it works ... A timely message is sent to a targeted mailing list using Aspen Marketing's 
					Proprietary List Sources. We can even include your customer database as part of the program.<br><br>Then it's 
					packaged to look just like a holiday greeting card from a friend or loved one. The recipients address 
					and return address appears to have been handwritten right on the envelope, and the Live Stamp is applied 
					slightly off to give it more authenticity.
				</div>
				<div class="ctv-btn" style="color:font:normal 30pt arial;align:center"><a data-toggle="modal" data-target="##turkeypop">Click Here to View</a></div> 
			</div>	
		</div>   <!--- container --->
	</div>	
	<div class="container">		
		<div class="row   no-pad">	
			<div class="col-md-7"   align="right">
				<h3  style="color:##000000!important;font-weight:bold;font-family:"Times New Roman", sans-Serif;">EXCLUSIVE VISA TURKEY REWARD CARD</h3>
				<div style="color:##000000!important;font:bold 14px arial;padding:0px 0px 0px 0px">
					We also include the perfect gift that people can take advantage of for the holidays, a Visa turkey reward card, 
					that's good towards their Thanksgiving turkey. You're sure to get the attention of your prospects and promote 
					a positive connection to your dealership.
				</div>
				 <div class="ctv-btn" style="color:font:normal 30pt arial;align:center"><a data-toggle="modal" data-target="##turkeypop2">Click Here to View</a></div> 
			</div>
			<div class="col-md-4"   align="center">
	 			<a data-toggle="modal" data-target="##turkeypop2"> <img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/visacard.png"  class="img-responsive"  alt="Visa Reward Card" >  </a>
			</div>
		</div>	
	</div>   <!--- container --->
	<div class="container">		
	<!--- Footer DESKTOP Page 1 --->	
		<div class="row   no-pad">	
			<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
	 			<a href="tel:8007360602" title="Click to Call" ><img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/footer.png"  class="img-responsive"  alt="Epsilon AspenAutomotive" ></a> 
			</div>
		</div>	
		<div class="row   no-pad">	
			<div class="col-md-11" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="right">
				 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  class="img-responsive"  alt="WorldDealer Advertising, Inc." >  <br>
			</div>
		</div>	
			
	</div>  <!--- container --->
	</section>
</div>  <!--- container --->
		
		<!---  <cfinvoke component="/cfcs/ultra10/popups" method="turkeypop">
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="turkeypop2"/>
			<cfinvokeargument name="image_src" value="1"/>
		</cfinvoke>
		 <cfinvoke component="/cfcs/ultra10/popups" method="turkeypop">
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="turkeypop"/>
			<cfinvokeargument name="image_src" value="0"/>
		</cfinvoke> --->
		 
	<!--- <cfelseif #url.page# EQ 2>

		
			 <div class="container">	
		<section class="section-spl">	 
		
	<!--- Body DESKTP & MOBILE Page 1  --->	
				<div class="row no-pad">	 
					<div class="col-md-12 body-text no-pad" align="left"> 
						 <img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/header.png" alt=" "  class="img-responsive" border="0">
					</div>
					<div class="row no-pad">	
						<div class="container" >	
						<div class="col-md-12 body-text no-pad" align="left">  
							<div style="color:##000000;font:bold 14px arial;padding:10px 20px 20px 20px;margin-right:30px;margin-left:25px;">
								<p>Epsilon Aspen Automotive, The largest and most experienced automotive direct marketing company in the country, has developed this program to turn an ordinary month into one of your best months this year. This has always been our most successful direct marketing event for our clients. Why? Because it works. It's direct marketing at its best. And we are pleased to be celebrating the 27th Anniversary of the Turkey Shoot Mailer!</p>
							</div>
						</div>	
						</div>
					</div>	
					<div class="row no-pad">	 
						<div class="container">	 
						<div class="col-md-12 body-text no-pad" align="left"> 
						<div style="background-color:##1C1004;border:3px solid white;padding:10px;margin:5px 5px 0px 5px;-moz-border-radius: 10px;border-radius: 10px;margin-right:30px">
						
							<div class="row no-pad">	
								<div class="col-md-offset-4 col-md-4 body-text no-pad" align="center" style="font:bold 20px arial;color:##ffffff"> 
									An Aspen IA Marketing Representative will be in touch with you shortly.
								</div>
					 				
				</div>
						</div>
					</div>	
					
				</div>
				</div>

			</div>  <!--- container --->
		
		
		
		
			<div class="container">		
				<div class="row   no-pad">	
					<div class="col-md-5"   align="center">
		 			 <a data-toggle="modal" data-target="##turkeypop"><img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/directmail.png"  class="img-responsive"  alt="Direct Mail Piece" ></a>  
					</div>
					<div class="col-md-6"   align="left">
							<h3  style="color:##000000!important;font-weight:bold;font-family:"Times New Roman", sans-Serif;">DIRECT MAIL PIECE</h3>
							<div style="color:##000000!important;font:bold 14px arial;padding:0px 0px 0px 0px">
								Here's how it works ... A timely message is sent to a targeted mailing list using Aspen Marketing's 
								Proprietary List Sources. We can even include your customer database as part of the program.<br><br>Then it's 
								packaged to look just like a holiday greeting card from a friend or loved one. The recipients address 
								and return address appears to have been handwritten right on the envelope, and the Live Stamp is applied 
								slightly off to give it more authenticity.
							</div>
							 <div class="ctv-btn" style="color:font:normal 30pt arial;align:center"><a data-toggle="modal" data-target="##turkeypop">Click Here to View</a>
							</div> 
					</div>
				</div>	
			</div>   <!--- container --->
		
		
			<div class="container">		
				<div class="row   no-pad">	
					<div class="col-md-7"   align="right">
							<h3  style="color:##000000!important;font-weight:bold;font-family:"Times New Roman", sans-Serif;">EXCLUSIVE VISA TURKEY REWARD CARD</h3>
							<div style="color:##000000!important;font:bold 14px arial;padding:0px 0px 0px 0px">
								We also include the perfect gift that people can take advantage of for the holidays, a Visa turkey reward card, 
								that's good towards their Thanksgiving turkey. You're sure to get the attention of your prospects and promote 
								a positive connection to your dealership.
							</div>
							 <div class="ctv-btn" style="color:font:normal 30pt arial;align:center"><a data-toggle="modal" data-target="##turkeypop2">Click Here to View</a>
							</div> 
					</div>
					<div class="col-md-4"   align="center">
		 			<a data-toggle="modal" data-target="##turkeypop2"> <img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/visacard.png"  class="img-responsive"  alt="Visa Reward Card" >  </a>
					</div>
				</div>	
			</div>   <!--- container --->
		
	
			<div class="container">		
	<!--- Footer DESKTOP Page 1 --->	
				<div class="row   no-pad">	
					<div class="col-md-12" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="left">
		 			<a href="tel:8007360602" title="Click to Call" ><img src="http://dealers.wdautos.com/dealer/aspturkeyshoot/images/icons/footer.png"  class="img-responsive"  alt="Epsilon AspenAutomotive" ></a> 
					</div>
				</div>	
				<div class="row   no-pad">	
					<div class="col-md-11" style="font-family: 'Open Sans', sans-serif;color:##000000!important;font-weight:normal!important;font-size:14px;" align="right">
		 			 <img src="http://dealers.wdautos.com/images/wd_logos/footericon_WD_Light.png"  class="img-responsive"  alt="WorldDealer Advertising, Inc." >  <br>
					</div>
				</div>	
			
			</div>  <!--- container --->
		</section>
			</div>  <!--- container --->
 --->		
	</cfif>			
  

		 <cfinvoke component="/cfcs/ultra10/popups" method="turkeypop">
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="turkeypop2"/>
			<cfinvokeargument name="image_src" value="1"/>
		</cfinvoke>
		 <cfinvoke component="/cfcs/ultra10/popups" method="turkeypop">
			<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
			<cfinvokeargument name="modal_name" value="turkeypop"/>
			<cfinvokeargument name="image_src" value="0"/>
		</cfinvoke>
	</cffunction>

	<cffunction name="legacy" description="shows a legacy splash page" output="Yes" access="public">

	</cffunction>

</cfcomponent>