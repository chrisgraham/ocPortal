<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocworld
 */

/**
 * Module page class.
 */
class Module_ocworld
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=3;
		$info['locked']=false;
		$info['update_require_upgrade']=1;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('w_attempts');
		$GLOBALS['SITE_DB']->drop_if_exists('w_inventory');
		$GLOBALS['SITE_DB']->drop_if_exists('w_itemdef');
		$GLOBALS['SITE_DB']->drop_if_exists('w_items');
		$GLOBALS['SITE_DB']->drop_if_exists('w_members');
		$GLOBALS['SITE_DB']->drop_if_exists('w_messages');
		$GLOBALS['SITE_DB']->drop_if_exists('w_portals');
		$GLOBALS['SITE_DB']->drop_if_exists('w_realms');
		$GLOBALS['SITE_DB']->drop_if_exists('w_rooms');
		$GLOBALS['SITE_DB']->drop_if_exists('w_travelhistory');

		deldir_contents(get_custom_file_base().'/uploads/ocworld',true);

		require_code('ocworld');

		$prices=get_ocworld_prices_default();
		foreach (array_keys($prices) as $name)
		{
			$GLOBALS['SITE_DB']->query_delete('prices',array('name'=>$name),'',1);
		}

		delete_specific_permission('administer_ocworld');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((is_null($upgrade_from)) || ($upgrade_from<3))
		{
			add_specific_permission('OCWORLD','administer_ocworld');
		}

		if ((!is_null($upgrade_from)) && ($upgrade_from<3))
		{
			$GLOBALS['SITE_DB']->alter_table_field('w_attempts','datetime','TIME','a_datetime');
			$GLOBALS['SITE_DB']->alter_table_field('w_items','count','INTEGER','i_count');
			$GLOBALS['SITE_DB']->alter_table_field('w_messages','message','SHORT_TEXT','m_message');
			$GLOBALS['SITE_DB']->alter_table_field('w_messages','datetime','TIME','m_datetime');
			$GLOBALS['SITE_DB']->alter_table_field('w_portals','text','ID_TEXT','p_text');
			$GLOBALS['SITE_DB']->alter_table_field('w_rooms','text','LONG_TEXT','r_text');
			$GLOBALS['SITE_DB']->alter_table_field('w_realms','private','BINARY','r_private');
		}

		if (is_null($upgrade_from))
		{
			$GLOBALS['SITE_DB']->create_table('w_attempts',array(
				'id'=>'*AUTO',
				'a_datetime'=>'TIME',
				'attempt'=>'SHORT_TEXT',
				'x'=>'INTEGER',
				'y'=>'INTEGER',
				'realm'=>'INTEGER',
			));

			$GLOBALS['SITE_DB']->create_table('w_inventory',array(
				'item_name'=>'*SHORT_TEXT',
				'item_count'=>'INTEGER',
				'item_owner'=>'*USER',
			));

			$GLOBALS['SITE_DB']->create_table('w_itemdef',array(
				'name'=>'*ID_TEXT',
				'bribable'=>'BINARY',
				'healthy'=>'BINARY',
				'picture_url'=>'URLPATH',
				'owner'=>'USER',
				'replicateable'=>'BINARY',
				'max_per_player'=>'INTEGER',
				'description'=>'SHORT_TEXT',
			));

			$GLOBALS['SITE_DB']->create_table('w_items',array(
				'name'=>'*ID_TEXT',
				'location_realm'=>'*INTEGER',
				'location_x'=>'*INTEGER',
				'location_y'=>'*INTEGER',
				'not_infinite'=>'BINARY',
				'cost'=>'INTEGER',
				'i_count'=>'INTEGER',
				'copy_owner'=>'*USER',
			));

			$GLOBALS['SITE_DB']->create_table('w_members',array(
				'id'=>'*INTEGER', // NOT USER because it can be negative for a troll
				'location_realm'=>'INTEGER',
				'location_x'=>'INTEGER',
				'location_y'=>'INTEGER',
				'banned'=>'BINARY',
				'health'=>'INTEGER',
				'trolled'=>'INTEGER',
				'lastactive'=>'TIME',
			));

			$GLOBALS['SITE_DB']->create_table('w_messages',array(
				'location_realm'=>'*INTEGER',
				'location_x'=>'*INTEGER',
				'location_y'=>'*INTEGER',
				'm_message'=>'*SHORT_TEXT',
				'originator_id'=>'*USER',
				'm_datetime'=>'*TIME',
				'destination'=>'USER',
			));

			$GLOBALS['SITE_DB']->create_table('w_portals',array(
				'name'=>'ID_TEXT',
				'p_text'=>'ID_TEXT',
				'start_location_realm'=>'*INTEGER',
				'start_location_x'=>'*INTEGER',
				'start_location_y'=>'*INTEGER',
				'end_location_realm'=>'*INTEGER',
				'end_location_x'=>'INTEGER',
				'end_location_y'=>'INTEGER',
				'owner'=>'?USER',
			));

			$GLOBALS['SITE_DB']->create_table('w_rooms',array(
				'name'=>'ID_TEXT',
				'location_realm'=>'*INTEGER',
				'location_x'=>'*INTEGER',
				'location_y'=>'*INTEGER',
				'r_text'=>'LONG_TEXT',
				'password_question'=>'LONG_TEXT',
				'password_answer'=>'SHORT_TEXT',
				'password_fail_message'=>'SHORT_TEXT',
				'required_item'=>'SHORT_TEXT', // blank means none
				'locked_up'=>'BINARY',
				'locked_down'=>'BINARY',
				'locked_right'=>'BINARY',
				'locked_left'=>'BINARY',
				'picture_url'=>'URLPATH',
				'owner'=>'?USER',
				'allow_portal'=>'BINARY',
			));

			$GLOBALS['SITE_DB']->create_table('w_travelhistory',array(
				'member_id'=>'*USER',
				'x'=>'*INTEGER',
				'y'=>'*INTEGER',
				'realm'=>'*INTEGER',
			));

			$GLOBALS['SITE_DB']->create_table('w_realms',array(
				'id'=>'*INTEGER',
				'name'=>'SHORT_TEXT',
				'troll_name'=>'SHORT_TEXT',
				'owner'=>'?USER',
				'r_private'=>'BINARY',
				'q1'=>'LONG_TEXT',
				'q2'=>'LONG_TEXT',
				'q3'=>'LONG_TEXT',
				'q4'=>'LONG_TEXT',
				'q5'=>'LONG_TEXT',
				'q6'=>'LONG_TEXT',
				'q7'=>'LONG_TEXT',
				'q8'=>'LONG_TEXT',
				'q9'=>'LONG_TEXT',
				'q10'=>'LONG_TEXT',
				'q11'=>'LONG_TEXT',
				'q12'=>'LONG_TEXT',
				'q13'=>'LONG_TEXT',
				'q14'=>'LONG_TEXT',
				'q15'=>'LONG_TEXT',
				'q16'=>'LONG_TEXT',
				'q17'=>'LONG_TEXT',
				'q18'=>'LONG_TEXT',
				'q19'=>'LONG_TEXT',
				'q20'=>'LONG_TEXT',
				'q21'=>'LONG_TEXT',
				'q22'=>'LONG_TEXT',
				'q23'=>'LONG_TEXT',
				'q24'=>'LONG_TEXT',
				'q25'=>'LONG_TEXT',
				'q26'=>'LONG_TEXT',
				'q27'=>'LONG_TEXT',
				'q28'=>'LONG_TEXT',
				'q29'=>'LONG_TEXT',
				'q30'=>'LONG_TEXT',
				'a1'=>'SHORT_TEXT',
				'a2'=>'SHORT_TEXT',
				'a3'=>'SHORT_TEXT',
				'a4'=>'SHORT_TEXT',
				'a5'=>'SHORT_TEXT',
				'a6'=>'SHORT_TEXT',
				'a7'=>'SHORT_TEXT',
				'a8'=>'SHORT_TEXT',
				'a9'=>'SHORT_TEXT',
				'a10'=>'SHORT_TEXT',
				'a11'=>'SHORT_TEXT',
				'a12'=>'SHORT_TEXT',
				'a13'=>'SHORT_TEXT',
				'a14'=>'SHORT_TEXT',
				'a15'=>'SHORT_TEXT',
				'a16'=>'SHORT_TEXT',
				'a17'=>'SHORT_TEXT',
				'a18'=>'SHORT_TEXT',
				'a19'=>'SHORT_TEXT',
				'a20'=>'SHORT_TEXT',
				'a21'=>'SHORT_TEXT',
				'a22'=>'SHORT_TEXT',
				'a23'=>'SHORT_TEXT',
				'a24'=>'SHORT_TEXT',
				'a25'=>'SHORT_TEXT',
				'a26'=>'SHORT_TEXT',
				'a27'=>'SHORT_TEXT',
				'a28'=>'SHORT_TEXT',
				'a29'=>'SHORT_TEXT',
				'a30'=>'SHORT_TEXT',
			),true);

			require_code('ocworld');

			$prices=get_ocworld_prices_default();
			foreach ($prices as $name=>$price)
			{
				$GLOBALS['SITE_DB']->query_insert('prices',array('name'=>$name,'price'=>$price));
			}

			require_code('ocworld_action');
			add_realm_wrap(NULL,do_lang('W_DEFAULT_REALM'),do_lang('W_DEFAULT_TROLL'),do_lang('W_DEFAULT_JAIL'),do_lang('W_DEFAULT_IN_JAIL'),'',do_lang('W_DEFAULT_JAIL_HOUSE'),do_lang('W_DEFAULT_IN_JAIL_HOUSE'),'',do_lang('W_DEFAULT_LOBBY'),do_lang('W_DEFAULT_LOBBY_TEXT'),'',array(),0,false);
		}
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('misc'=>'OCWORLD');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_code('ocworld');
		require_code('ocworld_screens');

		// Decide what functions to execute for this command
		$command=either_param('type','room');
		$param=either_param('param','');
		$dest_member_id=either_param_integer('user',-1);
		$member_id=get_member();
		if (is_guest($member_id))
		{
			ocw_refresh_with_message(do_lang_tempcode('W_NOT_LOGGED_IN'),'warn');
			return new ocp_tempcode();
		}
		$item=either_param('item','');

		// Create the member if they aren't already in the system
		$member_rows=$GLOBALS['SITE_DB']->query_select('w_members',array('*'),array('id'=>$member_id),'',1);
		if (!array_key_exists(0,$member_rows))
		{
			$member_rows[0]=array(
				'id'=>$member_id,
				'location_realm'=>0,
				'location_x'=>0,
				'location_y'=>0,
				'banned'=>0,
				'health'=>10,
				'trolled'=>0,
				'lastactive'=>time(),
			);
			$GLOBALS['SITE_DB']->query_insert('w_members',$member_rows[0]);
		}
		$member_row=$member_rows[0];

		// Check for banning
		if ($member_row['banned']==1) ocw_refresh_with_message(do_lang_tempcode('W_YOU_BANNED'),'warn');

		// Check for death
		if ($member_row['health']<1)
		{
			take_items($member_id);
			$GLOBALS['SITE_DB']->query_update('w_members',array('location_realm'=>0,'location_x'=>0,'location_y'=>0,'banned'=>0,'health'=>10),array('id'=>$member_id),'',1);
			ocw_refresh_with_message(do_lang_tempcode('W_YOU_DIED'),'warn');
		}

		// Mark as active
		$GLOBALS['SITE_DB']->query_update('w_members',array('lastactive'=>time()),array('id'=>$member_id),'',1);

		destick($member_id);

		// Check to see if the user is locked into answering a trolls questions
		if ($member_row['trolled']!=0)
		{
			$realm=$member_row['location_realm'];

			// Get the questions that were asked
			$i=0;
			$trolled=$member_row['trolled'];
			$q=array();
			$a=array();
			while (($trolled & (255<<($i*8)))!=0)
			{
				$q_num=($trolled>>($i*8)) & 255;
				$q[$i+1]=$GLOBALS['SITE_DB']->query_value('w_realms','q'.strval($q_num),array('id'=>$realm));
				$a[$i+1]=$GLOBALS['SITE_DB']->query_value('w_realms','a'.strval($q_num),array('id'=>$realm));
				$i++;
			}
			$num_questions=$i;

			// Are we marking or answering?
			if (post_param('a1','!!')!='!!') // Marking
			{
				// Mark them
				$pass=0;
				for ($i=1;$i<=$num_questions;$i++)
				{
					$given=strtolower(post_param('a'.strval($i)));
					$stored=strtolower($a[$i]);
					if ($given==$stored) $pass++; elseif (strstr(':'.$stored.':',':'.$given.':')!==false) $pass++;
				}

				// Regardless they have had their chance: no more questions
				$GLOBALS['SITE_DB']->query_update('w_members',array('trolled'=>0),array('id'=>$member_id),'',1);

				if ($pass==0)
				{
					$pen_id=mt_rand(0,2);
					if ($pen_id==0)
					{
						$joke=mt_rand(1,10);
						$penalty=do_lang_tempcode('W_JOKE_'.strval($joke));

						hurt($member_id);
					}
					if ($pen_id==1)
					{
						$penalty=do_lang('W_PENALTY_STOLEN');
						steal($member_id,-$realm-1);
					}
					if ($pen_id==2)
					{
						$penalty=do_lang('W_PENALTY_SENT_LOBBY');
						basic_enter_room($member_id,$realm,0,0);
					}

					ocw_refresh_with_message(do_lang_tempcode('W_TROLL_YOU',escape_html($penalty)),'warn');
				} else ocw_refresh_with_message(do_lang_tempcode('W_TROLL_THANKYOU',integer_format($pass)));

			} else // Answer question screen
			{
				$troll_name=$GLOBALS['SITE_DB']->query_value('w_realms','troll_name',array('id'=>$realm));
				$title=get_screen_title('W_TROLL_Q',true,array(escape_html($troll_name)));
				$questions=new ocp_tempcode();
				for ($i=1;$i<=$num_questions;$i++)
				{
					$questions->attach(do_template('W_TROLL_QUESTION',array('_GUID'=>'b09eb44e4264a9dca5bdf651ca9a48d4','Q'=>$q[$i],'I'=>strval($i))));
				}
				return do_template('W_TROLL',array('_GUID'=>'e108ccaebc5b1adfa9db6b5b23e93602','TITLE'=>$title,'TROLL'=>$troll_name,'QUESTIONS'=>$questions));
			}
		}

		// There is a chance the troll on this realm will pick this 'turn' to move
		if (mt_rand(0,6)==1)
		{
			$realm=$member_row['location_realm'];
			$troll_id=-$realm-1;
			$troll_loc=get_loc_details($troll_id,true);
			if (!is_null($troll_loc))
			{
				list(,$troll_x,$troll_y)=$troll_loc;
				$dx=-1;
				$dy=-1;
				do
				{
					$dx=mt_rand(-1,1);
					$dy=mt_rand(-1,1);
				}
				while (!room_exists($troll_x+$dx,$troll_y+$dy,$realm));
				$GLOBALS['SITE_DB']->query_update('w_members',array('location_x'=>($troll_x+$dx),'location_y'=>($troll_y+$dy)),array('id'=>$troll_id),'',1);
			}
		}

		require_code('uploads');

		// What command are we being asked to do?
		if ($command=='confirm')
		{
			$url=build_url(array('page'=>'ocworld'),'_SELF');
			$command2=either_param('btype','');
			$item=either_param('item','');
			$user=either_param_integer('user',-1);
			$param=either_param('param','');

			return do_template('W_CONFIRM_SCREEN',array('_GUID'=>'365870cb4c6cb4282ff6c7a11f4f8a5b','TITLE'=>get_screen_title('W_CONFIRM_TITLE'),'URL'=>$url,'COMMAND'=>$command2,'ITEM'=>$item,'USER'=>strval($user),'PARAM'=>$param));
		}
		if ($command=='reallocate')
		{
			if (!has_specific_permission(get_member(),'administer_ocworld')) ocw_refresh_with_message(do_lang_tempcode('W_ONLY_STAFF_REALLOC'),'warn');

			$out=new ocp_tempcode();

			$rows=$GLOBALS['SITE_DB']->query_select('items',array('*'),array('copy_owner'=>NULL));
			foreach ($rows as $myrow)
			{
				$owner=$GLOBALS['SITE_DB']->query_value('w_itemdef','owner',array('name'=>$myrow['name']));
				if (!is_null($owner))
				{
					$GLOBALS['SITE_DB']->query_update('w_items',array('copy_owner'=>$owner),array('name'=>$myrow['name'],'copy_owner'=>NULL));
					$out->attach(paragraph(do_lang_tempcode('W_REALLOCATING',escape_html($myrow['name']),'tfgdfgd4rf')));
				}
			}

			return do_template('W_REALLOCATE',array('_GUID'=>'8fa4b9205310d6bc2fc28348a52898d5','TITLE'=>get_screen_title('W_REALLOCATE'),'OUT'=>$out));
		}	
		if ($command=='portal') portal($member_id,intval($param));
		if ($command=='realms')
		{
			realms();
			return new ocp_tempcode();
		}
		if ($command=='up')
		{
			$tpl=try_to_enter_room($member_id,0,-1,'');
			if (!is_null($tpl)) return $tpl;
			ocw_refresh_with_message(new ocp_tempcode());
		}
		if ($command=='down')
		{
			$tpl=try_to_enter_room($member_id,0,1,'');
			if (!is_null($tpl)) return $tpl;
			ocw_refresh_with_message(new ocp_tempcode());
		}
		if ($command=='right')
		{
			$tpl=try_to_enter_room($member_id,1,0,'');
			if (!is_null($tpl)) return $tpl;
			ocw_refresh_with_message(new ocp_tempcode());
		}
		if ($command=='left')
		{
			$tpl=try_to_enter_room($member_id,-1,0,'');
			if (!is_null($tpl)) return $tpl;
			ocw_refresh_with_message(new ocp_tempcode());
		}
		if ($command=='answered')
		{
			$tpl=try_to_enter_room($member_id,post_param_integer('dx'),post_param_integer('dy'),$param);
			if (!is_null($tpl)) return $tpl;
		}
		if ($command=='drop') drop_wrap($member_id,$item);
		if ($command=='give') give($member_id,$dest_member_id,$item);
		if ($command=='pickpocket') pickpocket($member_id,$dest_member_id);
		if ($command=='use') useitem($member_id,$item);
		if ($command=='take') take($member_id,$item,$dest_member_id);
		if ($command=='buy') buy($member_id,$item,$dest_member_id);
		if ($command=='inventory')
		{
			$tpl=output_inventory_screen($dest_member_id);
			return $tpl;
		}
		if ($command=='findperson') findperson(($param=='')?strval($dest_member_id):$param);
		if ($command=='message')
		{
			message($member_id,post_param('post'),post_param_integer('tuser'));
		}
		if ($command=='emergency') basic_enter_room($member_id,0,0,0);
		if ($command=='delete-message-by-person')
		{
			if ((!has_specific_permission($member_id,'administer_ocworld')) && ($member_id!=$dest_member_id)) ocw_refresh_with_message(do_lang_tempcode('ACCESS_DENIED__I_ERROR',$GLOBALS['FORUM_DRIVER']->get_username(get_member())),'warn');
			delete_message($member_id,$dest_member_id,addslashes($param));
		}

		// Management
		if ($command=='additem')
		{
			require_code('ocworld_action');

			$name=post_param('name','');
			if ($name=='')
			{
				$tpl=do_template('W_ITEM_SCREEN',array('_GUID'=>'0246f7037a360996bdfb4f1dcf96bcfc','PRICE'=>integer_format(get_price('mud_item')),'TEXT'=>paragraph(do_lang_tempcode('W_ADD_ITEM_TEXT')),'TITLE'=>get_screen_title('W_ADD_ITEM_TITLE'),'PAGE_TYPE'=>'additem','ITEM'=>'','DESCRIPTION'=>'','BRIBABLE'=>'0','HEALTHY'=>'0','PICTURE_URL'=>'','MAX_PER_PLAYER'=>'10','REPLICATEABLE'=>'1'));
				return $tpl;
			}

			$urls=get_url('url','pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			add_item_wrap($member_id,$name,post_param_integer('cost',0),post_param_integer('not_infinite',0),post_param_integer('bribable',0),post_param_integer('healthy',0),$urls[0],post_param_integer('max_per_player',-1),post_param_integer('replicateable',0),post_param('description'));
		}
		if ($command=='additemcopy')
		{
			require_code('ocworld_action');

			$name=post_param('name','');
			if ($name=='')
			{
				$rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'w_itemdef WHERE replicateable=1 OR owner='.strval((integer)get_member()).' ORDER BY name');
				$items='';
				foreach ($rows as $myrow)
				{
					$items.="<option value=\"".escape_html($myrow['name'])."\">".escape_html($myrow['name'])."</option>";
				}
				if ($items=='') ocw_refresh_with_message(do_lang_tempcode('W_NO_ITEMS_YET'),'warn');

				if ($GLOBALS['XSS_DETECT']) ocp_mark_as_escaped($items);

				$tpl=do_template('W_ITEMCOPY_SCREEN',array('_GUID'=>'15799930bca51eafdee3c0a8e197866a','PRICE'=>integer_format(get_price('mud_item_copy')),'TEXT'=>paragraph(do_lang_tempcode('W_ADD_ITEM_COPY_TEXT')),'TITLE'=>get_screen_title('W_ADD_ITEM_COPY_TITLE'),'PAGE_TYPE'=>'additemcopy','NOT_INFINITE'=>'1','ITEMS'=>$items,'COST'=>''));
				return $tpl;
			}
			add_item_wrap_copy($member_id,$name,post_param_integer('cost'),post_param_integer('not_infinite',0));
		}
		if ($command=='addroom')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				list($realm,$x,$y)=get_loc_details($member_id);
				$tpl=do_template('W_ROOM_SCREEN',array('_GUID'=>'5357a6cf8648c952cf29c2b7234cfa6c','PRICE'=>integer_format(get_price('mud_room')),'TEXT'=>paragraph(do_lang_tempcode('W_ADD_ROOM_TEXT')),'ROOM_TEXT'=>'','TITLE'=>get_screen_title('W_ADD_ROOM_TITLE'),'PAGE_TYPE'=>'addroom','NAME'=>'','PASSWORD_QUESTION'=>'','PASSWORD_ANSWER'=>'','PASSWORD_FAIL_MESSAGE'=>'','REQUIRED_ITEM'=>'','LOCKED_UP'=>'0','LOCKED_DOWN'=>'0','LOCKED_LEFT'=>'0','LOCKED_RIGHT'=>'0','ALLOW_PORTAL'=>'1','PICTURE_URL'=>''));
				return $tpl;
			}
			$urls=get_url('url','pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			add_room_wrap($member_id,post_param_integer('position'),$name,post_param('text'),post_param('password_question'),post_param('password_answer'),post_param('password_fail_message'),post_param('required_item'),post_param_integer('locked_up',0),post_param_integer('locked_down',0),post_param_integer('locked_right',0),post_param_integer('locked_left',0),$urls[0],post_param_integer('allow_portal',0));
		}
		if ($command=='addrealm')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				$fortnights=(time()-$GLOBALS['FORUM_DRIVER']->get_member_join_timestamp(get_member()))/(60*60*24*7*2);
				$made=$GLOBALS['SITE_DB']->query_value('w_realms','COUNT(*)',array('owner'=>get_member()));
				$left=round($fortnights-$made);

				$_qa=new ocp_tempcode();
				for ($i=1;$i<=30;$i++)
				{
					$_qa->attach(do_template('W_REALM_SCREEN_QUESTION',array('_GUID'=>'5fa7725f11b0df7e58ff83f2f1751515','I'=>strval($i),'Q'=>'','A'=>'')));
				}

				$tpl=do_template('W_REALM_SCREEN',array('_GUID'=>'7ae26fe1766aed02233e1be84772759b','PRICE'=>integer_format(get_price('mud_realm')),'TEXT'=>paragraph(do_lang_tempcode('W_ADD_REALM_TEXT',integer_format($left))),'TITLE'=>get_screen_title('W_ADD_REALM_TITLE'),'PAGE_TYPE'=>'addrealm','QA'=>$_qa,'NAME'=>'','TROLL_NAME'=>'','PRIVATE'=>'0'));
				return $tpl;
			}

			$i=1;
			$qa=array();
			while (strlen(post_param('question'.strval($i),''))>0)
			{
				$qa[$i]=array();
				$qa[$i]['q']=post_param('question'.strval($i));
				$qa[$i]['a']=post_param('answer'.strval($i));
				$i++;
			}
			$urls1=get_url('jail_pic_url','jail_pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			$urls2=get_url('jail_house_pic_url','jail_house_pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			$urls3=get_url('lobby_pic_url','lobby_pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			add_realm_wrap($member_id,$name,post_param('troll_name'),post_param('jail_name'),post_param('jail_text'),$urls1[0],post_param('jail_house_name'),post_param('jail_house_text'),$urls2[0],post_param('lobby_name'),post_param('lobby_text'),$urls3[0],$qa,post_param_integer('private',0));
		}
		if ($command=='addportal')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				$tpl=do_template('W_PORTAL_SCREEN',array('_GUID'=>'69e74a964f69721d0381a920c4a25ce5','PRICE'=>integer_format(get_price('mud_portal')),'TEXT'=>paragraph(do_lang_tempcode('W_ADD_PORTAL_TEXT')),'TITLE'=>get_screen_title('W_ADD_PORTAL_TITLE'),'PORTAL_TEXT'=>'','PAGE_TYPE'=>'addportal','NAME'=>'','END_LOCATION_REALM'=>'','END_LOCATION_X'=>'','END_LOCATION_Y'=>''));
				return $tpl;
			}

			add_portal_wrap($member_id,$name,post_param('text'),post_param_integer('end_location_realm',-1),post_param_integer('end_location_x',-1),post_param_integer('end_location_y',-1));
		}
		if ($command=='deleteitem')
		{
			require_code('ocworld_action');

			delete_item_wrap($item);
		}
		if ($command=='deleteroom')
		{
			require_code('ocworld_action');

			delete_room_wrap($member_id);
		}
		if ($command=='deleterealm')
		{
			require_code('ocworld_action');

			delete_realm_wrap($member_id);
		}
		if ($command=='deleteportal')
		{
			require_code('ocworld_action');

			delete_portal_wrap($member_id,intval($param));
		}

		// Admin commands
		if (has_specific_permission($member_id,'administer_ocworld'))
		{
			if ($command=='mergeitems') merge_items($item,either_param('item2'));
			if ($command=='teleport-person')
			{
				$ast=strpos($param,':');
				$b=strpos($param,':',$ast+1);
				$realm=substr($param,0,$ast);
				$x=intval(substr($param,$ast+1,$b-$ast-1));
				$y=intval(substr($param,$b+1));
				basic_enter_room($dest_member_id,$realm,$x,$y);
			}
			if ($command=='imprison-person') imprison($dest_member_id);
			if ($command=='hurt-person') hurt($dest_member_id);
			if ($command=='dehurt-person') dehurt($dest_member_id);
			if ($command=='ban-person') ban_member($dest_member_id);
			if ($command=='unban-person') unban_member($dest_member_id);
			if ($command=='take-from-person') steal($member_id,$dest_member_id);
		}
		if ($command=='edititem')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				$rows=$GLOBALS['SITE_DB']->query_select('w_itemdef',array('*'),array('name'=>either_param('item')),'',1);
				if (!array_key_exists(0,$rows)) ocw_refresh_with_message(do_lang_tempcode('MISSING_RESOURCE'),'warn');
				$row=$rows[0];

				$tpl=do_template('W_ITEM_SCREEN',array('_GUID'=>'1f581864bd2f0cbe05742e03ab6c2a53','TITLE'=>get_screen_title('W_EDIT_ITEM_TITLE'),'PAGE_TYPE'=>'edititem','ITEM'=>either_param('item'),'DESCRIPTION'=>$row['description'],'BRIBABLE'=>strval($row['bribable']),'HEALTHY'=>strval($row['healthy']),'PICTURE_URL'=>$row['picture_url'],'OWNER'=>is_null($row['owner'])?'':strval($row['owner']),'MAX_PER_PLAYER'=>strval($row['max_per_player']),'REPLICATEABLE'=>strval($row['replicateable'])));
				return $tpl;
			}

			$urls=get_url('url','pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			edit_item_wrap($member_id,$item,$name,post_param_integer('bribable',0),post_param_integer('healthy',0),$urls[0],grab_new_owner('new_owner'),post_param_integer('max_per_player',-1),post_param_integer('replicateable',0),post_param('description'));
		}
		if ($command=='edititemcopy')
		{
			require_code('ocworld_action');

			$cost=post_param_integer('cost',-1);

			if ($cost==-1)
			{
				$user=get_param_integer('user');
				list($realm,$x,$y)=get_loc_details($member_id);

				$cost=$GLOBALS['SITE_DB']->query_value('w_items','cost',array('copy_owner'=>$user,'location_x'=>$x,'location_y'=>$y,'location_realm'=>$realm,'name'=>get_param('item')));
				$not_infinite=$GLOBALS['SITE_DB']->query_value('w_items','not_infinite',array('copy_owner'=>$user,'location_x'=>$x,'location_y'=>$y,'location_realm'=>$realm,'name'=>get_param('item')));

				$tpl=do_template('W_ITEMCOPY_SCREEN',array('_GUID'=>'a8d28f6516408dba96a8b57ddcd7cee6','TITLE'=>get_screen_title('W_EDIT_ITEM_COPY_TITLE'),'PAGE_TYPE'=>'edititemcopy','NOT_INFINITE'=>strval($not_infinite),'X'=>strval($x),'Y'=>strval($y),'REALM'=>strval($realm),'ITEM'=>get_param('item'),'OWNER'=>strval($user),'COST'=>strval($cost)));
				return $tpl;
			}

			edit_item_wrap_copy($member_id,$item,$cost,post_param_integer('not_infinite',0),post_param_integer('new_x'),post_param_integer('new_y'),post_param_integer('new_realm'),grab_new_owner('new_owner'));
		}
		if ($command=='editroom')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				list($location_realm,$x,$y)=get_loc_details($member_id);

				$rows=$GLOBALS['SITE_DB']->query_select('w_rooms',array('*'),array('location_x'=>$x,'location_y'=>$y,'location_realm'=>$location_realm),'',1);
				if (!array_key_exists(0,$rows)) ocw_refresh_with_message(do_lang_tempcode('MISSING_RESOURCE'),'warn');
				$row=$rows[0];

				$tpl=do_template('W_ROOM_SCREEN',array('_GUID'=>'a4c5f8ae962cdbaa304135cf07c583a0','TITLE'=>get_screen_title('W_EDIT_ROOM_TITLE'),'PAGE_TYPE'=>'editroom','X'=>strval($x),'Y'=>strval($y),'REALM'=>strval($location_realm),'NAME'=>$row['name'],'ROOM_TEXT'=>$row['r_text'],'PASSWORD_QUESTION'=>$row['password_question'],'PASSWORD_ANSWER'=>$row['password_answer'],'PASSWORD_FAIL_MESSAGE'=>$row['password_fail_message'],'REQUIRED_ITEM'=>$row['required_item'],'LOCKED_UP'=>strval($row['locked_up']),'LOCKED_DOWN'=>strval($row['locked_down']),'LOCKED_LEFT'=>strval($row['locked_left']),'LOCKED_RIGHT'=>strval($row['locked_right']),'ALLOW_PORTAL'=>strval($row['allow_portal']),'PICTURE_URL'=>$row['picture_url'],'OWNER'=>is_null($row['owner'])?'':strval($row['owner'])));
				return $tpl;
			}

			$urls=get_url('url','pic','uploads/ocworld',0,OCP_UPLOAD_IMAGE);
			edit_room_wrap($member_id,$name,post_param('text'),post_param('password_question'),post_param('password_answer'),post_param('password_fail_message'),post_param('required_item'),post_param_integer('locked_up',0),post_param_integer('locked_down',0),post_param_integer('locked_right',0),post_param_integer('locked_left',0),$urls[0],post_param_integer('allow_portal',0),grab_new_owner('new_owner'),post_param_integer('new_x'),post_param_integer('new_y'),post_param_integer('new_realm'));
		}
		if ($command=='editrealm')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				list($realm,,)=get_loc_details($member_id);

				$rows=$GLOBALS['SITE_DB']->query_select('w_realms',array('*'),array('id'=>$realm),'',1);
				if (!array_key_exists(0,$rows)) ocw_refresh_with_message(do_lang_tempcode('MISSING_RESOURCE'),'warn');
				$row=$rows[0];

				$qatc=new ocp_tempcode();
				for ($i=1;$i<=30;$i++)
				{
					$qatc->attach(do_template('W_REALM_SCREEN_QUESTION',array('_GUID'=>'0510427a3895969dede2bd13db7d46a6','I'=>strval($i),'Q'=>$row['q'.strval($i)],'A'=>$row['a'.strval($i)])));
				}

				$tpl=do_template('W_REALM_SCREEN',array('_GUID'=>'f2503e0be6e45a296baa8625cafb4d72','TITLE'=>get_screen_title('W_EDIT_REALM_TITLE'),'PAGE_TYPE'=>'editrealm','OWNER'=>is_null($row['owner'])?'':strval($row['owner']),'QA'=>$qatc,'NAME'=>$row['name'],'TROLL_NAME'=>$row['troll_name'],'PRIVATE'=>strval($row['r_private'])));
				return $tpl;
			}

			for ($i=1;$i<=30;$i++)
			{
				$qa[$i]['q']=post_param('question'.strval($i));
				$qa[$i]['a']=post_param('answer'.strval($i));
			}
			edit_realm_wrap($member_id,$name,post_param('troll_name'),$qa,post_param_integer('private',0),grab_new_owner('new_owner'));
		}
		if ($command=='editportal')
		{
			require_code('ocworld_action');

			$name=post_param('name','');

			if ($name=='')
			{
				list($realm,$x,$y)=get_loc_details($member_id);
				$end_realm=get_param_integer('param');

				$rows=$GLOBALS['SITE_DB']->query_select('w_portals',array('*'),array('start_location_x'=>$x,'start_location_y'=>$y,'start_location_realm'=>$realm,'end_location_realm'=>$end_realm),'',1);
				if (!array_key_exists(0,$rows)) ocw_refresh_with_message(do_lang_tempcode('MISSING_RESOURCE'),'warn');
				$row=$rows[0];

				$tpl=do_template('W_PORTAL_SCREEN',array('_GUID'=>'cad0e01c1c4c410e67b775c3ff6eeb3a','TITLE'=>get_screen_title('W_EDIT_PORTAL_TITLE'),'PAGE_TYPE'=>'editportal','X'=>strval($x),'Y'=>strval($y),'REALM'=>strval($realm),'PARAM'=>$param,'NAME'=>$row['name'],'PORTAL_TEXT'=>$row['p_text'],'END_LOCATION_REALM'=>strval($end_realm),'END_LOCATION_X'=>strval($row['end_location_x']),'END_LOCATION_Y'=>strval($row['end_location_y']),'OWNER'=>is_null($row['owner'])?'':strval($row['owner'])));
				return $tpl;
			}

			edit_portal_wrap($member_id,intval($param),$name,post_param('text'),post_param_integer('end_location_realm'),post_param_integer('end_location_x'),post_param_integer('end_location_y'),grab_new_owner('new_owner'),post_param_integer('new_x'),post_param_integer('new_y'),post_param_integer('new_realm'));
		}
		if ($command=='room')
		{
			return output_room_screen($member_id);
		}

		ocw_refresh_with_message(do_lang('SUCCESS'));
		return new ocp_tempcode();
	}

}


