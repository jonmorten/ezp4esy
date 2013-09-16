# ezp4esy

_eZ Publish 4.x Extension Skeleton, Yessir_

## Abstract

Automate the setting up of extensions while imposing supposed best practices.

## Todo

* Testing
	* Build with all option combinations
	* Namespaces
		* See if they work properly, especially in _eztemplateautoload.php_
		* Might break _function_definition.php_
	* Template operators: See if the class version works
* _module.php_
	* Attempt to move configuration to a class - at least the view URLs
	* `$FunctionList`
	* `'params' => array( 'paramKey' => 'paramKey' ),`
* Silly two character prefix of navigation part
* _\_view.php_
	* Attempt to move path configuration to a class
