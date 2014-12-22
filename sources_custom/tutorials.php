<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    ocportal_tutorials
 */

/*

Tags defined in .txt files...

pinned
document video audio slideshow
novice regular expert
<names of addons>
Classifications, for which we have icons

Tags correspond also to icons, if one matches. Earliest match.

*/

function list_tutorials()
{
    $tutorials = array();

    $_tags = $GLOBALS['SITE_DB']->query_select('tutorials_external_tags', array('t_id', 't_tag'));
    $external = $GLOBALS['SITE_DB']->query_select('tutorials_external t', array('t.*', tutorial_sql_rating('t.id'), tutorial_sql_rating_recent('t.id'), tutorial_sql_likes('t.id'), tutorial_sql_likes_recent('t.id')));
    foreach ($external as $e)
    {
        $tags = array();
        foreach ($_tags as $tag) {
            if ($tag['t_id'] == $e['id']) {
                $tags[] = $tag['t_tag'];
            }
        }

        $tutorials[] = get_tutorial_metadata(strval($e['id']), $e, $tags);
    }

    $internal = $GLOBALS['SITE_DB']->query_select('tutorials_internal t', array('t.*', tutorial_sql_rating('t.t_page_name'), tutorial_sql_rating_recent('t.t_page_name'), tutorial_sql_likes('t.t_page_name'), tutorial_sql_likes_recent('t.t_page_name')));
    foreach ($internal as $e)
    {
        $tutorials[] = get_tutorial_metadata($e['t_page_name'], $e);
    }

    return $tutorials;
}

function get_tutorial_metadata($tutorial_name, $db_row = null, $tags = null)
{
    if (is_numeric($tutorial_name)) {
        if (is_null($db_row)) {
            $db_rows = $GLOBALS['SITE_DB']->query_select('tutorials_external t', array('t.*', tutorial_sql_rating('t.id'), tutorial_sql_rating_recent('t.id'), tutorial_sql_likes('t.id'), tutorial_sql_likes_recent('t.id')), array('id' => intval($tutorial_name)), '', 1);
            $db_row = $db_rows[0];
        }

        if (is_null($tags)) {
            $_tags = $GLOBALS['SITE_DB']->query_select('tutorials_external', array('t_tag'), array('t_id' => intval($tutorial_name)));
            $tags = collapse_1d_complexity('t_tag', $_tags);
        }

        return array(
            'url' => $db_row['t_url'],
            'title' => $db_row['t_title'],
            'summary' => $db_row['t_summary'],
            'icon' => find_tutorial_image($db_row['t_icon'], array_merge($tags, $db_row['t_media_type'], $db_row['t_difficulty_level'])),
            'tags' => $tags,
            'media_type' => $db_row['t_media_type'],
            'difficulty_level' => $db_row['t_difficulty_level'],
            'core' => $db_row['t_core'],
            'pinned' => $db_row['t_pinned'],
            'author' => $db_row['t_author'],
            'views' => $db_row['t_views'],
            'add_date' => $db_row['t_add_date'],
            'edit_date' => $db_row['t_edit_date'],

            'rating' => $db_row['rating'],
            'rating_recent' => $db_row['rating_recent'],
            'likes' => $db_row['likes'],
            'likes_recent' => $db_row['likes_recent'],
        );
    } else {
        if (is_null($db_row)) {
            $db_rows = $GLOBALS['SITE_DB']->query_select('tutorials_external t', array('t.*', tutorial_sql_rating('t.t_page_name'), tutorial_sql_rating_recent('t.t_page_name'), tutorial_sql_likes('t.t_page_name'), tutorial_sql_likes_recent('t.t_page_name')), array('t_page_name' => $tutorial_name), '', 1);
            $db_row = $db_rows[0];
        }

        $all_tags = TODO;
        $tags = array_diff($all_tags, array('document', 'video', 'audio', 'slideshow', 'novice', 'regular', 'expert', 'pinned'));

        $url = build_url(array('page' => $tutorial_name), '_SEARCH');

        $media_type = in_array('audio', $all_tags) ? 'audio' : (in_array('video', $all_tags) ? 'video' : (in_array('slideshow', $all_tags) ? 'slideshow' : 'document'));
        $difficulity_level = in_array('expert', $all_tags) ? 'expert' : (in_array('novice', $all_tags) ? 'novice' : 'regular');

        return array(
            'url' => $url,
            'title' => TODO,
            'summary' => TODO,
            'icon' => find_tutorial_image('', array_merge($tags, array($media_type, $difficulty_level))),
            'tags' => $tags,
            'media_type' => $media_type,
            'difficulty_level' => $difficulty_level,
            'core' => TODO,
            'pinned' => in_array('pinned', $all_tags),
            'author' => TODO,
            'views' => $db_row['t_views'],
            'add_date' => $db_row['t_add_date'],
            'edit_date' => TODO,

            'rating' => $db_row['rating'],
            'rating_recent' => $db_row['rating_recent'],
            'likes' => $db_row['likes'],
            'likes_recent' => $db_row['likes_recent'],
        );
    }
}

function tutorial_sql_rating($field)
{
    return '(SELECT AVG(rating) FROM '.get_table_prefix().'rating WHERE rating_for_type=\'tutorial\' AND rating_for_id=' . $field . ') AS rating';
}

function tutorial_sql_rating_recent($field)
{
    return '(SELECT AVG(rating) FROM '.get_table_prefix().'rating WHERE rating_for_type=\'tutorial\' AND rating_for_id=' . $field . ' AND rating_time>' . strval(time() - 60 * 60 * 24 * 31) . ') AS rating';
}

function tutorial_sql_likes($field)
{
    return '(SELECT COUNT(*) FROM '.get_table_prefix().'rating WHERE rating_for_type=\'tutorial\' AND rating_for_id=' . $field . ' AND rating=10) AS rating';
}

function tutorial_sql_likes_recent($field)
{
    return '(SELECT COUNT(*) FROM '.get_table_prefix().'rating WHERE rating_for_type=\'tutorial\' AND rating_for_id=' . $field . ' AND rating=10 AND rating_time>' . strval(time() - 60 * 60 * 24 * 31) . ') AS rating';
}

function find_tutorial_image($icon, $tags)
{
    if ($icon != '') {
        return $icon;
    }

    foreach ($tags as $tag) {
        $img = find_theme_image('tutorial_icons/' . strtolower(str_replace(' ', '_', $tag)), true);
        if ($img != '') {
            return $img;
        }
    }

    return find_theme_image('tutorial_icons/advice_and_guidance');
}
