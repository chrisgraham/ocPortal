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

/**
 * Block class.
 */
class Block_main_tutorials_carousel
{
    /**
     * Find details of the block.
     *
     * @return ?array                   Map of block info (null: block is disabled).
     */
    public function info()
    {
        $info = array();
        $info['author'] = 'Chris Graham';
        $info['organisation'] = 'ocProducts';
        $info['hacked_by'] = null;
        $info['hack_version'] = null;
        $info['version'] = 1;
        $info['locked'] = false;
        $info['parameters'] = array();
        return $info;
    }

    /**
     * Find cacheing details for the block.
     *
     * @return ?array                   Map of cache details (cache_on and ttl) (null: block is disabled).
     */
    function cacheing_environment()
    {
        $info=array();
        $info['cache_on']='$map';
        $info['ttl']=60;
        return $info;
    }

    /**
     * Execute the block.
     *
     * @param  array                    $map A map of parameters.
     * @return tempcode                 The result of execution.
     */
    public function run($map)
    {
        i_solemnly_declare(I_UNDERSTAND_SQL_INJECTION | I_UNDERSTAND_XSS | I_UNDERSTAND_PATH_INJECTION);

        require_code('tutorials');

        $tutorials = explode(',', $map['param']);
        $full_mode = (@$map['view'] == 'full');
        if ($full_mode) {
            echo <<<END
        <div class="float_surrounder tutorials">
        END;
        }
        foreach ($tutorials as $i => $tut) {
            if (file_exists(get_custom_file_base() . '/docs/pages/comcode_custom/EN/tut_' . $tut . '.txt')) {
                $linktitle = 'Read';
                $link = static_evaluate_tempcode(build_url(array('page' => 'tut_' . $tut), 'docs'));
                $javascript = '';
            } elseif (file_exists(get_custom_file_base() . '/uploads/website_specific/ocportal.com/video_tutorials/' . $tut . '.flv')) {
                $linktitle = 'Watch';
                $link = get_base_url() . '/uploads/website_specific/ocportal.com/swf_play.php?file=video_tutorials/' . $tut . '.flv&width=1024&height=788';
                $javascript = "window.open(this.href,'','width=1024,height=820,location=no,resizable=no,scrollbars=no,status=yes'); return false;";
            } elseif (file_exists(get_custom_file_base() . '/uploads/website_specific/ocportal.com/video_tutorials/' . $tut . '.swf')) {
                $linktitle = 'Watch';
                $link = get_base_url() . '/uploads/website_specific/ocportal.com/swf_play.php?file=video_tutorials/' . $tut . '.swf&width=1024&height=788';
                $javascript = "window.open(this.href,'','width=1024,height=768,location=no,resizable=no,scrollbars=no,status=yes'); return false;";
            } else { /*if (file_exists(get_custom_file_base().'/uploads/website_specific/ocportal.com/video_tutorials/'.$tut.'.mov'))*/
                $linktitle = 'Watch';
                $link = get_base_url() . '/uploads/website_specific/ocportal.com/mov_play.php?file=video_tutorials/' . $tut . '.mov';
                $javascript = "window.open(this.href,'','width=1024,height=768,location=no,resizable=no,scrollbars=no,status=yes'); return false;";
            }
            list($title, $summary, $date, $colour, $author) = TODO;
            $title = escape_html($title);
            $summary = escape_html($summary);
            $date = escape_html($date);
            $img = find_theme_image('tutorial_icons/' . $tut, true);
            if (($img == '') && ($linktitle == 'Watch')) {
                $img = find_theme_image('tutorial_icons/video', true);
            }
            if ($img == '') {
                $img = find_theme_image('tutorial_icons/default');
            }
            $_img = escape_html($img);

            $a = ($i % 2 == 0) ? 'standardbox_links_panel_right' : 'standardbox_inner_panel_right';
            $b = ($i % 2 == 0) ? 'standardbox_links_panel' : 'standardbox_inner_panel';
            $_link = escape_html(is_object($link) ? $link->evaluate() : $link);
            $_javascript = ($javascript == '') ? '' : (' onclick="' . $javascript . '"');
            $_date = escape_html($date);
            $_author = escape_html($author);

            if ($full_mode) {
                $side = ($i % 2 == 0) ? 'l' : 'r';
                echo <<<END
            <div class="{$side} {$colour}">
                <div class="b">
                    <img src="{$_img}" alt="" />

                    <div class="wt"><h4>{$title}</h4></div>

                    <p class="s">{$summary}</p>
                </div>

                <p class="author">
                    by {$_author}
                </p>
                <div class="wlink"><p class="link">&raquo; <a{$_javascript} title="{$title}" href="{$_link}">{$linktitle} Now</a></p></div>
            </div>
        END;
            } else {
                echo <<<END
            </div></div>
            <div class="{$a}"><div class="{$b}">
                <div class="tutorial"><div class="float_surrounder">
                    <div style="float: right; margin-left: 5px">
                            <p class="d">{$_date}</p>

                            <a href="{$_link}"{$_javascript}><img src="{$_img}" alt="" /></a>
                    </div>

                    <p><strong>{$title}</strong></p>
                    <p class="s">{$summary}</p>

                    <p class="r">[ <a title="{$title}" href="{$_link}"{$_javascript}>{$linktitle}</a> ]</p>
                </div></div>
        END;
            }
        }
        if ($full_mode) {
            echo <<<END
        </div>
        END;
        }

        if (!$full_mode) {
            $i++;
            $a = ($i % 2 == 0) ? 'standardbox_links_panel_right' : 'standardbox_inner_panel_right';
            $b = ($i % 2 == 0) ? 'standardbox_links_panel' : 'standardbox_inner_panel';
            $docs_link = build_url(array('page' => 'tutorials'), 'docs');
            $_docs_link = escape_html(is_object($docs_link) ? $docs_link->evaluate() : $docs_link);
            $_seemore_img = escape_html(find_theme_image('start_button_seemore'));
            echo <<<END
            </div></div>
            <div class="{$a}"><div class="{$b}">
                <div class="side_button"><a href="{$_docs_link}"><img alt="See more tutorials" src="{$_seemore_img}" /></a></div>
        END;
        }
    }
}
