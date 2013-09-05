class Build
	def self.clean()
		self.remove_output_dir()
	end

	private

	def self.get_output_dir_path()
		return [Dir::pwd, 'output'] * '/'
	end

	def self.make_output_dir()
		path = self::get_output_dir_path
		Dir::mkdir(path) unless File::exists?(path)
	end

	def self.remove_output_dir()
		path = self::get_output_dir_path
		FileUtils::rm_rf(path) if File::exists?(path)
	end
end
