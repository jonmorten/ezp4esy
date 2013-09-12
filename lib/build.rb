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

		shell = Shell.new()

		# Make extension directory
		shell.command <<-SH
			mkdir -p #{extension_dir}
		SH

		# Autoload
		if boolean_input['autoload']
			shell.command <<-SH
				cp -r #{template_dir}/autoloads #{extension_dir}/
				mkdir -p #{extension_dir}/settings
				cat #{template_dir}/settings/site.ini.append.autoload.php >> #{extension_dir}/settings/site.ini.append.php
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
