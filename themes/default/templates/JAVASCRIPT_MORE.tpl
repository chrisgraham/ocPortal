"use strict";

/**
 * debugFunctions.js
 *
 * This file contains a collection of debug functions for javascript.
 *
 * This source file is subject to version 2.1 of the GNU Lesser
 * General Public License (LGPL), found in the file LICENSE that is
 * included with this package, and is also available at
 * http://www.gnu.org/copyleft/lesser.html.
 * @package	  Javascript
 *
 * @author		Dieter Raber <dieter@dieterraber.net>
 * @copyright	2004-12-27
 * @version	  1.0
 * @license	  http://www.gnu.org/copyleft/lesser.html
 *
 */

/**
 * TOC
 *
 * - getObjectProperties
 * - print_ob
 * - alert_ob
 * - window_ob
 *
 * - format_r
 * - print_r
 * - alert_r
 * - window_r
 */

/**
 * showProps
 *
 * Shows the properties of an given object
 *
 * object object
 * @return array
 *
 * Use print_ob(), alert_ob() or window_ob() to display the result
 */
function getObjectProperties(item)
{
  var retVal = '';
  for (var prop in item)
  {
	 if (item[prop].constructor != Function)
	 {
		retVal += prop + ' => ' + item[prop] + '\n';
	 }
  }
  return retVal;
}




/**
 * showProps
 *
 * Shows the properties of an given object
 *
 * object object
 * @return array
 *
 * Use print_ob(), alert_ob() or window_ob() to display the result
 */
function getUserFunctions()
{
  var retVal = '';
  for (var prop in document)
  {
//	 if (document[prop].constructor == Function)
//	 {
//		retVal += prop + ' => ' + document[prop] + '\n';
//	 }
  }
  return document;
}



/**
 * print_ob(), alert_ob(), window_ob()
 *
 * These three functions are different ways to display the result of getObjectProperties()
 * print_ob uses document.write and can hence only be called onload
 * alert_ob displays the result in an alert box
 * window_ob opens a popup window and writes the results there
 */
function alert_ob(expr)
{
  alert(getObjectProperties(expr))
}

function window_ob(expr)
{
  var win = window.open('', 'format','width=400,height=300,left=50,top=50,status,menubar,scrollbars,resizable');
  win.document.open();
  win.document.write('<pre>' + getObjectProperties(expr) + '</pre>');
  win.document.close()
  try
  {
		win.focus();
  }
  catch (e) {};
}

function print_ob(expr)
{
  document.write('<pre>' + getObjectProperties(expr) + '</pre>');
}


/**
 * format_r
 *
 * Returns human-readable information about a variable
 *
 * format_r() returns information about a variable in a way that's readable by humans.
 * If given a string, integer or float, the value itself will be printed.
 * If given an array, values will be presented in a format that shows keys and elements.
 *
 * example:
 *	test = new Array ('foo', 'bar', 'foobar')
 *	format_r(test)
 *	returns: Array
 *				{
 *					  [0] => foo
 *					  [1] => bar
 *					  [3] => foobar
 *				}
 *
 */
function format_r(expr)
{
  if (typeof window.outputFormat=='undefined') return false; // This is actually defined at run-time

  var dim	 = 0;
  var padVal = '\xA0\xA0\xA0\xA0\xA0';
  var retVal;

  switch(typeof expr)
  {
	 case 'string':
	 case 'number':
		retVal = expr;
		break;
	 case 'object':
		retVal = 'Array\n { \n' + outputFormat(expr, dim) + '\n } ';
		break;
	 default:
		retVal = Null;
  }

  function pad(dim)
  {
	 var padding = '';
	 for (var i = 0; i < dim; i++)
	 {
		padding += padVal;
	 }
	 return padding;
  }

  function outputFormat(expr, dim)
  {
	 if (typeof window.pad=='undefined') return false; // This is actually defined at run-time

	 var retVal = '';
	 for (var key in expr)
	 {
		  if (typeof expr[key] == 'object' && expr[key].constructor == Array)
		  {
			 retVal += padVal + pad(dim) + '[' + key + '] => Array\n'
						+ padVal + pad(dim) + ' { \n'
						+ outputFormat(expr[key], dim + 1) + padVal + pad(dim) + ' } \n';
		  }
		  else if (expr[key].constructor == Function)
		  {
			 continue;
		  }
		  else
		  {
			 retVal = retVal + padVal + pad(dim) + '[' + key + '] => ' + expr[key] + '\n';
		  }
	 }
	 return retVal;
  }
  return retVal;
}

/**
 * print_r(), alert_r(), window_r()
 *
 * These three functions are just different ways to display the result of format_r()
 * print_r uses document.write and can hence only be called onload
 * alert_r displays the result in an alert box
 * window_r opens a popup window and writes the results there
 */
function alert_r(expr)
{
  alert(format_r(expr))
}

function print_r(expr)
{
  document.write('<pre>' + format_r(expr) + '</pre>');
}

/**
 * arrayFunctions.js
 *
 * This file contains a collection of array functions for javascript.
 * Most of them are inspired by their PHP equivalent.
 *
 * This source file is subject to version 2.1 of the GNU Lesser
 * General Public License (LPGL), found in the file LICENSE that is
 * included with this package, and is also available at
 * http://www.gnu.org/copyleft/lesser.html.
 * @package	  Javascript
 *
 * @author		Dieter Raber <dieter@dieterraber.net>
 * @copyright	2004-12-27
 * @version	  1.0
 * @license	  http://www.gnu.org/copyleft/lesser.html
 *
 */

/**
 * TOC
 * 
 * - arrayUnique
 * - inArray
 */ 
 
/**
 * arrayUnique
 *
 * Removes duplicate values from an array. It takes input array and 
 * returns a new array without duplicate values. The original keys
 * are preserved
 *
 * object array
 * @return array
 *
 * example:
 *	test = new Array ('foo', 'bar', 'foo')
 *	test.arrayUnique()  // returns the array ('foo', 'bar')
 *
 */
Array.prototype.arrayUnique = function()
{
  var uniqueArr = new Array();
  var valueExists;
  for (var origKey in this)
  {
	 valueExists = false;
	 for(var uniqueKey in uniqueArr)
	 {
		if(uniqueArr[uniqueKey] == this[origKey])
		{
		  valueExists = true;
		}
	 }
	 if(!valueExists)
	 {
		uniqueArr[origKey] = this[origKey];
	 }
  }
  return uniqueArr;
}


/**
 * inArray
 *
 * Checks if a value exists in an array 
 * Searches an array for a given value needle and returns TRUE 
 * if it is found in the array, FALSE otherwise.
 *
 * object array
 * param  mixed
 * @return boolean
 *
 * example:
 *	testArray  = new Array ('foo', 'bar', 'baz')
 *	testNeedle = 'foo'
 *	testArray.inArray(testNeedle) //returns true
 *
 */

Array.prototype.inArray = function(needle)
{
  for(var key in this)
  {
	 if(this[key] === needle)
	 {
		return true;
	 }
  }
  return false;
}

/**
 * arrayDelete
 *
 * Removes the first occurence of a value from an array. This function is NEW (24/2/06) by ocProducts.
 *
 * object array
 * param  mixed
 *
 * example:
 *	testArray  = new Array ('foo', 'bar', 'baz')
 *	testNeedle = 'foo'
 *	testArray.arrayDelete(testNeedle) //array becomes Array ('bar', 'baz')
 *
 */

Array.prototype.arrayDelete = function(needle)
{
  for(var key in this)
  {
	 if(this[key] === needle)
	 {
		 this.splice(key,1);
	 }
  }
  return this;
}

/**
 * requestVars.js
 *
 * This file contains functions to access the content of cookies
 * and GET parameters easily for javascript.
 * They are inspired by their PHP equivalent.
 *
 * This source file is subject to version 2.1 of the GNU Lesser
 * General Public License (LPGL), found in the file LICENSE that is
 * included with this package, and is also available at
 * http://www.gnu.org/copyleft/lesser.html.
 * @package	  Javascript
 *
 * @author		Dieter Raber <dieter@dieterraber.net>
 * @copyright	2004-12-27
 * @version	  1.0
 * @license	  http://www.gnu.org/copyleft/lesser.html
 *
 */

/**
 * TOC
 *
 * - readGet
 * - readCookies
 */


/**
 * _GET is the equivalent to PHP's $_GET
 * An associative array of variables passed to the current script
 * via the HTTP GET method. This function is called onload.
 * This means that as soon as this file is included _GET will be available
 *
 * example:
 *	If the curent URL contains GET parameters e.g.
 *	myurl.htm?color1=red&color2=blue
 *	then _GET['color1'] will contain 'red'
 *	and  _GET['color2'] will contain 'blue'
 */

function readGet()
{
  var _GET	 = new Array();
  var uriStr  = window.location.href.replace(/&amp;/g, '&');
  var paraArr, paraSplit;

  if (uriStr.indexOf('?') > -1)
  {
	 var uriArr  = uriStr.split('?');
	 var paraStr = uriArr[1];
  }
  else
  {
	 return _GET;
  }

  if (paraStr.indexOf('&') > -1)
  {
	 paraArr = paraStr.split('&');
  }
  else
  {
	 paraArr = new Array(paraStr)
  }

  for(var i = 0; i < paraArr.length; i++)
  {
	 paraArr[i] = paraArr[i].indexOf('=') > -1
					? paraArr[i]
					: paraArr[i] + '=';
	 paraSplit  = paraArr[i].split('=')
	 _GET[paraSplit[0]] = decodeURI(paraSplit[1].replace(/\+/g, ' '));
  }
  return _GET;
}
var _GET = readGet();



/**
 * stringFunctions.js
 *
 * This file contains a collection of string functions for javascript.
 * Most of them are inspired by their PHP equivalent.
 *
 * This source file is subject to version 2.1 of the GNU Lesser
 * General Public License (LPGL), found in the file LICENSE that is
 * included with this package, and is also available at
 * http://www.gnu.org/copyleft/lesser.html.
 * @package	  Javascript
 *
 * @author		Dieter Raber <dieter@dieterraber.net>
 * @copyright	2004-12-27
 * @version	  1.0
 * @license	  http://www.gnu.org/copyleft/lesser.html
 *
 */

/**
 * TOC
 *
 * - hex2rgb
 * - htmlentities
 * - trim
 * - ucfirst
 * - strPad
 */

/**
 * hex2rgb
 *
 * Convert hexadecimal color triplets to RGB
 *
 * Expects an hexadecimal color triplet (case insensitive)
 * Returns an array containing the decimal values
 * for r, g and b.
 *
 * example:
 *	test = 'ff0033'
 *	test.hex2rgb() //returns the array (255,00,51)
 */

String.prototype.hex2rgb = function()
{
  var red, green, blue;
  var triplet = this.toLowerCase().replace(/#/, '');
  var rgbArr  = new Array();

  if(triplet.length == 6)
  {
	 rgbArr[0] = parseInt(triplet.substr(0,2), 16)
	 rgbArr[1] = parseInt(triplet.substr(2,2), 16)
	 rgbArr[2] = parseInt(triplet.substr(4,2), 16)
	 return rgbArr;
  }
  else if(triplet.length == 3)
  {
	 rgbArr[0] = parseInt((triplet.substr(0,1) + triplet.substr(0,1)), 16);
	 rgbArr[1] = parseInt((triplet.substr(1,1) + triplet.substr(1,1)), 16);
	 rgbArr[2] = parseInt((triplet.substr(2,2) + triplet.substr(2,2)), 16);
	 return rgbArr;
  }
  else
  {
	 throw triplet + ' is not a valid color triplet.';
  }
}


/**
 * htmlEntities
 *
 * Convert all applicable characters to HTML entities
 *
 * object string
 * @return string
 *
 * example:
 *	test = '‰ˆ¸'
 *	test.htmlEntities() //returns '&auml;&ouml;&uuml;'
 */

String.prototype.htmlEntities = function()
{
  var chars = new Array ('&','<','>');

  var entities = new Array ('amp','lt','gt');

  var newString = this;
  var myRegExp;
  for (var i = 0; i < chars.length; i++)
  {
	 myRegExp = new RegExp();
	 if (typeof myRegExp.compile!='undefined')
	 {
		 myRegExp.compile(chars[i],'g')
	 } else
	 {
		 myRegExp = new RegExp(chars[i],'g');
	 }
	 newString = newString.replace (myRegExp, '&' + entities[i] + ';');
  }
  return newString;
}

/**
 * addSlashes
 *
 * Add slashes to a value such that it can fit inside a single-quoted string. This function is NEW (24/2/06) by ocProducts.
 *
 * object string
 * @return string
 *
 * example:
 *	test = "'foo'\\"
 *	test.addSlashes() //returns "\\'foo\\'\\\\"
 *
 */

String.prototype.addSlashes = function(needle)
{
  return this.replace(/\\/g,'\\\\').replace(/'/g,'\'');
}




/**
 * trim
 *
 * Strip whitespace from the beginning and end of a string
 *
 * object string
 * @return string
 *
 * example:
 *	test = '\nsomestring\n\t\0'
 *	test.trim()  //returns 'somestring'
 */
String.prototype.trim = function()
{
  return this.replace(/^\s*([^ ]*)\s*$/, '$1');
}


/**
 * ucfirst
 *
 * Returns a string with the first character capitalized,
 * if that character is alphabetic.
 *
 * object string
 * @return string
 *
 * example:
 *	test = 'john'
 *	test.ucfirst() //returns 'John'
 */

String.prototype.ucfirst = function()
{
  var firstLetter = this.charCodeAt(0);
  if((firstLetter >= 97 && firstLetter <= 122)
	  || (firstLetter >= 224 && firstLetter <= 246)
	  || (firstLetter >= 249 && firstLetter <= 254))
  {
	 firstLetter = firstLetter - 32;
  }
  alert(firstLetter)
  return String.fromCharCode(firstLetter) + this.substr(1,this.length -1)
}


/**
 * strPad
 *
 * Pad a string to a certain length with another string
 *
 * This functions returns the input string padded on the left, the right, or both sides
 * to the specified padding length. If the optional argument pad_string is not supplied,
 * the output is padded with spaces, otherwise it is padded with characters from pad_string
 * up to the limit.
 *
 * The optional argument pad_type can be STR_PAD_RIGHT, STR_PAD_LEFT, or STR_PAD_BOTH.
 * If pad_type is not specified it is assumed to be STR_PAD_RIGHT.
 *
 * If the value of pad_length is negative or less than the length of the input string,
 * no padding takes place.
 *
 * object string
 * @return string
 *
 * examples:
 *	var input = 'foo';
 *	input.strPad(9);							 // returns "foo		"
 *	input.strPad(9, "*+", STR_PAD_LEFT);  // returns "*+*+*+foo"
 *	input.strPad(9, "*", STR_PAD_BOTH);	// returns "***foo***"
 *	input.strPad(9 , "*********");		  // returns "foo******"
 */

var STR_PAD_LEFT  = 0;
var STR_PAD_RIGHT = 1;
var STR_PAD_BOTH  = 2;

String.prototype.strPad = function(pad_length, pad_string, pad_type)
{
  /* Helper variables */
  var num_pad_chars	= pad_length - this.length;/* Number of padding characters */
  var result			 = '';							  /* Resulting string */
  var pad_str_val	  = ' ';
  //var pad_str_len	  = 1;								/* Length of the padding string */
  var pad_type_val	 = STR_PAD_RIGHT;				/* The padding type value */
  var i					= 0;
  var left_pad		  = 0;
  var right_pad		 = 0;
  var error			  = false;
  var error_msg		 = '';
  var output			  = this;

  if (arguments.length < 2 || arguments.length > 4)
  {
	 error	  = true;
	 error_msg = 'Wrong parameter count.';
  }


  else if (isNaN(arguments[0]))
  {
	 error	  = true;
	 error_msg = 'Padding length must be an integer.';
  }
  /* Setup the padding string values if specified. */
  if (arguments.length >= 2)
  {
	 if (pad_string.length == 0)
	 {
		error	  = true;
		error_msg = 'Padding string cannot be empty.';
	 }
	 pad_str_val = pad_string;
	 //pad_str_len = pad_string.length;

	 if (arguments.length >= 3)
	 {
		pad_type_val = pad_type;
		if (pad_type_val < STR_PAD_LEFT || pad_type_val > STR_PAD_BOTH)
		{
		  error	  = true;
		  error_msg = 'Padding type has to be STR_PAD_LEFT, STR_PAD_RIGHT, or STR_PAD_BOTH.'
		}
	 }
  }

  if(error) throw error_msg;

  if(num_pad_chars > 0 && !error)
  {
	 /* We need to figure out the left/right padding lengths. */
	 switch (pad_type_val)
	 {
		case STR_PAD_RIGHT:
		  left_pad  = 0;
		  right_pad = num_pad_chars;
		  break;

		case STR_PAD_LEFT:
		  left_pad  = num_pad_chars;
		  right_pad = 0;
		  break;

		case STR_PAD_BOTH:
		  left_pad  = Math.floor(num_pad_chars / 2);
		  right_pad = num_pad_chars - left_pad;
		  break;
	 }

	 for(i = 0; i < left_pad; i++)
	 {
		output = pad_str_val.substr(0,num_pad_chars) + output;
	 }

	 for(i = 0; i < right_pad; i++)
	 {
		output += pad_str_val.substr(0,num_pad_chars);
	 }
  }

  return output;
}
