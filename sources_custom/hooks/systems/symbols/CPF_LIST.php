<?php

class Hook_symbol_CPF_LIST
{

	/**
	 * Standard modular run function for symbol hooks. Searches for tasks to perform.
    *
    * @param  array		Symbol parameters
    * @return string		Result
	 */
	function run($param)
	{
		$value='';

		if (isset($param[0]))
		{
			static $cache=array();
			if (isset($cache[$param[0]])) return $cache[$param[0]];

			if (($param[0]=='m_primary_group') || ($param[0]==do_lang('GROUP')))
			{
				$map=has_specific_permission(get_member(),'see_hidden_groups')?array():array('g_hidden'=>0);
				$group_count=$GLOBALS['FORUM_DB']->query_value('f_groups','COUNT(*)');
				$_m=$GLOBALS['FORUM_DB']->query_select('f_groups',array('id','g_name'),($group_count>200)?(array('g_is_private_club'=>0)+$map):$map,'ORDER BY g_order');
				foreach ($_m as $m)
				{
					if ($m['id']==db_get_first_id()) continue;

					if ($value!='') $value.=',';
					$value.=strval($m['id']).'='.get_translated_text($m['g_name'],$GLOBALS['FORUM_DB']);
				}
			}
			require_code('ocf_members');
			$cpf_id=find_cpf_field_id($param[0]);
			if (!is_null($cpf_id))
			{
				$test=$GLOBALS['FORUM_DB']->query_select('f_custom_fields',array('cf_default'),array('cf_type'=>'list','id'=>$cpf_id));
				if (array_key_exists(0,$test))
				{
					$bits=explode('|',$test[0]['cf_default']);
					sort($bits);
					foreach ($bits as $k)
					{
						if ($value!='') $value.=',';
						$value.=$k.'='.$k;
					}
				}
			}

			$cache[$param[0]]=$value;
		}

		return $value;
	}

}
