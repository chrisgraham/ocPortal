<script type="text/javascript" src="http://www.google.com/jsapi"></script>
{+START,IF,{$EQ,{CLUSTER},1}}
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclustererplus/src/markerclusterer_packed.js"></script>
{+END}
<script type="text/javascript">// <![CDATA[
	function google_map_users_initialize()
	{
		var bounds = new google.maps.LatLngBounds();
		var center = new google.maps.LatLng({$?,{$IS_EMPTY,{LATITUDE}},0.0,{LATITUDE}},{$?,{$IS_EMPTY,{LONGITUDE}},0.0,{LONGITUDE}});
		var map = new google.maps.Map(document.getElementById('{DIV_ID;}'),
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
		
		var infoWindow = new google.maps.InfoWindow();

		{$,Close InfoWindow when clicking anywhere on the map.}
		google.maps.event.addListener(map, 'click', function ()
		{
			infoWindow.close();
		});

		var data=[
			{+START,LOOP,DATA}
				{+START,IF,{$NEQ,{_loop_key},0}},{+END}
				['{ENTRY_TITLE;}',{LATITUDE},{LONGITUDE},{CC_ID},{ID}]
			{+END}
		];

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
				title: data[i][0]
			};

			{$, Reenable if you have put appropriate images in place
				var usergroupIcon = new GIcon(G_DEFAULT_ICON);
				usergroupIcon.image = "{$BASE_URL#}/themes/default/images_custom/map_icons/catalogue_category_" + data[i][3] + ".png";
				markerOptions.icon = usergroupIcon;
			}

			var marker = new google.maps.Marker(markerOptions);

			{+START,IF,{$EQ,{CLUSTER},1}}
				markers.push(marker);
			{+END}
			{+START,IF,{$NEQ,{CLUSTER},1}}
				marker.setMap(map);
			{+END}

			google.maps.event.addListener(marker, 'click', (function (argMarker, entry_title, entry_id)
			{
				return function ()
				{
					{$,Dynamically load a specific members details only when their marker is clicked.}
					var content = entry_title{+START,IF,{$EQ,{SHOW_LINKS},1}}+': <a href="'+'{ENTRIES_URL*}'.replace('%21',entry_id)+'">{!GO_TO_MAP_ENTRY}</a>'{+END};
					if (content != "")
					{
						infoWindow.setContent(content);
						infoWindow.open(map, argMarker);
					}
				};
			})(marker, data[i][0], data[i][4])); {$,These are the args passed to the dynamic function above.}
		}

		{+START,IF,{$EQ,{CLUSTER},1}}
			var markerCluster = new MarkerClusterer(map, markers);
		{+END}

		{$,Fit the map around the markers, but only if we want the map centered.}
		{+START,IF,{$EQ,{CENTER},1}}
			map.fitBounds(bounds);
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
	<div id="{DIV_ID*}" style="width:{WIDTH}; height:{HEIGHT}"></div>
{+END}

