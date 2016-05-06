<cfcomponent>

<!--- 
Files associated with this cfc are: 
cfc\vehicles\build_options
vehicles \splash_action
global\any inv cfm
teaking takes place in the javascript
--->

	<cffunction name="vertical_search" description="vertical display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="Search Now">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="default_geo" default="1">
		<cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
		<cfargument name="btn_pull" default="no-pull">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,249,330,14,262,264,265,47,55,288,333,369">
				<cfset arguments.default_new_used="u">
			</cfcase>
		</cfswitch>

	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		<!-- vertical search -->
		<form id="#arguments.form_id#" name="testform" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
		
 			<cfif #arguments.dealer_id# neq "233" AND #arguments.dealer_id# neq "84" >		<!--- Findlay Auto Group Radio Buttons 01/13/2015 --->
				<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#" <cfif #url.dealer_id# eq 28 or #url.dealer_id# eq 37 > onchange="this.form.submit()"</cfif>>
			
					<cfif arguments.dealer_id neq "35" and 
							arguments.dealer_id neq "249" and 
							arguments.dealer_id neq "330" and 
								arguments.dealer_id neq "14"  and 
									arguments.dealer_id neq "264" and 
										arguments.dealer_id neq "265"  and 
											arguments.dealer_id neq "262" and 
												arguments.dealer_id neq "47"  and  
												arguments.dealer_id neq "288"  and 
													arguments.dealer_id neq "55"  and 
													arguments.dealer_id neq "333"  and 
													arguments.dealer_id neq "369"   >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"	or 
							arguments.dealer_id eq "264" or 
							arguments.dealer_id eq "333" or 
								arguments.dealer_id eq "265" or 
								arguments.dealer_id eq "369" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
					<cfif arguments.dealer_id neq "1" and arguments.dealer_id neq "288" and arguments.dealer_id neq "67" and arguments.dealer_id neq "333" and arguments.dealer_id neq "369">
						<cfif arguments.dealer_id NEQ 28 AND  #url.dealer_id# neq 37 >
							<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
						<cfelse>
							<option value="U" onclick="this.form.submit()">Pre-Owned #srch_txt_used#</option>			<!--- washington honda & Toyota  --->
						</cfif>
					</cfif>	
					<cfif arguments.dealer_id eq "1" >
						<!---<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned Vehicles</option>	--->
                        <option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id eq "288" or arguments.dealer_id eq "67">
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned</option>	
					</cfif>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and 
							<!--- arguments.dealer_id neq "249"  and   --->
							arguments.dealer_id neq "14"  and 
								arguments.dealer_id neq "264" and 
									arguments.dealer_id neq "265"  and 
										arguments.dealer_id neq "1"  and 
										arguments.dealer_id neq "288"  and 
										arguments.dealer_id neq "333"  and 
										arguments.dealer_id neq "55" and arguments.dealer_id neq "67"  and arguments.dealer_id neq "369"  >     <!--- Lamacchia Honda --->
						<cfif arguments.dealer_id NEQ 28 AND  #url.dealer_id# neq 37 >
							<option value="C">Certified #srch_txt_certified#</option>
						<cfelse>
							<option value="C" onclick="this.form.submit()">Certified #srch_txt_used#</option>		<!--- washington honda & Toyota --->
						</cfif>	
					</cfif>  
					   <cfif arguments.dealer_id eq "66" OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"    >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
					<!--- <cfif arguments.dealer_id eq "1"   >     <!--- Baierl 05/21/2015  --->
						<option value="q"<cfif arguments.default_new_used eq "q">selected="selected"</cfif> onclick="this.form.submit()" >Baierl Budget Cars</option>
					</cfif>      --->
                    
                    <!---<cfif left(cgi.remote_addr,7) eq "10.0.0." or left(cgi.remote_addr,10) eq "192.168.5." or left(cgi.remote_addr,10) eq "172.16.25.">--->
                    	<cfif  arguments.dealer_id eq 78>
                        	<option value="A"<cfif arguments.default_new_used eq "a">selected="selected"</cfif>>Commercial Vehicles</option>
                        </cfif>
                    <!---</cfif>--->
				</select><br/>
			<cfelse>
			<cfif #arguments.dealer_id# neq "233" >
				  <select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14"   and arguments.dealer_id neq "262"  and 
							arguments.dealer_id neq "47"   and arguments.dealer_id neq "55"    and arguments.dealer_id neq "288"    >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"  or arguments.dealer_id eq "264" or arguments.dealer_id eq "265"  or arguments.dealer_id eq "288"  >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "264" and arguments.dealer_id neq "265"  and arguments.dealer_id neq "333"   >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>  
                     
				</select><br/>  
			 
				<!--- &nbsp;&nbsp;&nbsp;<span style="font-size:11pt;font-weight:bold" >
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="N" <cfif #arguments.default_new_used# eq "n">checked</cfif> /> New&nbsp;&nbsp;&nbsp;
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="U" <cfif #arguments.default_new_used# eq "u">checked</cfif> /> Used&nbsp;&nbsp;&nbsp;
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="C" <cfif #arguments.default_new_used# eq "c">checked</cfif> /> Certified</span>   --->
			<cfelse>
				<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14" and   arguments.dealer_id neq "55" and
							arguments.dealer_id neq "47" and arguments.dealer_id neq "262" and arguments.dealer_id neq "264"   and arguments.dealer_id neq "265"    and arguments.dealer_id neq "288"  and arguments.dealer_id neq "333"  >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"   or arguments.dealer_id eq "264" or arguments.dealer_id eq "265"  or arguments.dealer_id eq "288" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "55"  and arguments.dealer_id neq "333">     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67" OR  arguments.dealer_id eq "288"   >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
				</select><br/>
				</cfif>
			</cfif>
		 
			<cfif arguments.dealer_id eq "84"  <!---  Findlay Auto 84 --->  >
			  	<select class="spl-search-input" name="search_geo" id="search_geo_#arguments.form_id#">
			  		<option>Loading Regions...</option>
				</select><br/>
			</cfif>			

			 <select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
			  		<option>Loading Makes...</option>
			</select><br/>  
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
			  		<option>Loading Models...</option>
			</select><br/>
			<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
			  		<option>Loading Years...</option>
			</select><br/>
			
			<cfif arguments.dealer_id eq "178"    >
			  <select class="spl-search-input" name="search_zip" id="search_zip_#arguments.form_id#">
			</select><br/>
			</cfif> 		    

			<input class="spl-search-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>
		</form>
		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				<cfif arguments.dealer_id eq "178"    >
					var $zip = $('##search_zip_#arguments.form_id#')
				</cfif>
											
				loadGeo('','','#arguments.default_new_used#','#arguments.dealer_id#','');	
				loadMake('#arguments.default_new_used#', '#arguments.dealer_id#', '','','');
				loadModel('','#arguments.default_new_used#','#arguments.dealer_id#','','');	
				loadYear('','#arguments.default_new_used#','#arguments.dealer_id#','','');		
				<cfif arguments.dealer_id eq "178"    >
					$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				</cfif>								
												
				$new_used.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>								
				});					
					
				$geo.change(function(){	
					setDefaults();				
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>												
				});			
						
				$make.change(function(){
					setDefaults();
					<cfif arguments.dealer_id eq 15>	
					console.log(getCond())				;
						if ((getMake() == 'Chevrolet') && (getCond() == 'N')){
							top.location = 'https://baierlchevy.worktrucksolutions.com';
						}
					</cfif>
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());				
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>						
				});
								
				$model.change(function(){	
					setDefaults();	
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());			
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());		
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>				
				});
				
				/*$year.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(),getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
				});*/
				
				function getCond(){
					return $new_used.val();
				}
				function getGeo(){
					if ($geo.length){
						return $geo.val();	
					}else{
						return '';
					}										
				}
				function getMake(){
					if ($make.length){
						return encodeURIComponent($make.val());
					}else{
						return '';
					}					
				}
				function getModel(){
					if ($model.length){						
						return encodeURIComponent($model.val());
					}else{
						return '';
					}
				}
				function getYear(){
					if ($year.length){
						return $year.val();
					}else{
						return '';
					}
				}
				function getDealerID(){
					return #arguments.dealer_id#;
				}
				function setDefaults(){
					$condBeforeChg = getCond();
					$geoBeforeChg = getGeo();
					$makeBeforeChg = getMake();
					$modelBeforeChg = getModel();
					$yearBeforeChg = getYear();
				}
				
				function resetSel(){
					if ($new_used.children('option').length){
						try{ 
							$new_used.val($condBeforeChg);
						}catch (err){
							console.log(err);							
						}
					}
					if ($geo.children('option').length){
						try{
							if ($('##search_geo_#arguments.form_id# option[value="' +decodeURIComponent($geoBeforeChg)+ '"]').prop("selected", true).length) {
								$geo.val($geoBeforeChg);
							}else{
								$geo.val('');
							}
							
						}catch (err){							
							console.log(err);
						}
					}
					if ($make.children('option').length){
						try{
							if ($('##search_make_#arguments.form_id# option[value="' +decodeURIComponent($makeBeforeChg)+ '"]').prop("selected", true).length) {
								$make.val(decodeURIComponent($makeBeforeChg));
							}else{
								$make.val('');
							}
							
						}catch (err){
							console.log(err);							
						}
					}
					if ($model.children('option').length){
						try{							
							if ($('##search_model_#arguments.form_id# option[value="' +decodeURIComponent($modelBeforeChg)+ '"]').prop("selected", true).length) {
								$model.val(decodeURIComponent($modelBeforeChg));
							}else{
								$model.val('');
							}
						}catch (err){
							
						}
					}
					if ($year.children('option').length){
						try{
							if ($('##search_year_#arguments.form_id# option[value="' +$yearBeforeChg+ '"]').prop("selected", true).length) {						        
						        $year.val($yearBeforeChg);
						    }else{
						    	$year.val('');
						    }
							
						}catch (err){
							console.log(err);							
						}
					}
				}				
				function convCond(x){
					if (x == 'C')
					{
						return 'U';
					}else{
						return x;
					}
				}
				//dealerID  cond geo  make  model year  
				function loadMake(cond, dealerID, geo, year, model){					
					$make.load('global/inv_makes.cfm?new_used=' +cond+ '&dealer_id=' + dealerID+'&geo='+geo+'&year='+year/*+'&model='+model*/, function(){
						resetSel();
					});
				}
				function loadModel(make, cond, dealerID, geo, year){
					$model.load('global/inv_models.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&geo='+geo/*+'&year='+year*/, function(){
						resetSel();
					});
				}
				function loadYear(make, cond, dealerID, model, geo){
					$year.load('global/inv_years.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&model='+model+'&geo='+geo, function(){
						resetSel();
					});
				}
				function loadGeo(make, model, cond, dealerID, year){
					$geo.load('global/inv_geo.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&model='+model+'&make='+make+'&year='+year, function(){
						resetSel();
					});
				}
				
				<cfif arguments.dealer_id eq 65 or arguments.dealer_id eq 68>
					<cfif arguments.dealer_id eq 65>
						<cfset _make = 'Kia'>
					</cfif>
					<cfif arguments.dealer_id eq 68>
						<cfset _make = 'Mazda'>
					</cfif>
					
					
					if( $('##search_make_#arguments.form_id#').length )  {		
						setTimeout(function(){
						  $('##search_make_#arguments.form_id#').val('#_make#');	
						  setDefaults();
						  loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
						  loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());	
						}, 2000);
								
					}
				</cfif>

				
			});
		</script>
		
		
	</cffunction>

	<cffunction name="vertical_qq" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,55,264,265,288,333,369">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>
		
		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
<!-- vertical qq -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
				<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
				<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
				<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
				<p class="help-block">numbers only - no hypens or parentheses</p>
				<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
			<cfelse>
				<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
				<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
				<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
				<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
			</cfif>
			
			<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
				<cfif arguments.dealer_id neq "35" and  arguments.dealer_id neq "249" and  arguments.dealer_id neq "262" and  arguments.dealer_id neq "47"  and 
						arguments.dealer_id neq "264" and arguments.dealer_id neq "265"   and arguments.dealer_id neq "55"  and arguments.dealer_id neq "14"  and 
						arguments.dealer_id neq "288"  and arguments.dealer_id neq "333"   and arguments.dealer_id neq "369"  >
					<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
				</cfif>
				<cfif  arguments.dealer_id neq "333" AND  arguments.dealer_id neq "369" >
					<cfif arguments.dealer_id neq "1" >
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>
						<option value="C">Certified #srch_txt_certified#</option>
					<cfelse>	
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>
					</cfif>
				<cfelse>	
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
				</cfif>
			   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
					<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
				</cfif>   	
			</select>
			<br/>
			
			<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
			</select>
			<br/>
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
			</select>
			<br/>
			<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
			</select>
			
			<br/>
			<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>

		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				
				<cfif arguments.dealer_id eq 65 or arguments.dealer_id eq 68>
					<cfif arguments.dealer_id eq 65>
						<cfset _make = 'Kia'>
					</cfif>
					<cfif arguments.dealer_id eq 68>
						<cfset _make = 'Mazda'>
					</cfif>
					
					
					if( $('##search_make_#arguments.form_id#').length )  {		
						setTimeout(function(){
						  $('##search_make_#arguments.form_id#').val('#_make#');	
						  var condName = $new_used.val();
						  var makeName = $make.val();
						  $model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					      $year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
						}, 2000);
								
					}
				</cfif>

			});
		</script>
			
	</cffunction>

	<cffunction name="vertical_td" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="tdFormV">
		<cfargument name="form_class" default="td-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Schedule Test Drive">
		<cfargument name="btn_pull" default="no-pull">

		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>
		
		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		
		
<!-- vertical td -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<div class="row">
				<div class="col-md-6">
					<input name="First_Name" class="spl-td-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
				</div>
				<div class="col-md-6">
					<input name="Last_Name" class="spl-td-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<input name="Phone_1" class="spl-td-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone" onkeypress="return isNumberKey(event)">
				</div>
				<div class="col-md-6">
					<input name="Email" class="spl-td-input" id="Email" type="email" maxlength="100" placeholder="Email" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="spl-td-title" title="Vehicle Information">Vehicle Information</div>
					<select class="spl-td-input" name="voi_new_used" id="search_new_used_#arguments.form_id#" <cfif url.dealer_id EQ 37> onChange = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(true, 'o', 'selvehicle');" </cfif>>
						<option value="N" selected="selected">New #srch_txt_new#</option>
						<option value="U">Pre-Owned #srch_txt_used#</option>
						<option value="C">Certified #srch_txt_certified#</option>
					</select><br/>
					<select class="spl-td-input" name="voi_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-td-input" name="voi_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-td-input" name="voi_year" id="search_year_#arguments.form_id#">
					</select>
				</div>
				<div class="col-md-6">
					<div class="spl-td-title" title="Preferred Time">Preferred Time</div>
					<input name="Date" class="spl-td-input" id="Date" type="Date" maxlength="10" placeholder="Test Drive Date" required><br/>
					<select class="spl-td-input" name="Time" id="Time" required>
						<option value="">Select Time</option>
						<option value="Morning">Morning</option>
						<option value="Afternoon">Afternoon</option>
						<option value="Evening">Evening</option>
					</select><br/>
					<cfif Get_Form_Locations.Recordcount gt 0>
						<select name="Delivery_Dealer_ID" class="spl-td-input" id="Delivery_Dealer_ID" required>
							<option value="">Select a Dealer</option>
							<cfloop query="Get_Form_Locations">
								<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
							</cfloop> 
						</select><br/>
					<cfelse>
						<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
					</cfif>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<textarea name="Comments" class="spl-td-input"" id="Comments" placeholder="Comments" maxlength="1000"></textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#" <cfif url.dealer_id EQ 37> onSubmit = "tmsomni=s_gi('tdds-prod');tmsomni.linkTrackVars = 'prop6,prop64';tmsomni.linkTrackEvents = 'event54';tmsomni.prop6 = 'vehicle request';tmsomni.prop64 = 'vehicle'; tmsomni.tl(true, 'o', 'testdrive');" </cfif>>
				</div>
			</div>
			<div class="clearfix"></div>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="vertical_td_leg" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="tdFormV">
		<cfargument name="form_class" default="td-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Schedule Test Drive">
		<cfargument name="btn_pull" default="no-pull">

		<cfstoredproc datasource="Ultra10" procedure="Get_Form_Locations">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@dealer_id" value="#arguments.dealer_id#" maxlength="3">
			<cfprocresult name = "Get_Form_Locations" resultset="1">
		</cfstoredproc>
<!-- vertical td leg -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<table style="width:100%;" cellpadding="5" cellspacing="0">
				<tr>
					<td>
						<input name="First_Name" class="spl-td-input" id="First_Name" type="text" maxlength="50"  value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" class="spl-td-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
					</td>
					<td>
						<input name="Phone_1" class="spl-td-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'" onkeypress="return isNumberKey(event)">
						<input name="Email" class="spl-td-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					</td>
				</tr>
				<tr>
					<td valign="top">
						<div class="spl-td-title" title="Vehicle Information">Vehicle Information</div>
						<select class="spl-td-input" name="voi_new_used" id="search_new_used_#arguments.form_id#">
							<option value="N" selected="selected">New Vehicles</option>
							<option value="U">Pre-Owned Vehicles</option>
							<option value="C">Certified Vehicles</option>
						</select><br/>
						<select class="spl-td-input" name="voi_make" id="search_make_#arguments.form_id#">
						</select><br/>
						<select class="spl-td-input" name="voi_model" id="search_model_#arguments.form_id#">
						</select><br/>
						<select class="spl-td-input" name="voi_year" id="search_year_#arguments.form_id#">
						</select>
					</td>
					<td valign="top">
						<div class="spl-td-title" title="Preferred Time">Preferred Time</div>
						<input name="Date" class="spl-td-input" id="Date" type="Date" maxlength="10" value="Test Drive Date" onfocus="if (this.value=='Test Drive Date') this.value = ''" onblur="if (this.value=='') this.value = 'Test Drive Date'"><br/>
						<select class="spl-td-input" name="Time" id="Time" required>
							<option value="">Select Time</option>
							<option value="Morning">Morning</option>
							<option value="Afternoon">Afternoon</option>
							<option value="Evening">Evening</option>
						</select><br/>
						<cfif Get_Form_Locations.Recordcount gt 0>
							<select name="Delivery_Dealer_ID" class="spl-td-input" id="Delivery_Dealer_ID" required>
								<option value="">Select a Dealer</option>
								<cfloop query="Get_Form_Locations">
									<option value="#Get_Form_Locations.Location_ID#">#Get_Form_Locations.Display_Name#</option>
								</cfloop> 
							</select><br/>
						<cfelse>
							<input type="hidden" id="Delivery_Dealer_ID" name="Delivery_Dealer_ID" value="#arguments.dealer_id#">
						</cfif>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="Comments" class="spl-td-input"" id="Comments" maxlength="1000" onfocus="if (this.value=='Comments') this.value = ''" onblur="if (this.value=='') this.value = 'Comments'">Comments</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
					</td>
				</tr>
			</table>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="horizontal_search" description="horizontal display for search tool section of Variable_1028" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="Search Now">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="default_geo" default="1">
		<cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
		<cfargument name="btn_pull" default="no-pull">

	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
	
		<!-- horizontal search -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<div class="row" >
				<div class="col-md-2 col-md-offset-2">
 			<cfif #arguments.dealer_id# neq "233" AND #arguments.dealer_id# neq "84" >		<!--- Findlay Auto Group Radio Buttons 01/13/2015 --->
				<select class="horizontal-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and 
							arguments.dealer_id neq "249" and 
								arguments.dealer_id neq "14"  and 
									arguments.dealer_id neq "264" and 
										arguments.dealer_id neq "265"  and 
											arguments.dealer_id neq "262" and 
											arguments.dealer_id neq "288" and 
												arguments.dealer_id neq "47"  and 
													arguments.dealer_id neq "55"  and 
													arguments.dealer_id neq "369"   >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"	or 
							arguments.dealer_id eq "264" or 
								arguments.dealer_id eq "265" or 
								arguments.dealer_id eq "288"or 
								arguments.dealer_id eq "369" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and 
							arguments.dealer_id neq "249"  and 
								arguments.dealer_id neq "264" and 
									arguments.dealer_id neq "265"  and 
										arguments.dealer_id neq "55"  and 
										arguments.dealer_id neq "369"  >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
				</select>
				</div>
			<cfelse>
			<cfif #arguments.dealer_id# neq "84" >
				<div class="col-md-2">

				  <select class="horizontal-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14"   and arguments.dealer_id neq "262"  and 
							arguments.dealer_id neq "47"   and arguments.dealer_id neq "55"   and arguments.dealer_id neq "288"   and arguments.dealer_id neq "369"    >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"  or arguments.dealer_id eq "264" or arguments.dealer_id eq "265" or arguments.dealer_id eq "288"  or arguments.dealer_id eq "369"  >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "264" and arguments.dealer_id neq "265"   and arguments.dealer_id neq "369"   >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
				</select>
				</div>  
			<cfelse>
				<div class="col-md-2">

				<select class="horizontal-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14" and   arguments.dealer_id neq "55" and
							arguments.dealer_id neq "47" and arguments.dealer_id neq "262" and arguments.dealer_id neq "264"   and arguments.dealer_id neq "265"   and arguments.dealer_id neq "288"  >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"   or arguments.dealer_id eq "264" or arguments.dealer_id eq "265" or arguments.dealer_id eq "288" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "55">     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66" OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"   >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
				</select>
				</div>
				</cfif>
			</cfif>				
			<div class="col-md-2">

			 <select class="horizontal-search-input" name="search_make" id="search_make_#arguments.form_id#">
			</select></div>				
			<div class="col-md-2">

			<select class="horizontal-search-input" name="search_model" id="search_model_#arguments.form_id#">
			</select></div>		
			<cfif 	arguments.dealer_id neq "256" >
			<div class="col-md-2">
			<select class="horizontal-search-input" name="search_year" id="search_year_#arguments.form_id#">
			</select></div>
			<cfelse> 
			<input   type="hidden" name="search_year" value="">
			</cfif> 	
							
			<div class="col-md-2">

			<input class="horizontal-go-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			</div>
			<div class="clearfix"></div>
		</form>
		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $zip = $('##search_zip_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$geo.load('global/inv_geo.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
												
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var geoName = $geo.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');	
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName  + '&geo=' + geoname + '&dealer_id=#arguments.dealer_id#');					
				});
						
										
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var geoName = $geo.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');		
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName + '&geo=' + geoName + '&dealer_id=#arguments.dealer_id#');					
				});
				
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					var geoName = $geo.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');	
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName  + '&geo=' + geoName + '&dealer_id=#arguments.dealer_id#');			
				});	
			});
		</script>
			
	</cffunction>


	<cffunction name="horizontal_search_huge" description="horizontal display for search tool section of Variable_1028" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="Search">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="default_geo" default="1">
		<cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
		<cfargument name="btn_pull" default="no-pull">

		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert,srch_type_txt_other_1,srch_type_txt_other_1_cd, 
		srch_type_txt_other_2,srch_type_txt_other_2_cd FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#"><cfset srch_txt_other_1="#chk_srp_style.srch_type_txt_other_1#"><cfset srch_txt_other_2="#chk_srp_style.srch_type_txt_other_2#">	
		<cfset srch_txt_other_1_cd="#chk_srp_style.srch_type_txt_other_1_cd#"><cfset srch_txt_other_2_cd="#chk_srp_style.srch_type_txt_other_2_cd#">	
	<!--- Search Style & Text 02/23/2016 --->	
	<cfif #url.dealer_id# eq 288 >
		<cfset arguments.defaul_new_used = "" >
	</cfif>	
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<div class="row row-centered" >
			<div class="col-md-12<!-- col-centered-->">
				<div class="col-md-2">
					<select class="horizontal-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
						<cfif #srch_style# EQ 1 >
							<cfset arguments.default_new_used = "">
							<option value="" <cfif arguments.default_new_used eq "">selected="selected"</cfif>>Type</option>
						</cfif>
						<cfif #srch_txt_new# NEQ "" >
							<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>#srch_txt_new#</option>
						</cfif>
						<cfif #srch_txt_used# NEQ "" >
							<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>#srch_txt_used#</option>	
						</cfif>
						<cfif #srch_txt_certified# NEQ "" >
							<option value="C"<cfif arguments.default_new_used eq "c">selected="selected"</cfif>>#srch_txt_certified#</option>
						</cfif>
						<cfif #srch_txt_other_1# NEQ "" >
							<option value="#srch_txt_other_1_cd#">#srch_txt_other_1#</option>
						</cfif>
						<cfif #srch_txt_other_2# NEQ "" >
							<option value="#srch_txt_other_2_cd#">srch_txt_other_2</option>
						</cfif>
					</select>
				</div>
				<div class="col-md-2">
				 	<select class="horizontal-search-input" name="search_make" id="search_make_#arguments.form_id#">
					</select>
				</div>				
				<div class="col-md-2">
					<select class="horizontal-search-input" name="search_model" id="search_model_#arguments.form_id#">
					</select>
				</div>		
				<div class="col-md-2">
					<select class="horizontal-search-input" name="search_year" id="search_year_#arguments.form_id#">
					</select>
				</div>
				<div class="col-md-2">
					<input class="horizontal-go-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
				</div>
				<div class="clearfix"></div>
		</form>
		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $zip = $('##search_zip_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$geo.load('global/inv_geo.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
												
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var geoName = $geo.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');	
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName  + '&geo=' + geoname + '&dealer_id=#arguments.dealer_id#');					
				});
						
										
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var geoName = $geo.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');		
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName + '&geo=' + geoName + '&dealer_id=#arguments.dealer_id#');					
				});
				
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					var geoName = $geo.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');	
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName  + '&geo=' + geoName + '&dealer_id=#arguments.dealer_id#');			
				});	
			});
		</script>
			
	</cffunction>

	<cffunction name="horizontal_qq" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,249,262,264,265,288">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>
		
		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		
<!-- horizontal qq -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<div class="row">
				<div class="col-md-6">
					<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<p class="help-block">numbers only - no hypens or parentheses</p>
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					<cfelse>
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
					</cfif>
				</div>
				<div class="col-md-6">
					<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
						<cfif arguments.dealer_id neq "35" and  arguments.dealer_id neq "249" and  arguments.dealer_id neq "262"and  arguments.dealer_id neq "47"  and
								 arguments.dealer_id neq "264" and arguments.dealer_id neq "265"   and arguments.dealer_id neq "55"  and arguments.dealer_id neq "14"  and arguments.dealer_id neq "288"  >
							<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
						</cfif>
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>
						<cfif arguments.dealer_id neq "55" >
						<option value="C">Certified #srch_txt_certified#</option>
						</cfif>
						<cfif arguments.dealer_id eq "264" OR  arguments.dealer_id eq "265"  OR  arguments.dealer_id eq "288" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif> >Used #srch_txt_used#</option>
						</cfif>
					</select><br/>
					<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
					</select><br/>
					<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
				</div>
			</div>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

	<cffunction name="portal_fmc" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,249,262,264,265,288">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>
		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
<!-- portal fmc -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<div class="row">
				
				<div class="col-md-12">
					<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
						<cfif arguments.dealer_id neq "35" and  arguments.dealer_id neq "249" and  arguments.dealer_id neq "262"and  arguments.dealer_id neq "47"  and
								 arguments.dealer_id neq "264" and arguments.dealer_id neq "265"   and arguments.dealer_id neq "55"  and arguments.dealer_id neq "14"  and arguments.dealer_id neq "288"  >
							<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
						</cfif>
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>
						<cfif arguments.dealer_id neq "55" >
						<option value="C">Certified #srch_txt_certified#</option>
						</cfif>
						<cfif arguments.dealer_id eq "264" OR  arguments.dealer_id eq "265"  OR  arguments.dealer_id eq "288" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif> >Used #srch_txt_used#</option>
						</cfif>
					</select><br/>
					<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
					</select><br/>
					<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
				</div>
			</div>
		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>

<!--- Get a Quote section of Video/commercial section --->
	<cffunction name="horizontal_qq_big" description="horizontal display for search tool for WD_1008" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="default_geo" default="1">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,249,14,262,47,55,264,265,288">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>
		
	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		
<!-- horizontal qq big -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<div class="row">
				<div class="row">
					<div class="col-md-6"><span style="color:white;font-weight:bold;font-size:9pt">&nbsp;&nbsp;&nbsp;Tell Us About You</span></div><div class="col-md-6"<span style="color:white;font-weight:bold;font-size:9pt">What You're Looking For?</span></div>
				</div>	
				<div class="col-md-6">
					<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<p class="help-block">numbers only - no hypens or parentheses</p>
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					<cfelse>
						<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
						<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
						<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
						<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
					</cfif>
				</div>
				<div class="col-md-6">
					<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
						<cfif arguments.dealer_id neq "35" and 
								arguments.dealer_id neq "249" and  
									arguments.dealer_id neq "249"  and 
										arguments.dealer_id neq "262"   and 
											arguments.dealer_id neq "47"   and 
												arguments.dealer_id neq "264" and 
													arguments.dealer_id neq "265"   and  
													arguments.dealer_id neq "288"   and 
														arguments.dealer_id neq "55"   and 
															arguments.dealer_id neq "14"  >
							<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
						</cfif>
						<cfif arguments.dealer_id neq "264" and arguments.dealer_id neq "265" >
							<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>
							<cfif arguments.dealer_id neq "55" >
								<option value="C">Certified #srch_txt_certified#</option>
							</cfif>
						<cfelse>	
<!--- 						</cfif>
						<cfif arguments.dealer_id eq "264" or arguments.dealer_id eq "265" > --->
							<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif> >Used #srch_txt_used#</option>	
						</cfif>		
						
					</select><br/>
					<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
					</select><br/>
					<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
					</select><br/>
					<cfif #url.dealer_id# neq 38 and #url.dealer_id# neq 45 and #url.dealer_id# neq 179>
						<input class="blk2-btn" type="submit" value="#arguments.btn_submit#">
					<cfelse>
						<input class="blk2-btn" type="submit" value="Send">	
					</cfif>
				</div>
			</div>
		</form>
		

		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $zip = $('##search_zip_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$geo.load('global/inv_geo.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
												
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var geoName = $geo.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');	
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName  + '&geo=' + geoname + '&dealer_id=#arguments.dealer_id#');					
				});
						
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var geoName = $geo.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');		
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName + '&geo=' + geoName + '&dealer_id=#arguments.dealer_id#');					
				});
				
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					var geoName = $geo.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');	
					$geo.load('global/inv_geo.cfm?new_used=' + condName + '&make=' + makeName  + '&geo=' + geoName + '&dealer_id=#arguments.dealer_id#');			
				});
				
			});
		</script>


		
<!---  		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script> --->
  		
	</cffunction>

	<cffunction name="horizontal_qq_leg" description="horizontal display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/>
		<cfargument name="btn_submit" default="Get Quote">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35">
				<cfset arguments.default_new_used="u">
			</cfcase> 
		</cfswitch>

		<table style="width:100%" cellpadding="0" cellspacing="0">
			<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
				<tr>
					<td style="width:50%" style="padding:10px;" valign="top">
						<input name="First_Name" id="First_Name" class="spl-search-input" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
						<input name="Last_Name" id="Last_Name" class="spl-search-input" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
						<input name="Phone_1" id="Phone_1" class="spl-search-input" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
						<input name="Email" id="Email" class="spl-search-input" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
					</td>
					<td style="width:50%" style="padding:10px;" valign="top">
						<select class="spl-search-input" name="search_new_used" class="spl-search-input" id="search_new_used_#arguments.form_id#">
							<cfif arguments.dealer_id neq "35"   and arguments.dealer_id neq "262" >
								<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
							</cfif>
							<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
							<option value="C">Certified Vehicles</option>
						</select><br/>
						<select name="search_make" class="spl-search-input" id="search_make_#arguments.form_id#">
						</select><br/>
						<select name="search_model" class="spl-search-input" id="search_model_#arguments.form_id#">
						</select><br/>
						<select name="search_year" class="spl-search-input" id="search_year_#arguments.form_id#">
						</select><br/>
						<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
					</td>
				</tr>
			</form>
		</table>

		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=n&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=n&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>


	<cffunction name="vertical_search_tire" description="vertical display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="SEARCH NOW">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="default_geo" default="1">
		<!--- <cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/> --->
		<cfargument name="srp_action" default="http://#cgi.server_name#"/>
		<cfargument name="btn_pull" default="no-pull">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,249,330,14,262,264,265,47,55,288,333">
				<cfset arguments.default_new_used="u">
			</cfcase>
		</cfswitch>

	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		<!-- vertical search -->
		<form id="#arguments.form_id#" name="testform" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
		
 			<cfif #arguments.dealer_id# neq "233" AND #arguments.dealer_id# neq "84" >		<!--- Findlay Auto Group Radio Buttons 01/13/2015 --->
				<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and 
							arguments.dealer_id neq "249" and 
							arguments.dealer_id neq "330" and 
								arguments.dealer_id neq "14"  and 
									arguments.dealer_id neq "264" and 
										arguments.dealer_id neq "265"  and 
											arguments.dealer_id neq "262" and 
												arguments.dealer_id neq "47"  and  
												arguments.dealer_id neq "288"  and 
													arguments.dealer_id neq "55"  and 
													arguments.dealer_id neq "333"   >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"	or 
							arguments.dealer_id eq "264" or 
							arguments.dealer_id eq "333" or 
								arguments.dealer_id eq "265" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
					<cfif arguments.dealer_id neq "1" and arguments.dealer_id neq "288" and arguments.dealer_id neq "67" and arguments.dealer_id neq "333">
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id eq "1" >
						<!---<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned Vehicles</option>--->	
                        <option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id eq "288" or arguments.dealer_id eq "67">
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned</option>	
					</cfif>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and 
							<!--- arguments.dealer_id neq "249"  and   --->
							arguments.dealer_id neq "14"  and 
								arguments.dealer_id neq "264" and 
									arguments.dealer_id neq "265"  and 
										arguments.dealer_id neq "1"  and 
										arguments.dealer_id neq "288"  and 
										arguments.dealer_id neq "333"  and 
										arguments.dealer_id neq "55" and arguments.dealer_id neq "67"  >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66" OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"    >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
					<!--- <cfif arguments.dealer_id eq "1"   >     <!--- Baierl 05/21/2015  --->
						<option value="q"<cfif arguments.default_new_used eq "q">selected="selected"</cfif> onclick="this.form.submit()" >Baierl Budget Cars</option>
					</cfif>      --->
                    
                    <!---<cfif left(cgi.remote_addr,7) eq "10.0.0." or left(cgi.remote_addr,10) eq "192.168.5." or left(cgi.remote_addr,10) eq "172.16.25.">--->
                    	<cfif  arguments.dealer_id eq 78>
                        	<option value="A"<cfif arguments.default_new_used eq "a">selected="selected"</cfif>>Commercial Vehicles</option>
                        </cfif>
                    <!---</cfif>--->
				</select><br/>
			<cfelse>
			<cfif #arguments.dealer_id# neq "233" >
				  <select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14"   and arguments.dealer_id neq "262"  and 
							arguments.dealer_id neq "47"   and arguments.dealer_id neq "55"    and arguments.dealer_id neq "288"    >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"  or arguments.dealer_id eq "264" or arguments.dealer_id eq "265"  or arguments.dealer_id eq "288"  >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "264" and arguments.dealer_id neq "265"  and arguments.dealer_id neq "333"   >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>  
                     
				</select><br/>  
			 
				<!--- &nbsp;&nbsp;&nbsp;<span style="font-size:11pt;font-weight:bold" >
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="N" <cfif #arguments.default_new_used# eq "n">checked</cfif> /> New&nbsp;&nbsp;&nbsp;
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="U" <cfif #arguments.default_new_used# eq "u">checked</cfif> /> Used&nbsp;&nbsp;&nbsp;
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="C" <cfif #arguments.default_new_used# eq "c">checked</cfif> /> Certified</span>   --->
			<cfelse>
				<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14" and   arguments.dealer_id neq "55" and
							arguments.dealer_id neq "47" and arguments.dealer_id neq "262" and arguments.dealer_id neq "264"   and arguments.dealer_id neq "265"    and arguments.dealer_id neq "288"  and arguments.dealer_id neq "333"  >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"   or arguments.dealer_id eq "264" or arguments.dealer_id eq "265"  or arguments.dealer_id eq "288" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "55"  and arguments.dealer_id neq "333">     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67" OR  arguments.dealer_id eq "288"   >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
				</select><br/>
				</cfif>
			</cfif>
		 
			<cfif arguments.dealer_id eq "84"  <!---  Findlay Auto 84 --->  >
			  	<select class="spl-search-input" name="search_geo" id="search_geo_#arguments.form_id#">
			  		<option>Loading Regions...</option>
				</select><br/>
			</cfif>			

			 <select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
			  		<option>Loading Makes...</option>
			</select><br/>  
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
			  		<option>Loading Models...</option>
			</select><br/>
			<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
			  		<option>Loading Years...</option>
			</select><br/>
			
			<cfif arguments.dealer_id eq "178"    >
			  <select class="spl-search-input" name="search_zip" id="search_zip_#arguments.form_id#">
			</select><br/>
			</cfif> 		    

			<input class="spl-search-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>
		</form>
		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				<cfif arguments.dealer_id eq "178"    >
					var $zip = $('##search_zip_#arguments.form_id#')
				</cfif>
											
				loadGeo('','','#arguments.default_new_used#','#arguments.dealer_id#','');	
				loadMake('#arguments.default_new_used#', '#arguments.dealer_id#', '','','');
				loadModel('','#arguments.default_new_used#','#arguments.dealer_id#','','');	
				loadYear('','#arguments.default_new_used#','#arguments.dealer_id#','','');		
				<cfif arguments.dealer_id eq "178"    >
					$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				</cfif>								
												
				$new_used.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>								
				});					
					
				$geo.change(function(){	
					setDefaults();				
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>												
				});			
						
				$make.change(function(){
					setDefaults();
					<cfif arguments.dealer_id eq 15>	
					console.log(getCond())				;
						if ((getMake() == 'Chevrolet') && (getCond() == 'N')){
							top.location = 'https://baierlchevy.worktrucksolutions.com';
						}
					</cfif>
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());				
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>						
				});
								
				$model.change(function(){	
					setDefaults();	
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());			
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());		
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>				
				});
				
				/*$year.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(),getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
				});*/
				
				function getCond(){
					return $new_used.val();
				}
				function getGeo(){
					if ($geo.length){
						return $geo.val();	
					}else{
						return '';
					}										
				}
				function getMake(){
					if ($make.length){
						return encodeURIComponent($make.val());
					}else{
						return '';
					}					
				}
				function getModel(){
					if ($model.length){						
						return encodeURIComponent($model.val());
					}else{
						return '';
					}
				}
				function getYear(){
					if ($year.length){
						return $year.val();
					}else{
						return '';
					}
				}
				function getDealerID(){
					return #arguments.dealer_id#;
				}
				function setDefaults(){
					$condBeforeChg = getCond();
					$geoBeforeChg = getGeo();
					$makeBeforeChg = getMake();
					$modelBeforeChg = getModel();
					$yearBeforeChg = getYear();
				}
				
				function resetSel(){
					if ($new_used.children('option').length){
						try{ 
							$new_used.val($condBeforeChg);
						}catch (err){
							console.log(err);							
						}
					}
					if ($geo.children('option').length){
						try{
							if ($('##search_geo_#arguments.form_id# option[value="' +decodeURIComponent($geoBeforeChg)+ '"]').prop("selected", true).length) {
								$geo.val($geoBeforeChg);
							}else{
								$geo.val('');
							}
							
						}catch (err){							
							console.log(err);
						}
					}
					if ($make.children('option').length){
						try{
							if ($('##search_make_#arguments.form_id# option[value="' +decodeURIComponent($makeBeforeChg)+ '"]').prop("selected", true).length) {
								$make.val(decodeURIComponent($makeBeforeChg));
							}else{
								$make.val('');
							}
							
						}catch (err){
							console.log(err);							
						}
					}
					if ($model.children('option').length){
						try{							
							if ($('##search_model_#arguments.form_id# option[value="' +decodeURIComponent($modelBeforeChg)+ '"]').prop("selected", true).length) {
								$model.val(decodeURIComponent($modelBeforeChg));
							}else{
								$model.val('');
							}
						}catch (err){
							
						}
					}
					if ($year.children('option').length){
						try{
							if ($('##search_year_#arguments.form_id# option[value="' +$yearBeforeChg+ '"]').prop("selected", true).length) {						        
						        $year.val($yearBeforeChg);
						    }else{
						    	$year.val('');
						    }
							
						}catch (err){
							console.log(err);							
						}
					}
				}				
				function convCond(x){
					if (x == 'C')
					{
						return 'U';
					}else{
						return x;
					}
				}
				//dealerID  cond geo  make  model year  
				function loadMake(cond, dealerID, geo, year, model){					
					$make.load('global/inv_makes.cfm?new_used=' +cond+ '&dealer_id=' + dealerID+'&geo='+geo+'&year='+year/*+'&model='+model*/, function(){
						resetSel();
					});
				}
				function loadModel(make, cond, dealerID, geo, year){
					$model.load('global/inv_models.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&geo='+geo/*+'&year='+year*/, function(){
						resetSel();
					});
				}
				function loadYear(make, cond, dealerID, model, geo){
					$year.load('global/inv_years.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&model='+model+'&geo='+geo, function(){
						resetSel();
					});
				}
				function loadGeo(make, model, cond, dealerID, year){
					$geo.load('global/inv_geo.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&model='+model+'&make='+make+'&year='+year, function(){
						resetSel();
					});
				}
				
			});
		</script>
		
		

	</cffunction>

	
	<cffunction name="vertical_tire" description="horizontal display for search tool on Baierl Tires" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="qqFormV">
		<cfargument name="form_class" default="qq-form-v">
		<cfargument name="form_method" default="post">
		<!--- <cfargument name="srp_action" default="http://#cgi.server_name##cgi.script_name#"/> --->
		<cfargument name="srp_action" default="http://#cgi.server_name#"/>
		<cfargument name="btn_submit" default="CONTACT US">
		<cfargument name="btn_pull" default="no-pull">
		<cfargument name="default_new_used" default="n">

<!-- vertical qq -->
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">

			<cfif url.site_mode eq "legacy" or cgi.http_user_agent contains "MSIE 9.0">
				<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" value="First Name" onfocus="if (this.value=='First Name') this.value = ''" onblur="if (this.value=='') this.value = 'First Name'">
				<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" value="Last Name" onfocus="if (this.value=='Last Name') this.value = ''" onblur="if (this.value=='') this.value = 'Last Name'">
				<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" value="Phone" onfocus="if (this.value=='Phone') this.value = ''" onblur="if (this.value=='') this.value = 'Phone'">
				<p class="help-block">numbers only - no hypens or parentheses</p>
				<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" value="Email" onfocus="if (this.value=='Email') this.value = ''" onblur="if (this.value=='') this.value = 'Email'">
			<cfelse>
				<input name="First_Name" class="spl-search-input" id="First_Name" type="text" maxlength="50" placeholder="First Name" required>
				<input name="Last_Name" class="spl-search-input" id="Last_Name" type="text" maxlength="50" placeholder="Last Name" required>
				<input name="Phone_1" class="spl-search-input" id="Phone_1" type="text" minlength="10" maxlength="10" placeholder="Phone">
				<input name="Email" class="spl-search-input" id="Email" type="email" maxlength="100" placeholder="Email" required>			
			</cfif>
			<!--- 
			<select class="spl-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
				<cfif arguments.dealer_id neq "35" and  arguments.dealer_id neq "249" and  arguments.dealer_id neq "262" and  arguments.dealer_id neq "47"  and 
						arguments.dealer_id neq "264" and arguments.dealer_id neq "265"   and arguments.dealer_id neq "55"  and arguments.dealer_id neq "14"  and arguments.dealer_id neq "288"  and arguments.dealer_id neq "333"  >
					<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New Vehicles</option>
				</cfif>
				<cfif  arguments.dealer_id neq "333" >
					<cfif arguments.dealer_id neq "1" >
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
						<option value="C">Certified Vehicles</option>
					<cfelse>	
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned Vehicles</option>
					</cfif>
				<cfelse>	
						<option value="U"<cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used Vehicles</option>
				</cfif>
			   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
					<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
				</cfif>   	
			</select>
			<br/>
			
			<select class="spl-search-input" name="search_make" id="search_make_#arguments.form_id#">
			</select>
			<br/>
			<select class="spl-search-input" name="search_model" id="search_model_#arguments.form_id#">
			</select>
			<br/>
			<select class="spl-search-input" name="search_year" id="search_year_#arguments.form_id#">
			</select>
			 --->
			<br/>
			<input class="spl-qq-btn #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>

		</form>
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				$make.load('global/inv_makes.cfm?new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$model.load('global/inv_models.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$year.load('global/inv_years.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				$new_used.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$make.load('global/inv_makes.cfm?new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
				});
				$make.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					$model.load('global/inv_models.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					$year.load('global/inv_years.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
				$model.change(function(){
					var condName = $new_used.val();
					var makeName = $make.val();
					var modelName = $model.val();
					$year.load('global/inv_years.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
				});
			});
		</script>
			
	</cffunction>


	<cffunction name="vertical_search_mbl" description="vertical display for search tool" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="Search Now">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="default_geo" default="1">
		<cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
		<cfargument name="btn_pull" default="no-pull">

		<cfswitch expression="#arguments.dealer_id#" >
			<cfcase value="66,35,249,330,14,262,264,265,47,55,288,333">
				<cfset arguments.default_new_used="u">
			</cfcase>
		</cfswitch>

	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		<!-- vertical search -->
		<form id="#arguments.form_id#" name="testform"  method="#arguments.form_method#" action="#arguments.srp_action#">
		
 			<cfif #arguments.dealer_id# neq "233" AND #arguments.dealer_id# neq "84" >		<!--- Findlay Auto Group Radio Buttons 01/13/2015 --->
				<select class="spl-search-input-mbl" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and 
							arguments.dealer_id neq "249" and 
							arguments.dealer_id neq "330" and 
								arguments.dealer_id neq "14"  and 
									arguments.dealer_id neq "264" and 
										arguments.dealer_id neq "265"  and 
											arguments.dealer_id neq "262" and 
												arguments.dealer_id neq "47"  and  
												arguments.dealer_id neq "288"  and 
													arguments.dealer_id neq "55"  and 
													arguments.dealer_id neq "333"   >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"	or 
							arguments.dealer_id eq "264" or 
							arguments.dealer_id eq "333" or 
								arguments.dealer_id eq "265" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
					<cfif arguments.dealer_id neq "1" and arguments.dealer_id neq "288" and arguments.dealer_id neq "67" and arguments.dealer_id neq "333">
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id eq "1" >
						<!---<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned Vehicles</option>	--->
                        <option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id eq "288" or arguments.dealer_id eq "67">
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Certified Pre-Owned</option>	
					</cfif>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and 
							<!--- arguments.dealer_id neq "249"  and   --->
							arguments.dealer_id neq "14"  and 
								arguments.dealer_id neq "264" and 
									arguments.dealer_id neq "265"  and 
										arguments.dealer_id neq "1"  and 
										arguments.dealer_id neq "288"  and 
										arguments.dealer_id neq "333"  and 
										arguments.dealer_id neq "55" and arguments.dealer_id neq "67"  >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66" OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"    >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
					<!--- <cfif arguments.dealer_id eq "1"   >     <!--- Baierl 05/21/2015  --->
						<option value="q"<cfif arguments.default_new_used eq "q">selected="selected"</cfif> onclick="this.form.submit()" >Baierl Budget Cars</option>
					</cfif>      --->
                    
                    <!---<cfif left(cgi.remote_addr,7) eq "10.0.0." or left(cgi.remote_addr,10) eq "192.168.5." or left(cgi.remote_addr,10) eq "172.16.25.">--->
                    	<cfif  arguments.dealer_id eq 78>
                        	<option value="A"<cfif arguments.default_new_used eq "a">selected="selected"</cfif>>Commercial Vehicles</option>
                        </cfif>
                    <!---</cfif>--->
				</select><br/>
			<cfelse>
			<cfif #arguments.dealer_id# neq "233" >
				  <select class="spl-search-input-mbl" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14"   and arguments.dealer_id neq "262"  and 
							arguments.dealer_id neq "47"   and arguments.dealer_id neq "55"    and arguments.dealer_id neq "288"    >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"  or arguments.dealer_id eq "264" or arguments.dealer_id eq "265"  or arguments.dealer_id eq "288"  >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "264" and arguments.dealer_id neq "265"  and arguments.dealer_id neq "333"   >     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67"  OR  arguments.dealer_id eq "288"  >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>  
                     
				</select><br/>  
			 
				<!--- &nbsp;&nbsp;&nbsp;<span style="font-size:11pt;font-weight:bold" >
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="N" <cfif #arguments.default_new_used# eq "n">checked</cfif> /> New&nbsp;&nbsp;&nbsp;
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="U" <cfif #arguments.default_new_used# eq "u">checked</cfif> /> Used&nbsp;&nbsp;&nbsp;
				<input name="search_new_used" type="Radio" id="search_new_used_#arguments.form_id#" value="C" <cfif #arguments.default_new_used# eq "c">checked</cfif> /> Certified</span>   --->
			<cfelse>
				<select class="spl-search-input-mbl" name="search_new_used" id="search_new_used_#arguments.form_id#">
			
					<cfif arguments.dealer_id neq "35" and arguments.dealer_id neq "249" and arguments.dealer_id neq "14" and   arguments.dealer_id neq "55" and
							arguments.dealer_id neq "47" and arguments.dealer_id neq "262" and arguments.dealer_id neq "264"   and arguments.dealer_id neq "265"    and arguments.dealer_id neq "288"  and arguments.dealer_id neq "333"  >
						<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
					</cfif>
					<cfif arguments.dealer_id eq "36"   or arguments.dealer_id eq "264" or arguments.dealer_id eq "265"  or arguments.dealer_id eq "288" >
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Used #srch_txt_used#</option>
					<cfelse>
						<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
					</cfif>	
					<cfif arguments.dealer_id neq "51"  and arguments.dealer_id neq "249"  and arguments.dealer_id neq "55"  and arguments.dealer_id neq "333">     <!--- Lamacchia Honda --->
						<option value="C">Certified #srch_txt_certified#</option>
					</cfif>  
					   <cfif arguments.dealer_id eq "66"  OR  arguments.dealer_id eq "67" OR  arguments.dealer_id eq "288"   >     <!--- Courtesy Imports Classic Cars  also changes in used/splash_action.cfm 11/04/2014--->
						<option value="O"<cfif arguments.default_new_used eq "O">selected="selected"</cfif>>Classic Cars</option>
					</cfif>   
				</select><br/>
				</cfif>
			</cfif>
		 
			<cfif arguments.dealer_id eq "84"  <!---  Findlay Auto 84 --->  >
			  	<select class="spl-search-input-mbl" name="search_geo" id="search_geo_#arguments.form_id#">
			  		<option>Loading Regions...</option>
				</select><br/>
			</cfif>			

			 <select class="spl-search-input-mbl" name="search_make" id="search_make_#arguments.form_id#">
			  		<option>Loading Makes...</option>
			</select><br/>  
			<select class="spl-search-input-mbl" name="search_model" id="search_model_#arguments.form_id#">
			  		<option>Loading Models...</option>
			</select><br/>
			<select class="spl-search-input-mbl" name="search_year" id="search_year_#arguments.form_id#">
			  		<option>Loading Years...</option>
			</select><br/>
			
			<cfif arguments.dealer_id eq "178"    >
			  <select class="spl-search-input-mbl" name="search_zip" id="search_zip_#arguments.form_id#">
			</select><br/>
			</cfif> 		    

			<input class="spl-search-btn-mbl #arguments.btn_pull#" type="submit" value="#arguments.btn_submit#">
			<div class="clearfix"></div>
		</form>
		
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				<cfif arguments.dealer_id eq "178"    >
					var $zip = $('##search_zip_#arguments.form_id#')
				</cfif>
											
				loadGeo('','','#arguments.default_new_used#','#arguments.dealer_id#','');	
				loadMake('#arguments.default_new_used#', '#arguments.dealer_id#', '','','');
				loadModel('','#arguments.default_new_used#','#arguments.dealer_id#','','');	
				loadYear('','#arguments.default_new_used#','#arguments.dealer_id#','','');		
				<cfif arguments.dealer_id eq "178"    >
					$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				</cfif>								
												
				$new_used.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>								
				});					
					
				$geo.change(function(){	
					setDefaults();				
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>												
				});			
						
				$make.change(function(){
					setDefaults();
					<cfif arguments.dealer_id eq 15>	
					console.log(getCond())				;
						if ((getMake() == 'Chevrolet') && (getCond() == 'N')){
							top.location = 'https://baierlchevy.worktrucksolutions.com';
						}
					</cfif>
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());				
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>						
				});
								
				$model.change(function(){	
					setDefaults();	
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());			
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());		
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>				
				});
				
				/*$year.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(),getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
				});*/
				
				function getCond(){
					return $new_used.val();
				}
				function getGeo(){
					if ($geo.length){
						return $geo.val();	
					}else{
						return '';
					}										
				}
				function getMake(){
					if ($make.length){
						return encodeURIComponent($make.val());
					}else{
						return '';
					}					
				}
				function getModel(){
					if ($model.length){						
						return encodeURIComponent($model.val());
					}else{
						return '';
					}
				}
				function getYear(){
					if ($year.length){
						return $year.val();
					}else{
						return '';
					}
				}
				function getDealerID(){
					return #arguments.dealer_id#;
				}
				function setDefaults(){
					$condBeforeChg = getCond();
					$geoBeforeChg = getGeo();
					$makeBeforeChg = getMake();
					$modelBeforeChg = getModel();
					$yearBeforeChg = getYear();
				}
				
				function resetSel(){
					if ($new_used.children('option').length){
						try{ 
							$new_used.val($condBeforeChg);
						}catch (err){
							console.log(err);							
						}
					}
					if ($geo.children('option').length){
						try{
							if ($('##search_geo_#arguments.form_id# option[value="' +decodeURIComponent($geoBeforeChg)+ '"]').prop("selected", true).length) {
								$geo.val($geoBeforeChg);
							}else{
								$geo.val('');
							}
							
						}catch (err){							
							console.log(err);
						}
					}
					if ($make.children('option').length){
						try{
							if ($('##search_make_#arguments.form_id# option[value="' +decodeURIComponent($makeBeforeChg)+ '"]').prop("selected", true).length) {
								$make.val(decodeURIComponent($makeBeforeChg));
							}else{
								$make.val('');
							}
							
						}catch (err){
							console.log(err);							
						}
					}
					if ($model.children('option').length){
						try{							
							if ($('##search_model_#arguments.form_id# option[value="' +decodeURIComponent($modelBeforeChg)+ '"]').prop("selected", true).length) {
								$model.val(decodeURIComponent($modelBeforeChg));
							}else{
								$model.val('');
							}
						}catch (err){
							
						}
					}
					if ($year.children('option').length){
						try{
							if ($('##search_year_#arguments.form_id# option[value="' +$yearBeforeChg+ '"]').prop("selected", true).length) {						        
						        $year.val($yearBeforeChg);
						    }else{
						    	$year.val('');
						    }
							
						}catch (err){
							console.log(err);							
						}
					}
				}				
				function convCond(x){
					if (x == 'C')
					{
						return 'U';
					}else{
						return x;
					}
				}
				//dealerID  cond geo  make  model year  
				function loadMake(cond, dealerID, geo, year, model){					
					$make.load('global/inv_makes.cfm?new_used=' +cond+ '&dealer_id=' + dealerID+'&geo='+geo+'&year='+year/*+'&model='+model*/, function(){
						resetSel();
					});
				}
				function loadModel(make, cond, dealerID, geo, year){
					$model.load('global/inv_models.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&geo='+geo/*+'&year='+year*/, function(){
						resetSel();
					});
				}
				function loadYear(make, cond, dealerID, model, geo){
					$year.load('global/inv_years.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&model='+model+'&geo='+geo, function(){
						resetSel();
					});
				}
				function loadGeo(make, model, cond, dealerID, year){
					$geo.load('global/inv_geo.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&model='+model+'&make='+make+'&year='+year, function(){
						resetSel();
					});
				}
				
			});
		</script>
		
		

	</cffunction>



	<cffunction name="horizontal_search_huge_v1" description="horizontal display for search tool section of Variable_1028" output="Yes" access="public">

		<!---arguments--->
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_id" default="carfinderFormV">
		<cfargument name="form_class" default="carfinder-form-v">
		<cfargument name="btn_submit" default="Search Now">
		<cfargument name="form_method" default="post">
		<cfargument name="default_new_used" default="n">
		<cfargument name="default_geo" default="1">
		<cfargument name="srp_action" default="http://#cgi.server_name#/vehicles/splash_action.cfm"/>
		<cfargument name="btn_pull" default="no-pull">

	<!--- Search Style & Text 02/23/2016 --->	
		<cfset srch_style = 0 >	<cfset srch_txt_new = "Vehicles" >	<cfset srch_txt_used = "Vehicles" >	<cfset srch_txt_certified = "Vehicles" >	
		<cfquery datasource="ultra10" name="chk_srp_style">SELECT srch_type,srch_type_txt_new,srch_type_txt_used,srch_type_txt_cert FROM Dealers WHERE dealer_id = #url.dealer_id#</cfquery>  
		<cfset srch_style = #chk_srp_style.srch_type# ><cfset srch_txt_new="#chk_srp_style.srch_type_txt_new#"><cfset srch_txt_used="#chk_srp_style.srch_type_txt_used#">
		<cfset srch_txt_certified="#chk_srp_style.srch_type_txt_cert#">	
	<!--- Search Style & Text 02/23/2016 --->	
		
		<form id="#arguments.form_id#" class="#arguments.form_class#" method="#arguments.form_method#" action="#arguments.srp_action#">
			<div class="row row-centered " >
				<div class="col-md-12 col-centered"  >
					<ul class="nav">
						<li style="display: inline-block; padding-right:20px;" >
							<select class="horizontal-search-input" name="search_new_used" id="search_new_used_#arguments.form_id#">
								<option value="N" <cfif arguments.default_new_used eq "n">selected="selected"</cfif>>New #srch_txt_new#</option>
								<option value="U" <cfif arguments.default_new_used eq "u">selected="selected"</cfif>>Pre-Owned #srch_txt_used#</option>	
								<option value="C">Certified #srch_txt_certified#</option>
							</select>
						</li>		
						<li  style="display: inline-block; padding-right:20px;">
						 	 <select class="horizontal-search-input" name="search_make"  id="search_make_#arguments.form_id#"></select>
						</li>		 			
						<li  style="display: inline-block; padding-right:20px;">
							 <select class="horizontal-search-input" name="search_model"  id="search_model_#arguments.form_id#"></select>
						</li>		 		
						<li  style="display: inline-block; padding-right:20px;">
							 <select class="horizontal-search-input" name="search_year"   id="search_year_#arguments.form_id#"></select>
						</li>	 			
						<li  style="display: inline-block; padding-right:20px;">
							 <input class="horizontal-go-btn horizontal-btn-input" type="submit" value="#arguments.btn_submit#">
					</li>
					</ul>
				</div>
 
			</div>	
				
			<div class="clearfix"></div>
				
		</form>
		
				
		<script>
			$(function() {
				var $new_used = $('##search_new_used_#arguments.form_id#')
				var $make = $('##search_make_#arguments.form_id#')
				var $model = $('##search_model_#arguments.form_id#')
				var $year = $('##search_year_#arguments.form_id#')
				var $geo = $('##search_geo_#arguments.form_id#')
								/* &geo=#arguments.default_geo#*/
				<cfif arguments.dealer_id eq "178"    >
					var $zip = $('##search_zip_#arguments.form_id#')
				</cfif>
											
				loadGeo('','','#arguments.default_new_used#','#arguments.dealer_id#','');	
				loadMake('#arguments.default_new_used#', '#arguments.dealer_id#', '','','');
				loadModel('','#arguments.default_new_used#','#arguments.dealer_id#','','');	
				loadYear('','#arguments.default_new_used#','#arguments.dealer_id#','','');		
				<cfif arguments.dealer_id eq "178"    >
					$zip.load('global/inv_zip.cfm?make=&new_used=#arguments.default_new_used#&dealer_id=#arguments.dealer_id#');
				</cfif>								
												
				$new_used.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>								
				});					
					
				$geo.change(function(){	
					setDefaults();				
					loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?new_used=' + condName + '&make=' + makeName + '&dealer_id=#arguments.dealer_id#');
					</cfif>												
				});			
						
				$make.change(function(){
					setDefaults();
					<cfif arguments.dealer_id eq 15>	
					console.log(getCond())				;
						if ((getMake() == 'Chevrolet') && (getCond() == 'N')){
							top.location = 'https://baierlchevy.worktrucksolutions.com';
						}
					</cfif>
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());				
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>						
				});
								
				$model.change(function(){	
					setDefaults();	
					//loadMake(getCond(),getDealerID(),getGeo(),getYear(), getModel());			
					//loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadYear(getMake(),getCond(),getDealerID(),getModel(),getGeo());		
					<cfif arguments.dealer_id eq "178"    >
						$zip.load('global/inv_zip.cfm?model=' + modelName + '&make=' + makeName + '&new_used=' + condName + '&dealer_id=#arguments.dealer_id#');
					</cfif>				
				});
				
				/*$year.change(function(){
					setDefaults();
					loadGeo(getMake(),getModel(),getCond(),getDealerID(),getYear());
					loadMake(getCond(),getDealerID(),getGeo(),getYear(),getModel());
					loadModel(getMake(),getCond(),getDealerID(),getGeo(),getYear());
				});*/
				
				function getCond(){
					return $new_used.val();
				}
				function getGeo(){
					if ($geo.length){
						return $geo.val();	
					}else{
						return '';
					}										
				}
				function getMake(){
					if ($make.length){
						return encodeURIComponent($make.val());
					}else{
						return '';
					}					
				}
				function getModel(){
					if ($model.length){						
						return encodeURIComponent($model.val());
					}else{
						return '';
					}
				}
				function getYear(){
					if ($year.length){
						return $year.val();
					}else{
						return '';
					}
				}
				function getDealerID(){
					return #arguments.dealer_id#;
				}
				function setDefaults(){
					$condBeforeChg = getCond();
					$geoBeforeChg = getGeo();
					$makeBeforeChg = getMake();
					$modelBeforeChg = getModel();
					$yearBeforeChg = getYear();
				}
				
				function resetSel(){
					if ($new_used.children('option').length){
						try{ 
							$new_used.val($condBeforeChg);
						}catch (err){
							console.log(err);							
						}
					}
					if ($geo.children('option').length){
						try{
							if ($('##search_geo_#arguments.form_id# option[value="' +decodeURIComponent($geoBeforeChg)+ '"]').prop("selected", true).length) {
								$geo.val($geoBeforeChg);
							}else{
								$geo.val('');
							}
							
						}catch (err){							
							console.log(err);
						}
					}
					if ($make.children('option').length){
						try{
							if ($('##search_make_#arguments.form_id# option[value="' +decodeURIComponent($makeBeforeChg)+ '"]').prop("selected", true).length) {
								$make.val(decodeURIComponent($makeBeforeChg));
							}else{
								$make.val('');
							}
							
						}catch (err){
							console.log(err);							
						}
					}
					if ($model.children('option').length){
						try{							
							if ($('##search_model_#arguments.form_id# option[value="' +decodeURIComponent($modelBeforeChg)+ '"]').prop("selected", true).length) {
								$model.val(decodeURIComponent($modelBeforeChg));
							}else{
								$model.val('');
							}
						}catch (err){
							
						}
					}
					if ($year.children('option').length){
						try{
							if ($('##search_year_#arguments.form_id# option[value="' +$yearBeforeChg+ '"]').prop("selected", true).length) {						        
						        $year.val($yearBeforeChg);
						    }else{
						    	$year.val('');
						    }
							
						}catch (err){
							console.log(err);							
						}
					}
				}				
				function convCond(x){
					if (x == 'C')
					{
						return 'U';
					}else{
						return x;
					}
				}
				//dealerID  cond geo  make  model year  
				function loadMake(cond, dealerID, geo, year, model){					
					$make.load('global/inv_makes.cfm?new_used=' +cond+ '&dealer_id=' + dealerID+'&geo='+geo+'&year='+year/*+'&model='+model*/, function(){
						resetSel();
					});
				}
				function loadModel(make, cond, dealerID, geo, year){
					$model.load('global/inv_models.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&geo='+geo/*+'&year='+year*/, function(){
						resetSel();
					});
				}
				function loadYear(make, cond, dealerID, model, geo){
					$year.load('global/inv_years.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&make='+make+'&model='+model+'&geo='+geo, function(){
						resetSel();
					});
				}
				function loadGeo(make, model, cond, dealerID, year){
					$geo.load('global/inv_geo.cfm?&new_used=' +cond+'&dealer_id='+dealerID+'&model='+model+'&make='+make+'&year='+year, function(){
						resetSel();
					});
				}
				
			});
		</script>
		

			
	</cffunction>

		
	
</cfcomponent>