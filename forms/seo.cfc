<cfcomponent>
	<cffunction name="launch_intake" access="public" returntype="void" output="yes">
		<!---<cfargument name="myArgument" type="string" required="yes">--->
<form class="form-vertical" action="/forms/seo_action.cfm" method="post">
  <div class="form-group">
    <label class="control-label col-md-2" for="web_url">Web Address : </label>
    <div class="col-md-10">
      <input name="web_url" class="form-control input-md" id="web_url" type="text" maxlength="50" placeholder="URL" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-2" for="name">Name : </label>
    <div class="col-md-10">
      <input name="name" class="form-control input-md" id="name" type="text" maxlength="50" placeholder="Name" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-2" for="email">Email : </label>
    <div class="col-md-10">
      <input name="email" class="form-control input-md" id="email" type="email" maxlength="50" placeholder="Email" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-2" for="phone">Phone : </label>
    <div class="col-md-10">
      <input name="phone" class="form-control input-md" id="phone" type="phone" maxlength="50" placeholder="Phone" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question1">Identify your primary market (PMA) </label>
    <div class="col-md-12">
      <textarea name="question1" class="form-control input-md" id="question1" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question2">Identify up to 5 additional markets, areas, cities, or towns </label>
    <div class="col-md-12">
      <textarea name="question2" class="form-control input-md" id="question2" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question3">Identify your 4 "core models" of vehicles that you sell </label>
    <div class="col-md-12">
      <textarea name="question3" class="form-control input-md" id="question3" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question4">Identify the age range, gender, or other characteristics of your ideal customers </label>
    <div class="col-md-12">
      <textarea name="question4" class="form-control input-md" id="question4" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question5">List the 10 most important keyword phrases you would like to rank for within your local market. This could include most popular models sold or requested and most frequent services performed in your service department. List in order of importance.  You may list more up to 20. </label>
    <div class="col-md-12">
      <textarea name="question5" class="form-control input-md" id="question5" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question6">What local businesses, events, charities or organizations do you sponsor or conduct business with on a regular basis throughout the year? </label>
    <div class="col-md-12">
      <textarea name="question6" class="form-control input-md" id="question6" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question7">Identify your top 3 competitors</label>
    <div class="col-md-12">
      <textarea name="question7" class="form-control input-md" id="question7" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question8">Briefly explain any mission statement or value propositions that you may already be known for in these markets (i.e. "Huge selection of used cars with warranties", "buy here, pay here",  "service after the sale with trained technicians", etc.) </label>
    <div class="col-md-12">
      <textarea name="question8" class="form-control input-md" id="question8" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question9">Identify local landmarks within a small radius of your dealership </label>
    <div class="col-md-12">
      <textarea name="question9" class="form-control input-md" id="question9" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question10">Identify local highways or popular roads leading to or near your dealership </label>
    <div class="col-md-12">
      <textarea name="question10" class="form-control input-md" id="question10" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question11">What do YOU believe to be the radius of your PMA? </label>
    <div class="col-md-12">
      <textarea name="question11" class="form-control input-md" id="question11" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question12">Identify any additional services or conveniences that your customers enjoy </label>
    <div class="col-md-12">
      <textarea name="question12" class="form-control input-md" id="question12" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question13">List the zipcodes that account for 80% of your business :  </label>
    <div class="col-md-12">
      <textarea name="question13" class="form-control input-md" id="question13" ></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-12" for="question14"><input type="checkbox" name="notbotbox" id="notbotbox" />I am not a bot! </label>    
  </div>  
  <div class="form-group" style="margin-top:20px">
    <label class="control-label col-md-3" for="submit"></label>
    <div class="col-md-3">
      <input type="submit" class="btn btn-primary" id="submit" value="Submit">
    </div>
  </div>
  <input type="hidden" name="imahuman" id="imahuman" value="0" />
</form>
<script>


	// Shorthand for $( document ).ready()
$(function() {
	setUpHumanTest();	
});
	// Set up	
	function setUpHumanTest() {
		$( "##notbotbox" ).click(function() {
		  markAsHuman();
		});
	}
	// Identify a human
	function markAsHuman() {
		document.getElementById("imahuman").value = "1";
	}
	
</script>
	</cffunction>
</cfcomponent>