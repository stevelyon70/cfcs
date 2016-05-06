<!--- nav types
	1 - Text
	2 - Link - Direct
	3 - Link - New Window
	4 - Image
	5 - Image - Direct Link
	6 - Image - New Window
	7 - Text - Modal Window
	8 - Image - Modal Window
	10 - Nissan Redline
	11 - 3rd Party Script
	12 - Null
 --->

<cfcomponent>

	<cffunction name="standard" description="shows a standard nav" output="Yes" access="public">
		<!--- arguments --->
		<cfargument name="data_directory" required="true">
		
<nav class="navbar navbar-default" role="navigation">
	<div class="container">
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li class="active"><a href="##">Link</a></li>
			<li><a href="##">Link</a></li>
			<li class="dropdown">
				<a href="##" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="##">Action</a></li>
					<li><a href="##">Another action</a></li>
					<li><a href="##">Something else here</a></li>
					<li class="divider"></li>
					<li><a href="##">Separated link</a></li>
					<li class="divider"></li>
					<li><a href="##">One more separated link</a></li>
				</ul>
			</li>
		</ul>
	</div><!-- /.navbar-collapse -->
</nav>


<!---	<div class="container">
		<div class="navbar">
<cfinclude template="#arguments.data_directory#/nav_data_13.cfm" >
		</div>
	</div>--->

	</cffunction>

</cfcomponent>