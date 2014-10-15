<?php

class Hook_image_thumbs
{
    /**
	 * Find details about this cleanup hook.
	 *
	 * @return ?array	Map of cleanup hook info (NULL: hook is disabled).
	 */
    public function info()
    {
        return NULL; // Disabled if thumbnails are controlled manually
    }
}
