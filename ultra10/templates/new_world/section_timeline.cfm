
<style type="text/css">
*, *:after, *:before {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

.cd-container {
  /* this class is used to give a max-width to the element it is applied to, and center it horizontally when it reaches that max-width */
  width: 90%;
  max-width: 1170px;
  margin: 0 auto;
  padding: 10px;
  font-size: 100%;
  font-family: Baskerville, "Palatino Linotype", Palatino, "Century Schoolbook L", "Times New Roman", serif;
  color: #7f8c97;
}
.cd-container::after {
  /* clearfix */
  content: '';
  display: table;
  clear: both;
}

#cd-timeline {
  position: relative;
  padding: 2em 0;
  margin-top: 2em;
  margin-bottom: 2em;
}
#cd-timeline::before {
  /* this is the vertical line */
  content: '';
  position: absolute;
  top: 0;
  left: 18px;
  height: 100%;
  width: 4px;
  background: #c4c4c4;
}
@media only screen and (min-width: 1170px) {
  #cd-timeline {
    margin-top: 3em;
    margin-bottom: 3em;
  }
  #cd-timeline::before {
    left: 50%;
    margin-left: -2px;
  }
}

.cd-timeline-block {
  position: relative;
  margin: 2em 0;
}
.cd-timeline-block:after {
  content: "";
  display: table;
  clear: both;
}
.cd-timeline-block:first-child {
  margin-top: 0;
}
.cd-timeline-block:last-child {
  margin-bottom: 0;
}
@media only screen and (min-width: 1170px) {
  .cd-timeline-block {
    margin: 4em 0;
  }
  .cd-timeline-block:first-child {
    margin-top: 0;
  }
  .cd-timeline-block:last-child {
    margin-bottom: 0;
  }
}

.cd-timeline-img {
  position: absolute;
  top: 0;
  left: 0;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  box-shadow: 0 0 0 4px white, inset 0 2px 0 rgba(0, 0, 0, 0.08), 0 3px 0 4px rgba(0, 0, 0, 0.05);
}
.cd-timeline-img img {
  display: block;
  width: 24px;
  height: 24px;
  position: relative;
  left: 50%;
  top: 50%;
  margin-left: -12px;
  margin-top: -12px;
}
.cd-timeline-img.cd-picture {
  background: #000000;
}

@media only screen and (min-width: 1170px) {
  .cd-timeline-img {
    width: 60px;
    height: 60px;
    left: 50%;
    margin-left: -30px;
    /* Force Hardware Acceleration in WebKit */
    -webkit-transform: translateZ(0);
    -webkit-backface-visibility: hidden;
  }
  .cssanimations .cd-timeline-img.is-hidden {
    visibility: hidden;
  }
  .cssanimations .cd-timeline-img.bounce-in {
    visibility: visible;
    -webkit-animation: cd-bounce-1 0.6s;
    -moz-animation: cd-bounce-1 0.6s;
    animation: cd-bounce-1 0.6s;
  }
}

@-webkit-keyframes cd-bounce-1 {
  0% {
    opacity: 0;
    -webkit-transform: scale(0.5);
  }

  60% {
    opacity: 1;
    -webkit-transform: scale(1.2);
  }

  100% {
    -webkit-transform: scale(1);
  }
}
@-moz-keyframes cd-bounce-1 {
  0% {
    opacity: 0;
    -moz-transform: scale(0.5);
  }

  60% {
    opacity: 1;
    -moz-transform: scale(1.2);
  }

  100% {
    -moz-transform: scale(1);
  }
}
@keyframes cd-bounce-1 {
  0% {
    opacity: 0;
    -webkit-transform: scale(0.5);
    -moz-transform: scale(0.5);
    -ms-transform: scale(0.5);
    -o-transform: scale(0.5);
    transform: scale(0.5);
  }

  60% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    -moz-transform: scale(1.2);
    -ms-transform: scale(1.2);
    -o-transform: scale(1.2);
    transform: scale(1.2);
  }

  100% {
    -webkit-transform: scale(1);
    -moz-transform: scale(1);
    -ms-transform: scale(1);
    -o-transform: scale(1);
    transform: scale(1);
  }
}
.cd-timeline-content {
  position: relative;
  margin-left: 70px;
  background: #ffffff;
  border-radius: 10px;
  padding: 5px;
  border: 1px solid #C3C3C3;
  box-shadow: 0 3px 0 #d7e4ed;
  font-family: Helvetica, Arial, sans-serif;
}
.cd-timeline-content:after {
  content: "";
  display: table;
  clear: both;
}
.cd-timeline-content h2 {
  color: #303e49;
  font-family:Baskerville, "Palatino Linotype", Palatino, "Century Schoolbook L", "Times New Roman", serif;
 
}
.cd-timeline-content p, .cd-timeline-content .cd-read-more, .cd-timeline-content {
  font-size: 13px;
}

.cd-date {
  font-size: 20px;
  font-weight:900;
  color: #000000;
}

.cd-timeline-content .cd-read-more, .cd-timeline-content .cd-date {
  display: inline-block;
}
.cd-timeline-content p {
  margin: 1em 0;
  line-height: 1.6;
}
.cd-timeline-content .cd-read-more {
  float: right;
  padding: .8em 1em;
  background: #acb7c0;
  color: white;
  border-radius: 0.25em;
}
.no-touch .cd-timeline-content .cd-read-more:hover {
  background-color: #bac4cb;
}
.cd-timeline-content .cd-date {
  float: left;
  padding: .8em 0;
  opacity: .7;
}
.cd-timeline-content::before {
  content: '';
  position: absolute;
  top: 16px;
  right: 100%;
  height: 0;
  width: 0;
  border: 7px solid transparent;
  border-right: 7px solid #c4c4c4;
  
}
@media only screen and (min-width: 768px) {
  .cd-timeline-content h2 {
    font-size: 20px;
    font-size: 1.25rem;
  }
  .cd-timeline-content p {
    font-size: 16px;
    font-size: 1rem;
  }
  .cd-timeline-content .cd-read-more, .cd-timeline-content {
    font-size: 14px;
    font-size: 0.875rem;
  }
  
  .cd-date {
  font-size: 20px;
  font-weight:900;
  color: #000000;
}
}
@media only screen and (min-width: 1170px) {
  .cd-timeline-content {
    margin-left: 0;
    padding: 1.6em;
    width: 45%;
  }
  .cd-timeline-content::before {
    top: 24px;
    left: 100%;
    border-color: transparent;
    border-left-color: #c4c4c4;
  }
  .cd-timeline-content .cd-read-more {
    float: left;
  }
  .cd-timeline-content .cd-date {
    position: absolute;
    width: 100%;
    left: 122%;
    top: 6px;
    font-size: 20px;
	font-weight:900;

  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content {
    float: right;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content::before {
    top: 24px;
    left: auto;
    right: 100%;
    border-color: transparent;
    border-right-color: #c4c4c4;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content .cd-read-more {
    float: right;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content .cd-date {
    left: auto;
    right: 122%;
    text-align: right;
  }
  .cssanimations .cd-timeline-content.is-hidden {
    visibility: hidden;
  }
  .cssanimations .cd-timeline-content.bounce-in {
    visibility: visible;
    -webkit-animation: cd-bounce-2 0.6s;
    -moz-animation: cd-bounce-2 0.6s;
    animation: cd-bounce-2 0.6s;
  }
}

@media only screen and (min-width: 1170px) {
  /* inverse bounce effect on even content blocks */
  .cssanimations .cd-timeline-block:nth-child(even) .cd-timeline-content.bounce-in {
    -webkit-animation: cd-bounce-2-inverse 0.6s;
    -moz-animation: cd-bounce-2-inverse 0.6s;
    animation: cd-bounce-2-inverse 0.6s;
  }
}
@-webkit-keyframes cd-bounce-2 {
  0% {
    opacity: 0;
    -webkit-transform: translateX(-100px);
  }

  60% {
    opacity: 1;
    -webkit-transform: translateX(20px);
  }

  100% {
    -webkit-transform: translateX(0);
  }
}
@-moz-keyframes cd-bounce-2 {
  0% {
    opacity: 0;
    -moz-transform: translateX(-100px);
  }

  60% {
    opacity: 1;
    -moz-transform: translateX(20px);
  }

  100% {
    -moz-transform: translateX(0);
  }
}
@keyframes cd-bounce-2 {
  0% {
    opacity: 0;
    -webkit-transform: translateX(-100px);
    -moz-transform: translateX(-100px);
    -ms-transform: translateX(-100px);
    -o-transform: translateX(-100px);
    transform: translateX(-100px);
  }

  60% {
    opacity: 1;
    -webkit-transform: translateX(20px);
    -moz-transform: translateX(20px);
    -ms-transform: translateX(20px);
    -o-transform: translateX(20px);
    transform: translateX(20px);
  }

  100% {
    -webkit-transform: translateX(0);
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -o-transform: translateX(0);
    transform: translateX(0);
  }
}
@-webkit-keyframes cd-bounce-2-inverse {
  0% {
    opacity: 0;
    -webkit-transform: translateX(100px);
  }

  60% {
    opacity: 1;
    -webkit-transform: translateX(-20px);
  }

  100% {
    -webkit-transform: translateX(0);
  }
}
@-moz-keyframes cd-bounce-2-inverse {
  0% {
    opacity: 0;
    -moz-transform: translateX(100px);
  }

  60% {
    opacity: 1;
    -moz-transform: translateX(-20px);
  }

  100% {
    -moz-transform: translateX(0);
  }
}
@keyframes cd-bounce-2-inverse {
  0% {
    opacity: 0;
    -webkit-transform: translateX(100px);
    -moz-transform: translateX(100px);
    -ms-transform: translateX(100px);
    -o-transform: translateX(100px);
    transform: translateX(100px);
  }

  60% {
    opacity: 1;
    -webkit-transform: translateX(-20px);
    -moz-transform: translateX(-20px);
    -ms-transform: translateX(-20px);
    -o-transform: translateX(-20px);
    transform: translateX(-20px);
  }

  100% {
    -webkit-transform: translateX(0);
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -o-transform: translateX(0);
    transform: translateX(0);
  }
}
</style>

<cfoutput>
	<section class="section-portal">
		<div class="container pad-top-5  visible-sm visible-xs  visible-lg visible-md">
			<div class="row"><div class="col-md-12 pad-top-10  visible-sm visible-xs visible-lg visible-md">
						
	
					<section id="cd-timeline" class="cd-container">
						<div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
				            
								<img style="max-width: 210px; padding:10px;" alt="" src="http://66.179.17.10/templates/dlr/images/0046-0000-999-01-0000000000/ad/orig_dealership.jpg" style="align:left" border="0" hspace="20" vspace="20">
								<h2>1932</h2>
								<p>Henry Faulkner, Inc. opens as an Oldsmobile dealership in Philadelphia, PA</p>
				
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				
						<div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
				            				<h2>1974</h2>
								<p>Faulkner BMW opens in Lancaster, PA.</p>
				
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				
						<div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1978</h2>
								<p>Faulkner Chevrolet and Cadillac open in Bethlehem, PA</p>
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				
						<div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1981</h2>
								<p>Faulkner Mazda opens in Bethlehem, PA</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				
						<div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1985</h2>
								<p>Faulkner opens three Buick GMC locations (West Chester, Trevose and Harrisburg), as well as a Subaru location in Bethlehem, PA</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				
						<div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1988</h2>
								<p>Faulkner expands their brand offerings by adding Honda in Harrisburg, PA, and Toyota/Scion in Trevose, PA.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				        <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1989</h2>
								<p>Faulkner Faulkner adds another Chevrolet dealership to serve the Lancaster, PA area.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				        <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1990</h2>
								<p>Faulkner Faulkner opens their first Nissan dealership in Harrisburg, PA.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				        <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1997</h2>
								<p>Faulkner adds another Toyota/Scion dealership in Harrsiburg, PA.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				        <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>1998</h2>
								<p>Faulkner's second Subaru and Mazda dealerships open in Harrisburg, PA.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				        <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>2009</h2>
								<p>Faulkner adds to the family by opening a Nissan dealership in Jenkintown, PA and a Hyundai dealership in Harrisburg.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				        <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>2011</h2>
								<p>Faulkner expands again to include another Hyundai location (Philadelphia) and a FIAT dealership in Harrisburg.</p>
				
							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
				        
				                <div class="cd-timeline-block">
							<div class="cd-timeline-img cd-picture">
								<img src="http://dealers.wdautos.com/dealer/faulknertobesure/images/library/Icon_FaulknerF.png" alt="Faulkner To Be Sure">
							</div> <!-- cd-timeline-img -->
				
							<div class="cd-timeline-content">
								<h2>2014</h2>
								<p>Faulkner adds Maserati dealership in Mechanicsburg to their lineup.</p>

							</div> <!-- cd-timeline-content -->
						</div> <!-- cd-timeline-block -->
					</section> <!-- cd-timeline -->

				
				
				</div>  <!--- End Row --->
			</div>  <!--- end container --->
			
		<div class="clearfix"></div>
		</div>	
	</section>
	 

</cfoutput>


						