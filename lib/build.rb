class Build
	def self.clean()
		path = self::get_output_dir_container
		FileUtils::rm_rf(path) if File::exists?(path)
	end

	def self.make(extension_name, module_names, boolean_input)
		extension_name_placeholder = self.get_placeholder(:extension)
		module_name_placeholder = self.get_placeholder(:module)

		extension_dir = [self.get_output_dir_container(), extension_name] * '/'
		template_dir = [self.get_template_dir_container(), extension_name_placeholder] * '/'
		relative_dirs = {
			:classes => 'classes/_Vendor/_Module',
		}

		shell = Shell.new()

		# Make extension directory
		shell.command <<-SH
			mkdir -p #{extension_dir}
		SH

		# PHP classes
		if boolean_input['php_classes']
			shell.command <<-SH
				mkdir -p #{extension_dir}/#{relative_dirs[:classes]}
				cp #{template_dir}/#{relative_dirs[:classes]}/_Classname.php #{extension_dir}/#{relative_dirs[:classes]}/
			SH
		end

		# Template fetch functions
		if boolean_input['tpl_fetch_fn']
			shell.command <<-SH
				mkdir -p #{extension_dir}/#{relative_dirs[:classes]}
				cp #{template_dir}/#{relative_dirs[:classes]}/_FetchFunctions.php #{extension_dir}/#{relative_dirs[:classes]}/
			SH
		end

		# Template operators
		if boolean_input['tpl_operators']
			shell.command <<-SH
				mkdir -p #{extension_dir}/#{relative_dirs[:classes]}
				cp #{template_dir}/#{relative_dirs[:classes]}/_TemplateOperators.php #{extension_dir}/#{relative_dirs[:classes]}/
				cp -r #{template_dir}/autoloads #{extension_dir}/
				mkdir -p #{extension_dir}/settings
				cat #{template_dir}/settings/site.ini.append.tpl_operators.php >> #{extension_dir}/settings/site.ini.append.php
			SH
		end

		# Replace extension name placeholder with extension name in all files
		shell.command <<-SH
			pushd #{extension_dir}
			find * -type f \\! -name '.*' \
			| xargs -I '{}' sed -i '' -e 's/#{extension_name_placeholder}/#{extension_name}/g' '{}'
			popd
		SH

		shell.run
	end


	private

	def self.get_template_dir_container()
		return [Dir::pwd, 'template'] * '/'
	end

	def self.get_output_dir_container()
		return [Dir::pwd, 'output'] * '/'
	end

	@@placeholders = {
		:extension => '_ext_name',
		:module => '_module_name',
	}

	def self.get_placeholder(key)
		raise ArgumentError, ":#{key} is not set" unless @@placeholders.key?(key)
		return @@placeholders[key]
	end
end


class Shell
	def initialize()
		@command = ''
	end

	def command(string)
		@command << string
	end

	def dump
		print @command
	end

	def run
		Rake::sh @command.gsub!(/\t/, '')
	end
end
