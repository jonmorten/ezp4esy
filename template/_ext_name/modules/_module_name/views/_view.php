<?php

/**
 *  Useful description
 *
 *  @author     your name   <user@host.tld>
 */

$http = eZHTTPTool::instance();
$module = $Params['Module'];

$tplView = eZTemplate::factory();
$tplView->setVariable( 'content', 'Dummy content' );

$tplFrame = eZTemplate::factory();
$tplFrame->setVariable( 'header', 'Dummy header' );
$tplFrame->setVariable( 'content', $tplContent->fetch( 'design:_module_name/views/_view.tpl' ) );

$Result['title_path'] = array(
    array(
        'text' => '_module_name',
    ),
);
$Result['path'] = array(
    array(
        'text' => '_module_display_name',
        'url' => '_module_name',
    ),
    array(
        'text' => '_view_display_name',
        'url' => '_module_name/_view_url',
    ),
);
$Result['content'] = $tplFrame->fetch( 'design:_module_name/frame.tpl' );
$Result['left_menu'] = 'design:_module_name/parts/menu.tpl';
return $Result;
