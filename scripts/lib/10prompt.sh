#!/bin/bash


#	Echo wrappers
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


#	Prompt resulting in a boolean value
#	Params
#		$1: Prompt text
#		$2: Name of variable receiving the boolean value
#	Example: prompt_boolean "More shell insanity?" "output_variable_name"
prompt_boolean()
{
	while true; do
		read -p "$1"$' [y/n]\n > ' input;
		case $input in
			[Yy]*)
				var_hoist "$2" true;
				break;
				;;
			[Nn]*)
				var_hoist "$2" false;
				break;
				;;
		esac;
	done;
}
