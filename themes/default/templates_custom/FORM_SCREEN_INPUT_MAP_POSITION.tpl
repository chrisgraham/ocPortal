<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script type="text/javascript">// <![CDATA[
	var marker,map;
	function google_map_users_initialize()
	{
		marker=new google.maps.Marker();
		var bounds=new google.maps.LatLngBounds();
		var center=new google.maps.LatLng({$?,{$IS_EMPTY,{LATITUDE}},0,{LATITUDE;}},{$?,{$IS_EMPTY,{LONGITUDE}},0,{LONGITUDE;}});
		map=new google.maps.Map(document.getElementById('map_position_{NAME;}'),
		{
			zoom: {$?,{$IS_NON_EMPTY,{LATITUDE}},12,1},
			center: center,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			overviewMapControl: true,
			overviewMapControlOptions:
			{
				opened: true
			},
			styles: [{
				featureType: "poi",
				elementType: "labels",
				stylers: [ { visibility: "off" } ]
			}]
		});

		var infoWindow=new google.maps.InfoWindow();

		{$,Close InfoWindow when clicking anywhere on the map.}
		google.maps.event.addListener(map, 'click', function ()
		{
			infoWindow.close();
		});

		{$,Show marker for current position}
		{+START,IF,{$AND,{$IS_NON_EMPTY,{LATITUDE}},{REQUIRED}}}
			place_marker({LATITUDE;},{LONGITUDE;});
			marker.setMap(map);
		{+END}

		{$,Save into hidden fields}
		var lastPoint;
		google.maps.event.addListener(map, "mousemove", function(point) {
			lastPoint=point.latLng;
		});
		google.maps.event.addListener(map, "click", function() {
			document.getElementById('{NAME;}_latitude').value=lastPoint.lat();
			document.getElementById('{NAME;}_longitude').value=lastPoint.lng();
			place_marker(lastPoint.lat(),lastPoint.lng());
			marker.setMap(map);
		});
	}

	function place_marker(latitude,longitude)
	{
		var latLng=new google.maps.LatLng(latitude,longitude);
		marker.setPosition(latLng);
	}

	google.load("maps", "3",  {callback: google_map_users_initialize, other_params:"sensor=false"});
//]]></script>

<div id="map_position_{NAME*}" style="width:100%; height:300px"></div>

<label for="{NAME*}_latitude">
	Latitude
	<input onchange="place_marker(this.form.elements['latitude'].value,this.form.elements['longitude'].value);" type="number" {+START,IF,{REQUIRED}}class="hidden_required" {+END}id="{NAME*}_latitude" name="latitude" value="{LATITUDE*}" />
</label>

<label for="{NAME*}_longitude">
	Longitude
	<input onchange="place_marker(this.form.elements['latitude'].value,this.form.elements['longitude'].value);" type="number" {+START,IF,{REQUIRED}}class="hidden_required" {+END}id="{NAME*}_longitude" name="longitude" value="{LONGITUDE*}" />
</label>

{$REQUIRE_JAVASCRIPT,javascript_ajax}
<form action="{$SELF_URL*}" onsubmit="return false;">
	<div>
		<label for="location">Look at Location:</label>
		<input onclick="return geoposition_user_input('location');" class="search_button" src="{$IMG*,you}" type="image" title="Find yourself" />
		<input id="location" name="location" type="search" value="" />
		<input class="search_button" onclick="return geoposition_map_goto('location',map);" src="{$IMG*,search}" type="image" title="Look around for Location" />
	</div>
</form>
