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
