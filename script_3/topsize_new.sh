#!/bin/bash

# инициализация нужных элементов
opt_sep=
num_files=
opt_h=
opt_s=
minsize=1c
dir_name=.

# ввод параметров и опций
for arg in "$@"
do
	if [[ -z "$opt_sep" ]]
	then
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
		*)      dir_name="$arg"
				if ! [[ -d "$dir_name" ]]
				then
			        echo "Error: invalid option "$arg"">&2
			        exit 2
			    fi;;
		esac
	else
		dir_name="$arg"
		if [[ -d "$dir_name" ]]
		then
			 echo "Error: invalid option "$arg"">&2
			 exit 2
		fi
	fi
done 

	
if [[ "$opt_h" && "$num_files" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 |xargs -0 du -bh | sort -hbr | head -"$num_files" 

elif [[ "$opt_h" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du -bh | sort -hbr 
	
elif [[ "$num_files" ]]
then
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du -b | head -"$num_files" 
else
	find "$dir_name" -type f -size +"$minsize" -print0 | xargs -0 du -b | sort -hr

fi
