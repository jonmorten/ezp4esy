# ezp4esy

_eZ Publish 4.x Extension Skeleton, Yessir_

## Abstract

Automate the setting up of extensions while imposing supposed best practices.

## Requirements

* [Ruby](https://www.ruby-lang.org/en)
* [RubyGems](http://rubygems.org)
* [Rake](http://rake.rubyforge.org)

## Usage

Clone the repository and run Rake inside it. `build` is the default task.

    rake

or

    rake build

The build will be placed in a folder named _output_.

## Caveats

* Can only make one module per build
* Not tested

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
