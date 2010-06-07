<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
<meta name="description" content="description"/>
<meta name="keywords" content="keywords"/> 
<meta name="author" content="author"/> 
<cfoutput>
	<link rel="stylesheet" type="text/css" href="#resp.encodeURL('/assets/css/styles.css')#" media="screen"/>
</cfoutput>
<title>cfdistro</title>
</head>

<body>

<div class="container">
		
	<div class="main">

		<cfoutput>#body#</cfoutput>

	</div>

	<div class="navigation">
		<a href="index.cfm"><cfoutput><img src="#resp.encodeURL('/assets/images/cfdistro.png')#" border="0"></cfoutput></a>

		<h1>Distros</h1>
		<ul>
<cfoutput>
			<li><a href="#resp.encodeURL('index.cfm?action=distro.list')#" title="View the list of distros">List</a></li>
			<li><a href="#resp.encodeURL('index.cfm?action=distro.form')#" title="Fill out form to add new distro">Add New</a></li>
</cfoutput>
		</ul>

		<h1>Recent Test Results</h1>
		<ul>
			<li><a href="index.html">consequat molestie</a></li>
		</ul>

		<h1>Recent Builds</h1>
		<ul>
			<li><a href="index.html">consequat molestie</a></li>
		</ul>


		<h1>cfdistro</h1>
		<ul>
<cfoutput>			
			<li><a href="#resp.encodeURL("index.cfm?action=distro.loadpersisted")#" title="Loads any saved distros">Load Persisted Distros</a></li>
			<li><a href="#resp.encodeURL('index.cfm?action=distro.persist')#" title="Saves distros to disk">Persist All Distros</a></li>
			<li><a href="#resp.encodeURL('/index.cfm??action=distro.default&reload=true')#" title="Resets framework cache">Reload App</a></li>
</cfoutput>
		</ul>

	</div>
	
	<div class="clearer"><span></span></div>
<cfoutput>
	<div class="footer">&copy; 2006 <a href="#resp.encodeURL('/')#">cfdistro</a>. Valid <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> &amp; <a href="http://validator.w3.org/check?uri=referer">XHTML</a>. Template design by <a href="http://templates.arcsin.se">Arcsin</a>
</cfoutput>	
	</div>

</div>

</body>

</html>