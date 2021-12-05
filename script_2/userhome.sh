#!/bin/bash

#
user_name="$USER"
file_name=passwd
opt_f=
opt_sep=


#
for arg in "$@"
do
	if [[ -z "$opt_sep" && "${arg:0:1}" == "-" ]]
	then
		case $arg in
		-h) echo "This file found the path to the your file."
			;;
		-f) opt_f=1
			;;
		--) opt_sep=1
			;;
		-*) echo "Invalid option: "$arg" ">&2
			exit 2
			;;
		esac
	fi
done


#
opt_sep=
for arg in "$@"
do
	if [[ "$opt_sep" || "${arg:0:1}" != "-" ]]
	then
		if [[ "$user_name" == "$USER" ]]
		then
			user_name=$arg
		elif [[ "$user_name" != "$USER" && "$opt_f" ]]
		then
			file_name=$arg
		else
			echo "Invalid option: "$arg" ">&2
			exit 2
		fi
	fi
done

if [ "$file_name" = passwd ]
then
	if getent passwd "$user_name" >/dev/null;
	then
		user_path=$(grep "$user_name" /etc/passwd | cut -f6 -d":")
		echo "$user_path"
	else
		echo "User with this name was not found.">&2
		exit 1
	fi
elif [ -e "$file_name" ]
then
	if grep "$user_name" "$file_name" >/dev/null;
	then
		user_path=$(grep "$user_name" "$file_name" | cut -f6 -d":")
		echo "$user_path"
	else
		echo "User with this name wasn't found.">&2
		exit 1
	fi
else
	echo 'File with this name was not found.'>&2
	exit 2
fi

	
