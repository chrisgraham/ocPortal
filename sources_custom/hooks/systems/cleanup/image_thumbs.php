<?php

class Hook_image_thumbs
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		return NULL; // Disabled if thumbnails are controlled manually
	}
}

