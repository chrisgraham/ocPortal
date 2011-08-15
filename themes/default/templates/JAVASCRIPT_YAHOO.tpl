/*
Software License Agreement (BSD License)

Copyright (c) 2006, Yahoo! Inc.
All rights reserved.

Redistribution and use of this software in source and binary forms, with
or without modification, are permitted provided that the following 
conditions are met:

* Redistributions of source code must retain the above
  copyright notice, this list of conditions and the
  following disclaimer.

* Redistributions in binary form must reproduce the above
  copyright notice, this list of conditions and the
  following disclaimer in the documentation and/or other
  materials provided with the distribution.

* Neither the name of Yahoo! Inc. nor the names of its
  contributors may be used to endorse or promote products
  derived from this software without specific prior
  written permission of Yahoo! Inc.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER 
OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


/**
 * @class The Yahoo global namespace
 */
var YAHOO = function() {

	 return {

		  /**
			* Yahoo presentation platform utils namespace
			*/
		  util: {},

		  /**
			* Yahoo presentation platform widgets namespace
			*/
		  widget: {},

		  /**
			* Yahoo presentation platform examples namespace
			*/
		  example: {},

		  /**
			* Returns the namespace specified and creates it if it doesn't exist
			*
			* YAHOO.namespace("property.package");
			* YAHOO.namespace("YAHOO.property.package");
			*
			* Either of the above would create YAHOO.property, then
			* YAHOO.property.package
			*
			* @param  string	sNameSpace String representation of the desired
			*									  namespace
			* @return object				  A reference to the namespace object
			*/
		  namespace: function( sNameSpace ) {

				if (!sNameSpace || !sNameSpace.length) {
					 return null;
				}

				var levels = sNameSpace.split(".");

				var currentNS = YAHOO;

				// YAHOO is implied, so it is ignored if it is included
				for (var i=(levels[0] == "YAHOO") ? 1 : 0; i<levels.length; ++i) {
					 currentNS[levels[i]] = currentNS[levels[i]] || {};
					 currentNS = currentNS[levels[i]];
				}

				return currentNS;

		  }
	 };

} ();

YAHOO.namespace("YAHOO.widget");


