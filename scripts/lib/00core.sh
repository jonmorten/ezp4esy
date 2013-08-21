#!/bin/bash


#	Assign value to variable in scope above
#	Params
#		$1: Variable name
#		$2: Value to assign
#	Example
#		hoist_var "step" 2
var_hoist()
{
	local var_name="$1"
	eval $var_name="$2"
}
