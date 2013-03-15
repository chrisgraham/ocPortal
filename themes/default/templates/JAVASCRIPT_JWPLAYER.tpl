{$,Parser hint: pure}
{$,Parser hint: .innerHTML okay}

jwplayer = function (a) {
	return jwplayer.constructor(a)
};
jwplayer.constructor = function (a) {};
$jw = jwplayer;
jwplayer.utils = function () {};
jwplayer.utils.typeOf = function (b) {
	var a = typeof b;
	if (a === "object") {
		if (b) {
			if (b instanceof Array) {
				a = "array"
			}
		} else {
			a = "null"
		}
	}
	return a
};
jwplayer.utils.extend = function () {
	var a = jwplayer.utils.extend["arguments"];
	if (a.length > 1) {
		for (var b = 1; b < a.length; b++) {
			for (element in a[b]) {
				a[0][element] = a[b][element]
			}
		}
		return a[0]
	}
	return null
};
jwplayer.utils.extension = function (a) {
	return a.substr(a.lastIndexOf(".") + 1, a.length).toLowerCase()
};
jwplayer.utils.html = function (a, b) {
	a.innerHTML = b
};
jwplayer.utils.append = function (a, b) {
	a.appendChild(b)
};
jwplayer.utils.wrap = function (a, b) {
	a.parentNode.replaceChild(b, a);
	b.appendChild(a)
};
jwplayer.utils.ajax = function (d, c, a) {
	var b;
	if (window.XMLHttpRequest) {
		b = new XMLHttpRequest()
	} else {
		b = new ActiveXObject("Microsoft.XMLHTTP")
	}
	b.onreadystatechange = function () {
		if (b.readyState === 4) {
			if (b.status === 200) {
				if (c) {
					c(b)
				}
			} else {
				if (a) {
					a(d)
				}
			}
		}
	};
	b.open("GET", d, true);
	b.send(null);
	return b
};
jwplayer.utils.load = function (b, c, a) {
	b.onreadystatechange = function () {
		if (b.readyState === 4) {
			if (b.status === 200) {
				if (c) {
					c()
				}
			} else {
				if (a) {
					a()
				}
			}
		}
	}
};
jwplayer.utils.find = function (b, a) {
	return b.getElementsByTagName(a)
};
jwplayer.utils.append = function (a, b) {
	a.appendChild(b)
};
jwplayer.utils.isIE = function () {
	return navigator.userAgent.toLowerCase().indexOf('msie')!=-1;
};
jwplayer.utils.isIOS = function () {
	var a = navigator.userAgent.toLowerCase();
	return (a.match(/iP(hone|ad)/i) !== null)
};
jwplayer.utils.hasHTML5 = function (b) {
	var a = document.createElement("video");
	if ( !! a.canPlayType) {
		if (b) {
			var d = {};
			if (b.playlist && b.playlist.length) {
				d.file = b.playlist[0].file;
				d.levels = b.playlist[0].levels
			} else {
				d.file = b.file;
				d.levels = b.levels
			}
			if (d.file) {
				return jwplayer.utils.vidCanPlay(a, d.file)
			} else {
				if (d.levels && d.levels.length) {
					for (var c = 0; c < d.levels.length; c++) {
						if (d.levels[c].file && jwplayer.utils.vidCanPlay(a, d.levels[c].file, d.levels[c].type)) {
							return true
						}
					}
				}
			}
		} else {
			return true
		}
	}
	return false
};
jwplayer.utils.vidCanPlay = function (b, a, sourceType) {
	if (!sourceType)
	{
		var c = jwplayer.utils.strings.extension(a);
		if (jwplayer.utils.extensionmap[c] !== undefined) {
			sourceType = jwplayer.utils.extensionmap[c]
		} else {
			sourceType = "video/" + c + ";"
		}
	}
	return (b.canPlayType(sourceType) || a.toLowerCase().indexOf("youtube.com") > -1)
};
jwplayer.utils.hasFlash = function() { 
	if (typeof navigator.plugins != "undefined" && typeof navigator.plugins['Shockwave Flash'] != "undefined") { 
		return true; 
	} 
	if (typeof window.ActiveXObject != "undefined") { 
		try { 
			new ActiveXObject("ShockwaveFlash.ShockwaveFlash"); 
			return true 
		} catch (err) { 
		} 
	}
	return false; 
};
(function (e) {
	e.utils.mediaparser = function () {};
	var g = {
		element: {
			width: "width",
			height: "height",
			id: "id",
			"class": "className",
			name: "name"
		},
		media: {
			src: "file",
			preload: "preload",
			autoplay: "autostart",
			loop: "repeat",
			controls: "controls"
		},
		source: {
			src: "file",
			type: "type",
			media: "media",
			"data-jw-width": "width",
			"data-jw-bitrate": "bitrate"
		},
		video: {
			poster: "image"
		}
	};
	var f = {};
	e.utils.mediaparser.parseMedia = function (i) {
		return d(i)
	};

	function c(j, i) {
		if (i === undefined) {
			i = g[j]
		} else {
			e.utils.extend(i, g[j])
		}
		return i
	}
	function d(m, i) {
		if (f[m.tagName.toLowerCase()] && (i === undefined)) {
			return f[m.tagName.toLowerCase()](m)
		} else {
			var n = {};

				var children=m.getElementsByTagName('source');
				for (var ci=0;ci<children.length;ci++)
				{
					var nx=d(children[ci], i);
					for (var nxi in nx)
					{
						n[nxi]=nx[nxi];
					}
				}

			i = c("element", i);
			for (var j in i) {
				if (j != "length") {
					var l = m.getAttribute(j);
					if (!(l === "" || l === undefined || l === null)) {
						n[i[j]] = m.getAttribute(j)
					}
				}
			}
			var k = m.style["#background-color"];
			if (k && !(k == "transparent" || k == "rgba(0, 0, 0, 0)")) {
				n.screencolor = k
			}
			return n
		}
	}
	function h(o, k) {
		k = c("media", k);
		var m = [];
		if (e.utils.isIE()) {
			var l = o.nextSibling;
			if (l !== undefined) {
				while (l.nodeName.toLowerCase() == "source") {
					m.push(a(l));
					l = l.nextSibling
				}
			}
		} else {
			var j = e.utils.selectors("source", o);
			for (var n in j) {
				if (!isNaN(n)) {
					m.push(a(j[n]))
				}
			}
		}
		var p = d(o, k);
		if (p.file !== undefined) {
			m[0] = {
				file: p.file
			}
		}
		p.levels = m;
		return p
	}
	function a(k, j) {
		j = c("source", j);
		var i = d(k, j);
		i.width = i.width ? i.width : 0;
		i.bitrate = i.bitrate ? i.bitrate : 0;
		return i
	}
	function b(k, j) {
		j = c("video", j);
		var i = h(k, j);
		return i
	}
	e.utils.mediaparser.replaceMediaElement = function (i, k) {
		if (e.utils.isIE()) {
			var l = false;
			var n = [];
			var m = i.nextSibling;
			while (m && !l) {
				n.push(m);
				if (m.nodeType == 1 && m.tagName.toLowerCase() == ("/") + i.tagName.toLowerCase()) {
					l = true
				}
				m = m.nextSibling
			}
			if (l) {
				while (n.length > 0) {
					var j = n.pop();
					j.parentNode.removeChild(j)
				}
			}
			i.outerHTML = k
		}
	};
	f.media = h;
	f.audio = h;
	f.source = a;
	f.video = b
})(jwplayer);
jwplayer.utils.selectors = function (a, c) {
	if (c === undefined) {
		c = document
	}
	a = jwplayer.utils.strings.trim(a);
	var b = a.charAt(0);
	if (b == "#") {
		return c.getElementById(a.substr(1))
	} else {
		if (b == ".") {
			if (c.getElementsByClassName) {
				return c.getElementsByClassName(a.substr(1))
			} else {
				return jwplayer.utils.selectors.getElementsByTagAndClass("*", a.substr(1))
			}
		} else {
			if (a.indexOf(".") > 0) {
				selectors = a.split(".");
				return jwplayer.utils.selectors.getElementsByTagAndClass(selectors[0], selectors[1])
			} else {
				return c.getElementsByTagName(a)
			}
		}
	}
	return null
};
jwplayer.utils.selectors.getElementsByTagAndClass = function (d, g, f) {
	elements = [];
	if (f === undefined) {
		f = document
	}
	var e = f.getElementsByTagName(d);
	for (var c = 0; c < e.length; c++) {
		if (e[c].className !== undefined) {
			var b = e[c].className.split(" ");
			for (var a = 0; a < b.length; a++) {
				if (b[a] == g) {
					elements.push(e[c])
				}
			}
		}
	}
	return elements
};
jwplayer.utils.strings = function () {};
jwplayer.utils.strings.trim = function (a) {
	return a.replace(/^\s*/, "").replace(/\s*$/, "")
};
jwplayer.utils.strings.extension = function (a) {
	return a.substr(a.lastIndexOf(".") + 1, a.length).toLowerCase()
};
(function (a) {
	a.utils.extensionmap = {
		"3gp": "video/3gpp",
		"3gpp": "video/3gpp",
		"3g2": "video/3gpp2",
		"3gpp2": "video/3gpp2",
		flv: "video/x-flv",
		f4a: "audio/mp4",
		f4b: "audio/mp4",
		f4p: "video/mp4",
		f4v: "video/mp4",
		mov: "video/quicktime",
		m4a: "audio/mp4",
		m4b: "audio/mp4",
		m4p: "audio/mp4",
		m4v: "video/mp4",
		mkv: "video/x-matroska",
		mp4: "video/mp4",
		sdp: "application/sdp",
		vp6: "video/x-vp6",
		aac: "audio/aac",
		mp3: "audio/mp3",
		ogg: "audio/ogg",
		ogv: "video/ogg",
		webm: "video/webm"
	}
})(jwplayer);
(function (b) {
	var a = [];
	b.constructor = function (c) {
		return b.api.selectPlayer(c)
	};
	b.api = function () {};
	b.api.events = {
		API_READY: "jwplayerAPIReady",
		JWPLAYER_READY: "jwplayerReady",
		JWPLAYER_FULLSCREEN: "jwplayerFullscreen",
		JWPLAYER_RESIZE: "jwplayerResize",
		JWPLAYER_ERROR: "jwplayerError",
		JWPLAYER_MEDIA_BUFFER: "jwplayerMediaBuffer",
		JWPLAYER_MEDIA_BUFFER_FULL: "jwplayerMediaBufferFull",
		JWPLAYER_MEDIA_ERROR: "jwplayerMediaError",
		JWPLAYER_MEDIA_LOADED: "jwplayerMediaLoaded",
		JWPLAYER_MEDIA_COMPLETE: "jwplayerMediaComplete",
		JWPLAYER_MEDIA_TIME: "jwplayerMediaTime",
		JWPLAYER_MEDIA_VOLUME: "jwplayerMediaVolume",
		JWPLAYER_MEDIA_META: "jwplayerMediaMeta",
		JWPLAYER_MEDIA_MUTE: "jwplayerMediaMute",
		JWPLAYER_PLAYER_STATE: "jwplayerPlayerState",
		JWPLAYER_PLAYLIST_LOADED: "jwplayerPlaylistLoaded",
		JWPLAYER_PLAYLIST_ITEM: "jwplayerPlaylistItem"
	};
	b.api.events.state = {
		BUFFERING: "BUFFERING",
		IDLE: "IDLE",
		PAUSED: "PAUSED",
		PLAYING: "PLAYING"
	};
	b.api.PlayerAPI = function (d) {
		this.container = d;
		this.id = d.id;
		var j = {};
		var o = {};
		var c = [];
		var g = undefined;
		var i = false;
		var h = [];
		var m = d.outerHTML;
		var n = {};
		var k = 0;
		this.setPlayer = function (p) {
			g = p
		};
		this.stateListener = function (p, q) {
			if (!o[p]) {
				o[p] = [];
				this.eventListener(b.api.events.JWPLAYER_PLAYER_STATE, f(p))
			}
			o[p].push(q);
			return this
		};

		function f(p) {
			return function (r) {
				var q = r.newstate,
					t = r.oldstate;
				if (q == p) {
					var s = o[q];
					if (s) {
						for (var u in s) {
							if (typeof s[u] == "function") {
								s[u].call(this, {
									oldstate: t,
									newstate: q
								})
							}
						}
					}
				}
			}
		}
		this.addInternalListener = function (p, q) {
			p.jwAddEventListener(q, 'function(dat) { jwplayer("' + this.id + '").dispatchEvent("' + q + '", dat); }')
		};
		this.eventListener = function (p, q) {
			if (!j[p]) {
				j[p] = [];
				if (g && i) {
					this.addInternalListener(g, p)
				}
			}
			j[p].push(q);
			return this
		};
		this.dispatchEvent = function (r) {
			if (j[r]) {
				var q = e(r, arguments[1]);
				for (var p in j[r]) {
					if (typeof j[r][p] == "function") {
						j[r][p].call(this, q)
					}
				}
			}
		};

		function e(q, p) {
			var r = b.utils.extend({}, p);
			if (q == b.api.events.JWPLAYER_FULLSCREEN) {
				r.fullscreen = r.message;
				delete r.message
			} else {
				if (q == b.api.events.JWPLAYER_PLAYLIST_ITEM) {
					if (r.item && r.index === undefined) {
						r.index = r.item;
						delete r.item
					}
				} else {
					if (typeof r.data == "object") {
						r = b.utils.extend(r, r.data);
						delete r.data
					}
				}
			}
			return r
		}
		this.callInternal = function (q, p) {
			if (i) {
				if (typeof g != "undefined" && typeof g[q] == "function") {
					if (p !== undefined) {
						return (g[q])(p)
					} else {
						return (g[q])()
					}
				}
				return null
			} else {
				h.push({
					method: q,
					parameters: p
				})
			}
		};
		this.playerReady = function (r) {
			i = true;
			if (!g) {
				this.setPlayer(document.getElementById(r.id))
			}
			this.container = document.getElementById(this.id);
			for (var p in j) {
				this.addInternalListener(g, p)
			}
			this.eventListener(b.api.events.JWPLAYER_PLAYLIST_ITEM, function (s) {
				if (s.index !== undefined) {
					k = s.index
				} else {
					if (s.item !== undefined) {
						k = s.item
					}
				}
				n = {}
			});
			this.eventListener(b.api.events.JWPLAYER_MEDIA_META, function (s) {
				b.utils.extend(n, s.metadata)
			});
			this.dispatchEvent(b.api.events.API_READY);
			while (h.length > 0) {
				var q = h.shift();
				this.callInternal(q.method, q.parameters)
			}
		};
		this.getItemMeta = function () {
			return n
		};
		this.getCurrentItem = function () {
			return k
		};
		this.destroy = function () {
			j = {};
			h = [];
			if (this.container.outerHTML != m) {
				b.api.destroyPlayer(this.id, m)
			}
		};

		function l(r, t, s) {
			var p = [];
			if (!t) {
				t = 0
			}
			if (!s) {
				s = r.length - 1
			}
			for (var q = t; q <= s; q++) {
				p.push(r[q])
			}
			return p
		}
	};
	b.api.PlayerAPI.prototype = {
		container: undefined,
		options: undefined,
		id: undefined,
		getBuffer: function () {
			return this.callInternal("jwGetBuffer")
		},
		getDuration: function () {
			return this.callInternal("jwGetDuration")
		},
		getFullscreen: function () {
			return this.callInternal("jwGetFullscreen")
		},
		getHeight: function () {
			return this.callInternal("jwGetHeight")
		},
		getLockState: function () {
			return this.callInternal("jwGetLockState")
		},
		getMeta: function () {
			return this.getItemMeta()
		},
		getMute: function () {
			return this.callInternal("jwGetMute")
		},
		getPlaylist: function () {
			var d = this.callInternal("jwGetPlaylist");
			for (var c = 0; c < d.length; c++) {
				if (d[c].index === undefined) {
					d[c].index = c
				}
			}
			return d
		},
		getPlaylistItem: function (c) {
			if (c == undefined) {
				c = this.getCurrentItem()
			}
			return this.getPlaylist()[c]
		},
		getPosition: function () {
			return this.callInternal("jwGetPosition")
		},
		getState: function () {
			return this.callInternal("jwGetState")
		},
		getVolume: function () {
			return this.callInternal("jwGetVolume")
		},
		getWidth: function () {
			return this.callInternal("jwGetWidth")
		},
		setFullscreen: function (c) {
			if (c === undefined) {
				this.callInternal("jwSetFullscreen", true)
			} else {
				this.callInternal("jwSetFullscreen", c)
			}
			return this
		},
		setMute: function (c) {
			if (c === undefined) {
				this.callInternal("jwSetMute", true)
			} else {
				this.callInternal("jwSetMute", c)
			}
			return this
		},
		lock: function () {
			return this
		},
		unlock: function () {
			return this
		},
		load: function (c) {
			this.callInternal("jwLoad", c);
			return this
		},
		playlistItem: function (c) {
			this.callInternal("jwPlaylistItem", c);
			return this
		},
		playlistPrev: function () {
			this.callInternal("jwPlaylistPrev");
			return this
		},
		playlistNext: function () {
			this.callInternal("jwPlaylistNext");
			return this
		},
		resize: function (d, c) {
			this.container.width = d;
			this.container.height = c;
			return this
		},
		play: function (c) {
			if (typeof c === "undefined") {
				var c = this.getState();
				if (c == b.api.events.state.PLAYING || c == b.api.events.state.BUFFERING) {
					this.callInternal("jwPause")
				} else {
					this.callInternal("jwPlay")
				}
			} else {
				this.callInternal("jwPlay", c)
			}
			return this
		},
		pause: function () {
			var c = this.getState();
			switch (c) {
			case b.api.events.state.PLAYING:
			case b.api.events.state.BUFFERING:
				this.callInternal("jwPause");
				break;
			case b.api.events.state.PAUSED:
				this.callInternal("jwPlay");
				break
			}
			return this
		},
		stop: function () {
			this.callInternal("jwStop");
			return this
		},
		seek: function (c) {
			this.callInternal("jwSeek", c);
			return this
		},
		setVolume: function (c) {
			this.callInternal("jwSetVolume", c);
			return this
		},
		onBufferChange: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_BUFFER, c)
		},
		onBufferFull: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_BUFFER_FULL, c)
		},
		onError: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_ERROR, c)
		},
		onFullscreen: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_FULLSCREEN, c)
		},
		onMeta: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_META, c)
		},
		onMute: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_MUTE, c)
		},
		onPlaylist: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_PLAYLIST_LOADED, c)
		},
		onPlaylistItem: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_PLAYLIST_ITEM, c)
		},
		onReady: function (c) {
			return this.eventListener(b.api.events.API_READY, c)
		},
		onResize: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_RESIZE, c)
		},
		onComplete: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_COMPLETE, c)
		},
		onTime: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_TIME, c)
		},
		onVolume: function (c) {
			return this.eventListener(b.api.events.JWPLAYER_MEDIA_VOLUME, c)
		},
		onBuffer: function (c) {
			return this.stateListener(b.api.events.state.BUFFERING, c)
		},
		onPause: function (c) {
			return this.stateListener(b.api.events.state.PAUSED, c)
		},
		onPlay: function (c) {
			return this.stateListener(b.api.events.state.PLAYING, c)
		},
		onIdle: function (c) {
			return this.stateListener(b.api.events.state.IDLE, c)
		},
		setup: function (c) {
			return this
		},
		remove: function () {
			this.destroy()
		},
		initializePlugin: function (c, d) {
			return this
		}
	};
	b.api.selectPlayer = function (d) {
		var c;
		if (d == undefined) {
			d = 0
		}
		if (d.nodeType) {
			c = d
		} else {
			if (typeof d == "string") {
				c = document.getElementById(d)
			}
		}
		if (c) {
			var e = b.api.playerById(c.id);
			if (e) {
				return e
			} else {
				return b.api.addPlayer(new b.api.PlayerAPI(c))
			}
		} else {
			if (typeof d == "number") {
				return b.getPlayers()[d]
			}
		}
		return null
	};
	b.api.playerById = function (d) {
		for (var c in a) {
			if (a[c].id == d) {
				return a[c]
			}
		}
		return null
	};
	b.api.addPlayer = function (d) {
		for (var c in a) {
			if (a[c] == d) {
				return d
			}
		}
		a.push(d);
		return d
	};
	b.api.destroyPlayer = function (f, d) {
		var e = -1;
		for (var h in a) {
			if (a[h].id == f) {
				e = h;
				continue
			}
		}
		if (e >= 0) {
			var c = document.getElementById(a[e].id);
			if (c) {
				if (d) {
					c.outerHTML = d
				} else {
					var g = document.createElement("div");
					g.setAttribute("id", c.id);
					c.parentNode.replaceChild(g, c)
				}
			}
			a.splice(e, 1)
		}
		return null
	};
	b.getPlayers = function () {
		return a.slice(0)
	}
})(jwplayer);
var _userPlayerReady = (typeof playerReady == "function") ? playerReady : undefined;
playerReady = function (b) {
	var a = jwplayer.api.playerById(b.id);
	if (a) {
		a.playerReady(b)
	}
	if (_userPlayerReady) {
		_userPlayerReady.call(this, b)
	}
};
(function (a) {
	a.embed = function () {};
	a.embed.Embedder = function (c) {
		this.constructor(c)
	};
	a.embed.defaults = {
		width: 400,
		height: 300,
		players: [{
			type: "flash",
			src: "player.swf"
		},
		{
			type: "html5"
		}],
		components: {
			controlbar: {
				position: "over"
			}
		}
	};
	a.embed.Embedder.prototype = {
		config: undefined,
		api: undefined,
		events: {},
		players: undefined,
		constructor: function (d) {
			this.api = d;
			var c = a.utils.mediaparser.parseMedia(this.api.container);
			this.config = this.parseConfig(a.utils.extend({}, a.embed.defaults, c, this.api.config))
		},
		embedPlayer: function () {
			var c = this.players[0];
			if (c && c.type) {
				switch (c.type) {
				case "flash":
					if (a.utils.hasFlash()) {
						if (this.config.file && !this.config.provider) {
							switch (a.utils.extension(this.config.file).toLowerCase()) {
							case "webm":
							case "ogv":
							case "ogg":
								this.config.provider = "video";
								break
							}
						}
						if (this.config.levels || this.config.playlist) {
							this.api.onReady(this.loadAfterReady(this.config))
						}
						this.config.id = this.api.id;
						var e = a.embed.embedFlash(document.getElementById(this.api.id), c, this.config);
						this.api.container = e;
						this.api.setPlayer(e)
					} else {
						this.players.splice(0, 1);
						return this.embedPlayer()
					}
					break;
				case "html5":
					if (a.utils.hasHTML5(this.config)) {
						var d = a.embed.embedHTML5(document.getElementById(this.api.id), c, this.config);
						this.api.container = document.getElementById(this.api.id);
						this.api.setPlayer(d)
					} else {
						this.players.splice(0, 1);
						return this.embedPlayer()
					}
					break
				}
			} else {
				this.api.container.innerHTML = "<p>No suitable players found</p>"
			}
			this.setupEvents();
			return this.api
		},
		setupEvents: function () {
			for (evt in this.events) {
				if (typeof this.api[evt] == "function") {
					(this.api[evt]).call(this.api, this.events[evt])
				}
			}
		},
		loadAfterReady: function (c) {
			return function (e) {
				if (c.playlist) {
					this.load(c.playlist)
				} else {
					if (c.levels) {
						var d = this.getPlaylistItem(0);
						if (!d) {
							d = {
								file: c.levels[0].file,
								provider: (c.provider ? c.provider : "video")
							}
						}
						if (!d.image) {
							d.image = c.image
						}
						d.levels = c.levels;
						this.load(d)
					}
				}
			}
		},
		parseConfig: function (c) {
			var d = a.utils.extend({}, c);
			if (d.events) {
				this.events = d.events;
				delete d.events
			}
			if (d.players) {
				this.players = d.players;
				delete d.players
			}
			if (d.plugins) {
				if (typeof d.plugins == "object") {
					d = a.utils.extend(d, a.embed.parsePlugins(d.plugins))
				}
			}
			if (d.playlist && typeof d.playlist === "string" && !d["playlist.position"]) {
				d["playlist.position"] = d.playlist;
				delete d.playlist
			}
			if (d.controlbar && typeof d.controlbar === "string" && !d["controlbar.position"]) {
				d["controlbar.position"] = d.controlbar;
				delete d.controlbar
			}
			return d
		}
	};
	a.embed.embedFlash = function (e, i, d) {
		var j = a.utils.extend({}, d);
		var g = j.width;
		delete j.width;
		var c = j.height;
		delete j.height;
		delete j.levels;
		delete j.playlist;
		a.embed.parseConfigBlock(j, "components");
		a.embed.parseConfigBlock(j, "providers");
		if (a.utils.isIE()) {
			var f = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="' + g + '" height="' + c + '" id="' + e.id + '" name="' + e.id + '">';
			f += '<param name="movie" value="' + i.src + '">';
			f += '<param name="allowfullscreen" value="true">';
			f += '<param name="allowscriptaccess" value="always">';
			f += '<param name="wmode" value="opaque">';
			f += '<param name="flashvars" value="' + a.embed.jsonToFlashvars(j) + '">';
			f += "</object>";
			if (e.nodeName.toLowerCase() == "video" || e.nodeName.toLowerCase() == "audio") {
				a.utils.mediaparser.replaceMediaElement(e, f)
			} else {
				e.outerHTML = f
			}
			return document.getElementById(e.id)
		} else {
			var h = document.createElement("object");
			h.setAttribute("type", "application/x-shockwave-flash");
			h.setAttribute("data", i.src);
			h.setAttribute("width", g);
			h.setAttribute("height", c);
			h.setAttribute("id", e.id);
			h.setAttribute("name", e.id);
			a.embed.appendAttribute(h, "allowfullscreen", "true");
			a.embed.appendAttribute(h, "allowscriptaccess", "always");
			a.embed.appendAttribute(h, "wmode", "opaque");
			a.embed.appendAttribute(h, "flashvars", a.embed.jsonToFlashvars(j));
			e.parentNode.replaceChild(h, e);
			return h
		}
	};
	a.embed.embedHTML5 = function (d, f, e) {
		if (a.html5) {
			d.innerHTML = "";
			var c = a.utils.extend({
				screencolor: "0x000000"
			}, e);
			a.embed.parseConfigBlock(c, "components");
			if (c.levels && !c.sources) {
				c.sources = e.levels
			}
			if (c.skin && c.skin.toLowerCase().indexOf(".zip") > 0) {
				c.skin = c.skin.replace(/\.zip/i, ".xml")
			}
			return new(a.html5(d)).setup(c)
		} else {
			return null
		}
	};
	a.embed.appendAttribute = function (d, c, e) {
		var f = document.createElement("param");
		f.setAttribute("name", c);
		f.setAttribute("value", e);
		d.appendChild(f)
	};
	a.embed.jsonToFlashvars = function (d) {
		var c = "";
		for (key in d) {
			c += key + "=" + escape(d[key]) + "&"
		}
		return c.substring(0, c.length - 1)
	};
	a.embed.parsePlugins = function (e) {
		if (!e) {
			return {}
		}
		var g = {},
			f = [];
		for (plugin in e) {
			var d = plugin.indexOf("-") > 0 ? plugin.substring(0, plugin.indexOf("-")) : plugin;
			var c = e[plugin];
			f.push(plugin);
			for (param in c) {
				g[d + "." + param] = c[param]
			}
		}
		g.plugins = f.join(",");
		return g
	};
	a.embed.parseConfigBlock = function (f, e) {
		if (f[e]) {
			var h = f[e];
			for (var d in h) {
				var c = h[d];
				if (typeof c == "string") {
					if (!f[d]) {
						f[d] = c
					}
				} else {
					for (var g in c) {
						if (!f[d + "." + g]) {
							f[d + "." + g] = c[g]
						}
					}
				}
			}
			delete f[e]
		}
	};
	a.api.PlayerAPI.prototype.setup = function (d, e) {
		if (d && d.flashplayer && !d.players) {
			d.players = [{
				type: "flash",
				src: d.flashplayer
			},
			{
				type: "html5"
			}];
			delete d.flashplayer
		}
		if (e && !d.players) {
			if (typeof e == "string") {
				d.players = [{
					type: "flash",
					src: e
				}]
			} else {
				if (e instanceof Array) {
					d.players = e
				} else {
					if (typeof e == "object" && e.type) {
						d.players = [e]
					}
				}
			}
		}
		var c = this.id;
		this.remove();
		var f = a(c);
		f.config = d;
		return (new a.embed.Embedder(f)).embedPlayer()
	};

	function b() {
		if (!document.body) {
			return setTimeout(b, 15)
		}
		var c = a.utils.selectors.getElementsByTagAndClass("video", "jwplayer");
		for (var d = 0; d < c.length; d++) {
			var e = c[d];
			a(e.id).setup({
				players: [{
					type: "flash",
					src: "/jwplayer/player.swf"
				},
				{
					type: "html5"
				}]
			})
		}
	}
	b()
})(jwplayer);
(function (a) {
	a.html5 = function (b) {
		var c = b;
		this.setup = function (d) {
			a.utils.extend(this, new a.html5.api(c, d));
			return this
		};
		return this
	};
	a.html5.version = "5.3"
})(jwplayer);
(function (b) {
	b.html5.utils = function () {};
	b.html5.utils.extension = function (d) {
		return d.substr(d.lastIndexOf(".") + 1, d.length).toLowerCase()
	};
	b.html5.utils.getAbsolutePath = function (j) {
		if (j === undefined) {
			return undefined
		}
		if (a(j)) {
			return j
		}
		var k = document.location.href.substring(0, document.location.href.indexOf("://") + 3);
		var h = document.location.href.substring(k.length, document.location.href.indexOf("/", k.length + 1));
		var e;
		if (j.indexOf("/") === 0) {
			e = j.split("/")
		} else {
			var f = document.location.href.split("?")[0];
			f = f.substring(k.length + h.length + 1, f.lastIndexOf("/"));
			e = f.split("/").concat(j.split("/"))
		}
		var d = [];
		for (var g = 0; g < e.length; g++) {
			if (!e[g] || e[g] === undefined || e[g] == ".") {
				continue
			} else {
				if (e[g] == "..") {
					d.pop()
				} else {
					d.push(e[g])
				}
			}
		}
		return k + h + "/" + d.join("/")
	};

	function a(e) {
		if (e === null) {
			return
		}
		var f = e.indexOf("://");
		var d = e.indexOf("?");
		return (f > 0 && (d < 0 || (d > f)))
	}
	b.html5.utils.mapEmpty = function (d) {
		for (var e in d) {
			return false
		}
		return true
	};
	b.html5.utils.mapLength = function (e) {
		var d = 0;
		for (var f in e) {
			d++
		}
		return d
	};
	b.html5.utils.log = function (e, d) {
		if (typeof console != "undefined" && typeof console.log != "undefined") {
			if (d) {
				console.log(e, d)
			} else {
				console.log(e)
			}
		}
	};
	b.html5.utils.css = function (e, h, d) {
		if (e !== undefined) {
			for (var f in h) {
				try {
					if (typeof h[f] === "undefined") {
						continue
					} else {
						if (typeof h[f] == "number" && !(f == "zIndex" || f == "opacity")) {
							if (isNaN(h[f])) {
								continue
							}
							if (f.match(/color/i)) {
								h[f] = "#" + c(h[f].toString(16), 6)
							} else {
								h[f] = h[f] + "px"
							}
						}
					}
					e.style[f] = h[f]
				} catch (g) {}
			}
		}
	};

	function c(d, e) {
		while (d.length < e) {
			d = "0" + d
		}
		return d
	}
	b.html5.utils.isYouTube = function (d) {
		return d.indexOf("youtube.com") > -1
	};
	b.html5.utils.getYouTubeId = function (d) {
		d.indexOf("youtube.com" > 0)
	}
})(jwplayer);
(function (b) {
	var c = b.html5.utils.css;
	b.html5.view = function (p, n, e) {
		var s = p;
		var k = n;
		var v = e;
		var u;
		var f;
		var z;
		var q;
		var A;
		var m;

		function x() {
			u = document.createElement("div");
			u.id = k.id;
			u.className = k.className;
			k.id = u.id + "_video";
			c(u, {
				position: "relative",
				height: v.height,
				width: v.width,
				padding: 0,
				backgroundColor: C(),
				zIndex: 0
			});

			function C() {
				if (s.skin.getComponentSettings("display") && s.skin.getComponentSettings("display").backgroundcolor) {
					return s.skin.getComponentSettings("display").backgroundcolor
				}
				return parseInt("000000", 16)
			}
			c(k, {
				position: "absolute",
				width: v.width,
				height: v.height,
				top: 0,
				left: 0,
				zIndex: 1,
				margin: "auto",
				display: "block"
			});
			b.utils.wrap(k, u);
			q = document.createElement("div");
			q.id = u.id + "_displayarea";
			u.appendChild(q)
		}
		function i() {
			for (var C in v.plugins.order) {
				var D = v.plugins.order[C];
				if (v.plugins.object[D] && v.plugins.object[D].getDisplayElement !== undefined) {
					v.plugins.object[D].height = B(v.plugins.object[D].getDisplayElement().style.height);
					v.plugins.object[D].width = B(v.plugins.object[D].getDisplayElement().style.width);
					v.plugins.config[D].currentPosition = v.plugins.config[D].position
				}
			}
			t()
		}
		function t(D) {
			if (v.getMedia() !== undefined) {
				for (var C in v.plugins.order) {
					var E = v.plugins.order[C];
					if (v.plugins.object[E] && v.plugins.object[E].getDisplayElement !== undefined) {
						if (v.config.chromeless || v.getMedia().hasChrome()) {
							v.plugins.config[E].currentPosition = b.html5.view.positions.NONE
						} else {
							v.plugins.config[E].currentPosition = v.plugins.config[E].position
						}
					}
				}
			}
			h(v.width, v.height)
		}
		function B(C) {
			if (typeof C == "number") {
				return C
			}
			if (C === "") {
				return 0
			}
			return parseInt(C.replace("px", ""), 10)
		}
		function o() {
			m = setInterval(function () {
				if (u.width && u.height && (v.width !== B(u.width) || v.height !== B(u.height))) {
					h(B(u.width), B(u.height))
				} else {
					var C = u.getBoundingClientRect();
					if (v.width !== C.width || v.height !== C.height) {
						h(C.width, C.height)
					}
					delete C
				}
			}, 100)
		}
		this.setup = function (C) {
			k = C;
			x();
			i();
			s.jwAddEventListener(b.api.events.JWPLAYER_MEDIA_LOADED, t);
			o();
			var D;
			if (window.onresize !== null) {
				D = window.onresize
			}
			window.onresize = function (E) {
				if (D !== undefined) {
					try {
						D(E)
					} catch (F) {}
				}
				if (s.jwGetFullscreen()) {
					v.width = window.innerWidth;
					v.height = window.innerHeight
				}
				h(v.width, v.height)
			}
		};

		function g(C) {
			switch (C.keyCode) {
			case 27:
				if (s.jwGetFullscreen()) {
					s.jwSetFullscreen(false)
				}
				break;
			case 32:
				if (s.jwGetState() != b.api.events.state.IDLE && s.jwGetState() != b.api.events.state.PAUSED) {
					s.jwPause()
				} else {
					s.jwPlay()
				}
				break
			}
		}
		function h(F, C) {
			if (u.style.display == "none") {
				return
			}
			var E = [].concat(v.plugins.order);
			E.reverse();
			A = E.length + 2;
			if (!v.fullscreen) {
				v.width = F;
				v.height = C;
				f = F;
				z = C;
				c(q, {
					top: 0,
					bottom: 0,
					left: 0,
					right: 0,
					width: F,
					height: C
				});
				c(u, {
					height: z,
					width: f
				});
				var D = l(r, E);
				if (D.length > 0) {
					A += D.length;
					l(j, D, true)
				}
				w()
			} else {
				l(y, E, true)
			}
		}
		function l(H, E, F) {
			var D = [];
			for (var C in E) {
				var I = E[C];
				if (v.plugins.object[I] && v.plugins.object[I].getDisplayElement !== undefined) {
					if (v.plugins.config[I].currentPosition.toUpperCase() !== b.html5.view.positions.NONE) {
						var G = H(I, A--);
						if (!G) {
							D.push(I)
						} else {
							v.plugins.object[I].resize(G.width, G.height);
							if (F) {
								delete G.width;
								delete G.height
							}
							c(v.plugins.object[I].getDisplayElement(), G)
						}
					} else {
						c(v.plugins.object[I].getDisplayElement(), {
							display: "none"
						})
					}
				}
			}
			return D
		}
		function r(D, E) {
			if (v.plugins.object[D].getDisplayElement !== undefined) {
				if (a(v.plugins.config[D].position)) {
					if (v.plugins.object[D].getDisplayElement().parentNode === null) {
						u.appendChild(v.plugins.object[D].getDisplayElement())
					}
					var C = d(D);
					C.zIndex = E;
					return C
				}
			}
			return false
		}
		function j(C, D) {
			if (v.plugins.object[C].getDisplayElement().parentNode === null) {
				q.appendChild(v.plugins.object[C].getDisplayElement())
			}
			return {
				position: "absolute",
				width: (v.width - B(q.style.left) - B(q.style.right)),
				height: (v.height - B(q.style.top) - B(q.style.bottom)),
				zIndex: D
			}
		}
		function y(C, D) {
			return {
				position: "fixed",
				width: v.width,
				height: v.height,
				zIndex: D
			}
		}
		function w() {
			q.style.position = "absolute";
			var C = {
				position: "absolute",
				width: B(q.style.width),
				height: B(q.style.height),
				top: B(q.style.top),
				left: B(q.style.left)
			};
			c(v.getMedia().getDisplayElement(), C)
		}
		function d(D) {
			var E = {
				position: "absolute",
				margin: 0,
				padding: 0,
				top: null
			};
			var C = v.plugins.config[D].currentPosition.toLowerCase();
			switch (C.toUpperCase()) {
			case b.html5.view.positions.TOP:
				E.top = B(q.style.top);
				E.left = B(q.style.left);
				E.width = f - B(q.style.left) - B(q.style.right);
				E.height = v.plugins.object[D].height;
				q.style[C] = B(q.style[C]) + v.plugins.object[D].height + "px";
				q.style.height = B(q.style.height) - E.height + "px";
				break;
			case b.html5.view.positions.RIGHT:
				E.top = B(q.style.top);
				E.right = B(q.style.right);
				E.width = E.width = v.plugins.object[D].width;
				E.height = z - B(q.style.top) - B(q.style.bottom);
				q.style[C] = B(q.style[C]) + v.plugins.object[D].width + "px";
				q.style.width = B(q.style.width) - E.width + "px";
				break;
			case b.html5.view.positions.BOTTOM:
				E.bottom = B(q.style.bottom);
				E.left = B(q.style.left);
				E.width = f - B(q.style.left) - B(q.style.right);
				E.height = v.plugins.object[D].height;
				q.style[C] = B(q.style[C]) + v.plugins.object[D].height + "px";
				q.style.height = B(q.style.height) - E.height + "px";
				break;
			case b.html5.view.positions.LEFT:
				E.top = B(q.style.top);
				E.left = B(q.style.left);
				E.width = v.plugins.object[D].width;
				E.height = z - B(q.style.top) - B(q.style.bottom);
				q.style[C] = B(q.style[C]) + v.plugins.object[D].width + "px";
				q.style.width = B(q.style.width) - E.width + "px";
				break;
			default:
				break
			}
			return E
		}
		this.resize = h;
		this.fullscreen = function (D) {
			if (navigator.vendor.indexOf("Apple") === 0) {
				if (v.getMedia().getDisplayElement().webkitSupportsFullscreen) {
					if (D) {
						v.fullscreen = false;
						v.getMedia().getDisplayElement().webkitEnterFullscreen()
					} else {
						v.getMedia().getDisplayElement().webkitExitFullscreen()
					}
				} else {
					v.fullscreen = false
				}
			} else {
				if (D) {
					document.onkeydown = g;
					clearInterval(m);
					v.width = window.innerWidth;
					v.height = window.innerHeight;
					var C = {
						position: "fixed",
						width: "100%",
						height: "100%",
						top: 0,
						left: 0,
						zIndex: 2147483000
					};
					c(u, C);
					C.zIndex = 1;
					c(v.getMedia().getDisplayElement(), C);
					C.zIndex = 2;
					c(q, C)
				} else {
					document.onkeydown = "";
					o();
					v.width = f;
					v.height = z;
					c(u, {
						position: "relative",
						height: v.height,
						width: v.width,
						zIndex: 0
					})
				}
				h(v.width, v.height)
			}
		}
	};

	function a(d) {
		return ([b.html5.view.positions.TOP, b.html5.view.positions.RIGHT, b.html5.view.positions.BOTTOM, b.html5.view.positions.LEFT].indexOf(d.toUpperCase()) > -1)
	}
	b.html5.view.positions = {
		TOP: "TOP",
		RIGHT: "RIGHT",
		BOTTOM: "BOTTOM",
		LEFT: "LEFT",
		OVER: "OVER",
		NONE: "NONE"
	}
})(jwplayer);
(function (a) {
	var b = {
		backgroundcolor: "",
		margin: 10,
		font: "Arial,sans-serif",
		fontsize: 10,
		fontcolor: parseInt("000000", 16),
		fontstyle: "normal",
		fontweight: "bold",
		buttoncolor: parseInt("ffffff", 16),
		position: a.html5.view.positions.BOTTOM,
		idlehide: false,
		layout: {
			left: {
				position: "left",
				elements: [{
					name: "play",
					type: "button"
				},
				{
					name: "divider",
					type: "divider"
				},
				{
					name: "prev",
					type: "button"
				},
				{
					name: "divider",
					type: "divider"
				},
				{
					name: "next",
					type: "button"
				},
				{
					name: "divider",
					type: "divider"
				},
				{
					name: "elapsed",
					type: "text"
				}]
			},
			center: {
				position: "center",
				elements: [{
					name: "time",
					type: "slider"
				}]
			},
			right: {
				position: "right",
				elements: [{
					name: "duration",
					type: "text"
				},
				{
					name: "blank",
					type: "button"
				},
				{
					name: "divider",
					type: "divider"
				},
				{
					name: "mute",
					type: "button"
				},
				{
					name: "volume",
					type: "slider"
				},
				{
					name: "divider",
					type: "divider"
				},
				{
					name: "fullscreen",
					type: "button"
				}]
			}
		}
	};
	_css = a.html5.utils.css;
	_hide = function (c) {
		_css(c, {
			display: "none"
		})
	};
	_show = function (c) {
		_css(c, {
			display: "block"
		})
	};
	a.html5.controlbar = function (j, L) {
		var i = j;
		var A = a.utils.extend({}, b, i.skin.getComponentSettings("controlbar"), L);
		if (a.html5.utils.mapLength(i.skin.getComponentLayout("controlbar")) > 0) {
			A.layout = i.skin.getComponentLayout("controlbar")
		}
		var P;
		var I;
		var O;
		var B;
		var t = "none";
		var f;
		var h;
		var Q;
		var e;
		var d;
		var w;
		var s;
		var J = {};
		var n = false;
		var c = {};

		function H() {
			O = 0;
			B = 0;
			I = 0;
			if (!n) {
				var V = {
					height: i.skin.getSkinElement("controlbar", "background").height,
					backgroundColor: A.backgroundcolor
				};
				P = document.createElement("div");
				P.id = i.id + "_jwplayer_controlbar";
				_css(P, V)
			}
			v("capLeft", "left", false, P);
			var W = {
				position: "absolute",
				height: i.skin.getSkinElement("controlbar", "background").height,
				background: " url(" + i.skin.getSkinElement("controlbar", "background").src + ") repeat-x center left",
				left: i.skin.getSkinElement("controlbar", "capLeft").width
			};
			N("elements", P, W);
			v("capRight", "right", false, P)
		}
		this.getDisplayElement = function () {
			return P
		};
		this.resize = function (X, V) {
			a.html5.utils.cancelAnimation(P);
			document.getElementById(i.id).onmousemove = x;
			d = X;
			w = V;
			x();
			var W = u();
			D({
				id: i.id,
				duration: Q,
				position: h
			});
			r({
				id: i.id,
				bufferPercent: e
			});
			return W
		};

		function o() {
			var W = ["timeSlider", "volumeSlider", "timeSliderRail", "volumeSliderRail"];
			for (var X in W) {
				var V = W[X];
				if (typeof J[V] != "undefined") {
					c[V] = J[V].getBoundingClientRect()
				}
			}
		}
		function x() {
			a.html5.utils.cancelAnimation(P);
			if (g()) {
				a.html5.utils.fadeTo(P, 1, 0, 1, 0)
			} else {
				a.html5.utils.fadeTo(P, 0, 0.1, 1, 2)
			}
		}
		function g() {
			if (i.jwGetState() == a.api.events.state.IDLE || i.jwGetState() == a.api.events.state.PAUSED) {
				if (A.idlehide) {
					return false
				}
				return true
			}
			if (i.jwGetFullscreen()) {
				return false
			}
			if (A.position.toUpperCase() == a.html5.view.positions.OVER) {
				return false
			}
			return true
		}
		function N(Y, X, W) {
			var V;
			if (!n) {
				V = document.createElement("div");
				J[Y] = V;
				V.id = P.id + "_" + Y;
				X.appendChild(V)
			} else {
				V = document.getElementById(P.id + "_" + Y)
			}
			if (W !== undefined) {
				_css(V, W)
			}
			return V
		}
		function G() {
			U(A.layout.left);
			U(A.layout.right, -1);
			U(A.layout.center)
		}
		function U(Y, V) {
			var Z = Y.position == "right" ? "right" : "left";
			var X = a.utils.extend([], Y.elements);
			if (V !== undefined) {
				X.reverse()
			}
			for (var W = 0; W < X.length; W++) {
				z(X[W], Z)
			}
		}
		function E() {
			return I++
		}
		function z(Z, ab) {
			var Y, W, X, V, ad;
			switch (Z.name) {
			case "play":
				v("playButton", ab, false);
				v("pauseButton", ab, true);
				K("playButton", "jwPlay");
				K("pauseButton", "jwPause");
				break;
			case "divider":
				v("divider" + E(), ab, true);
				break;
			case "prev":
				v("prevButton", ab, true);
				K("prevButton", "jwPlaylistPrev");
				break;
			case "next":
				v("nextButton", ab, true);
				K("nextButton", "jwPlaylistNext");
				break;
			case "elapsed":
				v("elapsedText", ab, true);
				break;
			case "time":
				W = i.skin.getSkinElement("controlbar", "timeSliderCapLeft") === undefined ? 0 : i.skin.getSkinElement("controlbar", "timeSliderCapLeft").width;
				X = i.skin.getSkinElement("controlbar", "timeSliderCapRight") === undefined ? 0 : i.skin.getSkinElement("controlbar", "timeSliderCapRight").width;
				Y = ab == "left" ? W : X;
				V = i.skin.getSkinElement("controlbar", "timeSliderRail").width + W + X;
				ad = {
					height: i.skin.getSkinElement("controlbar", "background").height,
					position: "absolute",
					top: 0,
					width: V
				};
				ad[ab] = ab == "left" ? O : B;
				var aa = N("timeSlider", J.elements, ad);
				v("timeSliderCapLeft", ab, true, aa, ab == "left" ? 0 : Y);
				v("timeSliderRail", ab, false, aa, Y);
				v("timeSliderBuffer", ab, false, aa, Y);
				v("timeSliderProgress", ab, false, aa, Y);
				v("timeSliderThumb", ab, false, aa, Y);
				v("timeSliderCapRight", ab, true, aa, ab == "right" ? 0 : Y);
				M("time");
				break;
			case "fullscreen":
				v("fullscreenButton", ab, false);
				v("normalscreenButton", ab, true);
				K("fullscreenButton", "jwSetFullscreen", true);
				K("normalscreenButton", "jwSetFullscreen", false);
				break;
			case "volume":
				W = i.skin.getSkinElement("controlbar", "volumeSliderCapLeft") === undefined ? 0 : i.skin.getSkinElement("controlbar", "volumeSliderCapLeft").width;
				X = i.skin.getSkinElement("controlbar", "volumeSliderCapRight") === undefined ? 0 : i.skin.getSkinElement("controlbar", "volumeSliderCapRight").width;
				Y = ab == "left" ? W : X;
				V = i.skin.getSkinElement("controlbar", "volumeSliderRail").width + W + X;
				ad = {
					height: i.skin.getSkinElement("controlbar", "background").height,
					position: "absolute",
					top: 0,
					width: V
				};
				ad[ab] = ab == "left" ? O : B;
				var ac = N("volumeSlider", J.elements, ad);
				v("volumeSliderCapLeft", ab, true, ac, ab == "left" ? 0 : Y);
				v("volumeSliderRail", ab, true, ac, Y);
				v("volumeSliderProgress", ab, false, ac, Y);
				v("volumeSliderCapRight", ab, true, ac, ab == "right" ? 0 : Y);
				M("volume");
				break;
			case "mute":
				v("muteButton", ab, false);
				v("unmuteButton", ab, true);
				K("muteButton", "jwSetMute", true);
				K("unmuteButton", "jwSetMute", false);
				break;
			case "duration":
				v("durationText", ab, true);
				break
			}
		}
		function v(Y, ac, ab, Z, V) {
			if ((i.skin.getSkinElement("controlbar", Y) !== undefined || Y.indexOf("Text") > 0 || Y.indexOf("divider") === 0) && !(Y.indexOf("divider") === 0 && s.indexOf("divider") === 0)) {
				s = Y;
				var X = {
					height: i.skin.getSkinElement("controlbar", "background").height,
					position: "absolute",
					display: "block",
					top: 0
				};
				if ((Y.indexOf("next") === 0 || Y.indexOf("prev") === 0) && i.jwGetPlaylist().length < 2) {
					ab = false;
					X.display = "none"
				}
				var aa;
				if (Y.indexOf("Text") > 0) {
					Y.innerhtml = "00:00";
					X.font = A.fontsize + "px/" + (i.skin.getSkinElement("controlbar", "background").height + 1) + "px " + A.font;
					X.color = A.fontcolor;
					X.textAlign = "center";
					X.fontWeight = A.fontweight;
					X.fontStyle = A.fontstyle;
					X.cursor = "default";
					aa = 14 + 3 * A.fontsize
				} else {
					if (Y.indexOf("divider") === 0) {
						X.background = "url(" + i.skin.getSkinElement("controlbar", "divider").src + ") repeat-x center left";
						aa = i.skin.getSkinElement("controlbar", "divider").width
					} else {
						X.background = "url(" + i.skin.getSkinElement("controlbar", Y).src + ") repeat-x center left";
						aa = i.skin.getSkinElement("controlbar", Y).width
					}
				}
				if (ac == "left") {
					X.left = V === undefined ? O : V;
					if (ab) {
						O += aa
					}
				} else {
					if (ac == "right") {
						X.right = V === undefined ? B : V;
						if (ab) {
							B += aa
						}
					}
				}
				if (Z === undefined) {
					Z = J.elements
				}
				X.width = aa;
				if (n) {
					_css(J[Y], X)
				} else {
					var W = N(Y, Z, X);
					if (i.skin.getSkinElement("controlbar", Y + "Over") !== undefined) {
						W.onmouseover = function (ad) {
							W.style.backgroundImage = ["url(", i.skin.getSkinElement("controlbar", Y + "Over").src, ")"].join("")
						};
						W.onmouseout = function (ad) {
							W.style.backgroundImage = ["url(", i.skin.getSkinElement("controlbar", Y).src, ")"].join("")
						}
					}
				}
			}
		}
		function C() {
			i.jwAddEventListener(a.api.events.JWPLAYER_PLAYLIST_LOADED, y);
			i.jwAddEventListener(a.api.events.JWPLAYER_MEDIA_BUFFER, r);
			i.jwAddEventListener(a.api.events.JWPLAYER_PLAYER_STATE, p);
			i.jwAddEventListener(a.api.events.JWPLAYER_MEDIA_TIME, D);
			i.jwAddEventListener(a.api.events.JWPLAYER_MEDIA_MUTE, T);
			i.jwAddEventListener(a.api.events.JWPLAYER_MEDIA_VOLUME, k);
			i.jwAddEventListener(a.api.events.JWPLAYER_MEDIA_COMPLETE, F)
		}
		function y() {
			H();
			G();
			u();
			R()
		}
		function R() {
			D({
				id: i.id,
				duration: i.jwGetDuration(),
				position: 0
			});
			r({
				id: i.id,
				bufferProgress: 0
			});
			T({
				id: i.id,
				mute: i.jwGetMute()
			});
			p({
				id: i.id,
				newstate: a.api.events.state.IDLE
			});
			k({
				id: i.id,
				volume: i.jwGetVolume()
			})
		}
		function K(X, Y, W) {
			if (n) {
				return
			}
			if (i.skin.getSkinElement("controlbar", X) !== undefined) {
				var V = J[X];
				if (V !== null) {
					_css(V, {
						cursor: "pointer"
					});
					if (Y == "fullscreen") {
						V.onmouseup = function (Z) {
							Z.stopPropagation();
							i.jwSetFullscreen(!i.jwGetFullscreen())
						}
					} else {
						V.onmouseup = function (Z) {
							Z.stopPropagation();
							if (W !== null) {
								i[Y](W)
							} else {
								i[Y]()
							}
						}
					}
				}
			}
		}
		function M(V) {
			if (n) {
				return
			}
			var W = J[V + "Slider"];
			_css(J.elements, {
				cursor: "pointer"
			});
			_css(W, {
				cursor: "pointer"
			});
			W.onmousedown = function (X) {
				t = V
			};
			W.onmouseup = function (X) {
				X.stopPropagation();
				S(X.pageX)
			};
			W.onmousemove = function (X) {
				if (t == "time") {
					f = true;
					var Y = X.pageX - c[V + "Slider"].left - window.pageXOffset;
					_css(J.timeSliderThumb, {
						left: Y
					})
				}
			}
		}
		function S(W) {
			f = false;
			var V;
			if (t == "time") {
				V = W - c.timeSliderRail.left + window.pageXOffset;
				var Y = V / c.timeSliderRail.width * Q;
				if (Y < 0) {
					Y = 0
				} else {
					if (Y > Q) {
						Y = Q - 3
					}
				}
				i.jwSeek(Y);
				if (i.jwGetState() != a.api.events.state.PLAYING) {
					i.jwPlay()
				}
			} else {
				if (t == "volume") {
					V = W - c.volumeSliderRail.left - window.pageXOffset;
					var X = Math.round(V / c.volumeSliderRail.width * 100);
					if (X < 0) {
						X = 0
					} else {
						if (X > 100) {
							X = 100
						}
					}
					if (i.jwGetMute()) {
						i.jwSetMute(false)
					}
					i.jwSetVolume(X)
				}
			}
			t = "none"
		}
		function r(W) {
			if (W.bufferPercent !== null) {
				e = W.bufferPercent
			}
			var X = c.timeSliderRail.width;
			var V = isNaN(Math.round(X * e / 100)) ? 0 : Math.round(X * e / 100);
			_css(J.timeSliderBuffer, {
				width: V
			})
		}
		function T(V) {
			if (V.mute) {
				_hide(J.muteButton);
				_show(J.unmuteButton);
				_hide(J.volumeSliderProgress)
			} else {
				_show(J.muteButton);
				_hide(J.unmuteButton);
				_show(J.volumeSliderProgress)
			}
		}
		function p(V) {
			if (V.newstate == a.api.events.state.BUFFERING || V.newstate == a.api.events.state.PLAYING) {
				_show(J.pauseButton);
				_hide(J.playButton)
			} else {
				_hide(J.pauseButton);
				_show(J.playButton)
			}
			x();
			if (V.newstate == a.api.events.state.IDLE) {
				_hide(J.timeSliderBuffer);
				_hide(J.timeSliderProgress);
				_hide(J.timeSliderThumb);
				D({
					id: i.id,
					duration: i.jwGetDuration(),
					position: 0
				})
			} else {
				_show(J.timeSliderBuffer);
				if (V.newstate != a.api.events.state.BUFFERING) {
					_show(J.timeSliderProgress);
					_show(J.timeSliderThumb)
				}
			}
		}
		function F(V) {
			D(a.utils.extend(V, {
				position: 0,
				duration: Q
			}))
		}
		function D(Y) {
			if (Y.position !== null) {
				h = Y.position
			}
			if (Y.duration !== null) {
				Q = Y.duration
			}
			var W = (h === Q === 0) ? 0 : h / Q;
			var V = isNaN(Math.round(c.timeSliderRail.width * W)) ? 0 : Math.round(c.timeSliderRail.width * W);
			var X = V;
			J.timeSliderProgress.style.width = V + "px";
			if (!f) {
				if (J.timeSliderThumb) {
					J.timeSliderThumb.style.left = X + "px"
				}
			}
			if (J.durationText) {
				if (m(Q).indexOf('NaN')==-1) J.durationText.innerHTML = m(Q);
			}
			if (J.elapsedText) {
				J.elapsedText.innerHTML = m(h)
			}
		}
		function m(V) {
			str = "00:00";
			if (V > 0) {
				str = Math.floor(V / 60) < 10 ? "0" + Math.floor(V / 60) + ":" : Math.floor(V / 60) + ":";
				str += Math.floor(V % 60) < 10 ? "0" + Math.floor(V % 60) : Math.floor(V % 60)
			}
			return str
		}
		function l() {
			var Y, W;
			var X = document.getElementById(P.id + "_elements").childNodes;
			for (var V in document.getElementById(P.id + "_elements").childNodes) {
				if (isNaN(parseInt(V, 10))) {
					continue
				}
				if (X[V].id.indexOf(P.id + "_divider") === 0 && W.id.indexOf(P.id + "_divider") === 0) {
					X[V].style.display = "none"
				} else {
					if (X[V].id.indexOf(P.id + "_divider") === 0 && Y.style.display != "none") {
						X[V].style.display = "block"
					}
				}
				if (X[V].style.display != "none") {
					W = X[V]
				}
				Y = X[V]
			}
		}
		function u() {
			l();
			if (i.jwGetFullscreen()) {
				_show(J.normalscreenButton);
				_hide(J.fullscreenButton)
			} else {
				_hide(J.normalscreenButton);
				_show(J.fullscreenButton)
			}
			var W = {
				width: d
			};
			var V = {};
			if (A.position.toUpperCase() == a.html5.view.positions.OVER || i.jwGetFullscreen()) {
				W.left = A.margin;
				W.width -= 2 * A.margin;
				W.top = w - i.skin.getSkinElement("controlbar", "background").height - A.margin;
				W.height = i.skin.getSkinElement("controlbar", "background").height
			} else {
				W.left = 0
			}
			V.left = i.skin.getSkinElement("controlbar", "capLeft").width;
			V.width = W.width - i.skin.getSkinElement("controlbar", "capLeft").width - i.skin.getSkinElement("controlbar", "capRight").width;
			var X = i.skin.getSkinElement("controlbar", "timeSliderCapLeft") === undefined ? 0 : i.skin.getSkinElement("controlbar", "timeSliderCapLeft").width;
			_css(J.timeSliderRail, {
				width: (V.width - O - B),
				left: X
			});
			if (J.timeSliderCapRight !== undefined) {
				_css(J.timeSliderCapRight, {
					left: X + (V.width - O - B)
				})
			}
			_css(P, W);
			_css(J.elements, V);
			o();
			return W
		}
		function k(Z) {
			if (J.volumeSliderRail !== undefined) {
				var X = isNaN(Z.volume / 100) ? 1 : Z.volume / 100;
				var Y = parseInt(J.volumeSliderRail.style.width.replace("px", ""), 10);
				var V = isNaN(Math.round(Y * X)) ? 0 : Math.round(Y * X);
				var aa = parseInt(J.volumeSliderRail.style.right.replace("px", ""), 10);
				var W = i.skin.getSkinElement("controlbar", "volumeSliderCapLeft") === undefined ? 0 : i.skin.getSkinElement("controlbar", "volumeSliderCapLeft").width;
				_css(J.volumeSliderProgress, {
					width: V,
					left: W
				});
				if (J.volumeSliderCapLeft !== undefined) {
					_css(J.volumeSliderCapLeft, {
						left: 0
					})
				}
			}
		}
		function q() {
			H();
			G();
			o();
			n = true;
			C();
			R();
			P.style.opacity = A.idlehide ? 0 : 1
		}
		q();
		return this
	}
})(jwplayer);
(function (b) {
	var a = ["width", "height", "state", "playlist", "item", "position", "buffer", "duration", "volume", "mute", "fullscreen"];
	b.html5.controller = function (s, q, d, p) {
		var v = s;
		var x = d;
		var c = p;
		var j = q;
		var z = true;
		var t = (x.config.debug !== undefined) && (x.config.debug.toString().toLowerCase() == "console");
		var h = new b.html5.eventdispatcher(j.id, t);
		b.utils.extend(this, h);

		function l(C) {
			h.sendEvent(C.type, C)
		}
		x.addGlobalListener(l);

		function o() {
			try {
				if (x.playlist[0].levels[0].file.length > 0) {
					if (z || x.state == b.api.events.state.IDLE) {
						x.setActiveMediaProvider(x.playlist[x.item]);
						x.addEventListener(b.api.events.JWPLAYER_MEDIA_BUFFER_FULL, function () {
							x.getMedia().play()
						});
						if (x.config.repeat) {
							x.addEventListener(b.api.events.JWPLAYER_MEDIA_COMPLETE, function (D) {
								setTimeout(m, 25)
							})
						}
						x.getMedia().load(x.playlist[x.item]);
						z = false
					} else {
						if (x.state == b.api.events.state.PAUSED) {
							x.getMedia().play()
						}
					}
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function A() {
			try {
				if (x.playlist[0].levels[0].file.length > 0) {
					switch (x.state) {
					case b.api.events.state.PLAYING:
					case b.api.events.state.BUFFERING:
						x.getMedia().pause();
						break
					}
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function w(C) {
			try {
				if (x.playlist[0].levels[0].file.length > 0) {
					switch (x.state) {
					case b.api.events.state.PLAYING:
					case b.api.events.state.PAUSED:
					case b.api.events.state.BUFFERING:
						x.getMedia().seek(C);
						break
					}
				}
				return true
			} catch (D) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, D)
			}
			return false
		}
		function i() {
			try {
				if (x.playlist[0].levels[0].file.length > 0 && x.state != b.api.events.state.IDLE) {
					x.getMedia().stop()
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function f() {
			try {
				if (x.playlist[0].levels[0].file.length > 0) {
					if (x.config.shuffle) {
						n(r())
					} else {
						if (x.item + 1 == x.playlist.length) {
							n(0)
						} else {
							n(x.item + 1)
						}
					}
				}
				if (x.state != b.api.events.state.PLAYING && x.state != b.api.events.state.BUFFERING) {
					o()
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function e() {
			try {
				if (x.playlist[0].levels[0].file.length > 0) {
					if (x.config.shuffle) {
						n(r())
					} else {
						if (x.item === 0) {
							n(x.playlist.length - 1)
						} else {
							n(x.item - 1)
						}
					}
				}
				if (x.state != b.api.events.state.PLAYING && x.state != b.api.events.state.BUFFERING) {
					o()
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function r() {
			var C = null;
			if (x.playlist.length > 1) {
				while (C === null) {
					C = Math.floor(Math.random() * x.playlist.length);
					if (C == x.item) {
						C = null
					}
				}
			} else {
				C = 0
			}
			return C
		}
		function n(D) {
			x.resetEventListeners();
			x.addGlobalListener(l);
			try {
				if (x.playlist[0].levels[0].file.length > 0) {
					var E = x.state;
					if (E !== b.api.events.state.IDLE) {
						i()
					}
					x.item = D;
					z = true;
					h.sendEvent(b.api.events.JWPLAYER_PLAYLIST_ITEM, {
						item: D
					});
					if (E == b.api.events.state.PLAYING || E == b.api.events.state.BUFFERING) {
						o()
					}
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function y(D) {
			try {
				switch (typeof(D)) {
				case "number":
					x.getMedia().volume(D);
					break;
				case "string":
					x.getMedia().volume(parseInt(D, 10));
					break
				}
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function k(D) {
			try {
				x.getMedia().mute(D);
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function g(D, C) {
			try {
				x.width = D;
				x.height = C;
				c.resize(D, C);
				return true
			} catch (E) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, E)
			}
			return false
		}
		function u(D) {
			try {
				x.fullscreen = D;
				c.fullscreen(D);
				return true
			} catch (C) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, C)
			}
			return false
		}
		function B(C) {
			try {
				i();
				x.loadPlaylist(C);
				z = true;
				return true
			} catch (D) {
				h.sendEvent(b.api.events.JWPLAYER_ERROR, D)
			}
			return false
		}
		b.html5.controller.repeatoptions = {
			LIST: "LIST",
			ALWAYS: "ALWAYS",
			SINGLE: "SINGLE",
			NONE: "NONE"
		};

		function m() {
			x.resetEventListeners();
			x.addGlobalListener(l);
			switch (x.config.repeat.toUpperCase()) {
			case b.html5.controller.repeatoptions.SINGLE:
				o();
				break;
			case b.html5.controller.repeatoptions.ALWAYS:
				if (x.item == x.playlist.length - 1 && !x.config.shuffle) {
					n(0);
					o()
				} else {
					f()
				}
				break;
			case b.html5.controller.repeatoptions.LIST:
				if (x.item == x.playlist.length - 1 && !x.config.shuffle) {
					n(0)
				} else {
					f()
				}
				break
			}
		}
		this.play = o;
		this.pause = A;
		this.seek = w;
		this.stop = i;
		this.next = f;
		this.prev = e;
		this.item = n;
		this.setVolume = y;
		this.setMute = k;
		this.resize = g;
		this.setFullscreen = u;
		this.load = B
	}
})(jwplayer);
(function (a) {
	a.html5.defaultSkin = function () {
		this.text = '<?xml version="1.0" ?><skin author="LongTail Video" name="Five" version="1.0"><settings><setting name="backcolor" value="0xFFFFFF"/><setting name="frontcolor" value="0x000000"/><setting name="lightcolor" value="0x000000"/><setting name="screencolor" value="0x000000"/></settings><components><component name="controlbar"><settings><setting name="margin" value="20"/><setting name="fontsize" value="11"/></settings><elements><element name="background" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAIAAABvFaqvAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAFJJREFUeNrslLENwAAIwxLU/09j5AiOgD5hVQzNAVY8JK4qEfHMIKBnd2+BQlBINaiRtL/aV2rdzYBsM6CIONbI1NZENTr3RwdB2PlnJgJ6BRgA4hwu5Qg5iswAAAAASUVORK5CYII="/><element name="capLeft" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAYCAIAAAC0rgCNAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAD5JREFUeNosi8ENACAMAgnuv14H0Z8asI19XEjhOiKCMmibVgJTUt7V6fe9KXOtSQCfctJHu2q3/ot79hNgANc2OTz9uTCCAAAAAElFTkSuQmCC"/><element name="capRight" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAYCAIAAAC0rgCNAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAD5JREFUeNosi8ENACAMAgnuv14H0Z8asI19XEjhOiKCMmibVgJTUt7V6fe9KXOtSQCfctJHu2q3/ot79hNgANc2OTz9uTCCAAAAAElFTkSuQmCC"/><element name="divider" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAYCAIAAAC0rgCNAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAD5JREFUeNosi8ENACAMAgnuv14H0Z8asI19XEjhOiKCMmibVgJTUt7V6fe9KXOtSQCfctJHu2q3/ot79hNgANc2OTz9uTCCAAAAAElFTkSuQmCC"/><element name="playButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAYCAYAAAAVibZIAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAEhJREFUeNpiYqABYBo1dNRQ+hr6H4jvA3E8NS39j4SpZvh/LJig4YxEGEqy3kET+w+AOGFQRhTJhrEQkGcczfujhg4CQwECDADpTRWU/B3wHQAAAABJRU5ErkJggg=="/><element name="pauseButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAYCAYAAAAVibZIAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAChJREFUeNpiYBgFo2DwA0YC8v/R1P4nRu+ooaOGUtnQUTAKhgIACDAAFCwQCfAJ4gwAAAAASUVORK5CYII="/><element name="prevButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAYCAYAAAAVibZIAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAEtJREFUeNpiYBgFo2Dog/9QDAPyQHweTYwiQ/2B+D0Wi8g2tB+JTdBQRiIMJVkvEy0iglhDF9Aq9uOpHVEwoE+NJDUKRsFgAAABBgDe2hqZcNNL0AAAAABJRU5ErkJggg=="/><element name="nextButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAYCAYAAAAVibZIAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAElJREFUeNpiYBgFo2Dog/9AfB6I5dHE/lNqKAi/B2J/ahsKw/3EGMpIhKEk66WJoaR6fz61IyqemhEFSlL61ExSo2AUDAYAEGAAiG4hj+5t7M8AAAAASUVORK5CYII="/><element name="timeSliderRail" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAADxJREFUeNpiYBgFo2AU0Bwwzluw+D8tLWARFhKiqQ9YuLg4aWsBGxs7bS1gZ6e5BWyjSX0UjIKhDgACDABlYQOGh5pYywAAAABJRU5ErkJggg=="/><element name="timeSliderBuffer" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAD1JREFUeNpiYBgFo2AU0Bww1jc0/aelBSz8/Pw09QELOzs7bS1gY2OjrQWsrKy09gHraFIfBaNgqAOAAAMAvy0DChXHsZMAAAAASUVORK5CYII="/><element name="timeSliderProgress" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAClJREFUeNpiYBgFo2AU0BwwAvF/WlrARGsfjFow8BaMglEwCugAAAIMAOHfAQunR+XzAAAAAElFTkSuQmCC"/><element name="timeSliderThumb" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAMAAAAICAYAAAA870V8AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABZJREFUeNpiZICA/yCCiQEJUJcDEGAAY0gBD1/m7Q0AAAAASUVORK5CYII="/><element name="muteButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAYCAYAAADKx8xXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAADFJREFUeNpiYBgFIw3MB+L/5Gj8j6yRiRTFyICJXHfTXyMLAXlGati4YDRFDj8AEGAABk8GSqqS4CoAAAAASUVORK5CYII="/><element name="unmuteButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAYCAYAAADKx8xXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAD1JREFUeNpiYBgFgxz8p7bm+cQa+h8LHy7GhEcjIz4bmAjYykiun/8j0fakGPIfTfPgiSr6aB4FVAcAAQYAWdwR1G1Wd2gAAAAASUVORK5CYII="/><element name="volumeSliderRail" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAYCAYAAADkgu3FAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAGpJREFUeNpi/P//PwM9ABMDncCoRYPfIqqDZcuW1UPp/6AUDcNM1DQYKtRAlaAj1mCSLSLXYIIWUctgDItoZfDA5aOoqKhGEANIM9LVR7SymGDQUctikuOIXkFNdhHEOFrDjlpEd4sAAgwAriRMub95fu8AAAAASUVORK5CYII="/><element name="volumeSliderProgress" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAYCAYAAADkgu3FAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAFtJREFUeNpi/P//PwM9ABMDncCoRYPfIlqAeij9H5SiYZiqBqPTlFqE02BKLSLaYFItIttgQhZRzWB8FjENiuRJ7aAbsMQwYMl7wDIsWUUQ42gNO2oR3S0CCDAAKhKq6MLLn8oAAAAASUVORK5CYII="/><element name="fullscreenButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAE5JREFUeNpiYBgFo2DQA0YC8v/xqP1PjDlMRDrEgUgxkgHIlfZoriVGjmzLsLFHAW2D6D8eA/9Tw7L/BAwgJE90PvhPpNgoGAVDEQAEGAAMdhTyXcPKcAAAAABJRU5ErkJggg=="/><element name="normalscreenButton" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAEZJREFUeNpiYBgFo2DIg/9UUkOUAf8JiFFsyX88fJyAkcQgYMQjNkzBoAgiezyRbE+tFGSPxQJ7auYBmma0UTAKBhgABBgAJAEY6zON61sAAAAASUVORK5CYII="/></elements></component><component name="display"><elements><element name="background" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAEpJREFUeNrszwENADAIA7DhX8ENoBMZ5KR10EryckCJiIiIiIiIiIiIiIiIiIiIiIh8GmkRERERERERERERERERERERERGRHSPAAPlXH1phYpYaAAAAAElFTkSuQmCC"/><element name="playIcon" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAALdJREFUeNrs18ENgjAYhmFouDOCcQJGcARHgE10BDcgTOIosAGwQOuPwaQeuFRi2p/3Sb6EC5L3QCxZBgAAAOCorLW1zMn65TrlkH4NcV7QNcUQt7Gn7KIhxA+qNIR81spOGkL8oFJDyLJRdosqKDDkK+iX5+d7huzwM40xptMQMkjIOeRGo+VkEVvIPfTGIpKASfYIfT9iCHkHrBEzf4gcUQ56aEzuGK/mw0rHpy4AAACAf3kJMACBxjAQNRckhwAAAABJRU5ErkJggg=="/><element name="muteIcon" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHJJREFUeNrs1jEOgCAMBVAg7t5/8qaoIy4uoobyXsLCxA+0NCUAAADGUWvdQoQ41x4ixNBB2hBvBskdD3w5ZCkl3+33VqI0kjBBlh9rp+uTcyOP33TnolfsU85XX3yIRpQph8ZQY3wTZtU5AACASA4BBgDHoVuY1/fvOQAAAABJRU5ErkJggg=="/><element name="errorIcon" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAWlJREFUeNrsl+1twjAQhsHq/7BBYQLYIBmBDcoGMAIjtBPQTcII2SDtBDBBwrU6pGsUO7YbO470PtKJkz9iH++d4ywWAAAAAABgljRNsyWr2bZzDuJG1rLdZhcMbTjrBCGDyUKsqQLFciJb9bSvuG/WagRVRUVUI6gqy5HVeKWfSgRyJruKIU//TrZTSn2nmlaXThrloi/v9F2STC1W4+Aw5cBzkquRc09bofFNc6YLxEON0VUZS5FPTftO49vMjRsIF3RhOGr7/D/pJw+FKU+q0vDyq8W42jCunDqI3LC5XxNj2wHLU1XjaRnb0Lhykhqhhd8MtSF5J9tbjCv4mXGvKJz/65FF/qJryyaaIvzP2QRxZTX2nTuXjvV/VPFSwyLnW7mpH99yTh1FEVro6JBSd40/pMrRdV8vPtcKl28T2pT8TnFZ4yNosct3Q0io6JfBiz1FlGdqVQH3VHnepAEAAAAAADDzEGAAcTwB10jWgxcAAAAASUVORK5CYII="/><element name="bufferIcon" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAuhJREFUeNrsWr9rU1EUznuNGqvFQh1ULOhiBx0KDtIuioO4pJuik3FxFfUPaAV1FTdx0Q5d2g4FFxehTnEpZHFoBy20tCIWtGq0TZP4HfkeHB5N8m6Sl/sa74XDybvv3vvOd8/Pe4lXrVZT3dD8VJc0B8QBcUAcEAfESktHGeR5XtMfqFQq/f92zPe/NbtGlKTdCY30kuxrpMGO94BlQCXs+rbh3ONgA6BlzP1p20d80gEI5hmA2A92Qua1Q2PtAFISM+bvjMG8U+Q7oA3rQGASwrYCU6WpNdLGYbA+Pq5jjXIiwi8EEa2UDbQSaKOIuV+SlkcCrfjY8XTI9EpKGwP0C2kru2hLtHqa4zoXtZRWyvi4CLwv9Opr6Hkn6A9HKgEANsQ1iqC3Ub/vRUk2JgmRkatK36kVrnt0qObunwUdUUMXMWYpakJsO5Am8tAw2GBIgwWA+G2S2dMpiw0gDioQRQJoKhRb1QiDwlHZUABYbaXWsm5ae6loTE4ZDxN4CZar8foVzOJ2iyZ2kWF3t7YIevffaMT5yJ70kQb2fQ1sE5SHr2wazs2wgMxgbsEKEAgxAvZUJbQLBGTSBMgNrncJbA6AljtS/eKDJ0Ez+DmrQEzXS2h1Ck25kAg0IZcUOaydCy4sYnN2fOA+2AP16gNoHALlQ+fwH7XO4CxLenUpgj4xr6ugY2roPMbMx+Xs18m/E8CVEIhxsNeg83XWOAN6grG3lGbk8uE5fr4B/WH3cJw+co/l9nTYsSGYCJ/lY5/qv0thn6nrIWmjeJcPSnWOeY++AkF8tpJHIMAUs/MaBBpj3znZfQo5psY+ZrG4gv5HickjEOymKjEeRpgyST6IuZcTcWbnjcgdPi5ghxciRKsl1lDSsgwA1i8fssonJgzmTSqfGUkCENndNdAL7PS6QQ7ZYISTo+1qq0LEWjTWcvY4isa4z+yfQB+7ooyHVg5RI7/i1Ijn/vnggDggDogD4oC00P4KMACd/juEHOrS4AAAAABJRU5ErkJggg=="/></elements></component><component name="dock"><elements><element name="button" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAFBJREFUeNrs0cEJACAQA8Eofu0fu/W6EM5ZSAFDRpKTBs00CQQEBAQEBAQEBAQEBAQEBATkK8iqbY+AgICAgICAgICAgICAgICAgIC86QowAG5PAQzEJ0lKAAAAAElFTkSuQmCC"/></elements></component><component name="playlist"><elements><element name="item" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAIAAAC1nk4lAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHhJREFUeNrs2NEJwCAMBcBYuv/CFuIE9VN47WWCR7iocXR3pdWdGPqqwIoMjYfQeAiNh9B4JHc6MHQVHnjggQceeOCBBx77TifyeOY0iHi8DqIdEY8dD5cL094eePzINB5CO/LwcOTptNB4CP25L4TIbZzpU7UEGAA5wz1uF5rF9AAAAABJRU5ErkJggg=="/><element name="sliderRail" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAA8CAIAAADpFA0BAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAADhJREFUeNrsy6ENACAMAMHClp2wYxZLAg5Fcu9e3OjuOKqqfTMzbs14CIZhGIZhGIZhGP4VLwEGAK/BBnVFpB0oAAAAAElFTkSuQmCC"/><element name="sliderThumb" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAA8CAIAAADpFA0BAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAADRJREFUeNrsy7ENACAMBLE8++8caFFKKiRffU53112SGs3ttOohGIZhGIZhGIZh+Fe8BRgAiaUGde6NOSEAAAAASUVORK5CYII="/></elements></component></components></skin>';
		this.xml = null;
		if (window.DOMParser) {
			parser = new DOMParser();
			this.xml = parser.parseFromString(this.text, "text/xml")
		} else {
			this.xml = new ActiveXObject("Microsoft.XMLDOM");
			this.xml.async = "false";
			this.xml.loadXML(this.text)
		}
		return this
	}
})(jwplayer);
(function (a) {
	_css = a.html5.utils.css;
	_hide = function (b) {
		_css(b, {
			display: "none"
		})
	};
	_show = function (b) {
		_css(b, {
			display: "block"
		})
	};
	a.html5.display = function (k, s) {
		var q = k;
		var d = {};
		var f;
		var t;
		var r;
		var l;
		var g;
		var j = q.skin.getComponentSettings("display").bufferrotation === undefined ? 15 : parseInt(q.skin.getComponentSettings("display").bufferrotation, 10);
		var e = q.skin.getComponentSettings("display").bufferinterval === undefined ? 100 : parseInt(q.skin.getComponentSettings("display").bufferinterval, 10);
		var c = {
			display: {
				style: {
					cursor: "pointer",
					top: 0,
					left: 0
				},
				click: p
			},
			display_icon: {
				style: {
					cursor: "pointer",
					position: "absolute",
					top: ((q.skin.getSkinElement("display", "background").height - q.skin.getSkinElement("display", "playIcon").height) / 2),
					left: ((q.skin.getSkinElement("display", "background").width - q.skin.getSkinElement("display", "playIcon").width) / 2),
					border: 0,
					margin: 0,
					padding: 0,
					zIndex: 3
				}
			},
			display_iconBackground: {
				style: {
					cursor: "pointer",
					position: "absolute",
					top: ((t - q.skin.getSkinElement("display", "background").height) / 2),
					left: ((f - q.skin.getSkinElement("display", "background").width) / 2),
					border: 0,
					backgroundImage: (["url(", q.skin.getSkinElement("display", "background").src, ")"]).join(""),
					width: q.skin.getSkinElement("display", "background").width,
					height: q.skin.getSkinElement("display", "background").height,
					margin: 0,
					padding: 0,
					zIndex: 2
				}
			},
			display_image: {
				style: {
					display: "none",
					width: f,
					height: t,
					position: "absolute",
					cursor: "pointer",
					left: 0,
					top: 0,
					margin: 0,
					padding: 0,
					textDecoration: "none",
					zIndex: 1
				}
			},
			display_text: {
				style: {
					zIndex: 4,
					position: "relative",
					opacity: 0.8,
					backgroundColor: parseInt("000000", 16),
					color: parseInt("ffffff", 16),
					textAlign: "center",
					fontFamily: "Arial,sans-serif",
					padding: "0 5px",
					fontSize: 14
				}
			}
		};
		q.jwAddEventListener(a.api.events.JWPLAYER_PLAYER_STATE, i);
		q.jwAddEventListener(a.api.events.JWPLAYER_MEDIA_MUTE, i);
		q.jwAddEventListener(a.api.events.JWPLAYER_PLAYLIST_ITEM, i);
		q.jwAddEventListener(a.api.events.JWPLAYER_ERROR, o);
		u();

		function u() {
			d.display = n("div", "display");
			d.display_text = n("div", "display_text");
			d.display.appendChild(d.display_text);
			d.display_image = n("img", "display_image");
			d.display_image.onerror = function (v) {
				_hide(d.display_image)
			};
			d.display_icon = n("div", "display_icon");
			d.display_iconBackground = n("div", "display_iconBackground");
			d.display.appendChild(d.display_image);
			d.display_iconBackground.appendChild(d.display_icon);
			d.display.appendChild(d.display_iconBackground);
			b()
		}
		this.getDisplayElement = function () {
			return d.display
		};
		this.resize = function (w, v) {
			f = w;
			t = v;
			_css(d.display, {
				width: w,
				height: v
			});
			_css(d.display_text, {
				width: (w - 10),
				top: ((t - d.display_text.getBoundingClientRect().height) / 2)
			});
			_css(d.display_image, {
				width: w,
				height: v
			});
			_css(d.display_iconBackground, {
				top: ((t - q.skin.getSkinElement("display", "background").height) / 2),
				left: ((f - q.skin.getSkinElement("display", "background").width) / 2)
			});
			i({})
		};

		function n(v, x) {
			var w = document.createElement(v);
			w.id = q.id + "_jwplayer_" + x;
			_css(w, c[x].style);
			return w
		}
		function b() {
			for (var v in d) {
				if (c[v].click !== undefined) {
					d[v].onclick = c[v].click
				}
			}
		}
		function p(v) {
			if (typeof v.preventDefault != "undefined") {
				v.preventDefault()
			} else {
				v.returnValue = false
			}
			if (q.jwGetState() != a.api.events.state.PLAYING) {
				q.jwPlay()
			} else {
				q.jwPause()
			}
		}
		function h(v) {
			if (g) {
				return
			}
			_show(d.display_iconBackground);
			d.display_icon.style.backgroundImage = (["url(", q.skin.getSkinElement("display", v).src, ")"]).join("");
			_css(d.display_icon, {
				display: "block",
				width: q.skin.getSkinElement("display", v).width,
				height: q.skin.getSkinElement("display", v).height,
				top: (q.skin.getSkinElement("display", "background").height - q.skin.getSkinElement("display", v).height) / 2,
				left: (q.skin.getSkinElement("display", "background").width - q.skin.getSkinElement("display", v).width) / 2
			});
			if (q.skin.getSkinElement("display", v + "Over") !== undefined) {
				d.display_icon.onmouseover = function (w) {
					d.display_icon.style.backgroundImage = ["url(", q.skin.getSkinElement("display", v + "Over").src, ")"].join("")
				};
				d.display_icon.onmouseout = function (w) {
					d.display_icon.style.backgroundImage = ["url(", q.skin.getSkinElement("display", v).src, ")"].join("")
				}
			} else {
				d.display_icon.onmouseover = null;
				d.display_icon.onmouseout = null
			}
		}
		function m() {
			_hide(d.display_icon);
			_hide(d.display_iconBackground)
		}
		function o(v) {
			g = true;
			m();
			d.display_text.innerHTML = v.error;
			_show(d.display_text);
			d.display_text.style.top = ((t - d.display_text.getBoundingClientRect().height) / 2) + "px"
		}
		function i(v) {
			if ((v.type == a.api.events.JWPLAYER_PLAYER_STATE || v.type == a.api.events.JWPLAYER_PLAYLIST_ITEM) && g) {
				g = false;
				_hide(d.display_text)
			}
			if (l !== undefined) {
				clearInterval(l);
				l = null;
				a.html5.utils.animations.rotate(d.display_icon, 0)
			}
			switch (q.jwGetState()) {
			case a.api.events.state.BUFFERING:
				h("bufferIcon");
				r = 0;
				l = setInterval(function () {
					r += j;
					a.html5.utils.animations.rotate(d.display_icon, r % 360)
				}, e);
				h("bufferIcon");
				break;
			case a.api.events.state.PAUSED:
				_css(d.display_image, {
					background: "transparent no-repeat center center"
				});
				h("playIcon");
				break;
			case a.api.events.state.IDLE:
				if (q.jwGetPlaylist()[q.jwGetItem()].image) {
					_css(d.display_image, {
						display: "block"
					});
					d.display_image.src = a.html5.utils.getAbsolutePath(q.jwGetPlaylist()[q.jwGetItem()].image)
				} else {
					_css(d.display_image, {
						display: "none"
					});
					delete d.display_image.src
				}
				h("playIcon");
				break;
			default:
				if (q.jwGetMute()) {
					_css(d.display_image, {
						display: "none"
					});
					delete d.display_image.src;
					h("muteIcon")
				} else {
					_css(d.display_image, {
						display: "none"
					});
					delete d.display_image.src;
					_hide(d.display_iconBackground);
					_hide(d.display_icon)
				}
				break
			}
		}
		return this
	}
})(jwplayer);
(function (jwplayer) {
	jwplayer.html5.eventdispatcher = function (id, debug) {
		var _id = id;
		var _debug = debug;
		var _listeners;
		var _globallisteners;
		this.resetEventListeners = function () {
			_listeners = {};
			_globallisteners = []
		};
		this.resetEventListeners();
		this.addEventListener = function (type, listener, count) {
			try {
				if (_listeners[type] === undefined) {
					_listeners[type] = []
				}
				if (typeof(listener) == "string") {
					eval("listener = " + listener)
				}
				_listeners[type].push({
					listener: listener,
					count: count
				})
			} catch (err) {
				jwplayer.html5.utils.log("error", err)
			}
			return false
		};
		this.removeEventListener = function (type, listener) {
			try {
				for (var lisenterIndex in _listeners[type]) {
					if (_listeners[type][lisenterIndex].toString() == listener.toString()) {
						_listeners[type].slice(lisenterIndex, lisenterIndex + 1);
						break
					}
				}
			} catch (err) {
				jwplayer.html5.utils.log("error", err)
			}
			return false
		};
		this.addGlobalListener = function (listener, count) {
			try {
				if (typeof(listener) == "string") {
					eval("listener = " + listener)
				}
				_globallisteners.push({
					listener: listener,
					count: count
				})
			} catch (err) {
				jwplayer.html5.utils.log("error", err)
			}
			return false
		};
		this.removeGlobalListener = function (listener) {
			try {
				for (var lisenterIndex in _globallisteners) {
					if (_globallisteners[lisenterIndex].toString() == listener.toString()) {
						_globallisteners.slice(lisenterIndex, lisenterIndex + 1);
						break
					}
				}
			} catch (err) {
				jwplayer.html5.utils.log("error", err)
			}
			return false
		};
		this.sendEvent = function (type, data) {
			if (data === undefined) {
				data = {}
			}
			jwplayer.utils.extend(data, {
				id: _id,
				version: jwplayer.html5.version,
				type: type
			});
			if (_debug) {
				jwplayer.html5.utils.log(type, data)
			}
			for (var listenerIndex in _listeners[type]) {
				try {
					_listeners[type][listenerIndex].listener(data)
				} catch (err) {
					jwplayer.html5.utils.log("There was an error while handling a listener", _listeners[type][listenerIndex].listener, err)
				}
				if (_listeners[type][listenerIndex].count === 1) {
					delete _listeners[type][listenerIndex]
				} else {
					if (_listeners[type][listenerIndex].count > 0) {
						_listeners[type][listenerIndex].count = _listeners[type][listenerIndex].count - 1
					}
				}
			}
			for (var globalListenerIndex in _globallisteners) {
				try {
					_globallisteners[globalListenerIndex].listener(data)
				} catch (err) {
					jwplayer.html5.utils.log("There was an error while handling a listener", _globallisteners[globalListenerIndex].listener, err)
				}
				if (_globallisteners[globalListenerIndex].count === 1) {
					delete _globallisteners[globalListenerIndex]
				} else {
					if (_globallisteners[globalListenerIndex].count > 0) {
						_globallisteners[globalListenerIndex].count = _globallisteners[globalListenerIndex].count - 1
					}
				}
			}
		}
	}
})(jwplayer);
(function (a) {
	a.html5.extensionmap = {
		"3gp": "video/3gpp",
		"3gpp": "video/3gpp",
		"3g2": "video/3gpp2",
		"3gpp2": "video/3gpp2",
		flv: "video/x-flv",
		f4a: "audio/mp4",
		f4b: "audio/mp4",
		f4p: "video/mp4",
		f4v: "video/mp4",
		mov: "video/quicktime",
		m4a: "audio/mp4",
		m4b: "audio/mp4",
		m4p: "audio/mp4",
		m4v: "video/mp4",
		mkv: "video/x-matroska",
		mp4: "video/mp4",
		sdp: "application/sdp",
		vp6: "video/x-vp6",
		aac: "audio/aac",
		mp3: "audio/mp3",
		ogg: "audio/ogg",
		ogv: "video/ogg",
		webm: "video/webm"
	}
})(jwplayer);
(function (a) {
	var b = {
		prefix: "http://l.longtailvideo.com/html5/",
		file: "logo.png",
		link: "http://www.longtailvideo.com/players/jw-flv-player/",
		margin: 8,
		out: 0.5,
		over: 1,
		timeout: 3,
		hide: true,
		position: "bottom-left"
	};
	_css = a.html5.utils.css;
	a.html5.logo = function (g, h) {
		var l = g;
		var j;
		if (b.prefix) {
			var i = g.version.split(/\W/).splice(0, 2).join("/");
			if (b.prefix.indexOf(i) < 0) {
				b.prefix += i + "/"
			}
		}
		if (h.position == a.html5.view.positions.OVER) {
			h.position = b.position
		}
		var f = a.utils.extend({}, b);
		if (!f.file) {
			return
		}
		var c = document.createElement("img");
		c.id = l.id + "_jwplayer_logo";
		c.style.display = "none";
		c.onload = function (n) {
			_css(c, k());
			l.jwAddEventListener(a.api.events.JWPLAYER_PLAYER_STATE, m)
		};
		if (f.file.indexOf("http://") === 0) {
			c.src = f.file
		} else {
			c.src = f.prefix + f.file
		}
		c.onmouseover = function (n) {
			c.style.opacity = f.over;
			d()
		};
		c.onmouseout = function (n) {
			c.style.opacity = f.out;
			d()
		};
		c.onclick = e;

		function k() {
			var p = {
				textDecoration: "none",
				position: "absolute"
			};
			p.display = f.hide ? "none" : "block";
			var o = f.position.toLowerCase().split("-");
			for (var n in o) {
				p[o[n]] = f.margin
			}
			return p
		}
		this.resize = function (o, n) {};
		this.getDisplayElement = function () {
			return c
		};

		function e(n) {
			n.stopPropagation();
			window.open(f.link, "_blank");
			return
		}
		function d() {
			if (j) {
				clearTimeout(j)
			}
			j = setTimeout(function () {
				a.html5.utils.fadeTo(c, 0, 0.1, parseFloat(c.style.opacity))
			}, f.timeout * 1000)
		}
		function m(n) {
			switch (l.jwGetState()) {
			case a.api.events.state.BUFFERING:
				c.style.display = "block";
				c.style.opacity = f.out;
				if (f.hide) {
					d()
				}
				break;
			case a.api.events.state.PAUSED:
				break;
			case a.api.events.state.IDLE:
				break;
			case a.api.events.state.PLAYING:
				break;
			default:
				if (f.hide) {
					d()
				}
				break
			}
		}
		return this
	}
})(jwplayer);
(function (a) {
	var c = {
		ended: a.api.events.state.IDLE,
		playing: a.api.events.state.PLAYING,
		pause: a.api.events.state.PAUSED,
		buffering: a.api.events.state.BUFFERING
	};
	var b = a.html5.utils.css;
	a.html5.mediavideo = function (f, C) {
		var G = {
			abort: t,
			canplay: m,
			canplaythrough: m,
			durationchange: q,
			emptied: t,
			ended: m,
			error: l,
			loadeddata: q,
			loadedmetadata: q,
			loadstart: m,
			pause: m,
			play: J,
			playing: m,
			progress: z,
			ratechange: t,
			seeked: m,
			seeking: m,
			stalled: m,
			suspend: m,
			timeupdate: J,
			volumechange: t,
			waiting: m,
			canshowcurrentframe: t,
			dataunavailable: t,
			empty: t,
			load: e,
			loadedfirstframe: t
		};
		var H = new a.html5.eventdispatcher();
		a.utils.extend(this, H);
		var h = f;
		var x = C;
		var D;
		var F;
		var d = a.api.events.state.IDLE;
		var A = null;
		var n;
		var g = 0;
		var y = false;
		var r = false;
		var L;
		var K;
		var i = [];
		var M;
		var B = false;

		function v() {
			return d
		}
		function e(N) {}
		function t(N) {}
		function m(N) {
			if (c[N.type]) {
				s(c[N.type])
			}
		}
		function s(N) {
			if (B) {
				return
			}
			if (n) {
				N = a.api.events.state.IDLE
			}
			if (N == a.api.events.state.PAUSED && d == a.api.events.state.IDLE) {
				return
			}
			if (d != N) {
				var O = d;
				h.state = N;
				d = N;
				var P = false;
				if (N == a.api.events.state.IDLE) {
					p();
					if (h.position >= h.duration && (h.position || h.duration)) {
						P = true
					}
					if (x.style.display != "none" && !h.config.chromeless) {
						x.style.display = "none"
					}
				}
				H.sendEvent(a.api.events.JWPLAYER_PLAYER_STATE, {
					oldstate: O,
					newstate: N
				});
				if (P) {
					H.sendEvent(a.api.events.JWPLAYER_MEDIA_COMPLETE)
				}
			}
			n = false
		}
		function q(N) {
			var O = {
				height: N.target.videoHeight,
				width: N.target.videoWidth,
				duration: Math.round(N.target.duration * 10) / 10
			};
			if (h.duration === 0 || isNaN(h.duration)) {
				h.duration = Math.round(N.target.duration * 10) / 10
			}
			h.playlist[h.item] = a.utils.extend(h.playlist[h.item], O);
			H.sendEvent(a.api.events.JWPLAYER_MEDIA_META, {
				metadata: O
			})
		}
		function J(O) {
			if (n) {
				return
			}
			if (O !== undefined && O.target !== undefined) {
				if (h.duration === 0 || isNaN(h.duration)) {
					h.duration = Math.round(O.target.duration * 10) / 10
				}
				if (!y && x.readyState > 0) {
					s(a.api.events.state.PLAYING)
				}
				if (d == a.api.events.state.PLAYING) {
					if (!y && x.readyState > 0) {
						y = true;
						try {
							x.currentTime = h.playlist[h.item].start
						} catch (N) {}
						x.volume = h.volume / 100;
						x.muted = h.mute
					}
					h.position = Math.round(O.target.currentTime * 10) / 10;
					H.sendEvent(a.api.events.JWPLAYER_MEDIA_TIME, {
						position: Math.round(O.target.currentTime * 10) / 10,
						duration: Math.round(O.target.duration * 10) / 10
					})
				}
			}
			z(O)
		}
		function E() {
			var N = (i[i.length - 1] - i[0]) / i.length;
			M = setTimeout(function () {
				if (!F) {
					z({
						lengthComputable: true,
						loaded: 1,
						total: 1
					})
				}
			}, N * 10)
		}
		function z(P) {
			var O, N;
			if (P !== undefined && P.lengthComputable && P.total) {
				o();
				O = P.loaded / P.total * 100;
				N = O / 100 * (h.duration - x.currentTime);
				if (50 < O && !F) {
					clearTimeout(M);
					E()
				}
			} else {
				if ((x.buffered !== undefined) && (x.buffered.length > 0)) {
					maxBufferIndex = 0;
					if (maxBufferIndex >= 0) {
						O = x.buffered.end(maxBufferIndex) / x.duration * 100;
						N = x.buffered.end(maxBufferIndex) - x.currentTime
					}
				}
			}
			if (D === false && d == a.api.events.state.BUFFERING) {
				D = true;
				H.sendEvent(a.api.events.JWPLAYER_MEDIA_BUFFER_FULL)
			}
			if (!F) {
				if (O == 100 && F === false) {
					F = true
				}
				if (O !== null && (O > h.buffer)) {
					h.buffer = Math.round(O);
					H.sendEvent(a.api.events.JWPLAYER_MEDIA_BUFFER, {
						bufferPercent: Math.round(O)
					})
				}
			}
		}
		function w() {
			if (A === null) {
				A = setInterval(function () {
					J()
				}, 100)
			}
		}
		function p() {
			clearInterval(A);
			A = null
		}
		function l(P) {
			var O = "There was an error: ";
			if ((P.target.error && (P.target.nodeName.toLowerCase() == "video" || P.target.nodeName.toLowerCase() == "audio")) || P.target.parentNode.error && (P.target.parentNode.nodeName.toLowerCase() == "video" || P.target.parentNode.nodeName.toLowerCase() == "audio")) {
				var N = P.target.error === undefined ? P.target.parentNode.error : P.target.error;
				switch (N.code) {
				case N.MEDIA_ERR_ABORTED:
					O = "You aborted the video playback: ";
					break;
				case N.MEDIA_ERR_NETWORK:
					O = "A network error caused the video download to fail part-way: ";
					break;
				case N.MEDIA_ERR_DECODE:
					O = "The video playback was aborted due to a corruption problem or because the video used features your browser did not support: ";
					break;
				case N.MEDIA_ERR_SRC_NOT_SUPPORTED:
					O = "The video could not be loaded, either because the server or network failed or because the format is not supported: ";
					break;
				default:
					O = "An unknown error occurred: ";
					break
				}
			} else {
				if (P.target.nodeName.toLowerCase() == "source") {
					K--;
					if (K > 0) {
						return
					}
					O = "The video could not be loaded, either because the server or network failed or because the format is not supported: "
				} else {
					a.html5.utils.log("Erroneous error received. Continuing...");
					return
				}
			}
			u();
			O += j();
			B = true;
			H.sendEvent(a.api.events.JWPLAYER_ERROR, {
				error: O
			});
			return
		}
		function j() {
			var P = "";
			for (var O in L.levels) {
				var N = L.levels[O];
				var Q = x.ownerDocument.createElement("source");
				P += a.html5.utils.getAbsolutePath(N.file);
				if (O < (L.levels.length - 1)) {
					P += ", "
				}
			}
			return P
		}
		this.getDisplayElement = function () {
			return x
		};
		this.play = function () {
			if (d != a.api.events.state.PLAYING) {
				if (x.style.display != "block") {
					x.style.display = "block"
				}
				x.play();
				w()
			}
		};
		this.pause = function () {
			x.pause();
			s(a.api.events.state.PAUSED)
		};
		this.seek = function (N) {
			if (!(h.duration === 0 || isNaN(h.duration)) && !(h.position === 0 || isNaN(h.position))) {
				x.currentTime = N;
				x.play()
			}
		};

		function u() {
			x.pause();
			p();
			h.position = 0;
			n = true;
			s(a.api.events.state.IDLE)
		}
		this.stop = u;
		this.volume = function (N) {
			x.volume = N / 100;
			h.volume = N;
			H.sendEvent(a.api.events.JWPLAYER_MEDIA_VOLUME, {
				volume: Math.round(N)
			})
		};
		this.mute = function (N) {
			x.muted = N;
			h.mute = N;
			H.sendEvent(a.api.events.JWPLAYER_MEDIA_MUTE, {
				mute: N
			})
		};
		this.resize = function (O, N) {
			if (false) {
				b(x, {
					width: O,
					height: N
				})
			}
			H.sendEvent(a.api.events.JWPLAYER_MEDIA_RESIZE, {
				fullscreen: h.fullscreen,
				width: O,
				hieght: N
			})
		};
		this.fullscreen = function (N) {
			if (N === true) {
				this.resize("100%", "100%")
			} else {
				this.resize(h.config.width, h.config.height)
			}
		};
		this.load = function (N) {
			I(N);
			H.sendEvent(a.api.events.JWPLAYER_MEDIA_LOADED);
			D = false;
			F = false;
			y = false;
			if (!h.config.chromeless) {
				i = [];
				o();
				s(a.api.events.state.BUFFERING);
				setTimeout(function () {
					J()
				}, 25)
			}
		};

		function o() {
			var N = new Date().getTime();
			i.push(N)
		}
		this.hasChrome = function () {
			return r
		};

		function I(U) {
			h.duration = U.duration;
			r = false;
			L = U;
			var P = document.createElement("video");
			P.preload = "none";
			B = false;
			K = 0;
			for (var O in U.levels) {
				var N = U.levels[O];
				if (a.html5.utils.isYouTube(N.file)) {
					delete P;
					k(N.file);
					return
				}
				var Q;
				if (N.type === undefined) {
					var T = a.html5.utils.extension(N.file);
					if (a.html5.extensionmap[T] !== undefined) {
						Q = a.html5.extensionmap[T]
					} else {
						Q = "video/" + T + ";"
					}
				} else {
					Q = N.type
				}
				if (P.canPlayType(Q) === "") {
					continue
				}
				var S = x.ownerDocument.createElement("source");
				S.src = a.html5.utils.getAbsolutePath(N.file);
				S.type = Q;
				K++;
				P.appendChild(S)
			}
			if (K === 0) {
				B = true;
				H.sendEvent(a.api.events.JWPLAYER_ERROR, {
					error: "The video could not be loaded because the format is not supported by your browser: " + j()
				})
			}
			if (h.config.chromeless) {
				P.poster = a.html5.utils.getAbsolutePath(U.image);
				P.controls = "controls"
			}
			P.style.position = x.style.position;
			P.style.top = x.style.top;
			P.style.left = x.style.left;
			P.style.width = x.style.width;
			P.style.height = x.style.height;
			P.style.zIndex = x.style.zIndex;
			P.onload = e;
			P.volume = 0;
			x.parentNode.replaceChild(P, x);
			P.id = x.id;
			x = P;
			for (var R in G) {
				x.addEventListener(R, function (V) {
					if (V.target.parentNode !== null) {
						G[V.type](V)
					}
				}, true)
			}
		}
		function k(R) {
			var O = document.createElement("object");
			R = ["http://www.youtube.com/v/", R.replace(/^[^v]+v.(.{11}).*/, "$1"), "&amp;hl=en_US&amp;fs=1&autoplay=1"].join("");
			var U = {
				movie: R,
				allowFullScreen: "true",
				allowscriptaccess: "always"
			};
			for (var N in U) {
				var S = document.createElement("param");
				S.name = N;
				S.value = U[N];
				O.appendChild(S)
			}
			var T = document.createElement("embed");
			var P = {
				src: R,
				type: "application/x-shockwave-flash",
				allowscriptaccess: "always",
				allowfullscreen: "true",
				width: document.getElementById(f.id).style.width,
				height: document.getElementById(f.id).style.height
			};
			for (var Q in P) {
				T[Q] = P[Q]
			}
			O.appendChild(T);
			O.style.position = x.style.position;
			O.style.top = x.style.top;
			O.style.left = x.style.left;
			O.style.width = document.getElementById(f.id).style.width;
			O.style.height = document.getElementById(f.id).style.height;
			O.style.zIndex = 2147483000;
			x.parentNode.replaceChild(O, x);
			O.id = x.id;
			x = O;
			r = true
		}
		this.embed = I;
		return this
	}
})(jwplayer);
(function (jwplayer) {
	var _configurableStateVariables = ["width", "height", "start", "duration", "volume", "mute", "fullscreen", "item", "plugins"];
	jwplayer.html5.model = function (api, container, options) {
		var _api = api;
		var _container = container;
		var _model = {
			id: _container.id,
			playlist: [],
			state: jwplayer.api.events.state.IDLE,
			position: 0,
			buffer: 0,
			config: {
				width: 480,
				height: 320,
				item: 0,
				skin: undefined,
				file: undefined,
				image: undefined,
				start: 0,
				duration: 0,
				bufferlength: 5,
				volume: 90,
				mute: false,
				fullscreen: false,
				repeat: "none",
				autostart: false,
				debug: undefined,
				screencolor: undefined
			}
		};
		var _media;
		var _eventDispatcher = new jwplayer.html5.eventdispatcher();
		var _components = ["display", "logo", "controlbar"];
		jwplayer.utils.extend(_model, _eventDispatcher);
		for (var option in options) {
			if (typeof options[option] == "string") {
				var type = /color$/.test(option) ? "color" : null;
				options[option] = jwplayer.html5.utils.typechecker(options[option], type)
			}
			var config = _model.config;
			var path = option.split(".");
			for (var edge in path) {
				if (edge == path.length - 1) {
					config[path[edge]] = options[option]
				} else {
					if (config[path[edge]] === undefined) {
						config[path[edge]] = {}
					}
					config = config[path[edge]]
				}
			}
		}
		for (var index in _configurableStateVariables) {
			var configurableStateVariable = _configurableStateVariables[index];
			_model[configurableStateVariable] = _model.config[configurableStateVariable]
		}
		var pluginorder = _components.concat([]);
		if (_model.plugins !== undefined) {
			if (typeof _model.plugins == "string") {
				var userplugins = _model.plugins.split(",");
				for (var userplugin in userplugins) {
					pluginorder.push(userplugin.replace(/^\s+|\s+$/g, ""))
				}
			} else {
				for (var plugin in _model.plugins) {
					pluginorder.push(plugin.replace(/^\s+|\s+$/g, ""))
				}
			}
		}
		if (jwplayer.utils.isIOS()) {
			_model.config.chromeless = true
		}
		if (_model.config.chromeless) {
			pluginorder = []
		}
		_model.plugins = {
			order: pluginorder,
			config: {
				controlbar: {
					position: jwplayer.html5.view.positions.BOTTOM
				}
			},
			object: {}
		};
		if (typeof _model.config.components != "undefined") {
			for (var component in _model.config.components) {
				_model.plugins.config[component] = _model.config.components[component]
			}
		}
		for (var pluginIndex in _model.plugins.order) {
			var pluginName = _model.plugins.order[pluginIndex];
			var pluginConfig = _model.config[pluginName] === undefined ? {} : _model.config[pluginName];
			_model.plugins.config[pluginName] = _model.plugins.config[pluginName] === undefined ? pluginConfig : jwplayer.utils.extend(_model.plugins.config[pluginName], pluginConfig);
			if (_model.plugins.config[pluginName].position === undefined) {
				_model.plugins.config[pluginName].position = jwplayer.html5.view.positions.OVER
			}
		}
		_model.loadPlaylist = function (arg, ready) {
			var input;
			if (typeof arg == "string") {
				try {
					input = eval(arg)
				} catch (err) {
					input = arg
				}
			} else {
				input = arg
			}
			var config;
			switch (jwplayer.utils.typeOf(input)) {
			case "object":
				config = input;
				break;
			case "array":
				config = {
					playlist: input
				};
				break;
			default:
				config = {
					file: input
				};
				break
			}
			_model.playlist = new jwplayer.html5.playlist(config);
			if (_model.config.shuffle) {
				_model.item = _getShuffleItem()
			} else {
				if (_model.config.item >= _model.playlist.length) {
					_model.config.item = _model.playlist.length - 1
				}
				_model.item = _model.config.item
			}
			if (!ready) {
				_eventDispatcher.sendEvent(jwplayer.api.events.JWPLAYER_PLAYLIST_LOADED);
				_eventDispatcher.sendEvent(jwplayer.api.events.JWPLAYER_PLAYLIST_ITEM, {
					item: _model.item
				})
			}
			_model.setActiveMediaProvider(_model.playlist[_model.item])
		};

		function _getShuffleItem() {
			var result = null;
			if (_model.playlist.length > 1) {
				while (result === null) {
					result = Math.floor(Math.random() * _model.playlist.length);
					if (result == _model.item) {
						result = null
					}
				}
			} else {
				result = 0
			}
			return result
		}
		function forward(evt) {
			if (evt.type == jwplayer.api.events.JWPLAYER_MEDIA_LOADED) {
				_container = _media.getDisplayElement()
			}
			_eventDispatcher.sendEvent(evt.type, evt)
		}
		_model.setActiveMediaProvider = function (playlistItem) {
			if (_media !== undefined) {
				_media.resetEventListeners()
			}
			_media = new jwplayer.html5.mediavideo(_model, _container);
			_media.addGlobalListener(forward);
			if (_model.config.chromeless) {
				_media.load(playlistItem)
			}
			return true
		};
		_model.getMedia = function () {
			return _media
		};
		_model.setupPlugins = function () {
			for (var plugin in _model.plugins.order) {
				try {
					if (jwplayer.html5[_model.plugins.order[plugin]] !== undefined) {
						_model.plugins.object[_model.plugins.order[plugin]] = new jwplayer.html5[_model.plugins.order[plugin]](_api, _model.plugins.config[_model.plugins.order[plugin]])
					} else {
						if (window[_model.plugins.order[plugin]] !== undefined) {
							_model.plugins.object[_model.plugins.order[plugin]] = new window[_model.plugins.order[plugin]](_api, _model.plugins.config[_model.plugins.order[plugin]])
						} else {
							_model.plugins.order.splice(plugin, plugin + 1)
						}
					}
				} catch (err) {
					jwplayer.html5.utils.log("Could not setup " + _model.plugins.order[plugin])
				}
			}
		};
		return _model
	}
})(jwplayer);
(function (a) {
	a.html5.playlist = function (b) {
		var d = [];
		if (b.playlist && b.playlist.length > 0) {
			for (var c in b.playlist) {
				d.push(new a.html5.playlistitem(b.playlist[c]))
			}
		} else {
			d.push(new a.html5.playlistitem(b))
		}
		return d
	}
})(jwplayer);
(function (a) {
	a.html5.playlistitem = function (c) {
		var b = {
			author: "",
			date: "",
			description: "",
			image: "",
			link: "",
			mediaid: "",
			tags: "",
			title: "",
			provider: "",
			file: "",
			streamer: "",
			duration: -1,
			start: 0,
			currentLevel: -1,
			levels: []
		};
		for (var d in b) {
			if (c[d] !== undefined) {
				b[d] = c[d]
			}
		}
		if (b.levels.length === 0) {
			b.levels[0] = new a.html5.playlistitemlevel(b)
		}
		return b
	}
})(jwplayer);
(function (a) {
	a.html5.playlistitemlevel = function (b) {
		var d = {
			file: "",
			streamer: "",
			bitrate: 0,
			width: 0
		};
		for (var c in d) {
			if (b[c] !== undefined) {
				d[c] = b[c]
			}
		}
		return d
	}
})(jwplayer);
(function (a) {
	a.html5.skin = function () {
		var b = {};
		var c = false;
		this.load = function (d, e) {
			new a.html5.skinloader(d, function (f) {
				c = true;
				b = f;
				e()
			}, function () {
				new a.html5.skinloader("", function (f) {
					c = true;
					b = f;
					e()
				})
			})
		};
		this.getSkinElement = function (d, e) {
			if (c) {
				try {
					return b[d].elements[e]
				} catch (f) {
					a.html5.utils.log("No such skin component / element: ", [d, e])
				}
			}
			return null
		};
		this.getComponentSettings = function (d) {
			if (c) {
				return b[d].settings
			}
			return null
		};
		this.getComponentLayout = function (d) {
			if (c) {
				return b[d].layout
			}
			return null
		}
	}
})(jwplayer);
(function (a) {
	a.html5.skinloader = function (f, n, i) {
		var m = {};
		var c = n;
		var j = i;
		var e = true;
		var h;
		var l = f;
		var q = false;

		function k() {
			if (l === undefined || l === "") {
				d(a.html5.defaultSkin().xml)
			} else {
				a.utils.ajax(a.html5.utils.getAbsolutePath(l), function (r) {
					d(r.responseXML)
				}, function (r) {
					d(a.html5.defaultSkin().xml)
				})
			}
		}
		function d(w) {
			var C = w.getElementsByTagName("component");
			if (C.length === 0) {
				return
			}
			for (var F = 0; F < C.length; F++) {
				var A = C[F].getAttribute("name");
				var z = {
					settings: {},
					elements: {},
					layout: {}
				};
				m[A] = z;
				var E = C[F].getElementsByTagName("elements")[0].getElementsByTagName("element");
				for (var D = 0; D < E.length; D++) {
					b(E[D], A)
				}
				var x = C[F].getElementsByTagName("settings")[0];
				if (x !== undefined && x.childNodes.length > 0) {
					var I = x.getElementsByTagName("setting");
					for (var N = 0; N < I.length; N++) {
						var O = I[N].getAttribute("name");
						var G = I[N].getAttribute("value");
						var v = /color$/.test(O) ? "color" : null;
						m[A].settings[O] = a.html5.utils.typechecker(G, v)
					}
				}
				var J = C[F].getElementsByTagName("layout")[0];
				if (J !== undefined && J.childNodes.length > 0) {
					var K = J.getElementsByTagName("group");
					for (var u = 0; u < K.length; u++) {
						var y = K[u];
						m[A].layout[y.getAttribute("position")] = {
							elements: []
						};
						for (var M = 0; M < y.attributes.length; M++) {
							var B = y.attributes[M];
							m[A].layout[y.getAttribute("position")][B.name] = B.value
						}
						var L = y.getElementsByTagName("*");
						for (var t = 0; t < L.length; t++) {
							var r = L[t];
							m[A].layout[y.getAttribute("position")].elements.push({
								type: r.tagName
							});
							for (var s = 0; s < r.attributes.length; s++) {
								var H = r.attributes[s];
								m[A].layout[y.getAttribute("position")].elements[t][H.name] = H.value
							}
							if (m[A].layout[y.getAttribute("position")].elements[t].name === undefined) {
								m[A].layout[y.getAttribute("position")].elements[t].name = r.tagName
							}
						}
					}
				}
				e = false;
				p()
			}
		}
		function p() {
			clearInterval(h);
			if (!q) {
				h = setInterval(function () {
					o()
				}, 100)
			}
		}
		function b(w, v) {
			var u = new Image();
			var r = w.getAttribute("name");
			var t = w.getAttribute("src");
			var y;
			if (t.indexOf("data:image/png;base64,") === 0) {
				y = t
			} else {
				var s = a.html5.utils.getAbsolutePath(l);
				var x = s.substr(0, s.lastIndexOf("/"));
				y = [x, v, t].join("/")
			}
			m[v].elements[r] = {
				height: 0,
				width: 0,
				src: "",
				ready: false
			};
			u.onload = function (z) {
				g(u, r, v)
			};
			u.onerror = function (z) {
				q = true;
				p();
				j()
			};
			u.src = y
		}
		function o() {
			for (var r in m) {
				if (r != "properties") {
					for (var s in m[r].elements) {
						if (!m[r].elements[s].ready) {
							return
						}
					}
				}
			}
			if (e === false) {
				clearInterval(h);
				c(m)
			}
		}
		function g(r, t, s) {
			m[s].elements[t].height = r.height;
			m[s].elements[t].width = r.width;
			m[s].elements[t].src = r.src;
			m[s].elements[t].ready = true;
			p()
		}
		k()
	}
})(jwplayer);
(function (a) {
	var b = {};
	a.html5.utils.animations = function () {};
	a.html5.utils.animations.transform = function (c, d) {
		c.style.webkitTransform = d;
		c.style.MozTransform = d;
		c.style.OTransform = d
	};
	a.html5.utils.animations.transformOrigin = function (c, d) {
		c.style.webkitTransformOrigin = d;
		c.style.MozTransformOrigin = d;
		c.style.OTransformOrigin = d
	};
	a.html5.utils.animations.rotate = function (c, d) {
		a.html5.utils.animations.transform(c, ["rotate(", d, "deg)"].join(""))
	};
	a.html5.utils.cancelAnimation = function (c) {
		delete b[c.id]
	};
	a.html5.utils.fadeTo = function (l, f, e, i, h, d) {
		if (b[l.id] != d && d !== undefined) {
			return
		}
		var c = new Date().getTime();
		if (d > c) {
			setTimeout(function () {
				a.html5.utils.fadeTo(l, f, e, i, 0, d)
			}, d - c)
		}
		l.style.display = "block";
		if (i === undefined) {
			i = l.style.opacity === "" ? 1 : l.style.opacity
		}
		if (l.style.opacity == f && l.style.opacity !== "" && d !== undefined) {
			if (f === 0) {
				l.style.display = "none"
			}
			return
		}
		if (d === undefined) {
			d = c;
			b[l.id] = d
		}
		if (h === undefined) {
			h = 0
		}
		var j = (c - d) / (e * 1000);
		j = j > 1 ? 1 : j;
		var k = f - i;
		var g = i + (j * k);
		if (g > 1) {
			g = 1
		} else {
			if (g < 0) {
				g = 0
			}
		}
		l.style.opacity = g;
		if (h > 0) {
			b[l.id] = d + h * 1000;
			a.html5.utils.fadeTo(l, f, e, i, 0, b[l.id]);
			return
		}
		setTimeout(function () {
			a.html5.utils.fadeTo(l, f, e, i, 0, d)
		}, 10)
	}
})(jwplayer);
(function (c) {
	var d = new RegExp(/^(#|0x)[0-9a-fA-F]{3,6}/);
	c.html5.utils.typechecker = function (g, f) {
		f = f === null ? b(g) : f;
		return e(g, f)
	};

	function b(f) {
		var g = ["true", "false", "t", "f"];
		if (g.indexOf(f.toLowerCase().replace(" ", "")) >= 0) {
			return "boolean"
		} else {
			if (d.test(f)) {
				return "color"
			} else {
				if (!isNaN(parseInt(f, 10)) && parseInt(f, 10).toString().length == f.length) {
					return "integer"
				} else {
					if (!isNaN(parseFloat(f)) && parseFloat(f).toString().length == f.length) {
						return "float"
					}
				}
			}
		}
		return "string"
	}
	function e(g, f) {
		if (f === null) {
			return g
		}
		switch (f) {
		case "color":
			if (g.length > 0) {
				return a(g)
			}
			return null;
		case "integer":
			return parseInt(g, 10);
		case "float":
			return parseFloat(g);
		case "boolean":
			if (g.toLowerCase() == "true") {
				return true
			} else {
				if (g == "1") {
					return true
				}
			}
			return false
		}
		return g
	}
	function a(f) {
		switch (f.toLowerCase()) {
		case "blue":
			return parseInt("0000FF", 16);
		case "green":
			return parseInt("00FF00", 16);
		case "red":
			return parseInt("FF0000", 16);
		case "cyan":
			return parseInt("00FFFF", 16);
		case "magenta":
			return parseInt("FF00FF", 16);
		case "yellow":
			return parseInt("FFFF00", 16);
		case "black":
			return parseInt("000000", 16);
		case "white":
			return parseInt("FFFFFF", 16);
		default:
			f = f.replace(/(#|0x)?([0-9A-F]{3,6})$/gi, "$2");
			if (f.length == 3) {
				f = f.charAt(0) + f.charAt(0) + f.charAt(1) + f.charAt(1) + f.charAt(2) + f.charAt(2)
			}
			return parseInt(f, 16)
		}
		return parseInt("000000", 16)
	}
})(jwplayer);
(function (a) {
	a.html5.api = function (b, j) {
		var i = {};
		if (!a.utils.hasHTML5()) {
			return i
		}
		var d = document.createElement("div");
		b.parentNode.replaceChild(d, b);
		d.id = b.id;
		i.version = a.html5.version;
		i.id = d.id;
		var h = new a.html5.model(i, d, j);
		var e = new a.html5.view(i, d, h);
		var g = new a.html5.controller(i, d, h, e);
		i.skin = new a.html5.skin();
		i.jwPlay = g.play;
		i.jwPause = g.pause;
		i.jwStop = g.stop;
		i.jwSeek = g.seek;
		i.jwPlaylistItem = g.item;
		i.jwPlaylistNext = g.next;
		i.jwPlaylistPrev = g.prev;
		i.jwResize = g.resize;
		i.jwLoad = g.load;

		function f(k) {
			return function () {
				return h[k]
			}
		}
		i.jwGetItem = f("item");
		i.jwGetPosition = f("position");
		i.jwGetDuration = f("duration");
		i.jwGetBuffer = f("buffer");
		i.jwGetWidth = f("width");
		i.jwGetHeight = f("height");
		i.jwGetFullscreen = f("fullscreen");
		i.jwSetFullscreen = g.setFullscreen;
		i.jwGetVolume = f("volume");
		i.jwSetVolume = g.setVolume;
		i.jwGetMute = f("mute");
		i.jwSetMute = g.setMute;
		i.jwGetState = f("state");
		i.jwGetVersion = function () {
			return i.version
		};
		i.jwGetPlaylist = function () {
			return h.playlist
		};
		i.jwAddEventListener = g.addEventListener;
		i.jwRemoveEventListener = g.removeEventListener;
		i.jwSendEvent = g.sendEvent;
		i.jwGetLevel = function () {};
		i.jwGetBandwidth = function () {};
		i.jwGetLockState = function () {};
		i.jwLock = function () {};
		i.jwUnlock = function () {};

		function c(m, l, k) {
			return function () {
				m.loadPlaylist(m.config, true);
				m.setupPlugins();
				l.setup(m.getMedia().getDisplayElement());
				var n = {
					id: i.id,
					version: i.version
				};
				k.sendEvent(a.api.events.JWPLAYER_READY, n);
				if (playerReady !== undefined) {
					playerReady(n)
				}
				if (window[m.config.playerReady] !== undefined) {
					window[m.config.playerReady](n)
				}
				m.sendEvent(a.api.events.JWPLAYER_PLAYLIST_LOADED);
				m.sendEvent(a.api.events.JWPLAYER_PLAYLIST_ITEM, {
					item: m.config.item
				});
				if (m.config.autostart === true && !m.config.chromeless) {
					k.play()
				}
			}
		}
		if (h.config.chromeless) {
			setTimeout(c(h, e, g), 25)
		} else {
			i.skin.load(h.config.skin, c(h, e, g))
		}
		return i
	}
})(jwplayer);
