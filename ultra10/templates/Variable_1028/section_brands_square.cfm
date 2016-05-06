
<cfoutput> 
  <!--- BRANDS --->
  <cfquery name="Get_Assigned_OEMs" datasource="Ultra10" >
	SELECT  a.ID, a.dealer_id, a.dealer_oem_image, a.oem_name, a.link_to, a.active, a.hierarchy, a.pg_2_link, a.pg_3_link, a.pg_4_link, a.pg_5_link, a.pg_6_link,a.pg_2_txt,a.pg_3_txt,a.pg_4_txt,a.pg_5_txt,a.pg_6_txt,
			a.website_link,a.website_target,a.link_to_target,a.pg_2_link_target,a.pg_3_link_target,a.pg_4_link_target,	a.pg_5_link_target,	a.pg_6_link_target,
			a.pg_7_link, a.pg_7_link_target, a.pg_7_txt,a.pg_8_link, a.pg_8_link_target, a.pg_8_txt,a.pg_9_link, a.pg_9_link_target, a.pg_9_txt,a.pg_10_link, a.pg_10_link_target, a.pg_10_txt
	FROM    Vulcan_Brand_Links_Square a
	where 	a.dealer_id = #url.dealer_id#
	and a.active = 1
	order by a.oem_name ASC
</cfquery>
  <cfset nbr_col = "2" >
  <cfset howmany = #Get_Assigned_OEMs.recordcount# >
  <cfquery name="gt_brands" datasource="Ultra10">
				SELECT	CTA_Title_1, ft_size, ft_color, ft_weight, txt_align, 
						CTA_Title_2, ft_size_2, ft_color_2, ft_weight_2, txt_align_2
				FROM    Dealer_CTA_Titles
				where dealer_id = #url.dealer_id#
				AND		active = 1
				AND CTA = 2
			</cfquery>
  <cfset ln_1_style="font-size:#gt_brands.ft_size#;color:###gt_brands.ft_color#;font-weight:#gt_brands.ft_weight#;font-family:Times New Roman">
  <cfset ln_1_align="#gt_brands.txt_align#">
  <cfset ln_2_style="font-size:#gt_brands.ft_size_2#;color:###gt_brands.ft_color_2#;font-weight:#gt_brands.ft_weight_2#">
  <cfset ln_2_align="#gt_brands.txt_align_2#">
  <cfif  #Get_Assigned_OEMs.recordcount# GT 0 >
    <section class="section-brands">
      <div class="container pad-top-10">
        <div class="container-brands">
          <cfif #gt_brands.recordcount# NEQ 0 >
            <div class="row">
              <div class="col-md-12 pad-top-10 brands-title visible-lg visible-md" style="align:#ln_1_align#">
                <p class="fancy"><span style="#ln_1_style#;font-family:arial!important;">#gt_brands.CTA_Title_1#</span></p>
                <cfif #gt_brands.CTA_Title_2# NEQ "">
                  <br>
                  <span style="#ln_2_style#">#gt_brands.CTA_Title_2#</span>
                </cfif>
              </div>
              <div class="col-md-12 pad-top-10 brands-title visible-sm visible-xs" style="align:#ln_1_align#"> <span style="#ln_1_style#">#gt_brands.CTA_Title_1#</span>
                <cfif #gt_brands.CTA_Title_2# NEQ "">
                  <br>
                  <span style="#ln_2_style#">#gt_brands.CTA_Title_2#</span>
                </cfif>
              </div>
            </div>
          </cfif>
          <div class="row">
            <div class="col-md-12 " style="align:center">
              <cfset whats_left = #Get_Assigned_OEMs.recordcount# >
              <cfset do_once = 1 >
              <cfset off_set = 0 >
              <cfloop query="Get_Assigned_OEMs" >
                <cfif #whats_left# lt 6 AND #do_once# EQ 1 >
                  <cfset off_set = 6 - #whats_left# >
                  <cfset do_once = 0 >
                <cfelse>
                  <cfset off_set = 0 >
                </cfif>
                <div class="col-md-#nbr_col# col-md-offset-#off_set# pad-top-10" style="align:center">
                  <cfif #pg_nbr# NEQ 3 and  #pg_nbr# NEQ 1  and  #pg_nbr# NEQ 5   and  #pg_nbr# NEQ 6  and  #pg_nbr# NEQ 7 >
                    <cfif  #len(Get_Assigned_OEMs.dealer_oem_image)# gt 0 >
                      <cfif #Get_Assigned_OEMs.link_to# EQ "" >
                        <cfif #Get_Assigned_OEMs.website_target# EQ 0 >
                          <cfset goto="">
                          <cfelse>
                          <cfset goto="_blank" >
                        </cfif>
                        <a href="#Get_Assigned_OEMs.website_link#" target="#goto#" ><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                        <cfelse>
                        <cfif #Get_Assigned_OEMs.link_to_target# EQ 0 >
                          <cfset goto="">
                          <cfelse>
                          <cfset goto="_blank" >
                        </cfif>
                        <a href="../#Get_Assigned_OEMs.link_to#"><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                      </cfif>
                      <cfelse>
                      #Get_Assigned_OEMs.OEM_Name#
                    </cfif>
                  </cfif>
                  <cfif #pg_nbr# EQ 3 >
                    <!--- Finance --->
                    <cfif  #len(Get_Assigned_OEMs.dealer_oem_image)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_4_link_target# EQ 1 >
                        <cfset goto="_blank">
                        <a href="#Get_Assigned_OEMs.pg_4_link#" target="#goto#" ><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                        <cfelse>
                        <a href="../#Get_Assigned_OEMs.pg_4_link#"><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                      </cfif>
                      <cfelse>
                      #Get_Assigned_OEMs.OEM_Name#
                    </cfif>
                  </cfif>
                  <cfif #pg_nbr# EQ 2 >
                    <!--- Special Offers --->
                    <cfif  #len(Get_Assigned_OEMs.pg_2_link)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_2_link_target# EQ 0 >
                        <cfset goto="">
                        <cfelse>
                        <cfset goto="_blank" >
                      </cfif>
                      <div class="row"><a class="btn-fin-content" target="#goto#"  href="../#Get_Assigned_OEMs.pg_2_link#"><span class="glyphicon glyphicon-chevron-right"></span>&nbsp;#Get_Assigned_OEMs.pg_2_txt#</a></div>
                    </cfif>
                    <cfif  #len(Get_Assigned_OEMs.pg_3_link)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_3_link_target# EQ 0 >
                        <cfset goto="">
                        <cfelse>
                        <cfset goto="_blank" >
                      </cfif>
                      <div class="row"><a  class="btn-fin-content" target="#goto#"  href="../#Get_Assigned_OEMs.pg_3_link#"><span class="glyphicon glyphicon-chevron-right"></span>&nbsp;#Get_Assigned_OEMs.pg_3_txt#</a></div>
                    </cfif>
                  </cfif>
                  <cfif #pg_nbr# EQ 1 >
                    <!--- Service --->
                    <cfif  #len(Get_Assigned_OEMs.dealer_oem_image)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_5_link_target# EQ 1 >
                        <cfset goto="_blank">
                        <a href="#Get_Assigned_OEMs.pg_5_link#" target="#goto#" ><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                        <cfelse>
                        <a href="../#Get_Assigned_OEMs.pg_5_link#"><img src="http://dealers.wdautos.com//images/brand_logos/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                      </cfif>
                      <cfelse>
                      #Get_Assigned_OEMs.OEM_Name#
                    </cfif>
                  </cfif>
                  <cfif #pg_nbr# EQ 5 >
                    <!--- Careers --->
                    <cfif  #len(Get_Assigned_OEMs.dealer_oem_image)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_6_link_target# EQ 1 >
                        <cfset goto="_blank">
                        <a href="#Get_Assigned_OEMs.pg_6_link#" target="#goto#" ><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                        <cfelse>
                        <a href="../#Get_Assigned_OEMs.pg_6_link#"><img src="http://dealers.wdautos.com//images/brand_logos/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                      </cfif>
                      <cfelse>
                      #Get_Assigned_OEMs.OEM_Name#
                    </cfif>
                  </cfif>
                  <cfif #pg_nbr# EQ 6 >
                    <!--- Community --->
                    <cfif  #len(Get_Assigned_OEMs.dealer_oem_image)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_7_link_target# EQ 1 >
                        <cfset goto="_blank">
                        <a href="#Get_Assigned_OEMs.pg_7_link#" target="#goto#" ><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                        <cfelse>
                        <a href="../#Get_Assigned_OEMs.pg_7_link#"><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                      </cfif>
                      <cfelse>
                      #Get_Assigned_OEMs.OEM_Name#
                    </cfif>
                  </cfif>
                  <cfif #pg_nbr# EQ 7 >
                    <!--- Discover --->
                    <cfif  #len(Get_Assigned_OEMs.dealer_oem_image)# gt 0 >
                      <cfif #Get_Assigned_OEMs.pg_8_link_target# EQ 1 >
                        <cfset goto="_blank">
                        <a href="#Get_Assigned_OEMs.pg_8_link#" target="#goto#" ><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                        <cfelse>
                        <a href="../#Get_Assigned_OEMs.pg_8_link#"><img src="http://dealers.wdautos.com//images/brand_logos_square/#Get_Assigned_OEMs.dealer_oem_image#" alt="#Get_Assigned_OEMs.oem_name#" <!--- border="0" ---> class="img-responsive" ></a>
                      </cfif>
                      <cfelse>
                      #Get_Assigned_OEMs.OEM_Name#
                    </cfif>
                  </cfif>
                </div>
                <cfset whats_left = #whats_left# - 1>
              </cfloop>
            </div>
          </div>
        </div>
      </div>
      <div class="clearfix"></div>
    </section>
  </cfif>
</cfoutput>