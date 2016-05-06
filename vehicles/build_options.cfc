<cfcomponent>

	<cffunction name="get_all" description="gets makes" output="Yes" access="public">

	
	
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">

		<cfquery datasource="#arguments.dsn#" name="Get_Data">
			SELECT DISTINCT #arguments.data_field# as My_Data
			FROM         	#arguments.data_table#
			WHERE			#arguments.data_field# <> 'Aston Martin'
			ORDER BY		#arguments.data_field#
		</cfquery>
		
		 <option value="">#arguments.default_option#</option> 
		<cfloop query="Get_Data">
			<option value="#Get_Data.My_Data#">#Get_Data.My_Data#</option>	
		</cfloop>

	</cffunction>

	<cffunction name="get_condition" description="gets makes" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dealer_id_field" default="dealer_id">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">
		<cfargument name="condition_field" default="new_used">
		<cfargument name="conditon_value" default="u">
		
		
		
		<cfif arguments.conditon_value eq "c">
			<cfset variables.my_value="u">
		<cfelseif arguments.conditon_value eq "">
			<cfset variables.my_value="u">
		<!--- <cfelseif arguments.conditon_value eq "null">
			<cfset variables.my_value="u"> --->
		<cfelse>
			<cfset variables.my_value=arguments.conditon_value>
		</cfif>

		
		<cfquery datasource="#arguments.dsn#" name="Get_Data">
			SELECT DISTINCT #arguments.data_field# as My_Data
			FROM         	#arguments.data_table#
			WHERE			#arguments.dealer_id_field# IN 
				(	SELECT 	Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
					AND 	#arguments.dealer_id_field# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
					
			<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or 
					arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
				AND			V_Make = 'Nissan'
			</cfif>
			<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or 
					arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200  or arguments.dealer_id eq 160>
				AND			V_Make = 'Honda'
			</cfif>
			<cfif arguments.dealer_id eq 37 or  arguments.dealer_id eq 73 or  arguments.dealer_id eq 74  or  arguments.dealer_id eq 12>
				AND			(V_Make = 'Toyota' or V_MAKE = 'Scion')
			</cfif>
			<cfif arguments.dealer_id eq 45  >	 
				AND			(V_Make = 'Scion')
			</cfif>
			<cfif arguments.dealer_id eq 179  >	 
				AND			(V_Make = 'Scion')
			</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
			<cfif arguments.dealer_id eq 46 >		<!--- Stoltz Toyota --->
				AND			(V_Make = 'Toyota')
			</cfif>
			<cfif arguments.dealer_id eq 30 >		<!--- Findlay Toyota --->
				AND			(V_Make = 'Toyota')
			</cfif>
			<cfif arguments.dealer_id eq 89>
				AND			V_Make = 'Mitsubishi'
			</cfif>
			<cfif arguments.dealer_id eq 132 and #variables.my_value# eq 'n'>  <!--- Northpointe CDJR --->
				AND			( V_Make = 'Chrysler' or V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
			</cfif> 
			<cfif arguments.dealer_id eq 195 and #variables.my_value# eq 'n'>  <!--- Northpointe GM --->
				AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
			</cfif> 
			<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82 or arguments.dealer_id eq 68  or arguments.dealer_id eq 375  >
				AND			V_Make = 'Mazda'
			</cfif>
			<cfif arguments.conditon_value neq "a">
				AND				#arguments.condition_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
			</cfif>
			<cfif arguments.conditon_value eq "c">
				AND			certified = 1
			</cfif>
			<cfswitch expression="#arguments.dealer_id#">
				<cfdefaultcase>
					ORDER BY		#arguments.data_field#
				</cfdefaultcase>
				<cfcase value="70,37">
					<cfif variables.my_value eq "n">
						ORDER BY		#arguments.data_field# DESC
					<cfelse>
						ORDER BY		#arguments.data_field#
					</cfif>
				</cfcase>
			</cfswitch>
		</cfquery>
		
<!--- This is where the MAKE could be defaulted  02/04/2015  --->
		
		
		 <option value="">#arguments.default_option#</option> 
		
		<cfloop query="Get_Data">
			<option value="#Get_Data.My_Data#">#Get_Data.My_Data#</option>	
		</cfloop>

	</cffunction>

	<cffunction name="get_chain" description="gets makes" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="chain_field" required="true">
		<cfargument name="chain_value" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">

		<cfquery datasource="#arguments.dsn#" name="Get_Data">
			SELECT DISTINCT #arguments.data_field# as My_Data
			FROM         	#arguments.data_table#
			WHERE			#arguments.chain_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value#" maxlength="100">
			ORDER BY		#arguments.data_field#
		</cfquery>

		<option value="">#arguments.default_option#</option> 
		<cfloop query="Get_Data">
			<option value="#Get_Data.My_Data#">#Get_Data.My_Data#</option>	
		</cfloop>

	</cffunction>

	<cffunction name="get_chain_condition" description="gets models" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="chain_field" required="true">
		<cfargument name="chain_value" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">
		<cfargument name="condition_field" default="new_used">
		<cfargument name="conditon_value" default="u">

		<cfif arguments.conditon_value eq "c">
			<cfset variables.my_value="u">
		<cfelseif arguments.conditon_value eq "">
			<cfset variables.my_value="u">
		<!--- <cfelseif arguments.conditon_value eq "null">
			<cfset variables.my_value="u"> --->
		<cfelse>
			<cfset variables.my_value=arguments.conditon_value>
		</cfif>

		<cfquery datasource="#arguments.dsn#" name="Get_Data">
			SELECT DISTINCT #arguments.data_field# as My_Data
			FROM         	#arguments.data_table#
			WHERE			#arguments.dealer_id_field# IN 
				(	SELECT 	Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
					AND 	#arguments.dealer_id_field# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
			AND				#arguments.chain_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value#" maxlength="100">
			<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
				AND			V_Make = 'Nissan'
			</cfif>
			<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
				AND			V_Make = 'Honda'
			</cfif>
			<cfif arguments.dealer_id eq 37 or  arguments.dealer_id eq 30 or  arguments.dealer_id eq 46  or  arguments.dealer_id eq 73 or  arguments.dealer_id eq 74  or  arguments.dealer_id eq 12>
				AND			V_Make = 'Toyota'
			</cfif>
			
			<cfif arguments.dealer_id eq 132 and #variables.my_value# eq 'n'>  <!--- Northpointe CDJR --->
				AND			( V_Make = 'Chrysler' or	V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
			</cfif>
			<cfif arguments.dealer_id eq 195 and #variables.my_value# eq 'n'>  <!--- Northpointe GM --->
				AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
			</cfif> 
			<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82 or arguments.dealer_id eq 68  or arguments.dealer_id eq 375  >
				AND			V_Make = 'Mazda'
			</cfif>
			<cfif arguments.dealer_id eq 45    >
				AND			V_Make = 'Scion'
			</cfif>
			<cfif arguments.dealer_id eq 179  >	 
				AND			(V_Make = 'Scion')
			</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
			<cfif arguments.conditon_value neq "a">
				AND				#arguments.condition_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
			</cfif>
			<cfif arguments.conditon_value eq "c">
				AND			certified = 1
			</cfif>
			ORDER BY		#arguments.data_field#
		</cfquery>
		<option value="">#arguments.default_option#</option>
		<cfloop query="Get_Data">
			<cfset variables.this_MyData=replace(Get_Data.My_Data,"&","%26","all" )>
			<cfset variables.this_MyData=replace(variables.this_MyData," ","%20","all" )>
			<option value="#variables.this_MyData#">#Get_Data.My_Data#</option>
		</cfloop>

	</cffunction>

	<cffunction name="get_chain_two" description="gets models" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="chain_field" required="true">
		<cfargument name="chain_value" required="true">
		<cfargument name="chain_field_2" required="true">
		<cfargument name="chain_value_2" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">
		<cfargument name="condition_field" default="new_used">
		<cfargument name="conditon_value" default="u">

		<cfif arguments.conditon_value eq "c">
			<cfset variables.my_value="u">
		<cfelseif arguments.conditon_value eq "">
			<cfset variables.my_value="u">
		<!--- <cfelseif arguments.conditon_value eq "null">
			<cfset variables.my_value="u"> --->
		<cfelse>
			<cfset variables.my_value=arguments.conditon_value>
		</cfif>

		<cfquery datasource="#arguments.dsn#" name="Get_Data" result="r1">
			SELECT DISTINCT #arguments.data_field# as My_Data
			FROM         	#arguments.data_table#
			WHERE			#arguments.dealer_id_field# IN 
				(	SELECT 	Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
					AND 	#arguments.dealer_id_field# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
			<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
				AND			V_Make = 'Nissan'
			</cfif>
			<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
				AND			V_Make = 'Honda'
			</cfif>
			<cfif arguments.dealer_id eq 37 or  arguments.dealer_id eq 30  or  arguments.dealer_id eq 46  or  arguments.dealer_id eq 73  or  arguments.dealer_id eq 74  or  arguments.dealer_id eq 12 >
				AND			V_Make = 'Toyota'
			</cfif>
			
			<cfif arguments.dealer_id eq 132 and #variables.my_value# eq 'n'>  <!--- Northpointe CDJR --->
				AND			( V_Make = 'Chrysler' or	V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
			</cfif>
			<cfif arguments.dealer_id eq 195 and #variables.my_value# eq 'n'>  <!--- Northpointe GM --->
				AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
			</cfif> 
			
			<cfif arguments.dealer_id eq 45   >
				AND			V_Make = 'Scion'
			</cfif>
			<cfif arguments.dealer_id eq 179  >	 
				AND			(V_Make = 'Scion')
			</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
			<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82 or arguments.dealer_id eq 68  or arguments.dealer_id eq 375  >
				AND			V_Make = 'Mazda'
			</cfif>
			<cfif len(trim(arguments.chain_value)) gt 0>
				AND			#arguments.chain_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value#" maxlength="100">
			</cfif>
			<cfif len(trim(arguments.chain_value_2)) gt 0>
				AND			#arguments.chain_field_2# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value_2#" maxlength="100">
			</cfif>
			<cfif arguments.conditon_value neq "a">
				AND			#arguments.condition_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
			</cfif>
			<cfif arguments.conditon_value eq "c">
				AND			certified = 1
			</cfif>
			ORDER BY		#arguments.data_field#
		</cfquery>

		<option value="">#arguments.default_option#</option>
		<cfloop query="Get_Data">
			<option value="#Get_Data.My_Data#">#Get_Data.My_Data#</option>	
		</cfloop>
		<!---<cfdump var="#r1#">--->
	</cffunction>
	
	
	<cffunction name="getChainWithVarOptions" description="returns data based on array of clasue conditions" output="true" access="public">
		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">
		<cfargument name="condition_array" default="" required="true" type="struct" >
		<!---<cfargument name="chain_field" required="true">
		<cfargument name="chain_value" required="true">
		<cfargument name="chain_field_2" required="true">
		<cfargument name="chain_value_2" required="true">--->
		<cfargument name="condition_field" default="new_used">
		<cfargument name="conditon_value" default="u">
		<cfargument name="noFilterMake" default="0">

		<cfif arguments.conditon_value eq "c" or arguments.conditon_value eq "z">
			<cfset variables.my_value="u">
		<cfelseif arguments.conditon_value eq "">
			<cfset variables.my_value="u">
		<!--- <cfelseif arguments.conditon_value eq "null">
			<cfset variables.my_value="u"> --->
		<cfelse>
			<cfset variables.my_value=arguments.conditon_value>
		</cfif>
		<cfquery datasource="#arguments.dsn#" name="Get_Data" result="r1">
			SELECT DISTINCT #arguments.data_field# as My_Data
			FROM         	#arguments.data_table#
			WHERE			#arguments.dealer_id_field# IN 
				(	SELECT 	Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
					AND 	#arguments.dealer_id_field# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
			<cfif arguments.dealer_id eq 18 or arguments.dealer_id eq 78 or arguments.dealer_id eq 79 or arguments.dealer_id eq 52 or arguments.dealer_id eq 54 or arguments.dealer_id eq 257 or arguments.dealer_id eq 41>
				AND			V_Make = 'Nissan'
			</cfif>
			<cfif arguments.dealer_id eq 51 or arguments.dealer_id eq 28 or arguments.dealer_id eq 25 or arguments.dealer_id eq 27 or arguments.dealer_id eq 7 or arguments.dealer_id eq 200 or arguments.dealer_id eq 160>
				AND			V_Make = 'Honda'
			</cfif>
			<cfif arguments.dealer_id eq 37 or  arguments.dealer_id eq 30  or  arguments.dealer_id eq 46  or  arguments.dealer_id eq 73  or  arguments.dealer_id eq 74  or  arguments.dealer_id eq 12 >
				AND			V_Make = 'Toyota'
			</cfif>            
			<cfif arguments.dealer_id eq 171 or  arguments.dealer_id eq 172  or  arguments.dealer_id eq 180  or  arguments.dealer_id eq 181  or  arguments.dealer_id eq 303 or  arguments.dealer_id eq 65 or  arguments.dealer_id eq 8><!--- fuccillo kia --->
            <cfif arguments.noFilterMake eq 0>
				AND			V_Make = 'Kia'
            </cfif>
			</cfif>
			
			<cfif arguments.dealer_id eq 132 and #variables.my_value# eq 'n'>  <!--- Northpointe CDJR --->
				AND			( V_Make = 'Chrysler' or	V_Make = 'Dodge'	or	V_Make = 'Jeep'	or	V_Make = 'RAM' )
			</cfif>
			<cfif arguments.dealer_id eq 195 and #variables.my_value# eq 'n'>  <!--- Northpointe GM --->
				AND			( V_Make = 'Cadillac' or	V_Make = 'Chevrolet' )
			</cfif> 
			
			<cfif arguments.dealer_id eq 45    >
				AND			V_Make = 'Scion'
			</cfif>
			<cfif arguments.dealer_id eq 179  >	 
				AND			(V_Make = 'Scion')
			</cfif>
				<cfif  arguments.dealer_id eq 38>		<!--- Washington Scion --->
					AND			(V_Make = 'Scion' )
					AND			(V_Make <> 'Toyota' )
				</cfif>
			<cfif arguments.dealer_id eq 24 or arguments.dealer_id eq 82  or arguments.dealer_id eq 68  or arguments.dealer_id eq 375 >
				<cfif arguments.noFilterMake eq 0>
                	AND V_Make = 'Mazda'
                </cfif>
			</cfif>
            
            <!---<cfif arguments.conditon_value eq "z">
				<!--- Courtesy Imports Classic Used Cars --->
                <cfif arguments.dealer_id EQ 66 OR arguments.dealer_id EQ 40 OR  arguments.dealer_id eq 67  OR  arguments.dealer_id eq 288 >
                    AND		V_Year < 1991
                </cfif>	
            </cfif>--->
            
			<cfif IsStruct(condition_array) and StructCount(condition_array)>
				<cfloop list="#structKeyList(condition_array)#" index="key">
					<cfif 	len(condition_array[key])>
						AND #key# =  '#condition_array[key]#'
					</cfif>				
				</cfloop>
			</cfif>
			
			<!---<cfif len(trim(arguments.chain_value)) gt 0>
				AND			#arguments.chain_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value#" maxlength="100">
			</cfif>
			<cfif len(trim(arguments.chain_value_2)) gt 0>
				AND			#arguments.chain_field_2# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value_2#" maxlength="100">
			</cfif>
			<cfif arguments.conditon_value neq "a">
				AND			#arguments.condition_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
			</cfif>
			<cfif arguments.conditon_value eq "c">
				AND			certified = 1
			</cfif>--->
			ORDER BY		#arguments.data_field#
		</cfquery>

		<option value="">#arguments.default_option#</option>
        <cfif arguments.dealer_id eq 15 and arguments.data_field is 'V_Make' and variables.my_value is 'n'>
        <option value="Chevrolet">Chevrolet</option>
        </cfif>
		<cfloop query="Get_Data"><!--- <cfif arguments.data_field is 'V_Make' and variables.my_value is 'n' and (arguments.dealer_id eq 65 or arguments.dealer_id eq 68)>selected</cfif>--->
			<option value="#urlencodedformat(Get_Data.My_Data)#">#Get_Data.My_Data#</option>	
		</cfloop>	
        <!--- add script that selects [1] from options list --->
        <!---<cfif arguments.data_field is 'V_Make' and variables.my_value is 'n' and (arguments.dealer_id eq 65 or arguments.dealer_id eq 68)>
        <script>// Shorthand for $( document ).ready()
		$(function() {
			$make.val(1);	
		});		
		</script>
        </cfif>--->
        <!---<cfif cgi.remote_addr eq '172.16.25.102'><cfdump var="#r1#"></cfif>--->	
	</cffunction>
	
	
	 <!--- zip --->
      <cffunction name="get_chain_zip" description="gets models" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="chain_field" required="true">
		<cfargument name="chain_value" required="true">
		<cfargument name="chain_field_2" required="true">
		<cfargument name="chain_value_2" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">
		<cfargument name="condition_field" default="new_used">
		<cfargument name="conditon_value" default="u">

		<cfif arguments.conditon_value eq "c">
			<cfset variables.my_value="u">
		<cfelse>
			<cfset variables.my_value=arguments.conditon_value>
		</cfif>

		<cfquery datasource="#arguments.dsn#" name="Get_Data">
			SELECT DISTINCT #arguments.data_field# as My_Data, Dealer_Display_Name as D_Name
			FROM         	#arguments.data_table#
			<cfif #url.dealer_id# eq 178 >
				WHERE			Dealer_Display_Name LIKE '%fuccillo%' AND LEN([Dealer_Zip]) = 5 
			<cfelse>	
				WHERE			Dealer_Display_Name LIKE '%findlay%' AND LEN([Dealer_Zip]) = 5 
			</cfif>
				<!---(	SELECT 	Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
					AND 	#arguments.dealer_id_field# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
			--->
			<cfif len(trim(arguments.chain_value)) gt 0>
				AND			#arguments.chain_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value#" maxlength="100">
			</cfif>
			<cfif len(trim(arguments.chain_value_2)) gt 0>
				AND			#arguments.chain_field_2# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value_2#" maxlength="100">
			</cfif>
			<cfif arguments.conditon_value neq "a">
				AND			#arguments.condition_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
			</cfif>
			<cfif arguments.conditon_value eq "c">
				AND			certified = 1
			</cfif>
			ORDER BY		#arguments.data_field# ASC
		</cfquery>

		<option value="">#arguments.default_option#</option>
		<cfloop query="Get_Data">		
				<option value="#Get_Data.My_Data#">#Get_Data.My_Data# - #Get_Data.D_Name#</option>	
		</cfloop>

	</cffunction>

	
	 <!--- geo --->
      <cffunction name="get_chain_geo" description="gets Geographic Locations" output="Yes" access="public">

		<!--- arguments --->
		<cfargument name="dealer_id" required="true">
		<cfargument name="dsn" required="true">
		<cfargument name="data_field" required="true">
		<cfargument name="chain_field" required="true">
		<cfargument name="chain_value" required="true">
		<cfargument name="chain_field_2" required="true">
		<cfargument name="chain_value_2" required="true">
		<cfargument name="data_table" required="true">
		<cfargument name="default_option" default="Choose One">
		<cfargument name="cache_results" default="no">
		<cfargument name="condition_field" default="new_used">
		<cfargument name="conditon_value" default="u">

		<cfif arguments.conditon_value eq "c">
			<cfset variables.my_value="u">
		<cfelse>
			<cfset variables.my_value=arguments.conditon_value>
		</cfif>

		<cfquery datasource="#arguments.dsn#" name="Get_Data">
			SELECT DISTINCT #arguments.data_field# as My_Data, Dealer_Display_Name as D_Name
			FROM         	#arguments.data_table#
			
			 WHERE			( Dealer_Display_Name LIKE '%findlay%' AND region_id <> 0  )   
			 		OR ( Dealer_Display_Name LIKE '%land rover reno%' AND region_id <> 0 )
			 		OR ( Dealer_Display_Name LIKE '%jaguar%' AND region_id <> 0 )  
			
			<!--- WHERE			Dealer_Display_Name LIKE '%pinto%'	AND region_id <> 0  --->
				<!---(	SELECT 	Share_ID 
					FROM 	ultra10.dbo.Dealer_Shares 
					WHERE 	New_Used = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
					AND 	#arguments.dealer_id_field# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dealer_id#" maxlength="4">)
			--->
			<cfif len(trim(arguments.chain_value)) gt 0>
				AND			#arguments.chain_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value#" maxlength="100">
			</cfif>
			<cfif len(trim(arguments.chain_value_2)) gt 0>
				AND			#arguments.chain_field_2# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.chain_value_2#" maxlength="100">
			</cfif>
			
			<cfif arguments.conditon_value neq "a">
				AND			#arguments.condition_field# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.my_value#" maxlength="1">
			</cfif>
			<cfif arguments.conditon_value eq "c">
				AND			certified = 1
			</cfif>
			ORDER BY		#arguments.data_field# ASC
		</cfquery>

		<option value="">#arguments.default_option#</option>
		<cfset hld = 0 >
		<cfloop query="Get_Data">
			<cfquery datasource="#arguments.dsn#" name="Get_Region">
				SELECT	ID, Dealer_ID, Region_text, active
				FROM    Dealer_Regions
				WHERE	ID = #Get_Data.My_Data#
			</cfquery>
			<cfif #Get_Data.My_Data# NEQ #hld# >
				<option value="#Get_Region.ID#">#RTrim(Get_Region.Region_text)#</option>	
				<cfset hld = #Get_Data.My_Data# >
			</cfif>
		</cfloop>

	</cffunction>

</cfcomponent>