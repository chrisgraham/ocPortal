<script type="text/javascript" src="http://www.google.com/jsapi"></script>
{+START,IF,{$EQ,{CLUSTER},1}}
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclustererplus/src/markerclusterer_packed.js"></script>
{+END}
<script type="text/javascript">// <![CDATA[
	function google_map_users_initialize()
	{
		var bounds = new google.maps.LatLngBounds();
		var center = new google.maps.LatLng({$?,{$IS_EMPTY,{LATITUDE}},0.0,{LATITUDE}},{$?,{$IS_EMPTY,{LONGITUDE}},0.0,{LONGITUDE}});
		var map = new google.maps.Map(document.getElementById('map_canvas'),
		{
			zoom: {ZOOM},
			center: center,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			overviewMapControl: true,
			overviewMapControlOptions:
			{
				opened: true
			},
		});
		
		{+START,IF_EMPTY,{LATITUDE}}
			if (google.loader.ClientLocation)
			{
				map.setCenter(new google.maps.LatLng(google.loader.ClientLocation.latitude, google.loader.ClientLocation.longitude), 15);
			} else
			{
				if (typeof navigator.geolocation!='undefined')
				{
					try
					{
						navigator.geolocation.getCurrentPosition(function(position) {
							map.setCenter(google.maps.LatLng(position.coords.latitude,position.coords.longitude));
						});
					}
					catch (e) {};
				} 
			}
		{+END}

		var infoWindow = new google.maps.InfoWindow();

		{$,Close InfoWindow when clicking anywhere on the map.}
		google.maps.event.addListener(map, 'click', function ()
		{
			infoWindow.close();
		});
	
		{DATA}

		{$,Show markers}
		{+START,IF,{$EQ,{CLUSTER},1}}
		var markers = [];
		{+END}
		for (var i = 0; i < data.length; i++)
		{
			var latLng = new google.maps.LatLng(data[i][1], data[i][2]);
			bounds.extend(latLng);

			var markerOptions = {
				position: latLng,
				title: '{USERNAME_PREFIX}' + data[i][0]
			};

			{$, Reenable if you have put appropriate images in place
				var usergroupIcon = new GIcon(G_DEFAULT_ICON);
				usergroupIcon.image = "{$BASE_URL#}/themes/default/images_custom/map_icons/usergroup_" + data[i][3] + ".png";
				markerOptions.icon = usergroupIcon;
			}

			var marker = new google.maps.Marker(markerOptions);

			{+START,IF,{$EQ,{CLUSTER},1}}
				markers.push(marker);
			{+END}
			{+START,IF,{$NEQ,{CLUSTER},1}}
				marker.setMap(map);
			{+END}

			google.maps.event.addListener(marker, 'click', (function (argMarker, argMember)
			{
				return function ()
				{
					{$,Dynamically load a specific members details only when their marker is clicked.}
					var reply = load_XML_doc("{$BASE_URL}/data_custom/get_member_tooltip.php?member=" + argMember+keep_stub());
					var content = reply.responseXML.documentElement.getElementsByTagName('result')[0].firstChild.nodeValue;
					if (content != "")
					{
						infoWindow.setContent(content);
						infoWindow.open(map, argMarker);
					}
				};
			})(marker, data[i][0])); {$,These are the args passed to the dynamic function above.}
		}

		{+START,IF,{$EQ,{CLUSTER},1}}
			var markerCluster = new MarkerClusterer(map, markers);
		{+END}

		{$,Fit the map around the markers, but only if we want the map centered.}
		{+START,IF,{$EQ,{CENTER},1}}
			map.fitBounds(bounds);
		{+END}

		{+START,IF,{$EQ,{GEOLOCATE_USER},1}}
			{+START,IF_NON_EMPTY,{SET_COORD_URL}}
				{$,Geolocation for current member to get stored onto the map}
				if (typeof navigator.geolocation!='undefined')
				{
					try
					{
						navigator.geolocation.getCurrentPosition(function(position) {
							load_XML_doc('{SET_COORD_URL;}'+position.coords.latitude+'_'+position.coords.longitude+keep_stub());
							var initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
							map.setCenter(initialLocation);
						});
					}
					catch (e) {};
				}
			{+END}
		{+END}

		{$,Sample code to grab clicked positions
			var lastPoint;
			google.maps.event.addListener(map, "mousemove", function(point) \{
				lastPoint = point.latLng;
			\});
			google.maps.event.addListener(map, "click", function() \{
				console.log(lastPoint.lat() + ', ' + lastPoint.lng());
			\});
		}
	}
	google.load("maps", "3",  {callback: google_map_users_initialize, other_params:"sensor=false"{+START,IF_NON_EMPTY,{REGION}}, region:'{REGION}'{+END}});
//]]></script>

{+START,BOX,{TITLE*}}
	<div id="map_canvas" style="width:{WIDTH}; height:{HEIGHT}"></div>
{+END}
