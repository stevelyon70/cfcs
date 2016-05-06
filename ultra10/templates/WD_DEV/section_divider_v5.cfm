<cfoutput>
		
<!--- Splash Banners --->
 <cfset which_select = 5 >
 
<!--- Text Above and/or below Banners --->
	<cfquery name="dtxt5" datasource="Ultra10">
		SELECT	ID, dealer_id, template_id, section_height, background_image, background_color, wireframe_status, main_ic_width, main_ic_pad_top, main_ic_pad_left, main_ic_pad_right, 
            main_ic_pad_bottom, split_box1_on, split_box1_width,split_box1_left_border,split_box1_right_border, split_box1_top_pad, split_box1_top_left_pad, split_box1_top_right_pad, split_box1_top_bottom_pad, 
            split_box1_title, split_box2_on, split_box2_width,split_box2_left_border,split_box2_right_border, split_box2_top_pad, split_box2_top_left_pad, split_box2_top_right_pad, split_box2_top_bottom_pad, 
            split_box2_title, active, hierarchy
		FROM    Variable_Multi_Section
		WHERE	dealer_id = #url.dealer_id#
		AND hierarchy = #which_select#
		AND	template_id = 20
		order by hierarchy ASC
	</cfquery>



<cfset wireframe_d5 = "#dtxt5.wireframe_status#" >		<!--- FOR TESTING ONLY  --->


<style type="text/css">
.d5-section_multi{  height:<cfoutput>#dtxt5.section_height#</cfoutput>; background: url('<cfoutput>#dtxt5.background_image#</cfoutput>') no-repeat center top; -webkit-background-size: cover;  -moz-background-size: cover;  -o-background-size: cover;
	 			background-size: cover; background-color: <cfoutput>###dtxt5.background_color#</cfoutput>; border:<cfoutput>#wireframe_d3#</cfoutput>; }

.d5-left-block {   width:<cfoutput>#dtxt5.split_box1_width#</cfoutput>; margin-top:<cfoutput>#dtxt5.split_box1_top_pad#</cfoutput>; margin-left:<cfoutput>#dtxt5.split_box1_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#dtxt5.split_box1_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#dtxt5.split_box1_top_bottom_pad#</cfoutput>; float:left; 
				border:<cfoutput>#wireframe_d5#</cfoutput>; }
.d5-left-title-block {   width:100%;border-left:<cfoutput>#dtxt5.split_box1_left_border#</cfoutput>;border-right:<cfoutput>#dtxt5.split_box1_right_border#</cfoutput>; margin-bottom: <cfoutput>#dtxt5.split_box1_top_bottom_pad#</cfoutput>; }
.d5-right-block { 	width:	<cfoutput>#dtxt5.split_box2_width#</cfoutput>; margin-top: 	<cfoutput>#dtxt5.split_box2_top_pad#</cfoutput>; margin-left: <cfoutput>#dtxt5.split_box2_top_left_pad#</cfoutput>;
				margin-right: 	<cfoutput>#dtxt5.split_box2_top_right_pad#</cfoutput>; margin-bottom: 	<cfoutput>#dtxt5.split_box2_top_bottom_pad#</cfoutput>; float:right;  
				border:<cfoutput>#wireframe_d5#</cfoutput>;  }
.d5-right-title-block {   width:100%;border-left:<cfoutput>#dtxt5.split_box2_left_border#</cfoutput>;border-right:<cfoutput>#dtxt5.split_box2_right_border#</cfoutput>; }

</style>

			
<!--- Splash Banners --->
 
	<cfquery name="Chk_Splash_v5" datasource="Ultra10" >
		SELECT  Nav_ID, Dealer_ID, Nav_Type_ID,Start_Date, End_Date
		FROM    Navigation
		WHERE  	Dealer_ID = #url.dealer_id# 
		AND 	Nav_Type_ID = 41  
		AND 	hierarchy = #which_select#
		AND 	GETDATE() between Start_Date AND End_Date 	
		ORDER BY Start_Date ASC
	</cfquery>
	
	<cfif #Chk_Splash_v5.recordcount# NEQ 0 OR  #dtxt5.recordcount# NEQ 0 >
		<div container-fluid >
			<section class="d5-section_multi">
				<div class="container pad-top-10 visible-md visible-lg visible-sm visible-xs">
					<cfif #dtxt5.recordcount# NEQ 0	>
						<cfif #dtxt5.split_box1_on# EQ 1 >
							<div class="row  row-centered">
								<div class="d5-left-block" >
									<div class="col-md-12 d5-left-title-block" >
										 #dtxt5.split_box1_title#
									</div>	
								</div>	
							</div>
						</cfif>		
					</cfif>		
					<cfif #Chk_Splash_v5.recordcount# NEQ 0	>
						<div class="row  row-centered">
							<div class="col-centered no-pad" style="align:center">
								<cfinvoke component="/cfcs/ultra10/nav_elements" method="multi_banner">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="41"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="splash-icons"/>
									<cfinvokeargument name="pull" value="none"/>
									<cfinvokeargument name="which_select" value="#which_select#"/>
								</cfinvoke>
							</div>
						</div>
					</cfif>
					<cfif #dtxt5.recordcount# NEQ 0	>
						<cfif #dtxt5.split_box2_on# EQ 1 >
							<div class="row  row-centered">
								<div class="d5-right-block" >
									<div class="col-md-12 d5-right-title-block" >
										 #dtxt5.split_box2_title#
									</div>	
								</div>	
							</div>
						</cfif>		
					</cfif>	
				</div>  
			</section>
		</div>  
	</cfif>

</cfoutput>

