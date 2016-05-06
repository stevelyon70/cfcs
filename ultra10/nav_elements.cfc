<!--- 
	nav types
	1 : Main Nav
	2 : Sub Nav
	3 : Slideshow
	7-11 : Info Links
	12 : Shopping Links
	13-15 : Buttons
	16-27 : Header Links
	
	behaviours
	1 : Text - Direct link
	2 : Text - New Window
	3 : Text Only
	14 : Code Snippet
 --->

<cfcomponent>

	<cffunction name="query" description="shows nav driven by a query" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
							
		<cfloop query="Get_Nav">

			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
					<cfset variables.element_class="#arguments.element_class#-bold">
				<cfelse>
					<cfset variables.element_class="#arguments.element_class#">
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;">
				</cfif>
				<cfif len(trim(Get_Nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif Get_Nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset Get_Nav.pull="">
				</cfif>
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
				<!---nav switches--->
                <!-- 119 - #Get_Nav.Nav_Behaviour_ID#-->
				<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
					<cfcase value="1">
						<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#">
									<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
							<cfset variables.element_class="#variables.element_class# visible-lg visible-md">
						</cfif>
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif><cfif #url.dealer_ID# eq 30 and arguments.nav_type_id eq 12>style="color:##ffffff;"</cfif>  class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img style="#variables.element_style#"  class="nav_#Get_Nav.Nav_ID# img-responsive " alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
						</cfif>
					</cfcase>
					<cfcase value="2">
						<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
							<cfset variables.element_class="#variables.element_class# visible-lg visible-md">
						</cfif>
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img style="#variables.element_style#" class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>						
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img style="#variables.element_style#" class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
						</cfif>
					</cfcase>
					<cfcase value="3">
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<div style="#variables.element_style#" id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
						<cfelse>
							<div id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#" <cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0>style="align:#Get_Nav.Align#"</cfif>>
								<img style="#variables.element_style#" class="#Get_Nav.Nav_ID# <cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							</div>
						</cfif>					
					</cfcase>
					<cfcase value="4">
						<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#;text-decoration:none" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="http://#cgi.server_name#" title="#url.dealer_name#">#url.dealer_name#</a>	
					</cfcase>
					<cfcase value="6">
	                    <div itemscope itemtype="http://schema.org/AutoDealer">                        
						<cfloop query="Get_Phones">
							<cfif Get_Phones.Phone_ID eq Get_Nav.Phone_ID>
								<cfif len(trim(Get_Phones.Vanity_Number)) gt 0>
									<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Name# #Get_Phones.Vanity_Number#" itemprop="telephone">#Get_Nav.Nav_Name# #Get_Phones.Vanity_Number#</div>
								<cfelse>
									<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Name# (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#" itemprop="telephone">#Get_Nav.Nav_Name# (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</div>
								</cfif>
							</cfif>
						</cfloop>
                        </div>
					</cfcase>
					<cfcase value="10">
                    <div itemscope itemtype="http://schema.org/AutoDealer">
						<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#arguments.address_1# #arguments.address_2# #arguments.city#, #arguments.state# #arguments.zip#" itemprop="address" itemscope itemtype="ttp://schema.org/PostalAddress">
							<span itemprop="streetAddress">#arguments.address_1#</span><br/>
							<cfif len(trim(arguments.address_2)) gt 0>#arguments.address_2#<br/></cfif>
							<span itemprop="addressLocality">#arguments.city#</span>, <span itemprop="addressRegion">#arguments.state#</span> <span itemprop="postalCode">#arguments.zip#</span>
						</div>
                    </div>
					</cfcase>
					<cfcase value="11">
                    <div itemscope itemtype="http://schema.org/AutoDealer">
						<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#arguments.address_1# #arguments.address_2# #arguments.city#, #arguments.state# #arguments.zip#" itemprop="address" itemscope itemtype="ttp://schema.org/PostalAddress">
							<span itemprop="streetAddress">#arguments.address_1#</span> | <cfif len(trim(arguments.address_2)) gt 0>#arguments.address_2# | </cfif><span itemprop="addressLocality">#arguments.city#</span>, <span itemprop="addressRegion">#arguments.state#</span> <span itemprop="postalCode">#arguments.zip#</span>
						</div>
                    </div>
					</cfcase>
					<cfcase value="12">
						<cfif len(trim(Get_Nav.Nav_Image_Code)) gt 0>
							<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##">
								#Get_Nav.Nav_Image_Code#
							</a>
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
									<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##">
										<img style="#variables.element_style#" class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
									</a>
								<cfelse>
									<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##">
										<img style="#variables.element_style#" class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
									</a>
								</cfif>
							</cfif>
						</cfif>
					</cfcase>
					<cfcase value="13">
						<cfswitch expression="#url.site_mode#">
							<cfdefaultcase>
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#"  title="#Get_Nav.Nav_Alt#" href="##" data-toggle="modal" data-target="##videoModal">
									<img class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
							</cfdefaultcase>
							<cfcase value="legacy">
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#"  title="#Get_Nav.Nav_Alt#" href="http://#cgi.server_name#/dealership/videos.cfm">
									<img class="nav_#Get_Nav.Nav_ID#" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>							
							</cfcase>
						</cfswitch>
						<cfbreak>
					</cfcase>
					<cfcase value="14">
						<cfif len(trim(Get_Nav.Snippet)) gt 0>
							<div id="nav_#Get_Nav.Nav_ID#" style="display:block;#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Name#">
								#Get_Nav.Snippet#
							</div>
						</cfif>
					</cfcase>
					<cfcase value="15">
						<div class="redline"></div>
					</cfcase>
					<cfcase value="16">
						<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
							<a href="http://#cgi.server_name#/special_offers/print_me.cfm?Nav_ID=#Get_Nav.Nav_ID#" id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#" target="_blank">
								<img class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							</a>
						<cfelse>
							<a href="http://#cgi.server_name#/special_offers/print_me.cfm?Nav_ID=#Get_Nav.Nav_ID#" id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" title="#Get_Nav.Nav_Alt#" target="_blank">
								<img class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							</a>
						</cfif>
					</cfcase>
					<cfcase value="17">
						<cfif len(trim(Get_Nav.Nav_Link)) gt 0>
							<cfif len(trim(arguments.colspan)) eq 0>
								<cfset arguments.colspan=6>
							</cfif>
							<div class="col-md-#arguments.colspan#" style="align:center">
								<div title="#Get_Nav.Nav_Name#">#Get_Nav.Nav_Name#</div>
								<div class="#variables.element_class#">
									<iframe width="#Get_Nav.Width#" height="#Get_Nav.Height#" src="#Get_Nav.Nav_Link#" frameborder="0" allowfullscreen></iframe>
								</div>
							</div>
						</cfif>
					</cfcase>
					
				</cfswitch>
			</cfif>
		</cfloop>

	</cffunction>

	<cffunction name="icon_label" description="carousel nav driven by a query" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="pull" default="">
		<cfargument name="responsive" default="true">

		<cfset variables.element_class="#arguments.element_class#">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<cfloop query="Get_Nav">

			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
				<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
					<a class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
						<img style="#variables.element_style#"  class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
						#Get_Nav.Nav_Alt#
					</a>
				<cfelse>
					<a class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
						<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
						#Get_Nav.Nav_Alt#
					</a>
				</cfif>

			</cfif>

		</cfloop>
	
	</cffunction>

	<cffunction name="table" description="carousel nav driven by a query" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<cfloop query="Get_Nav">

			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif len(trim(Get_Nav.Nav_Link)) gt 0>
					<td style="align:center">
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
								 <a id="nav_#Get_Nav.nav_id#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img  class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>						
							<cfelse>
								<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
							</cfif>
						</cfif>
					</td>
				</cfif>

			</cfif>
		</cfloop>

	</cffunction>


<!--- Service Center Coupons --->
	<cffunction name="sccoupons" description="carousel nav driven by a query" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<cfloop query="Get_Nav">

			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif len(trim(Get_Nav.Nav_Link)) gt 0>
					<td style="align:center">
						<!--- <cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
								 <a id="nav_#Get_Nav.nav_id#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img  class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>						
							<cfelse>
								<a id="nav_#Get_Nav.Nav_ID#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
							</cfif>
						</cfif> --->
					</td>
				</cfif>

			</cfif>
		</cfloop>

	</cffunction>
<!--- Service Center Coupons --->
	
	
	<cffunction name="banner" description="banner nav driven by a query" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="page_id" required="true">
		<cfargument name="displayPageVal" default="3">
        
        
		<cfset Get_Nav=arguments.Get_Nav>
		<cfset variables.nav_count=0>	
		<cfloop query="Get_Nav">
        <cfif arguments.displayPageVal contains Get_Nav.displayPage>
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id and ( Get_Nav.Script_Name eq arguments.page_id or IsDefined("url.is_vdp_page"))>
				<cfset variables.nav_count=variables.nav_count+1>	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>
                
				<cfif len(trim(Get_Nav.Nav_Link)) gt 0>
					<div class="row row-centered" >
						<div class="md-col-12 pad-top-10 col-centered " style="text-align:center">
							<cfif get_nav.Nav_Behaviour_ID neq 3><a id="nav_#Get_Nav.nav_id#" class="#arguments.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"></cfif>
								<img class=" img-responsive nav_#Get_Nav.Nav_ID#" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							<cfif get_nav.Nav_Behaviour_ID neq 3></a></cfif>
						</div>
					</div>
				</cfif>
			</cfif>
		</cfif>		
		</cfloop>
	</cffunction>

	<cffunction name="carousel" description="carousel nav driven by a query" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="max_icons" required="true">

		<cfset Get_Nav=arguments.Get_Nav>

		<cfset variables.nav_count=0>
		<cfloop query="Get_Nav">
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
				<cfset variables.nav_count=variables.nav_count+1>
			</cfif>
		</cfloop>

		<cfif variables.nav_count lte arguments.max_icons>

			<cfset variables.nav_count=0>
		
			<cfloop query="Get_Nav">
				
				<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

					<div class="col-md-#round(12/arguments.max_icons)#" style="align:center">
		
						<cfset variables.nav_count=variables.nav_count+1>
			
						<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
							<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
						<cfelse>
							<cfif left(Get_Nav.Nav_Link,4) neq "http">
								<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
							</cfif>
						</cfif>
		
						<cfset variables.element_class="#arguments.element_class#">
			
						<!---nav switches--->
						<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
							<cfcase value="1">
								<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
									<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
								<cfelse>
									<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
										<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
											<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
										</a>						
									<cfelse>
										<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
											<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
										</a>
									</cfif>
								</cfif>
							</cfcase>
							<cfcase value="2">
								<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
									<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
								<cfelse>
									<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
										<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
											<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
										</a>						
									<cfelse>
										<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
											<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
										</a>
									</cfif>
								</cfif>					
							</cfcase>
							<cfcase value="3">
								<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
									<div id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
								<cfelse>
									<div id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">
										<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
									</div>
								</cfif>					
							</cfcase>
						</cfswitch>
			
					</div>
			
				</cfif>
	
			</cfloop>
			
		</cfif>
	
	</cffunction>

	<cffunction name="carousel_legacy" description="carousel nav driven by a query" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="max_icons" required="true">

		<cfset Get_Nav=arguments.Get_Nav>

		<cfset variables.nav_count=0>
		<cfloop query="Get_Nav">
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
				<cfset variables.nav_count=variables.nav_count+1>
			</cfif>
		</cfloop>

		<cfif variables.nav_count lte arguments.max_icons>

			<cfset variables.nav_count=0>
		
			<table style="width:100%">
				<tr>
					<cfloop query="Get_Nav">
						
						<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>
		
							<td style="align:center">
				
								<cfset variables.nav_count=variables.nav_count+1>
					
								<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
									<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
								<cfelse>
									<cfif left(Get_Nav.Nav_Link,4) neq "http">
										<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
									</cfif>
								</cfif>
				
								<cfset variables.element_class="#arguments.element_class#">
					
								<!---nav switches--->
								<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
									<cfcase value="1">
										<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
											<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
										<cfelse>
											<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
												<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
													<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
												</a>						
											<cfelse>
												<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
													<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
												</a>
											</cfif>
										</cfif>
									</cfcase>
									<cfcase value="2">
										<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
											<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
										<cfelse>
											<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
												<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
													<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
												</a>						
											<cfelse>
												<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
													<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
												</a>
											</cfif>
										</cfif>					
									</cfcase>
									<cfcase value="3">
										<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
											<div id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
										<cfelse>
											<div id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">
												<img class="#Get_Nav.Nav_ID# img-responsive" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
											</div>
										</cfif>					
									</cfcase>
								</cfswitch>
					
							</td>
					
						</cfif>
			
					</cfloop>
				</tr>
			</table>
			
		</cfif>
	
	</cffunction>
	
	<cffunction name="standard" description="shows a standard nav element" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<!---<cfargument name="dealer_template_id" required="true">--->

		<cfinclude template="/ultra10/dealer/#arguments.assets#/data/nav_data_#nav_type_id#.cfm">
		
		<cfset variables.nav_count=0>

		<cfloop list="#variables.nav_names#" index="main_nav" delimiters="^">
			
			<cfset variables.nav_count=variables.nav_count+1>

			<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
				<cfset variables.element_class="#arguments.element_class#-bold">
			<cfelse>
				<cfset variables.element_class="#arguments.element_class#">
			</cfif>

			<!--- nav id --->
			<cfset variables.nav_id="nav_#listgetat(variables.nav_ids,'#variables.nav_count#','^')#">

			<!--- nav behaviour --->
			<cfset variables.behaviour="#listgetat(variables.nav_behaviours,'#variables.nav_count#','^')#">

			<!--- alt text --->
			<cfset variables.alt="#listgetat(variables.nav_alts,'#variables.nav_count#','^')#">
			<cfif variables.alt eq "NULL"><cfset variables.alt="#variables.main_nav#"></cfif> <!--- 03/04/2015 --->

			<!--- nav link --->
			<cfset variables.nav_link="#listgetat(variables.nav_links,'#variables.nav_count#','^')#">
			<cfif variables.nav_link eq "NULL"><cfset variables.nav_link=""></cfif>

			<!--- nav img --->
			<cfset variables.nav_img="#listgetat(variables.nav_imgs,'#variables.nav_count#','^')#">
			<cfif variables.nav_img eq "NULL"><cfset variables.nav_img=""></cfif>

			<!--- nav rollover img --->
			<cfset variables.nav_roll_img="#listgetat(variables.nav_rollovers,'#variables.nav_count#','^')#">
			<cfif variables.nav_roll_img eq "NULL"><cfset variables.nav_roll_img=""></cfif>
			
			<!---nav switches--->
			<cfswitch expression="#variables.behaviour#">
				<cfcase value="1">
					<cfif len(trim(variables.nav_img)) eq 0>
						<a id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id# " href="#variables.nav_link#" title="#variables.alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#variables.main_nav#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
					<cfelse>
						<cfif len(trim(variables.nav_roll_img)) eq 0>
							<a id="#variables.nav_id#" class="#variables.element_class#" href="#variables.nav_link#" title="#variables.alt#">
								<img class="#variables.nav_id# img-responsive" alt="#variables.alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#variables.nav_img#" />
							</a>						
						<cfelse>
							<a id="#variables.nav_id#" class="#variables.element_class# rollover" href="#variables.nav_link#" title="#variables.alt#">
								<img class="#variables.nav_id# img-responsive" alt="#variables.alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#variables.nav_img#" />
							</a>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="2">
					<cfif len(trim(variables.nav_img)) eq 0>
						<a id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id#" href="#variables.nav_link#" title="#variables.alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#variables.main_nav#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>
					<cfelse>
						<cfif len(trim(variables.nav_roll_img)) eq 0>
							<a id="#variables.nav_id#" class="#variables.element_class#" href="#variables.nav_link#" title="#variables.alt#" target="_blank">
								<img class="#variables.nav_id# img-responsive" alt="#variables.alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#variables.nav_img#" />
							</a>						
						<cfelse>
							<a id="#variables.nav_id#" class="#variables.element_class# rollover" href="#variables.nav_link#" title="#variables.alt#" target="_blank">
								<img class="#variables.nav_id# img-responsive" alt="#variables.alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#variables.nav_img#" />
							</a>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="3">
					<cfif len(trim(variables.nav_img)) eq 0>
						<div id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id#" title="#variables.alt#">#variables.main_nav#</div>
					<cfelse>
						<div id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id#" title="#variables.alt#"><img class="img-responsive" alt="#variables.alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#variables.nav_img#" /></div>
					</cfif>
				</cfcase>
				<cfcase value="6">
					<div id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id#" title="#variables.alt#">#variables.main_nav#</div>
				</cfcase>
				<cfcase value="10">
					<div id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id#" title="#variables.alt#">#variables.main_nav#</div>
				</cfcase>
				<cfcase value="11">
					<div id="#variables.nav_id#" class="#variables.element_class# #variables.nav_id#" title="#variables.alt#">#variables.main_nav#</div>
				</cfcase>
			</cfswitch>
		</cfloop>
	
	</cffunction>
<!--- **************************************************************************************** --->

	<cffunction name="multi_banner" description="sectional banner pages by hierarchy" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="nav_type_id" required="true">
		<cfargument name="Get_Nav" required="true">
		<cfargument name="Get_Phones" required="true">
		<cfargument name="assets" required="true">
		<cfargument name="element_class" required="true">
		<cfargument name="bold_top" default="false">
		<cfargument name="pull" default="">
		<cfargument name="glyph_left" default="false">
		<cfargument name="glyph_right" default="false">
		<cfargument name="dealer_name" default="">
		<cfargument name="address_1" default="">	
		<cfargument name="address_2" default="">
		<cfargument name="city" default="">
		<cfargument name="state" default="">
		<cfargument name="zip" default="">
		<cfargument name="responsive" default="true">
		<cfargument name="colspan" default="">
		<cfargument name="which_select" default="1">

		<cfset Get_Nav=arguments.Get_Nav>
		<cfset Get_Phones=arguments.Get_Phones>

		<cfset variables.nav_count=0>
	
		<cfloop query="Get_Nav">
<cfif #arguments.which_select# EQ #Get_Nav.Hierarchy# >
			<cfif Get_Nav.Nav_Type_ID eq arguments.nav_type_id>

				<cfset variables.nav_count=variables.nav_count+1>
	
				<cfif Get_Nav.Nav_Link eq "index.cfm" or len(trim(Get_Nav.Nav_Link )) eq 0>
					<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#">
				<cfelse>
					<cfif left(Get_Nav.Nav_Link,4) neq "http">
						<cfset Get_Nav.Nav_Link="http://#lcase(cgi.server_name)#/#lcase(Get_Nav.Nav_Link)#">
					</cfif>
				</cfif>

				<cfif arguments.bold_top eq "true" and variables.nav_count eq 1>
					<cfset variables.element_class="#arguments.element_class#-bold">
				<cfelse>
					<cfset variables.element_class="#arguments.element_class#">
				</cfif>

				<!---Create Inline Styles--->
				<cfset variables.element_style="">
				<cfif len(trim(Get_Nav.Align)) gt 0>
					<cfset variables.element_style=variables.element_style & "text-align:#Get_Nav.Align#;">
				</cfif>
				<cfif len(trim(Get_Nav.Text_Color)) gt 0>
					<cfset variables.element_style=variables.element_style & "color:###Get_Nav.Text_Color#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Size)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-size:#Get_Nav.Font_Size#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Family)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-family:#Get_Nav.Font_Family#;">
				</cfif>
				<cfif len(trim(Get_Nav.Font_Weight)) gt 0>
					<cfset variables.element_style=variables.element_style & "font-weight:#Get_Nav.Font_Weight#;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Top)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-top:#Get_Nav.Margin_Top#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Bottom)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-bottom:#Get_Nav.Margin_Bottom#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Left)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-left:#Get_Nav.Margin_Left#px;">
				</cfif>
				<cfif len(trim(Get_Nav.Margin_Right)) gt 0>
					<cfset variables.element_style=variables.element_style & "margin-right:#Get_Nav.Margin_Right#px;">
				</cfif>
				<cfif Get_Nav.pull eq "clear">
					<cfset variables.element_style=variables.element_style & "display:block;clear:both;">
					<cfset Get_Nav.pull="">
				</cfif>
				
				<cfif len(trim(Get_Nav.pull)) neq 0>
					<cfset arguments.pull=Get_Nav.pull>
				</cfif>
				
				<cfif arguments.pull eq "left">
					<cfset variables.element_class=variables.element_class & " pull-left">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:left;">
					</cfif>	
				</cfif>

				<cfif arguments.pull eq "right">
					<cfset variables.element_class=variables.element_class & " pull-right">
					<cfif url.site_mode eq "legacy">
						<cfset variables.element_style=variables.element_style & "float:right;">
					</cfif>	
				</cfif>
				
				<!---nav switches--->
                <!-- 119 - #Get_Nav.Nav_Behaviour_ID#-->
				<cfswitch expression="#Get_Nav.Nav_Behaviour_ID#">
					<cfcase value="1">
						<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#">
									<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
							<cfset variables.element_class="#variables.element_class# visible-lg visible-md">
						</cfif>
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#"><cfif arguments.glyph_left eq "true"><span <cfif #url.dealer_ID# eq 84>style="color:##2E9ADF;"</cfif><cfif #url.dealer_ID# eq 30 and arguments.nav_type_id eq 12>style="color:##ffffff;"</cfif>  class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img style="#variables.element_style#"  class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#">
									<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
						</cfif>
					</cfcase>
					<cfcase value="2">
						<cfif len(trim(Get_Nav.Nav_Mobile_Link)) gt 0>
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# visible-sm visible-xs" href="#Get_Nav.Nav_Mobile_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img style="#variables.element_style#"  class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
							<cfset variables.element_class="#variables.element_class# visible-lg visible-md">
						</cfif>
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# " href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img style="#variables.element_style#" class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>						
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							<cfelse>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0><div style="align:#Get_Nav.Align#"></cfif>
								<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" href="#Get_Nav.Nav_Link#" title="#Get_Nav.Nav_Alt#" target="_blank">
									<img style="#variables.element_style#" class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
								<cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0></div></cfif>
							</cfif>
						</cfif>
					</cfcase>
					<cfcase value="3">
						<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
							<div style="#variables.element_style#" id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#">#Get_Nav.Nav_Name#</div>
						<cfelse>
							<div id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#" <cfif len(trim(Get_Nav.pull)) eq 0 and  len(trim(Get_Nav.Align)) neq 0>style="align:#Get_Nav.Align#"</cfif>>
								<img style="#variables.element_style#" class="#Get_Nav.Nav_ID# <cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							</div>
						</cfif>					
					</cfcase>
					<cfcase value="4">
						<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#;text-decoration:none" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" href="http://#cgi.server_name#" title="#url.dealer_name#">#url.dealer_name#</a>	
					</cfcase>
					<cfcase value="6">
	                    <div itemscope itemtype="http://schema.org/AutoDealer">                        
						<cfloop query="Get_Phones">
							<cfif Get_Phones.Phone_ID eq Get_Nav.Phone_ID>
								<cfif len(trim(Get_Phones.Vanity_Number)) gt 0>
									<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Name# #Get_Phones.Vanity_Number#" itemprop="telephone">#Get_Nav.Nav_Name# #Get_Phones.Vanity_Number#</div>
								<cfelse>
									<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Name# (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#" itemprop="telephone">#Get_Nav.Nav_Name# (#Get_Phones.Area_Code#) #Get_Phones.Prefix#-#Get_Phones.Line_Number#</div>
								</cfif>
							</cfif>
						</cfloop>
                        </div>
					</cfcase>
					<cfcase value="10">
                    <div itemscope itemtype="http://schema.org/AutoDealer">
						<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#arguments.address_1# #arguments.address_2# #arguments.city#, #arguments.state# #arguments.zip#" itemprop="address" itemscope itemtype="ttp://schema.org/PostalAddress">
							<span itemprop="streetAddress">#arguments.address_1#</span><br/>
							<cfif len(trim(arguments.address_2)) gt 0>#arguments.address_2#<br/></cfif>
							<span itemprop="addressLocality">#arguments.city#</span>, <span itemprop="addressRegion">#arguments.state#</span> <span itemprop="postalCode">#arguments.zip#</span>
						</div>
                    </div>
					</cfcase>
					<cfcase value="11">
                    <div itemscope itemtype="http://schema.org/AutoDealer">
						<div id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#arguments.address_1# #arguments.address_2# #arguments.city#, #arguments.state# #arguments.zip#" itemprop="address" itemscope itemtype="ttp://schema.org/PostalAddress">
							<span itemprop="streetAddress">#arguments.address_1#</span> | <cfif len(trim(arguments.address_2)) gt 0>#arguments.address_2# | </cfif><span itemprop="addressLocality">#arguments.city#</span>, <span itemprop="addressRegion">#arguments.state#</span> <span itemprop="postalCode">#arguments.zip#</span>
						</div>
                    </div>
					</cfcase>
					<cfcase value="12">
						<cfif len(trim(Get_Nav.Nav_Image_Code)) gt 0>
							<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##">
								#Get_Nav.Nav_Image_Code#
							</a>
						<cfelse>
							<cfif len(trim(Get_Nav.Nav_Image)) eq 0>
								<a id="nav_#Get_Nav.Nav_ID#" style="#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##"><cfif arguments.glyph_left eq "true"><span class="glyphicon glyphicon-chevron-right"></span> </cfif>#Get_Nav.Nav_Name#<cfif arguments.glyph_right eq "true"> <span class="glyphicon glyphicon-chevron-right pull-right"></span></cfif></a>	
							<cfelse>
								<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
									<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##">
										<img style="#variables.element_style#" class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
									</a>
								<cfelse>
									<a id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" onclick="javascript:window.open('#Get_Nav.Nav_Link#);return false;" title="#Get_Nav.Nav_Alt#" href="##">
										<img style="#variables.element_style#" class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
									</a>
								</cfif>
							</cfif>
						</cfif>
					</cfcase>
					<cfcase value="13">
						<cfswitch expression="#url.site_mode#">
							<cfdefaultcase>
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#"  title="#Get_Nav.Nav_Alt#" href="##" data-toggle="modal" data-target="##videoModal">
									<img class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>
							</cfdefaultcase>
							<cfcase value="legacy">
								<a id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#"  title="#Get_Nav.Nav_Alt#" href="http://#cgi.server_name#/dealership/videos.cfm">
									<img class="nav_#Get_Nav.Nav_ID#" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
								</a>							
							</cfcase>
						</cfswitch>
						<cfbreak>
					</cfcase>
					<cfcase value="14">
						<cfif len(trim(Get_Nav.Snippet)) gt 0>
							<div id="nav_#Get_Nav.Nav_ID#" style="display:block;#variables.element_style#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Name#">
								#Get_Nav.Snippet#
							</div>
						</cfif>
					</cfcase>
					<cfcase value="15">
						<div class="redline"></div>
					</cfcase>
					<cfcase value="16">
						<cfif len(trim(Get_Nav.Nav_Rollover)) eq 0>
							<a href="http://#cgi.server_name#/special_offers/print_me.cfm?Nav_ID=#Get_Nav.Nav_ID#" id="nav_#Get_Nav.nav_id#" class="#variables.element_class# nav_#Get_Nav.Nav_ID#" title="#Get_Nav.Nav_Alt#" target="_blank">
								<img class="nav_#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							</a>
						<cfelse>
							<a href="http://#cgi.server_name#/special_offers/print_me.cfm?Nav_ID=#Get_Nav.Nav_ID#" id="nav_#Get_Nav.Nav_ID#" class="#variables.element_class# nav_#Get_Nav.Nav_ID# rollover" title="#Get_Nav.Nav_Alt#" target="_blank">
								<img class="#Get_Nav.Nav_ID#<cfif arguments.responsive eq "true"> img-responsive</cfif>" alt="#Get_Nav.Nav_Alt#" src="http://#cgi.server_name#/dealer/#arguments.assets#/images/icons/#Get_Nav.Nav_Image#" />
							</a>
						</cfif>
					</cfcase>
					<cfcase value="17">
						<cfif len(trim(Get_Nav.Nav_Link)) gt 0>
							<cfif len(trim(arguments.colspan)) eq 0>
								<cfset arguments.colspan=6>
							</cfif>
							<div class="col-md-#arguments.colspan#" style="align:center">
								<div title="#Get_Nav.Nav_Name#">#Get_Nav.Nav_Name#</div>
								<div class="#variables.element_class#">
									<iframe width="#Get_Nav.Width#" height="#Get_Nav.Height#" src="#Get_Nav.Nav_Link#" frameborder="0" allowfullscreen></iframe>
								</div>
							</div>
						</cfif>
					</cfcase>
					
				</cfswitch>
			</cfif>
</cfif>			
		</cfloop>

	</cffunction>


	
	
	
	
	
</cfcomponent>