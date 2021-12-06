#!/bin/bash

opt_v=
opt_d=
opt_sep=
sfx=

for arg in "$@"
do
	if [[ -z "$opt_sep" && "${arg:0:1}" == "-" ]]
	then
		case "$arg" in
		-h) echo "'$0': rename file by insert suffix before file's extension."
			echo "Usage: '$0' [-h] [-d|-v] [--] suffix dir mask1 [mask2]..."
			echo -e "-d: dry run (no rename); \n-v: verbose output (print sourse and rename files; \n-h: print this help and exit; \n--: option/non-option argument separator; \n-suffix - input suffix; \n-dir - directory; \n-mask1 - file search mask."
			exit 0;;
		-v) opt_v=1;;
		-d) opt_d=1;;
		--) opt_sep=1;;
		*)  echo "Error: invalid option "$arg"">&2
			exit 2;;
		esac
	fi
done

opt_sep=
sfx=
dir=
k=0
declare -a masks

for arg in "$@"
do
	if [[ "$opt_sep" || "${arg:0:1}" != "-" ]] 
	then
		if [[ -z "$sfx" ]] 
		then
			sfx="$arg"
		else
			if [[ -z "$dir" ]]
			then
				dir="$arg"
			else
				masks[k]="$arg"
				k=$((k+1))
			fi
		fi
	fi
done

if [[ -z "$sfx" || -z "$dir" || -z "${masks[@]}" ]]
then
	echo "Error: suffix, directory or mask was not found.">&2
	exit 2
fi

answer=$(move "$dir" ".txt" ".000txt")
echo "$answer"
