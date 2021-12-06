#!/bin/bash

opt_v=
opt_d=
opt_sep=
sfx=
a=('bash' 'add_sfx.sh')

for arg in "$@"
do
	if [[ -z "$opt_sep" && "${arg:0:1}" == "-" ]]
	then
		case "$arg" in
		-h) echo "'$0': rename file by insert suffix before file's extension."
			echo "Usage: '$0' [-h] [-d|-v] [--] suffix dir mask_1 [mask_2]..."
			echo -e "-d: dry run (no rename); \n-v: verbose output (print sourse and rename files; \n-h: print this help and exit; \n--: option/non-option argument separator; \nsuffix: input suffix; \ndir: directory; \nmask:  file search mask."
			exit 0;;
		-v) a+=('-v');;
		-d) a+=('-d');;
		--) opt_sep=1
			a+=('--');;
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
			a+=("$arg")
			sfx=1
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

for mask in "${masks[@]}"
do
	find "$dir" -name "$mask";
done | sort -u | while read file;
do
	a+=("$(basename "$file")")
	${a[@]}
done

