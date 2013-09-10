class Build
	def self.clean()
		self.remove_output_dir()
	end

	def self.make(extension_name, module_names, boolean_input)
		extension_dir = [self.get_output_dir_path(), extension_name] * '/'
		extension_name_placeholder = self.get_placeholder(:extension)

		shell_command = ''
		shell_command << <<-SH
			mkdir -p #{extension_dir}
			cp -r template/#{extension_name_placeholder}/* #{extension_dir}/
			pushd #{extension_dir}
			find * -type f \\! -name '.*' \
			| xargs -I '{}' sed -i '' -e 's/#{extension_name_placeholder}/#{extension_name}/g' '{}'
			popd
		SH

		Rake::sh shell_command.gsub!(/\t/, '')
	end


	private

	def self.get_output_dir_path()
		return [Dir::pwd, 'output'] * '/'
	end

	def self.remove_output_dir()
		path = self::get_output_dir_path
		FileUtils::rm_rf(path) if File::exists?(path)
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
