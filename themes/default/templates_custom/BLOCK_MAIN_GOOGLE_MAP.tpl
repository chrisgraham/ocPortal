<script type="text/javascript" src="http://www.google.com/jsapi"></script>
{+START,IF,{$EQ,{CLUSTER},1}}
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclustererplus/src/markerclusterer_packed.js"></script>
{+END}
<script type="text/javascript">// <![CDATA[
	var data_map;
	function google_map_initialize()
	{
		var bounds=new google.maps.LatLngBounds();
		var center=new google.maps.LatLng({$?,{$IS_EMPTY,{LATITUDE}},0.0,{LATITUDE}},{$?,{$IS_EMPTY,{LONGITUDE}},0.0,{LONGITUDE}});
		data_map=new google.maps.Map(document.getElementById('{DIV_ID;}'),
		{
			zoom: {ZOOM},
			{+START,IF,{$NEQ,{CENTER},1}}
				center: center,
			{+END}
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			overviewMapControl: true,
			overviewMapControlOptions:
			{
				opened: true
			},
		});

		var infoWindow=new google.maps.InfoWindow();

		{$,Close InfoWindow when clicking anywhere on the map.}
		google.maps.event.addListener(data_map, 'click', function ()
		{
			infoWindow.close();
		});

		var data=[
			{+START,LOOP,DATA}
				{+START,IF,{$NEQ,{_loop_key},0}},{+END}
				['{ENTRY_TITLE;^/}',{LATITUDE},{LONGITUDE},{CC_ID},{ID},'{ENTRY_CONTENT;^/}',{STAR}]
			{+END}
		];

		{$,Show markers}
		var latLng,markerOptions,marker;
		var bound_length=0;
		{+START,IF,{$EQ,{CLUSTER},1}}
		var markers=[];
		{+END}
		{+START,IF,{$AND,{$NEQ,{MIN_LATITUDE},{MAX_LATITUDE}},{$NEQ,{MIN_LONGITUDE},{MAX_LONGITUDE}}}}
			{+START,IF_NON_EMPTY,{MIN_LATITUDE}{MIN_LONGITUDE}}
				latLng=new google.maps.LatLng({MIN_LATITUDE}, {MIN_LONGITUDE});
				bounds.extend(latLng);
				bound_length++;
			{+END}
			{+START,IF_NON_EMPTY,{MAX_LATITUDE}{MAX_LONGITUDE}}
				latLng=new google.maps.LatLng({MAX_LATITUDE}, {MAX_LONGITUDE});
				bounds.extend(latLng);
				bound_length++;
			{+END}
		{+END}
		for (var i=0; i < data.length; i++)
		{
			latLng=new google.maps.LatLng(data[i][1], data[i][2]);
			bounds.extend(latLng);
			bound_length++;

			markerOptions={
				position: latLng,
				title: data[i][0]
			};

			{$, Reenable if you have put appropriate images in place
				var categoryIcon="{$BASE_URL#}/themes/default/images_custom/map_icons/catalogue_category_" + data[i][3] + ".png";
				markerOptions.icon=categoryIcon;
			}
			if (data[i][6]==1)
			{
				var starIcon="{$BASE_URL#}/themes/default/images_custom/star-3.png";
				markerOptions.icon=starIcon;
			}

			marker=new google.maps.Marker(markerOptions);

			{+START,IF,{$EQ,{CLUSTER},1}}
				markers.push(marker);
			{+END}
			{+START,IF,{$NEQ,{CLUSTER},1}}
				marker.setMap(data_map);
			{+END}

			google.maps.event.addListener(marker, 'click', (function (argMarker, entry_title, entry_id, entry_content)
			{
				return function ()
				{
					{$,Dynamically load entry details only when their marker is clicked.}
					var content=entry_content.replace(/<colgroup>(.|\n)*<\/colgroup>/,'').replace(/&nbsp;/g,' ');
					if (content != "")
					{
						infoWindow.setContent('<div class="global_middle_faux float_surrounder">'+content+'<\/div>');
						infoWindow.open(data_map, argMarker);
					}
				};
			})(marker, data[i][0], data[i][4], data[i][5])); {$,These are the args passed to the dynamic function above.}
		}

		{+START,IF,{$EQ,{CLUSTER},1}}
			var markerCluster=new MarkerClusterer(data_map, markers);
		{+END}

		{$,Fit the map around the markers, but only if we want the map centered.}
		{+START,IF,{$EQ,{CENTER},1}}
			if (bound_length==0) {$,We may have to auto-center after all}
			{
				data_map.setCenter(center);
			} else
			{
				data_map.fitBounds(bounds);
			}
		{+END}

		{$,Sample code to grab clicked positions
			var lastPoint;
			google.maps.event.addListener(data_map, "mousemove", function(point) \{
				lastPoint=point.latLng;
			\});
			google.maps.event.addListener(data_map, "click", function() \{
				console.log(lastPoint.lat() + ', ' + lastPoint.lng());
			\});
		}
	}
	google.load("maps", "3",  {callback: google_map_initialize, other_params:"sensor=true"{+START,IF_NON_EMPTY,{REGION}}, region:'{REGION}'{+END}});
//]]></script>

<section class="box box___block_main_google_map"><div class="box_inner">
	<h3>{TITLE*}</h3>

	<div id="{DIV_ID*}" style="width:{WIDTH}; height:{HEIGHT}"></div>
</div></section>

