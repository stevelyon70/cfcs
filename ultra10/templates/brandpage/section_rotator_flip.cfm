
<style type="text/css">
.cta-button {
	-moz-box-shadow:inset 0px 1px 0px 0px #cb0101;							/*  DB Feed */
	-webkit-box-shadow:inset 0px 1px 0px 0px #cb0101;							/*  DB Feed */
	box-shadow:inset 0px 1px 0px 0px #cb0101;							/*  DB Feed */
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #cb0101), color-stop(1, #cb0101) );							/*  DB Feed */
	background:-moz-linear-gradient( center top, #cb0101 5%, #cb0101 100% );							/*  DB Feed */
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#cb0101', endColorstr='#cb0101');							/*  DB Feed */
	background-color:#cb0101;							/*  DB Feed */
	-webkit-radius:10px;
	-moz-border-radius:10px;
	border-radius:10px;
	text-indent:0;
	border:1px solid #cb0101;
	display:inline-block;
	color:#ffffff;							/*  DB Feed */
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	font-style:normal;
	height:30px;
	line-height:30px;
	width:80%;					/* was 150px */ 
	text-decoration:none;
	text-align:center;
	text-shadow:1px 1px 0px #cb0101;
	margin: 2px;
	margin-left: 30px;
}
.cta-button:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #cb0101), color-stop(1, #cb0101) );							/*  DB Feed */
	background:-moz-linear-gradient( center top, #cb0101 5%, #cb0101 100% );							/*  DB Feed */
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#cb0101', endColorstr='#cb0101');							/*  DB Feed */
	background-color:#cb0101;
	color:#ffffff;							/*  DB Feed */
}.cta-button:active {
	position:relative;
	top:1px;
	color:#ffffff;							/*  DB Feed */
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
			max-width: 300px;    /* Panel width   */								/*  DB Feed */
			height: 150px;    /* Panel Height   */							/*  DB Feed */
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

		.front, .back {
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
			background: #cccccc;							/*  DB Feed */
			
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
			color: #cb0101;							/*  DB Feed */
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
			color: #cb0101;							/*  DB Feed */
			position: absolute;
			top: 180px;
			left: 0;
			right: 0;
			text-align: center;
			text-shadow: 0.1em 0.1em 0.05em #acd7e5;
			font-family: Courier;
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



<cfoutput>
<cfquery name="get_flippers" datasource="Ultra10" >
	SELECT	ID, dealer_id, front_image, front_image_alt, panel_width, panel_height, 
			back_bg_color, back_title, back_title_color, 
			cta_btn_background, cta_btn_text_color, 
			button1_text, button1_link, button1_target, 
			button2_text, button2_link, button2_target, 
			button3_text, button3_link, button3_target, 
			button4_text, button4_link, button4_target, 
			hierarchy, active
	FROM    Variable_Template_Flipcard
	WHERE	dealer_id	=	#URL.dealer_id#
</cfquery>




<section class="section-landing-pg">
	<div class="container">
			
		<div class="row">
			<div class="col-md-12 pad-top-10 pad-bottom-10" style="align:center">
				<span style="color:##00000;font-size:12pt">Roll over or swipe for options</span> 
			</div>
		</div>
		
		
		
		<div class="row">
		
		<cfloop query="get_flippers" >

		

			<div class="col-md-4">
				<div class="content">
					<div class="flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="flipper">
							<div class="front" style="align:center">
								<!--- <div class="vertical-text">Click to View Options!</div>  --->
						         <img src="http://dealers.wdautos.com/dealer/#arguments.assets#/images/icons/#get_flippers.front_image#" alt="#get_flippers.front_image_alt#" class="img-responsive"> 
							</div>
							<div class="back" style="align:center">
								<div style="font-size:28px;align:center"><cfif #get_flippers.back_title# NEQ "" >#get_flippers.back_title#<br></cfif>
									<cfif #get_flippers.button1_text# NEQ "" >
										<a href="#get_flippers.button1_link#" class="cta-button">#get_flippers.button1_text#</a> <br>
									</cfif>
									<cfif #get_flippers.button2_text# NEQ "" >
										<a href="#get_flippers.button2_link#" class="cta-button">#get_flippers.button2_text#</a> <br>
									</cfif>
									<cfif #get_flippers.button3_text# NEQ "" >
										<a href="#get_flippers.button3_link#" class="cta-button">#get_flippers.button3_text#</a> <br>
									</cfif>
									<cfif #get_flippers.button4_text# NEQ "" >
										<a href="#get_flippers.button4_link#" class="cta-button">#get_flippers.button4_text#</a> 
									</cfif>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
			
			
		</cfloop>
		</div>
			
		<div class="row pad-top-10">
			<p style="align:center">&nbsp;</p>
		</div>
	</div>
</section>



</cfoutput>
