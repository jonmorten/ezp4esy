#
#	Bootstrap the build
#	Handle and transfer user input
#


lib_dir = 'lib'
Dir.entries(lib_dir).each do |lib|
	if lib.index('.rb')
		require [lib_dir, lib] * '/'
	end
end


verbose false

task :default => [:clean, :build]

task :clean do
	Build::clean()
end

task :build do
	#	Extension name
	extension_name = Cli::input_pattern 'Extension name [<extension_name>]', /[a-zA-Z_]+/

	#	Module
	module_name = Cli::input_pattern 'Module name [<module_name>]', /[a-zA-Z_]+/

	#	Boolean options
	#	Use crack hash to keep sort order. Ruby 1.8 hashes won't keep the order
	# 	in which they were created, but arrays will.
	boolean_input = {}
	boolean_options = [
		['php_classes', 'PHP classes?'],
		['tpl_fetch_fn', 'Template fetch functions?'],
		['tpl_operators', 'Template operators?'],
		['frontend_design', 'Frontend design?'],
		['admin_design', 'Admin design?'],
		['admin_tab', 'Admin tab?'],
		['setup_tab_item', 'Setup tab item?'],
		['cronjobs', 'Cronjobs?'],
		['sql', 'SQL?'],
		['translation', 'Translation?'],
	]
	boolean_options.each do |set|
		boolean_input[set[0]] = Cli::input_boolean set[1]
	end

	#	Copy template and replace placeholders
	Build::make extension_name, module_name, boolean_input
end
