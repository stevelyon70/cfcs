
<style type="text/css">
.cta-button {
	-moz-box-shadow:inset 0px 1px 0px 0px #cc0000;
	-webkit-box-shadow:inset 0px 1px 0px 0px #cc0000;
	box-shadow:inset 0px 1px 0px 0px #cc0000;
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #cc0000), color-stop(1, #cc0000) );
	background:-moz-linear-gradient( center top, #cc0000 5%, #cc0000 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#cc0000', endColorstr='#cc0000');
	background-color:#cc0000;
	-webkit-radius:10px;
	-moz-border-radius:10px;
	border-radius:10px;
	text-indent:0;
	border:1px solid #cc0000;
	display:inline-block;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	font-style:normal;
	height:20px;
	line-height:20px;
	width:60%;
	text-decoration:none;
	text-align:center;
	text-shadow:1px 1px 0px #cc0000;
	margin: 2px;
}
.cta-button:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #cc0000), color-stop(1, #cc0000) );
	background:-moz-linear-gradient( center top, #cc0000 5%, #cc0000 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#cc0000', endColorstr='#cc0000');
	background-color:#cc0000;
	color:#ffffff;
}.cta-button:active {
	position:relative;
	top:1px;
	color:#ffffff;
}

.vertical-text {
	transform: rotate(90deg);
	transform-origin: left top 0;
	float: left;
	color:#000000;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	font-style:normal;
	height:80px;
	line-height:30px;
	width:150px;
	text-decoration:none;
	text-align:center;
}

		/* simple */
		.flip-container {
		border:0px solid black;   /* was 2px   */
			-webkit-perspective: 1000;
			-moz-perspective: 1000;
			-ms-perspective: 1000;
			perspective: 1000;

			-ms-transform: perspective(1000px);
			-moz-transform: perspective(1000px);
    			-moz-transform-style: preserve-3d; 
    			-ms-transform-style: preserve-3d; 
				
		font-family:Impact, Haettenschweiler, "Franklin Gothic Bold", "Arial Black", sans-serif;
		}
			/* START: Accommodating for IE */
			.flip-container:hover .back, .flip-container.hover .back {
    -webkit-transform: rotateY(0deg);
    -moz-transform: rotateY(0deg);
    -o-transform: rotateY(0deg);
    -ms-transform: rotateY(0deg);
    transform: rotateY(0deg);
}

.flip-container:hover .front, .flip-container.hover .front {
    -webkit-transform: rotateY(180deg);
    -moz-transform: rotateY(180deg);
    -o-transform: rotateY(180deg);
    transform: rotateY(180deg);
}
		
		/* END: Accommodating for IE */

		.flip-container, .front, .back {
			margin: 0 auto;
			width: 100%;
			max-width: 420px;    /* Panel width   */	
			height: 420px;    /* Panel Height   */
		}

		.flipper {
			-webkit-transition: 0.6s;
			-webkit-transform-style: preserve-3d;
			-ms-transition: 0.6s;

			-moz-transition: 0.6s;
			-moz-transform: perspective(1000px);
			-moz-transform-style: preserve-3d;
			-ms-transform-style: preserve-3d;

			transition: 0.6s;
			transform-style: preserve-3d;

			position: relative;
			

		}

		.front, .back  {
			-webkit-backface-visibility: hidden;
			-moz-backface-visibility: hidden;
			-ms-backface-visibility: hidden;
			backface-visibility: hidden;

		    -webkit-transition: 0.6s;
		    -webkit-transform-style: preserve-3d;
		    -webkit-transform: rotateY(0deg);

		    -moz-transition: 0.6s;
		    -moz-transform-style: preserve-3d;
		    -moz-transform: rotateY(0deg);

		    -o-transition: 0.6s;
		    -o-transform-style: preserve-3d;
		    -o-transform: rotateY(0deg);

		    -ms-transition: 0.6s;
		    -ms-transform-style: preserve-3d;
		    -ms-transform: rotateY(0deg);

		    transition: 0.6s;
		    transform-style: preserve-3d;
		    transform: rotateY(0deg);

			position: absolute;
			top: 0;
			left: 0;
			
			-webkit-radius:10px;
			-moz-border-radius:10px;
			border-radius:10px;
		}

		.front {
			-webkit-transform: rotateY(0deg);
			-ms-transform: rotateY(0deg);
			background: #ffffff;
			z-index: 2;
		}

		.back {
			background: #000000!important;
			
			-webkit-transform: rotateY(-180deg);
		    -moz-transform: rotateY(-180deg);
		    -o-transform: rotateY(-180deg);
		    -ms-transform: rotateY(-180deg);
		    transform: rotateY(-180deg);
		}
 

		.front .name {
			font-size: 2em;
			display: inline-block;
			background: rgba(33, 33, 33, 0.9);
			color: #f8f8f8;
			font-family: Courier;
			padding: 5px 10px;
			border-radius: 5px;
			bottom: 60px;
			left: 25%;
			position: absolute;
			text-shadow: 0.1em 0.1em 0.05em #333;
			display: none;

			-webkit-transform: rotate(-20deg);
			-moz-transform: rotate(-20deg);
			-ms-transform: rotate(-20deg);
			transform: rotate(-20deg);
		}

		.back-logo {
			position: absolute;
			top: 40px;
			left: 90px;
			width: 160px;
			height: 117px;
			background: url(logo.png) 0 0 no-repeat;
		}

		.back-title {
			font-weight: bold;
			color: #00304a;
			position: absolute;
			top: 180px;
			left: 0;
			right: 0;
			text-align: center;
			text-shadow: 0.1em 0.1em 0.05em #acd7e5;
			font-family: arial!important;
			font-size: 22px;
		}

		.back p {
			padding: 10px;
			font-size: 14px;
		}
		.back h3 {
			padding: 10px;
			font-size: 18px;
		}
 .content {
	 width:100%;	/*  49% */
	 float:left;
	 padding:2px;
 }
 
 @media (max-width: 1100px) {	/* 600  */
 .content {
	 width:100%;
	 float:none;
	 padding:2px;
 }
}
</style>


<section class="section-landing-pg">
	<div class="container">
		
			
		<div class="row pad-top-10">
			<div class="col-md-6 pad-top-10">
				<div class="content">
					<div class="flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="flipper">
							<div class="front" style="align:center">
								<!--- <div class="vertical-text">Click to View Options!</div>  --->
						         <img src="http://dealers.wdautos.com/dealer/henderson/images/icons/icon_kia.png" alt="Kia" > 
							</div>
							<div class="back" style="align:center">
								<div style="font-size:28px;">
								<a href="http://www.hendersonkia.com/new/" target="_blank"  ><img src="http://dealers.wdautos.com/dealer/henderson/images/icons/logo_HendersonKia9_off.png" alt="Kia" class="img-responsive" ></a> 
									(702) 757-4677<br>
									<a href="http://www.hendersonkia.com/new/" target="_blank" class="cta-button">Shop New Kias</a> <br>
									<a href="http://www.hendersonkia.com/used/" target="_blank"  class="cta-button">Shop Used Vehicles</a> <br>
									<a href="http://www.hendersonkia.com/new/special_offers.cfm"  target="_blank" class="cta-button">New Specials</a> <br>
									<a href="http://www.hendersonkia.com/used/special_offers.cfm"  target="_blank" class="cta-button">Used Specials</a>
									<div class="row visible-md visible-lg">
										<div class="col-md-6 pad-top-10">
											<a href="http://hendersonkia.com"  target="_blank" ><img src="http://dealers.wdautos.com/dealer/henderson/images/icons/img_SeHablaEspanol3_off.png" alt="Spanish" ></a>
										</div>
										<div class="col-md-6 pad-top-10">
											<a href="http://hendersonkia.com/dealer/hendersonkia/finance_application.cfm"  target="_blank" ><img src="http://dealers.wdautos.com/dealer/henderson/images/icons/PreApproval70x70_off.png" alt="Financing" ></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
			
			<div class="col-md-6 pad-top-10">
				<div class="content">
					<div class="flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="flipper">
							<div class="front" style="align:center"> 
						      <img src="http://dealers.wdautos.com/dealer/henderson/images/icons/icon_Mazda.png"  alt="Mazda" >
							</div>
							<div class="back" style="align:center">
								<div style="font-size:22pt;color:##cc0000" style="align:center"><a href="http://mazdahenderson.com"  target="_blank" ><img src="http://dealers.wdautos.com/dealer/henderson/images/icons/logo_HendersonMazda3_off.png"  alt="Mazda" class="img-responsive" ></a>  
									(702) 551-7124<br>
									<a href="http://mazdahenderson.com/new/"  target="_blank" class="cta-button">Shop New Mazdas</a> <br>
									<a href="http://mazdahenderson.com/used/" target="_blank"  class="cta-button">Shop Used Vehicles</a> <br>
									<a href="http://mazdahenderson.com/new/special_offers.cfm"  target="_blank" class="cta-button">New Specials</a> <br>
									<a href="http://mazdahenderson.com/used/special_offers.cfm"  target="_blank" class="cta-button">Used Specials</a> <br>
									<div class="row visible-md visible-lg">
										<div class="col-md-6 pad-top-10">
											<a href="http://mazdahenderson.com"  target="_blank" ><img src="http://dealers.wdautos.com/dealer/henderson/images/icons/img_SeHablaEspanol3_off.png" alt="Spanish" ></a>
										</div>
										<div class="col-md-6 pad-top-10">
											<a href="http://mazdahenderson.com/dealer/hendersonmazda/finance_application.cfm"  target="_blank" ><img src="http://dealers.wdautos.com/dealer/henderson/images/icons/PreApproval70x70_off.png"  alt="Financing"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
			<div class="row pad-top-10">
				<p style="align:center"><!--- <a href="/new/" class="cta-button">Shop New</a> 
				<a href="/used/" class="cta-button">Shop Used</a> 
				<a href="/new/special_offers.cfm" class="cta-button">New Specials</a> 
				<a href="/used/special_offers.cfm" class="cta-button">Used Specials</a> 
				<a href="/dealer/baierl/tradein_marketplace.cfm" class="cta-button">Get Trade Value</a> 
				<a href="/forms/contact.cfm" class="cta-button">Contact Baierl</a> ---></p>
			</div>
	</div>
</section>

