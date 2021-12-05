#!/bin/bash

# инициализация нужных элементов
opt_sep=
num_files=
opt_h=
opt_s=
minsize=

# ввод параметров и опций
for arg in "$@"
do
	case $arg in
	--help)  echo "'$0': output the N largest files and all its subdirectories. "
			 echo "Usage: '$0' [-help] [-h] [-N] [-s minsize] [--] [dir]"
			 echo -e "-help - print this help and exit; \n-N - number of files; \n-h - convenient output format; \ndir - search directory; \n-- separation of options and catalog"
			 exit 0;;
	-[0-9]*) num_files="${arg:1}";;
	-h) 	 opt_h=1;;
	-s) 	 opt_s=1;;
	--)		 opt_sep=1;;
	[0-9]*)  if [[ "$opt_s" == 1 ]]
			 	then
					minsize="$arg"
				else
	                echo "Error: invalid option "$arg"">&2
	                exit 2
				fi;;
	*)       if [[ "$opt_sep" == 1 && "${arg:0:1}" != "-" && ( "$arg" != "$minsize" || -z "$opt_s") ]]
	            then	
		            dir_name="$arg"
	            else
	                echo "Error: invalid option "$arg"">&2
	            fi;;
	esac 
done 


if [[ "$opt_s" && "$num_files" && "$opt_h" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du | sort -nr | head -"$num_files" | cut -f2  | xargs -I{} du -sh {} 
	
elif [[ "$opt_s" && "$opt_h" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du | sort -nr | cut -f2  | xargs -I{} du -sh {} 
	
elif [[ "$opt_s" && "$num_files" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du | sort -n -r| head -"$num_files" 
	
elif [[ "$opt_s" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du | sort -n -r
	
elif [[ "$opt_h" && "$num_files" ]]
then
	find "$dir_name" -type f -print0 | xargs -0 du | sort -nr | head -"$num_files" | cut -f2  | xargs -I{} du -sh {}
	
elif [[ "$opt_h" ]]
then
	find "$dir_name" -type f -print0 | xargs -0 du | sort -nr | cut -f2 | xargs -I{} du -sh {}

elif [[ "$num_files" ]]
then
	find "$dir_name" -type f -print0 | xargs -0 du | sort -nr | head -"$num_files" 
fi


# проверка наличия ошибок в вызове сценария
if [[ "$sep_s" && -z "$minsize" ]]
then
	echo "Error: minsize for option [-s] is not found.">&2
	exit 2
fi
