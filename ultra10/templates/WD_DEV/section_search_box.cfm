<cfoutput>

<div class="container-fluid">

	<section class="section-search-box">
	
		<div class="container-search-box">

           <cfinvoke component="/cfcs/views/simpleTextSearch" method="displaytextBox">
               <cfinvokeargument name="formWrap" value="yes" />
               <cfinvokeargument name="class" value="form-control input-lg" />
               <cfinvokeargument name="id" value="simpleSrh" />
               <cfinvokeargument name="width" value="500px" />
           </cfinvoke>
		
		</div>	
		
	</section>
	
</div>
</cfoutput>