<cfoutput>
			
<!--- LOWER CTA Variation 1 --->
	<cfquery name="Get_Block4" datasource="Ultra10" maxrows="2" >
		SELECT  ID, dealer_id, name, image, link, active, create_ts,target, hierarchy
		FROM    Nav_Block_4
		where 	dealer_id = #url.dealer_id#
		and 	active = 1
		order by hierarchy ASC
	</cfquery>
	
	<cfif #Get_Block4.recordcount# NEQ 0 >
		<cfset a_name = ArrayNew(1)>
		<cfset a_image = ArrayNew(1)>
		<cfset a_link = ArrayNew(1)>
		<cfset a_target = ArrayNew(1)>
  		<cfset maxblk = #Get_Block4.recordcount# >
		<cfset y = 0>
	
		<cfloop query="Get_Block4">
			<cfset y = #y#+1>
			<cfset a_name[y] = #Get_Block4.name# >
			<cfset a_image[y] = #Get_Block4.image#>
			<cfset a_link[y] = #Get_Block4.link#>
			<cfset a_target[y] ="">
			<cfif #Get_Block4.target# NEQ "" ><cfset a_target[y] = "_blank"></cfif>
		</cfloop>
		
		<section class="section-cta-lower-v1">
			 <div class="container pad-top-10 pad-bottom-10">
				<div class="row pad-bottom-10">
					<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" style="align:center">
						<cfloop index="x" from="1" to="2">
							<div class="row pad-top-10" style="min-height:40px;align:center">
								<div class="col-md-12  visible-sm visible-xs  visible-lg visible-md" style="align:center">
									<a href="#a_link[x]#" target="#a_target[x]#" ><img class="img-responsive" src="http://dealers.wdautos.com/dealer/#url.assets#/images/icons/#a_image[x]#" style="border:2;border-color:white"></a>
								</div>
							</div>
						</cfloop>	
					</div>
					<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" style="align:center">
						<div class="row pad-top-10" style="min-height:40px;align:center">
						
							<div class="col-md-12  visible-lg visible-md" style="align:center">
							
		<!--- TEMPORARY UNTIL SITE GOES LIVE --->					
								<iframe width="450" height="330" src="//www.youtube.com/embed/videoseries?list=PLChOW8lu1vx25UWMSYwsEhSY-QOkcSmLE" showinfo="0" controls="0" frameborder="0" allowfullscreen></iframe>
								
<!--- 								<cfinvoke component="/cfcs/ultra10/nav_elements" method="query">
									<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
									<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
									<cfinvokeargument name="nav_type_id" value="30"/>
									<cfinvokeargument name="assets" value="#arguments.assets#"/>
									<cfinvokeargument name="element_class" value="video-link"/>
									<cfinvokeargument name="glyph_left" value="true"/>
								</cfinvoke> --->
							</div>
						</div>
					</div>
				</div>
			</div>	
			<div class="clearfix"></div>
		</section>
	</cfif>	

</cfoutput>
