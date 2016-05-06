<cfcomponent>

	<cffunction name="standard" description="shows standard states dropdown" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="input_class" default="">
		<cfargument name="state" default="">

		<select class="#arguments.input_class#" id="state" name="state">
			<option value="AL"  <cfif url.state eq "AL">selected="selected"</cfif>>Alabama</option>
			<option value="AK" <cfif url.state eq "AK">selected="selected"</cfif>>Alaska</option>
			<option value="AZ" <cfif url.state eq "AZ">selected="selected"</cfif>>Arizona</option>
			<option value="AR" <cfif url.state eq "AR">selected="selected"</cfif>>Arkansas</option>
			<option value="CA" <cfif url.state eq "CA">selected="selected"</cfif>>California</option>
			<option value="CO" <cfif url.state eq "CO">selected="selected"</cfif>>Colorado</option>
			<option value="CT" <cfif url.state eq "CT">selected="selected"</cfif>>Connecticut</option>
			<option value="DE" <cfif url.state eq "DE">selected="selected"</cfif>>Delaware</option>
			<option value="DC" <cfif url.state eq "DC">selected="selected"</cfif>>District of Columbia</option>
			<option value="FL" <cfif url.state eq "FL">selected="selected"</cfif>>Florida</option>
			<option value="GA" <cfif url.state eq "GA">selected="selected"</cfif>>Georgia</option>
			<option value="HI" <cfif url.state eq "HI">selected="selected"</cfif>>Hawaii</option>
			<option value="ID" <cfif url.state eq "ID">selected="selected"</cfif>>Idaho</option>
			<option value="IL" <cfif url.state eq "IL">selected="selected"</cfif>>Illinois</option>
			<option value="IN" <cfif url.state eq "IN">selected="selected"</cfif>>Indiana</option>
			<option value="IA" <cfif url.state eq "IA">selected="selected"</cfif>>Iowa</option>
			<option value="KS" <cfif url.state eq "KS">selected="selected"</cfif>>Kansas</option>
			<option value="KY" <cfif url.state eq "KY">selected="selected"</cfif>>Kentucky</option>
			<option value="LA" <cfif url.state eq "LA">selected="selected"</cfif>>Louisiana</option>
			<option value="ME" <cfif url.state eq "ME">selected="selected"</cfif>>Maine</option>
			<option value="MD" <cfif url.state eq "MD">selected="selected"</cfif>>Maryland</option>
			<option value="MA" <cfif url.state eq "MA">selected="selected"</cfif>>Massachusetts</option>
			<option value="MI" <cfif url.state eq "MI">selected="selected"</cfif>>Michigan</option>
			<option value="MN" <cfif url.state eq "MN">selected="selected"</cfif>>Minnesota</option>
			<option value="MS" <cfif url.state eq "MS">selected="selected"</cfif>>Mississippi</option>
			<option value="MO" <cfif url.state eq "MO">selected="selected"</cfif>>Missouri</option>
			<option value="MT" <cfif url.state eq "MT">selected="selected"</cfif>>Montana</option>
			<option value="NE" <cfif url.state eq "NE">selected="selected"</cfif>>Nebraska</option>
			<option value="NV" <cfif url.state eq "NV">selected="selected"</cfif>>Nevada</option>
			<option value="NH" <cfif url.state eq "NH">selected="selected"</cfif>>New Hampshire</option>
			<option value="NJ" <cfif url.state eq "NJ">selected="selected"</cfif>>New Jersey</option>
			<option value="NM" <cfif url.state eq "NM">selected="selected"</cfif>>New Mexico</option>
			<option value="NY" <cfif url.state eq "NY">selected="selected"</cfif>>New York</option>
			<option value="NC" <cfif url.state eq "NC">selected="selected"</cfif>>North Carolina</option>
			<option value="ND" <cfif url.state eq "ND">selected="selected"</cfif>>North Dakota</option>
			<option value="OH" <cfif url.state eq "OH">selected="selected"</cfif>>Ohio</option>
			<option value="OK" <cfif url.state eq "OK">selected="selected"</cfif>>Oklahoma</option>
			<option value="OR" <cfif url.state eq "OR">selected="selected"</cfif>>Oregon</option>
			<option value="PA" <cfif url.state eq "PA">selected="selected"</cfif>>Pennsylvania</option>
			<option value="RI" <cfif url.state eq "RI">selected="selected"</cfif>>Rhode Island</option>
			<option value="SC" <cfif url.state eq "SC">selected="selected"</cfif>>South Carolina</option>
			<option value="SD" <cfif url.state eq "SD">selected="selected"</cfif>>South Dakota</option>
			<option value="TN" <cfif url.state eq "TN">selected="selected"</cfif>>Tennessee</option>
			<option value="TX" <cfif url.state eq "TX">selected="selected"</cfif>>Texas</option>
			<option value="UT" <cfif url.state eq "UT">selected="selected"</cfif>>Utah</option>
			<option value="VT" <cfif url.state eq "VT">selected="selected"</cfif>>Vermont</option>
			<option value="VA" <cfif url.state eq "VA">selected="selected"</cfif>>Virginia</option>
			<option value="WA" <cfif url.state eq "WA">selected="selected"</cfif>>Washington</option>
			<option value="WV" <cfif url.state eq "WV">selected="selected"</cfif>>West Virginia</option>
			<option value="WI" <cfif url.state eq "WI">selected="selected"</cfif>>Wisconsin</option>
			<option value="WY" <cfif url.state eq "WY">selected="selected"</cfif>>Wyoming</option>
		</select>
	</cffunction>
</cfcomponent>

