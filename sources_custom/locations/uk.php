<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		locations
 */

/**
 * Get a map betweeen regions and possible counties.
 *
 * @return array			Map: region=>list of counties
 */
function get_county_map()
{
	/* NB: Choice of counties dictated by the address data we had available for free. */
	/* NB: We can assume all lower-level region names are globally unique. */

	$data=array(
		'Scotland'=>array('Inverclyde'=>1,'Renfrewshire'=>1,'West Dunbartonshire'=>1,'East Dunbartonshire'=>1,'Glasgow City'=>1,'East Renfrewshire'=>1,'North Lanarkshire'=>1,'Falkirk'=>1,'West Lothian'=>1,'City of Edinburgh'=>1,'Midlothian'=>1,'East Lothian'=>1,'Clackmannanshire'=>1,'Fife'=>1,'Dundee City'=>1,'Angus'=>1,'Aberdeenshire'=>1,'Aberdeen City'=>1,'Moray'=>1,'Highland and Isle of Skye'=>1,'Western Isles'=>1,'Argyll and Bute'=>1,'Perth and Kinross'=>1,'Stirling'=>1,'North Ayrshire'=>1,'East Ayrshire'=>1,'South Ayrshire'=>1,'Dumfries and Galloway'=>1,'South Lanarkshire'=>1,'Scottish Borders'=>1,'Orkney Islands'=>1,'Shetland Islands'=>1,), // http://en.wikipedia.org/wiki/Council_Areas_of_Scotland=http://en.wikipedia.org/wiki/Subdivisions_of_Scotland [NOT http://en.wikipedia.org/wiki/Lieutenancy_areas_of_Scotland OR http://en.wikipedia.org/wiki/Registration_county OR http://en.wikipedia.org/wiki/Large_burghs OR http://en.wikipedia.org/wiki/Regions_and_districts_of_Scotland OR http://en.wikipedia.org/wiki/Counties_of_Scotland]
		'Northern Ireland'=>array('County Antrim'=>1,'County Armagh'=>1,'County Down'=>1,'County Fermanagh'=>1,'County Londonderry'=>1,'County Tyrone'=>1),
		'Wales'=>array('Merthyr Tydfil'=>1,'Caerphilly'=>1,'Blaenau Gwent'=>1,'Torfae'=>1,'Monmouthshire'=>1,'Newport'=>1,'Cardiff'=>1,'Vale of Glamorgan'=>1,'Bridgend'=>1,'Rhondda Cynon Taff'=>1,'Neath Port Talbot'=>1,'Swansea'=>1,'Carmarthenshire'=>1,'Ceredigion'=>1,'Powys'=>1,'Wrexham'=>1,'Flintshire'=>1,'Denbighshire'=>1,'Conwy'=>1,'Gwynedd'=>1,'Isle of Anglesey'=>1,'Pembrokeshire'=>1), // http://en.wikipedia.org/wiki/Administrative_divisions_of_Wales [NOT http://en.wikipedia.org/wiki/Preserved_counties_of_Wales OR http://en.wikipedia.org/wiki/Historic_counties_of_Wales]

		// http://en.wikipedia.org/wiki/Metropolitan_and_non-metropolitan_counties_of_England
		// except Herefordshire+Worcestershire are combined
		// and the following towns weren't promoted to counties: Blackpool, Blackburn with Darwen, Nottingham, Derby, Halton, Warrington, Telford and Wrekin, Leicester, Southend-on-Sea, Thurrock, Luton, Swindon, Medway, Torbay, Plymouth
		// [NOT http://en.wikipedia.org/wiki/Ceremonial_counties_of_England OR http://en.wikipedia.org/wiki/County_borough]
		'North East'=>array('Darlington'=>1,'Middlesbrough'=>1,'Hartlepool'=>1,'Stockton-on-Tees'=>1,'Redcar and Cleveland'=>1,'Northumberland'=>1,'Tyne and Wear'=>1,'County Durham'=>1),
		'North West'=>array('Cheshire'=>1,'Cumbria'=>1,'Greater Manchester'=>1,'Lancashire'=>1,'Merseyside'=>1),
		'Yorkshire and the Humber'=>array('York'=>1,'Kingston upon Hull'=>1,'South Yorkshire'=>1,'West Yorkshire'=>1,'North Yorkshire'=>1,'East Riding of Yorkshire'=>1),
		'East Midlands'=>array('North Lincolnshire'=>1,'North East Lincolnshire'=>1,'Derbyshire'=>1,'Nottinghamshire'=>1,'Lincolnshire'=>1,'Leicestershire'=>1,'Rutland'=>1,'Northamptonshire'=>1),
		'West Midlands'=>array('Hereford and Worcester'=>1,'Shropshire'=>1,'Staffordshire'=>1,'Warwickshire'=>1,'West Midlands county'=>1),
		'East'=>array('Bedfordshire'=>1,'Cambridgeshire'=>1,'Essex'=>1,'Hertfordshire'=>1,'Norfolk'=>1,'Peterborough'=>1,'Suffolk'=>1),
		'South East'=>array('Brighton and Hove'=>1,'Portsmouth'=>1,'Southampton'=>1,'Milton Keynes'=>1,'Berkshire'=>1,'Buckinghamshire'=>1,'East Sussex'=>1,'Hampshire'=>1,'Isle of Wight'=>1,'Kent'=>1,'Oxfordshire'=>1,'Surrey'=>1,'West Sussex'=>1),
		'South West'=>array('Bath and North East Somerset'=>1,'South Gloucestershire'=>1,'North Somerset'=>1,'Bournemouth'=>1,'Poole'=>1,'Somerset'=>1,'Bristol'=>1,'Gloucestershire'=>1,'Wiltshire'=>1,'Dorset'=>1,'Devon'=>1,'Cornwall'=>1),
		'London'=>array('Central London and West End (WC, EC, W, SW)'=>1,'North London (N, EN)'=>1,'East London (E, IG, RM)'=>1,'South East London (SE, BR, DA, TN)'=>1,'South West London (SW, CR, KT, SM, TW)'=>1,'West London (W)'=>1,'North West London (NW, HA, UB)'=>1),
	);
	return $data;
}
