<script type="text/javascript" src="http://www.google.com/jsapi"></script>
{+START,IF,{$EQ,{CLUSTER},1}}
	<script type="text/javascript" src="https://raw.githubusercontent.com/printercu/google-maps-utility-library-v3-read-only/master/markerclustererplus/src/markerclusterer_packed.js"></script>
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
			}
		});

		{+START,IF_EMPTY,{LATITUDE}}
			if (google.loader.ClientLocation)
			{
				map.setCenter(new google.maps.LatLng(google.loader.ClientLocation.latitude,google.loader.ClientLocation.longitude),15);
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

		var info_window=new google.maps.InfoWindow();

		{$,Close InfoWindow when clicking anywhere on the map.}
		google.maps.event.addListener(map,'click',function ()
		{
			info_window.close();
		});

		{DATA}

		{$,Show markers}
		var markers=[];
		for (var i=0; i < data.length; i++)
		{
			add_data_point(data[i],bounds,markers,info_window,map);
		}

		{+START,IF,{$EQ,{CLUSTER},1}}
			var markerCluster=new MarkerClusterer(map,markers);
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

							add_data_point(['{$USERNAME;}',position.coords.latitude,position.coords.longitude,''],bounds,markers,info_window,map);
						});
					}
					catch (e) {};
				}
			{+END}
		{+END}

		{$,Sample code to grab clicked positions
			var last_point;
			google.maps.event.addListener(map,'mousemove',function(point) \{
				last_point=point.latLng;
			\});
			google.maps.event.addListener(map,'click',function() \{
				console.log(last_point.lat()+', '+last_point.lng());
			\});
		}
	}

	function add_data_point(data_point,bounds,markers,info_window,map)
	{
		var lat_lng=new google.maps.LatLng(data_point[1],data_point[2]);
		bounds.extend(lat_lng);

		var marker_options={
			position: lat_lng,
			title: '{USERNAME_PREFIX}'+data_point[0]
		};

		{$,Reenable if you have put appropriate images in place
			var usergroup_icon=new GIcon(G_DEFAULT_ICON);
			usergroup_icon.image='{$BASE_URL;}/themes/default/images_custom/map_icons/usergroup_'+data_point[3]+'.png';
			marker_options.icon=usergroup_icon;
		}

		var marker=new google.maps.Marker(marker_options);

		{+START,IF,{$EQ,{CLUSTER},1}}
			markers.push(marker);
		{+END}
		{+START,IF,{$NEQ,{CLUSTER},1}}
			marker.setMap(map);
		{+END}

		google.maps.event.addListener(marker,'click',(function (arg_marker,arg_member)
		{
			return function()
			{
				{$,Dynamically load a specific members details only when their marker is clicked.}
				var reply=do_ajax_request('{$BASE_URL;}/data_custom/get_member_tooltip.php?member='+arg_member+keep_stub());
				var content=reply.responseXML.documentElement.getElementsByTagName('result')[0].firstChild.nodeValue;
				if (content!='')
				{
					info_window.setContent('<div class="global_middle_faux float_surrounder">'+content+'<\/div>');
					info_window.open(map,arg_marker);
				}
			};
		})(marker,data_point[0])); {$,These are the args passed to the dynamic function above.}
	}

	google.load('maps','3',{callback: google_map_users_initialize,other_params:'sensor=true'{+START,IF_NON_EMPTY,{REGION}},region:'{REGION}'{+END}});
//]]></script>

<section class="box box___block_main_google_map_users"><div class="box_inner">
	<h3>{TITLE*}</h3>

	<div id="map_canvas" style="width: {WIDTH}; height: {HEIGHT}"></div>
</div></section>
