<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		pointstore
 */

class Hook_pointstore_ocdeadpeople
{

	/**
	 * Standard pointstore item initialisation function.
	 */
	function init()
	{
		require_lang('ocdeadpeople');
	}

	/**
	 * Standard pointstore item initialisation function.
	 *
	 * @return array			The "shop fronts"
	 */
	function info()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		//if (get_option('is_on_'.$class.'_buy')=='0') return array();

		$next_url=build_url(array('page'=>'_SELF','type'=>'action','id'=>$class),'_SELF');
		return array(do_template('POINTSTORE_'.strtoupper($class),array('NEXT_URL'=>$next_url)));
	}

	/**
	 * Standard interface stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action()
	{
		require_code('database_action');
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		if (!$GLOBALS['SITE_DB']->table_exists('diseases')) {
			$GLOBALS['SITE_DB']->create_table('diseases',array(
				'id'=>'*AUTO',
				'name'=>'SHORT_TEXT',
				'image'=>'SHORT_TEXT',
				'cure'=>'SHORT_TEXT',
				'cure_price'=>'INTEGER',
				'immunisation'=>'SHORT_TEXT',
				'immunisation_price'=>'INTEGER',
				'spread_rate'=>'INTEGER',
				'points_per_spread'=>'INTEGER',
				'last_spread_time'=>'INTEGER',
				'enabled'=>'BINARY'
			));
		}

		$tablename='members_diseases';
		$tablename_exists=false;
		 $row=$GLOBALS['SITE_DB']->query("SHOW TABLES LIKE '".get_table_prefix().$tablename."'");

		 foreach ($row as $rs) {
		  foreach ($rs as $rs1) {
		   if ($rs1 == get_table_prefix().$tablename) {
			$tablename_exists=true;
		   }
		  }
		 }

		$title=get_page_title('DESEASES_CURES_IMMUNIZATIONS_TITLE');

		if(!$tablename_exists) {
		  $GLOBALS['SITE_DB']->create_table($tablename,array(
			'user_id'=>'*INTEGER',
			'desease_id'=>'*INTEGER',
			'sick'=>'BINARY',
			'cure'=>'BINARY',
			'immunisation'=>'BINARY',
		   ));
		}

		require_code('form_templates');
		//$fields=new ocp_tempcode();
		$fields='<table style="width: 100%" cellspacing="0" cellpadding="0" border="1"><tr style="border: 1px solid #ccc; background-color: #E3EAF6;"><th colspan="2">Disease</th><th width="33%">Cure</th><th width="33%">Immunisation</th></tr>';

		$member_id=get_member();
		$rows=$GLOBALS['FORUM_DB']->query_select('diseases',array('*'),NULL);
		$counter=0;
		foreach($rows as $desease) {
			//$cure_url=get_base_url().'/site/index.php?page=pointstore&type=action_done&id=ocdeadpeople&desease='.$desease['id'].'&cure=1'; //hardcoded url
			$cure_url='';
			$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','desease'=>$desease['id'],'cure'=>1),'_SEARCH');
			$cure_url=$cure_url->evaluate();

			//$immunization_url=get_base_url().'/site/index.php?page=pointstore&type=action_done&id=ocdeadpeople&desease='.$desease['id'].'&immunization=1'; //hardcoded url
			$immunization_url='';
			$immunization_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','desease'=>$desease['id'],'immunization'=>1),'_SEARCH');
			$immunization_url=$immunization_url->evaluate();

			$member_rows=$GLOBALS['FORUM_DB']->query_select('members_diseases',array('*'),array('user_id'=>$member_id,'desease_id'=>$desease['id']));

			$get_cure=true;
			$get_immunization=true;

			if(isset($member_rows[0]['sick']) && $member_rows[0]['sick']==1 && $member_rows[0]['cure']==0) 
			{
				$get_cure=true;
				$get_immunization=false;
			}elseif(isset($member_rows[0]['sick']) && $member_rows[0]['sick']==0 && $member_rows[0]['immunisation']==0) 
			{
				$get_cure=false;
				$get_immunization=true;
			} elseif(!isset($member_rows[0])) 
			{
				$get_cure=false;
				$get_immunization=true;
			} elseif(isset($member_rows[0]['sick']) && ($member_rows[0]['cure']==1 || $member_rows[0]['immunisation']==1)) 
			{
				//skip this desease - because user has been immunizated or has been cured
				$get_cure=false;
				$get_immunization=false;
			}

			if($get_immunization || $get_cure)
			{
				if(is_file(get_file_base().'/'.$desease['image']))
				{
					if($get_cure)
					{
						$fields.='<tr style="border: 1px solid #ccc; background-color: #D4E0F1;"><td width="45"><img width="45" src="'.get_base_url().'/'.$desease['image'].'" /></td><td>'.$desease['name'].'</td><td width="33%">'.$desease['cure'].' costs '.$desease['cure_price'].' points<br /><a href="'.$cure_url.'">'.do_lang('PROCEED').'</a></td><td width="33%">-</td></tr>';
						$counter++;
					} else {
						$fields.='<tr style="border: 1px solid #ccc; background-color: #D4E0F1;"><td width="45"><img width="45" src="'.get_base_url().'/'.$desease['image'].'" /></td><td>'.$desease['name'].'</td><td width="33%">-</td><td width="33%">'.$desease['immunisation'].' costs '.$desease['immunisation_price'].' points<br /><a href="'.$immunization_url.'">'.do_lang('PROCEED').'</a></td></tr>';
						$counter++;
					}
				} else {
					if($get_cure)
					{
						$fields.='<tr style="border: 1px solid #ccc; background-color: #D4E0F1;"><td colspan="2">'.$desease['name'].'</td><td width="33%">'.$desease['cure'].' costs '.$desease['cure_price'].' points<br /><a href="'.$cure_url.'">'.do_lang('PROCEED').'</a></td><td width="33%">-</td></tr>';
						$counter++;
					} else {
						$fields.='<tr style="border: 1px solid #ccc; background-color: #D4E0F1;"><td colspan="2">'.$desease['name'].'</td><td width="33%">-</td><td width="33%">'.$desease['immunisation'].' costs '.$desease['immunisation_price'].' points<br /><a href="'.$immunization_url.'">'.do_lang('PROCEED').'</a></td></tr>';
						$counter++;
					}
				}
			}
		}

		if($counter==0) 
			$fields.='<tr><td colspan="4">'.do_lang('NO_ENTRIES_TO_DISPLAY').'</td></tr>';
		$fields.='</table>';

		return do_template('POINTSTORE_OCDEADPEOPLE_DESEASES',array('TITLE'=>$title,'FIELDS'=>$fields));
	}

	/**
	 * Standard actualisation stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action_done()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$desease_id=get_param('desease',0);
		$member_id=get_member();

		//default values
		$sick=0;

		$get_cure=get_param('cure',0);
		$get_immunization=get_param('immunization',0);

		$cure=($get_cure==1)?1:0;
		$immunization=($get_immunization==1)?1:0;

		$member_rows=$GLOBALS['FORUM_DB']->query_select('members_diseases',array('*'),array('user_id'=>$member_id,'desease_id'=>$desease_id));
		
		$insert=true;

		if(isset($member_rows[0]['user_id']) && $member_rows[0]['user_id']<>0)
		{
			//there is already a db member desease record
			$insert=false;
			$sick=($get_cure==1 && $member_rows[0]['sick']==1)?0:$sick;
		} else {
			//we should insert a new db member desease record
		}

		$rows=$GLOBALS['FORUM_DB']->query_select('diseases',array('*'),array('id'=>$desease_id));

		$cure_price=(isset($rows[0]['cure_price']) && (intval($rows[0]['cure_price'])>0))?intval($rows[0]['cure_price']):0;
		$immunization_price=(isset($rows[0]['immunisation_price']) && (intval($rows[0]['immunisation_price'])>0))?intval($rows[0]['immunisation_price']):0;
		$amount=($get_immunization==1)?$immunization_price:$cure_price;

		$title=get_page_title('DESEASES_CURES_IMMUNIZATIONS_TITLE');

		// Check points
		$points_left=available_points(get_member());

		if (!has_specific_permission(get_member(),'give_points_self'))
		{
			if ($points_left<$amount)
			{
				return warn_screen($title,do_lang_tempcode('_CANT_AFFORD_THIS'));
			}
		}
		
		// Actuate
		require_code('points2');
		if($get_immunization==1) 
		{
			charge_member(get_member(),$amount,do_lang('IMMUNIZATION_PURCHASED'));
		}
		else 
		{
			charge_member(get_member(),$amount,do_lang('CURE_PURCHASED'));
		}

		if($insert)
		{
			$GLOBALS['SITE_DB']->query_insert('members_diseases',array('user_id'=>$member_id,'desease_id'=>$desease_id,'sick'=>strval($sick),'cure'=>strval($cure),'immunisation'=>strval($immunization)));
		}
		else 
		{
			$GLOBALS['SITE_DB']->query_update('members_diseases',array('user_id'=>$member_id,'desease_id'=>$desease_id,'sick'=>strval($sick),'cure'=>strval($cure),'immunisation'=>strval($immunization)),array('user_id'=>$member_id,'desease_id'=>$desease_id),'',1);
		}

		if($get_immunization==1) 
		{
			// Show message
			$result=do_lang_tempcode('IMMUNIZATION_CONGRATULATIONS');
		}
		else
		{
			// Show message
			$result=do_lang_tempcode('CURE_CONGRATULATIONS');
		}


		$url=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');
		return redirect_screen($title,$url,$result);
	}

}


