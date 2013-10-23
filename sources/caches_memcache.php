<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/*EXTRA FUNCTIONS: Memcache*/

/**
 * Cache Driver.
 * @package		core
 */
class ocp_memcache extends Memcache
{
	/**
	 * Constructor.
	 */
	function __construct()
	{
		$this->connect('localhost',11211);
	}

	var $objects_list=NULL;

	/**
	 * Instruction to load up the objects list.
	 */
	function load_objects_list()
	{
		if (is_null($this->objects_list))
		{
			$this->objects_list=parent::get(get_file_base().'PERSISTENT_CACHE_OBJECTS');
			if ($this->objects_list===NULL) $this->objects_list=array();
		}
		return $this->objects_list;
	}

	/**
	 * Get data from the persistent cache.
	 *
	 * @param  string			Key
	 * @param  ?TIME			Minimum timestamp that entries from the cache may hold (NULL: don't care)
	 * @return ?mixed			The data (NULL: not found / NULL entry)
	 */
	function get($key,$min_cache_date=NULL)
	{
		$test=parent::get($key,$min_cache_date);
		if ($test===false) return NULL;
		return $test;
	}

	/**
	 * Put data into the persistent cache.
	 *
	 * @param  string			Key
	 * @param  mixed			The data
	 * @param  integer		Various flags (parameter not used)
	 * @param  ?integer		The expiration time in seconds (NULL: no expiry)
	 */
	function set($key,$data,$flags=0,$expire_secs=NULL)
	{
		// Update list of persistent-objects
		$objects_list=$this->load_objects_list();
		if (!array_key_exists($key,$objects_list))
		{
			$objects_list[$key]=true;
			parent::set(get_file_base().'PERSISTENT_CACHE_OBJECTS',$objects_list);
		}

		parent::set($key,array(time(),$data),$flags,$expire_secs);
	}

	/**
	 * Delete data from the persistent cache.
	 *
	 * @param  string			Key
	 */
	function delete($key)
	{
		// Update list of persistent-objects
		$objects_list=$this->load_objects_list();
		unset($objects_list[$key]);
		parent::set(get_file_base().'PERSISTENT_CACHE_OBJECTS',$objects_list);

		parent::delete($key);
	}

	/**
	 * Remove all data from the persistent cache.
	 */
	function flush()
	{
		// Update list of persistent-objects
		$objects_list=array();
		parent::set(get_file_base().'PERSISTENT_CACHE_OBJECTS',$objects_list);

		parent::flush();
	}
}