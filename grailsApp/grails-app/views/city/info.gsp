<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="layout" content="main" />
<title>
	${cityInstance.name} info
</title>

<link href="../../css/jquery.zweatherfeed.css" rel="stylesheet"
	type="text/css" />
<link href="../../css/jquery.zgooglemap.css" rel="stylesheet"
	type="text/css" />
<link href="../../css/jquery.zflickrfeed.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet"
	href="${resource(dir: 'css/galleria/themes/classic', file:'galleria.classic.css')}"
	type="text/css">


<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script src="../../js/jquery.zweatherfeed.min.js" type="text/javascript"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false&region=ES"
	type="text/javascript"></script>
<script src="../../js/jquery.zgooglemap.min.js" type="text/javascript"></script>
<script src="../../js/jquery.zflickrfeed.min.js" type="text/javascript"></script>
<script src="../../js/galleria/galleria-1.2.5.min.js"></script>
<script src="../../js/galleria/plugins/flickr/galleria.flickr.min.js"></script>



<script>
var aLocations = new Array();
var aTitles = new Array();
var aDetails = new Array();

aLocations = [
'${cityInstance.name},${cityInstance.name},${cityInstance.country}'
];
aTitles = [
'${cityInstance.name}'
];
aSummary = [
'<h3>${cityInstance.name}</h3><p>${cityInstance.name} is a city of ${cityInstance.country}...</p>'
]; 

$(document).ready(function () {
  $('#tabs').tabs();
  $('#weather').weatherfeed(['${flash.code}']);
  $('#gmap').GoogleMap(aLocations, aTitles, aSummary, {
	  type: 3,
	  zoom: 9
	});
  $('#flicker').flickrfeed('','${cityInstance.name}', {
	    limit: 5
	  });
  Galleria.loadTheme('../../css/galleria/themes/classic/galleria.classic.min.js');
  $('#galleria').galleria({
      height: 500,
	  flickr: 'search:${cityInstance.name}',
	  flickrOptions: {
	  	sort: 'relevance',
	  	description: 'true'
	  }
	});
});



</script>
</head>
<body>

	<div id="tabs">
		<ul>
			<li><a href="#tabs-1"><g:message
						code="default.tab.information.name" default="General Information" /></a></li>
			<li><a href="#tabs-2"><g:message
						code="default.tab.news.name" default="News" /></a></li>
			<li><a href="#tabs-3"><g:message
						code="default.tab.photos.name" default="Photos" /></a></li>
			<g:message code="default.info.code.label"
				args="[cityInstance.name,flash.code]"
				default="Information about ${cityInstance.name} with code ${flash.code}" />
			<li><a href="#tabs-4"><g:message
						code="default.tab.wikipedia.name" default="Wikipedia" /></a></li>
		
<%--			${cityInstance.name}--%>
<%--		with code--%>
<%--		${flash.code}--%>
		</ul>
		<div id="tabs-1">
			<div id="cabecera" style="margin-bottom: 20px;">
				<div id="weather" style="float: left; margin: 0px; width: 250px;"></div>
				<div id="gmap" style="float: right;"></div>
			</div>
			<div id="galleria" style="margin-top: 20px;"></div>
		</div>
		<div id="tabs-2">
			<g:each var="news" in="${flash.lnews}">
				<p>
					${news.title}
				</p>
				<p>
					${news.description}
				</p>
			</g:each>

		</div>

		<div id="tabs-3">
			<div id="flicker"></div>

		</div>
		<div id="tabs-4">
		<div id="wikipedia">
<%--			${flash.wikipedia}--%>
			</div>

		</div>
	</div>


	<a href="/city/index"><g:message code="default.backtolist.name"
			default="Back to city list" /></a>


	<div class="body"></div>
</body>
</html>