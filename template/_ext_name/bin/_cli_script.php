<?php

/**
 *	Run from the eZ root directory.
 *
 *	@author	your name	<user@host.tld>
 */

require 'autoload.php';

$cli = \eZCLI::instance();
$script = \eZScript::instance(
	array(
		'description' => '',
		'use-extensions' => true,
		'use-modules'    => true,
	)
);
$options = $script->getOptions( '[param0:][param1:]',
	'',
	array(
		'param0' => 'Description for param0',
		'param1' => 'Description for param1',
	)
);
$script->startup();
$script->initialize();

$param0 = $options['param0'];
$param1 = $options['param1'];

$cli->output( $param0 );
$cli->output( $param1 );

$script->shutdown();
