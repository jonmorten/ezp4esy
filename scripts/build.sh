#!/bin/bash


#
#	Bootstrap the build
#	Handles and transfers user input
#


# Utility
SET_CLR_NORMAL=$(tput sgr0);
SET_CLR_YELLOW=$(tput setaf 3);

echo_info()
{
	echo "$SET_CLR_YELLOW""$*""$SET_CLR_NORMAL";
}
echo_break()
{
	echo '';
}
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


# Input: Extension name
while true; do
	read -p $'Extension name [<name>]\n > ' ext_name;
	if [[ "${ext_name}" =~ [a-zA-Z_]+ ]]; then
		break;
	fi;
done;
echo_break;


# Input: Module name(s)
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


# Input: Autoloading
while true; do
	read -p $'PHP autoloading? [y/n]\n > ' input;
	case $input in
		[Yy]*)
			req_autoloading=true;
			break;
			;;
		[Nn]*)
			req_autoloading=false;
			break;
			;;
	esac;
done;
echo_break;


# Input: Fetch functions
while true; do
	read -p $'Template fetch functions? [y/n]\n > ' input;
	case $input in
		[Yy]*)
			req_fetch_func=true;
			break;
			;;
		[Nn]*)
			req_fetch_func=false;
			break;
			;;
	esac;
done;
echo_break;


# @todo
# Input: Admin tab
# Input: Cronjobs
# Input: Design/extent of design
# Input: SQL
# Input: Translation


# Input: Confirm configuration
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


# Copy template into export folder, depending on extent of build
# Replace placeholders
