<cfoutput>


			<style type="text/css">
			body, html {
				margin: 0 auto;
				padding: 0;
				width:100%;
				font-family: Helvetica, Arial, sans-serif;
			}
			.header {
				background-color: ##ffffff;
				position:fixed;
				top: 0;
				left: 0;
				margin: 0 auto;
				width: 100%;
				height: 150px;
			}
			
			.section1 {
				margin: 150px auto;
				margin-bottom: 0px;
				width: 100%;
				float: left;
				background-image: url('http://dealers.wdautos.com/dealer/worlddealergeneric/images/icons/bg_main.jpg');
				background-position:center middle;
				background-repeat:no-repeat;
				background-size:cover;	
			}
			.section2 {
				background-color: ##ffffff;
				width: 100%;
				float: left;
			}	
			
			.column1 {
				width: 5%;
				padding: 10px;
				float: left;
			}
			
			.column2 {
				width: 42%;
				padding: 10px;
				float: left;
				margin: 20px 0px 20px 40px;
			}
			
			.column3 {
				width: 48%;
				padding: 10px;
				float: right;
				margin: 20px 60px 20px 0px;
			}
			
			.FormField {
				width: 250px;
				-webkit-border-radius:5px;
				-moz-border-radius:5px;
				border-radius:5px;
				border:1px solid ##3d5797;
				font-family:arial;
				font-size:15px;
				font-weight:bold;
				font-style:normal;
				height:36px;
				line-height:36px;
				padding-left: 20px;
			}
			.RWDButtons {
				-moz-box-shadow:inset 0px 1px 0px 0px ##3d5797;
				-webkit-box-shadow:inset 0px 1px 0px 0px ##3d5797;
				box-shadow:inset 0px 1px 0px 0px ##3d5797;
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, ##4161ae), color-stop(1, ##3d5797) );
				background:-moz-linear-gradient( center top, ##4161ae 5%, ##3d5797 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='##4161ae', endColorstr='##3d5797');
				background-color:##4161ae;
				-webkit-border-radius:5px;
				-moz-border-radius:5px;
				border-radius:5px;
				border:1px solid ##3d5797;
				display:inline-block;
				color:##ffffff;
				font-family:arial;
				font-size:15px;
				font-weight:bold;
				font-style:normal;
				height:36px;
				line-height:36px;
				width:275px;
				text-decoration:none;
				text-align:center;
				text-shadow:1px 1px 0px ##3d5797;
			}
			.RWDButtons:hover {
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, ##3d5797), color-stop(1, ##4161ae) );
				background:-moz-linear-gradient( center top, ##3d5797 5%, ##4161ae 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='##3d5797', endColorstr='##4161ae');
				background-color:##3d5797;
			}.RWDButtons:active {
				position:relative;
				top:1px;
			}
			
			.quote {
				font-style: italic;
				font-size: 13pt;
				padding-left: 180px;
				padding-right:180px;
			}
			
			@media (max-width: 800px) {
				
			.section1 {
				margin: 150px auto;
				margin-bottom: 0px;
				width: 100%;
				float: none;
				background-image:url('http://dealers.wdautos.com/dealer/worlddealergeneric/images/icons/bg_main_mobile.jpg');
				background-position:left top;
				background-repeat:no-repeat;
				background-size:cover;	
			}
			.section2 {
				background-color: ##ffffff;
				width: 100%;
				float: none;
				margin: 0 auto;
			}	
			
			.column2, .column3 {
				width: 95%;
				padding: 10px;
				float: none;
				margin: 10px;
			}
			
			.FormField {
				width: 95%;
				-webkit-border-radius:5px;
				-moz-border-radius:5px;
				border-radius:5px;
				border:1px solid ##3d5797;
				font-family:arial;
				font-size:15px;
				font-weight:bold;
				font-style:normal;
				height:50px;
				line-height:50px;
				padding-left: 20px;
			}
			.RWDButtons {
				-moz-box-shadow:inset 0px 1px 0px 0px ##3d5797;
				-webkit-box-shadow:inset 0px 1px 0px 0px ##3d5797;
				box-shadow:inset 0px 1px 0px 0px ##3d5797;
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, ##4161ae), color-stop(1, ##3d5797) );
				background:-moz-linear-gradient( center top, ##4161ae 5%, ##3d5797 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='##4161ae', endColorstr='##3d5797');
				background-color:##4161ae;
				-webkit-border-radius:5px;
				-moz-border-radius:5px;
				border-radius:5px;
				border:1px solid ##3d5797;
				display:inline-block;
				color:##ffffff;
				font-family:arial;
				font-size:15px;
				font-weight:bold;
				font-style:normal;
				height:50px;
				line-height:50px;
				width:90%;
				text-decoration:none;
				text-align:center;
				text-shadow:1px 1px 0px ##3d5797;
			}
			.quote {
				font-style: italic;
				padding: 15px;
			}
			}
			
			
			</style>


<cfif NOT IsDefined("url.thanks") >
			
			<div class="header">
			<h3 style="text-align:center"><img src="http://dealers.wdautos.com/dealer/worlddealergeneric/images/icons/AutoViewLogo.png" width="350" alt=""/></h3>
			</div>
			
			<div class="section1">
			  <div class="column2">
			  <h2 style="text-align:left">The mobile revolution is here!</h2>
			
			<p>Google is changing the way they rank mobile sites. Not only are they making their search results more mobile friendly, but they are giving weight to sites that consider the mobile user. With so many people doing the majority of their searching, shopping, and surfing on mobile devices, it’s important for Google to stay ahead of the trends. It should be important to you as well!</p>
			
			<p>With an AutoView Responsive Website from WorldDealer, you can take advantage of these Google changes. You will have one website for all devices and users.</p></div>
			
			 </div>
			
			<div class="section2" style="background-color: ##4161ae; color: ##ffffff;">
			<h3 class="quote">&quot;With our new responsive website from WorldDealer, we have seen our traffic, engagement and sales increase significantly&quot; - Bob Baierl - Baierl Automotive 
			</div>
			
			<div class="section2">
			<div style="width: 80%; margin: 0 auto;">
			<div class="column2">
			<h3 style="font-size:14pt;text-align:left">What can an AutoView website from WorldDealer do for you?</h3>
			<ul>
			<li>Increase all organic traffic</li>
			<li>Increase mobile organic traffic</li>
			<li>Increase sales</li>
			<li>Streamline your SEO efforts by only having one set of code</li>
			<li>Provide a seamless user experience to your customers</li>
			<li>Get world-class service</li>
			</ul>
			</div>
			<div class="column3">
			<h3 style="font-size:14pt;text-align:center">Get ahead of your competition with an AutoView Responsive Website from WorldDealer.</h3>
			<p style="align:center">Fill out the form below to have an advocate contact you!</p>
				<cfinvoke component="/cfcs/forms/form_qq_rwd" method="qq_micro_rwd">
					<cfinvokeargument name="dealer_id" value="#url.dealer_id#"/>
					<cfinvokeargument name="VOI_Vin" value=""/>
					<cfinvokeargument name="VOI_New_Used" value=""/>
					<cfinvokeargument name="form_name" value="quick_quote_mobile"/>
					<cfinvokeargument name="form_action" value="http://#cgi.server_name#/dealer/worlddealergeneric/micro_rwd_action.cfm"/>
				</cfinvoke>  
			</div></div>
			
			
			<div class="section2" style="background-color: ##333132; color: ##ffffff;">
			                <p style="align:center"><img src="http://dealers.wdautos.com/dealer/worlddealergeneric/images/icons/logo_WD2.png" width="100%" style="max-width:300px; padding:10px;"></p>
			                <p style="font-size:12px; padding:10px;center">101 North Meadows Drive | Suite 125 | Wexford, PA 15106<br />
			                (866) 485-8800 | WorldDealer.net</p>
			</div>
			
<cfelse>
			<!--- Thanks Page --->
			<div class="header">
			<h3 style="text-align:center"><img src="http://dealers.wdautos.com/dealer/worlddealergeneric/images/icons/AutoViewLogo.png" width="350" alt=""/></h3>
			</div>
			
			<div class="section1">
			 
			<div class="section2">
			 <h1 align="center" >Thank You!</h1>
			<div style="width: 80%; margin: 0 auto;">
			<!--- <div class="column2"> --->
			
<h4 style="text-align:left">A representative will contact you soon regarding your interest in our AutoView Responsive website platform.  Please <a href="http://www.worlddealer.net?utm_source=rwd-microsite&utm_medium=referral">view our full website</a> to learn about some of our other marketing cababilities!</h4>
			
			<!--- </div> --->
			
			
			<div class="section2" style="background-color: ##333132; color: ##ffffff; position:fixed; bottom: 0; left: 0;">
                <p style="align:center"><a href="http://www.worlddealer.net?utm_source=rwd-microsite&utm_medium=referral"><img class="img-responsive" src="http://dealers.wdautos.com/dealer/worlddealergeneric/images/icons/logo_WD.png" width="100%"   style="max-width:300px; padding:10px;"  border="0"></a></p>
                <p style="font-size:12px; padding:10px;align:center">101 North Meadows Drive | Suite 125 | Wexford, PA 15106<br />
                (866) 485-8800 | <a href="http://www.worlddealer.net?utm_source=rwd-microsite&utm_medium=referral">WorldDealer.net</a></p>
</div>


</cfif>			

			
			
			
</cfoutput>