<cfcomponent>

<!--- Data Collection --->
		<cfset variables.dsn = "Aspen10">
		
		<cfquery name="load_imgs" datasource="#variables.dsn#" dbtype="ODBC">
			SELECT     	Customer_PIN_ID, DateCreated, DateModified, Dealer_ID, Customer_Name, PIN, Active,Logo_Img,Logo_url,offer,phone,featured_mbr
			FROM        Customer_PINs
			WHERE		Logo_Img is not null
			ORDER BY 	srt_fld ASC
		</cfquery>
		<cfset mbr_img			=	ArrayNew(1) >
		<cfset mbr_logo_url		=	ArrayNew(1) >
		<cfset mbr_offer		=	ArrayNew(1) >
		<cfset mbr_phone		=	ArrayNew(1) >
		<cfset mbr_pin			=	ArrayNew(1) >
		<cfset mbr_id			=	ArrayNew(1) >
		<cfset x = 0>
		<cfloop query="load_imgs">
			<cfif #load_imgs.Active# NEQ 0 and #load_imgs.featured_mbr# NEQ 0 >
				<cfset x = #x# + 1>
				<cfset mbr_img[x]		=	"#load_imgs.Logo_Img#" >
				<cfset mbr_logo_url[x]	=	"#load_imgs.Logo_url#" >
				<cfset mbr_offer[x]		=	"#load_imgs.offer#" >
				<cfset mbr_phone[x]		=	"#load_imgs.phone#" >
				<cfset mbr_pin[x]		=	"#load_imgs.pin#" >
				<cfset mbr_id[x]		=	"#load_imgs.Customer_PIN_ID#" >
			</cfif>
		</cfloop>
		<cfset tot_pics = #x# >
		
		
		<cfquery datasource="#variables.DSN#" name="Get_Dealer_Details">
			SELECT		Dealer_ID,
						Display_Name,
						Dealer_Directory
			FROM		Dealers
			WHERE		Dealer_ID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.Dealer_ID#" maxlength="6">
			ORDER BY 	Dealer_Name
		</cfquery>
		
		<cfset variables.imgfldr = "images\staff">
		<cfset variables.fullpath = "http://#cgi.server_name#/dealer/#Get_Dealer_Details.Dealer_Directory#/#variables.imgfldr#/">

	<cffunction name="modern_standard" description="create standard staff page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">
		<!---former settings--->
		<cfparam name="url.old_year" default="">
		<cfparam name="url.old_make" default="">


	<cfif IsDefined("form.submit")>
		<cfquery name="get_cust" datasource="#variables.DSN#">
			SELECT     	Customer_PIN_ID, DateCreated, DateModified, Dealer_ID, Customer_Name, PIN, Active,LastAccess, AccessCtr
			FROM        Customer_PINs
			WHERE		PIN = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PIN#" maxlength="10" >
			AND			Active = 1
		</cfquery>
		<cfif #get_cust.recordcount# NEQ 0 >
			<cfif #get_cust.AccessCtr# EQ "" >
				<cfset nu_cnt = 1 >
			<cfelse>	
				<cfset nu_cnt = #get_cust.AccessCtr# + 1 >
			</cfif>
			<cfquery NAME="UpdateCode" datasource="#variables.DSN#">
				UPDATE Customer_PINs
						SET	AccessCtr	=	#nu_cnt#, 
							LastAccess	=	#CreateODBCDateTime(now())#
				WHERE	Customer_PIN_ID	=	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#get_cust.Customer_PIN_ID#" maxlength="6">
			</cfquery>
			<cfset valid_user = -1 >
			<cfset fail_login = 0 >
			<div class="row"><div class="col-md-12" align="center" ><h1>Members Discount Benefit Program</h1></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12" align="center" ><b>Login Successful!</b></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12" align="center" ><b>Click below to view your Special Offers!</b></div>	
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row">
				<div class="col-md-6" align="right" >
					<a href="http://#cgi.server_name#/dealer/findlaytoyota/pdfs/ft_specials.pdf" target="_blank"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/btn_ftmembers.png" /></a>
				</div>
				<div class="col-md-6" align="left" >
					<a href="http://#cgi.server_name#/dealer/findlaytoyota/member_discount_page.cfm" target="_blank"><img class="img-responsive"  src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/btn_ftmembers_sheet.png" /></a>
				</div>
			</div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row">
				<div class="col-md-12" align="center" >
					<a href="http://#cgi.server_name#/dealer/findlaytoyota/images/members/printablecoupon.png" target="_blank"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/printablecoupon.png" width="400px" height="190px" border="0"/></a>
				</div>
			</div>
			<cfexit>

		<cfelse>
			<cfset valid_user = 0 >
			<cfset fail_login = -1 >
			<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?fail_login=-1">
		</cfif>
	</cfif>
		
		<div class="row">
			<div class="col-md-2">
				<img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/logo_findlaytoyota.png"/>
			</div>
			<div class="col-md-10">
				<h2>Members Discount Benefit Program</h2>
			</div>
		</div>
		<cfif IsDefined("url.fail_login")>
			<div class="row">
				<div class="col-md-12" align="center" style="color:red;font-size:12pt"> 
					<b>Login Failed!</b>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12" align="center">  
					Please Try Again
				</div>
			</div>
		</cfif>
		
		<form action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="POST" name="nFirstABox" >
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
						Congratulations, Findlay Toyota is pleased to announce a Special offer to our business community, 
						this offer allows for a haggle free bottom line pricing for all your team members, and families, 
						to save substantially on any new or pre-owned vehicle in inventory. This Exclusive Program is designed 
						for small to large companies, and organizations who strive to offer team members extra benefits to save 
						significantly on products and services that Findlay Toyota has to offer. On this site you can view our entire 
						Inventory, along with the substantial discounts and benefits we provided just for members. You can view the inventory, 
						and exclusive pricing at your leisure by accessing the web link and entering your company's Promo Code. 
						It's also a way to reward your team members with valuable discounts and benefits from other participating 
						local businesses, this link is updated monthly so you can enjoy your savings today ...
			</div>
		</div>	
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
						<strong>Also some of the great benefits you will find are ...</strong>
							<ul>
								<li>&nbsp;&nbsp;Access to Members Discount Price List</li>
								<li>&nbsp;&nbsp;2 yr. Complementary Maintenance (new vehicles)*</li>
								<li>&nbsp;&nbsp;Special pricing on New & Pre-Owned vehicles</li>
								<li>&nbsp;&nbsp;Tires for Life (new vehicles)*</li>
								<li>&nbsp;&nbsp;10% Discount on Parts & Service*</li>
								<li>&nbsp;&nbsp;Military Discounts</li>
								<li>&nbsp;&nbsp;College Graduate Discounts</li>
								<li>&nbsp;&nbsp;Local Business Discounts</li>
								<li>&nbsp;&nbsp;Customized Solutions on company vehicles</li>
								<li>&nbsp;&nbsp;Complementary Rental Car (with service.)*</li>
								<li>&nbsp;&nbsp;Ticket to Sports and Special Events*</li>
								<li>&nbsp;&nbsp;Referral Fund Program</li>
							</ul>
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
				At Findlay Toyota we value our community and hope this program will be a great value to your company and team members.
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
				<b>For Existing Members enter Promo Code to access discount and benefits&nbsp;</b>
				<input type="Text" name="PIN" size="11" maxlength="10" >
				&nbsp;&nbsp;			
				<input type="submit" class="ssButtonMicro" name="submit" value="Submit">
			</div>
		</div>
		</form>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
					If you would like to have your business included in the Business Discount Network Program please contact,
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
					Ralph Lovell
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
					Program Administrator
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
					<a href="mailto:ralphlovell@findlayauto.com" target="_blank">ralphlovell@findlayauto.com</a>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
					702 566-2000 ext.5605   702 250-5099
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row">
			<div class="col-md-12">
					<h1>Featured Participating Members</h1>
			</div>
		</div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<div class="row"><div class="col-md-12">&nbsp;</div></div>
		<cfif #mbr_id[1]# EQ 17 >
			<div class="row">
				<div class="col-md-12">	
					<a href="http://findlaytoyota.com/dealer/findlaytoyota/findlay_toyota_business_solutions.cfm" target="_blank"> 
					<img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/#mbr_img[1]#" border="0" >
				</div>
			</div>
		</cfif>
		<cfloop index="x" from="2" to="#tot_pics#" step="2" >
			<div class="row">
				<div class="col-md-6">
					<a href="#mbr_logo_url[x]#" target="_blank"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/#mbr_img[x]#" border="0" ></a>
				</div>	
				<cfif #x#+1 LTE #tot_pics# >
					<div class="col-md-6">
						<a href="#mbr_logo_url[x+1]#" target="_blank"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/#mbr_img[x+1]#" border="0" ></a>
				</div>	
				</cfif>
			</div>	
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
		</cfloop>

		
	</cffunction>

	<cffunction name="legacy_standard" description="create standard staff page" output="yes" access="public">

		<!---default parameters--->
		<cfparam name="url.dealer_id" default="">

	<cfif IsDefined("form.submit")>
		<cfquery name="get_cust" datasource="#variables.DSN#">
			SELECT     	Customer_PIN_ID, DateCreated, DateModified, Dealer_ID, Customer_Name, PIN, Active,LastAccess, AccessCtr
			FROM        Customer_PINs
			WHERE		PIN = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PIN#" maxlength="10" >
			AND			Active = 1
		</cfquery>
		<cfif #get_cust.recordcount# NEQ 0 >
			<cfif #get_cust.AccessCtr# EQ "" >
				<cfset nu_cnt = 1 >
			<cfelse>	
				<cfset nu_cnt = #get_cust.AccessCtr# + 1 >
			</cfif>
			<cfquery NAME="UpdateCode" datasource="#variables.DSN#">
				UPDATE Customer_PINs
						SET	AccessCtr	=	#nu_cnt#, 
							LastAccess	=	#CreateODBCDateTime(now())#
				WHERE	Customer_PIN_ID	=	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#get_cust.Customer_PIN_ID#" maxlength="6">
			</cfquery>
			<cfset valid_user = -1 >
			<cfset fail_login = 0 >
			<div class="row"><div class="col-md-12" align="center" ><h1>Members Discount Benefit Program</h1></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12" align="center" ><b>Login Successful!</b></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12" align="center" ><b>Click below to view your Special Offers!</b></div>	
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row">
				<div class="col-md-6" align="right" >
					<a href="http://#cgi.server_name#/dealer/findlaytoyota/pdfs/ft_specials.pdf" target="_blank"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/btn_ftmembers.png" border="1"/></a>
				</div>
				<div class="col-md-6" align="left" >
					<a href="http://#cgi.server_name#/dealer/findlaytoyota/member_discount_page.cfm" target="_blank"><img class="img-responsive"  src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/btn_ftmembers_sheet.png" border="1"/></a>
				</div>
			</div>
			<div class="row"><div class="col-md-12">&nbsp;</div></div>
			<div class="row">
				<div class="col-md-12" align="center" >
					<a href="http://#cgi.server_name#/dealer/findlaytoyota/images/members/printablecoupon.png" target="_blank"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/printablecoupon.png" width="400px" height="190px" border="0"/></a>
				</div>
			</div>
			<cfexit>

		<cfelse>
			<cfset valid_user = 0 >
			<cfset fail_login = -1 >
			<cflocation url="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?fail_login=-1">
		</cfif>
	</cfif>
		
		<div class="row">
			<div class="col-md-2">
				<img class="img-responsive" src="http://dealers.wdautos.com/dealer/findlaytoyota/images/members/logo_findlaytoyota.png"/>
			</div>
			<div class="col-md-10">
				<h2>Members Discount Benefit Program</h2>
			</div>
		</div>
		<cfif IsDefined("url.fail_login")>
			<div class="row">
				<div class="col-md-12" align="center" style="color:red;font-size:12pt"> 
					<b>Login Failed!</b>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12" align="center">  
					Please Try Again
				</div>
			</div>
		</cfif>

		<form action="#GetFileFromPath(cgi.CF_TEMPLATE_PATH)#?page_action=submit_form" method="POST" name="nFirstABox" >
			<table cellpadding="4" cellspacing="0" border="0" width="100%" align="center">
				<tr>
					<td class="blacktitles" valign="TOP" align="left" >
						Congratulations, Findlay Toyota is pleased to announce a Special offer to our business community, 
						this offer allows for a haggle free bottom line pricing for all your team members, and families, 
						to save substantially on any new or pre-owned vehicle in inventory. This Exclusive Program is designed 
						for small to large companies who strives to offer team members extra benefits to save significantly on 
						products and services that Findlay Toyota has to offer. On this site you can view our entire Inventory, 
						along with the substantial discounts and benefits we provided just for members. You can view the inventory, 
						and exclusive pricing at your leisure by accessing the web link and entering your company's Promo Code, 
						It's also a way to reward your team members with valuable discounts and benefits from other participating 
						local businesses; this link is updated monthly so you can enjoy your savings today ...
					</td>
				</tr>		
				<tr><td height="8" </td></tr>	
				<tr>
					<td class="blacktitles" valign="TOP" align="left" >
						<!--- bullet types "disc"(default) , "circle" , "square" --->
						<strong>Also some of the great benefits you will find are ...</strong>
							<ul>
								<li>&nbsp;&nbsp;Access to Members Discount Price List</li>
								<li>&nbsp;&nbsp;2 yr. Complementary Maintenance (new vehicles)*</li>
								<li>&nbsp;&nbsp;Special pricing on used vehicles</li>
								<li>&nbsp;&nbsp;Tires for Life (new vehicles)*</li>
								<li>&nbsp;&nbsp;10% Discount on Parts & Service*</li>
								<li>&nbsp;&nbsp;Military Discounts</li>
								<li>&nbsp;&nbsp;College Graduate Discounts</li>
								<li>&nbsp;&nbsp;Local Business Discounts</li>
								<li>&nbsp;&nbsp;Customized Solutions on company vehicles</li>
								<li>&nbsp;&nbsp;Complementary Rental Car with service.*</li>
								<li>&nbsp;&nbsp;Ticket to Sports and Special Events*</li>
								<li>&nbsp;&nbsp;Referral Fund Program</li>
							</ul>
					</td>
				</tr>	
				<tr><td height="8" </td></tr>	
				<tr>
					<td class="blacktitles" valign="TOP" align="left" >
						At Findlay Toyota we value our community and hope this program will be a great value to your company and team members.
					</td>
				</tr>	
				<tr><td height="8" </td></tr>	
				<tr>
					<td class="blacktitles" align="left" >
						<b>For Existing Members enter Promo Code to access discount benefits&nbsp;</b>
						<input type="Text" name="PIN" size="11" maxlength="10" >
						&nbsp;&nbsp;			
						<input type="submit" class="ssButtonMicro" name="submit" value="Submit">
					</td>
				</tr>	
				<tr><td height="8"></td></tr>	
				<tr>
					<td align="center">
					</td>
				</tr>
			</table>
		</form>
		
		<table cellpadding="4" cellspacing="0" border="0" width="90%" align="center">
			<tr><td height="10"></td></tr>	
			<tr>
				<td class="blacktitles" align="left" >	
					If you would like to have your business included in the Business Discount Network Program please contact,
				</td>
			</tr>	
			<tr><td height="5"></td></tr>	
			<tr>
				<td class="blacktitles"   align="left" >
					Ralph Lovell
				</td>
			</tr>	
			<tr><td height="5"></td></tr>	
			<tr>
				<td class="blacktitles"   align="left" >
					Program Administrator
				</td>
			</tr>
			<tr><td height="5"></td></tr>	
			<tr>
				<td class="blacktitles"   align="left" >
					<a href="mailto:ralphlovell@findlayauto.com" target="_blank">ralphlovell@findlayauto.com</a>
				</td>
			</tr>
			<tr><td height="5"></td></tr>	
			<tr>
				<td class="blacktitles"   align="left" >
					702 566-2000 ext.5605   702 250-5099
				</td>
			</tr>	
		</table>
		
		<table cellpadding="4" cellspacing="0" border="0" width="95%" align="center">
			<tr><td height="15"></td></tr>	
			<tr>
				<td class="blacktitles" align="left" >	
					<h1>Featured Participating Members</h1>
				</td>
			</tr>					
			<tr><td height="10"></td></tr>	
			<tr>
				<td class="blacktitles"   align="left" > 
					<table cellpadding="4" cellspacing="0" border="0" width="100%" align="left">
						<tr><td height="10"></td></tr>	
							<cfif #mbr_id[1]# EQ 17 >
								<tr>
									<td class="blacktitles" align="left" valign="MIDDLE"  >	
										<table cellpadding="1" cellspacing="0" border="0" width="90%" align="center">
											<tr><!--- <img src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/#mbr_img[1]#" border="0" > --->
												<td class="blacktitles" align="center" colspan="2" valign="MIDDLE"  >	
													<a href="http://findlaytoyota.com/dealer/findlaytoyota/findlay_toyota_business_solutions.cfm" target="_blank"> 
													<img src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/#mbr_img[1]#" border="0" ></a>
												</td>
											</tr>
										</table>			
									</td>
								</tr>	
							</cfif>
							<cfloop index="x" from="2" to="#tot_pics#" step="2" >
								<tr>
									<td class="blacktitles" align="left" valign="MIDDLE"  >	
										<table cellpadding="3" cellspacing="2" border="0" width="90%" align="center">
											<tr> <!--- <img src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/#mbr_img[x]#" border="0" > --->
												<td class="blacktitles" align="center" width="40%" valign="MIDDLE"  >	
													<a href="#mbr_logo_url[x]#" target="_blank"><img src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/#mbr_img[x]#" border="0" ></a>
												</td> <!--- <img src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/#mbr_img[x+1]#" border="0" > --->
												<cfif #x#+1 LTE #tot_pics# >
													<td class="blacktitles" align="center" width="40%" valign="MIDDLE"  >	
														<a href="#mbr_logo_url[x+1]#" target="_blank"><img src="http://#cgi.server_name#/dealer/findlaytoyota/images/members/#mbr_img[x+1]#" border="0" ></a>
													</td>
												</cfif>
											</tr>
										</table>			
									</td>
								</tr>	
								<tr><td height="30"></td></tr>	
							</cfloop>
						</table>
					</td>
				</tr>	
			</table>
		
	</cffunction>

</cfcomponent>