class Build
	def self.clean()
		path = self::get_output_dir_container
		FileUtils::rm_rf(path) if File::exists?(path)
	end

	def self.make(extension_name, module_name, boolean_input)
		extension_name_placeholder = self.get_placeholder(:extension)
		module_name_placeholder = self.get_placeholder(:module)

		extension_dir = [self.get_output_dir_container(), extension_name] * '/'
		template_dir = [self.get_template_dir_container(), extension_name_placeholder] * '/'
		relative_dirs = {
			:classes => 'classes/_Vendor/_Module',
			:admin_templates => 'design/admin2/templates',
			:frontend_templates => 'design/standard/templates',
		}

		shell = Shell.new()

		# Make extension directory
		shell.command <<-SH
			mkdir -p #{extension_dir}
		SH

		# Module settings and structure
		shell.command <<-SH
			mkdir -p #{extension_dir}/settings
			cp #{template_dir}/settings/module.ini.append.php #{extension_dir}/settings/
			mkdir -p #{extension_dir}/modules/#{module_name}
			cp -r #{template_dir}/modules/#{module_name_placeholder}/* #{extension_dir}/modules/#{module_name}/
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

		# Designs
		if boolean_input['admin_design'] || boolean_input['frontend_design']
			shell.command <<-SH
				mkdir -p #{extension_dir}/design #{extension_dir}/settings
				cp #{template_dir}/settings/design.ini.append.php #{extension_dir}/settings/
			SH

			# Admin
			if boolean_input['admin_design']
				shell.command <<-SH
					mkdir -p #{extension_dir}/#{relative_dirs[:admin_templates]}/#{module_name}
					cp -r #{template_dir}/#{relative_dirs[:admin_templates]}/#{module_name_placeholder}/* #{extension_dir}/#{relative_dirs[:admin_templates]}/#{module_name}/
				SH
			end

			# Frontend
			if boolean_input['frontend_design']
				shell.command <<-SH
					mkdir -p #{extension_dir}/#{relative_dirs[:frontend_templates]}/#{module_name}
					cp -r #{template_dir}/#{relative_dirs[:frontend_templates]}/#{module_name_placeholder}/* #{extension_dir}/#{relative_dirs[:frontend_templates]}/#{module_name}/
				SH
			end
		end

		# Admin tab
		if boolean_input['admin_tab']
			shell.command <<-SH
				mkdir -p #{extension_dir}/settings
				cat #{template_dir}/settings/menu.ini.append.admin_tab.php >> #{extension_dir}/settings/menu.ini.append.php
			SH
		end

		# Setup tab menu item
		if boolean_input['setup_tab_item']
			shell.command <<-SH
				if [[ -f #{extension_dir}/settings/menu.ini.append.php ]]; then echo >> #{extension_dir}/settings/menu.ini.append.php; fi
				mkdir -p #{extension_dir}/settings
				cat #{template_dir}/settings/menu.ini.append.setup_tab_item.php >> #{extension_dir}/settings/menu.ini.append.php
			SH
		end

		# Cronjobs
		if boolean_input['cronjobs']
			shell.command <<-SH
				cp -r #{template_dir}/cronjobs #{extension_dir}/
				mkdir -p #{extension_dir}/settings
				cp #{template_dir}/settings/cronjob.ini.append.php #{extension_dir}/settings/cronjob.ini.append.php
			SH
		end

		# SQL
		if boolean_input['sql']
			shell.command <<-SH
				cp -r #{template_dir}/sql #{extension_dir}/
			SH
		end

		# Translation
		if boolean_input['translation']
			shell.command <<-SH
				cp -r #{template_dir}/translations #{extension_dir}/
				if [[ -f #{extension_dir}/settings/site.ini.append.php ]]; then echo >> #{extension_dir}/settings/site.ini.append.php; fi
				cat #{template_dir}/settings/site.ini.append.translation.php >> #{extension_dir}/settings/site.ini.append.php
			SH
		end

		# Replace placeholders in files
		shell.command <<-SH
			pushd #{extension_dir}
			find * -type f \\! -name '.*' \
			| xargs -I '{}' sed -i '' -e 's/#{extension_name_placeholder}/#{extension_name}/g' '{}'
			find * -type f \\! -name '.*' \
			| xargs -I '{}' sed -i '' -e 's/#{module_name_placeholder}/#{module_name}/g' '{}'
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
		Rake::sh @command.gsub(/\t/, '')
	end
end
