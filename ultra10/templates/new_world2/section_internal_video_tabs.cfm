<cfoutput>

		
		<cfif NOT IsDefined("url.v_make") >
			<cfset url.v_make = "" >
		</cfif>
	<cfquery datasource="Ultra10" name="get_content">
		SELECT	 ID, dealer_id, Page_Type, Vehicle_Make, Title, title_font_family, title_font_size, title_font_color, title_font_weight, title_decoration, text_section, 
                      text_font_family, text_font_size, text_font_color, text_font_weight, text_decoration, button_text, btn_background, btn_text_font_size, btn_text_font_color, 
                      btn_text_font_family, btn_text_font_weight, btn_text_decoration, button_link, Video, Video_Image, Video_position, link_1_text, link_1, link_1_inc, link_2_text, link_2, 
                      link_2_inc, link_3_text, link_3, link_3_inc, link_4_text, link_4, link_4_inc, link_5_text, link_5, link_5_inc, link_6_text, link_6, link_6_inc, link_font_color, 
                      link_font_family, link_font_size, link_font_weight, link_decoration, active, hierarchy,tab_active_on_load,tab_location,tabs_on_off
		FROM    Dealer_Internal_Video
		WHERE	dealer_id = #url.dealer_id#
		<cfif IsDefined("url.v_make") and #url.v_make# NEQ "" >
			AND		Vehicle_Make = '#url.v_make#'
			AND		page_type = 4
		<cfelseif #url.dealer_id# eq 233>	
			AND page_type = 0
		<cfelse>	
			AND page_type = 8
		</cfif>
		AND		active = 1
		ORDER BY hierarchy ASC
	</cfquery>
	<cfset active_class = ArrayNew(1) >
	<cfset content_active_class = ArrayNew(1) >
	<cfloop index="x" from="1" to="6" ><cfset active_class[x] = "" ><cfset content_active_class[x] = "" ></cfloop>
	<cfif #get_content.tab_active_on_load# GT 0 >
		<cfset active_class[#get_content.tab_active_on_load#] = "active" >
		<cfset content_active_class[#get_content.tab_active_on_load#] = "in active" >
	</cfif>
	
	<style>
		.nav-tabs 	{
					font-size:#get_content.link_font_size#!important;
					font-weight:bold!important;
					font-decoration:none;
					}		
	 	.nav-tabs, li, a	{
							color:###get_content.link_font_color#!important;  
							}
	</style>
	
<div class="container-fluid">
	<cfif #get_content.recordcount# NEQ 0 >
		<section class="section-internal-video">
			<div class="container">
			<cfloop query="get_content" >
				<div class="row"><div class="col-md-12 pad-top-10 visible-sm visible-xs visible-lg visible-md"><div class="gradient"></div></div></div>	
					<div class="row">
						<cfif #get_content.Video_position# EQ 0 >
							<div class="col-md-1 pad-top-10 pad-5" >&nbsp;</div>
							<div class="col-md-4 pad-top-10 pad-5">
								 <div class="row-centered"><div class="col-centered   pad-bottom-10 visible-sm visible-xs visible-lg visible-md">	 
									<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="video_var">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="30"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="video-link"/>
										<cfinvokeargument name="glyph_left" value="true"/>
										<cfinvokeargument name="pass_make" value="#url.v_make#"/>
										<cfinvokeargument name="pass_video" value="#get_content.id#"/>
									</cfinvoke>
									</div></div>
								</div>
						</cfif>
					 
					
						<div class="col-md-6">
						

							<cfif #get_content.tabs_on_off# NEQ "0" AND #get_content.tab_location# EQ 0 >
								 <div class="row">  
									<div class="col-md-12 pull-left  pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
									
											<ul class="nav nav-tabs"> 
											  <li> <a class="#active_class[1]#" data-toggle="tab" href="##tab1">#get_content.link_1_text#</a></li>
											  <cfif #get_content.link_2_text# NEQ "" >
											 	 <li><a class="#active_class[2]#" data-toggle="tab" href="##tab2">#get_content.link_2_text#</a></li>
												</cfif>	 
											  <cfif #get_content.link_3_text# NEQ "" >
											 	 <li><a class="#active_class[3]#" data-toggle="tab" href="##tab3">#get_content.link_3_text#</a></li>
												</cfif>	 
											  <cfif #get_content.link_4_text# NEQ "" >
											  	<li><a class="#active_class[4]#" data-toggle="tab" href="##tab4">#get_content.link_4_text#</a></li>
											  </cfif>
											  <cfif #get_content.link_5_text# NEQ "" >
											  	<li><a class="#active_class[5]#" data-toggle="tab" href="##tab5">#get_content.link_5_text#</a></li>
											  </cfif>
											  <cfif #get_content.link_6_text# NEQ "" >
											  	<li><a class="#active_class[6]#" data-toggle="tab" href="##tab6">#get_content.link_6_text#</a></li>
											  </cfif>
											</ul>
											
											<div class="tab-content">
											  <div id="tab1" class="tab-pane fade #content_active_class[1]#">
											  <cfif #get_content.link_1_inc# NEQ "0" ><h3>#get_content.link_1_text#</h3></cfif>
											    <p>#RTrim(get_content.link_1)#<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="color:red!important;align:right">Close</span></a></div></p>
											  </div>
											  <div id="tab2" class="tab-pane fade #content_active_class[2]#">
											  <cfif #get_content.link_2_inc# NEQ "0" ><h3>#get_content.link_2_text#</h3> </cfif>
											    <p>#RTrim(get_content.link_2)#<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="color:red!important">Close</span></a></div></p>
											  </div>
											  <cfif #get_content.link_3_text# NEQ "" >
												  <div id="tab3" class="tab-pane fade #content_active_class[3]#">
												  <cfif #get_content.link_3_inc# NEQ "0" ><h3>#get_content.link_3_text#</h3> </cfif>
												    <p>#RTrim(get_content.link_3)#<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="color:red!important">Close</span></a></div></p>
												  </div>
											</cfif>	  
											  <cfif #get_content.link_4_text# NEQ "" >
												  <div id="tab4" class="tab-pane fade #content_active_class[4]#">
												  <cfif #get_content.link_4_inc# NEQ "0" ><h3>#get_content.link_4_text#</h3> </cfif>
												    <p>#RTrim(get_content.link_4)#<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="color:red!important">Close</span></a></div></p>
												  </div>
											</cfif>							  
											  <cfif #get_content.link_5_text# NEQ "" >
												  <div id="tab5" class="tab-pane fade #content_active_class[5]#">
												   <cfif #get_content.link_5_inc# NEQ "0" ><h3>#get_content.link_5_text#</h3> </cfif>
												    <p>#RTrim(get_content.link_5)#<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="color:red!important">Close</span></a></div></p>
												  </div>
											 </cfif> 
											  <cfif #get_content.link_6_text# NEQ "" >
												  <div id="tab6" class="tab-pane fade #content_active_class[6]#">
												  <cfif #get_content.link_6_inc# NEQ "0" ><h3>#get_content.link_6_text#</h3> </cfif>
												    <p>#RTrim(get_content.link_6)#<div align="center" ><a data-toggle="tab" href="##tabclear"><span  style="color:red!important">Close</span></a></div></p>
												  </div>
											 </cfif> 
											  <!--- Content Close --->
											  <div id="tabclear" class="tab-pane fade "></div>
											  
											</div>

									</div>
							
								  </div> 
						</cfif>
						
								<cfset tf_color = "###get_content.title_font_color#" >
								<cfset tf_size = "#get_content.title_font_size#" >
								<cfset tf_weight = "#get_content.title_font_weight#" >
								<cfset tf_familiy = "#get_content.title_font_family#" >
								<cfset tf_decor = "#get_content.title_decoration#" >
							<div class="spl-search-name pad-top-10 pad-5" style="align:left"><span style="font-style:#tf_decor#;color:#tf_color#;font-size:#tf_size#;font-weight:#tf_weight#;font-family:#tf_familiy#">#get_content.Title#</span></div>
								<div class="row">
									<cfset txtf_color = "###get_content.text_font_color#" >
									<cfset txtf_size = "#get_content.text_font_size#" >
									<cfset txtf_weight = "#get_content.text_font_weight#" >
									<cfset txtf_familiy = "#get_content.text_font_family#" >
									<cfset txtf_decor = "#get_content.text_decoration#" >
									<div class="col-md-12 pad-top-5 pad-5 visible-lg visible-md">
										<span style="font-style:#txtf_decor#;color:#txtf_color#;font-size:#txtf_size#;font-weight:#txtf_weight#;font-family:#txtf_familiy#">#get_content.text_section#
									</div>
								</div>			
								
								 <div class="row">
									<div class="col-md-12 pad-top-5 pad-bottom-10 visible-lg visible-md">
										<cfset btnf_bkgrnd = "###get_content.btn_background#" >
										<cfset btnf_color = "###get_content.btn_text_font_color#" >
										<cfset btnf_size = "#get_content.btn_text_font_size#" >
										<cfset btnf_weight = "#get_content.btn_text_font_weight#" >
										<cfset btnf_familiy = "#get_content.btn_text_font_family#" >
										<cfset btnf_decor = "#get_content.btn_text_decoration#" >
										<cfif #get_content.button_text# NEQ "" >
											<a href="../#get_content.button_link#" ><input type="button" class="btn " style="background-color:#btnf_bkgrnd#;font-style:#btnf_decor#;color:#btnf_color#;font-size:#btnf_size#;font-weight:#btnf_weight#;font-family:#btnf_familiy#" id="#get_content.button_text#" value="#get_content.button_text#"></a>
										<cfelse>
											&nbsp;	
										</cfif>
									</div>
								</div>	 


							<cfif #get_content.tabs_on_off# NEQ "0" AND #get_content.tab_location# EQ 1 >
								 <div class="row">  
									<div class="col-md-12 pull-left  pad-top-10 pad-bottom-10 visible-lg visible-md visible-sm visible-xs ">
									
											<ul class="nav nav-tabs">
											  <li> <a class="#active_class[1]#" data-toggle="tab" href="##tab1">#get_content.link_1_text#</a></li>
											  <li><a data-toggle="tab" href="##tab2">#get_content.link_2_text#</a></li>
											  <cfif #get_content.link_3_text# NEQ "" >
											 	 <li><a class="#active_class[3]#" data-toggle="tab" href="##tab3">#get_content.link_3_text#</a></li>
												</cfif>	 
											  <cfif #get_content.link_4_text# NEQ "" >
											  	<li><a class="#active_class[4]#" data-toggle="tab" href="##tab4">#get_content.link_4_text#</a></li>
											  </cfif>
											  <cfif #get_content.link_5_text# NEQ "" >
											  	<li><a class="#active_class[5]#" data-toggle="tab" href="##tab5">#get_content.link_5_text#</a></li>
											  </cfif>
											  <cfif #get_content.link_6_text# NEQ "" >
											  	<li><a class="#active_class[6]#" data-toggle="tab" href="##tab6">#get_content.link_6_text#</a></li>
											  </cfif>
											</ul>
											
											<div class="tab-content">
											  <div id="tab1" class="tab-pane fade #content_active_class[1]#">
											  <cfif #get_content.link_1_inc# NEQ "0" ><h3>#get_content.link_1_text#</h3></cfif>
											    <p>#get_content.link_1#</p>
											  </div>
											  <div id="tab2" class="tab-pane fade #content_active_class[2]#">
											  <cfif #get_content.link_2_inc# NEQ "0" ><h3>#get_content.link_2_text#</h3> </cfif>
											    <p>#get_content.link_2#</p>
											  </div>
											  <cfif #get_content.link_3_text# NEQ "" >
												  <div id="tab3" class="tab-pane fade #content_active_class[3]#">
												  <cfif #get_content.link_3_inc# NEQ "0" ><h3>#get_content.link_3_text#</h3> </cfif>
												    <p>#get_content.link_3#</p>
												  </div>
											</cfif>	  
											  <cfif #get_content.link_4_text# NEQ "" >
												  <div id="tab4" class="tab-pane fade #content_active_class[4]#">
												  <cfif #get_content.link_4_inc# NEQ "0" ><h3>#get_content.link_4_text#</h3> </cfif>
												    <p>#get_content.link_4#</p>
												  </div>
											</cfif>							  
											  <cfif #get_content.link_5_text# NEQ "" >
												  <div id="tab5" class="tab-pane fade #content_active_class[5]#">
												   <cfif #get_content.link_5_inc# NEQ "0" ><h3>#get_content.link_5_text#</h3> </cfif>
												    <p>#get_content.link_5#</p>
												  </div>
											 </cfif> 
											  <cfif #get_content.link_6_text# NEQ "" >
												  <div id="tab6" class="tab-pane fade #content_active_class[6]#">
												  <cfif #get_content.link_6_inc# NEQ "0" ><h3>#get_content.link_6_text#</h3> </cfif>
												    <p>#get_content.link_6#</p>
												  </div>
											 </cfif> 
											  
											  
											</div>

									</div>
							
								  </div> 
						</cfif>



						</div>


						
						<cfif #get_content.Video_position# EQ 1 >
							<div class="col-md-4 pad-top-10 pad-5" style="align:left">
								<div class="row"><div class="col-md-12 pad-bottom-10 visible-sm visible-xs visible-lg visible-md"></div></div>	
									<cfinvoke component="/cfcs/ultra10/var_nav_elements" method="video_var">
										<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
										<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
										<cfinvokeargument name="nav_type_id" value="30"/>
										<cfinvokeargument name="assets" value="#arguments.assets#"/>
										<cfinvokeargument name="element_class" value="video-link"/>
										<cfinvokeargument name="glyph_left" value="true"/>
										<cfinvokeargument name="pass_make" value="#url.v_make#"/>
										<cfinvokeargument name="pass_video" value="#get_content.id#"/>
									</cfinvoke>
							</div>
						</cfif>
					</div>
					<div class="row pad-top-10" style="min-height:20px;align:center"></div>
			</cfloop>	
			</div>
		</section>
  </cfif>	
</div>	
</cfoutput>