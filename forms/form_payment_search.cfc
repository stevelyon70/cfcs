<cfcomponent>

	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	
	<cfoutput>
			<!--- Set Defaults --->
			<cfquery datasource="ultra10" name="Get_APR">
				SELECT	ID, dealer_id, APR, default_apr, hierarchy, active
				FROM    Dealer_Loan_APR
				WHERE 	dealer_id = #url.dealer_id#
				AND 	active = 1
				AND 	default_apr = 1
			</cfquery>
		<cfset dflt_apr = 0>
		<cfloop query="Get_APR"><cfif #Get_APR.default_apr# EQ 1><cfset dflt_apr = #Get_APR.APR#></cfif></cfloop>
			<cfquery datasource="ultra10" name="Get_Term">
				SELECT	ID, dealer_id, loan_term, default_term, hierarchy, active
				FROM    Dealer_Loan_Terms
				WHERE 	dealer_id =  #url.dealer_id#
				AND 	active = 1
				AND		default_term = 1
			</cfquery>
		<cfset dflt_term = 0>
		<cfloop query="Get_Term"><cfif #Get_Term.default_term# EQ 1><cfset dflt_term = #Get_Term.loan_term#></cfif></cfloop>
	</cfoutput>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script>
	    CARS = window.CARS || {};
	    var asyncAd = true;
		
	var preloadRateParam = "";			
	var vpLoanParam = "0";			
	
	if (vpLoanParam == "" || vpLoanParam == "null" || isNaN(vpLoanParam))
		{
			vpLoanParam = "";  // Use vp if vpLoan doesn't exist in URL
		}
	var dpLoanParam = "0";
	var tvLoanParam = "0";
	var stLoanParam = "0";
	var rateLoanParam = "<cfoutput>#dflt_apr#</cfoutput>";
	var termLoanParam = "<cfoutput>#dflt_term#</cfoutput>";
	var mpLoanParam = "";
	var tcLoanParam = "0";
	var micrositeParam=false;
	
	var RATE_USED = <cfoutput>#dflt_apr#</cfoutput>;
	var RATE_NEW = 3.01;
	// Do affordability or "reverse" calculation of affordability=yes
	var affordabilityParam = "yes";
	var modeParam = "full";
	var newCars = "no";
	//-->
	var gInclude = false;
				
	
	function remExtraDecPlaces(numStr, newDecPlaces, addTrailingZerosFlag) {
	  return setDecPlaces(numStr, newDecPlaces, addTrailingZerosFlag);
	}
	
	// Returns a value equal to numStr with newDecPlaces decimals at most.  Adds trailing zeros if flag is set to true
	function setDecPlaces(numStr, newDecPlaces, addTrailingZerosFlag) {
	
	  numStr = numStr.toString(); // make sure numStr is a string
	  var decIndex = numStr.indexOf('.');
	  var decPlaces = 0;
	  if (decIndex != -1) {
	    decPlaces = numStr.length - decIndex - 1;
	  }
	  
	  if (newDecPlaces == 0 && decIndex != -1) {
	    numStr = numStr.substring(0, decIndex); // strip decimal point
	  } else if (decPlaces > newDecPlaces) {
	    numStr = numStr.substring(0, (decIndex + newDecPlaces + 1)); // remove decimal places
	  } else if (decPlaces < newDecPlaces && addTrailingZerosFlag) { // add trailing zeros if necessary
	    if (decIndex == -1) {
	      numStr = numStr + "."; // add a decimal point if there isn't one
	    }
	    for (; decPlaces < newDecPlaces; decPlaces++) { // add enough zeros such that decPlaces = newDecPlaces
	      numStr = numStr + "0";
	    }
	  }
	
	  return NaNToZero(numStr);
	}
	
	// Returns a string value of "0" if the argument is not a number or empty
	function NaNToZero(value) {
	  if (value == null || value == "" || isNaN(value)) {
	    return "0";
	  } else {
	    return value;
	  }
	}
	
	function fillZeros(theForm) {
	  var e;
	  for (var i = 0; i < theForm.elements.length - 1; i++) {
	    e = theForm.elements[i];
	    // modify hidden or text fields that are empty
	    if ((e.value == null || e.value == "") &&
	        (e.type == "text" || e.type == "hidden")) {
	      theForm.elements[i].value = 0;
	    }
	  }
	}
	
	// Use this test string (which should clean up to 123.45678901):  
	function cleanUpField(field) {
	  stripIllegalChars(field);
	  switch (field.name) { // strip decimals
	    // no decimals
	    case "vpLoan":  case "dpLoan":  case "tvLoan":  case "termLoan":
	    case "vpLease": case "dpLease": case "tvLease": case "termLease": case "rvLease":
	    case "cb_vprice":  case "cb_downpayment":  case "cb_tradein":  case "cb_rebate":  case "cb_term":
	    case "lif_vprice": case "lif_downpayment": case "lif_tradein": case "lif_rebate": case "lif_term":
	      field.value = setDecPlaces(field.value.toString(), 0);
	      break;
	    // 2 dec places
	    case "mpLoan": case "mpLease":
	      field.value = setDecPlaces(field.value.toString(), 2);
	      break;
	    // 3 dec places
	    case "rateLoan": case "stPerLoan": case "stPerLease": case "cb_tax": case "lif_tax": case "cb_apr": case "lif_apr":
	      field.value = setDecPlaces(field.value.toString(), 3);
	      break;
	    // 6 dec places
	    case "rateLease":
	      field.value = setDecPlaces(field.value.toString(), 6);
	      break;
	  }
	}
	
	function stripIllegalChars(field) {
	//  alert(field.value + " " + field.name);
	  var regExp = /[^0123456789.]+/;
	  var val = field.value;
	  while (val.match(regExp)) val = val.replace(regExp, ""); // remove all non-numbers (keep decimals)
	  val = NaNToZero(val); // set blank fields to zero
	  field.value = val;
	}
	
	/*
	  Checks _field_ for errors. The type of error check is determined by _name_. x, y & z hold other necessary values
	  Originally intended to be used with all calculators. It allows different pages to access the same error functionality
	  even if they use different field names
	*/
	function checkError (field, name, x, y, z) {
	  var errorFlag = false;
	  // Set flag if the field name begins with "cb" or "lif"
	  var incentivesFlag = (field.name.indexOf("cb") == 0 || field.name.indexOf("lif") == 0) ? true : false;
	
	  switch (name) {
	
	    case "vp": // Vehicle Price
	      var vp = parseFloat(field.value);
	      var dp = parseFloat(x);
	      var tv = parseFloat(y);
	      var rebate = parseFloat(NaNToZero(z)); // sometimes no rebate is passed
	      if ( (vp < dp + tv + rebate) || (vp > 500000) ) {
	        errorFlag = true;
	        if (incentivesFlag) { // display rebate msg for incentives calc only
	          alert("Vehicle Price must be greater than Down Payment + Trade-In Value + Rebate and less than $500,000.");
	        } else {
	          alert("Vehicle Price must be greater than Down Payment + Trade-In Value and less than $500,000.");
	        }
	      }
	    break;
	
	    case "dp": // Down Payment
	      var dp = parseFloat(field.value);
	      var vp = parseFloat(x);
	      var tv = parseFloat(y);
	      var rebate = parseFloat(NaNToZero(z)); // sometimes no rebate is passed
	      if (vp < dp + tv + rebate) {
	        errorFlag = true;
	        if (incentivesFlag) { // display rebate msg for incentives calc only
	          alert("Trade-In Value + Down Payment + Rebate must be less than Vehicle Price.");
	        } else {
	          alert("Trade-In Value + Down Payment must be less than Vehicle Price x.");
	        }
	      }
	    break;
	      
	    case "tv": // Trade-In Value
	      var tv = parseFloat(field.value);
	      var vp = parseFloat(x);
	      var dp = parseFloat(y);
	      var rebate = parseFloat(NaNToZero(z)); // sometimes no rebate is passed
	      if (vp < dp + tv + rebate) {
	        errorFlag = true;
	        if (incentivesFlag) { // display rebate msg for incentives calc only
	          alert("Trade-In Value + Down Payment + Rebate must be less than Vehicle Price.");
	        } else {
	          alert("Trade-In Value + Down Payment must be less than Vehicle Price y.");
	        }
	      }
	    break;
	
	    case "stPer": // Sales Tax
	      if (parseFloat(field.value) < 0 || parseFloat(field.value) > 100) {
	        errorFlag = true;
	        alert("Sales Tax must be between 0 and 100.");
	      }
	    break;
	      
	    case "rebate": // Rebate
	      var rebate = parseFloat(field.value);
	      var vp = parseFloat(x);
	      var dp = parseFloat(y);
	      var tv = parseFloat(z);
	      if (vp < dp + tv + rebate) {
	        errorFlag = true;
	        alert("Trade-In Value + Down Payment + Rebate must be less than Vehicle Price.");
	      }
	      break;
	
	    case "rate":
	      if (parseFloat(field.value) < 0 || parseFloat(field.value) > 50) {
	        errorFlag = true;
	        alert("Interest Rate must be between 0 and 50.");
	      }
	    break; 
	    case "term":
	      if (parseFloat(field.value) < 6 || parseFloat(field.value) > 96) {
	        errorFlag = true;
	        alert("Term of loan must be between 6 and 96." );
	      }
	    break;
	  }
	  
	  if (errorFlag) {
	  // Put cursor in field and highlight. Delay so that 2 fields aren't highlighted on tab
	    var calcForm;
	    if (document.LoanLeaseResultForm) calcForm = "document.LoanLeaseResultForm)";
	    else calcForm = "document.calculator";
	    setTimeout(calcForm + "." + field.name + ".select()", 10);
	    setTimeout(calcForm + "." + field.name + ".focus()", 10);
	    return true;
	  } else {
	    return false;
	  }
	}
	
				
	var preloadRate = preloadRateParam;
	// vehicle price (range:  dp + tv  to 500,000)
	console.log(vpLoanParam);
	var var_vpLoan = NaNToZero(vpLoanParam);
	var var_vpLoanDefault = "0"
	var var_vpLoanMin = "0"
	var var_vpLoanMax = "500000"
	var var_vpLoanErrMsg = "Vehicle Price must be greater than Down Payment + Trade-In Value and less than $500,000."
	var var_vpLoanDecPlaces = 0
	// down payment (range:  0 to vp - tv )
	var var_dpLoan = NaNToZero(dpLoanParam)
	var var_dpLoanDefault = "0"
	var var_dpLoanMin = "0"
	var var_dpLoanMax = var_vpLoan
	var var_dpLoanErrMsg = "Trade-In Value + Down Payment must be less than Vehicle Price a."
	var var_dpLoanDecPlaces = 0
	// trade-in value (range:  0 to vp - dp)
	var var_tvLoan = NaNToZero(tvLoanParam)
	var var_tvLoanDefault = "0"
	var var_tvLoanMin = "0"
	var var_tvLoanMax = var_vpLoan
	var var_tvLoanErrMsg = "Trade-In Value + Down Payment must be less than Vehicle Price."
	var var_tvLoanDecPlaces = 0
	// Sales Tax (range:  0 to 100)
	var var_stPerLoan = NaNToZero(stLoanParam)
	var var_stPerLoanDefault = "0"
	var var_stPerLoanMin = "0"
	var var_stPerLoanMax = "100"
	var var_stPerLoanErrMsg = "Sales Tax must be between 0 and 100."
	var var_stPerLoanDecPlaces = 3
	// sales tax ($) (range:  0 to (vp * stPer / 100))
	var var_stDolLoan = "0"
	var var_stDolLoanDefault = "0"
	var var_stDolLoanMin = "0"
	var var_stDolLoanMax = ""
	var var_stDolLoanErrMsg = "Sales tax ($) must be less than 100% equivalent Sales Tax."
	var var_stDolLoanDecPlaces = 3
	// rate (interest) (range:  0 to 50)
	var var_rateLoan = RATE_USED // default value
	var var_rateLoanDefault = RATE_USED
	if (preloadRate == "new") var_rateLoan = RATE_NEW; // override default
	if (rateLoanParam != "" && !isNaN(rateLoanParam) ) var_rateLoan = rateLoanParam; // override either default rate
	if( (var_rateLoan == "") || isNaN(var_rateLoan) || var_rateLoan.toString() == "0") var_rateLoan = var_rateLoanDefault;
	else var_rateLoanDefault = var_rateLoan;
	var var_rateLoanMin = "0"
	var var_rateLoanMax = "50"
	var var_rateLoanErrMsg = "Interest Rate must be between 0 and 50."
	var var_rateLoanDecPlaces = 3
	// term (range: 6 to 96)
	var var_termLoan = "<cfoutput>#dflt_term#</cfoutput>" // default value
	if (preloadRate != "new") var_termLoan = "36"; // overrides first value
	if (termLoanParam != "" && !isNaN(termLoanParam)) var_termLoan = termLoanParam; // override either default term
	var var_termLoanDefault = "<cfoutput>#dflt_term#</cfoutput>"
	if (var_termLoan == "0") var_termLoan = var_termLoanDefault;
	var var_termLoanMin = "6"
	var var_termLoanMax = "96"
	var var_termLoanErrMsg = "Term of loan must be between 6 and 96."
	var var_termLoanDecPlaces = 0
	// monthly payment (range:  0 to 2000)
	var var_mpLoan = NaNToZero(mpLoanParam);
	var var_mpLoanDefault = "0"
	var var_mpLoanMin = "0"
	var var_mpLoanMax = "5000"
	var var_mpLoanErrMsg = "Monthly payment must be between 0 and $5,000."
	var var_mpLoanDecPlaces = 2
	// amount financed
	var var_afLoan = "0"
	var var_afLoanDefault = "0"
	var var_afLoanDecPlaces = 2
	// total spent
	var var_tsLoan = "0"
	var var_tsLoanDefault = "0"
	var var_tsLoanDecPlaces = 0 // changed from 2
	// comparible cost to own
	var var_cctoLoan = "0"
	var var_cctoLoanDefault = "0"
	var var_cctoLoanDecPlaces = 2
	
	if(!micrositeParam) var micrositeParam=false;
	
	// Used for field validation.
	var dirtyField = true
	var validating = false
	
	// New Search by Affordability Maximum Price...default is empty to allow for searches without calc interaction
	var maxp = "";
	
	function initCalc() {
	  // Initialize loan calculator input.
	  with (document.calculator) {
	    // Initialize loan calculator input and default values.
	    // Default values need to be set in case of toolbar hiding or reloads.
	    vpLoan.value = var_vpLoan;
	    dpLoan.value = var_dpLoan;
	    tvLoan.value = var_tvLoan;
	    stPerLoan.value = var_stPerLoan;
	    rateLoan.value = var_rateLoan;
	    termLoan.value = var_termLoan;
	    mpLoan.value = var_mpLoan;
	    document.getElementById("tsLoanDiv").innerHTML = var_tsLoan;
	    
	    
	    // New Search by Affordability
	    if (affordabilityParam == "yes" && mpLoan.value != 0) {
	      // Set focus and select first input field.
	      validateField(mpLoan);
	      mpLoan.select()
	      mpLoan.focus()
	    // End New Search by Affordability
	    } else {
	      validateField(vpLoan);
	      vpLoan.select();
	      vpLoan.focus();
	    }
	  }
	}
	
	//=================================================
	function validRange(field)
	{
	  var strMin = "Min"
	  var strMax = "Max"
	  var tempName = "var_" + field.name
	  var fieldMin = eval(tempName + "Min")
	  var fieldMax = eval(tempName + "Max")
	  var tempErrMsg = eval(tempName + "ErrMsg")
	  
	  if (parseFloat(field.value) < parseFloat(fieldMin) || parseFloat(field.value) > parseFloat(fieldMax))
	  {
	    return false
	  }
	  else
	  {
	    return true
	  }
	}
	
	function validateField(field)
	{
	   cleanUpField(field);
	   var numErrFlag = false
	   var rangeErrFlag = false
	   var fieldErrMsg = eval("var_" + field.name + "ErrMsg")
	   var tempField = 'var_' + field.name
	
	   if (field.value == "") field.value = 0;
	   
	   if (!isNumeric(field))
	   {
	//      alert('validateField: not numeric')
	      alert(fieldErrMsg)
	      field.value = eval("var_" + field.name)
	      field.select()
	      field.focus()
	   }
	   else
	   {
	      if(!validRange(field))
	      {
	//       alert('validateField: not in range')
	         alert(fieldErrMsg)
	         field.value = eval("var_" + field.name)
	         field.select()
	         field.focus()
	      }
	      else
	         {
	            // Input is valid...now set any related fields for future validation.
	            eval(tempField = field.value)
	            field.defaultValue = field.value
	            recalculate(field)
				
	            if(gInclude && gInclude == true)
	            {
	              showChartIframe();
	            }
	
	            /*if ( ((field.name == "mpLoan") || (field.name == "vpLoan")) && 
	                 (typeof CARS.adProducts.CalculatorSponsorship.checkAdPriceRange == "function") ) {
	              CARS.adProducts.CalculatorSponsorship.checkAdPriceRange();
	            }  */    
	      
	       }
	   }
	}
	
	
	
	    //=================================================
	function changedField()
	{
	   dirtyField = "true"
	}
	
	function recalculate(field)
	{
	   // Recalculate fields.
	
	   // LOAN:  change in top input fields
	   if (field.name == "vpLoan" || field.name == "dpLoan" || field.name == "tvLoan" || field.name == "stPerLoan" || field.name == "rateLoan" || field.name == "termLoan" || field.name == "stDolLoan" || field.name == "mpLoan")
	   {
	      // Recalc. mp, stDol, af, ts, and ccto.
	
	      var_dpLoan = document.calculator.dpLoan.value
	      var_tvLoan = document.calculator.tvLoan.value
	      var_rateLoan = document.calculator.rateLoan.value
	      var_termLoan = document.calculator.termLoan.value
	      
	      eval ("var_" + field.name + " = field.value");
	      
	      if (field.name == "mpLoan" || (field.name != "vpLoan" && affordabilityParam == "yes")) {
	        // Calculate VP from MP
	        if (var_rateLoan == 0) { // Avoid divide-by-zero when IR = 0%
	          var_vpLoan = var_mpLoan * var_termLoan;
	        } else {
	          var tempRate = eval(var_rateLoan / 1200);
	          var tempMpDenom = 1 - Math.pow(eval(1 + parseFloat(tempRate)), eval(-1 * var_termLoan));
	          var_vpLoan = eval(parseFloat(var_mpLoan) * tempMpDenom / tempRate).toString();
	        }
	          var_vpLoan = eval(eval(parseFloat(var_vpLoan) + parseFloat(var_dpLoan) + parseFloat(var_tvLoan)) /
	                       ( 1 + ( var_stPerLoan / 100 ) ) ).toString();
	      }
	
	      var_stDolLoan = eval(var_vpLoan * var_stPerLoan/100).toString()
	
	      // Calculate new fields for output.
	      var_afLoan = eval(parseFloat(var_stDolLoan) + (parseFloat(var_vpLoan) - parseFloat(var_dpLoan) -
	                        parseFloat(var_tvLoan))).toString()
	//      if (field.name != "mpLoan")
	      if (field.name == "vpLoan" || (field.name != "mpLoan" && affordabilityParam != "yes"))
	      {
	         // Calculate MP from VP
	         if (var_rateLoan == 0) { // Avoid divide-by-zero when IR = 0%
	           var_mpLoan = eval(parseFloat(var_afLoan) / parseFloat(var_termLoan));
	         } else {
	          var tempRate = eval(var_rateLoan / 1200).toString();
	          var tempMpDenom = 1 - Math.pow(eval(1 + parseFloat(tempRate)), eval(-1 * var_termLoan));
	          var_mpLoan = eval(parseFloat(var_afLoan) * parseFloat(tempRate) / tempMpDenom).toString();
	         }
	      }
	      var_tsLoan = eval((parseFloat(var_mpLoan) * parseFloat(var_termLoan)) + parseFloat(var_dpLoan) + parseFloat(var_tvLoan)).toString()
	      var_cctoLoan = var_tsLoan
	
	      var_vpLoan = setDecPlaces(var_vpLoan, 0)
	      var_dpLoan = setDecPlaces(var_dpLoan, 0)
	      var_tvLoan = setDecPlaces(var_tvLoan, 0)
	      var_stPerLoan = setDecPlaces(var_stPerLoan, 3)
	      var_stDolLoan = setDecPlaces(var_stDolLoan, 3)
	      var_mpLoan = setDecPlaces(var_mpLoan, 2, true)
	      var_afLoan = setDecPlaces(var_afLoan, 2)
	      var_tsLoan = setDecPlaces(var_tsLoan, 0)
	      var_cctoLoan = setDecPlaces(var_cctoLoan, 2)
	  
	      // Place new values in Loan fields.
	      with (document.calculator) {
	         vpLoan.value = var_vpLoan
			 vpLoan.value = '$' + vpLoan.value
			// console.log(var_vpLoan)
	         dpLoan.value = var_dpLoan
	         stPerLoan.value = var_stPerLoan
	         rateLoan.value = var_rateLoan
	         termLoan.value = var_termLoan
	         mpLoan.value = var_mpLoan
	         document.getElementById('tsLoanDiv').innerHTML = var_tsLoan;
	        // New Search by Affordability: hide from NewCars as they don't have the Search widget
	        // Display Vehicle Price above Search widget and set form variable
			if ((modeParam=="full") && (newCars == "no")) {
				if (var_vpLoan != 0) {
					/*document.newForm.maxp.value = var_vpLoan;
					document.usedForm.maxp.value = var_vpLoan;*/
					function formatCurrency(num) {
						num = num.toString().replace(/\$|\,/g,'');
						num = Math.floor(num).toString();
						for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
						num = num.substring(0,num.length-(4*i+3))+','+
						num.substring(num.length-(4*i+3));
						return ('$' + num);
						}
					var var_vpLoanDisplay = formatCurrency(var_vpLoan);
					/*document.getElementById('affordSearchDiv').innerHTML = ' priced up to ';
					document.getElementById('affordSearchDivPrice').innerHTML = var_vpLoanDisplay;*/
				} else {
					/*document.newForm.maxp.value = '';
					document.usedForm.maxp.value = '';
					document.getElementById('affordSearchDiv').innerHTML = '';
					document.getElementById('affordSearchDivPrice').innerHTML = '';*/
				}
			}
	        // End New Search by Affordability
	         if ( (tempRate == 0 ) && (mpLoan.value == "NaN") ) {
	           mpLoan.value = setDecPlaces(parseFloat(eval(parseFloat(var_afLoan) / var_termLoan)).toString(), 2, true);
	         }
	      }
	      updateMinMax(field);
	   }
	}
	
	//=================================================
	function updateMinMax(field) {
	  with (document.calculator) {
	    var_vpLoanMin     = parseFloat(dpLoan.value) + parseFloat(tvLoan.value);
	    var_dpLoanMax     = parseFloat(vpLoan.value) - parseFloat(tvLoan.value);
	    var_tvLoanMax     = parseFloat(vpLoan.value) - parseFloat(dpLoan.value);
	         vpLoanMin.value = var_dpLoanMax
		
	  }
	}
	
	//=================================================
	function isNumeric(field)
	{
	  // Check if input field is numeric.
	  
	  var floatValue = new Number(parseFloat(field.value,10))
	  var isNumber = true
	  var chr = 0;
	  var decPlaces = 0;
	  var errorMsg = "";
	  
	  //   alert('In validateField()')
	  
	  dirtyField = true
	  if (dirtyField)
	  {
	    //        alert('if (inNumber)')
	    // Check for digits '0'-'9' and '.'
	    for ( var i = 0; i < field.value.length; i ++ )
	    {
	      chr = field.value.charAt( i )
	      //           alert('Char is ' + chr)
	      
	      // verify that the number is in fact numeric
	      if ((chr >= "0" && chr <= "9") || chr == ".")
	      {
	        if ( chr == "." )
	        {
	           decPlaces  += 1;
	           //  Checks to make sure that there's at most one decimal point.
	           if ( decPlaces > 1 )
	           {
	              isNumber = false 
	              errorMsg = "You can only have one decimal point in your number."
	        //                     alert(errorMsg)
	              i = field.value.length
	           }
	        }
	      }
	      else
	      {
	        isNumber = false 
	        errorMsg = "The only values allowed are numbers (0 through 9) and a decimal point."
	        //               alert(errorMsg)
	        i = field.value.length
	      }
	    }
	  }
	  if (isNumber)
	  {
	    dirtyField = false
	    field.value = setDecPlaces(field.value, eval("var_" + field.name + "DecPlaces"))
	    return true
	  }
	  else
	  {
	    return false
	  }
	}
	</script>
	</head>
	
	<cffunction name="reverse_price_srch" description="Price Search open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="price_search">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/wcia_action.cfm">
		<cfargument name="voi_new_used" default="">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
		
		<cfset err_style = "" >
		<cfif IsDefined("url.err_msg") and #len(url.err_msg)# GT 0 >
			<cfset err_style = "background-color:yellow" >
		</cfif>
  
  		<cfquery datasource="Ultra10" name="get_control">
			SELECT  ID, dealer_id, condition_text, month_pay_text, down_pay_text, finance_text, contract_len_text, estimated_budget_text, button_text, srch_amt_below, 
			        srch_amt_above, right_side_image, right_side_text, show_instock_count, instock_text, click_thru, active
			FROM    Dealer_Loan_Control
			WHERE	dealer_id	=	#url.dealer_id#
			AND		active = 1
		</cfquery>
  		
		<cfif #get_control.recordcount# EQ 0 >		<!--- 11/19/2015 Bob --->
			<cflocation url="#cgi.server_name#"> 
		</cfif>
  
		<cfif #get_control.click_thru# EQ "" >
	  		<cfset old_plus_clicks =  1 >
		<cfelse>
	  		<cfset old_plus_clicks = #get_control.click_thru# + 1 >	
		</cfif>
  
		<cfquery datasource="ultra10" name="Get_APR">
			SELECT	ID, ctrl_id, dealer_id, APR, default_apr, hierarchy, active
			FROM    Dealer_Loan_APR
			WHERE 	dealer_id = #url.dealer_id#
			 AND 	ctrl_id = #get_control.id# 
			AND 	active = 1
			ORDER BY hierarchy ASC
		</cfquery>
		<cfset dflt_apr = 0>
		<cfloop query="Get_APR"><cfif #Get_APR.default_apr# EQ 1><cfset dflt_apr = #Get_APR.APR#></cfif></cfloop>
		<cfquery datasource="ultra10" name="Get_Term">
			SELECT	ID, ctrl_id,  dealer_id, loan_term, default_term, hierarchy, active
			FROM    Dealer_Loan_Terms
			WHERE 	dealer_id = #url.dealer_id#
		 AND 	ctrl_id = #get_control.id#  
			AND 	active = 1
			ORDER BY hierarchy ASC
		</cfquery>
		<cfset dflt_term = 0>
		<cfloop query="Get_Term"><cfif #Get_Term.default_term# EQ 1><cfset dflt_term = #Get_Term.loan_term#></cfif></cfloop>

		<cfquery datasource="Ultra10" name="cnt_Inv">
		SELECT  Vehicle_ID, Dealer_ID 
		FROM    Vehicles
		WHERE		Dealer_ID IN 
				(	SELECT 	Distinct Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
				)
		</cfquery>
	<body  onload="document.calculator.mpLoan.focus()">
		<cfform id="calculator" method="post" name="calculator" action="#form_action#" >
			<input id="tvLoan" name="tvLoan" type="hidden" value="0" >
			<input id="stPerLoan" name="stPerLoan" type="hidden" value="0" >
			<input id="dealer_id" name="dealer_id" type="hidden" value="#url.dealer_id#" >
			<input id="ctrl_rec" name="ctrl_rec" type="hidden" value="#get_control.id#" >
			<input id="new_clicks" name="new_clicks" type="hidden" value="#old_plus_clicks#" >
			<cfif #get_control.show_instock_count# EQ 1 >
			    <div class="row">
					<div class="col-md-12 pay-search-title visible-sm visible-xs  visible-lg visible-md"  align="center" >	
						<cfset get_control.instock_text=replace(get_control.instock_text,"$COUNT$","#numberformat(cnt_Inv.recordcount)#","All")>
						<h1 style="font-weight:bold;font-style: italic;color:##cc0000">#get_control.instock_text#</h1>
					</div>
				</div>	
			</cfif>
		    <div class="row">
				<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md"  >	
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="voi_new_used">#get_control.condition_text#:&nbsp;</label>
						</div> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<cfif #url.dealer_id# NEQ 35 >
								<input name="voi_new_used"   id="voi_new_used" type="radio" checked="checked" value="N" >
								<span style="font-size:10pt">New</span>
								&nbsp;&nbsp;
							</cfif>
							<input name="voi_new_used"   id="voi_new_used1" type="radio" <cfif #url.dealer_id# EQ 35 >checked</cfif> value="U">
							<span style="font-size:10pt">Used</span>
							&nbsp;&nbsp;
							<input name="voi_new_used"   id="voi_new_used2" type="radio" value="C">
							<span style="font-size:10pt">Certified</span>
						</div>
		            </div>
					
					<div class="row" style="#err_style#" > 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.month_pay_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input  class="pay-search-input" id="mpLoan" name="mpLoan" type="text" value="0" size="20"  maxlength="20" tabindex="1" onChange="validateField(this)">
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="dpLoan">#get_control.down_pay_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input id="dpLoan"  class="pay-search-input"  name="dpLoan" type="text" value="0" size="20" maxlength="20"  tabindex="2" onChange="validateField(this)">
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.finance_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<select name="rateLoan" id="rateLoan"  class="pay-search-input"  tabindex="3"  onChange="validateField(this)">
								<option value="" selected>Select APR</option>
								<cfloop query="Get_APR"><option value="#Get_APR.APR#" <cfif #dflt_apr# eq #Get_APR.APR# >selected</cfif>>#Get_APR.APR#%&nbsp;&nbsp;</option></cfloop>
							</select>
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.contract_len_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<select name="termLoan" id="termLoan"  class="pay-search-input"  tabindex="4" onChange="validateField(this)">
								<option value="0" selected>Select Term</option>
								<cfloop query="Get_Term"><option value="#Get_Term.loan_term#" <cfif #dflt_term# eq #Get_Term.loan_term# >selected</cfif>>#Get_Term.loan_term# Months&nbsp;&nbsp;</option></cfloop>
							</select>
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.estimated_budget_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input id="vpLoan" name="vpLoan"  class="pay-search-result"  type="text" value="" size="20" maxlength="20"  onChange="validateField(this)">
						</div>
		            </div>
					<div class="row"> 
						<div class="col-md-6 col-md-offset-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input class=" pay-search-btn pull-right" name="Contact_Us" id="Contact_Us" tabindex="5" type="submit" value="#get_control.button_text#">
						</div>
		            </div>
					
				</div>			
				<!--- <div class="col-md-1  visible-lg visible-md">&nbsp;</div> --->
				<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" >	
					<cfif #get_control.right_side_image# NEQ "" >
						<div class="row"> 
							<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md" align="center" >	
								 <img src="http://dealers.wdautos.com/dealer/#url.assets#/images/library/#get_control.right_side_image#" alt="Placeholder"  class="img-responsive" border="0">
							</div>
			            </div>
					</cfif>
					<cfif #get_control.right_side_text# NEQ "" >
						<div class="row"> 
							<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md" align="center" >	
								#get_control.right_side_text#
							</div>
			            </div>
					</cfif>
				
				</div>
				<div id="tsLoanDiv" style="display:none"/></div>
	        </div>
		</cfform>  

	</cffunction>
	
	
	<cffunction name="reverse_price_srch_v1" description="Price Search open form" output="yes" access="public">

		<!--- arguments --->
		<cfargument name="form_name" default="price_search">
		<cfargument name="dealer_id" required="true">
		<cfargument name="form_action" default="http://#cgi.server_name#/forms/wcia_action.cfm">
		<cfargument name="voi_new_used" default="">
		<cfargument name="voi_vin" default="">
		<cfargument name="voi_year" default="">
		<cfargument name="voi_make" default="">
		<cfargument name="voi_model" default="">
		<cfargument name="input_class" default="form-control input-md">
		<cfargument name="button_class" default="">
		<cfargument name="button_label" default="">
					
		<cfargument name="show_labels" default="false">
		
		<cfset err_style = "" >
		<cfif IsDefined("url.err_msg") and #len(url.err_msg)# GT 0 >
			<cfset err_style = "background-color:yellow" >
		</cfif>
  
  
  		<cfquery datasource="Ultra10" name="get_control">
			SELECT	ID, dealer_id, condition_text, month_pay_text, down_pay_text, finance_text, contract_len_text, estimated_budget_text, button_text, srch_amt_below, 
			        srch_amt_above, credit_rating_flag, sales_tax_flag, sales_tax_rate, right_side_image, right_side_text, show_instock_count, instock_text, click_thru, active
			FROM    Dealer_Loan_Control
			WHERE	dealer_id	=	#url.dealer_id#
			AND		active = 1
		</cfquery>
		<cfif #get_control.recordcount# EQ 0 >		<!--- 11/19/2015 Bob --->
			<cflocation url="#cgi.server_name#"> 
		</cfif>
  		<cfset old_plus_clicks = #get_control.click_thru# + 1 >
		
  
		<cfquery datasource="ultra10" name="Get_APR">
			SELECT	ID, ctrl_id, dealer_id, APR, default_apr, cr_none, cr_poor, cr_average, cr_good, cr_very_good, cr_excellent, hierarchy, active
			FROM    Dealer_Loan_APR
			WHERE 	dealer_id = #url.dealer_id#
			AND 	ctrl_id = #get_control.id# 
			<cfif #get_control.credit_rating_flag# EQ 1 >
				AND	( 	cr_none = 1 OR
						cr_poor = 1 OR
						cr_average = 1 OR
						cr_good = 1 OR
						cr_very_good = 1 OR
						cr_excellent = 1 )
			</cfif>
			AND 	active = 1
			ORDER BY hierarchy ASC
		</cfquery>
		<cfset dflt_apr = 0>
		<cfloop query="Get_APR"><cfif #Get_APR.default_apr# EQ 1><cfset dflt_apr = #Get_APR.APR#></cfif></cfloop>
		<cfquery datasource="ultra10" name="Get_Term">
			SELECT	ID, ctrl_id, dealer_id, loan_term, default_term, cr_none, cr_poor, cr_average, cr_good, cr_very_good, cr_excellent, hierarchy, active
			FROM    Dealer_Loan_Terms
			WHERE 	dealer_id = #url.dealer_id#
			AND 	ctrl_id = #get_control.id#  
			<cfif #get_control.credit_rating_flag# EQ 1 >
				AND	( 	cr_none = 1 OR
						cr_poor = 1 OR
						cr_average = 1 OR
						cr_good = 1 OR
						cr_very_good = 1 OR
						cr_excellent = 1 )
			</cfif>
			AND 	active = 1
			ORDER BY hierarchy ASC
		</cfquery>
		<cfset dflt_term = 0>
		<cfloop query="Get_Term"><cfif #Get_Term.default_term# EQ 1><cfset dflt_term = #Get_Term.loan_term#></cfif></cfloop>

		<cfquery datasource="Ultra10" name="cnt_Inv">
		SELECT  Vehicle_ID, Dealer_ID 
		FROM    Vehicles
		WHERE		Dealer_ID IN 
				(	SELECT 	Distinct Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	Dealer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">
				)
		</cfquery>
	<body  onload="document.calculator.mpLoan.focus()">
		<cfform id="calculator" method="post" name="calculator" action="#form_action#" >
			<input id="tvLoan" name="tvLoan" type="hidden" value="0" >
			<input id="stPerLoan" name="stPerLoan" type="hidden" value="0" >
			<input id="dealer_id" name="dealer_id" type="hidden" value="#url.dealer_id#" >
			<input id="ctrl_rec" name="ctrl_rec" type="hidden" value="#get_control.id#" >
			<input id="new_clicks" name="new_clicks" type="hidden" value="#old_plus_clicks#" >
			<cfif #get_control.show_instock_count# EQ 1 >
			    <div class="row">
					<div class="col-md-12 pay-search-title visible-sm visible-xs  visible-lg visible-md"  align="center" >	
						<cfset get_control.instock_text=replace(get_control.instock_text,"$COUNT$","#numberformat(cnt_Inv.recordcount)#","All")>
						<h1 style="font-weight:bold;font-style: italic;color:##cc0000">#get_control.instock_text#</h1>
					</div>
				</div>	
			</cfif>
		    <div class="row">
				<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md"  >	
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="voi_new_used">#get_control.condition_text#:&nbsp;</label>
						</div> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<cfif #url.dealer_id# NEQ 35 >
								<input name="voi_new_used"   id="voi_new_used" type="radio" checked="checked" value="N" >
								<span style="font-size:10pt">New</span>
								&nbsp;&nbsp;
							</cfif>
							<input name="voi_new_used"   id="voi_new_used1" type="radio" value="U">
							<span style="font-size:10pt">Used</span>
							&nbsp;&nbsp;
							<input name="voi_new_used"   id="voi_new_used2" type="radio" value="C">
							<span style="font-size:10pt">Certified</span>
						</div>
		            </div>
					
					<div class="row" style="#err_style#" > 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.month_pay_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input  class="pay-search-input" id="mpLoan" name="mpLoan" type="text" value="0" size="20"  maxlength="20" tabindex="1" onChange="validateField(this)">
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="dpLoan">#get_control.down_pay_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input id="dpLoan"  class="pay-search-input"  name="dpLoan" type="text" value="0" size="20" maxlength="20"  tabindex="2" onChange="validateField(this)">
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.finance_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<select name="rateLoan" id="rateLoan"  class="pay-search-input"  tabindex="3"  onChange="validateField(this)">
								<option value="" selected>Select APR</option>
								<cfloop query="Get_APR"><option value="#Get_APR.APR#" <cfif #dflt_apr# eq #Get_APR.APR# >selected</cfif>>#Get_APR.APR#%&nbsp;&nbsp;</option></cfloop>
							</select>
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.contract_len_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<select name="termLoan" id="termLoan"  class="pay-search-input"  tabindex="4" onChange="validateField(this)">
								<option value="0" selected>Select Term</option>
								<cfloop query="Get_Term"><option value="#Get_Term.loan_term#" <cfif #dflt_term# eq #Get_Term.loan_term# >selected</cfif>>#Get_Term.loan_term# Months&nbsp;&nbsp;</option></cfloop>
							</select>
						</div>
		            </div>
					
					<div class="row"> 
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="right" >	
							<label class="pay-search-name" for="mpLoan">#get_control.estimated_budget_text#:&nbsp;</label>
						</div>
						<div class="col-md-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input id="vpLoan" name="vpLoan"  class="pay-search-result"  type="text" value="" size="20" maxlength="20"  onChange="validateField(this)">
						</div>
		            </div>
					<div class="row"> 
						<div class="col-md-6 col-md-offset-6  visible-sm visible-xs  visible-lg visible-md" align="left" >	
							<input class=" pay-search-btn pull-right" name="Contact_Us" id="Contact_Us" tabindex="5" type="submit" value="#get_control.button_text#">
						</div>
		            </div>
					
				</div>			
				<div class="col-md-1  visible-lg visible-md">&nbsp;</div>
				<div class="col-md-5  visible-sm visible-xs  visible-lg visible-md" >	
					<cfif #get_control.right_side_image# NEQ "" >
						<div class="row"> 
							<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md" align="center" >	
								 <img src="http://dealers.wdautos.com/dealer/#url.assets#/images/library/#get_control.right_side_image#" alt="Placeholder"  class="img-responsive" border="0">
							</div>
			            </div>
					</cfif>
					<cfif #get_control.right_side_text# NEQ "" >
						<div class="row"> 
							<div class="col-md-12 visible-sm visible-xs  visible-lg visible-md" align="center" >	
								#get_control.right_side_text#
							</div>
			            </div>
					</cfif>
				
				</div>
			  	<div id="tsLoanDiv" style="display:none"/></div>
	        </div>
		</cfform>  

	</cffunction>





	<cffunction name="form_submit" description="default contact layout" output="yes" access="public">
  	
	</cffunction>

<script type="text/javascript">
    $(function() {			
		$sec = $('#_form');	
		$sec.html('<span>Loading...</span>');
		$sec.load('info_collect.cfm', function() {
		  initCalc();
		});
		
	});

	function loadTab(_sec){	
		$sec = $('#_form');	
		$sec.html('<span>Loading...</span>');
		$sec.load(_sec, function() {
		  initCalc();
		});
	}

  </script> 
	</cfcomponent>