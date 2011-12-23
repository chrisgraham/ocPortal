window.hasFocus=true;
addEventListenerAbstract(window,'blur',function() { window.hasFocus=false; });
addEventListenerAbstract(window,'focus',function() { window.hasFocus=true; });

function play_sound_url(url) // Used for testing different sounds
{
	if (typeof window.soundManager=='undefined') return;

	var base_url=((url.indexOf('data_custom')==-1)&&(url.indexOf('uploads/')==-1))?'{$BASE_URL_NOHTTP;}':'{$CUSTOM_BASE_URL_NOHTTP;}';
	soundManager.destroySound('temp');
	soundManager.createSound('temp',base_url+'/'+url);
	soundManager.play('temp');
}

function play_chat_sound(sID,for_member)
{
	if (typeof window.soundManager=='undefined') return;

	var play_sound=window.document.getElementById('play_sound');
	
	if ((play_sound) && (!play_sound.checked)) return;

	if (for_member)
	{
		var override=soundManager.getSoundById(sID+'_'+for_member,true);
		if (override)
		{
			sID=sID+'_'+for_member;
		}
	}

	soundManager.play(sID);
}

function chat_load(room_id)
{
	document.getElementById("post").focus();

	manageScrollHeight(document.getElementById('post'));

	con.addPacketListener(
	    function(msg) {
	      // load extensions that are present in the packet using our ExtensionProvider
	      msg.loadExtensions(extProvider);

	      chatMessageHandler(null,msg);

	    }, 
       new Xmpp4Js.PacketFilter.PacketTypeFilter( "groupchat" )
	);

	play_chat_sound('you_connect');
}

function chatMessageHandler(chat, messagePacket)
{
	if( messagePacket.hasContent() )
	{
		addChatMessage(messagePacket.getFrom().replace(/.*\//,'').replace(/\./g,' '),messagePacket.getBody(),messagePacket.getDate());
	}
}

function addChatMessage(username,body,_date)
{
	var messages=document.getElementById('messages_window');
	if (!_date)
		_date=new Date();
	var date=_date.toLocaleString();
	setInnerHTML(messages,"<div class=\"chat_message\"><a href=\"{$BASE_URL*}/site/index.php?page=members&amp;type=view&amp;id="+escape_html(username)+"\"><img class=\"chat_avatar\" src=\"{$FIND_SCRIPT*,get_avatar}?id="+window.encodeURIComponent(username)+keep_stub(false)+"\" alt=\"{!AVATAR}\" title=\"\" /></a><div><span class=\"chat_message_by\">By <a href=\"{$BASE_URL*}/site/index.php?page=members&amp;type=view&amp;id="+escape_html(username)+"\">"+escape_html(username)+"</a></span> <span class=\"associated_details\">("+escape_html(date)+")</span></div><blockquote>"+escape_html(body)+"</blockquote></div>"+getInnerHTML(messages));
}

// Post a chat message
function chat_post(event,current_room_id,field_name)
{
	var message=document.getElementById(field_name).value;
	if (message=='') return false;
	room.sendText( message );
	document.getElementById(field_name).value='';

	play_chat_sound('message_sent');

	//addChatMessage('{$USERNAME;}',message,null);
	
	return false;
}

function xmpp_connect(username,password,onLoginCompleted)
{
	window.extProvider = new Xmpp4Js.Ext.PacketExtensionProvider();
	extProvider.register( Xmpp4Js.Ext.Muc.XMLNS, Xmpp4Js.Ext.Muc );
	extProvider.register( Xmpp4Js.Ext.MucUser.XMLNS, Xmpp4Js.Ext.MucUser );
	extProvider.register( Xmpp4Js.Ext.Error.XMLNS, Xmpp4Js.Ext.Error );

	var sp = new Xmpp4Js.Packet.StanzaProvider();  
	sp.registerDefaultProviders();  

	window.con = new Xmpp4Js.Connection( {
	   transport: {
	       clazz: Xmpp4Js.Transport.BOSH,
	       //endpoint: "{$FIND_SCRIPT#,xmpp_proxy}"
			 endpoint: "http://{$DOMAIN#}:5280/http-bind/" // Same origin policy support
	   },
      stanzaProvider: sp
	} );
	con.on("connect", function() { onConnectForLogin(username,password,onLoginCompleted) }, this, {single: true} );
	con.on("error", onConnectError, this, {single: true} );
	con.connect( "{$DOMAIN;}" );
}

function onConnectError()
{
	if (typeof window.mucMan=='undefined')
		window.fauxmodal_alert('Error connecting to XMPP server.');
}

function onConnectForLogin(username,password,onLoginCompleted)
{
   var loginFlow = new Xmpp4Js.Workflow.Login({
       con: con
   });

	loginFlow.on("success", onLoginCompleted );
	loginFlow.on("failure", onConnectError );

	loginFlow.start( "plaintext", username, password );

	window.mucMan = Xmpp4Js.Muc.MucManager.getInstanceFor( window.con, "conference.{$DOMAIN;}", window.extProvider );

	addEventListenerAbstract(window,'unload',function () {
		if (con.isConnected()) // Clean shutdown
		{
			if (window.room) room.part();
			con.close();
		}
	} );
	
	window.setInterval( function() {
		if (!con.isConnected()) // Auto reconnect on errors
		{
			xmpp_connect(username,password,onLoginCompleted);
		}
	} , 10000 );
}
