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


task :default => [:clean, :build]

task :clean do
	Build::clean()
end

task :build do
	#	Extension name
	extension_name = Cli::input_pattern 'Extension name [<extension_name>]', /[a-zA-Z_]+/

	#	Modules
	module_names = Cli::input_until 'Modules? [<module_name>/n]', /^n$/

	#	Boolean options
	#	Both Bash 3 and Ruby 1.8 hashes were worked on by top men. Top. Men.
	boolean_input = {}
	boolean_options = [
		['autoload', 'PHP autoloading?'],
		['fetch_fn', 'Template fetch functions?'],
		['admin_tab', 'Admin tab?'],
		['cronjobs', 'Cronjobs?'],
		['frontend_design', 'Frontend design?'],
		['sql', 'SQL?'],
		['translation', 'Translation?'],
	]
	boolean_options.each do |set|
		boolean_input[set[0]] = Cli::input_boolean set[1]
	end
end
