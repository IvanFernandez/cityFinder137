<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="layout" content="main" />
<title>
	${cityInstance.name} info
</title>

<style type="text/css">
.eventful-badge,.eventful-badge * {
	margin: 0 !important;
	padding: 0 !important;
	border: 0 !important;
	text-align: center !important;
	color: #CCC !important;
	font-family: Arial !important;
	text-decoration: none !important;
}

.eventful-small {
	position: relative !important;
	width: 100px !important;
	font-size: 11px !important;
	line-height: 11px !important;
}

#calendar {
	width: 900px;
	height: 100%; <%--
	position: relative; --%>
	margin: 0 auto;
}
fc-view


 


fc-view-month


 


fc-grid
</style>

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
<%--<script src="http://maps.google.com/maps/api/js?sensor=false&region=ES"--%>
<%--	type="text/javascript"></script>--%>
<%--<script src="../../js/jquery.zgooglemap.min.js" type="text/javascript"></script>--%>
<script src="../../js/jquery.zflickrfeed.min.js" type="text/javascript"></script>
<script src="../../js/galleria/galleria-1.2.5.min.js"></script>
<script src="../../js/galleria/plugins/flickr/galleria.flickr.min.js"></script>

<script type="text/javascript"
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAARwAQmI-wgFQ47AJ0-t5D-RSHIYQK0rWx9IE2QxXCr1QnppSkHBQiIyWzGtiGBiNpWY92_84WsBCZRg"></script>
<script type="text/javascript" src="../../js/jquery.gmap-1.1.0-min.js"></script>

<link rel='stylesheet' type='text/css'
	href='../../js/fullcalendar/fullcalendar.css' />
<link rel='stylesheet' type='text/css'
	href='../../js/fullcalendar/fullcalendar.print.css' media='print' />
<script type='text/javascript'
	src='../../js/jquery-ui-1.8.11.custom.min.js'></script>
<script type='text/javascript'
	src='../../js/fullcalendar/fullcalendar.min.js'></script>

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


var options = 
{
	    latitude:               ${flash.latitude},
	    longitude:              ${flash.longitude},
	    zoom:                   11,
	    markers: ${flash.events},
	    controls:               ["GSmallMapControl", "GMapTypeControl"],
	    scrollwheel:            false,
	    maptype:                G_NORMAL_MAP,
	    html_prepend:           '<div class="gmap_marker">',
	    html_append:            '</div>',
	    icon:
	    {
	        image:              "../../images/blue_flag.png",
	        shadow:             false,
	        iconsize:           [19, 21],
	        shadowsize:         false,
	        iconanchor:         [4, 19],
	        infowindowanchor:   [8, 2]
	    }
	};
$(document).ready(function () {
  $("#map").gMap(options);
  $('#tabs').tabs();
  $('#weather').weatherfeed(['${flash.weatherCode}']);
<%--  $('#gmap').GoogleMap(aLocations, aTitles, aSummary, {--%>
<%--	  type: 3,--%>
<%--	  zoom: 9--%>
<%--	});--%>
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

	$('#calendar').fullCalendar({
		firstDay: 1,
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		editable: true,
		events: ${flash.events}
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
			<li><a href="#tabs-4"><g:message
						code="default.tab.events.name" default="Events" /></a></li>
			<li><a href="#tabs-5"><g:message
						code="default.tab.calendar.name" default="Calendar" /></a></li>
			<li><g:message code="default.info.code.label"
					args="[cityInstance.name,flash.woeid]"
					default="Information about ${cityInstance.name} with code ${flash.woeid}" />
			</li>
		</ul>
		<div id="tabs-1">
			<div id="cabecera" style="margin-bottom: 20px;">
				<div id="weather" style="float: left; margin: 0px; width: 250px;"></div>
				<%--				<div id="gmap" style="float: right;"></div>--%>
			</div>
			<div id="galleria" style="margin-top: 20px;"></div>
			<g:if test="${!flash.isEmptyEvents}">
				<div id='calendar'></div>
			</g:if>
			<g:else>
				<g:message code="default.info.noevents" args="[cityInstance.name]"
					default="There are no events in ${cityInstance.name}" />
			</g:else>

		</div>
		<div id="tabs-2">
			<g:if test="${flash.googleNews != null}">
				<g:each var="news" in="${flash.googleNews}">
					<p>
						${news.title}
					</p>
					<p>
						${news.description}
					</p>
				</g:each>
			</g:if>
			<g:else>
				<g:message code="default.info.nonews" args="[cityInstance.name]"
					default="There are no news in ${cityInstance.name}" />
			</g:else>
		</div>

		<div id="tabs-3">
			<div id="flicker"></div>

		</div>
		<div id="tabs-4">
			<div id="map"
				style="width: 100%; height: 500px; border: 1px solid #777; overflow: hidden;"></div>

			<div class="eventful-badge eventful-small">
				<img src="http://api.eventful.com/images/powered/eventful_58x20.gif"
					alt="Local Events, Concerts, Tickets">
				<p>
					<a href="http://eventful.com/">Events</a> by Eventful
				</p>
			</div>
			<div id="wikipedia">
				<%--		pefsdfqueño cambio	${flash.wikipedia}--%>
			</div>

		</div>
		<div id="tabs-5"></div>

	</div>

<%--	<a href="/cityFinder/city/list"><g:message--%>
<%--			code="default.backtolist.name" default="Back to city list" /></a>--%>
		<a href="/city/list"><g:message code="default.backtolist.name"
				default="Back to city list" /></a>


	<div class="body"></div>
</body>
</html>