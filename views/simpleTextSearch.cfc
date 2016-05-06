<cfcomponent>
	<cffunction name="displaytextBox" access="public" returntype="void">
		<cfargument name="width" type="string" required="no" default="200px">
        <cfargument name="height" type="string" required="no" default="50px">
        <cfargument name="fontSize" type="string" required="no" default="12px">
        <cfargument name="class" type="string" required="no" default=""><!---element DOM attribute class of the input --->
        <cfargument name="id" type="string" required="no" default=""><!---element DOM attribute id of the input --->
        <cfargument name="instanceName" type="string" required="no" default="searchBox"><!---element DOM attribute name of the input --->
        <cfargument name="formWrap" type="string" required="no" default="no"><!---add <form > tags around the input --->
        <cfargument name="formClass" type="string" required="no" default="form-inline">
        
    	<cfoutput>    
		
			<cfif arguments.formWrap is 'yes'>        
                <form action="" method="post" class="#arguments.formClass# ontop">
            </cfif>
                <div class="form-group col-md-12 ontop">
                <div class="input-group">
                    <div class="input-group-addon"><a href="##" data-toggle="modal" data-target="##simpleSrhModalHelp">?</a></div>
                    <input type="text" name="#arguments.instanceName#" id="#arguments.id#" class="#arguments.class# ontop" placeholder="SEARCH #UCase(url.dealer_name)#" />
                    <div class="input-group-addon" id="searchResultsCount">results</div>
                </div>
                </div>  
                <div id="#arguments.id#_display" class="displayTextBoxOutput col-md-12 ontop"></div>          
                <div id="modalBox" class="modalBg fade" role="dialog"></div>
            <cfif arguments.formWrap is 'yes'>            
                </form>
            </cfif>
            	<!-- Modal -->
                <div id="simpleSrhModalHelp" class="modal fade" role="dialog">
                  <div class="modal-dialog">
                
                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Search Help</h4>
                      </div>
                      <div class="modal-body">
                        <p>Use the term New/Used/Preowned to narrow results based on the vehicle condition</p>
                        <p>You can use a < and or > sign plus dollar amount to anrrow search by price</p>
                        <p>You can enter a VIN to search for specific vin</p>
                        <p>You can search for stock number to find specific vehicle</p>
                        <p>Example search - new nissan >12000 <25000</p>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                      </div>
                    </div>
                
                  </div>
                </div>
            	
            	<style>
					.ontop{z-index:125;}
					###arguments.id#{z-index:100;}
					.displayTextBoxOutput{
						min-width:1px;
						min-height:1px;
						max-height:250px;
						position:absolute;
						overflow:auto;		
						background-color:##ffffff;	
					}
					.searchResultsImg{
						max-width:75px;
						max-height:50px;	
					}
					.modalBg{
					    position: fixed;
						top: 0;
						right: 0;
						bottom: 0;
						left: 0;
						z-index: 75;
						display: none;
						overflow: hidden;
						-webkit-overflow-scrolling: touch;
						outline: 0;	
						background-color:##000;
					}
					.fade{
						opacity:.75!important;}
				</style>
                
                <script>
					var $results = $('###arguments.id#_display');
					var $resultCnt = $('##searchResultsCount');
					var $searchCrit = $('###arguments.id#');
	
					$searchCrit.focus(function() {
						if($searchCrit.val().length){									
							runSearch();
						}else{
							clearSearch();
						}					
					});
					
					$searchCrit.keyup(function() {						
						if($searchCrit.val().length){
							runSearch();							
						}else{
							clearSearch();
						}						
					});
					
					$('*').on('click', function() {
						if(this.id == 'simpleSrh'){
							//console.log($(event.target).parent());							
							return false;
						}else if ((this.id == 'simpleSrh_display') && ($(event.target).parent().prop('tagName') != 'A')){
							console.log($(event.target).parent().prop('tagName'));							
							return false;
						}else if ((this.id == 'simpleSrh_display') && ($(event.target).parent().prop('tagName') == 'A')){
							//follow link
						}else{
							clearSearch();
						}
					});
					
					clearSearch = function(){
						$results.html('');		
						hideModal();	
					}
					runSearch = function(){
						$results.load('/global/searchResults.cfm?dealer_Id=#url.dealer_id#&crit=' + getCritEscaped(), function(responseTxt, statusTxt, xhr){
							if(statusTxt == "success")
								setResults(responseTxt);
							if(statusTxt == "error")
								console.log("Error: " + xhr.status + ": " + xhr.statusText);
						});		
						showModal();	
					}					
					
					getCritEscaped = function(){
						var _crit = $searchCrit.val();
						_crit = encodeURIComponent(_crit);
						
						return _crit;
					}
					
					setResults = function(_r){
						var _start = _r.search("<results>");
						_start = _start + 9;
						var _end = _r.search("</results>");
						var r = _r.substring(_start, _end);
						$resultCnt.html(r);
					}
					hideModal = function(){
						$('##modalBox').hide();
					}
					showModal = function(){
						$('##modalBox').show();
					}

				</script>
		</cfoutput>
        <!--- 
			build jquery function to run ajax search for any vehicle with the matching search text
			
			ajax calls page that runs query ...displays results and displays in an id 
			
			id is set to fixed with and height of the seaarch box and scrollable
			
			
		
		--->
        
        
        
		
	</cffunction>
    <cffunction name="displaytextBoxResults" access="remote">
    	
        <table>
        	<tr>
            	<td>
                	Title
                </td>
                <td>
                	Year
                </td>
            </tr>
        </table>
        
    </cffunction>
    
</cfcomponent>