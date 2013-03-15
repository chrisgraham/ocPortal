<script type="text/javascript" src="http://www.google.com/jsapi"></script>
{+START,IF,{$EQ,{CLUSTER},1}}
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclustererplus/src/markerclusterer_packed.js"></script>
{+END}
<script type="text/javascript">// <![CDATA[
	function google_map_users_initialize()
	{
		var bounds=new google.maps.LatLngBounds();
		var center=new google.maps.LatLng({$?,{$IS_EMPTY,{LATITUDE}},0.0,{LATITUDE}},{$?,{$IS_EMPTY,{LONGITUDE}},0.0,{LONGITUDE}});
		var map=new google.maps.Map(document.getElementById('map_canvas'),
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

		var infoWindow=new google.maps.InfoWindow();

		{$,Close InfoWindow when clicking anywhere on the map.}
		google.maps.event.addListener(map, 'click', function ()
		{
			infoWindow.close();
		});

		{DATA}

		{$,Show markers}
		var markers=[];
		for (var i=0; i < data.length; i++)
		{
			add_data_point(data[i],bounds,markers,infoWindow,map);
		}

		{+START,IF,{$EQ,{CLUSTER},1}}
			var markerCluster=new MarkerClusterer(map, markers);
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
							do_ajax_request('{SET_COORD_URL;}'+position.coords.latitude+'_'+position.coords.longitude+keep_stub());
							var initialLocation=new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
							map.setCenter(initialLocation);

							add_data_point(['{$USERNAME;}',position.coords.latitude,position.coords.longitude,''],bounds,markers,infoWindow,map);
						});
					}
					catch (e) {};
				}
			{+END}
		{+END}

		{$,Sample code to grab clicked positions
			var lastPoint;
			google.maps.event.addListener(map, "mousemove", function(point) \{
				lastPoint=point.latLng;
			\});
			google.maps.event.addListener(map, "click", function() \{
				console.log(lastPoint.lat() + ', ' + lastPoint.lng());
			\});
		}
	}

	function add_data_point(data_point,bounds,markers,infoWindow,map)
	{
		var latLng=new google.maps.LatLng(data_point[1], data_point[2]);
		bounds.extend(latLng);

		var markerOptions={
			position: latLng,
			title: '{USERNAME_PREFIX}' + data_point[0]
		};

		{$, Reenable if you have put appropriate images in place
			var usergroupIcon=new GIcon(G_DEFAULT_ICON);
			usergroupIcon.image="{$BASE_URL#}/themes/default/images_custom/map_icons/usergroup_" + data_point[3] + ".png";
			markerOptions.icon=usergroupIcon;
		}

		var marker=new google.maps.Marker(markerOptions);

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
				var reply=do_ajax_request("{$BASE_URL}/data_custom/get_member_tooltip.php?member=" + argMember+keep_stub());
				var content=reply.responseXML.documentElement.getElementsByTagName('result')[0].firstChild.nodeValue;
				if (content != "")
				{
					infoWindow.setContent(content);
					infoWindow.open(map, argMarker);
				}
			};
		})(marker, data_point[0])); {$,These are the args passed to the dynamic function above.}
	}

	google.load("maps", "3",  {callback: google_map_users_initialize, other_params:"sensor=true"{+START,IF_NON_EMPTY,{REGION}}, region:'{REGION}'{+END}});
//]]></script>

<section class="box box___block_main_google_map_users"><div class="box_inner">
	<h3>{TITLE*}</h3>

	<div id="map_canvas" style="width:{WIDTH}; height:{HEIGHT}"></div>
</div></section>
