<?php

/**
 *  Useful description
 *
 *  @author     your name   <user@host.tld>
 */

$Module = array(
    'name' => '_module_name',
);

$ViewList = array(

    '_view_url' => array(
        'default_navigation_part' => 'XX_navigtaion_part',
        'functions' => array(
            '_policy_function',
        ),
        'script' => 'views/_view.php',
        'params' => array( '_paramKey' => '_paramKey' ),
    ),

    // Default view
    '' => array(
        'default_navigation_part' => 'XX_navigtaion_part',
        'functions' => array(
            '_policy_function',
        ),
        'script' => 'views/_view.php',
    ),

);

$FunctionList = array(
    '_policy_function' => array(),
);
