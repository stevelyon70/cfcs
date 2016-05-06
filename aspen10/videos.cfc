<cfcomponent>

	<cffunction name="videos" description="shows standard dealer video player" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
<!--- 
		<cfquery datasource="Aspen10" name="Get_Videos">
			SELECT		Dealer_Video_ID,
						Dealer_ID,
						Video_Name,
						Thumbnail,
						FLV_URL,
						HTML5_URL,
						Start_Date,
						End_Date,
						Hierarchy
			FROM		Dealer_Videos
			WHERE		Dealer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.dealer_id#" maxlength="6">
			AND			Start_Date <= <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			End_Date >= <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(),"mm/dd/yyyy")#" maxlength="10">
			AND			FLV_URL is not null
			ORDER BY 	Hierarchy
		</cfquery> --->

		<script src="#url.boostrap_url#/flowplayer/flowplayer-3.2.13.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="http://cdn.jquerytools.org/1.2.6/tiny/jquery.tools.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="#url.boostrap_url#/flowplayer/flowplayer.playlist-3.2.11.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="#url.boostrap_url#/flowplayer/flowplayer.ipad-3.2.13.min.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="#url.boostrap_url#/flowplayer/playlist-horizontal.css"/>
			
			<table style="width:100%">
				<!--- <tr>
					<td align="center">
						<a id="player" class="player"></a>
					</td>
				</tr> --->
				<tr>
					<td align="center">
						<div class="playlist_wrap">
							<table style="width:100%;background-color:##fff">
								<tr>
									<td>
										<a class="prev"></a>
									</td>
									<td>
										<div id="pl">
											<div class="entries">
												<!--- <div class="page"> --->
													<!--- <cfloop query="Get_Videos"> --->
														<a video href="http://f0ee7d87fb46e4914b78-6c71a0283b469ea963b5d5efa5318a5d.r9.cf1.rackcdn.com/AutoProvalDec14_1.flv" title="Autoproval">
															<img class="img-responsive" src="http://#cgi.server_name#/dealer/#variables.dlr_dir#/images/icons/VideoPlaceholdsr.jpg">
														</a>
														<!--- <cfif Get_Videos.currentrow mod 4 eq 0>
															</div><div class="page">
														</cfif>
													</cfloop> --->
												<!--- </div> --->
											</div>
										</div>										
									</td>
									<td>
										<a class="next"></a>	
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
				

		<script>
                            $(function () {
                                // set up the player
                                $f("player", {
                                    src: "#url.boostrap_url#/flowplayer/flowplayer-3.2.18.swf",                                    
                                    wmode: "transparent",
                                    clip:
                                        {
                                        autoPlay: false,
                                        autoBuffering: true
                                        },                                    
                                    // the iPad plugin and the playlist plugin
                                }).ipad().playlist("div.entries");
                                // set up scrolling for the playlist elements
                                $("##pl").scrollable();                                                               
                            });
                        </script>
		<!---
		<script>
		$(function() {
			// set up the player
			$f("player", "#url.boostrap_url#/flowplayer/flowplayer-3.2.18.swf", {
				clip: {
					autoPlay: false,
					autoBuffering: true
				}
			// the iPad plugin and the playlist plugin
			}).ipad().playlist("div.entries");
			// set up scrolling for the playlist elements
			$("##pl").scrollable();
		});
		</script>--->

	</cffunction>

</cfcomponent>