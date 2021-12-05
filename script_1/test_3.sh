#!/bin/bash

files=(file_1.txt file2.txt -file_3.html)

for file in "${files[@]}"
do
	bash add_sfx.sh -v -- 000 "$file"
done

bash add_sfx.sh -v -- 


