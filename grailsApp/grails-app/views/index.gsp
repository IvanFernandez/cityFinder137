<!doctype html>
<html>
<head>
<meta name="layout" content="main" />
<title>Bienvenidos a cityFinder</title>


<style type="text/css" media="screen">
* {
	padding: 0;
	margin: 0;
}

body {
	font-family: "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif;
}

span.reference {
	position: fixed;
	left: 10px;
	bottom: 10px;
	font-size: 11px;
}

span.reference a {
	color: #fff;
	text-decoration: none;
	text-transform: uppercase;
	text-shadow: 0 1px 0 #000;
}

span.reference a:hover {
	color: #f0f0f0;
}

.box {
	margin: auto 0;
	height: 450px;
	width: 100%;
	position: relative;
	-moz-box-shadow: 0px 0px 5px #444;
	-webkit-box-shadow: 0px 0px 5px #444;
	box-shadow: 0px 0px 5px #444;
	background: #1783BF url(/images/search/click.png) no-repeat 380px 80px;
}

.box h2 {
	background-color: #1275AD;
	border-color: #0E5A85 #0E5A85 #0E5A85;
	border-style: ridge ridge solid;
	border-width: 1px;
	color: #FFFFFF;
	font-size: 22px;
	padding: 10px;
	text-shadow: 1px 1px 1px #000000;
}

div.tip {
<%--	background-color: #1275AD;--%>
<%--	border-color: #0E5A85 #0E5A85 #0E5A85;--%>
<%--	border-style: ridge ridge solid;--%>
	border-width: 1px;
	color: #FFFFFF;
	font-size: 15px;
	padding: 10px;
	text-shadow: 1px 1px 1px #000000;
}
</style>
<%--<link rel="stylesheet" href="css/search.css" type="text/css"--%>
<%--	media="screen" />--%>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="js/search/searchbox.js"></script>
<link rel="stylesheet" href="css/search/searchBoxStyle.css"
	type="text/css" media="screen" />


</head>
<body>
	<div class="content">

		<div class="box">
			<h2>CityFinder</h2>
			<div id="tip" class="tip">Write a city name in the search box below</div>

			<form id="ui_element" action="city/info" method="POST"
				class="sb_wrapper">

				<p>
					<span class="sb_down"> </span> <input class="sb_input" type="text"
						name="city" id="city" /> <input class="sb_search" type="submit"
						value="" />
				</p>

				<ul id="list" class="sb_dropdown" style="display: none;">
					<li class="sb_filter">Filter your search</li>
					<li><input id="all" name="all" type="checkbox" /><label
						for="all"><strong>All Categories</strong></label></li>
					<li><input id="weather" name="weather" type="checkbox" /><label
						for="Weather">Weather</label></li>
					<li><input id="news" name="news" type="checkbox" /><label
						for="News">News</label></li>
					<li><input id="photos" name="photos" type="checkbox" /><label
						for="Photos">Photos</label></li>
					<li><input id="events" name="events" type="checkbox" /><label
						for="Events">Events</label></li>
				</ul>
			</form>
		</div>
	</div>



	<!-- The JavaScript -->

	<%--	<script type="text/javascript"--%>
	<%--		src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>--%>

	<script type="text/javascript">
            $(function() {
				/**
				* the element
				*/
				var $ui 		= $('#ui_element');
				/**
				* on focus and on click display the dropdown, 
				* and change the arrow image
				*/

				$ui.find('.sb_input').bind('focus click',function(){

					$ui.find('.sb_down')

					   .addClass('sb_up')

					   .removeClass('sb_down')

					   .andSelf()

					   .find('.sb_dropdown')

					   .show();

				});

				

				/**

				* on mouse leave hide the dropdown, 

				* and change the arrow image

				*/

				$ui.bind('mouseleave',function(){

					$ui.find('.sb_up')

					   .addClass('sb_down')

					   .removeClass('sb_up')

					   .andSelf()

					   .find('.sb_dropdown')

					   .hide();

				});

				

				/**

				* selecting all checkboxes

				*/

				$ui.find('.sb_dropdown').find('label[for="all"]').prev().bind('click',function(){

					$(this).parent().siblings().find(':checkbox').attr('checked',this.checked).attr('disabled',this.checked);

				});

            });

        </script>



</body>
</html>
