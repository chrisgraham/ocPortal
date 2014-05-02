/**
 * swfupload.js
 * 
 * SWFUpload: http://www.swfupload.org, http://swfupload.googlecode.com
 *
 * mmSWFUpload 1.0: Flash upload dialog - http://profandesign.se/swfupload/,  http://www.vinterwebb.se/
 *
 * SWFUpload is (c) 2006-2007 Lars Huring, Olov Nilzon and Mammon Media and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * SWFUpload 2 is (c) 2007-2008 Jake Roberts and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */


/* ******************* */
/* Constructor & Init  */
/* ******************* */
var SWFUpload;

if (typeof SWFUpload == 'undefined') {
	SWFUpload = function (settings) {
		this.initSWFUpload(settings);
	};
}


SWFUpload.prototype.initSWFUpload = function (settings) {
	try {
		this.customSettings = {};	// A  where developers can place their own settings associated with this instance.
		this.settings = settings;
		this.eventQueue = [];
		this.movieName = "SWFUpload_" + SWFUpload.movieCount++;
		this.movieElement = null;


		// Setup global control tracking
		SWFUpload.instances[this.movieName] = this;

		// Load the settings.  Load the Flash movie.
		this.initSettings();
		this.loadFlash();
		this.displayDebugInfo();
	} catch (ex) {
		delete SWFUpload.instances[this.movieName];
		throw ex;
	}
};

/* *************** */
/* Static Members  */
/* *************** */
SWFUpload.instances = {};
SWFUpload.movieCount = 0;
SWFUpload.version = "2.2.0 2009-03-25";
SWFUpload.QUEUE_ERROR = {
	QUEUE_LIMIT_EXCEEDED	  		: -100,
	FILE_EXCEEDS_SIZE_LIMIT  		: -110,
	ZERO_BYTE_FILE			  		: -120,
	INVALID_FILETYPE		  		: -130
};
SWFUpload.UPLOAD_ERROR = {
	HTTP_ERROR				  		: -200,
	MISSING_UPLOAD_URL					: -210,
	IO_ERROR				  		: -220,
	SECURITY_ERROR			  		: -230,
	UPLOAD_LIMIT_EXCEEDED	  		: -240,
	UPLOAD_FAILED			  		: -250,
	SPECIFIED_FILE_ID_NOT_FOUND		: -260,
	FILE_VALIDATION_FAILED	  		: -270,
	FILE_CANCELLED			  		: -280,
	UPLOAD_STOPPED					: -290
};

SWFUpload.FILE_STATUS = {
	QUEUED		 : -1,
	IN_PROGRESS	 : -2,
	ERROR		 : -3,
	COMPLETE	 : -4,
	CANCELLED	 : -5
};
SWFUpload.BUTTON_ACTION = {
	SELECT_FILE  : -100,
	SELECT_FILES : -110,
	START_UPLOAD : -120
};
SWFUpload.CURSOR = {
	ARROW : -1,
	HAND : -2
};
SWFUpload.WINDOW_MODE = {
	WINDOW : "window",
	TRANSPARENT : "transparent",
	OPAQUE : "opaque"
};

// Private: takes a URL, determines if it is relative and converts to an absolute URL
// using the current site. Only processes the URL if it can, otherwise returns the URL untouched
SWFUpload.completeURL = function(url) {
	if (typeof(url) !== "string" || url.match(/^https?:\/\//i) || url.match(/^\//)) {
		return url;
	}

	var currentURL = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ":" + window.location.port : "");

	var indexSlash = window.location.pathname.lastIndexOf("/");
	if (indexSlash <= 0) {
		path = "/";
	} else {
		path = window.location.pathname.substr(0, indexSlash) + "/";
	}

	return /*currentURL +*/ path + url;

};


/* ******************** */
/* Instance Members  */
/* ******************** */

// Private: initSettings ensures that all the
// settings are set, getting a default value if one was not assigned.
SWFUpload.prototype.initSettings = function () {
	this.ensureDefault = function (settingName, defaultValue) {
		this.settings[settingName] = (typeof this.settings[settingName] == 'undefined') ? defaultValue : this.settings[settingName];
	};

	// Upload backend settings
	this.ensureDefault("upload_url", "");
	this.ensureDefault("preserve_relative_urls", false);
	this.ensureDefault("file_post_name", "Filedata");
	this.ensureDefault("post_params", {});
	this.ensureDefault("use_query_string", false);
	this.ensureDefault("requeue_on_error", false);
	this.ensureDefault("http_success", []);
	this.ensureDefault("assume_success_timeout", 0);

	// File Settings
	this.ensureDefault("file_types", "*.*");
	this.ensureDefault("file_types_description", "All Files");
	this.ensureDefault("file_size_limit", 0);	// Default zero means "unlimited"
	this.ensureDefault("file_upload_limit", 0);
	this.ensureDefault("file_queue_limit", 0);

	// Flash Settings
	this.ensureDefault("flash_url", "swfupload.swf");
	this.ensureDefault("prevent_swf_caching", true);

	// Button Settings
	this.ensureDefault("button_image_url", "");
	this.ensureDefault("button_width", 1);
	this.ensureDefault("button_height", 1);
	this.ensureDefault("button_text", "");
	this.ensureDefault("button_text_style", "color: #000000; font-size: 16pt;");
	this.ensureDefault("button_text_top_padding", 0);
	this.ensureDefault("button_text_left_padding", 0);
	this.ensureDefault("button_action", SWFUpload.BUTTON_ACTION.SELECT_FILES);
	this.ensureDefault("button_disabled", false);
	this.ensureDefault("button_placeholder_id", "");
	this.ensureDefault("button_placeholder", null);
	this.ensureDefault("button_cursor", SWFUpload.CURSOR.ARROW);
	this.ensureDefault("button_window_mode", SWFUpload.WINDOW_MODE.WINDOW);

	// Debug Settings
	this.ensureDefault("debug", false);
	this.settings.debug_enabled = this.settings.debug;	// Here to maintain v2 API

	// Event Handlers
	this.settings.return_upload_start_handler = this.returnUploadStart;
	this.ensureDefault("swfupload_loaded_handler", null);
	this.ensureDefault("file_dialog_start_handler", null);
	this.ensureDefault("file_queued_handler", null);
	this.ensureDefault("file_queue_error_handler", null);
	this.ensureDefault("file_dialog_complete_handler", null);

	this.ensureDefault("upload_start_handler", null);
	this.ensureDefault("upload_progress_handler", null);
	this.ensureDefault("upload_error_handler", null);
	this.ensureDefault("upload_success_handler", null);
	this.ensureDefault("upload_complete_handler", null);

	this.ensureDefault("debug_handler", this.debugMessage);

	this.ensureDefault("custom_settings", {});

	// Other settings
	this.customSettings = this.settings.custom_settings;

	// Update the flash url if needed
	if (!!this.settings.prevent_swf_caching) {
		this.settings.flash_url = this.settings.flash_url + (this.settings.flash_url.indexOf("?") < 0 ? "?" : "&") + "preventswfcaching=" + new Date().getTime();
	}

	if (!this.settings.preserve_relative_urls) {
		//this.settings.flash_url = SWFUpload.completeURL(this.settings.flash_url);	// Don't need to do this one since flash doesn't look at it
		this.settings.upload_url = SWFUpload.completeURL(this.settings.upload_url);
		this.settings.button_image_url = SWFUpload.completeURL(this.settings.button_image_url);
	}

	delete this.ensureDefault;
};

// Private: loadFlash replaces the button_placeholder element with the flash movie.
SWFUpload.prototype.loadFlash = function () {
	var targetElement, tempParent;

	// Make sure an element with the ID we are going to use doesn't already exist
	if (document.getElementById(this.movieName) !== null) {
		throw "ID " + this.movieName + " is already in use. The Flash Object could not be added";
	}

	// Get the element where we will be placing the flash movie
	targetElement = document.getElementById(this.settings.button_placeholder_id) || this.settings.button_placeholder;

	if (typeof targetElement == 'undefined') {
		throw "Could not find the placeholder element: " + this.settings.button_placeholder_id;
	}

	// Append the container and load the flash
	tempParent = document.createElement("div");
	set_inner_html(tempParent,this.getFlashHTML());
	var next=tempParent.firstChild.nextSibling;
	targetElement.parentNode.replaceChild(tempParent.firstChild, targetElement);
	if (next) targetElement.appendChild(next);

	// Fix IE Flash/Form bug
	if ((typeof window[this.movieName]=='undefined') || (!window[this.movieName])) {
		window[this.movieName] = this.getMovieElement();
	}
};

// Private: getFlashHTML generates the object tag needed to embed the flash in to the document
SWFUpload.prototype.getFlashHTML = function () {
	// Flash Satay object syntax: http://www.alistapart.com/articles/flashsatay
	return [
				'<object id="', this.movieName, '" type="application/x-shockwave-flash" data="', this.settings.flash_url, '" width="', this.settings.button_width, '" height="', this.settings.button_height, '" class="swfupload">',
				'<param name="wmode" value="', this.settings.button_window_mode, '" />',
				'<param name="movie" value="', this.settings.flash_url, '" />',
				'<param name="quality" value="high" />',
				'<param name="menu" value="false" />',
				'<param name="allowScriptAccess" value="always" />',
				'<param name="flashvars" value="' + this.getFlashVars() + '" />',
				'</object>',
				'<object type="application/x-shockwave-flash" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="1" height="1">',
				'<param name="movie" value="{$BASE_URL*}/data/swfupload/blank.swf" />',
				'<param name="pluginspage" value="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" />',
				'</object>'
			].join("");
};

// Private: getFlashVars builds the parameter string that will be passed
// to flash in the flashvars param.
SWFUpload.prototype.getFlashVars = function () {
	// Build a string from the post param object
	var paramString = this.buildParamString();
	var httpSuccessString = this.settings.http_success.join(",");

	// Build the parameter string
	return ["movieName=", encodeURIComponent(this.movieName),
			"&amp;uploadURL=", encodeURIComponent(this.settings.upload_url),
			"&amp;useQueryString=", encodeURIComponent(this.settings.use_query_string),
			"&amp;requeueOnError=", encodeURIComponent(this.settings.requeue_on_error),
			"&amp;httpSuccess=", encodeURIComponent(httpSuccessString),
			"&amp;assumeSuccessTimeout=", encodeURIComponent(this.settings.assume_success_timeout),
			"&amp;params=", encodeURIComponent(paramString),
			"&amp;filePostName=", encodeURIComponent(this.settings.file_post_name),
			"&amp;fileTypes=", encodeURIComponent(this.settings.file_types),
			"&amp;fileTypesDescription=", encodeURIComponent(this.settings.file_types_description),
			"&amp;fileSizeLimit=", encodeURIComponent(this.settings.file_size_limit),
			"&amp;fileUploadLimit=", encodeURIComponent(this.settings.file_upload_limit),
			"&amp;fileQueueLimit=", encodeURIComponent(this.settings.file_queue_limit),
			"&amp;debugEnabled=", encodeURIComponent(this.settings.debug_enabled),
			"&amp;buttonImageURL=", encodeURIComponent(this.settings.button_image_url),
			"&amp;buttonWidth=", encodeURIComponent(this.settings.button_width),
			"&amp;buttonHeight=", encodeURIComponent(this.settings.button_height),
			"&amp;buttonText=", encodeURIComponent(this.settings.button_text),
			"&amp;buttonTextTopPadding=", encodeURIComponent(this.settings.button_text_top_padding),
			"&amp;buttonTextLeftPadding=", encodeURIComponent(this.settings.button_text_left_padding),
			"&amp;buttonTextStyle=", encodeURIComponent(this.settings.button_text_style),
			"&amp;buttonAction=", encodeURIComponent(this.settings.button_action),
			"&amp;buttonDisabled=", encodeURIComponent(this.settings.button_disabled),
			"&amp;buttonCursor=", encodeURIComponent(this.settings.button_cursor)
		].join("");
};

// Public: getMovieElement retrieves the DOM reference to the Flash element added by SWFUpload
// The element is cached after the first lookup
SWFUpload.prototype.getMovieElement = function () {
	if (!this.movieElement) {
		this.movieElement = document.getElementById(this.movieName);
	}
	if (this.movieElement === null) {
		throw "Could not find Flash element";
	}

	return this.movieElement;
};

// Private: buildParamString takes the name/value pairs in the post_params setting object
// and joins them up in to a string formatted "name=value&amp;name=value"
SWFUpload.prototype.buildParamString = function () {
	var postParams = this.settings.post_params; 
	var paramStringPairs = [];

	if (typeof(postParams) === "object") {
		for (var name in postParams) {
			if (postParams.hasOwnProperty(name)) {
				paramStringPairs.push(encodeURIComponent(name.toString()) + "=" + encodeURIComponent(postParams[name].toString()));
			}
		}
	}

	return paramStringPairs.join("&amp;");
};

// Public: Used to remove a SWFUpload instance from the page. This method strives to remove
// all references to the SWF, and other objects so memory is properly freed.
// Returns true if everything was destroyed. Returns a false if a failure occurs leaving SWFUpload in an inconsistant state.
// Credits: Major improvements provided by steffen
SWFUpload.prototype.destroy = function () {
	try {
		// Make sure Flash is done before we try to remove it
		this.cancelUpload(null, false);


		// Remove the SWFUpload DOM nodes
		var movieElement = null;
		movieElement = this.getMovieElement();

		if (movieElement && typeof(movieElement.CallFunction) === "unknown") { // We only want to do this in IE
			// Loop through all the movie's properties and remove all function references (DOM/JS IE 6/7 memory leak workaround)
			for (var i in movieElement) {
				try {
					if (typeof(movieElement[i]) === "function") {
						movieElement[i] = null;
					}
				} catch (ex1) {}
			}

			// Remove the Movie Element from the page
			try {
				movieElement.parentNode.removeChild(movieElement);
			} catch (ex) {}
		}

		// Remove IE form fix reference
		window[this.movieName] = null;

		// Destroy other references
		SWFUpload.instances[this.movieName] = null;
		delete SWFUpload.instances[this.movieName];

		this.movieElement = null;
		this.settings = null;
		this.customSettings = null;
		this.eventQueue = null;
		this.movieName = null;


		return true;
	} catch (ex2) {
		return false;
	}
};


// Public: displayDebugInfo prints out settings and configuration
// information about this SWFUpload instance.
// This function (and any references to it) can be deleted when placing
// SWFUpload in production.
SWFUpload.prototype.displayDebugInfo = function () {
	this.debug(
		[
			"---SWFUpload Instance Info---\n",
			"Version: ", SWFUpload.version, "\n",
			"Movie Name: ", this.movieName, "\n",
			"Settings:\n",
			"\t", "upload_url:					", this.settings.upload_url, "\n",
			"\t", "flash_url:					 ", this.settings.flash_url, "\n",
			"\t", "use_query_string:			", this.settings.use_query_string.toString(), "\n",
			"\t", "requeue_on_error:			", this.settings.requeue_on_error.toString(), "\n",
			"\t", "http_success:				 ", this.settings.http_success.join(", "), "\n",
			"\t", "assume_success_timeout:	", this.settings.assume_success_timeout, "\n",
			"\t", "file_post_name:			  ", this.settings.file_post_name, "\n",
			"\t", "post_params:				  ", this.settings.post_params.toString(), "\n",
			"\t", "file_types:					", this.settings.file_types, "\n",
			"\t", "file_types_description:	", this.settings.file_types_description, "\n",
			"\t", "file_size_limit:			 ", this.settings.file_size_limit, "\n",
			"\t", "file_upload_limit:		  ", this.settings.file_upload_limit, "\n",
			"\t", "file_queue_limit:			", this.settings.file_queue_limit, "\n",
			"\t", "debug:						  ", this.settings.debug.toString(), "\n",

			"\t", "prevent_swf_caching:		", this.settings.prevent_swf_caching.toString(), "\n",

			"\t", "button_placeholder_id:	 ", this.settings.button_placeholder_id.toString(), "\n",
			"\t", "button_placeholder:		 ", (this.settings.button_placeholder ? "Set" : "Not Set"), "\n",
			"\t", "button_image_url:			", this.settings.button_image_url.toString(), "\n",
			"\t", "button_width:				 ", this.settings.button_width.toString(), "\n",
			"\t", "button_height:				", this.settings.button_height.toString(), "\n",
			"\t", "button_text:				  ", this.settings.button_text.toString(), "\n",
			"\t", "button_text_style:		  ", this.settings.button_text_style.toString(), "\n",
			"\t", "button_text_top_padding:  ", this.settings.button_text_top_padding.toString(), "\n",
			"\t", "button_text_left_padding: ", this.settings.button_text_left_padding.toString(), "\n",
			"\t", "button_action:				", this.settings.button_action.toString(), "\n",
			"\t", "button_disabled:			 ", this.settings.button_disabled.toString(), "\n",

			"\t", "custom_settings:			 ", this.settings.custom_settings.toString(), "\n",
			"Event Handlers:\n",
			"\t", "swfupload_loaded_handler assigned:  ", (typeof this.settings.swfupload_loaded_handler === "function").toString(), "\n",
			"\t", "file_dialog_start_handler assigned: ", (typeof this.settings.file_dialog_start_handler === "function").toString(), "\n",
			"\t", "file_queued_handler assigned:		 ", (typeof this.settings.file_queued_handler === "function").toString(), "\n",
			"\t", "file_queue_error_handler assigned:  ", (typeof this.settings.file_queue_error_handler === "function").toString(), "\n",
			"\t", "upload_start_handler assigned:		", (typeof this.settings.upload_start_handler === "function").toString(), "\n",
			"\t", "upload_progress_handler assigned:	", (typeof this.settings.upload_progress_handler === "function").toString(), "\n",
			"\t", "upload_error_handler assigned:		", (typeof this.settings.upload_error_handler === "function").toString(), "\n",
			"\t", "upload_success_handler assigned:	 ", (typeof this.settings.upload_success_handler === "function").toString(), "\n",
			"\t", "upload_complete_handler assigned:	", (typeof this.settings.upload_complete_handler === "function").toString(), "\n",
			"\t", "debug_handler assigned:				 ", (typeof this.settings.debug_handler === "function").toString(), "\n"
		].join("")
	);
};

/* Note: addSetting and getSetting are no longer used by SWFUpload but are included
	the maintain v2 API compatibility
*/
// Public: (Deprecated) addSetting adds a setting value. If the value given is undefined or null then the default_value is used.
SWFUpload.prototype.addSetting = function (name, value, default_value) {
	if (typeof value == 'undefined') {
		return (this.settings[name] = default_value);
	} else {
		return (this.settings[name] = value);
	}
};

// Public: (Deprecated) getSetting gets a setting. Returns an empty string if the setting was not found.
SWFUpload.prototype.getSetting = function (name) {
	if (typeof this.settings[name] != 'undefined') {
		return this.settings[name];
	}

	return "";
};



// Private: callFlash handles function calls made to the Flash element.
// Calls are made with a setTimeout for some functions to work around
// bugs in the ExternalInterface library.
SWFUpload.prototype.callFlash = function (functionName, argumentArray) {
	argumentArray = argumentArray || [];

	var movieElement = this.getMovieElement();
	var returnValue, returnString;

	// Flash's method if calling ExternalInterface methods (code adapted from MooTools).
	try {
		returnString = movieElement.CallFunction('<invoke name="' + functionName + '" returntype="javascript">' + __flash__argumentsToXML(argumentArray, 0) + '</invoke>');
		returnValue = eval(returnString);
	} catch (ex) {
		throw "Call to " + functionName + " failed";
	}

	// Unescape file post param values
	if (typeof returnValue != 'undefined' && typeof returnValue.post === "object") {
		returnValue = this.unescapeFilePostParams(returnValue);
	}

	return returnValue;
};

/* *****************************
	-- Flash control methods --
	Your UI should use these
	to operate SWFUpload
	***************************** */

// WARNING: this function does not work in Flash Player 10
// Public: selectFile causes a File Selection Dialog window to appear.  This
// dialog only allows 1 file to be selected.
SWFUpload.prototype.selectFile = function () {
	this.callFlash("SelectFile");
};

// WARNING: this function does not work in Flash Player 10
// Public: selectFiles causes a File Selection Dialog window to appear/ This
// dialog allows the user to select any number of files
// Flash Bug Warning: Flash limits the number of selectable files based on the combined length of the file names.
// If the selection name length is too long the dialog will fail in an unpredictable manner.  There is no work-around
// for this bug.
SWFUpload.prototype.selectFiles = function () {
	this.callFlash("SelectFiles");
};


// Public: startUpload starts uploading the first file in the queue unless
// the optional parameter 'fileID' specifies the ID 
SWFUpload.prototype.startUpload = function (fileID) {
	this.callFlash("StartUpload", [fileID]);
};

// Public: cancelUpload cancels any queued file.  The fileID parameter may be the file ID or index.
// If you do not specify a fileID the current uploading file or first file in the queue is cancelled.
// If you do not want the uploadError event to trigger you can specify false for the triggerErrorEvent parameter.
SWFUpload.prototype.cancelUpload = function (fileID, triggerErrorEvent) {
	if (triggerErrorEvent !== false) {
		triggerErrorEvent = true;
	}
	this.callFlash("CancelUpload", [fileID, triggerErrorEvent]);
};

// Public: stopUpload stops the current upload and requeues the file at the beginning of the queue.
// If nothing is currently uploading then nothing happens.
SWFUpload.prototype.stopUpload = function () {
	this.callFlash("StopUpload");
};

/* ************************
 * Settings methods
 *	These methods change the SWFUpload settings.
 *	SWFUpload settings should not be changed directly on the settings object
 *	since many of the settings need to be passed to Flash in order to take
 *	effect.
 * *********************** */

// Public: getStats gets the file statistics object.
SWFUpload.prototype.getStats = function () {
	return this.callFlash("GetStats");
};

// Public: setStats changes the SWFUpload statistics.  You shouldn't need to 
// change the statistics but you can.  Changing the statistics does not
// affect SWFUpload accept for the successful_uploads count which is used
// by the upload_limit setting to determine how many files the user may upload.
SWFUpload.prototype.setStats = function (statsObject) {
	this.callFlash("SetStats", [statsObject]);
};

// Public: getFile retrieves a File object by ID or Index.  If the file is
// not found then 'null' is returned.
SWFUpload.prototype.getFile = function (fileID) {
	if (typeof(fileID) === "number") {
		return this.callFlash("GetFileByIndex", [fileID]);
	} else {
		return this.callFlash("GetFile", [fileID]);
	}
};

// Public: addFileParam sets a name/value pair that will be posted with the
// file specified by the Files ID.  If the name already exists then the
// exiting value will be overwritten.
SWFUpload.prototype.addFileParam = function (fileID, name, value) {
	return this.callFlash("AddFileParam", [fileID, name, value]);
};

// Public: removeFileParam removes a previously set (by addFileParam) name/value
// pair from the specified file.
SWFUpload.prototype.removeFileParam = function (fileID, name) {
	this.callFlash("RemoveFileParam", [fileID, name]);
};

// Public: setUploadUrl changes the upload_url setting.
SWFUpload.prototype.setUploadURL = function (url) {
	this.settings.upload_url = url.toString();
	this.callFlash("SetUploadURL", [url]);
};

// Public: setPostParams changes the post_params setting
SWFUpload.prototype.setPostParams = function (paramsObject) {
	this.settings.post_params = paramsObject;
	this.callFlash("SetPostParams", [paramsObject]);
};

// Public: addPostParam adds post name/value pair.  Each name can have only one value.
SWFUpload.prototype.addPostParam = function (name, value) {
	this.settings.post_params[name] = value;
	this.callFlash("SetPostParams", [this.settings.post_params]);
};

// Public: removePostParam deletes post name/value pair.
SWFUpload.prototype.removePostParam = function (name) {
	delete this.settings.post_params[name];
	this.callFlash("SetPostParams", [this.settings.post_params]);
};

// Public: setFileTypes changes the file_types setting and the file_types_description setting
SWFUpload.prototype.setFileTypes = function (types, description) {
	this.settings.file_types = types;
	this.settings.file_types_description = description;
	this.callFlash("SetFileTypes", [types, description]);
};

// Public: setFileSizeLimit changes the file_size_limit setting
SWFUpload.prototype.setFileSizeLimit = function (fileSizeLimit) {
	this.settings.file_size_limit = fileSizeLimit;
	this.callFlash("SetFileSizeLimit", [fileSizeLimit]);
};

// Public: setFileUploadLimit changes the file_upload_limit setting
SWFUpload.prototype.setFileUploadLimit = function (fileUploadLimit) {
	this.settings.file_upload_limit = fileUploadLimit;
	this.callFlash("SetFileUploadLimit", [fileUploadLimit]);
};

// Public: setFileQueueLimit changes the file_queue_limit setting
SWFUpload.prototype.setFileQueueLimit = function (fileQueueLimit) {
	this.settings.file_queue_limit = fileQueueLimit;
	this.callFlash("SetFileQueueLimit", [fileQueueLimit]);
};

// Public: setFilePostName changes the file_post_name setting
SWFUpload.prototype.setFilePostName = function (filePostName) {
	this.settings.file_post_name = filePostName;
	this.callFlash("SetFilePostName", [filePostName]);
};

// Public: setUseQueryString changes the use_query_string setting
SWFUpload.prototype.setUseQueryString = function (useQueryString) {
	this.settings.use_query_string = useQueryString;
	this.callFlash("SetUseQueryString", [useQueryString]);
};

// Public: setRequeueOnError changes the requeue_on_error setting
SWFUpload.prototype.setRequeueOnError = function (requeueOnError) {
	this.settings.requeue_on_error = requeueOnError;
	this.callFlash("SetRequeueOnError", [requeueOnError]);
};

// Public: setHTTPSuccess changes the http_success setting
SWFUpload.prototype.setHTTPSuccess = function (http_status_codes) {
	if (typeof http_status_codes === "string") {
		http_status_codes = http_status_codes.replace(" ", "").split(",");
	}

	this.settings.http_success = http_status_codes;
	this.callFlash("SetHTTPSuccess", [http_status_codes]);
};

// Public: setHTTPSuccess changes the http_success setting
SWFUpload.prototype.setAssumeSuccessTimeout = function (timeout_seconds) {
	this.settings.assume_success_timeout = timeout_seconds;
	this.callFlash("SetAssumeSuccessTimeout", [timeout_seconds]);
};

// Public: setDebugEnabled changes the debug_enabled setting
SWFUpload.prototype.setDebugEnabled = function (debugEnabled) {
	this.settings.debug_enabled = debugEnabled;
	this.callFlash("SetDebugEnabled", [debugEnabled]);
};

// Public: setButtonImageURL loads a button image sprite
SWFUpload.prototype.setButtonImageURL = function (buttonImageURL) {
	if (typeof buttonImageURL == 'undefined') {
		buttonImageURL = "";
	}

	this.settings.button_image_url = buttonImageURL;
	this.callFlash("SetButtonImageURL", [buttonImageURL]);
};

// Public: setButtonDimensions resizes the Flash Movie and button
SWFUpload.prototype.setButtonDimensions = function (width, height) {
	this.settings.button_width = width;
	this.settings.button_height = height;

	var movie = this.getMovieElement();
	if (typeof movie != 'undefined') {
		movie.style.width = width + "px";
		movie.style.height = height + "px";
	}

	this.callFlash("SetButtonDimensions", [width, height]);
};
// Public: setButtonText Changes the text overlaid on the button
SWFUpload.prototype.setButtonText = function (html) {
	this.settings.button_text = html;
	this.callFlash("SetButtonText", [html]);
};
// Public: setButtonTextPadding changes the top and left padding of the text overlay
SWFUpload.prototype.setButtonTextPadding = function (left, top) {
	this.settings.button_text_top_padding = top;
	this.settings.button_text_left_padding = left;
	this.callFlash("SetButtonTextPadding", [left, top]);
};

// Public: setButtonTextStyle changes the CSS used to style the HTML/Text overlaid on the button
SWFUpload.prototype.setButtonTextStyle = function (css) {
	this.settings.button_text_style = css;
	this.callFlash("SetButtonTextStyle", [css]);
};
// Public: setButtonDisabled disables/enables the button
SWFUpload.prototype.setButtonDisabled = function (isDisabled) {
	this.settings.button_disabled = isDisabled;
	this.callFlash("SetButtonDisabled", [isDisabled]);
};
// Public: setButtonAction sets the action that occurs when the button is clicked
SWFUpload.prototype.setButtonAction = function (buttonAction) {
	this.settings.button_action = buttonAction;
	this.callFlash("SetButtonAction", [buttonAction]);
};

// Public: setButtonCursor changes the mouse cursor displayed when hovering over the button
SWFUpload.prototype.setButtonCursor = function (cursor) {
	this.settings.button_cursor = cursor;
	this.callFlash("SetButtonCursor", [cursor]);
};

/* *******************************
	Flash Event Interfaces
	These functions are used by Flash to trigger the various
	events.

	All these function as Private.

	Because the ExternalInterface library is buggy the event calls
	are added to a queue and the queue then executed by a setTimeout.
	This ensures that events are executed in a determinate order and that
	the ExternalInterface bugs are avoided.
******************************* */

SWFUpload.prototype.queueEvent = function (handlerName, argumentArray) {
	// Warning: Don't call this.debug inside here or you'll create an infinite loop

	if (typeof argumentArray == 'undefined') {
		argumentArray = [];
	} else if (!(argumentArray instanceof Array)) {
		argumentArray = [argumentArray];
	}
	argumentArray.push(this);

	var self = this;
	if (typeof this.settings[handlerName] === "function") {
		// Queue the event
		this.eventQueue.push(function () {
			this.settings[handlerName].apply(this, argumentArray);
		});

		// Execute the next queued event
		setTimeout(function () {
			self.executeNextEvent();
		}, 0);

	} else if (this.settings[handlerName] !== null) {
		throw "Event handler " + handlerName + " is unknown or is not a function";
	}
};

// Private: Causes the next event in the queue to be executed.  Since events are queued using a setTimeout
// we must queue them in order to garentee that they are executed in order.
SWFUpload.prototype.executeNextEvent = function () {
	// Warning: Don't call this.debug inside here or you'll create an infinite loop

	var  f = this.eventQueue ? this.eventQueue.shift() : null;
	if (typeof(f) === "function") {
		f.apply(this);
	}
};

// Private: unescapeFileParams is part of a workaround for a flash bug where objects passed through ExternalInterface cannot have
// properties that contain characters that are not valid for JavaScript identifiers. To work around this
// the Flash Component escapes the parameter names and we must unescape again before passing them along.
SWFUpload.prototype.unescapeFilePostParams = function (file) {
	var reg = /[$]([0-9a-f]\{4})/i;
	var unescapedPost = {};
	var uk;

	if (typeof file != 'undefined') {
		for (var k in file.post) {
			if (file.post.hasOwnProperty(k)) {
				uk = k;
				var match;
				while ((match = reg.exec(uk)) !== null) {
					uk = uk.replace(match[0], String.fromCharCode(parseInt("0x" + match[1], 16)));
				}
				unescapedPost[uk] = file.post[k];
			}
		}

		file.post = unescapedPost;
	}

	return file;
};
// Private: Called by Flash to see if JS can call in to Flash (test if External Interface is working)
SWFUpload.prototype.testExternalInterface = function () {
	try {
		return this.callFlash("TestExternalInterface");
	} catch (ex) {
		return false;
	}
};

// Private: This event is called by Flash when it has finished loading. Don't modify this.
// Use the swfupload_loaded_handler event setting to execute custom code when SWFUpload has loaded.
SWFUpload.prototype.flashReady = function () {
	// Check that the movie element is loaded correctly with its ExternalInterface methods defined
	var movieElement = this.getMovieElement();

	if (!movieElement) {
		this.debug("Flash called back ready but the flash movie can't be found.");
		return;
	}

	this.cleanUp(movieElement);

	this.queueEvent("swfupload_loaded_handler");
};

// Private: removes Flash added functions to the DOM node to prevent memory leaks in IE.
// This function is called by Flash each time the ExternalInterface functions are created.
SWFUpload.prototype.cleanUp = function (movieElement) {
	// Pro-actively unhook all the Flash functions
	try {
		if (this.movieElement && typeof(this.movieElement.CallFunction) === "unknown") { // We only want to do this in IE
			this.debug("Removing Flash functions hooks (this should only run in IE and should prevent memory leaks)");
			for (var key in movieElement) {
				try {
					if (typeof(movieElement[key]) === "function") {
						movieElement[key] = null;
					}
				} catch (ex) {
				}
			}
		}
	} catch (ex1) {

	}
};

/* This is a chance to do something before the browse window opens */
SWFUpload.prototype.fileDialogStart = function () {
	this.queueEvent("file_dialog_start_handler");
};


/* Called when a file is successfully added to the queue. */
SWFUpload.prototype.fileQueued = function (file) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("file_queued_handler", file);
};


/* Handle errors that occur when an attempt to queue a file fails. */
SWFUpload.prototype.fileQueueError = function (file, errorCode, message) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("file_queue_error_handler", [file, errorCode, message]);
};

/* Called after the file dialog has closed and the selected files have been queued.
	You could call startUpload here if you want the queued files to begin uploading immediately. */
SWFUpload.prototype.fileDialogComplete = function (numFilesSelected, numFilesQueued, numFilesInQueue) {
	this.queueEvent("file_dialog_complete_handler", [numFilesSelected, numFilesQueued, numFilesInQueue]);
};

SWFUpload.prototype.uploadStart = function (file) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("return_upload_start_handler", file);
};

SWFUpload.prototype.returnUploadStart = function (file) {
	var returnValue;
	if (typeof this.settings.upload_start_handler === "function") {
		file = this.unescapeFilePostParams(file);
		returnValue = this.settings.upload_start_handler.call(this, file);
	} else/* if (typeof this.settings.upload_start_handler != 'undefined')*/ {
		//throw "upload_start_handler must be a function";	// IE seems to pass null as 'object', got lost in translation somewhere
	}

	// Convert undefined to true so if nothing is returned from the upload_start_handler it is
	// interpretted as 'true'.
	if (typeof returnValue === 'undefined') {
		returnValue = true;
	}

	returnValue = !!returnValue;

	this.callFlash("ReturnUploadStart", [returnValue]);
};



SWFUpload.prototype.uploadProgress = function (file, bytesComplete, bytesTotal) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("upload_progress_handler", [file, bytesComplete, bytesTotal]);
};

SWFUpload.prototype.uploadError = function (file, errorCode, message) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("upload_error_handler", [file, errorCode, message]);
};

SWFUpload.prototype.uploadSuccess = function (file, serverData, responseReceived) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("upload_success_handler", [file, serverData, responseReceived]);
};

SWFUpload.prototype.uploadComplete = function (file) {
	file = this.unescapeFilePostParams(file);
	this.queueEvent("upload_complete_handler", file);
};

/* Called by SWFUpload JavaScript and Flash functions when debug is enabled. By default it writes messages to the
	internal debug console.  You can override this event and have messages written where you want. */
SWFUpload.prototype.debug = function (message) {
	this.queueEvent("debug_handler", message);
};


/* **********************************
	Debug Console
	The debug console is a self contained, in page location
	for debug message to be sent.  The Debug Console adds
	itself to the body if necessary.

	The console is automatically scrolled as messages appear.

	If you are using your own debug handler or when you deploy to production and
	have debug disabled you can remove these functions to reduce the file size
	and complexity.
********************************** */

// Private: debugMessage is the default debug_handler.  If you want to print debug messages
// call the debug() function.  When overriding the function your own function should
// check to see if the debug setting is true before outputting debug information.
SWFUpload.prototype.debugMessage = function (message) {
	if (this.settings.debug) {
		var exceptionMessage, exceptionValues = [];

		// Check for an exception object and print it nicely
		if (typeof message === "object" && typeof message.name === "string" && typeof message.message === "string") {
			for (var key in message) {
				if (message.hasOwnProperty(key)) {
					exceptionValues.push(key + ": " + message[key]);
				}
			}
			exceptionMessage = exceptionValues.join("\n");
			exceptionValues = exceptionMessage.split("\n");
			exceptionMessage = "EXCEPTION: " + exceptionValues.join("\nEXCEPTION: ");
			SWFUpload.Console.writeLine(exceptionMessage);
		} else {
			SWFUpload.Console.writeLine(message);
		}
	}
};

SWFUpload.Console = {};
SWFUpload.Console.writeLine = function (message) {
	var console, documentForm;

	try {
		console = document.getElementById("SWFUpload_Console");

		if (!console) {
			documentForm = document.createElement("form");
			document.getElementsByTagName("body")[0].appendChild(documentForm);

			console = document.createElement("textarea");
			console.id = "SWFUpload_Console";
			console.style.fontFamily = "monospace";
			console.setAttribute("wrap", "off");
			console.wrap = "off";
			console.style.overflow = "auto";
			console.style.width = "700px";
			console.style.height = "350px";
			console.style.margin = "5px";
			documentForm.appendChild(console);
		}

		console.value += message + "\n";

		console.scrollTop = console.scrollHeight - console.clientHeight;
	} catch (ex) {
		window.fauxmodal_alert("Exception: " + ex.name + " Message: " + ex.message);
	}
};

/*
	fileprogress.js

	A simple class for displaying file information and progress
*/

// Constructor
// file is a SWFUpload file object
// targetID is the HTML element id attribute that the FileProgress HTML structure will be added to.
// Instantiating a new FileProgress object with an existing file will reuse/update the existing DOM elements
function FileProgress(file, targetID) {
	this.fileProgressID = file.id;

	this.opacity = 100;
	this.height = 0;

	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		this.fileProgressWrapper = document.createElement("div");
		this.fileProgressWrapper.className = "progressWrapper";
		this.fileProgressWrapper.id = this.fileProgressID;

		this.fileProgressElement = document.createElement("div");
		this.fileProgressElement.className = "progressContainer";

		var progressCancel = document.createElement("a");
		progressCancel.className = "progressCancel";
		progressCancel.href = "#";
		progressCancel.style.visibility = "hidden";
		progressCancel.appendChild(document.createTextNode(" "));

		var progressText = document.createElement("div");
		progressText.className = "progressName";
		if (typeof file.name!='undefined')
			progressText.appendChild(document.createTextNode(file.name));

		var progressBar = document.createElement("div");
		progressBar.className = "progressBarInProgress";

		var progressStatus = document.createElement("div");
		progressStatus.className = "progressBarStatus";
		set_inner_html(progressStatus,"&nbsp;");

		this.fileProgressElement.appendChild(progressCancel);
		this.fileProgressElement.appendChild(progressText);
		this.fileProgressElement.appendChild(progressStatus);
		this.fileProgressElement.appendChild(progressBar);

		this.fileProgressWrapper.appendChild(this.fileProgressElement);

		document.getElementById(targetID).appendChild(this.fileProgressWrapper);
	} else {
		this.fileProgressElement = this.fileProgressWrapper.firstChild;
		if (typeof file.name!='undefined')
			set_inner_html(this.fileProgressElement.childNodes[1],file.name);
	}

	this.height = this.fileProgressWrapper.offsetHeight;

}
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.className = "progressContainer green";
	this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	this.fileProgressElement.childNodes[3].style.width = percentage + "%";
};
FileProgress.prototype.setComplete = function () {
	this.appear();
	this.fileProgressElement.className = "progressContainer blue";
	this.fileProgressElement.childNodes[3].className = "progressBarComplete";
	this.fileProgressElement.childNodes[3].style.width = "";

	var oSelf = this;
	setTimeout(function () {
		oSelf.disappear();
	}, 10000);
};
FileProgress.prototype.setError = function () {
	this.appear();
	this.fileProgressElement.className = "progressContainer red";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

	var oSelf = this;
	setTimeout(function () {
		oSelf.disappear();
	}, 5000);
};
FileProgress.prototype.setCancelled = function () {
	this.appear();
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

	var oSelf = this;
	setTimeout(function () {
		oSelf.disappear();
	}, 2000);
};
FileProgress.prototype.setStatus = function (status) {
	set_inner_html(this.fileProgressElement.childNodes[2],status);
};

// Show/Hide the cancel button
FileProgress.prototype.toggleCancel = function (show, swfUploadInstance) {
	this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
	if (swfUploadInstance) {
		var fileID = this.fileProgressID;
		this.fileProgressElement.childNodes[0].onclick = function () {
			swfUploadInstance.cancelUpload(fileID);
			return false;
		};
	}
};

// Makes sure the FileProgress box is visible
FileProgress.prototype.appear = function () {
	if (this.fileProgressWrapper.filters) {
		try {
			this.fileProgressWrapper.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 100;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			this.fileProgressWrapper.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=100)";
		}
	} else {
		this.fileProgressWrapper.style.opacity = 1;
	}

	this.fileProgressWrapper.style.height = "";
	this.height = this.fileProgressWrapper.offsetHeight;
	this.opacity = 100;
	this.fileProgressWrapper.style.display = "";
};

// Fades out and clips away the FileProgress box.
FileProgress.prototype.disappear = function () {

	var reduceOpacityBy = 15;
	var reduceHeightBy = 4;
	var rate = 30;	// 15 fps

	if (this.opacity > 0) {
		this.opacity -= reduceOpacityBy;
		if (this.opacity < 0) {
			this.opacity = 0;
		}

		if (this.fileProgressWrapper.filters) {
			try {
				this.fileProgressWrapper.filters.item("DXImageTransform.Microsoft.Alpha").opacity = this.opacity;
			} catch (e) {
				// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
				this.fileProgressWrapper.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=" + this.opacity + ")";
			}
		} else {
			this.fileProgressWrapper.style.opacity = this.opacity / 100;
		}
	}

	if (this.height > 0) {
		this.height -= reduceHeightBy;
		if (this.height < 0) {
			this.height = 0;
		}

		this.fileProgressWrapper.style.height = this.height + "px";
	}

	if (this.height > 0 || this.opacity > 0) {
		var oSelf = this;
		setTimeout(function () {
			oSelf.disappear();
		}, rate);
	} else {
		this.fileProgressWrapper.style.display = "none";
	}
};


/*
	handlers.js
*/

var formChecker = null;
function swfUploadLoaded(ob) {
	if (typeof ob.originalClickHandler!='undefined') return; // Called when Flash redisplayed after being obscured, so we need to return to avoid a recursion error

	var btnSubmit = document.getElementById(ob.settings.btnSubmitID);
	var old_onclick=btnSubmit.onclick;
	ob.originalClickHandler = old_onclick;
	btnSubmit.onclick = function(event,_ob,form,recurse) { if (typeof event=='undefined') var event=window.event; ob.originalClickHandler = old_onclick; return doSubmit(event,ob,recurse); };

	// Preview button too
	var btnSubmit2 = document.getElementById('preview_button');
	if (btnSubmit2)
	{
		var old_onclick2=btnSubmit2.onclick;
		btnSubmit2.onclick = function(event,_ob,form,recurse) { if (typeof event=='undefined') var event=window.event; ob.originalClickHandler = old_onclick2; return doSubmit(event,ob,recurse); };
	}
}

// Called by the submit button to start the upload
function doSubmit(e,ob,recurse) {
	/*
	This routine is rather complex. Essentially the uploader takes control of form submission, sitting in front of it, cancelling the form submission in it's own code.
	Rather than a normal form submit, click handlers on the submit button are chained after the upload is confirmed okay.
	If the full chain of click handlers returns true (same as checking the top click handler, which is put in originalClickHandler) then the form submit is manually triggered.
	*/

	if (formChecker != null) {
		clearInterval(formChecker);
		formChecker = null;
	}

	window.just_checking_requirements=true;

	ob.submitting=true;

	var btnSubmit=document.getElementById(ob.settings.btnSubmitID);
	var txtFileName = document.getElementById(ob.settings.txtFileNameID);
	if (txtFileName.value == '') // Field not filled in
	{
		var ret=true;
		if (ob.settings.required)
		{
			set_field_error(document.getElementById(ob.settings.txtName),'{!REQUIRED_NOT_FILLED_IN;^}');
			ret=false;
		}
		window.form_submitting=btnSubmit.form; // For IE
		if (typeof ob.originalClickHandler=='undefined')
		{
			if ((btnSubmit.form.onsubmit) && (false===btnSubmit.form.onsubmit())) return false;
			if (!ret) return false;
			if (!recurse) btnSubmit.form.submit();
			return true;
		}

		var ret2=ob.originalClickHandler(e,ob,btnSubmit.form,true);
		if (ret2 && !ret)
			window.fauxmodal_alert('{!REQUIRED_NOT_FILLED_IN;^}');
		if (!recurse && ret && ret2) btnSubmit.form.submit(); // If we aren't stuck in a recursion, and the field did not need filling in, and submit handler says otherwise okay, trigger the form to submit explicitly
		return ret && ret2; // Whether submit may happen (the field did not need filling in, and submit handler says otherwise okay)
	}

	e = e || window.event;
	if ((typeof e!='undefined') && (e))
	{
		cancel_bubbling(e);
		if (typeof e.preventDefault!='undefined') e.preventDefault();
	}

	var txtID = document.getElementById(ob.settings.txtFileDbID);
	if (txtID.value == '-1') // Has not uploaded yet
	{
		btnSubmit.disabled = true;
		ob.startUpload(); // Start the upload
		smooth_scroll(find_pos_y(txtFileName,true));
	} else // Has uploaded
	{
		window.just_checking_requirements=false;

		window.form_submitting=btnSubmit.form; // For IE

		if (typeof ob.originalClickHandler=='undefined')
		{
			if ((btnSubmit.form.onsubmit) && (false===btnSubmit.form.onsubmit())) return false;
			if (!recurse) btnSubmit.form.submit();
			return true;
		}

		if (ob.originalClickHandler(e,ob,btnSubmit.form,true))
		{
			if (!recurse) btnSubmit.form.submit();
			return true;
		}
	}

	return false; // Either has not uploaaded yet, or a submit handler otherwise blocked submission (which we must relay)
}

function fileDialogStart(ob) {
	var txtFileName = document.getElementById(ob.settings.txtFileNameID);
	txtFileName.value = '';
	var id = document.getElementById(ob.settings.txtFileDbID);
	id.value = '-1';
	ob.customSettings.upload_successful = false;

	this.cancelUpload();
}



function fileQueueError(file, errorCode, message, ob)  {
	// Handle this error separately because we don't want to create a FileProgress element for it.
	switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			window.fauxmodal_alert('You have attempted to queue too many files.\n' + (message === 0 ? 'You have reached the upload limit.' : 'You may select ' + (message > 1 ? 'up to ' + message + ' files.' : 'one file.')));
			return;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			window.fauxmodal_alert('{!FILE_TOO_BIG_GENERAL;^}');
			this.debug('Error Code: File too big, File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			return;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			window.fauxmodal_alert('{!FILE_WAS_EMPTY;^}');
			this.debug('Error Code: Zero byte file, File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			return;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			window.fauxmodal_alert('{!INVALID_FILE_TYPE_GENERAL^#,xxx}'.replace(/xxx/,ob.settings.file_types));
			this.debug('Error Code: Invalid File Type, File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			return;
		default:
			window.fauxmodal_alert('{!INTERNAL_ERROR;^}');
			this.debug('Error Code: ' + errorCode + ', File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			return;
	}
}

function fileQueued(file, ob) {
	var txtFileName = document.getElementById(ob.settings.txtFileNameID);
	txtFileName.value = file.name;
	var name=ob.settings.txtName;
	dispatch_for_page_type(ob.settings.page_type,name,file.name,ob.settings.posting_field_name);
	fireFakeChangeFor(name,'1');
}

function dispatch_for_page_type(page_type,name,file_name,posting_field_name)
{
	if ((typeof posting_field_name=='undefined') || (!posting_field_name)) var posting_field_name='post';

	if (page_type=='attachment')
	{
		var current_num=name.replace('file', '');
		set_attachment(posting_field_name,current_num,file_name);
		document.getElementById(name).onchange=null;
	}
	if (page_type=='upload_multi')
	{
		document.getElementById(name).onchange=null;

		var mid=name.lastIndexOf('_');
		if (mid==-1) mid=name.length-2;
		var nameStub=name.substring(0,mid+1);
		var thisNum=name.substring(mid+1,name.length)-0;
		var nextNum=thisNum+1;
		var txtFileName=document.getElementById('txtFileName_'+nameStub+'1');
		var nextField=document.getElementById('txtFileName_'+nameStub+nextNum);
		var name=nameStub+nextNum;
		var thisId=name;

		if (!nextField)
		{
			nextNum=thisNum+1;
			var nextField=document.createElement('input');
			nextField.className='input_upload';
			nextField.setAttribute('id',nameStub+nextNum);
			nextField.onchange=window._ensure_next_field_upload;
			nextField.setAttribute('type','file');
			nextField.name=nameStub+nextNum;
			var br=document.createElement('br');
			txtFileName.parentNode.parentNode.parentNode.appendChild(br);
			txtFileName.parentNode.parentNode.parentNode.appendChild(nextField);
			replaceFileInput('upload_multi',nextField.name,null,posting_field_name);
		}
	}
}

function fireFakeChangeFor(name,value)
{
	var rep=document.getElementById(name);
	if ((typeof rep.onchange!='undefined') && (rep.onchange)) rep.onchange();
	rep.value=value;
	rep.virtual_value=value;
	if ((typeof rep.simulated_events!='undefined') && (typeof rep.simulated_events['change']!='undefined'))
	{
		var e=rep.simulated_events['change'];
		var length=e.length;
		for (var i=0;i<length;i++)
			e[i]();
	}

	var ob=rep.swfob;
	if ((typeof ob.immediate_submit!='undefined') && (ob.immediate_submit))
	{
		var txtID = document.getElementById(ob.settings.txtFileDbID);
		var txtFileName = document.getElementById(ob.settings.txtFileNameID);
		if ((txtID.value == '-1') && (txtFileName.value != ''))
		{
			ob.submitting=false;
			ob.startUpload();
		}
	}
}

function fileDialogComplete(numFilesSelected, numFilesQueued, _, ob) {
	document.getElementById(ob.settings.btnSubmitID).disabled = false;
}

function uploadProgress(file, bytesLoaded, bytesTotal) {
	var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);

	var progress = new FileProgress(file, this.customSettings.progress_target);
	progress.setProgress(percent);
	progress.setStatus('{!SWFUPLOAD_UPLOADING;^}');
}

function uploadSuccess(file, serverData, _, ob) {
	var progress = new FileProgress(file, this.customSettings.progress_target);
	progress.setComplete();
	progress.setStatus('{!SWFUPLOAD_COMPLETE;^}');
	progress.toggleCancel(false);

	if (serverData === ' ') {
		this.customSettings.upload_successful = false;
	} else {
		this.customSettings.upload_successful = true;

		var decodedData = eval('(' + serverData + ')');
		document.getElementById(ob.settings.txtFileDbID).value = decodedData['upload_id'];

		if (typeof window.handle_meta_data_receipt!='undefined') handle_meta_data_receipt(decodedData);
	}
}

function uploadComplete(file, ob) {
	if (this.customSettings.upload_successful) {
		this.setButtonDisabled(true);

		var btnSubmit = document.getElementById(ob.settings.btnSubmitID);
		btnSubmit.disabled = false;

		if ((typeof ob.submitting!='undefined') && (ob.submitting))
		{
			window.form_submitting=btnSubmit.form; // For IE
			if (typeof ob.originalClickHandler!='undefined')
			{
				ob.originalClickHandler(null,ob,btnSubmit.form);
			} else
			{
				if ((btnSubmit.form.onsubmit) && (false===btnSubmit.form.onsubmit())) return;
				btnSubmit.form.submit();
			}
		}
	} else {
		var progress = new FileProgress(file, this.customSettings.progress_target);
		progress.setError();
		progress.setStatus('File rejected');
		progress.toggleCancel(false);

		var txtFileName = document.getElementById(ob.settings.txtFileNameID);

		if (txtFileName.value != '')
			window.fauxmodal_alert('{!INTERNAL_ERROR;^}');

		txtFileName.value = '';
		fireFakeChangeFor(ob.settings.txtName,'');
		document.getElementById(ob.settings.btnSubmitID).disabled = false;
	}
}

function uploadError(file, errorCode, message, ob) {
	if (errorCode === SWFUpload.UPLOAD_ERROR.FILE_CANCELLED) {
		// Don't show cancelled error boxes
		return;
	}

	var txtFileName = document.getElementById(ob.settings.txtFileNameID);
	txtFileName.value = '';
	fireFakeChangeFor(ob.settings.txtName,'');
	document.getElementById(ob.settings.btnSubmitID).disabled = false;

	// Handle this error separately because we don't want to create a FileProgress element for it.
	switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			window.fauxmodal_alert('{!ONLY_ONE_FILE;^}');
			this.debug('Error Code: Upload Limit Exceeded, File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			return;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			break;
		default:
			window.fauxmodal_alert('An error occurred in the upload. Try again later.');
			this.debug('Error Code: ' + errorCode + ', File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			return;
	}

	var progress = new FileProgress(file, this.customSettings.progress_target);
	progress.setError();
	progress.toggleCancel(false);

	switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			progress.setStatus('Upload Error');
			this.debug('Error Code: HTTP Error, File name: ' + file.name + ', Message: ' + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus('{!SWFUPLOAD_FAILED;^}');
			this.debug('Error Code: Upload Failed, File name: ' + file.name + ', File size: ' + file.size + ', Message: ' + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus('Server (IO) Error');
			this.debug('Error Code: IO Error, File name: ' + file.name + ', Message: ' + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus('Security Error');
			this.debug('Error Code: Security Error, File name: ' + file.name + ', Message: ' + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			progress.setStatus('{!SWFUPLOAD_CANCELLED;^}');
			this.debug('Error Code: Upload Cancelled, File name: ' + file.name + ', Message: ' + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus('{!SWFUPLOAD_STOPPED;^}');
			this.debug('Error Code: Upload Stopped, File name: ' + file.name + ', Message: ' + message);
			break;
	}
}

function preinitFileInput(page_type,name,_btnSubmitID,posting_field_name,filter)
{
	if (('{$CONFIG_OPTION,complex_uploader}'=='0') || (window.location.search.indexOf('keep_no_swfupload=1')!=-1)) return;
	if ('{$MOBILE}'=='1') return;

	if ((typeof posting_field_name=='undefined') || (!posting_field_name)) var posting_field_name='post';

	var rep=document.getElementById(name);
	rep.originally_disabled=rep.disabled;
	rep.disabled=true;
	replaceFileInput(page_type,name,_btnSubmitID,posting_field_name,filter);
}

function replaceFileInput(page_type,name,_btnSubmitID,posting_field_name,filter)
{
	if (typeof filter=='undefined') var filter='{$CONFIG_OPTION;,valid_types}';
	if (filter=='') filter='{$CONFIG_OPTION;,valid_types}';
	filter+=','+filter.toUpperCase();

	var rep=document.getElementById(name);
	if (!rep.originally_disabled) rep.disabled=false;

	// Mark so we don't do more than once
	if (typeof rep.replaced_with_swfupload!='undefined') return;
	rep.replaced_with_swfupload=true;

	if (('{$CONFIG_OPTION,complex_uploader}'=='0') || (window.location.search.indexOf('keep_no_swfupload=1')!=-1)) return;
	if ('{$MOBILE}'=='1') return;

	if (typeof window.no_java=='undefined') window.no_java=false;

	var java_method=false;
	{+START,IF,{$CONFIG_OPTION,java_upload}}
		if (window.location.search.indexOf('keep_java=1')!=-1)
		{
			if ((!window.no_java) && (isValidJVM())) java_method=true;
		}
	{+END}

	if (!java_method)
	{
		function getFlashVersion(){
			var flashNiceWay=function()
			{
				try
				{
					if(navigator.mimeTypes['application/x-shockwave-flash'].enabledPlugin)
					{
						return (navigator.plugins['Shockwave Flash 2.0'] || navigator.plugins['Shockwave Flash']).description.replace(/\D+/g, ',').match(/^,?(.+),?$/)[1];
					}
				}
				catch(e) {}
				return '0,0,0';
			};

			// ie
			if (typeof window.ActiveXObject!='undefined')
			{
				try {
					try {
						// avoid fp6 minor version lookup issues
						// see: http://blog.deconcept.com/2006/01/11/getvariable-setvariable-crash-internet-explorer-flash-6/
						var axo = new ActiveXObject('ShockwaveFlash.ShockwaveFlash.6');
						try { axo.AllowScriptAccess = 'always'; }
						catch(e) { return '6,0,0'; }
					}
					catch(e) {}
					return new ActiveXObject('ShockwaveFlash.ShockwaveFlash').GetVariable('$version').replace(/\D+/g, ',').match(/^,?(.+),?$/)[1];
				// other browsers
				} catch(e) {
					return flashNiceWay();
				}
			} else
			{
				return flashNiceWay();
			}
			return '0,0,0';
		}
 
		var version = getFlashVersion().split(',').shift();
		if(version < 9)
		{
			return;
		}
	}

	if (!_btnSubmitID)
	{
		_btnSubmitID='submit_button';
		if (!document.getElementById(_btnSubmitID))
		{
			_btnSubmitID=null;
			var inputs=rep.form.elements;
			for (var i=0;i<inputs.length;i++)
			{
				if ((inputs[i].nodeName.toLowerCase()=='button') || (inputs[i].type=='image') || (inputs[i].type=='submit') || (inputs[i].type=='button'))
				{
					if (!inputs[i].id) inputs[i].id='rand_id_'+Math.floor(Math.random()*10000);
					_btnSubmitID=inputs[i].id;
					if (inputs[i].getAttribute('accesskey')=='u') /* Identifies submit button */
						break; // Ideal, let us definitely use this (otherwise we end up using the last)
				}
			}
		}
	}

	var maindiv=document.createElement('div');
	rep.parentNode.appendChild(maindiv);

	var subdiv=document.createElement('div');
	maindiv.appendChild(subdiv);

	if (!java_method)
	{
		var filenameField=document.createElement('input');
		filenameField.setAttribute('size',24);
		filenameField.setAttribute('id','txtFileName_'+name);
		filenameField.setAttribute('type','text');
		filenameField.value='';
		filenameField.name='txtFileName_'+name;
		filenameField.disabled=true;
		subdiv.appendChild(filenameField);
	}

	var placeholder=document.createElement('span');
	placeholder.id='spanButtonPlaceholder_'+name;
	subdiv.appendChild(placeholder,rep);

	var progressDiv=document.createElement('div');
	progressDiv.id='fsUploadProgress_'+name;
	progressDiv.className='flash';
	maindiv.appendChild(progressDiv);

	var hidFileID=document.createElement('input');
	hidFileID.setAttribute('id','hidFileID_'+name);
	hidFileID.name='hidFileID_'+name;
	hidFileID.setAttribute('type','hidden');
	hidFileID.value='-1';
	maindiv.appendChild(hidFileID);

	var disable_link=document.createElement('a');
	set_inner_html(disable_link,'{!SWITCH_TO_REGULAR_UPLOADER;}');
	disable_link.setAttribute('href',window.location+(((window.location+'').indexOf('?')==-1)?'?':'&')+'keep_no_swfupload=1');
	disable_link.className='associated_details';
	disable_link.target='_blank';
	disable_link.onclick=function(e) {
		if ((window.handle_form_saving) && document.getElementById(posting_field_name)) handle_form_saving(e,document.getElementById(posting_field_name),true);

		window.fauxmodal_confirm(
			'{!DISABLE_SWFUPLOAD_CONFIRM;}',
			function(proceeding)
			{
				if (proceeding)
					click_link(disable_link);
			},
			'{!Q_SURE;}'
		);

		return false;
	}
	maindiv.appendChild(disable_link);

	// Replace old upload field with text field that holds a "1" indicating upload has happened (and telling ocP to check the hidFileID value for more details)
	rep.style.display='none';
	rep.disabled=true;
	rep.name=name+'_old';
	rep.id=name+'_old';
	var rep2=document.createElement('input');
	rep2.type='text';
	rep2.simulated_events=rep.simulated_events;
	rep2.style.display='none';
	rep2.disabled=true;
	rep2.name=name;
	rep2.id=name;
	rep.parentNode.appendChild(rep2);
	var clearBtn=document.getElementById('clearBtn_'+name);
	if (clearBtn) clearBtn.style.display='none';

	if (java_method)
	{
		var btnSubmit=document.getElementById(_btnSubmitID);

		var hidFileName=document.createElement('input');
		hidFileName.setAttribute('id','hidFileName_'+name);
		hidFileName.name='hidFileName_'+name;
		hidFileName.setAttribute('type','hidden');
		hidFileName.value='';
		maindiv.appendChild(hidFileName);

		var random=Math.floor(Math.random()*100000);

		var base='{$CONFIG_OPTION*;,java_ftp_path}';
		if (base.substr(base.length-1,1)!='/') base+='/';
		hidFileID.value=''+random+'.dat';

		var colorAt=rep.parentNode,backgroundColor;
		do
		{
			backgroundColor=abstract_get_computed_style(colorAt,'background-color');
			colorAt=colorAt.parentNode;
		}
		while ((colorAt) && (backgroundColor) && (backgroundColor=='transparent'));
		if ((!backgroundColor) || (backgroundColor=='transparent')) backgroundColor='#FFFFFF';
		var foregroundColor=abstract_get_computed_style(rep.parentNode,'color');
		if (!foregroundColor) foregroundColor='#000000';
		var matches;
		function dec_to_hex(number)
		{
			var hexbase='0123456789ABCDEF';
			return hexbase.charAt((number>>4)&0xf)+hexbase.charAt(number&0xf);
		}
		matches=backgroundColor.match(/^\s*rgba?\s*\(\s*(\d+),\s*(\d+),\s*(\d+)\s*(,\s*(\d+)\s*)?\)\s*$/i);
		if (matches) backgroundColor='#'+dec_to_hex(matches[1])+dec_to_hex(matches[2])+dec_to_hex(matches[3]);
		matches=foregroundColor.match(/^\s*rgba?\s*\(\s*(\d+),\s*(\d+),\s*(\d+)\s*(,\s*(\d+)\s*)?\)\s*$/i);
		if (matches) foregroundColor='#'+dec_to_hex(matches[1])+dec_to_hex(matches[2])+dec_to_hex(matches[3]);

		var out='';
		var maxLength=(typeof btnSubmit.form.elements['MAX_FILE_SIZE']=='undefined')?'2000000000':(btnSubmit.form.elements['MAX_FILE_SIZE'].value);
		out+='<object width="430" height="29" classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93">';
		out+='	<param name="codebase" value="{$BASE_URL*;}/data/javaupload/" />';
		out+='	<param name="code" value="Uploader.class" />';
		out+='	<param name="archive" value="{$BASE_URL*;}/data/javaupload/Uploader.jar?cachebreak='+random+',{$BASE_URL*;}/data/javaupload/Net.jar" />';
		out+='	<param name="scriptable" VALUE="true" />';
		out+='	<param name="mayscript" VALUE="true" />';
		out+='	<param name="address" value="{$CONFIG_OPTION*;,java_ftp_host}" />';
		out+='	<param name="username" value="{$CONFIG_OPTION*;,java_username}" />';
		out+='	<param name="password" value="{$CONFIG_OPTION*;,java_password}" />';
		out+='	<param name="uploadedFileName" value="'+base+random+'.dat" />';
		out+='	<param name="backgroundColor" value="'+backgroundColor+'" />';
		out+='	<param name="foregroundColor" value="'+foregroundColor+'" />';
		out+='	<param name="fileNameID" value="hidFileName_'+name+'" />';
		out+='	<param name="nameID" value="'+name+'" />';
		out+='	<param name="maxLength" value="'+maxLength+'" />';
		out+='	<param name="page_type" value="'+page_type+'" />';
		out+='	<param name="posting_field_name" value="'+posting_field_name+'" />';
		out+='	<param name="_btnSubmitID" value="'+_btnSubmitID+'" />';
		out+='	<param name="types" value="'+escape_html(filter)+'" />';
		out+='	<param name="fail_message" value="{$REPLACE*,<br />,\\n,{!JAVA_FTP_fail_message;^}}" />';
		out+='	<param name="uploaded_message" value="{!JAVA_FTP_uploaded_message*;^}" />';
		out+='	<param name="reverting_title" value="{!JAVA_FTP_reverting_title*;^}" />';
		out+='	<param name="valid_types_label" value="{!JAVA_FTP_valid_types_label*;^}" />';
		out+='	<param name="refused_connection" value="{!JAVA_FTP_refused_connection*;^}" />';
		out+='	<param name="output_complete" value="{!JAVA_FTP_output_complete*;^}" />';
		out+='	<param name="transfer_error" value="{!JAVA_FTP_transfer_error*;^}" />';
		out+='	<param name="file_name_label" value="{!JAVA_FTP_file_name_label*;^}" />';
		out+='	<param name="browse_label" value="{!JAVA_FTP_browse_label*;^}" />';
		out+='	<param name="upload_label" value="{!JAVA_FTP_upload_label*;^}" />';
		out+='	<param name="please_choose_file" value="{!JAVA_FTP_please_choose_file*;^}" />';
		out+='	<param name="wrong_path" value="{!JAVA_FTP_wrong_path*;^}" />';
		out+='	<param name="max_size_label" value="{!JAVA_FTP_max_size_label*;^}" />';
		out+='	<param name="too_large" value="{!JAVA_FTP_too_large*;^}" />';
		out+='	<comment>';
		out+='		<embed width="430" height="29" fail_message="{$REPLACE*,<br />,\\n,{!JAVA_FTP_fail_message;^}}" uploaded_message="{!JAVA_FTP_uploaded_message*;^}" reverting_title="{!JAVA_FTP_reverting_title*;^}" valid_types_label="{!JAVA_FTP_valid_types_label*;^}" refused_connection="{!JAVA_FTP_refused_connection*;^}" output_complete="{!JAVA_FTP_output_complete*;^}" transfer_error="{!JAVA_FTP_transfer_error*;^}" file_name_label="{!JAVA_FTP_file_name_label*;^}" browse_label="{!JAVA_FTP_browse_label*;^}" upload_label="{!JAVA_FTP_upload_label*;^}" please_choose_file="{!JAVA_FTP_please_choose_file*;^}" wrong_path="{!JAVA_FTP_wrong_path*;^}" max_size_label="{!JAVA_FTP_max_size_label*;^}" too_large="{!JAVA_FTP_too_large*;^}" _btnSubmitID="'+_btnSubmitID+'" page_type="'+page_type+'" nameID="'+name+'" types="{$CONFIG_OPTION,valid_types}" maxLength="'+maxLength+'" fileNameID="hidFileName_'+name+'" address="{$CONFIG_OPTION*;,java_ftp_host}" username="{$CONFIG_OPTION*;,java_username}" password="{$CONFIG_OPTION*;,java_password}" uploadedFileName="'+base+random+'.dat" backgroundColor="'+backgroundColor+'" foregroundColor="'+foregroundColor+'" scriptable="true" mayscript="true" codebase="{$BASE_URL*;}/data/javaupload/" code="Uploader.class" archive="{$BASE_URL*;}/data/javaupload/Uploader.jar?cachebreak='+random+',{$BASE_URL*;}/data/javaupload/Net.jar" type="application/x-java-applet" pluginspage="http://java.sun.com/products/plugin/index.html#download">';
		out+='		</embed>';
		out+='	</comment>';
		out+='</object>';
		/*out+='<applet mayscript="true" scriptable="true" code="Uploader.class" archive="{$BASE_URL}/data/javaupload/Uploader.jar?cachebreak='+random+',{$BASE_URL}/data/javaupload/Net.jar" width="430" height="29" id="uploader_'+name+'">';
		out+='</applet>';*/
		set_inner_html(progressDiv,out);

		var old_onclick=btnSubmit.onclick;
		btnSubmit.onclick=function() {
			if ((rep2.value=='1') || (rep.className.indexOf('required')==-1))
			{
				window.form_submitting=btnSubmit.form; // For IE
				old_onclick();
				return;
			}
			window.fauxmodal_alert('{!UPLOAD_FIRST;^}');
			btnSubmit.disabled=true;
			var timer=window.setInterval(function() {
				if (rep2.value=='1')
				{
					window.clearTimeout(timer);
					btnSubmit.disabled=false;
					window.form_submitting=btnSubmit.form; // For IE
					old_onclick();
				}
			} , 500);
		}

		return;
	}

	try
	{
		var mfs=filenameField.form.elements['MAX_FILE_SIZE'];
		if ((typeof mfs!='undefined') && (typeof mfs.value=='undefined')) mfs=mfs[0];

		filter='*.'+filter.replace(/,/g,';*.');

		var ob=new SWFUpload({
			// ocPortal binding settings
			txtFileNameID : 'txtFileName_'+name,
			txtFileDbID : 'hidFileID_'+name,
			txtName : name,
			page_type : page_type,
			btnSubmitID: _btnSubmitID,
			required: rep.className.indexOf('required')!=-1,
			posting_field_name: posting_field_name,

			// Backend settings
			upload_url: '{$FIND_SCRIPT;,incoming_uploads}'+keep_stub(true),
			file_post_name: 'file',

			// Flash file settings
			file_size_limit : (typeof mfs=='undefined')?'2 GB':(((typeof mfs[0]!='undefined')?mfs[0].value:mfs.value)+' B'),
			file_types : (name.indexOf('file_novalidate')==-1)?filter:'*.*',
			file_types_description : '{!ALLOWED_FILES;^}',
			file_upload_limit : '0',
			file_queue_limit : '1',

			// Event handler settings
			swfupload_loaded_handler : swfUploadLoaded,

			file_dialog_start_handler: fileDialogStart,
			file_queued_handler : fileQueued,
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,

			//upload_start_handler : uploadStart,	// I could do some client/JavaScript validation here, but I don't need to.
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccess,
			upload_complete_handler : uploadComplete,

			// Button Settings
			button_image_url : '{$IMG;,pageitem/upload}'.replace(/^http:/,window.location.protocol),
			button_placeholder_id : 'spanButtonPlaceholder_'+name,
			button_width: 66,
			button_height: 20,
			button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,

			// Flash Settings
			flash_url : '{$BASE_URL_NOHTTP;}'+'/data/swfupload/swfupload.swf',

			custom_settings : {
				progress_target : 'fsUploadProgress_'+name,
				upload_successful : false
			},

			// Debug settings
			debug: false
		});
		rep2.swfob=ob;

		var newClearBtn=document.createElement('input');
		newClearBtn.id='fsClear_'+name;
		newClearBtn.type='image';
		newClearBtn.setAttribute('src','{$IMG;,pageitem/clear}'.replace(/^http:/,window.location.protocol));
		newClearBtn.style.marginLeft='8px';
		newClearBtn.style.verticalAlign='top';
		newClearBtn.value='{!UPLOAD;^}: {!CLEAR;^}';
		subdiv.appendChild(newClearBtn);

		newClearBtn.onclick=function() {
			var txtFileName = document.getElementById('txtFileName_'+name);
			txtFileName.value = '';
			if ((typeof rep.form.elements[posting_field_name]!='undefined') && (name.indexOf('file')!=-1))
			{
				var new_contents=get_textbox(rep.form.elements[posting_field_name]);
				new_contents=new_contents.replace(new RegExp('\\[(attachment|attachment_safe)[^\\]]*\\]new_'+name.replace(/^file/,'')+'\\[/(attachment|attachment_safe)\\]'),'');
				new_contents=new_contents.replace(new RegExp('<input[^<>]* class="ocp_keep_ui_controlled"[^<>]*[^<>]* value="[^"]+"[^<>]* />'),''); // Shell of the above
				set_textbox(rep.form.elements[posting_field_name],new_contents,new_contents);
			}
			fireFakeChangeFor(name,'');
			ob.setButtonDisabled(false);
			document.getElementById(ob.settings.txtFileDbID).value='-1';
			ob.customSettings.upload_successful = false;
			return false;
		};
	}
	catch (e) {
		//window.fauxmodal_alert(e.message);
		// Failed to load - so restore normal file input
		restoreFormerInput(maindiv,rep2,rep,name,page_type,_btnSubmitID,posting_field_name);
	}
}

function restoreFormerInput(maindiv,rep2,rep,name,page_type,_btnSubmitID,thenRefresh,posting_field_name)
{
	if (!maindiv) maindiv=document.getElementById('hidFileID_'+name).parentNode;
	if (!rep2) rep2=document.getElementById(name+'_old');
	if (!rep) rep=document.getElementById(name);

	var hidFileID=document.getElementById('hidFileID_'+name);
	if (hidFileID)
	{
		hidFileID.parentNode.removeChild(hidFileID);
	}
	var txtFileName=document.getElementById('txtFileName_'+name);
	if (txtFileName)
	{
		txtFileName.parentNode.removeChild(txtFileName);
	}

	maindiv.parentNode.removeChild(maindiv);
	rep2.parentNode.removeChild(rep2);
	rep.style.display='block';
	rep.disabled=false;
	rep.name=name;
	rep.id=name;

	if (thenRefresh)
	{
		window.no_java=true;
		replaceFileInput(page_type,name,_btnSubmitID,posting_field_name);
	}
}

/* JAVA UPLOAD (VIA FTP) */

/** 
 * check to see if the JVM supports the file uploader... 
 */  
function isValidJVM()  
{  
	var pluginWanted='application/x-java-applet;version=';	//	Not needed as in theory the _isValidJVM checks should work on Firefox too
	for (var i=0; i < navigator.plugins.length; i++)
	{
		for (var j = 0; j < navigator.plugins[i].length; j++)
		{
			var full = navigator.plugins[i][j].type;
			if (full.substr(0,pluginWanted.length) == pluginWanted)
			{
				if ((full.substr(pluginWanted.length) != '1.0')
				&&
				(full.substr(pluginWanted.length) != '1.1')
				&&
				(full.substr(pluginWanted.length) != '1.2')
				&&
				(full.substr(pluginWanted.length) != '1.3')
				&&
				(full.substr(pluginWanted.length) != '1.4')
				)
					return true;
			}
		}
	}

	var checker = document.getElementById('java_checker_2');
	if (checker) if (_isValidJVM(checker)) return true;
	var checker = document.getElementById('java_checker_1');
	if (checker) if (_isValidJVM(checker)) return true;
	return false;
}  

function _isValidJVM(checker)  
{  
	return (checker.getVersion != null &&
		checker.getVendor != null &&
		checker.getVendor().indexOf('Sun') > -1 &&
		checker.getVersion().substr(0,3) != '1.0'
		&&
		checker.getVersion().substr(0,3) != '1.1'
		&&
		checker.getVersion().substr(0,3) != '1.2'
		&&
		checker.getVersion().substr(0,3) != '1.3'
		&&
		checker.getVersion().substr(0,3) != '1.4'
	);
}

/* HTML5 UPLOAD */

function initialise_dragdrop_upload(key,key2)
{
	var ob=document.getElementById(key);
	ob.ondragover=function(event) { if (typeof event=='undefined') var event=window.event; if ((typeof event.dataTransfer!='undefined') && (typeof event.dataTransfer.types!='undefined') && (event.dataTransfer.types[0].indexOf('text')==-1)) { cancel_bubbling(event); if (typeof event.preventDefault!='undefined') event.preventDefault(); event.returnValue=false; } }; // NB: don't use dropEffect, prevents drop on Firefox.
	ob.ondrop=function(event) { if (typeof event=='undefined') var event=window.event; html5_upload(event,key2); };
}

function html5_upload(event,field_name,files)
{
	var dt = event.dataTransfer;
	if (typeof dt=='undefined') return;
	if (!files) files = dt.files;
	if (typeof files=='undefined') return;
	var count = files.length;

	if (count>0)
	{
		cancel_bubbling(event);
		if (typeof event.preventDefault!='undefined') event.preventDefault();
	}

	if (typeof window.extraAttachmentBase=='undefined') window.extraAttachmentBase=1000;

	var boundary = '------multipartformboundary' + (new Date).getTime();
	var dashdash = '--';
	var crlf	= '\r\n';

	var valid_types='{$CONFIG_OPTION;,valid_types}'.split(/\s*,\s*/g);

	for (var i = 0; i < count; i++)
	{
		var file=files.item(i);

		if ((typeof file.size!='undefined') && (file.size>3000000))
		{
			window.fauxmodal_alert('{!FILE_TOO_LARGE_DRAGANDDROP;^}');
			continue;
		}

		var request = new XMLHttpRequest();
		var fileUpload = request.upload;

		// File type check
		var good_type=false;
		var file_ext=file.name.substr(file.name.indexOf('.')+1);
		for (var j=0;j<valid_types.length;j++)
		{
			if (valid_types[j]==file_ext)
			{
				good_type=true;
				break;
			}
		}
		if (!good_type)
		{
			window.fauxmodal_alert('{!INVALID_FILE_TYPE_GENERAL;^}'.replace(/\\{1\\}/g,file_ext).replace(/\\{2\\}/g,valid_types.join(', ')));
			continue;
		}

		fileUpload.fileProgress={
			id: 'progress_'+window.extraAttachmentBase,
			name: file.name
		};

		fileUpload.addEventListener('progress', function(e) { if (typeof e=='undefined') var e=window.event; html5_upload_progress(e,field_name); }, false);
		request.onreadystatechange = build_upload_handler(request,fileUpload.fileProgress,window.extraAttachmentBase,field_name);

		/* Generate headers. */
		var data='';
		data+=(dashdash);
		data+=(boundary);
		data+=(crlf);
		data+=('Content-Disposition: form-data; name="file"');
		if (file.name) {
			data+=('; filename="' + file.name + '"');
		}
		data+=(crlf);

		data+=('Content-Type: application/octet-stream');
		data+=(crlf);
		data+=(crlf); 

		/* Append binary data. */
		var file_data;
		if (typeof file.getAsBinaryString!='undefined') file_data=file.getAsBinaryString();
		else if (typeof file.getAsBinary!='undefined') file_data=file.getAsBinary();
		else if (typeof file.readAsBinaryString!='undefined') file_data=file.readAsBinaryString();
		else
		{
			if (typeof window.FileReader!='undefined') // Chrome sends differently, so we cheat and patch it to behave like Firefox
			{
				var file_reader=new FileReader();
				file_reader.readAsBinaryString(file);
				var main_event=event;
				file_reader.onloadend=function(){
					file_data=file_reader.result;
					file.getAsBinaryString=function()
					{
						return file_data;
					}
					html5_upload(main_event,field_name,files);
				};
				continue;
			} else
			return; // :(. Probably old Chrome
		}
		if (typeof request.sendAsBinary=='undefined')
		{
			file_data=base64_encode(file_data);
		}
		data+=file_data;
		data+=(crlf);

		/* Write boundary. */
		data+=(dashdash);
		data+=(boundary);
		data+=(crlf);

		if (typeof request.sendAsBinary=='undefined')
		{
			request.open('POST', '{$FIND_SCRIPT;,incoming_uploads}'+keep_stub(true)+'&base64=1');
		} else
		{
			request.open('POST', '{$FIND_SCRIPT;,incoming_uploads}'+keep_stub(true));
		}
		request.overrideMimeType('multipart/form-data; boundary=' + boundary);
		request.setRequestHeader('content-type','multipart/form-data; boundary=' + boundary);
		if (typeof request.sendAsBinary!='undefined')
		{
			request.sendAsBinary(data);
		} else
		{
			request.send(data);
		}

		/* HTML hidden fields */
		var hidfileid=document.createElement('input');
		hidfileid.type='hidden';
		hidfileid.name='hidFileID_file'+window.extraAttachmentBase;
		hidfileid.id=hidfileid.name;
		hidfileid.value='-1';
		document.getElementById('container_for_'+field_name).appendChild(hidfileid);
		var hidfilename=document.createElement('input');
		hidfilename.type='hidden';
		hidfilename.name='txtFileName_file'+window.extraAttachmentBase;
		hidfilename.id=hidfilename.name;
		hidfilename.value=file.name;
		document.getElementById('container_for_'+field_name).appendChild(hidfilename);

		var progress = new FileProgress(fileUpload.fileProgress, 'container_for_'+field_name);
		progress.setProgress(0);
		progress.setStatus('{!SWFUPLOAD_UPLOADING;^}');

		/* Keep tabs of it */
		window.extraAttachmentBase++;
	}
}

function html5_upload_progress(event,field_name)
{
	if (event.lengthComputable) {
		var percentage = Math.round((event.loaded * 100) / event.total);
		if (percentage < 100) {
			var progress = new FileProgress(event.target.fileProgress, 'container_for_'+field_name);
			progress.setProgress(percentage);
			progress.setStatus('{!SWFUPLOAD_UPLOADING;^}');
		}
	}
}

function build_upload_handler(request,fileProgress,attachmentBase,field_name)
{
	return function() {
		switch(request.readyState) {
			case 4:
				if (request.responseText=='') {
					/* We should have got an ID back */

					var progress = new FileProgress(fileProgress, 'container_for_'+field_name);
					progress.setProgress(100);
					progress.setStatus('{!SWFUPLOAD_FAILED;^}');
				} else
				{
					insert_textbox(document.getElementById(field_name),'[attachment description=\"'+fileProgress.name.replace(/"/g,'\'')+'\" thumb=\"1\" type=\"island\"]new_"+attachmentBase+"[/attachment]\n');

					var progress = new FileProgress(fileProgress, 'container_for_'+field_name);
					progress.setProgress(100);
					progress.setComplete();
					progress.setStatus('{!SWFUPLOAD_COMPLETE;^}');

					var decodedData = eval('(' + request.responseText + ')');
					document.getElementById('hidFileID_file'+attachmentBase).value = decodedData['upload_id'];
				}

				break;
		}
	};
}

function base64_encode(input) // Based on http://www.webtoolkit.info/javascript-base64.html
{
	var output = '';
	var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
	var i = 0;

	//input = _utf8_encode(input);

	var _keyStr='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

	while (i < input.length) {

		chr1 = input.charCodeAt(i++);
		chr2 = input.charCodeAt(i++);
		chr3 = input.charCodeAt(i++);

		enc1 = chr1 >> 2;
		enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		enc4 = chr3 & 63;

		if (isNaN(chr2)) {
			enc3 = enc4 = 64;
		} else if (isNaN(chr3)) {
			enc4 = 64;
		}

		output = output +
		_keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
		_keyStr.charAt(enc3) + _keyStr.charAt(enc4);

	}

	return output;
}
