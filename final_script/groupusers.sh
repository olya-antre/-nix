#!/bin/bash

# инициализация нужных переменных
file_name=group
opt_f=
group_name=

for arg in "$@"
do
	if [[ "${arg:0:1}" == "-" ]]
	then
		case $arg in 
		-f) opt_f=1
			echo "Option f is here!";;
		-*) echo "Error: invalid option "$arg" ">&2
			exit 2;;
		esac
	fi
done

# считывание имени файла для опции f и имени группы
for arg in "$@"
do
	if [[ "${arg:0:1}" != "-" ]] 
	then
		if [[ "$file_name" == group && "$opt_f" == 1 ]] 
		then
			file_name="$arg"
		else
			if ! [[ "$group_name" ]]
			then
				group_name=$arg
			else
				echo "Error: invalid option "$arg"">&2
				exit 2
			fi
		fi
	fi
done 

# проверка наличия имени файла при опции f
if [[ "$opt_f" && "$file_name" == group ]]
then
	echo "Error: file's name was not found.">&2
	exit 2
elif [[ -z "$group_name" ]]
then	
	echo "Error: group's name was not found">&2
	exit 2
fi

users=
if [[ "$file_name" == "group" ]]
then 
	if getent group "$group_name" >/dev/null
	then
		a=$(grep "^$group_name:" /etc/group | cut -f4 -d":")
		IFS=',' read -ra users <<< "$a"
	else
		echo "Error: group with this name was not found">&2
		exit 1
	fi
elif [[ -e "$file_name" ]]
then
	if grep "^$group_name:" "$file_name" >/dev/null;
	then
		a=$(grep "^$group_name:" "$file_name" | cut -f4 -d":")
		IFS=',' read -ra users <<< "$a"
	else
		echo "Error: group with this name was not found">&2
		exit 1
	fi
else
	echo 'Error: file with this name was not found.'>&2
	exit 2
fi

for user in "${users[@]}"
do
	echo "$user"
done
