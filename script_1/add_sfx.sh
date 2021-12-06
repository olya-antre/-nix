#!/bin/bash

# инициализация переменных
opt_v=
opt_d=
opt_sep=


# перебор опций и параметров
for arg in "$@"
do
	if [[ -z "$opt_sep" && "${arg:0:1}" == "-" ]]
	then
		case $arg in
		-h) echo "'$0': rename file by insert suffix before file's extension."
			echo "Usage: '$0' [-h] [-d] [-v] [--] suffix files..."
			echo -e "-d: dry run (no rename); \n-v: verbose output (print sourse and rename files; \n-h: print this help and exit; \n--: option/non-option argument separator."
			exit 0;;
		-v) opt_v=1;;
		-d) opt_d=1;;
		--) opt_sep=1;;
		*)  echo "Error: invalid option "$arg"" >&2
			exit 2;;
		esac
	fi
done


# перебор суффикса и названий файлов
opt_sep=
sfx=
declare -a file_names
k=0

for arg in "$@"
do
	if [[ "$opt_sep" || "${arg:0:1}" != "-" ]]
	then
		if [[ -z "$sfx" ]]
		then
			sfx="$arg"
		else
			file_names[k]="$arg"
			k=$((k+1))
		fi
	elif [[ "$arg" == "--" ]]
	then
		opt_sep=1
	fi
done


# реализация разных вариантов работы программы
for file in "${file_names[@]}"
do
	name="${file%.*}"
	ext="${file#$name}"
	new_name="$name$sfx$ext"
	if [[ "$opt_d" == 1  || "$opt_v" == 1 ]]
	then
		echo ""$file" --> "$new_name" "
	fi
	if [[ -z "$opt_d" ]]
	then
		mv -- "$file" "$new_name"			
	fi
done


# проверка наличия суффикса и имен файлов для переименования
if [[ -z "$sfx" || -z "$file_names" ]]
then
	echo ""$0": No suffix or file's name given, type "$0" -h for help" >&2
	exit 2
fi

