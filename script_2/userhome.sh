#!/bin/bash

#инициализация используемых переменных
user_name="$USER"
file_name=passwd
opt_f=
opt_sep=


#ввод опций
for arg in "$@"
do
	if [[ -z "$opt_sep" && "${arg:0:1}" == "-" ]]
	then
		case $arg in
		-h) echo ""$0": Search the home directory of the entered user in the list of users. By default, the current user and /etc/passwd."
			echo "Usage: $0 [-h] [-f] [--] [login] [file]"
			echo -e "-h: print this help and exit; \n-f: input file with list of users; \n--: option/non-option separator."
			exit 0
			;;
		-f) opt_f=1
			;;
		--) opt_sep=1
			;;
		-*) echo "Error: invalid option "$arg" ">&2
			exit 2
			;;
		esac
	fi
done


#ввод параметров
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
			echo "Error: invalid option "$arg" ">&2
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
		echo "Error: user with this name was not found.">&2
		exit 1
	fi
elif [ -e "$file_name" ]
then
	if grep "$user_name" "$file_name" >/dev/null;
	then
		user_path=$(grep "$user_name" "$file_name" | cut -f6 -d":")
		echo "$user_path"
	else
		echo "Error: ser with this name wasn't found.">&2
		exit 1
	fi
else
	echo 'Error: file with this name was not found.'>&2
	exit 2
fi

	
