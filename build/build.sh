#!/bin/bash


#
#	Bootstrap the build
#	Handle and transfer user input
#


for script in lib/*; do
	. $script;
done;


echo_ext()
{
	echo_info "Extension name: $ext_name";
}
echo_modules()
{
	echo_info "Module name(s): ${module_names[@]}";
}
echo_autoloading()
{
	echo_info "Autoloading: $req_autoloading";
}
echo_fetch_func()
{
	echo_info "Template fetch functions: $req_fetch_func";
}


echo_break;


#	Input: Extension name
while true; do
	read -p $'Extension name [<name>]\n > ' ext_name;
	if [[ "${ext_name}" =~ [a-zA-Z_]+ ]]; then
		break;
	fi;
done;
echo_break;


#	Input: Module name(s)
prompt_modules=$'Add module [<name>/n]\n > ';
declare -a module_names;
while true; do
	read -p "$prompt_modules" input;
	case $input in
		[Nn])
			if [[ ! -z "${module_names}" ]]; then
				break;
			fi;
			;;
		[a-zA-Z_]*)
			module_names=("${module_names[@]}" "$input");
			echo_modules;
			;;
		*)
		;;
	esac;
done;
echo_break;


#	Input: Autoloading
declare req_autoloading;
prompt_boolean "PHP autoloading?" "req_autoloading";
echo_break;


#	Input: Fetch functions
declare req_fetch_func;
prompt_boolean "Template fetch functions?" "req_fetch_func";
echo_break;


# @todo
# Input: Admin tab
# Input: Cronjobs
# Input: Design/extent of design
# Input: SQL
# Input: Translation


#	Input: Confirm configuration
echo_info "Configuration summary:";
echo_ext;
echo_modules;
echo_autoloading;
echo_fetch_func;
while true; do
	read -p $'Build? [y/n]\n > ' input;
	case $input in
		[Yy]*)
			echo 'WOHO';
			break;
			;;
		[Nn]*)
			echo 'OH NO';
			break;
			;;
	esac;
done;
echo_break;


# @todo
# Unique module names
# Copy template into export folder, depending on extent of build
# Replace placeholders
