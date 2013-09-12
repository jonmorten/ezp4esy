class Build
	def self.clean()
		path = self::get_output_dir_path
		FileUtils::rm_rf(path) if File::exists?(path)
	end

	def self.make(extension_name, module_names, boolean_input)
		extension_dir = [self.get_output_dir_path(), extension_name] * '/'
		extension_name_placeholder = self.get_placeholder(:extension)

		shell = Shell.new()

		shell.command <<-SH
			mkdir -p #{extension_dir}
			cp -r template/#{extension_name_placeholder}/* #{extension_dir}/
			pushd #{extension_dir}
			find * -type f \\! -name '.*' \
			| xargs -I '{}' sed -i '' -e 's/#{extension_name_placeholder}/#{extension_name}/g' '{}'
			popd
		SH

		shell.run
	end


	private

	def self.get_output_dir_path()
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
