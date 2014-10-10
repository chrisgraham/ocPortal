<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_google_results
{
	/**
	 * Find details of the block.
	 *
	 * @return ?array	Map of block info (NULL: block is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Kamen / Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array();
		return $info;
	}

	/**
	 * Find cacheing details for the block.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: block is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array()';
		$info['ttl']=(get_value('no_block_timeout')==='1')?60*60*24*365*5/*5 year timeout*/:60*5;
		return $info;
	}

	/**
	 * Execute the block.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		i_solemnly_declare(I_UNDERSTAND_SQL_INJECTION | I_UNDERSTAND_XSS | I_UNDERSTAND_PATH_INJECTION);

		require_lang('google_search');

		return do_template('BLOCK_MAIN_GOOGLE_SEARCH_RESULTS',array('_GUID'=>'e2bd264817a6ad7852918583986bd373'));
	}
}


