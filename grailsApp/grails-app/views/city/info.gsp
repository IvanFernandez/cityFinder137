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
	height: 100%;
	<%--
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
<%--	    markers:                [{latitude: 47.670553, longitude: 9.588479, html: "Tettnang, Germany"},--%>
<%--	                             {latitude: 47.65197522925437, longitude: 9.47845458984375, html: "Friedrichshafen, Germany"}],--%>
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
  $('#weather').weatherfeed(['${flash.code}']);
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
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();

	$('#calendar').fullCalendar({
		firstDay: 1,
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		editable: true,
		events: ${flash.my_events}
<%--			[--%>
<%--			{--%>
<%--				title: 'All Day Event',--%>
<%--				start: new Date(y, m, 1)--%>
<%--			},--%>
<%--			{--%>
<%--				title: 'Long Event',--%>
<%--				start: new Date(y, m, d-5),--%>
<%--				end: new Date(y, m, d-2)--%>
<%--			},--%>
<%--			{--%>
<%--				id: 999,--%>
<%--				title: 'Repeating Event',--%>
<%--				start: new Date(y, m, d-3, 16, 0),--%>
<%--				allDay: false--%>
<%--			},--%>
<%--			{--%>
<%--				id: 999,--%>
<%--				title: 'Repeating Event',--%>
<%--				start: new Date(y, m, d+4, 16, 0),--%>
<%--				allDay: false--%>
<%--			},--%>
<%--			{--%>
<%--				title: 'Meeting',--%>
<%--				start: new Date(y, m, d, 10, 30),--%>
<%--				allDay: false--%>
<%--			},--%>
<%--			{--%>
<%--				title: 'Lunch',--%>
<%--				start: new Date(y, m, d, 12, 0),--%>
<%--				end: new Date(y, m, d, 14, 0),--%>
<%--				allDay: false--%>
<%--			},--%>
<%--			{--%>
<%--				title: 'Birthday Party',--%>
<%--				start: new Date(y, m, d+1, 19, 0),--%>
<%--				end: new Date(y, m, d+1, 22, 30),--%>
<%--				allDay: false--%>
<%--			},--%>
<%--			{--%>
<%--				title: 'Click for Google',--%>
<%--				start: new Date(y, m, 28),--%>
<%--				end: new Date(y, m, 29),--%>
<%--				url: 'http://google.com/'--%>
<%--			}--%>
<%--		]--%>
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
					args="[cityInstance.name,flash.code]"
					default="Information about ${cityInstance.name} with code ${flash.code}" />
			</li>
		</ul>
		<div id="tabs-1">
			<div id="cabecera" style="margin-bottom: 20px;">
				<div id="weather" style="float: left; margin: 0px; width: 250px;"></div>
				<%--				<div id="gmap" style="float: right;"></div>--%>
			</div>
			<div id="galleria" style="margin-top: 20px;"></div>
			<div id='calendar'></div>

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
			<div id="map"
				style="width: 547px; height: 320px; border: 1px solid #777; overflow: hidden;"></div>
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
		<div id="tabs-5">

			<div id='calendar'></div>
		</div>

	</div>

	<a href="/cityFinder/city/list"><g:message code="default.backtolist.name"
			default="Back to city list" /></a>
<%--	<a href="/city/list"><g:message code="default.backtolist.name"--%>
<%--			default="Back to city list" /></a>--%>


	<div class="body"></div>
</body>
</html>